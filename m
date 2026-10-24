Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792869420;
	b=NH3+115lAECRnRAb1Pv9xNp/aHqyOlJfQDjQlVn+9OybnES+GbWpbo+Jo/CpuA5hiGjz
	 0+naQIhgOAjPYEnLKB0ltTChMfiH+UsDUAiAgL7YNx9YyDct7wt2b41hrCeQUIVvGaOWF
	 jgDCmkoC/ZKwfkfaCgvxlHudppNd202slV3cpjyDNuev67YKHdDw1fFTINAYmklBag5/b
	 qmsJYBf3UuM6OwZozquO8xIk7sCAFReJwZB9pqbBBYeAhzvySil2DEJLcvV4IUvNiQR0B
	 dM8ZpvKJo4N30KpTZj0t1OymhxgUYF3/dnDek5ZalSxMA/UtuLIAamO95isfHI0R16Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792869420;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:To:Cc:Subject:From:In-Reply-To:
	 References:X-Mailer:Content-Transfer-Encoding:MIME-Version;
	bh=lKFFsDPJi43yOKcVhD1KfWpsA5pIZBGsoSSoZl1wDJc=;
	b=IXRgf9EmvGLTKE2E2WVzK5YiuSKUNewSyLWAylph4c7SLQchAX0ixgHFES/07PHLx+2m
	 Y5K+ht4ETgvHKfnaBoX7dGZWnJ0wNVrWi+us7auc5a7on8W6OG/mG7d/r19aZc+I5fBLr
	 NlKJN9mVoL0LXCAbXa+MDP6ilchlheX1m/kj73vdyunQLSAj5BUg66wfioN8kzIZg72md
	 95Z2WpBGXhii7CKhO05gLOTUW7M/hJWNM3NmJ5KFQLhvVLAdHHxLUKTTLcBuQIA3WNlCv
	 IdwisT0Xqx+xCFd+i1CLbjK+orsjRwYkX5GyKOsa0ZNzy5nxUHNCmSCsd9rhKMBzhcw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=QgKIUsU7;
	arc=none smtp.remote-ip=209.85.216.49
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4628606A31B
	for <bpf@vger.kernel.org>; Sat, 24 Oct 2026 19:16:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D4628606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=QgKIUsU7
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3ac9f49b984so1140735a91.1
        for <bpf@vger.kernel.org>; Sat, 24 Oct 2026 12:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792869419; x=1793474219; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:from
         :subject:cc:to:message-id:date:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lKFFsDPJi43yOKcVhD1KfWpsA5pIZBGsoSSoZl1wDJc=;
        b=QgKIUsU7aew1BGoiglSAO76u8KjLpLQHZwFy2GP5rPKDP0kC7FOX0/AN4a9beYGPTe
         IP3f2YK3E0xtDj0TnQXttu9rcpeXHwLv3mfPOaIVoX85qKETm+v26xBQkT9xBN35fFNW
         H3YdXsbK923tp1dJbv3EvDxBPliC9xn/8ujRqBl+fpOMZW6ZMPG7K8tZOoeWrCWvtITf
         z3WNrEWLr7UUgQYrI14C23gJGgQk3WYNVGnWOXtj9EUwKzF7V3FLS7dYmXj2OzP6MlKM
         Jj/2h0aF+GGYLrK97gMQRPuL4Vx173iOOShowkYbu0MPsacc/kkPs4kwVgl0595jc3dZ
         12mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792869419; x=1793474219;
        h=mime-version:content-transfer-encoding:references:in-reply-to:from
         :subject:cc:to:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lKFFsDPJi43yOKcVhD1KfWpsA5pIZBGsoSSoZl1wDJc=;
        b=21GlRfVjdhbwqjeYR43/CriwhHnix9m8LYh/u5ugf3bEzvOuDuszOBZ6EgyYp6p1O3
         TCKsyUFQNSV0l0GaNLAVGDSZtkPrOQfOcsAXAqHzS80ab4VyHrlrYxSDnUaxQ4jocCZ3
         GnJgENiPje27TATALVklB/i9VocaihGGUknFf8ZO31TxfZv9CSoU3K6zzKFNiYUcNLsh
         JLQbNCLuIdVYayQD9gy/zKLTK6oChoaw5+HfBVkt8yUz/QQ6/43MmUYen2VTRqfOFffy
         WV1u5uSZrD+MbWPORWAhC7rRJvlpoi90+qRlNKQNbiEkg5D3SUtpoqARX9o3KBljgP1R
         PZaw==
X-Forwarded-Encrypted: i=1; AKwUvBwrC7hv6KOjKwRvGcqAALpPKedfaF7IzDhvlJCvxPQlTQd+LTHbI0Wa4UE5CAxU+/NnZrU=@vger.kernel.org
X-Gm-Message-State: AFq9FYJf5xW/1fa4iXZLisUY0PliEJ0o6Kgew3ZUx6bja6n8bxZsoa2w
	ztAwLmphHGHLwtuwEGwJ85/t9oxJninEhiTit196kAypY6ELO64hKHve
X-Gm-Gg: AYBFou08zm/Wt46h1oMSgrZH1JgZHmV2z0NdJsKZ8o9Lq1aPZkx4RioqVRkGV39ama2
	/udx6xaCfZG0hJlQwj2MW8DV57g9t51wZuWnsSNxx31Xi5x0QkFTRHT42tSfvdqOEAQ6wNAAEHO
	KXeAfXn/vLcp5aRbCkHrFbHILKnGjin8sBX56SenKMES8CC1eYXUj/YlG1o12yndEW8Ya/YBWG4
	48vKBl0JwSuYCxE7eggh7g68VnJjA+K6nokuXsJZPkHZmU5xorUNb+t1AljzCZmOjy5RjHethBi
	yZJoFGBHJ8nMceYXz+Lg+ylbCblTqTBKLdf4euC455PgYXNPwtTz7vW8qOj0+AA7QYEs5jVNGpR
	8Ji/R5xeOP/hXJ+BOl1V9vdcdzY1le1GoxNA5t4JqdUYNPOtP/Bxah5X6iPPEk1ItN4Syff8lYs
	z5dq8/aaPGhhcsrfzO2zdri8x97NcBejQxvkFxz0VNdNrB5VL8yhXYhOSceBcxeelE6gqkNtb9z
	lKF77E6mWB76IcLKcIJpOfjjrCq033yhBWJzjTy5xXBwGxJHp92HIcQDyjM5gl74W0yuTwmlQmt
	ZbUr1gWci58MArbo9fj7Cd3ohmbXpgnKVZOW+G1kQLOyeA1R/1p2fTu6MDCO
X-Received: by 2002:a17:90b:3f43:b0:3a0:2900:f55e with SMTP id 98e67ed59e1d1-3adeb5e5ba1mr1705897a91.29.1792869419155;
        Sat, 24 Oct 2026 12:16:59 -0700 (PDT)
Received: from localhost ([153.61.198.248])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adebb0dda7sm2125056a91.4.2026.10.24.12.16.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Oct 2026 12:16:58 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Sat, 24 Oct 2026 19:16:57 +0000
Message-Id: <DMDB605R77PX.PQ7NOLJHOC33@gmail.com>
To: "Eduard Zateev" <hackerowskiy@gmail.com>, <bpf@vger.kernel.org>
Cc: <daniel@iogearbox.net>, <andrii@kernel.org>, <eddyz87@gmail.com>,
 <memxor@gmail.com>, <martin.lau@linux.dev>, <song@kernel.org>,
 <yonghong.song@linux.dev>, <jolsa@kernel.org>, <emil@etsalapatis.com>,
 <ihor.solodrai@linux.dev>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] libbpf: fix helper macro C++ compatibility
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
In-Reply-To: <20261024035902.44566-1-hackerowskiy@gmail.com>
References: <20261024035902.44566-1-hackerowskiy@gmail.com>
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

On Fri, Oct 23, 2026 at 08:59 PM Eduard Zateev <hackerowskiy@gmail.com> wrote:
> The human submitter must review the changes and test results before
> submission.

ouch. did you read what AI generated for you?

The reason for rejection is the same as before.
You're stratching the surface without thinking.
Pls stop sending such patches.

pw-bot: cr
