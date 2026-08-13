Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C6443B9DBB
	for <bpf@vger.kernel.org>; Thu, 13 Aug 2026 23:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786664430; cv=none; b=u4dzoFWNO6V6wwT9Dx+wZxkHkJpy7zvXLWHqeH3kxiXYEccb2ru648pxgEQOPANn279nw6459L+1bUYGeLi3yYnlivKfU0T3IOiP/DIDUhcgCRk1/l2768pZfNvpi3j6MbejnbwnYihV7TqDw7FL7YlzejAJl8s4Ko5fd7vrdGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786664430; c=relaxed/simple;
	bh=Vh6O2bkmGsyLVoh1YtwNyStE0H5+try9Z2nmaQVH2UA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=A6eGI3cpilXt7G3EGw4s+TxC/09nJeKSBZIgpH52DsiZ95icgTjS+igxvfsqShEw2iUgRxBgSsF2FEedsxnY4fVxfaJxWJ5pKHPAeZY1EtGzU1KEk2V2arD3eRGtTiFu5jzkCruaWXRaSr1bIgPv+DVjePvXX9erqxqi3/Z00nI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pbV493eD; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pbV493eD"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2ce87c7e3bbso6198125ad.1
        for <bpf@vger.kernel.org>; Thu, 13 Aug 2026 16:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786664428; x=1787269228; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Vh6O2bkmGsyLVoh1YtwNyStE0H5+try9Z2nmaQVH2UA=;
        b=pbV493eDD2GUUVhVZnxpj+32X5fMaRcY/tSQ31uTo+Jt+vBy4ZX/3Ue4aShRriWiJL
         dYaq6PLLDfDEILZIA+Ytq91gK58HB0rPKuQvU7OMaJr/+ijYFb3qGi1UdDhIP41Kyl2f
         YgsZe897XhJvpnUMjxJxRWa1qnyxI9aUsSzZKj7zcgcaw37JW8wlMkl2ORaQ8b9tzWic
         fcodXbDHV8H1DV+dJ+X7tcbD44MKnivMRJEIPp4WyeHac4LWeDtsM22Td8D88vp6Sgr2
         0rFadztKchAX/sBAt1rRlU38MO4TQy4hWF125KRhYs1j/pUQ9OLPik+fRJ3NaQQUN/+7
         7YLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786664428; x=1787269228;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Vh6O2bkmGsyLVoh1YtwNyStE0H5+try9Z2nmaQVH2UA=;
        b=OVVBECOR5YpRVGiSof13qZlDwIcBRPsX9cGNVkikng2KpjJZWjvn3Y8EKeSSlQ1jh7
         VNPtDnkO4pAR+ryCh4au9AXBxF5FRJ3XmBKmnXGnPtXiLsxgUNhCfGHm0bVvQ8ZgiJ2C
         DK8qMJf/AK1x8ybzqoXXPSP8UOvUhOf3199/MsT4SNP5WHQTZSKhsRc+k0u5DQocwqwa
         Gmnp2QfmmJ+yvC6DCh4CGKNKCTqKUvEatKQEaNVK62sa9h3tHjqBe0K0JdcQ0uA2M3TH
         WZBwBalukidYK0TfpM99kEY7k8X1CDZTuYHzeKUJ3p6aNT+tBilZ3VzzBeg3jRs239Yz
         NPHw==
X-Forwarded-Encrypted: i=1; AHgh+RpVe9rrtCy8W3uYm3wJtzdFsRpya+bL6TIWb5WXvGnHJ05Vb06xvI0NT6pkh7cNGLpb0do=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqkQn2sahlqR9K+1ipjXEt0zLnMXXiJMtSK5PLilHH7GR7C4en
	OxLcgAHUDmujygn73WOYlt9E5Lh4bqr7pZqI4YXt23y4/lwXZDlIcZ58
X-Gm-Gg: AR+sD13KJy5BrbBQkm/ckXx/uHWJbgABh9nYFEIcFQ8VCNwb5DoLB9f0sjdSanK2hpn
	rCf6vEY+y19OpC6vFPbtxkT34lwOt63eQucWtEs90FGfWhx9em0aOBef0DH8JEw8b1KNDmscvQe
	UbfgJ6eirIx/bwrXZ//LQhHX3v0m1027nsIqQaZf71vgkJ5FfNmboS/f+4pdW66XvY2FCmbjAZr
	40CzarBseBv84bQP17o2ekrENlitbUzSD8ZPD+VoSEMCxiKQoc/+IK8lm70YegbtntZDsKI3Ry4
	9vc+2ovirYwhH+kbt0Uy+uamDwSQXqrygMppHpf4neTkX69aBM4TvvHQwpeCZX/EjSKpj+uwAs8
	gj8NYlqW00AMZcCF1VNjzB3DZHieE1KS4pttVvAg+Z/vF2hTX5fWi4qBZk9Vnp7PM7s4v7SHS4i
	vsYyUjNPn2Lc5Ne4AOWkjncvRGDiKIbR8b1WqvDcnh5MFnDclPAO9WhMCkWiaH/Bp39nA0Z6tW+
	l/D1bWyKx+fXrHli+Dq7Ttgf6aBSnWhxuj0IQusrH0u/Q==
X-Received: by 2002:a17:903:2c8:b0:2ca:e5c:7fcf with SMTP id d9443c01a7336-2d3b08014f7mr21774335ad.3.1786664428259;
        Thu, 13 Aug 2026 16:40:28 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:2cae:4c28:2903:b6f9? ([2620:10d:c090:500::7:1c5e])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d3ae756b5fsm2956905ad.11.2026.08.13.16.40.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 16:40:27 -0700 (PDT)
Message-ID: <9a038e45b117a359960cc6f944655dac1ce943f0.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 3/3] selftests/bpf: guarantee zero
 termination for veristat test buffers
From: Eduard Zingerman <eddyz87@gmail.com>
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org, ast@kernel.org
Cc: andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev, 
	kernel-team@fb.com, yonghong.song@linux.dev, martin.lau@kernel.org,
 clm@meta.com, 	ihor.solodrai@linux.dev
Date: Thu, 13 Aug 2026 16:40:24 -0700
In-Reply-To: <6142836b7397cc1eac282de8416547c479dc8b2efc514f2b3873db36ff00f5bf@mail.kernel.org>
References: <20260811-veristat-filter-fix-v2-3-6c234c4cd6ef@gmail.com>
	 <6142836b7397cc1eac282de8416547c479dc8b2efc514f2b3873db36ff00f5bf@mail.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2026-08-13 at 23:38 +0000, bot+bpf-ci@kernel.org wrote:
> > selftests/bpf: guarantee zero termination for veristat test buffers
> >=20
> > In veristat tests replace direct read() calls with calls to
> > read_output() utility function, which:
> > - guarantees that the input buffer is zero terminated;
> > - asserts that read operation succeeded.
> >=20
> > Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
>=20
> This looks like a bug fix rather than just a cleanup. The pre-existing
> code called read() on a buffer that was never zero terminated, then passe=
d
> it to __CHECK_STR() which expands to strstr(). Because init_fixture() and
> teardown_fixture() reuse the same malloc()'d buffer across subtests,
> strstr() could match text from a previous run and report a false PASS, or
> read past the buffer end.
>=20
> Should this include a Fixes tag pointing to the commit that added the
> veristat subtests with the unterminated read() calls?

Nope.
