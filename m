Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00D5A380FF2
	for <bpf@vger.kernel.org>; Tue, 29 Sep 2026 08:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790671784; cv=none; b=AV/oGg9ZHrheW3jqTDxnePPP+LXjvx65QjJBN2gkPgvMNfHumKqNMa4n8PRTtz4PS/WbhgGj7jRNWFAowobmskR2beEGa4Ql/UdeFJT7XDC7BSBB/mFy4hc6NBhJEInJBL52Gv0gbUXrmg0aYqT1xmH5/Bc0S9cRAQduW3OlLMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790671784; c=relaxed/simple;
	bh=SJUx1RmhLvMGYE0lUd7x/432WN37+I1YQLrXPKPU4ss=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=reuPWTqZqjmhtczGRcYp94xmnJ5NB4gJHAzvQbJoXa3mJ+faX+oATUBC21iIxeNxtbmyRpzfKNXGJJUtS2V5BTt8JueF7J5cXlkhZ39xLF0oEgVJSXtsgn+11NAnVix0vaUGjMw9wiqxEHKe0J1fsm7jh3AJB79ygIc2KHcUWYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UzP7L2sT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UzP7L2sT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEBD01F00893;
	Tue, 29 Sep 2026 08:49:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790671774;
	bh=RSunYOxrqtRKS90uQnKvUTOE6TKl2R3pzgcsXlr6jT8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UzP7L2sTWTjEW0OhwsyANL6O/kEgcaqbp1zu1fsOCXc29GLeoFA9+g5oD5imAwV+0
	 tuiqEDypVOQg0nVqJJUbisi+d5RxGKc8DkEvKi7XlSJN+yXPOOZCFkjbjpzOlHVfA4
	 ga/vrvWt3+g7yY5rmAlMabu0JleJkiBdqx4rYA08yIJ3D2CilVKXDYFCZ4WTHOzJPX
	 u4IlRg7zkaGitw68jpbQKOT60oop1OuZuioKzy9tWnYwuul9ObSW23w/PtFe4dFgQZ
	 PkcgTAMOepTjMPFZOEWn1LWPv16dFbnB0yIz4ISIcWy5jbZvXzSCcJdOv95LL9juCC
	 XB9/jeo5Se5gA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 1/2] bpf, sockmap: Fix udp_bpf_recvmsg()
 spinning on backlog-only ingress
Reply-To: sashiko-reviews@lists.linux.dev
To: chenyuan_fl@163.com
Cc: bpf@vger.kernel.org
In-Reply-To: <20260929083447.558818-2-chenyuan_fl@163.com>
References: <20260929083447.558818-1-chenyuan_fl@163.com>
 <20260929083447.558818-2-chenyuan_fl@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 08:49:33 +0000
Message-Id: <20260929084933.BEBD01F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] bpf, sockmap: udp_bpf_recvmsg deadlocks on data in ingress_skb
--

commit 4b047bd002c9028eba9dda4d7ee00341f2525fa3
Author: Yuan Chen <chenyuan@kylinos.cn>

bpf, sockmap: Fix udp_bpf_recvmsg() spinning on backlog-only ingress
   =20
udp_bpf_recvmsg() re-arms its msg_bytes_ready loop whenever psock_has_data()
is true, but that predicate also covers an skb parked in psock->ingress_skb.
This commit changes it to re-arm only on !sk_psock_queue_empty(psock).

> diff --git a/net/ipv4/udp_bpf.c b/net/ipv4/udp_bpf.c
> index ad57c4c9eaab6..8aca9fb893349 100644
> --- a/net/ipv4/udp_bpf.c
> +++ b/net/ipv4/udp_bpf.c
> @@ -91,7 +91,7 @@ static int udp_bpf_recvmsg(struct sock *sk, struct msgh=
dr *msg, size_t len,
>  		timeo =3D sock_rcvtimeo(sk, flags & MSG_DONTWAIT);
>  		data =3D udp_msg_wait_data(sk, psock, timeo);
>  		if (data) {
> -			if (psock_has_data(psock))
> +			if (!sk_psock_queue_empty(psock))
>  				goto msg_bytes_ready;
> =20
>  			release_sock(sk);

[Severity: High]
Does this introduce a deadlock when data is parked in ingress_skb?

If a BPF program redirects UDP data into a socket's ingress_skb,
udp_msg_wait_data() will return 1 immediately because it relies on
udp_msg_has_data(), which evaluates to true when ingress_skb has data.

With this patch, the execution then strictly checks sk_psock_queue_empty().
Because this function only evaluates ingress_msg, it will return true when
ingress_msg is empty. This causes the if condition to evaluate to false,
routing the code to sk_udp_recvmsg():

    release_sock(sk);
    ret =3D sk_udp_recvmsg(sk, msg, len, flags);
    goto out;

When sk_udp_recvmsg() is called, it eventually sleeps in __skb_recv_udp()
waiting for data in sk_receive_queue. It completely ignores data parked in
the BPF ingress_msg queue.=20

When the backlog workqueue eventually moves the data to ingress_msg and wak=
es
the socket, __skb_recv_udp() will ignore ingress_msg, find sk_receive_queue
still empty, and go back to sleep indefinitely.=20

Could this cause the receiving thread to hang permanently in recv(), leading
to a denial of service?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929083447.5588=
18-1-chenyuan_fl@163.com?part=3D1
