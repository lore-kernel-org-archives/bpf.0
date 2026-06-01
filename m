Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 944F936655B
	for <bpf@vger.kernel.org>; Mon,  1 Jun 2026 21:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780349793; cv=none; b=DCZLPapMcV9sR8jbMDgwL3ZC8yp0ocsSTNcb+aMVcDh06Ao3tqvYe0qk21RaALIDN+DBUMRxDrgYh/Aiy4scC32MKUX95IBjnK8SLi2xM9qEReH+q/a8HYbM8hQgsGtnGXBFYG+MhHxFXSg4oxrPSXeGOndnMjfMsqa3x6FRHDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780349793; c=relaxed/simple;
	bh=ohGvsnt5wGGrS8nCkxbknV7cYtW8Z1frw09epT2l/qE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Co8QHokp3uuo7A3PvwLUdcxON2byQjBt2RrQi37Uh/3yBPvxBIL4bL0bQIxYu0gwWmLLZL/KP9lSDXpGKjUGVfkRQ8NPQuKmmVj6gDIBxSQPbeWiN8fAJvXdauAbxMHUxG7T+K0m4wbmVe6CHl7btWd2jS411nQGtkCTxFfT6Kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oUw6c95p; arc=none smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oUw6c95p"
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-307263ad0cbso1538279eec.0
        for <bpf@vger.kernel.org>; Mon, 01 Jun 2026 14:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780349792; x=1780954592; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cbl2ijxMWZNunjPG65UITZHrQVdSUsTPik/smPG+J7A=;
        b=oUw6c95p7Y4weuSbUMo43WXRCB4C4Y7mBfpqhuqZUXNKM7Hy0WUizh24zsI5skLp5U
         RnZF8YRuoCcWyjRDdlxdL8LJwQEIqGixsiGyqCFItYPjeEHUvOVKepIuXvxqcp0WixGz
         6tQwEL6m+6WMCcdRvLr4CyzodZ3+FegMBNYnU4zs02Q9R9EZzGqnzXLAqyqszruMRa5P
         cW2WOGTX+ouMEYgLBoG3Jt5bagw7/4BshvY2ut5B1Ybn+87ziaTpRaHwHlSmEARLEVUT
         jfAz30tNjHH3c0xgbamQaqLVceWbGSI61vBOrLijwj5kCWyzhs1NRueOFlP1ytO6kSQO
         2YxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780349792; x=1780954592;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cbl2ijxMWZNunjPG65UITZHrQVdSUsTPik/smPG+J7A=;
        b=LD1ERT0CwyekNNOSUndF3lLGW0YBH7EUYZDxrr3QAOf8YUJmJU5kXizMTzWPU5QtJ0
         e3z4+N6iwLrv77Dp+ijB8SYFmSzCaD/IB1MCGYxu8FDXHygDZcYATMY6/C6F3vsuniu4
         AMstYe+x/UBFAkn/IEsygA4i5EovBCkEgH3NyGT0peTA96tQFT1UDTwUhNI//aUtFQ9W
         Kmqm8d+QGvaNYt08Aiq/PvKAVdurS/1ji4XZD9lTUk2XWpFyEb7iqa7m9rBysSw45i8b
         8sGjf6AOcRwkWNKfyaaVvgU/hGa2EuZ1onMob+4nEr8/IfyadXN/MOlurhFrvu3tB2g6
         ErKw==
X-Forwarded-Encrypted: i=1; AFNElJ+IUoyA3Ez7UQixAM5DAE7ZE+iaZ4eRAgBfbGLROKsUYv4dB52YVmiTayqWooORxxBBkcc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1bQizZc/hXCy9hw8YGvSp1NMd6qZA4kDrFKAvciyZo+spS2VE
	JDy6OaDNW1JUQpE4OBHw8Q/47UiyInXZmwHtyphL7KVrJIaEtEtsvnhIxrAEAXOh
X-Gm-Gg: Acq92OECjzHbRtclDd08OXBt3SqITclt+pOrSQHT5d/QrLZ/xvN9gOt4w1g+AHoY5ax
	lqnu2e0/o1RB3utH7IVFXLpISQSkJRFDCo5YwZscIO0CB/CiKKAeGH6BtErcwTfIG8IHJ108Ckp
	YSYXNlXZ96mMiproJKd9XLvpPBGQXt5Bsac2TOjOwwJZp8a+wJTPiTkZ51xZkYE/7Y7C8hMEIdb
	dh8JE2H09HQ5Ovx5ygDuRArOHnT4Cm6acAxTEh5KWZvYdEedK79l6QQeEkm3IqyMNEWVbTgVLx2
	PUO0G0SGOQlIg+6Q3H3sDUxPi2IGG/bsWxhGya8AA5O/VMZlZNWQwXNuraSrPfMXjWIczTaDLxz
	pWQ4qguh4pRgSmBSn2X8janiAR0h/Ztvqhj43TqGyLzvV0bYCyDeWFXNNPcJJ0hGcFyo9NA/iGq
	r2fw4lYaw9Q7AKUc5ww181xeSxPmfRJSM2Sq/6TExrP+unn88n6lT+4KizssNCMAQaxczCXcnX7
	bdXPSJeWOYaSAM6jhk=
X-Received: by 2002:a05:7300:3b07:b0:304:e6fb:f2f0 with SMTP id 5a478bee46e88-304fa6a904dmr6476151eec.34.1780349791549;
        Mon, 01 Jun 2026 14:36:31 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:c3a5:3c8c:3e68:6e4d? ([2620:10d:c090:500::1:c0f8])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-304ed2c312csm10231858eec.6.2026.06.01.14.36.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 14:36:31 -0700 (PDT)
Message-ID: <5168f215501c61b3b53e592f35569768e82f0cef.camel@gmail.com>
Subject: Re: [PATCH bpf v2 1/2] bpf: Fix kfunc implicit arg inject type
 detection to prevent invalid pointer deref
From: Eduard Zingerman <eddyz87@gmail.com>
To: chenyuan_fl@163.com
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
 chenyuan@kylinos.cn, 	daniel@iogearbox.net, jolsa@kernel.org,
 linux-kernel@vger.kernel.org, 	martin.lau@linux.dev, memxor@gmail.com,
 song@kernel.org, yonghong.song@linux.dev
Date: Mon, 01 Jun 2026 14:36:29 -0700
In-Reply-To: <20260601064611.807637-2-chenyuan_fl@163.com>
References: <20260407080900.551797-1-chenyuan_fl@163.com>
	 <20260601064611.807637-1-chenyuan_fl@163.com>
	 <20260601064611.807637-2-chenyuan_fl@163.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2026-06-01 at 14:46 +0800, chenyuan_fl@163.com wrote:

[...]

> @@ -11899,8 +11932,17 @@ static int check_kfunc_args(struct bpf_verifier_=
env *env, struct bpf_kfunc_call_
>  		u32 ref_id, type_size;
>  		bool is_ret_buf_sz =3D false;
>  		int kf_arg_type;
> -
> -		if (is_kfunc_arg_prog_aux(btf, &args[i])) {


Thank you for figuring out this corner case.
I don't think I like matching the type by name here, though.
Wdyt about a somewhat more generic solution described below?
bpf_fixup_kfunc_call() lists all the cases when verifier injects an
implicit argument:
- functions with KF_IMPLICIT_ARGS flag and a parameter of type bpf_prog_aux=
.
- functions with KF_IMPLICIT_ARGS allowed by is_bpf_list_push_kfunc() /
  is_bpf_rbtree_add_kfunc().
 =20
Meaning that current check_kfunc_arg() code can be changed as follows:

       if (is_kfunc_arg_prog_aux(btf, &args[i])) {
               ... unmodified ...
               continue;
       }
       if (is_bpf_list_push_kfunc(...) || is_bpf_rbtree_add_kfunc(...)) {
               ...
               continue;
       }
       if (is_kfunc_arg_implicit(meta, i)) {
               ... report error ...
               return -EFAULT;
       }

Thus catching all the cases.

> +		enum kfunc_inject_arg_type inject_type;
> +
> +		inject_type =3D get_kfunc_arg_inject_type(btf, &args[i]);
> +		switch (inject_type) {
> +		case KF_INJECT_ARG_PROG_AUX:
> +			/* Validate the arg type against vmlinux's definition */
> +			if (!is_kfunc_arg_prog_aux(btf, &args[i])) {
> +				verbose(env, "arg#%d implicit argument type mismatch, "
> +					"expected struct bpf_prog_aux *\n", i);
> +				return -EINVAL;
> +			}
>  			/* Reject repeated use bpf_prog_aux */
>  			if (meta->arg_prog) {
>  				verifier_bug(env, "Only 1 prog->aux argument supported per-kfunc");

[...]
