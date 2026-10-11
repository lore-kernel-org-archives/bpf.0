Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2158312831;
	Sun, 11 Oct 2026 14:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791729615; cv=none; b=cYucM2bwQnmAUWMei9H3wsTl0JBM15OQ4HeAM53K1dCfqn7OiofYhvP/m0S8iMc5+Wrq3eWvYizIoNTYhaPYA4JiW+UH38j0Rvsz9aJmXwsd7AmZkjOerhx4N3129qmLv+bYtb4Q5hZnCvJx4OqLkegfHRYu1uupEM8I7sCVqU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791729615; c=relaxed/simple;
	bh=Z1OVY4OUF8Of/CX3we9KSbqm9WZQzj8SosoxBGN/H2E=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=fKTogI8Xg0J3l30hd3PUAj4MArbomxENlSZBYzhPNo0hMNeC24dFSENjDSz7Ck6cNUTJ99YOdyaGYDRXdXyQOfbetyKe3r0hxyrdX9PweFpr8HnYV2wCis3LaQNqP/4TlXQS19ccqaChoALp1I8YtBsTecPMu+TOSX6x5GWcmpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I2XEARt2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I2XEARt2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCD801F0089B;
	Sun, 11 Oct 2026 14:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791729614;
	bh=ktsNKPGL6JlMq864QckXCxNTZWD3FqCQk4ps5BpQc+8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=I2XEARt23cZ6dV8ATDqAiY0sdO5b8DFiYScBgJuc92CPdxtUpI8Ov74qJ96Oh3NyG
	 RxXS4Xmw5mlkMJCDmSKNivBsW5e5eCZ+j6bgfRw45zSW43Cegq1tksRYBu4s1bW6WA
	 AJq+Q41q08y+nb8WyE9HI5WaHxkgs8gYlLm7Mi7Gp3E294xN7cH0zzUkZApBklaobQ
	 MPzWDmZ8dqDxKaNDzeqSKHi17wfgBUCVj+Pyxjc346l6rYqFg7pUftZzR9Il9UD2c/
	 YVv0tfdRdUbtj8o+Bp6cwyT18CZiFLNnYiW4CkVVjlFFAANni4IEgz9VX8elM82EU8
	 7i61A1wSTOopw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B432938119C4;
	Sun, 11 Oct 2026 14:40:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4 bpf-next 0/7] kbuild, bpf: Support inline info in BTF
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179172961326.2072230.906820075160340410.git-patchwork-notify@kernel.org>
Date: Sun, 11 Oct 2026 14:40:13 +0000
References: <20261009112324.1442319-1-alan.maguire@oracle.com>
In-Reply-To: <20261009112324.1442319-1-alan.maguire@oracle.com>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 eddyz87@gmail.com, jolsa@kernel.org, ihor.solodrai@linux.dev,
 yonghong.song@linux.dev, song@kernel.org, qmo@kernel.org,
 martin.lau@linux.dev, memxor@gmail.com, emil@etsalapatis.com,
 mcgrof@kernel.org, petr.pavlu@suse.com, tj@kernel.org, kees@kernel.org,
 nathan@kernel.org, arnd@arndb.de, puranjay@kernel.org, yatsenko@meta.com,
 atenart@kernel.org, ojeda@kernel.org, linux-modules@vger.kernel.org,
 arnaldo.melo@gmail.com, bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri,  9 Oct 2026 12:23:17 +0100 you wrote:
> If CONFIG_DEBUG_INFO_BTF_INLINE=y|m, add the "inline" BTF feature
> and encode inline site info in BTF alongside standard BTF data.
> resolve_btfids will then partition into non- and inline-related
> info and split BTF will be used to store inline info in a
> .BTF.inline section in vmlinux and modules.  For
> CONFIG_DEBUG_INFO_BTF=m, vmlinux inline info will be stored
> in btf_vmlinux_inline.ko and will be loaded on-demand if used
> via /sys/kernel/btf/vmlinux.inline.  A .BTF.inline.link section
> in vmlinux stores the module name, the SHA of the BTF and the
> size so that even without loading the kernel can size the
> sysfs representation correctly.  This approach is based on [1]
> and the .BTF.inline.link section is modeled on .GNU_debuglink.
> 
> [...]

Here is the summary with links:
  - [v4,bpf-next,1/7] resolve_btfids: Build separate main and inline BTF objects
    https://git.kernel.org/bpf/bpf-next/c/cf91a7db92c6
  - [v4,bpf-next,2/7] resolve_btfids: Populate BTF link section
    https://git.kernel.org/bpf/bpf-next/c/aac67645215d
  - [v4,bpf-next,3/7] kbuild, btf: Expose vmlinux inline BTF through sysfs
    https://git.kernel.org/bpf/bpf-next/c/672981f4aec1
  - [v4,bpf-next,4/7] btf: Preserve string relocation maps for split BTF
    https://git.kernel.org/bpf/bpf-next/c/5876080366ae
  - [v4,bpf-next,5/7] btf: Relocate and expose module inline BTF
    https://git.kernel.org/bpf/bpf-next/c/42d7153fcb44
  - [v4,bpf-next,6/7] selftests/bpf: Test BTF sysfs inline representations
    https://git.kernel.org/bpf/bpf-next/c/d0de4dc51247
  - [v4,bpf-next,7/7] selftests/bpf: Add a test verifying inline information
    https://git.kernel.org/bpf/bpf-next/c/400f0881c912

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


