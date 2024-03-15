Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E7318E06
	for <bpf@vger.kernel.org>; Fri, 15 Mar 2024 18:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710526002; cv=none; b=TXd7ycOEwhil4b3B2xatx9t7Wli6Zwr9zue77X0AJ88olEpKC2IRUBo4xFVgg32Ssd8kKs3wcUsKglX0a4/j1ez6bmvUwaai+nG+dFF+Yh37Rm78rAE+m44/Y8/TCjt4euI2lCgznpAHYcdoW1WRjadvUrJl/+tHehzQjn/we7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710526002; c=relaxed/simple;
	bh=eaConrFTCFRsp48DV9uPf7/3GltAzi7UXd6VipidtjE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SPDkO+pkXmOfkRtzy9AM+iv3NjKGMtnzXZzz6jz4Y1PNMGniqp6IcGQQ7LH1HFQ9SAvgytsUbMUphYVSYdNAHyVuVE1r9/Te104PQNGrr2Rh5Zi0/jtau3tVaUNS8ZjFxCQ+/WEbsAKn4v6eN1nt6eG9vmcRe0nfcE76hs+RbV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hw7SaPMm; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hw7SaPMm"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-413f1853bf3so14186585e9.0
        for <bpf@vger.kernel.org>; Fri, 15 Mar 2024 11:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710525999; x=1711130799; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eeEu3JhrqRGkTm/bv6iEm+UjuoiMn7S3m2umS1hfXHw=;
        b=hw7SaPMmdugB6h4wxpj0CCDmRMv1+9kJY/juh0CR/adCnPlQTcDxlSgvUPgDFTELJA
         wr/LXfmjbF9TUiu6FVNyVG5ZW2rtDGsNjkN/HOAQFDVbK8jaMMt4VxCEgY886m5xTBK0
         06Zw+JQpszWtb4WkLuowFSdr65onvLfw1HJdYd0UrbfWZe+EEuZeDIA4yDI54afWWWgn
         jLfKnHJEO/8qxruSYb1nO+JGlEjcq+2o8cuAQ51hdED6ulkXg4kBTvbHD0YB+T457+mA
         1ndnD8v1NgiTZ750L4GvxgQPCKAzc+iyWLe39kj/8N+4iXsMNSO0z9tHa1DEu8XIzuSq
         2RhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710525999; x=1711130799;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eeEu3JhrqRGkTm/bv6iEm+UjuoiMn7S3m2umS1hfXHw=;
        b=gYxV0xnSG4NWGrnq+Bf9xeqnuQHVQfuOXGeCyxINJ1aur+cOXtGFK6OT73QzMsQ9Vt
         p98ezFHTiFo78k298b71/QT6x9jvrywmaYU2k81dMCbmvbWdFC/6sHfWqLQwNyR2eIqV
         bhwd24+mfqHmtNxKclbNZxia6YbPN01KnBArV3uPHhFpYx3iyStBl2ZDPSjTcLHpdjCX
         UV+fm23vlHiulNub5936n23wTqz2CAlQDbArkwSZtWfQXit3exVJIDsMDtGOUvH5A/Km
         KPXvkkWS3KqKlrtXaWddfuc/9jfXlxxpjTWzV5jcQhH3tlSXaQZmNtKPDpqOHUcUajl2
         NQOQ==
X-Gm-Message-State: AOJu0YwzX0UuYC/7RYRcotUZsqwKIuezno7jnYZtZ3w/F/iJdcKbXRks
	HtoVNB0bzfAxs5ZkrYFIT8hVLUJuJzN6jPfpP44dTsnNOTQQkTWx
X-Google-Smtp-Source: AGHT+IEwi3I142UoxxQgLlOSyXhnfacP9FDY6y90vtP4NKFh3t3Ekp2Uo5O7jByuWeSC88OJYrTAgQ==
X-Received: by 2002:a05:600c:3541:b0:413:1f57:a312 with SMTP id i1-20020a05600c354100b004131f57a312mr3878663wmq.11.1710525998806;
        Fri, 15 Mar 2024 11:06:38 -0700 (PDT)
Received: from [192.168.1.8] ([82.66.150.212])
        by smtp.gmail.com with ESMTPSA id fa11-20020a05600c518b00b00413f0347a3dsm6729743wmb.12.2024.03.15.11.06.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Mar 2024 11:06:38 -0700 (PDT)
Message-ID: <dc02f7f4-6996-4a1e-a45d-09784c164939@gmail.com>
Date: Fri, 15 Mar 2024 19:06:37 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: PF_PACKET RPS like using bpf
Content-Language: en-GB
To: Stanislav Fomichev <sdf@google.com>
Cc: bpf@vger.kernel.org
References: <12a4fa23-fd37-4cc9-9744-09ae056fc872@gmail.com>
 <ZfSF6aNQ419Dx9yS@google.com>
From: Alexandre Cassen <acassen@gmail.com>
In-Reply-To: <ZfSF6aNQ419Dx9yS@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 15/03/2024 18:31, Stanislav Fomichev wrote:
> On 03/14, Alexandre Cassen wrote:
>> Hello,
>>
>> While implementing a large scale L2 processing soft, there is a need for
>> high perf ingress handling.
>>
>> In short: using BPF socket_filter prog with a hash func over ethernet
>> address to distribute load across multiple PF_PACKET sockets: mainly
>> filtering out non related hkey packets. It simplify userland app by using
>> multiple PF_PACKET sockets in dedicated pthread.
>>
>> Longer discussion + quick source code illustration here:
>>
>> https://github.com/acassen/bpf-pfpacket-rps
>>
>>
>> My question would be related to sockmap. I tried to figure out how to
>> perform the same policing design using sockmap. And cant find my way around
>> it :/ If bpf verdict prog can get socket fd from __sk_buff then it could
>> drives the same hash/policing decision.
>>
>> Is it possible to get socket fd from __sk_buff from sockmap verdict prog ?
> 
> Don't have an answer about sockmap, but I'd suggest you look at AF_XDP
> if you want the best perf out there with raw frames.
> IIRC, it just recently got a mode where you can redirect into multiple
> sockets (== consumer threads):
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git/commit/?id=2863d665ea41

thanks for replying, __sk_buff bpf mirror doesnt export struct sock as 
present into kernel skbuff, so no options but extending.
AF_XDP is an option. Will extend test code with it later on.
