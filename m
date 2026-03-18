Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D424337F018
	for <bpf@vger.kernel.org>; Wed, 18 Mar 2026 21:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773870099; cv=none; b=iKt0MdfyjR3BnAJVO2H1cz355SB/c4bprQV+L67NyZklBPaHjQMvRoTlTZPlqccdr+Ag+dKh44CwgkN6uasb0Z6NXWU5ptMhY8QMv6mTwOaHtyvCvhwVTQkqkAfSc3Jx1223RQ465mSNBKVgfRWeNsOTpGCekeug9TPLSGY/yGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773870099; c=relaxed/simple;
	bh=W5XDU8uL1Bn2bDAi52vyOjsq733scXtfkIqoBIVJ0pQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gwp49z+3Zt5Ju+R/t+JvPKOtckENiXb5GDGlxADp0Y/mTTah76hfobdwyvY2lSoT3qlIpB+7G4dueih/h64AgXqpczKQKgp+sHXuBmu6oyNmyQ5fM+jEOxsF31eg0AVDmmcmWv7Utv3K67n+zIQOsQx4eIZ/iU6k/HtHe6wqGog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WExSn+TN; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WExSn+TN"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2aae146b604so50955ad.3
        for <bpf@vger.kernel.org>; Wed, 18 Mar 2026 14:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773870097; x=1774474897; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pycndCnpLOVCoo8IopI4wWPEypE0bpdF7U5VLPW80J4=;
        b=WExSn+TNqZHGNbp8s1pgvnsJQFhwsanXpzS6oYIj0GZk41VXVuyo2tMj4df5nIwJgo
         IdjnqdpJioHgMGF0wvPslJR01iqoZHFK+sH5frtvCbNnbXJUDSHFi31Ea/oFz6P8tqEJ
         3jekLg9xfveb6MBiUtnzqQPfvMiUk60rlQ2TOEhxL+75N9J2mXf5wv/H7Q8XFRnTFTMT
         t54szAeLbYUibTfVOKFohH0DP+4GAFhWQL24jhk5CHflP+85171clW2zUOz0yU5aJ8s1
         4MZ3zvIideAMg3F1VzyHb/C+/Jsvwn8gBm/K5jbSiCUPnW4R1wXyPYp1gQ+VSFPuhqwy
         kVVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773870097; x=1774474897;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pycndCnpLOVCoo8IopI4wWPEypE0bpdF7U5VLPW80J4=;
        b=Hp16mVl1ktPVWsFoI9DBcOpoKYXntkCltxbNggf+XEC0JwsjJ9Rb+u1jfqyYtNOqF3
         mAZqH/oJvMmQTTRS3D57tBT8vZzbFiYwRjFGSfX7oZdFSofOW0VC7MXF0VxSExCQ7xlY
         0xckhhezqHHgLXQcKav3YFnSQ+sYxHL9JBUCzLaaJqoPJjeaVRmjrdJpCvA0YiANOQbE
         zK2WTL81xaCxV3QJcTZaKUd3o99UURiX4ifNL/cvFfF47amhJMYDRjAx+iRns/ZcL0Ut
         w51weRM3Yd2InOv4O4YL49aIFVnYl1Np4jY1ROJCRDjtWZeUsM7Jmtr4oHK1gMWHOSIL
         0pWg==
X-Forwarded-Encrypted: i=1; AJvYcCV65jIl12NnBDPOTtNtECmRbbAcPCmh6XaBU1B8lk3zrDZkHPIB/ujgkFuS30ctgs4au8I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEm3xRuN+VWZ0qMs6KDoshKuhod9+eFzFLlVQ6SA3OVYrPevQ/
	xBOcOoApQ33Ry0YYvPfPle2urBxZkmROSBf04/iaFzJneareMXvhwmvr
X-Gm-Gg: ATEYQzx1dE1KRqolxJ7yzHTzBnKLnhQGBCqJDZH6D98Cxoi99k31sC3BrhGLZtveOBQ
	LWqIxjblIKjB+nKOwWLys61mnJ+7U5w9bdssdpWQuTgmFpKqfYCZlRDWzAB5g2TmCsDtTVU6mjn
	tmRSKbi7BOAZO/Jb6fDvXlODPQC13GCwTZ+0Oa+Kk5LkiwY16n3Klv6wMYjfa6/T7tWM1d8gFEU
	gCbqx/75WpOCM6b0hqLV2+SDZ683RSTwocr5dqPUht9/i4g1f39ZE3KUYzSSuO+jiA+GxWAVbBE
	V7ihRJYDgQf5TLy+M3vl6u8OH+ZelJLjWGFMs6lRx7lnR/0xHIzzaMwTbGznUmSLPwd9cCVnR92
	GICuWs8x/ipaq9i3ATZ749cVWKF/RiZtxiTJ4fEQrW/O4LmsIEnIrjLcUi7+WvOswrcRIRiJ11j
	IvbYEY5IpMg9purxUL3fG9CU5cisA0XFC4eUV1uUQD1nACb1goUrvnOPRI1hCaVQ==
X-Received: by 2002:a17:903:1666:b0:2b0:6475:73d0 with SMTP id d9443c01a7336-2b06e33a0d3mr44095135ad.12.1773870097211;
        Wed, 18 Mar 2026 14:41:37 -0700 (PDT)
Received: from [192.168.0.56] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b06e63a971sm64219175ad.83.2026.03.18.14.41.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 14:41:36 -0700 (PDT)
Message-ID: <e04886a885e3fef31cd2cb4487a93e3b76deb153.camel@gmail.com>
Subject: Re: [PATCH bpf-next v3 2/3] selftests/bpf: Add syscall ctx variable
 offset tests
From: Eduard Zingerman <eddyz87@gmail.com>
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, Kumar Kartikeya Dwivedi
	 <memxor@gmail.com>, bpf@vger.kernel.org
Cc: Emil Tsalapatis <emil@etsalapatis.com>, Alexei Starovoitov
 <ast@kernel.org>,  Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Martin KaFai Lau	 <martin.lau@kernel.org>, Tejun
 Heo <tj@kernel.org>, Dan Schatzberg	 <dschatzberg@meta.com>, kkd@meta.com,
 kernel-team@meta.com
Date: Wed, 18 Mar 2026 14:41:33 -0700
In-Reply-To: <878qbpkxh9.fsf@gmail.com>
References: <20260318103526.2590079-1-memxor@gmail.com>
	 <20260318103526.2590079-3-memxor@gmail.com> <878qbpkxh9.fsf@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.1 (3.58.1-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-03-18 at 14:45 +0000, Mykyta Yatsenko wrote:
> Kumar Kartikeya Dwivedi <memxor@gmail.com> writes:
>=20
> > Add various tests to exercise fixed and variable offsets on PTR_TO_CTX
> > for syscall programs, and cover disallowed cases for other program type=
s
> > lacking convert_ctx_access callback. Load verifier_ctx with CAP_SYS_ADM=
IN
> > so that kfunc related logic can be tested. While at it, convert assembl=
y
> > tests to C.

Nit: I'd move the conversion to a separate patch in the set.

[...]

> > @@ -173,7 +179,7 @@ void test_verifier_cgroup_skb(void)=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { RUN(verifier_cgroup_skb); }
> > =C2=A0void test_verifier_cgroup_storage(void)=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 { RUN(verifier_cgroup_storage); }
> > =C2=A0void test_verifier_const(void)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { RUN(verifier_co=
nst); }
> > =C2=A0void test_verifier_const_or(void)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { RUN(verifier_const_or); }
> > -void test_verifier_ctx(void)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { RUN(verifier=
_ctx); }
> > +void test_verifier_ctx(void)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { RUN_WITH_CAP=
_SYS_ADMIN(verifier_ctx); }

Wouldn't this be the same as to use RUN_TESTS(), like a few lines below?
Also, tjos changes the semantics by always running verifier_ctx tests
with CAP_SYS_ADMIN, is that important?

> > =C2=A0void test_verifier_ctx_sk_msg(void)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { RUN(verifier_ctx_sk_msg); }
> > =C2=A0void test_verifier_d_path(void)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { RUN(verifier_d_path);=
 }
> > =C2=A0void test_verifier_default_trusted_ptr(void)=C2=A0 { RUN_TESTS(ve=
rifier_default_trusted_ptr); }

[...]

> > diff --git a/tools/testing/selftests/bpf/progs/verifier_ctx.c
> > b/tools/testing/selftests/bpf/progs/verifier_ctx.c

[...]

> > +	SEC(type)							\
> > +	__description(type ": reject kfunc zero-sized ctx access")	\
> > +	__failure __msg("R1 type=3Dctx expected=3Dfp")			\
> > +	int no_rewrite_##name##_kfunc_zero(void *ctx)			\
> > +	{								\
> > +		bpf_kfunc_call_test_mem_len_pass1(ctx, 0);		\
> > +		return 0;						\
> > =C2=A0	}
> > =C2=A0
> > -no_rewrite_ctx_access("syscall", syscall, 4, u32);

--- 8< ----------------------------------------------

> > -no_rewrite_ctx_access("kprobe", kprobe, 8, u64);
> > -no_rewrite_ctx_access("tracepoint", tp, 8, u64);
> > -no_rewrite_ctx_access("raw_tp", raw_tp, 8, u64);
> > -no_rewrite_ctx_access("raw_tracepoint.w", raw_tp_w, 8, u64);
> > -no_rewrite_ctx_access("fentry/bpf_modify_return_test", fentry, 8, u64)=
;
> > -no_rewrite_ctx_access("cgroup/dev", cgroup_dev, 4, u32);
> > -no_rewrite_ctx_access("netfilter", netfilter, offsetof(struct bpf_nf_c=
tx, skb), u64);
> > +no_rewrite_ctx_access("kprobe", kprobe, 8, __u64);
> > +no_rewrite_ctx_access("tracepoint", tp, 8, __u64);
> > +no_rewrite_ctx_access("raw_tp", raw_tp, 8, __u64);
> > +no_rewrite_ctx_access("raw_tracepoint.w", raw_tp_w, 8, __u64);
> > +no_rewrite_ctx_access("fentry/bpf_modify_return_test", fentry, 8, __u6=
4);
> > +no_rewrite_ctx_access("cgroup/dev", cgroup_dev, 4, __u32);
> > +no_rewrite_ctx_access("netfilter", netfilter, offsetof(struct bpf_nf_c=
tx, skb), __u64);

---------------------------------------------- >8 ---

The chunks above differ only in '__' prefix for u32/u64.

[...]
