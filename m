Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F0733115A5
	for <bpf@vger.kernel.org>; Tue, 12 May 2026 19:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778612646; cv=none; b=aFEQnCRtpK1r/eZZ5iaI7A6U2bTr/kgPrhxoddQHr6QSKeCFNALuTxYCB55q4gYgfEYE2b1NPxQkk/QNuaiybs63YskiPd8bybLjxNMksm8Cte8+LL+gLj5ZFXYE6VVy4AOQfrI08DNdfrPypI8WxYA3ZYP2T2OMNqJhjTrZM0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778612646; c=relaxed/simple;
	bh=mTY+R3VxQExeKt46CYiR65Ep6AB1M3Cgr5Vft7aQvRQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TwKJxDQFwrbb6yqdQ9qAfWZmu4ha8n9gDnvto/UqdrLnHdVZttpZljiY17lH0s37pHZWiC8ukNiK2GtLiyKDIsJZviZlOHAt0JaV1idMZrDlUp6sAmqKcCbErvNJZLgTeL98IQAqykCP5VURml0LKJ9mAs9TFM7ak2okDAogvO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SHex4lU5; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SHex4lU5"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3660ab73adbso3893287a91.1
        for <bpf@vger.kernel.org>; Tue, 12 May 2026 12:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778612644; x=1779217444; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hLrOPfSWJbKfvY5t7b50lNIFV8G5y1Vr3EZ68WeaQHU=;
        b=SHex4lU5H4sS7VZUOkKVOT2/Lzjd/PhaUJ/Ka7dZBiwHWaycGKRiVijvWaePb4XKov
         Q5rwG/LOdBMU23YQj2hGatl/sRBpC2UaYzKK6FM3k02sJZGJdlDQUSmAFoNMLiUxXk1L
         RO+27Ne1LKJGlM20u2xIeUE+0NVHPImH1JCDYrr96TX9h3xaBc1UVMVsXyiiYnDCps90
         BLfsBBNcQRb7ZKQIENPtYmKzO45n54pA/saC90KQjdb+wTXu+zQmZEz/Ohj0pIDFSfjt
         vKT+GkCQ8ei+nL2pbMKFPrnGa4de1+nMK0ERKn1PnJWa4Yn7z58QnJcqW3xdv3zGvJjC
         hx4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778612644; x=1779217444;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hLrOPfSWJbKfvY5t7b50lNIFV8G5y1Vr3EZ68WeaQHU=;
        b=V9vyrLH9M4ESANSONIF4apLGWUtqQDR5NSWjqCfcIFwpItl2la7Uo+AQm1wpJpi51m
         vUvad8wTXv8niLtBE8kLp+A6byr9l/bqCituDLkfjZYIjCRUe6XnJue+kzqehMVJTXmS
         ej50JQRWVTL2nCY1ZhFp9oXEJUATS+lXq4gU1Xn50GigHjzvy1EjdknHOIodOksEwwuk
         9vsU6rC5q2MHjaBotLJuGoojy507GGU2uIdkmh9XqiWLspMa2GAMnH7C/+5413vbqICL
         fulLCfvTDojEhe/tbd+NqYRiJIyPhXXZWogJkXKe7KHjaizKCZT5vsRO7kL+G9oXQ2Sr
         6YLA==
X-Forwarded-Encrypted: i=1; AFNElJ+QkIkb6s4vqmttDL4tTlWV5Si23zwwwB3AZbCmWWGUqziBiRxVp390Lmyg0CY4RspJWVM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwydD6jVCem3ukrU5/Xno2kOSp+gYVtLfN75l7WPigR4wOp2FCz
	qyf4/Dild0Sp9qobgY4SSadIvzXIkpoL8j4jBFKs4AAIQNNo4Q8BQ8ca
X-Gm-Gg: Acq92OG3H/Sv8cFlTmlPkvcvYuzr2+Wdlk/6wPNc0ncpLoUXp/HtLfghCfrN6y5HC7N
	MnS8C34TZtdAKVh5LGQymMEmn+XG3FFBblkmoMUGuB/b+Lu0m2EOzsY+ppBBO1s33XaeHEBvWvN
	cag/VNq/0B3LMyAyvnXu+C1dRbigkq1HRJL07+WSK8MLrTNSyDcFYFg2BI6UqZU/LKuHD/hSR56
	7FN7eGtCby+EiZbJXjK/pPuJOSYK68X3UqNZsAj5wxPb7ZOHMdp62lHvy9xA2ghqLJeBEOkp4fy
	9nrrdDpv7cFBPOV+lR3EAD7mHr9az2SULZDQdSLodEn4oeozshXu0HsbOk9BHkcvUPMzJrD+3ft
	oegdQgA/ysXnVbit4Hf2V83a1JjahB0b/aWi05AlRG5pbLrFxOO1nlFeRG7IDY1/b2nLp/ieAWp
	hKtJT7soL8qv5SOsH6jcmCkG9xzFBTykzl0vRFm3LAz+olTzpSG1sD
X-Received: by 2002:a17:90b:5625:b0:368:4a6f:28f8 with SMTP id 98e67ed59e1d1-368f3a97ce1mr223838a91.1.1778612644560;
        Tue, 12 May 2026 12:04:04 -0700 (PDT)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-368ed962120sm601698a91.0.2026.05.12.12.04.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 12:04:04 -0700 (PDT)
Message-ID: <23140ed4c48babfa8af91f3b67f379773bdc04c1.camel@gmail.com>
Subject: Re: [PATCH bpf-next v4 07/12] bpf: Unify referenced object tracking
 in verifier
From: Eduard Zingerman <eddyz87@gmail.com>
To: Amery Hung <ameryhung@gmail.com>, bpf@vger.kernel.org
Cc: netdev@vger.kernel.org, alexei.starovoitov@gmail.com, andrii@kernel.org,
 	daniel@iogearbox.net, memxor@gmail.com, martin.lau@kernel.org, 
	mykyta.yatsenko5@gmail.com, kernel-team@meta.com
Date: Tue, 12 May 2026 12:03:29 -0700
In-Reply-To: <20260506142709.2298255-8-ameryhung@gmail.com>
References: <20260506142709.2298255-1-ameryhung@gmail.com>
	 <20260506142709.2298255-8-ameryhung@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-05-06 at 07:27 -0700, Amery Hung wrote:

LGTM, a nit below.

[...]

> @@ -8028,14 +8024,13 @@ static int check_func_arg(struct bpf_verifier_env=
 *env, u32 arg,
>  	}
> =20
>  	if (reg->ref_obj_id && base_type(arg_type) !=3D ARG_KPTR_XCHG_DEST) {
> -		if (meta->ref_obj_id) {
> -			verbose(env, "more than one arg with ref_obj_id R%d %u %u",
> -				regno, reg->ref_obj_id,
> -				meta->ref_obj_id);
> +		if (meta->release_regno && meta->ref_obj.cnt) {
> +			verbose(env, "more than one arg with ref_obj_id %s %u %u",
> +				reg_arg_name(env, argno), reg->ref_obj_id,
> +				meta->ref_obj.ref_obj_id);

I think this should be reported from update_ref_obj() itself,
it is more consistent logically and also avoids reporting code
duplication in check_kfunc_args() and check_kfunc_call().
Also, technically the reg_arg_name() is an independent fix.

> Drop the selftest introduced in 7ec899ac90a2 (=E2=80=9Cselftests/bpf: Neg=
ative
> test case for ref_obj_id in args=E2=80=9D) since the verifier no longer
> complains about ambiguous ref_obj if it is not used.

On the other hand, if you think that this property is worth having,
then maybe wrap the check with in some utility function?

>  			return -EACCES;
>  		}
> -		meta->ref_obj_id =3D reg->ref_obj_id;
> -		meta->id =3D reg->id;
> +		update_ref_obj(&meta->ref_obj, reg);
>  	}
> =20
>  	switch (base_type(arg_type)) {

[...]
