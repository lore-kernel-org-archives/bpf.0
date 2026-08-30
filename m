Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2CB72EFD9B
	for <bpf@vger.kernel.org>; Sun, 30 Aug 2026 22:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788127880; cv=none; b=u2EcSxIDdDsi5DIBPo0hbpQuYgufWNeRe97OfQiOqOkev9YdCPgdwo+LCXS5X7HL5Lvy0gZqHF0z5SuVPDNQVY1QE18Vnmaz6mbaqftQKXNrScxzQzliMRl8qXljBFuP2hAiIXki7Re7HJlBk9GfQw5+RVI8pOnKuodZjXGDiHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788127880; c=relaxed/simple;
	bh=2zXSAYsNegag5NXEriA9Zj45P81JpMcNiRSHg4UVj2Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=smcVnCzZgc3tF01xor3GTJqvrmcAwUYrNYflPHZTz7EdBwHYBbL5D+++ANwAr+S6KYl9wa5QcVSCb4VkR34BP9v4nJ6sLRxDoWEyEp+yr4/faQA4K5b0lLcIBh2+u8jBgLzllY5SvGjjXpzwsQeJdVjxgfBj6NbGqyBcdnlQ8xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b8kMtGP3; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b8kMtGP3"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-69c108fee7fso3663550a12.3
        for <bpf@vger.kernel.org>; Sun, 30 Aug 2026 15:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788127877; x=1788732677; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2zXSAYsNegag5NXEriA9Zj45P81JpMcNiRSHg4UVj2Y=;
        b=b8kMtGP350rdbfOsFX3ZqyIrxgcggt+Vx3wZfXBdQMGsrdYtGTdW2SnucBKDPMpkot
         4uJ9+SRzlJFWhKNSxX9DG1k4g4mfENF1MWVefpQmH1J5AbiiQUuNp8uoAHzDhCioyjJy
         l3Un74c2UVqrAr5tt3ARxhbkS1h8RjUZWXtRIwQkDax7BqDR9ZShF2x0o7LaWrBFA0Gr
         uypSt2gT+o/6YiPRJ5rBcOx2A7uRevpaoSpmaDI5dDKYjxvWvz3Dxb0QE6FPA6el2Ylh
         Lbr5ir6++OTifo7760oI7oRpi/DLZywkCu4RRKefZAIVdNhbNK+sUTtloMkEIL4feAiM
         ycsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788127877; x=1788732677;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2zXSAYsNegag5NXEriA9Zj45P81JpMcNiRSHg4UVj2Y=;
        b=Z+L0DG2+n6jpAoFNmjSRY+MjHbZA4WIzxJenVivBvnfCY33pr5YIuJDm9NPNPhZrxr
         TNGa/uV3upsVl1NKwEkVZ2o/RFwWK8GlC9ie6WnuiewYGa32vdoMKlLGA+F20Km3/d+W
         qlrLMZg9PFfLEgtXFPJPXeDM4pnf9YBMv4mvRgAifUYBQaG+CNGg5ZzOVtwTW2+ZGyMd
         QA+x715/N0bdMoMd3VI4LzRMxZBlXg6TeMfZyeoVTkQAuVMn4gvPXiiZlbF0mo8Mn61g
         u4MvfQVXzK/Gynd1Tlw/H2fFDoe20ItNCfVoSBE7BG2nWSTlZSP5YWpRdqlynU0dlQfV
         sq2w==
X-Forwarded-Encrypted: i=1; AKwUvBwSpOcoWb5gx52H82sclgdPwgp4+HreMgrgjjNfMyODBSBbF8ErkT8bVGlqh6QAm2vxfC0=@vger.kernel.org
X-Gm-Message-State: AFuF++l7g2GvPmEKBrXrice9+foAT6KHP4IYvROtAPXoROgilvyCEyrq
	gnE1sKjJJg3R2M8F55Dyhv3eLP2miq97zDPWyEopYiPuKyE1DBwHFlKV
X-Gm-Gg: AYBFou2vHa0t7lsgX6glmilTX30QtiRRDcbJBtSwtrY3pKfk20kQvDfBSQfAe8vJY62
	xNwU30Kw4DtyxJ8D3bWz1aByO81QenSBGvovX9zRTYk8fxQr6qEhMXTQhaf2XPBw84Jl8H7ajgk
	e8WInefY/5EiJEqjvRpdj7qq3H0gdAAk39ZGYTbIH/VU2MKM9XZi/OLH9MbnVY+vo+SJ84BFEct
	KhyJ4AJ7wUdAs2VdTWCjhIopKMjQpaTesFSxKj8xi4B6TT3EyioycYoHIccJoyZM/4yZ4TB1VgJ
	u/l2MHmgWrBTYaYlaZ5ZYPzUVuqp8QlsrVsGs+jFh2O9t7SWIhHu7g0XQZgJGODh93Dx43ofe3H
	uQNWjZIo1xJEpN0v9/jtdZy3Snuc2oxdQSVMbpvxq9+nMpro9mQTHIYtFswsHEWdyi5JaIDIuc6
	Vw53wguLB3zX5SwhZiHqGMbQJQvVy6r/+2pq6HHQRRP4NV7nkMqtlsq18LbV2TGQll34g3SAB/R
	SlaWURR7KyPxNu5bzZSrf7w0rZod+eMVOOvcOaTg9i9+DLpwkcsetdSWBvXwzbWdCI7L2ruqxUd
	YWtTdaAr6sR144F/aej55dPeHRAOfTmfWE4Dv+KyzELJ1XE24YibSscV
X-Received: by 2002:a05:6402:1ed6:b0:6a1:fd14:8832 with SMTP id 4fb4d7f45d1cf-6a60d3c8b6fmr12523036a12.12.1788127876853;
        Sun, 30 Aug 2026 15:11:16 -0700 (PDT)
Received: from fedora.home.arpa (77-162-219-136.fixed.kpn.net. [77.162.219.136])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a611b675d1sm2933128a12.9.2026.08.30.15.11.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Aug 2026 15:11:15 -0700 (PDT)
From: Bruno Xavier <bfxavier@gmail.com>
To: fabriciogava@gmail.com,
	florian@schauer.to
Cc: netdev@vger.kernel.org,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	davem@davemloft.net,
	lorenzo@kernel.org,
	hawk@kernel.org,
	ilias.apalodimas@linaro.org,
	bpf@vger.kernel.org,
	Bruno Xavier <bfxavier@gmail.com>
Subject: Re: [PATCH] net: skbuff: keep the page_pool fragment offset aligned in skb_pp_cow_data()
Date: Mon, 31 Aug 2026 00:11:13 +0200
Message-ID: <20260830221113.1238112-1-bfxavier@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260830212331.546227-1-fabriciogava@gmail.com>
References: <20260827122926.31123-1-bfxavier@gmail.com> <20260830212331.546227-1-fabriciogava@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, Aug 30, 2026 at 09:23:27PM +0000, Fabricio Gava wrote:
> That version has already been sent, by Florian Schauer, the day before
> this patch -- "page_pool: keep frag_offset aligned for odd-sized requests",
> now at v2:

Thanks for linking the threads, I had not seen Florian's v1.

> xdp_copy_frags_from_zc() does the same, net/core/xdp.c:700-705:

I mispoke in my own notes on this one. I checked system_page_pool for
other consumers before sending and read it as having exactly one,
net/core/dev.c:5619. xdp.c:753 is the second. So fixing skb_pp_cow_data()
alone leaves the defect reachable through the zero-copy path.

Florian's patch is the right fix. Please drop this one.

On veth, drivers/net/veth.c:762 passes its own rq->page_pool rather than
the per-cpu one, so I don't think it widens the sharing. It widens where
the misaligning loop runs, which is the part your reading of the Fixes tag
gets at.

I have the reproducer and an A/B kernel harness here. Building v2 now,
numbers on Florian's thread.

Thanks,
Bruno
