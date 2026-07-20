Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB9C63D9024
	for <bpf@vger.kernel.org>; Mon, 20 Jul 2026 10:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784544106; cv=none; b=dfGojBG0elHdxCHYkJ83Q22K2d1LOMpDDljr8VgU5F7kA/u9cZ7m5yyVwrGzc24qzl0uQRpzJeR94GIG9LA3Y2DCxtDGnsf4r0ohIP0X5XZfW36mgW2fJqUd5W34FPY2aSyIIlZmWvS0R3NpSbzZ8ULFgUsThkuTWqdfTQQVFZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784544106; c=relaxed/simple;
	bh=7AIZV6ikm+f7Vp88ExXBmJtyqrAuf5TUyp94rGhxfMM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gKJyMSe5ji/CWJORfsF8qDkC6njEQsdZphokHqQ40c7mx4mxUhkaaaFXuXN+D37DElmaAbZJ3ur1T+fLSAH+p6NxtDCRVU6eDm9mPJaoDNoQbPLxDSZCUeoOvr5xnNSo1HJtsEyf0xkB5pVf3lBQk+D56CcMhHSEtn+N32RDOYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pm9cw4Xi; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pm9cw4Xi"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-49546c690ffso24012495e9.2
        for <bpf@vger.kernel.org>; Mon, 20 Jul 2026 03:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784544101; x=1785148901; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1Xz/6qEDyrPzu6QgGCWx4KiBgrI/vNssPvEcJi05ZpI=;
        b=Pm9cw4XiSswat1qWFr7AcuBkSPKMOOWW6oXJ7jR4cH8SElX3HFjNqUShS57x6sDUVm
         zv0byl8uC434EXznlC4BJ2xKh0BLPYlM4Cqk68I2p9bd8gXY7Is3XCXKQglFB6S4lQDn
         trKeDInKxVJFZTGNJ236rX2L7vVLiDbOp6sOj93lR3usq1NGo4gV9rLJj02f6qHbbBsP
         jUVrFaHET/MahVEXmFP+qfAL5KmITW//OqRaugUomgOAY8wZ666DVyrabEtc91iNyUED
         6uSnPq1Jtu4n9LKvPoJhUlmWU8O7+qp6j7nXr74673Ptruq4KJsXkZN1Bz0HqhRf3DVZ
         lpQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784544101; x=1785148901;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1Xz/6qEDyrPzu6QgGCWx4KiBgrI/vNssPvEcJi05ZpI=;
        b=G3tlf69nNjkuxqn+fKofLqqXfVmYZJUUiQUmXJWgAxtvY8+OcJprlTh3a1611//14p
         E4RWhF+oS39XV2uTvRL8x1toCz3dz2Cdj1jsZYCUq95WUrg3Ar7jbdc/GVZh0NW6/pof
         EI5zLlC/RUax6qB3G9RE+6wc8KnzRpDA6NRLHRN9lRcQ97q5ZqtlpyMM+ovdYGg7Awnq
         70+dscQlxOGMTX0016WT1FV+8tW3YKIZVRCYniHiDo7iX2Ez/bV+KbJDI9bwT2halhyV
         H4wASmPjlZUnpVz0lCnS/6QxGuizzXQWZLxaA9k+FHWLhmr0Kih2Owu++TN5jk1QKi9y
         zrLQ==
X-Gm-Message-State: AOJu0Yz5nWW216XwLSJep8n+AzmqusHy3IGMVrI8sJgKgZnAL3/7xUsp
	22RnxYrUtOXNbElK6Afxy61ZRL/B9kX2FOA1dZ9omd9IOpLbvq84lzQ8xAQQvvVf
X-Gm-Gg: AfdE7cmUfaQJdA4hdnV7Emtwlu7Z6s4OsW4KoTgs4r4ws+VkEIm7ubi+fGQoADtVPlO
	FRN+nD8bF4c3dkI2+IFAWy9HdLOfoMsmrK9HQ9CKHsUPXsHFEFDes/nOJ+erYZnsMCctL9fEZQK
	RX7Q5JGGEw8ijjdVOEXzRNZQKwEtRQ86H3bQVs05aSOxLtbXnB0/ECNzWxjm/Sgpz3NzEmi5/Wb
	yCo9DWbmckeyrIy067et56okabPwS3ZtwnYggiJPqmphhZb96r0c6EM8aTteVLyT4Kvp3NgUp8D
	k+GZLzGcVCiHUcGyRLQIQR8LpbtwMSVgDkgnvi2HFGxRiXcAvEu58EMx+i90VrOYuqzVSVJ26iv
	0gaXnsC7Sta160ryAI2mSqXZI/3S/SvzgZi54r2gTKsYri4dfWSPfFb49ZbPdrvgpTiKe/4WBoT
	JjgZeyszrxuzw+cRclJOTtxu4oa3Ts34ZlnYCzwrvhcldZIr+9+9gFguiPvO4VF62+bg==
X-Received: by 2002:a05:600c:4743:b0:495:406c:81d5 with SMTP id 5b1f17b1804b1-4954a50b8b8mr156161615e9.28.1784544100735;
        Mon, 20 Jul 2026 03:41:40 -0700 (PDT)
Received: from localhost.localdomain (host86-153-201-25.range86-153.btcentralplus.com. [86.153.201.25])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f63e496afsm29695130f8f.1.2026.07.20.03.41.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 03:41:40 -0700 (PDT)
Date: Mon, 20 Jul 2026 11:41:38 +0100
From: Nnamdi Onyeyiri <nnamdio@gmail.com>
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Subject: Re: [PATCH v5 1/2] bpf, sockmap: handle spurious tcp_msg_wait_data()
 wakeup
Message-ID: <al3uUF4FaneGEvmB@localhost.localdomain>
References: <20260717155348.54975-1-nnamdio@gmail.com>
 <20260717155348.54975-2-nnamdio@gmail.com>
 <20260717170146.A8CCB1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260717170146.A8CCB1F000E9@smtp.kernel.org>

On Fri, Jul 17, 2026 at 05:01:46PM +0000, sashiko-bot@kernel.org wrote:
> 
> [Severity: High]
> This is a pre-existing issue in tcp_bpf_recvmsg_parser(), but this patch
> copies the same logic into tcp_bpf_recvmsg(). Does this create an unkillable
> infinite loop if the user calls recv() with a length of 0?
> 
> If a user waits for data to be queued and ensures an error state is set (for
> example, the peer sends a FIN setting RCV_SHUTDOWN), and then calls
> recv(fd, buf, 0, 0), sk_msg_recvmsg() immediately returns 0 since len is 0.
> 
> The code enters the if (!copied) block, hits the RCV_SHUTDOWN check, and
> because !sk_psock_queue_empty(psock) is true, it executes goto
> msg_bytes_ready.
> 
> Since len is 0, the cycle repeats immediately without releasing the socket
> lock or checking for signals, pegging the CPU and potentially causing a
> soft lockup. Is there a way to safely break out of this loop when len is 0?
> 

I don't think this is possible, as both tcp_bpf_recvmsg() and
tcp_bpf_recvmsg_parser() have an early return (before the loop) if len is 0.

> 
> [Severity: High]
> This is a pre-existing issue, but does tcp_bpf_recvmsg() propagate an
> incorrect -EFAULT to userspace when receiving a 0-length message?
> 
> If a BPF verdict program redirects a 0-length packet (such as an empty TCP
> FIN) to a sockmap socket, it is queued as an sk_msg with sge->length == 0.
> 
> When the user calls recv(), __sk_msg_recvmsg() in net/core/skmsg.c
> processes the element, sets copy = sge->length (which is 0), and bypasses
> copy_page_to_iter(). It then evaluates if (!copy).
> 
> Since copy is 0, it triggers copied = copied ? copied : -EFAULT, returning
> -EFAULT.
> 
> Because -EFAULT is not 0, tcp_bpf_recvmsg() bypasses the if (!copied) error
> handling block above and directly assigns ret = copied, returning the
> -EFAULT back to the syscall caller. Should this case return EOF (0) instead
> of -EFAULT?
> 

I can reproduce this in a selftest.  As this patchset is addressing
EAGAIN errors, I'll send patch for the EFAULT separately.
