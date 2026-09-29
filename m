Received: from mail-yx2-f41.google.com (mail-yx2-f41.google.com [74.125.224.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9188A51814E
	for <bpf@vger.kernel.org>; Tue, 29 Sep 2026 11:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790682586; cv=pass; b=aRmtyGoJuxAQvRIOjGUvAKhsrnOH5juKQOT4/MHS2Y4Z8+xviX+V+4s4iWVAuPjZe9H7S8JsfoL2jgg9L1M5cot0SSXSVF/MHFF/zuIDjoVb3UusPtWqK/kUZdg0OBIbNQPmqDDTwwIRxwnTHld+RPtJwWdpPs2x1jRYoE8Uy+Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790682586; c=relaxed/simple;
	bh=kgjy2BB8Nwb8PNLZfFsqLbfjDohsf0KQ3TZfyRHIEYc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=axOHBVZXSGMQiiK23k7EOpDPm/idBIYAT84yW36AzC4t3PG0bcCp2A3KpyBArqEiwS1VvMwcouAFXvd2/rbbg02XmYqO4ZFZV1cj/gFlmWVaNU29aM8wXSUTV6pH5Zo+yYno9Dl9PhvO1v7W/b++TtFaiUYBMI/ULfWH/jws/PU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GwhE5rIr; arc=pass smtp.client-ip=74.125.224.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GwhE5rIr"
Received: by mail-yx2-f41.google.com with SMTP id 956f58d0204a3-6756acdc3a8so243702d50.1
        for <bpf@vger.kernel.org>; Tue, 29 Sep 2026 04:49:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790682583; cv=none;
        d=google.com; s=arc-20260327;
        b=BOtkRV7dqblD4xfbTYCz/+nG1CGtsSnDwrMh2KqurWBRTBQJHdGXIaLEoO5g324p88
         m1yOCUC5bTXB6aYJq2CLcrGru722GftIc1Gi16BL4DzXZwg3WMcRHmD0FuP7obKb8nFw
         ZCE8Blc6lmQoSW6iW6Um+g1WDT6jk8tcplVpIP3TuH6bf0ODumM2UtWpechei2sLV4LV
         CVo8jnbcOBtpSiONAbhE+GTjEod0iPeUtEiBL03yP+31XtgzTCLA1LRvnvTigz4pxIj/
         8GTvnsFivmLGM+zXX+9SGxlZ2n8o8xTncgmWALBuy6pGUIdHSkJ+2nvMHXW9SjeXLrol
         CfJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PinsfWb5o3H1N8+JPrpcg6f6Oxc9ozJUPh0iCkDqvJw=;
        fh=tFVkUTtUXJ4swQQtNU5TgANaqkLDgWbYgI+RqcY0GwA=;
        b=qrSk6nkr36IzHwF89RGURtCelgJrM8JGjfzbMaRpM//q0SRpDl+oCdzHmEbD1NMtJZ
         /AZ563/wkRmMOTslVsR84zJuyUwIWzJzm3ULC4VjO8A2ewZsu4r/+AiwVYFjbqVLB8g6
         pJXu3rjeUgeY87WiaBgT4YBlZZGfN0YI4vA+1UxgzKgl8ouNYAWUUuArymkFURoa5zHJ
         hvmqp+ggB1r3/NjDVbLr9V/XX2bviv7MQls38IZ1ZnMa0eMXdeFbhCj3dOdeqwY6FGs4
         vnd5Rw2vhHY9MUTkZ2exfs86zBknKxee9vJpEpbt4KGwzjGyLTDUMyooVPYTD6H/ckYO
         k7AA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790682583; x=1791287383; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PinsfWb5o3H1N8+JPrpcg6f6Oxc9ozJUPh0iCkDqvJw=;
        b=GwhE5rIrih0pY2UIXirrTWjpTlblATUKmmDYILdI35pc/2y7JVOR/hYrvlTxQV+10A
         pCA5Ta12ibOETBKTEwhMjKjM8NCJJ/PqInEC721YWfO/BCM+hilBXJUTI5OxizkA2K+v
         GuS0ibKZH6CtMb39fU4MBNlgRH8AxZWlHAloTlZZF22NyhU5wn9N5xKZ7SDD1u8vDBhm
         zVq1/C5zayoM2IOhl7wBVBc5n7Q6LV6He53wTiCyugtTQgIB1Q+0UaTg+74+8GjaMppv
         DYyl9SxXRcNJXoD3yd2/GUopP2MBEXEiflJs4DHtWlTmJ4zFQ4xNI0mZMYsg5AQ3C0be
         dxHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790682583; x=1791287383;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PinsfWb5o3H1N8+JPrpcg6f6Oxc9ozJUPh0iCkDqvJw=;
        b=fk1zKPRTd+HZ0O0ibx76nIxEPinE45+db/ie2w2Fq76/cYwVbFx9Ukyf3TsaOE/xOm
         UjAAbCNZdB1bqDccimwOOLw4YovoEGCGTCcVYJ4FISnr6APxMLbpmB0jgaSA5PxNQ394
         EDYKmS2SMSyhFST80xaqrr6kzdb0YxTSH5HbSTDx+n6FUNdG9ST95IwxEyqnXeEVlTxC
         Qp6/zq1xepI55AOyIfn+qJ8VCENYLWfiXFIsFH5OcE9iCC8ZtncCfCRUs2XIerd0Ce8v
         yOpJFl90h+ljk2BH5nNN8whpMBpHAb7jOsl0+B52l/fKGLDhNysGNxJ+Cinzwnv85f42
         ZRuQ==
X-Forwarded-Encrypted: i=1; AKwUvBy7izm7MAbr3Qxu0fOW4whSHmlEHF9W8ksca88zwc9/nTkJIrBeTXWLBfQNtBC3Y/O2iMs=@vger.kernel.org
X-Gm-Message-State: AFq9FYKpGhk+ym2q6IkMg5xVLvhadHCrm15vmtKMxu1Vl5UiYnVkfQ+N
	N3QlSJ47a/RKE3W2tDsK6Jdz98DxNQuZnmlOjL7HE7goIbCL8MICC1UdyZezUclTV0aVyRY74vW
	0MT/3jsBcfZKXT7BqIHsNDtAJFsFp4zU=
X-Gm-Gg: AYBFou2hinAR0JPSO0mcwLuWNh4JHiMATks2Vtd37MHKHEjpbw08rwtlJcEKDhwydvP
	dh/mzsmO0NWkLxtBZj6LI6i5oce0oIZyRcauYnyIf0RoYRTicNp72xIn6gNUUDYjL+DXCh7oxoQ
	NlRmEaXpPCSdkZAQQ/bMCVC62P5ME4N/8GDc1IpZLs/RomU/V011SG859mBWTELIQcz4j34wtLb
	G3tQW4s/YAl3AqtlOG1E54kzcBnkgRV94YnuzfE+mYydSMSvIsDh0vrVsDLEp+AQZ/1MhGYUu4v
	bBIbjwpUkzz427Jl0XHsL3397ISkHGJA8LWEjtGFmaWpnIP4Zwmp781ZzzcvAOTQm7Tii9mLNBM
	MOKozNMwgPA==
X-Received: by 2002:a05:690e:144e:b0:668:9230:e266 with SMTP id
 956f58d0204a3-674112442a9mr4372761d50.46.1790682583424; Tue, 29 Sep 2026
 04:49:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260921192559.2619635-1-shakeel.butt@linux.dev> <20260921192559.2619635-2-shakeel.butt@linux.dev>
In-Reply-To: <20260921192559.2619635-2-shakeel.butt@linux.dev>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Tue, 29 Sep 2026 19:49:02 +0800
X-Gm-Features: AclHuK-nFEkgx8S0aZZQyW2aKsafwpBB_ccNYji7zHIK6DtT7XurPCTCqUpsYEY
Message-ID: <CALOAHbAb_aKHNxKV3ecUW6ZxK3VR8XAwxD0vHiaZa__6e2pKwQ@mail.gmail.com>
Subject: Re: [RFC PATCH 1/4] bpf, cgroup: fix cgroup struct_ops query for a
 second attach type
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, Alexei Starovoitov <ast@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, JP Kobryn <jp.kobryn@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Tejun Heo <tj@kernel.org>, Michal Koutny <mkoutny@suse.com>, 
	Amery Hung <ameryhung@gmail.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Emil Tsalapatis <emil@etsalapatis.com>, 
	Jiri Olsa <jolsa@kernel.org>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, Jiayuan Chen <jiayuan.chen@linux.dev>, hui.zhu@linux.dev, 
	Donet Tom <donettom@linux.ibm.com>, Greg Thelen <gthelen@google.com>, 
	Meta kernel team <kernel-team@meta.com>, linux-mm@kvack.org, bpf@vger.kernel.org, 
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 22, 2026 at 3:31=E2=80=AFAM Shakeel Butt <shakeel.butt@linux.de=
v> wrote:
>
> Two things in __cgroup_bpf_query() work only because CGROUP_TCP_SOCK_OPS =
is
> the only one struct_ops attach type.
>
> It calls cgroup_bpf_enabled(atype) with an atype that
> find_atype_by_struct_ops_id() works out at runtime.  That macro is an asm
> goto and needs a constant.  Today the compiler can see there is only one
> value; add a second type and the build breaks with "impossible constraint=
 in
> 'asm'".  Add cgroup_bpf_enabled_runtime(), which reads the key instead, a=
nd
> use it here.  This is a syscall path, so the cost does not matter.
>
> And find_atype_by_struct_ops_id() matches on type_id alone.  An attach ty=
pe
> whose subsystem is not built keeps type_id 0, so a query for type 0 finds=
 it
> and returns success with nothing instead of -ENOENT.  Skip such slots.
>
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>

Acked-by: Yafang Shao <laoar.shao@gmail.com>

Could you please send this fix separately from the series so it can
land in bpf-next on its own?

> ---
>  include/linux/bpf-cgroup.h | 9 +++++++++
>  kernel/bpf/cgroup.c        | 3 ++-
>  2 files changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/include/linux/bpf-cgroup.h b/include/linux/bpf-cgroup.h
> index 8a75a6cd7309..3b2c127d401d 100644
> --- a/include/linux/bpf-cgroup.h
> +++ b/include/linux/bpf-cgroup.h
> @@ -76,6 +76,14 @@ to_cgroup_bpf_attach_type(enum bpf_attach_type attach_=
type)
>
>  extern struct static_key_false cgroup_bpf_enabled_key[MAX_CGROUP_BPF_ATT=
ACH_TYPE];
>  #define cgroup_bpf_enabled(atype) static_branch_unlikely(&cgroup_bpf_ena=
bled_key[atype])
> +/*
> + * Same test when @atype is not a constant.  cgroup_bpf_enabled() uses
> + * static_branch_unlikely which creates jump-label site and requires sta=
tically
> + * selected key. Since key is selected dynamically, use static_key_enabl=
ed here
> + * and keep it off fast paths.
> + */
> +#define cgroup_bpf_enabled_runtime(atype) \
> +       static_key_enabled(&cgroup_bpf_enabled_key[atype])
>
>  struct bpf_cgroup_storage_map;
>
> @@ -508,6 +516,7 @@ static inline int cgroup_bpf_struct_ops_attach(struct=
 bpf_map *map,
>  }
>
>  #define cgroup_bpf_enabled(atype) (0)
> +#define cgroup_bpf_enabled_runtime(atype) (0)
>  #define BPF_CGROUP_RUN_SA_PROG_LOCK(sk, uaddr, uaddrlen, atype, t_ctx) (=
{ 0; })
>  #define BPF_CGROUP_RUN_SA_PROG(sk, uaddr, uaddrlen, atype) ({ 0; })
>  #define BPF_CGROUP_PRE_CONNECT_ENABLED(sk) (0)
> diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
> index 696b27383974..99b4e96f5db7 100644
> --- a/kernel/bpf/cgroup.c
> +++ b/kernel/bpf/cgroup.c
> @@ -45,6 +45,7 @@ static enum cgroup_bpf_attach_type find_atype_by_struct=
_ops_id(u32 type_id)
>
>         for (atype =3D 0; atype < MAX_CGROUP_BPF_ATTACH_TYPE; atype++) {
>                 if (cgroup_bpf_is_struct_ops_atype(atype) &&
> +                   cgroup_struct_ops[atype].type_id &&
>                     cgroup_struct_ops[atype].type_id =3D=3D type_id)
>                         return atype;
>         }
> @@ -1448,7 +1449,7 @@ static int __cgroup_bpf_query(struct cgroup *cgrp, =
const union bpf_attr *attr,
>                         return -ENOENT;
>                 from_atype =3D to_atype =3D atype;
>                 flags =3D 0;
> -               if (!cgroup_bpf_enabled(atype))
> +               if (!cgroup_bpf_enabled_runtime(atype))
>                         goto skip_count;
>         } else if (type =3D=3D BPF_LSM_CGROUP) {
>                 if (!effective_query && attr->query.prog_cnt &&
> --
> 2.53.0-Meta
>
>


--=20
Regards
Yafang
