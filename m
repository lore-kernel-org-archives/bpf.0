Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794544064;
	b=dI3fHOfdy7P78QjoKrQQcEoIRPjsxMFRQ9S0R/Wsigd7AiIlxq2mlhf5FuOkgAQHk9f8
	 sS9voZC1xPGNMbBSOVByXk4ffa1+ZYvlvhuAO0ohQGGR/r71a97GKxPrz5dCTFy0s1FN4
	 kPK/ZHJo7OBURN3G5M/8Whqsq6Rks4b8KGnecAV+zWiCkVR09M49YCCgtHSaHyO1bddVK
	 3jz6PixrtdIWHVBYqYGX8Til3stb70JwWXPeElRJLC4V3v6DT9roOk1gwDyCAIfcjJG+e
	 u3rv/ELZFAnL0MQQPFNyx0f8K3PQZ22Y71SeyOT/eP6UPhRXR9WToAOTGr3gBLaRwxw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794544064;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Content-Type:Date:
	 Message-Id:Cc:Subject:From:To:In-Reply-To:References:
	 Content-Transfer-Encoding:MIME-Version;
	bh=ddDWPbeZ30rBGVuXwO4qlxfXVwbuSPzUuAr284nFCLY=;
	b=IpUlsLqTiBTv9U4QiAuidF+Pmibj3nDPPvSSf5ZDrHew292C/JMpU/RxTl6H5rcWXStZ
	 Hbc4U4lLy+QvEA/yWOxhusiIcvbxf6XTcoS5OqaEKqYz5GyM4ZF1dghu2RKIMaOP8mVzP
	 xOyzAHTmjQrXgFW+de6uj4m+G4oi3jDVMxIsnhC980X9D8RdmHdUUhstV/hJpUc+sd6CC
	 4yWNd9myKkiSuD9RXY+ZfYQ/9sT5mVHQHxaJnh/YuPtJzcHtgpe6LvoOGeUjiFhm9HK+J
	 u32Lq/qURSaRKEN9mkmt50BpQTm45bjW1P3HsVWMfn/FXyhp/QIKYSZ+sVPXEjRzMzg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=g5OC2FBK;
	arc=none smtp.remote-ip=209.85.216.47
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7449606A323
	for <bpf@vger.kernel.org>; Fri, 13 Nov 2026 04:27:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E7449606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=g5OC2FBK
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3b0ae87069dso383421a91.2
        for <bpf@vger.kernel.org>; Thu, 12 Nov 2026 20:27:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794544063; x=1795148863; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ddDWPbeZ30rBGVuXwO4qlxfXVwbuSPzUuAr284nFCLY=;
        b=g5OC2FBKh6a9lARx55uhsvz0mvO9Us9QCQuTYJMK6BrZSA7ABICnlS47qVmjB6zbQp
         ux+7HF4ytLuc8cNznw/K9d15gFSD0owx8ionzMjtroyHHiKRne/axX9Cnjlnsp5Duzgw
         n+FskRk4hXAO0sQdMRO3WtF3UPp6I30entapgh4jE+tOrNe/yvv3POznAof4GLgj8ILt
         fPuRqLoASLMsho4HjRVJ8hnVco7G+8mdbRmbkiXzdUBbohNGeGdGdgjrWt1DDWGFhDsH
         t7grUknwpqEJKiWVDn+OXn+fXE4215PL9yOkwd0RAFaBhGH2xAHzMKFbu2JyZ2AGRRz6
         OlVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794544063; x=1795148863;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ddDWPbeZ30rBGVuXwO4qlxfXVwbuSPzUuAr284nFCLY=;
        b=v7mWq/TojRBgdHeHbfVMIlFbmDdXV+T2g08paisWOyOSSsP1FieRSJTX8yi9IPLtTY
         OEo4seEE/n+m6ZNxMtjl8cG6lcOca8cAUMbhDDQyeioFtFSPmKlA9n1kgvcfGqi/WCeu
         94NtEbHYCCJlOJG/G+SaiAbDKcVhR4zE+XF8yzj6f3YlAIxlU7FoawisCf+579SKLyCy
         Wx4mvu/Ppib6C5eeo4Zi3cyEJJLsaRoy+iiyt3foCFEnmwRw+JZO75dugkoBsJ1ScAtc
         VnP53KlmFDYEZ82UYiCeAr7Di0nEBYGm0z70oruGyifgdxz0V8NIdAU4wvW6qYevlrek
         bQ+Q==
X-Gm-Message-State: APuU4Z+3tCToemeuOIjz+eMP3psyA+d9a32pr+6PGwmcUUuQbx6x5Pee
	qNYUFWl7bM8n5JDY2sNHlcB0t98TfIwzEtLxWIGRhPcMjXKtxSqdkxA3
X-Gm-Gg: AYBFou0AMa+JFAEwimju/WPKoTNSne10twq5mAhSRsuOtVVSQtZpRpPwZz2BfjGaRJ+
	8cgTiiKkpUk3XDbGyKdG0Bx8wx+lIkxaA1B7kvDYhs1xlNhaPgbgPI3tIwLUINbvKo/5jR/ZHyq
	3cFpNNVGXj/JsqZaFGLlNWyL78wwPC6RC+dltMWB2ICl4ZU16nsJqZDoKwT4toUrW182XP3EC4s
	yaf43/tA82fuERGok6+T2ijoaOok7+ComxHnT6JRCBTHIb4+6HlaZZ2PAERwL/kb9I23Qaq46oR
	MjAPtPJJ7VDxEGP87vugDMPl/tM/wd2HQV2pPm5dpfeLxQ/Nz7Y/PTxYObw/6OW0dLx80fMuqjT
	m3c1084gmEUmArBwACfI6/5k/nF4LeiWMl0LyQvx/FdqwBTwhoePZq4b0ZRBqOx1JqJyg09Jq9M
	caBQtBjcyATQAexuHSw5s0BwOoD2vXnHkaH0nbU2brJ4ch326kQCu+mPNlJ8aolguYmEVkhVpvm
	d0KOABVbEeZoVTAIB2g0nBNk9+ZNo6W0UnrnI+rzqfPM4XW4yevfnwE+n5reJoJdY3aDTNoKqZb
	VHteHEwLMwmD3BrO34dK+f4EGUJctNu3IDnJn0AS2ZRbm+3za9BeeKDWw7GM/O6wpZF9JhSVDtq
	M2nHceFXh3DmaajRYNzKs9NpZErHxo6OjIg==
X-Received: by 2002:a17:90b:4d0b:b0:3a2:b16d:928b with SMTP id 98e67ed59e1d1-3b1b0a48f95mr999049a91.46.1794544063053;
        Thu, 12 Nov 2026 20:27:43 -0800 (PST)
Received: from localhost ([153.61.198.248])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ee0f862426sm4061385ad.46.2026.11.12.20.27.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Nov 2026 20:27:42 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Fri, 13 Nov 2026 04:27:41 +0000
Message-Id: <DMTSS10JMVNJ.VGHU9E75OZ5@gmail.com>
Cc: <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf 2/2] selftests/bpf: Test that a drained task_vma
 iterator keeps returning NULL
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Kang Chen" <k.chen@smail.nju.edu.cn>, "Yonghong Song"
 <yonghong.song@linux.dev>, "Daniel Borkmann" <daniel@iogearbox.net>,
 "Andrii Nakryiko" <andrii@kernel.org>, "Eduard Zingerman"
 <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
In-Reply-To: <20261113024500.922824-2-k.chen@smail.nju.edu.cn>
References: <20261113024500.922824-1-k.chen@smail.nju.edu.cn> <20261113024500.922824-2-k.chen@smail.nju.edu.cn>
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

On Thu, Nov 12, 2026 at 06:45 PM Kang Chen <k.chen@smail.nju.edu.cn> wrote:
> +		addr = (void *)(unsigned long)skel->bss->last_end;
> +		ctx->addr = mmap(addr, getpagesize(), PROT_READ | PROT_WRITE,
> +				 MAP_PRIVATE | MAP_ANONYMOUS | MAP_FIXED_NOREPLACE,
> +				 -1, 0);

This mmap() fails when the test runs after attach_probe in the same
test_progs process.

You didn't even test your AI slop :(

    test_task_vma_iter_next_after_drain:FAIL:mmap new VMA unexpected error: 12 (errno 95)

I'm tossing all of your patches out.
Submit them all as one patch series and they better be tested this time.

pw-bot: cr
