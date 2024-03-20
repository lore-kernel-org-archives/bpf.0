Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1C95125AC
	for <bpf@vger.kernel.org>; Wed, 20 Mar 2024 06:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710915629; cv=none; b=nnHaIinS7saPkZZd7NS+zZzYFGqJ6HQup6v/XvsD6yP0+a655OytpcVbrWMK48BolkmxFv/JnVHpSTOhcz71MpQaiMzjfmb2DafMe55KBX4UmKgIlLKXtgtOQ5spE/1YaZ2TzbPS44d4nzjL22crMA5JmNbP+CfaoV6osts8H60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710915629; c=relaxed/simple;
	bh=7UkoLKyAVG29RLXuplheQNeX2dH8KD09c1Nu12hwFkM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=NcpvwkFULQiHpI7Wt992K+KUNhKHH2ImgIBuhNPVfAn+dhKihtAUX5JhW7o0QQ/m1SmfpUXkenfyNoAgwXHY1hgwsfjFEzDi9iyHKz4pzddPdXSe23AP4oLEVR4Bf0SRUHfSC59HRFrpA1IrQnpsRA79xvS79rITSJd+Gnlqgi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GFCc2+qV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GFCc2+qV"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 58F82C43399;
	Wed, 20 Mar 2024 06:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710915629;
	bh=7UkoLKyAVG29RLXuplheQNeX2dH8KD09c1Nu12hwFkM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=GFCc2+qVEx6ey5kAsaq9yF/bYFj+eDvUR/SPOQUHNGVCQQ3/L8mhNgGSTzjQ06QSy
	 P1MUkFxEHPeWcUa5SdgvuVFaN4NlZXhGlGtHndJlHA4bw925zVlC1+ev43F3jlMLvy
	 hCDffhvPefWZTPAbgxTStYK3D+3p+fyBUkIl2w4BUjxr23koyeXbmNhdK/gJys1Em8
	 vt6Fbr853dbGOQqb83zLh/pphfgyl3ernvsezwYFkt25Qyc6VOLyZufehoC+gVQG+K
	 TP+5DGqyfkCRq9dYEhxGuOtaGvCVX4+rl55fS1mmF6yerFMzNyXObdkKQgz92Q7PYj
	 hsiRZ6y2FAhJw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 46BF9D95060;
	Wed, 20 Mar 2024 06:20:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpftool: Remove unnecessary source files from
 bootstrap version
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171091562928.21070.5097550574692377899.git-patchwork-notify@kernel.org>
Date: Wed, 20 Mar 2024 06:20:29 +0000
References: <20240320013457.44808-1-qmo@kernel.org>
In-Reply-To: <20240320013457.44808-1-qmo@kernel.org>
To: Quentin Monnet <qmo@kernel.org>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@google.com, haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed, 20 Mar 2024 01:34:57 +0000 you wrote:
> Commit d510296d331a ("bpftool: Use syscall/loader program in "prog load"
> and "gen skeleton" command.") added new files to the list of objects to
> compile in order to build the bootstrap version of bpftool. As far as I
> can tell, these objects are unnecessary and were added by mistake; maybe
> a draft version intended to add support for loading loader programs from
> the bootstrap version. Anyway, we can remove these object files from the
> list to make the bootstrap bpftool binary a tad smaller and faster to
> build.
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpftool: Remove unnecessary source files from bootstrap version
    https://git.kernel.org/bpf/bpf-next/c/e9a826dd145b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


