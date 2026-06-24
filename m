Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACABC3254BB
	for <bpf@vger.kernel.org>; Wed, 24 Jun 2026 16:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782319115; cv=pass; b=b8v0eLIoVGIr8LVuD6ahd7ikPJoFUhBqRj9i9InDiAfCkXea17gJm6Ohnf6tkbbghLMZ69XFIpVvr7gVkDsivYmPKWE/KIGAhvvyNyZIFUROS3dwY4edgmspyMEpYYKzi2w5sfV19nv5gWUGc1OWoj8Gjo9Rp3uN6BDWQVr1H7k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782319115; c=relaxed/simple;
	bh=H9W1dEJDPyRKl2sfdT8dO28enMeQoXfFCCRppVuhqnY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nsBxOJhy10uXoQvRoK3M3y6BIBuVtOzL9en6Jw8rjLRFCVCY1dBWeDXlMUf4mBukZUerSRJTRoP6P7qnI8aoQId6dqoweEPijW3Q0HMOzjeEjxdBnopROSFN42e5pE63VV0zTV/zCSJ2kJdzansl7qpD8UByNY9x7DrNpZ8d9lQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dLVE/Jga; arc=pass smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dLVE/Jga"
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-662c360aa73so1365095d50.3
        for <bpf@vger.kernel.org>; Wed, 24 Jun 2026 09:38:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782319113; cv=none;
        d=google.com; s=arc-20240605;
        b=WW0ekLGTMQMKv7xbM+H0vtJ8c7bpZ57/I5iYFmUd2Q9m3K3DZkljir1S3S2BpEYkOk
         Y5FqRshgLNzndQchn5zFdnbJ/KNtSudceKLQrdov1OzQWYdDl5DPmobQTJtNLgQVmiBb
         /pw9ngIw8e5/geEsrgFZedh8PuuYTQdebApGEv+o0lCRwfjPRg3y5Ql4XSZHt7ZAV41L
         z5vurXDuSUpT8DvCCnMTbh5GKylCM+UVm5dGqJms9qO9SzWxWI0Y7tdc/vjulcEleubR
         byLGTyjDZGqCg/JkxjHI2TW7CsXLMKfOG5mqC2NCqJhcShrg+NJ2ukgiKjMjHrAafVo7
         1W0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GSu9YbZfMzCAQKitxFaYWjlM2XOAqBeVNR6Gv9gvDe8=;
        fh=uA360uvxR9S0K/Y4Lovo7aIaGlBwzVBnnb2BKWupr/4=;
        b=JqvW5csA729++QBgtmCwMEZbWtZF4Qkn8jyGWWzCi4uJ81CuAj/Rr0c39Ad7utTC8H
         oPD9Iw6/YxZ5VKUqdMqFafkxRzbEWw3mlBpP9xLj/6qY2MBoqZDYTajIU8VyFEUrbuI1
         dQsAH2vrOUy6UPAjt/tVl9AUCgOYuThVDo3zmiHlzMMfNE+PkBOJkcJtu5XPl2yxi03c
         5zkeDdXQsSvT+N7QInC0CmS14XYMxzPXaTgYeU/sgkrnMIqT6f6Mokt+hc9pEeuRwK3Z
         dQHIlzI2ENt5kt+TJAQGqKDVjt5Je3hAIYBHS3+1W53VOZK+hzpUeIGiATrS58umGQWa
         qVuw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782319113; x=1782923913; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GSu9YbZfMzCAQKitxFaYWjlM2XOAqBeVNR6Gv9gvDe8=;
        b=dLVE/Jga5YP1U1N3EMJFv2Qt7GikyRus/bHpyAsjuW97fKL7ujr9cLs9Zx/3+bjkGB
         Z4U9iDcVK1tDysMdp9onOhNb25UEC0DZQn41aOq44DJ1xrdjQFUtl8MNsn6Ugs53os0s
         69o8JYrRPKKpOcYVKSKbbLKYstlGpnkY1n1rvUwF3fnWEHT3rqWMyHo+WhEu0KBemtOf
         SfW6J7Ko9vYxAaLglR78hOHjvzE7GYXoz5eBJ6TPRK0i0Uof9Pl2IkN1amrSH26hl6iL
         XImkmgFfqWwqOHSqfRPs9n8qX1RV8HgO80g6Se4uvkAOwhOLeZF0jr4fXKdxZ7qvNLDA
         +vIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782319113; x=1782923913;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GSu9YbZfMzCAQKitxFaYWjlM2XOAqBeVNR6Gv9gvDe8=;
        b=FPcv4sgiY6yZqBTRBSoADrv0CiNMGgKtpMl+dmyuY9CTOQSlmllNwFp84bUotkcNPE
         cawIrJZE9/r9Lw5F6ATvhJw4Ez9b9nm+ERIE6bnVhy/4hK//AiiEu2SMDtQVjlam2hrj
         w1gxVgsoy42s491hfvwb3qAYswpt9mDzeUf5FHB3sW0GMf9FQzp9zdICeVIavQvd2tM+
         GfaPC0f0Dpf+cYcDXDrRelhVhIZy5KGnBH/cvAzPcM0uyzd/OnTiKJsqvr2iDIqxDAJl
         koLt2gYlJe4momJ0tDx1XV56Mm68DL69TvuOqz6QMT+6aRJqgEPX8NjzUUeVSGSYUT5r
         X6zg==
X-Gm-Message-State: AOJu0Yy4kBZKKTcV5g3SOfNkc72bkKbm7eKpyg+qS1fG1TAnCyLk5FTJ
	olWec6AQkLe8EigPFlKt2Osb0xZEFPGnqo1BHicmglTcVugkBHptLSXA+uJivAHw7lgUEmXkMAm
	OJp1Eif0t1WLlzbjmnGjq6GAR7yxoO70=
X-Gm-Gg: AfdE7ckQGImRap30uZhqHhOAm2CYygycyUXAJaZv0znqGs1beh/G/567CehhJOxrClF
	4M6Q+RN6dR2az46yCwTgx79b2PSw7UmcTmL3diwXMTz7jL5K059DNPDiobCj1EUMIdT7qvq9Sdc
	Ql+ififd/g5eE53Ugc9GBwAm8paLBab1IldpkcYiuZpRmhsJNnsN/BU+cl/4QEolCpjQtP9tBgs
	XJv6N5pG80Jwc/ZPGFUsU7NSYEofR2absID2qKU2P8OaBJ2Rz3g4ZPkEBJkmC7/mdbWcIOgASjS
	cEala7M=
X-Received: by 2002:a53:ac8d:0:b0:660:460e:2559 with SMTP id
 956f58d0204a3-6636e423652mr3698458d50.39.1782319112490; Wed, 24 Jun 2026
 09:38:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260623175006.3136053-1-ameryhung@gmail.com> <20260623175006.3136053-4-ameryhung@gmail.com>
 <20260623214054.909821F000E9@smtp.kernel.org>
In-Reply-To: <20260623214054.909821F000E9@smtp.kernel.org>
From: Amery Hung <ameryhung@gmail.com>
Date: Wed, 24 Jun 2026 09:38:21 -0700
X-Gm-Features: AVVi8CcrW35Pmper7ivcINQsaPKGZjDfSdaMkwiJLsQ4RNi_3YmC0K5FQFU7oAI
Message-ID: <CAMB2axNYMbRZcBJaa=hZEM_NU-P3SxrfMopE6zAc9DrTKW=Aww@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 03/15] bpf: Add bpf_struct_ops accessor helpers
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 23, 2026 at 2:40=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Low] The newly added bpf_struct_ops_kdata_map_id function is an exact =
duplicate of the pre-existing bpf_struct_ops_id function.
> --
>
> commit d1f80ae7e459b35d14e3b364a031f8d29bf9da8e
> Author: Martin KaFai Lau <martin.lau@kernel.org>
>
> bpf: Add bpf_struct_ops accessor helpers
>
> This commit adds several helper functions in bpf_struct_ops.c to be used
> for creating a struct_ops to cgroup attachment link. It also refactors
> link update validation into a reusable function.
>
> > diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
> > index c422ce41873ee..1ca44584ed17c 100644
> > --- a/kernel/bpf/bpf_struct_ops.c
> > +++ b/kernel/bpf/bpf_struct_ops.c
>
> [ ... ]
>
> > @@ -1236,7 +1236,33 @@ int bpf_struct_ops_for_each_prog(const void *kda=
ta,
> >  }
> >  EXPORT_SYMBOL_GPL(bpf_struct_ops_for_each_prog);
> >
> > -static bool bpf_struct_ops_valid_to_reg(struct bpf_map *map)
> > +void *bpf_struct_ops_map_kdata(struct bpf_map *map)
> > +{
> > +     struct bpf_struct_ops_map *st_map;
> > +
> > +     st_map =3D container_of(map, struct bpf_struct_ops_map, map);
> > +     return st_map->kvalue.data;
> > +}
> > +
> > +u32 bpf_struct_ops_kdata_map_id(void *kdata)
> > +{
> > +     struct bpf_struct_ops_value *kvalue =3D
> > +             container_of(kdata, struct bpf_struct_ops_value, data);
> > +     struct bpf_struct_ops_map *st_map =3D
> > +             container_of(kvalue, struct bpf_struct_ops_map, kvalue);
> > +
> > +     return st_map->map.id;
> > +}
>
> [Severity: Low]
> This isn't a bug, but does bpf_struct_ops_kdata_map_id() duplicate the
> pre-existing bpf_struct_ops_id() function?
>
> Looking at bpf_struct_ops_id() which is already exported in the same file=
:
>
> u32 bpf_struct_ops_id(const void *kdata)
> {
>         struct bpf_struct_ops_value *kvalue;
>         struct bpf_struct_ops_map *st_map;
>
>         kvalue =3D container_of(kdata, struct bpf_struct_ops_value, data)=
;
>         st_map =3D container_of(kvalue, struct bpf_struct_ops_map, kvalue=
);
>
>         return st_map->map.id;
> }
>
> Both functions perform the exact same series of container_of macros to re=
trieve
> the id from the map field of a bpf_struct_ops_map. The only difference is=
 the
> parameter type (void * vs const void *). Could the external caller direct=
ly
> invoke the already exported bpf_struct_ops_id() instead of adding this ne=
w
> helper?

Yes. I missed the same comment in v1 also raised by sashiko. I will
remove bpf_struct_ops_kdata_map_id().

>
> > +
> > +void *bpf_struct_ops_map_cfi_stubs(struct bpf_map *map)
> > +{
> > +     struct bpf_struct_ops_map *st_map;
> > +
> > +     st_map =3D container_of(map, struct bpf_struct_ops_map, map);
> > +     return st_map->st_ops_desc->st_ops->cfi_stubs;
> > +}
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260623175006.31=
36053-1-ameryhung@gmail.com?part=3D3
