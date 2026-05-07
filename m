Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82DB63233F4
	for <bpf@vger.kernel.org>; Thu,  7 May 2026 18:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778179037; cv=none; b=kaD10iJMWWs4m2sOOuoY2tDgU4RXh/8HkCsyjDYXap4Igp68vBLwZcz5MCzahTA3QSWQjljIil+iBYWxSM5MwS3axvNM2HxLN49m14WrLKEgX7WvpYuOpb9XtDwazndELYl2ear+E0ui9MKNEXisVSiMg/nr5YuWf3PtATC5/Dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778179037; c=relaxed/simple;
	bh=0mU+Gr18j8ctUXlUwK5bdZXpnTobEBXi2+Wby91srKU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kQQc+/5bEa3M6T2aSr3sWvPXYIrXmTJX7IgOxbojw5WmCZZsqqbIM/wd0dcdSw+2MOGkHhy1QCU/nLV7EIt7d+1mpsbdH9ReH20EaAu04sajMNo6RquDDKD94s6q4748BhLbDLRo9i3TV+K616M1gVQZ3K+jxKvwz/XZDbBSQcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=TDHvjKWF; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="TDHvjKWF"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-7bb0d18c7f9so12553347b3.0
        for <bpf@vger.kernel.org>; Thu, 07 May 2026 11:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1778179033; x=1778783833; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=x8i4c2z2WoES1t5qSKN6GUknygX5CCKfGDT1oqYJPeA=;
        b=TDHvjKWFJoWHC9uFBuMgwiI+qpUqrLa97iwkqGHkK6YH+7KGHpXRfS+PJZl9GG8e6h
         sw5zkqR2EGuac1g/0qK5Li6+rKi4imr+/0YiOML/PIIdvnT9MirAdTzpx+X6Gel1t1Qh
         ugXbJ58Q6MDG3W+6jAPopELHVxtJZk4uQu+ynhYF/ovQOygTd/XRfwp+0WSAZaS5+qKf
         AR2/9OX6zzDyEAa9Jp+65SrygIbNlQICtrz2IQr/QsyIOhII5ilo5DZIcmW+716/+Xfa
         pFSMvn/IW08crA2OuhcF2t4tbpxvGrbk0O4Jm1PcRrBJVpq24/+tOwi/fuT07WuXa43n
         qKtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778179033; x=1778783833;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x8i4c2z2WoES1t5qSKN6GUknygX5CCKfGDT1oqYJPeA=;
        b=Pav/sdmz6rQ3fwrv3dNMoUnOM42IPqnra1Ma22K6kJp5EZ/tuJ4jzqXq1PE2vnC2rE
         A3auUd5KAE6GeuA4KMsn6XVUzbVdmmUAaOAFO+vcjrsaDB2C+SWHGJQeZA3YDI78xYLq
         JeBoIWcPQ8enMTewX4PLAv9dyzYfG2K578vGuSfyRmgIkTbpfS+sglsUwK4OJdVrttGm
         N4juJS3P+t2K1KBRdmYLHICLKBMKtYbtYFSHBQ0cd9/uZq9NPxxQNQnR/zMWAFNMzoL6
         2R1z2b3n/3QNIpDytw8u9upWYJMAooe7tspHi5aEBGa8kRgDAhzgKteqnw8GYv6qn64H
         fkKQ==
X-Forwarded-Encrypted: i=1; AFNElJ/ntTL8sd5myohd+aMyC+sK1qrollau/FFKDn0VEazLgI3kX0vkShxoxDOTyOGGTISDMlY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7BYgQw4Ntl54W/Lpw4moHoeZs2aeDFf5HZmW6PoeMAku3143T
	nYxec6GJ04/2xrclJ3c9ODCzfZSNMRCXoJn550spGUrHa/v40cUXq7BW6vZOXFaRM+M=
X-Gm-Gg: Acq92OFhjhP6E0Y5we3OkDAyOcK9/x/S9sNLNoPTqB09dIZxc3N2B0Lh6A3iTwaUttP
	ix4z7ghkYlZpfp6vJ7nqAzjqUuAW7qc/HQAggiVV1FamNvNnshRj5aOQn5mIP0pt7+O+QSuglNC
	vwqtRYEtfhri97D/wBjUi+hfN+ZPWTXcZ6Puy6sNkr2E+BPDs/rINmp06i+193WGVIWO2OGE4JL
	CmTM9rwZEJz67e0+y84YWivRgjyL7HH3aErziI9L3DKapwzzBx8uoXl4WhUhSUIB7Gfc7ijfbwK
	/L4DGwPzlf3ufPUFm83qv6rXI0rLrO9tLYpRk0V2/T1VZ2nAOCZLbiEfgNWgQDvSGL/UIgJuA10
	9dIH9QNwMq36x+n2Tsp4ALpt9BOaUXyMKLMx1+WvC8BlDG7Xlqi50Oet6mXzlcyt2FZbKDj6ZoL
	mtWIOLpYoK1auve54GII47hWtkvg9oLFmlu8woNIIHDPedDuKq2UmpxrXnjMm75zxn
X-Received: by 2002:a05:690c:6101:b0:7a3:7ad3:3e9e with SMTP id 00721157ae682-7bdf5e7cda0mr98323737b3.32.1778179033551;
        Thu, 07 May 2026 11:37:13 -0700 (PDT)
Received: from [172.22.22.234] (c-75-72-117-212.hsd1.mn.comcast.net. [75.72.117.212])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7bd976fd09asm57064577b3.41.2026.05.07.11.37.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 May 2026 11:37:12 -0700 (PDT)
Message-ID: <3c78f48c-6478-46d0-87c2-581bb58637dd@riscstar.com>
Date: Thu, 7 May 2026 13:37:09 -0500
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 08/12] dt-bindings: net: toshiba,tc965x-dwmac:
 add TC956x Ethernet bridge
To: Bjorn Andersson <andersson@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, maxime.chevallier@bootlin.com,
 rmk+kernel@armlinux.org.uk, konradybcio@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, linusw@kernel.org, brgl@kernel.org,
 arnd@arndb.de, gregkh@linuxfoundation.org,
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
 <20260501155421.3329862-9-elder@riscstar.com> <afycOwz5TpkegkZd@baldur>
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <afycOwz5TpkegkZd@baldur>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/7/26 9:12 AM, Bjorn Andersson wrote:
> On Fri, May 01, 2026 at 10:54:16AM -0500, Alex Elder wrote:
>> diff --git a/Documentation/devicetree/bindings/net/toshiba,tc956x-dwmac.yaml b/Documentation/devicetree/bindings/net/toshiba,tc956x-dwmac.yaml
> [..]
>> +
>> +  gpio-controller: true
> 
> I don't have any concern with the use of a proper gpio driver to model
> the implementation, but if I understand correctly this relationship
> between gpio controller and gpio consumer is strictly internal to "the
> PCI device".

(I think you're already cool with this but I still wanted to respond.)

That is not correct.  These GPIO lines are used two ways for the
RB3gen2:
- drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c uses GPIOs 2 and 3 to
   assert/deassert the reset lines associated with the two exposed
   downstream PCIe ports on the PCIe switch within the TC956x.

- Each of the Ethernet PHYs has a reset GPIO.  On the RB3gen2, the
   GPIOs used for the purpose come from the GPIO controller embedded
   in the TC9564 (00 and 01).

These are therefore "exposed" (they are *not* strictly internal).

> Is this connection variable or is the link merely expressed in
> DeviceTree to mitigate the fact that you choose to implement the
> responsibilities of the two parts split into two device drivers?

It is variable.  These resets might be implemented by other GPIO
controllers on other platforms.

> Are there other consumers of these TC956x gpios which would result in a
> board designer (and hence dts author) to ever reference this
> gpio-controller in a different way?

They could.  Nine of these GPIOs are exposed by the TC956x pins
(GPIO00-06, GPIO12, GPIO35 and GPIO36).  The RB3gen2 uses 00-03
(and possibly 04 but that's for a PHY we haven't tested yet).

					-Alex

> Regards,
> Bjorn

