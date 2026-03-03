Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 961462EE611
	for <bpf@vger.kernel.org>; Tue,  3 Mar 2026 05:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772514806; cv=none; b=MmHHvYJU1afYRyslqmRTWQsqwwHl4sT09ZkhftpPa9SCvqkh0qfptcsL/EirKNkVR3nlS76kV9nTLo+Pf0JYVatTw4i54E3FT/NP7hCWSUpArGCszQZQ15Ji39KFFhi3xLLatpha/A0Jw9k+TjFMv155br0b4WKvMVSuIj8mIdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772514806; c=relaxed/simple;
	bh=9QhRN++VT7N32e20qr2KgKnnqQUvg9FZjJs62CzbUA0=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=X70BGsONKfSpJ0r/HrUw9xhkxuoIMHDTr5d3lSYdp8/dSOVCf3Ncg1a7KWUaEKHBxC55p1XFKQBT+3FhH1e0E0svLR4BhuNPjCiQuZz2fDR1m3KVCW1CtNRe108VYDknC+alYOJuGwi8qhj39QoEFlOGM0clNm9JcDursyMIc1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FDYRNvis; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FDYRNvis"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AF35C116C6;
	Tue,  3 Mar 2026 05:13:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772514806;
	bh=9QhRN++VT7N32e20qr2KgKnnqQUvg9FZjJs62CzbUA0=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=FDYRNvisPTJPFPYKbeB1q6Y+q34fI2mNmNmS1qB6fIDZB1H8ZIuK2Spz7+vvfkvnt
	 lDl/IFt+7amS0aakIlDJ/sYOD/konloLMhhFrozLlmiI5NdKiG3RxXoaAWkF0nW8+L
	 4EstIkMswpt894/02dgTE7Xg5bAiuAYa63qBh381nSDWo3WFFXxl2YHZJSEuL0nctS
	 0KZs3fiRmGX52g6RsZApJCzVsJEtaKDHtDGO4A/MJ1Hlz2l+CAHFRwfLirZelA/5Dg
	 lortaAhNnMjzkcCJwu7flLC+4wAN1uXrXYbV4Zty9s/fEN1Mmf0OaTUO2BElgXemon
	 TAb/UCPq26FDQ==
Content-Type: multipart/mixed; boundary="===============4093751139783373728=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <ad397307a9cd76c9739ee05f4642c7b6a881b7dfb8a2facefa6b2062ffe328ea@mail.kernel.org>
In-Reply-To: <20260303043106.406099-2-emil@etsalapatis.com>
References: <20260303043106.406099-2-emil@etsalapatis.com>
Subject: Re: [PATCH bpf-next v3 1/2] bpf: Only enforce 8 frame call stack limit for all-static stacks
From: bot+bpf-ci@kernel.org
To: emil@etsalapatis.com,bpf@vger.kernel.org
Cc: andrii@kernel.org,ast@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,martin.lau@kernel.org,memxor@gmail.com,song@kernel.org,yonghong.song@linux.dev,emil@etsalapatis.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue,  3 Mar 2026 05:13:26 +0000 (UTC)

--===============4093751139783373728==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -650,6 +650,8 @@ enum priv_stack_mode {
>  	PRIV_STACK_ADAPTIVE,
>  };
>
> +struct bpf_subprog_info;
> +
>  struct bpf_subprog_info {

This isn't a bug, but the forward declaration above the struct
definition appears unnecessary.  The new fields (ret_insn, frame,
cidx) are all plain int types, not self-referential pointers that
would require forward declaration.  Is there a reason for it?

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -6799,7 +6808,7 @@
>  		if (subprog[idx].has_tail_call)
>  			tail_call_reachable = true;
>
> -		frame++;
> +		frame = subprog_is_global(env, idx) ? 0 : frame + 1;
>  		if (frame >= MAX_CALL_FRAMES) {
>  			verbose(env, "the call stack of %d frames is too deep !\n",
>  				frame);

In the selftest below, the expected error message was changed to
"the call stack of 9 frames", but this verbose() call still prints
the raw frame counter.

With 9 static functions in the chain (global_func3 + f1 through f8),
frame reaches 8 when entering f1, and the verifier outputs "the call
stack of 8 frames is too deep !" -- which does not contain "9 frames".

The MAX_BPF_STACK error path was updated from frame + 1 to a cidx
chain walk for total count:

    for (total = 1; subprog[idx].cidx >= 0 ; total++)
        idx = subprog[idx].cidx;
    verbose(env, "combined stack size of %d calls ...\n", total, depth);

Was a similar update intended here?  Changing frame to frame + 1 in the
verbose() call would match the selftest expectation and be consistent
with how the stack overflow message now reports total count.

> diff --git a/tools/testing/selftests/bpf/progs/test_global_func3.c b/tools/testing/selftests/bpf/progs/test_global_func3.c
> --- a/tools/testing/selftests/bpf/progs/test_global_func3.c
> +++ b/tools/testing/selftests/bpf/progs/test_global_func3.c

[ ... ]

> @@ -5,56 +5,56 @@
>  SEC("tc")
> -__failure __msg("the call stack of 8 frames")
> +__failure __msg("the call stack of 9 frames")
>  int global_func3(struct __sk_buff *skb)
>  {
>  	return f8(skb);

This expected message does not match the verifier output as described
above.

Also, the function header comment for check_max_stack_depth_subprog()
currently reads:

    Since recursion is prevented by check_cfg() this algorithm
    only needs a local stack of MAX_CALL_FRAMES to remember callsites

The local arrays ret_insn[] and ret_prog[] have been removed in favor
of struct fields (subprog[].cidx, subprog[].frame, subprog[].ret_insn).
Should this comment be updated to reflect the new approach?  The v2
patch did update this comment for its design.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/22608683847
--===============4093751139783373728==--
