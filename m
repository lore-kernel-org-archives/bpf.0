Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87B15334695
	for <bpf@vger.kernel.org>; Fri, 19 Jun 2026 01:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781834065; cv=none; b=tDkFGPhX/gf3WcaVTFhfP9ZM+rftbi5vaBwtPVkwyqWLdMwcCrDGVw0amExkfHnwU/5qb0iIpoMCHia36RlSGwfulaoQ8mumOiuSAks01YdQwPOpwoAqYd/x8P7hLnmDlMZo8hpFmeekWUMUh4vigXdISc3Gi/zxlqtodvNqn80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781834065; c=relaxed/simple;
	bh=F54uGKLXdXw8RyXpmpClJJ7IJaFDWg2C7EZ6wH5z/xs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s0mYdrO4dDXDS58PBo8ocl9Z3ZdJNyQKzF3N3v9YVepTEUkyp8UvZtvHy0US3A5MjfCkk/Sselu0SllGTlAHTe5Xb6RJzsic1XV1IvQV0AsdjItJaRVAIsHD3hO3uf0DPglHa/Z8z3wOq9zU9bZAv5FlGOUdzz/Mis4BjKtGGyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KbKrnDKg; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KbKrnDKg"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-845537740ddso94426b3a.0
        for <bpf@vger.kernel.org>; Thu, 18 Jun 2026 18:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781834064; x=1782438864; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+Ap11umBm5DdvodyMZh7hH54B56SBafq3wrv+UubuQw=;
        b=KbKrnDKgNXGcEvUfwGwsJNSBAdegJy4zOsyu9szg4AUt50B12gqc13Obhly6DC+g2V
         HgYEYo+VsiT5uKJS/GDGjd7GJWauhQd6nAinCJf222cGraXIhI5oAGOdRU47tTNbAOX+
         KXSZg6WncWNnURY0rQCL3vOOMTG0gFzU+9N/A5ZhKGUOS29IRaEPzQR8mF2+1aQSdt5o
         fK1zdF1RmG7RvOeR9OBNaL6BFKVdO3gV+6aWx2hc1UBiVsHJqXq5Ov4/wN491R5D+lyc
         xpyqWbG7GLkaFcmlWHKSVXuw3UCjLNMq6nqLT+AsAFpZiO6FWsfsPK3Av24hbIqfT1ZZ
         13Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781834064; x=1782438864;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+Ap11umBm5DdvodyMZh7hH54B56SBafq3wrv+UubuQw=;
        b=djO7Spj/f2eG36R3iYkFgRyXccYNTyb05SUD40R8/hF7XczUizdWUI6R7n3KziNygt
         WMaGTV2RGXKTBn2fB3TjSd2OjYJY3BDcOi1RdwXq+d3DtslzljnOx60Nt6JZaz4rVr2X
         9HI1A7RMiAw8HRBioYK0t7utUvwQUTV97OM8WyVAM8IsjnylAcFbNbgfJwv1WvNuYlwg
         f3zepOJk7LRA3TuA5OeQ8OzjYEcf2MZU1SSiPNY1YYNhJ56aJRTPQnWNj96in3bvP3uJ
         AXswZmrwD7ZyqVkMaUlA1tedv8Iy43q+TgHFdJOz2cf1IN9X+XKBhX479DAX3UWp10FF
         q94w==
X-Forwarded-Encrypted: i=1; AFNElJ9vv5rWmgbFOYfdBKLQAcl2pZKrrH94I4qTRgnwcevXiBgZfyPTTxqPnWhaKMDPfrE/Ilo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRDjwlzrIar1fjewKqLr3O5e5Unsy29XdtPEp0HAlscp/GOeOn
	PNdd8KtDOMrMhLaJEnlxE24BQuLHkDXsiwGn519IKAarRL/9z/XSQKAJ
X-Gm-Gg: AfdE7clwGID6/b03SnhDp4A0TaPiwgsmTwDwem0KllicmQtYv3KVaAaeMBdwCo6kd+x
	mjTYDLJciUSEhfs5NvTQKHmlzD80v2CxKbwdOvX8Oq4Do/H6QbnQfX/vVE3cqlfzsFGxx88WdC2
	5YndHTDpSKefmAuPav4ycBxLxqCKU7zhuT3i9s5u9COHSoJT7T9s3p23QZLJjD6+rt63PLERf4j
	Tmb55sAPy+A/IqAFZIq6NLF24N/kZhqA5F99309BM7tZWk3hnXxyxqt3ga5prNvE19F4JNUJdrj
	Gp/BHR9wGuCWYWD69rfSRBGgifLAY3LQo28O1eYS4gAvT6zAyfhUcDL4Ya2mDmLcA/AahGx6fOA
	UAhvPZ9Me0YqeWHys89id7y5xhKk6NK7NHvnCKDDhDFzbmUFVWZj0XwLYPvcIalgNUXeqhXN6xP
	pLmoaj6+Nw29t+PjT5F8rMztMuLNEJ8FdjPGxrS+dMosJRyKaq
X-Received: by 2002:a05:6a00:2e22:b0:845:3fe5:cddd with SMTP id d2e1a72fcca58-845508bc039mr1411984b3a.36.1781834063813;
        Thu, 18 Jun 2026 18:54:23 -0700 (PDT)
Received: from cps-manycore-1 ([147.46.174.222])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-845536758ddsm481839b3a.15.2026.06.18.18.54.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 18:54:23 -0700 (PDT)
Date: Fri, 19 Jun 2026 01:54:16 +0000
From: Sechang Lim <rhkrqnwk98@gmail.com>
To: John Fastabend <john.fastabend@gmail.com>
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>, netdev@vger.kernel.org, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH bpf v3 1/2] bpf, sockmap: fix use-after-free when the
 stream parser resizes the skb
Message-ID: <ybczxlhdqo3rlhhob2zlmss2nxluli4y4k6vj5vophm6hyangc@cnts5oueqlph>
References: <20260618102718.2331468-1-rhkrqnwk98@gmail.com>
 <20260618102718.2331468-2-rhkrqnwk98@gmail.com>
 <34f330b8-60d2-4647-a6b4-a5b001c3715d@linux.dev>
 <ajQwWe4SC1M7MtJa@john-p8>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ajQwWe4SC1M7MtJa@john-p8>

On Thu, Jun 18, 2026 at 11:01:58AM -0700, John Fastabend wrote:
>On Thu, Jun 18, 2026 at 07:56:34PM +0800, Jiayuan Chen wrote:
>>
>>On 6/18/26 6:27 PM, Sechang Lim wrote:
>>>sk_psock_strp_parse() runs the BPF_PROG_TYPE_SK_SKB stream-parser program
>>>to find the length of the next message. strparser assembles a message out
>>>of several received skbs by chaining them onto the head's frag_list and
>>>recording where to append the next one in strp->skb_nextp:
>>>
>>>	*strp->skb_nextp = skb;
>>>	strp->skb_nextp = &skb->next;
>>>
>>>and then calls the parser on the head:
>>>
>>>	len = (*strp->cb.parse_msg)(strp, head);
>>
>>[...]
>>
>>>unaffected and may still modify the skb.
>>>
>>>Fixes: 8a31db561566 ("bpf: add access to sock fields and pkt data from sk_skb programs")
>>
>>Is the Fixes tag correct ?
>>
>>Anyway, I don't think this patch is a fix; it's more of a hardening. 
>>So no Fixes tag needed, IMO.

Thanks for your review, dropping the Fixes tag in v4.

>>
>>
>>>Signed-off-by: Sechang Lim <rhkrqnwk98@gmail.com>
>>>---
>
>[...]
>
>>
>>
>>CI failed:
>>https://github.com/kernel-patches/bpf/actions/runs/27754218839/job/82113319982
>>   Failed stream parser bpf prog attach
>>
>>Hi John
>>I noticed that bpf_skb_pull_data was added to the skmsg test:
>>https://github.com/torvalds/linux/commit/82a8616889d506cb690cfc0afb2ccadda120461d
>>
>>Can we drop bpf_skb_pull_data in parser prog(sockmap_parse_prog.c‎) ?
>>And are there any scenarios where we need to modify skb len when 
>>using strparser ?
>
>We should never modify the skb from strparser. Just remove any tests
>that do this and state its not safe. We haven't used strparser progs
>for a long time anyways.

Thanks for your review. Will do in v4. 

Best,
Sechang
