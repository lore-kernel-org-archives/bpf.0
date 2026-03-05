Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED2E5378D96
	for <bpf@vger.kernel.org>; Thu,  5 Mar 2026 11:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772711076; cv=none; b=rOqrH50HHApRgdZhthWlv6vf1zyrqn32W+irbqP+FUf4K6vPK3Cb+fqiRmcMyfWX0JbSc5RV1nsbpRcwhjBxQzFqfaOMEZoMDDLuAkveNwll2/FcYGguGMxUA18M+1gkOTJX3/8yL69zPBjjmGq16tAzaHUyECpsjutxobbNGJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772711076; c=relaxed/simple;
	bh=/0XFzDbt1OeftBqbZi0eWIao1hkizOLEMD1YcCWqRG4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IG6ntmi90auVeki7NOifGLTZfehNIGpZiKgn3llJMPsxFRfMKOD1sFRTjMEu5CAW7FrsUxS5yEwq7XN9cYCtl1GxgwBU6maqROkveINMSn/E53ya+cY3vzf6tMX2xm73t9AnS2ThhVwj1sp0ZKIQNHKguKJGrJpAVJQ2OSqLsGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=IHFEI3hs; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="IHFEI3hs"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b904e1cd038so1066905966b.1
        for <bpf@vger.kernel.org>; Thu, 05 Mar 2026 03:44:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1772711073; x=1773315873; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=RCxkrMhyBYQPmJVmEwEa8XKJ/EiaedFOYCkENfL/8Jg=;
        b=IHFEI3hsU/ocqKHO79RLk8h24CFgVyCAkXR45MaCrL3fDnHk0poPigkiKVbCBPxt0E
         2AltYmWV6WhbXjRwJlyua0MjyVtOAYiPCcZiXhvAYNXd3v/EJ4C6rDzu+5BmQwImWWLI
         apJCuAXbGbn0lDW08Tboe+A5Hi44VGzKhIScJRKmPSnTxq5WOy/Vq2aWBn8VC58PeijI
         T35okrHtWcoJbqEiTyKEhYj02Fvti9FyqvaywjX8CZCONeT+iQ5Cu/38NWygYPwA13Q2
         Pg+sBdzzPm6nj8MKofYc513Hz/RcEjViVJSSACxSg7uwqMocnZMREdTV/Xmn315uNsjV
         vS0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772711073; x=1773315873;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RCxkrMhyBYQPmJVmEwEa8XKJ/EiaedFOYCkENfL/8Jg=;
        b=H9jantK2kiMr8aKnYgem5FNsmu6+dw1sZ2y2YtkffdUKu+9OyYWbxwRJDnp5Oq03uI
         zIlsxYToWxun6KynMIzetaHdwmyIpAyQsntPhptN5+QPYruiDg1WUHogSAZqjZtB6R6K
         QQ0ip5C5CTYVC9jiN4Lxp0m7V9JclTOmUl5d4Fy9jmS2fEIFfRV0fFwV91woXcO4FIwC
         0XQs/56v0zR88o5hNGc7TQBuQ7rxAYBZ3hapg4NxqLG3swhj++X1WpaP6Sc11BAJckFd
         pbPLfdJJDZ2FCDuno05zKRYaLAgIyViawwup07xwmjCeOOeYFqzSlKnqsaWJblSj/D4I
         F0Eg==
X-Forwarded-Encrypted: i=1; AJvYcCUO3WaOIfYVGiGNjgjDsE2MgYgAtmH6nAEN3lw6FxvOhOT004jlGYyI7aBXFC6PVQszL9c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfOcPQBp6lU9XZXx4Ex9quoed6lGvRf1ftyiq4lIAFOwv5Q4/N
	MrvW/BkBZYlTu+tpKfuyksSQsVWzWyOsLbpnvXXFovEfD0Rt3uI2yjl76VAF2/H+Ffg=
X-Gm-Gg: ATEYQzwAVRJu4g4TtncVssDtpQ4lHaceRMpTtIkXS74/PaS65D1loMQ97tbFPu8dPyS
	/kZDLOJOU2BzdKPmJPhyjQdXaMTljWWpM8QesWoLQDnufwA9YiM5dRpb8BVFmUNajAVEMYHzJi2
	I9DjxJBXsS/lbT5DNDeEVgGveQ4D3j2njdsnxdckb2L6fBx6Uk4lLahG0njyYcMFO2CFh29Stgo
	emiSdEqEcq9BCwwnAgy+94hAG52IgVhHxg8Ng85PZBfe2BxeWXQwUx1Cajzx3K4o6iMmZIGLsbC
	2KcqNza3mC4DyV9ue84NqaOcRWeTe4mYS4GnT/GqcPmBfNhSKiiHBW66r6djk/dXt3U3rpmNryW
	kp1s0cvyjvlZzf6Lae8ahBNpKMx3+BGf6yrIc9PKOKeH7RmYXFHVov+NVVe+YIlCKSxZc20ieLw
	GTeyPgjl11S7nSihUmyu4RRUhv+6R7RpqNCxOSh8NgnJed1Amr1zvXMFwATG8tq8owTAbrlqxB5
	kI9TXrR
X-Received: by 2002:a17:907:9686:b0:b8f:96f3:de05 with SMTP id a640c23a62f3a-b93f1552c04mr299133866b.60.1772711073180;
        Thu, 05 Mar 2026 03:44:33 -0800 (PST)
Received: from cloudflare.com (79.184.124.63.ipv4.supernova.orange.pl. [79.184.124.63])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b93eea5869bsm241536066b.13.2026.03.05.03.44.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 03:44:32 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: John Fastabend <john.fastabend@gmail.com>,  Willem de Bruijn
 <willemdebruijn.kernel@gmail.com>,  Kuniyuki Iwashima
 <kuni1840@gmail.com>,  bpf@vger.kernel.org,  netdev@vger.kernel.org
Subject: Re: [PATCH v4 bpf/net 4/6] sockmap: Inline
 sk_psock_create_ingress_msg().
In-Reply-To: <20260221233234.3814768-5-kuniyu@google.com> (Kuniyuki Iwashima's
	message of "Sat, 21 Feb 2026 23:30:51 +0000")
References: <20260221233234.3814768-1-kuniyu@google.com>
	<20260221233234.3814768-5-kuniyu@google.com>
Date: Thu, 05 Mar 2026 12:44:31 +0100
Message-ID: <871phyo600.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Sat, Feb 21, 2026 at 11:30 PM GMT, Kuniyuki Iwashima wrote:
> SOCKMAP memory accounting for UDP is broken for two reasons:
>
>   1. sk->sk_forward_alloc must be changed under
>      spin_lock_bh(&sk->sk_receive_queue.lock)
>
>   2. sk_psock_skb_ingress_self() should not be used for UDP
>      since UDP may reclaim sk->sk_forward_alloc partially
>      before passing skb to sockmap, resulting in a negative
>      sk->sk_forward_alloc
>
> This is a prep commit to consolidate sk_psock_skb_ingress_self()
> and centralise the fix to sk_psock_skb_ingress().
>
> Let's inline sk_psock_create_ingress_msg().
>
> Note that now alloc_sk_msg() is called first.
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> ---
> v4: Don't pass gfp_flags and instead change it based on
>     take_ref in the next patch
> ---

Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>
