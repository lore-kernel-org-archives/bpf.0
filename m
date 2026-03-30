Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CC6B2ED16D
	for <bpf@vger.kernel.org>; Mon, 30 Mar 2026 18:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774894540; cv=none; b=Y1zjaF15DqwWNPL1CachWRkjjTK7u6NId4QsKQNzzBP0Wz3GEBOOJ0zJBKXM4hCEdnSF7hEs/nctbju/VB2IBkFIvinjewWJc7HiSWvPVasOirGNxB3XIKiTiKaIHhcZn4toVsVfef3t9cht2A8xXM8wSLa6xAf/A5JOj6iHmCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774894540; c=relaxed/simple;
	bh=2Wmykm9TEFQ6qJqutwx5G/WM3MIPHdk0eyShmReCWl0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aAQIN0KAxsUrcXIhwuzcREfiixjOARh1zyPzyOTThCQPsZe/caj//gYqbxezL9dvz2QYvOQ1Zd/hHrJFszEF5azx4awa8JzvftIy8uchLIT6oKDdyGXNBfcVwPZcmj+vyQ+123xwYgVETVyLEzEBrTKV+HA9OkmltZjtEhawqpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o3VGP6PA; arc=none smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o3VGP6PA"
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-12a71ade78cso5651610c88.0
        for <bpf@vger.kernel.org>; Mon, 30 Mar 2026 11:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774894538; x=1775499338; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B3FCFfolEnP72cZRGyyoWzCdd0oZhy94NWlfVfZ54PQ=;
        b=o3VGP6PAtkMFocHSb0NQ9Vz3JEJ4Um3CZPorVo2enIDFF6JnS7UEPbHM424gXx/Hbw
         u7jgpdf1aFlk08kJ13SByjUe9khZXlsyutYOPiGHj2QqpzZXfTYDMqJiEHp2L4r/ECht
         D2OQMqJ+y+XD+tHen1EXLD5JttWWxN4FWOGoggEVd+nzPwQmysbofKq8Rm/Hv7rBuFDT
         myVjG7mwwCTvkuiLiONvdJRPuyo4aMJrSekL21RK9jRf5CChcnIMafJKqpx9RN3J9KfD
         5OkeRxOrDQ2ByLCGi0ykcdJhYCk2wOrJajH24n68m6DSUH+y7aBxCVLlWbi5mLhDimbS
         ChtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774894538; x=1775499338;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B3FCFfolEnP72cZRGyyoWzCdd0oZhy94NWlfVfZ54PQ=;
        b=EDNdYDC0KNS1yFdq/N3ARREUblBCTbYVVjWBkxOzQsGoXQAM4lCRiP+aX3iR3W9Ytf
         IOL0QEpdKEjvkBkhDYYL6LmZsieOoH+CpGC895N3kThqhh296j955eDfHVMNrX/fg8k1
         xbzS5rrCZvxG39hPGRk3HgtEEPoxH1JcyQw+w4NmegpW0tnaMwibOOofJmSiBJKkIgEi
         pWRW7AHqFy5gb/opoCEbdfYjnka/DyiAopKixOOJ61e7KKvnFykqrgxNFbxv9Gv+et/e
         U7ujZOvwkVyj91vbrJhyeK+wXNFdmu9bdPRL6Sfjh+2VJEfOXWeF6SO2zpOXkM7zt2bh
         J6jw==
X-Forwarded-Encrypted: i=1; AJvYcCX8M9cWjPwqsR8eEE6TrZuJ3TYhB7AfCNTtFexPUwh6hnKpa901RMPeq14fiIIACLlZka4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxL4JjOxBeUxeuLxTW/1V6fwXSTbVXl4XrI3LLinlCxbhwAvZjn
	5JayBaOrGgvr+GR0L6duin3NUcMpiwAst50wy7ZgH4IcQFBvEuTcEq1z
X-Gm-Gg: ATEYQzzc0qcrhRYzFhGXPSnPORVh9TKuvK1r8+x7Q2PuOAfDEw9jQB1OizXipLZmlMU
	4fvoMIgPwNtlF/gNv0K9d8FsfAY4guP9CZQpFKOHL5WlFKnEUQt+mmI0DArWQbmtW/IJPFcRtzA
	EHY3vvMewDpzSsbu5APIz6TpfI9BdiTVoWKyNrPvzzHWsBp8LQniBaR0m8bNsHwMMdBXYN+FXi3
	xBcDd2EKO1lKbjEf8Pq/+nUHfwArN1RzgSLiu4qjqWom9fljEaBBnKea2zv70kVGrv/ssr4hBEk
	+n3bDUTnDVSEgmfTCZ453IAxdBSFnFSK19G0Y4fOfMCqGwRBJCpDm+yjUXZ12+AnaM+77q7jQY4
	4xEMT+afJRHfnpdpbB+AINvdH6DZLToh6m0zGGPKTE0+xYHkH3T21SJF42iglvqHXZW5vkSR6H/
	JkO84Gga74FVceqpl7Myu1ia3jmHNPhiISOOoyeL5CLU6q0iFid7gSSA47oG77Bus3VX5BBHcHC
	/vHU1vqz6NN
X-Received: by 2002:a05:693c:3005:b0:2c0:ba91:48b6 with SMTP id 5a478bee46e88-2c185f3295emr7416238eec.26.1774894538329;
        Mon, 30 Mar 2026 11:15:38 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1151:15:c56:221b:35d5:85f? ([2620:10d:c090:500::1:79e])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c3c3bd9894sm7758362eec.4.2026.03.30.11.15.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Mar 2026 11:15:38 -0700 (PDT)
Message-ID: <1d551008-3c42-4b7b-9507-03072740a54a@gmail.com>
Date: Mon, 30 Mar 2026 11:15:36 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 3/6] net: bcmgenet: add basic XDP support
 (PASS/DROP)
To: Nicolai Buchwitz <nb@tipi-net.de>, netdev@vger.kernel.org
Cc: Doug Berger <opendmb@gmail.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org
References: <20260319115402.353509-1-nb@tipi-net.de>
 <20260319115402.353509-4-nb@tipi-net.de>
Content-Language: en-US
From: Mohsin Bashir <mohsin.bashr@gmail.com>
In-Reply-To: <20260319115402.353509-4-nb@tipi-net.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



> +static int bcmgenet_xdp_setup(struct net_device *dev,
> +			      struct netdev_bpf *xdp)
> +{
> +	struct bcmgenet_priv *priv = netdev_priv(dev);
> +	struct bpf_prog *old_prog;
> +	struct bpf_prog *prog = xdp->prog;
> +
> +	if (prog && dev->mtu > PAGE_SIZE - GENET_RX_HEADROOM -
> +	    SKB_DATA_ALIGN(sizeof(struct skb_shared_info))) {
> +		NL_SET_ERR_MSG_MOD(xdp->extack,
> +				   "MTU too large for single-page XDP buffer");
> +		return -EOPNOTSUPP;
> +	}

The MTU check here is great. But I do not see support for 
.ndo_change_mtu. This would allow users to change MTU size AFTER the 
program is attached.
