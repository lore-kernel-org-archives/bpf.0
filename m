Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E20381EB5E3
	for <bpf@vger.kernel.org>; Wed, 15 Apr 2026 18:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776276779; cv=none; b=Cwu3f6so7IFT3Oy1nZ+H7D2Caf2bbzla83YS31yeqoG7V53Z+Pc2ilLMZtiz02O1W2SqRvG3kK6cIOxwhWtNswg0o1pJ0GBe/9DvaiA5oXnFfLi3yOnlHrCG124lSel8ODjYNoYZevKAqtzlZFEtbGEaOyN//Nf5buGPH1OAftE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776276779; c=relaxed/simple;
	bh=xuBugwAPRWxTp/rGLYw2T3rsOVKCDWNhWWPbUlOApb4=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UZEU25KsDV8Z2eo2zwsCIJHvrE5uAs/0VWiq7SUNpBtavKAbNn9qbvR5VbVrCEMyTvQ3jZh0+zVXzzZqdHobZQ/FeGoKa6V9NRp8ua3Q/bWk6oQ0OpgX/xx6xhCnRl6fFK0HHkFmnBQKmD+3fueWQUYrmQa/jfnY9BnS9m4sWvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NO8LwNh2; arc=none smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NO8LwNh2"
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-12c19d23b19so8527625c88.0
        for <bpf@vger.kernel.org>; Wed, 15 Apr 2026 11:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776276777; x=1776881577; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IJGjylw6DdMpKyotHh1RaXqArO8pofJ71mbPiDBvte8=;
        b=NO8LwNh2ZsQFdsw04/zOkxa86S9TnRixiRC6wlen/1/gFVCsToQW5re+6BRkjL4vWn
         QoW434n7Ho+dmV0rQ0ygiBAkQA7BW3SObDK0bFKkd1kXQCqBtaysZmiIvgNd7LUIwyqf
         g7XlPPFuLPbIG0NSYlWMYcvIdBXVI8Xgp9cH967iIQPirueBpWTPgbXV04eZAMDM3b3F
         vGCVwwqcr39hBEE4Qby96hDdh2El5skcuJsUWvz2Gspi11w82vWEu5tyYPPROkRaKdOU
         8wh5N2iE8qtSc+j5YRu6CYpCTq1tAFc0ZGMwL827s0GcGFqed5Ny3zl2/Dk5CQXC2kUG
         iPPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776276777; x=1776881577;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IJGjylw6DdMpKyotHh1RaXqArO8pofJ71mbPiDBvte8=;
        b=bVZdOV5XD2FCCR2Pja3JbfjW5Q5Q2V1INCdtzF71VcGi3J43iIvEgSi6ZaqSeKET/K
         nmxvQ381cJJ6FIvuLjoKFUn/QcLB+6L5hfT+OHrP5y0TyiT+/zub3sYJFvBLkUzo+lOJ
         q2XGEfmHRYgRgdb7WqQU5EbngQoRgNyAe2t1nULuDpXMO4ipQNIS5YmM5v5WMudnKEHb
         d/3AZ+7Z5YXxqqCBkbLvqybZNR+AJ1nqQgryYdKD6Pcc0i27nLb5csdPJRR0APSvKW62
         1dnUJTKyPNfU8GT8Fc0Fq+n2AibIQjhxcORhMrfOoBIxIiYdzB9xP2xbf220HfqRG1vS
         ncOQ==
X-Forwarded-Encrypted: i=1; AFNElJ/GMCAxB1lo5/sK3SDFkiUomW8N2LHISPR7y2aaIgk0S0EAFJW4SJiy6pa/ViAB3G4qqyM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPbeapRqFDnetclg0HXM6h2B0f/aZSHNte/7r6NsPbZPcmiuJ8
	zqDe3SiecIF0c8r3jj4wA5mqrv4pulqhzuSzW6m7diJLlqE1ZDVzFaDU
X-Gm-Gg: AeBDievblwiWZyDIR1tKPrQphTP+YHF6+g4gzgU/Hpto+bKoK+JA20n3BqjeQY9Zmmm
	b33notxLe6YiL//7aI9RIi/3v+ZI8fuZ1OezWFNDcA1h/GIEzezSTBghHo678wK7xQR1gd36VzY
	EgTw+a2ZW6UoaF4l7HXkfIJZS9mLiiVuh6SzYSgpqO0q2iz7AOmX0fG2ch0htq4Uq+4/3YSqh2C
	Z2MlsNSGzJrHaVBqZdpcEPkhP6+714wcaiFPG0DrnZ7XxiH4C+yE41UtskgRM7KNt1s3+adaGLr
	YoegNU0J3st0lbky/tIT2Ou8Ppkua4/OkRi5Ptp1OTOMZC4MzVjsiZt3j5xwUrRlG3/UE/Qw/AU
	zbAsnpcIiqUR29I5DMZngA98mjjN8bjOzDdDOGo591SIvsjAur49XeL/GKG764WzFDGwuP4k+EJ
	CAnOGp8QnchSy+rdliCzgWNZn6HCkA539cPT5knTL5J7MuVb6dupO0z6gXjIv6jIhSQXetJungc
	vWNYA==
X-Received: by 2002:a05:7022:790:b0:119:e56b:98b9 with SMTP id a92af1059eb24-12c34eeae15mr12703540c88.32.1776276776885;
        Wed, 15 Apr 2026 11:12:56 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:21dc:2944:7f23:f4d7? ([2620:10d:c090:500::cdb0])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2de8c606925sm4601940eec.12.2026.04.15.11.12.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 11:12:56 -0700 (PDT)
Message-ID: <c948fe66d53d09eed5c72d33abc54ed25b463c09.camel@gmail.com>
Subject: Re: [PATCH 1/2] bpf: deduce_bounds_64_from_32 tightening with
 circular range logic
From: Eduard Zingerman <eddyz87@gmail.com>
To: Helen Koike <koike@igalia.com>, andrii@kernel.org,
 shung-hsi.yu@suse.com, 	yonghong.song@linux.dev, ast@kernel.org,
 bpf@vger.kernel.org, 	linux-kernel@vger.kernel.org, kernel-dev@igalia.com
Date: Wed, 15 Apr 2026 11:12:55 -0700
In-Reply-To: <20260410124035.297632-1-koike@igalia.com>
References: <20260410124035.297632-1-koike@igalia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-04-10 at 09:40 -0300, Helen Koike wrote:
> Unify handling of signed and unsigned using circular range logic.
>=20
> Signed and unsigned numbers follows the same order in bit
> representation. We can think of it as a clock, were 12h is
> 0x0000_0000 and 11h is 0xFFFF_FFFF, regardless of its sign.
>=20
> Then, instead of dealing with max and min, we deal with a base and len,
> where len =3D max - min.
>=20
> Example:
>     range [-1, 3] is represented by base=3D0xFFFF_FFFF len=3D4
>     since (u32)3 - (u32)-1 is 4.
>=20
> And we can verify if a value v is in range if:
>     (u32)(v - base) <=3D len
> which is true if v is signed -1 or v is unsigned 0xFFFF_FFFF.
>=20
> This automatically handles the wrapping case, discarding the need to
> check if it crosses the signed range or not and handle each case.
>=20
> It also fixes the following current issues:
> * [(u32)umin, (u32)umax] falling outside of [u32_min_value, u32_max_value=
]
> * [(u32)umin, (u32)umax] falling in the gap [(u32)s32_max_value, (u32)s32=
_min_value]
>=20
> Fixes: c51d5ad6543c ("bpf: improve deduction of 64-bit bounds from 32-bit=
 bounds")
> [Circular representation]
> Suggested-by: Eduard Zingerman <eddyz87@gmail.com>
> Signed-off-by: Helen Koike <koike@igalia.com>
>=20
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]
