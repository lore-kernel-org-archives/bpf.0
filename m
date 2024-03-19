Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF0F81754
	for <bpf@vger.kernel.org>; Tue, 19 Mar 2024 16:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710865469; cv=none; b=AuBi6u4Y7NCv1gPcrMlIXql06SLamEBtxSMQOa1b89+gd7NY4Iqr+bCg63CatVK63tvSt4AAC5qEmdpj1Rc+H51d8diLQ/Xu7iLM7qEk047n+PFSyQI4xZPZkPA5FBnXOn+DB4ywEDAjclVRnkUjlT4mcy8pl4ly+Le7ZZmq8Zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710865469; c=relaxed/simple;
	bh=ba4u/SReX+3KCyyPprFODc4oujyEH+dg3H6+Au2Nzoo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UBvbQZDnMlO7amYWNyOGgddlhWoJeTozTHCut1pIFZEoyBHdizB90UrKaZ8CMm5XNetXRxQ6zAZvyphN5HLu16fhf1+p7Ile9EZo/kIGdJ3w9u6/TbewQhMmzBQLjqommcDf/E1TihlBMj+dW3Hez+bZfoM6HC6Y9W64JAXfZgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rx882Grt; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rx882Grt"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-414612cfd82so11189255e9.2
        for <bpf@vger.kernel.org>; Tue, 19 Mar 2024 09:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710865466; x=1711470266; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ba4u/SReX+3KCyyPprFODc4oujyEH+dg3H6+Au2Nzoo=;
        b=Rx882Grt/p0jqmgFvJTkS9CxXdeieVmtqHmM2pKHUNhrwGQ7WnIPwoD5QA/Shzrx1j
         BP1VG8/Iuk4gUiH+xShuaqNcLYUiLOJsoS1BN4h1AoM+A/eFNpOXO5/5opw0biV1lNfC
         m/7ZsPke/L1p/BcK9hdNn2kDD96nE4pUXduV9+tTNMHOWnT8O6kYbJMuQLchQcjfEy1F
         f1YWhtGXyiRWRzGeNLe7oKmJoWQDXIDI3EF9ESnLGZad5DCg+l0rshTW7rWXTXnFLRRp
         NP41HNsyjI/kZH4v8ZMWkkrKT/o0JntpjQqZ0rxxx0CbupD8a8JDuFnsRx1hdbUYf4Uq
         ELwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710865466; x=1711470266;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ba4u/SReX+3KCyyPprFODc4oujyEH+dg3H6+Au2Nzoo=;
        b=djDFtWRAhPwKjfC1MzBqSGO8FeVMG2H8/YE4XBJ41oGAhwN0as9RI8RwcA121zHBTV
         Y+x1nROOZqgqAGPpy3pVUntByOXEKfeJznF68I3Ydg2jo0IgtdQdFasvLk+5M1DNZNGv
         3l9cLmatD4rEb5awsHR2Sf+JXqrbYmqnSYcmd+oXpfrH8RZ4k69mFt9C6KMaPneQwFWd
         +8pn3w5R0j7VpnBWl1scK0K4BuwbUfeemgLpY9/Twq6Ym3jfrkWcmcqzENysHW5alz4p
         /7rWrwa8qzbUvnQPusPVNXdVaI23Hh3xryVbjqwbGx40oiWhvkETx10zHv5xFTuN8nQr
         uKRA==
X-Forwarded-Encrypted: i=1; AJvYcCVC55LRop9QFqqSgkD4dD666g1O3B+O8JoV5W+EPrK+Lw+C6lelgS2phGeH15kj67aUzxhzrOwFEcpKtsVsxt26Ryta
X-Gm-Message-State: AOJu0YxFB8YyrvYe4/Ni4T225fneQKosZW+Tb8YYoNg9CDHy5BPY2IIv
	sZ7VssMlDVhvsADbNjZTE/Fim7urG0HtO5Q4NN5Qm0V+spWa9eRj
X-Google-Smtp-Source: AGHT+IHBu7a1z4AGVag4lhMT7ZXdVhY/vV0gHQZt0L58VMv+4OGdAkXYC0W0wIlaLuutzzNyTySBQQ==
X-Received: by 2002:a05:600c:19ce:b0:414:255:c6a7 with SMTP id u14-20020a05600c19ce00b004140255c6a7mr1898536wmq.32.1710865465609;
        Tue, 19 Mar 2024 09:24:25 -0700 (PDT)
Received: from [192.168.6.255] ([5.1.5.0])
        by smtp.gmail.com with ESMTPSA id fm24-20020a05600c0c1800b00414650448a7sm2480576wmb.11.2024.03.19.09.24.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 09:24:25 -0700 (PDT)
Message-ID: <6a904a7257998dd5576ee18f46c204c426f10cee.camel@gmail.com>
Subject: Re: [PATCH v2 bpf-next 4/5] libbpf: add support for BPF cookie for
 raw_tp/tp_btf programs
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
 ast@kernel.org,  daniel@iogearbox.net, martin.lau@kernel.org,
 kernel-team@meta.com, Stanislav Fomichev <sdf@google.com>
Date: Tue, 19 Mar 2024 18:24:24 +0200
In-Reply-To: <CAEf4BzYNCYyeZJSf0YUHf9TG2QwwqoFqgYg-C_bfe2rpHK2dAA@mail.gmail.com>
References: <20240318184037.3209242-1-andrii@kernel.org>
	 <20240318184037.3209242-5-andrii@kernel.org>
	 <2887bbf7ec08942ce15740044860aec9aa9870cd.camel@gmail.com>
	 <CAEf4BzYNCYyeZJSf0YUHf9TG2QwwqoFqgYg-C_bfe2rpHK2dAA@mail.gmail.com>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-03-19 at 09:16 -0700, Andrii Nakryiko wrote:
[...]

> So I considered `bpf_raw_tracepoint_open_opts()`, but it felt so
> verbose that I decided to shorten it to `bpf_raw_tp_open()`, given we
> do have SEC("raw_tp") and that's very recognizable contraction.
>=20
> Having said that, I'm not opposed to going with
> bpf_raw_tracepoint_open_opts(), as I don't think many users will ever
> need to call it directly, so verboseness doesn't matter all that much.
>=20
> Let me know if you still prefer the `bpf_raw_tracepoint_open_opts()` vari=
ant.

I'd prefer the longer variant if you don't mind.
I'm a relative beginner to libbpf internals and seeing bpf_raw_tp_open
instead bpf_raw_tracepoint_open_opts kinda broke my intuitive
expectations based on other APIs, so we can use it as a test :)
