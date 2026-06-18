Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2353349B15
	for <bpf@vger.kernel.org>; Thu, 18 Jun 2026 18:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781805722; cv=none; b=M1tuyI2pKEuddruRO5M//Uk0daaSfMFfKu0UGFeGtNjbeDedenaZRe0Hzr8BDZTUlBd9YYaO0RW/H5cD7zf+I3aWRKcaxYLgpmLQQjsWyG+TWiQaleTgwLxIu1CJFaJvhAwFVeBldSFo1LklhoIq4ymUmvJQQX2AcCoEBL+jt1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781805722; c=relaxed/simple;
	bh=rceMiOFNT5IbVb+Iy0f6uW9Ol5m+/2jK9nDJ80jiYkM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M05RBzfrcO3dJlOQ/1Zj2ik8OwcCNJv6odQBijZdunSEL5y0DoGeGumwtyxMw9Q664BU9oXuglgfqbWnUoEVagPAkhdGCAgnGRiWoX/aJYl/cgsjQlJN3dNJZzsaDLNq/qzRYVCpR51FtWgx6c1x9fxmCOFVBuUWgCTIwsjKFkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XxYInc7h; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XxYInc7h"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-84237c55ef9so791769b3a.0
        for <bpf@vger.kernel.org>; Thu, 18 Jun 2026 11:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781805721; x=1782410521; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=sAapUc3J2AoNA+b13H0L2cysqTGIB0y1ElmSTV/xFso=;
        b=XxYInc7hQMjWg1fPqfitpPuUpNQfQM8TsO1rgxAZVrOoY4YguYa0xWzZGaEavR3BpF
         3Vt94mtf7XrZMB7kBXbnPx73jqHYCUajZjuX1HpuEZk6l69FudC4E1NlL6n9EkQXLRlC
         0l2VA+66y5PiQDLVsftjTU/H4yTAh+ABM7oaKO/s0B081P9zc3fLnIXU3jjo8NnilYCP
         SIdKee7bmKpakf6KW3v64357QGOyizBNgxlwKAVIDHH/WbHrNSwiecXF3LlLv6oNhKOs
         s70Y0fRPPDhtlg3holLFBH9J9o3wjxRgAne97eYuhTTbhmZUIXsj9X6L2LnjzPeaDFVK
         BzdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781805721; x=1782410521;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sAapUc3J2AoNA+b13H0L2cysqTGIB0y1ElmSTV/xFso=;
        b=Fl1SUo7Xs7nDmEpzOx0PXBu8kwQEc+0pr5ytlUUuTPHvfTVq4fO49EE0D6BS78BpFI
         RYEU2txL/BXu7cLKPARq2x27C4TkSuEDpI+xarvuCs+r6prSCoXuNrO1FamM9z8nNWXo
         xxVaKXURdfL1j+t42G4rkrqG1cjCY9lPgfT5Mx0crBTlmBL5O1tlzxmIr8+rEm0AGzn3
         ecIrLvHgzyYdmwHIl81A7Bw+esC+s3ytZsoAsd4kSOUJf35vRo53Aq3dcZZoYw02HA4y
         3WE4hL6Ytw7VpS3aYbvzfzKSTP8/P5HOULbRqqjm1y+ae9m8ZBW5B4xAJOuJE2uBGowb
         734w==
X-Forwarded-Encrypted: i=1; AFNElJ9Ndq9uMrmJ2sFtqIwpAMfzQ2gDgsTXEMQl8O2felCiipqYvJp1ZwXljwL7nsrj3IGC1XI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxj2fqyRI0sGIa9rFpMETdRyNLMWRs0qAtAGLzz81bzE3vshlGH
	JJFY2/QKeVqLVSM4NsH0Ob3GwE606DdXiigGm/59MFTBU6zceFLGBjTD
X-Gm-Gg: AfdE7ckmBW44SGdCCv2/kV+85ftrnn5YY3hWkkYILiB6UX8hyk4pLpg23VpamPP/P+f
	vD1X+aNwPPNKCWHvEXAF3LUU4TYgh79Azg8aoeaPH6+xOd8NadLlWhLwKFNtdxTpzrERQC+Ba6G
	K/8PijFvzImd9Wh/AwybViaaWtHudjUk4FXhIpC4UW9ibUHRl70a83ic6AKAs/q921Og91mteeO
	ntdFNLi3lyO0WgPXSX1oocZyrInexsDmYdn7WTNgFB9/t/eTUguVozgFHqd2sERT5PIK4Fvg4MX
	gHc3Msb918O03hkQksLRQALRwxxIxzcO7tittZJWKH6/hvqiTOwZDTA9bQvaWmcpwVl6VhGxaor
	EJPZxPzmwrEwCTFYDJ/M5qSKg/w+tarbyAEDQ2CJ0n0xAs59QWxLiOcXF1PFrVnc/41Jtr+HaD6
	oL55gEiOCm8g==
X-Received: by 2002:a05:6a00:3e22:b0:845:36e8:7a96 with SMTP id d2e1a72fcca58-84536e8a65bmr6414763b3a.26.1781805721007;
        Thu, 18 Jun 2026 11:02:01 -0700 (PDT)
Received: from john-p8 ([98.97.43.82])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8434ad0118asm18772100b3a.27.2026.06.18.11.01.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 11:01:59 -0700 (PDT)
Date: Thu, 18 Jun 2026 11:01:58 -0700
From: John Fastabend <john.fastabend@gmail.com>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, 
	Sechang Lim <rhkrqnwk98@gmail.com>
Subject: Re: [PATCH bpf v3 1/2] bpf, sockmap: fix use-after-free when the
 stream parser resizes the skb
Message-ID: <ajQwWe4SC1M7MtJa@john-p8>
References: <20260618102718.2331468-1-rhkrqnwk98@gmail.com>
 <20260618102718.2331468-2-rhkrqnwk98@gmail.com>
 <34f330b8-60d2-4647-a6b4-a5b001c3715d@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <34f330b8-60d2-4647-a6b4-a5b001c3715d@linux.dev>

On Thu, Jun 18, 2026 at 07:56:34PM +0800, Jiayuan Chen wrote:
>
>On 6/18/26 6:27 PM, Sechang Lim wrote:
>>sk_psock_strp_parse() runs the BPF_PROG_TYPE_SK_SKB stream-parser program
>>to find the length of the next message. strparser assembles a message out
>>of several received skbs by chaining them onto the head's frag_list and
>>recording where to append the next one in strp->skb_nextp:
>>
>>	*strp->skb_nextp = skb;
>>	strp->skb_nextp = &skb->next;
>>
>>and then calls the parser on the head:
>>
>>	len = (*strp->cb.parse_msg)(strp, head);
>
>[...]
>
>>unaffected and may still modify the skb.
>>
>>Fixes: 8a31db561566 ("bpf: add access to sock fields and pkt data from sk_skb programs")
>
>Is the Fixes tag correct ?
>
>Anyway, I don't think this patch is a fix; it's more of a hardening. 
>So no Fixes tag needed, IMO.
>
>
>>Signed-off-by: Sechang Lim <rhkrqnwk98@gmail.com>
>>---

[...]

>
>
>CI failed:
>https://github.com/kernel-patches/bpf/actions/runs/27754218839/job/82113319982
>   Failed stream parser bpf prog attach
>
>Hi John
>I noticed that bpf_skb_pull_data was added to the skmsg test:
>https://github.com/torvalds/linux/commit/82a8616889d506cb690cfc0afb2ccadda120461d
>
>Can we drop bpf_skb_pull_data in parser prog(sockmap_parse_prog.c‎) ?
>And are there any scenarios where we need to modify skb len when using 
>strparser ?

We should never modify the skb from strparser. Just remove any tests
that do this and state its not safe. We haven't used strparser progs
for a long time anyways.
