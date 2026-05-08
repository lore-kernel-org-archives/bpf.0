Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB2C3EBF16
	for <bpf@vger.kernel.org>; Fri,  8 May 2026 14:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778249028; cv=none; b=FOVbIUqPtu+J4QQnnMH9svPc6UJ3LDIKpwxkjuSlT3vK9Ey7rHxkeDOZDQFpTlqbcYrwtceEo9MO7+yrXAYFr5uwtnoMyT61FcHy+06RocXRv/2Q4t8GPWQTRqGufxTxT2ih7W/OF928JccvH6hdkD6tZ9v6dvcZArngck5rM58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778249028; c=relaxed/simple;
	bh=tVLN9H4wXbxCspwoH2tS6QtKKtprn15Te8BRG+V6lVg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WOkdac+Zsi9ilr6iG2uVMZ+QWuboFpDV4vaRGik+q+x4oYcwC8fqcSA8PKGO6wSxwVLubLLk7fUP9Mq+JpBbCawbH/alQmNHEC01Hr3B6kfggdOqDTPQyZohRjeOhR8RRP1K/xXiMyBKJAhQ5/pat3wk9QAIsVOGFi/eEA1Usxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=A/sY6KHY; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RAgxulmI; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="A/sY6KHY";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RAgxulmI"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6489iHVR2770840
	for <bpf@vger.kernel.org>; Fri, 8 May 2026 14:03:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6PaLrzZ/Tau/BNFGUX9KOBZJHsqcYNs5C4hkDbabRvQ=; b=A/sY6KHYIFcKhS94
	NhiWomB1DvClA0fBtyGO6SgZcMfBuYQ50w+MPtem2yUW8HZxGwFdM22iBWMXYWEK
	SPLwfIZ7yqcelZQLTFFzBrIEfpTVEPX6pSmM8dQ0fLc77cdDpBzRCkgOnUQXs5xo
	hrvbnHXiC1I2Yf+kaO2ruFaVnrfojf4/+Rk9k5No29B4iwKmlAjb0mIp4lYGLjHK
	jMfMZHNnUXlr1+m3x4NrTHDxRXBgOprkfUICLIXLX2sj+tPP026KpsDia3MPJNCK
	C102f0AIeG6Q9UrWboM111YS23g0oJyYeng21kCsv3dqgcJYLEx5N+4tbmCl6Ftg
	KRL3NA==
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com [209.85.210.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e0yt5m3xk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Fri, 08 May 2026 14:03:45 +0000 (GMT)
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-7def9da8485so551124a34.1
        for <bpf@vger.kernel.org>; Fri, 08 May 2026 07:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778249024; x=1778853824; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6PaLrzZ/Tau/BNFGUX9KOBZJHsqcYNs5C4hkDbabRvQ=;
        b=RAgxulmIV9ITf0LZ0rgjIy+Y16/dkHdgdyAIufxSZKriKDoKOSsmzlbLh+ncsMyfio
         l+MkwJ/xTaIFblmmAnw5HzLRHeHxPnibebOXl+2N7NVvXFR3VK10pfFCWw4RlT2gYq1s
         5+eCTX5FmlTtX67Lx/eY+cTysulXK97B1iSDWTEbDH3N0BU3Sk5nZ67bny/eY6ssvwcS
         59Iq636N+RssjJhBRVfuZ0oD5jGmdv1YJZlIqUnUrcCruRlsvnORnrRN5pRlhc9/TR7p
         rVcUmGhMnJDaRalPmFgb3ngd0aailqCqqzWokZh2QlvE7/x8yJ3qvurDNQM0WxuSkXYM
         fzrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778249024; x=1778853824;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6PaLrzZ/Tau/BNFGUX9KOBZJHsqcYNs5C4hkDbabRvQ=;
        b=OslzK4MXs1Qhj1+1s8OICD5WUWj2wEYkbD0vp2lN8yZNtrWTcYJNfO06Vwlmu/nUaB
         w6gL/t4PMJYpUZf9HuavF1jQE9epy/2vz41Ar7Qssd5gb4nJYrhaOJccVvSGaGteYzrW
         x7eZr1V8oEN9r1kpBFznbbSSIZlMF54tgKwF9D7urLEuiw7iMGMMi1EKrAbKAtqX8AnA
         KhnbWIxugdLVrMXokFmOQmY8/hfRjmA0WBuRhbOEjT6ycYyeF9ZP8O9tzZ886LnSyKVf
         XdQKMYfGJ1YhfDYFge5rX4uShANwitd715K8tHX9VU9KPg9e9fVMfPUstnDPQzx0iDS5
         jSgA==
X-Forwarded-Encrypted: i=1; AFNElJ86AiLoTbD4ws3LLQvoILi9sTtVKL4OvGZxKHWLBOYaaN3NNPJu6SOh/VwNlNXXwrU1IcI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBGygvQgWXBZ7RqrzSuOfgZCpsPuEqC98KZF4hVvyByj+tZyMC
	VBGZ8gHpzENf1mmxii3Oaa5mSE5f4DcNfQrAU5QB92aPsGs6lfTwNqgSXaucyX5XQVbQJ5/q/Fj
	ib38HPt04RVXUXsAscfJtI9bKtynLSZcstLB4+3EdlQ+x25HToX/P5qM=
X-Gm-Gg: AeBDies3j+ed6rSoHIXawKsuTgb8pMDtR3o97fPc6KjQtbn2UWdr5GJFLXZnESk7RUS
	aR5Gwl3fqQz1LP3Hp2gMxZgvdqWE1I6SjznHj23Lng9H3EB0yIK4FxEV6ynuqC5DTlFfaO8lxqK
	vKB6AuXvFGvAG6jyww7EeCCPaqhtx7i6K8iu6nmrx4vENJmIJi5KjONCd6ZFdt3jYC3ekUg1Qlh
	ZevADqST5iKq+yGc/3r99CIEZEDuGkCom1PqAAN80VvzMyhGdGT01iYnZBjuf+PHUiRYoid62ve
	9+xLsd5qn3KxajDx0ko3QzWxHEGqACQ4AbsxwmDfj+Mzf1oHYLCuOdrHhqmTEqxWexhdSK4GKjI
	nICLV8byffRJf9TAfS5pDhzqBzgDhpZe6/o4F0TrcWZZ6aIR78FtgprwreTPgNGOm+k3XDMWQvf
	Hbpnk=
X-Received: by 2002:a05:6830:2b29:b0:7dc:c31e:7823 with SMTP id 46e09a7af769-7e1df018fc4mr4435627a34.4.1778249024109;
        Fri, 08 May 2026 07:03:44 -0700 (PDT)
X-Received: by 2002:a05:6830:2b29:b0:7dc:c31e:7823 with SMTP id 46e09a7af769-7e1df018fc4mr4435567a34.4.1778249023494;
        Fri, 08 May 2026 07:03:43 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bcac4358cedsm87169366b.47.2026.05.08.07.03.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 May 2026 07:03:42 -0700 (PDT)
Message-ID: <01d6ea18-e022-41c7-a642-ac0321957923@oss.qualcomm.com>
Date: Fri, 8 May 2026 16:03:36 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 12/12] arm64: dts: qcom: qcs6490-rb3gen2: enable
 TC9564 with a single QCS8081 phy
To: Alex Elder <elder@riscstar.com>, andrew+netdev@lunn.ch,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, maxime.chevallier@bootlin.com,
        rmk+kernel@armlinux.org.uk, andersson@kernel.org,
        konradybcio@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, linusw@kernel.org, brgl@kernel.org, arnd@arndb.de,
        gregkh@linuxfoundation.org
Cc: Daniel Thompson <daniel@riscstar.com>, mohd.anwar@oss.qualcomm.com,
        a0987203069@gmail.com, alexandre.torgue@foss.st.com, ast@kernel.org,
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
        linux-gpio@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20260501155421.3329862-1-elder@riscstar.com>
 <20260501155421.3329862-13-elder@riscstar.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260501155421.3329862-13-elder@riscstar.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Dc0nbPtW c=1 sm=1 tr=0 ts=69fded42 cx=c_pps
 a=+3WqYijBVYhDct2f5Fivkw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=ee_2aqc6AAAA:8 a=lW0hg0oAPnnF6MRRTAsA:9 a=QEXdDO2ut3YA:10
 a=eYe2g0i6gJ5uXG_o6N4q:22 a=VOpmJXOdbJOWo2YY3GeN:22
X-Proofpoint-GUID: dJ-Yxtn3uazOcPU-vgclhW44tN3-1vKU
X-Proofpoint-ORIG-GUID: dJ-Yxtn3uazOcPU-vgclhW44tN3-1vKU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA4MDE0MiBTYWx0ZWRfX31amQLgyZ/rv
 KnYDU/mJOhpE6sFTBzWlFWYWDYnM8dx/7SSK2ZRU79BcrJzYjAg/T8tcrov9yReXTRaIj3A5NWw
 tKH1jRHjf4tpHEdJNf+kJhM8n/CZ0Dr7tCfY8P3S2LiYdJ4Ec8ihKTI51GXc5r3r2spIFqfgCOr
 gldswqAGfYOFUbKN67eCPZ79qI/WbrYBQGb5xdcRZoQkccYg4cDLyQHEA5TqtgBjXIW0MWkP/JE
 eHaZfv/oR5mkdh658TxHXcVYEW/Z552jzz9nhko5319C3XAqKdoHkxMeLH2tD7/9K8bBl0coUy9
 1xxcly57NaKIFL+YhWYy/OjxtpziXXwT4K/Cma+wldP+FkiHVXKPdhCtzXP8ZIZOTXodOinc+wE
 o06zsZjioHHmGFehZFV2XzhgSliIMi0HQ1BgImUHzGCZaqKV+o74wvz6u4EdOikxSQML09sXchM
 UL9bYRuEmxhy+lZZEag==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_02,2026-05-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0
 bulkscore=0 priorityscore=1501 phishscore=0 adultscore=0 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605080142

On 5/1/26 5:54 PM, Alex Elder wrote:
> From: Daniel Thompson <daniel@riscstar.com>
> 
> The QCS6490 RB3Gen2 includes a Toshiba TC9564 (a.k.a. Qualcomm QPS615).
> TC9564 is an twin Ethernet-AVB/TSN bridge with an integrated PCIe switch.
> 
> There are multiple builds of RB3Gen2 with components included/excluded.
> That means whether or not there is a phy attached to eMAC0 depends on
> the exact board. However all versions include a TC9564 combined with a
> single QCS8081 attached to eMAC1.
> 
> Add properties to the existing PCI nodes to describe how the TC9564 and
> QCS8081 are connected to each other (and to the host SoC).
> 
> (Note: "pci1179,0220" is documented in the "net/toshiba,tc956x-dwmac.yaml"
> binding, but checkpatch.pl doesn't recognize that.)

This should probably go under the --- line

[...]

> +	qep_1p8: regulator-qep-1p8 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "qep_1p8";
> +		gpio = <&pm7325_gpios 8 GPIO_ACTIVE_HIGH>;
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <1800000>;
> +		enable-active-high;
> +		regulator-always-on;
> +	};

If I'm reading the schematics right, this is only required for the PHY
- is it collapsible, or does it really need to be a-on?

[...]

> +	qep_irq_pin: qep-irq-state {
> +		pins = "gpio101";
> +		function = "gpio";
> +		drive-strength = <2>;
> +		bias-disable;

There's no pull-up onboard, should we use the on-chip one?

Konrad
