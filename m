Received: from mail-wr2-f0.google.com (mail-wr2-f0.google.com [74.125.225.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 424E73B71BD
	for <bpf@vger.kernel.org>; Sat,  1 Aug 2026 17:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785605710; cv=none; b=AWV8Ttk7nhqM+Ip5nm57thNcJ2qluC+CwEjYx8qlT2VaAcmAx+63ua+PfPw3NZ6K8aMi+W0L7zNamfiSsODzO/Ae4ub1M3zSERkvFz/Q/R7DA02zuz42VtXciz0iePQJcRyqLXxPEdlZT5mmE12k4XmRMxMyYL5HEPQX2pAa44A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785605710; c=relaxed/simple;
	bh=qrkQjH/yPS0Ki/jy3KZEKed04xYWuEysIpsTesxuj9o=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=D1FVSFFAFIp/F5z8043ciKj9ViGHR1YGcP64BnzRLt7TM/4Yh/xu4WU+3lgOsWQGW04D/NSxQBE1tXmrtqICRDZYY81GZZKtGwIDn/ZkaL9ZMYg8XLKTnI5QDy8sfGb3vqjFaqlg3fW2PASua+H5pdkpC5+9JEiIEVYsgcQj/qA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rw+Xa1p8; arc=none smtp.client-ip=74.125.225.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rw+Xa1p8"
Received: by mail-wr2-f0.google.com with SMTP id ffacd0b85a97d-4784b41f3aeso647360f8f.1
        for <bpf@vger.kernel.org>; Sat, 01 Aug 2026 10:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785605706; x=1786210506; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ug8010ZyC+kV7fl3Lgjmm0rAlYJx/RD0vaE5unAL+gA=;
        b=Rw+Xa1p8b+Q79mnXdJ3t5QFA2uR/kKEh6P6I2IoRK6Rd92rsgaZLhgvhvbm0jCOONX
         aHeGv00bIRehPZdrWYaGE0j06rj/RX8uz39hyuV+nkRv9NVc7I9A+y1ScfHGMxrEg9hp
         n+Bp4SUWZGV2YwpUu59Wns178tBo7etr4lNs1mzuD4qy6plxhYuVx1U4FVwve+9LrAQv
         9RNFLHT0wkX707mSzZFDhXuHGBcEwNN7ahUuQuyISR8T40BNM4/0ZlayqG74B8J43eBj
         wiSwRw+mKONjCCUKACsLoV+6xofUDY9/EklE3b1oVuYTyVaNgd2mM3oKz1a7MWcof9q1
         8X9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785605706; x=1786210506;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ug8010ZyC+kV7fl3Lgjmm0rAlYJx/RD0vaE5unAL+gA=;
        b=bFIvFeEx5I7kaokh1niRxnD6HIUdy1O/JfAS/xqCnRQGJZdjubmWiaEYfEv3b7s9JN
         +lkOaZoO1cup5ErEjutKm3tGuIKo4a9avwOh5oBO+oL/sQMNQWwbeF805mp+a3KLI+DR
         ubF/LhIbUkQyWUnfwB5TxI2EPJWIkeQki/pvVfghCb4cKDHhePAmO4RrypXCsrWxlhQg
         BJITEg63jr3tk/acZqMBzQH5k37N0iEWm4xNJq0q3kofBhpouYlEDfUK6EOTQR8xVT/p
         3OH/YtJ7J59gGKWoRAJWLhnU3M5YG06pkYCucxDTTAsBQuNB5BUPJBtFm8RZrOlKl7Tw
         fL3Q==
X-Forwarded-Encrypted: i=1; AHgh+Rr7ybXj+MkChsd3b4WFZ673i8pbv7+RczGKnVixiKkZ/8pra0odblN9SzwWCZiFL2hgK5U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXIPU2wzGuLlzw9Ghv0I81XaMsua75l/9lLWvfrAlXaMnDseUI
	cIbh9WcFP7Neq+0rNIRgXGgMawF+hS21dQwNloglCpN7XdWyDj5vd+fy
X-Gm-Gg: AR+sD10RU2uGTYzLw/Ar4p1OK2cbQOYT5YvJqaXP7HQJd3YUFOderHLakW3GnnOmq+T
	ktynel8ksdzjeVr1O1PVE8xwXhUCGdLTRyh5rzDzzh7Fop9sdrsldjvaR6uX/DqHMQQFNBqo/n3
	46iMtS+NzSP27qtmC2Wcni45I/jtg8pu6nORN5RguHoPLBthEg3lnAkE74724mV7uiuqMQSWVia
	4MkJjkRDhhWHKxndhTOJPRxxjS+T8fnFKv57SWDP9ye4I5I0oHHG/Lt0DmrQUrfHufciLg1bhij
	+Yw0cZorZxksE/+HKp28hDzQzFtr0cFR6SL4cLYWdHBg+rPvbWWbzlKBfcqkpsPOW0J35L8WFUw
	KrRxNfS36EFEFkRUDbMqW94UKW12yOj/vlzN45GQXKXm6aEo66bd2GDyX9YQtW/c4EXpoZdTeX9
	1Siztl2srVay+ntjO8sQmyhJVWJ/86hnPrWAkDvmFsLP/H/BVvoJmcg1ouq4eCMQgniiFqBqAHc
	Q6o8rLdWTaGVAwXaF0y24IzOPpLBDmI1eNSx9fJCFYjLZBr/ncqzYpSuGRFqz1eFT2X51QeZsa2
	1hPb2eoORwkoC4AMgBUj5dk5xrHyQxJUz/ENMg==
X-Received: by 2002:a05:600c:c4a3:b0:493:a613:56b2 with SMTP id 5b1f17b1804b1-4980c64b5c2mr55006905e9.8.1785605706390;
        Sat, 01 Aug 2026 10:35:06 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49808199f2csm98595505e9.5.2026.08.01.10.35.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2026 10:35:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 01 Aug 2026 19:35:04 +0200
Message-Id: <DKDSE8AVM7Q3.3KZHCSNL4NT4L@gmail.com>
Cc: <fsverity@lists.linux.dev>, <bpf@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "Alexei Starovoitov" <ast@kernel.org>,
 "Daniel Borkmann" <daniel@iogearbox.net>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Eduard Zingerman" <eddyz87@gmail.com>, "Martin KaFai
 Lau" <martin.lau@linux.dev>, "Song Liu" <song@kernel.org>, "Yonghong Song"
 <yonghong.song@linux.dev>, "Emil Tsalapatis" <emil@etsalapatis.com>, "Jiri
 Olsa" <jolsa@kernel.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH] fsverity: Fix bpf_get_fsverity_digest() dynptr
 assumptions
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: "Eric Biggers" <ebiggers@kernel.org>
X-Mailer: aerc 0.21.0
References: <20260731003925.2728977-1-ebiggers@kernel.org>
 <DKDRHTVNMQ2E.1FCTWQZO2EB7Z@gmail.com> <20260801171549.GB3567@quark>
In-Reply-To: <20260801171549.GB3567@quark>

On Sat Aug 1, 2026 at 7:15 PM CEST, Eric Biggers wrote:
> On Sat, Aug 01, 2026 at 06:52:45PM +0200, Kumar Kartikeya Dwivedi wrote:
>> > Also correctly handle sizes over INT_MAX, which previously caused an
>> > integer overflow and crash.  __bpf_dynptr_size() returns a u64.
>> >
>>
>> I guess this occurs when using file dynptrs? Otherwise the size is cappe=
d to
>> DYNPTR_SIZE_MASK.
>
> Yes, though it looks like __bpf_dynptr_data_rw() excludes file dynptrs.
> So this particular issue might be unreachable.  Still seems like a good
> idea to match the u64 type that __bpf_dynptr_size() returns though.
>

I don't see this in patchwork, so you might have to resend this with [PATCH
bpf-next] subject again to trigger CI if you want this to go through bpf tr=
ee.

> - Eric

