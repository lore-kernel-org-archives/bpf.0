Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48F432EC0A1
	for <bpf@vger.kernel.org>; Sat, 31 Jan 2026 15:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769873860; cv=none; b=G2RzCssmrDlOb0BwrEJPt4jSN3qYlfX5UjrvTQTvfuHvAzdYrDT/gzsMPKOYfcZZdKhR0vRdtv9F5lUzR4SLl0n1YRjXd4KSX0j8mKZjhTFnqCWtDOYftTQ5LICa587S1JxM2IyyUUpknGUDbLX/yyPP8Bk06iORqV4asA6mX+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769873860; c=relaxed/simple;
	bh=lFbN1ibUBCn+rfsJwuXg8x9jgyMUTQsXiXRrAR+KlJM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IfCameq7PkTRrViEQDd4tkBs4vWO6XF2mCumyN4ABFLGrTg8BB5FqCf2W3x1Vdizvl9MGAfAg3Fj6Oh3am0c/2OSXZaA/4abU/LlLApCt88NLh5s8WfvMhY9qsrRO+KCWkO5G5dhXF8g6f8twMZjIekFA1tbDGQg6dLoKFb62+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LKLL/PF3; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LKLL/PF3"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-42fed090e5fso2460136f8f.1
        for <bpf@vger.kernel.org>; Sat, 31 Jan 2026 07:37:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769873858; x=1770478658; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fiS78dJ3E+O9/koHhs6/YjJ5zOTAaZI2BPhavS+ZM4w=;
        b=LKLL/PF37LNsasvQeiStabOoc4MTAqg5cxw12Z16BGRdPsZ3k8BNy1lZii6+vmer0P
         i3A9u6wqNIqmHtP6GWciy6QnpDt/n7wiQ897b71obCRHaxQPBsrLj8g++OenDLgSl0JU
         4QnwMbgPAL8JknhbNTmjiu4oRqiK90lNogDknzHfnYY6GhnCYt32gNSHkGwOsinGgwM2
         S/1uMXzRvVBhywF43Zp7BOcGsRplneaOZ5iyeUTwEzhmX/YAvlzLLiSabuBukDXL7VNg
         ydZrH+up0+QphBayWrBIY9WKsYoZDGSznlURirDIEVGX4yPGI90m4GWN2mv/fy5T2rSw
         3K9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769873858; x=1770478658;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fiS78dJ3E+O9/koHhs6/YjJ5zOTAaZI2BPhavS+ZM4w=;
        b=xPKdMPbiKtx7RC1Hc41MQnNlVJlLvT5qh2D2rjW1sPxqcBmKxiTkPRBKF2A6p2d196
         aYb523Ru1+fKJbo+BeG88QUhAFcwtbjFLGU2udiDYsoSNX0P7wHnw/i25fDcNzxfBq1m
         F3fXKrSj1M9zIVXNS4Tep3Mnz/HAfdsa+rjXaOZLaeWwhK4+lENHfPe1yOYuf5T2nWdt
         4DXsv3acESlnijhl2eArddmZ2oGvjnaUEi7syD/v3SuFWVEqTyVBfIvUlhkk3EiZDO34
         RhbjYN62oFPMI0bOF/QV00+SxdFkvRH82MHTP0UbKuEBkNIxoT8AnJa4nhF75JeluGzW
         cApw==
X-Forwarded-Encrypted: i=1; AJvYcCVmtPcK0QIpk9Mb+WXe3mOckhWh0wTdaZiGVpPohT62TJKIekGk+nIdCvYU7q00Xcu/SF4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzIhmz5Rpcep2QuT2rwH/EKb0wjllbH7o0UDx2hvUjlF5quyqK
	wRbeWfFrFH7qXF5OKaslaAE0xJ5G5E0ctAdogXYYZmvNuN83CDWwM/oy
X-Gm-Gg: AZuq6aIuQJgOY1b1pbjzrJbQhuiu3U+PBVsP01qFe5S/ai0cAvs/Khsu7YWO+sAYjbV
	wRvuw7bhQmda0eUH22o5YEMw5IvQcUjM03OV4KxIlZV5lGr9iooUs/VQJiRpq15g1S8YzBabKok
	qDdo44X+rvk/Turw08xQ6RsQIm3kHRG4GkOnLAUs3R5xvvDBspytWlTXHZdE/ULc99mXjloIUyV
	fQaUoAs4TJVc0jiYxS8ix7XvFh/9T/2o9F7GQlJIAziBqgCXL5bTIM4dOB/S2UlgzGjxPay7goo
	NkmrwkAGealm40jk69Glz4gSV2PnNWbbbZg3a22nVXM6L7PHU3sn0C+/bGOwxhDNd/sP6ee1yjS
	kO+ZDkK0ANzaeohgNHSPMVWCqffhaN+BK/z1tSycemgpk8pS4ck6ONMYBC184GDMJmG97i8HzZl
	7IC7MHHoyKLwsYER40ZaNnJ71xl/nDKl3veGA3mKGiXgZByKHtElzTYJ1ATcREogU=
X-Received: by 2002:a05:6000:4285:b0:430:f3ab:56a1 with SMTP id ffacd0b85a97d-435f3abaa14mr9728576f8f.42.1769873857412;
        Sat, 31 Jan 2026 07:37:37 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435e10e48a6sm29620829f8f.8.2026.01.31.07.37.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Jan 2026 07:37:37 -0800 (PST)
Date: Sat, 31 Jan 2026 15:37:35 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Breno Leitao <leitao@debian.org>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, Willem de Bruijn
 <willemb@google.com>, metze@samba.org, axboe@kernel.dk, Stanislav Fomichev
 <sdf@fomichev.me>, io-uring@vger.kernel.org, bpf@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH net-next RFC 0/3] net: move .getsockopt away from __user
 buffers
Message-ID: <20260131153735.3c9273a8@pumpkin>
In-Reply-To: <CAHk-=wiiPxGrVxFzzf1nbx7_0abjZkhmd9oPximUxUyDM7gwug@mail.gmail.com>
References: <20260130-getsockopt-v1-0-9154fcff6f95@debian.org>
	<20260130205227.6fb1d9ad@pumpkin>
	<CAHk-=wiiPxGrVxFzzf1nbx7_0abjZkhmd9oPximUxUyDM7gwug@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 30 Jan 2026 17:19:55 -0800
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Fri, 30 Jan 2026 at 14:40, David Laight <david.laight.linux@gmail.com> wrote:
> >
> > There is not much point making the 'optval' parameter more than
> > a structure of a user and kernel address - one of which will be NULL.  
> 
> That's exactly what we do *NOT* want. Because people will get it
> wrong, and then we're back to the bad old days where trivial bugs
> result in security issues.

It can still be a (semi-)transparent structure that code isn't allowed to change.
That is no different from using iov_iter.

> Can you point to an actual case where setsockopt / getsockopt would be
> performance-critical? Typically you do it once or twice.

IIRC a really horrid one - I think for async io.
That is also one of the few where the supplied length is a lie.

	David

> 
>               Linus
> 

