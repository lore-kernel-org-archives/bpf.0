Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48E0B3BD629
	for <bpf@vger.kernel.org>; Mon,  9 Mar 2026 16:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773074631; cv=pass; b=CUPu8rJiyb1YAY/5thHwUvX+BQSzPE/l4yY7qW1H7f2U8GFyheA0xgioRnoOxExJ/cafSah2lETOTcYob1EuFS39YSb4YJfIGdkk1ldxLxGiOOA4exwnkUIQgTAS1rBUNMMehkLlQlwcqbgk48yy74AyIfXojM0IlJfORGGgJnI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773074631; c=relaxed/simple;
	bh=AkNgp1eLlxvEHqjLOIKt78ShAP+kfaM9ulUs6EDX/Cc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P6h95JnzL+SsnTzkuhXBOMOdzJCFmLeD6fuGOfhSJ5Ih/LcCfampebtf9nhxykSAMufs9L+R1WfToB4gjzsN4MQVuO7Niia3A+DOGDrZJ9l2+tVndi9a73e5LdUxKv+zQK7Qw6HFNu97DZ+OcMGckT1sr43HhKzFFToOKn2b4/M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P7xCDQbr; arc=pass smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P7xCDQbr"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-482f454be5bso120209125e9.0
        for <bpf@vger.kernel.org>; Mon, 09 Mar 2026 09:43:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773074629; cv=none;
        d=google.com; s=arc-20240605;
        b=EehEyKCVWZ7fkgCyR173cvoTzpP0YhFdvVLHHeuHYaQHnM4htRe0NYiWNfl4mK5IYb
         NQb5Aw04uDwDkaFGMKrjnOpGWHPcMLmt0TXOnLNWROHrXCQVHdft1d5W3nCe1TmdXhWE
         EerRu2PF4pwMBFpmNo6A72zjuUT/LWx8jTT8mq4oWLQSeI7Yq2BOQ9RnRHDWbAuTFM5A
         +gDHv37XoxA727fyz/yvR+9p8z4HK8F7T6AOKQEjuXTsyNSZMpHh8SfycAcBBQlwdAU6
         thERblBp3DvMBvfrTuZWFiBvIDxuS5ZGjSZjU2RhRcGPNk/y+r6GO74cesHoaTIsaxcY
         J0bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=e4EhVoj49ZUMnMW1q1OJFdF+yBsMfqNiDQfLN/Qthj0=;
        fh=9lU5pBBVa87dlQpIpX+nBBSuWiNIF/1UNjjuoFBRepw=;
        b=ih6uRL6iZtNmjx9mPCGMChzAn3G1RxQ4dsPIsuyizasdL+RjrReIFINUMRMizY+mDX
         C88Me/fGvWnsa4+vnGZZWwZxStuHEYQOsub+EI+i/IqGvg5V6RhXzNYNFHhmR++OtWlx
         g2ulFZoXKHXLa7gsOLxfaE4kthOeiEdknzQ5sAEy6OHwqEkWgermc7HPn8XVjgwF4F+i
         8wpBfB6VQ79Ifz5+82xdTnPp095yRLVhT/Swa2tnbj3amFGlFe97Xpm4lgAgabtnmbY4
         Oa5qA2FJJhi0XpP4I59v8OkdtHMjysrPatCk51bFt0ZSfFb7H7fKoS9Q6nKF79MeUSmm
         4+iw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773074629; x=1773679429; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e4EhVoj49ZUMnMW1q1OJFdF+yBsMfqNiDQfLN/Qthj0=;
        b=P7xCDQbriT8BjFo/mIY/dwGuBRA0+oMTZzeA7AifUhSrCOgbU6hH66b4+YO7V57Cxu
         bDsbR4X2ZTc8QgQVGDRAYtvDuiprJVuIlR41trEUa1XmjlyAK+vn39sZhqHk+erpIEYS
         fzyebRxwI0jsKGqNpTcTVgdJ7izk0dq1rxnQ3qQKDynG8hbixSzEkZY1rREmraqct9dc
         EXIEI6z9X8+8yR6ClVsEqw10NrP8uDsrlhu4u75xmLZ18Dr+wSDtjOiZzoknk10pDnYl
         S3yk+QtXGV/08twrq4x7C0FKdqnzxK4+miUmonONco1dXXGOvGSNXezcw9EJq3rfOWMd
         d44A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773074629; x=1773679429;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=e4EhVoj49ZUMnMW1q1OJFdF+yBsMfqNiDQfLN/Qthj0=;
        b=wpKjx5ssiLe4QTgLdnC/5IxO3dVTzrODN/z/MTME0DPhZDBK3eMBnMru20C80pj6WF
         g0qNfRk1tO3EOMRZZTazvVlOsItjw2CVs4CXXnmRb/hvRnRLG+I7XU6x9sE0d1qzxj67
         Y3RNz5O4fJV61MMdk0BFJPxS5vGfka7ClVowjX3SPO1ImV1Okp1tIVk6V+VleT108ubz
         FkVSBK6CPwrVirMd5ExnSS44xR25TMtTf0glSjuM4ls1V3ShE3XRP3C6M/E8rL2XgbM3
         uCTXSG+dxfib0gGuoavOGQ9pdhExdud98i5b/OnYZ679yhPhpMgXUCB+28EpTDLbKDCR
         EALA==
X-Forwarded-Encrypted: i=1; AJvYcCX/yph9cV5VYrqi1OuLupF0C4zpfOhuKRLIoQBhwKZKsK7MfAPAWL5uuRweUP6DFO6W334=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBjp/+lKLd4sd50S5lSKrefRmfrCN0SrIEvYZHWdSuGxkfBvs3
	Xwu8IrUi2WzTXX5ulwfYb5TODVJsfLZSJ20/xxMC5cZ4aEkJxUsMAtAXmqPvHcdHZzu+JpNE0xO
	e97Wy6SUY5eiUeKBqBh1w7QTTjIfV6T8=
X-Gm-Gg: ATEYQzwUj6LgyliS1dTd2q/PO3O1cnUQX1r1ZCCV0CAEk4TLTBTDo1DL2FGZekFUerc
	w/nU5sZ2hsho2ZEBBl8hd650dQyYKO2wCK/EYZHS0K7pnTJIMUKq7euc94AbUxn4cX2NzQSbGgV
	uo/a9R9QSwTWnViwHaDL0Mj0Ct2TlpfxUfa1bcaTYN0QguDTo2ss4bnSxPQkZWYaQ06ixMO5ZAA
	qDf+MyxWyhfOReJshZmKjOKXFTVaSnKXvKO7DeqFGxa62xF3Uc9z6IFo6PWwZkG4zCs4ZingOUw
	1tEev9LOh+mQ3RPSwJIe11AK2tiGljqpMAL1SrIi6sfa4WjG417ICRfXutAwBVLsOJzlyJWME3W
	nFomffp8jQdcQL0LRsKZeA1LRAg==
X-Received: by 2002:a5d:5f82:0:b0:439:ddc0:4bef with SMTP id
 ffacd0b85a97d-439eff2fbd3mr537205f8f.8.1773074628559; Mon, 09 Mar 2026
 09:43:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260309022847.106150-1-zhaomzhao@126.com> <20260309022847.106150-3-zhaomzhao@126.com>
 <DGYECIPVC266.25320R7256YJT@etsalapatis.com>
In-Reply-To: <DGYECIPVC266.25320R7256YJT@etsalapatis.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 9 Mar 2026 09:43:36 -0700
X-Gm-Features: AaiRm50Dkzn77wqhRT6cnmHBFSFIlO8rogOJoWrV3he1NEuRyNufB70yN3teypA
Message-ID: <CAADnVQKdrt3fRcfBrJqSfPP9ALVD59cAQFuDANQG+_=0XDEq5Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] tools/sched_ext: scx_sdt: Fix BPF verifier
 rejection on older LLVMs
To: Emil Tsalapatis <emil@etsalapatis.com>
Cc: Zhao Mengmeng <zhaomzhao@126.com>, Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>, 
	Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, sched-ext@lists.linux.dev, 
	LKML <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	clang-built-linux <llvm@lists.linux.dev>, zhaomengmeng@kylinos.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 9, 2026 at 9:40=E2=80=AFAM Emil Tsalapatis <emil@etsalapatis.co=
m> wrote:
>
> On Sun Mar 8, 2026 at 10:28 PM EDT, Zhao Mengmeng wrote:
> > From: Zhao Mengmeng <zhaomengmeng@kylinos.cn>
> >
> > Under Clang 17/18, when running scx_sdt scheduler, it fails with:
> >
> > libbpf: prog 'sdt_init_task': BPF program load failed: -EACCES
> > libbpf: prog 'sdt_init_task': -- BEGIN PROG LOAD LOG --
> > ...
> > ; desc =3D desc_find_empty(alloc->root, &idx); @ scx_sdt.bpf.c:479
> > 43: (79) r8 =3D *(u64 *)(r6 +32)        ; frame1: R6=3Dmap_value(map=3D=
scx_sdt.bss,ks=3D4,vs=3D200,off=3D120) R8=3Dscalar()
> > ; for (level =3D zero; level < SDT_TASK_LEVELS && can_loop; level++) { =
@ scx_sdt.bpf.c:407
> > 44: (e5) may_goto pc+51
> > ; idx |=3D pos; @ scx_sdt.bpf.c:418
> > 96: (bf) r7 =3D r2                      ; frame1: R2=3D0 R7=3D0
> > 97: (bf) r1 =3D r10                     ; frame1: R1=3Dfp0 R10=3Dfp0
> > ;  @ scx_sdt.bpf.c:0
> > 98: (07) r1 +=3D -56                    ; frame1: R1=3Dfp-56
> > ; bpf_for(u, 0, SDT_TASK_LEVELS) { @ scx_sdt.bpf.c:447
> > 99: (b4) w2 =3D 0                       ; frame1: R2=3D0
> > 100: (b4) w3 =3D 3                      ; frame1: R3=3D3
> > 101: (85) call bpf_iter_num_new#82234         ; frame1: R0=3Dscalar() f=
p-56=3Diter_num(ref_id=3D2,state=3Dactive,depth=3D0)
> > 102: (18) r9 =3D 0x1ffffffffffffff8     ; frame1: R9=3D0x1fffffffffffff=
f8
> > 104: (bf) r1 =3D r10                    ; frame1: R1=3Dfp0 R10=3Dfp0
> > ;  @ scx_sdt.bpf.c:0
> > 105: (07) r1 +=3D -56                   ; frame1: R1=3Dfp-56
> > ; bpf_for(u, 0, SDT_TASK_LEVELS) { @ scx_sdt.bpf.c:447
> > 106: (85) call bpf_iter_num_next#82235        ; frame1: R0=3D0 fp-56=3D=
iter_num(ref_id=3D2,state=3Ddrained,depth=3D0)
> > 107: (15) if r0 =3D=3D 0x0 goto pc+29     ; frame1: R0=3D0
> > ; if (tmp->nr_free > 0) @ scx_sdt.bpf.c:456
> > 137: (bf) r1 =3D r10                    ; frame1: R1=3Dfp0 R10=3Dfp0
> > ; bpf_for(u, 0, SDT_TASK_LEVELS) { @ scx_sdt.bpf.c:447
> > 138: (07) r1 +=3D -56                   ; frame1: R1=3Dfp-56
> > 139: (85) call bpf_iter_num_destroy#82232     ; frame1:
> > 140: (b7) r9 =3D 0                      ; frame1: R9=3D0
> > ; if (unlikely(desc =3D=3D NULL)) { @ scx_sdt.bpf.c:480
> > 141: (15) if r8 =3D=3D 0x0 goto pc+15     ; frame1: R8=3Dscalar(umin=3D=
1)
> > ; chunk =3D desc->chunk; @ scx_sdt.bpf.c:485
> > 142: (79) r4 =3D *(u64 *)(r8 +72)
> > R8 invalid mem access 'scalar'
> >
> > The reason is these older compilers lacks native support for
> > __BPF_FEATURE_ADDR_SPACE_CAST, __arena macro is defined as empty.
> >
> > Fix it by adding cast_kern when dereferencing variables with __arena ta=
g.
> >
>
> I am not sure if we want to support older Clang versions at this point.
> This issue is fixed for Clang 19, and adding the macros back in makes it
> confusing for those who use the code as a starting point. And while
> it would be nice to support older Clang versions, we already don't
> handle Clang 15/16 that don't have arena support. So it's not
> unreasonable if we say Clang 17/18 are also incompatible with this
> example.

+1
People should upgrade their compilers.
