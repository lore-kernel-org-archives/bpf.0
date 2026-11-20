Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795207353;
	b=mxx0JI+iBVvIe9+sQ5UH3DxGBvdpeqCWYpLl6/E9Sj8myAILy8kXR6T09vO//nBv30mY
	 6vWIOPxujgSix2UHDv0+6pufRWw+Xd5OecBuPkz8pQ3z8Ev8W6zHsplg/ufgthRNJUySx
	 lR/alFmFRRTP92+YoxyMY78sLjdpw2V2G2R0J6uNUII01hE0pNLy9XOm79EDR5Sc5Vsg+
	 NSk0USdOQ8jZSh9lNNGgq2CQ0NwPozyV9RXMgKbhjXqK/NGJIoV5JD73PTkdiPrMySsX6
	 rJejksTdHVu9RkQ7QB8YO/M3gVKFj/CDZvXXCSwDe4eRikcz8L/wFF5RcAHTA0lCDdQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795207353;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding;
	bh=/nc/dvqxtPLsGgO4o7Y1s1suhT4X+uftd8Sz7H41zfQ=;
	b=T7KtMqqiQx5u2r3YsV3KWHESxY+wY0MH7C61Ee+wAYWWwmPWwL0Hf7p6GQAsslWUVEvb
	 X61kb+WLJ9lwsolgCVJ2Me/nqe2uo+ccSHZP/K/cnZIb7SqEXWRcMwtTV8JV3LFjZ/KZi
	 KJsbD+T65tv4jGW+cF2LNgotPweYX3T0Ld9dzZZIlgoU+9+Q4T/Qb0KU+hkbfIw33JSCf
	 Bpx5D5oY57zUZNzQYWP4CCVY8zurflUryh9ZfDjWAE9+oL68sFgp2WX7bJNQp5oUfan4E
	 UVSbFH4bwiKXPhJfUnVb2okfhKkBSpIEKT7YW0J+iQc5+DI8ZFKmT/C5mMXB/z2sPOQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=kernel.org;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.222.171
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2795E606A6D5
	for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 20:42:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2795E606A6D5
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-9496577d4c4so142759585a.1
        for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 12:42:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795207352; x=1795812152;
        h=content-transfer-encoding:content-type:references:in-reply-to
         :mime-version:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/nc/dvqxtPLsGgO4o7Y1s1suhT4X+uftd8Sz7H41zfQ=;
        b=szgrB6fQiezI5RRThwP3JkSlnwd8vwen11/evB4/dE0iu+2bkwb8IdX/C00+Tc8jk2
         FiCJy8cZQ7aurvhvbJXd9fVzRjYPMIeYT2cdCqL5au44J2Jqr/j8KZNBCPIhkc1O9+EF
         /EwYCCgcRQHx5at2q4DA2txpRfwvc7Mb0BV9tsrnVH1rsCTe1+3h3pwcwW7qCazeo6F2
         m8Z9vB1uaOnpnC9BN3rXD59xMjnRRsZoTCvqQodZYpuNRDgMQMPzOCFzfEUc+gBrpH7/
         x8zkyQuL4X3iQfFR0VN+MuzcD9KIFYFLrZxQIEYnxPwdcx8mt4qLYRDzK8E+v/qINZGm
         Yn6Q==
X-Gm-Message-State: APuU4Z++wlXxFnjXZpQJi8q5Mu15LsU+Mlr6Gx/dJoKyqdpmyFB4khrO
	28WzT53a+P0TkWA5Kk1PMt7/pjI50boBTa3GuF2oqinKtJII9C3ioie7SLrXVA==
X-Gm-Gg: AYBFou3ymOVFrJ0ELBk9ky2XjwZvp/7HdzPROGCMYkIfyUIJLNe14Q5c6dTXkiAyUTS
	TMOgA6McG6sUNLS9JIMAjfV4HyQNEEhAGBqWMuhRFxq9BUDyEYjxuBLQVf92hVBrT9hafZr3Pne
	GDwlgwQNYB0z6xinPQEdocKSJUC00XLeA8AruznkQy5Frxeyg/8LgUxvZye/wBg+GzqWDxSJ4FP
	Irrqcu7uZCQpTp2PmHNm7Id2+oI0CF51ZbEp/KR7xr/+MOk2FV2jJHWBiYO/+Cma2fz8NpOsNfh
	6x5eZxqLi4oEyI9E9xdhL9MCEeCz1vy2Ac6VqpyXVdmKITxeKwXxNpYTYN2IroNrZzfNKz/e4tK
	BDmJYSxZIPfIF722sJClwVyd5MAwTCoXOmvvYNMA/fqFgp1kFs8ifIUm0zAmG2iM42t5PvgZRLJ
	C0GpJSzIX1ygAcU3G+UFxy8k/t5FE7a1OUiKSwYIk7ub1khGsq58GaeX+9/IvuUIl9u8pTRRVQc
	IJNADK2cN55C36rxEKapE1PE5WYQdXIVmrPcE+BtdbtIsqHc3+1A5yKX+Lyf9M+m19JpqgpjZry
	qYIeSiD4DPoUd2b65zj/NbNtOSpPKH1LCOv4FVodYQZXW9CZBuGX/WAfKY+40txIgT240Iw1Z6e
	uJpe2uMVed3awQkQPakFjmlTqBE2CWHe5/B6ZwyXYjed6vr2sHqUG
X-Received: by 2002:a05:620a:a982:20b0:949:ca77:6d7a with SMTP id af79cd13be357-949ca7774a5mr149266385a.41.1795207352202;
        Fri, 20 Nov 2026 12:42:32 -0800 (PST)
Received: from localhost ([199.170.132.196])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-949bb34ac11sm279160685a.14.2026.11.20.12.42.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 12:42:31 -0800 (PST)
From: Tamir Duberstein <tamird@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Subject: Re: [PATCH bpf v2 4/8] libbpf: ringbuf: Handle position counter wrap
Date: Fri, 20 Nov 2026 17:51:54 -0000
Message-ID: <179519711436.18576.14633882852101651098@kernel.org>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <20260619004130.23E331F000E9@smtp.kernel.org>
References: <20260618-bpf-ringbuf-fixes-v2-0-33fde039ddf3@kernel.org> <20260618-bpf-ringbuf-fixes-v2-4-33fde039ddf3@kernel.org> <20260619004130.23E331F000E9@smtp.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

> compat mismatch between
> 32-bit userspace and 64-bit kernels?

Yes. That requires matching shared-counter representations and accesses
on both sides. It remains outside this series.
