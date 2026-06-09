Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 838643CFF79
	for <bpf@vger.kernel.org>; Tue,  9 Jun 2026 06:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780986041; cv=none; b=lwBs2+r5S83cfewYSJDRfFSlDKcx791fQ9e027xdiTMR0r/g0Y9Mkot7Bjs0P10O7+koO2zv/h1vGHdbYcWa/cyyDcanWEHB9llezk0SaSFarJGNCWIZeYeVEomcJP6zCx74XlR+YufGbURMcGZNRxFo3rtiW+0ZunlA5VcY+rQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780986041; c=relaxed/simple;
	bh=59BYnUJvAIePb2VZBI/fz1ozbVQZ7Vi0JTONFFwKaf8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CSlbEp6+8ShkKNoTEaBAp3lqOH2t7ooPZSYseJFCouonWXw0zVxWrnVfMuY4I+i9R55/qSvxYAgRuE+Fg6JsTacsAFCAEs17B+mAutcb55Ha0xCaXqboefjA8EByW8lf6RsDZR708M6ECzQJL8UF6+sERN+1inmyVVN/YdzoAdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K7x1V3/h; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K7x1V3/h"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-36da8439078so4561341a91.2
        for <bpf@vger.kernel.org>; Mon, 08 Jun 2026 23:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780986040; x=1781590840; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ygTYj/KNafIzaOesNpmK0Q14mDJk1wjTmzJnvwA/XPg=;
        b=K7x1V3/hT3tZoa4A5lj+p/TUmtPEDkeo2ZiFdab5mScFvk/HYOJ7h7Gg5UQKiyHHeo
         RjSbijiWdWL5y0T0JEvD6JyNE9Q3h3H8FG3PwskOMa7V4DnYGHeb4BNdQheel+RPIadW
         WltyfD530q4u1eKifrYR8DPhGZR7FHNgnOrbJXDMkhKXE9AyWhm7N3RtxBrTAsmgSsMm
         qtq0bnfCo3zrIMbWaOSyfjT1S0+bfX/JFp9i/0meP01EgByEGL850usa9nJrivZLQnvR
         Rg4w/xMsvZEOZmmucV2cBBGQS5sprCPTusoW7hq2KYLP0UDn5FUTbgor5UjZ8r2m+rj9
         dd4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780986040; x=1781590840;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ygTYj/KNafIzaOesNpmK0Q14mDJk1wjTmzJnvwA/XPg=;
        b=iTDiISavyQW0aLf6U9JsIGhliuvggoTDFS7BRvNXswJqcPBqwcvVL47s68kDKCXsyA
         28LD9ZPFtj5czT9BovOjEdZlXD+xv3I1R7zLoZ1t/EW5z02Tg3KZuKbD9CqKXB+bwrAb
         OgqjciOxcf9jT4FfqIZGPwq2+4wFMnFNwM2PXjsPqdRe+ktdxpQg2LXls0w0Nw13W438
         JY5+exM2VNttVy0++0oqoWXGJp9fEOyq9P8NhcgY46AHmUpeCCfOqwG/A06V/6VlkPCI
         G8FxO0FddCKB+TlxFPlqO4Fus/MkACY5jUD5FlBNPTR1oeFU4we1OLjGEbDf6W9ayU+e
         chcA==
X-Forwarded-Encrypted: i=1; AFNElJ81Bt8Y0CtNuSnvG8RTSAuyXQHZGSgeG6lcFjVzz4MXZbB8jyl1YYnXQKQprDmSdivgQZg=@vger.kernel.org
X-Gm-Message-State: AOJu0YznBGNgVlnAvjtGfJ9lteE1/xxovmt+CqnY4sHdHKWG3PKIAT4w
	bPLSPx+hjjzSwMvW+v2OjzgmGOcGA+jpeic1MUTHfT7n0fPUJpKV3BFb
X-Gm-Gg: Acq92OGOspHiMshKA8VFvLb2gB9owy67FKn2ukaf5BRJ/8fnGNCJvoS2YxdD6WEc4vy
	cwqJdegCeYmJH0m06sME75W7ka8xYkq9Yrg8ZRXXJtkdPkI3gNc890L9BUxrFHZuIHG2b8xENBk
	IzIGNwkWVPXA3VbPy8INjvNj6DgWwso1lv+G9KvKJxvlcrrQLOB83HXNm/kt3UijWEJIYHSWZeC
	GHOyGE+Z5Ssrx3UUz0vPKU4cOobQUKXzwFRGYpSSGCyuJZldSbQWk32cm4APUjLOOhmYx8ks5Ps
	fYlydJSh6S4MQXV3qIdec6heT6ODo8nBghCs4ZhzCdp2PUJHfN5XenuBWzVRDBIMvFB6whKPTtM
	K+nUijXgK6XyrgHhVhOMad16hFlB11AGFddKZF97aSOjVmDnDrB8UwP6makWjsk0cZ84kRy1Wqi
	brXz/v6OZR/XfZaOL/MWFrWYgQZ2ZjfRvCwS0eBQw/wEIjB2wU7JGN/jVa81hl0A==
X-Received: by 2002:a17:90b:1d89:b0:368:ea0c:1b75 with SMTP id 98e67ed59e1d1-370ee82fe25mr19783866a91.6.1780986039807;
        Mon, 08 Jun 2026 23:20:39 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3712ef0add7sm12079255a91.0.2026.06.08.23.20.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 23:20:39 -0700 (PDT)
Message-ID: <0d63a8d68bf0778d6e931ed27892a5bcb151295d.camel@gmail.com>
Subject: Re: [PATCH bpf v5 1/2] bpf: Fix kfunc implicit arg inject type
 detection to prevent invalid pointer deref
From: Eduard Zingerman <eddyz87@gmail.com>
To: Ihor Solodrai <ihor.solodrai@linux.dev>, chenyuan_fl@163.com
Cc: andrii@kernel.org, ast@kernel.org, bot+bpf-ci@kernel.org,
 bpf@vger.kernel.org, 	chenyuan@kylinos.cn, clm@meta.com,
 daniel@iogearbox.net, jolsa@kernel.org, 	linux-kernel@vger.kernel.org,
 martin.lau@kernel.org, martin.lau@linux.dev, 	memxor@gmail.com,
 song@kernel.org, yonghong.song@linux.dev
Date: Mon, 08 Jun 2026 23:20:36 -0700
In-Reply-To: <118b0bc7-5126-465d-993c-3b25e331e2cf@linux.dev>
References: <20260602093836.2632714-1-chenyuan_fl@163.com>
	 <20260608142618.3064380-1-chenyuan_fl@163.com>
	 <20260608142618.3064380-2-chenyuan_fl@163.com>
	 <eab4e479-2023-49b8-9915-1c8ef2356837@linux.dev>
	 <49c36dc0f52bd05d0f8c055e3d3e96992ae716a6.camel@gmail.com>
	 <118b0bc7-5126-465d-993c-3b25e331e2cf@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-9 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2026-06-08 at 18:18 -0700, Ihor Solodrai wrote:

[...]

> > > > @@ -11885,9 +11885,27 @@ static int check_kfunc_args(struct bpf_ver=
ifier_env *env, struct bpf_kfunc_call_
> > > > =C2=A0			continue;
> > > > =C2=A0		}
> > > > =C2=A0
> > > > -		if (is_kfunc_arg_ignore(btf, &args[i]) || is_kfunc_arg_implicit(=
meta, i))
> > > > +		if (is_kfunc_arg_ignore(btf, &args[i]))
> > > > =C2=A0			continue;
> > > > =C2=A0
> > > > +		if (is_kfunc_arg_implicit(meta, i)) {
> > > > +			/* kfuncs with implicit args (e.g. 'off' parameter)
> > > > +			 * handled during verification in bpf_fixup_kfunc_call():
> > > > +			 * obj_new, percpu_obj_new, obj_drop, percpu_obj_drop,
> > > > +			 * refcount_acquire, list_push, rbtree_add. Don't flag them. */
> > > > +			if (is_bpf_obj_new_kfunc(meta->func_id) ||
> > > > +			=C2=A0=C2=A0=C2=A0 is_bpf_percpu_obj_new_kfunc(meta->func_id) |=
|
> > > > +			=C2=A0=C2=A0=C2=A0 is_bpf_obj_drop_kfunc(meta->func_id) ||
> > > > +			=C2=A0=C2=A0=C2=A0 is_bpf_percpu_obj_drop_kfunc(meta->func_id) =
||
> > > > +			=C2=A0=C2=A0=C2=A0 is_bpf_refcount_acquire_kfunc(meta->func_id)=
 ||
> > > > +			=C2=A0=C2=A0=C2=A0 is_bpf_list_push_kfunc(meta->func_id) ||
> > > > +			=C2=A0=C2=A0=C2=A0 is_bpf_rbtree_add_kfunc(meta->func_id))
> > >=20
> > > Is the goal here to have a nice error message?
> > >=20
> > > I think this will fail for other functions like bpf_wq_set_callback()=
.
> > > For a proper check, the list must include every single kfunc with KF_=
IMPLICIT_ARGS, no?
> > >=20
> > > If we go this route, then the list of flagged kfuncs can be collected=
 automatically.
> > > I'm not sure we actually want to do this.
> >=20
> > The calls to functions with implicit arguments are patched by
> > bpf_fixup_kfunc_call(). As far as I understand, this function:
> > - handles functions with implicit bpf_prog_aux generically
> > - handles the functions listed above on a case-by-case basis.
> >=20
> > The goal is not to have a nice error message, but to prevent runtime
> > from reading garbage from a register.
>=20
> In check_kfunc_args() we only needed to know whether the arg is implicit,
> independent of its type, which is_kfunc_arg_implicit() already does. To s=
kip it.
>=20
> For vmlinux kernel kfuncs this should be enough, I think.
>=20
> To properly harden against reading garbage for a *module* kfunc, I think =
the=20
> verifier would have to check for the specific BTF type, e.g. "are we patc=
hing a=20
> struct bpf_prog_aux pointer?".

The only way for a module kfunc can have implicit args is to have
bpf_prog_aux parameter and an implicit args flag.
There are no module-specific callbacks to do custom implicit args patching.

The actual arguments patching is done by verifier.c:bpf_fixup_kfunc_call().
It has the following structure:

  int bpf_fixup_kfunc_call(...)
  {
	...

	if (is_bpf_obj_new_kfunc(desc->func_id) || is_bpf_percpu_obj_new_kfunc(des=
c->func_id)) {
		... patch args ...
	} else if (is_bpf_obj_drop_kfunc(desc->func_id) ||
		   is_bpf_percpu_obj_drop_kfunc(desc->func_id) ||
		   is_bpf_refcount_acquire_kfunc(desc->func_id)) {
		... patch args ...
	} else if (is_bpf_list_push_kfunc(desc->func_id) ||
		   is_bpf_rbtree_add_kfunc(desc->func_id)) {
                ... patch args ...
	} else if (desc->func_id =3D=3D special_kfunc_list[KF_bpf_cast_to_kern_ctx=
] ||
		   desc->func_id =3D=3D special_kfunc_list[KF_bpf_rdonly_cast]) {
		...
	} else if (desc->func_id =3D=3D special_kfunc_list[KF_bpf_session_is_retur=
n] && ...) {
		...
	} else if (desc->func_id =3D=3D special_kfunc_list[KF_bpf_session_cookie] =
&& ...) {
		...
	}

	if (env->insn_aux_data[insn_idx].arg_prog) {
		u32 regno =3D env->insn_aux_data[insn_idx].arg_prog;
                ... patch bpf_prog_aux arg in `regno` ...
	}
	return 0;
  }
 =20
Also consider how check_kfunc_args() looks w/o this patch:

  static int check_kfunc_args(...)
  {
	...
	for (i =3D 0; i < nargs; i++) {
		...
		if (is_kfunc_arg_prog_aux(btf, &args[i])) {
			... set env->insn_aux_data[insn_idx].arg_prog ...
		}
		if (is_kfunc_arg_ignore(btf, &args[i]) || is_kfunc_arg_implicit(meta, i))
			continue;
		...
	}
	return 0;
  }

The `is_kfunc_arg_prog_aux(btf, &args[i])` might return false in case of bo=
gus BTF.
In such a case `insn_aux_data[insn_idx].arg_prog` won't be set and no patch=
ing
would happen in check_kfunc_args(). The kfunc call would remain and the kfu=
nc would
read whatever happens to be in the should-have-been patched register.

So this patch modifies check_kfunc_args() to error out if function is
marked with implicit args flag, but neither of known good implicit
args cases is present.

> It could be done immediately before patching, but at that point the verif=
ication is
> complete, right?..

Actually, yes. The following should be a legit fix as well (I think):

  diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
  index b27352d72b4f..6d6f4ccf2021 100644
  --- a/include/linux/bpf_verifier.h
  +++ b/include/linux/bpf_verifier.h
  @@ -1606,6 +1606,7 @@ enum bpf_reg_arg_type {
   struct bpf_kfunc_desc {
          struct btf_func_model func_model;
          u32 func_id;
  +       u32 flags;
          s32 imm;
          u16 offset;
          unsigned long addr;
  diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
  index 02239c56801b..6e5f5a14a29c 100644
  --- a/kernel/bpf/verifier.c
  +++ b/kernel/bpf/verifier.c
  @@ -2752,6 +2752,7 @@ int bpf_add_kfunc_call(struct bpf_verifier_env *env=
, u32 func_id, u16 offset)
  =20
          desc =3D &tab->descs[tab->nr_descs++];
          desc->func_id =3D func_id;
  +       desc->flags =3D kfunc.flags ? *kfunc.flags : 0;
          desc->offset =3D offset;
          desc->addr =3D addr;
          desc->func_model =3D func_model;
  @@ -19753,9 +19754,7 @@ int bpf_fixup_kfunc_call(struct bpf_verifier_env =
*env, struct bpf_insn *insn,
                  insn_buf[4] =3D BPF_ALU64_REG(BPF_SUB, BPF_REG_0, BPF_REG=
_1);
                  insn_buf[5] =3D BPF_ALU64_IMM(BPF_NEG, BPF_REG_0, 0);
                  *cnt =3D 6;
  -       }
  -
  -       if (env->insn_aux_data[insn_idx].arg_prog) {
  +       } else if (env->insn_aux_data[insn_idx].arg_prog) {
                  u32 regno =3D env->insn_aux_data[insn_idx].arg_prog;
                  struct bpf_insn ld_addrs[2] =3D { BPF_LD_IMM64(regno, (lo=
ng)env->prog->aux) };
                  int idx =3D *cnt;
  @@ -19764,6 +19763,10 @@ int bpf_fixup_kfunc_call(struct bpf_verifier_env=
 *env, struct bpf_insn *insn,
                  insn_buf[idx++] =3D ld_addrs[1];
                  insn_buf[idx++] =3D *insn;
                  *cnt =3D idx;
  +       } else if (desc->flags & KF_IMPLICIT_ARGS) {
  +               verbose(env, "don't know how to patch kfunc call at instr=
uction %d, possible BTF mismatch, kfunc is marked with KF_IMPLICIT_ARGS\n",
  +                       insn_idx);
  +               return -EFAULT;
          }
          return 0;
   }

> Other than that we'd have to somehow pass through from check_kfunc_args()=
 to
> bpf_fixup_kfunc_call() information like "arg 1 of this kfunc can be patch=
ed to prog_aux" etc.
> We sort of do that already with the meta->arg_prog =3D true
>=20
> In a module one can define arbitrary kfuncs and add KF_IMPLICIT_ARGS to t=
hem, so
> proper hardening needs to be generic.
>=20
> I think this boils down to whether we want to error-check module kfuncs o=
r not.
> Not sure what the verifier strategy is here, but my understanding is that=
 in general
> a custom module can easily make kernel read garbage, and it's not a kerne=
l's problem.
