Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C66D62D7817
	for <bpf@vger.kernel.org>; Wed,  3 Jun 2026 14:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780498427; cv=none; b=omP9qiwhkMAPFvrrW242F7+AEHEfbNcbjnRMeud4Dp9AkjBk3FqljURr8JlixhVumzjDLmJN2dgrtx1QXIfJW5pn3W1kq2ZplZcrUMc9qKWZdypsbmwdmHcdPSCIw2gJIGPDxu4EwS8Vqs923Ck4Bb3zqP5uvH5hHMsqMWkl35c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780498427; c=relaxed/simple;
	bh=oIUn0YlzZFSw1Rp+7/LMrTQzBtsZvxehwH1Dlpr1sHw=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=E4j05pL5j+WpLLlOB2S/rcsM6KdE7m74ZAqAXumQohY5omU0i8DC6O6UXHnAiD7tHfx/KOjwBlrF+wqpPsfr0oGpZuP/QnDSLh0dCRcshL9wj8gFnMOMfZgOomwv5D9hLYdexyxqTSTWFFaQHeOJH5q72MLhK7Ei7rAyxqZ794k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HBtxWzJ/; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HBtxWzJ/"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4903d730b1fso117168135e9.2
        for <bpf@vger.kernel.org>; Wed, 03 Jun 2026 07:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780498424; x=1781103224; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oIUn0YlzZFSw1Rp+7/LMrTQzBtsZvxehwH1Dlpr1sHw=;
        b=HBtxWzJ/0zLX9xrDjRJOZ/z+jgpErfR+WPya6/DlLUBFgnJGQSZw5Zxz914S9kXDye
         jX9byn2zLV314m3kXkYin9DiCuLQzEYoBywOKYKoU1Vc4iSjhAnw1pgd6x21NLdc9Cee
         pKmzGXafzo3fOXuUa+bxhzzqpFuaBq3K9u1tha5gLJiGMnCuQJ7KBLhKpzrcI3lbHbPS
         TJ3lHebeuEiY3eGXvBB40dTaRmCbP3/B2qNRZ9NCVbq2mBNT4RnJNLaJK72kOweCXe7i
         Uc/x07BgNMa9E2bn6x2cv9rSGZFPdsXglhQQbV3wCzX4CrLNMSuy3GctHbyrmVjnd324
         lHkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780498424; x=1781103224;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oIUn0YlzZFSw1Rp+7/LMrTQzBtsZvxehwH1Dlpr1sHw=;
        b=C7sSHHZyTTn8PvjHUfOkZKP68KZ99Cy14Le+XlZ7gYdXB9YXt1DwYSL81F+pbR/I7H
         HsVxr6InHqcwqUlxfLEwFe+x10+m3DDVu6hnWhrvTRn58DqIimEt0Tg3JBF35P9s9azi
         36p/WpI5chtAj6y2SIHh5nPGidG8HnDK2+e+rWYipvDb1EXL2ImkrA4DLUnFO5dVcj1T
         aHM9x/WSg5SIYKVwXtCzOlZXgCUcvRYxCnXdsaxKskOPBuH52LciFgS2WEs8D6cocO5g
         Cm+MM/bKZVmn+l9d9FbnWz//yAtzzrgomGCHxIDPzZqRlk+O9GUNVDLX8sHroeM1rApi
         TTqw==
X-Gm-Message-State: AOJu0YzX+yfDgvYiOjVK1ErojlYcAyVdB0U1Xe9/a8DScaZJy2gDGI4U
	w6l+szvGIx4+G00kCJMTICut4ir2Co6msR176xfXO4qOXOBW0eGIZcQdnnfVxBZ6
X-Gm-Gg: Acq92OE8uH8LJevfdney7By5cNNDFUdCt0V+nKl2j5+3EpOUi9IeWheaWsFl96Df4dp
	X1w9QJ5Tzeb9ZEvTqRfiBWcYA3L2rX2GWveUfjMvQcJng/Gy+aqzPLLJjWM673bHg3AZyWZ0+eq
	/uWG7vzt1M0fvEFXOvh48+MWp9Pj2mY0gPjy0jCPY8RmNkDZLW5MzbioslFCaeJuT5YOISfgj+6
	snJm+WRAuCBVv+4SGm3gPYPn75cgI8G7TMGewfrN5KGjxn7yvqHaWMjNi+vak7aaXuFSmLfApZl
	IStOKyaiPUCe5GOX/QxqaVxBd5+zE4XcNbEBqU8hi3bTX6LBeVC9Irq/vHaIIhzqlAiqbX0y6QT
	YePvLuz/u9eMiZNZI1PlRu0ybdroOy+WMF202vmyyo65I9IG+S9A2004a8/4M9CHHMoSqy/OM8l
	CpjjQRQXYYHkV/0bR/l1TkgYbtJoVSp00STCplUQgBMl/fa2A/5SryYFQlLBM2Kb6pp2IrXCKGM
	jlBtgdxQIbw+dcUTC6Sfg==
X-Received: by 2002:a05:600c:8b2e:b0:490:50c5:8153 with SMTP id 5b1f17b1804b1-490b5e73ed4mr56452445e9.2.1780498424118;
        Wed, 03 Jun 2026 07:53:44 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:bd1f:f500:f867:fc8a:5174:5755? ([2a01:4b00:bd1f:f500:f867:fc8a:5174:5755])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f35fd33sm8781721f8f.35.2026.06.03.07.53.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jun 2026 07:53:43 -0700 (PDT)
Message-ID: <9a20906a-cd26-42a6-9902-674c55f6231e@gmail.com>
Date: Wed, 3 Jun 2026 15:53:43 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/bpf: Fix flaky file_reader test
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, kernel-team@meta.com, eddyz87@gmail.com,
 memxor@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>, Shung-Hsi Yu <shung-hsi.yu@suse.com>
References: <20260603-file_reader_flake-v1-1-7f3f52d1e388@meta.com>
Content-Language: en-US
In-Reply-To: <20260603-file_reader_flake-v1-1-7f3f52d1e388@meta.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

I forgot to add bpf-next tag to the subject, apologies.

