Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E10620E023;
	Thu, 29 Jan 2026 14:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769698471; cv=none; b=tV9O142F4BU0l/kRRbBr2Kzegt9wCpjenGdwM/AumGoea7W1x7Q2PsUP7QZebz6Kogc0lxlsBoR6Gtt2hD785UoEL1Im788qy6zypakjOg88mJErGvHzAxTrGYixRH2lI15Gy71XgKDxeoKa/LGc2KgSTnJSdoPWXGWpIile6Sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769698471; c=relaxed/simple;
	bh=uNTYkn+aM8NuAC+kDwXIL4ebrbnUJ+D01SE35TIEzlg=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=kuRIFn5Lp6dT2IVOuFXjUUvA5lRJUua5cMGjiGH74nm3EPzt1l/piWPg2HL+ZhO8/DevVvB4eqcniDSp5CculEFRBHtqnGdqc9Awmj8u3+HY7JWIYDjDcvSlXFcrA6JKQn8UC4VInkf9Wa2+Dp0yJNMSvoxpJNm2dYWax4FZov0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gxHDo6NX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gxHDo6NX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E13CBC4CEF7;
	Thu, 29 Jan 2026 14:54:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769698471;
	bh=uNTYkn+aM8NuAC+kDwXIL4ebrbnUJ+D01SE35TIEzlg=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=gxHDo6NX5nRoVPa8+7m/YvFTxRfnfZnFrhIXmElFdBc5AUiItxV6L4Q63wJ2+FeEC
	 V+Z9PFwGoAwPzbRjfTPYxEUuAyNmidBkW1Z8dk469nZkkcWdx3nUvjZOKWjjOzVHR/
	 iONRNui3M6OydUVjAxX8L4JMRtgLnwt6fXLTpJE0mvgDcLwC5MWqTEEviGLM4pDwbj
	 WSIxT58z0kgTsLEDQpEFmGV+Q85h1YRrb4PqglT20+yagYQwtd4xVhCzoAoxhlUa3b
	 e3CeLVtuCw49jqWKpFaMDPm0ottx+Fw0x1c4HJa3a4Yo+Q7AZKrbMO4dApwcBiJ1U4
	 OS9cdW+bNYeUg==
Content-Type: multipart/mixed; boundary="===============1026379547978389575=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <97fd7e67669f887badde4e276fc501a5969ff9dac703a6dccedda386dacd25f1@mail.kernel.org>
In-Reply-To: <20260129142536.48637-2-leon.hwang@linux.dev>
References: <20260129142536.48637-2-leon.hwang@linux.dev>
Subject: Re: [PATCH bpf-next v3 1/3] bpf: Add bpf_jit_supports_fsession()
From: bot+bpf-ci@kernel.org
To: leon.hwang@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,john.fastabend@gmail.com,kpsingh@kernel.org,sdf@fomichev.me,haoluo@google.com,jolsa@kernel.org,puranjay@kernel.org,xukuohai@huaweicloud.com,catalin.marinas@arm.com,will@kernel.org,shuah@kernel.org,menglong8.dong@gmail.com,leon.hwang@linux.dev,linux-arm-kernel@lists.infradead.org,linux-kernel@vger.kernel.org,linux-kselftest@vger.kernel.org,kernel-patches-bot@fb.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu, 29 Jan 2026 14:54:30 +0000 (UTC)

--===============1026379547978389575==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index e7ff8394e0..6e0693ac72 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -24874,6 +24874,9 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
>  	case BPF_TRACE_FENTRY:
>  	case BPF_TRACE_FEXIT:
>  	case BPF_TRACE_FSESSION:
> +		if (prog->expected_attach_type == BPF_TRACE_FSESSION &&
> +		    !bpf_jit_supports_fsession())
> +			return -EOPNOTSUPP;

This isn't a bug, but other similar bpf_jit_supports_*() checks in
this file include a bpf_log() message before returning an error. For
example:

  bpf_jit_supports_kfunc_call() -> "JIT does not support calling kernel function"
  bpf_jit_supports_exceptions() -> "JIT does not support calling kfunc..."
  bpf_jit_supports_arena()      -> "JIT doesn't support arena"
  bpf_jit_supports_private_stack() -> "Private stack not supported by jit"

Should this check also include a message like "JIT does not support
fsession" for consistency with other similar checks in the verifier?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/21482297342

AI-authorship-score: low
AI-authorship-explanation: The commit demonstrates specific debugging context with actual test output and errno values, correct understanding of kernel BPF conventions, and follows established patterns - typical of experienced human kernel developers.
issues-found: 1
issue-severity-score: low
issue-severity-explanation: Minor consistency issue - missing bpf_log() error message compared to similar checks in the same file; does not affect functionality or stability.

--===============1026379547978389575==--
