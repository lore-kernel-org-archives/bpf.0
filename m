Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5B273CB560
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 16:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790266816; cv=none; b=ao1mwgqrrtA3OJ44bT+gmdzkUwtPwopYtdHfO6CDmS96SQ11ZrqrxCJWFma5WO4CCCQ7baR33Hm0nvS3Mz0LxUmzUh+C/XbUsEvxj42dAF4YDdPx5QNiTF/LTqnNlP1UQeXmltq4yfTZiLNgIkgw68BUL6AxaRxfwn1hw9NYBHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790266816; c=relaxed/simple;
	bh=3RqIO6sePBeRSZKF7G/2KBgpPD2lZ4MbL7NsJ27Vwb4=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=OqzL9clFnk4UGoiTfOfj9O7eDNu0gC6U4UYL+ZLo8ozzIBX5QZWmJiHNPx8GaAjcpvcozrH+iHbKmZ71iNebWzDrDbwMN1CVoeyCHCeCQ114uEdKw5KpYROvuV+45ogLWOt0Lo5cIsaDVddo9cXWVGDg69ywiAQ9NsgPGndt9Nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j5bqZmiF; arc=none smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j5bqZmiF"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c254fa663bfso392299766b.1
        for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 09:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790266813; x=1790871613; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=qWiIWAbEhMe5Qe0PgIHxYK173K5Od+mN1jv9eb0aS9g=;
        b=j5bqZmiFLxl0IR2tzdLDnMn/kCWj/59BKoEpMyuMTDuGbQYr/XBsMj9JQhwI3L56yo
         EbsRsrDUuWfR89Q0N82oW3tadJ73JY2zaQPx45lkLrvrK6jLeZRw91hZNGgpnzMtyn9m
         wJIVwxoSEMKhZ4MhVs1LYWIZCbKqHvQ0U29dU5Fmg74YUkGXb/SGQNR3x4bektPqUi48
         Pb5pjTBJ5SJa20ac8uzXewiywYIIkUUcEWxseLbYm6CyGn/ezCWe1o/Kz1OIOMyTaZUf
         tD+hzkz857ISE6/E0xsUv13hP5e0Esz62XiGo5hiDYmWqJ5qkybGyHKOxNMEQDEJzIek
         XgSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790266813; x=1790871613;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qWiIWAbEhMe5Qe0PgIHxYK173K5Od+mN1jv9eb0aS9g=;
        b=Ms6JBMv366UPdhm9ShbV79ve1p/9NcEvBYagZl70vOQrXBAF3XQqfdwCRnTZqcIsLF
         DkBY4zeljaqAZNXrD1zZ07JOfkI7u19p630o4GhLa56Abl13RyN1/Abt/th66HVITbNw
         E6Ja/78XQ1kZB4c1FkUwrq2Zg6Dx2+Ebp+r87UINvFTNIPtr60VJy/z231bF/AgExLr4
         bka73NzZ5pZ7SlRXng3315ndMjdEWz3BGJSO0qyiy2zakOLskt3lJncsdBcESD8vHoWC
         LmJsgWF+pXJnRqjRPe49QB+7qrRh18asfcmOr57f1Dj/4J9B1sX9I0Y3KUpAWNmisjKg
         keog==
X-Forwarded-Encrypted: i=1; AKwUvBwvUdPuyU6xF8Rpnj9W/qbMJ+5qt2btOhgHsCqKrhpNXGlSO4vfq2c3BEGCENEUoQJyHCk=@vger.kernel.org
X-Gm-Message-State: AFuF++lIcpBX+kOu7E8+RSQS1MIwJvFduqq/AJ/U8Se/lpWxgjSSK/Bc
	XaDWkg1KC8YETdveQqX2IqbRvKbjiDgaxOrw0J0JsvNQrIPyHlO0ceFk
X-Gm-Gg: AYBFou2rMAQcZEgoutaHc9nBUMe4qYz1YmDK8OkRSc95f+BEVjl9GugRgWYW8R3DC+C
	wEO338q6fiAZqX6OgBkH6qHVt6sLz0ONtwB8kWzwuW9bzNswwWKm6dCP20hTxFFRVUYLMmf8iAW
	EsxLGJ7D7LftsjW5fHFZZkPTO+81UyviKva79uIEZSgU9npqF/TKZZBjEuCDVoF1FGrKNZOGYCX
	c9G9nntEQlV9twEAqslXyTe3iEYCTK3DcJtugOdF4Oh+OP1YSSzDc5Bm20k4EHk8nOU2X1YNEtC
	599Vf6pb8J4XmnR/SKz5djdJDpNuo6apUWE3Qd6zR0e1QbQ2201p/9jVAiqdpZI1lnJijtsqw1t
	M15/P8Hlc236Vb6CtITdNip8r4JOjYCIhNen1Qa1QnEuwbfNM3+mGNi1ImAXz9fDwdZj9+oAMT/
	C33m/1HNX9Ie95ed2uwK9E/+VmMyh3wT8tg3I9Q0vxjRZKIcQ6EQfPmIs1lc6tU3VpvHMemAlA/
	Jjnij5fNKAEgPXn+YeYF6RrUtz0uuVuS1M8DJZ6JYEjVFQ5+kJrfhRpqdDSf3BubgMSZ+PxLt67
	QGj2
X-Received: by 2002:a17:906:6312:b0:c25:2d27:5652 with SMTP id a640c23a62f3a-c2ac2308fd7mr272369366b.11.1790266812819;
        Thu, 24 Sep 2026 09:20:12 -0700 (PDT)
Received: from localhost ([153.61.198.248])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2aae5c6f35sm331872766b.12.2026.09.24.09.20.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Sep 2026 09:20:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 24 Sep 2026 16:20:08 +0000
Message-Id: <DLNOMA3RI740.18YZJ9G0HDKDQ@gmail.com>
Cc: "Alexei Starovoitov" <ast@kernel.org>, "Andrii Nakryiko"
 <andrii@kernel.org>, <bpf@vger.kernel.org>, <kernel-team@fb.com>
Subject: Re: [PATCH dwarves v2 0/3] pahole: Fix arm64 argument register
 allocation
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Alan Maguire" <alan.maguire@oracle.com>, "Yonghong Song"
 <yonghong.song@linux.dev>, "Arnaldo Carvalho de Melo"
 <arnaldo.melo@gmail.com>, <dwarves@vger.kernel.org>
X-Mailer: aerc 0.20.1-349-gb940a4174a3e-dirty
References: <20260917164038.1576763-1-yonghong.song@linux.dev>
 <09dbfeea-a4d1-4b7a-b92e-bcf8c4cdabb4@oracle.com>
In-Reply-To: <09dbfeea-a4d1-4b7a-b92e-bcf8c4cdabb4@oracle.com>

On Thu Sep 24, 2026 at 4:15 PM UTC, Alan Maguire wrote:
> On 17/09/2026 17:40, Yonghong Song wrote:
>>=20
>> The arm64 ABI starts an argument twice the register size on an even-numb=
ered
>> argument register, leaving a hole when the next free register is an odd =
one:
>>=20
>>   u64 f(u64 a, __int128 v, u64 b);
>>=20
>> passes a in x0, v in x2:x3 -- skipping x1 -- and b in x4.  pahole did no=
t
>> model the hole, so b looked like it was in an unexpected register and th=
e
>> whole function was dropped from BTF.  Patch 1 skips the register the ABI
>> leaves behind, patch 3 adds a test for it.  Only arm64 has this rule; th=
e
>> other architectures are unaffected.
>>=20
>> Patch 2 is a small follow-up.  Floating point and vector arguments are
>> allocated from a register bank of their own -- v0-v7 on arm64, xmm0-xmm7=
 on
>> x86-64 -- so a wide one never occupies a general purpose register pair a=
nd
>> must not trigger the even-register rule either.  It does not change the =
BTF
>> emitted today, because such an argument still advances the general purpo=
se
>> register index by its own size, so it comes with no test of its own; it
>> keeps the alignment rule scoped to the bank it applies to.
>>
>
> one small issue here; we record alignment for structs from DW_AT_align
> in associated tags; we should ensure that we utilize that alignment
> where available. However it's a bit broken in that we don't appear
> to record alignment for typedefs, just structs.
>
> I think we can tackle that with a followup though; unless anyone objects =
I'll
> land these patches later today.

Pls go ahead.
Also pls land LOC* things too, so you can post the rest of LOC* kernel bits=
.
So that everything lands and ready for the merge window in a couple weeks.

People will be traveling soon, so the sooner the better.

