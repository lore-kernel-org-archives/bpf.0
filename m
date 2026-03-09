Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1914737BE8F
	for <bpf@vger.kernel.org>; Mon,  9 Mar 2026 13:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773064640; cv=none; b=TZWx6jatx/75Rz0cDpm4OhLoDud8qzNXjyM7F3EeTWgKFEUFj9t2EaFKKAFzQNKhg3zSiT877NAUE+jLX14RH+TQPwOha8msvosGMGT33IOzPwTQtVBXnDyzpQOKkfU6bUwWYxwVxjZ6IF5mjK+WXYxs2yxlVm4XSPw7szSrzgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773064640; c=relaxed/simple;
	bh=YTlyaYk7PpX3cuau2SmIh3yb3TDKZyISR++MlIeKYbs=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=hG65d/A1XNTRLKMvIp26tW+ulV+AAKQzgYOGXMJfssV/dCmdJB9pp1067YeU9o5gVDBxTWhuVxAM2udluwq3Xb9yhSGf6jCHLd1ULBabNdiRsdhvB1kad7nz5J3dCuFWJHtJq4v4eXowaA5HrqdUdRSCh7dSc/DTwP/oug9XvXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mAwJHJMC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mAwJHJMC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 740BEC4CEF7;
	Mon,  9 Mar 2026 13:57:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773064639;
	bh=YTlyaYk7PpX3cuau2SmIh3yb3TDKZyISR++MlIeKYbs=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=mAwJHJMCK0p6RCtuV01QVl19gpgLhpLX1acf8suYEV+Vt67QNobIsxFOYZaCiIP2G
	 mpEGR0rXbJeeLusjQXrPEYxtFj8tF3YIvHWUvCcQMbItpDv8IhF6DYF3bvemiyOeUI
	 W4v8y7osq25AGL3kW77uPTm8h2BPjdTr8zkMC0XLSOI+3b/yqWOWZaKUNPWVoXrBk6
	 sm8wHG/KPIpp6eLXjDO9y9jlGTvUTFoCkuVRAszZxrD9uGu2hpS2G2dwW7d7bgu29p
	 EFnmnGYM0fQiooLwMSLXdvgqkF5FdbxJADdJGtxJyjdHbHG9Xc50kzyXT2RaI10Xcd
	 u3o/er4ImIvCQ==
Content-Type: multipart/mixed; boundary="===============7845476690454596425=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <cc821da4486a325d55ca172c85a4f7c1822cf60e30725fd80181f19a42e5623d@mail.kernel.org>
In-Reply-To: <20260309131635.302424-2-mahe.tardy@gmail.com>
References: <20260309131635.302424-2-mahe.tardy@gmail.com>
Subject: Re: [RFC PATCH bpf-next 1/4] bpf: Add netpoll kfuncs for sending UDP packets
From: bot+bpf-ci@kernel.org
To: mahe.tardy@gmail.com,bpf@vger.kernel.org
Cc: andrew+netdev@lunn.ch,davem@davemloft.net,edumazet@google.com,kuba@kernel.org,pabeni@redhat.com,martin.lau@linux.dev,daniel@iogearbox.net,john.fastabend@gmail.com,ast@kernel.org,andrii@kernel.org,eddyz87@gmail.com,song@kernel.org,mahe.tardy@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon,  9 Mar 2026 13:57:19 +0000 (UTC)

--===============7845476690454596425==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/net/core/bpf_netpoll.c b/net/core/bpf_netpoll.c
> new file mode 100644
> index 000000000000..1d01d5f43ee1
> --- /dev/null
> +++ b/net/core/bpf_netpoll.c

[ ... ]

> +/**
> + * bpf_netpoll_send_udp() - Send a UDP packet via netpoll.
> + * @bnp:	The BPF netpoll context. Must be an RCU-protected pointer.
> + * @data:	Pointer to the data to send.
> + * @data__sz:	Size of the data to send (max 1460 bytes).
> + *
> + * Sends a UDP packet using the netpoll infrastructure. Can be called
> + * from any context (process, softirq, hardirq).
> + *
> + * Return: 0 on success, negative errno on error.
> + */

Is the return value documentation here complete?  Tracing the call
chain through netpoll_send_udp() -> netpoll_send_skb() ->
__netpoll_send_skb(), the latter initializes its return value as
NET_XMIT_DROP (which is 1) and returns it when the device is not
running or not present:

net/core/netpoll.c:__netpoll_send_skb() {
    netdev_tx_t ret = NET_XMIT_DROP;
    ...
    if (!npinfo || !netif_running(dev) || !netif_device_present(dev)) {
        dev_kfree_skb_irq(skb);
        goto out;
    }
    ...
    ret = NETDEV_TX_OK;
out:
    ...
    return ret;
}

That positive 1 propagates back through netpoll_send_udp() which
casts it to int and returns it unchanged.

A BPF program following the documented contract and checking
ret < 0 for errors would silently miss the case where the packet
was dropped because the device went down.  Should the comment
document this, or should the return value be normalized to a
negative errno before returning to the caller?

> +__bpf_kfunc int bpf_netpoll_send_udp(struct bpf_netpoll *bnp,
> +				     const void *data, u32 data__sz)
> +{
> +	unsigned long flags;
> +	int ret;
> +
> +	if (data__sz > BPF_NETPOLL_MAX_UDP_CHUNK)
> +		return -E2BIG;
> +
> +	local_irq_save(flags);
> +	ret = netpoll_send_udp(&bnp->np, data, data__sz);
> +	local_irq_restore(flags);
> +
> +	return ret;
> +}

---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/22855649225
--===============7845476690454596425==--
