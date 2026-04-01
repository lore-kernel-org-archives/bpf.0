Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B034330E0D6
	for <bpf@vger.kernel.org>; Wed,  1 Apr 2026 18:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775067025; cv=none; b=sFCoGUy1+MpPWZpFHyHH7hXqt9er7AnD4+J/x2ZM3ura8Umlx4mUx+l0iHuY2Tq9bTpkDE94x2j3TuSqE5Pc/aUt8IE6mEhTTrUACixGfHag3Fz/VnSyskdFqSMnQYhNs42BZerO2aGgAUKCsPzZI4NAB2lGNeZAnVy7ltaW5/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775067025; c=relaxed/simple;
	bh=q2w9fllxftn/Dn+aeDVhMcD9IFD7B4W6SKpJ1EFB9cY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WFMQ99WZxOx9BYUfpzahVEBAwYpa6K1ZH3Gj9mciythid7wr1XxtfHJG/+Zfu/ftkqx2VsWtTNj21t0zcHUFfYKuYlhBpGXsfivLWCnBc7GqgalD7RDYqcN4Sn72B0LhDiap2DUuWdtkT1WVyBS0/d5/zE+lg/UJL1ibKtbO7aY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ja4faTNp; arc=none smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ja4faTNp"
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-2c5b3d8eab1so215414eec.1
        for <bpf@vger.kernel.org>; Wed, 01 Apr 2026 11:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775067024; x=1775671824; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=edxQkpAdo8vyFtjzZGynRbyOAKQskd0O43XW005wTrM=;
        b=ja4faTNpP/RkUFTLnBN1NmrCQ9NcnkKJrqpLj8t4mS3pc50E/ChL+NgRxtL/sCM9CA
         t6ITnBZz82f0TXvE+SZv4fycmC4BaSrcCO81QHFnooSvuARbY/c8QlW4Gpdft4oh2ker
         TaLViFLTVWXukMq+xFW1toKJUcQEsyMo+0QBZA0ZzXfxp7c0iQIAWwbkWlHkcTfQ09eR
         ajZWVBoG4VkSpAupXlGMfFiwTPekZwOIj2oUCQXXAl3XBu/HQ7bhRgJt/p3wdyne9Ood
         WmBJOZLtQWyoQB4NOIjznwlDmCE1QA2RjvNd2h+eDwQF2f+qfIBvfePdJ1xbc7GO1FRJ
         2FUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775067024; x=1775671824;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=edxQkpAdo8vyFtjzZGynRbyOAKQskd0O43XW005wTrM=;
        b=H4PbV1w0ILqplPnVkr/Z+NHFsp7NeiCr9Ru54w+gK3V0aQIMbtuDGLvbiItccluGsn
         XpYHaqOp3IlA8CRaru2VP1dt2qhIBZLjTQ5ntzWXzqa/KwIfPDQjDdQMM2JqYKBpAfcc
         zTfw16nfghjj6eS6dJ9IJHFu2owASxk+4D1KENk1ZgUelthyvxmrvhmVx/zX7zSsWCQb
         Abbs4i64UK7lprXNQCP/fNYXntpaebVmmINt+rCyfqiV+TFlXIjlrwgowXqzDC6LJyWb
         bhiFmpTk7z+90GytykrUCseFDqQjgyGU1zW207aMkAUHAYRcbzii7kjdku9FkLTDSXjQ
         +Tew==
X-Forwarded-Encrypted: i=1; AJvYcCXVvO2GIgPPNlAWM+4rmadb5V24BYmhnzxMzwQBTRJUWROvFjgqi8t0LT7VIr7Nu9OSy1w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUNwxgNkDrEkAwRym0XS1Qk0bmNTl3zW5W7N/iyPTqsZdQ6b37
	UF6JqIFqrfuGM8BqDsHhw2yanBYId5lxPohz7un8ya5FRJZ6xUrBQ/8=
X-Gm-Gg: ATEYQzyvueB0lWkSV/lpp1aGU7+bX7y8fAXLjb4ggC9HPIp/pLMqEYayGHAfoib+3SX
	OtdnWwpjxAnnNTkXyCOCxumF12HKRMRAm1D/oYwghQxTP6LRbgtGRoZh4/syDYm/2Tp3zzAjoLg
	6Euks6Kq8k6v8PsRT9pYB7danyc5Pv2wKKdLXmLCKWBwbQIZorX7eEOCE0Cu1meRuAHkLkF+K9Q
	+YcSbpNiVlnNGCEB6E6VgkAs/9BY1C/SxLZZALd5w66D7bjECG3pUt7Mlw2/LTKlyt6RRG/6zDh
	VjrHyAMk8T9/emTtnWi57ji18Z+otlOd8GDt/vlRNcYW4bcPBDTsb1NZCA6OZG2jPqey13+dEJP
	JfpVZG61QyNk9wagap4YaPd0YwcShKWWwXaFPixY3lt9sVkCmvA7SC4KmAOJ7aDkhngSGGiR0Ok
	AAV3tKmJCqBiQfpa5u1EnyE9pveXJfvJGMcUQYFEvF5ug57au7UbVkZlbgF1MscaeuuCHHNhG17
	dV3ZR9FvL0mc0z+ww==
X-Received: by 2002:a05:7300:c89:b0:2c7:ea98:d94 with SMTP id 5a478bee46e88-2c930798501mr2349509eec.2.1775067023492;
        Wed, 01 Apr 2026 11:10:23 -0700 (PDT)
Received: from localhost (c-76-102-12-149.hsd1.ca.comcast.net. [76.102.12.149])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ca78dfd323sm404829eec.1.2026.04.01.11.10.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 11:10:23 -0700 (PDT)
Date: Wed, 1 Apr 2026 11:10:22 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Breno Leitao <leitao@debian.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Willem de Bruijn <willemb@google.com>, metze@samba.org,
	axboe@kernel.dk, Stanislav Fomichev <sdf@fomichev.me>,
	io-uring@vger.kernel.org, bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH net-next v2 2/4] net: call getsockopt_iter if available
Message-ID: <ac1fjvVDfatpXwPY@mini-arch>
References: <20260401-getsockopt-v2-0-611df6771aff@debian.org>
 <20260401-getsockopt-v2-2-611df6771aff@debian.org>
 <ac1I_CMr43XTpvHj@mini-arch>
 <ac1Pzt4tpt73SkC6@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ac1Pzt4tpt73SkC6@gmail.com>

On 04/01, Breno Leitao wrote:
> On Wed, Apr 01, 2026 at 09:34:04AM -0700, Stanislav Fomichev wrote:
> > > +static int do_sock_getsockopt_iter(struct socket *sock,
> > > +				   const struct proto_ops *ops, int level,
> > > +				   int optname, sockptr_t optval,
> > > +				   sockptr_t optlen)
> >
> > If we want to eventually remove sockptr_t, why not make this new handler
> > work with iov_iters from the beginning? The callers can have some new temporary
> > sockptr_to_iter() or something?
> 
> The goal is to eliminate __user memory from the callbacks entirely, which
> would make sockptr_t unnecessary. This series removes the callbacks that
> originally necessitated sockptr_t's existence.
> 
> Therefore, working from the callbacks back to userspace seem to be a more
> logical approach than replacing the middle layers of the implementation,
> and then touching the callbacks.
> 
> So, yes, the sockptr_t() is used here as temporary glue to be able to
> get rid of the elephant in the room.

So maybe something like this is better to communicate your long term intent?

	} else if (ops->getsockopt_iter) {
		optval = sockptr_to_iter(optval)
		optlen = sockptr_to_iter(optlen)
		do_sock_getsockopt_iter(...) /* does not know what sockpt_t is */
	}

?

Then your new do_sock_getsockopt_iter is sockptr-free from the beginning
and at some point we'll just drop/move those sockptr_to_iter calls?
 
> > > +	/* iter is initialized as ITER_DEST. Callbacks that need to read
> > > +	 * from optval (e.g. PACKET_HDRLEN) must flip data_source to
> > > +	 * ITER_SOURCE, then restore ITER_DEST before writing back.
> > > +	 */
> >
> > Have you considered creating two iters? opt.iter_in and opt.iter_out.
> > That way you don't have to flip the source back and forth in the
> > handlers.
> 
> That's a good suggestion I hadn't considered. My initial thought was to
> create a helper like sockopt_read_val() to handle the flip-read-flip
> dance.
> 
> Would opt.iter_in and opt.iter_out be clearer than the helper approach?
> 
> Thanks for the review,
> --breno

I hope this way it will be easier to review protocol handler changes.

For example, looking at your AF_PACKET patch, you won't have to care
about flipping the source and doing the revert. Most/all of the changes will
be simple:
- s/get_user(len, optlen)/len = opt->optlen/
- s/put_user(len, optlen)/opt->optlen = len/
- s/copy_from_user(xxx, optval, len)/copy_from_iter(xxx, len, &opt->iter_in)/
- s/copy_to_user(optval, xxx, len)/copy_to_iter(xxx, len, &opt->iter_out)/

Might be even possible to express these with coccinelle?
