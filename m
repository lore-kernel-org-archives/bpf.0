Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61504382374
	for <bpf@vger.kernel.org>; Tue,  9 Jun 2026 20:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781037542; cv=none; b=cBem2tNIJnZ2bkLZEdG2sYrEZ4ylbmToXcZs924BMGxQA6M3nQa4UnfyZtK0cInjywMre0Z8ZsWlBBro4qTQawXIPALzoS5jmwDcQ2zu2yc0Nl2TefdfRsO6FozDqLAbNjxUm7hey2SsLvdYGDxE1z/t2t+iNPKfHkgfs3y1etI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781037542; c=relaxed/simple;
	bh=wjrsyFAFBOqBoBS2Vr6+ezTs640vJuST6uXExrhL44o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MfW9DzF/rf1f+WeoWz6FT94zeEM9qFqD+YQ7X+zPq50882CfmSH74e3+HrF0gNO8mGK0ywr6dewR008ia7BqtSH4WZw41mD3PhtYplZM90sD2N1SXCD+B2kT/kzARlBpBGhZmHRAWrhSaLAZjmGHIg5rclQt0UNnNOuMgyIkByM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=uD15CbDx; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="uD15CbDx"
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-486d0e175e9so1697762b6e.3
        for <bpf@vger.kernel.org>; Tue, 09 Jun 2026 13:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1781037540; x=1781642340; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uC/gW0bqBQrvyjGENIA0EklxnQV7jgJOX02+wy/otqQ=;
        b=uD15CbDxaDgpCz7FCWPx9LUw+F3dcanm+5CWJjR61AdNmkixfLjAga9HSe4/o21zNH
         0F+MdHfu5B40V9zrWv32fXZ7g1I6b2Dsjqcj7gjCMI2lwU+bRMCQD0DxLrKd/gwMZOMZ
         SK/4Q9Dqt+qt0uAvGamfAnV2bxS9x0cebWUnffrf5JXJKsGePfgye7Vm3qhxwdeBM+Gj
         M3rRiBRe5P2TubKg78Qxwjhec3HVg+0lWjAWc+LZnGFGNQEAPkHfB2wPJKgd2n+Nl6eC
         jXADHL3kQNAIrL9IReX17IDMSDj/RUJgOEiKS54xsbVqublmzCTX5l/FBPMyOSSbjQME
         s+wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781037540; x=1781642340;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uC/gW0bqBQrvyjGENIA0EklxnQV7jgJOX02+wy/otqQ=;
        b=YY36IP+mJd1y5OmISfL8sivgReQk4Q2wSLBoHLpZLvdan8pUq2F3gth+4yMNnlSj78
         7wu5YXkPdACVAYO6rTN1HvO8ts2RPb8PJ+hgcOiWBoRFIL0ShncDJugmjACelshPDc92
         TOa5t+/llhJqv/NBH1jvsPoiw7r+p19LX3OxsfYXCHbxTTRZY8zYr+xWwXf6m7eXyN7v
         bdnNKAnz9rG+1RXjmnZeA1P+jPbgX7ttTzWRQQD3hbU0GhbIdcx1PISX1rdp3fUzOam5
         Y7ynogUgZjSTWNfCkDfME9fbXdHQgl7gyzwXKk9OtSlJ+1tN1/A0BR3QNODyTL67CHZB
         zVww==
X-Forwarded-Encrypted: i=1; AFNElJ+sj+ofU/javwYxg4AxZZ6A/n5XnseKgZU+FsTcoxmtA6VO4dtyS0CEzxsIBjdllHVmTbs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvFNrVXokHJJA3JSXtgv40dKfPis3H892Rkn7PV9APO4wcw9Om
	hyicXfyoBVMAaKw2uzk4pen2+DSjLTVEdpEoHpSh93aUg519lChXjw4sk9dhsYvcYtc=
X-Gm-Gg: Acq92OGAMc1c/sUCfbzs7BnDt+5OGzGGHlQQOr39ILg8mQnE3a8xnZL2H72xerubMrQ
	czbxh2LmTbAOrfGkEHqqHvXQq6bJ5vTstON3LTmayEyLPY1B0Qgg8ZOBas3fa9WcW3afBRDirc+
	lC587hyqYDFwN/cI0Ebe0n+29g0wV1xvnEGv9tPGxU4B8XbtvuUltk7l1j8+3X8bi6oXWlJ6a1K
	7PB9pFwBSo+uSejwQJ5FBbsJE8AcBy6hCOn+WIj+2nQbiyvcmJEjohxQBHMlDpLJoo8aUZto2eg
	Vo81/uIog4ff/60tJY7YBKLIShtFK/4Fa2QpZsDLU5GqBby1ByazECD3qHDRNHpOhessqWESkga
	JeddQbGX7jO/FiBUBq9nmje16HM68M+hM2OAXUOd932T4q8CV49WnubyB+Fl5Y3W0ky7AuZKlK/
	GcCLOh/I9+uh+UfkTmz9S836YcKR/JXz76/ZeJg71yCnRx
X-Received: by 2002:a05:6808:d49:b0:479:e869:5424 with SMTP id 5614622812f47-4868dc7df9bmr12485645b6e.19.1781037540345;
        Tue, 09 Jun 2026 13:39:00 -0700 (PDT)
Received: from [172.22.22.28] ([73.62.185.64])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e6e78e7f9csm15313928a34.17.2026.06.09.13.38.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jun 2026 13:38:59 -0700 (PDT)
Message-ID: <8bc8bd9c-2982-4186-809b-13f7b75f7fd4@riscstar.com>
Date: Tue, 9 Jun 2026 15:38:58 -0500
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 01/14] dt-bindings: net: qca,qca808x: Add
 regulator properties
To: sashiko-reviews@lists.linux.dev
Cc: robh@kernel.org, devicetree@vger.kernel.org, bpf@vger.kernel.org,
 conor+dt@kernel.org
References: <20260605010022.968612-2-elder@riscstar.com>
 <20260606010120.590881F00893@smtp.kernel.org>
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <20260606010120.590881F00893@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/5/26 8:01 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Low] The device tree example incorrectly assigns a 1.8V regulator phandle to a 1.05V supply property.
> --

Impressive catch.  This will be fixed in the next version.

					-Alex

> commit 9408235f22241ddbd72a22ee2611a98eece3d7f2
> Author: Daniel Thompson <daniel@riscstar.com>
> 
> dt-bindings: net: qca,qca808x: Add regulator properties
> 
> This commit adds four power rail supply properties (avdd18, vdd, vdd18, and
> vdd125) to the QCA808x ethernet PHY device tree binding. It also updates the
> example section to demonstrate how to configure the power supplies.
> 
>> diff --git a/Documentation/devicetree/bindings/net/qca,qca808x.yaml b/Documentation/devicetree/bindings/net/qca,qca808x.yaml
>> index e2552655902a3..3c1b7eca33caf 100644
>> --- a/Documentation/devicetree/bindings/net/qca,qca808x.yaml
>> +++ b/Documentation/devicetree/bindings/net/qca,qca808x.yaml
> [ ... ]
>> @@ -25,6 +25,18 @@ properties:
>>       enum:
>>         - ethernet-phy-id004d.d101
>>   
>> +  avdd18-supply:
>> +    description: 1.8v analog power supply.
>> +
>> +  vdd-supply:
>> +    description: 1.05v power supply.
>> +
> [ ... ]
>> @@ -39,6 +51,8 @@ examples:
>>               compatible = "ethernet-phy-id004d.d101";
>>               reg = <0>;
>>   
>> +            vdd-supply = <&phy_vreg_1v8>;
>> +
> 
> [Severity: Low]
> Is this the intended phandle for the vdd-supply property in this example?
> 
> The property description defines vdd-supply as a 1.05v power supply, but the
> example assigns what appears to be a 1.8v regulator (&phy_vreg_1v8) to it.
> Could this discrepancy lead developers to copy-paste an overvoltage
> configuration into their actual board device trees?
> 
>>               leds {
>>                   #address-cells = <1>;
>>                   #size-cells = <0>;
> 

