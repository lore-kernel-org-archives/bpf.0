Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792620073;
	b=BrqPbC9WWCT43MnRt+tXNPqwPwwPSZO97cLR4YpzcU5bCn8LeW3AKaVL6mKBWuzuxm7q
	 rlnJIN0jF+Rbd+S++W0LCwNvjp8/ASS0IP9vVHQaUZomfSt4/yQ5fCxwejdTGjpJfM9wE
	 t/h75oF/4YeAle1QlgYYe2Nk8RFuLzbjEfLlW2WPm23vLYlR57WUSYj9VM1EfzLNloV2e
	 YNwDRxQhHe1N/z4xncZoT6ekvXHPqfxSKwphUsvZEFQs2pA3H9VTcdgM5DX7jV8+IzNpI
	 6+5+OSuYzVKa/Tiua1WA/aQwRUTeEJPsZqldmGarsdnoGjQRPwjoKy6yIPwfGf34/dg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792620073;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Subject:From:To:Cc:In-Reply-To:
	 References:X-Mailer:Content-Transfer-Encoding:MIME-Version;
	bh=ekANNG852YX/Rv0SYRliAvOikAthVPOfNHHk1KWJgg4=;
	b=2XYnngNr/KBJwN7FoMmtSVsH3Jv9YluQRefV2ao9fbquOrD/kwVuW8ic8zdGi+hK7z7F
	 pDU+VTZ3fjfUDwjv24YXkRqQwFO9GyC5leW5EqVAPNlK1UvyiniAPduEQLjmCpG9eyIsB
	 Lvwg4ZGX/VKP0aYPxAK/lyMhS5kbyKLx84CTS8J1ClgVN1lbZIfl6EIwLu/KEOmyg9I4v
	 VEDy8WoC/DpNlhyo054D4GEVo2ssqeF8XGQ+bzPdVRX8IzengmAoPfDsIrwwRRDo9Do3f
	 zF3o1oCgLn1ydEGRCU1KLNBqJ4F0wZhg7fxcggZ6DPoTtf2lPqIwIXQ9BouErhuNnzw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ezRxCH+X;
	arc=none smtp.remote-ip=209.85.210.172
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C04E7606A31D
	for <bpf@vger.kernel.org>; Wed, 21 Oct 2026 22:01:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C04E7606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ezRxCH+X
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-8a05b210703so529664b3a.0
        for <bpf@vger.kernel.org>; Wed, 21 Oct 2026 15:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792620072; x=1793224872; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:cc:to
         :from:subject:message-id:date:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ekANNG852YX/Rv0SYRliAvOikAthVPOfNHHk1KWJgg4=;
        b=ezRxCH+XFN6kqXAzUkHG2tuyt8LY9Se12NNEu6NCx7Zv8JzLColYWlPyghLRXld6hm
         xZDWfFEMmj6UzTmaikg6Y8318LeQ5mTF0RtV9FAJAfzSh5gQS/qFqIyjFEUI5x3l9lNr
         R/yIsuaAtmNPhm/1e6maqY5TwrtWTXBVM9Gn8GuxITZD0CQ3PsV7i6dVAcCSByahXTGR
         5fvL3Kj4C8GY9JjpuLmhrLTQKJ0PcLhfeSPhwwIB0tnkzDXjQKPFH+gAQwG7KxXESkdu
         musrbh9L5xzU8OLHo+AoJ0AWoSAI5mdC8PO1sWksCBobfztW6ACBhalN0Z6F0mCiXkdd
         wpGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792620072; x=1793224872;
        h=mime-version:content-transfer-encoding:references:in-reply-to:cc:to
         :from:subject:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ekANNG852YX/Rv0SYRliAvOikAthVPOfNHHk1KWJgg4=;
        b=f4WlTgTjo78hlyfGJHAU5TCXDwynXba5VhvG6OXnJzP1OQsvsPOoTFdYc9q74fSiEw
         mwc88Ly7uI/Oi98CLSWu5OU9PU1JaXzgNqnrc3+cI+NIdugxRZnvBLKgrY02GAcpQdZT
         1FLxaDWQFr3nDMcPuKna3xfubyfVaGkBLRU2UXGyxGZKSxG3BPSsvjyBnghXrkHTmK3j
         DZASOYC09ZuRxs/xp2/9yFIfykyfV5VztF9Yb7akNkY0Pu1KWWt2zNBJ4wHS41KRn2f4
         k9IhOLOwsgEklnq44o4hrEr4ZUcTvKGnmIaIGn1Qj8OYYvbntbvnAsBArCIdfKzF9OSW
         bYVQ==
X-Forwarded-Encrypted: i=1; AKwUvBwrHNirfeyAgkLD9Va/b+3VaIqM+b+0ugiqruybYJOEVydJ+iLXlOsoiCee2C9RX6HkrRU=@vger.kernel.org
X-Gm-Message-State: AFq9FYLK0dJjQ3aBkjgxQDbH3Oj9tIp/c+H/qvWK23+dCOwGCU/Q53g+
	SaMl95x/IAybzpjN8LPYvAlH2DlwcLyBCv3bpPe84JALsCqSSR1FhBp9
X-Gm-Gg: AYBFou2iSfGH/szqUP9hqWj8HqyLEkfWCi1JQEPOdw8JrftyPX0rmL/2l8tCnCcuI5F
	zo+ZAjg5TaB3NnaSbSeZVx3UaYVnmUW3FgjU9y5KG7XcrJt+bRGbABYVPDWl9uE0wAl9qoNhzLI
	e5o4kQKWBilXkJ3MOv4QDu9ZNM0Rn/Kcfbs9AkeaXUrqSWmVDFNVkS2/RCiBOz3UFeD8invwrQn
	4JIp/6iRkxPioC+OhoC0/zxRlOlNcIQMv23XXYKCgULk+XEyDeSwR6EWnrvySjBGtTldvsnqF2E
	yNxej/b19hy/y5+WSWDgkjtbwJMPqmxt8RfQNZPk7kCekHzwcfvw4ON06am3WetlIuYmA8p8vSk
	eqsfJwC9ZYPft8ggHTl9vDp+wmddH0ldEwRrpfdZQAx6IQuTyBqBrZ/dDoEmIPQqoexdPEgA7mV
	pDUlrZ9fZr5xPLC+T0Udm3ZcaCuxSpHzS4/AqTnzZTVE0UI7D9rRe8urFxXSsyOsMHAv1YkcR5J
	cH9bTtvzThUZX8FoW4rmNjm1LguXWwny95cARwIuAyIyERsW1VI2Ny/bAc6QfdYcAKk8PgOV1NO
	X/PpNH67zyMLdw+H3FBNALdt4FYogby5s6vM9j8YwQORp8euCtw7Pclki49S
X-Received: by 2002:a05:6a00:e86:b0:87c:e6aa:30e4 with SMTP id d2e1a72fcca58-8a089d79060mr2663523b3a.48.1792620071973;
        Wed, 21 Oct 2026 15:01:11 -0700 (PDT)
Received: from localhost ([153.61.198.252])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8a0895c05f4sm1334306b3a.28.2026.10.21.15.01.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Oct 2026 15:01:11 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Wed, 21 Oct 2026 22:01:10 +0000
Message-Id: <DMAUS3F32198.M27YWDF2F3UV@gmail.com>
Subject: Re: [PATCH v4 0/2] tracing: fgraph: fix the quadratic shadow stack
 walk
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Vineet Gupta" <vineet.gupta@linux.dev>, <rostedt@goodmis.org>,
 <mhiramat@kernel.org>
Cc: <mark.rutland@arm.com>, <mathieu.desnoyers@efficios.com>,
 <andrii@kernel.org>, <peterz@infradead.org>,
 <linux-trace-kernel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <bpf@vger.kernel.org>, <kernel-team@meta.com>
In-Reply-To: <20261021174406.2891598-1-vineet.gupta@linux.dev>
References: <20261021174406.2891598-1-vineet.gupta@linux.dev>
X-Mailer: mkdraft (claude review draft; edit before sending)
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

On Wed, Oct 21, 2026 at 10:44 AM Vineet Gupta <vineet.gupta@linux.dev> wrote:
> On a 60-core Sapphire Rapids machine with 400000 idle threads it took
> 227 s, inside a single bpf() syscall for the kprobe_multi case.

Acked-by: Alexei Starovoitov <ast@kernel.org>
