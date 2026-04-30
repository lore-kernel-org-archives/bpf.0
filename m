Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E8F42188D
	for <bpf@vger.kernel.org>; Thu, 30 Apr 2026 13:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777554839; cv=none; b=ZWZzDahaRmkFvO3UJuo17qB+hVs+NAeCAEQtzcpnCUUlLciBtbfpFMGSCEYSyMdERs1Qw8SDRZ+bxyNrxVUdVouF4+hU89m954zpoQmXXkKsOYdE4sM4nrCMQJH1Jr6Dlw5haQen+d+jIWGw+i5UVE5Ve8vBxLLWzOjPEE7l+gE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777554839; c=relaxed/simple;
	bh=xJjJzowTCghhIo1M1BBoQR1p6lnqeUhBs3J9/RR1jz0=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=EulS1PhqDdhwBttdCsxEHwqV3rAQgQ6lb1+cYu/BPyqii1JV1EtxuM/Brc6BzZjrKuogJnKrw1UQMvVgBv+Iu4tdScYaamApRRwgvV64i+hjg0pNKEq5UNISy95OB8o2OeX5SiAfgl2EmGnXuJi2qvks2YXs0wnlUBAqyTJWo1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=fVJ5i1Ae; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="fVJ5i1Ae"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4891b0786beso6185275e9.1
        for <bpf@vger.kernel.org>; Thu, 30 Apr 2026 06:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1777554835; x=1778159635; darn=vger.kernel.org;
        h=in-reply-to:references:from:to:cc:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zRe/Of4HXhlzR8gGS5doxSOHHPYhsd1Ia0Z7yzBuFU4=;
        b=fVJ5i1AeMcp41RtRmLNu+o+kRto0mUspGVdiWU/993NPcPfPudk8Ykc6k+OvZ0Oexj
         SsukS4hswULkGY1F30NLzYGDVCxNeK/z2evY4aeBSzNw8hO/s0bLdb/EzkKzFh+n8u6h
         leu1WwgnhgIfgOKdgRhSzUnfhpltakxBwjQkDuNzAx3wkjTj9tTxvKzQ0oKlRHSnGqiT
         BSpG42qle+dLTUCxbN41ncuqwnxpfvN3JIFJ+BzqXkwn8408zUe+jB8i0Gu3Uy+3f0Bn
         rHKFkycoOLwlMUopeJmE4tc6Ggv6anT13AnxbaMkpV+ul/MfZqzJAaEhlQAvgjndH/+5
         4SLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777554835; x=1778159635;
        h=in-reply-to:references:from:to:cc:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zRe/Of4HXhlzR8gGS5doxSOHHPYhsd1Ia0Z7yzBuFU4=;
        b=bpifm5smw+Mjkss23FX1nMaj1PuW7QiJ3+/v2X6ApSlTWZ8zLSlI5k85HuGO5hskAW
         4kjiKp649lFLn0KyU8TFqXZEpkWdYPhUNBEdQJ+2zHWQsp7VuuyC7zKwgJEnobGYRziN
         c09z6izzrTFeP2iUQtxamM+JHf61AkS9WOVCn0G+9+Jxjx3rh26ZMxfTyPqFYeQQAiUE
         gViON+RwrJ5JAb/vk5E9uur9xhZTnZPZZACsS5AGS8TKZ6kruaGeq+a/E0aertyl/ojG
         WeNV1h5kN1dAqv9Lwot/UWhFXknfqDrdGyWt8TilQt7aw4OWZ7DFPJULdrRrn+3v1BCc
         3k+w==
X-Gm-Message-State: AOJu0YxRfDsm9VXNiX8V+Oj2IJE1TC+lf4cRz94+fNq+Tbvrsx8Cj9Ym
	/EWPGjSycyQS5JeaaUNNEP3q/fsKwLNoD61elB4jgSF3WeauZJmUaqkh6NNmFuz5jTs=
X-Gm-Gg: AeBDievT18eNiHlKlhrCG/42GImUvR4nt4Iw3cac9TOlui5OX07qKvc8U9MHsTdCZ5s
	Q+k7nGC71Khpinx2thW1qqI74ibOi6oMfvbxh1r/oB1VYSWZFdzVjsRxAgGr9AVqG3VSzGX1Hct
	kMQktsfJtz72qJPtqlyUdIJSIYgTlNqSdolEVBHRfgNkmY2/LeG25G8q2DsE00z9q5H8KNos0I2
	8lIeBs/F+rE8r1JfbVafuo3BNhcI3xRC+xRB91Z6B79dh+ChfdkLn/1OQuYTDZOdoq0K5jCvk2d
	F5gn2D/Czx4zXFczR9uwXoiFdaTdtzvd6/EcnR2eN3v7/gnCHnGnvSEAaRdSX0NDNoAsDqF0o7p
	w13Md6CamsJfnF71Jka+sd7rtxW7DCHZUvZYfAFRVad4yp628XshQ9CIlPx7ECM/HTfMbcaxeHF
	M9vcIyOLkJFdbZEMqRDsHLBFEmrshkCEJ3tw==
X-Received: by 2002:a05:600c:3e8d:b0:48a:53ea:140b with SMTP id 5b1f17b1804b1-48a844a4728mr48868965e9.28.1777554834909;
        Thu, 30 Apr 2026 06:13:54 -0700 (PDT)
Received: from localhost ([2804:7f0:b765:105d:2ecf:67ff:fe81:9da0])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ed46afda3fsm3707956eec.30.2026.04.30.06.13.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 06:13:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 30 Apr 2026 10:13:51 -0300
Message-Id: <DI6ILKHKXCTR.2TAXUY0YUC5DS@suse.com>
Subject: Re: [PATCH bpf-next v10 06/11] selftests/bpf: Tolerate test file
 compilation failures
Cc: <bpf@vger.kernel.org>
To: <sashiko@lists.linux.dev>, =?utf-8?b?UmljYXJkbyBCLiBNYXJsacOocmU=?=
 <rbm@suse.com>
From: =?utf-8?b?UmljYXJkbyBCLiBNYXJsacOocmU=?= <rbm@suse.com>
X-Mailer: aerc 0.21.0-120-g22b95d38161f
References: <20260430-selftests-bpf_misconfig-v10-6-cd302a31af16@suse.com>
 <20260430131052.3E683C2BCB3@smtp.kernel.org>
In-Reply-To: <20260430131052.3E683C2BCB3@smtp.kernel.org>

On Thu Apr 30, 2026 at 10:10 AM -03, sashiko-bot wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Low] The inline condition `$(if $(V))` incorrectly suppresses the `BTF=
IDS` pretty output when `V=3D0` or `V=3D2`.
> --
>
> commit 0d69d461adbd02ed2bb765aad81f923aeaf2a8da
> Author: Ricardo B. Marli=C3=A8re <rbm@suse.com>
>
> selftests/bpf: Tolerate test file compilation failures
>
> This commit makes per-test compilation non-fatal for test_progs, skipping
> missing objects during linking. It adjusts the BTFIDS step to use standar=
d
> printf instead of the msg macro within the shell conditionals.
>
>> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selfte=
sts/bpf/Makefile
>> index 608e6dff03926..9becc077eb231 100644
>> --- a/tools/testing/selftests/bpf/Makefile
>> +++ b/tools/testing/selftests/bpf/Makefile
>
> [ ... ]
>
>> @@ -717,11 +723,14 @@ $(TRUNNER_TEST_OBJS): $(TRUNNER_OUTPUT)/%.test.o:	=
		\
>>  		      $(TRUNNER_TESTS_DIR)/%.c				\
>>  		      | $(TRUNNER_OUTPUT)/%.test.d
>>  	$$(call msg,TEST-OBJ,$(TRUNNER_BINARY),$$@)
>> -	$(Q)cd $$(@D) && $$(CC) -I. $$(CFLAGS) -MMD -MT $$@ -c $(CURDIR)/$$< $=
$(LDLIBS) -o $$(@F)
>> +	$(Q)(cd $$(@D) && $$(CC) -I. $$(CFLAGS) -MMD -MT $$@ -c $(CURDIR)/$$< =
$$(LDLIBS) -o $$(@F)) $(if $(filter test_progs%,$1),$(if $(PERMISSIVE),|| \
>> +		($(RM) $$@; printf '  %-12s %s\n' 'SKIP-TEST' '$$(notdir $$@)' 1>&2))=
)
>>  	$$(if $$(TEST_NEEDS_BTFIDS),						\
>> -		$$(call msg,BTFIDS,$(TRUNNER_BINARY),$$@)			\
>> +		$(Q)if [ -f $$@ ]; then						\
>> +		$(if $(V),true,printf '  %-8s%s %s\n' "BTFIDS" " [$(TRUNNER_BINARY)]"=
 "$$(notdir $$@)"); \
>
> Does this condition correctly handle V=3D0 or V=3D2?
>
> In GNU Make, the $(if) function evaluates to true if the condition expand=
s to
> any non-empty string. If a user sets make V=3D0, $(V) expands to the stri=
ng "0",
> which Make considers true.
>
> Consequently, `$(if $(V),true,printf ...)` will execute `true;`, silencin=
g the
> BTFIDS output entirely. The standard msg macro used for other compilation=
 steps
> explicitly checks `ifeq ($(V),1)`.
>
> This results in inconsistent behavior where V=3D0 correctly prints brief =
messages
> like TEST-OBJ but silently skips BTFIDS.
>
> Could this explicitly check for "1", such as using
> `$(if $(filter 1,$(V)),true,printf ...)` to accurately match the behavior=
 of
> the msg macro?

ugh I forgot about this one

>
>>  		$(RESOLVE_BTFIDS) --btf $(TRUNNER_OUTPUT)/btf_data.bpf.o $$@;	\
>> -		$(RESOLVE_BTFIDS) --patch_btfids $$@.BTF_ids $$@)
>> +		$(RESOLVE_BTFIDS) --patch_btfids $$@.BTF_ids $$@;		\
>> +		fi)

