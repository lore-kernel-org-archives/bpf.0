Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795063544;
	b=ZuMq/fYurpIOqo6uX2k+uoCFc6rBSLuK2tUWRThy9p8sFW+JkeLPtIrK68cHWUeM4n2I
	 RQwymAG/XMUgX+0+r5rsEnMxQTUfM9VXmy+WxccjiwCnKCkSmQvvAkTdNa64GfUc7uUXx
	 W5UNTx72ZmWQxrVXW6jEpdvJB2gzNhLaxrkb6vjzcnp4Xm77TNZV2CmjI+PJ+Xhs50c3y
	 9jtiD3Bi18BCGA8Fx6hEUGyB9SxGYbL3VhqlCKqn0dDDGMYZXqSUjKjC/A/IY/S3qecB/
	 cR+IMOh9IlRAoTIYYJqGLDY7JKiiTqAZgmQhVTB8ARSGq7adg4R7ARu/v+jQvH1icaQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795063544;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=LkI7Sy95lBvfbQtMVCxtNAxq0Xj/HDOqrG1KSqd25kM=;
	b=j3vaG0SR596dlmmrV0eIsS5u+NuH11o3C1aQqAe/PdRKXxgPKE7byxi3G5zZuQQDH6M5
	 WEal3cHgMCzYqgTCYV39V/5os2xoK7JY5CbloRI0yjJkkCuwAD/LC7cyDvvj4qnG2Jepl
	 LvPK8UWE9S+Zdxkr3KW6NI6YWh6wbO5a8ePzytyyCgGt4aa2TLD1sV+FCkbJttZAQPyok
	 msXLJ0VP92kJXqCLBKEF+1YXyeW6YdAfjt0TF6WhSiqzohyorHZLheiSnN1ArmCiIF7rQ
	 4frczL8PgjHnepOm92Qaq6xW9zKPRo26uEPxW2feefQVJ7vmqWMREAY6xq/OlVcgsFg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pt3Czxvu;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.54
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20110606A320
	for <bpf@vger.kernel.org>; Thu, 19 Nov 2026 04:45:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 20110606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pt3Czxvu
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4a207b02a2cso12476135e9.1
        for <bpf@vger.kernel.org>; Wed, 18 Nov 2026 20:45:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795063542; cv=none;
        d=google.com; s=arc-20260327;
        b=kMDDjUSwnFoL7CZQYhBAa6/FeRjqEE0XDABX4+9Oq05k3fVB6bjsyFacnWYhe+Utxv
         BqInrqJC+t3tpl0OsHXhVCibBwaVyrjh2Xxel0rv4ITK3POsdUlUtM3lUjK+89EIK8DH
         EZcD98j3yVymYwwhVZ0n2jBcHPsCZ2Rnf2g6+mcb6NFKuMUO18Alsf93oT55ckfU9uQE
         eTuzvwCt3+8GoFmItonINK9KwymqzBmScZPiacusVfYyY4T35SbDuAF1RYUKLGhojUOO
         t4fRlt9bLSsk9wEFlWr9rvuiOzNO9UBKHRDQ1MeUROWxyI6vsnIjJBtiVdADIOmgcFPa
         +ujg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LkI7Sy95lBvfbQtMVCxtNAxq0Xj/HDOqrG1KSqd25kM=;
        fh=4uw84coSCmWOj7LdwJRrIzQOX1n0jKyZ+O9ChA6x00s=;
        b=WmfK24n74/aXKNmoz7kQEWj6f4sxXKvYr0N9xF+bzVQD+GrQ9O63kBmSAV2yHvHBX/
         qkebNQjSSkUvS8w6S+KClYKqstx9qHG1L0LyufYlfck04XrNPF3AiQWFS7/VSnsdeWqN
         x5I2JNnK48ggjSpNtjvjiAPZeFILdwFBfLN4FDcAtNwgaEq1GonVhfsGaLpLUVZCwROf
         PDFcyOYZR+iWfDGz/9aJ3868GrU7OPkJ/HTmQdW/V3mxatniInwxASCBSMswzGAXB7oK
         uyFbdw7/YeZ0VRY7qluA0pWQd6SBsS17Jt4+Kr+Xv7RXtEzac10VemQ7XxugUPUtwVYt
         SZfg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795063542; x=1795668342; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LkI7Sy95lBvfbQtMVCxtNAxq0Xj/HDOqrG1KSqd25kM=;
        b=pt3CzxvuyBsOj1wsoXny9gI/xTJXqfh4On2chU/g8Il2ASxQE6OOanVQU2Ab1ubqdO
         lSGjIPvG/YGH5Sv93h5GKiVHjBVfey6dv+l+Xije0UBQUE4CgSM4XETUlFx0YstaQuDl
         AO3F2ObgGyZSZ0gJw31Fyh3++MuTQ2Vo1YXgsXYC66IhdTeqcPodMyGn5ggtrKWommLt
         OTPb2TQSfKO5R8JFPPyu0h6Yto6YneLZvl3m898mlMpuMX6h+bulfV7OTFKDFQJ+Gm91
         XcbnlBbDKsDw0UiYS68R2RXi4OHqt/lTEju39vskepOkvOc2HvDR4d/RGe3UH5Ze+Ugc
         3FXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795063542; x=1795668342;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LkI7Sy95lBvfbQtMVCxtNAxq0Xj/HDOqrG1KSqd25kM=;
        b=s16CQ8CaN8QVnkqefIoZCHxHU1WkCUouvQjgmdazmXWxH2rCnVTP1hWCO4k5A6grNY
         3yArZIUjU0BjoGm65s3yJ+mcr9jtjZiEBMmYoFhTNE7/bJ4SMMy5cQ22NnHVsFHn7PLF
         xmdLHs5yIiMpG+gYLMGGUH4EvFfQ0BWd7aRmHjaTpRwUAiDORY5/SrR30N3U3xRMoau6
         hpV3MfeCrkH05cX/x5xGjQim3ILjnKdC5YZzMOH9ePB00YnQUXeFsbBOVksGYS3v00gk
         EJa2CQsRNCxJjTPq0OfEA0ZQF/lmWpffxllo5IHoGZSWssNYXVxtuC7r3jJ+q11hISUM
         7BVA==
X-Forwarded-Encrypted: i=1; AL+hErG3IBpKLoiTqtPf9cDdb4tNs3YiGPJJjC7j/namRz/qJg8PMSXXEblHMcRa1M+X+b8Y/ko=@vger.kernel.org
X-Gm-Message-State: APuU4Z8fPigTM4K2VAGySlh3+rK1+JXQGzYidNsJiBywpqYL9XN7Cx61
	jrP2gGQJKJ+jYA+lDLwyK+tJIMIsfQTdOC4y0dEBNeLa/pPhVPhkcN0gvo7QNw1KBTggQSRAEo1
	5Gp/n3M9xOe+ruiY65ZQH36Y7qz2qRTfPUQ==
X-Gm-Gg: AYBFou19EBP694GnE8MUMtl/VeZ1Q3mOggi4KLX32pNQQbztvqz8T2H6BR8FbQXLcbZ
	dr5wzWHTa4biNy89k82HVjU6aomf+Mgg7ZEoVrPPKqX9dLEK1GKBqNR9zDMyj77EaGFDP2AxsV3
	pvWr64TEKPEKGkGqJ3AJtJhuOsR1dgzvNH1nQpPd3roY+/cjhIw9KNsq7OF21Cd30skjZl4FaT2
	7q4mvg6/PdIDK29Q0V+oWL8eRgs/UK1aMKlpgZUriSrzNmNsk8HFz4lAoW6Bo8Cp1MYPHNGmnSx
	/vLJxPxpCJUPaj7fDgTnNApIjmhVtM2W7+XPNsF1CBSEoxQa9PEiHkp5MgtTr4JNxCs40DlDsjC
	+z/l3JRzGdGSbhdvksR/DCYnKn/vxmRBMP/jv2S5gzNbW8aGrgEArcJe3eVoGpB2LOAUPaq+qiw
	eJjGxfGPLI6gmPDqYxSQ==
X-Received: by 2002:a05:600c:8b5c:b0:4a2:397:73f6 with SMTP id
 5b1f17b1804b1-4bb7da13a97mr99793645e9.8.1795063542301; Wed, 18 Nov 2026
 20:45:42 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261119000112.2377949-1-andrii@kernel.org> <20261119000112.2377949-2-andrii@kernel.org>
 <DMYSXNCMOF26.38XGLPOW4K29X@gmail.com>
In-Reply-To: <DMYSXNCMOF26.38XGLPOW4K29X@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 18 Nov 2026 20:45:30 -0800
X-Gm-Features: Aa3M54ru9v9e2z-jn0buLdaQZSqjE5mLeJ2k6xUEdsRdwJ_B7hJSsTaDWvpbQxk
Message-ID: <CAEf4BzbcPkqX+YncZ+3ysFnXmJWaAUyZiF9BkhbTW27h7MxPxg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/3] arm64: perf: Don't report the caller
 twice in caller-regs callchains
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com, 
	will@kernel.org, mark.rutland@arm.com, linux-perf-users@vger.kernel.org, 
	peterz@infradead.org, jolsa@kernel.org, rostedt@goodmis.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 18, 2026 at 5:38=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Wed, Nov 18, 2026 at 04:01 PM Andrii Nakryiko <andrii@kernel.org> wrot=
e:
> > Do the same on arm64. Set pstate to PSR_MODE_EL1t, which exceptions
> > taken from the kernel never have (the kernel runs in EL1h, or EL2h
> > with VHE), and skip the leaf regs->pc in perf_callchain_kernel() for
> > regs with that mode. The unwind still starts from regs, with the frame
> > record at x29 walked by the unwinder.
>
> my bot thinks the following will be a more accurate fix...
>
> diff --git a/arch/arm64/include/asm/perf_event.h b/arch/arm64/include/asm=
/perf_event.h
> index ee45b4e..7c5ab65 100644
> --- a/arch/arm64/include/asm/perf_event.h
> +++ b/arch/arm64/include/asm/perf_event.h
> @@ -13,11 +13,12 @@
>  #define perf_arch_bpf_user_pt_regs(regs) &regs->user_regs
>  #endif
>
> +/* PSR_MODE_EL1t marks these regs for kunwind_stack_walk() */
>  #define perf_arch_fetch_caller_regs(regs, __ip) { \
>         (regs)->pc =3D (__ip);    \
>         (regs)->regs[29] =3D (unsigned long) __builtin_frame_address(0); =
\
>         (regs)->sp =3D current_stack_pointer; \
> -       (regs)->pstate =3D PSR_MODE_EL1h; \
> +       (regs)->pstate =3D PSR_MODE_EL1t; \
>  }
>
>  #endif
> diff --git a/arch/arm64/kernel/stacktrace.c b/arch/arm64/kernel/stacktrac=
e.c
> index 3ebcf8c..de394ff 100644
> --- a/arch/arm64/kernel/stacktrace.c
> +++ b/arch/arm64/kernel/stacktrace.c
> @@ -357,6 +357,13 @@ kunwind_stack_walk(kunwind_consume_fn consume_state,
>                 if (task !=3D current)
>                         return -EINVAL;
>                 kunwind_init_from_regs(&state, regs);
> +               /*
> +                * With perf_arch_fetch_caller_regs() the PC is a copy of=
 the
> +                * LR in the frame record at FP. Start from that record.
> +                */
> +               if (processor_mode(regs) =3D=3D PSR_MODE_EL1t &&
> +                   kunwind_next(&state))
> +                       return -EINVAL;

if arm folks approve, I'm all for this fix deeper in the generic
unwinder code, smaller and cleaner change, thanks!

>         } else if (task =3D=3D current) {
>                 kunwind_init_from_caller(&state);
>         } else {
>
