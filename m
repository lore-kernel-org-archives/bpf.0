Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEBE329B8CF;
	Mon,  8 Jun 2026 01:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.16.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780880980; cv=none; b=nJJu4fLR4XOVdmvm9ki7CLyhiwDwEbc3P7KOVQFgVxsjs2PguxhJvsqJzdnb3+TP4HlaHN6v19bcK6exOdB+c7MNR//c27Zu77K3W0KoRZBxKzpaT2zSkLxoJ3cnlfmchlsoqzZ64ciIIUbjDsWMxlw1aKF+Y2rsVSdTrOxVqQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780880980; c=relaxed/simple;
	bh=6mFesj4hgoULMnFuaTjtFmFx3IRjOGWujjUMOSGa2r4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GK/RlCP/ul40iqaXSKYTBHPMGR6043MY8cg1kLbraZWUMgDUntGDvn3Rj0eEHrdSeI0O+oqwfhhvMwdwCtoJgROjpWpeaHEf1nC3hFD7DnD4onHrrSPLNSgDdTdU/Z07T0MuZsgz7NoMpP6JhFdDi6Okl4vN8qoo3h6t2f3M050=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=radxa.com; spf=pass smtp.mailfrom=radxa.com; arc=none smtp.client-ip=54.206.16.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=radxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=radxa.com
X-QQ-mid: zesmtpgz3t1780880959t22d2278c
X-QQ-Originating-IP: bXSnog20lGiDAATqGnwBlNDtCTN8ekmUmHTMsQS2HH0=
Received: from [127.0.0.1] ( [116.234.26.110])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 08 Jun 2026 09:09:14 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 6460039914688242846
Message-ID: <3ADB82C061204E67+dec56a7d-f8d1-4be9-9b21-3481a710df87@radxa.com>
Date: Mon, 8 Jun 2026 09:11:44 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 10/12] net: stmmac: tc956x: add TC956x/QPS615
 support
To: Daniel Thompson <daniel@riscstar.com>
Cc: Alex Elder <elder@riscstar.com>, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, maxime.chevallier@bootlin.com,
 rmk+kernel@armlinux.org.uk, andersson@kernel.org, konradybcio@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, linusw@kernel.org,
 brgl@kernel.org, arnd@arndb.de, gregkh@linuxfoundation.org,
 mohd.anwar@oss.qualcomm.com, a0987203069@gmail.com,
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
 <20260501155421.3329862-11-elder@riscstar.com>
 <DD71CDEABC7C16D5+02d052ff-13bb-4712-a847-91416f76c578@radxa.com>
 <7f3a0f16-5159-4bbc-8b15-9b5841603bf6@riscstar.com>
 <3A5C0389E7C0D241+21a4f16b-1af8-46ac-8831-0c1b49694df0@radxa.com>
 <agH4qC74A540koDl@aspen.lan>
Content-Language: en-US
From: Xilin Wu <sophon@radxa.com>
In-Reply-To: <agH4qC74A540koDl@aspen.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:radxa.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: MDqtQ4jGWXAGlDFsZ6teNi+ri0nkei5XfBZpP5QcO66nK0kgvh4BCaQl
	Xv3oHRWmoZLiQ1NbhcZ1qXlPzIzEJ8CqCdsiu47q1Qn6F76e06528BVQ1LttQpUElnXfWVs
	kxFAJ5ytcLC+VfARgmM31sq/2b7QO4PBBqhPnRI7sEDHqvvdwWDlv25MBk4KRA5bS4ucica
	5LXUd562FvcGSuV/5jz0F2qItoNRjuYDfdVQn9Ufko3tz9ITXa9kLpaJH1DOIfOljiaTiM1
	cm52MZ00AVEtz1epYd6lC8nyXQS77iE/Nko7iMytc+1tKt0H9lpaJW2fU/Q+dreKRRXaU4J
	C7KZ1dJgfuieH3e5gBQzDZDgdNF9MhwvyNGQnczkg5M1eMnXrNypBMqTuOgGwJtDM7zXH7T
	aL14LMPGqcut5WI7xpDFRVP8byDTHWJAF0aHiyGCVMlnVA9PHSMEzmSQ1nR2Y9Q476BFRC4
	gZ3uTWWAKoUYbVPo0C2RjESWKWJUvHeKksk+VVbEYED45ujiEyjt8JVYaLp6nF9FaLzQANb
	3rmqbPC/KMz+HZqvZE1vA0v13aS8u91Icyj4o41fJLWWreLEHmjko1yNMcIHfWgdp3knZm0
	zGGPju3+xADUZ0IAFNwX7Aj33LiSbUsJ14uyp9uCjpNAT+xhmIuRRR4ZwaTyMf9QdBjZYPQ
	2V22HYyjxivhLUFwTshRzC2ePMWyy+Z0fLfk2NUsbSZvEqDVKz/EeiGt98AXC+5a9OlRwcq
	uVRELH4XNH4e4pA1gRUXqDQD6v7yszNBTvvQHJU8GcJagoWLLtOj/iADYboC++zeJvNNxaA
	E2TS0jDnuvz+w11mRTOXml0xp3gU/6kcR9TVoPfyWf/966uwZSurnynl9XARHO4uscGHhhx
	+ccDGOym4uCEc+bnxqt6u51SoQ5798+mxa8gFXpB2rM0r9RS6OuvQaZ5YX6r5XcQ06LtkLC
	E4pSiQZCCa4RLLhuYmOGEpWqECYxcrP/FnHHjJifpUyFaMsNg69x+ef6ilhHzf4s4J7M=
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
X-QQ-RECHKSPAM: 0

On 5/11/2026 11:41 PM, Daniel Thompson wrote:
> Hi Xilin
> 
> On Thu, May 07, 2026 at 09:57:26PM +0800, Xilin Wu wrote:
>> Do you think if a shutdown callback like this is required? It looks like the
>> driver sometimes does a MDIO MMIO read when the PCIe link is down, causing
>> the board to reset due to SoC side PCIe NoC timeout.
>>
>> After this change, the board can always shutdown gracefully.
> 
> I've preferred controlled reboots to power cycles throughout development
> and I hadn't spotted any major problems with graceful shutdown (which
> isn't to say there have never crashes but generally I expect `reboot`
> to provoke a reboot successfully).
> 
> Just to be sure configured my board with irq=POLL (to match your setup)
> and still can't reproduce.
> 
> We mostly run Debian/systemd so there might be something happening in
> userspace to sequence things nicely. However I have ruled out
> NetworkManager.service and networking.service (stopped this services
> does *not* tear down the network link).
> 
> Can you share a bit more about how to reproduce the problem (including
> reliability of reproduction)?
> 
> 
> Daniel.
> 

Hi Daniel,

Sorry for the late reply. After some more investigation, I think the 
problem is more likely related to the PCIe platform driver rather than 
this driver. So I agree that a shutdown callback is probably not needed 
here.

-- 
Best regards,
Xilin Wu <sophon@radxa.com>

