Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795085385;
	b=nJIHikoqE9CtaZUsZb3D7OXCzhQSt48aLqULqim9q1ZnUT8BWh1In6gimPpr0uC91+aD
	 aDSTvJyHe5KdXImDWdC+8U1vlStQywKJD6jzdArrMpbp+OG5yjRZZohYJhtUC065NN3AJ
	 HB/6IkYL51uFKtPlWJLChBk7rZyyjW8cIQCVAR7negp5Ox32H3ssLG5BNltd7SYSrq1Zf
	 r5YWQpj7OjQgM0mc93svrOqXU1vo8nGG2/UqiOfyK8L/FV2D+fV6KH960iKGzhC8WL1qw
	 joDKdQbL7ns1G105k+MPEdj/AW2osaPV9FFKzimv1WFQGNtTgQyl2wHGD39IuwfPbAw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795085385;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=gWmNjMP+sg8RHRMSC21HnjHiZEQ4hcvMIRHCqkIXFzg=;
	b=Lc3VmpngejS6Q/eL+hTvmqWZNsqmDYQ19Fsynhw+2EAhzdvu4AzYI/ShIHeO5Z26lk5h
	 g2WA5HlWILN9gmzerugXV9a8jVHxqaMqat2DVVmAArQLbkgf8ygfcbSlAh9AMkimLXgiL
	 1AE6bbMMBifouoGHym0MUys5TCFifIC8bGnyhln8EzvK9O5yOjJ00NNGn/pn65IjvvNWP
	 absTzJdrsn8iOheXSFrFZimfgrwR/yAEksabcYploYiTv0GbimhuXgEyQpAfMu/FPFVOL
	 ZoOeegJs7T18eSXY9Z6kYmwFGBcCWdkXDNtdcT2lJg9/cSfjOrJZPJ1u4Ljj6RPHo8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=C+r7jmsF;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=qmnk73NJ;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12D07606A337
	for <bpf@vger.kernel.org>; Thu, 19 Nov 2026 10:49:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 12D07606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=C+r7jmsF;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=qmnk73NJ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795085384;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gWmNjMP+sg8RHRMSC21HnjHiZEQ4hcvMIRHCqkIXFzg=;
	b=C+r7jmsFs0bzS8CJJqQtx4EdLIRAB386tXEA4S+tZ4V3gy/Prw0VfpdQm800UmAVnR+K+h
	XKPcbgFd1SL6Z01SWMipKMAT31VRt2EO+IwR52nzUixXY9aTsXUaUFznGUeG10o4cPr/IH
	ZoE7Ge+0vwb+Y+YQLAJFZjSw1K1JOZ8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-190-93SLXT6fMBmpbN3AfBM5Ag-1; Thu, 19 Nov 2026 05:49:40 -0500
X-MC-Unique: 93SLXT6fMBmpbN3AfBM5Ag-1
X-Mimecast-MFC-AGG-ID: 93SLXT6fMBmpbN3AfBM5Ag_1795085380
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-4903fc8537aso1584578f8f.0
        for <bpf@vger.kernel.org>; Thu, 19 Nov 2026 02:49:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1795085379; x=1795690179; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gWmNjMP+sg8RHRMSC21HnjHiZEQ4hcvMIRHCqkIXFzg=;
        b=qmnk73NJf6DOljXpqtNoLk86T2PzOEnIK058W3W1xzhvZquEYIAHpITks+XchqOo7U
         mCmSg/1L6j/n86L1FFk6mHaUvD4VfNPyBgm5k4Ug+hkngyvs8Yhd+VpfND56l2i1Cbsz
         JAqFXr7bGfNjBch+jkUqTbQB+fIkvRTp15/4PJT/ThBAThYQz5vAZJfTEKy5XtQdv2w+
         FcsnsS5lkVJ2A/WvpXg4hZgtbdvpQvOEGumR7t351Ba9biN0pXe4SgHNw+p+ol1KpSVi
         3TdVGBQGOjJG/MySIIdFR3dtXLFVI1dHur+p6Rj23PRUDDx+DT6zVmMPqEEbyjxdos+j
         9B7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795085379; x=1795690179;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gWmNjMP+sg8RHRMSC21HnjHiZEQ4hcvMIRHCqkIXFzg=;
        b=uax5tvg2xI2HFGQV8IBNwtooEZUoT+5oLSPP50BNM0mFbKSRjzAZ1ecKay2fX1/+Ek
         olxhNNi97vGpVvoU9BeaOfobHvkPMc3CpiUX7KD+vD3cjstKc654OL8JT/jtlaz6x6H0
         9KC1JROeS+RZidcin7EjiaqstT858PeixJEM5FMvgLQb3xwchb7K4zikA6TdAVdb7EZd
         hebu2fYIcIa2aHZY48yP8Bl1xO6FTwyzw5cExqZrdf3VgsVELz7ElOUlnEkaNDBouPHQ
         I9YoEx5NTCWp+f1Esywzbbj+kB7zw646qVqgEPEj3LPF54MhQgWSMqYtBBNM1eZ2PUwZ
         5TFg==
X-Forwarded-Encrypted: i=1; AL+hErGjLTqB9iIW4YSVAbnGV2w8zxbtu0Iv2QUeZuieQc3FSJnOWlcKfYYwZmDwrHmya2xhrcM=@vger.kernel.org
X-Gm-Message-State: APuU4Z9u7ydjnB+h44oXeAy+VyebAWWT0CI8hTRH/S6l4+q/RnLbaShm
	res8dHKf/+h+ZRdhm4WFngrQlrC+WQ/SMf39vwk/eY5S9KY3AE1h17mUx1YE+hiE0EaiTAje27U
	p3OzfwWOi2IWlvgDEI7RF4p8ngWUJv1eoS4mwgOX5FJAim9ojO+08Cw==
X-Gm-Gg: AZFdTZdmQiwm6P2bxaeecopFmBJ0qJxQjYirEfUiavQLBs4EEzBwF/cnM1AnBk2dEiF
	v9PR0vCPv8fWL44e9A3qeUcKHSogkqTecwYaeSV1cGWJal5m+XyHO8TTtdcxvEmINfEaqILWVqE
	CRvWapIPmfXBXwhU6JPL2HrEelutmtZAqoHd6tGPmEDABO4tjMyzNjzoC7KUQ3zqJXAgSHnIECo
	03k1YNS8ORBZFZilXmisI2dyoIkWg6OQ0d/OkxCwkB5lsW+rkHbjjpjHG1x261RUKyqjetgNXJz
	g0bCbqDnNQt5FuXjmgkZhaEym/F2fsnRXIwYi0EAVYcPQvyh2gy9+nJuUHHaPiFhs/dHLVdTFGQ
	QX92b638SxlPAbcfLkeZYFW0S8hzi3z6bOIOh2rrELUKfIjUjenT2Ya82Rdc9zA0PoACaqCVg2/
	EZqnmbGiDlghgKM4N+myGSK1fkQQTpPe0z9I/WLEbVjcDY
X-Received: by 2002:a05:6000:258a:b0:491:fd47:5df3 with SMTP id ffacd0b85a97d-4a6332bc8fcmr12141414f8f.7.1795085379527;
        Thu, 19 Nov 2026 02:49:39 -0800 (PST)
X-Received: by 2002:a05:6000:258a:b0:491:fd47:5df3 with SMTP id ffacd0b85a97d-4a6332bc8fcmr12141377f8f.7.1795085379181;
        Thu, 19 Nov 2026 02:49:39 -0800 (PST)
Received: from [192.168.88.30] (ip231-128-192-82.pool-bba.aruba.it. [82.192.128.231])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4a65560b2a1sm9587223f8f.32.2026.11.19.02.49.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Nov 2026 02:49:38 -0800 (PST)
Message-ID: <00d863db-2ca2-4d05-964b-ce742cd0740f@redhat.com>
Date: Thu, 19 Nov 2026 11:49:37 +0100
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
Subject: Re: [PATCH net 1/2] veth: wake a stopped peer txq beyond
 real_num_tx_queues
To: Simon Schippers <simon.schippers@tu-dortmund.de>,
 Tianyi Gao <tianyi@cloudflare.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Toshiaki Makita <toshiaki.makita1@gmail.com>,
 =?UTF-8?Q?Jonas_K=C3=B6ppeler?= <j.koeppeler@tu-berlin.de>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-team@cloudflare.com, tianyi.gao@linux.dev
References: <20261113104648.225983-1-simon.schippers@tu-dortmund.de>
 <20261113104648.225983-2-simon.schippers@tu-dortmund.de>
 <20261117181607.30219-1-tianyi@cloudflare.com>
 <ab31c0a9-8e3a-4c24-9570-7baf91c22288@tu-dortmund.de>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <ab31c0a9-8e3a-4c24-9570-7baf91c22288@tu-dortmund.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/17/26 19:53, Simon Schippers wrote:
> On 11/17/26 19:16, Tianyi Gao wrote:
>> On Fri, Nov 13, 2026 at 11:46:47AM +0100, Simon Schippers wrote:
>>> Fixes: dc82a33297fc ("veth: apply qdisc backpressure on full ptr_ring to reduce TX drops")
>>
>> I agree with Sashiko on the Fixes tag.
>>
>> I have reproduced the stall with your script (stuck after 2 cycles) and
>> confirmed this patch fixes it (all 30 cycles pass).
>> It is tested with veth from net at 5e9b2ad9b838, as a module on an arm64
>> VM with 8 vCPUs.
>>
>> Reviewed-by: Tianyi Gao <tianyi@cloudflare.com>
>> Tested-by: Tianyi Gao <tianyi@cloudflare.com>
>>
>> Cheers,
>> Tianyi
> 
> Hi, thanks for your testing!
> 
> Yes, I should have referenced the other commit, will post a v2
> if requested :)
Not needed: I'll update the tag while applying the patches.

/P

