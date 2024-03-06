Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1574173
	for <bpf@vger.kernel.org>; Wed,  6 Mar 2024 00:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709683546; cv=none; b=E/aHcifkQaljM17sYksP8HhNWGmfOaBVzjT44ndFbFkvW4+Y3aHQ84oQlBLmdFIIgCvuruLw9t5K3dP7BuoWmOBRTnww4OkytqysADl8xNcLUbRmbJAnfmH0AnNT8kJgG3hbYblOAiGksR5inKBVqK8ktij82j0xN0F0WOJzAWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709683546; c=relaxed/simple;
	bh=rgzEL+gSX2+E95KIVQqG9wel+wmzC339isHxpnX98cw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MH9wntbr3rCkRGncZ6ZfcSns1cG7+mMO4PkdhlDwV/abnPxLolql+PNXEeJ+kyC8PT68MaTa+Lxqnywm7TRyJyCgR53MSlLeq7aRDQW8xRImZfhc5NLf3IKj069n3NAlelS7tbvrYIvcuVNCZGcX8sBwXO94ky0aH+7WGff90co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ly8ll/Xv; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ly8ll/Xv"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a2f22bfb4e6so183483766b.0
        for <bpf@vger.kernel.org>; Tue, 05 Mar 2024 16:05:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709683543; x=1710288343; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=g2qkg7UIMTdmPXgnWaovTvFb+UZLnitqkU/Db8hyE2s=;
        b=Ly8ll/XvfsYdltNQ9a4i9yzWNI1LUCv2g8mcTcWcX7TB+wbtx54KlXq0nh8zOCPFyo
         y3mh4HMftKYEBqJK5I2LO3wnbg7l55c224NWl1zR2kmRtKal9JzVO96R+TQvuoFPdCBx
         uEyHXu4l/D+yJaqF/MvtJPLP7qjpquifme7FzNQzhNjPIl/h1zZOs36LyOaj7IttV+g0
         JUQn4vr1TgjlMKiW9XJE2xfBSfqIXiWVxu+mLY62BqelSCGDzd04wiim4FQ43k65dRZ0
         lou1SeVO3sD/SyOiqvamErZVl4Hm8qb7m+m6tD6xZv2qOJJUnYC5qqAnyu+KadBFvR7a
         j+4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709683543; x=1710288343;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g2qkg7UIMTdmPXgnWaovTvFb+UZLnitqkU/Db8hyE2s=;
        b=E+Z1cg0TqBhgzAaWXCbhz3DiFtBhUDW8wnLWsDxn1EMXfkqJhhe+atiIpeJQpwyOfx
         W8m/w2vlHZFGOsGkSO7XSpyHwNXUNUICJF3zJ5Jr8ObPr96xz9LeSV9bjfRNFcPqqPsv
         KzWdNpGBX6/aATBsEb4D9tPAN2iqkH9xkQtfrreJFy2vXbr8jP7QySIjC9hUCQYUJQhG
         4CpU8pZcmyfOL4p8hIttYZrir2DeJQAavV3A6UBpP2gRgNusYC3oUX77QFoq7dZ+OzRg
         VLuituBlZF6C2UorO+OylVBrwMgJoaNSvnQ9Fs9erWBAMNeQVIzataHWkLj+IQujCd2w
         SkCg==
X-Gm-Message-State: AOJu0Ywh7Ud/szO5Y7ZZKRZneM8LQTFoJxkVIRABc8cjE8oDtz74Nae8
	M+8thr+TOoZwGCmyltNqwHWXemGe8ZPqLJPMED4oo/Tff4ariBy+
X-Google-Smtp-Source: AGHT+IHtS1g9BiM4WUuhUT3raul2xZYP/xUyHiEa63XRyQfmhvo7YD7ZRY8ymfNXnQyTx4Hiwe8fyA==
X-Received: by 2002:a17:906:6954:b0:a45:8f10:50c6 with SMTP id c20-20020a170906695400b00a458f1050c6mr3433133ejs.57.1709683542709;
        Tue, 05 Mar 2024 16:05:42 -0800 (PST)
Received: from [192.168.1.94] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id v23-20020a170906565700b00a455ff77e7bsm2523658ejr.88.2024.03.05.16.05.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 16:05:42 -0800 (PST)
Message-ID: <f597c577db67c2da71a77debe88fbdd7729ce837.camel@gmail.com>
Subject: Re: [PATCH bpf-next v3 06/15] selftests/bpf: bad_struct_ops test
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net,  martin.lau@linux.dev, kernel-team@fb.com,
 yonghong.song@linux.dev,  void@manifault.com, sinquersw@gmail.com
Date: Wed, 06 Mar 2024 02:05:41 +0200
In-Reply-To: <CAEf4BzbhBw-xhiSoUAP5bXefSNiQwXY6eADk6fkLj=HCc6YbuQ@mail.gmail.com>
References: <20240304225156.24765-1-eddyz87@gmail.com>
	 <20240304225156.24765-7-eddyz87@gmail.com>
	 <CAEf4BzbhBw-xhiSoUAP5bXefSNiQwXY6eADk6fkLj=HCc6YbuQ@mail.gmail.com>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-03-05 at 11:29 -0800, Andrii Nakryiko wrote:
> On Mon, Mar 4, 2024 at 2:52=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.co=
m> wrote:
> >=20
> > When loading struct_ops programs kernel requires BTF id of the
> > struct_ops type and member index for attachment point inside that
> > type. This makes it not possible to have same BPF program used in
> > struct_ops maps that have different struct_ops type.
> > Check if libbpf rejects such BPF objects files.
> >=20
> > Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> > ---
> >  .../selftests/bpf/bpf_testmod/bpf_testmod.c   | 24 +++++++++++++
> >  .../selftests/bpf/bpf_testmod/bpf_testmod.h   |  4 +++
> >  .../selftests/bpf/prog_tests/bad_struct_ops.c | 35 +++++++++++++++++++
> >  .../selftests/bpf/progs/bad_struct_ops.c      | 25 +++++++++++++
> >  4 files changed, 88 insertions(+)
> >  create mode 100644 tools/testing/selftests/bpf/prog_tests/bad_struct_o=
ps.c
> >  create mode 100644 tools/testing/selftests/bpf/progs/bad_struct_ops.c
> >=20
>=20
> CI reports kernel crashes, so please check that, but overall things look =
good:
>=20
> Acked-by: Andrii Nakryiko <andrii@kernel.org>

Newly added test case struct_ops_multi_pages does not define
bpf_testmod_ops->test_1 field for struct_ops map,
so the following code from my patch caused null pointer dereference:

       563  static int bpf_dummy_reg(void *kdata)
       564  {
       565          struct bpf_testmod_ops *ops =3D kdata;
       566
       567          ops->test_1();

Fixed by adding "if (ops)" check.

[...]
