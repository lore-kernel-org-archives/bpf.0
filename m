Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 284973F0AB6
	for <bpf@vger.kernel.org>; Thu, 25 Jun 2026 17:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782408914; cv=none; b=f6ckumSPANLJRM9RPLOt4AMD9qx/jAJmLcAjWwXZoFadgb0IOHMaGRA+iSLawWq5dm3QOEd5vpubrykRSYhWPrOSOMAvocKtiRbjeyzEbkvDjFEtW3GQIgwghsftYkMmm/AjQOUxfowkzPhVQFLtpgzc400ziRjWWgLd4yVBy6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782408914; c=relaxed/simple;
	bh=CWcHyXL1nuFr2zBbxcD+I49gXR+BUjlAzdxCBWdkI8E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RYj/ZTrZsmChV6V/uQdv0TiLVn1PXLANKKQaowN65xOqDr8vhWUN6+gox0QBTeu/CHjYbGtIILlnUcjSju/JHM1fNpsYy1gEDnHRAwISqk98JWgoL1EN3paQhgaK+2QMRBtT+weeWVDQNeEVr7aEAZlQkxotbSMFJ8quYBii8Kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Stdkh4aZ; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Stdkh4aZ"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-492438c79cdso114395e9.2
        for <bpf@vger.kernel.org>; Thu, 25 Jun 2026 10:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782408911; x=1783013711; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hfJs9w2lKJotpLjpMf0F1SfbJUWEBXoJkkJG2VjG/Js=;
        b=Stdkh4aZqRfpjEo20uwKLo9PSk7NjBdJNHDhqI7RfXNgpMJMHszH6ey6s+vMvevgEU
         FxecJgaftf9/fhtPN6St4eVRhStIQnKM0AGJZ21fO02zHgoeWBvyxIc0Cq7Pzyc8kMZN
         32rLAGP7+05pkOiuC+gAbR+tAHY4mDNzd+iDDqYy52rTJM6q9rSZzMPZeaWGUyT1Wfmg
         k3g7eZO7QypA0oXHk8ppmsOIhqnu055Mh0ykQnuApZs7nk2sZE8hC0p72rX+IEwpoFyB
         8wZcgufD7/uJ52OwLuyS0XD82OJlRT6IYAt2w1SyODb9TmepFeM0F8lCdAgYZjvKPSwZ
         4bLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782408911; x=1783013711;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hfJs9w2lKJotpLjpMf0F1SfbJUWEBXoJkkJG2VjG/Js=;
        b=nUxx0VEDtbrRS/hCpruNJemXray3tMvvQ/otmo0ViWmq7/jlmz2B7ww5IvxK0+44q7
         66jdWI5JLajaNvrbpUh+fA/Kp2xp/wCFcCaelMd2hxSVtocGTrt71F4ITf/IOJD2h1Np
         Udp9++B+laEA+xuezPvu6QV3yha+fOpNVtnfLbJg7Rb4oVCbke3l58QNC25eCEQ8fcfL
         1deUCWeeGJhUx3n6Uxt+6Hk9NmDph/jbqS5a8Raif4O4D3sb2tbN4RLpp/hvbxfo+s3u
         ACcdVZhBLEGuxKJUsIjSw+ItwVkCxZabix7zCOpkSeSQhHHmydJHJ5I91S0jmALNRjA6
         0Rqw==
X-Forwarded-Encrypted: i=1; AHgh+RqgfVvTK4u/r305w0MWfDZ2pOOFXV9bwE08aaopCBwNky032UgxY0weiJUQGhLEkOT8tdQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrypEZa3vluna6SZg8/rmYhEmM64wCMI5sgi0ADishTy3pokDh
	RdcTpKA0Y2UP/XaIeEoor4D/WsHM0dH3OJ6c/MdNpfrKlWmptpAuFWdh
X-Gm-Gg: AfdE7cnrYVlNbpoPGt/L3uY6C4VIQFGx4yUwCTIUbkF0hyD+/PfiwZkbFIYqDaGmce5
	Gu9Lp6n6DXJeZzIA5zrz0hf9ondoBeHQCV++DIwLRqyfZLqoHmWqj+xY9q1I2n46icX/pFMDrHg
	ouGF93svVe9c0jbmPTl6ENmUP0IhwjXxlcqml7Kri7yUeFNs5y+7o7paqMGzhE74PYyrT9FKdMK
	GZz7mDI5J4QVZr//MYPDeKKRFGUUoD1o+hN2Dzke+aaUPZ0IFEGPdNTk81jjBh02Uz3CwKQUPAL
	1m6+gKdELOCIRvv9H9eloqFZ3Ib+chaMnW9cPO5PbxBigDtwLCL9M/QZRegXDiUdQYK2f/lOOpp
	9Fx7Iu4HzFzULIP06zoSFh2nddpy8Hyit8u0Fcna8ypjFV4karmFmE/l9HOLmWzaGF/esSGVxSw
	ICCOTgHeGGc4VmqJXdpGhrkr1W2uJiZw==
X-Received: by 2002:a05:6000:2c08:b0:46a:8000:617a with SMTP id ffacd0b85a97d-46dc2733530mr2636381f8f.8.1782408911409;
        Thu, 25 Jun 2026 10:35:11 -0700 (PDT)
Received: from [192.168.1.135] ([165.50.1.138])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46c1ee0189esm18233741f8f.9.2026.06.25.10.35.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jun 2026 10:35:10 -0700 (PDT)
Message-ID: <cb5c9a44-2b05-46a2-958b-cafe368c5576@gmail.com>
Date: Thu, 25 Jun 2026 19:35:02 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] bpf: preserve rx_queue_index across XDP redirects
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Jakub Kicinski <kuba@kernel.org>, Siddharth C <siddharthcibi@icloud.com>
Cc: ast@kernel.org, hawk@kernel.org, andrii@kernel.org,
 netdev@vger.kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20260620121321.45227-1-siddharthcibi@icloud.com>
 <20260620121321.45227-2-siddharthcibi@icloud.com>
 <20260624185432.32d90aa8@kernel.org> <DJIA58WBML8S.A897NKI06DV9@gmail.com>
Content-Language: en-US
From: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
In-Reply-To: <DJIA58WBML8S.A897NKI06DV9@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/25/26 5:44 PM, Alexei Starovoitov wrote:
> On Wed Jun 24, 2026 at 6:54 PM PDT, Jakub Kicinski wrote:
>> On Sat, 20 Jun 2026 12:13:13 +0000 Siddharth C wrote:
>>> diff --git a/kernel/bpf/cpumap.c b/kernel/bpf/cpumap.c
>>> index 5e59ab896f05..8f2d7013620f 100644
>>> --- a/kernel/bpf/cpumap.c
>>> +++ b/kernel/bpf/cpumap.c
>>> @@ -197,7 +197,7 @@ static int cpu_map_bpf_prog_run_xdp(struct bpf_cpu_map_entry *rcpu,
>>>   
>>>   		rxq.dev = xdpf->dev_rx;
>>>   		rxq.mem.type = xdpf->mem_type;
>>> -		/* TODO: report queue_index to xdp_rxq_info */
>>> +		rxq.queue_index = xdpf->rx_queue_index;
>>
>> Do you actually need this or you're just trying to address the TODO?
> 
> It's a 3rd if not 4th attempt from various "people" to address this TODO.
> We should just remove this line instead.
> 

I was one of the people that tried this. And also I have already sent
a patch to address the misleading comment to prevent future wasted 
effort. My patch is still on hold (LINK: 
https://lore.kernel.org/all/20251021114714.1757372-1-mehdi.benhadjkhelifa@gmail.com/).

Best Regards,
Mehdi Ben Hadj Khelifa

