Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07D3E39733E
	for <bpf@vger.kernel.org>; Tue, 21 Jul 2026 22:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784674514; cv=none; b=EdpdnibvTWMVhUh3EBlIYkOjPBmv5rpHENoau7kZ8A/PXiy6KKi/cvYInX7ESoM37SXphVmztDXSmaCDd8L8c5ectiBo9/j5p9kbQzZqb8ZxRwtu7pH187KDJ4pxpeyUpkylTMVX76qf2XvkRaOgFrTOe4EGp5YOlOAfErVJBIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784674514; c=relaxed/simple;
	bh=BH9A11gE5WDpEpF1RlKabOs2LWx2nWMnQ15sI7lfLTQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VWav9glzDIyd+9VsZaZk/6FoxoGz1vrpBi43icqG7kgHVwxK7IzwoQBLyHez1NIpFlsQfZXrn4cCiz+5hBA+/GqGb0EPGAWvAZmKdZ36vEyHXaU7l8ECFoT6ELf5yohK7ltxlcTg9dBGpqyB7qjwZvjSp+S4HO5hQCL4amCzJ+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DjXgN8W1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DjXgN8W1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9654C1F000E9;
	Tue, 21 Jul 2026 22:55:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784674512;
	bh=oGzLqzOoM3Y3STKMGs+6YyF9D0VntwZeTh0ZJ56PDxM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DjXgN8W19HRWcTmtrAlbdULD4OrdJreezii+NzD4Wy/xlz9mIISsKHfJ2ZVFUnygP
	 txxihYyPlSPVy1PLxCphXCGDTwxWym2Lr6zx++iA24vhRUsLgoK0WMAXUbBEMJpYNC
	 +kBV8tNTixUsRJoR1W9twlfSdcS6demjKjMB4XnAYYSKmBEMN6yInXTBzBNlTfGoRS
	 v/Mpk5oyWfKDmfbkwHg98jUkNrB9X9S2FCRc43hXmvs/WCg6ISoMnNT9ZL+tGPQ47G
	 tE6nePHVDXCNaQE2hxQK5IfhBJlhhujo2I1wS2RCVwwPNdiHBjmv1LSSll6najaE1D
	 6VDfd3eZnMbYg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 1/2] bpf, sockmap: handle spurious
 tcp_msg_wait_data() wakeup
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nnamdi Onyeyiri" <nnamdio@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260721223807.75101-2-nnamdio@gmail.com>
References: <20260721223807.75101-1-nnamdio@gmail.com>
 <20260721223807.75101-2-nnamdio@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Jul 2026 22:55:12 +0000
Message-Id: <20260721225512.9654C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] tcp_bpf_recvmsg_parser() fails to handle unparsed data in sk_recei=
ve_queue, returning premature EAGAIN on blocking sockets.
--

--- Patch [1]: [PATCH v7 1/2] bpf, sockmap: handle spurious tcp_msg_wait_da=
ta() wakeup ---
commit 7468e0f3ba324455b02b600d4c77965cd4caa92c
Author: Nnamdi Onyeyiri <nnamdio@gmail.com>

bpf, sockmap: handle spurious tcp_msg_wait_data() wakeup

This commit addresses spurious wakeups from tcp_msg_wait_data() by looping
back to msg_bytes_ready instead of returning -EAGAIN. It also passes a poin=
ter
for timeo to allow sk_wait_event() to update the remaining timeout.

> diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
> index 8e905b50deadb..87aef99a13792 100644
> --- a/net/ipv4/tcp_bpf.c
> +++ b/net/ipv4/tcp_bpf.c
[ ... ]
> @@ -310,13 +311,15 @@ static int tcp_bpf_recvmsg_parser(struct sock *sk,
>  			goto out;
>  		}
> =20
> -		data =3D tcp_msg_wait_data(sk, psock, timeo);
> +		data =3D tcp_msg_wait_data(sk, psock, &timeo);
>  		if (data < 0) {
>  			copied =3D data;
>  			goto unlock;
>  		}
>  		if (data && !sk_psock_queue_empty(psock))
>  			goto msg_bytes_ready;
> +		if (!data && timeo > 0)
> +			goto msg_bytes_ready;

[Severity: High]
This is a pre-existing issue, but could this return a premature -EAGAIN on a
blocking socket when data is waiting to be parsed?

If data arrives and is added to sk_receive_queue, but a stream parser requi=
res
more bytes to complete a message (or the parser is deferred to a workqueue),
tcp_msg_wait_data() will return 1.

Because psock->ingress_msg is still empty, both the existing condition:
    if (data && !sk_psock_queue_empty(psock))
and the new condition:
    if (!data && timeo > 0)
will evaluate to false.

Does this mean tcp_bpf_recvmsg_parser() falls through and returns -EAGAIN
instead of continuing to wait for the remaining data to be parsed?

>  		copied =3D -EAGAIN;
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260721223807.7510=
1-1-nnamdio@gmail.com?part=3D1
