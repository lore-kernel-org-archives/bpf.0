Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A9CB3F482C
	for <bpf@vger.kernel.org>; Fri,  5 Jun 2026 15:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780672471; cv=none; b=TmUXYHRcGZUf6wBANib7u/8qnX6hTeLWpCaj6DQNit9OHO1m0tWuNP58xGM+L2OGG50dJjAHoeBVxLU6zZ0jwmNKdmv6uRJ3YhJXIP3hbFtg2oqmSxCyC1fWVppN5RR0FlW7DPibq+GajQA13JFbHTtack44Rm1oF/oNOgsjzEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780672471; c=relaxed/simple;
	bh=+iR1M9yYqzyufLOWTZWg7ajKK1GPg5ZrcC7VtQr30Mk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iZi7BhnjoG0ncvk4nVi8cCFRt7lhIB2vs4teLeBF6Peir6XlX7bT5s0uEZgpBOqShW+wJ/0+DMBur2TQBundmf3B1VBFNpilCSZy02MTmLk1f5dUszMh4Kz/qWjDpoESlXEgDEdH2cTFmBZmPDxzfeE91G9vgsf5aexqEzxm97Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ho1GCmC7; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ho1GCmC7"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-45ef1629ff4so1424262f8f.0
        for <bpf@vger.kernel.org>; Fri, 05 Jun 2026 08:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780672468; x=1781277268; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AyRiQRM4moCCjTKbCSr5rYbdhGQBceKTugMVudUxfDs=;
        b=Ho1GCmC7MLe4FjtT6OG6EeAhoe70WMOZIFJBWvDmW0eKcWhOOtHGYDNWnXjzlZc0Up
         eKB8qKFQbzbAH+lGQiYAF4Yq/wZwkzWC0lf4odkQ+EKK5ht7Q0VUBhwrFbuK541GV19A
         UgxPl3MHU9VBCNgP7IFwGQYOpZjV/07g8ATC+Ogb3DHy9DRo8onqb3b/sWCcvzywGfDk
         rSexU0demSl0plhYmo1jm6SpG5FA8ds8XmOIxfIfCTgLynm/vNWRNNSagUiQpqBS4Wo2
         Itx3Tq8JH+GCKEW+lSzDkkQAIwk5+m5NkXX0O1Z2U9+rc0HmYq0QW/wEzDwCBZy+LS6J
         IIPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780672468; x=1781277268;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AyRiQRM4moCCjTKbCSr5rYbdhGQBceKTugMVudUxfDs=;
        b=isNQL3DwCEzTU+b7GPYzu1fjvpjNZGLvhCkA1R5Y9YujAsSDLhVcijjdWOUJtZ4y9F
         ac+Z+5TDdmV/mGB/feXS3fAmHiU5sEOhDT0Zki7D0d7ll7NKv6P97y2odR3Wd+fN20ce
         bqNar+gOGQlB2jUnpHWNwNWxyaD0bM6ezdTN3ym9rROcA6BOI7KYCmkdWO40EEJxPyjN
         eN+m7rUIQa8MkCeeUZ9NUlvhbUY2RSuR2DkMZ7TKWutimR5kWMxdWALw3VyrCr9UttY9
         EO1WsscsHcIxXhkBz9elByVL802CsncG5T96fD0LKDvL83aBLtRj787ZV2a6VC9ZQbWW
         IKGw==
X-Forwarded-Encrypted: i=1; AFNElJ+SFOMT2c+80Y5FEqahr/z0tUng3YrkTXTFKDW/viK/aCepFr812Ruk7uJnUaA15mhQtZw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfbEJM91vrjmrVAm5TD+cqQ1zMt/v7QJt/K+EPNb3Y1BHqf8Rt
	FpXWRpMnJdAj3CrCf6YyK5e0vNgVXfTKHjgukmP/EqMJUoq1ehF9pBm4
X-Gm-Gg: Acq92OGuqLGlhw27awpG6T4AmjvqQOjrrBW17otxKeczk+KVsdykF5joeAwsfqYdQg/
	pNbuap84f4TFBBpUW8rwqfMT8FiCFewURkuk9hdvDEkwkLFAXni6heZNDYfGRhzNBXwkCHUNrhG
	MhguABaMH5RIgNHNiLih/OvXb2bJRzwiRLQoOJ8+/+VkBc54HY31zFKjRonU2uGBl+yN29eyoan
	AuEk/XneLT2V98w7XC/31nE5bBnsqVPQZb5Y8bX8dpIa14cUX4vtqr6caYbbCmVmTY/lQ4rhJEX
	032DRrYQiLYqsEMUmHfN8hj+iUE9UmJ4k23E0w1wPHij4CGC2R4RMWgGQK3+cM2WS2tJ1Qp53HR
	9hrHq6MHDUMeufn0/l6QwrYRcsa8FeWkhsOBv/CMuDpQZWBgEIDKdzcSeaGVmQW6VmjiP81wF/p
	S+xvMewN4yhXcjCKMlmMPDspvd2pGhEt/DNxyMAhk/W3tWV1pLf04EBjYGPNJXrl1XZ0GSoBA=
X-Received: by 2002:a05:600c:34c5:b0:490:be9e:fd07 with SMTP id 5b1f17b1804b1-490c25ae3e8mr66631365e9.10.1780672467777;
        Fri, 05 Jun 2026 08:14:27 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2dcad5sm29110357f8f.5.2026.06.05.08.14.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 08:14:26 -0700 (PDT)
Date: Fri, 5 Jun 2026 16:14:24 +0100
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
 buffers (update 1)
Message-ID: <20260605161424.334a05d5@pumpkin>
In-Reply-To: <aiK94g9vphHls3x_@gmail.com>
References: <20260408-getsockopt-v3-0-061bb9cb355d@debian.org>
	<aiK94g9vphHls3x_@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 5 Jun 2026 05:25:21 -0700
Breno Leitao <leitao@debian.org> wrote:

> On Wed, Apr 08, 2026 at 03:30:28AM -0700, Breno Leitao wrote:
> > Currently, the .getsockopt callback requires __user pointers:
> > 
> >   int (*getsockopt)(struct socket *sock, int level,
> >                     int optname, char __user *optval, int __user *optlen);
> > 
> > This prevents kernel callers (io_uring, BPF) from using getsockopt on
> > levels other than SOL_SOCKET, since they pass kernel pointers.
> > 
> > Following Linus' suggestion [0], this series introduces sockopt_t, a
> > type-safe wrapper around iov_iter, 

I'd have thought it would also have been better to use a wrapper function
instead of direct calls to copy_from_iter().
There is no need for most of the code to know there is a iov_iter hiding
inside sockopt_t.

-- David

> > and a getsockopt_iter callback that
> > works with both user and kernel buffers. AF_PACKET and CAN raw are
> > converted as initial users, with selftests covering the trickiest
> > conversion patterns.  
> 
> Quick update on this effort.
> 
> All proto_ops users have been converted to getsockopt_iter and submitted.
> 
> Most conversions are already in linux-next. Three remain:
> 
> 1) rds: Under review
>    https://lore.kernel.org/all/20260605-getsock_more-v2-3-80f38cdb8706@debian.org/
> 
> 2) smc: Submitted today. This is only limited to UBUF right now
>    https://lore.kernel.org/all/20260605-getsockopt_smc-v1-1-65da62fa44c4@debian.org/
> 
> 3) CAN drivers: Reviewed and acked, pending Marc's merge
>    https://lore.kernel.org/all/f83e25e1-b9f5-4810-bbd6-fdb8d2a10c8e@hartkopp.net/
> 
> Once these are merged, I'll rename getsockopt_iter to getsockopt and
> remove the legacy path.
> 
> Next, I'll convert struct proto the same way to eliminate the remaining
> userspace optlen/optval pointers.
> 
> After that, io_uring getsockopt operations will be unblocked.
> 

