Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 475773446AF
	for <bpf@vger.kernel.org>; Wed, 11 Feb 2026 08:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770799859; cv=none; b=VSgMZy39kaG2siAOqCx9//hnaDSPzvNL8/IJlZXsVVUuE8FCP+/0XZFZAicC2YPAQJo5vZSyCJpAvV4q1OROrhXXVeNMXSSDHBTXH7Z7vUHox+bEjQC5xfSOjCQ4+q+zvGZ5yaw8ZXPelsG+za+HD6GSvVndK8FEkeqy+H//HgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770799859; c=relaxed/simple;
	bh=E7dZn11UnsXXsFzX/ltgj6TrTuL6RFRnhzRJQUZKAYc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tCHcZ1fODJtQrRUfgMnLEOXPDSiRKPHHhp/vaSqJistwpXXyIkewtAGxlj5Cs0OA1dGQbf7OeXHfc6SPE5asRAnaCVHfA1EKwbqoSnqmq6XCe38pkAAVKVJq2eHA6lVXI+Le9Zt6BgEuq364ZAmAN5LRTOLnVuTC/D9PaMUznWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XSvWN7LW; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=BFOVYaPG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XSvWN7LW";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="BFOVYaPG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770799857;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N+yV3LiHwvo0TdX0nZb4kx1fDWzSnhxc2PkisRPoz5g=;
	b=XSvWN7LWWHNMR9UOacabTWew+fKduAS5zlTZ95Bj2WnzdenlQmzKMAAbUkfrD4wFUZyWXc
	gLjw9jVqrD8AfrmPIuU0NmZJhqtcJ5QMkM/QbIVQ3SDzRyUvJphMUe5oeHxmRgY9QhLGx5
	liYduxVeB8tH3Hwil7RDaW8eiyUwV+w=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-272-r6TrOFm3P8iZt4G-y_IG3Q-1; Wed, 11 Feb 2026 03:50:55 -0500
X-MC-Unique: r6TrOFm3P8iZt4G-y_IG3Q-1
X-Mimecast-MFC-AGG-ID: r6TrOFm3P8iZt4G-y_IG3Q_1770799854
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-4358f90fe8dso435206f8f.0
        for <bpf@vger.kernel.org>; Wed, 11 Feb 2026 00:50:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1770799854; x=1771404654; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=N+yV3LiHwvo0TdX0nZb4kx1fDWzSnhxc2PkisRPoz5g=;
        b=BFOVYaPGOj1wg83jwlQDQAbjj8N39QHrRcjpI9Vmp7pXPTZw36TJDRcySQ4Zutslg3
         0LYmVnpWqX8YpKrI5o4mpXS5WT7h5ITMmGB09d3UuvEhCWK9z5qp3lB12auTJcHcOpxW
         L63gxOZ15LHpGTFhxZKeyCucbbOWtqJwXe8jFatQxsBAzcbm1C67r0tjuFHj8JR30Kvm
         SA8jeXUnVC9u9vjaPbo581odpTNTNdTLAVCzL2kR32POudrYNw1QgbVl069VzpuV6pO8
         /v/Zk6kdDK5+0K6fJYRC3idCFUIbwoqD9+5YfGdFGS0IgcZJAXUdcK2H0/GGr/EoM+vC
         ceIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770799854; x=1771404654;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N+yV3LiHwvo0TdX0nZb4kx1fDWzSnhxc2PkisRPoz5g=;
        b=RkeCvn7VkApjqjBpSG2W5c7ibbh5K+Rmsv3b8STxcDWjjm4u09WDu/Ie/MvOPqwfKN
         z1agO8Kw7QLLd5HN25VGmA8b63fRSSmqUXxJuW3DT7nKK96BowMj9fH5eH9WsOzD0/1N
         inHhOKeXZdBf+5P/Gw2G1XCihmjmPeQ/MFRhO8alAR29MkI1nILbxDbOK5CspJ5q+AVH
         kGOGnqtRwTJSa+a1fpcWvFm/gvpgdUCiTtYYdl1MLj6hrLjWaLxW3n7rDwOADNGTHaaz
         hoWRMp+Fl/OxlmKQH7LKrr5tH7krchPcrEsW6xdiSRJ1wwpfRFJ0bCosY7tQDENG3WK7
         Q+bQ==
X-Gm-Message-State: AOJu0YzetCWP6L97jnk90jHmozbvlT05I1QijpvsKFluYaH5RMSKxkXt
	vBB/GmS4HbyEy3X98/BTqNC8OHjoU/HAk/zeMEtkCiU20ZFSIMhsK4ceZ8bDTTHmqYZozszYFQz
	rt6h7HiqJwg8ADfksgD4HPbTvVkEOjCTua78Z6C7iYUBLnN3Uuxgczg==
X-Gm-Gg: AZuq6aJMn7OT4gUdjQK8V3QTAj0XGTLEY5iLjkKNbOz9+S0VKNgbfCU5rdDVB9mZjDP
	4G9icKV7imrMqSkOsl0DB1jTTD0NuJwBSPakglFqZbvcpQuCIsZo2Sc+Fn3OD0z930jh0oJvIPS
	lMBdYPZbxIVb+IoU2dHxVpZO5qwd+tpa2ruYvLXB3gea/jLrMLBDiXUIlaG+W+njFJpwdDMs5Q4
	Vt+uaM4m7LyVcHJWjruOa707M6umHdOOubAF8xuSCYNuPfUAl0DIr/2DGS/BRb5jj3ml5aHbMdl
	Kr9HAS+7l8d7GHyrhh9nXJqrjC65+9SvanAGkQb6G2FoDiBNkjs0qlbOSMX99zQZB7y6LxMvC09
	7BXy2smqNfb0UEkU5IIXfIHIK8A==
X-Received: by 2002:a05:6000:40e1:b0:430:fdc8:8bd6 with SMTP id ffacd0b85a97d-4377a20004dmr8338966f8f.31.1770799854195;
        Wed, 11 Feb 2026 00:50:54 -0800 (PST)
X-Received: by 2002:a05:6000:40e1:b0:430:fdc8:8bd6 with SMTP id ffacd0b85a97d-4377a20004dmr8338919f8f.31.1770799853750;
        Wed, 11 Feb 2026 00:50:53 -0800 (PST)
Received: from [192.168.88.32] ([212.105.155.220])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43783dfc8b9sm2993554f8f.24.2026.02.11.00.50.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Feb 2026 00:50:53 -0800 (PST)
Message-ID: <36d9d3f0-2a26-4b9c-b6b6-f50610fbaa31@redhat.com>
Date: Wed, 11 Feb 2026 09:50:51 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 1/6] net: sched: introduce qdisc-specific drop
 reason tracing
To: Jesper Dangaard Brouer <hawk@kernel.org>, netdev@vger.kernel.org,
 Eric Dumazet <eric.dumazet@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?=
 <toke@toke.dk>
Cc: bpf@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, horms@kernel.org,
 jiri@resnulli.us, edumazet@google.com, xiyou.wangcong@gmail.com,
 jhs@mojatatu.com, atenart@redhat.com, carges@cloudflare.com,
 kernel-team@cloudflare.com
References: <177039500964.2258217.2989656069254156812.stgit@firesoul>
 <177039506239.2258217.7863252279149995024.stgit@firesoul>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <177039506239.2258217.7863252279149995024.stgit@firesoul>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/6/26 5:24 PM, Jesper Dangaard Brouer wrote:
> Create new enum qdisc_drop_reason and trace_qdisc_drop tracepoint
> for qdisc layer drop diagnostics with direct qdisc context visibility.
> 
> The new tracepoint includes qdisc handle, parent, kind (name), and
> device information. Existing SKB_DROP_REASON_QDISC_DROP is retained
> for backwards compatibility via kfree_skb_reason().
> 
> Convert FQ, FQ_CoDel, CoDel, SFB, and pfifo_fast to use the new
> infrastructure.
> 
> Reported-by: syzbot+ci335f183b8446659a@syzkaller.appspotmail.com
> Signed-off-by: Jesper Dangaard Brouer <hawk@kernel.org>
> ---
>  include/net/dropreason-core.h  |   42 ++----------------
>  include/net/dropreason-qdisc.h |   95 ++++++++++++++++++++++++++++++++++++++++

I think it would be useful to add dropreason-qdisc.h to the net/sched
maintainer's entry.

/P

