Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4DA759B4C
	for <bpf@vger.kernel.org>; Mon, 18 Mar 2024 21:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710798310; cv=none; b=U0ZW5VrjO2A4qIwT1TnJapyctvoRAKS+IHbj14x8JgzYUKaFu8GxOAis9RVrN12/MmGPaXS7amIva1pZBNcHZalsfwDOUWf3azKAeZz6rpp7k3/5lRB33c4i5w1NtiBVCbZ2aeJKuzH3U5ptM2r9QW93dDnvRH1U1Tb624GSz90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710798310; c=relaxed/simple;
	bh=KspocECjbBz8OTBfmQSMBh23zviiVgja5v9m39CAag4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vbh8SkoiYYN2W5uQ266aqDFay6Gno44egG5CTg297f/4n1ozoI40QN9qKGRt7bX0/R5XziPShkvdnqTPr+lxLBZZPd0YL0fPrhx60Yg4NKlm5aC00zq28ttMWE5bteNwZ332SaBzx0TdIO+Sva5WyPtOmCMVY+zfgUNh9MwZ/Zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gyj+PkD/; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gyj+PkD/"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4140edd58c9so12181985e9.2
        for <bpf@vger.kernel.org>; Mon, 18 Mar 2024 14:45:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710798307; x=1711403107; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VAy60YtRc+BOzMXXlIzzuuF45svQTtJZUPjtnhlWfk4=;
        b=gyj+PkD/qIQNeSyhAqsCJB3Wr92ELVqikeuNSjWPSLY6PdmOepfM2r7Sb85S6cQL90
         x3A6/6C0ESomCZW7QlXPNhH9oXApIy7QQw//8zsh4E8tki10mDj/tybTjKzmvydUotNh
         fjyetzfWIDwT+oGPM6q5nBPCWZd5jxPIHW1RsYwKTkRtmD/JjiDp1tnXgF1VG8e857t5
         L/UHZdkY3MKPWdMH5zjzlcfdKzWDRay4QVuuxAnlyOqIaRFu5OyxTmBZdK+d9dP1uOTO
         p79Zw0Yfx+TIRSsXfBCAKkfVsliU1E/0Rh9KoM5XcKoIjHeerZ7oNhS7EIuNUomxlAyX
         lLMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710798307; x=1711403107;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VAy60YtRc+BOzMXXlIzzuuF45svQTtJZUPjtnhlWfk4=;
        b=C4+SG0sW1pcTN1Y7yEi17AqcU7QsKcfGyKC+bhfu0WnboCgXubS6UdjOq7Y+oGuU8n
         AQuxO2KhobCFoCUPWZFnp8KSNLJsenvo9uRaxJEDrzM80Kg6ka4AnPLxkjs/0gljIYE4
         F0I+zMos1uFEBwwGGz58wUVcN8d8Dm3R2JR7o+9/CUv6kABOFlxjR65GiM0OoRe/RYwj
         5c//c0W+vgcnsvFqB+GwOF72doGa8XXRMd36KOWldGFJeWGQuldgcw/wVT6vGuXW0I2+
         F04CSId9XvH4VhmFFI0UcZwyhn0gPd6tSBbw/aN9ymuSpmcltLstsot/+3Hut2XxWg4o
         AuTw==
X-Gm-Message-State: AOJu0YyNQRvMMmi88Tm6S3soIaGIFxM+4bU5DFNNeCv9eWr3Jt2wDkEQ
	Gq1I1Vp26tHvpqHHZPfA+um/fvuMv9g3D3KqYa1/sCACD8lfnhmawkkuWJV7P9M=
X-Google-Smtp-Source: AGHT+IFsk2NXMWAvUvBp3TQdkDMOTl22ifLhgk2A1GOQayQi+fgT9TKULxBsxnieaxvBOPGTn9BBFA==
X-Received: by 2002:a05:600c:310f:b0:414:5ec3:8fcb with SMTP id g15-20020a05600c310f00b004145ec38fcbmr555136wmo.23.1710798306997;
        Mon, 18 Mar 2024 14:45:06 -0700 (PDT)
Received: from [192.168.1.8] ([82.66.150.212])
        by smtp.gmail.com with ESMTPSA id bh18-20020a05600c3d1200b0041462294fe3sm763365wmb.42.2024.03.18.14.45.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Mar 2024 14:45:06 -0700 (PDT)
Message-ID: <e08f55b0-aaae-4c03-ac69-e76fc6725cd1@gmail.com>
Date: Mon, 18 Mar 2024 22:45:05 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: PF_PACKET RPS like using bpf
Content-Language: en-GB
To: Yonghong Song <yonghong.song@linux.dev>,
 Stanislav Fomichev <sdf@google.com>
Cc: bpf@vger.kernel.org
References: <12a4fa23-fd37-4cc9-9744-09ae056fc872@gmail.com>
 <ZfSF6aNQ419Dx9yS@google.com>
 <dc02f7f4-6996-4a1e-a45d-09784c164939@gmail.com>
 <ZfSTq3tBoHoiUNMv@google.com>
 <6f3325fe-4417-4024-9830-039f9c505ae0@linux.dev>
From: Alexandre Cassen <acassen@gmail.com>
In-Reply-To: <6f3325fe-4417-4024-9830-039f9c505ae0@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 18/03/2024 17:40, Yonghong Song wrote:
> 
> On 3/15/24 11:30 AM, Stanislav Fomichev wrote:
>> On 03/15, Alexandre Cassen wrote:
>>>
>>> On 15/03/2024 18:31, Stanislav Fomichev wrote:
>>>> On 03/14, Alexandre Cassen wrote:
>>>>> Hello,
>>>>>
>>>>> While implementing a large scale L2 processing soft, there is a 
>>>>> need for
>>>>> high perf ingress handling.
>>>>>
>>>>> In short: using BPF socket_filter prog with a hash func over ethernet
>>>>> address to distribute load across multiple PF_PACKET sockets: mainly
>>>>> filtering out non related hkey packets. It simplify userland app by 
>>>>> using
>>>>> multiple PF_PACKET sockets in dedicated pthread.
>>>>>
>>>>> Longer discussion + quick source code illustration here:
>>>>>
>>>>> https://github.com/acassen/bpf-pfpacket-rps
>>>>>
>>>>>
>>>>> My question would be related to sockmap. I tried to figure out how to
>>>>> perform the same policing design using sockmap. And cant find my 
>>>>> way around
>>>>> it :/ If bpf verdict prog can get socket fd from __sk_buff then it 
>>>>> could
>>>>> drives the same hash/policing decision.
>>>>>
>>>>> Is it possible to get socket fd from __sk_buff from sockmap verdict 
>>>>> prog ?
>>>> Don't have an answer about sockmap, but I'd suggest you look at AF_XDP
>>>> if you want the best perf out there with raw frames.
>>>> IIRC, it just recently got a mode where you can redirect into multiple
>>>> sockets (== consumer threads):
>>>>
>>>> https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git/commit/?id=2863d665ea41
>>> thanks for replying, __sk_buff bpf mirror doesnt export struct sock as
>>> present into kernel skbuff, so no options but extending.
>>> AF_XDP is an option. Will extend test code with it later on.
>> We do export bpf_sock in __sk_buff:
>>
>>     __bpf_md_ptr(struct bpf_sock *, sk);
>>
>> But it has a very minimal set of 'struct sock' fields exported.
> 
> You could use bpf_core_cast() in bpf_core_read.h to cast 'struct 
> bpf_sock' to kernel 'struct sock'.


good idea, other option could be to userland set SO_MARK one time and 
get it back from bpf prog via bpf_sock.mark to drive policing decision
