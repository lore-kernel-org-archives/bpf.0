Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49E4B4582C5
	for <bpf@vger.kernel.org>; Thu, 23 Jul 2026 12:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784808384; cv=pass; b=C2P0D9PVyQ/AwUGP0hYcEEzm0NqA9VjNCfVbvKri660OyWoRk84YZRotyCvxs3/9FeYpGuSALkxwqAFdJ33YSQ++rEaXU+asjton7upBSG4+ykinHtcL2bF01GZUO/f5/UgW3+oOZ8ZKY4GmVRnL7Qa/T/5TNQzlw1pfQT+RGsI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784808384; c=relaxed/simple;
	bh=VvdkSEeK1pCtA7zottET1dPjUJJE5q2ZltSj3vFP120=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r/FMjgW4oQgGPt144xDegik+MceCZea3oMboiW8q4b38Naze2F+36xf/EHwMDXFVCH7/phCCshERuE6izhsVk/5XI7BqA2Ympw/2ppQmDtEfjEKUTacu+Mh24OPScarCfLLefQVRF93uMEcnvMaYfaGyKzzO83y+XPbB46CNUik=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ssdA6TCT; arc=pass smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ssdA6TCT"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-81e86df8987so4790457b3.3
        for <bpf@vger.kernel.org>; Thu, 23 Jul 2026 05:06:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784808382; cv=none;
        d=google.com; s=arc-20260327;
        b=kBZx9iz781jR21EwX2POsuaAAwQ/iK2DjkuZdw9/hsMO7af4Odnm5MeRln3LCd6Tu/
         H6OSLQU0vhW4/kmaj3ppUaaoxflj/56tb63r3ZgUVEeW7c7To/HsvSgPtsTA0SaZnsWA
         UT+LOy0xJoGX6agUjMWyXeK+aeWP84jwlk0e6mfOlySCaCQhYLyq0nnWeR4270nJSTvD
         wVfvLImHxR/HAj51F2R0OVg/m64Yr8k3c0VnaPzcqlp9UxKYpkWN3RzHIDAVpeSPdvUM
         MzYBbUMXQp58ipKGJEoADyOV48Yh/7jjOJ3Y6ZPK2ungbVDM8zZ/euCO0RxcBk3UhaV3
         DvgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=VvdkSEeK1pCtA7zottET1dPjUJJE5q2ZltSj3vFP120=;
        fh=Q89WiRFWLM8s7kP01HZuMTS3iqGVnGSlWkxygkuX76g=;
        b=WAUN7FG1JxIWpA9Rl7iqI91CiZAbq5Q32nGT9Uzr8XMtkvMZTy4LMWX5rjI0kjf6Tr
         XQ9HGkYrJ7JZka2q4nlA+CNSQq+ud0CdwFCQjPrWS+siKYoqgVRqwaNptroXuUcn2k9y
         B9zIY//hf+GBrqOuMpwJri97njz+3RAfufn7Q08fizpTYIS3CCCdiP+FjzJJ2CiLCz8t
         my2T55D+298NECiVHIwKDWZ4LNj1AVYz5lE397lVOz+MsCNDzHDVos+y2KZgKpOqIVbl
         2S46+5DbJ9caC6wSaTx7ZFyGkmFJfZj4eF3nwrvozkvGxskasBZgIFo7WfIiUU9VpL2Z
         HjGw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784808382; x=1785413182; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VvdkSEeK1pCtA7zottET1dPjUJJE5q2ZltSj3vFP120=;
        b=ssdA6TCTp3sV4yi4dRKTaXyJM5+Bkc9ZNXpm7k5VK6LsItY7ZEYWlJUHIgHRR6dpII
         18pHvYGHUNRngurNlqULpryLy8YBVwJZGvFKpVeyxUFOmX9AH4oz4V/tNZlITbkERa2k
         saSjhbn4ZxQxuH5IMQNjaiHzwNBAIGcfnvJCRCIXkXx0LDiii8cQ0RQ1n0PlOQd3RZ/U
         Y5MGK+RtZcvNa4eqU9lFVULBg7gnBREO6ZX+jla7IMBth1WCy1+m5Y1e9TmLz1mPHZGn
         YYmO6x/36Ejr1T5DkDj/CXG33anjRnKAAjij9kNSkRt8b/k0HAMtqU6L0F/30uq6z3QF
         4nlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784808382; x=1785413182;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=VvdkSEeK1pCtA7zottET1dPjUJJE5q2ZltSj3vFP120=;
        b=SHRhSSWV0/oA1Ru8iP+dL7/6soTO9+YBCjh+fYA2h6snI/YfB/gUA8BoohLzkkRq22
         gliJlz78eflFfSFPw1eD5MYMJYiiM0KVc1VQMwZQKaFgP+sGi7bvdhRzwKwzI9xwABdF
         sOUzzQ4m4joLQl7sxj38xNMizCFQ+cg1w/iY02ZR3rqeZYq8FV9H3iLd3dCQanmXvnBZ
         hGcO7aG2D5yEDebdY74jMRRNRmAkRz49gHp6FL215RubuHeVof+pCq94AwOrXf0fnlav
         Fh7wBK5LmsrmZ1ziHBvzVkwFHJBI6d292vxrQ+NTkADngEKHM41pAtQ1tjYr1PUCgxsQ
         ZbIQ==
X-Forwarded-Encrypted: i=1; AHgh+RokQDbWy6eVGw1LCyyU3+tpDyAo4dnWyllw8ojmeQHGVng/4ucL/ri+8m/iPni9kOtM7b0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuV1kldODQLWT010FhDKv4Rjke8nXBamiK8ZnqHz8hdwhIXda2
	jg1TWbvyhn5Go6X5Ro4lzWb+J+IFSCGRGGOmeUyXknWqC5/aSRhnLVlFzug8+pMoejcK8IY4mqK
	OsKIMe8lyrfL3/HpUx/wb0ybFoVUs/DQ=
X-Gm-Gg: AR+sD12QjcDty62JjYaph8yka3M0a6KFlGZ2wHd3th/l3UJbdA/bi0wAzS2zoDuIz3G
	LXbTaix3sXQxK/JrbEUGBdRhpzUMjkZgkleMlDgJ/wvr+LtflrhQwh9b16LivhvoRoPAsSYo5om
	uKxBinyBStZHjLTXk6pkGRO5DJmDmx9WUiwmUaDaqkWEiV9s9vZT0U327c4KCvuj12cTotLNzun
	Nd5dvLaQTBXSNZ2h5RrVLgUpqm8giSJk+56DY0bHZIOfFg47w8Eu/4OQCc+Jpw=
X-Received: by 2002:a05:690c:450f:b0:80c:85e5:8755 with SMTP id
 00721157ae682-81f4c393384mr8368317b3.62.1784808382077; Thu, 23 Jul 2026
 05:06:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260722041326.75199-1-blbllhy@gmail.com> <amEBJTKhUJHaAsBG@devvm7509.cco0.facebook.com>
 <amHuIvHN1zY4wYpt@boxer>
In-Reply-To: <amHuIvHN1zY4wYpt@boxer>
From: Cen Zhang <blbllhy@gmail.com>
Date: Thu, 23 Jul 2026 08:06:10 -0400
X-Gm-Features: AUfX_myxdYyN-FDseAq5GS0y9o3kOqSSRxpPEbIzRQ50kO1HBtZJPXnfkXDNHuQ
Message-ID: <CAB8m9WjDoHb67ixPVs=6XgFfGP2D4kqM_SSUj5as=xegF63NMQ@mail.gmail.com>
Subject: Re: [PATCH net v2] xsk: reject undersized tx_metadata at runtime validation
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>, Stanislav Fomichev <sdf.kernel@gmail.com>
Cc: magnus.karlsson@intel.com, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, sdf@fomichev.me, horms@kernel.org, 
	netdev@vger.kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	AutonomousCodeSecurity@microsoft.com, tgopinath@linux.microsoft.com, 
	kys@microsoft.com
Content-Type: text/plain; charset="UTF-8"

On Wed, Jul 22, 2026 at 10:55:17AM -0700, Stanislav Fomichev wrote:
> Hmm, the AI review points out another set of TOCTOU issues :-/ I wonder
> whether want to go all in and rewrite the users to have a copy
> of metadata? Something like the following below, build tested only,
> any issues with that?

I applied your proposed patch and tested it against my local reproducer
-- the bug is gone.

> Maybe you want to take ownership of this patch and run the proposed
> resolution against internal AI review?

Please go ahead and carry this forward. Happy to help test further
if needed.
