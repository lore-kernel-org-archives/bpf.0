Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9407F43D4FA
	for <bpf@vger.kernel.org>; Mon, 11 May 2026 16:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778517244; cv=none; b=i5EOHpZftc5GDJEMvfFgPJNip20PLCY2H6RE5nAQ5H8JydxYxSJtl3oB/ejvaMN160k20Knfu5pgk4ocZ4daqtEesP4vS9xVvwhugF1TbQjK/+BlWbdv8Up92HCVQ+jX8OmsU5CYStFHeE+r9FQUB4DQG/2jc+WQthekSMFgFvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778517244; c=relaxed/simple;
	bh=G5r4YW6EK4mB3T+WYJ63kK4isI2xyCdaH8r8zNOiQ8E=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=jiXtRTFEGc2UcnG3ttUYsat9E5d0LCupb+TsegD+JKWUp5XgdlXrR+LxuSpkXwvoKc2dyCC4CFRAAKlR+mmi1B1ScPkFrJMAgHDRu/wgOyRJWwOxrUOpp4kjpCf0aCuJIus0CuUQcPkcXMGdpE915aVggs5ppCMzBrgynKOKGi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VLQK9BXn; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VLQK9BXn"
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-48270f099d5so932620b6e.0
        for <bpf@vger.kernel.org>; Mon, 11 May 2026 09:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778517241; x=1779122041; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yh56JEXIueZyjtYRGdInmWMmuqZuTGL0S8MyJigvGF8=;
        b=VLQK9BXnX8yWyeGuWdlbgoULFpQRJbgIHbEADiDtkKoL97/JT4Q3XkVekxQkpX03uq
         U/HqBFFdKsLMuErXrj560uM1r4mc+1AjTIKjwAsxTQ0y142mDt5MF1o+5Jhmh6GuRpo0
         sqhq4QXcudLaP4cwdE4bcayTSwesoDIUNYpCZU5Zvd0PX3T2WZgRwmBGFCurvfxMOHiE
         JTGANp3+3GALmd107czDyQ1WsFopx9tXs2sWGSZGj7vg42XSjLQz0u3XnpdvQ5C8ZN2T
         ecZNjLNdOcr1OhttBEwC1S3ZTXf5t/dxGKgVJsr7atvBIdIis3NMpqJ1x90fQyLx4x6Q
         D1bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778517241; x=1779122041;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yh56JEXIueZyjtYRGdInmWMmuqZuTGL0S8MyJigvGF8=;
        b=Qlp246L6vv9cns30CzgtpGZWJ7yx4qar6VNaLAcHQbZUQlJSoO1kjiRbTtIWXiu2el
         GoX97l8f+Q3gjaiAjXKTSws48xOH97RkXFC90HSedQhscRu6GjyXFIzF4eyRmlQDfoNz
         G54DY7hE69ULEGdeW4T0w1kacwpExXmdXtsSsfV6FEmzEj9pq81qSso3y5LTc7uH8UNd
         i4K6RIXsmldNiYlUAZZ3qJNzNil3HPV6mKW6bueEYkamS68JQVs2cbeTVTx89fvvjW6C
         Ik6Z7wW6U7C2uFFZEQX2uh219nS3t9rzwoskm0eXppHO4p3lWqOBgSgEnClejmsYIciY
         1dcA==
X-Forwarded-Encrypted: i=1; AFNElJ/nrOJzZ5AmfVauQPGpVVl5JJZzBPoi9pAiAv/GvFDK91OAHenkKkYp7iVyg4MjJOjeVIg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJjrzlwNI/jOjKsPjikdmkEV9f2GsWVo+g7oqux23XKqmHSIN+
	ktaU5g3R12GICoKoOBGx31Yzv2SwhVh1gr7RdJjTgUA1sZ3sHR9OhKbb
X-Gm-Gg: Acq92OHcNY/ss9KXpDjcvCsrXM1gklAv3F8rr3BIED12bgF9A5Qra4AqtuSGxGbIWxQ
	gv61VU/I5pCvjyW85gURStl8Ms4VJhH8TBED8P6au5uC4hbhkoiW3TLKumZjZkV2ifwTMI2LBN6
	AxBPGjbbsmoZF1VynNS+hoNGu5ellxyixEPUXiYkLDyPPCmTRYQ/Im0+83iZFSS4ZT2Fxtqf0gb
	NnzOVlM7potTUevT6VIYxqPsLMHQm89ExldhkW61b51ER7oKvnhfXxYPLJXTX3ZkvakxJDSJko7
	hNduDOJKfi9QNET0J85jQ17y2O3e8/oRqWNydIPknSFLsEB2i78/vTIpVQkFdQcImf+roC+iE0Q
	iUk65LJpPHl0qmyz/kLQjp7kM3ydE7taYZboCpV6j4d10QnOamlJt6rWeFcQtofhOMEChuElZTP
	g4Lz6mXAhQHsLEbsvkR4uL9RUBhrktGWoaSuVhjP3c+4sPO0t1lzTkSbnBtZ48lqAS9FnYGcVXc
	rYHNo9J5oWYlTmgs4zEV2/vNUzFj2PnpHDERQ==
X-Received: by 2002:a05:6808:2222:b0:467:e7b:6fd5 with SMTP id 5614622812f47-48042503bbemr15550423b6e.41.1778517241391;
        Mon, 11 May 2026 09:34:01 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:1::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e367c0bc16sm7154971a34.12.2026.05.11.09.34.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 May 2026 09:34:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 11 May 2026 09:34:00 -0700
Message-Id: <DIFZQSR5B66I.26PF8V3P74KSK@gmail.com>
Cc: "Alexei Starovoitov" <ast@kernel.org>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>, "Jose E .
 Marchesi" <jose.marchesi@oracle.com>, <kernel-team@fb.com>, "Martin KaFai
 Lau" <martin.lau@kernel.org>
Subject: Re: [PATCH bpf-next v3 09/24] bpf: Extend liveness analysis to
 track stack argument slots
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Yonghong Song" <yonghong.song@linux.dev>, <bpf@vger.kernel.org>
X-Mailer: aerc
References: <20260511053301.1878610-1-yonghong.song@linux.dev>
 <20260511053348.1885300-1-yonghong.song@linux.dev>
In-Reply-To: <20260511053348.1885300-1-yonghong.song@linux.dev>

On Sun May 10, 2026 at 10:33 PM PDT, Yonghong Song wrote:
> @@ -1071,8 +1105,24 @@ static void arg_track_xfer(struct bpf_verifier_env=
 *env, struct bpf_insn *insn,
>  	struct arg_track *dst =3D &at_out[insn->dst_reg];
>  	struct arg_track *src =3D &at_out[insn->src_reg];
>  	struct arg_track none =3D { .frame =3D ARG_NONE };
> -	int r;
> -
> +	int r, slot;
> +
> +	/* Handle stack arg stores and loads. */
> +	if (is_stack_arg_st(insn) || is_stack_arg_stx(insn)) {
> +		slot =3D stack_arg_off_to_slot(insn->off);
> +		if (slot >=3D 0) {
> +			if (is_stack_arg_stx(insn))
> +				at_out[MAX_BPF_REG + slot] =3D at_out[insn->src_reg];
> +			else
> +				at_out[MAX_BPF_REG + slot] =3D none;
> +		}
> +		return;
> +	}
> +	if (is_stack_arg_ldx(insn)) {
> +		slot =3D stack_arg_off_to_slot(insn->off);
> +		at_out[insn->dst_reg] =3D (slot >=3D 0) ? at_stack_arg_entry[slot] : n=
one;
> +		return;
> +	}
>  	if (class =3D=3D BPF_ALU64 && BPF_SRC(insn->code) =3D=3D BPF_K) {

claude doesn't have a taste.
Please use 'else if' like the rest of the function and remove both 'return'=
.

>  		if (code =3D=3D BPF_MOV) {
>  			*dst =3D none;
> @@ -1297,6 +1347,14 @@ static int record_load_store_access(struct bpf_ver=
ifier_env *env,
>  	struct arg_track resolved, *ptr;
>  	int oi;
> =20
> +	/*
> +	 * Stack arg insns use dst_reg=3DBPF_REG_PARAMS(11), but at[11] tracks
> +	 * the value stored in stack arg slot 0, not a memory base pointer.
> +	 * Skip to avoid misinterpreting that value as an FP-derived pointer.

The comment is confusing. 'not a memory base pointer'? what does it mean?

> +	 */
> +	if (is_stack_arg_stx(insn) || is_stack_arg_st(insn) || is_stack_arg_ldx=
(insn))
> +		return 0;
> +

> -/* Return true if any of R1-R5 is derived from a frame pointer. */
> +/* Return true if any of R1-R5 or stack args is derived from a frame poi=
nter. */
>  static bool has_fp_args(struct arg_track *args)
>  {
>  	for (int r =3D BPF_REG_1; r <=3D BPF_REG_5; r++)
>  		if (args[r].frame !=3D ARG_NONE)

let's make it consisten with below and use arg_is_fp here?

>  			return true;
> +	for (int r =3D 0; r < MAX_STACK_ARG_SLOTS; r++)
> +		if (arg_is_fp(&args[MAX_BPF_REG + r]))
> +			return true;
>  	return false;
>  }
