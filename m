Received: from mail-pj2-f6.google.com (mail-pj2-f6.google.com [74.125.227.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B179441B8EE
	for <bpf@vger.kernel.org>; Tue, 29 Sep 2026 23:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790724849; cv=none; b=tfS+OLGgidKUKRwUE4Qiv5fi/UeMSp0fc3mD6CY0eMWQiD+Lkt59hxlLfYzwY4MVA7B3VHg8+dWB+0cKgTRlUO8/m8oOBHaLVpMplxMTROMU6V18OJyYk8lcoYLStoEbrc6AvqvetUsckSI8GwNn2f1tfwcsWbS4eBips0s0S+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790724849; c=relaxed/simple;
	bh=21BdaXn+aXicksfhcnNmMDsFu4APPEfR/vUajY39fXs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=enyqwhZNyt+ljFL2A4TcUOw+dD4tlKaeX/cvrfumUqz1uyTrPgim78ZPtwPL9Xoiwqo70fTBVbDU9f7tZl8mGaCq48NxHtNJCxPuSv2EkZJE5UfqeLIW2kID9cFJ/j9MecpCAPZspQGk8wUG+ZFkd8s7W40Us2dJGLvH4o8V8Jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Leo0yHoP; arc=none smtp.client-ip=74.125.227.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Leo0yHoP"
Received: by mail-pj2-f6.google.com with SMTP id 98e67ed59e1d1-3964e7720afso2662807a91.1
        for <bpf@vger.kernel.org>; Tue, 29 Sep 2026 16:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790724846; x=1791329646; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZrOY01z4EAWqgOPMnx+FKjXEAkFljL8pV12WM+AKhjs=;
        b=Leo0yHoPjD/UTRWJl8ED1nwIv01Yl/TRfPtUxaBq1MggylSU8oW+inVfgbTo95NuS2
         ZDnetdWAUp2CKrZYX97GiEozRHr9VMp5JzlHxKndyDhlxvLFETBBZ9esQtcD7cSIcquc
         SZwAnVq+VIG7lA0uH/tDGNCgWHV4/K43pbOA/6Z9zt9RfNS1W7BZedFSbw7PBmLNsLly
         9iepUgE3+o5zEKpZn0mCbVOSyAf03ocv0UEb6A4/mTq2EFsn06J07AJS9O2BxrULEZKL
         u5FlZTt4Dy2qX2ftbHrqB2J7TJhZ1WmoWaPTzAHmzHdlONhWK+4t5v5OkQ986SPAsJ3w
         rY0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790724846; x=1791329646;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZrOY01z4EAWqgOPMnx+FKjXEAkFljL8pV12WM+AKhjs=;
        b=0xsELVbr/wbVdhWEFvuRW01Q1V3VFIaYBgYA+kk2AnHDTgxCYhTML2JBDpNOdotYAA
         KBZisGyouzi4jnKp+YoydDZtt7zPBjg3tHniKWd5OjpaRjDbBk2pNHYfW+xFyOvW5XvQ
         gIGR4KnY/FI3i468ZMpM0/EV9rNoNb57GVwF+9YgDZdIplrCoNFEJLICwZJAmWg0sOI9
         xu5bel9R3ZCsDhJwssMCF5eoNj0A3RBnrPY9XqHsmflIBh8WiwMvgLZ4X4+dohX84Spp
         VZaa/X7Jww+VkLdWiukpGthf0YYhy2N04Iye0K7Uiwg6SA8qAAp65W+H4Vvf9kPmpukb
         ZKCg==
X-Forwarded-Encrypted: i=1; AKwUvBysLlU2lskGE97KoyoUUYzO0RP7hGCy3JL5qniL7hVa8pU8FeFJLPHHskohnwYDjL0dWbg=@vger.kernel.org
X-Gm-Message-State: AFq9FYLicHRE6DSGEwb/CL+w401+7B+mCHsMvJMRQlpCWf996uEs6TQH
	MwI3uEqhprIA3sYqJbI2qXzssabaluX0EPJ74Cnei5aPSDu4mxIYbrR3
X-Gm-Gg: AYBFou2CD7H6Bx9LoJS4nuSKve1xI7Yfqv+K+v9nMTwu8VFhYfBOksH2DQvmf89Mz1O
	cajatdYSmB3CU2cKLX0+EGxRAsi+IM5BSdEHP8XIdN27ZnQEc58WlXY4J43f3gCdrWA9HjieYmJ
	pn5UcKtz+kw7ZzAwFEJsseXnNBMLwpdo3rKZmO1NqBFCfaDyzU/W6BxzBrGVm4u9AMAVnWHun5n
	ADuII/yOL3MjprYARC3dlRnaaJTGbxgsCp1/7jkMRgSH2cCp2Hw/0+wywU4JydlO8gIWhWnEugd
	j5gk/jYc32REVAK4jNfsKMtFB6rktOA5QFibmUpq/g7B2asAQ0udDFVRsOHONuqunI1J+kI2Hd+
	GwrUPF17a8R/ZxuHCJqdELywIDx58gTZiWaLDYb3FrQDFyOf8iuuabjgMpilAFpnvU+bZNl4udt
	SDSBhTMJXPzqP9pAJt5DhCfshl1d3kgO9rs2kyp52vcIvxP1xkQsOLSabN8LrCHTwB
X-Received: by 2002:a17:90b:1d4f:b0:39e:4546:fb13 with SMTP id 98e67ed59e1d1-3a4bfde6c04mr656202a91.19.1790724846094;
        Tue, 29 Sep 2026 16:34:06 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:5e::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a4ca3b0d13sm193050a91.5.2026.09.29.16.34.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 16:34:05 -0700 (PDT)
Date: Tue, 29 Sep 2026 16:32:24 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, jv@jvosburgh.net, 
	hawk@kernel.org, sdf@fomichev.me, emil@etsalapatis.com, liuhangbin@gmail.com, 
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, willemdebruijn.kernel@gmail.com, 
	aleksander.lobakin@intel.com
Subject: Re: [PATCH net-next 2/5] netdevsim: add ndo_xdp_xmit
Message-ID: <arxKg3-oojhXAZjr@devvm7509.cco0.facebook.com>
References: <20260928223648.2739371-1-kuba@kernel.org>
 <20260928223648.2739371-3-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260928223648.2739371-3-kuba@kernel.org>

On 09/28, Jakub Kicinski wrote:
> Bonding refuses a slave which has no ndo_xdp_xmit once the bond runs an
> XDP program, so netdevsim can't currently be enslaved into an XDP bond
> and the propagation of XDP down to lower devices has no test coverage
> at all.
> 
> There is no data path behind it. netdevsim does not advertise
> NETDEV_XDP_ACT_NDO_XMIT, so nothing should be redirecting frames here;
> anything which does anyway is counted and freed rather than dropped
> silently.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>
