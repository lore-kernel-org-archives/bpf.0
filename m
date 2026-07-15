Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 607D73D34B3
	for <bpf@vger.kernel.org>; Wed, 15 Jul 2026 21:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784151664; cv=none; b=gC4QpEugPK17PLcRbKs8fftv5eDvLdOz4r5R00UrhNIcEIoXIeD+S407G6ElPFgsHrfIfC9k7o/j6rwTaOfjIk35pCYeRtww5VBXI/lYxMRWxU7dDaIc0Gq2FSP1/Pow0SRLGvrkxOV6DOkTQoS3TbvFqjXTKajUzrnQyfTM/A8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784151664; c=relaxed/simple;
	bh=zq0I5qk5hP0VPhPf04laI8HrhxkLl8p5PZFWdIVIm5c=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=FH76/9T2v9SiieJgq1AI9bxwRskTozCPz1UCaHuummTLW2WQN1CEaOb43EGGdy7FQFgwLWM0iC8Mo1XezCKAajB0t0mCsi0Xs7sDJIgCBhCYunqpaCbVkxar8kJEXQHarUdxdKpaQtyrw0iPUXRv7tBdYnQfvYlMOhhqr4C6WEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=gs0SpCTa; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="gs0SpCTa"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-493e8d4f4dcso43475095e9.0
        for <bpf@vger.kernel.org>; Wed, 15 Jul 2026 14:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1784151661; x=1784756461; darn=vger.kernel.org;
        h=in-reply-to:references:from:to:cc:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=VBgodXPKQuUMriRytvZ6LOP5ecvhprUS0jAzk/7/d7Q=;
        b=gs0SpCTaOtu3KRuh3o00He8U4z38artp7UeNda4FqDGczd/RLQVOA4/w+HB5qc38jr
         SycTd210TUmvkMXfsHUvUE7AlFBPzbOeCaCOajbo+JM1yUaez2JWdB3fdNgFUdFc7vW7
         fvCtQvnh97kjod5ptDU5zQxBNOXperFmcECku05gcfryEx6kn/y3k1bWqnRaqKjKkL9u
         Ry9XoKwUlmhciFr9N7JEdj9Lj+Z7sdg2+r45jUvlwibyBEcbiLQ/X3JtfymHPmWK2/vB
         iG3442iBSHN37HqL+7DUlJDHNVwqqFlnVCw6roKE3fZCPFEZGGNS2L97otClIPNXJJP3
         SLNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784151661; x=1784756461;
        h=in-reply-to:references:from:to:cc:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VBgodXPKQuUMriRytvZ6LOP5ecvhprUS0jAzk/7/d7Q=;
        b=LGrRtLmOAgiHw6OA0FKF+NnCILOcw6VvhtwhiR/33BLciwdNHPjd/FSu8Z8iS60L37
         k3hkWki6J3/oGRlP0M/X4jleNPKF4bHOOtcvdjCrsdwEALlRonGrkndyW2W6M4n4Eoa0
         d0oNNIqenhSgTseoMO4zgWwrbAdL/jk4DzxBwyFPM+eO/GS10ir4zYWVYlG5FA84Hlqz
         p+neonW5DGBdvTvIKaIpM9qXPiuq8wrfE0wBdDbCv993cTfYOtRpWlsDgs9VFAbXFweM
         eFb2N5mGu1FTaaMRqnFT83Xvu9L6C6WTujVzZYh8yo931QgFpnT2lY2pkzEY9KfEn6Z3
         sIXQ==
X-Gm-Message-State: AOJu0YyKWRmZT4Ec8ZIJGclavz/CIgloxG38HrKoMG4L4ieKYruSK5vI
	WaaPnePhxW323eqADSfPVZNLKFBn2SJf4E1lg/zTP7TZM8WlO9TpTXFhXAMOJyxNiI0=
X-Gm-Gg: AfdE7cmWy0j4rhlsoEHmwTjSGkCZvEIjDm6ji6IXfdW9OmYeloKaZ5JdRIXcnQQO+Jp
	IvIyCgs56pB1P3/zGVTAAS48nMOyNzVfM54/M1atQSA3lF3Tf/2U9stzrsJForvZrMRoA0FzISF
	hx4zyJj0blbll5jd3oCh6mcSZfRWOhLWWgi8RQjl/YLgJXQPTKZ8oysWp6mG8hTtHSEZJNra6ZG
	iFsb8mkIVFO3OSbsYxqwO/QoUY5b1yFfqEAi/1EnyzCftLyj+cP/RuNV9MF9qLfLYM6sP6Ep4Jl
	YKeb/iKZLuRxPUr+D4xGkBafFcZgv1Q2WPvJdlmWx6/RrDHYec5mDz5DaFYYMITvdkcl7JvlBuY
	EZCWtipZpJ+X2YimPF2L/dN3lNjJwapiwQrzmkIn6QdhAau60plly9nG3ZyqKKavB
X-Received: by 2002:a05:600c:350a:b0:493:bb23:152a with SMTP id 5b1f17b1804b1-4953c28868emr49257555e9.34.1784151660586;
        Wed, 15 Jul 2026 14:41:00 -0700 (PDT)
Received: from localhost ([2804:7f0:b765:c3e:eeab:5970:313d:2132])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81e7cb44c06sm155311497b3.25.2026.07.15.14.40.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 14:40:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 15 Jul 2026 18:40:57 -0300
Message-Id: <DJZGZ8AG04SO.1G3LGDU8VGRI0@suse.com>
Subject: Re: [PATCH 1/4] selftests/bpf: Install bpftool where test_progs
 expects to find it
Cc: <bpf@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
To: =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
 =?utf-8?b?UmljYXJkbyBCLiBNYXJsacOocmU=?= <rbm@suse.com>, "Alexei
 Starovoitov" <ast@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>,
 "Andrii Nakryiko" <andrii@kernel.org>, "Eduard Zingerman"
 <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, "Martin
 KaFai Lau" <martin.lau@linux.dev>, "Song Liu" <song@kernel.org>, "Yonghong
 Song" <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>, "Emil
 Tsalapatis" <emil@etsalapatis.com>, "Shuah Khan" <shuah@kernel.org>, "Ihor
 Solodrai" <ihor.solodrai@linux.dev>, "Christian Brauner"
 <brauner@kernel.org>
From: =?utf-8?b?UmljYXJkbyBCLiBNYXJsacOocmU=?= <rbm@suse.com>
X-Mailer: aerc 0.21.0-146-g87073a0460e3
References: <20260710-selftests-bpf_fixes-v1-0-aa24dfd6f4f9@suse.com>
 <20260710-selftests-bpf_fixes-v1-1-aa24dfd6f4f9@suse.com>
 <DJXJWE3X286K.16LM4LUS201ZP@bootlin.com>
In-Reply-To: <DJXJWE3X286K.16LM4LUS201ZP@bootlin.com>

On Mon Jul 13, 2026 at 12:32 PM -03, Alexis Lothor=C3=A9 wrote:
> Hi,
>
> On Sat Jul 11, 2026 at 12:09 AM CEST, Ricardo B. Marli=C3=A8re wrote:
>> bpftool_helpers.c looks for bpftool at "tools/sbin/bpftool" or
>> "../tools/sbin/bpftool" relative to the running test_progs binary, match=
ing
>> the build directory layout where bpftool sits at
>> $(OUTPUT)/tools/sbin/bpftool.
>>
>> INSTALL_RULE installs bpftool through the generic TEST_GEN_PROGS_EXTENDE=
D
>> mechanism, which flattens it straight into $(INSTALL_PATH) and loses the
>> tools/sbin/ prefix. After "make install", every flavor of test_progs,
>> including the default one, fails to locate bpftool, and bpftool_maps_acc=
ess
>> and bpftool_metadata error out with "Failed to detect bpftool path", eve=
n
>> though bpftool itself built and installed fine.
>>
>> Explicitly install bpftool under tools/sbin/ in the installed tree
>> so its relative location matches what detect_bpftool_path() already
>> expects, restoring the pre-install layout instead of introducing a
>> new one.
>>
>> Fixes: f21fae577446 ("selftests/bpf: Add a few helpers for bpftool testi=
ng")
>> Signed-off-by: Ricardo B. Marli=C3=A8re <rbm@suse.com>
>
> I did not face the issue because I am running the selftests in-tree, and
> the CI seems to do the same, but for users using selftests after running
> `make install`, I guess the change makes sense.
>
> That's not the first fix aiming to improve bpftool
> detection/installation (eg the BPFTOOL env variable, see [1]), so it
> makes me wonder if we shouldn't just make bpftool part of
> TRUNNER_EXTRA_FILES for all flavours of test_progs, similarly to other
> binaries needed during tests (eg: urandom_read), instead of just adding
> some bpftool-specific details in this generic install rule, and just
> make the test runners assume that the needed binary is in the same
> directory.

I'm not sure TRUNNER_EXTRA_FILES can be used like that, because it gets
reset in test_maps definition. But maybe we can use a symlink like
what's done in $(USE_BOOTSTRAP)bpftool

>
> Alexis
>
> [1] https://lore.kernel.org/all/20260223191118.655185-2-ihor.solodrai@lin=
ux.dev/
>
>> ---
>>  tools/testing/selftests/bpf/Makefile | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selfte=
sts/bpf/Makefile
>> index b642ee489ea6..47911c9b4977 100644
>> --- a/tools/testing/selftests/bpf/Makefile
>> +++ b/tools/testing/selftests/bpf/Makefile
>> @@ -1055,6 +1055,8 @@ endif
>>  DEFAULT_INSTALL_RULE :=3D $(INSTALL_RULE)
>>  override define INSTALL_RULE
>>  	$(DEFAULT_INSTALL_RULE)
>> +	@mkdir -p $(INSTALL_PATH)/tools/sbin
>> +	@rsync -a $(if $(PERMISSIVE),--ignore-missing-args) $(TRUNNER_BPFTOOL)=
 $(INSTALL_PATH)/tools/sbin/
>>  	@for DIR in $(TEST_INST_SUBDIRS); do				  \
>>  		mkdir -p $(INSTALL_PATH)/$$DIR;				  \
>>  		rsync -a $(if $(PERMISSIVE),--ignore-missing-args)	  \


