Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.7
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794608567;
	b=TQkGu63Pfn91xCGwed074SA3yixr+zPCNewmQ4WYL7uD/1kMMp18/aGJ4El5/WS9vnIL
	 MagucChc5RQkiIaEOEomM9YZ8PGpTqWbYUmMsrgF8+966mhuaFiv1f2sPzAXFCw9NXgwJ
	 mMkSJh+T+d/jIA+HPQfIbzH7bpAnnwKYlM28s2TjJDlsEK1juzqj/NLBml3hdzOaTqeMH
	 Sy+MYVcr4e8kG5MrSW9c6tzLCNPkLKt2rhfzraaa9SMgJvRa+ebMyFKG7J0/BkDNNSsYE
	 mn8AL3j5TQPHoa9qMoI5qzHtibDgDlyFn8ETPq2jXS9Gq7e7CuN1RQGxC7J9xIVBTIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794608567;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=PuWQ2BwaMw0F60EupC+5yCUtgb9A+hweuIMrIgnawM4=;
	b=y2K6w+ODRnmZDMxLHYtLIFDMwvG4finyXTR8ZAEDXULuNiJqtKQQ+h2ZGgVtnBbUgP5h
	 pFj7qJsCDymEvyXOGGlOs09+0AJLhIPdaOWLYveSyNQq+3gVUN05i2MLR9s5LjC0j/qe2
	 QwA6AjEPVnQEFkI52z1NWsU60Fc4Y8E89yObP+fGfRKbm6qK8JqvTTCJo4JeQ8C2arwsk
	 GqkB9QY0Uw+e6HOIN1nyUMev+bCbpsh/rPnXnUVXUKifqiiiiAP4Zvntp3U5l18VD03QD
	 wy6nIaLFAnUh+RXiAj2eXV3Ld4xfbj/Ti+Di2AQPIx2UiZKrteOWhAP2mv46cvd5nhA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kt0eGjZ6;
	arc=none smtp.remote-ip=74.125.229.7
Received: from mail-dy2-f7.google.com (mail-dy2-f7.google.com [74.125.229.7])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB363606A88B
	for <bpf@vger.kernel.org>; Fri, 13 Nov 2026 22:22:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AB363606A88B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kt0eGjZ6
Received: by mail-dy2-f7.google.com with SMTP id 5a478bee46e88-36c9b5c6faaso716665eec.0
        for <bpf@vger.kernel.org>; Fri, 13 Nov 2026 14:22:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794608566; x=1795213366; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PuWQ2BwaMw0F60EupC+5yCUtgb9A+hweuIMrIgnawM4=;
        b=kt0eGjZ6lI9yQVuQ0WalkgZYGqnAu6quAkbn/YNnSaNNY4bDxmg7vWu5L/iCEKeRq1
         BcHDv16Nly2AE2lgZ1szXyCbpA//4r+TIy7pmoIrIaWlaAuhxishgr/nf6iJy+MF8JHL
         MnFiQ8swqhS0T9o7CW2+KpZh79x4DzoeNMIG6AbPH6bu90SMA4+yEXC9cAzM6enI8Y0J
         2N0H9Y4xL4Kj41pYFL5pMsv1U33XLXGZlmtM3S4WLqvVUbDJ+yObSu0oCraJ4gIg+Qrv
         xYsUdpVKLCo1UNmumy85tcug4O2Qi4xN+kSO2xy4WFG7/h6Nu2vesGAp6pwgnTMh6ALv
         Nypw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794608566; x=1795213366;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PuWQ2BwaMw0F60EupC+5yCUtgb9A+hweuIMrIgnawM4=;
        b=0mjZMQU/eWBTI3tCfSN7X0Fn7fWbjS5jszoHHX+UzRvLUg1x3f3s/NdgVfmKSaL2MC
         pGjSS1ePa4YoeM3poQif7QcVqQbtUQUYsfDmMowyxXG/O925leDE4b8yXYpVHdXVpcBs
         4G5B1HZ1ql9WVQM5SBojmSsntuSgNf8MtimPKZeKaWG50oil75p8WWUZBbMH8v6uJKqW
         xpLnuH0QGm69cEub7vG0TO3ciZ3uaIXW+ZHMzMc2NziphtVL1F4hJKbrSHQljm6Gphj0
         UZMekHfxoJpjFQtojX3u0hU58+SfrDOo7CIGz1q9UYDxwGJwtrNJJVp7OEJDFvqrI79T
         ZjMg==
X-Forwarded-Encrypted: i=1; AL+hErGgAasdRQo8BXXSLkK/WIOduXteeqPXCZ62WzvjD0X3ANMU8Iz0RX+xJmWDcPIH4FYvtcg=@vger.kernel.org
X-Gm-Message-State: APuU4Z9K4wCvHAqZxdcIfEldtmzNjRgBlpYYANxiQBSt5Bt1smEQ4JIJ
	MOyYNF4fIll3yLvCF5NYEPG3rnHaYoD8VOZcDcRURX5R+vo5dcAWC3nz
X-Gm-Gg: AYBFou2og4dy+UvQnnJKnDSI4Yh81/c62t1pIXiYsgV+bIFI8bNimQQPKxRGEmlT+34
	H0wpodCoYSQP2mWRyZfQ0VqJb3h0bL6t+3miOLfGi6836uE/7wCMe/89t/F0PP6ceANZGYy0MOQ
	LMEUYJLGx4oB3qGWvVxWhpJSD+N1cJ1ZiZ5xeNa75huXMQ0wyLC18STIftcEM+u2aOr0rIW69TI
	SCgkjNKBKQBsdHwt3QAZP6PPLjkzi4X0O9evEe7Wx5tq4GJ5M9+asUQODlvQyLH7GjT0Sn4nQS0
	r7uqq5+ZNoYf2XUDwmyk3QxnPDwGgw22PwSoVc/S+7jb2IJN4U28iX1Ze5WCEVKfOm7tDBUrXZd
	Ku4JlufXoh7DdHCEq4C+YfxUxztwNtG7/X7g2o55tr00FPqfouCVoIQkGwVpcsl1oH/zatjInT5
	RftllDwb2+IyA4nVp23G8tvjjvNDcUvVbKoL+76VS9oKsSoAx1ww1/0srCPuTVw5NIpDB5kcQgr
	A36hdif/3rrQ0QpKTx1aloVkDuppiljxZlDZtcjWfc+GmwyymU9VmFpA/hZeRAj4kro/QEEJjht
	T6HV1997tQw4l+w6ZYqOEjM=
X-Received: by 2002:a05:7300:cf8c:b0:369:f70e:bd40 with SMTP id 5a478bee46e88-3796628f4c8mr3171439eec.16.1794608565735;
        Fri, 13 Nov 2026 14:22:45 -0800 (PST)
Received: from localhost ([2a03:2880:9ff:72::])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3795378d7e5sm10160338eec.3.2026.11.13.14.22.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 14:22:45 -0800 (PST)
Date: Fri, 13 Nov 2026 14:22:41 -0800
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, jv@jvosburgh.net, 
	haiyangz@microsoft.com, ast@kernel.org, hawk@kernel.org, john.fastabend@gmail.com, 
	sdf@fomichev.me, bpf@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next 0/5] net: make xdp config checks effective vs
 netif_xdp_propagate()
Message-ID: <aveNqpUudFjo0jA9@devvm16445.scu0.facebook.com>
References: <20261112235027.4072149-1-kuba@kernel.org>
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
In-Reply-To: <20261112235027.4072149-1-kuba@kernel.org>

On 11/12, Jakub Kicinski wrote:
> Bonding (and netvsc) try to auto-propagate XDP programs down
> to their lower devices. These programs were installed directly
> with .ndo_bpf and not recorded in struct net_device of the lowers.
> This makes all the config checks for features incompatible with XDP
> ineffective - HDS, memory providers etc. use dev_xdp_prog_count()
> and do not call down to the driver to ask it whether it has XDP
> installed.
> 
> Record the state appropriately. dev_xdp_prog_count() will now
> "see" the propagated programs.
> 
> The issue was discovered when reworking HW-GRO and XDP interactions.
> I was trying to make sure HW-GRO is reliably disabled with XDP,
> and discovered we have a way to bypass all checks with bonding.
> Not treating this as a fix since it's admin-only self-inflicted
> damage that nobody is reporting being bothered by in real life.
> 
> Jakub Kicinski (5):
>   net: don't safety-check device features for XDP uninstall
>   net: move dev_xdp_set_link() and dev_xdp_set_prog() up
>   net: record XDP programs propagated to lower devices
>   selftests/bpf: check XDP attach on a nested bond slave
>   selftests/bpf: check replacing and detaching XDP on a bond through a
>     link

Acked-by: Stanislav Fomichev <sdf@fomichev.me>
