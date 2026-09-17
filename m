Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E323B518154
	for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 16:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789664398; cv=none; b=eVbPVbSNQ29kuSUNAAVCQrN5FSAQOqm4EWzYzpXjN0J/ZRIVNdRxnbfB6y9hB/bqDCElPxaTDbZa5lz2v1y0p153mw8hDvML3qLCISLmrAbuiA2d92qR3aV6YXZ5u5q2TlWKyTejqLrWd+fmZ+sMAgDWWvNezpSd7corAAehHIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789664398; c=relaxed/simple;
	bh=o6UqOTY41tuRkO5AHdjDRDEciBrken1pog5VHjo2Pt8=;
	h=Content-Type:Date:Message-Id:To:Cc:Subject:From:In-Reply-To:
	 References:MIME-Version; b=HFy7FSB9Hen0Yt99xjo8GPFD8OR2KhGg81GRNjgztcpgDKYJbjEwJhBIpt5mKs9okrQh6rEhEV+PviVUjVgRV6J/jaHxXv0J1aYsr2GKkmP7X7ypBF8cXy9+pOpcdnxN+pXW2hbYBVhYPFuvYkTvv/M8q7SKUkeZ9gfp2X9acBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UUNNdsM2; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UUNNdsM2"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2db18fe433fso9620955ad.2
        for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 09:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789664396; x=1790269196; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:from
         :subject:cc:to:message-id:date:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CU2rNOkPTWonMJ/LHusUbLASqrBVu1PgH/m6EZ16kLk=;
        b=UUNNdsM2rI/9aR3nQbwgFzURukDKRivhAOaPQpfmkcwWcKHJFToXA4gfaI9t/76+sh
         40UmK4s2vN7/wHygqTM1GAEEAwnOolto6T3DVYVJlsvZn0CbHk4Do6moY9caSy64ndVr
         MJDfJPnBzJKqE/92dkIUWgNx9qV4EEpXehm1lG3I91IAF7pi09A7EwutiUkDydMjVItJ
         TcLymoginJcxEjDs19qykRWCztgTZrWMJBjb/oTGd7zulTYAHZu2CHRt+Mqa66kg+pI1
         ifSKnjtO4iBeGFjEMkdOuDPQM58JR3FAp6w9eIdHK7tNctnz7UB43LmYXh7yPOIhw4Ay
         zI3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789664396; x=1790269196;
        h=mime-version:content-transfer-encoding:references:in-reply-to:from
         :subject:cc:to:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CU2rNOkPTWonMJ/LHusUbLASqrBVu1PgH/m6EZ16kLk=;
        b=jbnFhQg+Lh4IWrrfD2bmyhhxdwsy2XMcvaHhgXEWGrRnfX5RnwbFjjuKVO2aqlm9Fd
         mlRSCtFvzPYL1/sPvqHwP9TZgGN9J8bDe1TsVxOnpisc8/oQ/iryVbLueTRXz+8+XBT0
         dyHBk0KlK8sR2HkVvfhUto/1H9/OvyaqknlR83BbGNYLk9D5j5r5b89hyFWCZ9rOixoI
         bHXYqdwCek1XHW/WwjXYeJx6N9HtcvTfvef0sPbEQH+cl5/HFn/qK1hJ9K3jJzkDnVXh
         CFw6TmHAkXpMn3YykekakXP2i2qrdJxIl/bAr9KLHWTiylZ+j5fpqpLm4v5pprM/m9KG
         ym/A==
X-Forwarded-Encrypted: i=1; AKwUvBwwROUN0CDJgV7CJD+LssF7mjZtoYEOEJNI8Yi1MAvd94GoUYVy8JM7LUNRyc9PmNCO9uI=@vger.kernel.org
X-Gm-Message-State: AFuF++njoQSW55l8T8FrQx/rvDrufTm9OWDulOu7KACZPuFMRsJq7mVK
	r6ThJi9WVqU98ek5f6WqLsAXmBeyYNxnZcPYO04kbh9sk0dJ7RwcmcAv
X-Gm-Gg: AYBFou3bQZMqNGs7WjAUOxWRo3MXPomRBIfTbWT/Cj7FBM5XIZMTLEBqjLkvaLjJ9yH
	gBIZERVt8wdpa89Hj6B4C3nnsvX30a7CLMwlCmJ91hXm77XYRPpVH54tOwnzZdW4FBgJ3C/0fDv
	9g19LO3e7N8sYmVjOh6EkyXoMYrqPjAAeur2IhQl4uf10zjuKgaRpSszurlZvwIAZOqQsULeSKU
	qMPfZgujS1SFF/zdULXjKGc04+WyP2O/pE85+1ZTOOA/6BY7Bj0O8PMI9F031d5NkymeEahOE7j
	BuAJDBQULXhApu6NR619cVk+HcDJFYEcgEo3rElZypxWbKmiaVbYiUiQxunPF0atIpqtA71pkAo
	lbnCr2xbztLorHVxCjBSDSL0OMunSoYFJPujEhK6ljrbmYfYKwQJl7BJZ4RGrXLLuhrlDfj19NO
	mz4Ch6Y/rmSSQS75kTtg9L4nIDY24jwQs+E7pLcqaYIP4+AZ5owfEbhUQzvxhCr0K9dzydoUWyP
	8dztXeIcXiR93uEqPBLNoO5P95fUllWaAxefv4OX7uUmhtU1hXFiMUBiqdOHM9qeJPUgcknNzZm
	QPj9
X-Received: by 2002:a17:903:2302:b0:2db:39dc:48af with SMTP id d9443c01a7336-2dd8e752ec5mr159169715ad.17.1789664396054;
        Thu, 17 Sep 2026 09:59:56 -0700 (PDT)
Received: from localhost ([153.61.198.242])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dd89f244bdsm30194175ad.77.2026.09.17.09.59.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Sep 2026 09:59:55 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Thu, 17 Sep 2026 16:59:55 +0000
Message-Id: <DLHR2X1P3BTT.HK3TEMB89P28@gmail.com>
To: "Ren Wei" <weir@nebusec.ai>, <bpf@vger.kernel.org>,
 <netdev@vger.kernel.org>
Cc: <daniel@iogearbox.net>, <john.fastabend@gmail.com>, <sdf@fomichev.me>,
 <martin.lau@linux.dev>, <andrii@kernel.org>, <eddyz87@gmail.com>,
 <memxor@gmail.com>, <song@kernel.org>, <yonghong.song@linux.dev>,
 <jolsa@kernel.org>, <emil@etsalapatis.com>, <ihor.solodrai@linux.dev>,
 <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
 <pabeni@redhat.com>, <horms@kernel.org>, <m.xhonneux@gmail.com>,
 <dlebrun@google.com>, <vega@nebusec.ai>, <rakukuip@gmail.com>
Subject: Re: [PATCH 1/1] bpf: fix TOCTOU in IPv6 SRH encapsulation
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
In-Reply-To: <20260917163408.252431-1-weir@nebusec.ai>
References: <cover.1789646866.git.rakukuip@gmail.com> <20260917163408.252431-1-weir@nebusec.ai>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, Sep 18, 2026 at 12:33 AM Ren Wei <weir@nebusec.ai> wrote:
> @@ -6706,16 +6706,22 @@ static const struct bpf_func_proto bpf_xdp_check_mtu_proto = {
>  #if IS_ENABLED(CONFIG_IPV6_SEG6_BPF)
>  static int bpf_push_seg6_encap(struct sk_buff *skb, u32 type, void *hdr, u32 len)
>  {
> -	int err;
> -	struct ipv6_sr_hdr *srh = (struct ipv6_sr_hdr *)hdr;
> +	struct ipv6_sr_hdr *srh;
> +	int err = -EINVAL;
> +
> +	srh = kmemdup(hdr, len, GFP_ATOMIC);
> +	if (!srh)
> +		return -ENOMEM;
>
>  	if (!seg6_validate_srh(srh, len, false))
> -		return -EINVAL;
> +		goto out;

Sorry. This TOCTOU issue applies to everything.
Patching it in one spot doesn't help.

pw-bot: cr
