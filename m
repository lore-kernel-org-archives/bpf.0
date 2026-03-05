Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD3EE383C7D
	for <bpf@vger.kernel.org>; Thu,  5 Mar 2026 11:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772711492; cv=none; b=Qpv+dM3zq3K2A8DRdgQ/5p36lN3zxE2IKVaya5l7GBge1JvvWOLyxV/trQ/kiZoW/Cba06BvJZBuCWVDDamvYVN2h9QR94tF2f4bhFJ9FaDROjN3OqI0JrbV7zbyv6It2cMRv7o3M6CRmkAykhPw3fCVofhMf+LQsGBBphzlzvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772711492; c=relaxed/simple;
	bh=4xPQDd0ljv/9b2VO7qXd5XCtz0aa94rQyFRE6a/5wPE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gkss9RHNR6YNhXo7uDOUEvBrszNGwoIHLYso5PIy9s4MfVaX4Oyktza8kQa5jDL8Yzf94UiuxfGlf2lknS+Cm74rsNk3wfqa91xSLnTOYGSOGUnG5WJD5hBEK1IhatLWQHP1xfOoRoCOlonKiLRajuMZYhGTqi8IxTLBI0GsAeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=ZXwRkc03; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="ZXwRkc03"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-65fb991d7eeso10634163a12.0
        for <bpf@vger.kernel.org>; Thu, 05 Mar 2026 03:51:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1772711490; x=1773316290; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=4xPQDd0ljv/9b2VO7qXd5XCtz0aa94rQyFRE6a/5wPE=;
        b=ZXwRkc03ZlinU9pRVjLJgJWY14X4DNfs+zMdDHALwpq+x4x2IE9xfteraMPwdvYIQ1
         P9zdwAvitSDKU4pxi+mgZFYsbbGlNJQEyb46pkbHs+t2Tn+USSPvNt7xVHzOYFZ0lJT/
         vJeQmMD9r5pyMuXQOa4gs7hS7Z6wczh9vSDDxJKeNTlS7hFlCnM4AdL1iY2FkTDjVM/Q
         h9iiPCd2GRUpiDXf4FCmhGN8NsY+TLujKqnaId+kWaseMV7HZBwaGGodSj3vZxEF50cK
         Xea0Wv+Awj6zgOMMM6BHGck5WKS45POvbHUhz4ckBFPpb+edaHX04l7seJ49//MBStez
         oH5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772711490; x=1773316290;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4xPQDd0ljv/9b2VO7qXd5XCtz0aa94rQyFRE6a/5wPE=;
        b=nL8UmpeJniGvI1XDsEkikkORl3LBtWYsdz8QqhI8qgIU1NC0xHPzRnpMq0XBIhMK0K
         XU9dU7ZlVwrO89i5E0mRB4cY6e5kvUL2PEJ+k6mqjXi5MTCzglte92xhiifW8Fyz84+E
         srp2eeSboFsOkeqLjtz3wbv17gjDL4TFzLn3MLofpZiEzNwdLk1cIOmjVddOVw7Vk6Wj
         hSdyEvzCJ6DbJ5pDzJ/B3wFTbSw8MMGwuVNddho5SQSs0aAsUwSRo0QbXzW7fRbblUnn
         EF5fz7MOmp4cgIHES0IILoez6r06G1D1mY5uZF9cUBdwQJuulS4roAVKxJmfQPk7emEf
         P94g==
X-Forwarded-Encrypted: i=1; AJvYcCV1/Ef26PVUuw3MermRTB8h2THZ6Pb0OVAO2KMjl/VdjJ55qaBuaQKxzCLRjwDPFNwBIlE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz67xHy4yo/mCxHnulFMJF9NG3dpxkP14CEui8wFAvyGxiRW24u
	nVuW31VkbdCykrLNKOrORcrl3cEYQ/YMm9WL/IB3RUH4+KDQlJl/5ZAheVOtuxvjNUI=
X-Gm-Gg: ATEYQzyuJWbfTR4BRETUQ5Xs8pVRFLU/BNvICsVYl/YIP0kUR0IlBN3c/c5BTBoIcUN
	ES18jFzdvXIqe4k3cUDVDVlfClqcR9o2PUvVH23SMrPpR4cxbd0tLb97lIEge6DdF6Ia442lOYs
	NvJzXRnqY2WcDSTI359TdERv966XYLRPdnOaKp3CBVbgEVbcDy9UOLkierOhMrST0irxpF0Lw+f
	AiFQWZeaozjRjGQVioWW9dd3hHr/ti3XOYKpV1lHC+I2MmpgE7701+twZrS5cGEBruWK/0pjeLk
	WIsQaJhcjIqMcxRDsL01T0tZdakO3eNODCEVpqf6Ujv8wyfXsItAcSfIoi4ojybKE2CsPoSieu4
	+ZiCbYoNq5XTTtG7kcbaPSHKoZqT0lhxdeZOcNrzX4C6VoLJz4ARfgPHxG0aQlauETgle48gpbV
	OFIHYIfwe0TlcrnepCREhSML8zaOLMX/dPicsA1U7I/IZ1VSkFBLM7hYvjWlz5LhpQ2IqLhA==
X-Received: by 2002:a17:907:25c9:b0:b8e:d04e:e506 with SMTP id a640c23a62f3a-b93f15afc56mr331477666b.57.1772711489846;
        Thu, 05 Mar 2026 03:51:29 -0800 (PST)
Received: from cloudflare.com (79.184.124.63.ipv4.supernova.orange.pl. [79.184.124.63])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b935ab13d57sm900463166b.12.2026.03.05.03.51.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 03:51:29 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: John Fastabend <john.fastabend@gmail.com>,  Willem de Bruijn
 <willemdebruijn.kernel@gmail.com>,  Kuniyuki Iwashima
 <kuni1840@gmail.com>,  bpf@vger.kernel.org,  netdev@vger.kernel.org
Subject: Re: [PATCH v4 bpf/net 2/6] sockmap: Annotate sk->sk_write_space()
 for UDP.
In-Reply-To: <20260221233234.3814768-3-kuniyu@google.com> (Kuniyuki Iwashima's
	message of "Sat, 21 Feb 2026 23:30:49 +0000")
References: <20260221233234.3814768-1-kuniyu@google.com>
	<20260221233234.3814768-3-kuniyu@google.com>
Date: Thu, 05 Mar 2026 12:51:28 +0100
Message-ID: <87wlzqmr3z.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Sat, Feb 21, 2026 at 11:30 PM GMT, Kuniyuki Iwashima wrote:
> UDP TX skb->destructor() is sock_wfree(), and UDP only
> holds lock_sock() for UDP_CORK / MSG_MORE sendmsg().
>
> Otherwise, sk->sk_write_space() is read locklessly.
>
> Let's use WRITE_ONCE() and READ_ONCE() for sk->sk_write_space().
>
> Fixes: 7b98cd42b049 ("bpf: sockmap: Add UDP support")
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> ---
> v3: Use WRITE_ONCE() in udp_bpf_update_proto()
> v2: Cache sk->sk_write_space in sock_wfree()
> ---

I agree with Jiayuan that it would be less confusing to drop the
overlapping parts but Eric's patch went through net tree and this is
targeted for bpf tree (?). I'm actually not sure what exactly the
bpf/net target signifies.

So if it makes everyone's life easier:

Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>
