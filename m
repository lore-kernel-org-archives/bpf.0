Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 214D24B0497
	for <bpf@vger.kernel.org>; Mon, 17 Aug 2026 12:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786968894; cv=none; b=DoMu3Nvtee5fC4F6IxAIQD5LDFq2Mvzt1oG+xyyjORGDC+TKS7oaRbNVOvmHDLuLDN3Gkdd3RyGUc8QqLLO02x+4hczeBn831el+2hrhCmetyZGj4mGjhDHCWlqCez61ZaxoyxMiyU0B/HsXAhYhyNbEVJlw2p8nY/bE1cGzxWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786968894; c=relaxed/simple;
	bh=+grdlO8J6+zq9JbtbB00lQNOLw0PobBwWH9M4IQUYmg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dY0s/BdNIY3tzy4nVJLfmeCEa3ojIZnhQiB1CPOnxEO/7G2aALckxMFPGXQE2bntWbIE0iJAlGr7CNtbUsnJFakf77olk0hD7wfxbVHj03ZeIr5maeQfy2Y8nChRzFj76xMEh0OJ5nfyf65myvYgMkc59PbDqfG6cSus0MhGiOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=AcFwCDFZ; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="AcFwCDFZ"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-496bb7cdf51so41427125e9.2
        for <bpf@vger.kernel.org>; Mon, 17 Aug 2026 05:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1786968891; x=1787573691; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=01zYHu0teBLcC0seY0nFh6OS3sPomq7wlr9susi30oE=;
        b=AcFwCDFZB582urYQGtmfEts5tyJt5PjdY2SUP6inB7ciEfrU0xJgLOTEtfZwr9xv+B
         OZcLjl2NK2W+sb9HtW7mrrZ3vZknWIelSEaf45WWLNdivTpxy9aNequggBKDS74UavR4
         b7M7hga68r+o1o6qlzs2hqJoPiCC+V8jY/mWv66GfSF7gIu/C/+Z1Lv1UeDZCgqA+wZt
         SF31mXQvKsCHsXxAiPvF08XRJSnATRMKBKK/qEVGh2P4B1MD9zRsNWcd+dB2eEWoIyW6
         Nqk8cMN14VJaNqj7U3e1GZNkhs8tUKmkHGFHztqssv4uzdYvUhFciitA5thqLfuCziyG
         k5fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786968891; x=1787573691;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=01zYHu0teBLcC0seY0nFh6OS3sPomq7wlr9susi30oE=;
        b=qrNRWAvz3qz1jslDHubNgtCSFhaJj9DFMTmpdfGoerabHNtaYSN9WekmmPWDDRk+Xf
         zAM5kbJYK9Xy24s6t31/PJ5S66manMMDt4YpwHSL6Zo+IeKYW+8mFmGUemzXJYValcV+
         d4sxMBrn8BBtkep581QnzqilwM73ai721oyCbEbKus9e+wtGYlXvsZB6fbKH76QYvRql
         8Rb/kboLo3fjrULFB9CF/CXw8rPNx8jkyajVS7b/lhWU4JBVLujw+3NyPX8xqYePU//a
         Sxd8SGqojA3qBz9ORFkNQDlgiKgWVwvvr33O9DB98ErYgsdFf0uiPrS6fZHk6ehLvcYM
         +76g==
X-Forwarded-Encrypted: i=1; AHgh+RppsMilR/RA4cp4eRLI1R2uaYRs0lMocZhiaFJUYSEQGaSbsZeVChrYKouxcjYdHRGpvtw=@vger.kernel.org
X-Gm-Message-State: AOJu0YziQczFXmeVarpNvtORCfXAWHAKIQ5GuCaX/zDoXMWwn1QhlJwU
	cgcQyycWs5EZlwGci3tGvg5tCRo4ahla1Fjn/z1e+YQr3M5eWMuD5Eqyh6jlM+slXgo=
X-Gm-Gg: AR+sD13Sf+OSRwctnppC6UtyEBb0FK8DB0Ru2nBPG63or6hs646WukHtu0eF/M5rKrq
	/a9Pt1Z3U9m+/HNcj6oPwPw2nXeWtTQyoudy6YcAEh2KIWu1MyRaFZ3XNXFDxGluqK8tinNRhRq
	op61RYsaewBl5hYdd+Gicd08c4g2OIi+zlrwo1HSgYZ2IVCkUxL0HU9VS8qiZ3MHztqB7lsNX0x
	e7INsR6Cy4lbqwWI0t+vheHoL1ITw+znTFhO/bbG3VeBUi3YoT8nFtGpI90nl6Bbon2lTOv2GA8
	BW1SDOGiDOZRFFugYOUM+EkrhCu8w+ID3KDlltF9Y+I6Inq4SdnkIPDzWjGgJVYNk7cs4NBZWO8
	oP1UXlXZt6kGmQU00UHy3liVsMJw6DulOgneY8wLcX63OZDOCK5kcAOJ2f845Fd8b6yJ6EzlEk/
	aoSLvxZ+TfaExhwomfzuWWilIoG10wMSumNPFQQeMcjRsP5G+IDl1mdcpewNVfdns=
X-Received: by 2002:a05:600c:4e13:b0:498:11b5:3ff7 with SMTP id 5b1f17b1804b1-499879bd2e1mr385420895e9.18.1786968891419;
        Mon, 17 Aug 2026 05:14:51 -0700 (PDT)
Received: from [10.20.4.146] ([149.62.206.129])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49996100082sm193773585e9.2.2026.08.17.05.14.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Aug 2026 05:14:51 -0700 (PDT)
Message-ID: <7daf8a03-c803-456e-8497-5f37050bcd6c@suse.com>
Date: Mon, 17 Aug 2026 15:14:48 +0300
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/5] x86/cpu: Move 32-bit SEP setup into identify_cpu()
To: Ihor Solodrai <ihor.solodrai@linux.dev>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, Ingo Molnar <mingo@redhat.com>,
 Thomas Gleixner <tglx@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Andrey Ryabinin <ryabinin.a.a@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>, "H . Peter Anvin"
 <hpa@zytor.com>, Andrey Konovalov <andreyknvl@gmail.com>,
 linux-kernel@vger.kernel.org, x86@kernel.org, bpf@vger.kernel.org,
 kasan-dev@googlegroups.com, linux-mm@kvack.org, kernel-team@meta.com
References: <20260814235134.3461435-1-ihor.solodrai@linux.dev>
 <20260814235134.3461435-5-ihor.solodrai@linux.dev>
From: Nikolay Borisov <nik.borisov@suse.com>
Content-Language: en-US
Autocrypt: addr=nik.borisov@suse.com; keydata=
 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
In-Reply-To: <20260814235134.3461435-5-ihor.solodrai@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/15/26 02:51, Ihor Solodrai wrote:
> identify_boot_cpu() and identify_secondary_cpu() both call
> enable_sep_cpu() under CONFIG_X86_32 immediately after identify_cpu().
> 
> Do it once and drop the ifdefs while at it.
> 
> No functional changes.
> 
> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>

Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
