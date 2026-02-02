Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76714366814
	for <bpf@vger.kernel.org>; Mon,  2 Feb 2026 22:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770071497; cv=none; b=QaWnihL1iUe5j3gzaRnmIl/Xdf3tJfPBGKx6hKAUgODBom2wGi8rjr9EVedXUzTRfNenQtVCbxmlb8WyLx0G2ZphGXpxE9ovPlNuUiQ4zo4mcV+OtOmc9ZcnMs6ZOCOfUoY7ybevvjxJbksuEmwUThmaJSvGNkn6v/Q63eJ3u00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770071497; c=relaxed/simple;
	bh=FKtoDRTtb+4i7v/qjEwG2Xg2B/SIBUBqdJA1PVVs8mU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aHapJeDvkQZHbqExLpFt+Rn/duPS9kUrMeSXAAdljtyCNWel4EfCYNm4NsNqEtIZIk1IKYZdQoe1RJnkUXS+nvGmZnYwmYeMLXxVpfv+nHoPMXkuMJNPTCVWWkElzfnl4r1e5TLbLNF0tFy9DkXV/3+kozR35D0NyW/3z5zqYOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hLTnF6Cv; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hLTnF6Cv"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4801c2fae63so37870045e9.2
        for <bpf@vger.kernel.org>; Mon, 02 Feb 2026 14:31:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770071494; x=1770676294; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NIZUSELiXp+s9+KpMxQDKTA6DmNxb624EHaq2wV6J20=;
        b=hLTnF6CvvwEYLHacUBpRKRDcOFKxz+c5YDRbqFyQJHGxjggfEdXhb5HALhEHITN1/q
         oa8y1n1bv4B4xe1Nd3xjxZQueIRnpJRqYnsONW6RasHTvjPqHYiQRwrF3k7MQ4MCRFiF
         fPpO0pptW3T098QMQM9upnZMloxQtgbpstpwET/j0QOdU+QrNJ2goleiHYMCcPGKIU0X
         5z52JGEgkSpmlzxXl82dgyGM/F1PSiFtS8eFb7mzZmpe9k2lEpdZ9yeK8EFd5NvxT/Wj
         o/v7Av4DO4wwrKc+O+ebSZR09VJSkNBPJGCYCl0MjRwAoSRP6O/PIP6LoitWN/QI3kir
         HxJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770071494; x=1770676294;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NIZUSELiXp+s9+KpMxQDKTA6DmNxb624EHaq2wV6J20=;
        b=NTrMz0bTqn8HZqkdgvweQcT4qgSWOIbFD6vc02vRCReXj/3JfN5/JMQcWa7svLywNI
         k1qEi2BA5f6oP8kBxkRtQ5npirHYT54EP5mVk2deu1lshkWJlCJISoUsCAU8kdVqiMRa
         ttyvpXM9zmR2I/rV37P/O8lfeWinp/tlhY+9NXHHOW4s5C4XKA3M8p0WfWOMCVYzfE05
         pk4S6xD2NAU4THC9RmNc1grehwsbOgzSIsw8lltdwxn5loDIUXb5vX+uu1xuNS7CPzwi
         TDsLRbVlOecB9ofGQj0Jz1ePIlQvPG3wqd+/0uFuNCNUGjGeyJssJMu0/WxXto5f7biZ
         p+Fg==
X-Forwarded-Encrypted: i=1; AJvYcCX3H/YVh5PeqZ7thexdvzktSF9F7dwLUCm/vCHXtrqWJqKHYivvVctpMVWMEHuvQpyqi+Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YylxSurVJbQkNeGN6eQrxaNYcUuoV8TB3aOIiaDprAmiKM+OZXe
	ABRctBTBD8ew90wbfJKWN4CnnVCploWYZo+hGaTwfV3AMCg+9d2rsxFz
X-Gm-Gg: AZuq6aIKyxSEHqiMvVPxcNXgYKvXNt5ZWdsuZJWntVGb9XAaPourxJrKxcFMvWOTOdL
	ue2D6oA3oIi4b6pn0X3oXt2oHq2zMLkJOtBUiKWSw7mMDs5k+c3TxcG8qL829NyEhHQG6ek+lvz
	PT/iFHutyYdlkKw0rQJ4PUwKDRLllIqbko4V9QJQqSBrOvhvttrv2dCOwpl47o8+R2TQmtFyIur
	FIkQZfK97JzFnx5Q/g7UOU+hbFNHqTFYHizkrxllv1YjJHyO0OjgKnK/bR+S9cQxoSPwT3BuBq1
	QbnkzqfgV/TwVxoGeqeUnXDXmpmhx0RNQDZ4DEbM4QyWSam1ho7w9OzTkwsCRnEZGBZ8Q1kCRzh
	rO7aUvfVt/pEXlMOKCUXyBqhnqJbyj1KKsXEy7l5K52Ni9/K/LUihn51kI02R4qU2eGx9m43KVa
	qSyLxHFf5l7KWFalvngKkLIrK8OJEs8sDQHHnsVAnrzR6AYUnhukyV
X-Received: by 2002:a05:600c:c16b:b0:477:9dc1:b706 with SMTP id 5b1f17b1804b1-482db47d849mr161092965e9.19.1770071493556;
        Mon, 02 Feb 2026 14:31:33 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483051539ddsm17861575e9.9.2026.02.02.14.31.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 14:31:33 -0800 (PST)
Date: Mon, 2 Feb 2026 22:31:31 +0000
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
Subject: Re: [PATCH net-next RFC 0/3] net: move .getsockopt away from __user
 buffers
Message-ID: <20260202223131.44e81ba1@pumpkin>
In-Reply-To: <aYCUpNyNihhR7no0@gmail.com>
References: <20260130-getsockopt-v1-0-9154fcff6f95@debian.org>
	<20260130205227.6fb1d9ad@pumpkin>
	<aYCUpNyNihhR7no0@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 2 Feb 2026 04:32:42 -0800
Breno Leitao <leitao@debian.org> wrote:

> Hello David,
> 
> On Fri, Jan 30, 2026 at 08:52:27PM +0000, David Laight wrote:
> 
> > The system call wrapper can do the user copies, it can also suppress
> > the write if the value is unchanged (which matters with clac/slac).  
> 
> This aligns with my proposal: using an in-kernel optlen that protocol
> functions can operate on directly:
> 
> 	typedef struct sockopt {
> 		struct iov_iter iter;
> 		int optlen;
> 	} sockopt_t;
> 
> > The obvious change would be to pass the length itself and make the
> > return value -ERRNO or the size.  
> 
> I explored this approach to avoid embedding optlen in sockopt (which was
> Linus' original suggestion). I attempted returning the length both via
> iov_iter and as a return value, but neither proved ideal.
> 
> > #define GETSOCKOPT_RVAL(errval, size) (1 << 31 | (errval) << 20 | (size))
> > which would get picked in the rval < 0 path.
> > It would also let 'return 0' mean 'don't change the size' requiring
> > a special return for the one (or two?) places that want to set the
> > size to zero and return success.  
> 
> My conclusion is that encoding both optlen and error in the return value
> requires pointer manipulation that isn't justified for this slow path.
> While technically feasible, the resulting "mixed pointer abomination"
> won't be worth it.

Not really, they are both just numbers.
99% of the protocol code can just do 'return -Exxxx' or 'return size'.
That is all simple and foolproof.
The calling code (not many copies) does:
	rval = foo->getsockopt(..., size_in);
	size_out = size_in;
	if (rval >= 0) {
		if (rval > 0)
			size_out = rval;
		rval = 0;
	} else {
		/* abnormal path */
		if ((rval & (1 << 30))) {
			size_out = rval & 0xffffff;
			rval = -((rval & ~(1 << 31)) >> 20);
		}
	}
	if (size_out != size_in)
		put_user(size_out);
	return rval;
(Or something similar depending on exactly how the values are merged.)

> 
> > There is not much point making the 'optval' parameter more than
> > a structure of a user and kernel address - one of which will be NULL.
> > (This is safer than sockptr_t's discriminant union.)  
> 
> This approach forces every protocol to distinguish between userspace and
> kernelspace, then perform the appropriate copy:
> 
>   static inline int mgetsockopt(void *kernel_optlen, void *user_optlen, ..)
>   {
> 	....
> 	if (kernel_optlen)
> 		memcpy(kernel_optlen, newoptlen, ...
> 	else
> 		copy_to_user(user_optlen, newoptlen, ...
>   }

That is a function provided by the implementation.
It is no different from using the ones that act on iov_iter.
The real difficultly is stopping the usual culprits (bpf an io_uring)
from cheating and looking inside the structures.

> Additionally, you'd need safeguards ensuring callers never pass both user
> and kernel pointers simultaneously. This seems significantly worse than
> using sockptr.

Sockptr has the real disadvantage that it is very easy to mix up the
kernel and user pointers (there is some horrid code that looks inside).
If you have separate pointers that can't happen.
You might access NULL, but you are never going to use the wrong address.
Remember some systems (s390?) use the same numbers for user and kernel
addresses - you have to get it right.
In any case, if both addresses are set you can just have a rule that
one is used by preference - it isn't a problem.

There might be legitimate reasons for setting both pointers.
Consider setsockopt, the wrapper could copy small user structures
into an on-stack buffer.
The structure would then need to contain the address/length of the
kernel buffer as well as the actual user address in case the code
wants to read more that the expected data length.
For a kernel caller you also want the actual length of the buffer
as a separate field from the length of the [sg]etsockopt().

I'm not sure what fields you need for the address buffer.
Probably 'user address', 'kernel address' and 'kernel length',
what you don't need is support for scatter-gather, page list,
pipes etc.


> 
> --breno
> 

