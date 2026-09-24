Received: from mail-wr2-f11.google.com (mail-wr2-f11.google.com [74.125.225.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D689D43F8D9
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 09:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790243898; cv=none; b=t7kqIkK/6ZAUjzBIArSa6aThH9pInyz3W4G2SBZniMMc95+aNAM+KeWkWH+UBxnujcNJjYv6cIqzAVZYBUC4sgqIhkpGxDLdudius5BIVWG9UUwwhp8gf2swvgF8HwnxX0kvXsA07VIaFkMB8ENGUvH2ZyT/A1APBkV54Fy5tlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790243898; c=relaxed/simple;
	bh=9SGKTc6D6xfMPeZHEks6c+okgQs+/kD01vjoPgrCeW0=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=XM/5VeaubY4IvhFkyDjeKg8LiNGFzUh7JtoCGadFCamjIA0QL6kDbpjZKHetUg3k2byajBOliQYEJ4M/81UKMTPdEvQneGnztAx71upQ0aWETPYK/wwb+SG5F5A+rqxqQCQajvn3TbDIUhT99fiRKFBPdx/tsaI2ln60a6hduek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e0dSR4jb; arc=none smtp.client-ip=74.125.225.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e0dSR4jb"
Received: by mail-wr2-f11.google.com with SMTP id ffacd0b85a97d-4843147998cso82658f8f.0
        for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 02:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790243883; x=1790848683; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=6Sg33ie5LuP6WxDBF1LG0/+7a9OYvJVQV6Xo3Y8WeTo=;
        b=e0dSR4jbPoJa3HD2AQhYCYLUyHpJ4+a+z4HOMHPlT0p46XJEedcAyrYw3StWoZGNRj
         h1szZOZ2+3IApzr6PKqCykR8Y451YJ8WxPvN7ocuxemWZXCY5hWs6svfSHRUOcrbdo72
         FoZ3J2PDYnqt+F5jV71uK9un0s4hRRpVFr29YIp0p8/LovRfXR2UyESwlc/3XUDvcgsp
         /8AgKTbXcbKQG3p6hu6QV4iRMBD6KByqMCmhtVO0wkrM0f2CfZHwBVlBNvFHY0ESam7L
         9TWG05QIccaFtePBp8U8h38Zkq+cgak/quocIv1pX1tSIwsNW3PEiaSxKmQwV65svocF
         7S7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790243883; x=1790848683;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6Sg33ie5LuP6WxDBF1LG0/+7a9OYvJVQV6Xo3Y8WeTo=;
        b=wGR9rawqeq1c9OfeTtqFfh+XyTl40Gml+cOkxvFmdYaCVM5sDQ9jwkjND2GrKqV57h
         I992ynHV75ZkXnw11HIQGXpCpRq1BVg5DmBRAUFoPQyGygLt/oNVsujeI/r/lvz8C9eL
         R6T5xScxfeCYhHJ8pV1iLiR4tTane2DgT7qAU8UPaGU1dIcY+hzgFQTLKJlvuZstpbkT
         lPG9lNuhKer6tkVUKYXHXfUhPsBeFCg5lqV0VyuXM8oEAbERCwyL0EL8OiFMM2BxH6LW
         sXfnBDcAduvvoyLaa2cfgwVbuJzyJ+GY5pPd5x4KAOj1VA4iYR7suv2X1UhvS0JVaYHY
         VfHg==
X-Forwarded-Encrypted: i=1; AKwUvBzUSkIL+T6UamwuJFr8P/UjMHgJ2UUSTug2qGsflrMdAuvR1KNqPKTseWrpit/XAfoAXGI=@vger.kernel.org
X-Gm-Message-State: AFuF++leS7DdHUeMxSdixUi6RZ4SequJwOlvpBhcE38P7yV+6pz2ovRE
	PwY41K5F677qUs5jF5zYlJEtk2mWuYE2oCSwcYxwt9DaGEUgvCLfxE4/
X-Gm-Gg: AYBFou3Lp7tsLdXNPUsUXSbqSCuc9mGSyMlLbEIl9yLFYMFS7FRk13wZPwwajRMT+Rt
	mvqSyWI8HlB/cyp3SNO1E3mzaF4mZFr/CDiIwhF3C+E+IjkP26zjEUwwPX8ySg1CvuOTeubhyF+
	9UrtpxaWdyhvnIPOtWWw5cqntCjTnZWXFJ4iX83RI84mi9VbCAjzL0cIxNCJKcLfoH6rl8miGWc
	bSGxRQ4JaSxks1jrCS/1xI1Q7zThCFfk/IkkxqZYm8Qd+kXxrN7WmpbsfuP9mCKUN1Br/mo6O7s
	iWgOaMBDeuZlanv4hZiBtavm6nAVfqAkmpXDyfZBI7tQF2/pGzm6mI+GuyBsm7pSHAiuI3f3gEK
	61ip+GlmJ2BASSWdCRSwo70kKnAo+Gx2Q1P0PbxwBLFWg2Y+bRkzY6kisuGkQmbfGcHUyAuwozf
	0LAfwWx90XjWuDIdHqNHMqFzKK0zUiSWxBLnxHiL2sTtT3t6amLfELK8iv1rAAgltoFw2hdyd39
	gFnt/mdI0WSmA7p6NPT2D6oew+/4Nut9oS22Gawf0/Zccv4zxYRWTnQK5we1rosYICxj3wO7SIc
	GcCzV298Zc6/OPQt8PnkW0nMs7BoFPHc0Qktig==
X-Received: by 2002:a05:600c:4e53:b0:49c:e37e:4389 with SMTP id 5b1f17b1804b1-49fe66c8288mr31334425e9.4.1790243882786;
        Thu, 24 Sep 2026 02:58:02 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fdf9691e2sm127086005e9.1.2026.09.24.02.58.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Sep 2026 02:58:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 24 Sep 2026 11:58:01 +0200
Message-Id: <DLNGHPJYHLOH.1KYZYC4XQPTRM@gmail.com>
Cc: <ast@kernel.org>, <andrii@kernel.org>, <daniel@iogearbox.net>,
 <eddyz87@gmail.com>, <emil@etsalapatis.com>, <tj@kernel.org>,
 <kkd@meta.com>, <kernel-team@meta.com>, <martin.lau@kernel.org>,
 <yonghong.song@linux.dev>, <mason@kernel.org>, <ihor.solodrai@linux.dev>
Subject: Re: [PATCH bpf-next v2 18/18] selftests/bpf: Test the 2 KiB stack
 budget
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: <bot+bpf-ci@kernel.org>, <bpf@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <20260924082607.2695649-19-memxor@gmail.com>
 <a0d61b61004d7351500248ef2a9e84ad6634dea366fe9bb15cd0a0887b301a82@mail.kernel.org>
In-Reply-To: <a0d61b61004d7351500248ef2a9e84ad6634dea366fe9bb15cd0a0887b301a82@mail.kernel.org>

On Thu Sep 24, 2026 at 11:13 AM CEST, bot+bpf-ci wrote:
>> diff --git a/tools/testing/selftests/bpf/progs/verifier_large_stack.c b/=
tools/testing/selftests/bpf/progs/verifier_large_stack.c
>> new file mode 100644
>> index 000000000000..2d4c81a3f0cb
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/progs/verifier_large_stack.c
>> @@ -0,0 +1,377 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +
>> +#include <linux/bpf.h>
>> +#include <bpf/bpf_helpers.h>
>> +#include "bpf_misc.h"
>> +
>> +/*
>> + * Programs may use MAX_BPF_STACK_JIT (2 KiB) of stack on JITs that sup=
port
>> + * large stacks, combined over a call chain, with no separate limit on =
a
>> + * single frame. Interpreted programs and other JITs keep 512 bytes.
>> + */
>> +
>> +SEC("socket")
>> +__description("single frame of 2048 bytes")
>> +__load_if_large_stack()
>> +__success __success_unpriv __retval(42)
>> +__naked void single_frame_2048(void)
>> +{
>> +	asm volatile ("					\
>> +	r1 =3D r10;					\
>> +	r1 +=3D -2048;					\
>> +	r0 =3D 42;					\
>> +	*(u64*)(r1 + 0) =3D r0;				\
>> +	r0 =3D *(u64*)(r1 + 0);				\
>> +	exit;						\
>> +"	::: __clobber_all);
>> +}
>> +
>> +SEC("socket")
>> +__description("single frame of 2048 bytes without large stack support")
>> +__load_if_no_large_stack()
>> +__failure __msg("invalid write to stack R1 off=3D-2048 size=3D8")
>> +__naked void single_frame_2048_no_large_stack(void)
>> +{
>> +	asm volatile ("					\
>> +	r0 =3D 0;						\
>> +	exit;						\
>> +"	::: __clobber_all);
>> +}
>
> Does the single_frame_2048_no_large_stack test body match its expected
> failure message?
>
> This test is meant to verify that a 2 KiB frame is rejected on systems
> without large stack support (the interpreter, bpf_jit_enable=3D0, and JIT=
s
> without bpf_jit_supports_large_stack() like s390x, riscv64, loongarch,
> and powerpc).
>
> The test is marked __failure with the expected message "invalid write to
> stack R1 off=3D-2048 size=3D8", but the test body is:
>
>     r0 =3D 0;
>     exit;
>
> This 2-instruction program never touches fp-2048, so it verifies fine on
> all configurations. The __failure annotation then causes
> ASSERT_ERR(err, "unexpected_load_success") to trip in run_subtest() in
> test_loader.c, failing the test on every configuration it targets.
>
> Looking at single_frame_2048 above, the expected error message matches
> this sequence:
>
>     r1 =3D r10;
>     r1 +=3D -2048;
>     r0 =3D 42;
>     *(u64*)(r1 + 0) =3D r0;
>
> Should single_frame_2048_no_large_stack repeat that write sequence so the
> verifier rejects it with the expected message on systems without large
> stack support?
>

Not a bug: single_frame_2048_no_large_stack does store through r1 =3D r10 -=
 2048;
the quoted two-instruction body is not in the patch.

>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a =
bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/READM=
E.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/359763=
22553

