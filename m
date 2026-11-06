Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.172
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793924713;
	b=gG3AVburihIBF31X8Yv8BmzuLxQvzXjQQP/G/jYJgmpSRJtFR0VQqGPytHJeppD0saPo
	 v9Ftd5BmOQXmTx5oLtjCXPy1S0t1OI/dwCCm1OIm8IUm80QPOr7QKLxvvt1fp1ic8ejkv
	 Cs93gKl0cf+P2h3lFFAdbcw+FECVMXEaFoEu02ARqVqsshKYEwtEkFOMIkmTPdU7Ehw2V
	 Tf13N4JOrMn+OHVi7R5E5oILDlN6iJX+SyBYhbbV5AqtFEjJt/aBed4zSXmCBZmyOwaSz
	 x7p+GrJl71MYvpwRNV0jsfCSIcjpVYutPkZda8EN3hSIYW2ZrbPs9dB6vA4FOKKEJZA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793924713;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=8ITPP4wVDVZVblz9hvw3bPYTvEJJ9kVGLO+kx7FbnFw=;
	b=hNSXGpNO1fhpTIJLKnXBohtG/X0EgpOF/p1BF/B8wNeGEvuZ/8euf40+NMvENrZcKEmD
	 FFH/Vy6VMuHWO/c1p2BO9AMZ53z0AdPj+M8eKTmZBQe+rWwBm+rdyEPipGDw3UzzVRZN8
	 Gw8UaFY8lvxKIyTy+ZgvMyubcngOzwIQ3aGK1uPYahoUZUOGGqXEcQ2rN5fg2pLcmutDr
	 PLaQ+Yo25sNa3RgteEcOutw+fHIJrGs1d6KcKCor1VQ10NGVAPS6rqez+zmG40n9BYnBG
	 ahldAjhQNm4vKHFlrZdyAQ2giSWAbs6e4jiFWKTbRJrRfS5bEmKi8Az5OT/4FZavUMQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fKVFC84J;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.172
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B0F6606A31B
	for <bpf@vger.kernel.org>; Fri,  6 Nov 2026 00:25:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9B0F6606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fKVFC84J
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2e977109392so463095ad.0
        for <bpf@vger.kernel.org>; Thu, 05 Nov 2026 16:25:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793924712; cv=none;
        d=google.com; s=arc-20260327;
        b=gAHBxPmjR8GXXRP2D2HWhk4nrfOIBp62apRnNx9aTzdYA2J3AAN66YLwP2DX/AoaAG
         cNqRoazeOtyTrGvNrjEXt909YxH/kDqD2culFUIC87QMfFMvDijiTEb2L7JhKY5rHYZ/
         7498Q+53bZ8bx6QlcgGe9zaE9Zn0H3PuSrBLs8PZ39osf+ZCgaQ2Ahb+sVJi0B+3AjYP
         gVz9uLvkzHRRvLOpFegvNEbvahV9El7M7Erho/0D299vRmTGRTEZoIkY6uYTd22eXj1N
         /rLKOlxbw7TBrGdVK4TpuM/2o4gDD6tTvRec69sb7RFicq7bkcFlxVzRZm0rtCvFyCZS
         3suQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8ITPP4wVDVZVblz9hvw3bPYTvEJJ9kVGLO+kx7FbnFw=;
        fh=Adjpv/xo1HChs9j22A0OEswJiX1NB6XwBl+kEA7EtIg=;
        b=T4GrWCAxxgnKmNf+LzZKWWxEUe8EI+3AQkF8uVGfXCtJ7mnqdAWcCWuWe691IDPRcX
         LMwn7sH6YRImW0JvMstV2YiRebihA3K6pwblHdOIj1H+x4+uZb3erqYkTbfEB1OLWaIJ
         ZrAq50MMwFJhnuk0CSoXqQmkbSjouZAXnhrDrlUJUR+hUCdAVWmKjRkRBpER84jdvdyv
         ZTRkbnlQMu9UW3jE27hw4boSBWhnicRyNn6wu+aMykY7P2FZ1TIRGFOU+RPykhvQ3oXq
         Kl6wzkDJab9/Z8ClI341YM2+8zYDa2le+CpVsZg7MMp7uzapSqQvfaSx2aGdnu9lQbnr
         1rkw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793924712; x=1794529512; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8ITPP4wVDVZVblz9hvw3bPYTvEJJ9kVGLO+kx7FbnFw=;
        b=fKVFC84JnwkRtQVgwYo72JmnXEk0XWrMxB8kACs04DnR47W3tszxFAA5Nd4MGYzNO5
         tdgCHwd0b126mQQFoGClomSJWe61cj9oBvIs4IGP83L+uM6ghQAJDRUODWN3yy1hlmnG
         uMLjCSuy6lKUZqmUTX/lxUJLuXRZqyYyfmIiCQX4dyAybX8/53KY61CSrY7V5h25hby0
         CHoH+ZMD9Ea/5FEgPCVnctoGeUJrxn1UoVbFmHBlImH0xPQsx8anmSQZhAAbOK2Ydy6x
         WisaJu28rZw1b9YrXxlhyex6+XNzZuTNq29PJKm+408722f3H3YBrbBnAnxBls6G04FF
         p9yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793924712; x=1794529512;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8ITPP4wVDVZVblz9hvw3bPYTvEJJ9kVGLO+kx7FbnFw=;
        b=HFnxprX9d6L6bK727yvfOgKNbbOOtxvI7SK0vN1FUqHI7vdcnUauIXUWRiVh2lPa7A
         10ecz5TqpouF/KxARvo/yZNyVIrWbLzIIiI6X6fYdzzv3kMUmhUfhNMC7L3i0/toyZwk
         40wpXo5LX+EcjSzeHIq0byuLhoMjuUQPdnG7bR3xmqlJc/KhDF5p6R+llYfH3kbKIba7
         M3oLW6AjGW2fdXA1BW/mOejIjuFtwaz+96lLX+DZNrb5u+M/zpzk/sj1SyCcoGgiZV6+
         bKTr1i76qwhq+u8uy5kUccZjafE2lZBCiLZMNwwLv2KKyVmBV32wvye7WAIPsgEgRzCs
         ligw==
X-Forwarded-Encrypted: i=1; AKwUvBxsAOLTkBe7x3X63je1y4FzI86ZDVbDHMw/U4+ABlr2cqvhnHrzKJzE2Mdv8EY1IPhsW4Q=@vger.kernel.org
X-Gm-Message-State: APuU4Z/II94/UXzr8h0uy46hwizlhoriV2zyrcWX8vnXWeu7L+YzuiK0
	K+m1NX7+hGgi/bC1YEg9iFYzCggP4frOMrMYn5gjIgc+eJCe5JoB9dmqpOFjgYIYO+7lbVT6UbA
	AZa/4/3/GNixojX1BetBqUXD1ET1jm+8=
X-Gm-Gg: AYBFou3IaZ0bbmBII051wwsA4MQRh4KOMzsBl9Y45GC2bfBZWKNY6p+rtDT6dESW9Cb
	UdgrM7sEMfM7JGu7F6w9C94OeayLESI53w2e/zqfTKGEokWlM29qzkwhag5rfnurCdlYf4Fw3ua
	lYYxsz+b8V8A0ThM+Ynm+zUpGZPCzXwU4Bux4VhnnSXuu53bnAe7QS0dYMPMaGBgch53DinUvaq
	NAWDZszg0XxTCNjhlTI0s33dDrgvk/kBYiGURox+y93oXCMJBAjs+ALaQfzaKY9trLd+vx0Dxja
	nHUCZib9OyLGBxECoSIwG4E7p5GWmBGXCjWv+Vs+Ul9z81dX/BVuhOqvWMJHXTr34gyobUvDHQn
	upZBV3nLeKgElKbdk00qd9dru0+PAm57OEdEIvS1k/w8nD1eZZ4/OrWQ6ocuY86IvP2o/bjEQQ9
	i3M2iQt3iE1dR5E5yjtca8rj3d1utUKSRNKA==
X-Received: by 2002:a17:902:c411:b0:2e8:e617:18 with SMTP id
 d9443c01a7336-2ed40e09583mr13774715ad.48.1793924711671; Thu, 05 Nov 2026
 16:25:11 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261105175845.30357-1-ihor.solodrai@linux.dev> <20261105175845.30357-7-ihor.solodrai@linux.dev>
In-Reply-To: <20261105175845.30357-7-ihor.solodrai@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 5 Nov 2026 16:24:59 -0800
X-Gm-Features: AclHuK90PpMEFvXLzon2ak4xfdWKEHAewbKiLggRa4mndgNo3_KPNxW2mVpVQvU
Message-ID: <CAEf4BzYqq-o8SRTWyO=J6gBnSkZa=QYuEiBNuBEVndVsVYcExg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 06/17] libbpf: Let decl tags override how
 btf_dump renders type tags
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Quentin Monnet <qmo@kernel.org>, bpf@vger.kernel.org, 
	Alan Maguire <alan.maguire@oracle.com>, Cupertino Miranda <cupertino.miranda@oracle.com>, 
	David Faust <david.faust@oss.qualcomm.com>, Ian Rogers <irogers@google.com>, 
	"Jose E . Marchesi" <jose.marchesi@oracle.com>, Vineet Gupta <vineet.gupta@linux.dev>, 
	Yonghong Song <yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 5, 2026 at 10:00=E2=80=AFAM Ihor Solodrai <ihor.solodrai@linux.=
dev> wrote:
>
> A tool that dumps C from kernel BTF may need a type tag printed
> differently than btf_dump prints it by default, for example as a macro
> that the generated header defines. The tool can't change the tag
> itself: kernel BTF must keep the encoding the kernel expects, and if
> the dumped BTF is the base of a split, a type in the base can't refer
> to a type added to the split.
>
> A decl tag annotates another type by referencing it, so a split can
> attach one to a type tag of its base.
>
> Let such decl tags override the rendering of the type tag: when a type
> tag has decl tags with component_idx -1, print them in its place, the
> same way as decl tags on declarations. The tool that builds the dumped
> BTF then decides how each type tag is rendered.
>
> The kernel rejects decl tags on type tags, so kernel BTF cannot have
> any, and its C dumps are unchanged.
>
> Document this in btf.rst.
>
> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> ---
>  Documentation/bpf/btf.rst | 10 ++++++++++
>  tools/lib/bpf/btf_dump.c  | 12 ++++++++++--
>  2 files changed, 20 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/bpf/btf.rst b/Documentation/bpf/btf.rst
> index 29de1222c3e7..ea0d699749af 100644
> --- a/Documentation/bpf/btf.rst
> +++ b/Documentation/bpf/btf.rst
> @@ -511,6 +511,9 @@ representing the attribute-list of the attribute spec=
ifier. For
>  example, for an ``__attribute__((aligned(4)))`` the string's contents
>  is ``aligned(4)``.
>
> +``btf_dump`` also accepts decl tags that reference a ``type_tag``, as
> +described under ``BTF_KIND_TYPE_TAG``.
> +

um... all this is libbpf-specific concerns, I don't think these doc
changes belong in Documentation/bpf/btf.rst

if at all, we should just maybe add it somewhere next to btf_dump API
in libbpf's btf_dump.h (or just not document this quirk at all)

I've applied, but I should we should clean this up in a follow up



>  2.2.18 BTF_KIND_TYPE_TAG
>  ~~~~~~~~~~~~~~~~~~~~~~~~
>
> @@ -542,6 +545,13 @@ If ``info.kind_flag`` is 1, then the type tag repres=
ents an arbitrary
>  __attribute__, and the ``name_off`` encodes a string representing the
>  attribute-list of the attribute specifier.
>
> +``btf_dump`` prints decl tags that reference a type tag, with
> +``btf_decl_tag.component_idx`` of ``-1``, in place of that type tag. The=
y
> +are printed the same way as decl tags on declarations. This lets a split
> +BTF built for a C dump change how the type tags of its base BTF are
> +printed, without modifying the base. The kernel rejects decl tags that
> +reference type tags.
> +
>  2.2.19 BTF_KIND_ENUM64
>  ~~~~~~~~~~~~~~~~~~~~~~
>
> diff --git a/tools/lib/bpf/btf_dump.c b/tools/lib/bpf/btf_dump.c
> index ad43bbd3b442..c12c3c248407 100644
> --- a/tools/lib/bpf/btf_dump.c
> +++ b/tools/lib/bpf/btf_dump.c
> @@ -1033,10 +1033,11 @@ static void btf_dump_emit_decl_tag(struct btf_dum=
p *d, const struct btf_type *t)
>   * tags of one type form a run that binary search finds the start of, in=
 a
>   * fixed order so that the same BTF always renders the same C.
>   */
> -static void btf_dump_emit_decl_tags(struct btf_dump *d, __u32 id, int co=
mp_idx)
> +static int btf_dump_emit_decl_tags(struct btf_dump *d, __u32 id, int com=
p_idx)
>  {
>         size_t i, lo =3D 0, hi =3D d->decl_tag_cnt, mid;
>         const struct btf_type *t;
> +       int cnt =3D 0;
>
>         /* lower bound on target_id */
>         while (lo < hi) {
> @@ -1051,9 +1052,13 @@ static void btf_dump_emit_decl_tags(struct btf_dum=
p *d, __u32 id, int comp_idx)
>         for (i =3D lo; i < d->decl_tag_cnt && d->decl_tags[i].target_id =
=3D=3D id; i++) {
>                 t =3D btf__type_by_id(d->btf, d->decl_tags[i].tag_id);
>
> -               if (btf_decl_tag(t)->component_idx =3D=3D comp_idx)
> +               if (btf_decl_tag(t)->component_idx =3D=3D comp_idx) {
>                         btf_dump_emit_decl_tag(d, t);
> +                       cnt++;
> +               }
>         }
> +
> +       return cnt;
>  }
>
>  static void btf_dump_emit_struct_def(struct btf_dump *d,
> @@ -1592,6 +1597,9 @@ static void btf_dump_emit_type_chain(struct btf_dum=
p *d,
>                         break;
>                 case BTF_KIND_TYPE_TAG:
>                         btf_dump_emit_mods(d, decls);
> +                       /* decl tags override the type tag, see btf.rst *=
/
> +                       if (btf_dump_emit_decl_tags(d, id, -1))
> +                               break;
>                         name =3D btf_name_of(d, t->name_off);
>                         if (btf_kflag(t))
>                                 btf_dump_printf(d, " __attribute__((%s))"=
, name);
> --
> 2.56.0
>
