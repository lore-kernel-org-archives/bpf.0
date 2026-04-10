Received: from mail-ot1-f66.google.com (mail-ot1-f66.google.com [209.85.210.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB9433D9031
	for <bpf@vger.kernel.org>; Fri, 10 Apr 2026 15:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775833893; cv=none; b=CTWpxQlCdfZGoVTIOVn2pbKyLxwlk5aLPrNYsQdjMqdjeptES0btg6mnIIiJC9OhL0jrflMLKEpN54DGZnIJxsvQ6Hxfri51U7lc4WjCn6n7YOihFfuETSrWG99XSaA3ScjfU6tNd+aTpQlrXTmKBSMZtXItwGevMDDujbBMDB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775833893; c=relaxed/simple;
	bh=xjJORM7tfy7vWxsh2geZIlFRt9OGr4V1D2nhCg5EtZo=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k/Rmvqu1Fe8oBsAuinkawWZravgWpmiinrRvhQB+MZIg0joT33/p+VEBQ0scjJHiwma3de6rqPxNoT+lYkNcOJ2dUu61fn3xE0iQOv5nXybwycV24qNz8NARM1LaKI5N9dHXLmIvsC+zF1cPL7xHFy+45FjKGyDc+Llq+ILyTV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dPdqteGM; arc=none smtp.client-ip=209.85.210.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dPdqteGM"
Received: by mail-ot1-f66.google.com with SMTP id 46e09a7af769-7d9e22176a7so1115980a34.1
        for <bpf@vger.kernel.org>; Fri, 10 Apr 2026 08:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775833891; x=1776438691; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zvG0lUmWvJDVV9hH9ZMs4QcX1z2+NpKGjl8rKX6kmfA=;
        b=dPdqteGMXfG9ncp72tu6tdueyp/AzdW32IBzu6cumBfqWtkJtTdQqEgnjTAVuex0S+
         QuFNDU9ssuG/62+F8yM3RQ6kkXWfGRSMwVysrJ0LxqxOyOFCwvoCt86l9f+e86cSe8JY
         050LQYdBO5WkXT3AGlpY3DwrBz9vayRg70SAFUcg4cO0nIHwTXWpGsa0K3oX0eGEILnK
         L3qIRGC23ocvMPhxcT2kWbjSRwoDKlbL31bwVVZRVCfjQgN3PgKvK9i5RTbgV4sw0C4E
         q7tHilimkIdtE1jgeb8CqgoEpUkD2xXF5rPGFaF5PMQI6BJ0VIRZXAQ6PuEu4rvFH7j8
         JUiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775833891; x=1776438691;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zvG0lUmWvJDVV9hH9ZMs4QcX1z2+NpKGjl8rKX6kmfA=;
        b=hGKKwIXgsB7WSlxFzJ4VAFUXKXBR/ll0MJ9o6Fw2VLyPr9cJy92rlby6P9WnDg9IOS
         oYDwJNYVvhDb7+zqZjlT2JJZjIBSSHUtSu8SX8r6BHwQ60y8nNFxH4EsEvd2/CiYixdl
         Vdhg9qBbYHKKmMCVcgf5JzadbZl8/TUVm5VqFv1heOOqDKjHBnpKDUNQ18mInVhw4GuX
         jOzKTAlU368+nJcceDdDwUlFkUibgI7aNAJLR9tKz+PEodjT6p0FALQrjzb8Z5nOKmN5
         QGQnEGuifAmOz63WpQvlce1Zy84bChlxp8fHJBCXLVUhZx7uM8Vlfwd58dRAJuJCH1/T
         htpA==
X-Forwarded-Encrypted: i=1; AJvYcCVeQevCaF3uLUKAbYU1Qy7RepcnBjLDralmLqVLik3TPAuNK4sH4S+sWYSJYPGBpMHK7/w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yylw74LOTPFCvnl4mVO+JZnEzk8/3bbCVMA13SV+b4ynJwzhgvT
	UJiUVThVgSqKvMo9jkUGaoUDCTHYWZWUf5GfgVP/KXvT15Zs1VOCWiAc
X-Gm-Gg: AeBDieth/Kmnq+1lpYMhcils+BUmxWQRBgIf/sOefxrJZoYq7qbmDBQOvhlpMM9BcRv
	iXzJ+W9LSQ8oq6D2WOVSCnt7NK79mjzu5hBbRx52NcCjRpQ2Pe6oQdXPDnrCQIx3JB4ypb9Bo81
	2iT8IQkij0RrNjcAtdYRTXthsPTh77hMSbs33mgiBcLM1J8bdyTN9hr1O0KoDYsZigzd0z4bPpt
	WJcpqkiSTrrDDorO6ujEvr8hA0ooZYmsXNbFcvQ/J9zV5fP/MeL6sFzxO0hoYJlZH2crnNtDtoR
	Bpmki3e2k+FBMAs3CNHB2hhO+TuWln8P2o7BNOIgDNzYXjp2Omme2xskEvSIAFOoK1KiCC8gJbA
	kLV50DE+pWdiCRl4Z+CH7doVy9+YJywzDlwFN/nuBIspTCj65Gnu3H9/OegB9q03ICuPD/2wPzC
	43PsNs2iqisA24OT+f
X-Received: by 2002:a05:6830:488e:b0:7d7:fb0f:3e56 with SMTP id 46e09a7af769-7dc27f74436mr1889260a34.26.1775833890725;
        Fri, 10 Apr 2026 08:11:30 -0700 (PDT)
Received: from localhost ([2a03:2880:12ff:4::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7dc323b3366sm472507a34.9.2026.04.10.08.11.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 08:11:30 -0700 (PDT)
From: Stanislav Fomichev <sdf.kernel@gmail.com>
X-Google-Original-From: Stanislav Fomichev <stfomichev@gmail.com>
Date: Fri, 10 Apr 2026 08:11:29 -0700
To: Breno Leitao <leitao@debian.org>
Cc: Stanislav Fomichev <sdf.kernel@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Willem de Bruijn <willemb@google.com>, metze@samba.org, 
	axboe@kernel.dk, Stanislav Fomichev <sdf@fomichev.me>, io-uring@vger.kernel.org, 
	bpf@vger.kernel.org, netdev@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH net-next v3 0/4] net: move .getsockopt away from __user
 buffers
Message-ID: <adkSnyihmD1Atfcf@devvm17672.vll0.facebook.com>
References: <20260408-getsockopt-v3-0-061bb9cb355d@debian.org>
 <adaJqy6Q4L7c-eTs@devvm17672.vll0.facebook.com>
 <adjvoD9f7QaQMu5K@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <adjvoD9f7QaQMu5K@gmail.com>

On 04/10, Breno Leitao wrote:
> Hello Stanislav,
> 
> On Wed, Apr 08, 2026 at 10:02:36AM -0700, Stanislav Fomichev wrote:
> > On 04/08, Breno Leitao wrote:
> >
> > LGTM! Not sure what's your plan for the selftest? You wanna keep it
> > outside or maybe repost v4 with it?
> 
> I'd be glad to include a selftest. I've already developed one covering both
> protocols in this series and can respin with it if you'd like.
> 
> Test available at:
> https://github.com/leitao/linux/commit/2d9311947061f1baa43858f597dd6c54d7ccc5d2
> 
> > Acked-by: Stanislav Fomichev <sdf@fomichev.me>
> 
> Thanks for the review and guidance.

Yes, yes, I did see the test, so let's add it? I'm thinking that we should
already have a lot of coverage from packetdrill tests, but things like
you convert (packet/can) are probably less covered.
 
> > I'm also not sure your unconditional 'copy-optlen-back' will work for every
> > proto, but I think we can put something into sockopt_t to make it avoid
> > the copy if needed in the future.
> 
> Good point. I'd prefer not to over-engineer this now, but keep it
> straightforward to add later if needed. This could be easily achieved with
> something like:
> 
>   typedef struct sockopt {
>         struct iov_iter iter_in;
>         struct iov_iter iter_out;
>         int optlen;
> +       bool optlen_dirty;      /* set by callback when optlen should be written back */
>   } sockopt_t;
> 
> Wrapper becomes:
> 
>   if (opt.optlen_dirty &&
>       copy_to_sockptr(optlen, &opt.optlen, sizeof(int)))
>         return -EFAULT;
> 
> and the protocol callback would need to set
> 
>    opt->optlen_dirty = true;
> 
> I don't think this is needed yet, and if we do need it, it would be better
> to review and commit them together, making the rationale clearer for
> future developers/LLM agents.
> 
> What do you think?

Agreed, I was thinking along the same lines. We can add it when/if
needed. Since you wrap everything in sockopt_t it should be really
easy to extend later.
