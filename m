Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0EB23B7751
	for <bpf@vger.kernel.org>; Mon, 20 Jul 2026 07:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784532274; cv=none; b=AZ19VfQYX3lgiuVt8ZqMvNIW/iwwF/meROdFBlMqPZq36HbTHcaEcNn7LUhVNPTpCGNIhVCtGEUEe5BM+vxA6Z6/Y06KxU1txwXdSdGfFLTphMFnnehPv4nzZQDpaGV0nuKMDZ0TOxVPSdV9pbwZJ+gg+XqSIcxi+87VjDAqvmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784532274; c=relaxed/simple;
	bh=xG3jBF/2XG87NZanEpdB0L/KCwiHNiowQsA+VJruadU=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:From:To:
	 References:In-Reply-To; b=YNfJa5ZafWvI61wqea7JtAXrvad+gtztv/UyGG+i7w2dBR66kRZI49uTriT7blLEIyOw8RdS8CXCSN7CuYsfY0HNdsiLxSuZ0ZweoI5pVW0hV6l7qsQTTao50RgCbf4iv8mMMKHc6YMtCOyFtHloV5E9GZOfdisLX2YTRVN3bIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=FTRj/rwF; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="FTRj/rwF"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 11DE94E40E7D;
	Mon, 20 Jul 2026 07:24:27 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id D07EB60360;
	Mon, 20 Jul 2026 07:24:26 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8DE1D11BD14B3;
	Mon, 20 Jul 2026 09:24:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1784532265; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=xG3jBF/2XG87NZanEpdB0L/KCwiHNiowQsA+VJruadU=;
	b=FTRj/rwFDWRp/v43DbHWV+kYGt9bgyjq073poKKsZjISXKp/Xk9T1LUdoC8UPmsyMNi6N9
	dl7vcVDUIeqWyy8lSsSdDyyXhwtNI0SzGVW8xkmP6wG5k+3ZqrLYU4bokstESQgvZGqNv0
	84O06UKHTDoxMhn9W/S6+/8cQfVxhdlov81hHQ67DKZO0DSbIr+9ZZC6cFYCCD6LjXfR2S
	EssdsSwwIm3oX4n5pFFbiNNkXMsObgrvKVG6HgBphhgkYzBi7NvYRtKi8N0gQfHe595jpA
	eUcKct1viLg+8VaWZ0PSTN45fS7vuHmbzGKbECqX3+fX1Ck2H84nIgSEdWMP8g==
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 20 Jul 2026 09:24:21 +0200
Message-Id: <DK37W3ML3YOU.6MWJW8H8S2GI@bootlin.com>
Subject: Re: [PATCH 1/4] selftests/bpf: Install bpftool where test_progs
 expects to find it
Cc: <bpf@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
From: =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
To: "Ihor Solodrai" <ihor.solodrai@linux.dev>,
 =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
 =?utf-8?b?UmljYXJkbyBCLiBNYXJsacOocmU=?= <rbm@suse.com>, "Alexei
 Starovoitov" <ast@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>,
 "Andrii Nakryiko" <andrii@kernel.org>, "Eduard Zingerman"
 <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, "Martin
 KaFai Lau" <martin.lau@linux.dev>, "Song Liu" <song@kernel.org>, "Yonghong
 Song" <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>, "Emil
 Tsalapatis" <emil@etsalapatis.com>, "Shuah Khan" <shuah@kernel.org>,
 "Christian Brauner" <brauner@kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260710-selftests-bpf_fixes-v1-0-aa24dfd6f4f9@suse.com>
 <20260710-selftests-bpf_fixes-v1-1-aa24dfd6f4f9@suse.com>
 <DJXJWE3X286K.16LM4LUS201ZP@bootlin.com>
 <f3a5c7dc-6731-4a3e-b8bd-909c0fff4520@linux.dev>
In-Reply-To: <f3a5c7dc-6731-4a3e-b8bd-909c0fff4520@linux.dev>
X-Last-TLS-Session-Version: TLSv1.3

On Thu Jul 16, 2026 at 11:09 PM CEST, Ihor Solodrai wrote:
> On 7/13/26 8:32 AM, Alexis Lothor=C3=A9 wrote:
>> Hi,
>>=20
>> On Sat Jul 11, 2026 at 12:09 AM CEST, Ricardo B. Marli=C3=A8re wrote:
>>> bpftool_helpers.c looks for bpftool at "tools/sbin/bpftool" or
>>> "../tools/sbin/bpftool" relative to the running test_progs binary, matc=
hing
>>> the build directory layout where bpftool sits at
>>> $(OUTPUT)/tools/sbin/bpftool.
>>>
>>> INSTALL_RULE installs bpftool through the generic TEST_GEN_PROGS_EXTEND=
ED
>>> mechanism, which flattens it straight into $(INSTALL_PATH) and loses th=
e
>>> tools/sbin/ prefix. After "make install", every flavor of test_progs,
>>> including the default one, fails to locate bpftool, and bpftool_maps_ac=
cess
>>> and bpftool_metadata error out with "Failed to detect bpftool path", ev=
en
>>> though bpftool itself built and installed fine.
>>>
>>> Explicitly install bpftool under tools/sbin/ in the installed tree
>>> so its relative location matches what detect_bpftool_path() already
>>> expects, restoring the pre-install layout instead of introducing a
>>> new one.
>>>
>>> Fixes: f21fae577446 ("selftests/bpf: Add a few helpers for bpftool test=
ing")
>>> Signed-off-by: Ricardo B. Marli=C3=A8re <rbm@suse.com>
>>=20
>> I did not face the issue because I am running the selftests in-tree, and
>> the CI seems to do the same, but for users using selftests after running
>> `make install`, I guess the change makes sense.
>>=20
>> That's not the first fix aiming to improve bpftool
>> detection/installation (eg the BPFTOOL env variable, see [1]), so it
>> makes me wonder if we shouldn't just make bpftool part of
>> TRUNNER_EXTRA_FILES for all flavours of test_progs, similarly to other
>> binaries needed during tests (eg: urandom_read), instead of just adding
>> some bpftool-specific details in this generic install rule, and just
>> make the test runners assume that the needed binary is in the same
>> directory.
>
> Alexis, using TRUNNER_EXTRA_FILES is a bit worse because that would
> copy bpftool into every flavor subdir. I think just doing a single
> rsync on install is fine.

Indeed, ok then :)

Thanks,

Alexis

>>=20
>> Alexis
>>=20
>> [1] https://lore.kernel.org/all/20260223191118.655185-2-ihor.solodrai@li=
nux.dev/
--=20
Alexis Lothor=C3=A9, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

