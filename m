Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 100C8440A2C
	for <bpf@vger.kernel.org>; Mon, 12 Oct 2026 08:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791793605; cv=none; b=Yvxke79aAVsFKy3yP3fIdGm73NiVwFhXs9OBuKmmfqyw7cfw1NNNc6tk/CvIfvTDyhgWkiY2QJYVFw3LmNyizts66Z7pfTiCJJ7Kny6CF/KWQP6bpkjqVZDMBtvysvyMX3YMmYzVp/U/wub8h61EsznsjI78Ur/4aZXb41wigLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791793605; c=relaxed/simple;
	bh=OeqP7i+bZF0CgakmY5tvMa76ztRCfLeHZp42OnDUfHM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IT6mbYd0rXRf4LlLU3ypzveBpNjNouHDnkdnOH54IbN1pICsg636wKRhJGe3lBDrzud7FERkDd23T9JI93ib+7540MaYENLnO/Aq6cUAWcnrhAFMkTiHsNt0ASMQ97FE10Y5x8AyLR5BTZ6v/aXkBGdH+I25gI3hZYpyM1EWlGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NA6QKBbw; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NA6QKBbw"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2e831e86ebfso8313405ad.1
        for <bpf@vger.kernel.org>; Mon, 12 Oct 2026 01:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791793603; x=1792398403; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FAWYds3044YACA2PSfudoINNHKxunhGI6mfgthZIvg0=;
        b=NA6QKBbw/6OlkBc+GDdXaTQtAFbwLx9tPiaqM1sq4FFfz3RvMFMqer8UpwBDQRsBLJ
         Ciplq0UsEpXaPUqPpoqFz40Kk2+anun3VOGbVmq//Qzq8Zd2m/rPX6OYmYBMl2wHgRtL
         t7tykuqEirhjagm/PB0rR+O/ffpRCoEEC2J7T8UAMEufpzhKJo8wrw4xCvMo+tkzyIj9
         FjhxqkBiB9V3LOOzPN2IPz/Sbm5xmYjwewFFMS3w1lWwBV699LgmlhGvIPlJecl3kAFj
         GhWR/6mZh0xmugMI4D0MqCBIfb1VDEBzSmAOU2JIX7U3oNgs+7huG5URP57NKHb9HIg3
         aQrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791793603; x=1792398403;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FAWYds3044YACA2PSfudoINNHKxunhGI6mfgthZIvg0=;
        b=GU5iqMa22QL/pjidQfPColzQFRBJkurgVYjMH1T0ZU/MKrysrCAn8/e+qUMRJRBE+w
         RxEmoXOjmV3Zx80CdS9XZgvnjmeRE5l/kKgfl7mSe32Ba6OT8L0f1WX15AW25HUARJgg
         X/lySTQbS/Uo1Hi9G4zBQK52UEi26Ufzhk6P6RHmQgj6N1xkO7ZgtXJOYeOrnD0TuFx/
         BGASStwNPpdaWsV4wSyZx7T82QvUA/VeK5Iv+IxrXSDkPFq8YB8q0+3lgof1LfJEre/s
         jlk5D53mskUzxN91mPfkdHMmoaxMS7xHKQ8+khEzBPZpBGt8XG46XXsAXk0PQLmlMi39
         eHGg==
X-Gm-Message-State: AFq9FYLPDM3SWEfeOctId9M8vZY1FLmenrJ7isin98LdFejp5q817N0M
	wXZDO8pItrQu2l8DuqoWdqbG1fDzNEktF7Js3wR+wNTPQyFlgMAmljUc
X-Gm-Gg: AYBFou2FvZMteQSY/hlyyXraeTPYZNp6QYldO3NHaM1mXgUdM805dKisXGfcmCl/YGz
	4OLlGlxtIpYGFHyYaxWjztCWNkoAH09HVMCWTDSU/6AWBt1RalcUG4ynPNJQMCW1DWcOrxuTrrH
	BC1+IP1glsnUni0KPa304LKBdCx4pWRMDl2LF95dicl1POjytJaBhitQC11JpMprxanqCA9yDQy
	msq70KT3FoIcWwTqwWvrn4YomhSyJkkiXW/S/sypoeVyTSlKT3hH6mZOzP880KC8i2N/6T64mJR
	g2lC5jJJLoTdl+lnzG+PcVb7jorggk6f1ihA7iwX3y3avZoU2nxj+4sDl6m4oNfw5e7MFfTqGvU
	YRqO/VfVJaEQHkeKhRRQ8NJcSi7locpHc//aX8ZY2B6pO2jxguHb4gMw/AXgUzHxkTh1bSCOR2t
	8wZeGb0W8F4TiDLFgpyA4Ei4wuqKl7mZui8gRcfKlfv+eHTaQIvOKUa+dp0VVpurNk0ccCRcHsD
	+1G0at+mjHJ4BPj
X-Received: by 2002:a17:903:41c1:b0:2e5:33a5:36ec with SMTP id d9443c01a7336-2e84280af99mr74092255ad.4.1791793603332;
        Mon, 12 Oct 2026 01:26:43 -0700 (PDT)
Received: from [10.22.64.46] ([118.201.124.118])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e8421b16b3sm40465045ad.30.2026.10.12.01.26.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Oct 2026 01:26:42 -0700 (PDT)
Message-ID: <6c732e69-0878-4bf8-80ec-47e40bbedc6f@gmail.com>
Date: Mon, 12 Oct 2026 16:26:38 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 0/2] bpf: Reject BTF ids with the same address in
 tracing_multi link
To: patchwork-bot+netdevbpf@kernel.org, memxor@gmail.com,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com
References: <20261011164836.2233874-1-alexei.starovoitov@gmail.com>
 <179178300502.3203934.18259867735111186075.git-patchwork-notify@kernel.org>
Content-Language: en-US
From: Leon Hwang <hffilwlqm@gmail.com>
In-Reply-To: <179178300502.3203934.18259867735111186075.git-patchwork-notify@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/10/26 13:30, patchwork-bot+netdevbpf@kernel.org wrote:
> Hello:
> 
> This series was applied to bpf/bpf-next.git (master)
> by Kumar Kartikeya Dwivedi <memxor@gmail.com>:
> 
> On Sun, 11 Oct 2026 16:48:34 +0000 you wrote:
>> From: Alexei Starovoitov <ast@kernel.org>
>>
>> tracing_multi link accepts different BTF ids that resolve to the same
>> address. The attach succeeds, the detach fails in ftrace and the kernel
>> crashes in freed trampoline images.
>> 'test_progs -t tracing_multi' hits it when the kernel is built with
>> CONFIG_DEBUG_INFO_BTF_INLINE. Without it the ids of aliased functions do
>> the same.
>>
>> [...]
> 
> Here is the summary with links:
>   - [bpf-next,1/2] bpf: Reject BTF ids with the same address in tracing_multi link
>     https://git.kernel.org/bpf/bpf-next/c/7211c18d7ee5
>   - [bpf-next,2/2] selftests/bpf: Test tracing_multi link with BTF ids of the same address
>     https://git.kernel.org/bpf/bpf-next/c/60e84b9127f6
> 
> You are awesome, thank you!


Oops, the applied commits did not collect my Acked-by tags.

Pls collect the Acked-by tags from Jiri and me.

Thanks,
Leon

