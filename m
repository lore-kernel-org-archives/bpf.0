Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F86C31D75E
	for <bpf@vger.kernel.org>; Thu,  7 May 2026 22:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778192254; cv=none; b=St+xY6EIsbdHzZHf7LNE9LC322YpqsNQQzazVCH1oYNGpbTSSKFvOdgxPClmTLHnYnMldxNsMxgXfXONehcA69eT5v/9tRK1CiaNRme6Y/uDOUjSay0Pnln1M+eosgvU7gAvdqNqF613vtRG9zUBPcoczkyB7jmDHJoH+yJgvhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778192254; c=relaxed/simple;
	bh=nUqtAeSwtxg2g10Nn3t8JgkOkKTEyo+HUlH2xOySZMw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j52tsnSM6gAkgIJlSNtwA56vFfGd/seaEzzaWT1N18efhIwdi2ow2lByi47sd10zeMu4SctzzVFn8Z5iScRoKEdkwNNxjjJRBWdbqmVtadcT/SHMwxh01BzKpH6sf17Ds6DW0PUZv02dp64bWqbOF0M3agqLAW32jC67dBD54qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=Hcrw5OJh; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="Hcrw5OJh"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-8eab809593cso136871185a.3
        for <bpf@vger.kernel.org>; Thu, 07 May 2026 15:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1778192252; x=1778797052; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V2Ov38+ykmqD6nZk6coLqjQ6cOEYuoDtYD74/Mx9UCo=;
        b=Hcrw5OJh6PlWZxzRnvFn+UW5odJBcqGZFJAcf1xuY+dVv+t7TCtX/vMaAWFjnVG6Yl
         s8oCh094BPUtVBIgneGKmDXKHHuzH8VjK4vRJtA4Rl6w91nS9Sa03BErXGDM8Oha97dk
         DFBaOSG2YwDEK8fJ5SrMSPqxu79cKZLhgnOh89+RnV+k7iyV/GB6Z7JdiAXASADEJvym
         oylte+CJp0zC4SJBr5DZIudaLYj/Q9TVVIuLGNsdPJISYCzy4uWhcPby4JoMNC8bsoET
         O9flifkcoqz6p1mZHo5I5LI206l8rwCXTCivGBs2kjGFapbOr5zY4k83j5vAUmXaArLP
         LNrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778192252; x=1778797052;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V2Ov38+ykmqD6nZk6coLqjQ6cOEYuoDtYD74/Mx9UCo=;
        b=WuWnZCYMAziTWsGsSSsrdyPvMTqcPmtYUVNpkDmbvqQIaBXf9PQVYJWfoVoRO3IcO/
         i8f+5BL51BWLYSDRY6bVkMjnSmA0UdYzLGMGqQF30arI4a4jMHIQTLJXttRz42M3Em/P
         jjz31QTJeU7vmJCB2TTIt+ai0aBBQL8ILdwZF8KmcLWJSL9KeGT+HCJahIRoy+OegcPA
         RmUuTXT2dboP+xhhOowhdMjXjW6uB3ZYNRuxnpYfBvTsHesWYDhgAR/qWZvfPI79zE1j
         szADiEyHcu3sS/oGsr1LqTiCthKhPd6I6ebpC/fsmWhwINbimMaewA6MAEq+7Oa3pyXv
         f9Pg==
X-Forwarded-Encrypted: i=1; AFNElJ8hTmNpJEfrAYT+9YMvbZ9fe8ld9PXHR0WpNTeeO+no6nwZAc7OnpOaAhld98XLKLpbZW4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzO9ONex9wnaBxtavdZYvsEdAdpPJL9gpg+H8MXxovhbuSks9NW
	sBbbggPsV4wtDmAqZ92bsR37pVQcqEKcYYHJaiA+DqXvKNPwPwBBWUTleWLn4O5ZX9g=
X-Gm-Gg: AeBDietCT+XKSJYFGgdP6kHyiDyk8uWp9c9+OBn4dp3xHG9RXxF0+c9g714WFCHDelw
	yjhOXRBgbshfDWC4YQCmEktHCsIklV7Q+VXvRM6EUhZ1ZiT4TczPkW/eeF4KIYLQ07PrNFqDerp
	U0n0B54jrJ5DriU+riUqZnoQU4mvxwpPMJ4SuhY9pZKJxgkEUpeBkiR+Z8mhVeQxrgpAR55Jv0X
	xfyJQbNIBOkrCMNz15FVgILB+H1k9UrWyuSnJ/ga+Wu1dRDMY9LYU5YU2v8QyRefDpyYGAjLEhc
	WJHCmgg7poqTLtj7kM9DCbBbkuFX/hN6qzKetDiO7Py0xldZobRNDWhIXCg+j1GKCIkwIsRqHLC
	8cXBjxjpZUsM0UbFAnSd0Cds1QvYJKDFvNt8rqiMPIX6H8ovoXi47thTKNSWn4VBgTn+ieSoESh
	PN9+naQboL+w4ZXkoBqOz/DINBa5x6bUA547Fy6BJErMqkYJ7kzeMAYcB2dgBLpbMacNk+LV4c1
	II=
X-Received: by 2002:a05:620a:29d0:b0:8cd:9033:1724 with SMTP id af79cd13be357-904d3cb8ed7mr1550360785a.9.1778192252020;
        Thu, 07 May 2026 15:17:32 -0700 (PDT)
Received: from [172.22.22.234] (c-75-72-117-212.hsd1.mn.comcast.net. [75.72.117.212])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-907b986c371sm9463285a.2.2026.05.07.15.17.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 May 2026 15:17:31 -0700 (PDT)
Message-ID: <967c1d96-9a48-48de-b7d9-58b63e782aee@riscstar.com>
Date: Thu, 7 May 2026 17:17:28 -0500
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 08/12] dt-bindings: net: toshiba,tc965x-dwmac:
 add TC956x Ethernet bridge
To: Andrew Lunn <andrew@lunn.ch>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, maxime.chevallier@bootlin.com,
 rmk+kernel@armlinux.org.uk, andersson@kernel.org, konradybcio@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, linusw@kernel.org,
 brgl@kernel.org, arnd@arndb.de, gregkh@linuxfoundation.org,
 Daniel Thompson <daniel@riscstar.com>, mohd.anwar@oss.qualcomm.com,
 a0987203069@gmail.com, alexandre.torgue@foss.st.com, ast@kernel.org,
 boon.khai.ng@altera.com, chenchuangyu@xiaomi.com, chenhuacai@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, hkallweit1@gmail.com,
 inochiama@gmail.com, john.fastabend@gmail.com, julianbraha@gmail.com,
 livelycarpet87@gmail.com, matthew.gerlach@altera.com,
 mcoquelin.stm32@gmail.com, me@ziyao.cc,
 prabhakar.mahadev-lad.rj@bp.renesas.com, richardcochran@gmail.com,
 rohan.g.thomas@altera.com, sdf@fomichev.me, siyanteng@cqsoftware.com.cn,
 weishangjuan@eswincomputing.com, wens@kernel.org, netdev@vger.kernel.org,
 bpf@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20260501155421.3329862-1-elder@riscstar.com>
 <20260501155421.3329862-9-elder@riscstar.com>
 <1f34cbce-e2dd-4e80-b136-55d0efa50002@lunn.ch>
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <1f34cbce-e2dd-4e80-b136-55d0efa50002@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/1/26 12:38 PM, Andrew Lunn wrote:
> Why not add an subnodes for the ethernet interfaces?

We will define "ethernet" devicetree subnodes of the PCIe functions
in the next version of the series.  Something like what's below.

					-Alex

pci@0,1 {
         compatible = "pci1179,0220";
         reg = <0x50100 0x0 0x0 0x0 0x0>;
         #address-cells = <3>;
         #size-cells = <2>;
         device_type = "pci";
         ranges;

         ethernet {
                 phy-mode = "sgmii";
                 phy-handle = <&tc956x_emac1_phy>;

                 mdio {
                         compatible = "snps,dwmac-mdio";
                         #address-cells = <1>;
                         #size-cells = <0>;

                         tc956x_emac1_phy: ethernet-phy@1c {
                                 compatible = "ethernet-phy-id004d.d101";
				...
			};
		};
	};
};
