Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07592279DAD;
	Thu,  3 Sep 2026 00:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788395476; cv=none; b=hWGsfF4J/Y+T+s4BJyLBW7k/cJ6iBatKwmGOlBXikI4y04yYJ6Um2SrBeZDXW5RlutlzRoa/C9Oy/RZBJIkW8orcJ2QKWTHunZa4ghPTV5BD0ivWr9V2hC8ZzMc3jeFj0XFU7U4cW1sKLxcBbFgqJ7JEbfCWFOOlduzs1OS81Og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788395476; c=relaxed/simple;
	bh=Onpra8qjJUbWJuoP6u3ypgR2WCs8YNKkKpvLpjUQFZw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=KkL9qHU5WEV0e1NS2kWn7ujr9HfAw6r9YXxWZ0JIBwl9UaWEu/hT0vaHSmjsrP0KOPqvezMD0Ym+Yel1qDW39rHtTPWbm1+xvsozXC2xtDlaMDDvpxmnkwy35YsYZ1oIQNxt9Gu8w5daz7H32GESukrEYFAq8t481o4KVROIlSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Odslmrt4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Odslmrt4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE0601F00A3A;
	Thu,  3 Sep 2026 00:31:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788395473;
	bh=mCWzaUzTv40D+6KhNoE6I9bpBUhdjHLKO0fcjFRSwhM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Odslmrt4q8oixmzeX5m2aVZ7GahbT+pyQFmtmi4mCjEwTEldgCO4S2tG8EMXUuANl
	 1uqX583JTmbIDGjaAovDYCvuKsyVJBhJs6xi/hQ+AhfJXIvxc0GnbujKirokHE8r95
	 jFsdG2IfvZQUR0ngNOAY7i21tTVluLACPL5HGuuMd6kwp41tdzL6QihWEOXepDvPy0
	 3J7g8LwhDxhY1BYuIuRioR2kJ3UbXpywnHmCARKFFtgObG25n+TAeeb+KxSgOR9pyj
	 RAcfk8bwDqDxNmHQDjrWj3tEcWrdwyTn3V0WpbBMpRrseh+IcLLxDXTZRBHG/eOSVJ
	 f1KJD8vr88dRw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93A503927054;
	Thu,  3 Sep 2026 00:30:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v3 0/4] libbpf: Move section-defined program
 flags
 to prog_flags
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178839541514.3016145.12088992460322743990.git-patchwork-notify@kernel.org>
Date: Thu, 03 Sep 2026 00:30:15 +0000
References: <20260901-libbpf-frags-flags-v3-0-4eb6f14968b0@redhat.com>
In-Reply-To: <20260901-libbpf-frags-flags-v3-0-4eb6f14968b0@redhat.com>
To: =?utf-8?b?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2VuIDx0b2tlQHJlZGhhdC5jb20+?=@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org
Cc: qmo@kernel.org, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, memxor@gmail.com, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com,
 ihor.solodrai@linux.dev, larysa.zaremba@intel.com, davem@davemloft.net,
 kuba@kernel.org, hawk@kernel.org, john.fastabend@gmail.com, sdf@fomichev.me,
 lorenzo@kernel.org, bpf@vger.kernel.org, netdev@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Tue, 01 Sep 2026 10:46:53 +0200 you wrote:
> This series moves the libbpf section-defined program flags into
> bpf_program->prog_flags, thereby making them available for applications
> to inspect and modify before loading the program into the kernel. See
> patch 3 in the series for details.
> 
> Setting program flags with bpf_program__set_flags() was always
> potentially a destructive action, as it clobbers any existing flags.
> Since this changes the flags value to be pre-populated at
> initialisation, this clobbering can be visible in cases it wasn't
> before. To prevent any fallout, the first two commits fixes up existing
> in-tree users of bpf_program__set_flags() to be non-destructive.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v3,1/4] bpftool: Set BPF_F_XDP_DEV_BOUND_ONLY flag non-destructively
    https://git.kernel.org/bpf/bpf-next/c/06d6f845c4bd
  - [bpf-next,v3,2/4] selftests/bpf: Set BPF program flags non-destructively
    https://git.kernel.org/bpf/bpf-next/c/d6746a246b36
  - [bpf-next,v3,3/4] libbpf: Move section-defined program flags to prog_flags
    https://git.kernel.org/bpf/bpf-next/c/d6b633b585f3
  - [bpf-next,v3,4/4] selftests/bpf: Check for flag presence in bpf_program__flags()
    https://git.kernel.org/bpf/bpf-next/c/99c71666dcb1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


