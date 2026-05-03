Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FA5B1F12E0
	for <bpf@vger.kernel.org>; Sun,  3 May 2026 02:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777773996; cv=none; b=N2ygEzzB0wennMfOLqprSbJpSK5o9l5R/wZFDIJuD1ou/W1vmSmbz66RPKNypxS9/buyoBCRG1mptNI8RJ8XFPtjbtHge4X3P5V1AIMQgMKPc1L1+jaM+P2dEmuPeCuEvgSTWarEoveCZ2l0s7b3p8Ai6h0BMK1OxIYD0HcW0gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777773996; c=relaxed/simple;
	bh=qTcHuUwch6LxOFnkGYTL4CalYWxKwr9/UP8XDKGTT/8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YcjZyMLTcrHtcGQui5ihetZO4EqS1sdXsuW4Kp+lwEtHRnxUENysLu/eq8NCyY7KEHyynumpmKel0rP4q+7xw/O9LvBT1LrZWyaIWSHb8DW7mV2Xs+TImCuGw1sqmyzeBrBTn+0eMeCE3/4ZsKBQ4Kd1byJ+TzQBmsyB3VKmvLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=IcIA02mK; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="IcIA02mK"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-8f15e900586so144369985a.1
        for <bpf@vger.kernel.org>; Sat, 02 May 2026 19:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1777773992; x=1778378792; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pi7lj8hY/RV2kHI36GdoypDFeZXohRaZRLU99hRCU8E=;
        b=IcIA02mKrh9cSLWZmfS2DujBZyk8sv50e4HrhVIIw+ClMHZKas/ZydC0ERbuySKjOa
         XLw25N3UJB2JWpKFF4/kd+OjeY8ro+3aHC1M9EjhAwZZoGYB4zKaQiLwqeNguRtvTRgt
         hwHisICTRc41PvUcNPyDT1gZem76y/MnSkeT1OF/kEEHQ30nzug1LtixNapAlmj81xZq
         XgNyZB99TvfK4TKtTyRCXvsefrR17Tc7f9YL3sfvyUkPrdHfpL0FnPu336AcRIIVJ3DD
         9434m04rZZtrSWigXZMfJSZFzgZrm8WpNyoQQFGf+6finIjld8BrfC0hKZ+mClFb+Z8+
         sbKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777773992; x=1778378792;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pi7lj8hY/RV2kHI36GdoypDFeZXohRaZRLU99hRCU8E=;
        b=duBWa4BpxP1Q8/prrRqcn6VWwr4+saAFKhKOUHMAFvtW0S7goDKA6tSq+vwnWWaSKE
         SCQUQFXqtub1a/C/oUJMngayGt26QLAJB2mnirEKuxc9rVtJbnJ0GpkUIXaHYHFo6tbh
         AJT7ve1FcucE1snlXoTcHakkWZsH+VNxSIJrHln4DBuzr7Pql6zUmsqbxgoOuRVqu97u
         RMxk3w3W51wXKk2vUtMiW+BRUqvzzj2GMR4pe5V1gg7UYyQZuJyvVmFU0/0TBSsVhW+F
         Ep1vvkiArCzLekesTzPegpJe/pxx4UVOugg/j3dwLLK9JiwNBv+eterLWFyX1BbNPdMp
         BhLg==
X-Forwarded-Encrypted: i=1; AFNElJ9bgiBl2rCuS43Yecagq9Vcd5DimYOi3zbM9o9dKBhJrs3x4nxGGq1z9K2LXfGMH/SzHRU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yza3VN55yD9f8rMBP8dxfpEgldYRn1glB3cwKi58vpa1l0s/rJX
	C87KCy1nPpjrnb7eAbaRqmKqp8aFxIwURiUvObyoCVVU5otCztwVo8zOiIJ4/JHy73E=
X-Gm-Gg: AeBDiesin55U+pdrmg2KvbmcBCc4YCU8Vm7Eigg7CYW6qnpGTZfk5dybir9igPCH9td
	1Ntrehczo7GpzMq3HHeLTjdX7E4vBaiZbXQWwsvpB+SsyDdMbbGT9uF7Hzr2i524MzeSj3ZmgI7
	LM6gvzCwf8fGDdcs489IwToU9bsRGnSyFxibs8twxB9OaRL2NQpOwUE7SsAMc/JEqcB8dtwfnx1
	jo/KpnNowd2Kldt7nO9CZuuN0Bz1d1NlcecwR34Oa/VaXeYMBLBreHExKOi0CYumEnb7GTekG3n
	+uK6Fg1XVyVvTIHoozh4iy3oMsSHiKjyd5VHQ0eXsIjJOHSDU1bCnxXlydPF8AlB4DtzGn8TcC1
	BAglGE5c67H51QfGW8fZ+PrhFEdXZ6HLgjJuVIGYoUnni9uW26tUnIds1DDoBbBawgESwQX0nRI
	stEo1VNt5JW0+QtrdIP9z2jnL/Ye9ZsB5FAnFT7JBmieNYWRuYUwP9Fms7GUiH9Mf8lZwlsOvl+
	A==
X-Received: by 2002:a05:620a:4083:b0:8f1:5e8f:ffe8 with SMTP id af79cd13be357-8fd16aa97ebmr768552485a.23.1777773992247;
        Sat, 02 May 2026 19:06:32 -0700 (PDT)
Received: from [172.22.22.28] (c-75-72-117-212.hsd1.mn.comcast.net. [75.72.117.212])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b53d831ac7sm72634806d6.49.2026.05.02.19.06.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 May 2026 19:06:31 -0700 (PDT)
Message-ID: <083e91d0-d86f-4de9-a01f-ce44eadacc13@riscstar.com>
Date: Sat, 2 May 2026 21:06:28 -0500
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 11/12] misc: tc956x_pci: add TC956x/QPS615
 support
To: Andrew Lunn <andrew@lunn.ch>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, maxime.chevallier@bootlin.com,
 rmk+kernel@armlinux.org.uk, andersson@kernel.org, konradybcio@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, linusw@kernel.org,
 brgl@kernel.org, arnd@arndb.de, gregkh@linuxfoundation.org,
 daniel@riscstar.com, mohd.anwar@oss.qualcomm.com, a0987203069@gmail.com,
 alexandre.torgue@foss.st.com, ast@kernel.org, boon.khai.ng@altera.com,
 chenchuangyu@xiaomi.com, chenhuacai@kernel.org, daniel@iogearbox.net,
 hawk@kernel.org, hkallweit1@gmail.com, inochiama@gmail.com,
 john.fastabend@gmail.com, julianbraha@gmail.com, livelycarpet87@gmail.com,
 matthew.gerlach@altera.com, mcoquelin.stm32@gmail.com, me@ziyao.cc,
 prabhakar.mahadev-lad.rj@bp.renesas.com, richardcochran@gmail.com,
 rohan.g.thomas@altera.com, sdf@fomichev.me, siyanteng@cqsoftware.com.cn,
 weishangjuan@eswincomputing.com, wens@kernel.org, netdev@vger.kernel.org,
 bpf@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20260501155421.3329862-1-elder@riscstar.com>
 <20260501155421.3329862-12-elder@riscstar.com>
 <f9336d01-e2d1-4894-848a-17ab20976872@lunn.ch>
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <f9336d01-e2d1-4894-848a-17ab20976872@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/1/26 4:07 PM, Andrew Lunn wrote:
>> diff --git a/drivers/misc/tc956x_pci.c b/drivers/misc/tc956x_pci.c
> 
>> +static inline void chip_reset_assert(const struct tc956x_chip *chip,
>> +				     enum reset_id id)
>> +{
>> +	tc956x_reset_clock_set(chip, true, true, true, (u8)id);
>> +}
> 
> This is in drivers/misc, where the rules might be different. But in
> netdev, we don't like inline functions in .c files. It is better to
> let the compiler decide.

That was a mistake.  I agree with that perspective.  These functions
were moved out of the header file because they were only used here.
And in the process, I neglected to drop the inline.  Will fix.

>> +static void chip_init_state(struct tc956x_chip *chip)
>> +{
>> +	/* The only IP block we currently use is MSIGEN */
>> +	chip_reset_assert(chip, RESET_MCU);
>> +	chip_reset_assert(chip, RESET_MCU1);
>> +	chip_reset_assert(chip, RESET_INTC);
>> +	chip_reset_assert(chip, RESET_UART0);
>> +	chip_clock_disable(chip, CLOCK_MCU);
>> +	chip_clock_disable(chip, CLOCK_SRAM);
>> +	chip_clock_disable(chip, CLOCK_PLL);
>> +	chip_clock_disable(chip, CLOCK_SGMII);
> 
> With my networking hat on, this one standard out.
> 
>> +	chip_clock_disable(chip, CLOCK_REFCLK);
> 
> The name REFCLK is sometimes used as for the clock signals for RGMII?

You're saying that the REFCLK disable stood out, and you want to
understand what "REFCLK" actually represents?

I believe this is an *output* reference clock signal generated by the
TC9564.  Looking at the schematic for the RB3gen2 it leads only to
a test point.

However I want to compare notes with Daniel on Monday about this.

Would it draw less attention if it were named "REFCLKO"?

In any case we can add some reassuring comments.

> 
>> +static int
>> +tc956x_function_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>> +{
>> +	struct device *dev = &pdev->dev;
>> +	struct tc956x_chip *chip;
>> +	unsigned int msigen_irq;
>> +	int ret;
>> +
>> +	/* Despite being a PCI device, we require devicetree */
>> +	if (!dev->of_node)
>> +		return -EINVAL;
> 
> Might be worth a dev_err(), since it is unusual.

Good suggestion.  I'll add that.

Thanks a lot for your review.

					-Alex

> 
> 	Andrew

