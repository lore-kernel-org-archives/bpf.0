Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 696D22405E1
	for <bpf@vger.kernel.org>; Sun,  3 May 2026 01:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777772755; cv=none; b=OhM01mPaejXymG1EZsT4Yit4TuHrgu8w9TgsXnvJzueiAz8i7NruMSqzM5bq2UoyN69WjUe0kbsz7nldwjcnMn/xD6iN6iHyCZGSgvhA48XFOtBHz/g7vJX0TklpXsc4AknyJrTRtO33vxC9m59No/qEoKj5D6zkN3I8fqm7GSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777772755; c=relaxed/simple;
	bh=YKj28Q85niDGU70q6VNatHef1IVTl7zI9IJbJKkrDqg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hT1b4EUvHwdPb07xfCOOH6GNN5b+oRbCRCuO5yXOoYVm/wiL4kg7pfcabmkcZajIdZLsa1/Q8D7NHuaxwI9ZCRZvjYMbqmtWpcBRH6/4+hZeS9r7t8jg9g1y/7y1q/pbaM1wnHN2y06taXI96mwEj8skE6yV82N/qRZwF3JYLWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=jiEwwJEI; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="jiEwwJEI"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-8d933da14f0so324905085a.2
        for <bpf@vger.kernel.org>; Sat, 02 May 2026 18:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1777772753; x=1778377553; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=k2VDIdBulUU5TGbhBANhJGFN/QeEIFSIYNJHL/TT6dc=;
        b=jiEwwJEIidVBpn5VKvdaqyut0STQFn5mUin1j0c7CPH3JyqMyIemYiIdKm9lx22P81
         sv3BQST9ufNYY5RSEqNxV3ydmGcdP1P9DKRRfCF/5VLCbkV6KzJqtEfwrP7XxN7jBkVY
         3jU+aJxY9wP68cm09MacVfg8HbSfAvnFojocv4c4fv1kJ3r4vGRF693QpbgFbJZNZYHm
         J9+kpgPA04Up0whIt4myKwa9Jrr13USBrhogdKpVf+nKoicoHY/Mhr+9Yzv6lxXfccbY
         PLOCKahXZZEwa6PRj9NvYXtyz1209AcMuvvlNoRYrWPVFUrhTtGhdFrtL1ARQTGX/ijI
         b60w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777772753; x=1778377553;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k2VDIdBulUU5TGbhBANhJGFN/QeEIFSIYNJHL/TT6dc=;
        b=gIvLBzpFx17I5PHl3FpP2Qdv3ErKjxgvkDM1Hd+RAJUNKtbIFxz3gIcDPyfYr3YmTR
         PYEobBCl4DtOt/6MzSlB1oYhoKDaPGLYEeBYTTm5f5olA16bAko3a53NLwi6Qf4CX8R4
         +s0INkgFPW28VM0tBqS79evk+/2yOs/ZaW4weQO91FPPhSBYbJ4iJyGhqimpLQhZ24OM
         FN3OeYPb2bc9DiGwRkmch4smE6o6lf1OyC+qT92ZB3lyN3wv68aHHRthc0XwpDKf3i9b
         SUvF5uKlezPpKklw6RrqXLvRKyHq6wqlH/n09+fBVQ1LP1vZMuFEPsYG1jXtXIo8ca4T
         zZpA==
X-Forwarded-Encrypted: i=1; AFNElJ+Wv6MftTQ3YS0j4LIJri/L/+A0mRDdBWeu8WCmI3gyf8g3LRZHPtxFDjpY5vXrP45NQX0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFaNV6Ca/4iahFD/SeDfltUA/mzTZUkoXSd+Maua5aQAWpiGwU
	xU6E9bBWM8sEo8nByksIHIebqcVBoyA5BHSNn2YIV1GKEXwv1WPwDxCl+hLiiyUdC14=
X-Gm-Gg: AeBDietFWM1qbIWcjE/kebPX2mWGyILu1Aro0cJ+d4P6kdHaoJbc/+5tq92QxAoSqqg
	qCpXIBIflvaBiOwdc1xXboi376Ri2v4QUdWEFm3A8mrC35wy5iLhsxcfN6/lm0ZpjUi0tnDhFr2
	c2Rgh4S0PJ5aBivTd+edw0QzdjClvkS2Kn+CmISkdxQ4DoWQBt2TL7UWk0411jJZd/2EmfjE/ir
	bmpkVzZSwIc3VxJU6jD6exvgKKgRy5nVWP0GMYqVTLPf3goINyJH4rwnyfybx4dQt+oF7gmopsO
	aImLcOiU2iswD6q4PQ4xPd0X5RszMN3w9tqoVIOl6C4aIbkJHs3vQGfeUmk9Z329l+NZzXEGGrd
	YnhvFfys7zqdPmev/qPY/g4WFAk4zZCaSqmBmSFsnpmWzEVR97nvGe5JBGIDc+AddzYmhI01XTv
	hbpUggHD0PKfK97Pu/oWSkcOkNxhL4JDH97dDyQKXG7vKvX6K0zCrIJrozykczgKVI7U9FO9YHA
	Q==
X-Received: by 2002:a05:620a:284a:b0:8eb:10d4:a471 with SMTP id af79cd13be357-8fd17e4b6c1mr769719785a.43.1777772753243;
        Sat, 02 May 2026 18:45:53 -0700 (PDT)
Received: from [172.22.22.28] (c-75-72-117-212.hsd1.mn.comcast.net. [75.72.117.212])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8fc2c9229c8sm680230385a.36.2026.05.02.18.45.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 May 2026 18:45:52 -0700 (PDT)
Message-ID: <30cec7dd-ac3c-47ab-896a-c29992bd5ba5@riscstar.com>
Date: Sat, 2 May 2026 20:45:48 -0500
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 09/12] gpio: tc956x: add TC956x/QPS615 support
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
 <20260501155421.3329862-10-elder@riscstar.com>
 <736fb3b7-c88a-4ec4-96ad-d1b79cc48d30@lunn.ch>
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <736fb3b7-c88a-4ec4-96ad-d1b79cc48d30@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/1/26 1:36 PM, Andrew Lunn wrote:
>> + * There is a TC956X PCI power controller driver that accesses the
>> + * direction and output value registers for GPIOs 2 and 3.  These
>> + * GPIOs control the reset signal for the two downstream PCIe ports.
>> + * Their values will never change during operation of this driver, and
>> + * this driver reserves these two GPIOS.
> 
> Why doesn't this power controller driver actually use this driver to
> control the GPIOs? Chicken/egg?

I am not the one with authority on this, but yes, that's my
understanding.  *Something* about this chip requires that the
PCIe ports need to have some configuration done on them *before*
PCIe is powered up.  So that driver uses the I2C interface to
apply these settings.  Meanwhile this driver uses the PCIe-mapped
memory to manage the GPIO registers.

> Maybe add a comment why gpio-regmap.c cannot be used. You probably
> need to instantiate it twice, but i still think you will end up with
> less code.

It's possible gpio-regmap.c *could* be used.  We started with
vendor code and this code got separated at some point along
the way.  It was working, and I don't think I pursued other
options at that point.  I'll look at this possibility before we
send out the next version.

What do you mean instantiate it twice?

					-Alex

> 
> 	Andrew

