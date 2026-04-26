Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9054E358391
	for <bpf@vger.kernel.org>; Sun, 26 Apr 2026 13:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777209360; cv=none; b=stXSSxc3NaLEjQn4kNJAh0fdYMSooeFULI9ehHGt6o05J33d++QwjRPS5Ek4KlSiDAQoex78kDiGIoS6/HV/sgfiVkueP93UM33Upj12plueVEzj+4rKNiBtg0k5a4cgt/EGvB742lGksddvFPj1TwBz7SFLukmd+1Beq320QBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777209360; c=relaxed/simple;
	bh=eyKjK9DnmrMAk5/TDuX9Ob6Z7Uj0pC06AmilCu18QOc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n8qXuwywAkcRJKLMLtKXL8AIS38INbn5u8IJzzWKxGtyvQOE+4OEM+mz4GeqZKs1JDZWmSBcnmb1NQ5EXqUExP/N0i9daYDAZPMbjd6vCrDFoTJY7QjUkmUikS8W4BnZABVeoeItwrNpNNnEt6Wlg9SL3xeQag9k/ygophqwv9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=ic6KsYgG; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="ic6KsYgG"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-50e5c5033f6so64915511cf.0
        for <bpf@vger.kernel.org>; Sun, 26 Apr 2026 06:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1777209357; x=1777814157; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9hWkzkPAt0w9C0nxCrWB+8VxSXZOrmsyO57QsFIVVZU=;
        b=ic6KsYgGNoeG6h9tCNcjsbujNQzxJJBdQFLVtrq4uoMrBDZjWv4JVPLONCdaeiADlL
         d2dXIARFaE48OewbCK18Vo5kc0zTHnjp6AlG++XxlvzhaRBQqNyZusZDZRKxXFsxjWIB
         EJGCXedGJQqWW7fuG4QkW/ut1csHnFgCj9KZC8cpMKbdCMVpfjJv0W1vcLp3c7IQmsVF
         YPoIwmb4i58PrtblLxH/L3OzmRo37Fy+Dckpw5L8GeyT72YVEcqvv+30B/HGQjFcQDKj
         QuFHyhZMUqKiCqE70G+gCI0XZtLleBbo+WAg0HJwsZnbAAMMB/70WEZJtLFk9rlfnj8j
         1mNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777209357; x=1777814157;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9hWkzkPAt0w9C0nxCrWB+8VxSXZOrmsyO57QsFIVVZU=;
        b=PYncdpdW8bTSj6fmeOu9lx66hXu+Xmi90XrOBjM4tUzWE5uembfiK/YwTBkIa3HgYM
         wro1QyNBDr5d3LrNXW1pFqhSE/n4qgLTFaJsTtjggsxqIrgriSMjm0QlKlALNDGULm5o
         WKmoqBKyU8nb3mxJOIZ+I2s3TD2XBPa50PxZBvm5/IKYBNgdv6EYnnM7NyB0OseCSIai
         A8X00iW5JckzH+GFzvCVHurw5JUM7SMkzIhHCOtuVswpLqsfFu5+qYIrDGakVhcY/9AL
         DdsSpBWdKsU/04IQgjOcnftoiL+RpeHpCqDPjtUbNUn0qq3V6uKUKtrZDNzn+boa1iRS
         wL0A==
X-Forwarded-Encrypted: i=1; AFNElJ8WfrfWxAqZXWGCS7Ez6/20P/MTUzKVPjK4IIQ7TzYAotYlqKnS0t3drTK4nErzoREpbuY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzqe+j0iigpJhVkGHA+VnK90QXnhbkN4VAa6XSJTFYl5wq+GUqa
	x41BkaEizaiaMmiXOocYm/ZwxewZNlPMab/WSnzgMRfXpFHSWHRw+ru8yE2Q0Zw2XsU=
X-Gm-Gg: AeBDietNPMlKdwexCgRWZ9BRS8K1pxN3cUrXEoQ91n5EkedFyi4r08Mbaal34RXGi9y
	/gUYDu2ZaCajnxGfOMxls9bMX/l0z6pTLU1ggeW8j/FMDqSmWaUvilwJASjhqLftE9VaB2Ve5VA
	SGM4gRNNfcYavOqqRgeJdI7xeDGAGvJyHlm/GA2sGwg4L+Lezk+/3WUs31ykzvoEaAskLCktPQc
	bXheUBYbqkVOM7gTC3Quy+NGL6swjbPAZLsgwsU9hdeLkJEqlG9ujYVMZSvmx2S64+7zxT7JiRX
	6ji2Gf8NkFFfOKstXUwQO4Yc0Hq1Ib3nebS4vafHI/Xs4NswNZ9Dx8xN8Ww9Kt47Q0BXijJoqff
	/WaF1qsEg4caepCzpi++2k8yxfy7BJnN67YBseAqcDiAhgZvb4wAQGgIp1sV7755azD+/n4+SmV
	FZKmvmREU1VP+emZZZxcpNP3DaEUCIZ0h4c2yVrXOToNJRqtmRccqEVP9q/gwIj+rAWudYIYAqN
	GltsDSIJUgEP57p
X-Received: by 2002:a05:622a:1189:b0:50d:84a7:72d0 with SMTP id d75a77b69052e-50e36e9c0c7mr584902211cf.36.1777209357541;
        Sun, 26 Apr 2026 06:15:57 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50e39487921sm230305001cf.24.2026.04.26.06.15.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2026 06:15:56 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wGzL1-0000000Ejbg-22WN;
	Sun, 26 Apr 2026 10:15:55 -0300
Date: Sun, 26 Apr 2026 10:15:55 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Dipayaan Roy <dipayanroy@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	leon@kernel.org, longli@microsoft.com, kotaranov@microsoft.com,
	horms@kernel.org, shradhagupta@linux.microsoft.com,
	ssengar@linux.microsoft.com, ernis@linux.microsoft.com,
	shirazsaleem@microsoft.com, linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org, stephen@networkplumber.org,
	jacob.e.keller@intel.com, dipayanroy@microsoft.com,
	leitao@debian.org, kees@kernel.org, john.fastabend@gmail.com,
	hawk@kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net,
	ast@kernel.org, sdf@fomichev.me, yury.norov@gmail.com
Subject: Re: [PATCH net] net: mana: hardening: Validate SHM offset from BAR0
 register to prevent crash due to alignment fault
Message-ID: <20260426131555.GA3501894@ziepe.ca>
References: <aepF3NwyANeklkfD@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aepF3NwyANeklkfD@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>

On Thu, Apr 23, 2026 at 09:16:28AM -0700, Dipayaan Roy wrote:
> During Function Level Reset recovery, the MANA driver reads
> hardware BAR0 registers that may temporarily contain garbage values.
> The SHM (Shared Memory) offset read from GDMA_REG_SHM_OFFSET is used
> to compute gc->shm_base, which is later dereferenced via readl() in
> mana_smc_poll_register(). If the hardware returns an unaligned or
> out-of-range value, the driver must not blindly use it, as this would
> propagate the hardware error into a kernel crash.

It is not what we are calling "hardening" if you are hitting actual
crashes in actual real systems.

"hardening" is the driver defending against actively malicious
hardware, operating in ways that will never be seen in real systems,
attempting to compromise the kernel.

Drivers working around real world broken/buggy/malfunctioning HW is
just entirely normal stuff.

> @@ -73,10 +74,25 @@ static int mana_gd_init_pf_regs(struct pci_dev *pdev)
>  	gc->phys_db_page_base = gc->bar0_pa + gc->db_page_off;
>  
>  	sriov_base_off = mana_gd_r64(gc, GDMA_SRIOV_REG_CFG_BASE_OFF);
> +	if (sriov_base_off >= gc->bar0_size ||
> +	    !IS_ALIGNED(sriov_base_off, sizeof(u32))) {
> +		dev_err(gc->dev,
> +			"SRIOV base offset 0x%llx out of range or unaligned (BAR0 size 0x%llx)\n",
> +			sriov_base_off, (u64)gc->bar0_size);
> +		return -EPROTO;
> +	}

.. and if it is entirely normal and something that happens is EPROTO
really the right way to deal with this race, or should the driver be
looping somehow until the device stabilizes??

Jason
