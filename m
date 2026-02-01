Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17FE81DF751
	for <bpf@vger.kernel.org>; Sun,  1 Feb 2026 22:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769984876; cv=none; b=omFhC+ZGTGiiEkq0PkEebpx25IA7kMsRlsv+qk+czs5gCYEI4J21doEljg3qffAeFqh3YzV+DBaGfwQmkNNhuG5hxJ/QOP1+wQ5RWkIfoIglAk/1VCeGb81FJOT9uAqWzJgfbGSOW7gfJI7hJbuWM36BBN2fn8qaTLDJUEdtq4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769984876; c=relaxed/simple;
	bh=uJhyolSrtatUAw+mRvmMrPYyuUryi2DApKK8xUiXypo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P+LN/+3GuN8rEyRTkCYy3ukhVY3jFL50qwxPjpdgZNLQGUbNW6I1fYy8GB8BfNig902xY3HOvHOf1G3hDmxodvPb+R3BgoWp/wTh2JsFPDnHphvSR3u2W+PF583BgWdYK+slDD6SQ2XUJEtFq/qwrL7pg0Sn6Y4TUSdolh6k9k0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=HoawHfqy; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="HoawHfqy"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-81ed3e6b8e3so1969600b3a.2
        for <bpf@vger.kernel.org>; Sun, 01 Feb 2026 14:27:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1769984874; x=1770589674; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GhOlhcxP38dJ2XGmh4H+Vv+ro6H1PQ0GligsQ8SN3e8=;
        b=HoawHfqym+XoPz4KshhIXbvSkyyze2SYPzUYtb9t4QYDS0N5gjgyS7+mv3VmP6XfUp
         5XsRt5y6U6hIsd+PD0EAGo0XnvvKbK9pmx9p8pG7UOkcl0QRb/2O+BgQPGBkoCySRNlu
         XTYHelGjULmFSYc88Sfm7u+kOLl1FGpjtClT2uUHoPYavX22YAUdtEnOxpUtjvpfhMnV
         lknugjm/B+dW5I1R5tFBJJ+/2E+fPm3LpUbXsbodFpAX3GXiCFHb6+tWLX1Db/e9OAlQ
         WabCOR0NvbzBxpskDC0idOXTHFYCZC4vJzWHMCj7/wulPsbmmnFbvY9qvHekqbaFCzz0
         M1ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769984874; x=1770589674;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GhOlhcxP38dJ2XGmh4H+Vv+ro6H1PQ0GligsQ8SN3e8=;
        b=jEw7o2zdRqJzDJ0CxZe/dX+E5ttOpq1/J3Jl+6e6USFzsjjQ9ZYLWzVjgDRMAOwgl7
         RkRqdnkvR4As6mM/PFWlGiiB7TP4xAQ79ZxOv7OtGZl/7d9mIpB6rjXQSAkP+4p15VpQ
         COOvh6zJp6j6aim7ZCAJ0RVucOGpUGVlqrkb8WkJ/uQKd5TgevYy6sdEMi4qN5gD/FNN
         C2XKB5uGiNKA67vCcPF6UoAycPcI9L3QtubdoFmudsC3Q/e0pjPpjl+TizK9735zF75X
         O+F3F/kIFSSegepIwvKSSScoLT7eQncMRTUZDh5DgrM54rkO9wRbkUSV9pRiTkX3fzIt
         tvQA==
X-Forwarded-Encrypted: i=1; AJvYcCVeX/uJ5WWGWcl1knilBso7uj+3+kIHmb5ZjG9VQ4RikfKZNivBg32su8f1jHSc6fLNFU8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQGqVa2nxMPuNVgGPeZe2hQ2+dBJzNvgc3it2AfFaJT06o1hVn
	yi/hxm3M1r4+/EeVOD3slGFHgbLOIP1QZPl4+fEE5nUx3HDK25J3FneZyNhLgu5CGAU=
X-Gm-Gg: AZuq6aKSiWNzIhyuvAODpMbqGpc/pQ9gA4FyO3X9VYlsv12d9pvqPPlekuTJlTSwCS1
	HGbCkRnteq3wqEqQfq8nrECD5IyTkH3IiopFxZ1W23cWy1RKnVqZl/ts4U2g7tEvRp5KEX0xwqB
	DwC95SHChq6s2gqaePnWyRgNHT9xoFj10xMyD9iHd+8whZVyItANdPfN+uXF12WGT9CCOW/Jcwq
	mTzARoBt4lc0bKGfDZZOSxOvYVN4e/YAzHBF4bVKpJKQmF7NM98X71dJj2YrXBLuHkMpJUN9VLy
	CwGU+HpktksmVS/T6yPdIhT9SV+PupIX9EWKhdPiirbVbfsBwOTfQI5DoMv348jgUBMBtxuNbLH
	cvXSN4qLmxM0NE/ts3HmVW3ZrDGUVy8DCDot7gk0/m8NWDqyrjpHZ4Sg+deMPXNTUJzXhviPdEI
	jdxwnfVA7DbiuxqAmzHuogMQ+5Jzrk13TOlMrkipuxU8mIpf11oXhtde+oIxv53WPJXQSCJkrBY
	nPdiJKvuduprnN4sg==
X-Received: by 2002:a05:6a00:438b:b0:823:1580:790e with SMTP id d2e1a72fcca58-823ab86cff2mr8898074b3a.56.1769984874525;
        Sun, 01 Feb 2026 14:27:54 -0800 (PST)
Received: from [192.168.100.174] (p94025-ipoefx.ipoe.ocn.ne.jp. [153.246.129.24])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82379b1bc68sm13786528b3a.2.2026.02.01.14.27.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Feb 2026 14:27:53 -0800 (PST)
Message-ID: <7ef5474a-f5d6-4afd-995d-16ecbfe00fa3@davidwei.uk>
Date: Mon, 2 Feb 2026 07:27:48 +0900
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v8 11/16] netkit: Implement rtnl_link_ops->alloc
 and ndo_queue_create
To: Jakub Kicinski <kuba@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, davem@davemloft.net,
 razor@blackwall.org, pabeni@redhat.com, willemb@google.com, sdf@fomichev.me,
 john.fastabend@gmail.com, martin.lau@kernel.org, jordan@jrife.io,
 maciej.fijalkowski@intel.com, magnus.karlsson@intel.com, toke@redhat.com,
 yangzhenze@bytedance.com, wangdongdong.6@bytedance.com
References: <20260129222830.439687-1-daniel@iogearbox.net>
 <20260129222830.439687-12-daniel@iogearbox.net>
 <20260131161903.064b5cb2@kernel.org>
Content-Language: en-US
From: David Wei <dw@davidwei.uk>
In-Reply-To: <20260131161903.064b5cb2@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2026-02-01 09:19, Jakub Kicinski wrote:
> On Thu, 29 Jan 2026 23:28:25 +0100 Daniel Borkmann wrote:
>> +	if (netif_running(dev))
>> +		netif_carrier_off(dev);
>> +	err = netif_set_real_num_rx_queues(dev, rxq_count_new);
>> +	if (netif_running(dev))
>> +		netif_carrier_on(dev);
> 
> Why do we need to flap the carrier?
> (If there's a reason perhaps add a comment?)

I saw veth doing this in veth_set_channels(): off, set num rx queues,
then on. But it doesn't sound like there's actually a need? I'll test
without this and remove it if everything works.
