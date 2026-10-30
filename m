Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.8
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793391179;
	b=nLHU9dIRq1LEYLDLborC7j7vy4Ne7//EDV0tFIfEHj/f4uHs4YTzMequ87qJZMJEVSPI
	 A0n3IgPhlF8yyOLcLrrNjYruJexya+M8GUduAw8TU/zRR2I9EWcd1oJFJiqxu7vzlj2za
	 ekAbhwsWIcgX4n+5nhDCPVPXAVUegFxygsSsAyXe/nDB8RqDs1wQFQjEzLGtlcpFvvaSe
	 kmohx17XV4rfmMO+wkSUVsoZYbZ7/AA1vipEvJakiIWyT7Xvmtd+tnu9WA4kJhfRRZtpo
	 TGuM8uOsEzyt/iABpZq/5ZKUmBCuvK5XVapqyG7TTq3kAPtDzcJ4vl7KuwLExK7KP2Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793391179;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=+uEj7dkzggUb6lkggRktE0fOB+YC39Gh7yxfAZ3lKo4=;
	b=fOnP36itTR/Rz3PdTe72ke3uPv+bxfgyW1WqtxpTR8rSh7/KBaGHEkrKa1dYMniHsDj+
	 mrHF7Pjwj+U1wEJgaU6409aszh80Z1UIRKad/PzZAzHuA+lBH40rqWfb+UVXmQGUwtfcr
	 Jop4M8wkG4Yx8vMsVKyXDqX/Qnc9oU0iCzuKgcCfRkzhx77e5Xaallj3LxHTnMVQ9gn3M
	 6cZhUdpDnBFNvXvAIIqvWdhOSgxKJ9DstlgNva1ZLr/nb8tF5s/+Dl3QBvIUJ3AaMhgw4
	 0gBtusR/HkH45j4GN9EEwLc/UCcGC1YdeYtHgX13oQYb05IfM+x3y44+WQ+Df6DvCdA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SbdZiQoN;
	arc=none smtp.remote-ip=74.125.229.8
Received: from mail-dy2-f8.google.com (mail-dy2-f8.google.com [74.125.229.8])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46442606A32C
	for <bpf@vger.kernel.org>; Fri, 30 Oct 2026 20:12:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 46442606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SbdZiQoN
Received: by mail-dy2-f8.google.com with SMTP id 5a478bee46e88-36a24f47293so634815eec.0
        for <bpf@vger.kernel.org>; Fri, 30 Oct 2026 13:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793391178; x=1793995978; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+uEj7dkzggUb6lkggRktE0fOB+YC39Gh7yxfAZ3lKo4=;
        b=SbdZiQoNd9v8nZxQuOMNPRPAe3YN2K/2lS+7X9Bn5BxLITOLrcB/hcYjzkI20WWS4y
         fQtDhN+STPp2Dp0/8jJwHW/ofizMr/sz7JyYnt0QKsCias2AT1scQyiu3EUysCy2pkMm
         5+8smIXAqprspCMZSCaCNLCvO9EIOEqYqVaFzDA4ea+YmKxbDNbpYljFke/oD5wDjtz7
         KVbwuTxXV9dDsWLdse7wjZIq7JVItQopjnOPpBeL6CnpdEAh51fr4V/62fxwkrOom3al
         rq9la/RooBlB1Fx85WhoLa0CIdH4Nn6lEELyrTkCoIaEivYuHKS1p/GFeD36Mx+YqvSp
         eTWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793391178; x=1793995978;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+uEj7dkzggUb6lkggRktE0fOB+YC39Gh7yxfAZ3lKo4=;
        b=WMdFRJiP4sieX6joSa22c4cYJX1eP3CiHBZmcCw6//pq4ledYaiHsz7Qqz7PVqxONi
         lqlVzT0ly5vOjblusNZEu4Tjp6NdxS5ls/6UgvwPE08OmA4ACrumDXf7SEjU6gUP7Dsu
         zxFccUtcWQlvK4Rm1KCFTOLPsuckkb7aGFnimIuAVwAkNZilNsDvtgFJcKuSjS6lM24a
         P1v5PKTPf1Z8lXCQMi4OEvkzcb5DPSh3mK+wgcbD/5bxTlEgiVsATe8x94BnOHTPOgjk
         1GcNqxx6uGJVeDOT+s4w1ySPHaCk7IxbRPzSGuWeFoMGVcUJtiN7IKvboB4ts6UYFDDz
         Ts5w==
X-Forwarded-Encrypted: i=1; AKwUvBz3xMrs82fFPmH+ZC8ORY7t8xLfxjvc53KnQK93fdgDawtccUK+yoHWGRk/jiGHlHCfjqo=@vger.kernel.org
X-Gm-Message-State: AFq9FYLw5aBLO1naumrmOTDkyRJGAp1c0EUVKS0bKKUgpi/v6p4+B11Z
	fLvYNfXnBNm8PPNHec6OwuJ9gTK2UTs3M1mYRVpu7HZ0SzhyevkLk+dC
X-Gm-Gg: AYBFou18X6s5ssEOk4Wv8KfTtlfN4n/ujiQl23FURqCDy8cU7znVkI+AiaEi84DC2AO
	bPJ/QRpO3M9W761OI3WRpUGWsW3wEtITLNrW9wnfJZYhKSJ9RpvHGFtjtxg+s4Ms7VzeUAF8bvW
	QTXW1oar2jdxeqyJ4dWpAXHpxGHBo/z3eMm7BzR0PdUF42GHif+oqserg+jKOBVVgbrw9hnUgY6
	4MBlUIpsB9Yqov3li/y+OqfLyH7m/aWFcJT0Hm6XntNFUcmsmFkj7UlwJLbhRI6LVy929iKtxJ6
	CD5fBNtB8D4zi012FRGazYc3815UbbIqQzHLJ8ByyibmnldZTZ75mNhA+8sYG5QF0FPKjk9+rJJ
	TBi4sYVuzPn8R/Nb7N+FrXPv0KrRNZkNsa8OUVqbybKU5stL2G1Mt3StqF+9UYLUG6bEExBlWpv
	CEZUfUWWN4b7AWI+UxF6h7sHyEhya2kqhqeDJwAFrHT1spEVW7qd1jQpQiiH/IE5xwf9P2GN2mz
	YkTJMkGR/fJJc7eTbLqfPYkzCrs5cwjh5TX5tLZUNzMhhnDzIaLEiTTWi/PA6uAkgasmcsct0CT
	UAaxJwcac9hblCwQ8/qDFdc=
X-Received: by 2002:a05:7300:e9c5:10b0:367:3d68:8480 with SMTP id 5a478bee46e88-36a4206d82emr5086488eec.0.1793391178247;
        Fri, 30 Oct 2026 13:12:58 -0700 (PDT)
Received: from localhost ([2a03:2880:9ff:6a::])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a429467cdsm9450626eec.19.2026.10.30.13.12.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 13:12:57 -0700 (PDT)
Date: Fri, 30 Oct 2026 13:12:53 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Rongzheng Wang <testwrzwrz@gmail.com>
Cc: netdev@vger.kernel.org, 
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>, Magnus Karlsson <magnus.karlsson@intel.com>, 
	Jason Xing <kerneljasonxing@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, stable@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v4 2/2] selftests/bpf: cover AF_XDP multi-buffer TX
 software checksum
Message-ID: <auT51NbSPvKJwgiD@devvm16445.scu0.facebook.com>
References: <20261030023248.78802-1-testwrzwrz@gmail.com>
 <20261030023248.78802-3-testwrzwrz@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261030023248.78802-3-testwrzwrz@gmail.com>

On 10/30, Rongzheng Wang wrote:
> Extend test_xdp_metadata to send the same UDP packet using every descriptor
> count from 1 through MAX_TX_DESCS (MAX_SKB_FRAGS + 1), and to run the
> existing metadata and checksum verification for each case.
> 
> Build the packet once and write it into the TX descriptors in a loop
> instead of using a flat two-descriptor layout. Keep the first descriptor
> large enough to cover the checksum offset; the remaining payload is split
> across the continuation descriptors, with the last descriptor taking the
> remaining length.
> 
> Reuse the existing AF_XDP setup, packet generation, completion, and receive
> helpers in xdp_metadata.c instead of adding a separate test harness.
> 
> Signed-off-by: Rongzheng Wang <testwrzwrz@gmail.com>
> ---
>  .../selftests/bpf/prog_tests/xdp_metadata.c   | 147 +++++++++++-------
>  1 file changed, 92 insertions(+), 55 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c b/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c
> index 5c31054ad4a4..17da0a145666 100644
> --- a/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c
> +++ b/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c
> @@ -18,12 +18,15 @@
>  #define TX_NAME "veTX"
>  #define RX_NAME "veRX"
>  
> -#define UDP_PAYLOAD_BYTES 4
> +#define UDP_PAYLOAD_BYTES 32
> +

[..]

> +#define MAX_SKB_FRAGS 17 /* minimum CONFIG_MAX_SKB_FRAGS */

Any reason you're not reading the real value from
/proc/sys/net/core/max_skb_frags ? 
