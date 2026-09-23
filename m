Received: from mail-wr2-f9.google.com (mail-wr2-f9.google.com [74.125.225.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B031446BFA
	for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 20:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790195279; cv=none; b=TLXaLIxTFVdGxYL4g7aaj97AkDoaHdZD5kaCDOrE3ziBeciOg8qcEtf1nOCa7CM6HxOQwZcbm2IVHDW+Iv/dAasnjIcjnZyMPpMHoysfqwFqnwUGfTK3fgQgn7svyxP/maq8vIXOV5CaoR4GcscJTwppdYWxnPbmXzax/AwoITc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790195279; c=relaxed/simple;
	bh=vGM4pE0+CcUEFtNZjgnbjGn/3JKfQfvWBPjTAr5zEIo=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=SyIm664QamqR4by9klN5STvZNyJ0EQGa6tNlIckeXhCB6Dr8scz/axambZ/jPxlPz4qKktT/KZ6kd4JTLhQzSkihFjZ0V/kJP9TF94zJDhIygNmwaBeCWzyZcVRZafcipoechGHE/eKX6+9/AJifxMXV1k7U4K0xJ03hbBUghZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sAdAGBVc; arc=none smtp.client-ip=74.125.225.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sAdAGBVc"
Received: by mail-wr2-f9.google.com with SMTP id ffacd0b85a97d-485850cf4deso633171f8f.1
        for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 13:27:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790195268; x=1790800068; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=+bWAEmF0jwHBSZVjWxaT1f4ys2Z+RuLUdbMhfhSxxxk=;
        b=sAdAGBVc7fs7xtM8RKU6Hj9ZeIPXhw3AllJZfE5M3djvXsA/xaov93rKFL0bmzhiRp
         pjWlQ8BqIU1NB4MrIr6T1kWPajIv7B8rrvgg/omuDbnZTFl3FOc80Zq8Aujhp8Z/3ySC
         UKrc8IgjrUAPg7yULucyUo6GJvg55lsKzT1wUEc0RGwpbZkbCPGPmfmkSjhWLtE1ijGS
         iCrb8IqnoOV6gNIvXZqyNyIreqCItEPR+/6Hx7Lm51y3tJOPOXbYE/88wX7Lg3Xa5wNS
         igciub3YeGxv9n3k9Hg+vhGB0+31qANHJeyxqdXxjT5QSOP5Hn8Xo3D7jD3Pgq3bEIO5
         cPGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790195268; x=1790800068;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+bWAEmF0jwHBSZVjWxaT1f4ys2Z+RuLUdbMhfhSxxxk=;
        b=2v2bovShJBUnn2VmeSnz/qZps0vAbL6oe2CtHxgu/GTH9fSAim9KziQwnwbi3OqChD
         i70takC/aZv+alFpVipFWrtg5xWX+h5/10wCpOx2+yBTTaibj1sXK/N3Muwvavz03Ice
         WRrTE43LAQkDVKVWEneonT0LExcFMnFyxhCRlUZGtJhTXEok9Jm/CsWHRjBjzXdvC4fq
         EpoN9V+APCL4bWEIBA8CSrqN6p+JL+dzgO2KIv8JX5uwwTgNXWDXvaHECMNyHMNLMxLy
         grjS5Utg+WR36dKB4cF8Sp8D9lY7lmbj4C2EjC8HD7RJ1pKb5aDsqr6+I0+cwBIFVpn9
         9sYg==
X-Forwarded-Encrypted: i=1; AKwUvBwcJkN86/Q15mD33MRYs/eecrZ1E7Tbx5FpeW6RsvKZ1fw1UneuXom2I9IX5WPESksZ7EQ=@vger.kernel.org
X-Gm-Message-State: AFuF++nBxWjm9YKj3Xpy4XyGNqbMwc/ZqBVFpzk/r3y4omeocgL8wyLh
	gKDV8xfvTm9McIQh+6h3OeyzPbxprhmaLiDSLd4Isf16sq6xNBPdgMuq
X-Gm-Gg: AYBFou2JvckAQbiyUaGpZRV1en8r8U4VqK3le1JRSRFUcK63S9k8F3vSgGzHgedCExV
	4Oz4/5K+7cDlBLE9x3HONmtVoNb6nK51MZx7e5wGBMcxteZulQMkSUlJLLyZjEdmDwmZEPa2pDn
	Hb3fpR1AAFD8s7RLOvLQC8U5y3rL1f51dQZ6Ozf97gMsAA5E87DZNCEomPOzt/fFo7xqTQipmJS
	Etaw8Oxggp3ZU4fnjlbT0kJe9PFUHiiEAyF0Zkuxoc2ZecuXLQ7xHtWKeZTSi2FJuiJe3T4XhWe
	gmwHTRtZb52UYZXYa8LhnK57dun3LeADf3PVB8K8+gOOl1NNsv4/oSbIwsCQoH073Agq0NO/cMs
	+IZ3inyCJdz+5xWb9ZvU7JrBinwCHsIR7xJjaG+64qyoUbXS4zAZ6nKluWzkNYRiTb5MM0x3pSR
	dkiwqjwlFa4dJNTXN8XGlaQ4xQV3LreuqCsrHLspLjjiF4mtpVAJJvzfP2PLyr0yM9jE30CV5AK
	UYo60ISISY98DTaMoCkcO4MgWyaSiV9haReHRKb9EJN6abnH3fd5pAKJIfZXjsweB/MZTO15voi
	LIA8LOwgiG+Ql6tgZDvWDehqpPApVgg+AZQrsA==
X-Received: by 2002:a05:600c:8b4c:b0:49f:bc28:e8bc with SMTP id 5b1f17b1804b1-49fe66f3712mr5649795e9.17.1790195268435;
        Wed, 23 Sep 2026 13:27:48 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-488688856f0sm8751808f8f.30.2026.09.23.13.27.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Sep 2026 13:27:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 23 Sep 2026 22:27:47 +0200
Message-Id: <DLMZ9CDY11JH.OPHO5N2Z1OTQ@gmail.com>
Cc: <ast@kernel.org>, <andrii@kernel.org>, <daniel@iogearbox.net>,
 <eddyz87@gmail.com>, <emil@etsalapatis.com>, <tj@kernel.org>,
 <kkd@meta.com>, <kernel-team@meta.com>, <martin.lau@kernel.org>,
 <yonghong.song@linux.dev>, <mason@kernel.org>, <ihor.solodrai@linux.dev>
Subject: Re: [PATCH bpf-next v1 14/18] selftests/bpf: Add load conditions on
 the program stack limit
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: <bot+bpf-ci@kernel.org>, <bpf@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <20260923191139.2816206-15-memxor@gmail.com>
 <28a022f0799e2e49ed8bc3df23a3cefe6aa25ace227b4bd0e3fe35fd7d1a7f9b@mail.kernel.org>
In-Reply-To: <28a022f0799e2e49ed8bc3df23a3cefe6aa25ace227b4bd0e3fe35fd7d1a7f9b@mail.kernel.org>

On Wed Sep 23, 2026 at 10:12 PM CEST, bot+bpf-ci wrote:
>> diff --git a/tools/testing/selftests/bpf/progs/bpf_misc.h b/tools/testin=
g/selftests/bpf/progs/bpf_misc.h
>> index 2ced1d751ace..f3dbc3b59bff 100644
>> --- a/tools/testing/selftests/bpf/progs/bpf_misc.h
>> +++ b/tools/testing/selftests/bpf/progs/bpf_misc.h
>> @@ -175,6 +175,9 @@
>>  #define __prepare_priv		__test_tag("test_prepare_priv")
>>  #define __load_if_JITed()	__test_tag("load_mode=3Djited")
>>  #define __load_if_no_JITed()	__test_tag("load_mode=3Dno_jited")
>> +/* Whether programs may use more than 512 bytes of stack on this kernel=
 and JIT */
>> +#define __load_if_large_stack()		__test_tag("stack_mode=3Dlarge")
>> +#define __load_if_no_large_stack()	__test_tag("stack_mode=3Dsmall")
>>  #define __stderr(msg)		__test_tag("test_expect_stderr=3D" msg)
>>  #define __stderr_unpriv(msg)	__test_tag("test_expect_stderr_unpriv=3D" =
msg)
>>  #define __stdout(msg)		__test_tag("test_expect_stdout=3D" msg)
>> diff --git a/tools/testing/selftests/bpf/test_loader.c b/tools/testing/s=
elftests/bpf/test_loader.c
>> index a6e3fcc1079c..25eeb1c1248b 100644
>> --- a/tools/testing/selftests/bpf/test_loader.c
>> +++ b/tools/testing/selftests/bpf/test_loader.c
>
> [ ... ]
>
>> @@ -1331,6 +1349,7 @@ void run_subtest(struct test_loader *tester,
>>  {
>>  	struct test_subspec *subspec =3D unpriv ? &spec->unpriv : &spec->priv;
>>  	int current_runtime =3D is_jit_enabled() ? JITED : NO_JITED;
>> +	int current_stack =3D is_large_stack_supported() ? LARGE_STACK : SMALL=
_STACK;
>>  	struct bpf_program *tprog =3D NULL, *tprog_iter;
>>  	struct bpf_link *link, *links[32] =3D {};
>>  	struct test_spec *spec_iter;
>
> [ ... ]
>
>> @@ -1360,6 +1379,11 @@ void run_subtest(struct test_loader *tester,
>>  		return;
>>  	}
>>
>> +	if ((current_stack & spec->stack_mask) =3D=3D 0) {
>> +		test__skip();
>> +		return;
>> +	}
>> +
>
> A subsystem pattern flags this as potentially concerning: the new
> stack-limit load condition skips the subtest with a bare test__skip() tha=
t
> prints no reason. When a user sees a verifier_large_stack or
> verifier_stack_ptr subtest reported as SKIP, they get no hint whether it
> was skipped because is_large_stack_supported() found the 2 KiB budget
> missing or present.
>
> This matters more because the probe can also fall back to "assuming 512
> bytes" when it fails for an unrelated reason. That fallback message goes =
to
> stderr before test__start_subtest_with_desc() runs, so it is not attached
> to the subtest that gets skipped.
>
> Does the skip need a message like the existing skip_reason and
> jited-disassembly skips in run_subtest do? Or is it acceptable for these
> stack-mode skips to match the arch_mask and load_mask pattern right above
> this check, which also skip without a message?
>

Won't fix.

>> diff --git a/tools/testing/selftests/bpf/testing_helpers.c b/tools/testi=
ng/selftests/bpf/testing_helpers.c
>> index d1d60451c5bc..47fe61a1ebff 100644
>> --- a/tools/testing/selftests/bpf/testing_helpers.c
>> +++ b/tools/testing/selftests/bpf/testing_helpers.c
>> @@ -517,6 +517,47 @@ bool is_jit_enabled(void)
>>  	return enabled;
>>  }
>>
>> +/*
>> + * Whether the kernel accepts a program using more than 512 bytes of st=
ack,
>> + * which depends on the JIT in use. Probed once with a program that sto=
res
>> + * at the 2 KiB depth. Only the verifier's verdict on that store is cac=
hed:
>> + * a load that fails for another reason, such as a missing capability, =
is
>> + * reported and probed again on the next call.
>> + */
>> +bool is_large_stack_supported(void)
>> +{
>> +	static int supported =3D -1;
>> +	struct bpf_insn insns[] =3D {
>> +		BPF_ST_MEM(BPF_DW, BPF_REG_10, -2048, 0),
>> +		BPF_MOV64_IMM(BPF_REG_0, 0),
>> +		BPF_EXIT_INSN(),
>> +	};
>> +	char log[1024] =3D {};
>> +	LIBBPF_OPTS(bpf_prog_load_opts, opts,
>> +		.log_buf =3D log,
>> +		.log_size =3D sizeof(log),
>> +		.log_level =3D 1,
>> +	);
>> +	int fd;
>> +
>> +	if (supported >=3D 0)
>> +		return supported;
>> +
>> +	fd =3D bpf_prog_load(BPF_PROG_TYPE_SOCKET_FILTER, NULL, "GPL", insns, =
ARRAY_SIZE(insns),
>> +			   &opts);
>> +	if (fd >=3D 0) {
>> +		close(fd);
>> +		supported =3D 1;
>> +	} else if (strstr(log, "invalid write to stack")) {
>> +		supported =3D 0;
>> +	} else {
>> +		fprintf(stderr, "%s: probe failed with errno %d, assuming 512 bytes:\=
n%s",
>> +			__func__, errno, log);
>> +		return false;
>> +	}
>> +	return supported;
>> +}
>> +
>
> [ ... ]
>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a =
bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/READM=
E.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/359098=
53278

