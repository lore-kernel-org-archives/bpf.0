Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B1A3BB9F4
	for <bpf@vger.kernel.org>; Fri,  5 Jun 2026 15:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780672226; cv=none; b=QxM4loQbWe3lcnkG5uOaaBnLfRuw86wFMYmJDWNEnnHRQyTm3rMEQXahBrr43JpzseR2G09oiwjzZPXFz3fVU6E2MWVA2DjkSUyeW/qzmsMjoJtuOaPMV9PYUisL7nUGIhV42GMyfKoS0sKS0MwkGKV5uNoYXpxpa1A+aqWfEqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780672226; c=relaxed/simple;
	bh=g3A4F7m/wsu1cTZh4V9dhJ4OBBIGVycR2yEKPghA5VQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=N0qjHOdkBUn2vENMXDu90M8NufegpK0typTDqZ5l8T+l0pbIU1luewBhG3+3eTbNoWq3meF3VZpVZxH+mGBnvZYvpftl3g//tF+lZe0l+Y8Sqlb3b8a1V35+ilF4l2XlDqQtWw65PogHlYyJBeIg+lVFkhhFw/kOznCuzWW5VNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O/kNtq47; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O/kNtq47"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A1381F00893;
	Fri,  5 Jun 2026 15:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780672225;
	bh=pIt4IAxFAb8apjraojKSnixncE0dRoCD/7Xyoq8NP2A=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=O/kNtq47pMsYP52mhekgJANXDyBZZCjaFG7IgwwRSvrw0X2D2Jayz5PlopT9PmwZb
	 UOQ7qjbE8ncBxRvUHDpr8OpGo3Zv9ZZGgLOVijxtFqQSqV3pwzK9jp1pVR1EeB1pn8
	 GPhl8WRS/bpHuFIKBrfdId0a9awHclyhBY++kcx8cc2yl9LFoghcjgMSBduAtb74a4
	 wp1/HBSx8nBKT3jxojuFGv/GkReege4FAygN31kRf1pXH9aHgyU2LcGMRqVGHx8/tD
	 GX+ZHoFccLPADBl+Z91ustIDveyKIixp6XOIC8VFiPU5oK/LXoJ08+Ql9+R8h1g/XS
	 FEfInWcy/ArSA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 19A403930BA1;
	Fri,  5 Jun 2026 15:10:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v7 00/12] bpf: Introduce resizable hash map
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178067222589.3794367.15593529397781335998.git-patchwork-notify@kernel.org>
Date: Fri, 05 Jun 2026 15:10:25 +0000
References: <20260605-rhash-v7-0-5b8e05f8630d@meta.com>
In-Reply-To: <20260605-rhash-v7-0-5b8e05f8630d@meta.com>
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com,
 eddyz87@gmail.com, memxor@gmail.com, herbert@gondor.apana.org.au,
 yatsenko@meta.com, emil@etsalapatis.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri, 05 Jun 2026 04:41:17 -0700 you wrote:
> This patch series introduces BPF_MAP_TYPE_RHASH, a new hash map type that
> leverages the kernel's rhashtable to provide resizable hash map for BPF.
> 
> The existing BPF_MAP_TYPE_HASH uses a fixed number of buckets determined at
> map creation time. While this works well for many use cases, it presents
> challenges when:
> 
> [...]

Here is the summary with links:
  - [bpf-next,v7,01/12] rhashtable: Add rhashtable_next_key() API
    https://git.kernel.org/bpf/bpf-next/c/8f4fa9f89b72
  - [bpf-next,v7,02/12] rhashtable: Add selftest for rhashtable_next_key()
    https://git.kernel.org/bpf/bpf-next/c/e673eee0f49e
  - [bpf-next,v7,03/12] rhashtable: Use irq work for shrinking
    https://git.kernel.org/bpf/bpf-next/c/46730ee6e884
  - [bpf-next,v7,04/12] bpf: Implement resizable hashmap basic functions
    https://git.kernel.org/bpf/bpf-next/c/16b4d3e2fb24
  - [bpf-next,v7,05/12] bpf: Implement iteration ops for resizable hashtab
    https://git.kernel.org/bpf/bpf-next/c/818e00848227
  - [bpf-next,v7,06/12] bpf: Allow special fields in resizable hashtab
    https://git.kernel.org/bpf/bpf-next/c/6905f8601298
  - [bpf-next,v7,07/12] bpf: Optimize word-sized keys for resizable hashtable
    https://git.kernel.org/bpf/bpf-next/c/9dcbb5045fe5
  - [bpf-next,v7,08/12] libbpf: Support resizable hashtable
    https://git.kernel.org/bpf/bpf-next/c/6e46ff0abefd
  - [bpf-next,v7,09/12] selftests/bpf: Add basic tests for resizable hash map
    https://git.kernel.org/bpf/bpf-next/c/249996365b66
  - [bpf-next,v7,10/12] selftests/bpf: Add BPF iterator tests for resizable hash map
    https://git.kernel.org/bpf/bpf-next/c/a996794fda84
  - [bpf-next,v7,11/12] bpftool: Add rhash map documentation
    https://git.kernel.org/bpf/bpf-next/c/2bea44ea3c4e
  - [bpf-next,v7,12/12] selftests/bpf: Add resizable hashmap to benchmarks
    https://git.kernel.org/bpf/bpf-next/c/84f7a49e76ec

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


