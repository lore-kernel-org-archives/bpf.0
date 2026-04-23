Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A658034C80D
	for <bpf@vger.kernel.org>; Thu, 23 Apr 2026 04:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776917471; cv=none; b=qeGiQL/Wg9kxhlCf354CsPalw9hsctqUNpr27xkBvXw6QHb5xAV5bJ2rlscuKg4jxvkPpv1IRAaHYmtkWEC5dzCJZD0oOgKh3yBVQZh58qYKgiH3S80TdhcWkSklGyuvlpEPDzM9YI2zrIB+aFh/t8ss9vgbWo5aDSX3sOYlSko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776917471; c=relaxed/simple;
	bh=aGzgzkFEc1UshexHnG5Epy2gCfAQ3QIR1fDX8TENUAw=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=PYk+hBI4LMjzpnAbJdr/I4A9hX5gEsbYwatLMcckejIh656oadoNlNh9+7/zWZ+y3eMUvLVoxT3+ZiTaP65g38BjdGuXU4qxurd5dtRdvBD4rUw8CISqOglhw7olYsOmMX52e64zvs3u+Lm78yWvm747eb1ZQiI6H/5/5xBXvSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JNDrPi++; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JNDrPi++"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 221B8C2BCB2;
	Thu, 23 Apr 2026 04:11:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776917471;
	bh=aGzgzkFEc1UshexHnG5Epy2gCfAQ3QIR1fDX8TENUAw=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=JNDrPi++42mWkxyTEdpB8S+SqY4d3/nvgYkQ8mRGtdhG6PYPu2TNQQuNACbI7GGbD
	 0U9+q9/RAwhDD2979GfcyZRp3k68UdGk6JU3F49Ew/B0a9OrDd+ZQhhtEeTXHcXNdP
	 0V00NfdIjeVzl+7gpAvfYKelK/T3amO2weqZRDEN6bJlbw7v0irUL9mguJt9uOZjUk
	 lacslhXr11Sa65y4EunI53PHpxjrFMU1997hqfgHGOUkaq8HgqTUrRmx2IVQPPGK/K
	 YYJUJO4l2ZSUdt2XBCfCauof7Q4osqo9vPHTk09EcTsom9ziwh/0YiBpQ0cNjLCuv7
	 5YWIdQEmfb3ow==
Content-Type: multipart/mixed; boundary="===============4091374199610002476=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <6f36f4b5fed807d8f983e46904bffe0c7e3746e93b40c37aa5a92934b029afb5@mail.kernel.org>
In-Reply-To: <20260423033511.2542870-1-yonghong.song@linux.dev>
References: <20260423033511.2542870-1-yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next v3 9/9] bpf: Reuse MAX_BPF_FUNC_ARGS for maximum number of arguments
From: bot+bpf-ci@kernel.org
To: yonghong.song@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,jose.marchesi@oracle.com,kernel-team@fb.com,martin.lau@kernel.org,puranjay@kernel.org,memxor@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu, 23 Apr 2026 04:11:11 +0000 (UTC)

--===============4091374199610002476==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index d3aea3931b85..715b6df9c403 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -1151,6 +1151,11 @@ struct bpf_prog_offload {
>
> -/* The longest tracepoint has 12 args.
> +/* The longest tracepoint has 12 args.
>   * See include/trace/bpf_probe.h

This isn't a bug, but the multi-line comment opening doesn't follow BPF
subsystem style. Per Documentation/process/maintainer-bpf.rst, multi-line
comments must have the opening /* on its own line, even if surrounding code
uses the old style.

> + *
> + * Also reuse this macro for maximum number of arguments a BPF function
> + * or a kfunc can have. Args 1-5 are passed in registers, args 6-12 via
> + * stack arg slots. The JIT may map some stack arg slots to registers based
> + * on the native calling convention (e.g., arg 6 to R9 on x86-64).
>   */
>  #define MAX_BPF_FUNC_ARGS 12


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/24815670157
--===============4091374199610002476==--
