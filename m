Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7EB0395DB8
	for <bpf@vger.kernel.org>; Wed, 13 May 2026 22:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778711851; cv=none; b=ATO5hM0poBx+nrCY4q5ncHc6AXBOZep88T+68aWsgEoh5GEO5Mn/2axCb27HeLwX95JtUXSZ5ME72clHQMsRpXN4/G4yHVEUIhl1LLti8bIpN6/+t3Fpk33xFrrJUUhz4c38pSeGrRisEGod5B/JjY6b2DPYxl56NB9Ob+KH9DQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778711851; c=relaxed/simple;
	bh=Xgg9HNCjyRGX23AO/sCUh+nwGgu/rEK41LJrspiAXD4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AOaw0KTNmxff0kNAgjm7SB3cgHf5ZfgLuSViT90b6g6DtEmOMOk22WFN5d2Ote51OuYTrUGVRFSr0jng4HvxbUiE/c6ufGByrlSWUbtYR0hTM/fvc5qvCeW+zl5hPCeYTdU8uKPTG9dvo7ye/geTqNEePYP39PjXyUMsCwDpagE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PR/FSUa3; arc=none smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PR/FSUa3"
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-13354eb66baso3822014c88.1
        for <bpf@vger.kernel.org>; Wed, 13 May 2026 15:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778711849; x=1779316649; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=EjgurmqF9AmDhw7t4esTINtqU6esw5454d78bG00bqQ=;
        b=PR/FSUa3c6vRnSXWzhuis1p7TFcWMstQ71/cTTvgss9ZgDSlz+ui30EClob2//MXba
         wNLCubb4Adat6EjJqCpOJ4grOMJPV92iJkF/KQJ1rg5MXzeh3WOEosCwaPOMMix993gc
         SjD3F8MxhBmmnwA8ys3NDCN+N+OdM3TLmNbouKUpaJeK3gc6L3sRZFQHQ0P1+mz6Iop8
         U6ZXIqlEbh8qi8+LkFkPuFyYYP41J/WXtlwMUGhPU8SHu2fpkhjtC2RHJiK8K5vIwyHg
         JNoOqqgijTKzwR7qhMpyoGegUkpgh92tCKjm8+bSJy2kF7wZeEYlIom60Tj1xZxIlMNW
         insQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778711849; x=1779316649;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EjgurmqF9AmDhw7t4esTINtqU6esw5454d78bG00bqQ=;
        b=TdIrdmXR8PLe5b9ShACj8VtH3s9ZtNNk7eIpFd/1LP7pt7SvRZcbZ+tR3wnSwNe2Hi
         a5Z5u4A3htT89+74A3aPPMzOlsq38HB6OQjQZFCY7xvgEmwAwK3mM/raKxfz7fk9YSCi
         YL2Ib8oxQh/2LFEO6fCsom6AGFdjZ2P/mzatCcAUb+cM3L+FV53ldP9lEaglPkpEsoay
         BwxkqGjteyog/NGBEYqPsYxjoq6AKo92GABWYZ5pXIbPF29MvXVgt0LdVqDoLhuUBF7i
         wgoKwS+MPPvyeJz/q+YNaaXHoyNhnGpYxnxmv9kzjD9Y/P2C/NjdRUiR4sbANVbu6sQQ
         6hiA==
X-Gm-Message-State: AOJu0YxNrgvp+eE2ZyDDZILeCxIcN9rXOBV/rvH2DqX/ot3Ql4Suu9j0
	bomaPwyRKbVTpmTX2KxkQ8n907Au2KYinwigGGiD4EaH+s/r9vqyR7Eo
X-Gm-Gg: Acq92OFuIy9Uay90b5J1NbDGmTd1P8L06+cxtpwJW+AZeSJMDp/Njnhit9FrCNcn89h
	fRLWGrrLWZfnWaMPI+WURxXRC3uVKAqLK8ckg8J1hLE3NYs9/8Qr3P3I0iIWGbecatvPHZK+zZC
	lm9yJWNZK+CIE1XXFyLly/ZmsWacSwL5IYPcOukmCEIOHOG/9x5QlvuV3DV+7ENSgxZ4JW9Oyu2
	7EkJ6Dn2hdM5XzeKGuv86mv8Cs3TkO08eGJIuOSp0WlUurueXs+6S18KjDrZRLwckXTCF2ne8Lh
	53jITi9IU25l0oMP3L9BVhCAPCoZcveI+hylhIWkklp53YyEGBc9UeGdswU8S1rTZR/fWNxbUGG
	7YEr2simJEacA121c3Aey3o9O1Py0w/5tpieRfEwcJxm1WdsBt2w4/UAvvlUjRbODHdrutbFVQb
	27GBgId1vTC9SL2owEKt4MWPSIjK6lf/U4yA66f19eVf48QyPY7lRKn+lE9syAtMUimTiCb8VVD
	VsfQJea4ox35kvkNw==
X-Received: by 2002:a05:7022:2513:b0:12d:b654:8176 with SMTP id a92af1059eb24-1342ee48a6fmr2921477c88.1.1778711848861;
        Wed, 13 May 2026 15:37:28 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:5152:641f:f5ef:6c7b? ([2620:10d:c090:500::2:8a9])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-302977a9474sm739335eec.25.2026.05.13.15.37.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 15:37:28 -0700 (PDT)
Message-ID: <0419643c9a04bf0824066742e52e3f197b43909b.camel@gmail.com>
Subject: Re: [PATCH RESEND bpf-next v10 7/8] bpf: allow non-owning list-node
 args via __nonown_allowed
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kaitao cheng <kaitao.cheng@linux.dev>, ast@kernel.org, corbet@lwn.net, 
	martin.lau@linux.dev, daniel@iogearbox.net, andrii@kernel.org,
 song@kernel.org, 	yonghong.song@linux.dev, john.fastabend@gmail.com,
 kpsingh@kernel.org, 	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
 shuah@kernel.org, 	chengkaitao@kylinos.cn, skhan@linuxfoundation.org,
 memxor@gmail.com
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, vmalik@redhat.com,
 linux-kselftest@vger.kernel.org
Date: Wed, 13 May 2026 15:37:25 -0700
In-Reply-To: <20260512055919.95716-8-kaitao.cheng@linux.dev>
References: <20260512055919.95716-1-kaitao.cheng@linux.dev>
	 <20260512055919.95716-8-kaitao.cheng@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-05-12 at 13:59 +0800, Kaitao cheng wrote:
> From: Kaitao Cheng <chengkaitao@kylinos.cn>
>=20
> KF_ARG_PTR_TO_LIST_NODE normally requires an owning reference
> (PTR_TO_BTF_ID | MEM_ALLOC with ref_obj_id). Introduce and use
> the __nonown_allowed annotation on selected list-node arguments
> so non-owning references with ref_obj_id=3D=3D0 are accepted as well.
>=20
> This enables passing bpf_list_front() / bpf_list_back() results to:
>=20
> bpf_list_add() as insertion point (prev)
> bpf_list_del() as deletion target (node)
> bpf_list_is_first/last() as query target (node)
>=20
> Verifier keeps existing owning-ref checks by default; only arguments
> annotated with __nonown_allowed bypass MEM_ALLOC/ref_obj_id checks
> and then follow the same list-node validation path.
>=20
> Signed-off-by: Kaitao Cheng <chengkaitao@kylinos.cn>
> ---

Reviewed-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

> @@ -12017,6 +12022,13 @@ static int check_kfunc_args(struct bpf_verifier_=
env *env, struct bpf_kfunc_call_
>  				return ret;
>  			break;
>  		case KF_ARG_PTR_TO_LIST_NODE:
> +			if (is_kfunc_arg_nonown_allowed(btf, &args[i]) &&
> +			    type_is_non_owning_ref(reg->type) && !reg->ref_obj_id) {
                                                                 ^^^^^^^^^^=
^^^^^^
                           Nit: I think this check is redundant, type_is_no=
n_owning_ref() should suffice.

> +				/* Allow bpf_list_front/back return value for
> +				 * __nonown_allowed list-node arguments.
> +				 */
> +				goto check_ok;
> +			}
>  			if (reg->type !=3D (PTR_TO_BTF_ID | MEM_ALLOC)) {
>  				verbose(env, "%s expected pointer to allocated object\n",
>  					reg_arg_name(env, argno));

[...]
