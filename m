Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95DAC3A6EF0
	for <bpf@vger.kernel.org>; Tue, 16 Jun 2026 21:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781644299; cv=none; b=eR7pyRrn7+QqP8ql5lIYM+EXqyaeJbI5YXGHqkM7SYEQRhSNHFHTdMXRzm+seMlNcNVM5Y5LjDI58Xs4Yq6UM0xA0atNcFxwWc29TKUB685LoBtVsZPGzZ1uT2ZxN5joPr/XQn7oWw57VFmORPSDpgNzhfCYvyaFYhhsFXScUZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781644299; c=relaxed/simple;
	bh=dTScQgtBwOK2hwTaGqbBqTlipviyaPVWGKAq5jz6pQo=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=KKKFJtKutB6cbnjhvgyJYGO+3yT/5TixSxW2bYHVpxhgTvgCvhVSUZlwcKODMYkWt0aVAmwfA8Wuw+IEPqIeTNY0xjKXBvEJ6rdUVR4YUagP4XphV+dzjNTAhNNsccXTAG2OhlLMc9xUfwJ8CQ+GXMTpqZmFnGhbp8CK8MDrTVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=WZrBbQRw; arc=none smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="WZrBbQRw"
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-30bbe98c3f0so1217882eec.0
        for <bpf@vger.kernel.org>; Tue, 16 Jun 2026 14:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1781644297; x=1782249097; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sAcBK62HKnF0ILRgaewfo9ZdRQ5WRb1ndFmhkIlqveA=;
        b=WZrBbQRw0+GonJJoDpDaKN4rUCpVcE5+xXWpOcyM5T2crzQb9EgyAlIy228bTWzhBT
         idm4/J/j1UhDpClvdYfuQUO/UXFvF2u4dzdtD0z2OL8wDpYY8wPXSKLMWYlG9csjKHI5
         uG9klvoR49UnDvp5XMhyTNz1b0U68Isjz8lBGm6mcnAjgVDv9Mk9dUAN4yWNVFrpJHy8
         Z8P8tk8/u1e2HezStfKPT2OpA+nzyN4U3CgXHRKmMydictI0UozQiCh2EqLJ5tovrAN8
         C55vmclf4LKHR4j+HAX8OECa+UNUousDpfEQ/wfvvwfs2MTiWs6SH5/+GjpRKy9YJpQ/
         iIGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781644297; x=1782249097;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sAcBK62HKnF0ILRgaewfo9ZdRQ5WRb1ndFmhkIlqveA=;
        b=ez1Qigie4k4t+PU1HF1Um4crwQRLZvsmeqwUrqYbwsKusSbpjzy+I6um4AsClKEtW8
         qF7XBtye10Yr8pgGVqrAnb3FvkYP3/7UzthEz7t9XuUipZwD3LNxPLfvtr3+kBtmCYyx
         f4TOyd3LvA0Lq3cG8+/04YdB5rbqM4Y3GcSXmPfCuRsh9n2Ip4pTsUL2OPs/o0x4MlgE
         OcsuTQ+KR3ziq8K8t7qD3fwZC0w85SQBW7cw9S3zKDrEMHjHgZUZq2O8hSS+kPwQk+Xf
         FMZdDnTZY/h5dM6OH1L9KbJuGUQk7K1tjDgcHLa4zdMPnAdRlBR3fIROG6915zhWT7lG
         DvCQ==
X-Forwarded-Encrypted: i=1; AFNElJ/mvr4X2qKBTJtkfiRpQbpqf+OKvzb4kQ3MyN3e8PmoQYHZxEwW9/UMeI21CRwcb62FdsE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyI+JBGYxiGWLzOMP5w+2LATY7npTP//yZvga13vTLQsWkfFqOc
	NwP4KFC5pDXUfM3iGVtosH9Lj8xFev4N9K/6siO/q4mQCCHhZJWNJ3Y+TE4JyWyW1uE=
X-Gm-Gg: Acq92OE2O0VzUK8Vt1QjaBSSqawl8Jt8wdzx079d2Yoyi/mqtKj384w7w6eUKp41LHx
	O2BBOQzpLc3PJ5/yVm6fKEuByHKFjibvASJ7cxnIvERbixkdlyZvkPxhOpHODFj8cipXs4Oneqi
	uWbGtEr5s6Ywq69+6AVwg+MgbltRNsvRh0cA8mq6xokw/x3THabT/px+lSm9PzJNkValuCMLbK3
	zav+TL/A7qhBk2fs+ETt2STPlqihBNTifVDbC3t/PGT+cmWEIwYqaFmlOYwgpyqTMUW63OrQuHQ
	5Jy2eAWpfHI7KN/wkZ1hvF6oDOjM/WzIWPvXrzPoLnxaSuf0qqA+nwkUiTmBP8r8UMV5GhWDcrV
	Y7HHfsfyRmdhLvvNdbSbgTuHu6UcDvmC5LzdvKrOFCExJBB/0D7SVPwcSLX3lRSfl0HkxSn2eGU
	P8KJcN
X-Received: by 2002:a05:7300:80d2:b0:30a:e5d4:1663 with SMTP id 5a478bee46e88-30bc9cad60cmr722692eec.7.1781644296622;
        Tue, 16 Jun 2026 14:11:36 -0700 (PDT)
Received: from localhost ([2620:10d:c090:600::1a8e])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3081ea4f7a0sm18675598eec.24.2026.06.16.14.11.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jun 2026 14:11:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 16 Jun 2026 17:11:33 -0400
Message-Id: <DJAS6XB7815V.1K8T5ZD0UVJQU@etsalapatis.com>
Cc: "John Fastabend" <john.fastabend@gmail.com>, "Martin KaFai Lau"
 <martin.lau@linux.dev>, "Luis Gerhorst" <luis.gerhorst@fau.de>, "Shuah
 Khan" <shuah@kernel.org>, <bpf@vger.kernel.org>,
 <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf 1/2] bpf: Fix stack slot index in nospec checks
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Nuoqi Gui" <gnq25@mails.tsinghua.edu.cn>, "Alexei Starovoitov"
 <ast@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>, "Andrii
 Nakryiko" <andrii@kernel.org>, "Eduard Zingerman" <eddyz87@gmail.com>,
 "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260617-f01-11-stack-nospec-slot-index-v1-0-e3a080b0cd7e@mails.tsinghua.edu.cn> <20260617-f01-11-stack-nospec-slot-index-v1-1-e3a080b0cd7e@mails.tsinghua.edu.cn>
In-Reply-To: <20260617-f01-11-stack-nospec-slot-index-v1-1-e3a080b0cd7e@mails.tsinghua.edu.cn>

On Tue Jun 16, 2026 at 12:57 PM EDT, Nuoqi Gui wrote:
> check_stack_write_fixed_off() computes the byte slot for a fixed-offset
> stack write as -off - 1, and records each written byte in slot_type[] wit=
h
> (slot - i) % BPF_REG_SIZE.
>
> The Spectre v4 sanitization pre-check uses slot_type[i] instead. For a
> 4-byte write at fp-8 after the lower half of fp-8 has been zeroed, the
> pre-check scans bytes 0..3 and sees STACK_ZERO while the actual write upd=
ates
> bytes 7..4. That can leave the second half-slot write without nospec_resu=
lt
> even though the bytes being overwritten still require sanitization.
>
> Use the same slot index in the sanitization pre-check that the write path=
 uses
> when updating slot_type[].
>
> Fixes: e4f4db47794c ("bpf: Fix pointer-leak due to insufficient speculati=
ve store bypass mitigation")
> Signed-off-by: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

> ---
>  kernel/bpf/verifier.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 2abc79dbf281c..50e80dbbc1784 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -3479,7 +3479,8 @@ static int check_stack_write_fixed_off(struct bpf_v=
erifier_env *env,
>  		bool sanitize =3D reg && is_spillable_regtype(reg->type);
> =20
>  		for (i =3D 0; i < size; i++) {
> -			u8 type =3D state->stack[spi].slot_type[i];
> +			u8 type =3D state->stack[spi].slot_type[(slot - i) %
> +							      BPF_REG_SIZE];
> =20
>  			if (type !=3D STACK_MISC && type !=3D STACK_ZERO) {
>  				sanitize =3D true;

