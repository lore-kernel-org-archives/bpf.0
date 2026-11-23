Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795426744;
	b=Qywyr9U9hIkbvE3cICHR8idL4g3yLI/IYJVZq3nqPMWsg0lfUwV+BDyEY3gHAG5qkeL2
	 LJtSs6b60F+aPb5N4xzo7J+4tyhHFYQtOT23DDJo1FoIa53iWXeyULFr2g27rgmBSHwtJ
	 gmMSY0ZGYBjSAi/FhRhItgTNou1PDIf5GofjNSR5pwc3zUpGX8g7r9q6k/r1s4GT20OBK
	 QmKsRtu8aW7q02kMERoRpgmbJZQOuZzE/aTiKRhbcbMHg/kNFqx1+8A6mGGizJGqlQCSz
	 I+8MdjsVY+hjViOmVSOzP9EEjv38amUDpB1MtV8o8bcd93RE2tliEs90bQZfs5Gj5Zg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795426744;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:Content-Language:To:
	 References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=m+p1znZjzopnvNRqk1tkPRf4Dco0mC826WvcYUflTYg=;
	b=3YL5vIOaegaGPVYIkKtRsdE/AlE3B3YE4uynv/5pX8/U/LQj7MbqkMhOjphim/ZWay+I
	 OdwWrNQFbvmZ24H4L6u3JAVBDe5Y2p+PFmznMZ33Ye2qkKR7evzk4qf5tmyShH7cWsppa
	 OBgZ2B9g2zs45xDYjIWqCLtwZYy30vXrYcBetN6oD4BPX5laQbbJea4TCz/XJKFDiQeHG
	 bKjvkB9ivuzL3FjzmbZlBlr79uwbqGc6LNpkhuU5ziaZMb+gxSKcfEj4+cjnX9+ajJk70
	 w81TU8SCFYk8QRXtJgETAEoFE3amkeDkycjP5IBCKQxxWcILcqm9YbgdiIOwPPU0dYw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=blackwall.org;
	spf=none smtp.mailfrom=blackwall.org;
	dkim=pass header.d=blackwall.org header.i=@blackwall.org header.a=rsa-sha256 header.s=google header.b=Ak8PdHeN;
	arc=none smtp.remote-ip=209.85.221.49
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E419F606A31A
	for <bpf@vger.kernel.org>; Mon, 23 Nov 2026 09:39:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E419F606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.a=rsa-sha256 header.s=google header.b=Ak8PdHeN
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-4ac109a8a12so1686539f8f.3
        for <bpf@vger.kernel.org>; Mon, 23 Nov 2026 01:39:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1795426742; x=1796031542; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=m+p1znZjzopnvNRqk1tkPRf4Dco0mC826WvcYUflTYg=;
        b=Ak8PdHeN5A54sygiNfWEyziSTMebKCB7ZhJS4MYDCl9pHH10grA/vabUuPJK0coeg4
         K15r2nMowRmhz3N280yAzR0/0pvOCwxV3zupib8LF2HJdsxj72/XqEtWbWl3fXhVbYqX
         y36Yc2QuoBdaNN31qtr6+Ii9QeYZzekTI4jGvTbELS0i7U/OpD4Ilakk2qJpXOUB15JC
         OYGxYVuNN47ATJxjS8TTUw0CjxSB4HNQhOsFIcxzYCZAxHKAW+JT+B0Oc2ksl24uYxqd
         Omf8nIuqyn45LVVLSsKvHRnmlUqAyN5YecobevpMetAMqwKiIEMioW1SgE2P8CxCLHPz
         GiDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795426742; x=1796031542;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=m+p1znZjzopnvNRqk1tkPRf4Dco0mC826WvcYUflTYg=;
        b=W6ljuwNyWUn+fLB3bPJHF/PXVPhnsG8Ns4AvPM1p+tvKl3xWuCzEetHxes3zP1piEo
         sXoJre3MoK6zGFLO8EeZkv8MpyMoG/6fxtAIgyr+JfUx8k34g9KA0ngIVmzfADyFUnMu
         Zq7n0FfaoVEbQ+uHSjXTO8kMdvYD1wEjhScfnKfe7tlJxWhHTNVBTbtaolERHgUecbsf
         7Iiea18oJl10lgAff7nXt99p4LEP9kGVZB60u3UujQDmpgbwFSZyKnGzt0XlIIRUiwb/
         sW7K+aHv1R+zGznZZ+jZHQyBWAJoS9TB0bNVMc6pRjwkVpYd/y7pC/am/scmz+dJOmwt
         ULVg==
X-Forwarded-Encrypted: i=1; AL+hErFoz5Y8/c7VkZcsnhapgM0ukmg5ADpA4qEBPSaPo0khmrJzTxWz3RTM3Y5ViFe4n+62Osc=@vger.kernel.org
X-Gm-Message-State: APuU4Z/EFfPQPBnDZp1yN9eyiiM9lGxAM/lluRve07dE3pChea3Pr6Tl
	XSHORFYuzClytSbrsPfLu+r74Huy81rDgVtEaociUBeuMz+taH/ZV/vZabAj7S5MJ2Xrj8fqljI
	rn5MTjPfDxA==
X-Gm-Gg: AZFdTZd6aX7j6GXMx2Z5pHA6X8/kB/ZZf8IfX74OcOmhd/BJrfbugBjmcKLKceSJO1D
	kdkwDDCK/LQaISgQ32kkxLys7AHfpz+WM/S6fX9HSz+F7jJkR66PH414fCh4NXNa/Qc3YPFBL5G
	S0gWfOTUFvddo9g6hVeQlDOn9slGwZtvaGm6ZltDR2V1XHMTsZaQiBhtuVjXYtdHStYVqrqa0+n
	kZFay0AnHrYeicB5ID4FPHxwmsZkI0W/gik6IaKz2PFME7FrL2Syr6AfaFxifZs/nT57oBBQeAp
	lVaa73cDy65f0UHYH98bllHLjxNngELT9AJq3J2g8t90p0bmaAsK5I/xikZkZtkMT7+icZF2sev
	x1y+SqoPqYeMIGRrUOQe8RygA5jb52qqjURvkjzn3FqutLfFKZUalOzxOEfM5BnpluJTfqBiq/h
	T25Viiq2n/JY4IgbHb1jAzr4NGOXaSz2ZEr4+gKYi6Z4GGBWlXKYOwA7AsvUQQBmE0qW52aBBdd
	b6GwTXQjIctOqIFhwO0tYkeSXnGGbp1BlCNZVhuoafum+QhWuP0GloVzT8oGzgaZ+qhk9ASjE/d
	ruEzeSMOzQHPMyGUXd/8pu8HMjwSI22cqjPHWCC1HIsdg8/34hJS2gF7PLw=
X-Received: by 2002:a05:600c:1c11:b0:4a1:e57b:667c with SMTP id 5b1f17b1804b1-4bb8881c357mr254339295e9.26.1795426742186;
        Mon, 23 Nov 2026 01:39:02 -0800 (PST)
Received: from [192.168.0.161] (78-154-14-127.ip.btc-net.bg. [78.154.14.127])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb853a12acsm366470335e9.8.2026.11.23.01.39.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Nov 2026 01:39:01 -0800 (PST)
Message-ID: <b744cc8b-d7c9-4969-aae2-3f282614ec1b@blackwall.org>
Date: Mon, 23 Nov 2026 11:39:01 +0200
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
Subject: Re: [PATCH bpf 1/2] bpf, net: validate assigned socket on receive
Content-Language: en-US, bg
To: sashiko-reviews@lists.linux.dev, bpf@vger.kernel.org
References: <20261123084138.723275-1-razor@blackwall.org>
 <20261123084138.723275-2-razor@blackwall.org>
 <sashiko-outbox-228972@kernel.org>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <sashiko-outbox-228972@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 23/11/2026 11:29, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 4 potential
> issues to consider:
> - [High] net: missing family check for non-fullsocks in
>    inet[6]_prefetched_sk_mismatch()
> - [High] net: missing v4-mapped check for AF_INET6 sockets in
>    inet[6]_prefetched_sk_mismatch()
> - [High] net: unvalidated syncookie request_sock left on skb->sk in
>    inet[6]_steal_sock()

Some of these are more valid mismatches that can happen, I will address them
in v2. The critical issue below is pre-existing and will be fixed separately.

[snip]



