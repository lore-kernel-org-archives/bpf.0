Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBAA84611CC
	for <bpf@vger.kernel.org>; Thu,  7 May 2026 18:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778179160; cv=none; b=m/QPg25lidUiQ2gbZ5QCabpl+j6hLjnALbUcFww5O45064DdZ9nDRvr878ZC+KA/bQeGlB8KNeSrQAXfOiH6BHdYBfpCSu2VL9zMEJamuBSc1yZNksKVckWoPyXhAdrD7ivKTTyJ1PgGYEH0YN2qlyrQ3DT6A+nVTo3Lny3Jzg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778179160; c=relaxed/simple;
	bh=f/VYt86QfsV33lO5nWhjommtwvlcryeqI+nt7Vqb76c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ts/rMptovNoPkppczk2MbekEVbEiMyrgJF7FWa01fDAMJaN6BA9JEv3RiXM5x3bTh8HuG8Wu4TXJ0EG7PnsXKrRhRgevixLg77UIM57spHwMZ3Ftg6uPZnApET1iwq0Ovn+0ol90zho0qi1cnyXws98SWUd9aX6whIHDXpYDpDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=sETjafTP; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="sETjafTP"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-8ed4dd182efso78498185a.3
        for <bpf@vger.kernel.org>; Thu, 07 May 2026 11:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1778179158; x=1778783958; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xAxf1DNF2nC8sz42taPRq/pgsGcKQpqrWaLh7UNAXF0=;
        b=sETjafTPdUg2ii93kH2SRdQpxIDwlHw++/Udnl0YvFhjKxo3mfpZymbm3zCbgKWwy1
         ZZTG/CwjDVG41bxom74SCHnJU+/7a9q6J2hC8o83bgco6Dr+7ETgR8oAhevz4ocMQDFX
         Ljcf7sSF83yMY1IdGcMdSDhhLa5F4ccPXRZr9o4kt7J8RlHc4eMCYebqQvQRTxtJPweY
         CbSHWFRgCs3jlhl7Ba3jBV+nkiOcv778l8CV5M7TCIdT8z5yhZMO1VXKgy2ghAU+ztSA
         rPjKoKJOaL9XsTVzUnI29jx+V0ofMTZcgeaBGW+QSjNrvNhH5sSNkCxFd4FPz2sDDIiR
         oyMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778179158; x=1778783958;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xAxf1DNF2nC8sz42taPRq/pgsGcKQpqrWaLh7UNAXF0=;
        b=cwaF2YolAeZBrU+hdPVskV4ffDRo3Ff5MLOmn5kbh54H2aYp5JzsxwelnYV30ILmgn
         CSYfzUC+L48i+7rPhVQ/HObc+bCjUyz8sVx2SQgSpgSUQOdmmU9g88jyaUO/4zL4cnyA
         ZXEIRYeGX49b4Ow+5cETjlciheN4nnYVE9cUZ4d04bdx/9sgqjlfQFug/HwuG9pK4WnV
         7LorL4vCI73uvIgumRWBrCtXZxXclatXKV7RL4yornd8PDbbGGpgaDpC5Y8J51NIl0Ri
         15Tv5oF0FGM/hDK8NUjUEf/+MvvMvDZ1scLji76m+MEH0Us3dMBaKcoL6eVbQVVqvSXf
         rQAQ==
X-Forwarded-Encrypted: i=1; AFNElJ9N26koySPQ0f4gKez+/vCpBVSO6e6jc5kJvCARJcUajfGbDoyeIMZqY37lneaEXOLvxEo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNGtD6afpi2IhSFoJJXBywEoI56pAeegqVZ3dEFdU1Y2H3xXs8
	xPVNpIF4gc7PXpCkU2f1DVLRKyvUdJlz9Exy7Au3yquL8AC2/70qvTiy7FEhhUj3zvk=
X-Gm-Gg: AeBDievmwI/6H5VxXmnDPBlIF9SLndODPn1KvrTCq9kA2aQpH2NjTSrDknLNh5iOYNZ
	XXXim7HY7nHrUryth1MmNkWXe2dx9NtLbvHzjeJ+CZtNm9vMOjVG7zH2greoPMF29cKH1Sun/9k
	EWN7R/f2OygEgH3NVxk0SBtMBmPGFsS4Om3K155j4hDbP+NBs1fKaK/0s0acBESTKWOXoFejRnj
	D6uWkjZXOpF5FlR59gSL5IPE6xs13vrTwCDJ5zFAnDbKwrhyj6uHDtlPEaJALeghC5XnQ8Rft+T
	FbJ5DciKr7Vp6qIswpAi9U6lX9MHnWmrvRaAbwxsCAMcqahTsbIHWqk8Nh4ZiPtw93RYIOltlcd
	lKegEUq4oAidqPFwtIZokIHeg1I3hL4MxcWaA0oRkz1isOTqs66buwBkjBZX1X7KieB1VOGHbwk
	pp76+qoxLqiXkCMYeacNeigPlZBCsDSip0hQ2Otii6opXA1K0Jw3Xe2J9OnvDCqU0O
X-Received: by 2002:a05:620a:40c9:b0:8e9:13ea:a0e1 with SMTP id af79cd13be357-904d496d4abmr1387402085a.18.1778179157638;
        Thu, 07 May 2026 11:39:17 -0700 (PDT)
Received: from [172.22.22.234] (c-75-72-117-212.hsd1.mn.comcast.net. [75.72.117.212])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8fc2c25324esm2298627185a.23.2026.05.07.11.39.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 May 2026 11:39:17 -0700 (PDT)
Message-ID: <20903580-85af-4e7b-b3dc-b8de49bd32c1@riscstar.com>
Date: Thu, 7 May 2026 13:39:13 -0500
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
 <30cec7dd-ac3c-47ab-896a-c29992bd5ba5@riscstar.com>
 <3e5a42cc-53b8-4065-a32a-d754be40b4c7@lunn.ch>
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <3e5a42cc-53b8-4065-a32a-d754be40b4c7@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/2/26 9:48 PM, Andrew Lunn wrote:
>> It's possible gpio-regmap.c *could* be used.  We started with
>> vendor code and this code got separated at some point along
>> the way.  It was working, and I don't think I pursued other
>> options at that point.  I'll look at this possibility before we
>> send out the next version.
> 
> The GPIO subsystem has made a big effort to provide generic code,
> since GPIOs are pretty simple things with a lot in common. So if the
> generic code works, or can be made to work with minor changes, you
> should use it.

Yes, I can confirm this is what I will use.  As mentioned
elsewhere, LinusW provided a patch that support the one
unusual thing this does (input-only GPIO lines).

>> What do you mean instantiate it twice?
> 
> I _think_ you need one instance for the first 32 GPIOs, and a second
> one for the remaining GPIOs. But maybe config->reg_stride might allow
> it to work with a single instance?

Oh I see.  Looking at it now, I presume the reg_stride will work here.

Thanks.

					-Alex


>     Andrew

