Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD23F42B720
	for <bpf@vger.kernel.org>; Tue, 28 Apr 2026 13:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777382295; cv=none; b=dgV5Ok5gMgjk5CuF9O2PYjD3+ONYAxGdzfJIB5jWYnB915ppdWr2LXkktt60Q3kMSRK/49B1lnjvCwKh79MbRJjlHyFDafZVXgjYp2iDFNfQQRLeLAHp/7FNXrVYqLHqP8IbcIJLHP8hQOesH5YheMfZgDTGRwQE55QHBMt0aTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777382295; c=relaxed/simple;
	bh=GhY3FksqwFDvPBV5sg0GBgUrwnJg+z9AjdtiOlcITa0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f4nLaBLV3u6z1EbEWTqGrR7woyNADwNNpJs7VGZflt9vbGLrrf+81oNtKFSd1j+P2fP3S+jByAj8Uo1CjvYiUgReA+jWGerdUGXte1Tezb26SYBOfclKp43rav5B+WeYi11kK2nSi0yaVu5+rQTDEfLRoPDQC0nFNj/R7YckXUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H1cBxKmi; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=DzcBCKCf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H1cBxKmi";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="DzcBCKCf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777382292;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MxRmdZGbgg8l5KcVhpmDGz3RcA0bF9mwQK5ZRRhDdpE=;
	b=H1cBxKmiTZ0KhcuLi/8Ir98Tve9xp+jAG59e0m5+GCw9yZcrZZVDyLYPRjeWRCysNRZR4B
	rUq1oi8JMgk7LqGoK2soGd4wAu4zxdX61fBOtuu9q2Rt7qwJGJ6MwUNEbz3jmFawf3vTYD
	0CxaApN8ybxTvTBHPC/TI2o6XbeWKwY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-9-tBI5zVTwPVqkSu9RGEO38g-1; Tue, 28 Apr 2026 09:18:06 -0400
X-MC-Unique: tBI5zVTwPVqkSu9RGEO38g-1
X-Mimecast-MFC-AGG-ID: tBI5zVTwPVqkSu9RGEO38g_1777382286
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-43d789cebcfso8094038f8f.1
        for <bpf@vger.kernel.org>; Tue, 28 Apr 2026 06:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1777382285; x=1777987085; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MxRmdZGbgg8l5KcVhpmDGz3RcA0bF9mwQK5ZRRhDdpE=;
        b=DzcBCKCfD5BT5eD5auT3BBHxxdPFcIg7ivEuNcs2/+eRGAuBUpNx1OC9WS63U7HXY6
         icHzzwVGjz8wX+UI9YXNDjsEmkLPCcNffdfJSoPn9y8kjNPHVWqIOfLyzmJQxBnKZt96
         pgC+N91PpO9Q9L5le5EpCce40Ji+e+Gjb1jkklw50vaEU/kTjxYSaDny1SMGvOA0gAPs
         tL7kYgm08rbYuB3Kln1+nBsCCEoQRDBNe2w8yg9MORnCHnUDGQIUc/ZNdvGE0HHV/2AG
         FTKm2SA8eXKnuKA4b8a0CWbJXuModyuS0vQEY+0CIgG4ehzIzHOqDCypgsF5KwEsC8MJ
         2Eeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777382285; x=1777987085;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MxRmdZGbgg8l5KcVhpmDGz3RcA0bF9mwQK5ZRRhDdpE=;
        b=J4S5a1b+1OO3qnSHKCmP9ksZcLD17gmmU+aX1R2oOl0AC0fGbHjXXd534C/QzphDZz
         vReRHM4cx7Lc1b/u1anXuepIBWLh1eb5PBFOPdjb0ZhuI/ap+0p0IaNFw15SUfb2rpN9
         XynGYiPBxcHv5lLpa+uO4hiz2gM0MJZvtakTmEFAO8xS41X657WgcHmszJCKw8LmP4kS
         glkqh/iqy+L7pOMhKVzvLfS940saWie3VZrRQG4gTsg00I2ISAHSY8jT9bEQZQAxRybO
         M94+uphFwbRUg14oIzZmedQlykq7/2XtpyUElnhVX2ceVEa9DKOTf3Xp0mtXBM88N5qZ
         kYDQ==
X-Gm-Message-State: AOJu0Yzxu/e6Zmc/+qsLlCKn02iN7G0s79CUGPszSAIuQvGbXH/HlQwQ
	o6NmNpAkW+YqxWfTjGKo7vmXxWx8qDmFYpFyae4rcCyg1vhzOlWn5pFCnijm2w95h2oFE+2jKSO
	2g6IvcsYDUQW2poYdBMuqJLgIwuYNavKRcsz6NhxY4RST7vK7+7OD7A==
X-Gm-Gg: AeBDiespZLYzChQhw9kmWztVnNUR1GEux6E8xkbAqSOUCFYWlLtciEN7EnoKLYjVFgS
	R3afVRwrP3K7yAZ+ikwIDygbcDKPcuJdFzByxJ37uc+16yp9vt+9YBwgi4y6MZOPEB6Tj72dKdz
	s6rjbCYMniSUL7TtGdKJvtLklEZZIMlxAPwhuWQvjRbTYSI+0VEo0dIrr0yxDd2WftotrxTEuUA
	TeMn8M71rjvG0uTGfkqo455JYV+IBvk/qAYnSkyW6CfGzLBY6Nvw4JRsotFpYroHJ1BIZpONvfj
	SD19kqWYqlTo0do6xyKTQKMB5N5q4XnymL0RsUR5R/GTq1mNz95MbELbgJ7G+RHI1II29E3zUZ1
	bDPVJKp/nHbSimNnsR2CPanBLHZ1q5+cbrpczHRTfhMX+bTKEyOGU9xD77jTUUk575Q==
X-Received: by 2002:a5d:644b:0:b0:43d:210:2b2d with SMTP id ffacd0b85a97d-44652b863a5mr3564962f8f.31.1777382285452;
        Tue, 28 Apr 2026 06:18:05 -0700 (PDT)
X-Received: by 2002:a5d:644b:0:b0:43d:210:2b2d with SMTP id ffacd0b85a97d-44652b863a5mr3564924f8f.31.1777382284851;
        Tue, 28 Apr 2026 06:18:04 -0700 (PDT)
Received: from [192.168.88.32] ([216.128.9.114])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4463fb7e366sm6197707f8f.31.2026.04.28.06.18.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Apr 2026 06:18:04 -0700 (PDT)
Message-ID: <b1fa683c-31e0-49f8-b1ca-bd921555aa55@redhat.com>
Date: Tue, 28 Apr 2026 15:18:02 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v4 8/8] xsk: fix u64 descriptor address truncation on
 32-bit architectures
To: Jason Xing <kerneljasonxing@gmail.com>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, bjorn@kernel.org,
 magnus.karlsson@intel.com, maciej.fijalkowski@intel.com,
 jonathan.lemon@gmail.com, sdf@fomichev.me, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 aleksander.lobakin@intel.com
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org,
 Jason Xing <kernelxing@tencent.com>
References: <20260424053816.27965-1-kerneljasonxing@gmail.com>
 <20260424053816.27965-9-kerneljasonxing@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260424053816.27965-9-kerneljasonxing@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/24/26 7:38 AM, Jason Xing wrote:
> From: Jason Xing <kernelxing@tencent.com>
> 
> In copy mode TX, xsk_skb_destructor_set_addr() stores the 64-bit
> descriptor address into skb_shinfo(skb)->destructor_arg (void *) via a
> uintptr_t cast:
> 
>     skb_shinfo(skb)->destructor_arg = (void *)((uintptr_t)addr | 0x1UL);
> 
> On 32-bit architectures uintptr_t is 32 bits, so the upper 32 bits of
> the descriptor address are silently dropped. In unaligned mode the chunk
> offset is encoded in bits 48-63 of the descriptor address
> (XSK_UNALIGNED_BUF_OFFSET_SHIFT = 48), meaning the offset is lost
> entirely. The completion queue then returns a truncated address to
> userspace, making buffer recycling impossible.
> 
> Fix this by handling the 32-bit case in the destructor_arg helpers:
> 
> - xsk_skb_destructor_set_addr(): on !CONFIG_64BIT, allocate an
>   xsk_addrs struct via kmem_cache_zalloc() to store the full u64
>   address. Leave num_descs as 0 (zalloc) so that the subsequent
>   xsk_inc_num_desc() brings it to the correct count of 1.
> 
> - xsk_skb_destructor_is_addr(): on !CONFIG_64BIT, return true only
>   when destructor_arg is NULL (not yet set), false when it points to
>   an xsk_addrs struct.
> 
> - xsk_skb_init_misc(): call xsk_skb_destructor_set_addr() first
>   before touching any other skb fields; on failure return early so
>   the skb destructor is never changed from sock_wfree.
> 
> The existing xsk_consume_skb() already handles 32-bit correctly after
> these changes: xsk_skb_destructor_is_addr() returns false for any
> allocated xsk_addrs, so the kmem_cache_free path is always taken.
> 
> The overhead is one extra kmem_cache_zalloc per first descriptor on
> 32-bit only; 64-bit builds are completely unchanged.
> 
> Closes: https://lore.kernel.org/all/20260419045824.D9E5EC2BCAF@smtp.kernel.org/
> Fixes: 0ebc27a4c67d ("xsk: avoid data corruption on cq descriptor number")
> Signed-off-by: Jason Xing <kernelxing@tencent.com>

LGTM, but waiting a bit more for Magnus, Maciej or Stan's ack.

/P

