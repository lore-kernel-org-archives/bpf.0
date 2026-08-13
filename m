Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D03F2FE56F
	for <bpf@vger.kernel.org>; Thu, 13 Aug 2026 03:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786592275; cv=none; b=Q0sZftZB4q07SoUWbrF+gNQFHEtCL7m5E2ScHEBVvIcCeYXTFoYW7Xc8E75m6XK/N1ITOXtwjeFMc9vQHb9zuzfXB8+6/h3iJDnqT0L71QxY9NcKmPFe/5rNCPX6HZrnVKYQFZ3VpYDV8Hp54jzIyBnBP91KW6MtJ3fAhjPInGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786592275; c=relaxed/simple;
	bh=64VOHehe7qe0DEFowvKN3EEY3JBmUkEAvPw92hkAK9k=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GmYSKLOc0mvoir9we6Tj6X9U/F3rXElN8U0baxfJyC6qSVftQQu2lY9w+pEFvWB8M52B5UAfXvoWArz3mCYwep9Cgt5gGvbBEDIhTKws86ZG49IAYHwq/2cMqSg9U/7BqsedQLNWd6Kb5v1MYlD1UFXPoDRoVB30lncV4uEuZGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JhD8iSwl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JhD8iSwl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B09FA1F000E9;
	Thu, 13 Aug 2026 03:37:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786592273;
	bh=GVZqrwyi4zzNbGzqL5DhnVegzoqR8alD8EtaBldPbao=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JhD8iSwlRcaPUS4OGuS2NDT/ge/t0ZA1d2xVbtQGL8pZqAagKlfAgnqaKlMcXLnVv
	 x4oLhDCMxcbC/HHc8a+rIzxEu7yIeM3VV6+R3W/+YWYqSzWjRCD/mXngK9/RS2ldE3
	 iDG2D5SLTnlWjUmmXNN7ItP18gZNOhg4z+pY9/2BKZSHNkJ4WHqIr9aSq+yIw2tRYR
	 3ihwJBMpdg5YYo3FmrIaBkoGU81hoEL+nZFr9SvmugAnywvoQaYTj6SIpZCBr+Aaro
	 /eAFMat54q4ZP/ybn0p31o4bp5KyZSqwsCD0p5IDjF6qjcFCadU4SdCON9RxOZgK0j
	 1vfAV9v1b8mPw==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH bpf-next v2 1/2] libbpf: support selective kernel
 module BTF loading via .kmod_btfs section
Reply-To: sashiko-reviews@lists.linux.dev
To: "Fuyu Zhao" <zhaofuyu@vivo.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260813032613.2755-2-zhaofuyu@vivo.com>
References: <20260813032613.2755-1-zhaofuyu@vivo.com>
 <20260813032613.2755-2-zhaofuyu@vivo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Aug 2026 03:37:53 +0000
Message-Id: <20260813033753.B09FA1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Missing increment of `nr_loaded` prevents early loop termination.
- [Low] Multi-line comment formatting violation.
--

--- Patch [1]: [RFC PATCH bpf-next v2 1/2] libbpf: support selective kernel=
 module BTF loading via .kmod_btfs section ---
commit 3f4fb04bbfb95d7f7ea0012b5651135983af6e62
Author: Fuyu Zhao <zhaofuyu@vivo.com>

libbpf: support selective kernel module BTF loading via .kmod_btfs section

This patch adds support for a ".kmod_btfs" ELF section to allow BPF programs
to specify which kernel modules need BTF loading. It introduces functions to
collect the module names and filter the BTF loading process to avoid loading
unneeded modules.

> diff --git a/tools/lib/bpf/bpf_helpers.h b/tools/lib/bpf/bpf_helpers.h
> index 9d160b5b9c0ee..171ea055cd323 100644
> --- a/tools/lib/bpf/bpf_helpers.h
> +++ b/tools/lib/bpf/bpf_helpers.h
> @@ -188,6 +188,20 @@ enum libbpf_tristate {
>  	TRI_MODULE =3D 2,
>  };
> =20
> +/* Helper typedef for declaring kernel module names that need BTF loadin=
g.
> + *

[Severity: Low]
This isn't a bug, but the BPF subsystem coding style expects multi-line
comments to have the opening /* on its own line. Should this be reformatted
to match the preferred kernel style?

> + * Usage: define an array in the ".kmod_btfs" ELF section to specify
> + * which modules need BTF loading:
> + *

[ ... ]

> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 514e4e9daa825..9fe8a653e8b6b 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c

[ ... ]

> @@ -5891,6 +5987,10 @@ static int load_module_btfs(struct bpf_object *obj)
>  			break;
>  		}
>  		obj->btf_module_cnt++;
> +
> +		if (obj->kmod_btfs &&
> +		    obj->kmod_btfs->nr_names =3D=3D obj->kmod_btfs->nr_loaded)
> +			break;

[Severity: Medium]
Is obj->kmod_btfs->nr_loaded missing an increment?

Looking at the loop in load_module_btfs(), when a module BTF is successfully
loaded and obj->btf_module_cnt is incremented, obj->kmod_btfs->nr_loaded
doesn't appear to be updated anywhere.

Will this prevent the intended optimization of breaking out of the loop ear=
ly,
causing it to always scan all remaining kernel BTF IDs unnecessarily?

>  	}
> =20
>  	if (err) {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260813032613.2755=
-1-zhaofuyu@vivo.com?part=3D1
