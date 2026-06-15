Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EF6423BF9F;
	Mon, 15 Jun 2026 00:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781484034; cv=none; b=We7/1O+O1tB8sZr9X8GygByEqktxKBiIgy+CTn7OL3FvKAyofNb85IXq0RQVuRb2MvsAWNomCwsh2kc8riTHfHCLn6w9kwNEnfQbfVPYbpSbsqlhK2pYkjziGqSNQAnog9820nqlutGRc3B3x8eYVT5fZbZ2OpK9e0LWp0oa2RY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781484034; c=relaxed/simple;
	bh=oxFDhOh+bQGe/fGOxNU9oFVi1hkHe1pdFg3N5tdCl2M=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=aUtDmTi33D9jxYX3BGO5cZ7+2AAFLH9gbBQXVP2gRsrNdm7S75jFrwo4O/1A7cP46Q7F8g2fel/7Q9AkRfkzx+NvB0YG55PZzehwNC9uKjl5aZKJzc4B0WhgmlHo1EtW3lus8zeJlBI/sStu8Kt3oy4Qy7b5htYPbjD6VSU/+Kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B4yZhG+g; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B4yZhG+g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59F4E1F000E9;
	Mon, 15 Jun 2026 00:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781484033;
	bh=jXv4XYGmxQm1hv9jzH1x0NJtxWmVyiiGQTlcM4SJqI8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=B4yZhG+gNegJ/tNt5QfgrA6h+n+yzg0afb8ye0ArsfXV1oK/xLbqsFyapOk/JNAUG
	 gN2c+S3aKgXZQ3GV8klAty3F3tVsNyXpaOMy98Q36pLSAIOeYq4zKFzcxwL/zXgneo
	 +jQLJ3QDRzu5aJO9yPdMw79yflxCfBQS6kG3sISQtPYupRXMJTfo/VD65eHcH4UMMr
	 ndvb8nea8hl51qNe3O8/oldymRSWvh8A2Z1t1T7tgQqtSv74Vr37k8sNaDFyKocEm4
	 sAwoX01GcL17DIFDZn4vo/WsIFGlPuvIB/GqODnU9cIcE9Pd09rhS8u2o1AH30XIaU
	 7ARKln2A7Mq4g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 198693A566D2;
	Mon, 15 Jun 2026 00:40:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2 0/8] tools build: bpf: Append EXTRA_CFLAGS and
 HOST_EXTRACFLAGS
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178148402863.2363016.5034665284884003104.git-patchwork-notify@kernel.org>
Date: Mon, 15 Jun 2026 00:40:28 +0000
References: 
 <20260602-tools_build_fix_zero_init_bpf_only-v2-0-c76e5250ea1c@arm.com>
In-Reply-To: 
 <20260602-tools_build_fix_zero_init_bpf_only-v2-0-c76e5250ea1c@arm.com>
To: Leo Yan <leo.yan@arm.com>
Cc: qmo@kernel.org, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, shuah@kernel.org,
 lmb@isovalent.com, nathan@kernel.org, nick.desaulniers+lkml@gmail.com,
 morbo@google.com, justinstitt@google.com, acme@kernel.org,
 namhyung@kernel.org, irogers@google.com, james.clark@linaro.org,
 kees@kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, llvm@lists.linux.dev,
 ihor.solodrai@linux.dev

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue, 02 Jun 2026 15:47:09 +0100 you wrote:
> Append EXTRA_CFLAGS and HOST_EXTRACFLAGS to the BPF build.
> 
> This mitigates an issue introduced in GCC 15, where a {0} initializer
> does not guarantee zeroing the entire union [1].
> 
> The common changes under tools to support EXTRA_CFLAGS and
> HOST_EXTRACFLAGS are sent separately [2].  As suggested, BPF patches
> would be picked up via the bpf tree, so this series only includes BPF
> related changes.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2,1/8] bpftool: Pass host flags to bootstrap libbpf
    https://git.kernel.org/bpf/bpf-next/c/9080b97689db
  - [bpf-next,v2,2/8] bpftool: Avoid adding EXTRA_CFLAGS to HOST_CFLAGS
    https://git.kernel.org/bpf/bpf-next/c/956841cbc3d7
  - [bpf-next,v2,3/8] bpftool: Append extra host flags
    https://git.kernel.org/bpf/bpf-next/c/3f2fec5b02b6
  - [bpf-next,v2,4/8] libbpf: Initialize CFLAGS before including Makefile.include
    https://git.kernel.org/bpf/bpf-next/c/f3846b3800a2
  - [bpf-next,v2,5/8] tools/bpf: build: Append extra cflags
    https://git.kernel.org/bpf/bpf-next/c/b40ba139371c
  - [bpf-next,v2,6/8] selftests/bpf: Initialize operation name before use
    https://git.kernel.org/bpf/bpf-next/c/55ffbe8a15b1
  - [bpf-next,v2,7/8] selftests/bpf: Use common CFLAGS for urandom_read
    https://git.kernel.org/bpf/bpf-next/c/584f3b7a3525
  - [bpf-next,v2,8/8] selftests/bpf: Avoid static LLVM linking for cross builds
    https://git.kernel.org/bpf/bpf-next/c/62617d28d9ae

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


