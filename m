Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793161418;
	b=fZPReGawzqF0BWjWoVdHrErxCDPIrpZCoTxR/yIurIRWkoco0Uq7BuOMds4nWzdNjUaX
	 H3ngmBXPE95a2LIZy7mK/YYJU63ndsARe2UeAL3je8LCUNLXTyjjFtPPln/dXvxjh6uy0
	 ZDTd29nPa10eDrt+djKYfyLUoRIioaK0BLiAyqUhyqnqfWa/LcGVzXJXnoYbaD1SjBdLy
	 3zFZ6zay+VppiAaNCWX3gd6EVsB3KqMgPpGDF5ssf/P7uP9NldTw06H8MCC3a58dA3yXt
	 L0UTckhjbbEuhoCF0ZLYGNauEk9n+u8gqSz5a/5XcKjQZkBG5CAWuZDCptYA/DrWrQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793161418;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=TwfpkTiXNbCGMMDhC6pFjLT/z9n0tpYaJKN4cto024w=;
	b=hJoBTjDg2Hy4/IZ47bHEl6+jTqqgNSb+/1AVCyoPtcNB1KDSL/oQ9V4FO9F3w6XDfUCc
	 DwLqohnMYDpJUAsYsTAZNNU8+NxZTgOUZPXapVlxKYD2Y4YKECfG7rrvnnCG39rw+tlXe
	 4fbTpL5/6ScDw5uCxoAbuFZ+QgBmmrjsWGcrw3b5nujkqT2Im+6tTCxOPh3cYyU9v0wCb
	 OqfiGrSIb83UDn25rOxrHJ5bBHoxNV+BRUHypkJeyZnZ2OJGtPw1M+t3oxXPWmVXEj4lx
	 UPsLfqX7HVEfaELQ3VCLBGOypoOOsw1sjdDjddJ2XLBiIEGhgFDhuH+4Mcr82Kjhxmw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pR99tAFQ;
	arc=none smtp.remote-ip=209.85.214.172
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC12B606A31A
	for <bpf@vger.kernel.org>; Wed, 28 Oct 2026 04:23:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EC12B606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pR99tAFQ
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2e608cd460eso2705155ad.3
        for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 21:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793161417; x=1793766217; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=TwfpkTiXNbCGMMDhC6pFjLT/z9n0tpYaJKN4cto024w=;
        b=pR99tAFQooP/kwRgaFNYC5DKJ8dXiLEGjToqqyaGaW23sN0we+ufkY9VvZdd1k8Vce
         oZDmdA5r/Mm/grtcCNlzFBvu+ZFodgnlYCbdl7nlear2YuSK1RbJ7QV4MCAip/w+C7mG
         C7G+8U/Ue8jafmY6RYCkIW0avom8nyws0mC1Au5wL4nrCkxb1gQake6+Cd0SOtMZAg4s
         fBEptLTiPqP4fnN3gDQBEmyfwWnDdBxG6/o1yn3UAIzDDcSjWGOZyV/3WFfbKqKDF+ku
         j47atxJC3LOumvimofCHNqVtSt/C7cF4GukJ+vHBGRqZaCikPYzUlnLCpsZTL0SKlYC2
         pcjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793161417; x=1793766217;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TwfpkTiXNbCGMMDhC6pFjLT/z9n0tpYaJKN4cto024w=;
        b=Mq+ci+YKBrf+Ac/Mp8xSdp70W+Io+6pLNbAdla+mnBvV3qGG1zxld/3sMsBYhNg3xR
         62/RS+ml5kEfHhKYPphbZGRNwDJ7IjAA8/K3+QA22YkiBCSHbW0skWlO26Y2k8BKYRa/
         NZPADfffKa20iYKpubo/2JR8PaXJit0FZQuIXouZIScNmOJUVQG4JVjxEn/1c2hbWBIH
         CUYv9kOk3yXUsGMF9VlJMTQIvsHaVgsr10qVGC05Q7mMlkUOFaqadxYE7FipDmQDk+eK
         +n7pdpMZc6gsHoF4mD1hSb+tA1ZH93+4qOOHeUjNu9JRML78ejmx6lV5nHIidi5p4bX1
         Fdnw==
X-Forwarded-Encrypted: i=1; AKwUvBxcmALUFjxj/wnK5xBRCKuR0wCt3ZETqAT9YMZoJmzdmrFnW0PPIH2+bdBXvwl8m4SCosc=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ5WiUPOh9rpObcxCHO7UqbzlEicEw3fhtzbsn1V/GjHATsd3Bz
	7MGeqX+P7e7Zc80XHvbMhYlxou5/0/L5UmiXJo9dzHdVCcAnmJ3eioMk
X-Gm-Gg: AYBFou2/MRc7CervvDU15eJVx3ijoit88bpJs31XpuQlvNFSFUwJic1UfZPNA6aURPF
	HyZUmmQgWuVU+/jaxU7kP5M33GOLLy0PuhnMcDEM4n+3HudbZ0umLkqkDgqD3o3ZLxkg7wJZFFp
	b4sy0rMCkdc3b836TPp1V0sDCNkvV10EGWleqDh3/whR4mG+PgVsVp7A1/chSuvBpXRRPY7kXHm
	4UuZp/VnzVa2O0rKwsfrZNCECT29RAeKs3YW/bL/3GMNZ29TaHRqpx0vmziVY4bAmhyBXdk45YD
	Sx1w1CXTJn63TwHZnaNkxabm2bqsVDzVT+DP8/BfQUQgE9c6T66EtrIuam5hYFJ+MyVP1qQjpGq
	O21+9jrDxdr3dh1LgKbiJHUD7xhi53hvPq7ur3OU8Ltc0KeMJNjrOdxenV9XnJKdrIt2R6QmZxy
	mCgdrsSQFHVtafbwHUbMQLUdj1Zk4zxR7TYE+L9hOPkM6Zx03sCEoSzZE9mgV+x54L1RszHV5xq
	z8quAO6ak+FbgoYIUW/O6mW2nADQdyxGo9STn2xDZtJj4eZwWFat5pxaG2NKXklJ7wNNVSuYmYv
	PhpcGiZDSzs3l0HlW/Ay2gahLuEag74ZP37k5X0WEMrSxLUU0O7rAbyD78FIE8tKKrqxjxhIyb8
	shc700EokfWfSX/iVIPvostYEdSRRgIBFIw==
X-Received: by 2002:a17:902:f64c:b0:2e9:53b1:a3d0 with SMTP id d9443c01a7336-2eb004bcb42mr12106965ad.40.1793161417159;
        Tue, 27 Oct 2026 21:23:37 -0700 (PDT)
Received: from localhost ([153.61.198.253])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eae6b7a216sm15955205ad.16.2026.10.27.21.23.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Oct 2026 21:23:36 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Wed, 28 Oct 2026 04:23:36 +0000
Message-Id: <DMG6O6EP77A5.2C5VRL2JY4KAJ@gmail.com>
Cc: <daniel@iogearbox.net>, <andrii@kernel.org>, <eddyz87@gmail.com>,
 <memxor@gmail.com>, "Puranjay Mohan" <puranjay12@gmail.com>
Subject: Re: [PATCH bpf] bpf: Don't hold pack_mutex over arm64 IPIs
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Puranjay Mohan" <puranjay@kernel.org>, <bpf@vger.kernel.org>
In-Reply-To: <m21p9avrr7.fsf@kernel.org>
References: <20261024031046.625578-1-alexei.starovoitov@gmail.com> <m21p9avrr7.fsf@kernel.org>
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

On Tue, Oct 27, 2026 at 12:59 PM Puranjay Mohan <puranjay@kernel.org> wrote:
> Can't we do the bpf_arch_text_invalidate() before taking the pack_mutex?
> then it works on all architectures and there is no lock nesting.
>
> Because the caller owns [ptr, ptr+size) until bitmap_clear() so it
> should work.

Interesting idea. I guess that's simpler.
bpf_arch_text_copy() already writes into a pack without pack_mutex.

but other archs gain nothing. fine.

> I can commandeer it if you want.

Sure. pls go ahead.

pw-bot:cr

first time for my own patches. next level unlocked :)

