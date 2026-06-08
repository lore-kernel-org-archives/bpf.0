Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CD6A3D47CF
	for <bpf@vger.kernel.org>; Mon,  8 Jun 2026 17:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780939698; cv=none; b=OnZbdvGFwMs4zvkatTLIBwf23a8RFKMAT7+MH2l7XK0BLARPc83pVExOjVmNBJsslPlXyWlJ6no3Eu8naoz6jm8D1kS9F0RCJ/oJ/97u89VUDipneERaNw9Y7dTqcHuiLTEfEc8fpnPD7WCJOazANOd5rJqHofL6kBrwSkzmM/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780939698; c=relaxed/simple;
	bh=TuuXcA/CeQXqGRSpW+SJ6GD872z7NotRRhc79b9gO80=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZNAYdRCB7AgeHX7E0BiJNcKXZ6jD56qexG+Qi5yNC8Rto++B4sNhLRBonYrDLT+RwPNISVTBET53UOqeahp1WR0TB230ywxEAEA6ZpNzM0qoEZgsjEhIw23IRPTtkySAm2xPlXoW24w/+A3yCRY6rbfJGkqsHsr35+zUDJMG7Ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=luU9cQgz; arc=none smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="luU9cQgz"
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-138188a7dccso4489899c88.1
        for <bpf@vger.kernel.org>; Mon, 08 Jun 2026 10:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780939696; x=1781544496; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TYMiwrXWTfWUuPK2v2C213WQs9viPvo98RE1MUgpO8k=;
        b=luU9cQgzwZ/tE2NoazhkoBXwzWGZnd9/QxK1IM9RpWw0sJzMWeJ68BmQ+ajR8XbrA2
         YgqrhEyZvXkY1Zn07mZUEL0wSkj10YRA3S7ndBZ+gigNjoTf8M0Xt76OKF57SEcAz9QF
         J7/T4cX7xfg455kgvbwUx1SsKc5n66/JtbJdcgJFLX3KKKZVRsVnktR4ccqQGBYoSfNy
         C9OGQA7Tf/ufLJupKe/dxfHbWqmgGtURqcLAel4/YF2AHgDbUH8i4wV9m6e4tQs0IiNs
         XbKhQboslK0tqEILcPFblDdgcuTOPkmnu5+LCDCC4rhQIdZjPm6bgCs2AXdssodPULVS
         bXEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780939696; x=1781544496;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TYMiwrXWTfWUuPK2v2C213WQs9viPvo98RE1MUgpO8k=;
        b=rbdF5vzQmzEmZnuQyyFQbr+29+KHM4JSnwzophniV8qwea+TEm7SD9ieZBP76hoY9O
         o1QtGaEQS/JNfj8HvG3Gpp3kFMbUPREGMP7Y66WzK29tShXRF0mzIEjvakh9+uQE2yoa
         vcDIfz7I/kMZftoORjE7Z2ws54n6u9ok/7pAWm059UEcEtWo9ejZpSGI5i7bjjFjc9/h
         5FuK/ZLRli6Jn4wy7XSkrdX3bkz+EgLn6N2iPUuyOTVla+4fTl8mHF3x5MChoKpYJZqo
         P0ZAgo4BYJtoT0Toq90sQzkHvzxschXSgjV0YoXkdVM8OoIOnxqOkBnKn7TaoNG25DKz
         jW7g==
X-Forwarded-Encrypted: i=1; AFNElJ9eHIjPkcupUo9x9kfQveB+VyvOgzGMQELYQth/Fd5qJb4gGC02u+kkKZeSNWrxyEmrVTo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUda5CfSrCNTygWPhllN1T3nV+wBEPDag50otAvblPB709bMBm
	TCkDq+QJi+4lnIgz3DGNPJI5JZqJD+qsEzSUMvd0Mwja5Nnbs1f/WacD
X-Gm-Gg: Acq92OGE0eB+JMYh2FsyhB0kI/eclPywo2aGeszA97ILfUsk6WdaJxfWYXd+t/tZRQm
	u5nQjwBzg6hHYdBMgOD5UGPo2RE4DY+fWohYFLyWMYt2D3+4ze2e+/aS0gNE2FrLqkIf0MlrZtU
	22SMaK7u+SFcGnJee+snzetHPaF8vo40rTgwIWBlH1ZAPOuZaXpWm0CzqwAkI879Dd/Aobowv0V
	/wt60L+JYDA+AAOc6sCC14N0bc8cjzrQovQdYCCs1QMRGOAN2nxAc6lXmYTF3EopAr1N3z8is3w
	+ZlC+Vj3+lnDfy4BzHrwwu1G8T6IUdxoTFfBRvAJ1dYBYjOafx15yYFARrMUgCOHa72+1weXlJl
	w9riJ86swsq5RGedg67gucZGrxQHN/kpU9syQmiLLTOvAQDgXfvWounQ4sLlR1I58m/TS/0NuP8
	mdKqHxfCo+IRcGveWIDqTRtyPUPKnxMNQwIcKwfD5ERN24zSnw+CmGMx0+0ufbLO4gXKpuv6GKk
	CXt/a7AskIqzQ2yyw==
X-Received: by 2002:a05:7022:618f:b0:12b:ec67:3529 with SMTP id a92af1059eb24-138066c0641mr9048559c88.14.1780939696403;
        Mon, 08 Jun 2026 10:28:16 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:83b6:a2e7:fe0b:431? ([2620:10d:c090:500::1:6687])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-138063de4a5sm8809393c88.13.2026.06.08.10.28.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 10:28:16 -0700 (PDT)
Message-ID: <78a23f159c9c72f3f1ca257ab28644118225cee9.camel@gmail.com>
Subject: Re: [PATCH bpf v5 1/2] bpf: Fix kfunc implicit arg inject type
 detection to prevent invalid pointer deref
From: Eduard Zingerman <eddyz87@gmail.com>
To: chenyuan_fl@163.com
Cc: andrii@kernel.org, ast@kernel.org, bot+bpf-ci@kernel.org,
 bpf@vger.kernel.org, 	chenyuan@kylinos.cn, clm@meta.com,
 daniel@iogearbox.net, ihor.solodrai@linux.dev, 	jolsa@kernel.org,
 linux-kernel@vger.kernel.org, martin.lau@kernel.org, 	martin.lau@linux.dev,
 memxor@gmail.com, song@kernel.org, yonghong.song@linux.dev
Date: Mon, 08 Jun 2026 10:28:13 -0700
In-Reply-To: <20260608142618.3064380-2-chenyuan_fl@163.com>
References: <20260602093836.2632714-1-chenyuan_fl@163.com>
	 <20260608142618.3064380-1-chenyuan_fl@163.com>
	 <20260608142618.3064380-2-chenyuan_fl@163.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2026-06-08 at 22:26 +0800, chenyuan_fl@163.com wrote:
> From: Yuan Chen <chenyuan@kylinos.cn>

[...]

> Fix
>=20
> Split the combined is_kfunc_arg_ignore() || is_kfunc_arg_implicit()
> check in check_kfunc_args() so that an implicit argument reaching
> is_kfunc_arg_implicit() without being handled by a prior handler is
> rejected with -EFAULT, instead of silently skipped.  Existing implicit
>       args in bpf_fixup_kfunc_call() (obj_new, percpu_obj_new, obj_drop,
>       percpu_obj_drop, refcount_acquire, list_push, rbtree_add) are
>       explicitly allowed.
>=20
> Suggested-by: Eduard Zingerman <eddyz87@gmail.com>
> Fixes: 64e1360524b9 ("bpf: Verifier support for KF_IMPLICIT_ARGS")
> Signed-off-by: Yuan Chen <chenyuan@kylinos.cn>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

>  kernel/bpf/verifier.c | 20 +++++++++++++++++++-
>  1 file changed, 19 insertions(+), 1 deletion(-)
>=20
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 8ed484cb1a8a..91aaed7a5eeb 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -11885,9 +11885,27 @@ static int check_kfunc_args(struct bpf_verifier_=
env *env, struct bpf_kfunc_call_
>  			continue;
>  		}
> =20
> -		if (is_kfunc_arg_ignore(btf, &args[i]) || is_kfunc_arg_implicit(meta, =
i))
> +		if (is_kfunc_arg_ignore(btf, &args[i]))
>  			continue;
> =20
> +		if (is_kfunc_arg_implicit(meta, i)) {
> +			/* kfuncs with implicit args (e.g. 'off' parameter)
> +			 * handled during verification in bpf_fixup_kfunc_call():
> +			 * obj_new, percpu_obj_new, obj_drop, percpu_obj_drop,
> +			 * refcount_acquire, list_push, rbtree_add. Don't flag them. */

Nit: comment does not follow formatting rules and the two lines
     listing relevant kfuncs are redundant.

			/*
			 * This an exhaustive list of the non-bpf_prog_aux implicit args kfuncs,
                         * which are handled post-verification by bpf_fixup=
_kfunc_call().
			 */

> +			if (is_bpf_obj_new_kfunc(meta->func_id) ||
> +			    is_bpf_percpu_obj_new_kfunc(meta->func_id) ||
> +			    is_bpf_obj_drop_kfunc(meta->func_id) ||
> +			    is_bpf_percpu_obj_drop_kfunc(meta->func_id) ||
> +			    is_bpf_refcount_acquire_kfunc(meta->func_id) ||
> +			    is_bpf_list_push_kfunc(meta->func_id) ||
> +			    is_bpf_rbtree_add_kfunc(meta->func_id))
> +				continue;
> +			verbose(env, "%s unrecognized implicit argument, possible BTF mismatc=
h\n",
> +				reg_arg_name(env, argno));
> +			return -EFAULT;
> +		}
> +
>  		t =3D btf_type_skip_modifiers(btf, args[i].type, NULL);
> =20
>  		if (btf_type_is_scalar(t)) {
