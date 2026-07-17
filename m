Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B59C22F6577
	for <bpf@vger.kernel.org>; Fri, 17 Jul 2026 17:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784307802; cv=none; b=hPt54gj6TPcMX1+06ABCzYIECjTmIsogpJ8noEaZcUBd/nCaSHmeIBIV6lIaSb6lxZr6dGXV5m54pAzyy8c0R4vbaw83xX0moyyk7oWVNhZcJc9v0s5yJTOgwS+Jhk/8sfT0eZdfpnjK7X20/M5HUMdReHH5eCBGpb3609+dvTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784307802; c=relaxed/simple;
	bh=Aqjs+/wvnc+XzflDewUf4sPZ/OtPVPmwqw20is6P0LM=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=gHfcNgEQOJlHu/ggjwM6hlX0b/8vzJM70i5CRyeFBufWuR6BmZjEO1Y+y2HPjxZXkI5F44a8Rsbk96TuFnxgt4IRncnY7kmsZRMkBN0LI6hAt0Q99CB8hTuhnDuivkc9V+hgXzF3ZUu1DapLzQRGvmmEywxZyRD/zVcfABVI5WY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=UK3xrn0E; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="UK3xrn0E"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4954f5e8020so971645e9.2
        for <bpf@vger.kernel.org>; Fri, 17 Jul 2026 10:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1784307799; x=1784912599; darn=vger.kernel.org;
        h=in-reply-to:references:from:to:cc:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=RYPHV4wIJq80HGDRpAYn0wJ8L1LNh/JSkEkUvyvSxrw=;
        b=UK3xrn0EuM9nKGIlVwQpowy0fdmJcxaMskPz1QHUTNfrbLKkleDE/cQLQmWq1R/obx
         X2JC3lnFEgKFoyzhc79impAfiyoz93/tpprmbLLqu0MDPNTXcbGuRIXh1b+vNnGSjRib
         ol5ad8r2HQE5KJYOOAEx2fMbtMOfVdee6JxTonZkww+kbCU3IHl1g7XHd7i7B3H3X62N
         M6RZG6oDLGqNI8Ro/Vn5zokZbbgaoe9xcGr6y5Rgp9LO0QJKMORMH8RqOA8kvWZ7G4t8
         IHfC2Qax/g+qcG3+o19MEs5EXrPV6m267fZvMZAIA44ww/GFEpFN0dj1a6LYCCyiRxpg
         J6lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784307799; x=1784912599;
        h=in-reply-to:references:from:to:cc:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RYPHV4wIJq80HGDRpAYn0wJ8L1LNh/JSkEkUvyvSxrw=;
        b=iCX9PC9Mo+lBfHPXlljS29V3NLTCG5kQMg2VraFOA/2+UfB5hrE4lKqvEy+Pf0Mn56
         9dvFRvfWw5YcqhkVHQINKzgeGuwFs2BZfG66BIRGreQco075mIFPgEpcwuDvDpqUhwXM
         KaPkmoOC/npi0AuHlyKBmHjYIX93KLBGFswAkKVxTlcE7obt/B2PNU5BzUrx1tZpBuwX
         A2tO0GnLKCOLoP2XCpIKWdlNIfD0EgxRbP2hs5wkqf8ulu3/S3H9l7yp4eb0PvccI+Sn
         nZvdMnZ22X7f8ZaLHPIZNN/l1TFWfcv2AL8hj7qY74uA3PN4eoWb9QmVE2YFZ+bJHsMb
         YIWw==
X-Gm-Message-State: AOJu0YyRxuacZinLexrQzmmieODCKCBSUGXQh6/KYmeTVCB42GQQNPgY
	CLVKHwHOLPlOYKYZSKaXDbySqGdWxZfwwHtdJAymZZO7bdkYddT+NaUhlYQb0w5YGJw=
X-Gm-Gg: AfdE7cmLwaV2gYjgMmRah97lj75WsrhOyrr/+/rY4ZkfvU72g0blL3GeLedrjun07V9
	SJLtfDYAuSJWphSuLatrFiLB1e1tv1iq/AdgrTVieMRzVj90uCdcfNtO7mLJzmmsHAz2UlEfVqZ
	2MrgMmAmKlKToRVKycU4QeA9MEpUeoaIYqvEZDNHCnas1fqE/kTCQ/5iay0jGVrXnX0cNfPMuUy
	XmvE9Sh77CGDE6wd3Zp0xpKjH8lVdmK3rewt7UkRdrmNrKURE9RFfcAyiVr21AOzJTIw9L1nkhG
	6NR+to7UiyaKvUxOF+xVifDNw8PjiwVjTyg0fKwsxhVeq+u/Jp6nBH+Pg6Hjo5r0mlG43PAJFrA
	OeZb2OV0XftbgK4N44u8XNYBL27ODSjzwklBywLVYju/KhrFfJjvhRGqdJWfphhmP
X-Received: by 2002:a05:600c:3143:b0:492:7142:f46e with SMTP id 5b1f17b1804b1-4954a3d0cd7mr45427135e9.2.1784307798858;
        Fri, 17 Jul 2026 10:03:18 -0700 (PDT)
Received: from localhost ([2804:7f0:b765:c3e:eeab:5970:313d:2132])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81ef42722d7sm14849437b3.31.2026.07.17.10.03.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 10:03:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 17 Jul 2026 14:03:16 -0300
Message-Id: <DK10BPLJ94CD.153PFYJP3M2Z8@suse.com>
Subject: Re: [PATCH 1/4] selftests/bpf: Install bpftool where test_progs
 expects to find it
Cc: <bpf@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
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
From: =?utf-8?b?UmljYXJkbyBCLiBNYXJsacOocmU=?= <rbm@suse.com>
X-Mailer: aerc 0.21.0-146-g87073a0460e3-dirty
References: <20260710-selftests-bpf_fixes-v1-0-aa24dfd6f4f9@suse.com>
 <20260710-selftests-bpf_fixes-v1-1-aa24dfd6f4f9@suse.com>
 <DJXJWE3X286K.16LM4LUS201ZP@bootlin.com>
 <f3a5c7dc-6731-4a3e-b8bd-909c0fff4520@linux.dev>
In-Reply-To: <f3a5c7dc-6731-4a3e-b8bd-909c0fff4520@linux.dev>

On Thu Jul 16, 2026 at 6:09 PM -03, Ihor Solodrai wrote:
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
>
>>=20
>> Alexis
>>=20
>> [1] https://lore.kernel.org/all/20260223191118.655185-2-ihor.solodrai@li=
nux.dev/
>>=20
>>> ---
>>>  tools/testing/selftests/bpf/Makefile | 2 ++
>>>  1 file changed, 2 insertions(+)
>>>
>>> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selft=
ests/bpf/Makefile
>>> index b642ee489ea6..47911c9b4977 100644
>>> --- a/tools/testing/selftests/bpf/Makefile
>>> +++ b/tools/testing/selftests/bpf/Makefile
>>> @@ -1055,6 +1055,8 @@ endif
>>>  DEFAULT_INSTALL_RULE :=3D $(INSTALL_RULE)
>>>  override define INSTALL_RULE
>>>  	$(DEFAULT_INSTALL_RULE)
>>> +	@mkdir -p $(INSTALL_PATH)/tools/sbin
>>> +	@rsync -a $(if $(PERMISSIVE),--ignore-missing-args) $(TRUNNER_BPFTOOL=
) $(INSTALL_PATH)/tools/sbin/
>
>
> It looks like we still have a redundant copy of bpftool because of:
>
> selftests/bpf/Makefile:327
>
>         TEST_GEN_PROGS_EXTENDED +=3D $(TRUNNER_BPFTOOL)
>
> selftets/lib.mk:153
>
>         $(eval INSTALL_LIST =3D $(TEST_GEN_PROGS_EXTENDED)) $(INSTALL_SIN=
GLE_RULE)
>
> Ricardo, does it makes sense to remove it with your fix?

I'll check and send v2 accordingly

>
> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftes=
ts/bpf/Makefile
> index 7260d672acf7..c776913bc32f 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -324,8 +324,6 @@ TRUNNER_BPFTOOL :=3D $(DEFAULT_BPFTOOL)
>  USE_BOOTSTRAP :=3D "bootstrap/"
>  endif
> =20
> -TEST_GEN_PROGS_EXTENDED +=3D $(TRUNNER_BPFTOOL)
> -
>  $(TEST_GEN_PROGS) $(TEST_GEN_PROGS_EXTENDED): $(BPFOBJ)
> =20
>  TESTING_HELPERS        :=3D $(OUTPUT)/testing_helpers.o
>
>>>  	@for DIR in $(TEST_INST_SUBDIRS); do				  \
>>>  		mkdir -p $(INSTALL_PATH)/$$DIR;				  \
>>>  		rsync -a $(if $(PERMISSIVE),--ignore-missing-args)	  \
>>=20
>>=20
>>=20
>>=20


