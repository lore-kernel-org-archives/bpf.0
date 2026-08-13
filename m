Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C99E374E48
	for <bpf@vger.kernel.org>; Thu, 13 Aug 2026 20:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786653295; cv=none; b=XM5xndlRpfhPYUYx7KWTvoAFizKke+YxhRyOya7vWpOEXk9szWTmpyqgWVZ0+9RFoM/P+NRv5S3qMKhgS6FIbW1YMeXePh30GaKxQXuO9Tj61rUbJDGZIWwUAe/rNaNEl2x/AkAgD3wFt67Wzkuc/5SRTHuecUXK5Z9+wKQ31iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786653295; c=relaxed/simple;
	bh=FnFVJViqvBX8E7IfGW7usMMqgeLnsRAujS6K4NOth7c=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sNZOasyPINAm2tuu5+xnvEoIEIgFlY9kqS9FTvKedKDVB95GVZlKRcJsEGIMbsXIU/Xzu+dLYjUxBZt7KiavS5k6QSdkWte6ekjYIeN06MPYhJv/w8SR3WETRQJRDperRARoMN/h+JRJ/OomstJTMMZaCQH2kitsUjX272nXU94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O8+pVB/D; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O8+pVB/D"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-cbedf433a99so249694a12.2
        for <bpf@vger.kernel.org>; Thu, 13 Aug 2026 13:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786653293; x=1787258093; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=72/YSZnlZ2Yl2UqWNgJCv51R/V1f8ZHrBGS/szDj6H4=;
        b=O8+pVB/DTOxvdDOzq00TA56TMyeUWXgqXf2BgqPgvg8PsCX65L1ZTNZamOflSIuQwm
         339P5t+0c/J5RFLQanhgR2p+A7+xw+9DUh91pkRCwAjPkZuAhOM05eIFRG5+h1OnuXKa
         XuerfytgNh02inuNECKvEZhKMbRlE1CfLPy/+FGmFHwDLCmV/SsHYv8p8EGcFnEk4Swe
         33dmfzMwDorrbR/pJirtHkD4WQxGebi8o+H+bpo9wiH7vjoA2BuV4gP0fm9cHeImUgyD
         P6I/94wRlnCC/Fx3denW6olbtJuUhrqzT7CpoDomvd8Hvpp5BbbrIURI/hSpk04JXMGO
         tTew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786653293; x=1787258093;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=72/YSZnlZ2Yl2UqWNgJCv51R/V1f8ZHrBGS/szDj6H4=;
        b=ZTZoLDBg7eOXSHxF3fia8VYGYYH0Eg+8anZtdaV5FUIEsbnnfFjgrL1CxWxrESMzlp
         UZCcqTkG3Qkt8OgdBt7kIvBnk7jwNIH07qpr5zRS25HCpKjDOlOQ3WoZxSH4WcSp0zL3
         8vk4cmsmfGWgWCTvXkuUnCZE/MaPdSHsjSpjKF6Rq5NYaiFARGZaule18UDmRhzNDQ1Y
         V0PlxuckyLIAnF2/rWJQqhzTaNiXYP5j1oilqP6yLzut9SU8uHuqd3/xxzh4SeOJdtiT
         dI7V9wd1KuyeXog6T7aFanbKDDzm1GkFZmNir3gJSTYU62NAZXdWagoS/zQC8Ulrx6BW
         +YFA==
X-Forwarded-Encrypted: i=1; AHgh+RoME0gpHGjtyqIt685f784XUj+Co4lN1tSDs+8ux2OPDouhkg5PFx+KrfqsCa7AyGKHgR8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxa36fRNoIU7VyzjjuGHHw3lZio6NogHCV3sNqEAd+FxsIhMHAB
	exzE6I6WVAJ94Z43TuJFPIU3wxEy1EuIivw4WiWF4Syi32wRIvk/EYGy
X-Gm-Gg: AR+sD13gM7v3SpIm163Sv3DVuEPesMezXvRdTBo4cRqCwwX1yv7El6jfNOMEwvtgZL1
	t6qzHy6b0IEMwHijRpoSYt3U0Qw+cYjDEcKGjhLcrLwXVpT+R1nXrGcnFW7NQ6aWS6oO6VnSj8k
	xkRiFL+APEnT3ssgQzjm8+f+YtEGO/NDeFKPH9KBtNnmSJtgodTuUNYQaPGMtXPtT/+VGbiXe1K
	2P+SSAPJI0ms4O+AqfAyf5a89MX8SeZdrCTvN+AV3EqdG4Cz1LsfUEfB3OB/kI28cjvi1JVexWk
	6hJ1Z5WIpQuIC5/hrYt7HlFkoo7oalcZceGKzflrlCke/ML6nlZlOy6j7mxt1tQ0sB8XpoJSv+5
	l23OUTP4n2mEHOVohwMy8Su7UW1alKLjNV+MI3Me/qHGeC6aZlxRyDrVN/aw0cN9dTwMlWJLpfs
	kI7kFpUztbbA7N25109WYH83FcIeEz4JAjmGce7NmUb4KYCHSN6ccuWWdBaKEzjt0mb+RFxCzrV
	AcOac87ejFqnLS4bz7xzmisLqQYOcSjiiegXmm9tZ/A6g==
X-Received: by 2002:a05:6a20:94c8:b0:3cb:b8a0:aa5a with SMTP id adf61e73a8af0-3cc71da444fmr403444637.35.1786653293389;
        Thu, 13 Aug 2026 13:34:53 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:2cae:4c28:2903:b6f9? ([2620:10d:c090:500::7:1c5e])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31ebc667bfesm10834619eec.2.2026.08.13.13.34.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 13:34:52 -0700 (PDT)
Message-ID: <9baab2473b734a0c75e2d49202e3b46adf5b22e1.camel@gmail.com>
Subject: Re: [PATCH bpf-next v4 15/16] bpf: Report Verifier Limit errors
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, Emil
 Tsalapatis <emil@etsalapatis.com>, kkd@meta.com, kernel-team@meta.com
Date: Thu, 13 Aug 2026 13:34:51 -0700
In-Reply-To: <20260812233326.3575958-16-memxor@gmail.com>
References: <20260812233326.3575958-1-memxor@gmail.com>
	 <20260812233326.3575958-16-memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2026-08-13 at 01:33 +0200, Kumar Kartikeya Dwivedi wrote:

...

> diff --git a/kernel/bpf/liveness.c b/kernel/bpf/liveness.c
> index 1c997aeba6fa..f39f01637ac0 100644
> --- a/kernel/bpf/liveness.c
> +++ b/kernel/bpf/liveness.c
> @@ -8,6 +8,8 @@
>  #include <linux/slab.h>
>  #include <linux/sort.h>
> =20
> +#include "diagnostics.h"
> +
>  #define verbose(env, fmt, args...) bpf_verifier_log_write(env, fmt, ##ar=
gs)
> =20
>  struct per_frame_masks {
> @@ -1856,6 +1858,10 @@ static int analyze_subprog(struct bpf_verifier_env=
 *env,
>  	if (++env->liveness->subprog_calls > 10000) {
>  		verbose(env, "liveness analysis exceeded complexity limit (%d calls)\n=
",
>  			env->liveness->subprog_calls);
> +		bpf_diag_limit(
> +			env, start, "liveness analysis complexity",
> +			"Reduce the number of distinct call paths or argument patterns reachi=
ng these subprograms.",

Nit: "these subprograms" is not very clear here, drop it?

> +			"The verifier recomputed subprogram liveness too many times while tra=
cking stack and register reads across call paths");

Nit: it's not a "subprogram liveness" ->

     "Stack liveness analysis failed to reach a fixed point after %d iterat=
ions".

>  		return -E2BIG;
>  	}
> =20
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 8e5319f47ccb..a14315d19866 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -5252,6 +5252,38 @@ struct bpf_subprog_call_depth_info {
>  	int frame; /* # of consecutive static call stack frames on top of stack=
 */
>  };
> =20
> +static const char *bpf_diag_append_subprog_chain(struct bpf_verifier_env=
 *env,
> +						 const char *chain, int subprog)
> +{
> +	const char *prefix =3D chain && *chain ? " -> " : "";
> +	const char *name =3D bpf_subprog_name(env, subprog);
> +	const char *old =3D chain ?: "";
> +
> +	if (name && *name)
> +		return bpf_diag_fmt(env, "%s%s%s", old, prefix, name);
> +	return bpf_diag_fmt(env, "%s%ssubprogram %d", old, prefix, subprog);
> +}
> +
> +static const char *bpf_diag_alloc_subprog_call_chain(struct bpf_verifier=
_env *env,
> +						     struct bpf_subprog_call_depth_info *dinfo,
> +						     int idx)

Nit: drop the 'bpf_diag_' prefix.

> +{
> +	int call_chain[MAX_CALL_FRAMES + 1];
> +	int i, subprog, cnt =3D 0;
> +	const char *chain =3D NULL;
> +
> +	for (subprog =3D idx; subprog >=3D 0 && cnt < ARRAY_SIZE(call_chain);
> +	     subprog =3D dinfo[subprog].caller)
> +		call_chain[cnt++] =3D subprog;
> +
> +	if (subprog >=3D 0)
> +		chain =3D "...";
> +	for (i =3D cnt - 1; i >=3D 0; i--)
> +		chain =3D bpf_diag_append_subprog_chain(env, chain, call_chain[i]);
> +
> +	return chain;
> +}
> +
>  /* starting from main bpf function walk all instructions of the function
>   * and recursively walk all callees that given function can call.
>   * Ignore jump and exit insns.
> @@ -5294,9 +5326,17 @@ static int check_max_stack_depth_subprog(struct bp=
f_verifier_env *env, int idx,
>  	 * of caller's stack as shown on the example above.
>  	 */
>  	if (idx && subprog[idx].has_tail_call && depth >=3D 256) {
> +		const char *chain =3D bpf_diag_alloc_subprog_call_chain(env, dinfo, id=
x);

Nit: bubble up `chain` definition to the top of the function.

> +
>  		verbose(env,
>  			"tail_calls are not allowed when call stack of previous frames is %d =
bytes. Too large\n",
>  			depth);
> +		bpf_diag_limit(
> +			env, subprog[idx].start, "call stack with tail calls",

"call stack with tail calls" -> "stack depth at tail call"

> +			"Reduce stack usage in caller frames, or avoid combining deep bpf2bpf=
 calls with tail calls.",
> +			"Call chain %s reaches a subprogram with tail calls after caller fram=
es already use %d bytes; "
> +			"tail-call paths are limited to 256 bytes in caller frames",
> +			chain ?: "the current call chain", depth);

"the current call chain" is useless, if it's a guard for ENOMEM,
let's make it "<can't render callchain>".

>  		return -EACCES;
>  	}
> =20

...
