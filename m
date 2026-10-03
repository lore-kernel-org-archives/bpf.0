Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96109316199;
	Sat,  3 Oct 2026 19:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791057599; cv=none; b=nl9e0PK+EJs6yKFrlZH29n4bqQblS8Ko3ELqu/mCvAXEgPYdek+IcCG2WDeu3Ss82/A+cPFZXLc1RJXnf3NuSY9JIYaR7kehB5VAe9c39AIs7MZKRAj/t+uLch1p9El6oakdAjNjzBWddC+SPb0Z/LvYyB8Mv+70M+PYcRfW+3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791057599; c=relaxed/simple;
	bh=GMRtN2Qt0F1qArkj9KfPEPY7gizsodHen5S5qZ9VVQM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YsBWfBtprsjQR0DjVXpqsCAo6nLc7c1b4DpT3O8CYv070fSkjfNCarVZQ3GKEOD5pBAaJs3mwO54N4lp0+8RQgemUTNQIFl+hrNQFfBgMToe2e2g48V1gkaxMZSNqs+SDjLmL2QseAHjFWIn5kyJVWkiOQT+Bcvwz0eRQGhE9fY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ovEhacaA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ovEhacaA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AE3A1F0089B;
	Sat,  3 Oct 2026 19:59:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791057595;
	bh=3tydVEnnCqS/l9AxjqZ6jNrB/aAwLwMTretghVcEW0Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ovEhacaAyGm4krmhYsFQP1DTUdbjCcZPgbXnARQynwiyerI+rMkZZLq8JE3lxynSv
	 khYT7kPbTJcOSf7W2kk7wc9AFTuIsAJi1uzyLbOs92XDqiUcKhu5DJFrDVpCPjS7i7
	 TxciIAV3IHcqY67nUY+ZyvjR20pqcjx1JFJtB9xDEbZ6xrBWcdFNXjkW0Kl8imI+ky
	 XRImOdOifLG8wbw7DbwS4IskAEinuXnHNLZZxeAhFbu6fH9sEgQDJrVLB4MQ5J+NVn
	 J9EhCrViu130Sq4Wm74JdwPjvtr3i/RRKjjuP+NNwEwYxgw9ADSa9m0BHSvjYs3RL2
	 JHyqmsUT8i9fg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 bpf-next 5/7] btf: Relocate and expose module inline
 BTF
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alan Maguire" <alan.maguire@oracle.com>
Cc: bpf@vger.kernel.org, "Petr Pavlu" <petr.pavlu@suse.com>, linux-modules@vger.kernel.org
In-Reply-To: <20261003194323.817885-6-alan.maguire@oracle.com>
References: <20261003194323.817885-1-alan.maguire@oracle.com>
 <20261003194323.817885-6-alan.maguire@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 03 Oct 2026 19:59:54 +0000
Message-Id: <20261003195955.5AE3A1F0089B@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] bpf: kernel panic on NULL pointer dereference in btf_parse_module(=
) error path
--

commit 7871f353137bb8eca880dde9f21fa3041a6f681f
Author: Alan Maguire <alan.maguire@oracle.com>

btf: Relocate and expose module inline BTF

This commit introduces parsing of module inline BTF data, rebases inline ty=
pe
IDs on top of the relocated module BTF, and exposes the result via sysfs.
Malformed inline BTF is warned about and skipped without preventing normal
module BTF registration.

> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index c535e636d41c1..28b7c9786fdce 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
[ ... ]
> @@ -6954,67 +7076,66 @@ static struct btf *btf_parse_module(const char *m=
odule_name, const void *data,
>  		base_btf =3D vmlinux_btf;
>  	}
> =20
> -	btf =3D kzalloc_obj(*btf, GFP_KERNEL | __GFP_NOWARN);
> -	if (!btf) {
> -		err =3D -ENOMEM;
> +	btf =3D btf_parse_split(env, module_name, data, data_size, base_btf);
> +	if (IS_ERR(btf)) {
> +		err =3D PTR_ERR(btf);
> +		btf =3D NULL;
>  		goto errout;
>  	}
[ ... ]
>  errout:
> +	kvfree(module_str_map);
>  	btf_verifier_env_free(env);
> +	btf_free(inline_btf);
>  	if (!IS_ERR(base_btf) && base_btf !=3D vmlinux_btf)
>  		btf_free(base_btf);
> -	if (btf) {
> -		kvfree(btf->data);
> -		kvfree(btf->types);
> -		kfree(btf);
> -	}
> +	btf_free(btf);

[Severity: High]
Will this cause a kernel panic if btf_parse_split() fails?

In the error path above, if btf_parse_split() returns an error, btf is
explicitly set to NULL and execution jumps to errout. At this point,
inline_btf is also initialized to NULL.

The errout path then calls btf_free() unconditionally for both inline_btf
and btf. Looking at btf_free():

static void btf_free(struct btf *btf)
{
        btf_free_struct_meta_tab(btf);
        ...
}

And btf_free_struct_meta_tab() unconditionally dereferences the pointer:

static void btf_free_struct_meta_tab(struct btf *btf)
{
        struct btf_struct_metas *tab =3D btf->struct_meta_tab;
        ...
}

Does this result in an immediate NULL pointer dereference when
btf_free() is called on the NULL btf or inline_btf pointers?

>  	return ERR_PTR(err);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261003194323.8178=
85-1-alan.maguire@oracle.com?part=3D5
