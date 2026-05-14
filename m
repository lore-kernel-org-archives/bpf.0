Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 195AC3176E0;
	Thu, 14 May 2026 16:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778777536; cv=none; b=P+YkDA6/OV3JxJFmJ2R0dkKk8teS8xCtMl+UM+cu4MUY/HxB231p9dOpW6S4zNtXqiXuj/QngI9h6qzOL9mHvJvg4n8S1tdrSV5hYtfCSxzHHzSP2eGU5iZx/2tlU9OsEVg/ckUOixswHpEV7R8FxOZZTsz+UYENm2B0Vpk55qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778777536; c=relaxed/simple;
	bh=20d5NURmdg8XNVDu9VX3zqh/CxhFwYLXtozrsR4MlM0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XR3WVquskEsx9tCCStsUjGd9V06MF1LBMFlBsY8Es8lWtk5QpGAKer9v97JjtXipwf3F8iAFxmPlb3wBUyWQ7K02TGbSKboq++Uzm+N980vp5l5vDBulcMyWqtxZ7GvzmUpU27KjxNyt5WO3DaGxIEieg8La9lUokGcQPiNmNg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=L/HvwL+d; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="L/HvwL+d"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Q+mJ7FFyAUMwWpfkEoOmIfAbcnlwS948ryL40IUiiFs=; b=L/HvwL+dfN5rN2iiWC9UQNqLal
	BQHl2Wno9FFr8djE2wCsc82CRC+nDEHEihwlmq7m9sesXU9G0LSJu18WrOkDagofxFsVAEmE/RfKI
	b9MejL0I7VcoMzvz6bRmoZYBtdMGTf1rS+kFX76mwdvpPWH9TYJavOaBsdbpar7wQKVGy6ilkuwjt
	mEMVe20BbUOzGsfI5xn+UqSe1magdIgD2XnVt9ZPkHIN0i05um+Ixqqs9/NxgI+X0Ens0xEPYWDzp
	d/5wmmBBGPWE6jQpvJMHYD3yS9M1v882QipOEzRypvBl3iuHadhVmfzmC/4ahqdGnjO5QsHN4SBVz
	J0qwNbLQ==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wNZIA-0045gD-0X;
	Thu, 14 May 2026 16:52:10 +0000
Date: Thu, 14 May 2026 09:52:05 -0700
From: Breno Leitao <leitao@debian.org>
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Subject: Re: [PATCH net-next 3/6] af_iucv: convert to getsockopt_iter
Message-ID: <agX81xwmAFERRs_0@gmail.com>
References: <20260513-getsock_four-v1-3-fe7f0e756fac@debian.org>
 <20260514124502.5C2ABC2BCB3@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260514124502.5C2ABC2BCB3@smtp.kernel.org>
X-Debian-User: leitao

On Thu, May 14, 2026 at 12:45:01PM +0000, sashiko-bot@kernel.org wrote:
> If iucv->hs_dev is cleared concurrently by another thread holding the lock
> (such as during iucv_sock_close), could the compiler emit two separate
> memory loads for hs_dev since READ_ONCE() isn't used?

It is unclear  if there is another concurrent user here, honestly.

iucv_sock_close() is the only writer of iucv->hs_dev and only runs from the
protocol release callback, which the socket layer invokes after the last file
reference drops. 

The getsockopt() syscall holds an fd reference for its entire duration via
fdget()/fdput(), so iucv_sock_close() cannot run concurrently with the
SO_MSGSIZE read on the same socket. There is no other writer of hs_dev, and the
aligned pointer load cannot tear on any architecture Linux supports, so the
existing code cannot observe a NULL dereference or use-after-free in practice.

At the same time, SO_MSGLIMIT has the lock:

          case SO_MSGLIMIT:
                  lock_sock(sk);
                  val = (iucv->path != NULL) ? iucv->path->msglim /* connected */
                                             : iucv->msglimit;    /* default */
                  release_sock(sk);
                  break;

So, although this is not an issue per-se, it is an extra safe to get a lock
around iucv->hs_dev in SO_MSGSIZE as well, more as a defensive programming than
a bug fix.

That said, my plan is to include this lock protection in my series, but not as
a fix (thus, not sending to 'net')
