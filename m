Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.136.64.228
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792466836;
	b=HpPc48vYCFZdT5cToEc0NOsEXRMtuK4pNR7LpMFt4MzBoBMI3DNL3jC1FZ4dJ6fwEIHS
	 5WB8Xbp1vBEpyH/QveUOQHUfdo1d2z83UNKX35HxV+Ido7DiCznHGVkCJ9hv/x6cM1pnB
	 XIl/Qhkz/Z1QlftimaHsvciVKCjXtgNQEk9vUWW/FWFcFvd5Q7/aLPStwxmdd+Mi0X8yh
	 TnpvlofUsMegISI2OkfQ9MY9v+ECsezyJQS8KG3hpYsvEVeIA3nGlk6m8MBRMhklxdBEz
	 5I+X37SUbcpzZEJgtaY5h2+j/9+XiE1J1Ullu38R+Nhyzdy7CCIUOtVqkHr15MeqtWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792466836;
	h=DMARC-Filter:Received:DKIM-Signature:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Flowmailer-Platform:Feedback-ID;
	bh=AknwDZpFHbgmcZuz/IKx9NqU9QqXE3cpHO28CghGflY=;
	b=CNyhsCO+hE5J4E5w7ove+e539XebDaNwWFCqg2aXzzSmIqj1/3SO29eYarC8mSxnwmkX
	 r0ppuLLoHPX2THhvIYuYZmDxtQ+vh6g/Q0stN39/rTlOtdgaKYtInBGNe3BnCmEnNvp6e
	 j2vsr2Nb2Ed91tt1QVzSHhQpm85F5JDxucm3fLykBeu2wiA1QB9Gns5FZVcFwtJNAeOta
	 fIRVCY4hcJZLtI/DFt1/Aueud0vzmB519EXOCXFjUJIDTYwq8a5Dcu4Sic0fFFhyhpbYK
	 0Ws+Q7SiLGgRP4t5oYVp8uGBRPuYJ4+E5u54cC2snwKYd/QG8U5Z4QulkFrK3jVjYVQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=siemens.com;
	spf=pass smtp.mailfrom=rts-flowmailer.siemens.com;
	dkim=pass header.d=siemens.com header.i=meng.ding@siemens.com header.a=rsa-sha256 header.s=fm2 header.b="NrF6/WNf";
	arc=none smtp.remote-ip=185.136.64.228
Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47942606A322
	for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 03:27:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 47942606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=meng.ding@siemens.com header.a=rsa-sha256 header.s=fm2 header.b=NrF6/WNf
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 20261020032705078cc23569000207e6
        for <bpf@vger.kernel.org>;
        Tue, 20 Oct 2026 05:27:06 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=meng.ding@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Cc:References:In-Reply-To;
 bh=AknwDZpFHbgmcZuz/IKx9NqU9QqXE3cpHO28CghGflY=;
 b=NrF6/WNfgU13FpfB7R/jRABuRCQNhnCGEeSriMFPtnglfLJjs50CLLL7/vp7EVDsRQWyKW
 F1tU1j2TNHwaoxvMFpdnFfyiHjevIZaL1hpUVOBnAWbiqh0Q1DCXtP+b9Ea0jHL31hssrbXR
 LA4fuAqo5CWKGQEppHd+/Uq7gBFWogvbiPHbTr2+0SaH56LhVrwOUoR7p9PA+HjzW5ShoYeO
 Y/O6HWcg507uuovhbFWu2IblyT+ybj3HoG093UrcORFpWG8636RUJF0ZkvIGZuPxr6NNjMCD
 fI1kaJg9Z8xlXLD5vauSpDR2u/D3BMmLssgq4ejPI+ixzegrcxk5ZWtQ==;
Date: Tue, 20 Oct 2026 11:26:52 +0800
From: Ding Meng <meng.ding@siemens.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, davem@davemloft.net, 
	pabeni@redhat.com, edumazet@kernel.org, andrew+netdev@lunn.ch, 
	netdev@vger.kernel.org, florian.bezdeka@siemens.com, p@1g4.org, tkusters@aweta.nl, 
	jiayuan.chen@linux.dev, pulehui@huawei.com, vinicius.gomes@intel.com, 
	maciej.fijalkowski@intel.com, magnus.karlsson@intel.com, ast@kernel.org, daniel@iogearbox.net, 
	hawk@kernel.org, john.fastabend@gmail.com, sdf@fomichev.me, bpf@vger.kernel.org, 
	richardcochran@gmail.com, dima.ruinskiy@intel.com, stable@vger.kernel.org, 
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>, Piotr Kwapulinski <piotr.kwapulinski@intel.com>
Subject: Re: [PATCH net 1/6] igc: Fix RX HW timestamp reporting when
 NET_RX_BUSY_POLL is disabled
Message-ID: <jqwba3eug2mqib3ffpyfubashuqeiv6rbg2t3mqj2yfspyvy77@r6mj7uylg4zw>
References: <20261001222443.3500206-1-anthony.l.nguyen@intel.com>
 <20261001222443.3500206-2-anthony.l.nguyen@intel.com>
 <20261007185727.68180ce3@kernel.org>
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
In-Reply-To: <20261007185727.68180ce3@kernel.org>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1335312:519-21489:flowmailer

On Wed, Oct 07, 2026 at 06:57:27PM -0700, Jakub Kicinski wrote:
> On Thu,  1 Oct 2026 15:24:34 -0700 Tony Nguyen wrote:
> > When CONFIG_NET_RX_BUSY_POLL is deactivated, fetching RX HW timestamps
> > from the NIC no longer works as expected, often resulting in incorrect
> > or negative values such as "HW raw -121948.050407424".
> > 
> > This occurs because disabling CONFIG_NET_RX_BUSY_POLL disables the
> > SKB NAPI mapping in __skb_mark_napi_id(). Consequently, get_timestamp()
> > fails to perform its driver lookup, and the igc driver's struct
> > net_device_ops::ndo_get_tstamp is never invoked.
> > 
> > Instead, get_timestamp() falls back to use shhwtstamps(skb)->hwtstamp,
> > a field that the driver has not populated. This results in incorrect
> > timestamps.
> > 
> > Fix this by populating the hwtstamp field with the correct timestamp
> > in the default timer when CONFIG_NET_RX_BUSY_POLL is disabled.
> > The "igc_adapter" is passed to igc_construct_skb() to enable
> > igc_ptp_rx_pktstamp() to access the necessary adapter details for
> > adjusting the timestamp.
> 
> looks like a driver workaround for a generic problem
> a better fix is likely needed here
I will prepare a new patch to fix it in the "get_timestamp"
execution path, rather than changing the driver code.
