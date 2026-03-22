Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AC3F33B974
	for <bpf@vger.kernel.org>; Sun, 22 Mar 2026 07:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774163503; cv=none; b=KNzTXtjLUmVZQ0qB1lhAgw3/zA7cCDz4ur0ej1Y0yNxvi7NsLc8Lqx5UKj1GNlRRT77nsV5PlJDWrSBuFKDDRygC67JUn2N6eWldzAhm6rOYlxPIEiJzIfZfcS/OBhI4cwpKdKVtUMg1DLF67RlxrrM6JQJ8jaHDb+Bu599N4lA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774163503; c=relaxed/simple;
	bh=Kuu/KCtElsU7pIeBSMNLm9DwMD7pPN5VzQXIuJI7N1g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RnayWx5CtmWZGXiO6XwnvRFljka+e0jjGD75n2upVs6eL8ePlQ1TbcIZwauGVE+oOP86/Vu6nrGNt5IaRW3tAxbufl0zLCQ9FuASEPTjLJ6B6Qkj3Rp94qVHEM5RK8vjccZcSnKMVK2WfN8AQTJbDzm6OrKNqgXNvPF3YfT5CI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CQZovMMh; arc=none smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CQZovMMh"
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-12a695044a4so2361646c88.0
        for <bpf@vger.kernel.org>; Sun, 22 Mar 2026 00:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774163502; x=1774768302; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SGAsPQktqc4FZugs1UeRZbzQYPPz69mZ+0Bu64YRsnc=;
        b=CQZovMMhMwc7n/a4Pm6jdkuItzq3bOZ0CCzMlTeB/AoBTKA32VaVWpXfiRJBIF+Sn0
         ixTWYEOHbsmEW/XJFgaMzbc71jfNjXpj89Bwi1D3U50zWn1N4m3iKzfEokRc8LmXgJ0f
         2Kl1LKHSvak66OlKVTJBWIoUmxlaksE3KQI5mdizLhTwR4KewkHu3BxlHAwUxm5cbqzZ
         9xnoSmgwsccaVQmMViKdigerrpEeBiO0HNj7Vzhue/SMnnt3VCZFQUVAvj8DLA8/xXcU
         Gc86spC5QL8AVsxtiJZJyIESbFGs1h+utOQZcnO0lQEIB/bQmH5FQtdSD9ePNVMKdl7U
         eXxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774163502; x=1774768302;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SGAsPQktqc4FZugs1UeRZbzQYPPz69mZ+0Bu64YRsnc=;
        b=s+Ru/pkEwv7kiUZ2TOLdvK+K6h2aGpOC2CfX4DhwyYhNjyD6jx9GPYMiJjVrb+K/VD
         cln7mMTuUzx9UKFIjFuIYyBY/6gwc6Zky8eQInpVUaFN/VAKMS1JDCBleA8Tl/aUV0ab
         3ixoppwa09ffxp35huJejjSeUUamjQlEKc+NgJI0HdCu7EPE4qn181dHCGrx16VjcT8s
         YAlQZFUCtM4ijt85drbN7SSU7YBST54/xcTyX7YwhUS5BBCNqpN27Lf7Jte3LiW/ncwm
         rBznL8Z8OsteHGjR2RKY+InfEWthanikbs175hGMThouhdAfzteuML+erTNsEpUUIzEi
         VMQw==
X-Forwarded-Encrypted: i=1; AJvYcCUOcTuuF7E/+ctYABbi/EzVGekD4xNlC1Fa2DdzMngG+l3fe/maH26NJnf0Pc8d39oeqKc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzwmP71FCV7R1oAC4hW83s6wFSH1fW4QsckUdlZ4Jwl+xW7H+f
	ovcmVFJGxoSOJOklcCS6t1zQhMd3jsWe5VS6E9GHxXjtfj/hH9hOr+Ua
X-Gm-Gg: ATEYQzyylz0IimQdc7DHHY2ubWnc2KSC/xKPe7VCXiUzKbBehOqhGQb3WLYP4hgjPCa
	t1qYRc/m5EQfd69G47H4/GXx1+dDs6YpInDn401yEPGJwdiJ4M979gyu2E6nE4EMuCa4mpzCVZb
	X3RxQlMyO3omwh+hnhMNSuhP+SrxQmmLjEKGIftpBu3LvPKP33IepAutLb5Ui4bmvNW8UWYDAi5
	r3QpLhPEly4192vCvEUoY+ayPOP2fW9WnsWIIolvOrc6A3RWalfn6PgWlB3PifbAT6HHOONF8Nv
	JKyD7RXRATWz+eNjUMmxR0BRCsVlIre11df0hGtv2Brv4Z6MX1caWVV4fI09hdAty0LgprQhoqt
	dTFkUs+w7JlPV4AGwg7yALglwHIZIrhzrLxcDkpVv42WMihGagMcEcoMQ0YatDU6/Ph2BmbQqLq
	CdYJaTSZyfZaCTOXbLO1X+hBa95WvNGvYjI9EVAqyS1L1WKnbAz1QCwm1OItQ4
X-Received: by 2002:a05:7022:2227:b0:128:ce44:be8f with SMTP id a92af1059eb24-12a726572c7mr4140330c88.2.1774163501581;
        Sun, 22 Mar 2026 00:11:41 -0700 (PDT)
Received: from ?IPV6:2620:10d:c085:21e1::1129? ([2620:10d:c090:400::5:dc02])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c10b14bac4sm12191223eec.4.2026.03.22.00.11.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Mar 2026 00:11:41 -0700 (PDT)
Message-ID: <ab2f788b-7214-4aa6-bfca-b33d3ab37321@gmail.com>
Date: Sun, 22 Mar 2026 00:11:39 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 08/10] net: lan966x: add PCIe FDMA XDP support
To: Daniel Machon <daniel.machon@microchip.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Horatiu Vultur <horatiu.vultur@microchip.com>,
 Steen Hegelund <steen.hegelund@microchip.com>, UNGLinuxDriver@microchip.com,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Herve Codina
 <herve.codina@bootlin.com>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org
References: <20260320-lan966x-pci-fdma-v1-0-ef54cb9b0c4b@microchip.com>
 <20260320-lan966x-pci-fdma-v1-8-ef54cb9b0c4b@microchip.com>
Content-Language: en-US
From: Mohsin Bashir <mohsin.bashr@gmail.com>
In-Reply-To: <20260320-lan966x-pci-fdma-v1-8-ef54cb9b0c4b@microchip.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


> +static int lan966x_xdp_pci_run(struct lan966x_port *port, void *data,
> +			       u32 data_len)
> +{
> +	struct bpf_prog *xdp_prog = port->xdp_prog;
> +	struct lan966x *lan966x = port->lan966x;
> +	struct xdp_buff xdp;
> +	u32 act;
> +
> +	xdp_init_buff(&xdp, lan966x->rx.max_mtu, &port->xdp_rxq);
> +
> +	xdp_prepare_buff(&xdp,
> +			 data - XDP_PACKET_HEADROOM,
> +			 IFH_LEN_BYTES + XDP_PACKET_HEADROOM,
> +			 data_len - IFH_LEN_BYTES,
> +			 false);
> +
> +	act = bpf_prog_run_xdp(xdp_prog, &xdp);
> +	switch (act) {
> +	case XDP_PASS:
> +		return FDMA_PASS;
> +	case XDP_TX:
> +		return lan966x_fdma_pci_xmit_xdpf(port, data, data_len) ?
> +		       FDMA_DROP : FDMA_TX;

What if the BPF program modifies packet boundaries (e.g., 
headroom/tailroom adjustment)? After bpf_prog_run_xdp(), xdp.data and 
xdp.data_end may differ from the original data and data_len, but 
lan966x_fdma_pci_xmit_xdpf() is called with the original values. 
Wouldn't any adjustments made by the XDP program be silently lost?

> +	default:
> +		bpf_warn_invalid_xdp_action(port->dev, xdp_prog, act);
> +		fallthrough;
> +	case XDP_ABORTED:
> +		trace_xdp_exception(port->dev, xdp_prog, act);
> +		fallthrough;
> +	case XDP_DROP:
> +		return FDMA_DROP;
> +	}
> +}
> +
