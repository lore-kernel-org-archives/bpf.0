Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E867D3AEF21
	for <bpf@vger.kernel.org>; Thu,  7 May 2026 08:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778144087; cv=none; b=Z81cchKPgPOKcPQHDBLJMEH4mDKfF9ljulPaDC1zvJBr9Sm5abJ29C2rT9vJfR4FWuOoKOuxsKw7b2sXJIy9OIEWlm77D0A2o02Ty+INyFBY8+VG1aAAy2kyF2vwg/pEKWySDezKckhaHOu15AhuZeRQe1cIu1spuMQMJHdbIe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778144087; c=relaxed/simple;
	bh=xb6ZiBwLsP6jdQI3LJVb4v/501VM5gzJU50dn0+gU+k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ogp3ACrZz/F0lx55GzjUiL5cGsIp9eNQjr+72GMZXDneRqepWchh4R82qmeYnUc8ix3ete2fCTZ6ZyVwo+6x6LwNYBtRcNB3whdkb82NyfIxudPgOivWQMnKmWD2EXQA+CA2Sdtlk3M04I0k0z05+Y6wqTdBEMLzUXitU0dPjKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DMUO1+7y; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=L9Ux6+0H; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DMUO1+7y";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="L9Ux6+0H"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778144077;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Cf5Hiy8Ry8GA3Jd9aF9Qx8+o0rODNaBHOnWLQ2WctSg=;
	b=DMUO1+7yvuvt36bs5BG8MUG+r049TDMdkONeL4XDNZxzZqCmVfN7FYtf1goOfrwX8keY5p
	CaJSHHBMV9vM9wwvN4hXxVO/iEvp6wHKfTcTeGwLVLweSYThHLvyP0iDryr1fAEZgAY/mf
	4Cr8ysxcXepNL2AzVMC6OxQpDrDLpGE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-353-WMOw0Y8bOs-W79yhc4AxEQ-1; Thu, 07 May 2026 04:54:36 -0400
X-MC-Unique: WMOw0Y8bOs-W79yhc4AxEQ-1
X-Mimecast-MFC-AGG-ID: WMOw0Y8bOs-W79yhc4AxEQ_1778144075
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-48a589c7879so13181585e9.1
        for <bpf@vger.kernel.org>; Thu, 07 May 2026 01:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778144075; x=1778748875; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Cf5Hiy8Ry8GA3Jd9aF9Qx8+o0rODNaBHOnWLQ2WctSg=;
        b=L9Ux6+0Ht5CdORY8beTbWj1Cb+2+S8TCcWboY8UyuxSGRn76je4gnHQwo8u28oxIup
         MWWpqdDIIy2XslNfsX+LI4FotkPNO3raF2y97VNBsFq7G3TziU5p3opaqhdwEAso8W61
         emzhD1aQ2dfobYmpP4hhIEZZuneVDRQ8RpbE3mCodDWAzhQjOHiFgqX5SCS4gv2YQ56X
         sP19lyPo/aW9AcKr504ogvDXeINXwnXypDk75/dByNSubr9Z8eZI2SS+oSETP6tWiUJ+
         hsRDDloXPeCdJMRjrgfAOcX2aXREVfrnxY3QmB8IRpCAamfe4jWWrkQ69jDUWA9bz2G2
         Fd2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778144075; x=1778748875;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Cf5Hiy8Ry8GA3Jd9aF9Qx8+o0rODNaBHOnWLQ2WctSg=;
        b=jknKLmV6cOmsWAhXz8vQKO3IPmE1VX25Q5A6h8Vg2o4798Xqya7M+A1LQuGXVz/eNo
         XjxcMClGl/SCM3Xmt9fy6S2TsldVFw6ygP5V79mQyewjpbKf5zlRmF3KzVidg6XwGtXY
         6lQxNzmdK3iHpKTal2TOeXj4xKQSl5XCrz192qoj6hiOxfkA/rAc02wSR7fa1iDD98L3
         Kpd3fc3LafSCdtgAz/4bXU3svIJfbXucVVQtO+w7KVpJcnXZJjnAcBKigMZ4H1Tq15is
         iYLuc2dS90kfoATb2EEpZQw9gnbmziiHzq/TJpVS0eETn3SnKHqQYzDsUtuoHSHXL7Tr
         e3Nw==
X-Forwarded-Encrypted: i=1; AFNElJ8B/UkLHMB3KEjzun05Q43NfwD2B4Fa4R3g66HK120E32yaRxDrTimuPcX25wAPZVBvWvg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw16dFx59KGZOsB5L19vI6K6q+Upos05cOU+BSPyNLI7MXi/hqW
	MZ6utoY108n3rExqlfxOsDeqOehJS5yE5Tq/4g9jRywPyohQlJqseDlxHySPJycW9MN/3cPFLf9
	e/5yD4KnwQAu3JD1vIae79R8fsvd2yz1oeNGobGRZ6sOO7XwMsc6ebw==
X-Gm-Gg: AeBDieuwp3U/BiCDLFy+2WCj+dG47u5Aq9JG3nhbbbNdHeRG5IepnOZbMYA4LOpKQBS
	oATXNlaE+ZBNJd4izpFQ5oIf+xC0EdDjoC5ev/G6fp8uGw0/BQBgqRFjsnynQQ2D1O87wKdHYSG
	1z1IgaEgYyRbmKam892WVMpv18z7NLbTExyN8+gj5aI0q9CF89cTvPSwszrHZApd2HFiSx3VQ+x
	1wrW9UUB/gDgaLtnU1VxyyPUMBcvYycf8vbocUuXN4CaMum9rJwWA6WA0465JvwbVJx1OB8JIaP
	hGsqYT6P+OVrok7enDC78fUM7BTSVeJ2ZdE1iCTklAG6FrWvgUp7FXTJoz3sUi6si1n1ZgLu/Ai
	7XgzPjHWIrLKUDT+TIHDGzgbsrRO6WWYfhhAtoB7Ka+/kffNqdtdT+zc37rkaOBBnv61RTiaqUW
	Sp
X-Received: by 2002:a05:600c:3e10:b0:485:3cef:d6ea with SMTP id 5b1f17b1804b1-48e5e0089e0mr31312665e9.13.1778144075248;
        Thu, 07 May 2026 01:54:35 -0700 (PDT)
X-Received: by 2002:a05:600c:3e10:b0:485:3cef:d6ea with SMTP id 5b1f17b1804b1-48e5e0089e0mr31312015e9.13.1778144074746;
        Thu, 07 May 2026 01:54:34 -0700 (PDT)
Received: from [192.168.88.32] ([150.228.93.82])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e53891163sm118910315e9.2.2026.05.07.01.54.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 May 2026 01:54:34 -0700 (PDT)
Message-ID: <b7399930-ea04-4899-a760-ca1410065aac@redhat.com>
Date: Thu, 7 May 2026 10:54:32 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 09/13] net: lan966x: add PCIe FDMA support
To: Daniel Machon <daniel.machon@microchip.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Horatiu Vultur <horatiu.vultur@microchip.com>,
 Steen Hegelund <steen.hegelund@microchip.com>, UNGLinuxDriver@microchip.com,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Herve Codina
 <herve.codina@bootlin.com>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Mohsin Bashir <mohsin.bashr@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20260504-lan966x-pci-fdma-v3-0-a56f5740d870@microchip.com>
 <20260504-lan966x-pci-fdma-v3-9-a56f5740d870@microchip.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260504-lan966x-pci-fdma-v3-9-a56f5740d870@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/4/26 4:23 PM, Daniel Machon wrote:
> +static int lan966x_fdma_pci_rx_check_frame(struct lan966x_rx *rx, u64 *src_port)
> +{
> +	struct lan966x *lan966x = rx->lan966x;
> +	struct fdma *fdma = &rx->fdma;
> +	struct lan966x_port *port;
> +	struct fdma_db *db;
> +	void *virt_addr;
> +	u32 blockl;
> +
> +	/* virt_addr points to the IFH. */
> +	virt_addr = fdma_dataptr_virt_addr_contiguous(fdma,
> +						      fdma->dcb_index,
> +						      fdma->db_index);
> +
> +	lan966x_ifh_get_src_port(virt_addr, src_port);
> +
> +	if (WARN_ON(*src_port >= lan966x->num_phys_ports))
> +		return FDMA_ERROR;
> +
> +	port = lan966x->ports[*src_port];
> +	if (!port)
> +		return FDMA_ERROR;
> +
> +	db = fdma_db_next_get(fdma);
> +
> +	/* BLOCKL is a 16-bit HW-populated field; reject obviously-bad
> +	 * values before they feed memcpy/XDP sizes.
> +	 */
> +	blockl = FDMA_DCB_STATUS_BLOCKL(db->status);
> +	if (blockl < IFH_LEN_BYTES + ETH_FCS_LEN || blockl > fdma->db_size)
> +		return FDMA_ERROR;

Pre-existing issues reported by sashiko (most of them actually) can be
safely ignored/postponed to follow-ups, but the above OOB (and in patch
11/13) access looks real and IMHO should be addressed.

/P

