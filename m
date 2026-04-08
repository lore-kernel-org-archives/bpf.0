Received: from mail-ot1-f66.google.com (mail-ot1-f66.google.com [209.85.210.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D2D73537F1
	for <bpf@vger.kernel.org>; Wed,  8 Apr 2026 17:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775667763; cv=none; b=GfRdJYGWmpf2N94Xmvr5Lehk7mtwsgjqV40ijeDnioExMMYOknqkYJDv437Cx+O7XvuhOvkzOiHy0XVKgyXeTsZ/AdJVxH0tMwAHGcYrC3bSCFuki4s0mANQfWxW8xiGklLADLi2TLpgFrM0ZICWJL7jqSdXgONO21JsOiLvFww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775667763; c=relaxed/simple;
	bh=xdLLVMMQT69JFQt1brGOUFUC5V03wHdBk5qEpoTRbKc=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PQz7MxQfpnHgkwCJh9pLvt5DDiPtSNwH3Q37E3jyB0xg4EO+FggzqSCXHTMoBYddRxFpirhCN+enyNV3JCIfXyiaRcnI1E5XywmC0Ycps8TPOdoVpdIpGa3gRPkN6F/tsy/CqcEYkyCV7Lqimm/XAxW1R21Klvy5xtZQzNh1+bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FTlH5UDy; arc=none smtp.client-ip=209.85.210.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FTlH5UDy"
Received: by mail-ot1-f66.google.com with SMTP id 46e09a7af769-7dbff06e4a6so42084a34.1
        for <bpf@vger.kernel.org>; Wed, 08 Apr 2026 10:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775667760; x=1776272560; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lMpI3o2mUCKoqrF6VB4ezds9Ya6pdU2HqjJAbgYriXQ=;
        b=FTlH5UDyfbxYhlBp0sxVrDv0sG4vY5BIN6h9qqoMbtEi4tRFnnWTQrBZZa6YrddcAQ
         N2auK8zv7t1LFG9mz9La7e+sWR5ZZq8gKlkXFRCs6ayikUL2uulDxGelJma7MaeM4Ymz
         bHtxfv+PRJ2aEqrZKgSro5IJ5EAVFLZiMWRks+cf5Hc0rkCwm8cpgQKEGmVwPvlXwwTw
         /NNJMcmftJpy06QCEeZ/2o+moBQfiJ+o4MxjvVkSQQmP2JBHR7C88wrGrU3VxHTrd7Lq
         ieuA3XanTNPPRm9iiosJAoVZXRBVQuRziCZVgCCQs/I7BnpiqTc1Utj/ZY9Czt/JY+KA
         PpXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775667760; x=1776272560;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lMpI3o2mUCKoqrF6VB4ezds9Ya6pdU2HqjJAbgYriXQ=;
        b=qTOgsAkhmogbu7jVFKpzcx6erosYhbKk5KySa+xQAPmMjEgLDD+QRSGg+oD/mvCiMj
         Yb69x3qh0gwKIIzgHjw4rpqBwN0h5V1vOVm9VXL27jjzsWEGWz+oxQtx7nhmUcOBhuyc
         yIPbzMdxrD1QGL1u2dROzVg+NQK3cT2LZwOMsPB8tz4XmQuU8bp6WaawTJTZZXZHzhVV
         ArdAs8turNUdlGFR9GOS8Q+u6syXaiZTaP4TtndQcRzcwXvmKKrCckKtI8zRbCbV5BGa
         z2n+M5NLWo7GuuMPImdM/iE9caAU1+NejGGVQtVmH9guiK1nRQznbGSXnVZjZDJxnEZu
         mI5g==
X-Forwarded-Encrypted: i=1; AJvYcCXjen9JncdwPzglJg7ZzY76T01p0gXuu5M9eK102XDyC4iTaduB1Tw07D76uq6dYYRz4mc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQFObMDJKOmF0fciydIxUFdZ0QGW3BYELrGXpr+FrTZMJ7J2y2
	M4EK9LpUkwEGUHaU5Z65rk/Q1oqewqbH1+aTHumyZW7Qksf/sm3uvuEu
X-Gm-Gg: AeBDiesdWf/qwjrUnrQPbwPLna0juCXNBJr66M66OQDBKQfcY0ux83lMUbJjA1KxyPy
	HZHk0Ojnfo5Llow5f2k7Pp6rPBelsETf2i9Q010Xovm2aPqAingmpkdHNpf8LSelIEmM9lHXMDv
	upIH7HRV2bzYJjkEqAFU79uxo6AtQAnZlAoky8I9kCIbeznjoNgoCHO2GZ4w8gki3bgwiBP8CTI
	WleZWDcc2aYYxPIddfsVofw3StRb0N6PK3bwQy+A6e4CgN8lQq0yD45rF9+BZYt0RVBZOGtQWmq
	XJnImHHXIIv5pCzX8sjntMSz/LgqkiedSTW/ESlSfUfCJ1rcPzM2JuColmMh89IFbtDnka5Rk9V
	iJ93h3VMA9+1czXAWWxpv/L2HKmXrzSAZlZyxcFkZHSlRarOnu9nBLJs6+CY4fGkQdRzbdhfM6y
	U7lc/ugPklKBV0q2r1
X-Received: by 2002:a05:6830:6103:b0:7d9:e9a7:cfaa with SMTP id 46e09a7af769-7dbb712a3a2mr14340529a34.15.1775667757936;
        Wed, 08 Apr 2026 10:02:37 -0700 (PDT)
Received: from localhost ([2a03:2880:12ff:3::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7dba73d8126sm14465822a34.27.2026.04.08.10.02.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 10:02:37 -0700 (PDT)
From: Stanislav Fomichev <sdf.kernel@gmail.com>
X-Google-Original-From: Stanislav Fomichev <stfomichev@gmail.com>
Date: Wed, 8 Apr 2026 10:02:36 -0700
To: Breno Leitao <leitao@debian.org>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Willem de Bruijn <willemb@google.com>, metze@samba.org, 
	axboe@kernel.dk, Stanislav Fomichev <sdf@fomichev.me>, io-uring@vger.kernel.org, 
	bpf@vger.kernel.org, netdev@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH net-next v3 0/4] net: move .getsockopt away from __user
 buffers
Message-ID: <adaJqy6Q4L7c-eTs@devvm17672.vll0.facebook.com>
References: <20260408-getsockopt-v3-0-061bb9cb355d@debian.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260408-getsockopt-v3-0-061bb9cb355d@debian.org>

On 04/08, Breno Leitao wrote:
> Currently, the .getsockopt callback requires __user pointers:
> 
>   int (*getsockopt)(struct socket *sock, int level,
>                     int optname, char __user *optval, int __user *optlen);
> 
> This prevents kernel callers (io_uring, BPF) from using getsockopt on
> levels other than SOL_SOCKET, since they pass kernel pointers.
> 
> Following Linus' suggestion [0], this series introduces sockopt_t, a
> type-safe wrapper around iov_iter, and a getsockopt_iter callback that
> works with both user and kernel buffers. AF_PACKET and CAN raw are
> converted as initial users, with selftests covering the trickiest
> conversion patterns.
> 
> [0] https://lore.kernel.org/all/CAHk-=whmzrO-BMU=uSVXbuoLi-3tJsO=0kHj1BCPBE3F2kVhTA@mail.gmail.com/
> 
> Updates from v2 to v3:
> 
> * Use two iov in sockopt_t instead of a single one:
>   a) .iter_in that is populated by the caller and will be read-only in
>   the protocols callback.
> 
>   b) .iter_out will be populated by the protocol and it will be sent
>   back to the caller.
> 
>   - This will avoid changing the protocol reset and changing the data
>     source at the callback, making the driver callback implementation
>     and converstion saner.
> 
> * created sockptr_to_sockopt() to convert sockptr to sockopt, making the
>   call to getsockopt_iter straight-forward
> 
> Link: https://lore.kernel.org/all/CAHk-=whmzrO-BMU=uSVXbuoLi-3tJsO=0kHj1BCPBE3F2kVhTA@mail.gmail.com/ [0]
> ---
> Changes in v3:
> - Create Two iov in sockopt_t instead of a single one (Stanislav Fomichev)
> - Implement the sockptr_to_sockopt() helper (Stanislav Fomichev)
> - Link to v2: https://patch.msgid.link/20260401-getsockopt-v2-0-611df6771aff@debian.org
> 
> Changes in v2:
> - Restore optlen even on error path (getsockopt_iter fails)
> - Move af_packet.c and can instead of netlink (given these are the most
>   complicate ones).
> - Link to v1: https://patch.msgid.link/20260130-getsockopt-v1-0-9154fcff6f95@debian.org

LGTM! Not sure what's your plan for the selftest? You wanna keep it
outside or maybe repost v4 with it?

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

I'm also not sure your unconditional 'copy-optlen-back' will work for every
proto, but I think we can put something into sockopt_t to make it avoid
the copy if needed in the future.
