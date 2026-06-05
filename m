Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C293101CE
	for <bpf@vger.kernel.org>; Fri,  5 Jun 2026 16:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780675286; cv=none; b=uV1RUkxA44I2a5hfXqxi7BWYoz7OM3AMzV+xU19oyRjsuzV2Ou8fesP70IBsYK9K/RzvFABNBdOp8ipshsLf2pB7LjGSSGia8tJt5GbuuSqvp/okUU0fcUE6i2eJUs/QCJbbSZaoiUNCKhClc+2tBBOfgXQAm2GPWpUMoaJyVfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780675286; c=relaxed/simple;
	bh=4SHwRJf3A0KTMl1ohPbzMkgClu49cZQGkWKbFTV02ek=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:From:To:
	 References:In-Reply-To; b=YMFok3s1YGoU0Hj+wwc6mrnmViSi6aJfQGhapH34xrd8bSbwf/c1/CPfFAxlCBm7Dz19SteCIH5oJb/UKRnFe1hKbifSv78aAnRPTky3N9JWicJVfDeNHgVLOtiF74iWzrITBbxMYM78O6SxUwgd9dLaLlvKLsxEhpH0CPnB0xI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=aKf/6ctG; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="aKf/6ctG"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id B0AB8C58476;
	Fri,  5 Jun 2026 16:01:22 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id C8EEB5FED1;
	Fri,  5 Jun 2026 16:01:22 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A1167106A252C;
	Fri,  5 Jun 2026 18:01:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1780675281; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=yZoPOqViDfS1ZaI7CjlclPfaVfp0hwRDdItmht55EEI=;
	b=aKf/6ctG9t/yPGcfoTJ9gphRxx+xRgto8JRT9kZ7mJy8y6Q4YabfcLOUTB/vsucB/M/VXK
	EZ3DvYEVjXFEBn/NYWNuDq3I+8cgFW9jPFXfEEpYSwsDyUNtbMMkqiP32pJ9PvrAwQtqz3
	8tVPEzvj9W0qcNj6AwEK8nHUc5aW0zl1zF6AoaEzpIQT8Ay0G+fFlsvYOYV0OsqS+Iix+o
	NktDJvpeDGZ+nZKWs6pK3jt45/PETYDs/FAWkyh6jKk80L1seulIdVo7X8hlsBr03q+Ocp
	CGFNfBZE8FwkjODbf6nZV/pOWKDjdaDD2OWADJ7IrnCXxG17zU1z5Rz6LpRWtg==
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 05 Jun 2026 18:01:16 +0200
Message-Id: <DJ18PD6QWGA2.2HOYGKU7RUB68@bootlin.com>
Subject: Re: [PATCH bpf-next v2 8/8] selftests/bpf: add tests to validate
 KASAN on JIT programs
Cc: <ebpf@linuxfoundation.org>, "Bastien Curutchet"
 <bastien.curutchet@bootlin.com>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>, <bpf@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
 <linux-stm32@st-md-mailman.stormreply.com>,
 <linux-arm-kernel@lists.infradead.org>
From: =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
To: "Yonghong Song" <yonghong.song@linux.dev>,
 =?utf-8?b?QWxleGlzIExvdGhvcsOpIChlQlBGIEZvdW5kYXRpb24p?=
 <alexis.lothore@bootlin.com>, "Alexei Starovoitov" <ast@kernel.org>,
 "Daniel Borkmann" <daniel@iogearbox.net>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Martin KaFai Lau" <martin.lau@linux.dev>, "Eduard
 Zingerman" <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>, "Song Liu" <song@kernel.org>, "Jiri Olsa"
 <jolsa@kernel.org>, "John Fastabend" <john.fastabend@gmail.com>, "Thomas
 Gleixner" <tglx@kernel.org>, "Ingo Molnar" <mingo@redhat.com>, "Borislav
 Petkov" <bp@alien8.de>, "Dave Hansen" <dave.hansen@linux.intel.com>,
 <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, "Shuah Khan"
 <shuah@kernel.org>, "Maxime Coquelin" <mcoquelin.stm32@gmail.com>,
 "Alexandre Torgue" <alexandre.torgue@foss.st.com>, "Ihor Solodrai"
 <ihor.solodrai@linux.dev>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260604-kasan-v2-0-c066e627fda8@bootlin.com>
 <20260604-kasan-v2-8-c066e627fda8@bootlin.com>
 <13b87293-5237-43d3-9f91-33c13041cb43@linux.dev>
In-Reply-To: <13b87293-5237-43d3-9f91-33c13041cb43@linux.dev>
X-Last-TLS-Session-Version: TLSv1.3

On Fri Jun 5, 2026 at 5:47 PM CEST, Yonghong Song wrote:

[...]

> [root@arch-fb-vm1 bpf]# ./test_progs -n 164
> test_kasan:PASS:alloc test ctx 0 nsec
> gzopen /boot/config-7.1.0-rc5-gec86c8156bd6: No such file or directory
> test_kasan:PASS:open prog 0 nsec
> test_kasan:PASS:find rnd_hi32 prog 0 nsec
> ...
> All error logs:
> test_kasan:PASS:alloc test ctx 0 nsec
> gzopen /boot/config-7.1.0-rc5-gec86c8156bd6: No such file or directory
> test_kasan:PASS:open prog 0 nsec
> test_kasan:PASS:find rnd_hi32 prog 0 nsec
> test_kasan:PASS:load prog 0 nsec
> test_kasan:PASS:open kernel logs 0 nsec
> test_kasan:PASS:get map 0 nsec
> test_kasan:PASS:set map 0 nsec
> run_subtest_with_size_and_location:PASS:find test prog 0 nsec
> run_subtest_with_size_and_location:PASS:fetch loaded program info 0 nsec
> run_subtest_with_size_and_location:PASS:run prog 0 nsec
> run_subtest_with_size_and_location:PASS:read kernel logs 0 nsec
> run_subtest_with_size_and_location:FAIL:report should be generated unexpe=
cted error: 1 (errno 11)
> #164/1   kasan/st_1_not_on_stack:FAIL

[...]

> #164     kasan:FAIL
>
> I checked the subtest 164/1,
>
> For
>
>          ret =3D check_kasan_report_in_kernel_logs(klog_buffer, ctx,
>                                                  test->is_write, access_s=
ize);
>          if (on_stack || test->expect_no_report)
>                  ASSERT_NEQ(ret, 0, "no report should be generated");
>          else
>                  ASSERT_OK(ret, "report should be generated");
>
> the ret is equal to 1 as klog_buffer is empty. This caused the failure.

Are you seeing any kasan report when you manually check your kernel
logs, or not at all ? If not at all, are you using the "CI" defconfig ?

  cat tools/testing/selftests/bpf/{config,config.vm,config.x86_64} > .confi=
g && make olddefconfig

If not, would you mind sharing your defconfig ?

Thanks,

Alexis
--=20
Alexis Lothor=C3=A9, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

