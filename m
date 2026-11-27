Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795770409;
	b=ovFt7pq+dEzPirFjPkYq6a+MDGSvKX3kbkl11jDq/T8+GdK3lxOEqy6mlt96+DtZXrXB
	 KdEMd57ZslfRxP4rFkolFU//xbY63qLqCzJBM/Yhrj4Hj21qNt2BZw95QayeuG3PdW+o9
	 fjytheJqLcgDGmDqq1xF3KvU5oJZxxKP5j2SHZFJ9K/llA2sdZddyQLB3HKSD4HQOs1hD
	 zrLJhrEtN5mxqj0XQls+b4SJjMPtqRXLDqQjUrLq6PaPHQo4W4hjjV8nBVR2AMENHOtRE
	 bkJqCiMb5HDFzbc/Hxd3NvEojTltLUJkyKu9zxdYMFRA6k6R9yRPNoDyDPwpq2wqtHQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795770409;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=5Op3vOLsjKgKLwppbHhkyMexS0KfO9oK7zPyIsv6o1U=;
	b=hslSfHhfqB4jzWesliYjm0Kvl5jvvQIR+oPvzIn31z1nJKPWQoQ97/e0bypQXQWxFzLB
	 HvcWk338Po7Xzk1TTt5XsiGaQFCCHFQBuCEJTbLHEccHUka/PxwpO2iPBEWfFIDULbFNQ
	 NYCmh+Ugs24LY603ueK0Dbz00s2W0wJIweM7Oz3xaQBM9VEHa7L5DiQcBEm3GA748D4ec
	 eW+bqeEtWbAzo1v4833WmBgxwP+PETbF/85Ko/yAwT5Q9GU7oaQlpYcy/CDToG5vEXUWy
	 IvTQ9n/epx8mkqI4TqKXKsCz13580M0Td/6t7g5ibhcZgTCciTDRdfyU9GLoTD4tPqg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=h7ORWMSv;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b="P2a/4hPA";
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C5F5606A31E
	for <bpf@vger.kernel.org>; Fri, 27 Nov 2026 09:06:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6C5F5606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=h7ORWMSv;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=P2a/4hPA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795770407;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5Op3vOLsjKgKLwppbHhkyMexS0KfO9oK7zPyIsv6o1U=;
	b=h7ORWMSvCFC6SDcKqHajOhoHRyLuGVqFBNIAn8ctPa35QRMB5Y/UnepLOSQb6kNTz2It0S
	xkD6XrvP2NOMq0n5tpb92qcR4AchMnGH1dlt6CkRoY+1+jfNq18gX8S0FoNGvDleSw2Nqx
	AnfzleTcX8Tvca0S+IwB32avnyl5J4M=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-694-5LxDAGl-OTeyiNKAfLUcyw-1; Fri, 27 Nov 2026 09:06:44 +0000
X-MC-Unique: 5LxDAGl-OTeyiNKAfLUcyw-1
X-Mimecast-MFC-AGG-ID: 5LxDAGl-OTeyiNKAfLUcyw_1795770402
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4bb6517ed8bso10691875e9.0
        for <bpf@vger.kernel.org>; Fri, 27 Nov 2026 01:06:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1795770402; x=1796375202; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5Op3vOLsjKgKLwppbHhkyMexS0KfO9oK7zPyIsv6o1U=;
        b=P2a/4hPArznaeL1QN2djlM8KPNYI6xK5Rlov60+LpdGbIJ4fjSxmV7wVTz+MvzyVBP
         UDOlna83PfbDVyLR+5c62mZX7ZN5U2FexCV7ZoofVAcLamiGtCiaeLlzyr7LK8v4/1Tl
         28tIt4R6z8RJzoIIfOg+kAy52oqP4GWFhiDCmLpfg0sHgSco78xczzP/USUuBDFcOYQw
         iLaj+WGdyRjkxTL3SBQAv4N36vDcIIKgEkeqCpSgcaColQBfAVYIyaQ45MdkqBppsM+o
         iDbtC6YExJoscqG+lLpMkb4mec5Gda5EtVq+B1T6q7K2BeLPSPtb4rbu8xYsRogixXO1
         kdVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795770402; x=1796375202;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5Op3vOLsjKgKLwppbHhkyMexS0KfO9oK7zPyIsv6o1U=;
        b=MMwSs/B01+xieeuqbBD2sfTx5VKolor3ZBBeS2v2/gtD5M9eooiiu/FBjebi72K/IC
         gxYnss1t+54GdKbWlAR7EHr5QoGlEzh2kHd/ZJw9u50yQZqgDgTFPqxHSQb36m/b4bbA
         96TvA2FLqU7O0/CdLXp1hVDC2naCtgTha6E7ECoKQUWIxY3U9b738m+oMpcHoq234hfU
         h/yvCAnppfkpbSSkwsRt5zz0gq2//0kgy4ZccoH+ILoY6J2phHbS9Z86F87UiW0045rV
         ZT//KdKyv9vM6+JMJMP/Tw1u0AvBDO8pbfz+WzPU4G/1m14Cjwf/9dRLaige0VfSIu6A
         kU2A==
X-Forwarded-Encrypted: i=1; AL+hErG3cpgzW5tXuKP0WM9MsDAvR7WIdttioniChows6zPSWoypjDfF4ZyAHQ0Y9AgV5ewsrMM=@vger.kernel.org
X-Gm-Message-State: APuU4Z8Q0Z9eg6XQnVP6bvpTnYb9ae0z6Xan3ZCNkj34fA0aTPDDvMXT
	IdBhv7V82QNSmIm6an/otKPffcGNsOxVX31wKiS5o9tS/JHckIKs5mjNoLdY4KDhSKv+m9Hhp1P
	GjkUCd3DHqCtDiZxb98ylhjp/FTKwkhZCI1FO+REVsjty6vnNByHxEQ==
X-Gm-Gg: AZFdTZeo7N8hnfi59DF2/jPJqX1ZSwTF+PVGcmUYQZEBBrt6xyak4JTOZcgNZACJgh9
	xQlU9plh92pqIzz8oyOTwTPRDM31L1b2Yec+KT111+h5LL5PRQbY91I6+zAl3b6QiQDcmmOjMzY
	E+0kVyKblYAspPF+PCjxVQ43M62HG0IdXLUBn6jhsSDDr9dtdZToo+mAZ+DSST0q/4qWTahpCNS
	8sun7+XxtRlMxx6P05/PyoL81jLsm8R+OGBAYGxAshUdHKOFhygCe9McIwaf8iaXQREJdkUGPvi
	1E0jyPk55I5rfj+9rXzBlhdQRrYwukAv+iyGgxAF2Dfa4ivQLKmyTUmoxz3ykdkmTgKgZggcXwt
	T5QK5WC244CYKgANPi2kIylw23AmX12vd048Eex2Q/rs1AcafAZQkPeuAKGc/NNhq6EfSYdXuFu
	QyV0EJNix86FRjBwqCQxysBv01yIBzLn9JVjIDq1/rT+o5
X-Received: by 2002:a05:600c:3b84:b0:4bb:6f45:2a6d with SMTP id 5b1f17b1804b1-4bb888074bbmr575646685e9.12.1795770402012;
        Fri, 27 Nov 2026 01:06:42 -0800 (PST)
X-Received: by 2002:a05:600c:3b84:b0:4bb:6f45:2a6d with SMTP id 5b1f17b1804b1-4bb888074bbmr575645345e9.12.1795770400957;
        Fri, 27 Nov 2026 01:06:40 -0800 (PST)
Received: from [192.168.88.30] (ip231-128-192-82.pool-bba.aruba.it. [82.192.128.231])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb85399d52sm648727075e9.6.2026.11.27.01.06.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Nov 2026 01:06:40 -0800 (PST)
Message-ID: <d7c589fd-0faa-4f48-817e-66efee73185c@redhat.com>
Date: Fri, 27 Nov 2026 10:06:39 +0100
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: lan966x: return an error for XDP frames that are
 not queued
To: Daniel Machon <daniel.machon@microchip.com>,
 Horatiu Vultur <horatiu.vultur@microchip.com>, UNGLinuxDriver@microchip.com,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org
References: <20261123-lan966x-xdp-xmit-errors-v1-1-f25b6661167d@microchip.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20261123-lan966x-xdp-xmit-errors-v1-1-f25b6661167d@microchip.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/23/26 15:54, Daniel Machon wrote:
> lan966x_xdp_xmit() counts a frame as transmitted when
> lan966x_fdma_xmit_xdpf() returns 0, and its caller only returns the
> frames that were not counted.
> 
> Before this patch, lan966x_fdma_xmit_xdpf() returns NETDEV_TX_OK, which
> is 0, when an xdp_frame has less headroom than the IFH or when its DMA
> mapping fails, without queueing the frame. The frame is then counted as
> transmitted and never freed. An xdp_frame can have less headroom than
> the IFH when an XDP program grows the head of a frame with
> bpf_xdp_adjust_head() before redirecting it to a lan966x port.
> 
> Return -EINVAL and -ENOMEM in these cases, so that lan966x_xdp_xmit()
> stops and the frames that were not queued are returned to the caller.
> 
> Found by an AI code review agent. Reproduced on a lan9668 board with an
> XDP program that grows the head of each frame and redirects it to
> another lan966x port. With the fix the frames are returned to the
> caller.
> 
> Fixes: a825b611c7c1 ("net: lan966x: Add support for XDP_REDIRECT")
> Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
It's not clear to me if the issue addressed here is stats miscount
(should target net-next) or deterministic memory leak per packet.

Could you please clarify?

Thanks!

Paolo

