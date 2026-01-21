Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 460171DD9AC
	for <bpf@vger.kernel.org>; Wed, 21 Jan 2026 03:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768967182; cv=none; b=j9FYVCVsw5fblJmuoWM12vctYzu6euiB/VQfn2X3MokCiSGfoGxc5uZ+fyiGHIGZIBD87snuOBxeydUfOr6BA+jc0M0l5H2hLA/o3W1PzRwS1FTcMSayD4Phb4lYMm4JgvdBAYQMOScOXLSOtzL/FffoD769MfwDToy3UCCOQW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768967182; c=relaxed/simple;
	bh=UNTMs4HY65rUCx3FGGC6no9DF3VupsC4H4otkdJ/MKc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eBWAWv8eC1rmflvfON4ptm87wNChxglvJIME1Vk+51zbzj9pulLNYtyUOAZm/Nu66I8aU5t0uCAiw1H0gqxyvhEvHK+sYPo3iJtfoBDUUQpF6cMG8s8eBzFoIdDYTpiZt+eifPJ+An42CNiGS/cSzvi9oliTEXJ2ja0c8FOFOSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=vwBSQcmN; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="vwBSQcmN"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-c0bccb8037eso2559210a12.1
        for <bpf@vger.kernel.org>; Tue, 20 Jan 2026 19:46:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1768967180; x=1769571980; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qRuq7cdSYizr1nEhJtCVuWq3DpoYkOwpDtOsi0u3UGI=;
        b=vwBSQcmNdTSGemK+y1b2/bi1l78Y0M55snA1j9sdRZjMN8vbEqctpQFjqvHEa0m/Ca
         V16z7EbvhJsrTbywNmuB7J3R5ah67UQIxSRc6kinRuLmRjTgU54yHzYswW7ee0q3AXmM
         msKxgEsN3XgECjzetqGyWu3sh53344ENco2xEuuJhF8V+3MaTO6t+1gaq5+/9wjxEvf5
         L1fdmVrnmdhFdZEK2WC5//kDyC1r1m121jOu1GlVBXB5dCov2ELEEo+oh4M8fB5cWHIc
         6DhO8+1MURH4JBcFBe7o4tKiUA/TPIidP2/3imPkXxd/AWrDCJJTV1q+2SeW17Rm8+1Y
         GZFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768967180; x=1769571980;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qRuq7cdSYizr1nEhJtCVuWq3DpoYkOwpDtOsi0u3UGI=;
        b=AX3UVuuDa6c4tvV9aT2Eyo5rEqL/svkayOhYzJ2wPvSwtDGwyBdIXJH/vy2adbCpZh
         /G3ukUnWGhqcF94hoZaENLtlAIxnLT9ovqs5RvR66MdZ/TUJkkm036CLjcfH65s46qXe
         oBn8oAkE5hGc2SDj7IwPT/taW1nmWxE6Nc+MkyftH276qbTGEmnkZFbez1CSuPznC6xD
         +8ETkrgEY5LwcSTn3dd7nIsN8SXvGuvDfePQskh4gfieIBgUIiNOybtYfpBq8Dvf5hU6
         gIVVve/MJaKxrrs1QamSiA4zyMESty03Lh9YFJs0yGjjlBFRFTLk/JO9QFEukPzFGdxP
         tLpQ==
X-Forwarded-Encrypted: i=1; AJvYcCVaYvmCUS245OdSEpr7mccqQTrkTDRgrfI9sqwoAyR3j6j0a4bvuc2TX95UxaX+rC8sw+Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEJNtFDNBhR95a8dEKLhtW7TsNBBy+nSR5IiwJm1CX4JUv21Vy
	lbDlt34Oxxfgq3D0RfxihOm7LaB5YBujdbg1KGVtDoKjboF9IVTEpiI0HxzdLUjmLN8=
X-Gm-Gg: AZuq6aIcdl+8ILvkVkniaeLJ5sAL75GBrFo/shXMqosqnNMr42x6UXtYl+ClYA3uWq4
	avqNIjUD9U6klyxSj6MdmQjnHRDNW80D+t9FaI+itKVfmW+RIAu7k+CkBgII8HxoUuXvhyKLWbe
	FtYnmsafGumipbvrli39gw/CPVY+dyHJW0COAh10LI0CWcerdbvbDck+zNiDeNForv7SbBupLyP
	+0R/kP+105Up81uJhsxSGLG2gfPxzDcNQQBivWBYkiojW5rne2PA9Io6naxdhgSl6if77svab6f
	oxHcO1yebOrXudtJboIcOzZ/yiADukbKMY7eHR4myUS+doZ66pAfw6xGqXiGUmNIiIGNmVRXiwH
	P32wLZSYGXvHVdy/pXlVOONWbwmTSEaRoqNndURsHzd1FxNyv7KgpAJbp5gBNgnW0r4Murh3PTj
	UMp8OAZQ6zOmhgTbAMeqmhIaL0gHCLnRyY3jygDj22QEcFwWP0x/vSnJTiG9OS/GhvxA==
X-Received: by 2002:a17:90b:3881:b0:32e:3c57:8a9e with SMTP id 98e67ed59e1d1-35272fcb836mr14613526a91.35.1768967180314;
        Tue, 20 Jan 2026 19:46:20 -0800 (PST)
Received: from [192.168.86.157] ([136.27.45.11])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3527310210fsm6698391a91.9.2026.01.20.19.46.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Jan 2026 19:46:19 -0800 (PST)
Message-ID: <be76a258-0dfd-4fea-a0ac-b8d6fc6e95b6@davidwei.uk>
Date: Tue, 20 Jan 2026 19:46:19 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7 00/16] netkit: Support for io_uring zero-copy
 and AF_XDP
To: Jakub Kicinski <kuba@kernel.org>, patchwork-bot+netdevbpf@kernel.org
Cc: Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
 bpf@vger.kernel.org, davem@davemloft.net, razor@blackwall.org,
 pabeni@redhat.com, willemb@google.com, sdf@fomichev.me,
 john.fastabend@gmail.com, martin.lau@kernel.org, jordan@jrife.io,
 maciej.fijalkowski@intel.com, magnus.karlsson@intel.com, toke@redhat.com,
 yangzhenze@bytedance.com, wangdongdong.6@bytedance.com
References: <20260115082603.219152-1-daniel@iogearbox.net>
 <176890982554.757566.17882816780312694183.git-patchwork-notify@kernel.org>
 <20260120180850.45ae4214@kernel.org>
Content-Language: en-US
From: David Wei <dw@davidwei.uk>
In-Reply-To: <20260120180850.45ae4214@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2026-01-20 18:08, Jakub Kicinski wrote:
> On Tue, 20 Jan 2026 11:50:25 +0000 patchwork-bot+netdevbpf@kernel.org
> wrote:
>> Here is the summary with links:
>>    - [net-next,v7,01/16] net: Add queue-create operation
>>      https://git.kernel.org/netdev/net-next/c/a5546e18f77c
> 
> I'm going to revert this, I sort of promised Pavel I will pull his
> work and he has the cross-dependency with io_uring. Y'all can rebase.

No problem, that's the ordering I expected anyway.

> Plus what this series does to "the code I wrote" saddens me deeply.

Yes, that's always sad. LMK once you learn how to clone yourself. I
wanna do the same, too.
