Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1216340D57C
	for <bpf@vger.kernel.org>; Tue,  9 Jun 2026 21:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781041750; cv=none; b=d0MT349X+C5Z0hmhTsJBjWvemZM3J6hUU2QCMs+hsb2AT3BqPs3c+vWYxrZksvuXIeT2+Io+UNAsFTOM9W/aMBGHv7tGUO/Qm9B7mh8HZsCrji7Av8ulx8Vh9qiSMnVfUJKxtMxm01IetyMQlrEhupJvO0H6O+CPx9m4ktv58jI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781041750; c=relaxed/simple;
	bh=7+nDeECa0mrwxUoPNMsskC8Qd7CFRkaGciXDK0p174w=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=G2k0aKeh6+nSNKj5eg/TYFC42shOBhPV/2u1oYM1fwW+SNDPgyycLq+kxE2IOCj/PwN1DEYwbH2SRCOBxJcpk1S+SOHnN2kaVkysVsvezJd+j/zRhUITvanZSQP+0HALUZHFDeTl3Gzj63GRkkupKS9vqs/EiEPdeFaQkgE+X+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qDbDzli9; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qDbDzli9"
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-4864a5c83f1so3864729b6e.0
        for <bpf@vger.kernel.org>; Tue, 09 Jun 2026 14:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781041748; x=1781646548; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7o/nRCgBurIHM9VuiCk+6PysoIU/3yVOZLoqzr7QXjE=;
        b=qDbDzli9PtGmuXAioUbObTdRvQz7g7GqlofEK3ZbIp6I8/ABKChbkmwyFb8N2BL0DO
         FL1pdTSGZBLK6dXD8DHCPZkQQz1YzRRJSwnbLYzbQUvcTdy1VE56JQMYkNRJ4UCvDwrL
         Ml4RqH5ZrSoLO41Wni6WJGohrbBc/9r69OlYp3ELNTjRLFp2OV4tFMckol2/oa2+J353
         PY02yGksJ73y0teRRl1XcZHA6OIMNFZ/137ngLJm2oR94O4Bq4BS+7dxRKP9EV9MOEO7
         /yQvCHF8fgGJwnBcUzbNVn2FPMa8juEkWgGCNK+9nSWm3ljSXVzuCJvYscY2gunkE4yT
         B9dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781041748; x=1781646548;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7o/nRCgBurIHM9VuiCk+6PysoIU/3yVOZLoqzr7QXjE=;
        b=PfdyWXsxEd/5hoXoWR1QlYMJjuy31D12jgTtbqThMjKrYBXFl4yQ2GlHfHF+uayRyo
         Kss3N5ALa5ismp3spxliaOKZsdvqopSSedbqUHQRDdK1uBOZzZA8U9rH3kSa4N/2W4QI
         5UR050IAbrTU3TBWu5gxXJ8AnqSt2sSjwbdykqLXx83cY8PucjVmOmvNekfOHRUkje1F
         2uI8VlnHNEIVa/BtRKgBtrdU3pCsFUH5wAc1c3yDnUCXbljqRJpVjInOagktXY7DksvF
         O7nyPSM3bkMFaWQtMhjXGDlbBR2LT+ryrwNgC3YwKqU3ZMmcyLng1FM87WipGB9Kwjsp
         UtPA==
X-Forwarded-Encrypted: i=1; AFNElJ+k3xQq/C2+9aGSZJgN14jg/DJVWctZAK7DuGCImlfA5ip2rjibGXOXA3OpmbZqBBb1O60=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbAGYyNtavTJinv+TcXjA/Nc7ffdCsglk4mkmUWnnKWaNL0XZo
	1QxIShYHDOPxXolnWyScK7TKo7rqWKo+LWJM3oGjqe/eXBEIJBqkBxTF
X-Gm-Gg: Acq92OH3jo1bOiDr1E+/u4H8gEE54H7VQttqXBeFe4i1jaUN8C9TZomC9WhlPK0ot3o
	pAYPn55b9hlEPIDAvtRrQ5ApEkPb2DEOLPoN3CgCXCj6f/tpK8rvrsQb+9deukrfOISmTXa2g8b
	UgbxwDD2nrz1muOZJoIDckp4OSHyf2te4mrb7aL+adLMc6eX17dd/9hBoUfvkbYRr1sZsd3aiaX
	O12sqq4viUJgTsFjzAE3YwhRSfGG3BlrfRHNSHjtULdr5UImQoXVHs594NBtN3J9FYgfZG/CG7s
	IjRjwH3eRSgWlKGe7JEPV4CaQoGcoBd5q9/WrtvgpSrdwtIVLpNDpiOoE5v6kj1Fsky2gaTVO+u
	XnvZbcF8TQ1/JHS3NlNSlRGX7RNEjPRI+n+Ls2mz/R2Z8nU3mDepeM+nw7SJXQuw4K/fb75jaTZ
	ZnkeHST9TCGd64Io0/AuWvqaiojDSZ09WLaTt4pc38NAVIT2aE7V2vonwAL8f42sGM9zPJ5MzZ9
	xgAIxyGpKPGddZoAvlPoPvPCXL4
X-Received: by 2002:a05:6808:e8d9:20b0:486:a5e9:c320 with SMTP id 5614622812f47-486a5e9c39dmr7889376b6e.29.1781041747936;
        Tue, 09 Jun 2026 14:49:07 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:51::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4865b745773sm17882030b6e.6.2026.06.09.14.49.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jun 2026 14:49:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 09 Jun 2026 14:49:04 -0700
Message-Id: <DJ4ULU6H2NYA.24B49ESUI6RNP@gmail.com>
To: "Yonghong Song" <yonghong.song@linux.dev>, <bpf@vger.kernel.org>
Cc: "Alexei Starovoitov" <ast@kernel.org>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>,
 <kernel-team@fb.com>, "Martin KaFai Lau" <martin.lau@kernel.org>
Subject: Re: [PATCH bpf-next 1/3] selftests/bpf: Keep int return type for
 tailcall subprogs with maps
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
X-Mailer: aerc
References: <20260609163947.1717694-1-yonghong.song@linux.dev>
 <20260609163952.1718472-1-yonghong.song@linux.dev>
 <DJ4PQYTQDWQT.1ENYNRIC3C7IH@gmail.com>
 <145c7132-ec43-4238-801d-55d518fb0da8@linux.dev>
In-Reply-To: <145c7132-ec43-4238-801d-55d518fb0da8@linux.dev>

On Tue Jun 9, 2026 at 2:30 PM PDT, Yonghong Song wrote:
>
> const struct bpf_func_proto bpf_tail_call_proto =3D { =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 /* func is=20
> unused for tail_call, we set it to pass the =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0* get_helper_proto=20
> check =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/ =C2=A0 =C2=A0 =C2=A0 =C2=A0 .f=
unc =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D BPF_PTR_POISON, =C2=A0 =C2=A0 =
=C2=A0 =C2=A0=20
> .gpl_only =C2=A0 =C2=A0 =C2=A0 =3D false, =C2=A0 =C2=A0 =C2=A0 =C2=A0 .re=
t_type =C2=A0 =C2=A0 =C2=A0 =3D RET_VOID, =C2=A0 =C2=A0 =C2=A0 =C2=A0=20
> .arg1_type =C2=A0 =C2=A0 =C2=A0=3D ARG_PTR_TO_CTX, =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 .arg2_type =C2=A0 =C2=A0 =C2=A0=3D=20
> ARG_CONST_MAP_PTR, =C2=A0 =C2=A0 =C2=A0 =C2=A0 .arg3_type =C2=A0 =C2=A0 =
=C2=A0=3D ARG_ANYTHING, }; and for=20
> RET_VOID, we have below in verifier.c: =C2=A0 =C2=A0 =C2=A0 =C2=A0 switch=
=20
> (base_type(ret_type)) { =C2=A0 =C2=A0 =C2=A0 =C2=A0 case RET_INTEGER: =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /*=20
> sets type to SCALAR_VALUE */ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 mark_reg_unknown(env, regs,=20
> BPF_REG_0); =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break=
; =C2=A0 =C2=A0 =C2=A0 =C2=A0 case RET_VOID: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0=20
>  =C2=A0 regs[BPF_REG_0].type =3D NOT_INIT; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 break; so we cannot=20
> return 'r0'.

Ahh, so bpf_tail_call() is a void return.
Then, I'll take it back. bpf_tail_call_static() is correct with void return=
.
I guess we have to teach the verifier to accept void subprogs asap.

In the meantime let's do shortest possible hack for tailcall_bpf2bpf_hierar=
chy1.c
to pass with llvm 23.
