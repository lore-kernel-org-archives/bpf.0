Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B1DC224FA
	for <bpf@vger.kernel.org>; Sat, 28 Mar 2026 06:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774680465; cv=none; b=gqpL7O/IQXXOVG/6KNyTjOI+TvOej66SNC4W3maJXchYnaYcvqEjtKoIUQWuMm5RBwWasKvFWhu0g0hfMYUJk1FLC3/jc5wD+If9RPvJpMGkJkrAtEINkHAO1egjOeC/3Y02LWg6usJTSaqXLlDNT+w5ltk70YIZsl3SYYEz2Kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774680465; c=relaxed/simple;
	bh=cveZp+Vy3Scii9Idd9Bdg1RVNpqTh3gkkpbJjk6j6Rs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IyV8LtYO4Irn4prWplp+6QPwHdZLI5ckts1X9BboVvUruHG/bgfFiWw7wy5PYJTXJWShq+1xvoyAU5Q354XNc1X+4WepO4JQpp5rTGm2mFyX40J/PWqiAg/IFJ/9eB8thb1FrGwGFLnKJZ7QnRmvA25BkPKekPJ/iv3QZ947WOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=HI9ztUpy; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="HI9ztUpy"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-486b9675d36so23862655e9.0
        for <bpf@vger.kernel.org>; Fri, 27 Mar 2026 23:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1774680462; x=1775285262; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xlZiBNibEuv2HGtFLqjsLg+70wU45AydbZfNpti4zn4=;
        b=HI9ztUpyeIvxsVZmB8GsW6dOGbHVM8wvDnUkfTqX16o4N1g34g+2Cqq3l/sLoHir3Z
         YiEtIYE7lI4IPrbL+BGEttku8hXDMpHMOX8H/HfuEK2kGU1WjPYOUEU6CvtKmvO6c8hE
         /2MLZeMImopxiVH9Xav6RPxQCXT2VIT4PTAa+zOxA/Li0Du6l7g6a4a74VSDZB3HbhEa
         BZ2NMj3xGKKnMADJv9+w3yENObzIt9ZeSQWObLKlxwonwbYuJA71K28wnhO1xZQR+jzE
         tA7Wp5ASSWkf6trgIZhdUeVVfZvYkxBT0k+PQtSEgvMs+hb1B47+85mlHwrZODj1VaG4
         kS1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774680462; x=1775285262;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xlZiBNibEuv2HGtFLqjsLg+70wU45AydbZfNpti4zn4=;
        b=aCY1pxOtNvUTP6HjapRwALzyu7bPm5kSecHvIUNxYQ6eGrk5Vi80apEc7Atodbau80
         7sbwRe9vrRjihWbA1Q55ohlS/2hCJkdoGzvVa4LWwCayYExreH7yCfZIa6W2xFbIuJ0z
         UfF2KigOv7dNapArSJFdaYA09UviKbCp1EvUNQmfzdtOaCx5AbPrw8vZN+GTLGihYSmT
         n3wNWIDU8fADz6dJuZ/ZaxxgtfzOh9avecB2YNBv4aw7WcLpMAYXpb8i5MLhyv+kfw6G
         GPtcQWVlCQ9H8KZu5GeSTqQRSu0gnU36V8XRwGCH10Mp8JZa6ZDziGutNMtY70ZkuOvj
         xG4w==
X-Gm-Message-State: AOJu0Yx3l6QtEf7NVJkuDCV2K7tKP0A8zEiyUT8F7ck2AB27HPQ4Ccfr
	bSI/nz5dSnqDZ9jWLCgCvKY1jsHZ3QhIb7aBBDEsVmvP3lzHOh2ihCTNHIwEGod2aGM=
X-Gm-Gg: ATEYQzyokPXwgYB4R1Ik7CTCzg/CLlHjhiyd6OzFTjyy4zcm0hW7L/JPIoPt8JMve4y
	x/JnbpgGH2Yc6TQhvuq88O2jIZx88HqJAiKcQZ4aoyIjdQKLfEzz8HDqTayYi/33gDgaA/dkrHo
	B7avDVSluDY2KYQXAYIedlUsJ7xwSEw2R6pLZiI0h9XezFLH7sPWzHS4BqmeKuv4qxpF93tE+VK
	cvJ4VLCBa8c/Eyg1LMmIiWLZw2Lro0afzDC6MlmissbqbhQAqHePoq0lpkVkeQHKkg25OxlL12j
	UCkflS1zWo+cQcj8fo7hNcO94yrThHGd+fgGeO0pZRSU20OJiJ5+aZWZBY8SQWTxPWKPiLZ+SYw
	JQ+lHZOf+vYpIeWToAa3M97o3S6L8XwwC2ZupkOsUJ5kUvaqcyDr+0TbFk6OAEy7nEbFaig6kUI
	v19MyzcPhQsnHPvryyjZJ/bxMStKKTIzs6PQfOiDLUIbsYFJEddT6m0A==
X-Received: by 2002:a05:600c:19cf:b0:487:1108:48bc with SMTP id 5b1f17b1804b1-48727ec7695mr89821295e9.17.1774680462322;
        Fri, 27 Mar 2026 23:47:42 -0700 (PDT)
Received: from [192.168.0.161] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43cf245f87esm3137076f8f.22.2026.03.27.23.47.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Mar 2026 23:47:41 -0700 (PDT)
Message-ID: <d7fe9d67-e20c-426c-b3cf-7d3962a427a5@blackwall.org>
Date: Sat, 28 Mar 2026 08:47:40 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v10 04/14] net, ethtool: Disallow leased real
 rxqs to be resized
To: Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org
Cc: bpf@vger.kernel.org, kuba@kernel.org, davem@davemloft.net,
 pabeni@redhat.com, willemb@google.com, sdf@fomichev.me,
 john.fastabend@gmail.com, martin.lau@kernel.org, jordan@jrife.io,
 maciej.fijalkowski@intel.com, magnus.karlsson@intel.com, dw@davidwei.uk,
 toke@redhat.com, yangzhenze@bytedance.com, wangdongdong.6@bytedance.com
References: <20260327121049.334562-1-daniel@iogearbox.net>
 <20260327121049.334562-5-daniel@iogearbox.net>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20260327121049.334562-5-daniel@iogearbox.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 27/03/2026 14:10, Daniel Borkmann wrote:
> Similar to AF_XDP, do not allow queues in a physical netdev to be
> resized by ethtool -L when they are leased. Cover channel resize
> paths (both netlink and ioctl) to reject resizing when the queues
> would be affected.
> 
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> Co-developed-by: David Wei <dw@davidwei.uk>
> Signed-off-by: David Wei <dw@davidwei.uk>
> ---
>   net/ethtool/channels.c | 17 ++++++++++++-----
>   net/ethtool/ioctl.c    | 16 +++++++++++-----
>   2 files changed, 23 insertions(+), 10 deletions(-)
> 



Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>

