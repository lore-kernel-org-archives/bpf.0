Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30ABA35C183
	for <bpf@vger.kernel.org>; Thu, 13 Aug 2026 18:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786646056; cv=none; b=EYlKF1wmmUAgLAS4T8h0bY+3UrETeDY4dwQoNHRiuRKdCI4ofQA1BUut8qYStJAbsfLV09g8E8hDtBHRso+isn8cU52qbnjcITJ9foHfxNiRJYpZ4AkY85Xjs1Ma2Tjy+mNqkJIcAEbRmHMvs3cj0fW+tsCSwVyiCqXM9D4ZzCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786646056; c=relaxed/simple;
	bh=DRJtIEX9qkC4/qw05OwejSSbvmFlWKfFHLYixsCuDeE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XLam3C+Wif3blNyYkWChBgpF3YttTFMrotKT9roSQzPI4ZvOnMNCHYDPEPtP5gF3v8xpwRcbwGXD7nz7bEbAzvtVlZwU0B4h59uqPw/+C1viNxdZDbDDO7erEuzzzzta8Fv9X0TNjv6kIuyITpoGB1NdvMz6TVJYvz9oJU+x8Mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e/vfWv8c; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e/vfWv8c"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2cc891373e0so4127315ad.2
        for <bpf@vger.kernel.org>; Thu, 13 Aug 2026 11:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786646054; x=1787250854; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=DRJtIEX9qkC4/qw05OwejSSbvmFlWKfFHLYixsCuDeE=;
        b=e/vfWv8ceZrsSKAztbxhMYDDIJ3WmiAXq4x3zlZFTECJ/I51QAs9GLtsqMexRR8JUL
         n6cQwjrPV1PtNspq+gE+rcKJFWciAGOPkpEM8nW/Xu/HmSkrIKw8i5q+D6cMkWsUttO+
         O/IVJHJruxelfTXtDu27JJ21NrfHJXDsvFcSxqyU+YrF+BiHVb+ceQhWaa4Fki8rtGg5
         P59fB7+VHooeYy6/ffWqWJkiD5NT0h5D5JEF4eKi0JBdQBQINn58TY3oU5Nc759Rjms0
         ADV/UXpKmOMGaEEF6HntrpzcLyCv6J/f/yDMj1OWvrG+MkitN919F4r+6Mrx3z1dY2RN
         Iwew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786646054; x=1787250854;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DRJtIEX9qkC4/qw05OwejSSbvmFlWKfFHLYixsCuDeE=;
        b=QyIflRbPnsMNKx84CDDlT6N43DPSsiC+ODP2wesbn1eNw1p2jZ7JZDyG6N+tv1dSVv
         pZbw45QN96HwxC/zUBgQDEQxzwa9oPy3zm6yNETLw0t1kImd1jlTmkH/0A6tK0cwRlpH
         hsXM15Uv1uTidqMAUOaIMutkt9V8j3d6hz3k9gzQb1HiTMrqogAYJiXagJRvdqUGQg/n
         7AQefDDO3UhGH7xEVKM6fZ0YaphmtC55C8PKJY66fO4a4o7SejX/0mPjAdxiRloxS3t+
         YOiht4OJLSM6zC42wmgGgNt4arK8XmTBzxk/+MteiQKhsZ9kOWPL2mGnVY7XgPEe3RG+
         pfIw==
X-Forwarded-Encrypted: i=1; AHgh+RqbK9pO5LWaHsXS2+V4b+2p3qzQGpZRowkZg503b5h4FX7GUUIR3ZqZCowBtVbAQm2xbTo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSF235tpR4mz51WmW8B8ZAZbRhiZdmc4h1KcmAiiVj/aUGHqoc
	dxCgiQY6P+pOclaVRF48OVgoU+HzKRil0iY2WkA75xDdbMNjkHDWyUuO
X-Gm-Gg: AR+sD10Njp0PnqbGBE4MJI2zp4xHBaNACUMM6CgoTzlMC1WVELBK46cG2m1BZLH3vsU
	hhakVMIpcmOhDVgs80I2e+tjO9s7i+ePO9GV4zQ8iWY5vqQf5yN5eI8g9msGgDxYJpfm+3854Dn
	mxUmZDX0SM5tCsywtjLWQSzdh4+57QSDuS4Wzu1S7yg6oGYpTR/MEx728g3luIbT/z6fsFsEfDt
	ktTc+MsVnqb/Z4YrhZ7qYqzPddhilAzcSvSoV9xxsU9mjLe1T/MXLZPljgc+YXO+QOxF8dFGCiY
	LrR6tllpTMuuo/NZXrr157XvkOWV3aoMcYo9QcwmuLpmarwgT4imqF9i7w3yHTK4Kl8wp67ZLrh
	9XgrO8OulfOD1OoPUn7BMUQmvVpiMif5342P6I9aCb4UO3vn9ZYzn4I079HPpStLmXsYi1gHTGH
	tUtlEieCQq/KKyavxSnM0EqmJmNdY2HURWwQ2ywib5Rw7M/kN4VawE9lcxE7wmp+Qx/zKqmLxlD
	bBVF+fmchXsjra9LUoMhW18X/16sgtsOROigudH4RMxfg==
X-Received: by 2002:a17:902:e746:b0:2ca:329:3da1 with SMTP id d9443c01a7336-2d37e86b7bbmr82400455ad.16.1786646054308;
        Thu, 13 Aug 2026 11:34:14 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:2cae:4c28:2903:b6f9? ([2620:10d:c090:500::7:1c5e])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31ec022acacsm491643eec.27.2026.08.13.11.34.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 11:34:13 -0700 (PDT)
Message-ID: <6abed14ca69727d780551e2f4e413fea746646d6.camel@gmail.com>
Subject: Re: [PATCH bpf-next v4 04/16] bpf: Prune verifier diagnostics when
 switching paths
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, Emil
 Tsalapatis <emil@etsalapatis.com>, kkd@meta.com, kernel-team@meta.com
Date: Thu, 13 Aug 2026 11:34:11 -0700
In-Reply-To: <20260812233326.3575958-5-memxor@gmail.com>
References: <20260812233326.3575958-1-memxor@gmail.com>
	 <20260812233326.3575958-5-memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2026-08-13 at 01:33 +0200, Kumar Kartikeya Dwivedi wrote:
> Save the diagnostic event-log position with each verifier stack entry and
> reset the environment-owned stream together with the normal verifier log
> when a queued state is popped. Also reset the diagnostic stream after
> successful subprogram verification even when level-2 logging preserves th=
e
> normal verifier log.
>=20
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

...
