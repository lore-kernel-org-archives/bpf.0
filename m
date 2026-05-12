Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9DFF72618
	for <bpf@vger.kernel.org>; Tue, 12 May 2026 01:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778548820; cv=none; b=ZaHG2ZQgNf7XwEPe2O6x3ODI7nXbQrXz2bh11kWRHExXSAyfpgqJ/k+KwY1BV5BgdV/wOQYwdUKVeu0efvqBKy73QpQxmSQlrNb0HwClV+NMthKF78lrVxsV/86Js/zAED2Pg0KdmNR1GZ5TAAeoQPTkCy/Yoyq0l4GxoG4Ybmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778548820; c=relaxed/simple;
	bh=OWghE6bdsX88v9L2a/fZ4VVAIfGR5YWoqshtZHRgEfM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UCglK2iOCx4owWYIafh4WgilsRaSJ/Hx086agcI+ERXqZsOCr2vlh9m3pYEGxS2XNVKNow0I5mX/UV6NsbWuBchb5Ta4UwcvC+jVE2pktqHwbF5YIB/SFhoZuc1EUbaP5Z7ZLl0Z/tGrVMwMz4roQaUdEMGo4MvCn3ARukZ9iSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G8wats7M; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G8wats7M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC698C2BCF7;
	Tue, 12 May 2026 01:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778548820;
	bh=OWghE6bdsX88v9L2a/fZ4VVAIfGR5YWoqshtZHRgEfM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=G8wats7Mkjsm12EQLYCM8DNKxWQ+IZsxzVUMQ8j/SaFE3A59IviNQDELVcuzrSM/v
	 if/slg7CFANZFcZxgkU/3I17lYO42pXcjvhlgyDB6BGzy6V4PE6zXAL9c+naSEBFFO
	 Xffysg7KCS8tbwcrBP7W5cQx+5WEqZ7iefCPYo7Srue4onHh5OUCrqSVijGSJNXODg
	 hI8dDQ4CGXCvhjc/i1aBKWbGB1wKT9rah9n8SxcZ5aOsVe1XIhNe2TnNFOqkRwDghX
	 gbXfow5T6G8W4kDB4Gw+Ur+xSQTa1U5XN14uY/HTxftOHuNlahjwFuIpBOVBkhQOtB
	 PB0XbvHneRw/w==
Date: Mon, 11 May 2026 18:20:19 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Mahe Tardy <mahe.tardy@gmail.com>
Cc: bpf@vger.kernel.org, andrew+netdev@lunn.ch, andrii@kernel.org,
 ast@kernel.org, daniel@iogearbox.net, davem@davemloft.net,
 eddyz87@gmail.com, edumazet@google.com, john.fastabend@gmail.com,
 martin.lau@linux.dev, pabeni@redhat.com, song@kernel.org,
 liamwisehart@meta.com
Subject: Re: [PATCH v1 1/4] bpf: Add netpoll kfuncs for sending UDP packets
Message-ID: <20260511182019.69ebc7c6@kernel.org>
In-Reply-To: <20260511085344.3302-2-mahe.tardy@gmail.com>
References: <20260511085344.3302-1-mahe.tardy@gmail.com>
	<20260511085344.3302-2-mahe.tardy@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 11 May 2026 08:53:41 +0000 Mahe Tardy wrote:
> Add BPF kfuncs that allow BPF programs to send UDP packets via the
> netpoll infrastructure. This provides a mechanism for BPF programs
> (e.g., LSM hooks) to emit telemetry over UDP without depending on
> the regular networking stack.
> 
> The API consists of four kfuncs:
> 
>   bpf_netpoll_create()   - Allocate and set up a netpoll context
>                            (sleepable, SYSCALL prog type only)
>   bpf_netpoll_acquire()  - Acquire a reference to a netpoll context
>   bpf_netpoll_release()  - Release a reference (cleanup via
>                            queue_rcu_work since netpoll_cleanup sleeps)
>   bpf_netpoll_send_udp() - Send a UDP packet (any context, LSM prog
>                            type only for now)
> 
> The implementation follows the established kfunc lifecycle pattern
> (create/acquire/release with refcounting, kptr map storage, dtor
> registration). The netpoll context is wrapped in a refcounted
> bpf_netpoll struct. Cleanup is deferred via queue_rcu_work() because
> netpoll_cleanup() takes rtnl_lock.

We have enough bug reports as is, let's not merge unusable toys.
For any use of netpoll by BPF:

Nacked-by: Jakub Kicinski <kuba@kernel.org>
