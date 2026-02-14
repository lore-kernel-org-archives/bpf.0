Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 104C97260F
	for <bpf@vger.kernel.org>; Sat, 14 Feb 2026 11:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771068688; cv=none; b=jY047GCyt/UnAP7BYjkCDZa47nVsoHLr0zonadhsI1zlEClOqHe64arZHTLl30F8dd2YrQ2CFJBo5piDaHs5DU0naK3VbL5xvcpgsuIO/WhXyirZd7oaW9NQHQ5sGWGgrnlLpIy4g7vnpBkBRbik+TQc9mVNPuglSZpSBpA3Xnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771068688; c=relaxed/simple;
	bh=jgsb6aSE7WPnfxKv5PMCEz/G0xsKQZzyhcPwhL0OMgo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W+VaA9rrOSM5vPljnxr4ZoqmW1YMc6VUsibLBtZNo4BAXPQWY1rmdhe8Fe+qpOzyzdIadlm+vqtWDLrNnRbDk3y0BvC55EZvyYpGk8f+Z4hynuCHXhw53o3vHJkNjEqWEW9txGMEv6R+Y37i5/t/Ta1N8whISxeBRBZDdNF8R/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j+veXALJ; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j+veXALJ"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-483770e0b25so10771165e9.0
        for <bpf@vger.kernel.org>; Sat, 14 Feb 2026 03:31:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771068685; x=1771673485; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OiZwlgtBXqE7LEsN2nlgf0AbHOoRJSUt9gOPy7eO3jU=;
        b=j+veXALJDkt8Dv94RwJ93S6+z5F1N3shcNGHNyUGucVq6CEWAt8DHu6S4lCZzFvwLN
         hR36fbgT0F38L58OaU67n1bpI62qdMJkrbm98OSKNS+TenaUriw14dWxiKYbvtE34ILh
         03oT6oLRRE9jab/l2tDf0WgiTkheAxO9dAYTczezqhuREFn+nNFIG7cqWiM6KVFgBHcr
         Iw5DfMM8WHEB9mFkDLtfJsNYbivZJ829JVUBGmLUVpXI5T3gFFz+jM7v41Jdvkmuk5Dy
         0Ikenfn7STop8Q0TC+1Tf0CzUmfAq2K9AJIZ5SBZT7TDxk+SmfwrkJjcRnwVe8RwOZYK
         kX9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771068685; x=1771673485;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OiZwlgtBXqE7LEsN2nlgf0AbHOoRJSUt9gOPy7eO3jU=;
        b=EvWHtuEopBQgU+cJwJjs0KETKGeNvAOhiLgBxBQNzpkqXNAw0RJ1iQnqclJDVIkMbX
         TPSoApork3rOrKI17ocZhGLqOZRvqhF9CR4EgdMOfKwrGyU+wQbHgjyVrlVx/sYEQzgH
         Lu9gNTj1+4UGf0LtgO3y8lao6mFT3+TgyH135Vz0EPEX51BEDmmLEF+C6h/bjEk8zIja
         TMg/m6njyfpFH2Doh7ItIxY9dDDt2uZxzsNZEi0HPL3YZqZRlEqoOVoWlbH1Dx7+P2nT
         q3f1dnhJfOl+YRmDqWQH6JdNoPM01QWB9n18RmsS24mkroVLPIG+uQZUoz8gk8UIxgsG
         qBRg==
X-Forwarded-Encrypted: i=1; AJvYcCXmVvot/s8o13gRDMnDdOBEqNES8XJW5CSLOONqySSrN07UhCs6dZw12SZmpPjzRuR4WgQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKut91CgGbvp5iHhES0Iok4H0VpX2/f2L2wWjHTR77FiFN3QSj
	NH7f9hC+i8GzsJHWUev6z+6/VlNHYFvJxrdDDQAlIbDFP763h7WMh2xg
X-Gm-Gg: AZuq6aLk/x2DoLs1rsGNXGnJdNevUHj1suTg3bPRPgWG4m+9iUOObKQuor0vc71+ghn
	ySN5X5Jr2WnjaQtKPi6MiBx8NDxrNbiex1de2aN4GDqh8UbDAyXOZv62a8y0wcZydpXgKcFLQc2
	2NJoXT3lb6rtaRu4y7l89neBYATOEp1NpoIMAuuzF109xdXOdTpLS9FM7VUS4zRBwJpLKXN7rTC
	eLj08A/+aH3s1yOogXBVswJfQJoyS8sbdFObB1tveN6RxblfgmarC4zOnm3WjESPpOg5nIk2fnm
	026sYHynI2gRjmbhApVwofC0mKjQrlwbRk+axnawq7RwcXMXeNunSqOHl7hwl+SuL4z4UtXnpWQ
	FGxAjo1GdgyDd6dc9bVUII5S1V8GVhHUoLM9uNG+Jrhz+4W9kn0E2sD2EOJ5d3+75QdlGWy7grW
	q3rkHpnon6QQMNDZvZ14nXfrFXUXv533/p5r/AfEaJgiE7nbgulMnTHKtMeM5eddlV
X-Received: by 2002:a05:600c:3f1b:b0:480:68ed:1e70 with SMTP id 5b1f17b1804b1-48371096d3amr84223035e9.35.1771068685196;
        Sat, 14 Feb 2026 03:31:25 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4836aa0847asm237182465e9.3.2026.02.14.03.31.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Feb 2026 03:31:24 -0800 (PST)
Date: Sat, 14 Feb 2026 11:31:22 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Ankur Arora <ankur.a.arora@oracle.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
 bpf@vger.kernel.org, arnd@arndb.de, catalin.marinas@arm.com,
 will@kernel.org, peterz@infradead.org, akpm@linux-foundation.org,
 mark.rutland@arm.com, harisokn@amazon.com, cl@gentwo.org, ast@kernel.org,
 rafael@kernel.org, daniel.lezcano@linaro.org, memxor@gmail.com,
 zhenglifeng1@huawei.com, xueshuai@linux.alibaba.com,
 joao.m.martins@oracle.com, boris.ostrovsky@oracle.com,
 konrad.wilk@oracle.com
Subject: Re: [PATCH v9 01/12] asm-generic: barrier: Add
 smp_cond_load_relaxed_timeout()
Message-ID: <20260214113122.70627a8b@pumpkin>
In-Reply-To: <87tsvj6hwf.fsf@oracle.com>
References: <20260209023153.2661784-1-ankur.a.arora@oracle.com>
	<20260209023153.2661784-2-ankur.a.arora@oracle.com>
	<20260212095621.4d99317b@pumpkin>
	<87tsvj6hwf.fsf@oracle.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 13 Feb 2026 20:58:08 -0800
Ankur Arora <ankur.a.arora@oracle.com> wrote:

> David Laight <david.laight.linux@gmail.com> writes:
...
> > Plus the cost of evaluating cond_expr 200 times.
> > I guess that isn't expected to contain a PCIe read :-)  
> 
> :). Good point. I'll see if I can add something like "when polling on
> a memory address".

I've only timed PCIe reads into an fpga (Cyclone V) target, but those
are about 1 micro-second - which is a lot of clocks.
Hard logic will be somewhat faster - but still slow.

There might be other places where 200 isn't a good value.
Perhaps add an extra #define that drops in the loop count?

	David
