Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C432DF145
	for <bpf@vger.kernel.org>; Fri, 30 Jan 2026 16:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769788851; cv=pass; b=tvVo2voNCo6EwhpjB+Xk5z0V7C47ks1xiNyiIblE2ViZbctJgkh6to2lx/jMQqFGI6CQLd5eOMwpR7GusWtCkIrXuJ5L8hCIWWtBmCWcSYo+pVTQpB8TOU4UN8xFGby91xuzG5wTPY7G+MmXfYYaGRqc/Tsh4Yunwg1gelPQEt0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769788851; c=relaxed/simple;
	bh=uxDqFTw3CNfXb7zKzemHuJLb+bCMbaWedd24lFCRvDA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=suNxgSh7POKyzTe1y0/dvsoTswLZjZbJ6+Ft39JqwRsxz6NBCnhRfRFJ/8wwc7Vzq2or4ar+fyE/qQb7OBpYQGqOL0OWAQq8NURKoM/Ec3Jm/1GOJjtysbkPs2cQVdk+8t2Y9RXtmLDOZuX7a09d2XmTN4HCGwBknfpJ2NaRib0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TXCL50mx; arc=pass smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TXCL50mx"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-47ee76e8656so30167105e9.0
        for <bpf@vger.kernel.org>; Fri, 30 Jan 2026 08:00:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769788849; cv=none;
        d=google.com; s=arc-20240605;
        b=WxJWe1v6YwxxLttYgJC0jn0CpHaI3Oey/KckNsNORLiHtKLqZE7Og/dBZaTFAXkQzq
         yUjI00uoM9zIIv80LtUz8022BcAIIPfDT8SdY6qg0Ws3yENR/bxdEz4hqkNu6QA8Gcul
         TO2X+2l4qhp5R8EoSyzOhlwyO6eI4cb/TKh0FWkcENcwa4ThPn9lUhy6FoQzUY9xiKkb
         zVcMzhh6jTGqEQYAB9GbQm5EYEkaE1aEJ+9O7HNwxyzobax9jm+J+teQ6XG4Zyjz9GDl
         xD9j2eh/c51WgSTNYRtXk2LE391LnI0klKLBxfjf/Gyy6m8ymfUSN1eWpRU/Q/NOwnVY
         aZnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jM48KExwAgQyvFI+thepUy+CLUaSYyap+Ycxsi37HFo=;
        fh=jLZez/p2RqZbblnlrNX5rcAhN5k3kwof5aditAh/XRQ=;
        b=NE649y/woYn+gfjbbbTnenvC1GT7nU4LKhD9lkTJJ1UIhfPz0QkYxp8Y9KDkYUtlWV
         v8pZcZaKaJ5w7+CJs1j69Duma4suiPTfMLU1OD4RghYzeYsn1mpaGhpXwVjSS+dRYzRW
         0QdQhCarYHKcqtuRw0IdeOmatOldPuU5OtSqpQ/ddKBM/RzcczIMJj8o5sDitD5Fe2yE
         q0rmBt2T02gfxQPOfjCqZiMqkA3t/nH3QXcaBgfd2xbQZeWZcbzXi1DMSel2L4z/wfL+
         VTK5jAJe0TQY7Ne92uTGJ9C1KDK2OpKk52xgj+Z0e20xwnIjkuZr9VPDy/PlFcf4vckM
         CeOA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769788849; x=1770393649; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jM48KExwAgQyvFI+thepUy+CLUaSYyap+Ycxsi37HFo=;
        b=TXCL50mxYrRE7XiUmEFn9VgykeKFeT9UgWSt1l6t6zmzRbgigpGZKJgSLu0vrlUD0y
         OLfZwPxd3iYT0MesMmdxzxxg/vvQ0XtXj0r+Rc/LFXXw0atMpLLSjJcF0bLWvSw6PEtp
         TC7T62YnzqVZqF/1P0R+LP1llLKWem6PPBw+amj/ehtVbcAfnnuNEbG/1BLfpQXwH3oh
         P7JVYwRei/j/ojiJJpNehzjSqjNWfhOnqmPzyK3I6XQauKnIQe6P0tnka2KzfNUy2pIr
         bugtVqrU9CeaJN1Z9lqbp/NieMMPRMKyM7fN3BREF+jlwlnqDIWzTtvSqR+Ioo6J/2R0
         9NWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769788849; x=1770393649;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jM48KExwAgQyvFI+thepUy+CLUaSYyap+Ycxsi37HFo=;
        b=X76cDIfSFCclNTHb4DozcM8kiZkhw1S9CE4dz6e5vqfjOhbyaHwNK+ueAjz+umOhTq
         oX71HEjRuOFbYrCyYf7RdB20Nw1W25I9E2Pzso0xX/GnOcSPnU2u/V9QffkZRQP2xHHn
         ZEziX2bKg4BdIdMZCF2yDW46DkjmBjGH4+ksmawfIRqUxf6jTE1FPiPvBeE2iYWuefpW
         3mtt/StPLo4fNh3gyOa8gwYEcxzNVon75SbyX76gQ7sHg3BL1qae5tNlQ4lb0W04XRnc
         723BeRvo7WKWDF9eltJZYp5J1pFfWzUPCIg8cU8CmkrkpyHBa25wRUYZSSm6y5NSzVVu
         LFzA==
X-Forwarded-Encrypted: i=1; AJvYcCXRBylOAT9RbO2usqWHH7zH2Lmj44M+bH7FYZOyqSwUdPWn8QDZgC9eNttmhuge2CRvQmk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxX0SdOx2RMkvu2PMW1zDDGVyA0bVn7Z5PvuuGOOTYEHvjsbjlO
	MYa6uoYOZxR/w9KTGlfI8Veu9/Q0616lrji4xsKQpJauv0XIhccHOeJNdh1nWkUQTG0NB3Dpy2c
	HZw+3g8XrNXpUH6P2jE7H0OEmBfmSI4E=
X-Gm-Gg: AZuq6aI/3RT9LR5CzotmXeNIzDE3LHrVa0QAX9wt9wk50kJyVfWOwYf7lVkMz6D9bES
	acFJN8wpHRUperIHLmv0JZqaB/5ugzC93+3q/n+md+JMetP4Xm/tgpNc0qDeyt8UVRZZoFsrE4X
	ajzCBkgh0h24zqX1FTM4JLu8af3JmNm+9mBfjLvTuUllR+FgEqtPiDIjVmXRSNlXZf55N9AxTq4
	/YgiD38FMtf3uhnep4yVLt11xt03vAFLdszk7OGgOC7cubmBiSb+fSPqXxeFeEHRx1QCOjB4537
	HCEtmBlkjrI1tJSXxnHF/9e3rxUX9C38H4Qnme6PkLrW6jTAEk0QI11M/yPZWM7WzImeFEE4Vqv
	BnmlAxsFE3OR4X2uf0nz2o4yn
X-Received: by 2002:a05:6000:4205:b0:435:e451:39d4 with SMTP id
 ffacd0b85a97d-435f3aac921mr4690428f8f.44.1769788848377; Fri, 30 Jan 2026
 08:00:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260129-verif_special_fields-v1-0-d310b7f146c8@meta.com>
 <20260129-verif_special_fields-v1-1-d310b7f146c8@meta.com>
 <CAMB2axOYwGFzB3eO8=pmAhF6qPJrZpgLEO-qWMUdTZcM4L+08g@mail.gmail.com> <8de50202-a580-4d6d-b4e1-9d7c2bbfb841@gmail.com>
In-Reply-To: <8de50202-a580-4d6d-b4e1-9d7c2bbfb841@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 30 Jan 2026 08:00:37 -0800
X-Gm-Features: AZwV_Qi_0BvsmscSHmJ4BFQp0QnK8mTy_ffkYLPv8lj7DXHDbS5q3icFvT9ajrk
Message-ID: <CAADnVQL7avWvsJ9CDYm=wEHNa6+=Us4pMdRa2y5+Wa1Dzg30rQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: Introduce struct bpf_map_desc in verifier
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: Amery Hung <ameryhung@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin Lau <kafai@meta.com>, 
	Kernel Team <kernel-team@meta.com>, Eduard <eddyz87@gmail.com>, 
	Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 30, 2026 at 7:46=E2=80=AFAM Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
> On 1/29/26 18:09, Amery Hung wrote:
> > On Thu, Jan 29, 2026 at 9:38=E2=80=AFAM Mykyta Yatsenko
> > <mykyta.yatsenko5@gmail.com> wrote:
> >> From: Mykyta Yatsenko <yatsenko@meta.com>
> >>
> >> Introduce struct bpf_map_desc to hold bpf_map pointer and map uid. Use
> >> this struct in both bpf_call_arg_meta and bpf_kfunc_call_arg_meta
> >> instead of having different representations:
> >>   - bpf_call_arg_meta had separate map_ptr and map_uid fields
> >>   - bpf_kfunc_call_arg_meta had an anonymous inline struct
> >>
> >> This unifies the map fields layout across both metadata structures,
> >> making the code more consistent and preparing for further refactoring =
of
> >> map field pointer validation.
> >>
> >> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> >> ---
> >>   kernel/bpf/verifier.c | 79 ++++++++++++++++++++++++++---------------=
----------
> >>   1 file changed, 40 insertions(+), 39 deletions(-)
> >>
> >> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> >> index c2f2650db9fdf71737eecd56febbe3cbf8fe42b4..2c5fb7be73923b9f8395a6=
fae53209f002c48fd1 100644
> >> --- a/kernel/bpf/verifier.c
> >> +++ b/kernel/bpf/verifier.c
> >> @@ -272,8 +272,13 @@ static bool bpf_pseudo_kfunc_call(const struct bp=
f_insn *insn)
> >>                 insn->src_reg =3D=3D BPF_PSEUDO_KFUNC_CALL;
> >>   }
> >>
> >> +struct bpf_map_desc {
> >> +       struct bpf_map *ptr;
> >> +       int uid;
> >> +};
> >> +
> >>   struct bpf_call_arg_meta {
> >> -       struct bpf_map *map_ptr;
> >> +       struct bpf_map_desc map;
> >>          bool raw_mode;
> >>          bool pkt_access;
> >>          u8 release_regno;
> >> @@ -283,7 +288,6 @@ struct bpf_call_arg_meta {
> >>          u64 msize_max_value;
> >>          int ref_obj_id;
> >>          int dynptr_id;
> >> -       int map_uid;
> >>          int func_id;
> >>          struct btf *btf;
> >>          u32 btf_id;
> >> @@ -351,10 +355,7 @@ struct bpf_kfunc_call_arg_meta {
> >>                  u8 spi;
> >>                  u8 frameno;
> >>          } iter;
> >> -       struct {
> >> -               struct bpf_map *ptr;
> >> -               int uid;
> >> -       } map;
> >> +       struct bpf_map_desc map;
> >>          u64 mem_size;
> >>   };
> >>
> >> @@ -8666,7 +8667,7 @@ static int process_timer_func(struct bpf_verifie=
r_env *env, int regno,
> >>          if (err)
> >>                  return err;
> >>
> >> -       if (meta->map_ptr) {
> >> +       if (meta->map.ptr) {
> >>                  verifier_bug(env, "Two map pointers in a timer helper=
");
> >>                  return -EFAULT;
> >>          }
> >> @@ -8674,8 +8675,8 @@ static int process_timer_func(struct bpf_verifie=
r_env *env, int regno,
> >>                  verbose(env, "bpf_timer cannot be used for PREEMPT_RT=
.\n");
> >>                  return -EOPNOTSUPP;
> >>          }
> >> -       meta->map_uid =3D reg->map_uid;
> >> -       meta->map_ptr =3D map;
> >> +       meta->map.uid =3D reg->map_uid;
> >> +       meta->map.ptr =3D map;
> >>          return 0;
> >>   }
> >>
> >> @@ -8739,7 +8740,7 @@ static int process_kptr_func(struct bpf_verifier=
_env *env, int regno,
> >>                          return -EINVAL;
> >>                  }
> >>                  rec =3D map_ptr->record;
> >> -               meta->map_ptr =3D map_ptr;
> >> +               meta->map.ptr =3D map_ptr;
> >>          }
> >>
> >>          if (!tnum_is_const(reg->var_off)) {
> >> @@ -9246,13 +9247,13 @@ static int resolve_map_arg_type(struct bpf_ver=
ifier_env *env,
> >>                                   const struct bpf_call_arg_meta *meta=
,
> >>                                   enum bpf_arg_type *arg_type)
> >>   {
> >> -       if (!meta->map_ptr) {
> >> +       if (!meta->map.ptr) {
> >>                  /* kernel subsystem misconfigured verifier */
> >>                  verifier_bug(env, "invalid map_ptr to access map->typ=
e");
> >>                  return -EFAULT;
> >>          }
> >>
> >> -       switch (meta->map_ptr->map_type) {
> >> +       switch (meta->map.ptr->map_type) {
> >>          case BPF_MAP_TYPE_SOCKMAP:
> >>          case BPF_MAP_TYPE_SOCKHASH:
> >>                  if (*arg_type =3D=3D ARG_PTR_TO_MAP_VALUE) {
> >> @@ -9906,7 +9907,7 @@ static int check_func_arg(struct bpf_verifier_en=
v *env, u32 arg,
> >>          switch (base_type(arg_type)) {
> >>          case ARG_CONST_MAP_PTR:
> >>                  /* bpf_map_xxx(map_ptr) call: remember that map_ptr *=
/
> >> -               if (meta->map_ptr) {
> >> +               if (meta->map.ptr) {
> >>                          /* Use map_uid (which is unique id of inner m=
ap) to reject:
> >>                           * inner_map1 =3D bpf_map_lookup_elem(outer_m=
ap, key1)
> >>                           * inner_map2 =3D bpf_map_lookup_elem(outer_m=
ap, key2)
> >> @@ -9919,23 +9920,23 @@ static int check_func_arg(struct bpf_verifier_=
env *env, u32 arg,
> >>                           *
> >>                           * Comparing map_ptr is enough to distinguish=
 normal and outer maps.
> >>                           */
> >> -                       if (meta->map_ptr !=3D reg->map_ptr ||
> >> -                           meta->map_uid !=3D reg->map_uid) {
> >> +                       if (meta->map.ptr !=3D reg->map_ptr ||
> >> +                           meta->map.uid !=3D reg->map_uid) {
> >>                                  verbose(env,
> >>                                          "timer pointer in R1 map_uid=
=3D%d doesn't match map pointer in R2 map_uid=3D%d\n",
> >> -                                       meta->map_uid, reg->map_uid);
> >> +                                       meta->map.uid, reg->map_uid);
> >>                                  return -EINVAL;
> >>                          }
> >>                  }
> >> -               meta->map_ptr =3D reg->map_ptr;
> >> -               meta->map_uid =3D reg->map_uid;
> >> +               meta->map.ptr =3D reg->map_ptr;
> >> +               meta->map.uid =3D reg->map_uid;
> > I was also working on this part when unifying bpf_call_arg_meta and
> > bpf_kfunc_call_arg_meta. The check and setting bpf_map_desc is almost
> > the same for kfunc and helper. Maybe extract this part out as a
> > function?
> Not sure if extracting to the function worth it, with this refactoring,
> we're left with just 2 places where we do this copy, and now we can write=
 it
> as a single line:
> meta->map =3D (struct bpf_map_desc){.ptr =3D reg->map_ptr, .uid =3D reg->=
map_uid};
>
> Or maybe we can use struct bpf_map_desc in struct bpf_reg_state, so
> assignment just works?

Let's not go too far with this.
Pls resend these 2 patches with sob and acks.
And then decide on any follow up while looking at future patches.
