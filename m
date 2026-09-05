Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D4252C15BE
	for <bpf@vger.kernel.org>; Sat,  5 Sep 2026 01:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788571281; cv=none; b=IaHLodaHmAsO0AYTFVVVtz58OaStRCMyqNgaPPbSVgJr8f5NF7oANGjN21OjtoF7eVRy2ik599TXBN5dTpCUHThPlwgA1DFJlJGNT6S2MhYgwsvAwllzUPCvSl6S56X8E6q5/3qSzpMjgNh8cb7iTXIAmGYDRL7eeVuxu244CMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788571281; c=relaxed/simple;
	bh=BzEs3r/+3ajkyLkRLZFCVtUp2HB3PXL80Jn1G5pukg8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=r3OY84z/TkcTV4GCM3NirbkdgSBXE6VS+/bph3zFzTiX7E0e64a/aYjQB1A/cA6GS1K2yTuuOgZG2BpKx9vtCNAgiIcbFQhYuwJhY6i1KfWThnkCejsH3j1RZDOwRGLJ5fwPCZdyH2cZZodam7S9xWn/GFXu2UU3NVt3b9cByVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m9fA7vLp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m9fA7vLp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2C191F00A3D;
	Sat,  5 Sep 2026 01:21:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788571279;
	bh=f3pre1PtmxvNINfdgNZQWTWH+NRnQdtQE81uS7WDMq8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=m9fA7vLpZSdIcT64i8ToA8gshBhCfyg39lDYsP/4E/uMTdlN2gYrK69ZR04jJqj38
	 CjTa41lx7BGbTv8AFV3XeTNfymuRTh5E2wnjts6JSOdw8ZEwBLawO8507B8s0Eeh40
	 0D97xW7D0ly7dTZu8UzcPrRIHdnO2EiUnT64lSIM6285Zn3e25wUPRnFmKaG7XuV5y
	 Ddwj65d1/LT4X8a5ZBaqodU2FO44v2L/0cSuawwbZ6C689AnG7ZWWXachz8/cdxiUh
	 cXOuCI3JWJbW0wvzn3ebwWV3rXI4SqU1gedic1dmkOXtop5JRfYh/A0uFW2D8kVMaI
	 7yJPxVtybsjfg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 90C113924FC0;
	Sat,  5 Sep 2026 01:20:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf 00/10] bpf: add missing precision propagation after
 bpf_register_is_null calls
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178857122039.1047271.17751024419566077235.git-patchwork-notify@kernel.org>
Date: Sat, 05 Sep 2026 01:20:20 +0000
References: 
 <20260904-register-is-null-precise-fixes-v1-0-0f5a360ff15d@gmail.com>
In-Reply-To: 
 <20260904-register-is-null-precise-fixes-v1-0-0f5a360ff15d@gmail.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com,
 yonghong.song@linux.dev, memxor@gmail.com

Hello:

This series was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri,  4 Sep 2026 17:05:51 -0700 you wrote:
> Fix [1] uncovered a host of locations where the call to
> bpf_register_is_null() is not followed by a call to
> bpf_mark_chain_precision().
> 
> check_map_kptr_access() is omitted as it is handled [2]
> by another series.
> 
> [...]

Here is the summary with links:
  - [bpf,01/10] bpf: mark a NULL call argument precise
    https://git.kernel.org/bpf/bpf/c/1a3a10b030c9
  - [bpf,02/10] selftests/bpf: precision of a NULL helper argument
    https://git.kernel.org/bpf/bpf/c/593c8eb0fb91
  - [bpf,03/10] bpf: mark a NULL memory argument of a call precise
    https://git.kernel.org/bpf/bpf/c/f1e418129f2e
  - [bpf,04/10] selftests/bpf: precision of a NULL global subprogram memory argument
    https://git.kernel.org/bpf/bpf/c/100f4cc0d59b
  - [bpf,05/10] bpf: mark a NULL kfunc argument precise
    https://git.kernel.org/bpf/bpf/c/506ada89629e
  - [bpf,06/10] selftests/bpf: precision of a NULL kfunc argument
    https://git.kernel.org/bpf/bpf/c/562d266d3fae
  - [bpf,07/10] bpf: mark a NULL BTF_ID argument of a global subprogram precise
    https://git.kernel.org/bpf/bpf/c/e726fc6b9afe
  - [bpf,08/10] selftests/bpf: precision of a NULL global subprogram BTF_ID argument
    https://git.kernel.org/bpf/bpf/c/91957791663f
  - [bpf,09/10] bpf: propagate mark_chain_precision() errors out of loop_flag_is_zero()
    https://git.kernel.org/bpf/bpf/c/1d7f8f191c06
  - [bpf,10/10] bpf: use mark_arg_precision() in check_mem_size_reg()
    https://git.kernel.org/bpf/bpf/c/cf2475616b11

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


