Received: from mail-pz2-f43.google.com (mail-pz2-f43.google.com [74.125.228.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50FF73AFB11
	for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 22:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789684377; cv=none; b=AcVH4HqG9ZvCE5VkQNd1TADuzJWmhcKtd+BbPfjixDaJUaK78OUYMv/DILX+6n3v+83PkVaLnSuhUYV7FAlqaYOoHEjzaP6CIFsFZnENVghSzuHrBy3LGjjvOfHe/dZjIXosx4oxA9AR6z2tSEIwntqsbx/aM617HsiyLdR/CPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789684377; c=relaxed/simple;
	bh=a2mwHg0kE0HJVWk8zZkOtU8TBaNIDR2JTkC8YzT7u+Y=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=k6qtYQ8ffYLSJd13xy6IAr2PoFuzehwc18xZBrKeAPD6UCg4nvTrelE+xsvxTHgVOG8h2Bwlo+a5IMqvWGBLsbMTbC8EARZxCfF87UmwfIfctcF1uIZBHrMipHfk6Z0EORmN1Iflyqaehv4zAjQsLBQnasRbIb0pDBbvFkQnnpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W9ypWy2W; arc=none smtp.client-ip=74.125.228.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W9ypWy2W"
Received: by mail-pz2-f43.google.com with SMTP id d2e1a72fcca58-85469e25187so77292b3a.2
        for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 15:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789684375; x=1790289175; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=a2mwHg0kE0HJVWk8zZkOtU8TBaNIDR2JTkC8YzT7u+Y=;
        b=W9ypWy2WKLbqILHeSYMIlqVgBFJFbklEWC6TS4u8EGO3ld6Necp92ouKGnPDC9yIMr
         7H1sodSbu4Oc12NZaUR5oAf2S/GWaMvKWoMG2wLtgUrD33JtWeI7ldi903qFp+oSb8J4
         nCnQ+u4gSunS9n0L8DnlySpqdHPo1cD4SJw69rAh3GcvUyFoEtxhzuYcHXGf10vPJUxF
         2OwHqzBxduiE0D8CaFTHFx+RiwrV2oxyslhjODwuF2z22LE5h28L2kSKzsaWTstG3Qre
         pBDLZ7UJ1yAYTYfVSIkut7y38L/QCaDYa5qEGWLhugtP7cA78YtaKR2GGnUl1yTlxrhx
         Gf7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789684375; x=1790289175;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=a2mwHg0kE0HJVWk8zZkOtU8TBaNIDR2JTkC8YzT7u+Y=;
        b=2XYqyhCb0aPPit0aVnig/u5+affdmObpjLi/rubjqSWHwGhgOxP9GMjekOp/xgF0Ab
         Ab6YuINE7fpBrV649OL6VteIn0OsvVFPcmWV2w8kD6jhcJbgJgRARa5rv7nh/GxsjinN
         LYwvPZ4uFRK7yMcqkC1rhiA8HVQhN+u5fFzG5V+Lh0Nl+QQXYO1tPccrLiW14je3FPmC
         yt9eDNtfqCi3dXiuJaeViaZqg4AuuL8gFLyIedmEfjrSN8BUJSEAaZoCz7lq6WXUbgCY
         v8mQq2jQejjceLi7ywHw09k+viWhC92jMCteyMMKBFCaU6405YJEzhuICjXoxqKxoeuR
         3FBg==
X-Gm-Message-State: AFuF++lqpSYZ5c0q6xrVbI9FlUydyhjxmuvlWQIlwnmk3XipBlErng1u
	g1LztRCTPhmzHRN08/7XxKWIjb4sEX6DqfGUMKBH5P0EKj9getNi6EmOUeYlbKaS
X-Gm-Gg: AYBFou1OH9+Epb3wVAEKPKVNaLhNXWWUvARMrpU/a687oUAh34SwM6aJpktaA1fk4Tm
	E9rHhFlLHEOcHZ1KkK78Hng61wuXJhyKsv4elvEx35FFPYzsSxHUjp3hz4bQ3jXiDK0MIBJHE8A
	4E7DVoocR2MnO6cVku0bbvzMkbOabn/NUe8itr/2v9DaqZnLbWibfYVwrweCosSNHPzlbrTYQ0T
	9fRjycNHLqnAG7o068qR1Y+OXxE1u1PH4JHKu9aGCq7aE5n87x8QWvv0NWln1+BuiwlqsEPH9Rg
	tToSbrDkdMVzdEZR1rUNL4TPh20AXHkOOxAldXxSSK2A0tlkL8kdVMLmXUFj0uZXBLmmYcQlU8q
	xzQv7WkDGvxioXtfZr21HJAVhzrukx2pqglduHjsGSFK3nMK3uElIuErN9dOvA1sCWhrDIaekhO
	34sRCK/EWascu9Fgjsmm+4P2abifBmEF7Dn204wkG3lp4bq4y/GipYtZQ30gOByD/IuFyZyLdEs
	RlojWBsrMMA7XaQlkQ9xmFvOE9Vm/mbtRP+89gMyWPPekgSLpbM2Vto2YqTEkLl6juP
X-Received: by 2002:a05:6a20:439f:b0:3d2:df:1854 with SMTP id adf61e73a8af0-3dd8c2aaa7emr764356637.6.1789684375413;
        Thu, 17 Sep 2026 15:32:55 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:c47a:decd:950f:5c9d? ([2620:10d:c090:500::7:463c])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33bf5b0520asm18808639eec.27.2026.09.17.15.32.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 15:32:55 -0700 (PDT)
Message-ID: <fd118fcc42ea435d04982b36e4a7e454b1c2edb2.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 1/4] libbpf: Walk types in
 btf_dump_resize(), not in mark_referenced()
From: Eduard Zingerman <eddyz87@gmail.com>
To: Ihor Solodrai <ihor.solodrai@linux.dev>, Alexei Starovoitov
 <ast@kernel.org>,  Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Kumar Kartikeya Dwivedi	 <memxor@gmail.com>
Cc: bpf@vger.kernel.org
Date: Thu, 17 Sep 2026 15:32:53 -0700
In-Reply-To: <20260917012037.1396254-2-ihor.solodrai@linux.dev>
References: <20260917012037.1396254-1-ihor.solodrai@linux.dev>
	 <20260917012037.1396254-2-ihor.solodrai@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-09-16 at 18:20 -0700, Ihor Solodrai wrote:
> btf_dump_mark_referenced() both walks every type added since the last
> resize and decides what each one references. Move the walk out to
> btf_dump_resize() and hand the function one type at a time, so a second
> per-type job can share the same pass instead of adding another one.
>=20
> No functional change.
>=20
> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

...
