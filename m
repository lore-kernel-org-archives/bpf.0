Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B6946AEF2
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 16:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790266280; cv=none; b=qu+RqaqMNU2ypuJ83tXMdfBzzOFMa9aGNWJYXzh0cun+7OgiAM7Xv6i9YEwT8+8H9zM64BkIs36UdHfGkPBqPKYjLB7XjfkMOaBZdXMw6Z92457Lc061fWqSsnKy6iPVNXE/CIiZq8qilAo7gjamnbbZBMozDZkl4+AMBESLs+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790266280; c=relaxed/simple;
	bh=mtKjWuOMiCYOuzYe2ycIDDyC0SxSd5jHgz2oW9hduvY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=t4QciadGBfOzc7qFTw7L6r5xk1cmqJXvAwub8Zo23X3pdUxbru8u8vnfeyCYUxzdj//NwtII30AbbbA7/P3TPepQYap6fjFRxE9al4mwfU5ilUatQJOdH9t57TrsbizW41ddQ85JSDHtOFJWH1EsrfxnFBMhDljrxxBOcENLP6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ks1y5McC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ks1y5McC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F3591F00893;
	Thu, 24 Sep 2026 16:11:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790266279;
	bh=2CO8PBM9qNMplP25BHQarpqdpkPB0B5TWwyK5Y14H8c=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=ks1y5McCa4gtMMAHDqfmLbhc25wLu2yzNSO/QBgUH79/PYkD/CY/0qaYGcizdVsKK
	 SbWBJj2fixfqbFsBe7R28oV+UqBsvKckr9fD6v07Z+qXzlSv4o2ZPk3O7A1kYFdNCJ
	 dqu2g9G6U80HlIpnegLMNfEPLPwYKGICsBY5q4cUpegBqVnmW/pipsp6GMY1YjMDda
	 +SCtG/4bljvQNw/Qr3bUQO0aURB+n+GB0aDJddL/SvzFCgXJfAfjPYS1SRMiIvp2ND
	 pAQZgV6rxMQFVE6IlsMOtWp0yc3gAAU/12FumM3+sZ8wlKuitUF1UuE3Xkmd+IJnhX
	 auvopAkN0fLfA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56A0B3A566CD;
	Thu, 24 Sep 2026 16:10:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4 bpf-next 00/11] Support inline functions in BTF
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179026620815.1631477.1701211223849452726.git-patchwork-notify@kernel.org>
Date: Thu, 24 Sep 2026 16:10:08 +0000
References: <20260924111428.75957-1-alan.maguire@oracle.com>
In-Reply-To: <20260924111428.75957-1-alan.maguire@oracle.com>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: ast@kernel.org, andrii@kernel.org, eddyz87@gmail.com, qmo@kernel.org,
 jolsa@kernel.org, daniel@iogearbox.net, ihor.solodrai@linux.dev,
 yonghong.song@linux.dev, song@kernel.org, martin.lau@linux.dev,
 memxor@gmail.com, emil@etsalapatis.com, bpf@vger.kernel.org, nsc@kernel.org,
 puranjay@kernel.org, yatsenko@meta.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu, 24 Sep 2026 12:14:17 +0100 you wrote:
> This series adds support to facilitate tracing of inline function
> sites using BPF Type Format (BTF) information. An excellent overview
> of the problem and proposed solution presented at LSF/MM/BPF is
> available at [1].
> 
> The aim is to produce a compact representation providing sufficient
> information to a tracer wishing to instrument an inline site via a
> kprobe.  The challenge to solve is compact representation - my
> local bpf-next builds show nearly 600,000 inline sites for approximately
> 100,000 functions.  Any BTF representation should utilize deduplication
> where possible to minimize overheads.
> 
> [...]

Here is the summary with links:
  - [v4,bpf-next,01/11] btf: Extend UAPI to support BTF location (inline site) info
    https://git.kernel.org/bpf/bpf-next/c/33c5a3278bdb
  - [v4,bpf-next,02/11] libbpf: Add support for BTF kinds LOC[_PARAM|_PROTO|SEC]
    https://git.kernel.org/bpf/bpf-next/c/dad2fcc644dd
  - [v4,bpf-next,03/11] selftests/bpf: Test helper support for BTF_KIND_LOC[_PARAM|_PROTO|SEC]
    https://git.kernel.org/bpf/bpf-next/c/0f1de9408e59
  - [v4,bpf-next,04/11] selftests/bpf: Add LOC_PARAM, LOC_PROTO, LOCSEC to field iter tests
    https://git.kernel.org/bpf/bpf-next/c/663fa771389d
  - [v4,bpf-next,05/11] selftests/bpf: Add LOC_PARAM, LOC_PROTO, LOCSEC to dedup split tests
    https://git.kernel.org/bpf/bpf-next/c/dfb463b07117
  - [v4,bpf-next,06/11] selftests/bpf: BTF distill tests to ensure LOC[_PARAM|_PROTO] add to split BTF
    https://git.kernel.org/bpf/bpf-next/c/49a4c23a2234
  - [v4,bpf-next,07/11] bpftool: Handle multi-split BTF by supporting multiple base BTFs
    https://git.kernel.org/bpf/bpf-next/c/7890a57356a2
  - [v4,bpf-next,08/11] bpftool: Document support for multi-split BTF
    https://git.kernel.org/bpf/bpf-next/c/0ec4caf73ce5
  - [v4,bpf-next,09/11] bpftool: Add ability to dump LOC_PARAM, LOC_PROTO and LOCSEC
    https://git.kernel.org/bpf/bpf-next/c/321562c34d5b
  - [v4,bpf-next,10/11] selftests/bpf: Test bpftool dump of BTF location info
    https://git.kernel.org/bpf/bpf-next/c/3429e01578b6
  - [v4,bpf-next,11/11] Documentation/bpf: Describe new location-related BTF kinds
    https://git.kernel.org/bpf/bpf-next/c/ce2913d959a2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


