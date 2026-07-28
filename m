Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD5D6396D09
	for <bpf@vger.kernel.org>; Tue, 28 Jul 2026 21:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785275448; cv=none; b=M1bTokpnXScKL7MjkTIot5LCMxFQDqGYaip91lxnmdmEgKmenS5w8CXYaeW+TT1kxlksnNbvvyWlWZJLWI2ZABZp5iejjdNQwxkaUCnIvlN86zWSoJaFDad73GI3b2Lm4/sdVuHNoLWj+lESDi3FkM+sxrY+rKxLl2axhqpZq34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785275448; c=relaxed/simple;
	bh=56djSAQocAzU8YsvSvVYy92bA/jft28BbykaQeuAKTg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dPzPVb9iHbYmnyXxcjYq9lQNXgbvciNjQ25OjTY+vvQ6nklmeuvRBjFXzVAHEkf7vbsLMc6AuyPJ42ZEyr7HByCQi8Vndi74D0fupMwAMSn9PHHQA7OWTq50pA5DRs4F+9sdhY2VNneds/uOq23H7K5tHusPJ7qj0C2s9q5WgzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NontGgLE; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NontGgLE"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2cc891373e0so4318515ad.2
        for <bpf@vger.kernel.org>; Tue, 28 Jul 2026 14:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785275446; x=1785880246; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=x96RRyAuNfwxQVYvVsrta7f+5nGEJEoHlQpXqKpUpao=;
        b=NontGgLEbC5uhMEz6a47dce0aqXstZZApTUb9X/8TSfKmNhnem0W3RMuhVn8WZ8xW3
         DdCwFTGkkYAOg+lpGygE7lsqSMimCispjcm8M5xsIKZLqGJSxcCb/bFu1aYo0vyuuV8t
         vMfHZ2ve2qJo+z5w15d/ltqsXovba8VhSkJQJy9UCDfwdKgRxM2Z+M9JY5xVvSl1YeBO
         QsTCY6vFLdgzaDYyN1ga5SHDdgTrXfG0+Xp7MJiqDwmQ29LYdR7euVdhMzHPW3PT6Au7
         1+YtpJ/tk1X2ZT4yDmLUwCV7qNmqTS+8vu5EAL6+RVXgHn0HsvKdr12gtjGv/cdHwoZL
         k26A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785275446; x=1785880246;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=x96RRyAuNfwxQVYvVsrta7f+5nGEJEoHlQpXqKpUpao=;
        b=rv1ZxqEI7C2CqWtz6iyEpvmQtngG0E3B+M++N0/Hmg5EoVVuSHqlWDSvsLlpOeU0nc
         lerHJlacgZN6rdxWMqTlJuEO++ZEYXHwZcOql1xGd4Xp/sEfiXMmRRXuBqIxmrHQyW1b
         +tnDlYvRCShHW6WXqsKe7jHwtqlb4UNHt7fiFvrY2gm3UNsZaFYCWNqmO2FGbjzavPQJ
         po0VKbdEyC8ZDzOC3v/aJ7/Iuv9ILP5qMBMkORcC3w29LKP40tD0WbPheRFDQBhOevTK
         Mr/+eEu/AsZyknf0tad8DaDDB/GdFhneAEjZH97QauWBBG3R/U01f/v3c29qNV3CLd6d
         NrtA==
X-Forwarded-Encrypted: i=1; AHgh+RqC/adj8UMtQ+LlNuhlKpnUjvzQLs5GOVVVEDecq0s6m141dJDZYSOoYrG1bovfJNkHUZg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVb0aAiBP39jaHRW0+dcC61/RO0f84btHHihx33fxAA6MSITPq
	VtgX6XwkydNq+MTIJSlJgaYFbIjIpPYpf+5/JVD6MHRWXGraOJY9rvj+
X-Gm-Gg: AR+sD13fgZ8SVopL+WYTBfmqJAkGcZ7/EbphejWMPpvwNLPy7Y7EWB13hJgQq3Tdv7Y
	amMKMe5n/N/Lq3XgTMb2BtVzlIPm1S8rCkAF8wk2r5Qsn0Gwb5upwyY4GKnFRgaYtuCjIKyWcqR
	kxY7XsjdkCWaIgZOeW86EK6w8OWXJwqweldKjcTtDJiHqxUzoTfTE6RUb/trkYElUdsh0k/Q5vi
	R7hd8/JHAelfNiacB7202bnYAhgQ1blizaqLkBE2V4lAx4cXuCcWM9K48VCRInMMGcaGHoGDVGG
	ZaQlmKK5/bkWVQL6fO4W/w7P/EYrNgZi0p2tx3nff2xGt/nvBqzQAalkYqv40p33y6m4cxsmIng
	HSM3Nrtbs4d0Qfm3U3fOUQg6qpstu/kG6c4VT3Xtbb1pesTo+7GzwpW19MjLUKMC4VuddegSV6C
	/yKd4gMBfL2Cf3qyw24R+VdU1xULPl65/9xknqxpYNRLxesubLMTtT5+rzDfaDOMi2kNrIIkIA1
	JNXFikiKoSUvM829+q7Jrvmhs59e/T2PqQdQxGUZHgN1qWK15cVOWgQ
X-Received: by 2002:a17:903:3c6e:b0:2c9:d539:61e7 with SMTP id d9443c01a7336-2d015c4e34bmr49593855ad.19.1785275445888;
        Tue, 28 Jul 2026 14:50:45 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:a358:4bd1:35cd:2e45? ([2620:10d:c090:500::5:ff91])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31504cc6936sm2183817eec.17.2026.07.28.14.50.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 14:50:45 -0700 (PDT)
Message-ID: <40ad8565f90619452bde3800cb246bf23b0e95e2.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 18/18] bpf: Generate kfunc argument
 prototype at add-call time
From: Eduard Zingerman <eddyz87@gmail.com>
To: Amery Hung <ameryhung@gmail.com>, bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com, andrii@kernel.org, daniel@iogearbox.net, 
	memxor@gmail.com, kernel-team@meta.com
Date: Tue, 28 Jul 2026 14:50:43 -0700
In-Reply-To: <20260724190813.1458271-19-ameryhung@gmail.com>
References: <20260724190813.1458271-1-ameryhung@gmail.com>
	 <20260724190813.1458271-19-ameryhung@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-07-24 at 12:08 -0700, Amery Hung wrote:

...

> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index b54c1a5c9b11..0655164e6af2 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h

...

> @@ -1305,8 +1306,19 @@ static inline u32 type_flag(u32 type)
>  /* only use after check_attach_btf_id() */
>  static inline enum bpf_prog_type resolve_prog_type(const struct bpf_prog=
 *prog)
>  {
> -	return (prog->type =3D=3D BPF_PROG_TYPE_EXT && prog->aux->saved_dst_pro=
g_type) ?
> -		prog->aux->saved_dst_prog_type : prog->type;
> +	if (prog->type =3D=3D BPF_PROG_TYPE_EXT) {
> +		/*
> +		 * saved_dst_prog_type is only set once check_attach_btf_id()
> +		 * runs. Before that -- e.g. when generating kfunc prototypes at
> +		 * add-call time -- fall back to the attach target's type, which
> +		 * is available from load time and holds the same value.
> +		 */
> +		if (prog->aux->saved_dst_prog_type)
> +			return prog->aux->saved_dst_prog_type;
> +		if (prog->aux->dst_prog)
> +			return prog->aux->dst_prog->type;

Let's avoid this fallback and set saved_dst_prog_type
in syscallc:bpf_prog_load() in the same place where
`prog->aux->dst_prog =3D dst_prog` is set up.

...

>  static inline bool bpf_prog_check_recur(const struct bpf_prog *prog)
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index e44fc7296d0c..1ca8779ab59a 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

...

> @@ -2806,11 +2823,29 @@ int bpf_add_kfunc_call(struct bpf_verifier_env *e=
nv, u32 func_id, u16 offset)
>  	if (err)
>  		return err;
> =20
> +	proto =3D kzalloc_obj(*proto, GFP_KERNEL_ACCOUNT);
> +	if (!proto)
> +		return -ENOMEM;

Nit: since `proto` is allocated for each kfunc object I'd embed the
     structure directly into the struct bpf_kfunc_desc and make the
     struct bpf_kfunc_desc_tab dynamically allocated by bpf_add_kfunc_call(=
).
     As a side-effect, there would be no need in bpf_free_kfunc_desc_tab().

> +
> +	memset(&meta, 0, sizeof(meta));
> +	meta.btf =3D kfunc.btf;
> +	meta.func_id =3D kfunc.id;
> +	meta.func_proto =3D kfunc.proto;
> +	meta.func_name =3D kfunc.name;
> +	meta.kfunc_flags =3D kfunc.flags ? *kfunc.flags : 0;
> +
> +	err =3D gen_kfunc_arg_proto(env, &meta, proto);
> +	if (err) {
> +		kfree(proto);
> +		return err;
> +	}
> +
>  	desc =3D &tab->descs[tab->nr_descs++];
>  	desc->func_id =3D func_id;
>  	desc->offset =3D offset;
>  	desc->addr =3D addr;
>  	desc->func_model =3D func_model;
> +	desc->proto =3D proto;
>  	sort(tab->descs, tab->nr_descs, sizeof(tab->descs[0]),
>  	     kfunc_desc_cmp_by_id_off, NULL);
>  	return 0;

...

> @@ -8858,7 +8893,7 @@ static bool check_raw_mode_ok(const struct bpf_func=
_proto *fn, struct bpf_call_a
>  {
>  	int i;
> =20
> -	for (i =3D 0; i < ARRAY_SIZE(fn->arg_type); i++) {
> +	for (i =3D 0; i < MAX_BPF_FUNC_REG_ARGS; i++) {

Nit: here and in other places I'd keep the ARRAY_SIZE for uniformity
     (and if 5->12 move is bothering, one can break at ARG_DONTCARE).

>  		if (!arg_type_is_raw_mem(fn->arg_type[i]))
>  			continue;
>  		if (meta->arg_raw_mem.regno)

...
