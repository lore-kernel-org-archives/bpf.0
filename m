Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEADD82880
	for <bpf@vger.kernel.org>; Thu,  7 Mar 2024 09:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709805315; cv=none; b=lfbgqB01NyURKed6nyCtrjIR18MNJcCauxCmfbnx4Qxp/4GDEu4hjUJPicFk03QfTGpEKsOl3tECBbV6znsn9rGF7CrKCFkMxabSAKcY7nQ7Hk0JlpqrHcNNFrKOlZWysaoGIBwt1eGlODU4PMkhSGtpIjHrFCPHqx9saFpxxEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709805315; c=relaxed/simple;
	bh=Oc6SYZO78SmbEa/NSKDDI9wZkcf9ih0cL7n3u98aQzo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M0crgdOcGEkaiUtlmxw/1EAzQrsUTjrpZWdF1r2znYD5mGeTGQExEgpJXGirGbo2jYw8RBcALTFuJehNTxAT5GYPToHClC59NuQRoFs65q7Gl6VaT7A2CA+UPcy6e7fthGazBmBBXtG4GzQGqrJRzbzsRY1Dszo8hj531wN9wXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=ZCjwyY/p; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="ZCjwyY/p"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-412ea23a750so4233415e9.0
        for <bpf@vger.kernel.org>; Thu, 07 Mar 2024 01:55:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1709805312; x=1710410112; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kR55/K1b35qaJ4PO9O+E6QK8ryoAMLDtF8xdzGow0uY=;
        b=ZCjwyY/pO0f9slL8qOSRBsSuthxlbD13cJOdEqJOHEiwaQhlBcrvbo4RtZPcwUw3kD
         xO24KCU8pStvOZiW5l54X3kp3Dvwk/kxP/yTKZhdBuUtpiRO/vRSWXduGS42M8Jy8gjX
         QrQeER8SByKDMqmeoTIR4R1r70of15V/UHqw4Wm4CdqhMb+U8x7n8zzW+wEWpo1uc8hE
         o8YptCfFEOgJjaFJ6XEhU9bVAaXZncf3xaVS2grJ8g1cTmZkvvtGpTX5Lu/Orn/3xFrj
         9AKfHb5cMl8wZo7qRqY8867HZuf0PB1cJvvx0fHzBMMvIBSqfsbvdbDsGOUUnxRTLou/
         4kfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709805312; x=1710410112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kR55/K1b35qaJ4PO9O+E6QK8ryoAMLDtF8xdzGow0uY=;
        b=HGGPismlhuDaZVY4jy4Q/Y0nEAc4TC/U5ldNu5VTXBwdqUKqOeLTP0nXb6PK1x2jEY
         WcqaEsQOqokraI5h/YY9oGVy6nEIWKxrfT94XpZoE1iECQTuIY4/iw1n0ksbkbjvKzYR
         YilRP0jh1Zrky7CLUDwWL5Se4AS5yQ1f6nEknBvcXThxqB+psp+jO35OaPrERCr00Vx4
         sWNjJtKiU7DSEoUglwksm9Bq+u3AvWBm45V/2Be6AYIN0NdHmk1uq/wYr9C/wLtVtsCm
         asa+DSWPwouzJ/6jbDgtkLJ3rOWVBnuoDPw/bdYVV2SCgza1cH/cz3ITgXX8FP2b9VdL
         WQMw==
X-Forwarded-Encrypted: i=1; AJvYcCWTd0dmcQYkmOqoW5M6tPJrLzYe891MGfBgxO/UK3tTm+qqg/mI5fVahdLhUVLwyVUP+VeXfti2/qMozMCUbpsqR4RH
X-Gm-Message-State: AOJu0YzNLRR2OxtkkCaJA9pX/p7Y4eWYF5n14dkfi6IwkMs2lMDo2HLd
	yrZJnNrsM1Cok1kywqWe/oFTOpw+aqViATBO5NIqK3y0xmd93WC9rbgr5DsfY6Q=
X-Google-Smtp-Source: AGHT+IHIap2gNOsYLxcW+VljI2GF3H+vK/3tUGHaqLIEE8pH0PSx3Y5+ANlUof+NgefOaReL90Yoag==
X-Received: by 2002:a05:600c:4f81:b0:412:f8e4:78cf with SMTP id n1-20020a05600c4f8100b00412f8e478cfmr1103385wmq.5.1709805311942;
        Thu, 07 Mar 2024 01:55:11 -0800 (PST)
Received: from ?IPV6:2a02:8011:e80c:0:c476:730:3d69:e891? ([2a02:8011:e80c:0:c476:730:3d69:e891])
        by smtp.gmail.com with ESMTPSA id i20-20020a05600c355400b004131035d28csm1534775wmq.23.2024.03.07.01.55.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Mar 2024 01:55:11 -0800 (PST)
Message-ID: <40bd2cf5-c723-4438-b05d-6b20022f32ab@isovalent.com>
Date: Thu, 7 Mar 2024 09:55:10 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 bpf-next 5/6] bpftool: rename is_internal_mmapable_map
 into is_mmapable_map
Content-Language: en-GB
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
Cc: daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org,
 memxor@gmail.com, eddyz87@gmail.com, kernel-team@fb.com
References: <20240307031228.42896-1-alexei.starovoitov@gmail.com>
 <20240307031228.42896-6-alexei.starovoitov@gmail.com>
From: Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <20240307031228.42896-6-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

2024-03-07 03:12 UTC+0000 ~ Alexei Starovoitov
<alexei.starovoitov@gmail.com>
> From: Andrii Nakryiko <andrii@kernel.org>
> 
> It's not restricted to working with "internal" maps, it cares about any
> map that can be mmap'ed. Reflect that in more succinct and generic name.
> 
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>

Acked-by: Quentin Monnet <quentin@isovalent.com>
