Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7537E2264D9
	for <bpf@vger.kernel.org>; Mon, 11 May 2026 15:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778514096; cv=none; b=i6OBF2HmcaLOWlJI7cpSlMAlMgQoUqbHaNgmt4rD+fDZvUuE7MQQZbDoFvQsdf+e3N6bEoDbyzcExdU8cA39OLmQgOJkYRcy58sTzBDEysx3Alj75DHbmPQIflEMy8OompXwzrdyWM4DudrseK+Lh4nyeZCBKg8H6QrtubhB1b8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778514096; c=relaxed/simple;
	bh=QYUz8b5kzsmvQFipBJ/YClQFCzx8AI1CLI1nrVUTxv0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bzQbQlm7EbNNIXj4ujRYcTg1QD9ErR9XLJRNdo9qiZkHcOguN+lYQ8mUPtxlAibXsUY33stk70Jgv0nUAh/nFHsV9OQW4wOfOYm+lOGOIZAxgDO930FLhWI4Q6EOAEfxhIQTI2hwYnYCpBm/D2ZHCOgZXmaWNYx5HGHYkv6JrYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=Heko3cGu; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="Heko3cGu"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-48896199cbaso41064645e9.1
        for <bpf@vger.kernel.org>; Mon, 11 May 2026 08:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1778514093; x=1779118893; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QYUz8b5kzsmvQFipBJ/YClQFCzx8AI1CLI1nrVUTxv0=;
        b=Heko3cGu0Pyebt5bmYaWD5pTPrs+ZlplJer06F5Q3e9Ipc3Hi+pgI51EIhUU1T0ncf
         c4gO5Em2u4wlHWzDpeHA3DKtgyvG/TC2z3IoMk96Ekl6HoiCL7TdKph+bb5n4SXJ6g0P
         /opjNxoxU4YepoTNEddD9i5yfspCTDqhwkCPHZpy6MP6pQHszoGnw+I0gAqxHglOk1td
         UX/nAq9/M1jppHUduHWyQFPlGUWPQZt2oBTccyRjSok+olkdvR+SLawsm+GtGJ7SjoMO
         4yUg9H0xC3yWKaHycUvgIdVK4SRQpAQg89Z1D43EhU1IglbucyJojJXkmJkcQcz9YkR4
         gd1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778514093; x=1779118893;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QYUz8b5kzsmvQFipBJ/YClQFCzx8AI1CLI1nrVUTxv0=;
        b=g5PPIUrvt7l/bdlpryesaJsFa/uE7BUB5PZFnkC5AU16qrI46mqIpoyOiQBkeP/EWE
         zthkKIRxsBg1XObMLk/WzcmiUntaifUc8M0QSu0NlzcctcvhG3Jq9Z4hAOcqkO5x1Hzb
         9RjmpmFqEMSW4oUoa8MA5LzPqOj0H+N/ZUlBgn3NSoChPCDwdDMd+hrftKMob9Nb8RH1
         mpeF7JyowbN6An5aCYHmwkFbMSc/YnQZqfgdqHd8ymAs9ZHWYQhJLXO8d1OTHTYtTdv9
         bzbEs8hOUj83pG03SSI51wy4BqsdfQtZm8gMOd1OmCf4BOLLrqeUZHkjXCZ9uzvuMi4G
         dncg==
X-Forwarded-Encrypted: i=1; AFNElJ/GE+vNqg3LxDqpHitUS3oVHY/qQdvUJE+rLLimtvzqUcTircCdcHIWnq0Lyqhul1GCgdA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqmmPMADytmD42SPRNL6SkOvddJLPxzyaKYJ18YiDNG7owm8vt
	k7ZjCcX6wrA9v2pq9oR+XMXcrWWekGDSYOJUVdZBm0XagTwWWlFWCHIOuPc5GnbbfgA=
X-Gm-Gg: Acq92OGrqs7QXuJLhRiPDulTYEHk4mF8TZQv2gB6YxMLwXtneDZwXGjCxtVxn6lh8DN
	42np4y8ag/l7pNcH0dAon2VSSCCu8pnduxmKXzXAz7gVHFDgQXwmqZLIyH2spH22CazRBskbY3T
	kzxDwK1YKvsgBDsnww73DQ23j/Ojtv+cUn+GZDay6xRDd72XigDUcT+ltiVc7KapaXwf1ktQL5w
	Jfril+cf5ztbWVNO6wsC9WHBLMr1sug92L0sxDzZDOyLe6bnsHXLqrRrivlJ2riG27yyLCMtkd6
	E299GTxPmlkZJrG3jcQPOPhaADHjGrq7fGfPSAG7ENgJ1hMCPK090Xe205xxBk9XrHpWml3BtLa
	tHQSWcTpAChxGC7P/Aj1En69hL09CHd8GSci3oWw1LJGyJb6B5mMdgQSgUDDpS8lWz7zdGHnhSZ
	jVTDDpQMwvb5Hs+vD3lI1021GmteBTkMqtQKN9eSHdBl3QHguca6tYMeluadBoSHl1F2dWlrFxa
	A5GX2inYPcyzsh3m3GKpJCozkPZC+GAivQf89pzgglRfG++nNf/EemPEQhih+aDH8hx9ciEl03y
	dHtT6jQj
X-Received: by 2002:a05:600c:1f89:b0:48e:8741:fd42 with SMTP id 5b1f17b1804b1-48e8741ff8cmr37216095e9.12.1778514092586;
        Mon, 11 May 2026 08:41:32 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e6d8e3247sm64622295e9.8.2026.05.11.08.41.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 08:41:31 -0700 (PDT)
Date: Mon, 11 May 2026 16:41:28 +0100
From: Daniel Thompson <daniel@riscstar.com>
To: Xilin Wu <sophon@radxa.com>
Cc: Alex Elder <elder@riscstar.com>, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, maxime.chevallier@bootlin.com,
	rmk+kernel@armlinux.org.uk, andersson@kernel.org,
	konradybcio@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, linusw@kernel.org, brgl@kernel.org,
	arnd@arndb.de, gregkh@linuxfoundation.org,
	mohd.anwar@oss.qualcomm.com, a0987203069@gmail.com,
	alexandre.torgue@foss.st.com, ast@kernel.org,
	boon.khai.ng@altera.com, chenchuangyu@xiaomi.com,
	chenhuacai@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
	hkallweit1@gmail.com, inochiama@gmail.com, john.fastabend@gmail.com,
	julianbraha@gmail.com, livelycarpet87@gmail.com,
	matthew.gerlach@altera.com, mcoquelin.stm32@gmail.com, me@ziyao.cc,
	prabhakar.mahadev-lad.rj@bp.renesas.com, richardcochran@gmail.com,
	rohan.g.thomas@altera.com, sdf@fomichev.me,
	siyanteng@cqsoftware.com.cn, weishangjuan@eswincomputing.com,
	wens@kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 10/12] net: stmmac: tc956x: add TC956x/QPS615
 support
Message-ID: <agH4qC74A540koDl@aspen.lan>
References: <20260501155421.3329862-1-elder@riscstar.com>
 <20260501155421.3329862-11-elder@riscstar.com>
 <DD71CDEABC7C16D5+02d052ff-13bb-4712-a847-91416f76c578@radxa.com>
 <7f3a0f16-5159-4bbc-8b15-9b5841603bf6@riscstar.com>
 <3A5C0389E7C0D241+21a4f16b-1af8-46ac-8831-0c1b49694df0@radxa.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3A5C0389E7C0D241+21a4f16b-1af8-46ac-8831-0c1b49694df0@radxa.com>

Hi Xilin

On Thu, May 07, 2026 at 09:57:26PM +0800, Xilin Wu wrote:
> Do you think if a shutdown callback like this is required? It looks like the
> driver sometimes does a MDIO MMIO read when the PCIe link is down, causing
> the board to reset due to SoC side PCIe NoC timeout.
>
> After this change, the board can always shutdown gracefully.

I've preferred controlled reboots to power cycles throughout development
and I hadn't spotted any major problems with graceful shutdown (which
isn't to say there have never crashes but generally I expect `reboot`
to provoke a reboot successfully).

Just to be sure configured my board with irq=POLL (to match your setup)
and still can't reproduce.

We mostly run Debian/systemd so there might be something happening in
userspace to sequence things nicely. However I have ruled out
NetworkManager.service and networking.service (stopped this services
does *not* tear down the network link).

Can you share a bit more about how to reproduce the problem (including
reliability of reproduction)?


Daniel.
