Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 414583D522C
	for <bpf@vger.kernel.org>; Wed,  8 Apr 2026 18:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775674606; cv=none; b=HJEC7gr+tjS8fCPKf9NfkzUW9zI9QvxizqW8Gufo/YAY69VXEdARceo/r6CE6GW8wbSPQLdE+doLjgu/qfi2kr0hyfA3RPCwXpHpnG79dlsFn9fF+Oz+9P+kgvTedwOB1jl6aANv5BzxNx5D10M9L7eO1nvI3cQqC5WdgXOpvuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775674606; c=relaxed/simple;
	bh=crZm2PijcEAXzpKSJa5xA82z7xsDYnBu7ZN0nWLhBuQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ftF4zuowv6YGYxCzW7dk3uMYcPvw8UXFxs2SXLyipX143ZEosVkA/UNXCQjUi4wnuQkN2bCfzVMaa/KhscXlT5sMRE6uyw1pC7ORWm5sb7SYQ04IkbLxipJg/NH655nbqzl69e/QEugWVjYYdI2fa9O2KNibbUZINq4OJ05/W98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j/3pooMV; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j/3pooMV"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-488a041eae5so421875e9.1
        for <bpf@vger.kernel.org>; Wed, 08 Apr 2026 11:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775674602; x=1776279402; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6SerQ/zT5jOcTdy+y8E9YY089fNttq9APZn3BZTXc58=;
        b=j/3pooMVrumXrMdNyTUFFQ2zdsP2Y8tQqosjKcKYNA7TzLaJ4DfPI5q/DpK5Bd8k6z
         CWt9T8JOdAsQ8jZfHTV9AC0ezqEMRjHfBlq08e6iezIgovNg6QkkdePK9y2LFh59ioZU
         KLe7K0P2jgoTQfKcMdtbvg2Jz7z1ISNO9B5VZFfsKpv0AewkU0EtMhvRejYfh5jB59X2
         TvpqnRsfHv7Bfj13a6GFqOkh3Bqt5FZGrNvj1zLvOh7paRgIgXFm1UVkdqf0c6e9B1yq
         4v0XBypuFMSrQsyv1xzGoJYrmeHeYTxykBXGIQwTkcGEX26VFxQsfZjwLe5IYnW91hls
         GXQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775674602; x=1776279402;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6SerQ/zT5jOcTdy+y8E9YY089fNttq9APZn3BZTXc58=;
        b=bwgZEGOgr0T8jNNdZNJV1ieOrDuwfPRA6oh5a96rGVr31AqawW3YCrIek8Ym2lkgKo
         0t/k8YgslnbtonePo7R+btPgvWJDpMG8o4Qek329f0ZX1Ycm20aCmu7lknCh98Z2mTcM
         wdk7xT+Jn2KJV7iMLzJRj7zuPqIAO/aQI7P2LAF+hdV46TwH6CYgeauZ6L7OC1v0PpLm
         TRFol4E0Msz5E2LNtMGodbEElli/3L3q6aNy/J77zHFD4BeRbJokqCpmMQf36rFNzvkp
         IXXAbtLKYi0VRbUJ/tj/V53WQzKLciBRsKEB0b+UhQUcr4eub+ig9j+XicZgYCRinwQT
         V0xQ==
X-Forwarded-Encrypted: i=1; AJvYcCXuEmzef6LjsKHBs1Gii7Bs9lbxqAHu811qAZlxfDciywdyhqt9tpOLGyu2I8JpcREeBj0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxspJsMjvCgbUYcU+4kGMmKltpmplWLpVwWrly2ugW07KYGQW8X
	tr/D3E00GNmKX/m7avUW4BiUV5o4fWduL+t73cWREHZb2+9D38GlJ2xCByR7gaCV
X-Gm-Gg: AeBDietHlQRCNQ/luhVPnLrnNKgnPE0sqPR4RI5Q05u1L1BYBQxJOGprThwluKYE5f0
	0z9D1hfFvx9FJnn8EVN1514NTLkeg+EeVz93JVAjpNOpmZL5eCWCk4X05Ely5x2S5EL8SBx1TLF
	HaBGgQS8oCkbIKvLvVY5S5669TcXRBWnkiM4OS96tKi1ShiVbBioBazr/04WNuY74o5woHMwe/E
	oNWRYc5gDYZX/5Mvzf8bbuHZYkEak0rnPv9UNogszBJvw5gbI+X2usN77ePFoXP0wSpgZVjxXxb
	7fQGmZblW/vqvhdyZFnB3pP3NgPv2+cduKFjKXnWI0QomoFJY6yZksMs6Cb8vOUXjFkhui3zVst
	XKAv8Au2EiracvbR9PSO7E83BjebhGvewFlI5cI7AVFIbM7Bp9jWu36XWJlg6DO4PI9exRx7wTA
	GQRo/IvcwfEtBOtJyEOxNAO4sJYi70dSdD8sPzpTb0efsYCZ65cA5U73laknnVzkCo
X-Received: by 2002:a05:600c:630a:b0:485:2fe9:336f with SMTP id 5b1f17b1804b1-488998e3cbemr314394195e9.30.1775674602340;
        Wed, 08 Apr 2026 11:56:42 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e4e221bsm57990166f8f.29.2026.04.08.11.56.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 11:56:41 -0700 (PDT)
Date: Wed, 8 Apr 2026 19:56:40 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Breno Leitao <leitao@debian.org>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Kuniyuki Iwashima
 <kuniyu@google.com>, Willem de Bruijn <willemb@google.com>,
 metze@samba.org, axboe@kernel.dk, Stanislav Fomichev <sdf@fomichev.me>,
 io-uring@vger.kernel.org, bpf@vger.kernel.org, netdev@vger.kernel.org,
 Linus Torvalds <torvalds@linux-foundation.org>,
 linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH net-next v3 0/4] net: move .getsockopt away from __user
 buffers
Message-ID: <20260408195640.324ee932@pumpkin>
In-Reply-To: <adZcnNgxhsUjAgZW@gmail.com>
References: <20260408-getsockopt-v3-0-061bb9cb355d@debian.org>
	<20260408122653.295953dd@pumpkin>
	<adZcnNgxhsUjAgZW@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 8 Apr 2026 06:52:54 -0700
Breno Leitao <leitao@debian.org> wrote:

> Hello David,
> 
> On Wed, Apr 08, 2026 at 12:26:53PM +0100, David Laight wrote:
> > On Wed, 08 Apr 2026 03:30:28 -0700
> > Breno Leitao <leitao@debian.org> wrote:
> >  
> > > Currently, the .getsockopt callback requires __user pointers:
> > >
> > >   int (*getsockopt)(struct socket *sock, int level,
> > >                     int optname, char __user *optval, int __user *optlen);
> > >
> > > This prevents kernel callers (io_uring, BPF) from using getsockopt on
> > > levels other than SOL_SOCKET, since they pass kernel pointers.
> > >
> > > Following Linus' suggestion [0], this series introduces sockopt_t, a
> > > type-safe wrapper around iov_iter, and a getsockopt_iter callback that
> > > works with both user and kernel buffers. AF_PACKET and CAN raw are
> > > converted as initial users, with selftests covering the trickiest
> > > conversion patterns.  
> >
> > What are you doing about the cases where 'optlen' is a complete lie?  
> 
> Is this incorrect optlen originating from userspace, and getting into
> the .getsockopt callbacks?

Look at tcp_ao_copy_mptks_to_user() in net/ipv4/tcp_ao.c
This isn't 'old code' it was added in 2023.

Basically what is being transferred is an array and 'optlen' is the
size of one element.
The number of elements is in the first one.

Yes, it is completely broken.

There was also some very old code that just didn't check the length
(probably only for 'int' sized parameters).
That might all have disappeared when decnet support was removed.

There was also a very longstanding bug that pretty much all the IP
protocols would treat negative lengths as 4.
That got 'fixed' not long ago, I do wonder how many applications that
broke! Passing an uninitialised on-stack variable would have worked
(for 'int' parameters) provided it wasn't in [0..3].
Even then there is code that will copy 1 byte (instead of 4) when
a short length is passed - but it only does something sensible on LE.

I've been though all this code trying to replace the 'int *optlen'
with 'unsigned int optlen' and then returning the updated length
(or -ERRNO) to the wrapper.
That simplifies 99% of the code.
However there are a very small number of places that want to return
an error with a corrected length.
If you were starting from scratch you could say that returning a bigger
length would return a specific errno (maybe -ERANGE) and the updated
length - but there is no consistency.

I pretty much decided that the getsockopt() functions would have to
be able to return one of:
	-errno
	length
	GETSOCKOPT_RVAL(errno, lenght)
with the wrapper separating out the merged value.

	David


> 
> > IIRC there is one related to some form of async io where it is just
> > the length of the header, the actual buffer length depends on
> > data in the header.  
> 
> Could you point me to the relevant code so I can examine this case?
> 
> > This doesn't matter with the existing code for applications, when they
> > get it wrong they just crash.  
> 
> Is this crash being triggered by the protocol callbacks?
> 
> I tried searching for this but couldn't find it. I'd appreciate any
> hints you could provide about this case.
> 
> Thanks
> --breno

