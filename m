Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00C56299943
	for <bpf@vger.kernel.org>; Thu,  5 Feb 2026 01:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770255893; cv=none; b=sNeVKFWZf0ktea2rjB5yE+9tigtsakH/PR2Uvjr2NPPX88uBJqzEg7I9tdyMFP/SpAkc6zkCdV0XeO6hnHFZIqId2zRxKUPSds+A/yfDrAf4+ZHqr6ARpQ17vhD7VK7GN4WPjQTKHYk2XywFJfdyoZ2S24I0D/Tntbo697xJc0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770255893; c=relaxed/simple;
	bh=cWR+NIQC8+IVnYP1ihJqr42Zfi0tIf6rTJpVE9edZSE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fm1f7nEs87S5wv2S9GATJQu92VvSta8OAmdxNJfYb1ZceRidr9fNX2a3ZoCh6DdBUlta3PKbNChtek6t4KLpGCKCRzTpQLclW2h6izN7ZGyOJvah2OX7SRgLu1y37kORgSRkRbB3EpuxQVYytdQgHnVabL9NcAOWhQWBZrgpLaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BaOS7f4Y; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BaOS7f4Y"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-790884840baso3992887b3.0
        for <bpf@vger.kernel.org>; Wed, 04 Feb 2026 17:44:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770255892; x=1770860692; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RdGCHRhz9ScFkBVtx8D0sOJfkRC6ABYnYH3vsQn15cg=;
        b=BaOS7f4YUR52RNKddY0rK8v77BahslndHZvoq306oEQAlz9Gbaq2k5Cz1cupzgI2dT
         xj9D7pLDWXLIw+pi8bilyP7Nhl5dQoYgwK4sBpwiMzt5E9OfZC0oRE3BSNcOJf7OGk55
         6mcrzs0qJdG/9uSUBDZ1imzd6YtMDj9i8kxfQFwjH+6fCUKK204vol2xXAdh2lUtQq3N
         yf2oN7l7za5ajLgeYxqAJWc8Q1ZFfU35E44UfoNvPz3yUqWqDM/3d2B30ktqazCez05u
         AI6k0GInoto/wRt6WqUuWN+ndgmHsQtiqtKsgv+g6ev22HUpekga9SywUD6jeD5T9p81
         xQvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770255892; x=1770860692;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RdGCHRhz9ScFkBVtx8D0sOJfkRC6ABYnYH3vsQn15cg=;
        b=KSdSDZhUqVwibAqwBKG5YHCnHe8+jBIOiKbUDG6zT1Np9sSD9jh0J64IU4Z0tEyBNS
         Q53vZeI/AYaGrBcnFv3QhgXs17B96e3pTS/YFC7ZPM/c53sq4+Wf+7ccvRix6fbBEJYL
         vqPlaczhqgOH4bsn99FVD6uFok69/FurHxfEPkCb4VnmcIbGWpVbxFLu44ObnPWTfS1e
         GC9I5we20qAmBiR5EWNKjOBk2vE/ri3Wf7g8G2Y8pJx+zewXzYCMGBNArLH14ocVoYA6
         lRAcFXmLIgz5tHwCsQGvKpZrkEXfSRlpi8vFZP0gndHS6dDa4DdbY8o/mCbaCPsT7/Cl
         MKKA==
X-Forwarded-Encrypted: i=1; AJvYcCXXVq2yvcVf1+aT5c2QD7Fw+mACdFnqNIKZhsSMfiK5MNnO+9ECbAkJhUwLoHPPg8tsE6k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTQNsX8yb8KyIdRtDiYk+8AVlw01/wK1DAj/JWMTSzX5sYrhbO
	jXHMAB2hGaMLFd1/qNPXAoM7CiDakpp6ioO3d0zDvyhrjlWxzhPoZ4CI
X-Gm-Gg: AZuq6aIaHrK1Y1e1rVFq6e8WbMe06o+JH3GjIhe/Aww1AZ1TkWprxnA0h8wM+3X6Y40
	TmMptXAJxuEkZ3qjJOzkLa5szlLOzRzbtzjyV0V6/HStf3NmJnYla2SuSmhs4pDe7JKQrO1/4cP
	pdKU9SdKT/tqqLl6B+enJt+Mke9uB0OkvWPUbI37nNmYrtjns5rYgZ4I2asoJILRHvxho/GblgP
	yYXjUbXgLRVN+ov36xiiGzabdREVAyw0if9OiHzWFXM5/f53b4chevtuG0POWTrROqKOuGPFsUT
	EWa/r4RAH1APjwjxjZJZgTp33MlDtgIGsV6EhmOjRLEd5YxfPe+cxZHJCDliVnTbolzGVQiCRGz
	CNtm6ROGJoEMx2YY29YDkJSrmqBNqwGMaaUnWJN6SAhN/Hi+CZBZuHVHz1S7c0fb5A2tVPQ7KWA
	bXKSNywZxfZB9ijAJnedPqXay7Qo1EYDStQA==
X-Received: by 2002:a05:690c:2fc7:b0:794:c5b8:7d13 with SMTP id 00721157ae682-794fe63f559mr29250637b3.11.1770255891860;
        Wed, 04 Feb 2026 17:44:51 -0800 (PST)
Received: from devvm11784.nha0.facebook.com ([2a03:2880:25ff:d::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-794fefd00b5sm34815287b3.43.2026.02.04.17.44.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 17:44:51 -0800 (PST)
Date: Wed, 4 Feb 2026 17:44:48 -0800
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, kuba@kernel.org,
	davem@davemloft.net, razor@blackwall.org, pabeni@redhat.com,
	willemb@google.com, sdf@fomichev.me, john.fastabend@gmail.com,
	martin.lau@kernel.org, jordan@jrife.io,
	maciej.fijalkowski@intel.com, magnus.karlsson@intel.com,
	dw@davidwei.uk, toke@redhat.com, yangzhenze@bytedance.com,
	wangdongdong.6@bytedance.com
Subject: Re: [PATCH net-next v8 16/16] selftests/net: Add netkit container
 tests
Message-ID: <aYP2EO8RANz+zCJi@devvm11784.nha0.facebook.com>
References: <20260129222830.439687-1-daniel@iogearbox.net>
 <20260129222830.439687-17-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260129222830.439687-17-daniel@iogearbox.net>

On Thu, Jan 29, 2026 at 11:28:30PM +0100, Daniel Borkmann wrote:
> From: David Wei <dw@davidwei.uk>
> 
> Add two tests using NetDrvContEnv. One basic test that sets up a netkit
> pair, with one end in a netns. Use LOCAL_PREFIX_V6 and nk_forward BPF
> program to ping from a remote host to the netkit in netns.
> 
> Second is a selftest for netkit queue leasing, using io_uring zero copy
> test binary inside of a netns with netkit. This checks that memory
> providers can be bound against virtual queues in a netkit within a
> netns that are leasing from a physical netdev in the default netns.
> 
> Signed-off-by: David Wei <dw@davidwei.uk>
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> ---
>  .../testing/selftests/drivers/net/hw/Makefile |  2 +
>  .../selftests/drivers/net/hw/nk_netns.py      | 23 +++++
>  .../selftests/drivers/net/hw/nk_qlease.py     | 90 +++++++++++++++++++
>  3 files changed, 115 insertions(+)
>  create mode 100755 tools/testing/selftests/drivers/net/hw/nk_netns.py
>  create mode 100755 tools/testing/selftests/drivers/net/hw/nk_qlease.py
> 
> diff --git a/tools/testing/selftests/drivers/net/hw/Makefile b/tools/testing/selftests/drivers/net/hw/Makefile
> index 9c163ba6feee..39ad86d693b3 100644
> --- a/tools/testing/selftests/drivers/net/hw/Makefile
> +++ b/tools/testing/selftests/drivers/net/hw/Makefile
> @@ -32,6 +32,8 @@ TEST_PROGS = \
>  	irq.py \
>  	loopback.sh \
>  	nic_timestamp.py \
> +	nk_netns.py \
> +	nk_qlease.py \
>  	pp_alloc_fail.py \
>  	rss_api.py \
>  	rss_ctx.py \

I think we might also need something like:

diff --git a/tools/testing/selftests/drivers/net/hw/config b/tools/testing/selftests/drivers/net/hw/config
index 2307aa001be1..334be5027a7c 100644
--- a/tools/testing/selftests/drivers/net/hw/config
+++ b/tools/testing/selftests/drivers/net/hw/config
@@ -5,6 +5,7 @@ CONFIG_FUNCTION_ERROR_INJECTION=y
 CONFIG_IO_URING=y
 CONFIG_IPV6=y
 CONFIG_IPV6_GRE=y
+CONFIG_NETKIT=y
 CONFIG_NET_IPGRE=y
 CONFIG_NET_IPGRE_DEMUX=y
 CONFIG_UDMABUF=y


Best,
Bobby
