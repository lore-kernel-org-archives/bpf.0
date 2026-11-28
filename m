Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795872750;
	b=WiEATIN8YY1HSvDfik5fHy0kEv1cgfEiHqYQcqWpWIu3rauAu1RwCL4GKnZng4igwNWS
	 Z1YG8qYMHdBC2f8D2/C3XS+zXEzb/2ne60Z8DKQQAaqe+VwlCMCBqF2Ev6iIht0W6iSPr
	 SOoGr+p0tBkj9QuV4JWQXgPzRsTEuJgNGkjvXbNzy5vhq3VhaW+G1XaH1xdnhclyOoPqB
	 waRWxRbQ5Geyf1IbXD3Nht3J8+N9h4V0X/RTOimC/r6T8NpbmsTXWBvQbAb2pHPbZEM2i
	 Z1tqfCvMjXHgbp3Rei/y09sOxpCA5l+q7RzqwWFPXgQf5vaEiEGCcXFqGmLbhDapEZg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795872750;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=4V2a+V6fQG2NiQXAdRuUPTgWpRpo/WBcKKqghb1iDS8=;
	b=DzOr6k4ftERG/d+aFLgV+ArQQJbfbl0a3wsUXCAEDXylAhOQRLMbus7sVUvKALRxtXuT
	 JpxlGtGmldFW+voFKWrtg3Bx3bkXTFnLJsV4vxIclyZONMX2s09dq5OZ7j0JXRZO9Dl2o
	 KVxnJPoXw+h+1leFkqxjSX0rQczwIxov5nBbgrJ7HZUoEVYKfBe3vBAfWp2Xa2MW65X5/
	 oTntPgewpRgtR8vdnCJgveW6gWQSVxwfBOiwxB6wnhepcG+PSRQ9dIgWNM/B+VGCIH4M5
	 rk7R0q8FO8zJoAfD9i1llLJw9ewE3w+TazerDu2dc5MDdNIKvOILShl7//YoeIga7Eg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TMFbXXy3;
	arc=none smtp.remote-ip=209.85.128.47
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AB33606A321
	for <bpf@vger.kernel.org>; Sat, 28 Nov 2026 13:32:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4AB33606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TMFbXXy3
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4a2d6d01ecbso47511365e9.0
        for <bpf@vger.kernel.org>; Sat, 28 Nov 2026 05:32:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795872748; x=1796477548; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4V2a+V6fQG2NiQXAdRuUPTgWpRpo/WBcKKqghb1iDS8=;
        b=TMFbXXy3VkgZTK+h4ARTANj0bd2OJWcSuDzdl4CAQt389Lpai+AVfRc4XA/gYyacly
         R879Dgv0XBK8CYbhAZ65Kc2El88wpAV7RM+wotXPg60QlWi7LV6TpyZIbr8Um0C23an6
         u8TQHz1N77s+FngyeyQ1L9xezzYMnq3z1q5gZyPlEmGptbiiGxR+FxenDTbXlJBq90e9
         mWsGq3acSFGPFShfLOaefOfjfSYazcTTWM+chxcEoBBQ9QljloO9eXgUQTZEX7eoBpeK
         bbiItkLRT3BRPAdlFbxhWj+dtp56eg+NcFz0UNzFKiLv8c1LTAHMzmFtQU8SlAwAy5pU
         W14w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795872748; x=1796477548;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4V2a+V6fQG2NiQXAdRuUPTgWpRpo/WBcKKqghb1iDS8=;
        b=imbuFl4ioCGNTXmbJcb3rozqRxdjiuQCSvW7lARNkSTSLzOYeGYv+80yFNWbiYkRd9
         UUD2X8vXYcnWnAgie2HmUBYHYh0OHzCcnWRyOhgRuFH7KHbLpaTlc7/zm+Pl0DdOcCia
         pNPSbB5Fjf1FMLPcJLTEx17mlQV9A3FPlJQiS1bmltLItm70e3HUNzOF2pMVzcnys3uY
         u1IhzGZP4OChnBAxEdhJoMQqKEeavRGwNZ6NuPieEarrFMbc3N94CtlGdTly0uMb1p/W
         HQQUnLzYS9dcX3Z3HQI0jT9caUz1//7EFmX9jCWbOidaUYUQptCJPBtZqpdNGQJDYF3a
         MIjg==
X-Forwarded-Encrypted: i=1; AL+hErGAWLiO6p47+ijiuR9FEwlhGnEIXdztdFZBY9mvjAL3NPQsr9a4efbMWmJ05mpP+7vmzSU=@vger.kernel.org
X-Gm-Message-State: APuU4Z/eCLUaznw7W84yPUqyugvL8/trxzlc1n2MWNA4No/0+qrBvokE
	v/HnHeiCaEupOKtUt/zCHGh8JJX9p9uPZchfyWn+1bu8qJi3Dcs7dWgu
X-Gm-Gg: AZFdTZcSbGUcUkklVFsCjySzQeDUHwVNjOoXPeM3wfsqtvC+RaoFavQsmiOvqRU4fbe
	x6I0ZKHEKl6mRvPeU9K1dQ7y+LIUCXGXQVaIR0ip+dtQdrZ4it05mV/FT7qcoaeuLFMXARnl+s0
	6IIQ/UGly4al+KYLWDigQCywy+olLt+CSvB/ePiqkEtKT1o9A9UXWpo+NeReDjcpdmsJwRgJR59
	vLTX68e2NvKZizUYu6/OeWJoCVQmr17E1TVpSX64ZSz5SGj15Yw8wHd5lVE1mmOMhb21It39pHD
	aLzx1bqmrn+9RcB1l4RSozCpEb0dJaDs4YwvWQII999MQiHZYVaC5u6NMwaZyz4PGjmafyZ7FlP
	KURQQSPpAXMLf3NPo9HDz2t2D+yb1HQBsXLUFpNpuQdoR58Vunq3zvlxhIE/7MYVU1CGXayhOZL
	Am2ecwXXtUolqcA3X7JJ8w2Q8eoVnKWg/f2SSVoxldMBN8VOm6Ds85hWVi/EXU+4mJtE3V5AzDH
	3Y6Cx6mmzwRGhFqHr0cs0QuwhR4ey/K4QQ+KJ/V/ylqtCd2pemjwXj6kG1V62HDUnHne0KllWk2
	wUhC36GPw5LqYs0ndzznpB2L08zEOf02YiJY2DW1TVMDzeB9yNdfyDA/3DK7u081rTr5h7vMZg8
	ps0iT1JlgZ+OOg5SiMeKiggIAo+SfoNvQ9qCP
X-Received: by 2002:a05:600c:1d2a:b0:4b7:6942:39bf with SMTP id 5b1f17b1804b1-4bb88814031mr666559775e9.28.1795872748317;
        Sat, 28 Nov 2026 05:32:28 -0800 (PST)
Received: from pc.tail250202.ts.net ([87.110.86.243])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb884865b1sm790112755e9.5.2026.11.28.05.32.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Nov 2026 05:32:26 -0800 (PST)
Date: Sat, 28 Nov 2026 15:32:23 +0200
From: Janis Edvarts Lacis <janislacis06@gmail.com>
To: Antonio Quartulli <antonio@mandelbit.com>
Cc: intel-wired-lan@lists.osuosl.org, 
	Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>, Kurt Kanzenbach <kurt@linutronix.de>, 
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>, Heiner Kallweit <hkallweit1@gmail.com>, Joe Damato <joe@dama.to>, 
	Sven Auhagen <sven.auhagen@voleatech.de>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Subject: Re: [PATCH net v5 0/6] igb: fix runtime PM resume issues
Message-ID: <5k4igk5etdbmaweimm5ams44kwe3vzcqjmnck6a2w2iyhsfsvd@ianca2g23kva>
References: <20261124235723.1135808-1-antonio@mandelbit.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20261124235723.1135808-1-antonio@mandelbit.com>

On 25 Nov 00:57, Antonio Quartulli wrote:
>igb can be runtime suspended when the link goes down (with
>power/control set to auto). Resuming it calls functions that need RTNL
>without holding it (patches 2 and 4), XDP and XSK changes race with a
>resume (patch 5), and devices that can't signal a wake-up are suspended
>anyway, so their port stays down when the link comes back (patch 6).
>
>Patch 1 fixes the XSK pool disable path when the device has fewer rings
>than the stack has queues: a NULL dereference with VFs (a single Tx
>queue on 82576), or after a fallback from MSI-X to MSI on resume. Patch
>3 keeps such queues while they still have an XSK pool, so that the pool
>can still be disabled.
>
>Tested with the 82576 emulated by QEMU, including, with test-only hooks,
>a runtime resume and a simulated system sleep (the suspend/resume
>callbacks called directly, as the test kernel has no CONFIG_SUSPEND)
>with the device forced to come back with MSI and a single queue.
>Patches 1 and 3 were tested with a zero-copy AF_XDP socket: closing it
>after enabling a VF oopses (queue 1, stock igb and v3) or warns and
>leaks (queue 2, v4), and warns after a resume forced to use MSI (v4);
>patch 5 by closing a socket and attaching an XDP program while runtime
>suspended. Not tested: real hardware and PME wake-up, a real system
>sleep, the MSI-X allocation failure itself, the window before the work
>item runs, SR-IOV with runtime PM, and a device that can wake up. Not
>run under KASAN.
>
>Sashiko also found two pre-existing issues in the XSK queue disable/
>enable paths (the Tx NAPI isn't stopped when Rx and Tx don't share a
>vector; a failed buffer reallocation leaves the queue half torn down);
>they will be fixed separately.
>
>igc has the same issues (see the notes); Joe Damato offered to test on
>igc, so its fix will be sent separately.
>
>Changes in v5:
>- new patch 3: keep the stack's Rx queues that still have an XSK pool
>  (Janis)
>- patch 4: cancel the work item before a suspend (Sashiko)
>- new patch 5: resume the device before changing XDP or XSK settings
>  (Sashiko)
>- patch 6: check pci_dev_run_wake() when scheduling the suspend
>  (Sashiko)
>
>Changes in v4:
>- patch 1: also handle queues with an Rx but no Tx ring, as with VFs:
>  tear down the Rx ring and skip only the Tx part (Sashiko); subject
>  changed from "don't disable rings ..." to "don't touch rings ..."
>
>Changes in v3:
>- new patch 1
>- patch 2: set the real queue counts on system sleep resume and from a
>  work item on runtime resume, and drop packets for queues the device
>  doesn't have until then (Janis, Sashiko)
>- patch 3 (now 4): link the NAPIs from the same work item
>
>Changes in v2:
>- patch 2 (v2 patch 1): keep setting the queue counts in __igb_open(),
>  only skipping them on resume (Sashiko)
>- mention the tested hardware in the commit messages
>
>v4: https://lore.kernel.org/netdev/20261120210134.133238-1-antonio@mandelbit.com/
>v3: https://lore.kernel.org/netdev/20261119140412.163202-1-antonio@mandelbit.com/
>v2: https://lore.kernel.org/netdev/20261116153041.3002666-1-antonio@mandelbit.com/
>v1: https://lore.kernel.org/netdev/20261113105835.3821433-1-antonio@mandelbit.com/
>
>Antonio Quartulli (6):
>  igb: don't touch rings that don't exist when disabling an XSK pool
>  igb: fix RTNL assertion when resuming from runtime suspend
>  igb: keep the stack's Rx queues that still have an XSK pool
>  igb: link queues to NAPIs under RTNL after runtime resume
>  igb: resume the device before changing XDP or XSK settings
>  igb: only allow runtime PM if the device can wake up
>
> drivers/net/ethernet/intel/igb/igb.h      |   1 +
> drivers/net/ethernet/intel/igb/igb_main.c | 144 +++++++++++++++++-----
> drivers/net/ethernet/intel/igb/igb_xsk.c  |  37 ++++--
> 3 files changed, 143 insertions(+), 39 deletions(-)
>
>-- 
>2.56.1
>
Reviewed-by: Janis Edvarts Lacis <janislacis06@gmail.com>
