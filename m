Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 625183BA24E
	for <bpf@vger.kernel.org>; Thu, 11 Jun 2026 12:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781182419; cv=none; b=PWmBcsCq0n0fgcCBp991cbPLashzebd0oGPvRmY+kwaa+5LX3CqXTLTYaRko7YznDeSc9Bhyu8M4b7g6MUljUzMfiCdehcfALGnlPZ4t5EH7dQtJaf+7H0Cd//GysitVRyBxhvTd1qcTgV146CrARJJiQ/HiNTIr+z3AMBDH0Hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781182419; c=relaxed/simple;
	bh=xe33OjRJ31yRlDzYAGzErlNddpCQA9aul2/O0t5h0tM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=H+Mrfw4c46TIUCWs96QeKdtX9Ln4tEbeWCVSm9by4LOCDrLeWvglm+4wTf85a06/xdj6OuZPNnDFtOhfQ6ZxxNDOWvVOOjKhPf5plQ3hIk0Enl+Ayb0a1bUJPVakSwk7S+5VcoNlGRJEveQ7UuusYQAfCnl3LqOOivRjgU0SZa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nuFeCFWN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nuFeCFWN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 277F91F00893;
	Thu, 11 Jun 2026 12:53:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781182418;
	bh=qtQHCIu7KmqigFVs07xy+HLjKPMG3HCp195Jq8jcnQo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nuFeCFWN7GRppVDpeucuHWk5I8ZDmaCUWe59yNr0nI2bhZfx6ei1JWCez62JrQqtW
	 /L11vE1lnZOGU/L62D2N5zdJ+fQqY9fjT4dIOgBbdO6sxVYYPkPf0U/mJl6d04stKE
	 qLdxmMgJh4z3GqPeM53t5WBEGzBruatqz2T13E6oe1OSaepTUwnDCkDBMiWPgbbV1J
	 UZTxCthNmrY32cWYCeoPoshyUrcuFoWCg+tkPbSbEByZ1VjUipxiYJ2iPKy5/jjCQ5
	 zygL4+IakmkKZ/TkLPodo5xrHAMG4/4lK3VYROdKXspFN6XWny+i2cAwbjynGTF3JG
	 odSIcgpCPFOYw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf v2 5/7] sockmap: Fix use-after-free in
 udp_bpf_recvmsg()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiayuan Chen" <jiayuan.chen@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260611123538.156005-6-jiayuan.chen@linux.dev>
References: <20260611123538.156005-6-jiayuan.chen@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 11 Jun 2026 12:53:37 +0000
Message-Id: <20260611125338.277F91F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Critical] The addition of `lock_sock(sk)` creates a D-state deadlock and=
 an unkillable spin loop if a packet is queued to `psock->ingress_skb` but =
cannot be converted due to memory limits.

Pre-existing issues:
- [High] Delegating to `sk_udp_recvmsg` on a blocking socket can cause a pe=
rmanent hang if BPF programs redirect incoming packets to `psock`.
--

commit 8b4a0fe8904c1ee85231827ded90d15006435b9c
Author: Kuniyuki Iwashima <kuniyu@google.com>

sockmap: Fix use-after-free in udp_bpf_recvmsg()

This patch aims to fix a use-after-free in sk_msg_recvmsg reported by syzbo=
t.
It adds lock_sock serialization around sk_msg_recvmsg in udp_bpf_recvmsg
to prevent multiple threads from concurrently touching the same sk_msg.

Link: https://lore.kernel.org/netdev/69922ac9.a70a0220.2c38d7.00e0.GAE@goog=
le.com/

> diff --git a/net/ipv4/udp_bpf.c b/net/ipv4/udp_bpf.c
> index 9f33b07b14813..ad57c4c9eaab6 100644
> --- a/net/ipv4/udp_bpf.c
> +++ b/net/ipv4/udp_bpf.c

[ ... ]

> @@ -79,6 +81,7 @@ static int udp_bpf_recvmsg(struct sock *sk, struct msgh=
dr *msg, size_t len,
>  		goto out;
>  	}
> =20
> +	lock_sock(sk);
>  msg_bytes_ready:
>  	copied =3D sk_msg_recvmsg(sk, psock, msg, len, flags);
>  	if (!copied) {
> @@ -90,11 +93,17 @@ static int udp_bpf_recvmsg(struct sock *sk, struct ms=
ghdr *msg, size_t len,
>  		if (data) {
>  			if (psock_has_data(psock))
>  				goto msg_bytes_ready;

[Severity: Critical]
Does this new locking introduce a potential unkillable spin loop under memo=
ry
pressure?

If sk_receive_queue fills up and hits the sk_rcvbuf limit, and a BPF program
redirects a packet to psock (placing it in ingress_skb), the backlog work
might fail to move it to ingress_msg with -EAGAIN due to the memory limits.

When recvmsg is called, it acquires lock_sock here, and sk_msg_recvmsg
returns 0 since ingress_msg is empty.

Then udp_msg_wait_data checks udp_msg_has_data. Since there is data
in ingress_skb, it immediately returns 1 without releasing lock_sock:

	ret =3D udp_msg_has_data(sk, psock);
	if (!ret) {
		release_sock(sk);
		...

Then back in udp_bpf_recvmsg, we hit the code above. Because
psock_has_data is true, it jumps back to msg_bytes_ready.

The lock is never released, and we never read from sk_receive_queue, so the
memory limit is never resolved. Could the syscall spin indefinitely holding
lock_sock, causing any other threads attempting to operate on the socket
to hang in D-state?

> +
> +			release_sock(sk);
> +
>  			ret =3D sk_udp_recvmsg(sk, msg, len, flags);
>  			goto out;
>  		}

[Severity: High]
This isn't a bug introduced by this patch, but could delegating to
sk_udp_recvmsg here result in a permanent hang for blocking sockets?

When psock_has_data is false, this code (and similar code at the start of
udp_bpf_recvmsg) delegates to sk_udp_recvmsg. For a blocking socket,
sk_udp_recvmsg will sleep waiting for data exclusively on sk_receive_queue.

If a packet arrives later and a BPF verdict program redirects it to the
socket's psock (meaning it goes to psock->ingress_skb or ingress_msg
instead of sk_receive_queue), the socket wait queue is awoken.

However, sk_udp_recvmsg will only check sk_receive_queue, find it empty,
and immediately go back to sleep.

Will this result in the syscall ignoring valid data successfully queued in
psock and hanging indefinitely?

>  		copied =3D -EAGAIN;
>  	}
> +
> +	release_sock(sk);
> +
>  	ret =3D copied;
>  out:
>  	sk_psock_put(sk, psock);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260611123538.1560=
05-1-jiayuan.chen@linux.dev?part=3D5
