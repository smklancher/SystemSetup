$packageArgs = @{
  PackageName   = 'CodeMaidVsix'
  VsixUrl       = 'https://stevecadwallader.gallerycdn.vsassets.io/extensions/stevecadwallader/codemaid/11.0.183/1553341607616/CodeMaid_v11.0.183.vsix'
  Checksum      = '910865a73496dbac5313e77fddee72c41c64d2de9a200f9c6a6011bc3c3d3bc5'
  ChecksumType  = 'sha256'
}

Install-VisualStudioVsixExtension @packageArgs