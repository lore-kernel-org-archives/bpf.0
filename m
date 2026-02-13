Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B370532C331
	for <bpf@vger.kernel.org>; Fri, 13 Feb 2026 10:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770978115; cv=none; b=EGnipYGoYQfCKR3Iju5vh3BVd0X2HhEvDN0XIoLWsoFs1eR0TtAB5jWKcwa/q9t7rGa2lEsJp/QJ3g2V0H5VdGuKmprinB+NwjWOtrY5rpwOeQ4dZkpRUFwvC1HLsDinxHZavdncFu1zDYkbMSIvfh8owlM5qtal5lwI9JGOdXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770978115; c=relaxed/simple;
	bh=So9xWeFEUrm58wRB5ilqa33PpLzyw90FIza6V2SASy8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JG/mgrywvJQ0kYU90Yr+RgMmGN7i/jEZA12q7SOVOD/bSNtCajJvrb0k33vtztbJLgogHbjkaWSUpSyHpLKYKWNr0+x/IuU4AVSxCEygz8Xo06lLPXNrbOW5Ue6r0ZBC31wJ/E045nkqzrXzJUNvLvi4rbDCOz2K86H495U0pW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FMdr5p8Q; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FMdr5p8Q"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4801c2fae63so6116555e9.2
        for <bpf@vger.kernel.org>; Fri, 13 Feb 2026 02:21:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770978113; x=1771582913; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zin/vneRUguhBG4fcbrCXY8+exjw7aASRCjjvjBSKHw=;
        b=FMdr5p8QGyPvmmg/yxe8o2d4vfqxtKGnZZ5T7wAaR1z0Ixhrzv/wLQuASUONP1UXoF
         O3HZwuYNEvAK34kFVvIGlAFMsfNGYUFshDtN/27TuH0txdOvJIMj/LLSRfoiaA+UYUmM
         asCezMH347OGH+2lnmboaI8vIUMETw11aH+z1UDJ0EoabMHL79bTkqoWj3GVSX5cvH62
         eoE4fiOY6bXL3BiVVmlkdfBl1ZZQTtNuwQVdQHRwmdE0uoLYZdihoUEsUfu5rjs+dG43
         d0RvYjGvoWGeE9nxInY2yrW7GuSragLdFbe3Q55nSVi8P19XYTZi2Soa9GjQ5G1Y/Wzk
         NqmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770978113; x=1771582913;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zin/vneRUguhBG4fcbrCXY8+exjw7aASRCjjvjBSKHw=;
        b=TR0841iCcpQTYdeE5iLT+pxwgDa729EyUXLFaIV3+A4zoZpRMIxbwEwsBkJDJ6xbgk
         ilfjYBeRcMDkrV78QrqKfv9vY8IVVjJhnLl7CP31cAIrWY/2vuW/JAZoZtWlgWRaeSOo
         2N/5SY1x1Bk4zo8EWFrkLjTbF8NP6uRss+nkDCvLfQiGyuoWQ4TnblgLTTRRInrfyHHv
         L/hmHOvuBSSmDhqaWDM0XSDn1wcRX89DuyEpW8a2sGZfM1Q0nwXH6O0lnwukaeUG55Jk
         lYhsF7kZZS0mSVdQq8/gMMaorvB7nPEjaXmWWcQy4nrR6wkB923aGcv5R/WAydxXBeBM
         tCCQ==
X-Gm-Message-State: AOJu0YxOfRVK5xjRqt5SaTRuqNcZgsgl/rtlzIq4W3UMhMiucEOf+3gR
	a+KhU/oz8g8HiWAqMowuOQrsCGwIxWmuPHUinQSTkQvJhtjK1x8tTsF9
X-Gm-Gg: AZuq6aINCptk4aTmTLGT+758rLnRjb0XpRXLoNKsDVwd7Wdh3M71y+UNCOvXlLj8b71
	9zyKLI1Yr4nKtFcIX7bW6sLhcYA4ynWyxfueUN0IZdz5eoAo+ByCAkgjnQdvjEcTxtqI93P3Wxn
	5T9PN3f8OAub5RrnvPZFYOzgCYVxWUzzINFpmqpJOPIPDaZeQxXWqcRLQcO1GH5zJyNLXFrI+Q4
	iicT4PmPGtIIvGJ1AEc+/EEUdDeS7HJ1GKReBLQ4H6jycsBzxRcn/LF/fMucNWVDhMR/Eifqzil
	6/QPkX2eHW0Yp2TcavoIfpF8CYmolO7Yl9XCVyHx8OALJeB/BqmghvcgjlS5E99hO5bEk619oaW
	JFd4v9xNBuqFm2rcE6y68oXde/uRBUoVVxC/jHRMAIIWFikqZwaf41JDLnCFGCdj7cVnU+j65bF
	5XKCqvccvk/xSj8Di4X3JvPqLREbbAU/i8ftdbOfHrrmg=
X-Received: by 2002:a05:600c:474e:b0:479:3a86:dc1f with SMTP id 5b1f17b1804b1-4837109740amr34875915e9.37.1770978112880;
        Fri, 13 Feb 2026 02:21:52 -0800 (PST)
Received: from mail.gmail.com ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4834d5e11f5sm243862745e9.4.2026.02.13.02.21.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Feb 2026 02:21:52 -0800 (PST)
Date: Fri, 13 Feb 2026 10:29:57 +0000
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: bpf@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [bug report] bpf: Fix a potential use-after-free of BTF object
Message-ID: <aY79JehckdNVA2ND@mail.gmail.com>
References: <caa37f28-a2e8-4e0a-a9ce-a365ce805e4b@stanley.mountain>
 <aY689z7gHNv8rgVO@stanley.mountain>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aY689z7gHNv8rgVO@stanley.mountain>

On 26/02/13 08:56AM, Dan Carpenter wrote:
> [ Smatch checking is paused while we raise funding. #SadFace
>   https://lore.kernel.org/all/aTaiGSbWZ9DJaGo7@stanley.mountain/ -dan ]
> 
> Hello Anton Protopopov,
> 
> Commit c81e4322acf0 ("bpf: Fix a potential use-after-free of BTF
> object") from Feb 9, 2026 (linux-next), leads to the following Smatch
> static checker warning:
> 
> 	kernel/bpf/verifier.c:25375 add_fd_from_fd_array()
> 	warn: double fget(): 'fd'
> 
> kernel/bpf/verifier.c
>     25360 static int add_fd_from_fd_array(struct bpf_verifier_env *env, int fd)
>     25361 {
>     25362         struct bpf_map *map;
>     25363         struct btf *btf;
>     25364         CLASS(fd, f)(fd);
> 
> This assigns f = fdget(fd);
> 
>     25365         int err;
>     25366 
>     25367         map = __bpf_map_get(f);
>     25368         if (!IS_ERR(map)) {
>     25369                 err = __add_used_map(env, map);
>     25370                 if (err < 0)
>     25371                         return err;
>     25372                 return 0;
>     25373         }
>     25374 
> --> 25375         btf = btf_get_by_fd(fd);
>                                       ^^
> This re-uses the fd.  The reason behind the warning is that the user
> could have changed the fd to point to a different file from the
> start of the function.

True, this could happen. Not sure this is a real problem (if a user
replaced this by a valid BTF, well...)

>     25376         if (!IS_ERR(btf))
>     25377                 return __add_used_btf(env, btf);

The problem with this piece of code is that originally I wanted to
keep naming/appearance in sync, but the corresponding map/btf
functions, historically, behave a bit different...

To keep things working and to address the bug report in this
thread, one fix is required:

-       btf = btf_get_by_fd(fd);
-       if (!IS_ERR(btf))
+       btf = __btf_get_by_fd(f);
+       if (!IS_ERR(btf)) {
+               btf_get(btf);
                return __add_used_btf(env, btf);
+       }

I will send this fix later.

>     25379         verbose(env, "fd %d is not pointing to valid bpf_map or btf\n", fd);
>     25380         return PTR_ERR(map);
>     25381 }
> 
> regards,
> dan carpenter
