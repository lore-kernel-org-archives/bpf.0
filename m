Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BFB2235C01
	for <bpf@vger.kernel.org>; Mon,  7 Sep 2026 05:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788760149; cv=none; b=ao2Lt/Mzys6W6XaYbKda4Zr7qS94qnCzmhErZkBLHOheRq30qARH6hT00RXRpJY+QFIPy/MfA9k+ATvecU3iriI5KYll8u7SNIODC8V9AgO6kcXSpcmmWN6JggTtDstsYWhzPn8mQiij5V8wQ+1MKwn2Li/6Bs2GjbYEua9i3Ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788760149; c=relaxed/simple;
	bh=11inFYyYSYs7/kRwfzWS0ZZ/r0i9DadYBav4t5MumdI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qVnPfoEqmr6E4qgMvQTA7gf47UwIEMdwBhycW7VaMaM2C34pUHSSoyFK3SRdVWO0EaFKq683kkZ6M7n+/fu/EQkjEJ01ay0J/7i0L1Xfmgi135oM/O648ZD4IygwnpIxnJgt0WMcnTiK48GMi3MqI4NunxLuFMGsYuP79z64dPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aKK/f7vO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aKK/f7vO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DEB51F00A3A;
	Mon,  7 Sep 2026 05:49:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788760147;
	bh=KP79w1wubCSmBEe0TxwqChyFsl3Zq34tf+yWzZ6xfjA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aKK/f7vOe818KsncpECL5+ppFOUsIbxRh99F1LD9yJiqFqUE0mgufIuulN9IqxE5T
	 hvDBnGw9kLmIZKm0iJEYmYw15siMadvz+AeXlJ6Kkr8rDvFF7htkPRFAXSl5kZ+Elj
	 /VABloKufSNM00J5lCsMf8Q4XTeF8zytJe11p71qqzEczeFUFqjjNOqquMuzxRlKZh
	 SpWqf0JHLTtgCP8AO37ESsG+itzmbLlRfRq5mEq9O5SAYnlD6GDzF0zW1SpNOZa0fm
	 jztQTkS1MIdQv5NIHHt1RzzXA3qP4tBRZxW4VYkOd2Ek3DGrirHEY9gjgqArVuETHN
	 x5Aq6slsiwuww==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v7 1/2] libbpf: support selective kernel module
 BTF loading via bpf_object_open_opts
Reply-To: sashiko-reviews@lists.linux.dev
To: "Fuyu Zhao" <zhaofuyu@vivo.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260907053847.1115-2-zhaofuyu@vivo.com>
References: <20260907053847.1115-1-zhaofuyu@vivo.com>
 <20260907053847.1115-2-zhaofuyu@vivo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 07 Sep 2026 05:49:07 +0000
Message-Id: <20260907054907.7DEB51F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] If `calloc` fails when allocating `btf_module_allowlist`, a NULL p=
ointer dereference occurs during cleanup in `bpf_object__close()`.
--

commit 2653ece25005f3595512126454652c2d89f17f3d
Author: Fuyu Zhao <zhaofuyu@vivo.com>

libbpf: support selective kernel module BTF loading via bpf_object_open_opts

This commit adds a btf_module_allowlist field to bpf_object_open_opts to
limit which kernel module BTFs libbpf is allowed to load. When the option is
unspecified, behavior remains unchanged, while an explicitly empty list
prevents consulting any module BTFs.

> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index c036e8a91ed88..d49e48c5c1417 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
[ ... ]
> @@ -8563,6 +8610,24 @@ static struct bpf_object *bpf_object_open(const ch=
ar *path, const void *obj_buf,
>  		}
>  	}
> =20
> +	obj->btf_module_allowlist_cnt =3D mod_allow ? mod_allow_cnt : -1;
> +	if (obj->btf_module_allowlist_cnt > 0) {
> +		obj->btf_module_allowlist =3D calloc(obj->btf_module_allowlist_cnt,
> +						   sizeof(*obj->btf_module_allowlist));
> +		if (!obj->btf_module_allowlist) {
> +			err =3D -ENOMEM;
> +			goto out;

[Severity: High]
If this calloc fails, obj->btf_module_allowlist_cnt is left > 0 while
obj->btf_module_allowlist remains NULL. The goto out path will then call
bpf_object__close() to clean up the object.

> +		}
> +
> +		for (i =3D 0; i < obj->btf_module_allowlist_cnt; i++) {
> +			obj->btf_module_allowlist[i] =3D strdup(mod_allow[i]);
> +			if (!obj->btf_module_allowlist[i]) {
> +				err =3D -ENOMEM;
> +				goto out;
> +			}
> +		}
> +	}
[ ... ]
> @@ -9684,6 +9750,10 @@ void bpf_object__close(struct bpf_object *obj)
>  		close(obj->jumptable_maps[i].fd);
>  	zfree(&obj->jumptable_maps);
> =20
> +	for (j =3D 0; j < obj->btf_module_allowlist_cnt; j++)
> +		zfree(&obj->btf_module_allowlist[j]);

[Severity: High]
Will this crash if the initial calloc failed in bpf_object_open()?

Because obj->btf_module_allowlist_cnt is > 0 but obj->btf_module_allowlist
is NULL, the loop will attempt to access &obj->btf_module_allowlist[j],
which evaluates to an offset from NULL. When zfree() tries to dereference
this pointer to free it, it will result in a NULL pointer dereference.

Should obj->btf_module_allowlist_cnt be cleared when calloc fails, or
should this loop check if obj->btf_module_allowlist is valid before looping?

> +	zfree(&obj->btf_module_allowlist);
> +
>  	free(obj);
>  }
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260907053847.1115=
-1-zhaofuyu@vivo.com?part=3D1
