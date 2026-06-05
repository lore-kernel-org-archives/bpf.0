Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B409221770B;
	Fri,  5 Jun 2026 12:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780662340; cv=none; b=Qz0M2bOYHQS25jGFJKERXMnFp5sZguWz3e1DZHSLKfju8ASJVToFBIuQYfNrtz8oMe4FwLr7sjx765rI6Iw1XWFHVabVtjhj0KidtmJEsL9xf3Z1bSXUag29eEqUeQQ1XEjXcS6kFj3obSN7L53s9ix6/VINgzat4tlZG01Prwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780662340; c=relaxed/simple;
	bh=7hiGcFLxFEKhHkZjVyJqJBXCTKtT6gXdmQ9JGqsFrVs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QjNYGHw7HAa+9UW2OeyFAlsm6+2hI6sOd12W4v2PM2oolHubS78Dl1ZUA37Xh5IEJJxJlt9Wfa9XV6H9d5o3MgFBDa8mSt8EPQ9wLAsj/cZOfL/HUhtbQI9NyTow3Bad+ZdVoraZakqV7w4O39GwmKmSoJDpSvJJCyFNDbPyhi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=O33AwwK3; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="O33AwwK3"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=554cJHTZWjVGBaLg4qLyp/xmftBxh0/L7bcES1SXh00=; b=O33AwwK3/CjjUs+yB1ErwPMdbt
	FD+oeo1ZO6j36NurPsHeHl41fV3SewL9z8gH0JLY3rqF+25F3LTO1iVDxPAOq3IbHGsM8EjvLmdsn
	B6p+HOzJTE06Y1ayqlUcMlqbB/rUzsTKI2AffP7G92bdIyYsVlP+MYeSXfZ7hfWken05E5tJbTj2P
	bronOdTVniE7SNHGiCLQjV7XIVezlG5PNbjeWLDLZ3p1SJjt8DgvefiolCXvYXVBxqJjsi/V/yk6i
	3QSD5ANTVxYRmqA0OFav3OnSoPHRYIttZfJD5pi9qoiZjXo4eg0O3UOlZaw3D7lZylF/Wnk2Um2D9
	xyXdOt9Q==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wVTc6-005HwE-1G;
	Fri, 05 Jun 2026 12:25:26 +0000
Date: Fri, 5 Jun 2026 05:25:21 -0700
From: Breno Leitao <leitao@debian.org>
To: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Willem de Bruijn <willemb@google.com>, metze@samba.org, 
	axboe@kernel.dk, Stanislav Fomichev <sdf@fomichev.me>
Cc: io-uring@vger.kernel.org, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH net-next v3 0/4] net: move .getsockopt away from __user
 buffers (update 1)
Message-ID: <aiK94g9vphHls3x_@gmail.com>
References: <20260408-getsockopt-v3-0-061bb9cb355d@debian.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260408-getsockopt-v3-0-061bb9cb355d@debian.org>
X-Debian-User: leitao

On Wed, Apr 08, 2026 at 03:30:28AM -0700, Breno Leitao wrote:
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

Quick update on this effort.

All proto_ops users have been converted to getsockopt_iter and submitted.

Most conversions are already in linux-next. Three remain:

1) rds: Under review
   https://lore.kernel.org/all/20260605-getsock_more-v2-3-80f38cdb8706@debian.org/

2) smc: Submitted today. This is only limited to UBUF right now
   https://lore.kernel.org/all/20260605-getsockopt_smc-v1-1-65da62fa44c4@debian.org/

3) CAN drivers: Reviewed and acked, pending Marc's merge
   https://lore.kernel.org/all/f83e25e1-b9f5-4810-bbd6-fdb8d2a10c8e@hartkopp.net/

Once these are merged, I'll rename getsockopt_iter to getsockopt and
remove the legacy path.

Next, I'll convert struct proto the same way to eliminate the remaining
userspace optlen/optval pointers.

After that, io_uring getsockopt operations will be unblocked.
