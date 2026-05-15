Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BBF870836
	for <bpf@vger.kernel.org>; Fri, 15 May 2026 00:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778803908; cv=none; b=IRMOZkPm1+jDzwvyL07/IR79UHSdAS3OY29eQISTxeuzuN6iz3A+4wU9v2dduCuNb6JjOoq6pvGSwtayqpVf9qB65OCkAwbCCOlIFckstdm3a1xpLLnl7DgKw1ldYosPuv3zf5n7tbX2Cl2xCfI1w5w7GqerMNaPYpmRJ+sPmvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778803908; c=relaxed/simple;
	bh=+JL5OsVcV5ZZ26CmKzvNk85TKo6Pqt13cfCU5sI6LHw=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=gk3o7DL6ejX5v5Uganuqzq8ti+UFRjGipdNrNi0ZcRUUz3nyQwBeqrj/XNu9gq+ai7xxYacjdANjsDk5d0Unl0PDOQGrH5sG7SPvb7aYf7HXDtz0BtWAkLkHV4zINT0bnR5VE3RG0QER9Tcuare7SbTSjyJ9NRpKqCAtOUTo4AU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UwcRJajL; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UwcRJajL"
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7dcd689829eso7630051a34.3
        for <bpf@vger.kernel.org>; Thu, 14 May 2026 17:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778803906; x=1779408706; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KvvRHNkDbH4EesEXdDUR+2ohqhlBr9grNyMFHVk/LXQ=;
        b=UwcRJajL/lJ0URY4I92yA42Wz2rr0f03Heq0s55r08ntar2L7AfCu3bfN5FhW+PI3O
         DHuemb8az4Z4aYpeDeUkiJ7qWrSiw1iwUx9yIoUQS62QCCjUzn42E8IPUmt9DO9stRsl
         ws3mQOZRQxlu6VqyN71NFAM4sxPeZl4qzl8ZuG6XMh/bpid3Riw8xVxVugSeV6pZJ4Yd
         D4XFflb+aJUrWvtlIDgLE6tXCY33Tpnr8bi/Ux80vNoMwLzV8DMwHLduoePwN3dfVSPZ
         3qbJeO3Ltb8Kfj3I/MnFZUlTvW17OoquIjLGbQFxf4xuPXWpATUc4thFD5AgUjDELvOS
         0OuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778803906; x=1779408706;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KvvRHNkDbH4EesEXdDUR+2ohqhlBr9grNyMFHVk/LXQ=;
        b=Up7Ob63uKTGWnr6rQBuyK+qtyAzPjjHzpfeipTPEMqLBPYLDD4BgHrZ5sa5/rE9N62
         OFJkUz5RlUhTfWXQbzcFhrIkSbBUvzVX6lkvUB3A/Oll9QZgWpt9kCb9ECyZJWYiIdr1
         tGCX6Ls0fsYE/uxsMg6F9Ok9V5fv87mnH+k1sRcq78rHkPSoBJmYW+cXSb4ezkbzzupN
         lOGiT2Vsd95vXVizlA2iEza/I7qRWnVuK+Qv9Tx8+EqniFRut2a91LRxU2krAKrgHb4Y
         u/VVGfn6e3TT2yKApsEc+ABYae69rTkkJBYqBn/e3fie0SRbQOilwVcfKBZl0OL+KRdu
         oHJQ==
X-Forwarded-Encrypted: i=1; AFNElJ/B8n0d2TstJboriSSPgORNKL9QKRVr568d4RY9iJqwQTA8uBxf4s4GP+/3GKod2caHRI8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxbw1FE9QHDPuXKpJBCyiTXZo2TkHPcJLc3osQBpHzhS2NEKSn7
	SHMxjLB6WKJ5VHwH1+Q5JiBXZw7X2tlYEePg0YRSJ4I3m1nZ/IIzoAwKaliw8w==
X-Gm-Gg: Acq92OEBAsATLJo4b2eQWi0tpxAUILkNnWZA6TtPxfYRMh5C9QnkZ3rCTZA9A03e671
	ZXF0Gfhiv8RpHiqWDB9DMse/ztTgeFmME6LMWjm08DVf94yf58wH43P3cOdoTEXHBDPmvj13wzm
	ksWC/sB33tFRg1L/qxU0Ci6MIqWzdNOu9kO1tyqz6DEKYJYqD1U/pVjfopnYXcYF+vOxvO9C7Fb
	tRe0rmL6hdqV4DqA0RmONqpj9CSO6NplMvcaIGnfXLMLVe0N0P1qZsRUeNsA6IgmnjqE+gBB3/N
	ZITrUdySBSUqdjAJAVDQ1JqytelX+Q8bVvaU2+eAMHloWgtqmnrmVLOn+4WSWgytldwCBv+Vtdt
	61qqDVWh10s4IMUBWnr2TEEQzqA+e3iFhV7CUzX0UrRT0x8luKwOEIp8zXA0rOgMfHvtSUXlTd7
	l9VI8lyicpox/AyM+7BSAUNCCgWQZWmkp7OL3KLh064ot/j8SedlvpHngy9jkHr/Ok/2LGfpswO
	+oejkNEG99HMGOGsg==
X-Received: by 2002:a05:6830:498c:b0:7e1:90a:97bd with SMTP id 46e09a7af769-7e4f2b89611mr994842a34.17.1778803906403;
        Thu, 14 May 2026 17:11:46 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:42::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e55b7c6b43sm31224a34.5.2026.05.14.17.11.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 May 2026 17:11:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 14 May 2026 17:11:45 -0700
Message-Id: <DIITCWVL8TOO.1X7D3HQOLY65V@gmail.com>
Cc: <ast@kernel.org>, <andrii@kernel.org>, <memxor@gmail.com>,
 <daniel@iogearbox.net>, <eddyz87@gmail.com>, <song@kernel.org>,
 <mattbobrowski@google.com>
Subject: Re: [RESEND PATCH bpf-next 2/2] selftests/bpf: libarena: Add
 Lev-Chase queue data structure
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Emil Tsalapatis" <emil@etsalapatis.com>, <bpf@vger.kernel.org>
X-Mailer: aerc
References: <20260511214100.9487-1-emil@etsalapatis.com>
 <20260511214100.9487-3-emil@etsalapatis.com>
In-Reply-To: <20260511214100.9487-3-emil@etsalapatis.com>

On Mon May 11, 2026 at 2:41 PM PDT, Emil Tsalapatis wrote:
> +
> +struct lv_queue {
> +	lv_arr_t *cur;
> +	volatile u64 top;
> +	volatile u64 bottom;
> +	struct lv_arr arr[LV_ARR_ORDERS];
> +};
> +
> +typedef struct lv_queue __arena lv_queue_t;
> +
> +int lvq_owner_push(lv_queue_t *lvq, u64 val);
> +int lvq_owner_pop(lv_queue_t *lvq, u64 *val);
> +int lvq_steal(lv_queue_t *lvq, u64 *val);
> +
> +u64 lvq_create_internal(void);
> +#define lvq_create() ((lv_queue_t *)lvq_create_internal())

workaround for some verifier issue?

> +/*
> + * NOTE: These selftests only test for the single-threaded use case, whi=
ch for
> + * Lev-Chase queues is obviously the simplest one. Still, it is importan=
t to
> + * exercise the API to ensure it passes verification and basic checks.
> + */

and multi-thread test pls :)

