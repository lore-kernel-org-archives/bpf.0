Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 942EB41D641
	for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 22:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790201482; cv=none; b=F4VTsiqRrQgo1hm26bUWKp6s6qjAUoNRM18H8gw0PQK2s2icSTZHuYrMsuLjlMrJq3nld86z1YC9TCsudVigrc+Fz5PL4i/D+GF5zSlP3RNiqNp0/eAG00ErV86TAH8/sRczwqPRAyxu4NkHAoJq074DwADhk6fcmGytCyBoL2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790201482; c=relaxed/simple;
	bh=abqDAL1y09RoUefta8psHs3jB6mbHf90LC3o9/Bi/6A=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:MIME-Version; b=BMZOOXIg7UtGP/NpeOXVpFioK//9ZSU2WX68BHcLcX8PDIb5ysdIWHUqzKoilpWGEFKUpOZPCWoVNA3eG/MPqHm5BXo3fYFpsXWLq/1pbeGlOcWEJ14+rmNKv0jJuBBf+ShmpJOHrXN1Ya33+jjSQDti11AETR/QWpfdScWODN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RANapUvK; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RANapUvK"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-39e03468a5fso883578a91.0
        for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 15:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790201481; x=1790806281; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=o10p2+AJrqSllpAFIBOfL0R8YhwsPzzJpB9HCt2D5JU=;
        b=RANapUvKQq9zFxu4NKKS4rfTwEYTvubzoBnfEEYwV3tqtG8RMFTViLFdlFlEb7Wr//
         GhDhfRKqkIQOxj5apyS5DDSoJqxIBjaeLZ09l7wVI9aPgWvtqPoBcAb9W2p4O1Tkn4YD
         9o0ZyEO3Ro1GfnZ7GQsHPYRdG5a4+qB/ZghWbRmLGFegICNYzwrhNxn1PhLIir7OO3oG
         LE/aeo/oGz5iL7NDFKfXL8KLMCk4JJvliDaD/67WGuroqddMZllSyAsPHTqDum5LoXn/
         pjT9Kdz1cfjh29e1szu+fRcBUr1BOJkI6jXSbn6cUKOvsgExqCHTbgV6gB8YYdFE+4Kj
         pIag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790201481; x=1790806281;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=o10p2+AJrqSllpAFIBOfL0R8YhwsPzzJpB9HCt2D5JU=;
        b=F0uoTES2SfvF1V6YvZUX+t1kwa2qhZ7c+I0SzbIiVjxb3Nw+/WgvBhsj0FLgHzL2wD
         ZIy6rgBwlO2iTOQtE71fo7rCNYwVz3Oc8TsZxf+liX6cyU5y0C/SplA3qO4TKHywscUa
         b9urSINsNdnRPiTnEmy3DA4dAlkBrKFoU3U2UFxPBtYAFTDpSY/EhlLZfRxu8LGWynNo
         Hb6W3WdadIyR+rjzyP1gExqGVLV0UHWGszptlT4X5PrVlCJwRVKsqDhlLJPqcZ9rkrBn
         c0G9Qyf8WRbEsyoZNkPwaLm8jk/OuQYitWU+zMVtIAUipYDrvkwoUmzy2pQ3GaKhPj1s
         mlCQ==
X-Forwarded-Encrypted: i=1; AKwUvBzKVvQZEBJ5f2J404CeQTzBLlwJN5H9z8vVoza/C3/TleKNb9uAoVxthjgl+0pmGDK5AoY=@vger.kernel.org
X-Gm-Message-State: AFuF++n92BN0d3WwUhbKL7cNS1ahMBLTskxwfSG9GXd54DXyXOu26Xb0
	cUonc93X4UjI6o1G9ly+Qx0uHulcghTGRqG7ZCiOhlyQVUXIf7NyQ7QC
X-Gm-Gg: AYBFou1soYRzWusRQtk6OqjbFUJXSBfa02+OTVBOlgrkGxxo/nvNlM/3cTxS7m6wwJr
	sTG9rYcBu9Lt495/BqOOyYbrixaJwIb/6I57niAJUFLcmjTzC/qovkBo8Z4fJ7ADxHhF5AyqApX
	43jhmaBTJkrdpXdFMB/5HjxizfK+hZp8fyXMHFUZJ62Pdrh6RGFzwZDPBE2jzEI+n2ULJt2PYx8
	TDvrdHMLGpWHi54wnZaedxkkvqiEJSwahUC/QavSTK3TuOwH4oOpr5tfaxaTkPDR7VADGTNyC6i
	5kfS85+pT+izC6UeUp5QwHTlx1yWqDRa2TvjSq0lY4qZ5eZ7ajnoC+SbdZHtmqvOm6BUFDaiS6B
	RkA4i+mnibr+klYnV1iU66LaP4/UGS9C1IS5gZHVPfk/+BrbSwvkt+djqi/Ncd5EBxIL5KsFmXY
	2psxIacomzG79lelol7JJpxkUpTI3OMHY5I+DSfCdFBfOrOz894a6/YGozhswIw5DRrD9RNWE/8
	xa5AlKsp20c21LXdlkD2+SBiEEoQ9TGW0rWZQ5Y3OOHPcuos/j6hvkvRXvXERuca7Sva0wHx49p
	UooC
X-Received: by 2002:a17:90b:1e4f:b0:3a0:4384:ae14 with SMTP id 98e67ed59e1d1-3a098ce544bmr350570a91.20.1790201479774;
        Wed, 23 Sep 2026 15:11:19 -0700 (PDT)
Received: from localhost ([153.61.198.251])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0972eec92sm1050601a91.7.2026.09.23.15.11.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Sep 2026 15:11:19 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Wed, 23 Sep 2026 22:11:19 +0000
Message-Id: <DLN1GM1DR3L8.1B0FXOU9BB33H@gmail.com>
Cc: "Daniel Borkmann" <daniel@iogearbox.net>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Martin KaFai Lau" <martin.lau@linux.dev>, "Eduard
 Zingerman" <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>, "Song Liu" <song@kernel.org>, "Yonghong Song"
 <yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Test fetching AND/OR/XOR
 atomics in arena
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Puranjay Mohan" <puranjay@kernel.org>, <bpf@vger.kernel.org>
In-Reply-To: <20260923165301.3463007-3-puranjay@kernel.org>
References: <20260923165301.3463007-1-puranjay@kernel.org> <20260923165301.3463007-3-puranjay@kernel.org>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, Sep 23, 2026 at 09:53 AM Puranjay Mohan <puranjay@kernel.org> wrote:
> -#ifdef __BPF_FEATURE_ATOMIC_MEM_ORDERING
> -	__c11_atomic_fetch_and(&and64_value, 0x011ull << 32, memory_order_relaxed);
> -	__c11_atomic_fetch_and(&and32_value, 0x011, memory_order_relaxed);
> -#else
> -	__sync_fetch_and_and(&and64_value, 0x011ull << 32);
> -	__sync_fetch_and_and(&and32_value, 0x011);
> -#endif
> +	and64_result = __sync_fetch_and_and(&and64_value, 0x011ull << 32);
> +	and32_result = __sync_fetch_and_and(&and32_value, 0x011);

These were the only tests of non-fetching and/or/xor in arena.
Pls keep them and add the fetching ones next to them.
