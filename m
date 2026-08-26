Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD3C1353A8F
	for <bpf@vger.kernel.org>; Wed, 26 Aug 2026 04:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787720296; cv=none; b=HIwfJyOXc3sedE274YSuZyQCmv/g1V8J9M7dbXM/qCI53OREe/avn2cjvgkJohraPg/KUGClqgJmY1ra31RQw7MmC6hZSdXKAfKJnvi7qEJgYXtXb0Bb84hFxu1D7KFXxlAIUkTh7FVHyHpWIo9UOH2S3gYlqdH4exfVKttCtxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787720296; c=relaxed/simple;
	bh=iy1J52n4+3jkPQjALXpOlCZ9iBY6VLvxDHorWI+OuOg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=D+y9OqKBzGZkyuuexEYwGiOmegv9xH2aXsaZTGf66ZKsTjqjTXCVuFOG0V2Mq72xfQ3w9E/1+pdWoqv+RSTucI1ueTSxzM6DmYu6sFPhALvtZv6rzssq1mjb8HCOgMMPxEEhpYpqGRJD+i2MYhKWnYh0qyl4OHWMhMGVQbKNTu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d+Is5Buf; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d+Is5Buf"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2ccf2360620so5989325ad.3
        for <bpf@vger.kernel.org>; Tue, 25 Aug 2026 21:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787720293; x=1788325093; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=iy1J52n4+3jkPQjALXpOlCZ9iBY6VLvxDHorWI+OuOg=;
        b=d+Is5Bufy0fADQaTMaI0w3Q0KV3a8IcZ7ynbtIvBROPibFXx45t2FFi+lsxAj3eWWu
         EcZiPa8O/eX2DlXaHnKBTk0i0gPZ+IR+V7FkMul2U0qrlxwCSGYMiMiOWXxBwQwBbJhb
         WkIsPblWH/jjz0/KY5qKYfrdS5K12L+Hce8g+3NbMX0wuzth52Kb8Xw6C0rHY26PMPgF
         MkgTbUj77ilChiOxU6oQW54enK+xvxAV5+ma4H8tlHuPZW0AzEHLaSljwGFNrGr/B8u6
         MoMdSedUZsi1cOQoH64ChKADqp25E2CYVND1Uxx9FWwhEKDb5UcK82rwCCfJ6guLQcCC
         rnSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787720293; x=1788325093;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iy1J52n4+3jkPQjALXpOlCZ9iBY6VLvxDHorWI+OuOg=;
        b=fn7zHPqY6TIK6iUVbA6MFjNsyi7dTdOu/UfdUH2AO8qffmWVJfMRfN7C/xOhQEdQeo
         NV32iWPItrtR1bYFvkgKiyFUQ8j1C2rxtAjN0Du3fBe4BZUtKKvTx0+69VFAAfWIkatm
         nHGv4h1779F6ZT9bvndWEQpRZCNzPYtyLQGEf5z8Q8zsI/ANsyJ9ETi5e0qkhe9Vw3TU
         Xwi4Bkj8dLmgq7fj0DvVI61dSsSffrEyyYWg9XhRdscb1eCYXCdKgiGtQ3BFWB48bSJE
         MCWwRuMjriVStXH4awOrdBDGXWYWCD06PfgMFaGZPA9fmp+1cvcBBvwWJRrp9mWp2Fvd
         +wWA==
X-Forwarded-Encrypted: i=1; AHgh+RrjHwx2x0ie4wgHjvPQDZjiW7JRIYXbTSzC+wwSlG5tHrJ2ITynrSh09F3xnKfEHf20+OI=@vger.kernel.org
X-Gm-Message-State: AFuF++mQtDbmz51v6GP81vC4pS9sD870tg8QStJWb0X4rTJS8jLHlPVS
	lRL5T7zyI1A5L4T29BizSyOVOIHU9COJ84vfDCkwJW0677FYupgv8dh1
X-Gm-Gg: AR+sD11MR6aDll/X1VMuGIfjC4zVnfLGgPFoHVESP6t5pvzb5mVN3wN2jcjQLna6xuN
	a6sGnDTltjmCwywEMJ/tmk/83fF2n8iO1XRph/HqLkaH2czV55kUMTH1RfpnGBNuCR/G2Waieko
	gvq+RIxGbWZ5QTzlmbJIMZGJpsMJiB/Ax4COsmH0UpQMkFX2rSaXScw0gv/DPGK3Q9W+8dz4osG
	VZfQN9Y72f+/0dJvQARvcbzd4iYIPn7h9uBoK7/zw+dqq/8tDtLoiPKUDXfCRGW/LncrM/bbHsO
	oavfp8fiw+0N1N5FAFbbkCzyFB7Xyi/8DcHIIa6JqzioZrdD9Z/WXUZbHFtBN0D/rAThex56fGA
	3srkR6I8xKPIJmONON80sf8PREG74UEk/reybjsNlLT2R1IZxMCa0qAzuDzUX1Kdpz1tM4/IJ/j
	21taqwWdjAu7oFJvgKRHmnb5vMxTfPEEgcVXJuga5VnljI82rjgPiAGF/M/5O8OCiM8KitJPsvk
	U3wp11qUkLyCwLB
X-Received: by 2002:a17:902:d4c3:b0:2b2:67ca:5ff9 with SMTP id d9443c01a7336-2d707803e2bmr57514635ad.0.1787720292912;
        Tue, 25 Aug 2026 21:58:12 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d70493f3f5sm4124715ad.1.2026.08.25.21.58.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 21:58:12 -0700 (PDT)
Message-ID: <5eda92178e2176a0a8bf85768fd724a6df26699a.camel@gmail.com>
Subject: Re: [PATCH bpf-next v7 9/9] selftests/bpf: build each test runner
 instance in its own sub-make
From: Eduard Zingerman <eddyz87@gmail.com>
To: Mykola Lysenko <nickolay.lysenko@gmail.com>, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, 	song@kernel.org, yonghong.song@linux.dev,
 jolsa@kernel.org, memxor@gmail.com
Date: Tue, 25 Aug 2026 21:58:09 -0700
In-Reply-To: <20cda214c123d41183bb1e5f95af8c1d9dd6621e.camel@gmail.com>
References: <20260823194241.3415152-1-nickolay.lysenko@gmail.com>
		 <20260823194241.3415152-10-nickolay.lysenko@gmail.com>
	 <20cda214c123d41183bb1e5f95af8c1d9dd6621e.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-08-25 at 16:55 -0700, Eduard Zingerman wrote:

...

> I tested this patch-set for:
> - clean build within selftests directory, ok
> - minimal rebuild after progs/*.c is touched, ok
> - minimal rebuild after prog_tests/*.c is touched, ok
> - test_progs, test_verifier, test_progs-cpuv4, test_maps
> =C2=A0 all work
> - build with O=3D specified, something goes sideways:
> =C2=A0 the build completes but the tests can't be executed.
>=20
> For example:
>=20
> $ make -j O=3D~/work/tmp/tests-build
>=20
> In the vm:
>=20
> # cd /home/eddy/work/tmp/test-build
> # ./test_verifier
> Failed to load bpf_testmod.ko into the kernel: -8
>=20
> # ./test_progs -a verifier_and
> ./test_progs: error while loading shared libraries: libLLVM.so.18.1: cann=
ot open shared object file: No such file or directory
>=20
> Note the following oddity:
>=20
> [root@testhost bpf]# ldd ./test_progs=C2=A0=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 linux-vdso.so.1 (0x00007f8bf85=
d5000)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libelf.so.1 =3D> /lib64/libelf=
.so.1 (0x00007f8bf01cd000)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libz.so.1 =3D> /lib64/libz.so.=
1 (0x00007f8bf01aa000)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libm.so.6 =3D> /lib64/libm.so.=
6 (0x00007f8bf00bc000)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libzstd.so.1 =3D> /lib64/libzs=
td.so.1 (0x00007f8befff8000)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libstdc++.so.6 =3D> /lib64/lib=
stdc++.so.6 (0x00007f8befc00000)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libgcc_s.so.1 =3D> /lib64/libg=
cc_s.so.1 (0x00007f8beffca000)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libc.so.6 =3D> /lib64/libc.so.=
6 (0x00007f8befa0e000)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /lib64/ld-linux-x86-64.so.2 (0=
x00007f8bf85d7000)
> [root@testhost bpf]# cd -
> /home/eddy/work/tmp/test-build
> [root@testhost test-build]# ldd ./test_progs
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 linux-vdso.so.1 (0x00007fd8fe3=
42000)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libelf.so.1 =3D> /lib64/libelf=
.so.1 (0x00007fd8fe319000)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libz.so.1 =3D> /lib64/libz.so.=
1 (0x00007fd8fe2f6000)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libpcap.so.1 =3D> /lib64/libpc=
ap.so.1 (0x00007fd8fe2a9000)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libLLVM.so.18.1 =3D> not found
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libc.so.6 =3D> /lib64/libc.so.=
6 (0x00007fd8fe0b7000)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libzstd.so.1 =3D> /lib64/libzs=
td.so.1 (0x00007fd8fdff1000)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libibverbs.so.1 =3D> /lib64/li=
bibverbs.so.1 (0x00007fd8fdfd1000)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /lib64/ld-linux-x86-64.so.2 (0=
x00007fd8fe344000)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libnl-route-3.so.200 =3D> /lib=
64/libnl-route-3.so.200 (0x00007fd8fdf3c000)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libnl-3.so.200 =3D> /lib64/lib=
nl-3.so.200 (0x00007fd8fdf1a000)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libgcc_s.so.1 =3D> /lib64/libg=
cc_s.so.1 (0x00007fd8fdeee000)

Redid the testing with O=3D and the above issue is gone.
Probably an error somewhere between the chain and keyboard.
Sorry for the noise, O=3D works as expected.
