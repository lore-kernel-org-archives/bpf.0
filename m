Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793838607;
	b=atq0u/1/lTPPE0+BErRa84agNZzlNT36T8ajjKSEJRy7aC6cZgV49pjXaKqDGEgG7olY
	 yUD94xIFRUKNKTamZbsOpQYhvUTP1fgYoUjy+0kF9o5fcjoO/y319fMSvecHdzS1KPmSC
	 g7JyjofpXiEbc3/XLRFwdcWEBzKVDgS1p0pecYvd7ZcwnOyvsKaAlMO9oCInCqd6LEghi
	 TO4c0Q77PVNpVU9qszT7GIm51pP9u9dltCQTmZ3PrCeTNJFmNTWj7iIepm/7oJ7Hi6t3V
	 avQz08SQRV9D2ZA99EwbX9q4sRVYuUfZZbDh93oze2GpVhLtVVSua34TdSo1TFhmhNg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793838607;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Message-Id:
	 Cc:Subject:From:To:X-Mailer:References:In-Reply-To;
	bh=CAcUZpu5nr/WPaZ13L4lxRMWj6+TFsdnALQA+l5Otkg=;
	b=yj95UGAB2nH3lO+qiixStGQNsIafFUmqgr+PNMZ3oXEq6NExLP7uZYqARp+6/IrqHuFp
	 vxBbIsgtE2w1t5+NW1Ns1dLDP0qEMF4LKJkrWLu0LxZ0aPXf7U+CfN9o4pP8DRbCpmp4r
	 jCcq4dDjGJV4h/LtHLI+msg+Ds/SPuRwvk5duJJvPQAXWXrYLKb4xRQTdwBFpx5iYxI4r
	 w1l0+VIXL3c+apwaZFL/tYqAnHDUweXLyYinYKu8C0W0y8VvSNWHzx9Csm1TXjCUTOM0O
	 aSDdca/yH8KHKZxVltjLnsxQscnXQtX/XZ9HTSrL5U5MNwq7ozKbrRVbB4ke68CkObg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ETC3eoqE;
	arc=none smtp.remote-ip=209.85.216.48
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CA45606A328
	for <bpf@vger.kernel.org>; Thu,  5 Nov 2026 00:30:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5CA45606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ETC3eoqE
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3ae1d0caaedso703834a91.2
        for <bpf@vger.kernel.org>; Wed, 04 Nov 2026 16:30:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793838607; x=1794443407; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=CAcUZpu5nr/WPaZ13L4lxRMWj6+TFsdnALQA+l5Otkg=;
        b=ETC3eoqEi4Gkqv8qwUrWl7KQgY6wCscwydTBodWUuXZpf0daeoidP+Jt9MYCprqTGR
         fi159MPpN/Dn9/Nvxf4+zf+aEM+PSAhw5Vc6EEsO0DDP81XoV1tQyKkV1nRIYC73eN35
         n91/tDLEXiqrbINEJIiPA4kOjBYEuu3Xn7uwsqV0e2JjAzfi5hsplVoUURMA3hlMXXgD
         pcNb0gdFhEndZfe7Bq/BauU6wXatpoDcnQqzIyhNPnMK7Q4rIoY0uQZW96JuI+kQaCJh
         xRkodqxzA8Uott+s/hMYyb97ZmDyT0+uUtRO6W/DwimTyf6d1v9gLB3x72H8XCxpZDdL
         RK+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793838607; x=1794443407;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CAcUZpu5nr/WPaZ13L4lxRMWj6+TFsdnALQA+l5Otkg=;
        b=OiF5NONar65gZaeppe/N1yCq/neb05+U63xA5/UGhdDqeI9Ag7Dj+xBR1okm/eSRaM
         stR2x/2aELQ3s05pNiztv3K82/9JHjMXG7/S1fxI4xHJJ6nlAKdmPRZAc+KxoIrnY5y5
         u4nI6mvcLuolt6EumKiKdsPrFlTJ67lMCTtex2WaEawpbESdiB3yMYhZmEJ4BOsp87fO
         5xb5tRFUlJX5+UdZsEiGZEHXrQu0LvpkjKE6qzQ27HVVLK6EJZ5QnqVjNdOID6Pf4VGI
         n84MdVK77nndMd+rF+jO4ujFDNxNQy5OFGe6tzS/8gb8SucEPBNB6t/57AVbKZ5k7Vfb
         xxvA==
X-Forwarded-Encrypted: i=1; AKwUvByXUTwDs5IQrYBjkn16Jh8utcRbs2PIrK+OEsBUPErAk8fxyFlVWsvOMo1mR8xc1RqK4ks=@vger.kernel.org
X-Gm-Message-State: APuU4Z+MOS8N7SZk/aVCdjk78X22q2UrMOo2KM9RK7WqQwCyoGO8xmJF
	gp4xxrxvWJ8PkfBkPkrHfhCELSxuHMt0AAb5GocuQEWiOKivRXe0aJGm
X-Gm-Gg: AYBFou2JFI6bEzR3fkzGyqDz0afsjNPnC4o9LPxyFAv5mXpXdlBC07FL4aIPh5apfLY
	iZ2jFLuQvxu9NFr+FAIy97JKTz+SpYf8oaQaKlQhI1zObyFSQfFkmxZnVOQIeF2LrP3S6J8ew3X
	BrRCpRmrVpbhOL4ax9yYjDCmXcxwI8fmizy+LWeODeSViPbZ87a6WZpE/WPQCw1HVejQ1ki50g7
	LoMrYK5YQi3/Vfirej7S5aU/VcjGhrI1KdlrtaE7DzlrckwRQjnndyRrex09xBFJDQjVpCNEGw2
	4DgWUZs4/kaBxh/52QD7dY0rKwzKrysxRKg30nvug2ijmVPs1YMySTN0pTPubCj6Dr7Q1+tbZfF
	5YjiTRvKAXYcrlHnLWBFjm6O4QxLC2LJ8bj+u8zfOsbZnDKNY2soEI7ajtcnWLmPBfmLR48ICEm
	o6xMgflNsgaMGVJQt2u6TI3yMyiU3DWa8zGDrCC0uPlKldM08joAo+sGzlcFFRtp7bRdIkllFJS
	rRfOWba+BhG+3uM6KGUWlwA5tTzPVt1a4AI5lZLAXrcgh5B40f9hhYzo8YX/S6XegNuUuVpoiki
	ZANUeO1m1HkzQboA+BNKK7/tjyX8Tr3f0ExjBeOk+qlDTR6M+MbLX0/LwhTqw65b6wNJpA+MW+Q
	0Kx0/TcqRXyUnOzAfoC8BgDpl2Dp80TK3wg==
X-Received: by 2002:a17:90b:3e83:b0:3ab:c370:3684 with SMTP id 98e67ed59e1d1-3ae89767179mr14059462a91.30.1793838606419;
        Wed, 04 Nov 2026 16:30:06 -0800 (PST)
Received: from localhost ([153.61.198.241])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b0b3131f8csm1099734a91.2.2026.11.04.16.30.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Nov 2026 16:30:05 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 05 Nov 2026 00:30:04 +0000
Message-Id: <DMMUPQJKJU84.344QCJ431X9I6@gmail.com>
Cc: <daniel@iogearbox.net>, <andrii@kernel.org>, <memxor@gmail.com>
Subject: Re: [PATCH bpf-next 16/37] bpf: Count loops whose first value or
 bound is a range
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Eduard Zingerman" <eddyz87@gmail.com>, <bpf@vger.kernel.org>
X-Mailer: aerc 0.20.1-355-gf870624f6c37
References: <20261103234104.208239-1-alexei.starovoitov@gmail.com>
 <20261103234104.208239-17-alexei.starovoitov@gmail.com>
 <f1e784a5de228293bc4fe21a5cfcc60d93a4400d.camel@gmail.com>
 <DMMMYOKCCSS2.15GTRVXFVMHTL@gmail.com>
 <74784940b7a6dcd4fee6f3008307ee6b04d65bc3.camel@gmail.com>
In-Reply-To: <74784940b7a6dcd4fee6f3008307ee6b04d65bc3.camel@gmail.com>

On Thu Nov 5, 2026 at 12:26 AM UTC, Eduard Zingerman wrote:
>
> I have a sketch that extracts cnum64/cnum32/tnum/base/step from
> bpf_reg_state as `struct scalar` plus a set of arithmetic operations
> and moves scev.c to use this abstraction.
> This removes `bias`, `domain_range` and unifies _count and _max
> variants, separate 32-bit into 64-bit embeddings.
> Can share tomorrow after cleanup if you are interested.

Great!
Pls share now. No need for cleanup.
