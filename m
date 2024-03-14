Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AA6A3209
	for <bpf@vger.kernel.org>; Thu, 14 Mar 2024 08:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710403511; cv=none; b=BNPx85DryPCDIp/tE1A+k/o0o/uwEeRedXVOG83vKI12Y8Inh6SrV20AdYEf1Ddjl/R7vDn3RbLbH4ahBJmLcc2qNTR1PS7k+1kFaDkbBqVTMH/WHlOV/sRtApI9FbAAU/qQK3dQkq+KGm53U2i25Ddgmc9LwkeRY6orlGGW1yE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710403511; c=relaxed/simple;
	bh=FMG/OIL1uiKxpN0qBE+WVeHUwKbnkC3Esjyme7VVJh4=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=siCGb1z44FHJT43TiNiZOALNSkDnUM7VfDf0I3c2UcIMH9PDnLYY5isgzrswn9ZD4sRMygi6PXFgJ6Sdu8bRUGsN7ZW3QgyMQzJomUxL1DcLbIsDGvOfzOya2aA2dmJkU4170glx3xX6eDk71tfkWSUdsjDGI+xsLP44TQZEINk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AyN4ntvi; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AyN4ntvi"
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2d094bc2244so8179881fa.1
        for <bpf@vger.kernel.org>; Thu, 14 Mar 2024 01:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710403507; x=1711008307; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ker6+N1S2POGgBxd68sMORPhi/L50UTBajKPd4vtR0Q=;
        b=AyN4ntvi3uImugMy45kGf9NluQ7vFbIMdjG/7y01dbeWRQmjj8VOsNWIXFr4Onz4Qi
         PM0wvgLskeA2rJld05V49FjayCVnS++vHm1rBYlbnhKE+kd3EU6XRuiMs88Q1TrNvQ0w
         gBXXrQwggEL1VBj7aFu7iudQ586C5bGlATapsbffOc3cDLQbKporVPPwKoARBHD+/Mnm
         raMJrRDddoBHJ8m53Ht4RlUd8qxvUT8gXXswUoUUU3smqkI4KKTM+KL03SZLd09NYUfW
         s/9TDzXBzPalE5zoED1D4DjJBXhjCGgXEfPdJ4W6Irr2AdufGEfnnChcj51l6MXWFcSC
         zUfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710403507; x=1711008307;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Ker6+N1S2POGgBxd68sMORPhi/L50UTBajKPd4vtR0Q=;
        b=UBjzDbONnzdQZXuRnibjM5/qKIyGtW1c1bEiRqEwfT/L82kwR1sbUsjyWkspTvCJ+P
         /FZXNoqVnb/3iomptouIpDC1bHX9T8tmWl97U+t6XQQ3Za7mmsv+FcVDabxXcA8zQ2gY
         Ne3vFMQUZt53xRFc9/6F2hlG2Y7pQijIBVgaP9tjgqd/FC+0qOuGcCsiGMfU2LqoNnLZ
         +UTeBOPO3a06icrcqNf4+13DMByfRq9KB2UcTsNm9GnRdHTTW0q4GuNO/mus8PRAIp6r
         2kgjUsKLnfUXIcqmGOz+t4qQhIVHsEYyFdS4/iUQ8c+gp1YxMsYiM8gMUN9nuRsKXyT7
         Ypfw==
X-Gm-Message-State: AOJu0Yx6yH/GlB036lgaC2JHGeIChTgoXnLsKwM5Ui3tem9TTrahRnNx
	qMTrWM2/zDiAnWrBduIXJuYmMQb0KWAJQw77hvMtG/WbqA6b+OUDPMqRzsmU
X-Google-Smtp-Source: AGHT+IFqQt6v9mYDNhj9gXgchJMMPOi6E9txFx4qSod1IK+VV/BCpczWi72RhHi8Us1OXyhiZLBg8g==
X-Received: by 2002:a2e:7015:0:b0:2d4:71e8:5312 with SMTP id l21-20020a2e7015000000b002d471e85312mr570344ljc.23.1710403507492;
        Thu, 14 Mar 2024 01:05:07 -0700 (PDT)
Received: from [192.168.1.61] ([82.66.150.212])
        by smtp.gmail.com with ESMTPSA id n28-20020adf8b1c000000b0033e745176f5sm115152wra.110.2024.03.14.01.05.07
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Mar 2024 01:05:07 -0700 (PDT)
Message-ID: <12a4fa23-fd37-4cc9-9744-09ae056fc872@gmail.com>
Date: Thu, 14 Mar 2024 09:05:06 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
To: bpf@vger.kernel.org
From: Alexandre Cassen <acassen@gmail.com>
Subject: PF_PACKET RPS like using bpf
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

While implementing a large scale L2 processing soft, there is a need for 
high perf ingress handling.

In short: using BPF socket_filter prog with a hash func over ethernet 
address to distribute load across multiple PF_PACKET sockets: mainly 
filtering out non related hkey packets. It simplify userland app by 
using multiple PF_PACKET sockets in dedicated pthread.

Longer discussion + quick source code illustration here:

https://github.com/acassen/bpf-pfpacket-rps


My question would be related to sockmap. I tried to figure out how to 
perform the same policing design using sockmap. And cant find my way 
around it :/ If bpf verdict prog can get socket fd from __sk_buff then 
it could drives the same hash/policing decision.

Is it possible to get socket fd from __sk_buff from sockmap verdict prog ?

regs,
Alexandre
