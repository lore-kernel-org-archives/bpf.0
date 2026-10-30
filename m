Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793382725;
	b=fn51sJJKhwmkmTF8H7+qcbJuNLgKJ3WNTMin/AVwsr9NtLkGlmfm+dCHz9ulymv2NQHf
	 f+y+HB8RZkjp1AcFy8rjoX5o1EY7XxWRldr0LtFBGVpOu+CQaZ/GYaImKZBkkAyo60unu
	 QTq4LM8RY7WOYOjg8p8QyQUZeubkUrDgEdhDgQDgoZrqdMKz3Uj4XlMCxGhsFzjMXjTCL
	 ntpRJANrPX2lIoCHW/qnW8eHQhIxW9zoZWdKKjw1EiBc2DKVAZMHyDI6dhv7kqr5z0NAj
	 E/yuz5NQ9tupSJcosW0Kfkho5tUNFC6cpSnQB49NEOPZdwbGzohFE9b/Xy4n/JEt1YQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793382725;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=A8Qg/pMJM7YKXFTAJR9+7x3FSNCuA32iDB+ph1tKvW8=;
	b=LLzSOA/0TR8svQFEcjZnEGvu2HPHR4KKV8u9yLT3PpkRqPI+a0w/2BP8y+ufQKW4HUu6
	 wv5zX/7drU9DoYIZruR37BeMrTWcMjDIBTrQ7EhWDYTqnqf4qKDuB/xZp3PlhFA9ojBQo
	 qYvbkILX7boeM3eAjoFIBjMkmdkWPdnUc/A7+LLIvo/ZWWoi+CQMSUXCAyEY39Y6ZvNNl
	 eDu3jcMZr7cw63B38iabR0v0g/ACx3YbUb5T99rwBf5TUZHQTjfdO3tL/DB9H6CeggAVq
	 1UDhzip1WuBCT/uNdROxrpqezHVKoz731NuDpJtBVC1GNZyV0gUE21b4K9+OaW90P/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gMjz0H0R;
	arc=none smtp.remote-ip=74.125.82.43
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7AB2606A331
	for <bpf@vger.kernel.org>; Fri, 30 Oct 2026 17:52:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C7AB2606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gMjz0H0R
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-18cdcfc05ffso1344024c88.1
        for <bpf@vger.kernel.org>; Fri, 30 Oct 2026 10:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793382724; x=1793987524; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=A8Qg/pMJM7YKXFTAJR9+7x3FSNCuA32iDB+ph1tKvW8=;
        b=gMjz0H0RIRMM5QvfYV6/Ej/bAPyVkgOILxvt/3iq5/cdQX451SCDHLnj1fHGFPpYAM
         dmZ4eBmqBDNGjDyFZUsXvh2CvpSNAGgLe2Lt139SOzXkkESnWDqGg+7vSfc7VuQ+eX7V
         eWonTrVPqd3bddDTnhH3AWkzZpehVy8BjrlRsuEctZ2MgnAIgVPWZwx8e8qqdGLNgqdn
         U4zBHnmv2I56iUPzrbjdAcvJ9zfHJ9J+ZWAWqj6LxKnefglO7ogDxh6zYVfVgBXWWDEf
         wxEQasae2fsoJ0FIVlkQkxrWmnNLXtQFCvEmO2iGbOB3W09FWMg67h3y4+ybI8ErnGcO
         O1jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793382724; x=1793987524;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=A8Qg/pMJM7YKXFTAJR9+7x3FSNCuA32iDB+ph1tKvW8=;
        b=ECyjOWRvCAUGaCQOAS4ggv/SYir8ySmZGVgFHeWKsDAj3OqNDkgCEUgf3M2oedu3k1
         fwsdR1NaP8ge/4Ic7OzBXDBnUbAul3fTDUQyNm1YxHxyOzDbC+qiWi1MNoctPE3DbVHW
         HBvFQgkM29JgLf94sxjCbP/nVqjua3bht4gB695hk7n/jLSF/Jlmj4//QPDxHmY5dKT3
         O8qe/q8JxmbmyNksIi5jZTbqo6651T+afj3am2qzpGemeqpHBka+96yeZIZmzouA8Std
         Ia+u+m8piu9DjYEX+CDmHs4Ljwaib/EqttRh3xyzDKOqjS5zt/Em+1riyrQ/1NzMHpce
         xZNw==
X-Forwarded-Encrypted: i=1; AKwUvBzbN8sW337+vdqpAXo8f2V0ULodab1sg4jIfxdmS9fB8lBTXVKOSkkgyW4sr37e1F0G47g=@vger.kernel.org
X-Gm-Message-State: AFq9FYJT8mHR9NRsmS3gujkNMeSitwTO/uop9BA7R2WYC02RR/kWV6Bt
	hxBoJJ+H8u7VTSC//A3HuewVzd5bPmo15LI8wbqlYK9uavkkhCCpvZRY
X-Gm-Gg: AYBFou2JUsFpLPQ6XnmCamjcOEPAH3nWnaZ96F9wrNjX/PxF3EJkjmTW+laOkKI63Q/
	0eCiNKDDyRyVtXToekzh/RRaj2S4QULRfVHb0VrGoow6Xkpnoj5+CQa7NU/b+q1u6phKjvR6rZL
	4zBhIAf6WXrX+DSXeml50QtWdCMG/oes7mz6qaHJpakL6slO/QtUcqQ1RfrVNrCuCAogwq3A+Sj
	gynWQdHF83+NFDsDj5g3yRvqpPSV9zxReNzydoUVnn4L3PGrakdbmy1x5qvYWvYP7NGjN1H/Aes
	zucr8GLrgU7ZOqHm9iK/NVfyz5iiZzLZV818RaFyPKsGB4n8P8e5vWnC4QHvDOVS1cK+voX4dG7
	omufU/z09gLTULAAHsOI5SJyygf+muLPBgA8tDhkXsDiHEOcoGK1203XitGCdJGCXS1sLl7FjBW
	lmAAz8XfZr0OEPGPF+OW04x5fKMyZ5CH1ORIh6hARk1lCePuvyqUq5x7WV3RqAPOV2tAF5K+zTM
	VlgBXOJ6KPto2GcMQIPWNJPMJv+WBswyhwuVFUCTEQqUnJH45nYDEALlK4XnlqhRx8WQ4fkIavI
	96WDMylhnF64+Gn+2LbqcbZyOE33/SJ2/Hr5+u9yUtXGoJE26JOfj19wGk8B9zeNPMyyhEMS9ue
	Eqd5Llq6UCGs=
X-Received: by 2002:a05:7022:eb45:20b0:184:992:c9ef with SMTP id a92af1059eb24-1ac5de547a4mr3991157c88.36.1793382723587;
        Fri, 30 Oct 2026 10:52:03 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:5d10:1794:f0d8:db5b? ([2620:10d:c090:500::4:1201])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1ac13ef1a16sm7637612c88.1.2026.10.30.10.52.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 10:52:03 -0700 (PDT)
Message-ID: <bec189f3ba6ff18c2a09f3cbc19bb73e4d3277cf.camel@gmail.com>
Subject: Re: [PATCH bpf-next v3 06/12] bpf: Track low-32 scalar equality
 across sign-extending movs
From: Eduard Zingerman <eddyz87@gmail.com>
To: Vineet Gupta <vineet.gupta@linux.dev>, ast@kernel.org,
 daniel@iogearbox.net, 	andrii@kernel.org, memxor@gmail.com
Cc: martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev, 
	jolsa@kernel.org, emil@etsalapatis.com, ihor.solodrai@linux.dev, 
	john.fastabend@gmail.com, shuah@kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Date: Fri, 30 Oct 2026 10:52:00 -0700
In-Reply-To: <20261020161907.2115379-7-vineet.gupta@linux.dev>
References: <20261020161907.2115379-1-vineet.gupta@linux.dev>
	 <20261020161907.2115379-7-vineet.gupta@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-2.fc44) 
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Tue, 2026-10-20 at 09:19 -0700, Vineet Gupta wrote:
> A 32-bit sign extension shares the source's low 32 bits too, filling the
> high half from bit 31:
>
>   r6 =3D ...              /* full 64-bit unknown */
>   r7 =3D (s32)r6          /* 32-bit sign-extending mov */
>   if w6 =3D=3D -1 goto ...  /* taken: r6's low 32 bits are all ones */
>   ...                   /* r7 is -1, not deduced today */
>
> No constant k makes dst =3D=3D (u32)(src + k) a sign extension, so this
> needs a third kind, BPF_REG_LINK_SEXT, driven by sext_32_to_64() where
> the zero-extending arm uses zext_32_to_64(). The enum already had room,
> so bpf_reg_state stays 80 bytes.
>
> Both work from the base's 32-bit range, which is what a 32-bit compare
> narrows; coerce_reg_to_size_sx() cannot serve, as it reads smin/smax,
> which straddle after such a compare. tnum_sext() is the counterpart to
> tnum_cast(), keeping the known low bits where a tnum_range() over the new
> bounds would not.
>
> sext_32_to_64() resets the register's base/step line; the comment there
> gives the arithmetic. Note it resets unconditionally, where
> coerce_reg_to_size_sx() and coerce_subreg_to_size_sx() return early when
> the extension is a provable no-op and keep the line. That costs a little
> precision in the same case here, which is not worth an extra branch on a
> path that has just rebuilt the value from the base.
>
> Unlike the zero-extending arm, the source's delta comes along. Both
> base + d and (u32)(base + d) have low half (base + d), so dst is
> (s32)(base + d) whichever the source was:
>
> 	w7 =3D w6;	/* BPF_REG_LINK_ZEXT, delta 0 */
> 	w7 +=3D 5;	/* BPF_REG_LINK_ZEXT, delta 5 */
> 	r8 =3D (s32)r7;	/* BPF_REG_LINK_SEXT, delta 5 */
>
> keeps r8 tied to r6. sext_mov_inherits_delta pins it; without the
> inheritance the program is rejected. A self-mov can form a link here too,
> which is how a sign-extended int return lands.
>
> sync_linked_regs() needs no separate sext path: the differencing arm
> already copies the base and adds the delta difference, and which extensio=
n
> follows is just the member's kind. Where the base does fit 32 bits the
> reverse direction runs for both narrow kinds with the *zero* extension --
> the base is then below 2^32 and equal to the member's low half, whichever
> way the member filled its own high half.

The above paragraph is very hard to parse.
sync_linked_regs() does call sext_32_to_64().
Please re-read whatever comments and messages the machine generates.
For whatever reason the bias is towards a wall of text and complex
sentences. I do read those and it hurts. Asking my machine rewrite
your machine's text, such that I can understand it is very time consuming.

...

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index ce7016446936..dffcaa2e1392 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -3763,7 +3763,7 @@ static void assign_scalar_id_before_mov(struct bpf_=
verifier_env *env,
>  	 * rY->id has special linked register already.
>  	 * Cleared it, since multiple rX +=3D const are not supported.
>  	 */
> -	if (src_reg->link_kind)
> +	if (src_reg->link_kind && src_reg->link_kind !=3D BPF_REG_LINK_SEXT)

Why is this rule relaxed only for SEXT?
Can it be relaxed for ZEXT/FULL as well?

>  		bpf_clear_scalar_id(src_reg);
>  	/*
>  	 * Ensure that src_reg has a valid ID that will be copied to
> @@ -6057,6 +6057,25 @@ static void zext_32_to_64(struct bpf_reg_state *re=
g)
>  	reg_set_urange64(reg, reg_u32_min(reg), reg_u32_max(reg));
>  }
>
> +/*
> + * The sign-extending counterpart. Signed bounds carry over directly bec=
ause
> + * sign extension is monotonic over the signed 32-bit range.
> + */
> +static void sext_32_to_64(struct bpf_reg_state *reg)
> +{
> +	/*
> +	 * See comment at reg_step_check_unsigned(). Sign extension subtracts
> +	 * 2^32 from every value with bit 31 set, which preserves a residue
> +	 * mod step only when step divides 2^32, so the line cannot be kept.
> +	 * The zero-extending twin calls reg_step_check_unsigned(reg, 32) for
> +	 * the same reason; the unsigned form does not apply here because the
> +	 * result is not the low 32 bits but the low 32 bits moved.
> +	 */
> +	reg_step_reset(reg);
> +	reg->var_off =3D tnum_sext(reg->var_off, 4);
> +	reg_set_srange64(reg, reg_s32_min(reg), reg_s32_max(reg));
> +}
> +

Please use coerce_reg_to_size_sx(). You can improve it by doing:

  reg->var_off =3D tnum_sext(reg->var_off, 4);
  reg_set_srange64(reg, reg_s32_min(reg), reg_s32_max(reg));

>  /* truncate register to smaller size (in bytes)
>   * must be called with size < BPF_REG_SIZE
>   */
> @@ -17544,12 +17563,29 @@ static int check_alu_op(struct bpf_verifier_env=
 *env, struct bpf_insn *insn)
>  						return -EACCES;
>  					} else if (src_reg->type =3D=3D SCALAR_VALUE) {
>  						bool no_sext;
> +						/*
> +						 * A 32-bit sign extension keeps the low 32
> +						 * bits, so dst shares them with whatever src
> +						 * shares them with. Both base + d and
> +						 * (u32)(base + d) have low half (base + d), so
> +						 * dst is (s32)(base + d) either way: inherit
> +						 * src's id and delta and record
> +						 * BPF_REG_LINK_SEXT.
> +						 */
> +						bool subreg_link =3D
> +							(insn->off >> 3) =3D=3D 4 &&
                                                        ^^^^^^^^^^^^^^^^^^^=
^^
                                    please make this a bool variable is_sex=
t32

> +							(src_reg !=3D dst_reg || src_reg->id);
>
>  						no_sext =3D reg_umax(src_reg) < (1ULL << (insn->off - 1));
>  						if (no_sext)
>  							assign_scalar_id_before_mov(env, src_reg);
> +						else if (subreg_link && !src_reg->id &&
> +							 !tnum_is_const(src_reg->var_off))
> +							src_reg->id =3D ++env->id_gen;

I don't like how this code sidesteps assign_scalar_id_before_mov().

>  						*dst_reg =3D *src_reg;
> -						if (!no_sext)
> +						if (!no_sext && subreg_link && src_reg->id)
> +							dst_reg->link_kind =3D BPF_REG_LINK_SEXT;
> +						else if (!no_sext)
>  							bpf_clear_scalar_id(dst_reg);
>  						coerce_reg_to_size_sx(dst_reg, insn->off >> 3);
>  					} else {
> @@ -18485,17 +18521,29 @@ static void sync_linked_regs(struct bpf_verifie=
r_env *env, struct bpf_verifier_s
>  		if (reg->id !=3D known_reg->id)
>  			continue;
>  		/*
> -		 * A zero-extending link, spelled BPF_REG_LINK_ZEXT: the
> -		 * relation reg =3D=3D (u32)(base + delta) does not invert once the
> -		 * base is wider than 32 bits, so the reverse direction is
> -		 * skipped.
> +		 * The reverse direction does not work for a narrow known_reg:
> +		 * it knows only its low 32 bits, which say nothing about a
> +		 * wider reg's high half. Neither (u32)(base + delta) nor
> +		 * (s32)(base + delta) inverts once the base is wider than 32
> +		 * bits.

Why is this "reverse direction"? what's "inverts"?

>  		 */
> -		if (known_reg->link_kind =3D=3D BPF_REG_LINK_ZEXT &&
> +		if ((known_reg->link_kind =3D=3D BPF_REG_LINK_ZEXT ||
> +		     known_reg->link_kind =3D=3D BPF_REG_LINK_SEXT) &&
> +		    reg->link_kind !=3D BPF_REG_LINK_ZEXT &&
> +		    reg->link_kind !=3D BPF_REG_LINK_SEXT &&

On a second thought, it appears it would make sense to collapse FULL
and NONE into the same category. E.g. the above condition would become
known_reg->link_kind !=3D FULL && reg->link_kind =3D=3D FULL,
much clearer.

>  		    get_reg_width(reg) > 32)
>  			continue;
>  		/*
> -		 * Skip mixed 32/64-bit links: the delta relationship doesn't
> -		 * hold across different ALU widths.
> +		 * Skip a pair of differing kinds. Where BPF_REG_LINK_FULL meets
> +		 * a 32-bit kind the delta relationship genuinely does not hold:
> +		 * the deltas were added at different ALU widths.
> +		 * BPF_REG_LINK_ZEXT against BPF_REG_LINK_SEXT is not that case
> +		 * -- both are base + delta in the low 32 bits, so narrowing one
> +		 * really does narrow the other -- but that deduction is
> +		 * declined on purpose. It makes an int loop counter a fresh
> +		 * constant on every iteration, so no two iterations prune
> +		 * against each other and the program runs to the instruction
> +		 * limit. See sext_no_sync_from_zext_sibling.
>  		 */
>  		if (reg->link_kind && known_reg->link_kind &&
>  		    reg->link_kind !=3D known_reg->link_kind)

Does this check skips propagation in the following case?

  w7 =3D w6              ; r6=3D{NONE,0}, r7=3D{ZEXT,0}
  r6 +=3D 1              ; r6=3D{FULL,1}
  if w6 !=3D 5 goto ...

known_reg is r6 in this case, so:
ZEXT && FULL && ZEXT !=3D FULL -> true, continue is hit.

...
