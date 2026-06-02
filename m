Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E3724A078;
	Tue,  2 Jun 2026 04:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780373405; cv=none; b=HXaVHmU7x/xQY3KdGwkDK/3ENUzO4G6Gc5rE2deJL4G+nyidHT9DiJpADD1XKMljbj/SsE1+kOStgX9mgY3xStNhtaxnOAVwVDBGTL7GlughektsuptRHwsHXvKmxPINm9+gqAJf3FRDVYc1UOK7M6IEwfcABsTrm7htOVzDt8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780373405; c=relaxed/simple;
	bh=GOksLGRL40GeO+va87NUPhjj1rU+XMLIGTqiY8UTvYQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=uTxIbrc31o0JwZGLReQjHNPGhaaIVrgKCkOLs3N5ae9FzwP67nxR6MM3945aYVOoojowKXWrrx+4gtkBIzNdvUQtpxoRrnGjtF2HfELFU7MDAdFSY1CxUWq7dnrSR2gcD0Vyku+Lc9xX4AeS34Qd6ERZHr0MA02VegMzOX//02Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fsMbhlnY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fsMbhlnY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EABF11F00898;
	Tue,  2 Jun 2026 04:10:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780373404;
	bh=TgvzW6CJsjPjgbBL8VU70j2utOOAg5aVrw67MI5vDMo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=fsMbhlnYcxa/zQ3Bhd/T+mVm9GO5Lcsacd+3X+BOWUxrCr6Ovmd10CfLR9+DdN/V2
	 DC1B/WYYBMCFopRnrJFHhV2W4TsDpRZRxkp960BJDZvvop3TnpsFS7uT5BwkLc3NwE
	 a3K77lD6RMLMwL6fAxg7+VnnOovrcPvxaQuK+Jj1YbqSeIedW7JkmqXKFDq8+IpuUd
	 OBbh6erbvi08L8gUnzDWkURMTFVjEwAzMEHQAkF62QW7GUHDkSTHpt3exk/585utso
	 CVS6K8ELO+OuICl2DzVM6tzb1Iq3cS1c4yZiS9givuqNKmPKjntJ1iZKrhvRbopiQp
	 f6UG1LjER2aOw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5699538119FB;
	Tue,  2 Jun 2026 04:10:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] bpf: fix UAF by restoring RCU-delayed inode freeing in
 bpffs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178037340615.242116.16690110802168346703.git-patchwork-notify@kernel.org>
Date: Tue, 02 Jun 2026 04:10:06 +0000
References: <20260602025249.113828-1-kartikey406@gmail.com>
In-Reply-To: <20260602025249.113828-1-kartikey406@gmail.com>
To: Deepanshu Kartikey <kartikey406@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, memxor@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, viro@zeniv.linux.org.uk, jolsa@kernel.org,
 kafai.wan@linux.dev, bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 brauner@kernel.org, jack@suse.cz,
 syzbot+36e50496c8ac4bcde3f9@syzkaller.appspotmail.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue,  2 Jun 2026 08:22:49 +0530 you wrote:
> commit 4f375ade6aa9 ("bpf: Avoid RCU context warning when unpinning
> htab with internal structs") moved inode cleanup from ->free_inode()
> into ->destroy_inode() to avoid sleeping in RCU context when calling
> bpf_any_put(). However this removed the RCU delay on freeing the
> inode itself and the cached symlink body (i_link), both of which
> can be accessed by RCU pathwalk (pick_link, may_lookup etc.).
> 
> [...]

Here is the summary with links:
  - [v2] bpf: fix UAF by restoring RCU-delayed inode freeing in bpffs
    https://git.kernel.org/bpf/bpf-next/c/b93c55b4932d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


