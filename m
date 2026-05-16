Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB97C2DFF04
	for <bpf@vger.kernel.org>; Sat, 16 May 2026 08:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778920475; cv=none; b=GulgoXkkLwnUeTj+lTFbzEut/PGglG2cVeS8fwuKGgA+P7czg/LQQ3I44rOxQjO3Sdtz5tfHzJVnE8wH8ZcBe8sZNsYP2wC6DIq0CFbgqfsd0NYw8YwwghsSlbg7XpzX3t8y/3mHRrR2nBwlL64h52QJciofu+9EJPiW4004GT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778920475; c=relaxed/simple;
	bh=Jwh5RSmNxRLdoB+RCG10kfWAZEH28EelEMVqOPheuGI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KtTryaekjCjv58yc/rJ4Sr2dntiBlMdwLCg7++m+Q6gtRFJ2ww17JHE7EjaqN1vHwRdxLVaPkqBssan8gJBWtewElxMwRbWNQIbWTfBAGmL2zrb8rz/H3VAE6BcX4X87Ct1FZaI03/GtjH+EzKLOpcVRefJcSrsIoT0SQF4YRBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c9aX6pSI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c9aX6pSI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FC23C19425;
	Sat, 16 May 2026 08:34:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778920474;
	bh=Jwh5RSmNxRLdoB+RCG10kfWAZEH28EelEMVqOPheuGI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=c9aX6pSI6XzRtf/jMi6kb+gKVv1K7SzQ60wwAEVa4VkxjriSGmxntOCJVVBz8WLJj
	 RGZkm08u+lIIhr9O41liL/Oxn9zrpmOeGbV/yffZ5JjlPnuU7hMjd2xucR31Al8yDY
	 11Ua06nkAxWu2h/I6ViTSg5Y+z8nwSCBHQXbRFmJpDIbDAvmI94z6x+/FWGOBYO5RA
	 f4Qa2RlxJTEJCiFegoSDLPj2k7o3QUyA32ojDrcsd/wuRHVo19cnijxb2CyTHdgQ8z
	 tO1Jte88llUbUElpBNYo1ZRWwRPmn/b9wZllnWzEyialVyprzka8LZi12nU9o8fUkW
	 z/ouULIYIq9ig==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v2 1/7] af_iucv: take socket lock around
 SO_MSGSIZE getsockopt
Reply-To: sashiko-reviews@lists.linux.dev
To: "Breno Leitao" <leitao@debian.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260515-getsock_four-v2-1-0d8eed952627@debian.org>
References: <20260515-getsock_four-v2-1-0d8eed952627@debian.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 16 May 2026 08:34:33 +0000
Message-Id: <20260516083434.6FC23C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The commit message incorrectly claims the bug is unexploitable and=
 targets the patch to `net-next` without a `Fixes` tag, bypassing stable ba=
ckports for a reachable NULL pointer dereference or use-after-free.
--

commit 2d366eacb5715c7a757195706a39c7382bd391e0
Author: Breno Leitao <leitao@debian.org>
af_iucv: take socket lock around SO_MSGSIZE getsockopt

This commit adds socket locking around the SO_MSGSIZE case in
iucv_sock_getsockopt() to prevent concurrent modifications to hs_dev.
The commit message states this is purely defensive and targets net-next.

> This is not an exploitable bug. iucv_sock_close() is the only writer
> of iucv->hs_dev and only runs from the protocol release callback,
> which the socket layer invokes after the last file reference drops.
> The getsockopt() syscall holds an fd reference for its entire
> duration via fdget()/fdput(), so iucv_sock_close() cannot run
> concurrently with the SO_MSGSIZE read on the same socket.

Is it strictly true that iucv_sock_close() only runs from the release
callback?

Looking at iucv_sock_recvmsg(), it appears to directly invoke
iucv_sock_close() when the message limit is exceeded:

net/iucv/af_iucv.c:iucv_sock_recvmsg() {
        ...
        if (atomic_read(&iucv->msg_recv) > iucv->msglimit) {
                ...
                iucv_sock_close(sk);
                ...
        }
        ...
}

Since recvmsg() executes with an active file descriptor reference, could
this path be triggered concurrently with a getsockopt() call evaluating
SO_MSGSIZE on the same socket?

If so, evaluating iucv->hs_dev and then dereferencing iucv->hs_dev->mtu
in getsockopt() before this patch could be vulnerable to a race with
iucv_sock_close(), potentially leading to a null pointer dereference or
use-after-free.

> Note: For the reason above, it doesn't contain a "Fixes" tag, and is
> aiming at net-next instead of net.

If the concurrent recvmsg() path is reachable, does this patch actually fix
an exploitable issue rather than being a purely defensive cleanup?

If it does fix a reachable crash, should it include a Fixes tag and be
targeted at the net tree so it gets backported to stable kernels?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260515-getsock_fo=
ur-v2-0-0d8eed952627@debian.org?part=3D1
