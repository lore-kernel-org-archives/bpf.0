Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE8010F2
	for <bpf@vger.kernel.org>; Sat, 15 Aug 2026 01:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786755818; cv=none; b=Qc/scj4CNkQ08FwFeVva1orjvFSQk81FZatT//yWaholD1gNfQGXrAi+NV7i+4Qr4Gkd2xQwPkzo9ouql1LcWN0Mj9cbd0MYv2fE3rGnUY/P+n4SXyuvpAFUQL0NpmJiQioI7dGQex4FJdhGOSuwoMjG7tub8Hi+vyaCRWoCjPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786755818; c=relaxed/simple;
	bh=nI3HtqXG1oy1JsMN5SGDPAZUyt+VeEpZPkVON7FlKoo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=o+Epl/B6QT076kVp7ptKGnQC7EYR9omIA12egDxiQS4KQJ9labS+LGcamPkjncDGAXF3UVRqZFkF8tRr9Mo1vcLudgitM6td6dCAryn4d2N4IIupI6+i3Nhycgx5txS76dt20NGYbrCiWVmDtgsBF78oe7nRxQKIc0JZrqVFd1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aJmleQRK; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aJmleQRK"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-c9e7391839cso1457279a12.0
        for <bpf@vger.kernel.org>; Fri, 14 Aug 2026 18:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786755816; x=1787360616; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=rzeer65vwC3CWLGr6lVPgO0IFbA4l3+0Vfz1MHKPK4E=;
        b=aJmleQRKdgURaOyLvaLLE4EH9wigBncqz4ep17T4sOI9gBspeDQ2EvO1cGbxJL43MU
         brkeZykE3t8mx5ggMuQzoCS0EBsFPIjG1arnvP9QnKVbIjjLPDme4dSJgb2XG65P0gBX
         4dTwIRLxNQZ3unR3ouqDBt82g5NMESicEkeUBNC+V0MhFSfsi29PveZbHvLRQ8Oo1Xfl
         IYGK2/ZhF0jaNObabN6BQYo5FIPzdSqxGYTPVqnD4pwp8O714vtuyLJqkg1cWZoUzOZs
         IIHL5x+csWVTwlhVXsZ31Vd9zlavvSK0yV6/bIwDkdbAnFJz6txjWJcLI08rRgfBLQtj
         8cXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786755816; x=1787360616;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rzeer65vwC3CWLGr6lVPgO0IFbA4l3+0Vfz1MHKPK4E=;
        b=WRcSfBMILTk4ReTpL/6OKC6t/3FYRSnuNX7fC10S6ulvpmSYFBGEfQfbRzLtysxHTr
         nhL8i/8yVPY7Xv3kzBkloTL8YaqulKNW2CmDf/W9N9Odu9wYw9PL/lztBfNBos7VY7Qd
         rTjgu4Hn8vIbCOZhi/xNueY5q+A60e3JotoMQHzjD5fqIpzQXPe8IXYKSRF3TyeQZptK
         5ZrPmcbOAx/FCxRBqOWKPW+XB9Lmu7It3sUE0G7TRR9E/j5ZzZFjuTw32h6aBG6hKwmK
         I/B/WTAIs8nj0hv8/95HUBFqcR8S8riEKWZ6IQ1ohcxdm0bXtHDdGlXI79Um0c0aIL4K
         Pb0Q==
X-Forwarded-Encrypted: i=1; AHgh+RrLK+K2+Ee8EEsFun/X13WmZJCak0XCSQppJSHX9A9UIa+Q6T05/CAaovNLGWNOlQC9Vho=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOBoknFdK7ORG70wezbCXlLzkHTMJwFMmve+1XSZrly7iMB1j6
	ZaA4gwqyv3iQHDxBRpkyYkkxKcE+NvRhxJ8vgix1EDOQp9kMePVDmhSiJKvjMi2T
X-Gm-Gg: AR+sD117bNN6FxPMfIH14qPZNxhCj5WZtMb4nZMrsRx9WscWT207+Rjq2s4Ht4khCpg
	E0HC7gH7Hd4iXp15RulFFynXv/xCewG/B3acoPxrWFXT+riQ0n10VCge1X8+23q4kwmErCOdWrB
	awAABP70ZUsKo2MmyUQXw7yxjGTjPDmLGkgjMoI1z8aDCDZXSBAXqAPqu2oPtuKU3AnxOojWwSJ
	pAxuN5l1VnQ7Iqjv7ljVQvayxbQDT2wmL23+ZF5xj3o4TVL5h0nKBc7E3UFbOFU6Spa4Pigd22D
	PlibezSqAyCRNBqy0IfCpFOsSjoN80cU9OtKTKnaUOZD/+8wbaksss4QzMLOnnAhIdt0M6xbKdh
	o/fWeBF1WLdbkhBEKNGtsIwIvk/BfwJk9nYiO1cMXpwgUy/3kkU/G/ITFCVE7/1GciVCb2ATywm
	4i9JEKleiYeZqJcdik7ff8jB3EYqVFtSH7rkQwofYaaC7eyoKAcvBOxj1Hv3ybY4XvYm+7wATjK
	hB5PtpVhbAfRGsV5nQgvcBp7pKCXz6DzYVj674XL6BGj+hRdRV2L+Ji
X-Received: by 2002:a05:6a20:6a1e:b0:3c3:6528:c87 with SMTP id adf61e73a8af0-3cc719d2a0amr12254050637.1.1786755816089;
        Fri, 14 Aug 2026 18:03:36 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:b77:bdad:4587:c682? ([2620:10d:c090:500::6:84a4])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-320d5bd9fe0sm14364453eec.1.2026.08.14.18.03.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 18:03:35 -0700 (PDT)
Message-ID: <d1a79a5bee37759da16f5944905dee8aa4a01604.camel@gmail.com>
Subject: Re: [PATCH bpf-next v5 10/11] selftests/bpf: Add inline-asm and
 subprog tests for R0:R2 returns
From: Eduard Zingerman <eddyz87@gmail.com>
To: Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>,
 kernel-team@fb.com
Date: Fri, 14 Aug 2026 18:03:34 -0700
In-Reply-To: <20260813200302.1997359-1-yonghong.song@linux.dev>
References: <20260813200210.1991507-1-yonghong.song@linux.dev>
	 <20260813200302.1997359-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2026-08-13 at 13:03 -0700, Yonghong Song wrote:

...

> diff --git a/tools/testing/selftests/bpf/progs/aggregate_ret_func.c b/too=
ls/testing/selftests/bpf/progs/aggregate_ret_func.c
> new file mode 100644
> index 000000000000..cfb21bcf704b
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/aggregate_ret_func.c

...

> +struct ptr_pair {
> +	void *p;
> +	__u64 x;
> +};
> +
> +static __naked __noinline struct ptr_pair static_ret_ptr_pair(void)
> +{
> +	asm volatile (
> +	"r0 =3D 0;"
> +	"r2 =3D r1;"
> +	"exit;"
> +	);
> +}
> +
> +SEC("tc")
> +__load_if_JITed()
> +__success __retval(0)
> +__naked int aggregate_ret_static_ptr_pair(void)

This test is redundant, already covered by a previous patch.

> +{
> +	asm volatile (
> +	"call %[static_ret_ptr_pair];"
> +	"r1 =3D *(u32 *)(r2 + 0);"	/* deref the returned ctx pointer */
> +	"r0 =3D 0;"
> +	"exit;"
> +	:
> +	: __imm(static_ret_ptr_pair)
> +	: __clobber_all);
> +}
> +
> +char _license[] SEC("license") =3D "GPL";

...

> diff --git a/tools/testing/selftests/bpf/progs/aggregate_ret_kfunc_c.c b/=
tools/testing/selftests/bpf/progs/aggregate_ret_kfunc_c.c
> index b66576307f73..2c1889fc28ef 100644
> --- a/tools/testing/selftests/bpf/progs/aggregate_ret_kfunc_c.c
> +++ b/tools/testing/selftests/bpf/progs/aggregate_ret_kfunc_c.c
> @@ -50,6 +50,66 @@ int aggregate_ret_kfunc_struct_c_test(struct __sk_buff=
 *skb)

> +int aggregate_ret_kfunc_li_c_test(struct __sk_buff *skb)
...
> +int aggregate_ret_kfunc_ii_c_test(struct __sk_buff *skb)
...
> +int aggregate_ret_kfunc_uu_c_test(struct __sk_buff *skb)

I don't think three tests above a warranted, the previous patch
already tested returning 16-byte structs. Maybe a test with a small
structs of two ints, but I'd skip even that.
This would drop a ton of code from the back of the patch.

...
