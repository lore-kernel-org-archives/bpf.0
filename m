Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F81913F00F
	for <bpf@vger.kernel.org>; Wed,  6 Mar 2024 19:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709753432; cv=none; b=I5bTO4P454FH8b6Fc+gvKQmrFZClOzJD+XaFVzTsbLK7WNJu4JTxqwxLD0+eBOQrwCmsLQ7zPdv/pAy1Kk6Z7cReF6yUBVImlN/E5fmiy4OCNNgcaRFEpSqiJ0ZXlGg568h/7YAtKJgqOZ/DPBOf6yNUxRlsrICzx6q6nnfeozw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709753432; c=relaxed/simple;
	bh=stufQQ8kD/M3tNiS1gVx0bYC984OYXvmu6Y1b/3GPuk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Y52P2NzeHWyUJMLtg7rMfTRrY5Enr/HJwYVQfRnD4kGwkfloCXf9MvjH5HIK+cnNqccLBPdMePeKuptl6akde71kayjQ21RbWO6iCCf7UKG5O2cmavMiJxczhnMm6qY+M2C3LlUm6W2ncRCl0/EmxoqpvRSeSx7t/rXE1gIeUH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VLkj40KW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VLkj40KW"
Received: by smtp.kernel.org (Postfix) with ESMTPS id C9D4AC43390;
	Wed,  6 Mar 2024 19:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709753431;
	bh=stufQQ8kD/M3tNiS1gVx0bYC984OYXvmu6Y1b/3GPuk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=VLkj40KWWSFYhPPNuH9AwSr8iVUNDnyExuVZPZDmM3FT17JPJvwWHc8qfxUahPk3Q
	 SiAo9WkuushwJbMTT0ziZb43/g97OnbhDJ8szf4jhn2xoB1d0X5iDVRVaBv/cf8Xzh
	 4ooaL68NuEFJdPLVMvnXeW2mIwgjzB4WA41NStWAXnt2YJGgHCr6kqdKaymozotfCP
	 aLH2Rd8BWoDasUMmYsBlNR5UV1lkL4S3zzFiYdNKoEz6eRC+HaphafnjcNXsfKlSnL
	 yuAmBmxYAWfY6Q3peCPWxp6et0ZmU1OuuDkaHsLUP5nLRsrq4Yc3n3O73u8ikJ+8jk
	 dXK6tVhrzlUQw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id ACAE1D9A4B5;
	Wed,  6 Mar 2024 19:30:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v4 00/15] libbpf: type suffixes and autocreate flag
 for struct_ops maps
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170975343169.31409.14202616471159827755.git-patchwork-notify@kernel.org>
Date: Wed, 06 Mar 2024 19:30:31 +0000
References: <20240306104529.6453-1-eddyz87@gmail.com>
In-Reply-To: <20240306104529.6453-1-eddyz87@gmail.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com,
 yonghong.song@linux.dev, void@manifault.com, sinquersw@gmail.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Wed,  6 Mar 2024 12:45:14 +0200 you wrote:
> Tweak struct_ops related APIs to allow the following features:
> - specify version suffixes for stuct_ops map types;
> - share same BPF program between several map definitions with
>   different local BTF types, assuming only maps with same
>   kernel BTF type would be selected for load;
> - toggle autocreate flag for struct_ops maps;
> - automatically toggle autoload for struct_ops programs referenced
>   from struct_ops maps, depending on autocreate status of the
>   corresponding map;
> - use SEC("?.struct_ops") and SEC("?.struct_ops.link")
>   to define struct_ops maps with autocreate == false after object open.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v4,01/15] libbpf: allow version suffixes (___smth) for struct_ops types
    https://git.kernel.org/bpf/bpf-next/c/88972acee1f9
  - [bpf-next,v4,02/15] libbpf: tie struct_ops programs to kernel BTF ids, not to local ids
    https://git.kernel.org/bpf/bpf-next/c/1fcdcca90bf2
  - [bpf-next,v4,03/15] libbpf: honor autocreate flag for struct_ops maps
    https://git.kernel.org/bpf/bpf-next/c/08c5dde48dd0
  - [bpf-next,v4,04/15] selftests/bpf: test struct_ops map definition with type suffix
    https://git.kernel.org/bpf/bpf-next/c/901a9c536f26
  - [bpf-next,v4,05/15] selftests/bpf: utility functions to capture libbpf log in test_progs
    https://git.kernel.org/bpf/bpf-next/c/4597f853d5bc
  - [bpf-next,v4,06/15] selftests/bpf: bad_struct_ops test
    https://git.kernel.org/bpf/bpf-next/c/9c82929ce1bc
  - [bpf-next,v4,07/15] selftests/bpf: test autocreate behavior for struct_ops maps
    https://git.kernel.org/bpf/bpf-next/c/08dfc1369554
  - [bpf-next,v4,08/15] libbpf: sync progs autoload with maps autocreate for struct_ops maps
    https://git.kernel.org/bpf/bpf-next/c/607a50ff2802
  - [bpf-next,v4,09/15] selftests/bpf: verify struct_ops autoload/autocreate sync
    https://git.kernel.org/bpf/bpf-next/c/404855a8c3be
  - [bpf-next,v4,10/15] libbpf: replace elf_state->st_ops_* fields with SEC_ST_OPS sec_type
    https://git.kernel.org/bpf/bpf-next/c/24d9fe302af5
  - [bpf-next,v4,11/15] libbpf: struct_ops in SEC("?.struct_ops") / SEC("?.struct_ops.link")
    https://git.kernel.org/bpf/bpf-next/c/cea716b7850b
  - [bpf-next,v4,12/15] libbpf: rewrite btf datasec names starting from '?'
    https://git.kernel.org/bpf/bpf-next/c/43525abbdb0d
  - [bpf-next,v4,13/15] selftests/bpf: test case for SEC("?.struct_ops")
    https://git.kernel.org/bpf/bpf-next/c/df32d591bf63
  - [bpf-next,v4,14/15] bpf: allow all printable characters in BTF DATASEC names
    https://git.kernel.org/bpf/bpf-next/c/503012aad7f3
  - [bpf-next,v4,15/15] selftests/bpf: test cases for '?' in BTF names
    https://git.kernel.org/bpf/bpf-next/c/bc22f9a13840

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


