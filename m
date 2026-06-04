Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AC053E0083
	for <bpf@vger.kernel.org>; Thu,  4 Jun 2026 08:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780561299; cv=none; b=q8aX/YM3OSjngR3W/my6Ae1tCS+RQHo4dDGOvTacwq7Kjad+DHSTcASNGSuKVnUd3ZPWhRKe+x7/YX7wn/P078Vi2V6TXQp1LN2VHsFHuyn7NpIKG23dXYDSDl1cpfDaS1OUROe/GO1TrASuLZsOdBeStDJyQA9eZZamYO2Iz8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780561299; c=relaxed/simple;
	bh=lyLEVoSy7cPnWoRIV7vp/WX8YuoCgz/kRZmaoRluvWo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HKIqtPIbAUGh60XLJj8wT1d+68R1ANlJ1MQuvoFNyBrS1BSXe4bkUQcSu7nUYftZxQz5UWBR6MVjM/+sCVKwENpyQ4LVHNagdPuNaDvvarf+eTGYR0bVcNmO9a+/XcAlrjIInWYQPk/F9aY2Ei5KsgfzZSxznlnUztDJqGHacIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L94Y2lTo; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=jvWL7RcE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L94Y2lTo";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="jvWL7RcE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780561297;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PZcGJsSal8T9WZ+z65zYJjCayJlSk9Z139NGTW50LAo=;
	b=L94Y2lToiCSBUHxM7S9WIHylRe0091gssOVC8wR+IqR04/EsT39dYlhd6MN0+7CM5p1mVu
	cUMrrBevHPC37vrcqtqM1CbefZJwlMWiCiCmi8D1ni9MRx3YWw7ADj4OYy59rkVfTvggrS
	Fw2mSlZbj9azhlduHYe0LoVZeCvnStc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-550-75o7uYQYOeaETqmH1fUHdA-1; Thu, 04 Jun 2026 04:21:35 -0400
X-MC-Unique: 75o7uYQYOeaETqmH1fUHdA-1
X-Mimecast-MFC-AGG-ID: 75o7uYQYOeaETqmH1fUHdA_1780561295
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-490b4d3d3e6so3458455e9.0
        for <bpf@vger.kernel.org>; Thu, 04 Jun 2026 01:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1780561294; x=1781166094; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PZcGJsSal8T9WZ+z65zYJjCayJlSk9Z139NGTW50LAo=;
        b=jvWL7RcEriPW5qVy4EQR6lHkaWf5KtsOvEx3oq3oRtGGRFs8iwLMUfSim9kY2X8JbL
         tTqfpOO53ODwTXunCP2z4lyshNq4nw3fhOsA7ilaPg45S6eyvTadXF1nVgJAEI4euqyf
         14qm33ya7hvTq2/uquE0WQurOwGGdm1CuPhANZnBAtScOTLSdKiN6PB8OXxV28h60z46
         xbyBZeVEMjCKV3GGpbyod61YtzgRWgJf1A2EMsj1/VEtshJRTl+g7Twnx/d24yALgIp4
         W3S27xuXdC6cOJqEx7xcoVs4nxqWzPdHrPRJHBgREUu+X2+p8Rcw1HU2gB+u1GJk6a21
         2WjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780561294; x=1781166094;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PZcGJsSal8T9WZ+z65zYJjCayJlSk9Z139NGTW50LAo=;
        b=jOHGl8lhZSaA3u+bcc/MPGKJok//6LruYOA+wZvJp9QbfegdNpMfT/+NMjlFzhyuMH
         WtL7bfbQHFc7sJWZ3DYaLXwbub/Dw/1JbZAKM2dAl5IV8YK/XsXDJh3Q8Cf8NIBRJe6+
         typwtM6dDbYnB8XHcXhyhc+9Cuo1RpLXYyyDyUmTDeTmuyKhicbWfkLptKmBLWfQtphu
         iY3J646ETNQZTIMcR0p+gLl9NNhU9COeyaYdDfmcYZWsjD+N4JPJ0kUbuB4ILgYEPn3h
         nbqRo/nqW3dTDL787oDLymQZkqsLx+q1rd6wtIC9WbZCxel+AGYLInC6sJToI6w63MKj
         7LTg==
X-Forwarded-Encrypted: i=1; AFNElJ8f5THfEIbprV9zlabrjTBpNYR9B1XAEgQldksGuu1fYi2Llc+nIWkPgzETxZRVisGicHg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJnjkRlIyh5XlF7R6DWh11O8K2u+qqsViK3ELK9OiWhi75F+vg
	YTYj88vmNg2oKCM/Ns33GEfArpVLmU0glIB0ECSD+J0GW8wlSwR7tmGxsz3bk/HXOq5qsRyB03e
	zBVFcu7uSJAF92yXtgIX3UuPgmLNcASbNiWvfyfjx/KdXZE/zytuNig==
X-Gm-Gg: Acq92OEJ7UieQDMMs+xslyRYxlqiPGplCDPCN89B64AYJjS4cXSsil3ISEHOQWUdLqK
	6RehH+5pfI960JctbDASpZp7AtRErEASq7C7cnd1fsc/VhCyqbDbrYGD3XQfMZRyjxT44mV0aZj
	URcB4+i37NjtT6gLFrMigz3SKjFxdnaUmPmOAwokHprtJREKcRuWdyvh1NV7C/Isu9pa5uH7lpb
	TUDcdWfKN3BkdjLNrI8ShGt9yHYxUK8V5Vnzeix7huSeLAqeMAjyJL6KZB9SStVGY3CmmiAPENG
	LLyXY4XsMTKAMCMLudn+XWwDtEzhUlBqtsMoeXPDEeEnPvpTVAgICb3DLJ8sUK/8Vwm1RUcRO2c
	jegnlvostk9GVVu6gynZ2VC1JtkC/GQ0EVi6+EQ15gK11j/TTAnMxyBHYDZzPXCnUPZ8=
X-Received: by 2002:a05:600c:1f96:b0:490:53d3:47a9 with SMTP id 5b1f17b1804b1-490b5e7962dmr106047585e9.3.1780561294463;
        Thu, 04 Jun 2026 01:21:34 -0700 (PDT)
X-Received: by 2002:a05:600c:1f96:b0:490:53d3:47a9 with SMTP id 5b1f17b1804b1-490b5e7962dmr106047165e9.3.1780561294130;
        Thu, 04 Jun 2026 01:21:34 -0700 (PDT)
Received: from [192.168.88.32] ([212.105.155.59])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f34413csm14143945f8f.21.2026.06.04.01.21.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jun 2026 01:21:33 -0700 (PDT)
Message-ID: <3dd59d38-5d16-4632-ae4c-0416c70f5a17@redhat.com>
Date: Thu, 4 Jun 2026 10:21:32 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 5/5] veth: time-based BQL completion
 coalescing via ethtool tx-usecs
To: hawk@kernel.org, netdev@vger.kernel.org
Cc: Simon Schippers <simon.schippers@tu-dortmund.de>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org
References: <20260527135418.1166665-1-hawk@kernel.org>
 <20260527135418.1166665-6-hawk@kernel.org>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260527135418.1166665-6-hawk@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/27/26 3:54 PM, hawk@kernel.org wrote:
> +static int veth_set_coalesce(struct net_device *dev,
> +			     struct ethtool_coalesce *ec,
> +			     struct kernel_ethtool_coalesce *kernel_coal,
> +			     struct netlink_ext_ack *extack)
> +{
> +	struct veth_priv *priv = netdev_priv(dev);
> +
> +	priv->tx_coal_usecs = ec->tx_coalesce_usecs;
Sashiko noted _ONCE() annotation are needed here and for lockless reader
below.

/P

