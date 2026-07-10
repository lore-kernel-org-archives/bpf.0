Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D2A6301474
	for <bpf@vger.kernel.org>; Fri, 10 Jul 2026 01:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783646401; cv=none; b=V6JHjLsfoAZrQlk5xUyT+/wVZML541UNR8bxPzb+wXXNqsjVFCf2EJ1qwgSVbHYTjc/YORAJW/6AOoAK9L4sDNEzKk+xo4qvjX7Bhc1wLAsRWxTipinEugMJWj6IQLWgGC4o6j8F4tRB/nppTrvrCA5RVxEQSE368JeSuQBEFiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783646401; c=relaxed/simple;
	bh=SUil1jMFAUbO2hOUlJTuFsrtDwHXhw41oXX8DeL9ZfA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TFsJyordEQGFQUBO1rJH3o/ou8lbgo7cGrDmw+2HWE1bxlz7faODmK1RWJoDJ9tzkPK9LzIV+MbDHOJney1UzfHACdZCXv0WHTTTehHq5x41qkogHRewFh0YDyJ16QLyQir6ZQdbSWlUUo6ULOh/BXsEevg0iyEYuNp2LJfKgQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DtDVdHiW; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DtDVdHiW"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2cc6ae3e7f1so2162345ad.0
        for <bpf@vger.kernel.org>; Thu, 09 Jul 2026 18:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783646399; x=1784251199; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=o1rD6Pk1nfn1uMSACm9d58komzrKNW2qo5mOYfOfH9U=;
        b=DtDVdHiWqX2QTvivItXMths8JJB/c/P2zlOuh+cD4eh9v0aPX+YhWzpU5JOg0GJpXI
         hr7YF2fu2JaY/bXufxK9HWR3wYKoM38KYhkdsglMx7q7O1woKuE0rUnaWw9ehE/SXMvb
         a/BbTBOuRk3ut5yHtLgRMXBWJ0b5aWHZzCAsX7zgQM1c8Siv7RKR2xD6D1isM967owsv
         L6limUJEX5S4apN+9EgHo/FPbAo9Mi/IMKUlfeFMRm5jxznw+VYPbnsUMhxs7GT+xxZH
         ob28SbhJciy8uNjX0Ivqf/jvfsT/3WbvK9QOQaoSqxto6j7gYn3FpXpycRI/uqtXo+RF
         Z81A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783646399; x=1784251199;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=o1rD6Pk1nfn1uMSACm9d58komzrKNW2qo5mOYfOfH9U=;
        b=sN8OFZXchcvKSaWNPAdxBOvxdJyJnin4yD6Xs2+UpGLrIbvW/tzERTC29e/IlsfnM1
         m5YfvbFo7340UYSw8wwBFYVkuUs69j+u21k2NNWSzLdMW7UEeSU75qnydlS9SL1L9d1C
         pfdwJHGIUKDf7tIh2uTesiIyMbhmdEFd18IfvoKlUuhc5Kk2I+cO5csadOFB2ur6awtx
         NUzt7ZiUXCwvXuOdZJ5ATCfs2i4q1LOuVg3BcC5srf5S6CmCAqe/Sh4RemOtBENuv6I+
         9mBwXEgRM8T+OwH+OIb0gpKglc8/nAlaGKzoP8Y0/zB6XdiSCfIXc5RTNFZxtcifX+CJ
         TFAw==
X-Forwarded-Encrypted: i=1; AHgh+RrigmKNWDwshh3KGtkesL7pxV7Zxp4DMtAE4z25T6r449BNE91ztNC0qDyl6FvnwIbAvJ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVQdnHC0wmhjORzw81YwH2gK6Ccu0RStNRRWnkpAT/rfHbFvBe
	Py9NApCYwT1No8y1qX1MIQnb87kz8skq+l6gTgGtZ/XEAsivihYEwrWtFb8dkw==
X-Gm-Gg: AfdE7cnxR7HozsKTf0/zXp5UZo9zFPO0NFaEGW1sJbZtMy2E28vZMJK6JOIyG4gg6Y8
	E6I6FWoY09Ba/9I7zkfD6xooVgm9OIOB+p9XgbJzHZcNm3poVenNpAt/j8I4q0j0x/nQwOfH1ou
	48s1aS7E4GbzE8xckkTlddMHHstkpY6GcznaiYn1aceGYTqxRxyk1ObDQj3CEAVjhHllEg5MZ5x
	o5DflBMSE/uJnXOUdCxHySZebUc03yPgMqVi2BhVjM/Jgam3I9Tb85AUfuZEFRbZzd6VGRgXwmX
	zTLgU88VIES/Q0ilVhe08cFshSzmyQwiCBszxAR5cozpUPhyV9izsaSyNU7nkJh6Ma5KufDeF5I
	lClFmKezdOyVXtDAimHhjqPug58IzL9QeIwNfWcVxQeO2S4hvvS/FzpBljwSkdI+HExoRy8QMmq
	gMad40PngVWKgvzKhst1imE1KwdkJk1nRrLWWNW3Kj
X-Received: by 2002:a17:902:f68d:b0:2c9:c517:d078 with SMTP id d9443c01a7336-2ccea42e1efmr91898815ad.36.1783646399330;
        Thu, 09 Jul 2026 18:19:59 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9d3bc1fsm51477485ad.55.2026.07.09.18.19.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 18:19:59 -0700 (PDT)
Message-ID: <cd58c8e1e7265ab59dff6882a2e429da97077fd6.camel@gmail.com>
Subject: Re: [PATCH bpf-next 09/12] selftests/bpf: Add C tests for 16-byte
 returns in R0:R2
From: Eduard Zingerman <eddyz87@gmail.com>
To: Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>,
 kernel-team@fb.com
Date: Thu, 09 Jul 2026 18:19:56 -0700
In-Reply-To: <20260708201025.2160583-1-yonghong.song@linux.dev>
References: <20260708200939.2153664-1-yonghong.song@linux.dev>
	 <20260708201025.2160583-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-07-08 at 13:10 -0700, Yonghong Song wrote:
> Add selftests that exercise a 16-byte return value passed in the R0:R2
> register pair, expressed in C so they rely on the compiler lowering the
> register-pair return. Tests include an __int128 return (from a subprogram
> and a kfunc), a 16-byte struct return (from static and global subprograms
> and a kfunc) and a 16-byte union return.
>=20
> The R0:R2 return convention is only emitted by LLVM 23 and newer, so the
> programs are gated on __clang_major__ >=3D 23; with an older compiler the=
y
> return a sentinel and the "int128_c", "struct_c", "global_struct_c",
> "kfunc_struct_c" and "union_c" subtests are skipped.
>=20
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> ---

[...]

> +static void run_prog(struct bpf_program *prog, bool may_skip)
> +{
> +	char buf[64] =3D {};
> +	LIBBPF_OPTS(bpf_test_run_opts, topts,
> +		.data_in =3D buf,
> +		.data_size_in =3D sizeof(buf),
> +		.repeat =3D 1,
> +	);
> +	int err;
> +
> +	err =3D bpf_prog_test_run_opts(bpf_program__fd(prog), &topts);
> +	if (!ASSERT_OK(err, "test_run"))
> +		return;
> +
> +	if (may_skip && (int)topts.retval =3D=3D -1) {
> +		test__skip();
> +		return;
> +	}
> +
> +	ASSERT_EQ(topts.retval, 0, "aggregate_ret_result");
> +}
> +
> +void test_aggregate_ret(void)
> +{

The test_aggregate_ret()/run_prog() duplicate functionality provided
by the __retval tag from test_loader.c. To achieve the same skipping
mechanics I suggest to:
- extend test_loader.c / bpf_misc.h with a new tag: __skip("reason")
- use this tag as:

  #ifdef __clang_major__ >=3D 23

  SEC("tc")
  int aggregate_ret_test(struct __sk_buff *skb) { ... }

  #else

  SEC("tc") __skip("... need clang23 ...")
  int aggregate_ret_test(struct __sk_buff *skb) { ... }

  #endif

[...]

> diff --git a/tools/testing/selftests/bpf/progs/aggregate_ret_int128_c.c .=
..
> diff --git a/tools/testing/selftests/bpf/progs/aggregate_ret_struct_c.c .=
..
> diff --git a/tools/testing/selftests/bpf/progs/aggregate_ret_union_c.c ..=
.

Nit: all three files can be merged into one.

[...]
