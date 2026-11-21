Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.180
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795220446;
	b=HFcuEFHAebLYW2Co9kLdm1l3xkSkycn96cNxOoLISucpgqwyfLhO0KJe0mpnTUQgvUYw
	 qiP9niiXetB9+VN7VOs/PLqIPoj8fRyIk95jeR8QaP9KWhEemXCdYek8kf2dau0YBvhjl
	 ykkFHcjD9qjH1+GBmZwipglItAzAzIc8mkxjElfu1oftmJj1wMrNuK39f8Ywpmsue9cSl
	 QKT5p7EmhPYryTilB+adDQGiNKm6KHvpf74kxMV+rJ9dGVyTsunc065zf3GI8WYpu8iuo
	 URYJX48RDkUSL/Ok7T8uzwwCAf/oalSnsNHH1oYJjS6r80HfZZ7+Fl8Z31gqUzjTjbA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795220446;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=oTW1ECUqKZPFZMGwmFF0XG/dMWrRIOOKKmtz6Ts2T3U=;
	b=G5WgpEX4kPrbSW3WkayzR7tHQEKx9hWY3XANSfY7eTnJznUPl6i+At3fC20XNitnHmWQ
	 NSkY94vmkitUJeinwWj4dOANWc8m2bfRaQ4MWpMfBGg+erHSKXxTZ8FnSqmxtyVdUn6QZ
	 V6k+Kj15DnI88YW22yHe5isU0ZWF1PnW/QBkzSTJvw2QzC93g2HajwDLz2ANmtwM8W4dI
	 Esw0r22jZ2h3h4Mm7FuPzWcatjLWy4jKMYeVYtCag5NGjeOo5RJRp817huujwSraMhOnr
	 E3kgRHqzY+aTZ+TbRUcgDl5ux4TW4fYT1qq/QoFp4g2M7I/FfFm8zNrI7/jl2dDmsDQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=paul-moore.com;
	spf=pass smtp.mailfrom=paul-moore.com;
	dkim=pass header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=LklpZjfD;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.180
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EF0A606A680
	for <bpf@vger.kernel.org>; Sat, 21 Nov 2026 00:20:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3EF0A606A680
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=LklpZjfD
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2eff92780daso11273885ad.1
        for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 16:20:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795220442; cv=none;
        d=google.com; s=arc-20260327;
        b=ToPsnB4CUg7nEc+dm/uSzQhfuFNEmb29YDh5mkaW7k6jE/tHNtfaNB1y21NeAvEWL6
         mebanXNLm6SBSyppzoeRhfDdPLzqH4FOqoq6o6nlG5+eiC4O9Psr3oua6QsE+WX50c+y
         fM+W5IBZJ2LrrMCyKk1PEYZbZ1BryH20WsWs2iohJmggXZkmyTv08kFjjKe4DA58VoXD
         ldIR6iegEplBluyWLoPRlwFnuuPKzkpPEkodbBH/svU9hWxmzYbgjQ5gMgsIpnFuAxZd
         sNDy8bbXNiZzgQgUiSks7HT/+TGHsU2NxVoU9+UuNpyaXJzwtv1Aq5BlveY/GNDZl8eH
         kcnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oTW1ECUqKZPFZMGwmFF0XG/dMWrRIOOKKmtz6Ts2T3U=;
        fh=nst4EXh9oDJgK0geF7fryKOWy5+r3C5toSfsh0KV+us=;
        b=mHetX9+wxIAOoP2e38Hh+1dMwblvdVineF6g3/x065lVdbS6sdku4AG8d8VYnIL/oF
         ckXiElXW30Fu9sNhZgGDZjn0lorv+2E4uzlPyfbw8A2hmoRGz9Vw9nqd9wyoyT8ogUUz
         2cj5mr8nJJfcAnyxROWe1f1sKvtGZSa5DpPSFRADD2kTckXqdar+BtkjzHcDjEVso+6h
         YHMm+9ybz9bEI3fk/VoHX9IGkHrPfyZ0Fz/9PrjAyE5a8FVcrFl2Kj8yDqZaVBncqN5e
         BWMrNXPsRXZegVS1n1/nsbpbC3wQ3hiz3F+vEZQt70mYohDf5sTSm13jEj0lZ0w4+W8w
         aydQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1795220442; x=1795825242; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=oTW1ECUqKZPFZMGwmFF0XG/dMWrRIOOKKmtz6Ts2T3U=;
        b=LklpZjfDtnvNwzndHIjW8ZNQ8zMlt3I98Fdj6dWCKzaDJHMX2vBYb0r30EuTxy9M06
         eQGhuC7Yd00TmtaxH7l61w5nkPpoOIydtVskUsiv/RWg/4GHNeQZO7yXThSxIg/cMJvq
         s55skHl3XgM2Hjtfb2lXYxlXe5AyNPaWs8TDCRw2j2xcvkU6RSPUD6Qj2LEElOHa+vRt
         Ke+/y0j0acY9FV8MnSNLvTrorvLnJ9CFyO7xdWgnxq4unh+56/00JLLA9wfiUbOJAafX
         uJk0bi/Qov+0va5b24OMN8H+By8PZUz/+csFTkmKtGJ2Y66fsZIybqh8WSdpGQQaP42R
         PWzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795220442; x=1795825242;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oTW1ECUqKZPFZMGwmFF0XG/dMWrRIOOKKmtz6Ts2T3U=;
        b=ECyslz5+dGJhv5FkbOifbWAfrTG8k4AHa1TCvSGPRRRzxGckTzRzOm7k2gwNxg0cxd
         eTeVi3Ur6Xl8ZCamySmIL3nvt7KSWwTQN8CIjgXWqbSgblVef9k5tMVDgBefL4II72K4
         dQ9crV2xGWJZ6kenuxgKpsHqLVkIkKa9v0zp0z6zx//BCxmndqlOk1sPPnBh+sIAZSlA
         i5ORV17dj8KQvnVjCwpy81DwYrnhODNvZPuj/HAuOT4sEtkna8wBdko2yjb0/H1yVDPz
         BBYI+ncGYHgGUfaPoM+WSsrB/Xj+9zcx8p1/G4K3kkLky4dlcht3afvf4HbMPM6U7+2p
         f+SA==
X-Forwarded-Encrypted: i=1; AL+hErEUdrW2JOu7QpLQVqWTCqB775ThTynW/vyNTdXTeA+wWDEbd+NV68R2Ur15zG6//D8tkmM=@vger.kernel.org
X-Gm-Message-State: APuU4Z/bLVJFHfErGNJeMtm99D8Zk+/+JerViEJPJmsX2BO9tPARcR6L
	ytwiG/7kOx8KY04ctEafchXwAeGuVOGBo3BzdTy+FmD6qak2lOG980lkOxUqDcpQuow5aKqz0Fz
	vMPzqgq2uwtx/AM1iVL/elR+vDeScyQzkTnl5EOcP
X-Gm-Gg: AZFdTZee30TMJKVK+U5WRMGhAyOGtGtJ1qjfCVx5LTNWG7qDaq42n5F1Dt3S9bdCerb
	lN13RiR2xK7IbUdeTvM6Hcs9WUIz+FnmQ1ne9nxlbb1KvD7h8pkIB833BfgHMAqC2UliOkTP/cK
	Szp32YGv+PyUyDnWfzUksQB5fDMtOO+Z6z/YR1kcxWZy7wmw2akJDRQhMTLovv06gzHe+Oxp1qn
	QQlb7eJ8i/B1RiQKxj0Wx40TnT9JKvOSiI+260i3GSzp9B5CtozUQ4SGgcCO//xaMcMQ2A45Buv
	bdf8rzaVLUUFUJCuu4FGlv+VPme5F2ezUCg5khVJKCAGoSxhykQXwguSHOvohxHmEw1Rv1ShkQp
	FfxSrCXCX4jyN63/wbLF3gebvD1tiFr+mp5mxhm1jDmFASrC1rwTCbMxgFh8NSow3tLKD
X-Received: by 2002:a17:902:e811:b0:2f0:22b2:bfe2 with SMTP id
 d9443c01a7336-2f03f201151mr45499255ad.31.1795220442596; Fri, 20 Nov 2026
 16:20:42 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261120-work-ns-mount_subtree-v1-0-06337377f94a@kernel.org> <20261120-work-ns-mount_subtree-v1-2-06337377f94a@kernel.org>
In-Reply-To: <20261120-work-ns-mount_subtree-v1-2-06337377f94a@kernel.org>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 20 Nov 2026 19:20:30 -0500
X-Gm-Features: Aa3M54rUKAyhudO_NMmwLoQSP6nA25xTN_t_G9kBgfIIkvZyJM13Qz-1vfwego8
Message-ID: <CAHC9VhQrbBEX7tHtCUSPGgUqLLObCdBCRPkNLgDdtcgxTC3V_w@mail.gmail.com>
Subject: Re: [PATCH 2/2] ns: don't call the namespace LSM hooks for
 kernel-internal namespaces
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, bpf@vger.kernel.org, 
	Zhiqi Zhang <zhiqizhangg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 20, 2026 at 7:30=E2=80=AFAM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> mount_subtree() allocates a private anonymous mount namespace so that
> automounts triggered while it looks up the path have somewhere to go.
> That namespace never becomes anyone's namespace and it's gone again
> before mount_subtree() returns. btrfs goes through it on every mount:
>
>   btrfs_get_tree()
>   -> btrfs_get_tree_subvol()
>      -> mount_subvol()
>         -> mount_subtree()
>
> and NFS on every NFSv4 mount and whenever it follows a referral:
>
>   nfs4_try_get_tree() / nfs4_get_referral_tree()
>   -> do_nfs4_mount()
>      -> mount_subtree()
>
> But __ns_common_init() calls security_namespace_init() for it like for
> any other namespace. Since commit 15dd86021b57a ("landlock: Enforce
> namespace use restrictions") Landlock enforces
> LANDLOCK_PERMISSION_NAMESPACE_USE in its namespace_init hook. So a task
> in a domain that handles that permission without allowing CLONE_NEWNS
> can't mount btrfs or NFSv4 anymore. mount(2) fails with EPERM even
> though the caller never asked for a mount namespace.
>
> Mark such namespaces as kernel-internal and don't call the namespace
> LSM hooks for them at all. That includes namespace_free. Currently
> security_namespace_free() only calls the hook if an LSM requested a
> namespace blob and none does. But we shouldn't rely on that. Otherwise
> a bpf program attached to namespace_free would see namespaces go away
> that it never saw being created.
>
> The anonymous mount namespaces created by open_tree(OPEN_TREE_CLONE)
> and fsmount() are handed to userspace and keep going through the hooks.
> Landlock covers them on purpose.
>
> Fixes: f675d2e95569 ("lsm: add LSM blob and hooks for namespaces")
> Reported-by: Zhiqi Zhang <zhiqizhangg@gmail.com>
> Closes: https://lore.kernel.org/20261114141323.19029-1-zhiqizhangg@gmail.=
com
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> ---
>  fs/namespace.c                     |  9 +++++++--
>  include/linux/ns/ns_common_types.h |  2 ++
>  include/linux/ns_common.h          | 20 +++++++++++++-------
>  kernel/nscommon.c                  |  9 ++++++---
>  4 files changed, 28 insertions(+), 12 deletions(-)

...

> diff --git a/kernel/nscommon.c b/kernel/nscommon.c
> index 4438c6b663f91..20fc0d0e98212 100644
> --- a/kernel/nscommon.c
> +++ b/kernel/nscommon.c

...

> @@ -66,6 +66,7 @@ int __ns_common_init(struct ns_common *ns, u32 ns_type,=
 const struct proc_ns_ope
>  #endif
>         ns->ops =3D ops;
>         ns->ns_type =3D ns_type;
> +       ns->ns_flags =3D flags;
>         ns_tree_node_init(&ns->ns_tree_node);
>         ns_tree_node_init(&ns->ns_unified_node);
>         ns_tree_node_init(&ns->ns_owner_node);
> @@ -85,7 +86,8 @@ int __ns_common_init(struct ns_common *ns, u32 ns_type,=
 const struct proc_ns_ope
>         /* Allocate the id before the LSM hook so it can track the namesp=
ace by it. */
>         __ns_tree_gen_id(ns, ns_id);
>
> -       ret =3D security_namespace_init(ns);
> +       if (!(flags & NS_COMMON_KERNEL))
> +               ret =3D security_namespace_init(ns);

We try not to make calls into LSM hooks conditional whenever possible,
preferring to leave that up to the individual LSMs.  In some cases it
isn't possible due the state used for the decision not being visible
in all of the cases where it is needed inside the LSM, but in this
case the flags/NS_COMMON_KERNEL state should already be present in the
ns_common variable passed to the LSM hook so we should be able to drop
the flags check and always call security_namespace_init(), letting the
LSM decide how to handle NS_COMMON_KERNEL namespaces.

The LSM could make a similar decision in the security_namespace_free()
hook below.

The update to Landlock's hook_namespace_init() should be as trivial as
the check here.

>         if (ret) {
>                 if (!inum)
>                         proc_free_inum(ns->inum);
> @@ -106,7 +108,8 @@ int __ns_common_init(struct ns_common *ns, u32 ns_typ=
e, const struct proc_ns_ope
>
>  void __ns_common_free(struct ns_common *ns)
>  {
> -       security_namespace_free(ns);
> +       if (!(ns->ns_flags & NS_COMMON_KERNEL))
> +               security_namespace_free(ns);
>
>         if (ns->inum > MNT_NS_INO_SPECIAL_MAX)
>                 proc_free_inum(ns->inum);
>
> --
> 2.53.0

--=20
paul-moore.com
