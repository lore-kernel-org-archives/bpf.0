Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7B2017B43F
	for <bpf@vger.kernel.org>; Tue,  7 Jul 2026 09:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783417278; cv=none; b=aNazli/lJsLxIDFVaqx3p0S4rjVPjL3wBKGEThRk5JiczJ40bm77M4ZnOHDz6H/QNK0egUefkMqu6fe8f32QmDWLbZ+lP7HKjoOTvZoMTqNhlwYEsiYPgheuBMo7AG4ETNOiC2XH5gUqV/duwmoZx39c8PnGeROLtodRsXG1Vdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783417278; c=relaxed/simple;
	bh=GPdHdqWRNzRZZchJQ9wPXni8dJdU+/hQXmvi8Itk7Q8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i4znpBhpFjOkpF5TofGGTRZW0PH7ubtnfuw2NKhuc5gTpbnUnWxTmNjVKBZDq7YZJmUZs6ao1OyCIsVVfIEUXDMLnNVpVqITNvZOekpsxFOklsoL8EiCbcgXuwL6DcAZLKjQ9JpzK0VM0VaDY1Gr+m9Qt1Rl6bHb6e8B8USR+cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kjExUrcD; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kjExUrcD"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-493b786d6c0so21256805e9.2
        for <bpf@vger.kernel.org>; Tue, 07 Jul 2026 02:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783417275; x=1784022075; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YZUJruZyrJKIs3f2D7Ek0uWfUfy3QKwkxgMqXzof9SI=;
        b=kjExUrcDAU5ADPZsKh7NEJYJULtzAEkgablAbNoWYvKBMeRW4x0BXt4AppaLnTtVFT
         vYSGrinF2AbF1w2ppuMdQuMvEMgSd5ha9D53CBOAwpo3iAOE0bJ1iMNlXNE6IG/tafmj
         vRdvwdL0m/iR8a2ssEne4b5/7pWSrYhlKgopkIHrawI6Lk9l/V2trA03GNmsAHMWKrkT
         uK37MIYq2mWDYRA6Mvej71W5IrgEb9Sv/Zj/UIItah2HP4GZ2WpIfMCflUCY5WrX4mVJ
         Q61UIvdV3fedtsMOhVK2+4BbRdJHOw5Z4eO+S6g2RXydNn9dyxjXlVvoYeLVVlOzgiK9
         gAzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783417275; x=1784022075;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YZUJruZyrJKIs3f2D7Ek0uWfUfy3QKwkxgMqXzof9SI=;
        b=SR/HJLzMlCb0jPGCfO2zTGXmhKKzTbvE2oXqElUG+2E3P5M56AP1OMWmeVcKcH3jjG
         IdjuGWCeYxa7czbMKGFNiGeagsCuH6h5WolzY7Uq5zPLW1MEEi6kGKssfbaL7DAKl/0m
         U72zV56eNh/f1EVoYES5VyKpfJl5Vf2xuG4yom9iUa6cri2liI7JjI7b96fpnzMXVEg3
         h3Y8lsZ7MdaAVCEwzSEWdWCwfWEu5sVhdbkQMhVZ3gG4UTMnwPzIoDU5LgEG6Wx//JTP
         A6DcervLyYT0dvscRNRjm90vnXjWMYFZ4PHfBjJJbQMjeT9mf1Hhq80Qw5Q4cmgt8vqG
         yfLQ==
X-Forwarded-Encrypted: i=1; AHgh+RqO0Y7J9Isz78f9EUDANp0l71AhTuM1EbgR7mEhbNVeU/qbOsTH4IbhXCGJvXYFLzekh2E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwckoLBcrLabFZbV63CHTbfqFEAUH3VmjhLp7NWyrK/Zl2PscuY
	LCoEMGzHne7xl9CCaB8bMqAB4Ff8rfp4dlK7IBQjANRO8DYH68OHBAYd
X-Gm-Gg: AfdE7clQWCdW0XxrOEOCpkl77I8Gcw0AcOhd66S+E5Fi/P7BcfWv7GwUl/g/RkA/GOi
	V/8b61Yc38LzOiUvzZw2YhUzAoGwv0bES9NsoRbXY/m96+avjhlO9xW0YMkSoH5HA9nZO3WYUF1
	fh5BF37vaWnVyV/WneQHKLhWNe5BoYwiS7nDvtqr3f2ORc9Sd4lRGycpQy02/qgSA8Ckm8Lf13i
	jcfwu/VjrHv5I6PJNcfGk+LPEcnB7Gq/eng4P+iG9um8ojqJakZEUl1eMp/RizZgP85fXCTeUYa
	0m2v/Wh1MMYv+qDeVWR2Y0No4rHP7oR0mFPGxamO7AWGryOPHtKdwLENDo4/b1HD+ANIXv5gzDi
	129AUsW7vbFoR3MVV9m2b0woIPwLfnNA8sdeYTW4ECdH3JXriJv2/V+X/7d83mrh+GmoyDGrNfm
	aeLsBS3m1jiji3hC1o4MBn6i4bFCwnFV0WRtM4+lM0yU95
X-Received: by 2002:a05:600c:4585:b0:493:bc4a:fb55 with SMTP id 5b1f17b1804b1-493df09e3cbmr47373745e9.38.1783417274421;
        Tue, 07 Jul 2026 02:41:14 -0700 (PDT)
Received: from gmail.com (deskosmtp.auranext.com. [195.134.167.217])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493e0f4e3afsm49184435e9.7.2026.07.07.02.41.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 02:41:13 -0700 (PDT)
Date: Tue, 7 Jul 2026 11:41:12 +0200
From: Mahe Tardy <mahe.tardy@gmail.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: sdf.kernel@gmail.com, andrew+netdev@lunn.ch, andrii@kernel.org,
	ast@kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net,
	davem@davemloft.net, eddyz87@gmail.com, edumazet@google.com,
	john.fastabend@gmail.com, kuba@kernel.org, liamwisehart@meta.com,
	martin.lau@linux.dev, netdev@vger.kernel.org, pabeni@redhat.com,
	song@kernel.org
Subject: Re: [PATCH bpf-next 2/6] bpf: Add ksock kfuncs
Message-ID: <akzJt4jua55mpUgA@gmail.com>
References: <akwTnnSGJpki9hAn@devvm7509.cco0.facebook.com>
 <20260706225047.1684039-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260706225047.1684039-1-kuniyu@google.com>

On Mon, Jul 06, 2026 at 10:50:33PM +0000, Kuniyuki Iwashima wrote:
> From: Stanislav Fomichev <sdf.kernel@gmail.com>
> Date: Mon, 6 Jul 2026 14:02:39 -0700
> > On 07/06, Mahe Tardy wrote:
> > > On Mon, Jul 06, 2026 at 09:58:09AM -0700, Stanislav Fomichev wrote:
> > > > On 07/06, Mahe Tardy wrote:
> > > > > Add BPF kfuncs that allow BPF LSM programs to create and use sockets for
> > > > > sending data. This provides a mechanism for BPF programs to emit
> > > > > telemetry. For this first patch set, it's restricted to SOCK_DGRAM
> > > > > socket types with IPPROTO_UDP protocol but could be easily extended to
> > > > > SOCK_STREAM and IPPROTO_TCP in the future.
> > > > > 
> > > > > The API consists of six kfuncs:
> > > > > 
> > > > >   bpf_ksock_create()   - Create a socket (sleepable)
> > > > 
> > > > [..]
> > > > 
> > > > >   bpf_ksock_bind()     - Bind socket to local address (sleepable)
> > > > >   bpf_ksock_connect()  - Connect socket to remote address (sleepable)
> > > > 
> > > > Since you're doing only UDP for now, maybe you don't need bind/connect? The
> > > > kernel should autobind (by default) when you sendmsg over UDP socket (IIRC).
> > > 
> > > Yep indeed, I kinda overlooked that as I started with UDP & TCP supports
> > > and mostly added the args checks. Another thing is that send is simpler
> > > since only used on connected sockets, so you just pass the struct
> > > bpf_ksock and data. So on one side it would simplify the current
> > > UDP-only API for now by removing the kfuncs but we might need a more
> > > complex send kfunc (something like sendto).
> > 
> > Since you were targeting bpf_netpoll_send_udp originally, maybe sendto
> > is a better fit? You get the payload and the destination and you
> > bpf_sendto() it? We can later move to stateful bind/connect if needed.
> > 
> > (mostly coming from the pow of minimizing api exposure initially, but
> > not a strong preference)
> 
> +1, small start would be better.

Okay I feel at least we can confidently remove bind for now. Indeed for
netpoll it was kinda obvious that it was going to be sendto-style but
now with the sockets I'm unsure what's best:

As Amery Hung wrote in a parallel thread:

> [...] but connect() + send() make sense to me. In the stated use case,
> the dst addr probably doesn't change often and I think avoiding route
> lookup everytime should be a good thing.

Looks like there's benefit to both approaches, I'll experiment.

> > > > >   bpf_ksock_send()     - Send data through the socket (sleepable)
> > > > >   bpf_ksock_acquire()  - Acquire a reference to a socket context
> > > > >   bpf_ksock_release()  - Release a reference (cleanup via
> > > > >                          queue_rcu_work since sock_release sleeps)
> > > > > 
> > > > [..]
> > > > 
> > > > > A bpf_ksock_max sysctl is added to limit the maximum number of BPF
> > > > > kernel sockets that may exist in each network namespace. Out of
> > > > > simplicity for now, the settings is host wide but the counters are per
> > > > > network namespace.
> > > > 
> > > > What is this guarding against? Rogue bpf programs creating too many sockets?
> > > 
> > > Yes. AI review raised this because users are prevented from creating too
> > > many sockets by bumping against the max number of fd and this would
> > > allow them to create way more sockets. I kind of agreed that having "a
> > > limit" on resource creation would make sense but maybe it doesn't and we
> > > can simplify this!
> > 
> > I believe even the kernel sockets go via lsm layer, so this enforcement
> > can be done in an lsm bpf program. Seems like that should be enough?
> 
> Right, I don't think the per-netns limit is useful for CAP_BPF users.

Ok, agree, let's remove all this then for the next version.

