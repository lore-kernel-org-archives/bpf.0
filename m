Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1511A40759D
	for <bpf@vger.kernel.org>; Wed,  3 Jun 2026 23:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780530512; cv=pass; b=t+NR1mLUuZE4u5oPmwklD/HklHv3vJ7gIxaQzYlO18WdnKwxIJYiauOD/TK8pdjCuLoZ3zmuCOqkLzovBwoIqxsy4C1jw1JD3XSkwPzWIUgv+XnfGpOZR7nQgaDCwFABUuokrfIt5rW9VzPHt933Nb6nPu6Ylf1c08nB49oyzm0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780530512; c=relaxed/simple;
	bh=QWkpgbb3Sv9J1u6cdXHz6Jljw2OMAo8XoiFg7eS8a2Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Af9RjBSjHtVdF0xL4PwARXsmXEVnYpfq+3fdHpFOBjjLotuKcqj/CDfo4g2mt4X83CozrrYYCJGTuc6HXkjFaAOWaQ1AoVb/bV4QCeLNcow9iYvR1QCvR0RguEn64Rpq6XwtvOgJJvng8niiWZpkc5lsFXhSPWBG/8HW4Ygv9QM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=algRIbVA; arc=pass smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="algRIbVA"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-68d23430690so127036a12.3
        for <bpf@vger.kernel.org>; Wed, 03 Jun 2026 16:48:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780530509; cv=none;
        d=google.com; s=arc-20240605;
        b=Y1DLu7x7BLwK7IMXCkZIGGn4FaaSCBNgMFkqWWcV2wxb5amOJgHWPWC5NrsBnTql0G
         5DW/MmmMXSMyvkOXO43DoKxlHbRSHPrGC5gepXSKLQAac4NwYl0Xjg6gaweP13Qrgd1m
         ai7QHP5u8w1w7dfD09wyTcO1ARZ9Z1MxMv6lRPKQ1hzyud/KURx5MjEWSWG8sRL0Uk16
         Ry0CWR7oUjxZhN+B8JCxzRQoKOFq+ogeCuD6udrQrS+Tz/3rOOPAJqWCSsh8dLRLWULd
         lN7PJmVPyMqXlqT/dPpCaX/62OZWgdHpfeEuT6jmqqfWJ7sB7aCdBAD1b/7G80sN+GwT
         KMKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=T90oynylW7AQk2MgYZP57oghSUfaSB8gw/FQu/tdAng=;
        fh=CtCjRi9LbqWSX4cLVKSwETE/pzxvWim/iGOjcP8/7wQ=;
        b=SDrVeh0XirwiTwS87NzmOmBn735AyjOs0RZwQGDW9y6LsH8ucZDjROMJrHh4NOtWso
         hqp50h60GIHEYZrv+yZooZIQc7DQ00VGCsWmOHvluP4JTqCaciLOtv4qT8F0sR1WYjN2
         UHX8XygHdMcMbDOgDWm79CLsm7NmMk7oWBVDXQwbI4jUZIvZ5gFElfYPao/hp4jLL9lh
         JLJoRajE5U7QAtX/6ARozmA9RUihOfnKQ2sdjr1eL+OF8tvWL6t3nQTEfsRVtHoh+sEM
         mxHI9tk0sLG09XEr7MR0c/j6pDUUDXAk3tZTENc1vWBtvBEK98gJqv1lwCds+AgSvZx6
         PLCA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780530509; x=1781135309; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T90oynylW7AQk2MgYZP57oghSUfaSB8gw/FQu/tdAng=;
        b=algRIbVABR7io4W547Mg7Z0HhCc9Ed99mp7dIYLYuF0OOHMf4+g4e5I3LVAVP/Anpm
         Kvn7tTpQQjjI7YRuVe9kf9dpKKl4dNsa2eHgPn589zen1QesEVjvUQ6dVFbWhClLfoLH
         Ai3K+hOcgN/ttKqI1KMnt/90hrJnfxsTM1wFPIH6K2DokZeGiCVg/dvE8E0Me74Nh5iM
         dbFGcdchIP8ofXTiJzMSjjyRUtytA6zKAfqrlYHowMEMaDu0Zl2DRDt7e8jNODHHpTNl
         h4VBbBDAgn/z3Oh+HNgUdoFnVRIS7UoJILjffB67LUq0zm+R7oldfiGVKV9JSGGy++uO
         Z2rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780530509; x=1781135309;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=T90oynylW7AQk2MgYZP57oghSUfaSB8gw/FQu/tdAng=;
        b=TF5WSfGQa5ziXUPL/CFfkye3ILhzY8qudlzHLQa7OMw/+wLXaSMYKDl5UFVYOFUPxs
         +cY8LuY8u74TAKzBp2XeL7u0IMTF231QYdV/tcySOCu1ztA4WRII7qFa1YUn8mV/DcT0
         9W5981gOLwxDfQJWRZyqbxfuiFC68tpZx+lpMQ7K5pc/Jk01gwtF3E+MiHogY8C3a2Nf
         cZ+jhXdhJgNl0tPOCDJhSSVIFkSbq3sJhkfMrQRE6f8EL5zPNW1X8Q0YVO0bi974d2vd
         XgS1E+vwwnM0nYN4FR3A8IoqJpWmnVHbzzRGKaXNVDka97haWfMJEXf2o9hojtEGjF8/
         Fkqg==
X-Forwarded-Encrypted: i=1; AFNElJ8dhfXK4SrielBze0pyzyz6jLT15nw7zVfeRmxuzKiGW/goZdjC05Ae/YYZ2zmbey7Egto=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6ktjRgrKj5qHOBoJaoaJaWKSyEwSzQ34Q5w4JpUw61TgBVrTL
	9qp+mMpEAiq/dfVWFJXCdae1X3dQhr2hOHsVGf3IGgi80M9fLA13Ad/gUTuO1EebrxwAK5xLZXm
	93YZ/aBYPU3aPO7NTcGtyxvAO6zxNHcE=
X-Gm-Gg: Acq92OE35O7uAyY6ywBvueZuYDGMeMMt7DdUPgKhEDYq0UnllFJ68T38T4xw4TmfFXI
	z90fYE0dVvjH7ClfyfR11mRuMNvyKbidK970jyG/bN2aB4KD9Otv83kD4+CBfLD+541uDkBTN2U
	+QUwjfJA25/yVZ4p+zBqjDcK+pjh30vXLxQJQ+6Os2hEnDh5GJfh+IMAoIbBGCrMuULXe73SdSP
	EXoxVMYBeeWotbQ1K+osIkVQHvsaoMnoQJpCVXLTSfhzO96h7XIKSccKytqzZEBuJIJq7Rz7N0K
	IGYqrLDMFUqeZDNIDcselZOvnZOZmbqv0/T4w1Jm1lUvLMXOrEeym/OCkt3EkvH+HU8tpqucr5Q
	=
X-Received: by 2002:a17:907:689c:b0:bf0:2253:ad67 with SMTP id
 a640c23a62f3a-bf0b3ca9707mr195111966b.46.1780530509262; Wed, 03 Jun 2026
 16:48:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260601221805.821394-1-ihor.solodrai@linux.dev> <20260601221805.821394-12-ihor.solodrai@linux.dev>
In-Reply-To: <20260601221805.821394-12-ihor.solodrai@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 3 Jun 2026 16:47:58 -0700
X-Gm-Features: AVHnY4LrNMNdKc8g-Y1siuv0xrZhlenvEq2LHaMzMA9GySUdDudubnJqhAdGsIQ
Message-ID: <CAEf4BzYeKAnQUb3nsxNZ1FEVtare4xrx6sBErCrxncCzKsi4-Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 11/14] resolve_btfids: Process KF_ARENA_*
 flags in resolve_btfids
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Alan Maguire <alan.maguire@oracle.com>, Jiri Olsa <jolsa@kernel.org>, 
	bpf@vger.kernel.org, linux-kbuild@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 1, 2026 at 3:19=E2=80=AFPM Ihor Solodrai <ihor.solodrai@linux.d=
ev> wrote:
>
> For kfuncs flagged KF_ARENA_RET, KF_ARENA_ARG1 or KF_ARENA_ARG2,
> address_space(1) attribute (type tag with kflag=3D1) needs to be emitted
> to BTF for the return type or arg type respectively.
>
> So far this has been done by pahole [1].
>
> Implement the emission of the arena attributes in resolve_btfids: for
> flagged kfuncs create a new function prototype with updated BTF types,
> adding tags as necessary.
>
> Similar to decl tags emission, the transformation is idempotent: if
> the types are already tagged with address_space(1), it's a noop.
>
> [1] https://lore.kernel.org/dwarves/20250228194654.1022535-1-ihor.solodra=
i@linux.dev/
>
> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> ---
>  tools/bpf/resolve_btfids/main.c | 131 ++++++++++++++++++++++++++++++++
>  1 file changed, 131 insertions(+)
>
> diff --git a/tools/bpf/resolve_btfids/main.c b/tools/bpf/resolve_btfids/m=
ain.c
> index f276200b1a68..aafbcfec755b 100644
> --- a/tools/bpf/resolve_btfids/main.c
> +++ b/tools/bpf/resolve_btfids/main.c
> @@ -162,6 +162,9 @@ struct object {
>  };
>
>  #define KF_FASTCALL (1 << 12)
> +#define KF_ARENA_RET (1 << 13)
> +#define KF_ARENA_ARG1 (1 << 14)
> +#define KF_ARENA_ARG2 (1 << 15)
>  #define KF_IMPLICIT_ARGS (1 << 16)
>  #define KF_IMPL_SUFFIX "_impl"
>
> @@ -1294,6 +1297,128 @@ static int ensure_decl_tag(struct btf2btf_context=
 *ctx, const char *tag_name,
>         return push_decl_tag_id(ctx, new_id);
>  }
>
> +static bool is_arena_type_attr(struct btf *btf, u32 id)
> +{
> +       const struct btf_type *t =3D btf__type_by_id(btf, id);
> +       const char *name;
> +
> +       if (!t || !btf_is_type_tag(t) || !btf_kflag(t))

!t can't (shouldn't) happen, let's not check for things that are not
supposed to happen, because we'll start double-guessing what are the
situations where this is valid and whether we deal with that
correctly.

It's kernel build, we can assume valid BTF.

> +               return false;
> +       name =3D btf__name_by_offset(btf, t->name_off);
> +       return name && strcmp(name, "address_space(1)") =3D=3D 0;
> +}
> +
> +static s32 ensure_arena_tagged_ptr(struct btf *btf, u32 ptr_id)
> +{
> +       const struct btf_type *ptr =3D btf__type_by_id(btf, ptr_id);
> +       s32 tag_id;
> +
> +       if (!ptr || !btf_is_ptr(ptr))
> +               return -EINVAL;
> +
> +       if (is_arena_type_attr(btf, ptr->type))
> +               return ptr_id;
> +
> +       tag_id =3D btf__add_type_attr(btf, "address_space(1)", ptr->type)=
;
> +       if (tag_id < 0)
> +               return tag_id;
> +
> +       return btf__add_ptr(btf, tag_id);
> +}
> +
> +/*
> + * Build a FUNC_PROTO for @kfunc with each arena-flagged return/paramete=
r
> + * pointer tagged with address_space(1). Pointers already tagged are kep=
t as is.
> + *
> + * If nothing needs tagging, the original proto id is returned unchanged=
.
> + * Otherwise a new FUNC_PROTO is created and its id returned. The origin=
al
> + * proto may be shared with sibling FUNCs, so it must not be modified in=
 place.
> + */
> +static s32 ensure_arena_tagged_proto(struct btf *btf, struct kfunc *kfun=
c)
> +{
> +       const struct btf_type *func =3D btf__type_by_id(btf, kfunc->btf_i=
d);
> +       u32 proto_id =3D func->type;
> +       const struct btf_type *proto =3D btf__type_by_id(btf, proto_id);
> +       const struct btf_param *params =3D btf_params(proto);
> +       u32 nr_params =3D btf_vlen(proto);
> +       s32 arg0_type_id =3D nr_params > 0 ? (s32)params[0].type : -1;
> +       s32 arg1_type_id =3D nr_params > 1 ? (s32)params[1].type : -1;
> +       s32 ret_type_id =3D proto->type;
> +       s32 new_proto_id, id;
> +       bool changed =3D false;
> +       int err;
> +
> +       if (kfunc->flags & KF_ARENA_RET) {
> +               id =3D ensure_arena_tagged_ptr(btf, ret_type_id);
> +               if (id < 0)
> +                       return id;
> +               changed |=3D id !=3D ret_type_id;
> +               ret_type_id =3D id;
> +       }
> +
> +       if (nr_params > 0 && (kfunc->flags & KF_ARENA_ARG1)) {
> +               id =3D ensure_arena_tagged_ptr(btf, arg0_type_id);
> +               if (id < 0)
> +                       return id;
> +               changed |=3D id !=3D arg0_type_id;
> +               arg0_type_id =3D id;
> +       }

else scream loudly, this is not supposed to happen. we are being too
lax about these violations here

this is a good place to check and emit human-readable errors about
invalid kfunc declarations, so let's do it

and again, let's not do the ensure pattern, add unconditionally, don't
check "changed" (it will), etc

> +
> +       if (nr_params > 1 && (kfunc->flags & KF_ARENA_ARG2)) {
> +               id =3D ensure_arena_tagged_ptr(btf, arg1_type_id);
> +               if (id < 0)
> +                       return id;
> +               changed |=3D id !=3D arg1_type_id;
> +               arg1_type_id =3D id;
> +       }
> +

[...]
