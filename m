Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D2EC19DFAB
	for <bpf@vger.kernel.org>; Sun,  1 Feb 2026 22:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769984602; cv=none; b=P5i9gYcKRxlDVvE/oNfvQwP+6Uhc7cY74XH4m4QdPzFpoqvabNbAR/mvubueFDfEJuBCnTNjQP1ZPTI9YmtNHlrt2wIpWfgNBfoikguA90tsiwG7fgg/LD9oTV+KsXudXUqZdP8WAUSu3Uf2feNbtT+cWkF7nhFC1ZZ95A3Jo84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769984602; c=relaxed/simple;
	bh=0vohZDdn+2gjzL0EZoKOGCHLzqKq/PvaR476DJwbQQY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mX7LWRcI++a7yK8LFGlxPU+uv6a/RUewWOib3UvxzjFvdjcBu8rv4KmU//QnSXJBpzaWQEOe3RTJhlvIQWmfnY1QXwG+GgkkSirU0HDYDWsB2RgF9iVukab1ESOHs7iz1ZhU5TGWl1uK3qYHvKX71zXs1rhALALqX3kGOOYrCy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=ir+QPGqt; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="ir+QPGqt"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2a0d52768ccso25373615ad.1
        for <bpf@vger.kernel.org>; Sun, 01 Feb 2026 14:23:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1769984600; x=1770589400; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=idvi5OfakJy/H3dbVsXRcowQ0slCnw6CmVCHkgylru4=;
        b=ir+QPGqtOEBYbOs+usNNQrVfIOjniIW6pmPa1drPMbXbTbqbE0oYrF5yCRIZrOwSFN
         MvS7P8+/tiKgYXHm4xP2s1qltC2E4SyspcBW8Lf87/jiU+ztyLcbT2jM+PC08B/smxEE
         lvUQqa8ju2W7H6IRoWTMWP0M70ikoo+18P9UZ+kxTNU27woNqifSjd6PPJb9bOaR0g63
         Z3v5M2XkgbCvcd4pzGkLMTJkTT9c+6HtHemZHeYm6RL8dGixVwGhCY6yXmY6tMa2f4Vw
         5FmKbpuAK2OpCea77wW0h9vF28nOlIJtiOa0BB8dn42E8hqMNd47LuV8eIXvhfyLzBeq
         Lsyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769984600; x=1770589400;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=idvi5OfakJy/H3dbVsXRcowQ0slCnw6CmVCHkgylru4=;
        b=csaah4xq7MJI1je6JxxVGPFEYqY74/MjJLhAjk5Cd4/ZfHdQlZ8mQZyVNvpYTO8FpS
         o52TOlqvJoUmWXDyjyDlM1NjRv9UD2azbzgVwUu1vw0StMvMVCCuIOFXBPfZcy14eyKC
         NCvgsH33M7KBAjjWmrjgZ8mXXJOnW01ZC4T21u1MvXlreracu/ltIjZYhUThfHnrDKuF
         TWaKEwg2sdFFxuWgJXcpI7Pn2hhZ5ZZRB8lEBgyS0vJAKvF5e+v6aPMiIG+t2zf4N2bc
         9u2XFA7hJEGyMFVbvfVJYeqKoDbYXpYVnpjjUYD0V92+Mv/vMChxHtfDQ/WlwMnnadBu
         VDew==
X-Forwarded-Encrypted: i=1; AJvYcCU1kF69UV63xbmOU7SDvzK0XCx5ZkvI2Q7rlBqFq9ftR89EoVxQ9Ndiwz2p+ztC58Z+mC0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzRA1spLnhIs7+WH38BMXoChB1hQyBv5qkD7DRmdnz9bQI6BzW
	fBN3uWRxXh+yYSiscOJO0aGVrcM/kfSqq2MsyG50LoJHAGAkDloqJIRFlQv8IssZQO8=
X-Gm-Gg: AZuq6aJ0sbeCYZmkCns7LK1uHjlRqMYYaJVCEgI4G4TJiHaRUPTIz4EK4oUeQ5Rnn90
	5ORVHM+xykv6ruEKld/HM88pBWEvwluFqAXwW0cVoMsg9bzoBo6xTeEypRitO8x4YdheGuNmODA
	Efas8v6ZeXI+dhdnCC5M7H14iumFfyiIo3uvwhhDQxKiW7E+sPgCplH/hlmkmRpFsWsodv+Y0kD
	T3TfDNkh64JMljx/8CCpFyXQ/T6m7tQCjVMpXkohjKTkOx5jilO1HgNqL/10Zv6Dw5ur0flDeLg
	0xPPQEkY2G2+QpTma3+3ztHDijMEjUmGMhLyxoemigWd0RvVFPfJ5+fcwKuD5Tn0vdCyOtW3CAO
	RtIpnD3xp4eEocDVo9Qm5LaN9W6kk0/9NdG0KOAZ3rHQnkySLhT2f5a85C3W6ooiRcej8TXLz3s
	r6hkMOtdLbPcWlciduZ3d+emX910vHykIMseDtvy5AoDFtG8qgLhe+3z7qRL/uq6VeOslvbwUlF
	QyYncOCcK88FgYFxg==
X-Received: by 2002:a17:903:124a:b0:2a9:db7:446e with SMTP id d9443c01a7336-2a90db74726mr19116715ad.45.1769984600381;
        Sun, 01 Feb 2026 14:23:20 -0800 (PST)
Received: from [192.168.100.174] (p94025-ipoefx.ipoe.ocn.ne.jp. [153.246.129.24])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a88b5d92a9sm124143805ad.69.2026.02.01.14.23.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Feb 2026 14:23:20 -0800 (PST)
Message-ID: <01509510-1248-468b-ad6c-50ab61d4a916@davidwei.uk>
Date: Mon, 2 Feb 2026 07:23:14 +0900
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v8 07/16] net: Proxy netdev_queue_get_dma_dev for
 leased queues
To: Jakub Kicinski <kuba@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, davem@davemloft.net,
 razor@blackwall.org, pabeni@redhat.com, willemb@google.com, sdf@fomichev.me,
 john.fastabend@gmail.com, martin.lau@kernel.org, jordan@jrife.io,
 maciej.fijalkowski@intel.com, magnus.karlsson@intel.com, toke@redhat.com,
 yangzhenze@bytedance.com, wangdongdong.6@bytedance.com
References: <20260129222830.439687-1-daniel@iogearbox.net>
 <20260129222830.439687-8-daniel@iogearbox.net>
 <20260131160445.2e49e9d3@kernel.org>
Content-Language: en-US
From: David Wei <dw@davidwei.uk>
In-Reply-To: <20260131160445.2e49e9d3@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2026-02-01 09:04, Jakub Kicinski wrote:
> On Thu, 29 Jan 2026 23:28:21 +0100 Daniel Borkmann wrote:
>> - * Get dma device for zero-copy operations to be used for this queue.
>> + * Get dma device for zero-copy operations to be used for this queue. If the
>> + * queue is leased to a physical queue, we retrieve the latter's dma device.
>>    * When such device is not available or valid, the function will return NULL.
>>    *
>>    * Return: Device or NULL on error
>>    */
>>   struct device *netdev_queue_get_dma_dev(struct net_device *dev, int idx)
>>   {
>> -	const struct netdev_queue_mgmt_ops *queue_ops = dev->queue_mgmt_ops;
>> +	const struct netdev_queue_mgmt_ops *queue_ops;
>>   	struct device *dma_dev;
>>   
>> +	if (idx < dev->real_num_rx_queues) {
>> +		struct netdev_rx_queue *rxq = __netif_get_rx_queue(dev, idx);
>> +
>> +		if (rxq->lease) {
>> +			rxq = rxq->lease;
>> +			dev = rxq->dev;
>> +			idx = get_netdev_rx_queue_index(rxq);
>> +		}
>> +	}
>> +
>> +	queue_ops = dev->queue_mgmt_ops;
> 
> We're gonna call physical device's op without locking it no?

Yeah, sorry about that. I'll change this to be similar to the new
mp_open.
