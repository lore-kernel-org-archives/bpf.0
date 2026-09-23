Received: from mail-wr2-f11.google.com (mail-wr2-f11.google.com [74.125.225.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FB135678E7
	for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 19:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790191786; cv=none; b=hsMqoqv99drWoWIVZ4W2vhxqKY8zl0fCzHjAJ0eVAcCaQr3LsRnArNGIM8voF6qFFRouxI+zhsInVMiOrt+lFB5+ca7Bk5lXFmzPo22ozXHHWuCrGLJ0QgmfhczoLiLqSqFqFvEn6xjDrDQ5W7HGcS+HkOuAblIqngmGVzBeCIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790191786; c=relaxed/simple;
	bh=1KwF/7YBtIPZkRPYZUO0p+gOfbBOZvlijizewDOJ8No=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=apFzM4f7Z5DTedLvUFriY3ZmosvftQd+h9dpR7e18VDDnylyhhX/uw5eJ4fkmS18V+Xlp8HnMMIdmDhf+NXAUd6OUZEChsCYUhXMsKpyTC6UxbEkC6RNSoSSNs02lgjZvxhv8A2UrUEn4W02vkRyaLOrrh04K1veImNbVcQajD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pqsKY6Ds; arc=none smtp.client-ip=74.125.225.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pqsKY6Ds"
Received: by mail-wr2-f11.google.com with SMTP id ffacd0b85a97d-4843147998cso56147f8f.0
        for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 12:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790191783; x=1790796583; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=IlP694hjPzjhxFPT82RcykXfpGBUKpwzMUdCD5lt6oY=;
        b=pqsKY6DsdIEWtuy0gzL74GUy+nP4+mir/H947GM3fZuwqqgJeBxXIlMEzBGZjuh7cg
         SxqdM/TXVVrCyJ1qlpYWHlgSWcu+l/L+0Fi7WWIoB8F1Z7JCDgGFNSKy14eKmwtQJj9f
         3vQn9eb2vHY1Kk2YlrKQDqGwdS/USA91nb9oWvLiMjDZiP7XPUe+ymwsPvj1bu1+FD3J
         s7MP9f3xcR3c0sA36IibuSSuCtsqMu/cHE/ovIouX6B7jsSOEo+o8Px+hAIncm2W3YUq
         QggJoTeiOMoWMC2RDDyhUK9pRCh39eEeOW+keNGoqcOYP9WO3LdkfK0PtgQRhP8BIIdO
         r4WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790191783; x=1790796583;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IlP694hjPzjhxFPT82RcykXfpGBUKpwzMUdCD5lt6oY=;
        b=nyoyJMn/i0arsjcSakiTZcRuL/CvBkqss6IcDjCpGz8M2SC1TS61PQk5jpr9lSXvYM
         qEEeYYoPf8PXYX0fANpjafcrIOm5OKP73ZWBAmpKJrFoUcNYafJCM6N4yte4R6vWcmdD
         8TOmD9+tjlwU0tHOgIsSnu6IGNC1jbSqBWcuxN7nJuL5d82x2J0TmaZzFK+kJclELLdf
         LrA0v5tRfol4YmJqGKYt9EqSF9SrV1IDl9H7E48oTCyli7lMj/GNF0uCFryxBXWcJI5a
         6fn69cxn4olwy82WJ8gn/fQwRsjO2afj7j9KQ8VL25v2wIozTVgAwl24jyXvYMbHtfcY
         xVrw==
X-Gm-Message-State: AFuF++kTcPU8D/M6YMa5JPbgkRER4XqJmScPc0HQDmT2EjVIdzVJXH/Z
	pDDYDdBQZtxdHiqeQD4hsEXuLOit4ZIcoLCbObBu6p6F0gV1qBBucxUjZ8vLX3ct
X-Gm-Gg: AYBFou0YjBwCDz1uAUffyqGp9XHyyIpOcRXm4exuawKzUbzNYd1rFiVC2tQhpVwVhNC
	gF3j278gkT9daX8UPTZpkPuY/zw5HN+IHASZ8LBxgYdZEmp8IJM4esUoT/kxaePRAuuuKvbZARt
	YCSUi1RR6aU10BKHay5PI/uc+7f3hgxmdCqBMzG5Uo6y0xYa1nwNrW6mZ4FRJ6m324DxYbNKOax
	XruyjXsIwfM2EkXdiQ6+pJWDM612kQ7TQU+qPL4W5n7NhXk7hp2tGfVU9/qQfmJlEFoel5YhI6N
	mYOxfNmE1CfMfV7tOyU+QusGPT7oKjYWHyUFrkHZzZE/ayql6lXbmXL3GzDOej2L3IZvadT2Kkk
	RQLhHDrbI+EjIcCtEJxVTl20Mq5rhikWzeJYmB6BEU02vfHBQjoC+HFV+OxtOmX/a7/po9O3Y0S
	7qKXc/K73W2yCuUWOywd61VDQcEhINVH1nbsPfsTV9LDYhxjo7/nm1SuKlBjOjCNxcyON7D/XQx
	4941Uwwc0iQ9XsXTRXMriCypqNPyMCiQdIqxJ+jE0pqar0N2J7IFzHrqhG/xZ7GviApYny+KNTN
	jvX9dhZPRscFh6Pdg406u9S9tVSsyDxrW302eHp/EE20ukzs
X-Received: by 2002:a05:600c:4f89:b0:49e:6581:7baf with SMTP id 5b1f17b1804b1-49fe66c80c8mr3977805e9.2.1790191783164;
        Wed, 23 Sep 2026 12:29:43 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fe5cca160sm7822465e9.12.2026.09.23.12.29.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Sep 2026 12:29:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 23 Sep 2026 21:29:42 +0200
Message-Id: <DLMY0VFF2ZG2.2LGZAQCRLJNI@gmail.com>
Cc: <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf-next v1 11/18] selftests/bpf: Check liveness merge
 of masks with different widths
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: <sashiko-reviews@lists.linux.dev>
X-Mailer: aerc 0.21.0
References: <20260923191139.2816206-1-memxor@gmail.com>
 <20260923191139.2816206-12-memxor@gmail.com>
 <20260923192607.8FC661F000FF@smtp.kernel.org>
In-Reply-To: <20260923192607.8FC661F000FF@smtp.kernel.org>

On Wed Sep 23, 2026 at 9:26 PM CEST, sashiko-bot wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Low] bpf: merge_keeps_whole_frame_read test is vacuous on some 64-bit =
archs
> --
>
> commit 1299c778ee1ba2ffa8d447fa3ce55a6d2aec24cd
> Author: Kumar Kartikeya Dwivedi <memxor@gmail.com>
>
> selftests/bpf: Check liveness merge of masks with different widths
>
> This commit adds a selftest to verify that merge_instances() correctly
> widens liveness masks of different widths when a function instance is
> analyzed through different call sites.
>
>> diff --git a/tools/testing/selftests/bpf/progs/verifier_live_stack.c b/t=
ools/testing/selftests/bpf/progs/verifier_live_stack.c
>> index f8758eb62dac5..a94365decd5f1 100644
>> --- a/tools/testing/selftests/bpf/progs/verifier_live_stack.c
>> +++ b/tools/testing/selftests/bpf/progs/verifier_live_stack.c
>> @@ -2861,3 +2861,52 @@ __naked void narrow_store_defines_nothing(void)
>
> [ ... ]
>
>> +SEC("socket")
>> +__log_level(2)
>> +__msg("stack use/def subprog#{{[0-9]+}} merge_read_all_callee (d2,cs{{[=
0-9]+}}):")
>> +__msg("(79) r0 =3D *(u64 *)(r1 +0){{.*}}; use: fp0-8..-512")
>> +__naked void merge_keeps_whole_frame_read(void)
>> +{
>> +	asm volatile (
>> +	"r1 =3D 0;"
>> +	"*(u64 *)(r10 - 8) =3D r1;"
>> +	"*(u64 *)(r10 - 16) =3D r1;"
>> +	"*(u64 *)(r10 - 264) =3D r1;"
>
> [Severity: Low]
> Is this test effectively vacuous on 64-bit architectures with a 512-byte =
stack
> limit?
>
> The precise 8-byte read at offset -264 touches half-slot 66. This means t=
he
> mask requires 66 bits, which on a 64-bit architecture occupies 2 words.
>
> The second pass performs an unknown-offset read, forcing a whole-frame ma=
sk.
> For a 512-byte stack limit, this covers 128 half-slots (128 bits), which
> also occupies 2 words.
>
> Because both masks occupy 2 words, the actual widening logic in
> widen_frame_masks() is silently skipped, missing the intended test covera=
ge.
>
> While later patches in this series might raise the stack limit for some
> architectures, the test remains mathematically vacuous on 64-bit architec=
tures
> that retain the 512-byte limit (e.g., RISC-V, s390x, or when JIT is off).
>
> Would changing the precise read to an offset <=3D 256 (e.g., -248) correc=
tly
> produce a 1-word mask and test the intended logic universally?
>

Plausible, will investigate.

>> +	"call %[bpf_get_prandom_u32];"
>> +	"r0 &=3D 8;"
>> +	"r1 =3D r10;"
>> +	"r1 +=3D -16;"
>> +	"r1 +=3D r0;"
>> +	"call merge_read_all_mid;"
>> +	"r1 =3D r10;"
>> +	"r1 +=3D -264;"
>> +	"call merge_read_all_mid;"
>> +	"r0 =3D 0;"
>> +	"exit;"
>> +	:: __imm(bpf_get_prandom_u32)
>> +	: __clobber_all);
>> +}

