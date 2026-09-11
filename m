Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A169331EB5
	for <bpf@vger.kernel.org>; Fri, 11 Sep 2026 23:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789170255; cv=pass; b=ilYoUQGIgW+Gy62WdevhiCbTGyPfhpbFn+Aek/Vx6vEwgiVvZ3fPj7MFHmpBZ9YShu5Yf6B3kKJbggeGM6oi1tSsUrjlcjHk5KUB9LUzWOld+PNPGNBnOf+bT1J+T5YkNQEgRxua3cwubWW3uFnsC8RrV53VKVFy3RMDqs8HHak=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789170255; c=relaxed/simple;
	bh=l0TnpUfoNt9EgHNS0hut5cim8kDMIHe0v55GovtfO5w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZfBRupR50lzeclznQpxzzN52jdJO8+pVceFI5u9WiTXNpWM/Q9puoW0lMRGlDcHgV7qoduRKSBqKVvu26SJP2s2G3u9X92dIKmkl8RQTU76f61dMpVmMLkfqzO/wdswXVWCb0k8E5ZMNrvWO3PKV6q1tOUwFoT0l2jhDVicP2o4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VKtuOQ05; arc=pass smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VKtuOQ05"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2d747f01375so1135925ad.1
        for <bpf@vger.kernel.org>; Fri, 11 Sep 2026 16:44:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789170249; cv=none;
        d=google.com; s=arc-20260327;
        b=VQeZQDJs8hT5XXslS7MeAIT4aN6Nodk2Olanzd4eBluUsqpGEHYqB4TVrw9Tn0EN2o
         9f04x5RVHgfZ/0MMadmETl98chknSh9LcDXI4av9V5gk/LzpWyUZn4EG9SjF0wVxXn+B
         3NJL449DgGQDJu1fVmkVPUfENXQ+XKb1vVNclw9+/VFH19djK6jxEgXPx+sMBby8bWQD
         7KoRYR6LJeLoF4VsmM2JsljLEMeKTQfZKJbJ9d1gt6aTj1zA644G+Zh5t4TM0p2W08aH
         tjsp/QZWvDvliyKJ+OIYw5YgfJoSPcu7QOZIctRGaqCVQFsVbz3jmw9rxNOQQJp42r6t
         P28g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DioAHBJoEh/q5crIv8eR4yxG34AKpE3BRnD9wps8oDA=;
        fh=Pt6sKbZv0ijAhavqZflLqF3fSjEVzNxt6H6Xlv9tcSU=;
        b=EwmD/XH5paZgTvOaWH9BekXalNOuV9VoWlJj6O17e7znwIyP3mJA7hclxbShuHGKoB
         Xg5EywT/VwIGDnzHKR3Azkukg+L++yRPt9qK+EdcKvE1LZzpwiioWNLvPqRULHjbLxfG
         XTVxZd6oZGCXECRDlQJ/ZxhKSbhV0xFf7FQtQNd2JK9IUUT87qm736mFW5dDzfsNnrRR
         r2MsKdzk+q1MGlYhYQbytD9PnCR4mP0SNu+DCaSC5dEF61ms7WgbBg5G6fKfhqta4tFN
         cQnsMSDdljb36tWM2hqZC6yzK6HkkY5WZ/YaaJ6Nw9ehxOTCSuYdqaDiIM2FRjAaSWIR
         eLlQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789170249; x=1789775049; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DioAHBJoEh/q5crIv8eR4yxG34AKpE3BRnD9wps8oDA=;
        b=VKtuOQ05dKw5CbiifwSeXu87etmrkkOtrYIoMZ37ZcM1Wm9rTncKNiP3SQ24eIWvsW
         ex3pBFbUYvg3h9M4Ee7/cr8zSpF2+PkqMx5jwrH2FB3Q5U/uj06KqyH5p3rkgyox8Oob
         68/CorKVH8jvh8l9gES/c/4bFzwPXoT3Wv/+kdlBDPK9yUh44pB9eZhTF6CZJsMZ17hr
         tQ8JZW8oaNLlxFUhWYsByswEZgglpnJuswu86mgQCJu/JpECe394UME1UT4DIeyj/Fy0
         4V+vizTQNSwYpQrkUpk1JR9N8tIPeuZ2EWyVQqwvkTpC5FyE+ItZwcVofHWKVvjZ1FHC
         HXwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789170249; x=1789775049;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DioAHBJoEh/q5crIv8eR4yxG34AKpE3BRnD9wps8oDA=;
        b=C40la/Fwn4bZANdLVkS4dxjyj8Ghztqjcg3mYRANHkTGdlIlmumR62ve2rOU583+8s
         oq1xwrH7/IX2Skm6m4ecXBFz6GIOSrMzliBFv+rVVaOsvS+mf58a2lzXqH8vlWO/YFq1
         UmZFcYXcvN73XaMaEyHQ2sJMmRk2WowsQm8DBJAqCIJlfM0SL/6jN4NKxsgrpb9i8FVc
         xKRYbX4uaR15FXGQeBP/SIp7zIrHvWNXyedoyIoRMcyyYx4GF+FRzSkL0WbYWkCn7gtP
         q+x9tr0mpnmLODy4GSlSZfmLB+xmbyS2mKiRA1ToiaFWroIaXsgwrTLosLjoxUhyuNqF
         NbOA==
X-Gm-Message-State: AFuF++lto4iJRfqkd5M6A/m0J2G20pQNbqOI2Tmqiyd2XVDew2reVMk/
	esRzXC62rgWzsKnYwwTqvKoYq86wBXKdvhBG4LQgyh7Vvf2rGjEuZaZrnGUQWvwu/N0pL3qT/Ii
	XJsa3U3OTLoMBYCeGg7MANjM2PwBPvi01cw==
X-Gm-Gg: AYBFou0ZhGyEAlHbNNYebCLm57JOLbOYdxTEEwXHA+bvmffe+5Wk9JZoTgUF/ut4o/E
	gWAEVlJa4Y+Wx2s+2G7ozPTtlsxuU83lOA8Bs3WTs6F8hkEFc1k1s305Sb4ur9zahXkPJ9fllpC
	mZUiYKjGFkBubM/XJkhECiPB4DRqCYKSmR+07kyho4B9XpVU9dTKbhImqU8Vw3mhGzzP50U5kQl
	nTHXpemdjuxrnaN7WmGkDRMbL/0Wi+bQpqK5Kk7RqFYBshVixrMHWzeZB7SgYoPPaHzcAZj1v94
	p4qFK/jnz97BKZ+VQXNxAjKrGccXlP3/Fd3pEMb/XLiVfRNWrIy4t1EpV9plrS+NIL/4CW+MDjY
	F+1vVDEXjAMXQCAPu0yqzuHH4IBp1UQS/q5HS
X-Received: by 2002:a17:90b:1c02:b0:396:4cbf:45bc with SMTP id
 98e67ed59e1d1-39dbc6a4af2mr775769a91.16.1789170249183; Fri, 11 Sep 2026
 16:44:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260826181825.1826541-1-andrey.grodzovsky@crowdstrike.com> <20260826181825.1826541-2-andrey.grodzovsky@crowdstrike.com>
In-Reply-To: <20260826181825.1826541-2-andrey.grodzovsky@crowdstrike.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 11 Sep 2026 16:43:53 -0700
X-Gm-Features: AcwNN1VUiiOWeCIag7DOiOM_dlucOs3S6tWi0-sBHYai7YOI0hiwkD1W2kWfKBI
Message-ID: <CAEf4BzaQzLbPZy=pnNhDBe0hOX_HbPytowZ8AqU87_7KTU2CxA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/5] libbpf: BPF program load type enum
To: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
Cc: bpf@vger.kernel.org, andrii@kernel.org, martin.kelly@crowdstrike.com, 
	slava.imameev@crowdstrike.com, linux-open-source@crowdstrike.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 26, 2026 at 11:18=E2=80=AFAM Andrey Grodzovsky
<andrey.grodzovsky@crowdstrike.com> wrote:
>
> From: Slava Imameev <slava.imameev@crowdstrike.com>
>
> Replacing the boolean field with an enum simplifies the addition
> of new load types. Currently, the bpf_program structure defines
> the autoload type using a boolean field. This field is now
> replaced with an enum, allowing new BPF program loading types
> to be introduced by extending the enum value range.
>
> Signed-off-by: Slava Imameev <slava.imameev@crowdstrike.com>
> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
> ---
>  tools/lib/bpf/libbpf.c   | 50 +++++++++++++++++++++++++---------------
>  tools/lib/bpf/libbpf.h   | 15 ++++++++++++
>  tools/lib/bpf/libbpf.map |  2 ++
>  3 files changed, 48 insertions(+), 19 deletions(-)
>

[...]

>
>  bool bpf_program__autoattach(const struct bpf_program *prog)
> @@ -15111,7 +15109,7 @@ int bpf_object__attach_skeleton(struct bpf_object=
_skeleton *s)
>                 struct bpf_program *prog =3D *prog_skel->prog;
>                 struct bpf_link **link =3D prog_skel->link;
>
> -               if (!prog->autoload || !prog->autoattach)
> +               if (prog->load_type !=3D BPF_PROG_LOAD_TYPE_AUTO || !prog=
->autoattach)
>                         continue;
>
>                 /* auto-attaching not supported for this program */
> @@ -15221,3 +15219,17 @@ void bpf_object__destroy_skeleton(struct bpf_obj=
ect_skeleton *s)
>         free(s->progs);
>         free(s);
>  }
> +
> +int bpf_program__set_load_type(struct bpf_program *prog, enum bpf_prog_l=
oad_type type)

I'm a bit worried about confusion with "load type" being interpreted
as "program type at load". More precisely this would be "load
strategy", totally libbpf concept. A bit verbose, but this is also not
something used everywhere, so perhaps "set_load_strategy" is
acceptable. WDYT? Am I overthinking?

> +{
> +       if (prog->obj->state >=3D OBJ_LOADED)
> +               return libbpf_err(-EINVAL);
> +
> +       prog->load_type =3D type;
> +       return 0;
> +}
> +
> +enum bpf_prog_load_type bpf_program__load_type(const struct bpf_program =
*prog)
> +{
> +       return prog->load_type;
> +}
> diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> index b965ad571540..700634664e32 100644
> --- a/tools/lib/bpf/libbpf.h
> +++ b/tools/lib/bpf/libbpf.h
> @@ -2078,6 +2078,21 @@ LIBBPF_API int libbpf_unregister_prog_handler(int =
handler_id);
>   */
>  LIBBPF_API int bpf_program__clone(struct bpf_program *prog, const struct=
 bpf_prog_load_opts *opts);
>
> +/**
> + * The program load type:
> + *
> + * - BPF_PROG_LOAD_TYPE_DISABLED: the program is not loaded.
> + * - BPF_PROG_LOAD_TYPE_AUTO: the program is autoloaded when the bpf_obj=
ect is loaded.
> + */
> +enum bpf_prog_load_type {
> +       BPF_PROG_LOAD_TYPE_DISABLED =3D 0,
> +       BPF_PROG_LOAD_TYPE_AUTO,
> +};
> +
> +LIBBPF_API int bpf_program__set_load_type(struct bpf_program *prog,
> +                                         enum bpf_prog_load_type loadtyp=
e);
> +LIBBPF_API enum bpf_prog_load_type bpf_program__load_type(const struct b=
pf_program *prog);
> +

please add doc-comments for new APIs

>  #ifdef __cplusplus
>  } /* extern "C" */
>  #endif
> diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
> index 08ab2ea881fb..4d63dac8c3b7 100644
> --- a/tools/lib/bpf/libbpf.map
> +++ b/tools/lib/bpf/libbpf.map
> @@ -462,4 +462,6 @@ LIBBPF_1.8.0 {
>                 bpf_program__clone;
>                 btf__find_by_name_kind_own;
>                 btf__new_empty_opts;
> +               bpf_program__load_type;
> +               bpf_program__set_load_type;

this list should be sorted

>  } LIBBPF_1.7.0;

> --
> 2.34.1
>
