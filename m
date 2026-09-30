Received: from mail-dl2-f43.google.com (mail-dl2-f43.google.com [74.125.229.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 975D0194C96
	for <bpf@vger.kernel.org>; Wed, 30 Sep 2026 00:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790726957; cv=none; b=La+w4sbk60medKPA9wpF3eSsvuf+TF73vjiYQEBhWoZKzhsq0hobVkPBnDRUr9L/9KPkKhWvhcxX7betEZHL45Eh2nqBSL5Ez1DladeDSUzNYPZrgA0gRTyUNrTGaIJkM7mXdO2mQJQqRqvS3bwK6zJT0i4V1l9qcfmpuogAFms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790726957; c=relaxed/simple;
	bh=4heefG//KMTDXCGayL28rzGd+8a0M5K4hg2QWZnZjNw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QSgpt3j80rb5OOYgrYfWwiwggr3MR3di8FHV7CHh1zakPGotWNFBSxaUa9O7G62C/3ZKf1q1gBwcWl/s3RKm4CyNh1Em26C+P/aCX/kHpfo35YtQjwSP5ZdM5YceduJKIkvpx9JBRZVtUyarwIGtfwqCwcyxwt10qN4AU0+aFk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sHW1t9s8; arc=none smtp.client-ip=74.125.229.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sHW1t9s8"
Received: by mail-dl2-f43.google.com with SMTP id a92af1059eb24-145047ad220so1593071c88.3
        for <bpf@vger.kernel.org>; Tue, 29 Sep 2026 17:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790726955; x=1791331755; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=AvsrKHrKUuCKCy2iIOMO57XypEz7wiGmQRnPb68ow84=;
        b=sHW1t9s8SR8dZrhdCz3dtteMIjNDJBM4Gw2nBNWM1I51+ZkUUDQrgw/Pd64Jh8Jshx
         G6UDS7zrHXvpyJS8ad757HqdH1itLF00TNMRtoV+Eqgnh+z7zMWfOHt1wx0MhS/2dRvS
         /z1W4M8k9n+wrKatA5RydpDcbJAd5MlC00vSQ1UmT/iBtIhZfBiRTyG1nkFfO6etBl1g
         usBeWw09QHCV+k5pkrZIYDyHrnxOaKXYIUSM4HI6yRw3NYm8BuSF3WCl9BlF8Fa/K3P1
         MqfSKiAa5FJOro1l26KcbYW8/OqRt+qGS2JlII/b2QRLE38UHFqLwW5U0LMKjVrkuEjA
         GgvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790726955; x=1791331755;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AvsrKHrKUuCKCy2iIOMO57XypEz7wiGmQRnPb68ow84=;
        b=TVuQUDLjhKMiXlzrsdm1mi2KHxWqGv4JGw32Ckk1Jk2kGdA12+vHCGaPOGlgbJHzOr
         89j4m3veo2DaXYoKW9GvUmvIGtrY9aK+/Ed+FbtQKEpQtMI6DzQ+RgadDdWXFnFMQ1yA
         FkpZjSrNWAtAZl8uqGlFAg/bUOJeQ7HPZk/1gUvN34ucp13nOaH3SJ/Mt+tMFcqb6PCQ
         +OTTal4rQcQOYzpuXgEE0AJXodHSAkQU+RujXjEUPLalP7d6X3IpzAQmkYi2MOIL2+kY
         XejtqbnKkI1eu8/i3hodYrfoU9IE17wiptGRHzDjE22Gya6pWaf2eVse0Eef4lI0Xb7r
         MvFw==
X-Forwarded-Encrypted: i=1; AKwUvBzXB4901YJGsb9jc/myGG/9R+Ua0lZs6Ts+BE0qV6E+02tyDHDfcZND/9jmL5je+5SgBg8=@vger.kernel.org
X-Gm-Message-State: AFuF++kadHjFbqlUyIeZc9W18HZjy1Hho/gvn4mP823suuLGCZTCGqqx
	VTWQXxNOtWz3MSJQHOixumin/fjCoASGaLyQcQB7M72Gqg0By7m0kvZC
X-Gm-Gg: AYBFou3Q7HOup1jwL8Dri3m6KiuLBZINyq2wJ4wNugiIc55pcXe1t7xVLeNpR/Yz3SI
	ANNIk7Gh/cv30VTQmCLTEfNxARvxh4hI4zVx6EnXvsaW2H4Eu9/THBtofEFaH2RpkZRrdjQlED3
	wkYH5+JXfCTEWDkilSa4H0JzY4o4aqxDZ7vbGAJEUwitXcdf6J14iCEXBxaFaVyNCPxA7kmghqe
	YkMT/T8424GDsGFpUEYCB/3r/uroxOMjPQ/yR1lSnegt368hHYxwHvdfZ8nin+rELqroOq6amOi
	I+6RAAqxWzvRvVdpnV9/7LFdeDiOe84kNQUF5VKmtQ4Y3U07MS27UThLpG8iMR1gKM50bEO233K
	k/MVRIDRgNWJl78TD1zugBOOVzSoJrpzb9B0NFLasMR1VvaIVHV8jApNE289K871hdG26QqqhVN
	dZ0A6oCwDtyrzQWbZYEyUtOdzIUA6l55CvbevaKAHQ2CCo6mTSUUwqiewMOxfGiN+rUkXeH5+J6
	K2IAp5m9cy7YN/nnDIUUwpESW4oJnt3DWm4Tjxy0QwXcs2gOOvvK+Mc
X-Received: by 2002:a05:7022:296:20b0:14c:be8e:69f5 with SMTP id a92af1059eb24-14cbe8e6b57mr498970c88.15.1790726954285;
        Tue, 29 Sep 2026 17:09:14 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:abbd:bfa5:f574:cca3? ([2620:10d:c090:500::7:dfd3])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14c640bc413sm1948765c88.11.2026.09.29.17.09.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 17:09:13 -0700 (PDT)
Message-ID: <21a8e3dfacb4269e348b10544c43cd05f785737b.camel@gmail.com>
Subject: Re: [PATCH bpf-next 11/36] bpf: add bpf_reg_union()
From: Eduard Zingerman <eddyz87@gmail.com>
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org, ast@kernel.org,
 andrii@kernel.org
Cc: daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com, 
	yonghong.song@linux.dev, memxor@gmail.com, martin.lau@kernel.org,
 mason@kernel.org, 	ihor.solodrai@linux.dev
Date: Tue, 29 Sep 2026 17:09:11 -0700
In-Reply-To: <92725cabd34b462486052bddd62757252de036696d01a7b0b96a6dacc01a8a09@mail.kernel.org>
References: <20260926-scev-minimal-rebase-v1-11-c8e5ab5ba79f@gmail.com>
	 <92725cabd34b462486052bddd62757252de036696d01a7b0b96a6dacc01a8a09@mail.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-2.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2026-09-27 at 20:42 +0000, bot+bpf-ci@kernel.org wrote:
> > diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.=
h
> > index 719b7c7fd2f5..706fdefbc07a 100644
> > --- a/include/linux/bpf_verifier.h
> > +++ b/include/linux/bpf_verifier.h
> > @@ -1748,6 +1748,8 @@ s64 bpf_kfunc_stack_access_bytes(struct bpf_verif=
ier_env *env,
> > =C2=A0int bpf_compute_subprog_arg_access(struct bpf_verifier_env *env);
> > =C2=A0int bpf_set_reg_range(struct bpf_verifier_env *env, struct bpf_re=
g_state *reg,
> > =C2=A0		      struct cnum64 range, u16 step);
> > +int bpf_reg_union(struct bpf_verifier_env *env, struct bpf_reg_state *=
acc,
> > +		  const struct bpf_reg_state *src);
> >
> > =C2=A0int bpf_stack_liveness_init(struct bpf_verifier_env *env);
> > =C2=A0void bpf_stack_liveness_free(struct bpf_verifier_env *env);
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index b5f45cb46f14..1ec44d72a346 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -30,6 +30,7 @@
> > =C2=A0#include <linux/module.h>
> > =C2=A0#include <linux/cpumask.h>
> > =C2=A0#include <linux/cnum.h>
> > +#include <linux/gcd.h>
> > =C2=A0#include <linux/bpf_mem_alloc.h>
> > =C2=A0#include <net/xdp.h>
> > =C2=A0#include <linux/trace_events.h>
>
> [ ... ]
>
> > @@ -16952,6 +16953,33 @@ int bpf_set_reg_range(struct bpf_verifier_env =
*env, struct bpf_reg_state *reg,
> > =C2=A0	return reg_bounds_sanity_check(env, reg, "bpf_set_reg_range");
> > =C2=A0}
> >
> > +/* acc :=3D acc U src, matching types only. Caller must clear acc's sc=
alar ID. */
> > +int bpf_reg_union(struct bpf_verifier_env *env, struct bpf_reg_state *=
acc,
> > +		  const struct bpf_reg_state *src)
> > +{
> > +	u16 base, step;
> > +
> > +	if (acc->type !=3D src->type) {
> > +		verifier_bug(env, "union of registers with different types");
> > +		return -EFAULT;
> > +	}
> > +	acc->r64 =3D cnum64_union(acc->r64, src->r64);
> > +	acc->r32 =3D cnum32_union(acc->r32, src->r32);
> > +	acc->var_off =3D tnum_union(acc->var_off, src->var_off);
>
> Does this function handle pointer registers correctly? When bpf_reg_union=
()
> widens a PTR_TO_PACKET's offset (r64/r32/var_off) but keeps its id, it ca=
n
> break the id-tracking invariant.
>
> For PTR_TO_PACKET, registers with the same id differ only by a known
> constant. When adjust_ptr_min_max_vals() adds a non-constant to a packet
> pointer, it gives it a fresh id:
>
> =C2=A0=C2=A0if (!known)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0dst_reg->id =3D ++env->id_gen;

The example is an utter hallucinated garbage, but the point is valid.
Here is a valid example that should be rejected:

  r7 =3D ctx->data;
  r8 =3D r7
  for (r6 =3D 0; r6 < 10 && random() !=3D 42; r7++, r6++);
  if (r7 >=3D ctx->data_end)
    return;
  // at this point the loop executed unknown number of times
  // hence r7 range gives no information about r8
  *(r8 + 4);

There are several other types in is_widenable_reg_type() to consider.
So far I think that it is necessary to reset the ids for the following
types: SCALAR_VALUE, PTR_TO_PACKET, PTR_TO_PACKET_META

> find_good_pkt_pointers() depends on this rule. After a successful
> 'pkt_ptr > pkt_end' test, it uses reg_umax(dst_reg) as the new range
> and sets reg->range =3D max(reg->range, new_range) on every PTR_TO_PACKET
> with the same id, assuming they all track the same maximum offset.
>
> Once bpf_reg_union() enlarges acc's umax but leaves acc in the same id
> group as registers that were not widened, a comparison on acc can give
> those other registers a range based on the widened umax that nothing at
> runtime backs.
>
> The comment says "Caller must clear acc's scalar ID", but for pointer
> types the id has a different meaning. Later in the series when this is
> called from union_any_reg() (1987b0e52b34), is_widenable_reg_type()
> accepts PTR_TO_PACKET, and scratch_scalar_id() only clears the id when
> reg->type =3D=3D SCALAR_VALUE.
>
> Here's a concrete example with a similar shape to the
> conditional_stack_pointer_assignment selftest at the series end:
>
> =C2=A0=C2=A0r2 =3D *(u32 *)(r1 + 0)   // data: pkt, id=3D0
> =C2=A0=C2=A0r3 =3D *(u32 *)(r1 + 4)   // data_end
> =C2=A0=C2=A0r9 =3D r2                 // pkt, id=3D0, off 0
> =C2=A0=C2=A0r7 =3D r2
> =C2=A0=C2=A0r7 +=3D 1000              // pkt, id=3D0 (constant add keeps =
id)
> =C2=A0=C2=A0r6 =3D 0
> 1: if r6 >=3D 3 goto 3f
> =C2=A0=C2=A0if r2 > r3 goto 3f      // fallthrough: find_good_pkt_pointer=
s(r2)
> =C2=A0=C2=A0r0 =3D *(u8 *)(r9 + 999)
> =C2=A0=C2=A0if r6 !=3D 1 goto 2f
> =C2=A0=C2=A0r2 =3D r7                 // r2 =3D (any r2 r7) at loop entry
> 2: r6 +=3D 1
> =C2=A0=C2=A0goto 1b
> 3: r0 =3D 0
> =C2=A0=C2=A0exit
>
> At loop entry, bpf_reg_union() turns r2 into pkt(id=3D0, [0,1000]), but r=
9
> keeps id=3D0 and [0,0]. On the fallthrough of 'if r2 > r3',
> find_good_pkt_pointers() sets r9->range =3D reg_umax(r2) =3D 1000. The lo=
ad
> from r9 + 999 then passes (0 + 999 + 1 <=3D 1000).
