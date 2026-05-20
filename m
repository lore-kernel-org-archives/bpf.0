Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E6961A6836;
	Wed, 20 May 2026 16:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779293662; cv=none; b=WjONBA/1sl+4jiQ0l7RqKXn83gcYD+dOJr+tBojaE1vYH0CQrVYdsRZohmDUr7jop/Ez8Gv7IRAZON6VFz7TOo4poyaJ1J7yWT0sFWLoi349t0jdI1KdCBQlqtd0TcrhMcjH4nFMkxcqKrDuOQEun8HGRHhdwp9O7O9m/Qtehtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779293662; c=relaxed/simple;
	bh=206Do778AhQOt1mOHVPBEMipIY28Q+yNhRY4+maBCoI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BuDJuH51KfrtkMO0b01odxKV13IwFFaTadu4gaaFzY0MEi1itrTkvnw5OGpA99KlhxsdD4OmRg6q4i62NATxGxGYOXqDpgVJg+pF7pDRsL3B+rHBX5k66beEX/DZcz0s6M7MrdnRsHsmaeYdavL/RpzRpKASx8WxIR3D70xbES4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=JaMF8kB9; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="JaMF8kB9"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=kCIUogO0mQs44DTJh/wxinjbQek0km84DbYAsM4WUd8=; b=JaMF8kB9trMMmNNO6sA6lOpJ49
	UDS/B7BvEXzI5J/9tDb3jdf5G/DZ3SqO4d9syGpBYK73sJz3d9YYdwV8XWjiY7fEVMwOHklrZVDPa
	gAdrd0EMR4Aq9Pcgm2cIBndpHnorLnni2ybVwGXg+7Kj1dFqcznFVxILDcDmoMbOblxoEPqtjIqv1
	UH9WwMWq1LPSp2iQsDFhYvfd62JzsmK34l/Qcd6hiTo8edlnO4PAvFyczmK2ZvXozy68w/nFxWkId
	eUpSY/sjWG2c6BBwOrI5ZLUVA7eks9Bv9jl7jkJJSR24SVTRcDVZiyeN7LoXxJAGqpLRJKZaaBo9/
	Xxn+bj7g==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wPjYo-003EE7-0v;
	Wed, 20 May 2026 16:14:18 +0000
Date: Wed, 20 May 2026 09:14:13 -0700
From: Breno Leitao <leitao@debian.org>
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Subject: Re: [PATCH net-next v2 1/7] af_iucv: take socket lock around
 SO_MSGSIZE getsockopt
Message-ID: <ag3dctqXsRO-1akg@gmail.com>
References: <20260515-getsock_four-v2-1-0d8eed952627@debian.org>
 <20260516083434.6FC23C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260516083434.6FC23C19425@smtp.kernel.org>
X-Debian-User: leitao

On Sat, May 16, 2026 at 08:34:33AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] The commit message incorrectly claims the bug is unexploitable and targets the patch to `net-next` without a `Fixes` tag, bypassing stable backports for a reachable NULL pointer dereference or use-after-free.
> --
> 
> commit 2d366eacb5715c7a757195706a39c7382bd391e0
> Author: Breno Leitao <leitao@debian.org>
> af_iucv: take socket lock around SO_MSGSIZE getsockopt
> 
> This commit adds socket locking around the SO_MSGSIZE case in
> iucv_sock_getsockopt() to prevent concurrent modifications to hs_dev.
> The commit message states this is purely defensive and targets net-next.
> 
> > This is not an exploitable bug. iucv_sock_close() is the only writer
> > of iucv->hs_dev and only runs from the protocol release callback,
> > which the socket layer invokes after the last file reference drops.
> > The getsockopt() syscall holds an fd reference for its entire
> > duration via fdget()/fdput(), so iucv_sock_close() cannot run
> > concurrently with the SO_MSGSIZE read on the same socket.
> 
> Is it strictly true that iucv_sock_close() only runs from the release
> callback?
> 
> Looking at iucv_sock_recvmsg(), it appears to directly invoke
> iucv_sock_close() when the message limit is exceeded:
> 
> net/iucv/af_iucv.c:iucv_sock_recvmsg() {
>         ...
>         if (atomic_read(&iucv->msg_recv) > iucv->msglimit) {
>                 ...
>                 iucv_sock_close(sk);
>                 ...
>         }
>         ...
> }
> 
> Since recvmsg() executes with an active file descriptor reference, could
> this path be triggered concurrently with a getsockopt() call evaluating
> SO_MSGSIZE on the same socket?
> 
> If so, evaluating iucv->hs_dev and then dereferencing iucv->hs_dev->mtu
> in getsockopt() before this patch could be vulnerable to a race with
> iucv_sock_close(), potentially leading to a null pointer dereference or
> use-after-free.

You are right. iucv_sock_recvmsg() does call iucv_sock_close() directly
on the AF_IUCV_TRANS_HIPER msglimit-exceeded branch, in syscall context
on a live fd. Two threads sharing an fd (or two fds for the same struct
sock after dup/fork) can then run recvmsg() and getsockopt(SO_MSGSIZE)
concurrently, if the dev_put() drops the last reference, A can be left
dereferencing a freed netdev.

That said, I will separate this patch and send it to 'net'.
