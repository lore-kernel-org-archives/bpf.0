Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C91E32720D
	for <bpf@vger.kernel.org>; Thu, 18 Jun 2026 19:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781809338; cv=none; b=HsDFGTBnarSLqNff/sXmld11nAqMTQYEajJxIlFvt8qN0VVOQ5OC4x+dhS/JyZLmOPrY2635qjvgolTdlVDJtzz8jyRi1hIssIOVXYk4DZP3508Ewz7tM0dwbE6P4lhjDvpamEDGfogJx0nBybjmp6e5Lp+7b63s7Q5IS9Nl3X8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781809338; c=relaxed/simple;
	bh=Ud7c7ziFdGIHMaWEoi0fi8loXZCXKJaP++l3geDTRd4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rbyquoxfokBd7BfJ+6OijD2dCEDULQFyCLW70NHgAdb81W0y7DWr7orcpVaxcX0l8GlGYGwBjAoYxzkCrHQmn14hhoIhcJBELX0oH+LDHVRWipXdefv2k9061THqM/OwoOkMc+WDtXm/nQXF41mJTDL7Avk51cVrzt/9+lD/nJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pW4gAIK1; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pW4gAIK1"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-36dd65b95f2so934739a91.0
        for <bpf@vger.kernel.org>; Thu, 18 Jun 2026 12:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781809337; x=1782414137; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=whmu7IhVKfdGkzE0JL0WMbR56gnvcartiKhVDhUrLW4=;
        b=pW4gAIK1uckRuYrWzMqf2X5OXbf7MmWb0v/K/Eri7nenR68dRFAsiY+eoieHKs6ILd
         6KYyAFWnHuGgSDzZs0/fGXQKAc9RE23IbLen9DF+OXH+OKuxzhKmvVzgXQ65Vyvgu/gy
         UGYOtyAStBiAx7kaw2lRU+9s4fJ6wCRj6PhtJ8zHaqnsSi8S9WCxORYimY/VNiAJ2FLn
         aqyWEDJH2IPDVspvmizWovb3QB2hOZ90M9l4yQZc8+1Rd6E001fEH+jwzpPveC+ubzCu
         DhGME/4gcbcKFuUM3GHou157ARQ03hfxZm/i6kIUEB9TFbt+YJCqLUvLWsoHr6cG+bMZ
         CExA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781809337; x=1782414137;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=whmu7IhVKfdGkzE0JL0WMbR56gnvcartiKhVDhUrLW4=;
        b=dOBwIBqlHKdv8bUx4w0eMN0C7J5QrkapEVWY9APD8U9aSEWCYuj+kCL+81htSxJ2kj
         1XjxlAV4YrvsQtftc6FL5dqQuSTi9oqC9vcQZwMkJzohBr9UsJN1ZTOLYsnrIavCwSEV
         xyBh2WIhH8fnu/SSG8Sf7EQB/gBoC0n6OD7yb55kuKevbQg7LDZcLp7VOExNuRXLY3JG
         7LfD674LVImBGVF7lyrDHCChiOpUVljizBByiIS1xQwkyeRUXOkn9+swp/230eMo/TOs
         +0O4sCyOq8iCzkWjiAyYrlQoA+GGFDM8K424K/UXE6QxV67uRFN64MgAxCx61jdpT+kV
         hCgw==
X-Forwarded-Encrypted: i=1; AFNElJ9FQJTn1qqIS9nm2DyLir42pwZ7+QPlp5x4+ZVlLDVcUQhmPaI1w3rTDtMn4OaCjArpu78=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxqkopnk7qZTy9ho1BC/RQ4ykh/KughV9egFlXIzrmbdodoGyzz
	pO/FkI1QeKdgQXSS3qs7Sbb8IX921R0pP4/YItwk8FEEwkq5dH6XM/dB3c/j4w==
X-Gm-Gg: AfdE7clQaknXSsANwNDuHnujF0RxlXhWW12JwLGGiEzWb9Y7NJAJ93cW173Lh0gr1Aa
	T3b2k32hPD+5Ptx9X0Tjw1cZI/WjeyEJvcFtDr8pv3RPyqV8nnwc5cj+NE1KhP/IYYnarw50JPi
	Vts41/zG6ccH+ex1A/u+iz1IcEyM7/cLZLZjGWvzG+Vk1LaCy+Cvb8pOKZOp9DcU2p+Za3Fsa9R
	qGl96CfDQOvb2zRms8I/QY3iuMj549jK1vVtfGmgO9xHa7NerthrNaxEjBJKULkZXaJsh+zH0Z8
	kLktCvSllB34KK54ZxJ4tiZlvX5XE4kGM6+UxYcKK4624GxnkrCYOvv75ebscWIVRn3lME4C47s
	pE9OjdNt6HY4g56QVqN2YMRYV4DZ3/BNW9g59HWSKIDxrZPyL0Kj74IvwP6r+dRsz99BwNG0B5z
	1RuV+8CwMfxg==
X-Received: by 2002:a17:90a:e183:b0:36a:caf2:3815 with SMTP id 98e67ed59e1d1-37d1a30f02bmr225853a91.15.1781809336618;
        Thu, 18 Jun 2026 12:02:16 -0700 (PDT)
Received: from john-p8 ([98.97.43.82])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37d157b7182sm415141a91.11.2026.06.18.12.02.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 12:02:15 -0700 (PDT)
Date: Thu, 18 Jun 2026 12:02:14 -0700
From: John Fastabend <john.fastabend@gmail.com>
To: sashiko-reviews@lists.linux.dev
Cc: Sechang Lim <rhkrqnwk98@gmail.com>, bpf@vger.kernel.org
Subject: Re: [PATCH bpf] bpf, sockmap: fix BUG_ON in skb_to_sgvec() on a
 resized ingress skb
Message-ID: <ajRAgiUlvyNt5wlr@john-p8>
References: <20260613082442.3252576-1-rhkrqnwk98@gmail.com>
 <20260613083747.CA2991F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260613083747.CA2991F000E9@smtp.kernel.org>

On Sat, Jun 13, 2026 at 08:37:47AM +0000, sashiko-bot@kernel.org wrote:
>Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
>- [High] Returning -EINVAL when an SKB is shrunk by a BPF program causes the `sk_psock_backlog` worker to incorrectly treat the valid shrink as a fatal error, leading to an unintended broken pipe (EPIPE).
>--
>
>commit 54e4eaf90ac6a727b56c416746a6a961673b62f5
>Author: Sechang Lim <rhkrqnwk98@gmail.com>
>
>bpf, sockmap: fix BUG_ON in skb_to_sgvec() on a resized ingress skb
>
>This commit prevents a BUG_ON when a BPF program shrinks an ingress SKB.
>It accomplishes this by clamping the length to skb->len - off and
>returning -EINVAL if off is already past the SKB length.
>
>> diff --git a/net/core/skmsg.c b/net/core/skmsg.c
>> index e1850caf1a71a..2961178ebd1e1 100644
>> --- a/net/core/skmsg.c
>> +++ b/net/core/skmsg.c
>> @@ -550,6 +550,10 @@ static int sk_psock_skb_ingress_enqueue(struct sk_buff *skb,
>>  {
>>  	int num_sge, copied;
>>
>> +	if (off >= skb->len)
>> +		return -EINVAL;
>> +	len = min_t(u32, len, skb->len - off);
>> +
>
>[Severity: High]
>Could returning -EINVAL here cause the sk_psock_backlog() worker to
>incorrectly treat a valid SKB shrink as a permanent error?

Yep it treats it as a hard error and breaks the socket. The above
patch does enough to fix the BUG but doesn't actually fix the
underlying issue.

Sashiko AI review · 
https://sashiko.dev/#/patchset/20260613082442.3252576-1-rhkrqnwk98@gmail.com?part=1
