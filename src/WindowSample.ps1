Add-Type -AssemblyName PresentationFramework

# XAML定義
$xaml = @"
<Window xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        Title="PowerShell ウィンドウ" Height="768" Width="1024" FontFamily="Meiryo UI" FontSize="12">
    <Grid Margin="10">
        <Grid.RowDefinitions>
            <RowDefinition Height="Auto"/>
            <RowDefinition Height="Auto"/>
            <RowDefinition Height="Auto"/>
            <RowDefinition Height="Auto"/>
            <RowDefinition Height="*"/>
        </Grid.RowDefinitions>
        <Grid.ColumnDefinitions>
            <ColumnDefinition Width="120"/>
            <ColumnDefinition Width="120"/>
        </Grid.ColumnDefinitions>

        <!-- テキストラベル3つ -->
        <TextBlock Grid.Row="0" Grid.Column="0" Text="ラベル1" HorizontalAlignment="Left" Margin="0,0,0,5"/>
        <TextBlock Grid.Row="1" Grid.Column="0" Text="ラベル2" HorizontalAlignment="Left" Margin="0,0,0,5"/>
        <TextBlock Grid.Row="2" Grid.Column="0" Text="ラベル3" HorizontalAlignment="Left" Margin="0,0,0,10"/>

        <!-- テキストボックス -->
        <TextBox Grid.Row="3" Grid.Column="0" Grid.ColumnSpan="2" Name="MainTextBox" Width="300" Margin="0,0,0,20"/>

        <!-- ラベルとボタン5組 -->
        <TextBlock Grid.Row="4" Grid.Column="0" Text="ラベル4" HorizontalAlignment="Right" VerticalAlignment="Center" Margin="0,0,10,0"/>
        <Button Grid.Row="4" Grid.Column="1" Name="Button1" Content="ボタン1" Width="100" Margin="0,0,0,5" VerticalAlignment="Top"/>

        <TextBlock Grid.Row="4" Grid.Column="0" Text="ラベル5" HorizontalAlignment="Right" VerticalAlignment="Center" Margin="0,40,10,0"/>
        <Button Grid.Row="4" Grid.Column="1" Name="Button2" Content="ボタン2" Width="100" Margin="0,40,0,5" VerticalAlignment="Top"/>

        <TextBlock Grid.Row="4" Grid.Column="0" Text="ラベル6" HorizontalAlignment="Right" VerticalAlignment="Center" Margin="0,80,10,0"/>
        <Button Grid.Row="4" Grid.Column="1" Name="Button3" Content="ボタン3" Width="100" Margin="0,80,0,5" VerticalAlignment="Top"/>

        <TextBlock Grid.Row="4" Grid.Column="0" Text="ラベル7" HorizontalAlignment="Right" VerticalAlignment="Center" Margin="0,120,10,0"/>
        <Button Grid.Row="4" Grid.Column="1" Name="Button4" Content="ボタン4" Width="100" Margin="0,120,0,5" VerticalAlignment="Top"/>

        <TextBlock Grid.Row="4" Grid.Column="0" Text="ラベル8" HorizontalAlignment="Right" VerticalAlignment="Center" Margin="0,160,10,0"/>
        <Button Grid.Row="4" Grid.Column="1" Name="Button5" Content="ボタン5" Width="100" Margin="0,160,0,5" VerticalAlignment="Top"/>
    </Grid>
</Window>
"@

# XAMLをロード
$reader = New-Object System.Xml.XmlNodeReader ([xml]$xaml)
$window = [Windows.Markup.XamlReader]::Load($reader)

# ボタン1のイベント
$button1 = $window.FindName("Button1")
$button1.Add_Click({
    [System.Windows.MessageBox]::Show("OK")
})

# WPFウィンドウ表示
$window.ShowDialog() | Out-Null
