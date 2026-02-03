Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7448F34B683
	for <bpf@vger.kernel.org>; Tue,  3 Feb 2026 13:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770123954; cv=pass; b=hgVp5bxj4VrOtEC9vrnVN1h0PuQkSCKNi1Jf4GvV2qAJg8NCjm5gjNPwktH0p5AZjwHOyx1o2tsjVFMC5Bd/cakar0MrFK9bfHK9M4DH3KLoYPDBJ+y5FIDdqPSSXyV6mQkgoLoURT9v229uSL0XLj+Dm0Lj7aMUphVHhBYCkaM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770123954; c=relaxed/simple;
	bh=voLKekegcCZk0vr/4QPCTc1uZsgmhHcmtHb1yEzgJ0Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xhr/62T5P2a/HBxBx6wdeNjMS+w8UYl/APaElcTu6zT52uvIx7aZzwbN3s35a2DSBs0Yjk2EwyuWPryVQAgubbwpgT5xld7V0htmH2Wr2RydwKmvSugbc/PewD4wTRW9WugC67DkJPQMBO8rJc0l077+Q6x/jEIxNI6Wga28tU8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ah77SLl7; arc=pass smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ah77SLl7"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-794db376fc3so20087527b3.0
        for <bpf@vger.kernel.org>; Tue, 03 Feb 2026 05:05:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770123952; cv=none;
        d=google.com; s=arc-20240605;
        b=Kk8hoYq0XirIaEBiqqUXOpKJbrJDrgkV0zU6v3f2cYpCFV5qHDscWeRbTIJuekOC/u
         srghKY2G0aAY6KJ25c1mna5qyOeAib7nKm7I7Pu+kSWM4f+8KbuKPISs4iK7Jc2wi022
         NGFINkseJIl9CmYZgg6QgdFhlkrVY5jmnBskvC8bqmaupA9tm8YaaiVr37JqcQC0e5v0
         Ad8EOOn/OeTb6J4JNLdzAdeF0SdwZ17I3IUMrQOrixO2DBAYceMBtB9u4a0Uu9+q3TeS
         UK4cd5Qh9d7R34jqXK1lDewV8SE/N2NyS/zQabV+yKFbAzBE4z+/1ZBb8FB5kfNgsSZ7
         gWsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=EzvCKkHvTDyl5Hbu0UI0p5YJ3tj4x14liy6theec5Kc=;
        fh=HGa2Ht1KfYXPiLqNq1eXjH+mE5lrfMjz1Br6ldgArMU=;
        b=OdcpYhHNCQyFBzZpoV5dDUx7+VOKGGu/iXrV0SqUZQji63CrbpA7ZfE7hO8zugo2Wk
         3cd1Qv9kIW7eJ50YWBOIRF27iH2QaMJbfKnqBm6RoUpFPv2CR6gzgpz9P4vIRwOQQnE5
         eSb6APgLRfFTH8ux0LU3fwJx+YDqbB7Y8uz60rqYzqXFLNVhtKc8TUC/Kt8EQja/764C
         cP2hpx6D1nW30bo1JG/7huKBK3hwnXDIFxrg/5Woh2rTRVYiLLIqgyM+jHVwv/TxAAxn
         jLXcvt/1Ev52rPMY97licMhqI986+j0Gn0jtKhhKeyw7UvL/YETrcszqJ3Nljzl4UVfE
         8svA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770123952; x=1770728752; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EzvCKkHvTDyl5Hbu0UI0p5YJ3tj4x14liy6theec5Kc=;
        b=ah77SLl78ZadDZvqsWf1HyUYFDANZituTkTeypLMev5DVch048NFyVh0XDtIixFzPO
         Iu+vIFQwEYUnxdLiQu1Dp4ttKBm4EVoHhLHFKNskSPlcklv7SMY0n3yMShQxWfRhF9jj
         Lxok7x7U6E7NrdmYBont85Nwm2RZW4e5wK4im9jzepXMMR8kCQQ0r04enfNfhVdwE43m
         k+Hg4E2+uR3K4qiFuorx8CIZCQ7A4H1sODkC6fxe3ft6SkWVq2GgFOmQZxIX25C3bVhh
         engzIq0hT4bkHYLQH8xG+z06Ut+fwxuxtS4PwE8A7j5tmeG/KL+1V3tzqgxgFbWw0Fa7
         0ZDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770123952; x=1770728752;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EzvCKkHvTDyl5Hbu0UI0p5YJ3tj4x14liy6theec5Kc=;
        b=fNwFNIXglZGmTopn7AJbGZ6iL5qWRFsbHe3URHmnjYhYP171/cCEzGCevI6Fum0M9J
         t2ITZ6AVu9wa8FUQfa97bYjC/DseZJX+Ict4tAeqvb1oWjz+5O6u33k+Rr0rzPPwtmUO
         0Q+d7HBzgq8ri0Vcw7canIcqEtYFWUq9xIvkLo+2SN1ZAFmZcK5Srpsdf3F71xsUuz7+
         x4aMxwGSf205hQwU19rfOapTaEWBLpAjaGJ1JiRR2Mlo4rYpZ9lM8KOw6j60kfG4HLD2
         eGGWa0EgdAQzbiDmEyLvJY2tBxlpFQVd4/vCMKjjlVyO5b193RfLG5t8tTie3l9LUL0b
         yVbw==
X-Forwarded-Encrypted: i=1; AJvYcCU8Wzkh4EgQr8UNyAGnvhyM2KGk3ppq4uSiM6diqsZc+Sh9p+wB2BgPSS3ZkuDhXsY1NAU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzqu77JOTf8gUj5M6kAs8FnedHqYIQEiyA2s7rfDu931zX9YUha
	QPqs/4xillNm0qo4WyO1odfyGrjGNiK0JI56gmjFZzyzgYrXBsjJcDCFDu97EP8grIzwLizkyin
	iOmIIdm03jYbvIYY5sx9AgFn3F02Q1gE=
X-Gm-Gg: AZuq6aLV4khvU4XEWR6a7GXjMOxedc3g4pCHkekQ455qepp1btor8JR9WfclEZ2qyNm
	VNYMye6ClbFpINZc8kDnu449tjSB0hpSXzbPXrpu0v4xgZ8Ni8CcgXy7DQeC94ggOjNzJuB8UPl
	TqzuRqNL0+mQSlo//kkxSs6//2v40CPDWzeLgl4mV7QsYxzYdCIUYZi3tfZXpnEQVoHm+YrLJyK
	8CcPdk0iKE8i11NRSINa1NjNzNYLnR1d/ocN9JLTOX1BzNYUxT6Gn/6bGP7bc6ieW6ralBA+jGk
	JhqOXQ==
X-Received: by 2002:a05:690e:1382:b0:649:cd05:c518 with SMTP id
 956f58d0204a3-649cd05c775mr4229871d50.44.1770123952334; Tue, 03 Feb 2026
 05:05:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260203084323.2685140-1-sun.jian.kdev@gmail.com> <aYHwd2mMaVp-qFlp@strlen.de>
In-Reply-To: <aYHwd2mMaVp-qFlp@strlen.de>
From: sun jian <sun.jian.kdev@gmail.com>
Date: Tue, 3 Feb 2026 21:05:41 +0800
X-Gm-Features: AZwV_Qh7OL-8yA3ZCQSQKBbrNjJ5KI5yV8gSWZdHYOrH-TO3MU-ndKsFoQt5iyM
Message-ID: <CABFUUZHwLvfAfxdmaJHvCPQ=YHXMnkqEiJxjqTN=29VyiSBhnQ@mail.gmail.com>
Subject: Re: [PATCH] netfilter: bpf: add missing declaration for bpf_ct_set_nat_info
To: Florian Westphal <fw@strlen.de>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>, Phil Sutter <phil@nwl.cc>, Simon Horman <horms@kernel.org>, 
	netfilter-devel@vger.kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 3, 2026 at 8:56=E2=80=AFPM Florian Westphal <fw@strlen.de> wrot=
e:
>
> Sun Jian <sun.jian.kdev@gmail.com> wrote:
> > When building with Sparse (C=3D2), the following warning is reported:
> >
> > net/netfilter/nf_nat_bpf.c:31:17: warning: symbol 'bpf_ct_set_nat_info'
> >  was not declared. Should it be static?
> >
> > This function is a BPF kfunc and must remain non-static to be visible
> > to the BPF verifier via BTF. However, it lacks a proper declaration
> > in the header file, which triggers the sparse warning.
> >
> > Fix this by adding the missing declaration in
> > include/net/netfilter/nf_conntrack_bpf.h inside the CONFIG_NF_NAT
> > conditional block.
>
> Didn't Alexei tell you to not send more fixes like this?
>
> https://lore.kernel.org/netfilter-devel/CAADnVQ+j8Q5+2KSsaddj3nmU1EkuRAt8=
XwM=3DzcSrfQfY+A1PsA@mail.gmail.com/
>
> "No. Ignore the warning. Sparse is incorrect.
> We have hundreds of such bogus warnings. Do NOT attempt to send
> more patches to "fix" them."
>
> I'm not applying patches when a subsystem maintainer already
> said no.
Sorry, I'll drop this patch.
