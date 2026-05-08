Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F17713C73DE
	for <bpf@vger.kernel.org>; Fri,  8 May 2026 14:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778251018; cv=none; b=kgKOruqADz1Rs2dsFRZXs2kdMyAfMmTqZ9KAsPtoZ9UOiRsbE3tPGRB0vXHtGUuVWFaV58Y/RF96mMlFMom8vAwoe6lTbnur30yd8kvABuifGmZc8MoPGJxVYxYx1QcshgHBFp1Tq2W4V6nUQyY21y70VWBZ5QRGkNmrC/4rg58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778251018; c=relaxed/simple;
	bh=E5BdW2FcgH1ffGpN/yDvwtsYgsCucJdUnVpqN2OQpsQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f9KOFcPHzLlH9Ad7SJ302mSdvhg62fUhTUDieDlpYMVS/w7ELeqACV2TSkR2nSsu88CIq2WJl73NbTtuwaUkzyFJmgTQsbzjDeY2yMX3eufw9OrCDkGPMbGIWhV85IB8DNg4KL7nPSi0b6NR8a6nm3puIV7I8MFXJQKjXEeHiFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=pF9a95Pt; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="pF9a95Pt"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-50fc496c8baso17605321cf.3
        for <bpf@vger.kernel.org>; Fri, 08 May 2026 07:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1778251016; x=1778855816; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I1eXzQgjFRPPJxicE/qQ6c85q3aMd0C62Q7xrxPUUZ8=;
        b=pF9a95PtzzUwT0MAS41PhPg65GvQXkn+io28yCtGSGDUhRmPdSkeSFNaXbo+490q2U
         8YHHsjaTvLrGeAziZLPX4URZdoyVoP00SNjoaWuWbnkhk8mVfXM9Mm7CUms5/dMa2WYo
         iC665Bt+oDgenC1MbVDuWEPPGp0fKHgQ25WXherne8s6fG68gklRjOh0dka5KVJOoDrK
         YyG/pHX4fIfl0maCQ83gJGaiHKNFTdJ/g0Tafbhfx2aOVS3Ft0ER6ZPPz5h3iFx1Cu2W
         p1s4/u2suhMVyB0xh4GM2+uP6HWBdn1BN988jOzRlSq91/kjaeMCmFc/57kb2xGKScqH
         p+Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778251016; x=1778855816;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I1eXzQgjFRPPJxicE/qQ6c85q3aMd0C62Q7xrxPUUZ8=;
        b=Oeyj09T3w7dh3KrYy2GAkZr4BcA35Kg3eeSTqMLlSR+KK5jmMiCtjH6pfcBwmTFbUZ
         sEENSQYkBuxm9ajYmkL2X4aLadrNqOniaDAmWIz98kly/XfwEIRpMWz0dRgG7+kCfNwB
         gaatP3v1D3smgb01Bb6t7ruIJCxmMd2L/+H5ZqJTpFsQGUXPxrQ19Ro+mg8HJXoEwVyR
         pwR0TKvkMd8QZO2c/ePWU5TLV1l0TQdGRL0LhVV3uc85/HAQZLCQ8zqwEm43xpDHmdMt
         A937OdbAodGTAmSIE44h/Y4UcoDP0TqsurhmWmCRU7SHuKytjxupx3KGTfhbMzWexPQm
         fPbA==
X-Gm-Message-State: AOJu0YxfDbw/5F4pHE4fXpu0zuXS76xefwcV2DEUbILSJE6mFla8Gtnb
	4HdKQMPI1pZVYCeKhqKjCQsAKQi9aa0INjbqrkRxcrHfYtWmlFtKtZ7KsInza//EXtE=
X-Gm-Gg: AeBDievmc7IUpVa39bq0fpZf0tiIp2uObYQhHoY4gm/PMv8rH/jz7+siodU0XdLIQ1B
	bDCNhxxGj3nQdus1Q5zHLlZhjMZUBnNMHWMaLQDbSq1vo2gA4hULcYjhs4QIQPv9zZcxAybutZS
	Uj51wOqkbnee7L9jy9BpQ1prjNB1vLZ/xbDSZ9HAd76YYDx1/JBf0qzPE/i39XMCjT6ij2uVGhk
	0I1IOogmAwwMurCO+yofFU9kF4SvbIh7LjJqn664i1O8ZIc7SBH47+bM79H7nCgGvzMY8KAS3/G
	Y5BRogo1nGWhS8OPMXH42ygbEzAVbeDC2aLI/tNX8wlOxLOd1M9n7cYBx+QEw6kqq/LtQ1QJGzU
	gLSXnzOhk9NLfByUq0ooevaWq0EVjrhpQM4sj8AlnXfFcTHSr6fDdPbjMj+puP+SMOhp5hHGH4J
	nHQiRcovUMjWh6OlacUyyHsj7Vybm871ykCmp8+L8OAkGmN+hJ5ISEQjak2fb6EYs=
X-Received: by 2002:a05:622a:1145:b0:50d:2a98:2571 with SMTP id d75a77b69052e-51461e72ca8mr170662291cf.26.1778251015806;
        Fri, 08 May 2026 07:36:55 -0700 (PDT)
Received: from [172.22.22.28] (c-75-72-117-212.hsd1.mn.comcast.net. [75.72.117.212])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5148e814c7asm17553001cf.23.2026.05.08.07.36.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 May 2026 07:36:55 -0700 (PDT)
Message-ID: <b301a613-a8f7-4d18-98db-aeac1201b902@riscstar.com>
Date: Fri, 8 May 2026 09:36:54 -0500
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 08/12] dt-bindings: net: toshiba,tc965x-dwmac:
 add TC956x Ethernet bridge
To: Rob Herring <robh@kernel.org>, sashiko@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260501155421.3329862-9-elder@riscstar.com>
 <20260502155615.AF378C19425@smtp.kernel.org>
 <20260507190215.GA2243588-robh@kernel.org>
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <20260507190215.GA2243588-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/7/26 2:02 PM, Rob Herring wrote:
> Please answer sashiko reports because if maintainers are, it's just more
> work for us. While agreeing with maintainer comments don't need a reply,
> I think we're still at the point any AI review does. Though sashiko is
> 2/2 here.

I plan to.  I've been responding to maintainer/reviewer things first,
but I fully intend to treat sashiko as a "proper reviewer" and will
respond to those as well.

					-Alex
