Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA8253E92BC
	for <bpf@vger.kernel.org>; Wed,  1 Apr 2026 12:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775047284; cv=pass; b=LDvbsJGhginHNbaOYD/6BpaOBAZIHH4+l2Y/Ya9I9usDMK3Gj6hceXPEHDpr/i90U5vofu1AoS+gksjmvFbr5kNVNEsI/2ZwcYTR2Yi60eE7UREawdRnDRbDc1cTZeFVzBwuFiSJG86PbTOeCxK8SKePp91RJBuzIYESN2mP3ZU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775047284; c=relaxed/simple;
	bh=kHfmg587nuz6sT+w9VNqzrsd52W3nqgr2XfojRBhOnc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AOHmCBcadUXGGjIE9mDNyZ7Dqzig50du/1517gs4/qLqvz2U3LrHmr8KKMf+mGXnikUyj98AxCl5pTjqL6kxWzkVmffZaW74bGAdEbQh6CZ9rM9dtWeShaPbl9H3rASY/s3QP2evVyll8Z4WqmFZiVwUVK3zcFOU/Rx9qo4+w/I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cuZqkfY9; arc=pass smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cuZqkfY9"
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-486fb439299so64026075e9.0
        for <bpf@vger.kernel.org>; Wed, 01 Apr 2026 05:41:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775047281; cv=none;
        d=google.com; s=arc-20240605;
        b=Kh2jtxHoNHLMsooYWXsvVPgNkOLF8BUp8EBVi2wiGe+b3s7HGOG7EGZMHZr0lTVvmw
         kIX8/Ot8uZyo0gXEYE2o+op75ZD9nhU9QQ/MMopKUW/1Qcg5mpB9lwnKLZMDKb/YZIuf
         K/E0A7oBq7RJnVmpEQF4Jv/W//G0fTyO0TLbmp/diaG6PC55D81LtKR374lYyLzWlCwu
         rJHqYd23x0Zpoe4aGVqnA7A9603UifG/yaM2oscMVeszTet7Wy0RK4rniKEEu/LNMs5P
         W5PMCRVNg6lMERetqvAQGoKkOHvsQ9Klo+HAeWDTQGgZ2p1arjbBTwr4OFVyTtkK2nk/
         SACg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=lBhH1kKcSYaK6STuvtxTFle/HgoE3Y3fFFB61xstfBk=;
        fh=l6WJarpbqo7h4qrS+dxsCcHiLB8aqrEFQ/wJibGtcEA=;
        b=IpkEcRZg6IZjTl0JmD1ULE6qJfG5g1ywyt2hT3rZy2rK2vI9ejWe4k8XWqOhK/3IV9
         8nID2rg35xevoIg3h8VuMdKmZdN1NBDSVNs9bntR+b3vO5ymJ5N7an+iUZOsSZTnp4Y+
         pgUumYRxHi0o5tzimk6h+oC8zoKFu8uqbJFI4314bwyOr7HCP5rF7w2L1N9J01ScuInr
         V83Dv3g5NzQekt8n2pN5MKFSYAS9YRnKPtTFN5Rx48dcCUvdHhVmN5mto2r4hFa5VBS4
         0iPw1NVRwWwLzPC7A4YJOJSkMQJlAZE2fwOAyrrmFLInBmO33ZdUXWj7/642l88hFgRU
         4L0w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775047281; x=1775652081; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lBhH1kKcSYaK6STuvtxTFle/HgoE3Y3fFFB61xstfBk=;
        b=cuZqkfY9KH2ebULBsln+5pzOMb0uFzk9spCTCpSLkiddvloyrh76iNJCYlCOL0RP4Y
         NE4IRh90fX9ft1gTntDbC/X9ebpmC1C7pGlGwnqjkRi0OfwA0jE5MTEUdlP/2jte6db7
         2AZMfJ46+840V2IXIzc7EGpcY/dV9VyYn+6YkejhQ8WwmAag3p2F9CkFKzPSaOmx/R5o
         yAJHSfnRQ+H2yyf6AJsqpf9y3HWymB6Na71KhCRXYRb/+Tu5nKdtQTfdGvlfmWOllKEV
         25UDCvy7jpHqh1S+lbYWX8py0Ysi01hT75MMp6fkBf6KWb6uRx7UVT6I3kh9yBmhZ/to
         RyOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775047281; x=1775652081;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lBhH1kKcSYaK6STuvtxTFle/HgoE3Y3fFFB61xstfBk=;
        b=Y0zF/ZdDf2XdBzyYjOx+0Kr27uWsCobVbP/sb68Fqf+qw+T6TOmAyQLhfVW2DEJ7dR
         r8kjJr47skVbfunFx1K6mv8/jNuuzM7FAuaKNm3p8f6+A/6YCMj5ByLIjMVh1GU03EJo
         sg8QUD4b4ut7BpEAXfZl3a9/+Ka9a58wr43p7JBJW1o0UxYbC62cHMJW47w4bKZtZ1qy
         t+jHbZlOfMA2JiC9YnIbf5tcJH+jmVilKF5hZA+wVQwJNElpkwlzWbtULVzPaos7I7ae
         sYJDAtcVkSfD/+mrx2FQjTpN22w5ArY4BhegzdJRWmTUh1PtQiwxLSVijt2ysabU5SDP
         X/8g==
X-Gm-Message-State: AOJu0Yx+6K4/EiZEsXa1zbaTNiVFwUwIbYSA0HNJBP6RhuLOVEfFOEjL
	8KYwAMykAcxo9uMVXfGE46rYpdBb1hWiNVQoWfStmU7OQhW9WnQK3G3vCiuxQDyQIoitNEN5k9W
	FOiRTmHQPAElFwjvbtZDiMW+LrLG6chkvY8+UYhF61Q==
X-Gm-Gg: ATEYQzxKvDNti21mBPD1BabvH+zJ/9EzRhrXpxYevUfPEYXVStr7XuIgpAMozypUvu7
	xczJ0Vp62kMbHtwHP9qndvxthd1o6Y9Ebiv8ev7pcpgxlfQT5vAquzrrhmPQHxjSzrxRLe0tjmJ
	RTdupx6diuKmIibcx2sJCJujycTN2M3jdF0y3eaPfIRmvPmqhnQMFIko/LJ+azsEVzfjAgfkl0e
	6MYjd4fXzDE4KZ9KqddJu5KKRSb1BVxi6omq5hbXQbh+NyynHwKTzmWh2x82vJ+7DpbmES0jfBP
	b2Adbshsm0UqShRDD0UHxDSBx4U/AN+/g0F6SpIA4raKp+jnfv7x9L+7fjY=
X-Received: by 2002:a05:600c:3516:b0:485:3f72:3230 with SMTP id
 5b1f17b1804b1-48883597e85mr50541405e9.15.1775047280346; Wed, 01 Apr 2026
 05:41:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260401122818.2240807-1-memxor@gmail.com> <20260401122818.2240807-2-memxor@gmail.com>
In-Reply-To: <20260401122818.2240807-2-memxor@gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Wed, 1 Apr 2026 14:40:44 +0200
X-Gm-Features: AQROBzC-1wgH-zDCh6t297bJoboCmEZSlYPbqqT9D58zzNvK8WJUiQhvVqrZGLM
Message-ID: <CAP01T75eUpgaYeM--RGms84QtvJeJxr-Ky9yDLpS2CdxDgn+=g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 1/7] bpf: Support variable offsets for syscall PTR_TO_CTX
To: bpf@vger.kernel.org
Cc: Emil Tsalapatis <emil@etsalapatis.com>, Puranjay Mohan <puranjay@kernel.org>, 
	Mykyta Yatsenko <yatsenko@meta.com>, Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Tejun Heo <tj@kernel.org>, Dan Schatzberg <dschatzberg@meta.com>, kkd@meta.com, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 1 Apr 2026 at 14:28, Kumar Kartikeya Dwivedi <memxor@gmail.com> wrote:
>
> Allow accessing PTR_TO_CTX with variable offsets in syscall programs.
> Fixed offsets are already enabled for all program types that do not
> convert their ctx accesses, since the changes we made in the commit
> de6c7d99f898 ("bpf: Relax fixed offset check for PTR_TO_CTX"). Note
> that we also lift the restriction on passing syscall context into
> helpers, which was not permitted before, and passing modified syscall
> context into kfuncs.
>
> The structure of check_mem_access can be mostly shared and preserved,
> but we must use check_mem_region_access to correctly verify access with
> variable offsets.
>
> The check made in check_helper_mem_access is hardened to only allow
> PTR_TO_CTX for syscall programs to be passed in as helper memory. This
> was the original intention of the existing code anyway, and it makes
> little sense for other program types' context to be utilized as a memory
> buffer. In case a convincing example presents itself in the future, this
> check can be relaxed further.
>
> We also no longer use the last-byte access to simulate helper memory
> access, but instead go through check_mem_region_access. Since this no
> longer updates our max_ctx_offset, we must do so manually, to keep track
> of the maximum offset at which the program ctx may be accessed.
>
> Take care to ensure that when arg_type is ARG_PTR_TO_CTX, we do not
> relax any fixed or variable offset constraints around PTR_TO_CTX even in
> syscall programs, and require them to be passed unmodified. There are
> several reasons why this is necessary. First, if we pass a modified ctx,
> then the global subprog's accesses will not update the max_ctx_offset to
> its true maximum offset, and can lead to out of bounds accesses. Second,
> tail called program (or extension program replacing global subprog) where
> their max_ctx_offset exceeds the program they are being called from can
> also cause issues. For the latter, unmodified PTR_TO_CTX is the first
> requirement for the fix, the second is ensuring max_ctx_offset >= the
> program they are being called from, which has to be a separate change
> not made in this commit.
>
> All in all, we can hint using arg_type when we expect ARG_PTR_TO_CTX and
> make our relaxation around offsets conditional on it.
>
> Drop coverage of syscall tests from verifier_ctx.c temporarily for
> negative cases until they are updated in subsequent commits.
>
> Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
> Acked-by: Puranjay Mohan <puranjay@kernel.org>
> Acked-by: Mykyta Yatsenko <yatsenko@meta.com>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---
> [...]
>
> @@ -9724,6 +9739,17 @@ static int check_func_arg_reg_off(struct bpf_verifier_env *env,
>                  * still need to do checks instead of returning.
>                  */
>                 return __check_ptr_off_reg(env, reg, regno, true);
> +       case PTR_TO_CTX:
> +               /*
> +                * Allow fixed and variable offsets for syscall context, but
> +                * only when the argument is passed as memory, not ctx,
> +                * otherwise we may get modified ctx in tail called programs and
> +                * global subprogs (that may act as extension prog hooks).
> +                */
> +               if (arg_type != ARG_PTR_TO_CTX &&
> +                   resolve_prog_type(env->prog) == BPF_PROG_TYPE_SYSCALL)

Sigh, this can be is_var_ctx_off_allowed(env->prog) for clarity. I
will fix in respin after waiting for comments.

> [...]
>
