Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39F613F4DEA
	for <bpf@vger.kernel.org>; Thu, 23 Jul 2026 07:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784793090; cv=none; b=TQX4V+uYTHF/KuJGPfGBRrs1eOwvIxe3SbEuPRlKkaAHH8SMsH6Wu5lBsNoLHmCT8Mn6UPy3PXiCGofzn9AhJFvW/myDM//iSUQlrbME3S5gbKx1ymkFRFYV3XajQNiAqtC/j6u+MdwzQQCypB15fUctfpx44lzGrzF7G9sz97g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784793090; c=relaxed/simple;
	bh=SNsUozUZWFKiCkN7Jy0qN4XIwMvqhfqRrgc2sGc6wkk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pZh6lJczDJUZ+3gWfeGrjKD2OttaWkSKyQC8as6tUIaRPedYpYFaVN2mlQUrsHx+67d9PYOIp4D39ZDoxSkCzTkBgj28iwqXWC0ldIqmYAfPSNrI/wO+k3Pd0r3Ca6smTDjOsJUDN9ipXTc4LDaZmVvYWFx9WnJyzOyEmDA4qyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VU2RkKgj; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=gw5ri8hU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VU2RkKgj";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="gw5ri8hU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784793088;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Sqak6NzeK3N9HwY2qRwknbGUvJUZRzXhr8+SM9jOMpE=;
	b=VU2RkKgjIxfoWa4U4Bi3c53vp6bzyU+OiyUFinuh9qgnpnu+Zy+NlAi9N9P3MGu0AcXOMw
	8bN/PbQtEOYVy2aHd1jurmNsh52G957UHqe6WoBFiwhdYCh83Eu7uF15Rb7U9SmpvQeEJd
	gCR9KLW48JQOXIgn0i1ZBYWP+QIzwjs=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-299-wD4B889pMbOeoNyxpyoTBA-1; Thu, 23 Jul 2026 03:51:26 -0400
X-MC-Unique: wD4B889pMbOeoNyxpyoTBA-1
X-Mimecast-MFC-AGG-ID: wD4B889pMbOeoNyxpyoTBA_1784793085
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-4629f312a67so237202f8f.2
        for <bpf@vger.kernel.org>; Thu, 23 Jul 2026 00:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1784793085; x=1785397885; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Sqak6NzeK3N9HwY2qRwknbGUvJUZRzXhr8+SM9jOMpE=;
        b=gw5ri8hUHS3THqsUHpSVklQonxVDAlt+skCZCdo+evbbTsz+VI/6xgaalzUXncs9iB
         34+XON/ARoC+i8mAWEdr79FYnwK3eSrTTaJ5n4ljmCn8qFRWuXtLMW5wsq7T4+7OIMQN
         5gDgaEo7Mq1wLzqVtU+1hpZG2eOvZdiKk+6y5U8L90QGW1gfIuj1WDs7bslXjI8xjMpu
         oP1rOvztnvY8UKPckuSI6/OR+6gue2VJOl+lqXMqVeRSbkEg8JMW0gMuCxXIRwjW5NYV
         S2tkIZstDkAphnJVg5Tftx3jUmfQbweh35A0lP8uZWwr3Uzp9LF1nD7mNBaH37PAypDa
         SLLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784793085; x=1785397885;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Sqak6NzeK3N9HwY2qRwknbGUvJUZRzXhr8+SM9jOMpE=;
        b=D4QJ4+/6XhbaaYswbBSOUW2jgn0cMGiIqckagWS0rVBH792wUDfinp/o57uNCksHvf
         Ag2yg14ftUaDcD5wDo0duoUOMZfZzbcNluItfsTS6IJ5gfXYMIwm6rj1r8FwsUH+ykQ8
         Q0CWT/BothWxlVGASp4qrbD9maXICZJLY6myifDxIEbTWLzLK4KWcl94C2WjgDqsEpGH
         ibl2Eug4sjJR0AU/EFZafINpmZz0PKG0RJpFOA3RKUqLc8NFUAKvykTRbxslCgT9E18B
         A30xVGTeRyAcIG3pMDZXNBQ0CNqvkMaX0q0tzmIJW2EUX33Mjjn5oWd+XnlMzxAy6Ymb
         GSUg==
X-Gm-Message-State: AOJu0YxTjkAdOA8Sy+bKstcJOtTY1ncYlv/IsSbS76jU3hFTHuiWy89M
	5tYogFUBL7YRUDzLN4+AB6SuH6EdnoDpfBOHxwdvb+Jj7zrRE4vbVEV7d0ZFwPyBlhaXBpOCBYq
	L1czv4drRO3sJ/CTDKT8Sru96w06dea6OQIdcaUH4rsKAUJCaqWzMLmRLKX5LAg==
X-Gm-Gg: AR+sD10gvCangZXozREjlUE/IOo8lN/OAf4Q9n0/YzihYoQW8VKBNt++uLkUeQ5MYgD
	ZPjFUOrNQ5ROtNrExeWOO0ECnqFEluHwPkmIgRQOVQe42Vs3v5uL4e5W+pnKTpy/mBkIktpm04y
	LVX7fScofKpbzMFol614LGtiGeFxQoK70r4ergqJ/ck3O9pDKC0BquLPD5egnjfJsS1jrvpmDOI
	QhPmWxknzm51122vUVnnrBmPrL48UdmpwQLwGkRZpuV6ngGDYdYkejmZWlFCN7XZC4/RW4u0eK8
	8AcZ8ouBqYUzP3ai8EhVx/33JbjYwJxVm+4ni2cxGJWjTn/nwdzkny30CszqYtupcnvJZJtsgkQ
	PXTULXIWvAVE67Mm1hKg58r+iX5Ro0dup2Wggej6u3Vg+pgwkeHIz2K0gQzkFy3EG5efpKFI5Ms
	KpGQ==
X-Received: by 2002:a05:6000:1ac9:b0:47f:3e80:7c3b with SMTP id ffacd0b85a97d-47f8d76ae47mr2447055f8f.48.1784793085215;
        Thu, 23 Jul 2026 00:51:25 -0700 (PDT)
X-Received: by 2002:a05:6000:1ac9:b0:47f:3e80:7c3b with SMTP id ffacd0b85a97d-47f8d76ae47mr2447020f8f.48.1784793084810;
        Thu, 23 Jul 2026 00:51:24 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:5521:6b10:58fd:68f:7756:389d? ([2a0d:3344:5521:6b10:58fd:68f:7756:389d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85c6e9a2sm13269952f8f.35.2026.07.23.00.51.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jul 2026 00:51:24 -0700 (PDT)
Message-ID: <3678f78e-f2e7-4520-84fb-d78b10dc00c5@redhat.com>
Date: Thu, 23 Jul 2026 09:51:23 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/2] net: atlantic: convert RX path to page_pool
To: sashiko-reviews@lists.linux.dev, Yangyu Chen <cyy@cyyself.name>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Cc: bpf@vger.kernel.org
References: <tencent_7DB01BE7F8FA056BB5F11D3570CF636C4309@qq.com>
 <tencent_164779DC8B18AB10B9C636BE23C178ED5907@qq.com>
 <20260710173815.DE08B1F00A3A@smtp.kernel.org>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260710173815.DE08B1F00A3A@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/10/26 7:38 PM, sashiko-bot@kernel.org wrote:
>> +		return -ENOMEM;
>> +	}
>>  
>> -	if (!rxbuf->rxdata.page) {
>> -		ret = aq_alloc_rxpages(&rxbuf->rxdata, self);
>> -		if (ret) {
>> -			u64_stats_update_begin(&self->stats.rx.syncp);
>> -			self->stats.rx.alloc_fails++;
>> -			u64_stats_update_end(&self->stats.rx.syncp);
>> -		}
>> -		return ret;
>> -	}
>> +	rxbuf->rxdata.page = page;
>> +	rxbuf->rxdata.daddr = page_pool_get_dma_addr(page);
>> +	rxbuf->rxdata.pg_off = pg_off + self->page_offset;
> 
> [Severity: Critical]
> Can this cause severe DMA memory corruption during RX buffer refill?
> 
> The initialization of buff->pa appears to be missing or was removed here,
> but the hardware callback still executes immediately after and
> unconditionally overwrites the descriptor's physical address:
> 
> hw_atl_b0_hw_ring_rx_fill() {
>     ...
>     rxd->buf_addr = buff->pa;
>     rxd->hdr_addr = 0U;
>     ...
> }

FTR, AFAICS the above is AI sloop (and quite an unexpected one!) as
buff->pa is actually always initialized by:

	buff->pa = aq_buf_daddr(&buff->rxdata);

that comes after the aq_get_rxpages() call. All other issues are
pre-existing ones.

/P

