Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793130661;
	b=ButDTXErwoxh4G8Kn0PPgM6KhOqEbbiRcHNWaJmlhhlwhCk9OujVfdMJJw/cDfCtpTjR
	 mQ38F1fY9q42/1lmBO/qCwHtGjswHRlvmQb1FdGOy8zswTW7ng0j+IE7X5Wb1COjlau3h
	 2FsZgOVRtdEzRsOfWsGv3J9J1xulWbRdKmfsbRzBOLa/DGKsPOUNL8j/H2/1u+dobHXmP
	 jlE8NbFq/HE0JW0pGH3xM+S3v+/jGGXdR/fPYeaKFv9HdB86abH26JAfm2CmWmCXV/2LT
	 9XYPvllWcIoYoEFdSCr95c7qZr3mbDIkrY40n6kwjv7SK4h9U4fBDsVM3ROyqYvegPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793130661;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=p3LnS5Gulsc9P8LXC3xm2cQUPKUuZYi2P3RaYtCTNvY=;
	b=UqpN6iWa5jwOmqMxO0Mi9kN4suYHLShmLzPnPdf/Xga64idWrCu7Dge/LJxppM9K6LJb
	 1FOAVtzhUXtRRLCyRDE5tNHNVsPsWktBioa8zKcGM1x5OwICjeD2m4LWhi1GxlWFoaBwX
	 zB5juMDSs0GJuAUvkELnicdt/JUYoDuUcHsBgtfQmCx32IgYDMnHT/KFqZHAxQUYDqF3K
	 WZQxHHnzf1AK8TC/+uEoHlzfIjeNwKJ32a8pixr+79ilC+x8OFEOtVxFH/BurNr7XYrOx
	 r8I3zYISSTPb/Mrvf/8i3/7ZMaY6AexaRT4znX+wJBlOt3Z2Y6m8Oh7F8h7d0xbSuCQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="hNOZUyg/";
	arc=none smtp.remote-ip=209.85.214.171
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93F05606A31A
	for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 19:51:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 93F05606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hNOZUyg/
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2ea138a3497so888095ad.2
        for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 12:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793130660; x=1793735460; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=p3LnS5Gulsc9P8LXC3xm2cQUPKUuZYi2P3RaYtCTNvY=;
        b=hNOZUyg/mwrPzxp2S1lHdyOr1fPY+C+6jXhzJKwsLG45c9nI4YCQoqwaTqNe/iH/EI
         rtzusSj0y7nQwbNMuOtXn4meDZD0gKt4i4yOwcb1TsHu5K4WcFXLe9wg5qBcrfUrGYvw
         CVXcsm5Kk1IFwcLedRJu+RB2fmuxWLQ+qmtdBLi+tnKsdd46369QBods2lch3rbBKlfY
         36TYpAIM4cos1PqVdD7IfydwR730JDx6b+1UcCVs1T9plQhTuQGwrELsbd/SSh0HD3Lg
         G4k5Wspmq9Eq3nfO8pNtrW2qvNwM2gQrAR2uKNKnRzlbcQ4jMH0v8RFS5KZU1W0/wEQz
         D2xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793130660; x=1793735460;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=p3LnS5Gulsc9P8LXC3xm2cQUPKUuZYi2P3RaYtCTNvY=;
        b=FoUn1bxD/jLuiLOa1nlmVVhzOw5ml9O/GDcPclN8Ieqx+I0IGOtdM6BYnAx28m1B5w
         qyFSUd3rfWwWVYcNsiHs9tYnHv+MqJz88vfz2Ls3m38w0L2nCkj1kw5ezu4+LC614WJQ
         rWeWBYEql+w7dalBBR/6ZUwmMKCLXFr1WU5tzi0TlLpmeCIHa/vM/uNATVcGIsh71XTX
         03R8LrnZ63l9hsUMRijdhmawJ6OoI43CI/0uGD37Z6vZvuP6wiP8q8KSj9cHe9X3gAXM
         Xr1IL59QyCIqGsSaGPvUdf0gaxElq38mXcONT1BTWIdQqtxTdNsUX1N8SBGpJFCZymSU
         yOWA==
X-Forwarded-Encrypted: i=1; AKwUvBwgvjkz66dfrdxLpb90gzKJJd9nvL30iM8Q5DoUDwgBt6c66T118od5nx5ZX0u9ahB5fIg=@vger.kernel.org
X-Gm-Message-State: AFq9FYJmYSe8W/9CGNpujqXzwWCeN6K64yRx/88mji7p+UL/5qZ38lz/
	CPPszKd11zgcbDnGc6nC7341vn3p/+GTPX+E0uYllpW/MHd+Poig6ij9oWdHoQ==
X-Gm-Gg: AYBFou1WootxWHvw4Fvn4gp5pi9MwqlAl30WiLY+UaYIGoLcqmVGF6HxfeWjAycQrNM
	oZZIyMnA9fA9+VGjp+Dg6SZJ929x8BJu6y9VrUtHkKKzHlHppxRAzO8mkF6C053RTLmXJvByDNE
	afTw4MvZ9DihltiggHKKky+E+THxVFF2ofDMgzgPA3tNaWSavyoPKrQ/h3327pLCtbCS6pI6XAj
	Mu7jv5QIiY+FcPbfQU4c+hgo71639/Z0oto02Lah6LciW4FIz7GenyNKseaXpRMQOmcC9Jwg2xl
	bbS2damPEEQF0yQzmaYyH7PpdrNhmUx+rnzzEYIq0Mbtu5krjvHIpCcjzkIDd7OQDhk1uKRaVrS
	o2+07PXPl63hjE3mmYDF/o4t2fVf+r1v8YGaZZEyyOs8cNL0GLaO/mmlL4WeCRRBtHtJhbxOqG5
	7A+s/y1Y4y/1Kw6UakeJWMp2kMh1r9faWpU2DOfJR7JQEs/SJDxY2UJcqpX/QxDPyePOK+Mm9os
	x5/47mQx/vAMeOgEtaWgUTDEFI0aT+18aEuhVnHoNBZ9dyPcLMYi07Qp0itj/zgg3DmaAa5VHe8
	QAUtiOdq27FRBmoOgvOiMQ5XVCbUK3Wq9Ycl6cEPZgbRaf/smaW8mAQ4XrDpb7RGTgAv9opKK+9
	KVpHxA0cPh0EfKYfiTGogpMD7WeKI0X8fjg==
X-Received: by 2002:a17:903:94d:b0:2e6:2868:e576 with SMTP id d9443c01a7336-2eb003c10a9mr3665665ad.31.1793130659750;
        Tue, 27 Oct 2026 12:50:59 -0700 (PDT)
Received: from localhost ([153.61.198.242])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eae6453ea6sm14514935ad.10.2026.10.27.12.50.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Oct 2026 12:50:59 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Tue, 27 Oct 2026 19:50:59 +0000
Message-Id: <DMFVROPTON36.3LX4QMXFDA91K@gmail.com>
Cc: <andrii@kernel.org>, <eddyz87@gmail.com>, <memxor@gmail.com>,
 <daniel@iogearbox.net>
Subject: Re: [PATCH bpf-next v3 5/7] selftests/bpf: libarena: Refill local
 caches in batches
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Emil Tsalapatis" <emil@etsalapatis.com>, <bpf@vger.kernel.org>
In-Reply-To: <20261023002056.6647-6-emil@etsalapatis.com>
References: <20261023002056.6647-1-emil@etsalapatis.com> <20261023002056.6647-6-emil@etsalapatis.com>
Content-Transfer-Encoding: 8bit
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Thu, Oct 22, 2026 at 05:20 PM Emil Tsalapatis <emil@etsalapatis.com> wrote:
> +	if (buddy_alloc_bulk(buddy, size, BUDDY_CACHE_BATCH_ORDER,
> +			     (void __arena * __arena *)slots->objects))
> +		return NULL;

This asks for one block of order + 3. When the existing chunks have free
objects of this order, but no such block, it goes to buddy_chunk_get().
Before this patch the existing chunks served such buddy_alloc().

A sleepable prog takes another 1 MiB chunk.
A non-sleepable prog loses 1 MiB of buddy->vaddr in every buddy_alloc():

  buddy_alloc()                       the cache is empty
    buddy_cache_refill()
      buddy_alloc_bulk()              no free block of order + 3
        buddy_chunk_get()
          buddy_alloc_arena_vaddr()   buddy->vaddr += 1 MiB
          bpf_arena_free_pages()      deferred to a worker
          bpf_arena_alloc_pages()     the range is still reserved: NULL
    buddy_alloc_memory()              one object from the existing chunks
                                      the cache is still empty

After 1024 of them buddy_alloc_arena_vaddr() fails for sleepable progs
too.

Should the refill look at the existing chunks only,
like buddy_alloc_nogrow() in your other series?
