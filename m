Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D254E28D8DA
	for <bpf@vger.kernel.org>; Tue, 14 Apr 2026 08:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776155189; cv=none; b=M6oykznCsoow6DouKWy61mh7F475Qe5ErLwGgD8+/37KhC0CDVTAMdrNBcMzZ6vI4XBa9i8+X1qrRMqcXgEYZ33v41+zaUtCe+mm3ZBmfAymB2aW7REqxCmtZCF+yP/PLIMbO65746vUgXGtTz65UlQ/a/7oOk+LCp7F+8+U1MA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776155189; c=relaxed/simple;
	bh=s7pGzQNpdOtS4MgwbyFZFR77cpO47eX7uE4J1Imw314=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=duNSCDkRkf+lf8gh5lgVQNy42jiApVj5DaOKfiN6bbJliIhito/+YHu3znQWrPfe3ZENCXeY0SjSIHjlVtjFSev+b+Vpfb8X35Minyh3UyzWq0F8kb5uvc4vYHxg81CdkBJz7rELhpvZjerM67Wub85RJ1EdFUSLqWWHzY1UNPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=DVih2khc; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="DVih2khc"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4888375f735so51738945e9.3
        for <bpf@vger.kernel.org>; Tue, 14 Apr 2026 01:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1776155185; x=1776759985; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gznaa9UOdNMHyu1ZJyIRg7GsjlfRTTNByQYvT20GEQs=;
        b=DVih2khc8CFdsHcnZtOe8qMq043xmBVxn0dF2oTViHP9YukdAxJExuxdXDmoQgmp5s
         e+HqQkxZocd5dz5k+qJZJyNnVGE4sPiewPmKW/h8M6oYQuXBXGPU1NOettmjr9tw4b1S
         ktkMDa3cY9nzCVO+DCjscaAdbMydNXusxvbds2hCnkje4x3R2eJsXorrUPaNhIKVDtne
         FIp2OC56yz2dWHd/yxIK+Ba5poHDgySBCBdCkGBgd4D0UNCZaljtfgixfxlbBJwadv9G
         4V20b3uZeHdvg5V5jG64O/Q3Nvb3CzHV6vz4apD9PCKHBQaWiyuq8QhiXjJVj62nGtIf
         JuLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776155185; x=1776759985;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gznaa9UOdNMHyu1ZJyIRg7GsjlfRTTNByQYvT20GEQs=;
        b=QpqiNWJLrgPZ/e4zIJdSTLSWOfdrZZZEFJDVab6chjRwWHS4xlE7a4p+bJHJXbIaGD
         j/B/g2xWfoai7ltc3EG0Fzovx+EEy+rjhb0IkltrB+l2a1FVwv5+Lv2qQuWGs5RTP7iJ
         T+GbZY/eh8zv34gDBGFNjm3mPEurhQ8VvikaI+O5TXv9c5X91oa9D5vuOWCzwzxxmHpR
         FOXQT+HoSqqzhk8z3zOHiJw1Q/xpGTaih0MyKSJZPbz+faQLh7lixE4ivAjWxB7+eZD1
         S26GSycfshXSo68gfucczb39cPVtp5U2mQDPfws1vnF2VTbtjBbpkHZ8e8MOyKgL4ZZ+
         0ovw==
X-Forwarded-Encrypted: i=1; AFNElJ/oSAC3CYWa/U7dj9PSmxZ+3NjIOTIVCvLHUXUZrKIqBwUv8GbSoHWys0ANTtzWDOIi0wc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLEaA8imS/Jge+T/oklHWcAMl1rtGW4R9M8DRgxry1pF2Ls4wE
	OVzjCc/I3xDxeYXaAMVD7GedclmoFKULielZ3tMSh8ETi0+eQszGzmYUoc81noXfowg=
X-Gm-Gg: AeBDiesStmxfGmxzV4mkHzROJ7NuoEwTniayvNFDNWOIIfFePsKDFXMMvHq/1KxaOkn
	O6ZdZM6fYBwCsjrb0LMMKWfL999LMPX14QT5b7Dwb+2e6Km8EnhwcQV3BAG4+45uKWBtx/3uOve
	ALPRif6du4k5ky9PJBEDBfN4K20J9S3DQVwTG7PuH72WSItfG2oHS/3qTM+KmRVpkEOKFo2PmTc
	cdbG7khZ9FAYsilShhPdUY2JzOEKcLc3T7CuUNw8GAbw4cfuj9EPRgVw67KxzpWDB8WFN3eDrd4
	XUDtMGVRkIujNAt1SXxj6f1SbT5NYcUVjmB3WC7tMvR6WcR0vsPO7OJegSA0KJQo/j57TtVysCN
	vc9GW0P2yDMrywjw/oKyRoOac/SdayOwA0mUUp9G/OC7zAwLPZ1i50C2AQvfKKhnlhgceI1/SZ6
	4oePlgvrqB21LMpYsCk9aanWNwS6wOUALzyLKISOZmKC4=
X-Received: by 2002:a05:600c:3b96:b0:488:b098:b653 with SMTP id 5b1f17b1804b1-488d67f0a8amr229234815e9.13.1776155185176;
        Tue, 14 Apr 2026 01:26:25 -0700 (PDT)
Received: from u94a (27-53-106-10.adsl.fetnet.net. [27.53.106.10])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f0c30ee3fsm14434057b3a.12.2026.04.14.01.26.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 01:26:24 -0700 (PDT)
Date: Tue, 14 Apr 2026 16:26:18 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Helen Koike <koike@igalia.com>
Cc: andrii@kernel.org, eddyz87@gmail.com, yonghong.song@linux.dev, 
	ast@kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel-dev@igalia.com
Subject: Re: [PATCH 1/2] bpf: deduce_bounds_64_from_32 tightening with
 circular range logic
Message-ID: <zeqb2e3d67as3an4u6h6dgvqymchgiyvx2p7mu5u7ns5rx66xf@j5flwnwsud6b>
References: <20260410124035.297632-1-koike@igalia.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260410124035.297632-1-koike@igalia.com>

Hi Helen,

On Fri, Apr 10, 2026 at 09:40:27AM -0300, Helen Koike wrote:
...
> This is a follow-up from discussion:
>   https://lore.kernel.org/all/7fb97184-baaa-4639-a0b9-ac289bf2e54d@igalia.com/

Base on the original thread, I see that motivation of the patchset came
from a Syzkaller reported issue[1]. Can you try to run the reproducer
again and see if you can still get it to reproduce on the bpf-next tree?
I tried it myself, but I somehow can't get the bpf-next kernel to boot
when KMSAN enabled. 

Given check_cond_jmp_op showed up the the kernel stack of the report,
I'm guessing it might have be resolved with Paul's "Fix invariant
violations and improve branch detection" patchset[2].

Side note: were you able to figure out why we get "KMSAN: uninit-value"
within reg_bounds_sanity_check() in the original Syzkaller report[1]
with the follow call?

	verifier_bug(env, "REG INVARIANTS VIOLATION (%s): %s u64=[%#llx, %#llx] "
		     "s64=[%#llx, %#llx] u32=[%#x, %#x] s32=[%#x, %#x] var_off=(%#llx, %#llx)",
		     ...);

1: https://syzkaller.appspot.com/bug?id=6f35b4962ae3653e4190d0ff3e30b882ebe86755
2: https://lore.kernel.org/bpf/cover.1775142354.git.paul.chaignon@gmail.com/

> I didn't tag this as v2 since it is a completely different
> implementation.
> 
> I did do an implementation[1] without circular range logic, by using
> if/elses blocks, but it feels I'm always missing a corner case and using
> circular range logic feels safer.
> 
> Eduard, I didn't use the exact code you pointed, since it seems it is
> covered by your RFC, so I used the logic just for this case while your
> RFC doesn't move forward.
> 
> Please let me know what you think.
> 
> [1]
> https://github.com/helen-fornazier/linux/commits/bpf-min-max-if-else-solution/
> (3 last commits)
> 
> Thanks,
> Helen
...
