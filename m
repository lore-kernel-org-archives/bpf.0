Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793763077;
	b=oT4VUTT83nAKOWmBujMwzDhCKlhaUkph8BWOPCxawcukJehJV9LRufQRbrgfP1qIAnGq
	 ioBY3mPJwCGsYzTTtM/TZAb2TQVyDlaI/xKdn4wSp9nFbp6Z5Su5UhldXXRR1CfTCs6pa
	 8kJ8TuVWTeb9twdkptFVZHXz1bwG8yruITQ48Up8JnTJd0WKZ/tK5fiJ4DbtUocEnClTk
	 HCVRUNFpAXTbW6OA1gyItqOMpCsnKe7nQmCkXpKrzfu93Thvekq9vOlxV0GxCC4Im5QvJ
	 d5u2pom2hYWxSlcCuDESJdGVLTz+TIPdxE+6QkRtLwd8FwAj4w6sRdNXwn+hE56lv+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793763077;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Content-Type:Date:
	 Message-Id:Subject:From:To:Cc:In-Reply-To:References:
	 Content-Transfer-Encoding:MIME-Version;
	bh=qZ477poDWsQIH8uZySkZJeF9GH10iPYgLbABrQrU9QU=;
	b=pPXCbHYT15kTWNnDbRuVeXZAmZZq7Whk/rMnCLMJVsP2QcChA4ubopnymdWND85tgS5S
	 4QLv8s6ObtUwTuk4UyVfwnXxfao9J+avGHFJ6jFdPkKIALyLeQXHFmjoKsrjwcGfZ+OMn
	 JdMEKW9r5WEBfr/6FMyVsigubsRAsjEVKxjje1B41GZB9+dsiB7r7+sH/rpVgjrkz667d
	 YNxvS5tgHxf76Ryigi+InQU8AQKFxbBih8MfvqfVUZi+lvcSYOy44rUzFvuaMmpJdaIDL
	 OCSbxLPWh28Zgou19Me28KgjJKZp0IpOEddKtVnDsk0i5ztPTM2YMk8y9yHprw543aw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=J2JEGNQY;
	arc=none smtp.remote-ip=209.85.216.54
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E740E606A338
	for <bpf@vger.kernel.org>; Wed,  4 Nov 2026 03:31:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E740E606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=J2JEGNQY
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3ac451e128cso214108a91.1
        for <bpf@vger.kernel.org>; Tue, 03 Nov 2026 19:31:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793763076; x=1794367876; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:cc:to
         :from:subject:message-id:date:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qZ477poDWsQIH8uZySkZJeF9GH10iPYgLbABrQrU9QU=;
        b=J2JEGNQY96KL12IsBLW/fnLvx8t9AudydOzSulMYyBOGni08vFWbrRR/9ZlQoLqNop
         7LHNDWUzZ8wk6dJXb0lmQ2CwPKd8ESo8ePEbGOKNn1IsubtjRpTFGBVCzqZngoPLvL4O
         ly84q2KtA/6XanOawbsqtIDFsZ57Zna3DJcfZIdXclbP0qYbTkDORjzJnMgtLcx/+wWl
         RU/OXs3qlSYSTsni3LN5mQHheEuMZaUD1ODT7syeljpqzzQn9vy27B7sUXPHdnqhxTwF
         q3e2o4e5kFhfhf0CIizkUv9AXeXrFmfyUithcVWlqjEpKpyAOucBeiGvCPcL8CkJDFkf
         OsbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793763076; x=1794367876;
        h=mime-version:content-transfer-encoding:references:in-reply-to:cc:to
         :from:subject:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qZ477poDWsQIH8uZySkZJeF9GH10iPYgLbABrQrU9QU=;
        b=DXOLIfUYXpTBNZShzhUd3ELQMGix5xgqLGNsjjiOAytEXLK1uAKeD2vnDgVjolGJl/
         NNmeqeyT9FA/CM9+XF54nwDceCwJ48tDDjrrrVtGYf2sP6bln+Jx5wrp91l5F1ecEEUP
         GUTBDPx8fh0PQTtER05tYrQ/msZ9ptCHZAFtZT3aCFCzPod8fKdN/o4W2ScP9C7L4ALP
         OFpLsS4pKSi4TlCAFfC8/BvMhuFmVf8WNvH0IrjjVajzqEVyETpjIQa6FgT1saFKU16u
         qvTJSuVFt5wus3pGQC0/Jx+VbTedqgUVHaGejUD+wK3tfR5PtSDppAxrcK8WN6QT5SP2
         dESA==
X-Gm-Message-State: APuU4Z+gVhUqtL5EO91hA+Dyu40sXSyp/yc9V8pOuna7rKlArWDatRxD
	vAyqv2olKU2ptLZJL6t0UcS0x2g3sYMHWxF9HF8Lp0vP5Ga1pJlfzo8Q0/UwSA==
X-Gm-Gg: AYBFou1ego31QoWLAEUflAJZKXlyxJF6LvEKNXy2/b1k5X7km2GGepobv+Yf0bzXzfS
	XrW7LnjdxdNVT1JtIkgipFuna9CYKvPYz65OtruNBcTcDXl2JAIjKEgPqpRG2q1PSGOEBRqS/Xh
	jnNT2Wv2UkkFRvvam4SXxuDDczBAUTizjoSNAqBXaAyai2eJJ4qpAYZ3jDuNfFFnU7s1kd+TKdP
	fUiAOcTSXfBsAx1jLoV2v6ISdnj0x2bdBUbNw4xwYqCBFjQQSMasd77q+bn3GaAeQmjfgZXndgQ
	4ldQGUP8QNq/rjADgegGR9T0zYWhBajLEBbe8gEtifLjwqAKF46CeSEm53oKKBhYyC58mfZfQuF
	LRwSlheGTdpHD4Y9tDw7WNTsgR4JNziEVqjyO32YgQ8XjwfkiPSJJkdyYhZ+kLEVCRtvphKjnTy
	8x4Hp3/3fmZCnIGMN6GJR7yMg7BUC8t6MgYZXp5gv1kGb+sBT0KTgpCnbyQc13UF7+uMI1k5jxS
	LMwwrfI+PpYWRTdWZkQOUgeC/v1fRicFOxTlUh3lBAycSnRug6XSFFFTz3hxex0HwzXfDZaPStH
	lZ7kRtUQT8fg9k1jcHQ3TyJ8qNKcbsRIYzHuUjUsMNghZmG5uFFZWjDPWYq/9ht0qwpx2BvVbYi
	I4AHLC1qkltCgdAq2qEyAJvBcGxBzOoYGlQ==
X-Received: by 2002:a17:90a:d24c:b0:3b0:9e2c:9b60 with SMTP id 98e67ed59e1d1-3b09e2cfe5dmr12936a91.21.1793763076118;
        Tue, 03 Nov 2026 19:31:16 -0800 (PST)
Received: from localhost ([153.61.198.248])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b07c9b0ec5sm6956456a91.16.2026.11.03.19.31.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Nov 2026 19:31:15 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Wed, 04 Nov 2026 03:31:15 +0000
Message-Id: <DMM3XWQJWG41.38YIBYIE2576N@gmail.com>
Subject: Re: [PATCH bpf-next v3 00/14] bpf: A stack in arena
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: <bpf@vger.kernel.org>
Cc: <daniel@iogearbox.net>, <andrii@kernel.org>, <eddyz87@gmail.com>,
 <memxor@gmail.com>
In-Reply-To: <20261104012401.1354861-1-alexei.starovoitov@gmail.com>
References: <20261104012401.1354861-1-alexei.starovoitov@gmail.com>
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

On Tue, Nov 03, 2026 at 05:24 PM Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
> No released compiler emits this code. The change to the BPF backend of LLVM
> is in review: https://github.com/llvm/llvm-project/pull/235577

The flags are made for Rust. I tried them on C.
C without __arena works. The kernel side of this series is enough for it.
The LLVM side needs more work.

-- libarena without __arena --

'#define __arena' is empty. The compiler moves the globals, the heap and
the locals to arena.

63 libarena progs out of 63 pass the verifier.

The price against libarena with __arena: two times more casts, JITed code
+18%, arena_malloc() +7%.

So probably not a recommended approach, but works for "lazy" C developers.
