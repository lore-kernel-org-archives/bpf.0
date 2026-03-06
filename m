Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ACCD29D269
	for <bpf@vger.kernel.org>; Fri,  6 Mar 2026 00:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772756494; cv=none; b=Vpul4lKuOcrdoE3hOoT5uToOwrjNY6npIYqJ6tUi+3pTz4HOvlAFcMgjAM3jQLxPp5wo/LQccWBJO1XHbydfO62eHUMQwq8T2seagKg3T3FVMB43NgGFd6UMxE+E7loe9JECSthU2MC1Hjq5zrG/SoliLKBYHT1mawr/kKlLgdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772756494; c=relaxed/simple;
	bh=APTL0BPkViB5c4y6a/4Ni/K7l8cFWYwjbQr20ZtlGTc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pjr1mT9qy9J9N8/9kikcl/ry/R0D9Ua/fUsUxorpdfFt9IoKCKH33jeEECF6nv/Tj8b+8plbm3DIb7ef+ITT1wpCruyHQNNVJS5D5p9Z0qtsTj07AGhuXvVpcdRlAsdgHPWwZ8dokT0Qcc5N4eQm3ibJ7zXASTaVuN/GtP+1GkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CaXq9qfD; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CaXq9qfD"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-439c4bde55cso1996415f8f.1
        for <bpf@vger.kernel.org>; Thu, 05 Mar 2026 16:21:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772756491; x=1773361291; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=18R+nrgwHC5k/eO2hFuuEc5nDpEsIHWOBuLE1wkKo+Y=;
        b=CaXq9qfD8FGVPm4fvYhX+Z/NmvCHSn5pvQPzjfVXtCDDWNBo/K6Ay9jSav9l0x4VN/
         6dPjef6Vav03Yj6Bh4FMPG+MWxxznM5e+HEfUUnyH1QA2zCcKISDZfCCrvGKK7BtzzY5
         6D73FhgeEarCP8o7/3H3GimJW42EEmVNaM3dQ6VSDt7+8FtfEpyN/IYqp2Oqz7NLysnz
         EFGzWcsLLiHXMbQfrflQ6DrmBM6qny5+i0Ji6gCw7jH2izeagUbFESZyRdAWfz6rrJl4
         quiiKSCCQnMZOSoJc4jawr6QvZY6bSSqjuFhQ+P1gDi4S0cTBJQIAWaz5wW7sAzQ1QMK
         dICQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772756491; x=1773361291;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=18R+nrgwHC5k/eO2hFuuEc5nDpEsIHWOBuLE1wkKo+Y=;
        b=o0QjdCe7tN9vgFAt07lrqYnRyTGCTVjYfH2Lx9oztEfS9f7jZYinqZKAOPQsDKFVEX
         uxXWC7+8NI82D+rCJsmqJ5lzL4a4tJo9TY/j0ib0Rvu31NKrKY4AQga1fInrRjZyyoCy
         o1IjOceCijREI/YtvaTrAkjcy+4QaszC1p1OWwCBy/vd8CMjMc/Ui2jmQcEzgFy00Qc3
         xFym8jUDASgJZRDR7ZzVagliTt9pCtxw2N6bhSdNO1mi2uZ6r5zmCP2EzpnnPnpG66FD
         ggcL5/RD+PIBDpgMz0MSUx1GiBxisgw6eRut0GcPSV4LlhUsymOUHeCKxQ6pptTB5Tc4
         D1Xw==
X-Gm-Message-State: AOJu0YyL7U6z04mwk47KpWRKQTaEGGrla06ABaO/Y5eEi+uUBWNn0Gei
	oSmcGk+Ut5sDu5QqiXfK83VGD+hAKR3WAk9VNsE5O+DtUEixSir/owA5
X-Gm-Gg: ATEYQzwgkQnrui3TAvdYfzXrD8Gl/5ooLyfTnsb1Eo15iJ2yIuRiWHvk8YSczxTLAw5
	D22wjPUydcipjGjED/+PHgPp9jrUMS2ikLDJlueLRCOh9wJF8q7rbfTmu4yFtBhUMVrPhY0Ucxi
	J/8iAdky5FPGDXRy//A4JD08sIrwmbFNAizJIVI9QOcI1yi7CxO/bw7WTTbJu999zDd473HL45Z
	IH9cerxOC29cvp0f/WjU0T9QylATie3v9qlD/ARQtuGhIAojmHlLfePZSruCxPE5UJxW7mCFR9E
	NxEMq7Z74sLnmzn0uJSzeC00WLl14VxuDlnOurZv0MqYTI0iQn0qALzAzgZSf9nQRXpLWQLpW6e
	9vbaTVLofh/7cyLYBKRgjJJglGk7hZSghL81tm5viRVgYCqSAV1V/xnGT54Wcp6lmqp8v/iC5Nb
	CgxmM2/OmzOF6jGxslFcnIyUhNCopmU169bIDrFXjkNzf4nsnBk2HRt2n3fN0r7eJB7mOQ3kWoQ
	FSpB3f4vuY5g4yY8voo+/DaKQELkO3wtrnxCFn5ZJy4JHU3tgEMmil5tkHHAz6Idfy+5KEKQrc=
X-Received: by 2002:a05:600c:8b68:b0:477:df7:b020 with SMTP id 5b1f17b1804b1-48526969730mr2134885e9.18.1772756491346;
        Thu, 05 Mar 2026 16:21:31 -0800 (PST)
Received: from Tunnel (2a01cb089436c0001b77cc3ec8ba0ad1.ipv6.abo.wanadoo.fr. [2a01:cb08:9436:c000:1b77:cc3e:c8ba:ad1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4851fafbf9bsm70849945e9.14.2026.03.05.16.21.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 16:21:30 -0800 (PST)
Date: Fri, 6 Mar 2026 01:21:28 +0100
From: Paul Chaignon <paul.chaignon@gmail.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
	daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com,
	yonghong.song@linux.dev, emil@etsalapatis.com, arighi@nvidia.com,
	shung-hsi.yu@suse.com
Subject: Re: [PATCH bpf v2 2/2] selftests/bpf: test refining u32/s32 bounds
 when ranges cross min/max boundary
Message-ID: <aaoeCEn0-_KWvSPS@Tunnel>
References: <20260305-bpf-32-bit-range-overflow-v2-0-7169206a3041@gmail.com>
 <20260305-bpf-32-bit-range-overflow-v2-2-7169206a3041@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260305-bpf-32-bit-range-overflow-v2-2-7169206a3041@gmail.com>

On Thu, Mar 05, 2026 at 11:48:23AM -0800, Eduard Zingerman wrote:
> Two test cases for signed/unsigned 32-bit bounds refinement
> when s32 range crosses the sign boundary:
> - s32 range [S32_MIN..1] overlapping with u32 range [3..U32_MAX],
>   s32 range tail before sign boundary overlaps with u32 range.
> - s32 range [-3..5] overlapping with u32 range [0..S32_MIN+3],
>   s32 range head after the sign boundary overlaps with u32 range.
> 
> This covers both branches added in the __reg32_deduce_bounds().
> 
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> ---

As mentioned in the other thread, we can now also switch the
BPF_F_TEST_REG_INVARIANTS flag on the existing test:

diff --git a/tools/testing/selftests/bpf/progs/verifier_bounds.c b/tools/testing/selftests/bpf/progs/verifier_bounds.c
index 60ef97695915..e526315c718a 100644
--- a/tools/testing/selftests/bpf/progs/verifier_bounds.c
+++ b/tools/testing/selftests/bpf/progs/verifier_bounds.c
@@ -1148,7 +1148,7 @@ l0_%=:    r0 = 0;                                         \
 SEC("xdp")
 __description("bound check with JMP32_JSLT for crossing 32-bit signed boundary")
 __success __retval(0)
-__flag(!BPF_F_TEST_REG_INVARIANTS) /* known invariants violation */
+__flag(BPF_F_TEST_REG_INVARIANTS)
 __naked void crossing_32_bit_signed_boundary_2(void)
 {
        asm volatile ("


With that,

Reviewed-by: Paul Chaignon <paul.chaignon@gmail.com>

>  .../testing/selftests/bpf/progs/verifier_bounds.c  | 37 ++++++++++++++++++++++
>  1 file changed, 37 insertions(+)
> 
> diff --git a/tools/testing/selftests/bpf/progs/verifier_bounds.c b/tools/testing/selftests/bpf/progs/verifier_bounds.c
> index 97065a26cf70603c3e4b8d43d3a04248828398fc..60ef976959153d25c19ba08c3c2f265d8d83b33e 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_bounds.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_bounds.c
> @@ -2000,4 +2000,41 @@ __naked void bounds_refinement_multiple_overlaps(void *ctx)
>  	: __clobber_all);
>  }
>  
> +SEC("socket")
> +__success
> +__flag(BPF_F_TEST_REG_INVARIANTS)
> +__naked void signed_unsigned_intersection32_case1(void *ctx)
> +{
> +	asm volatile("									\
> +	call %[bpf_get_prandom_u32];							\
> +	w0 &= 0xffffffff;								\
> +	if w0 < 0x3 goto 1f;		/* on fall-through u32 range [3..U32_MAX]  */	\
> +	if w0 s> 0x1 goto 1f;		/* on fall-through s32 range [S32_MIN..1]  */	\
> +	if w0 s< 0x0 goto 1f;		/* range can be narrowed to  [S32_MIN..-1] */	\
> +	r10 = 0;			/* thus predicting the jump. */			\
> +1:	exit;										\
> +"	:
> +	: __imm(bpf_get_prandom_u32)
> +	: __clobber_all);
> +}
> +
> +SEC("socket")
> +__success
> +__flag(BPF_F_TEST_REG_INVARIANTS)
> +__naked void signed_unsigned_intersection32_case2(void *ctx)
> +{
> +	asm volatile("									\
> +	call %[bpf_get_prandom_u32];							\
> +	w0 &= 0xffffffff;								\
> +	if w0 > 0x80000003 goto 1f;	/* on fall-through u32 range [0..S32_MIN+3] */	\
> +	if w0 s< -3 goto 1f;		/* on fall-through s32 range [-3..S32_MAX] */	\
> +	if w0 s> 5 goto 1f;		/* on fall-through s32 range [-3..5] */		\
> +	if w0 <= 5 goto 1f;		/* range can be narrowed to  [0..5] */		\
> +	r10 = 0;			/* thus predicting the jump */			\
> +1:	exit;										\
> +"	:
> +	: __imm(bpf_get_prandom_u32)
> +	: __clobber_all);
> +}
> +
>  char _license[] SEC("license") = "GPL";
> 
> -- 
> 2.53.0
> 
