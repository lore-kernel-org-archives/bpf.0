Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794666787;
	b=N27R+xcq6xByZQXyqMOmYLrYMMlGfpXGjBhuGhmCnUKCGmXihpud8JpYLZplY8P3Wy03
	 ao1EbJx79j0lUVWqHOOTFeHCvovJI1WFwYCGc15Rup5xoZpxxr8qijDdWMt6hGAC6AI9X
	 oLSY6pJtSGBD6URx+5+r+YeYyHDG7sbsTuVsQMzYDheZ/VKB6T06GJhn4/sNYz+xMEle3
	 /SetDcJfHa1e4/29fUCBgwoxIafAjEdPKx592rD2PFEiUVOEXdMm0f638YMvbTdN3HZxU
	 KNtRu3MGt+AlbcHHoW0uRjpGhXtf7Xdx61Za6hM2H0pPqccdXqQD5gT6ARpqsgYC1TA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794666787;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=zZTHArb7/cDEOGGmixdYHyste9bMwihASbVf49eSoI4=;
	b=KqFJBfoXf/s3Rpd8xCaPzbRmKxn9UqRYXem/md9CjZbtYWICl+30qySSYPy7bipT9k3Z
	 IWjZXOEyY1S4muYnbDnCAWBKB1js8uMbUwKtXRn+ivdkEK9qzaLWa0h9uckXja62Fs9e4
	 ssDfgFHNFEzy60PxRK/tv2KQTaRgM/b2WE2QxgiSA4lI1YRV7X3VK+CgkubJomjw3lEYD
	 KjlhmLsOD+doDsWqjTPJU0gjVk44jYaXquYpzqCjeNt6JZXRCvKsTTGPbkJEi5ZQTmfyt
	 VD3n+GbUWbhEVpQded54ZMHs5c18kddXrG1xkK0Tzo3UM8kyyJsL6X/uba6jrAYDoOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=o3UL23wO;
	arc=none smtp.remote-ip=209.85.128.47
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 407DD606A327
	for <bpf@vger.kernel.org>; Sat, 14 Nov 2026 14:33:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 407DD606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=o3UL23wO
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4a9a8d6cea8so20082605e9.1
        for <bpf@vger.kernel.org>; Sat, 14 Nov 2026 06:33:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794666784; x=1795271584; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zZTHArb7/cDEOGGmixdYHyste9bMwihASbVf49eSoI4=;
        b=o3UL23wOoojCCtw099LOef2o6FXVCYwfWYdM+YI1ELuwWae0ZY5CRolxwTnSJwqRo6
         tbmG7+Rxxvu7K+Xqs5BLB3WcVEs3MzYOF9EXviq05ByDs/kG4OheQ3+y71A0hUo+HVd6
         Eyr4xE6/uhsBTxt3gWXOtnN1bRczoxfiaKwMj2ow7adwVjJoWGJ1Z7bJgjFYxAYXQq+Z
         NNJahNh/iFfyTdhBEZsOABZe6f3g05zsZj5vT/hTlCYUgzzzKDM8gQbCEBp0wgkUBpG2
         fgn6OgovIRBTzLaHd10nD8jN2N8xl0Mrmw4MHrnqFr/sXmdQvxxe5FwyH0GoDA9It/rc
         PquA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794666784; x=1795271584;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zZTHArb7/cDEOGGmixdYHyste9bMwihASbVf49eSoI4=;
        b=fWRx9/Ms/XljX4M9D08u/lUm/YaGcsVXzSgcYHcU7CKJAdQNQGau/ZIuFc8s4tacdT
         j/rOB17JifjoEwXbiZfHryx16sI7O3a0lpGjxKHgKwTfbE07xeWzqiEoYV64I2w/0XhJ
         zoTOag+BxyRCIJeFv2L0zGhe1pl241JY2iegNRNozqVYy1fXibS9Rz4MuYhMmjnCAiMn
         2SMl8QIQTcp5Xa1/zWMXbf1SEsFuJypUwo5inEH5LUg2IvcCo3Boqa3n4kP05HjvZQUZ
         fHmUeBxLdTfnw8xrx/f9O4+MZCn93rtqk14GPmxypi5u8vwhQQvs9pLrM0V73q31CyGr
         XdKQ==
X-Forwarded-Encrypted: i=1; AL+hErFnlNNNbqmLg5Idl5aw/gNyENQgkgzGJ/X3iafYixOTP+gKBJkixzymekYZSafSxWkaa4I=@vger.kernel.org
X-Gm-Message-State: APuU4Z9VKajJlvEpd8Z1hpmblhNoW4yCSAlddFnS3PqrCn1MI9kRbVl2
	Bg5kWR/AswmDffKMyz9dcf7qeUYgV4rq2hLS3NodlaufXxwDS/XiVt+q
X-Gm-Gg: AYBFou0IqryTKmTwATcmGfKGV/qyPL1l1ufHHccg8u0BcZysM/8KJBc5BNTC/DyLPWZ
	ilizM93zOX5gSMPn7jtz3Ziouiv5Iew3/NOC9dKbkaE2yxYAXFAJu88rAC8O7X5Y5T87AR8Cqm3
	BbUsnCnfJmFNpC4dKdvV+zSsV2AvZlwrS8By0gVZgaIVmV1Tha2eyh/v20eYUVSOhZs7JYvtJcZ
	elmDGb3MS78uj+VydCvnf5NI1RUJ87ysDoSXRypaecDSRjbgP2AbeHcJJrGRN2luxFLE3A6v+nk
	VFkMr5cw8URE5ptJ3fHf5O+GFTe6OitR/oQBHuO1M8RQ+1nzqGDEODvwEgBcNOsxzC2aCL7m52c
	wBaX69ojjqAic8kAHgucsKMq9YBtL8OhjVCJGpycVKIlE5/f8j4pPedHoFo16K+gsVYFyVO9jlg
	RRha5TUW/CsLh6qYU3cKY3yLU8iXYwt3vaPgvtI+NviR3VGZJ6AK/kxjDhLM2tr2PhpYkx91DiA
	RJf/lf0SoXf4m/r6UuV8dUCSkGiNjpf3U5zjJLLRJ4pc/aOygJ9REQh5CBcqmb0tLSXX+tdUCMe
	voqkEXc1dXeM9JWXpEOdkPqj2UKG9zXhZA9/Gb8OayP8ATw/az7LyJ6npSsogBqKKg==
X-Received: by 2002:a05:600c:4691:b0:4bb:5e8c:13bc with SMTP id 5b1f17b1804b1-4bb5e8c13e4mr80850505e9.7.1794666784523;
        Sat, 14 Nov 2026 06:33:04 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb56fa1062sm95802815e9.5.2026.11.14.06.33.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 06:33:04 -0800 (PST)
Date: Sat, 14 Nov 2026 14:33:02 +0000
From: David Laight <david.laight.linux@gmail.com>
To: sashiko-bot@kernel.org
Cc: sashiko-reviews@lists.linux.dev, "Petr Mladek" <pmladek@suse.com>, "Kees
 Cook" <kees@kernel.org>, linux-kbuild@vger.kernel.org, bpf@vger.kernel.org,
 "Jim Cromie" <jim.cromie@gmail.com>, "Lorenzo Stoakes" <ljs@kernel.org>,
 "Luis Chamberlain" <mcgrof@kernel.org>, "Andrey Grodzovsky"
 <andrey.grodzovsky@crowdstrike.com>, "Steven Rostedt"
 <rostedt@goodmis.org>, "Andrii Nakryiko" <andrii@kernel.org>, "Samuel Wu"
 <wusamuel@google.com>, nathan@kernel.org, nsc@kernel.org
Subject: Re: [PATCH v3 next 05/13] kallsyms: Fix selftest startup delay
Message-ID: <20261114143302.3eb7125d@pumpkin>
In-Reply-To: <sashiko-outbox-208986@kernel.org>
References: <20261111115911.1142000-1-david.laight.linux@gmail.com>
	<20261111115911.1142000-6-david.laight.linux@gmail.com>
	<sashiko-outbox-208986@kernel.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 11 Nov 2026 12:36:03 +0000
sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential
> issue to consider:
> - [Low] kallsyms: missing Fixes trailer on selftest startup delay fix
> --

Missed because it isn't worth backporting.

David

> 
> commit 06f0c3fe023ccc28da9c2bd9798921899fb0ec63
> Author: David Laight <david.laight.linux@gmail.com>
> 
> > kallsyms: Fix selftest startup delay
> >
> > The kallsym_selftest code clearly intends to sleep until initialisation
> > is complete in order to get more reproducable timings.
> >
> > Replace the schedule_timeout() calls with schedule_timeout_idle()
> > so that the thread actually sleeps.
> > Poll every second (not every 5) for SYSTEM_RUNNING and then wait
> > another 10 seconds before starting the tests, otherwise the tests
> > start as soon an init is executed.
> >
> > This code is in the initial 2022 import of the tests.
> >
> > Signed-off-by: David Laight <david.laight.linux@gmail.com>  
> 
> [Severity: Low]
> Since this fixes the broken schedule_timeout() call from the initial
> selftest import, should it include:
> 
>   Fixes: 30f3bb09778d ("kallsyms: Add self-test facility")
> 

