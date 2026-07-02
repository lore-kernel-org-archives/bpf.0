Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08C7522332E;
	Thu,  2 Jul 2026 06:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782972116; cv=none; b=gE7UzWY3Iv4p0PRGLBXCycIVhoj01tzTbdqGw7CROUoBDLisG66Gmj64nn3nxH/omEUdafU4e/E2FjvSJNZA9OpQ/pzRTvUPPK1xDeVqO9j4X3p5F5m2B3Hbt5WuKz2kzQYagAcalp71EWdspa+aCWYibpyJOD1gywLvhnQOqjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782972116; c=relaxed/simple;
	bh=Ydtfqij3wo6LOGDeCGeZe/nU5WEx5kYmvGqqT05EK7U=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=J6CBFyXDkObeBCwOcaRX4o+pbwOC38NvxPGHc38i/WPBX8QCIcjoYB7Dafa5tKu0Ge4DWlbHkG2kc6Smx5SmfXHZw9gRv1Oojb7blAj44lko+oTkrAdWrkr4aJLo6JsoinvUMS5UXoZdu8SaAGCa59LyfuVXgb/aPtpN6JZRMAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BMuMb2zH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BMuMb2zH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D8921F000E9;
	Thu,  2 Jul 2026 06:01:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782972114;
	bh=cKPd4z1Xf8JW19YEmMTpu1uewWUK1Wlu0tLwU1Qpuv4=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=BMuMb2zHLahQbG+yGP+3FSf3EBA8dxXlYkM8zNcgs5HJ2qMEnJ0bqlPDlyp2jDrff
	 Yoc5gFv8kZVySRb9WpsrC1uHEc6Jp9VGE9upNsT/+aQ0KhTY37GAZV9U9LphwbfK6N
	 17yXEv+HYpkq8hdWWd+6fIRw6mU1HIHmoruy/6E/ZPNAr6mnb2HktAfsWTiClRxtOk
	 UfDJIRtA4LyI18jES2neitseKgzr/D+u3ShhyqDxFEEAjBEPpnrNOGApr0hhonxGQp
	 O7uxyB6sG48wtk0+boTr8tBpfmPhRfx93Idu0ZLU3rZVukyNW6cVndhgsTdb1Y9LZL
	 /50cXmBtZzA0w==
Content-Type: multipart/mixed; boundary="===============1323697411249830709=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <4f48c0a2f4a53b1faacf2b94c36a978cbf6075218f839de6922409e1566befbd@mail.kernel.org>
In-Reply-To: <20260702053127.23599-1-yangtiezhu@loongson.cn>
References: <20260702053127.23599-1-yangtiezhu@loongson.cn>
Subject: Re: [PATCH bpf-next v6] bpf: Reject programs with inlined helpers if JIT is unavailable
From: bot+bpf-ci@kernel.org
To: yangtiezhu@loongson.cn,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,kafai.wan@linux.dev
Cc: bpf@vger.kernel.org,loongarch@lists.linux.dev,leon.hwang@linux.dev,puranjay@kernel.org,bjorn@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu,  2 Jul 2026 06:01:54 +0000 (UTC)

--===============1323697411249830709==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index ba09795e0bfd..f5c283af3cf7 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -1889,6 +1889,7 @@ struct bpf_prog {
>  		u8 digest[SHA256_DIGEST_SIZE];
>  		u8 tag[BPF_TAG_SIZE];
>  	};
> +	u8			jit_required;	/* program strictly requires JIT compiler */
>  	struct bpf_prog_stats __percpu *stats;
>  	u8 __percpu		*active;	/* u8[BPF_NR_CONTEXTS] for recursion protection */
>  	unsigned int		(*bpf_func)(const void *ctx,

The placement and overall design of this jit_required field does not look
settled yet in the upstream discussion.

Changes were requested on this version, with the note that it is not an
improvement over the previous version, so is the standalone u8 field here
the approach that has been agreed on?

  https://lore.kernel.org/bpf/CAADnVQJodzDppDUjSYXra-jCo3J32t7=h32bHm4tQei-+5P72w@mail.gmail.com/

> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index 649cce41e13f..a55754bcc593 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -2639,7 +2639,7 @@ struct bpf_prog *__bpf_prog_select_runtime(struct bpf_verifier_env *env, struct
>
>  		fp = bpf_prog_jit_compile(env, fp);
>  		bpf_prog_jit_attempt_done(fp);
> -		if (!fp->jited && jit_needed) {
> +		if (!fp->jited && (jit_needed || fp->jit_required)) {
>  			*err = -ENOTSUPP;
>  			return fp;
>  		}
> diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
> index 12a8a4eb757f..94e0457a0aa3 100644
> --- a/kernel/bpf/fixups.c
> +++ b/kernel/bpf/fixups.c
> @@ -1841,8 +1841,10 @@ int bpf_do_misc_fixups(struct bpf_verifier_env *env)
>  		}
>
>  		/* Skip inlining the helper call if the JIT does it. */
> -		if (bpf_jit_inlines_helper_call(insn->imm))
> +		if (bpf_jit_inlines_helper_call(insn->imm)) {
> +			prog->jit_required = 1;
>  			goto next_insn;
> +		}
>
>  		if (insn->imm == BPF_FUNC_get_route_realm)
>  			prog->dst_needed = 1;


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/28568041313
--===============1323697411249830709==--
