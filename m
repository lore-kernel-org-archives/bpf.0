Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEFF93B1BD
	for <bpf@vger.kernel.org>; Tue, 28 Apr 2026 00:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777335138; cv=none; b=uAHaXbwUmIxyxDU1iDtQ4oKTLnA7ipYwoB0FXS+L7cHBZDa+sLdjICnUjdP+JL9Cp0gU27oPm83n8e6ZakXlJJD0j4U2Q0SdrVNy4WvzpnY4sMANxYHtNONgrjpea6rPcoNAvN7Ng6wwiM8UfXXRN4yREizQRuA+uuiTaLF58f4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777335138; c=relaxed/simple;
	bh=R2Ib8cHAyexDBlKWFOqwbeCPw+CRxn1PImkWFy87MBs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pVQL8VUdFkFa16a68w8e0YEDIn5sLZUJMyeiCoKrTRcftBBAKfCTU14JvKdJgb+EEQVpz/MBP1u+NUJemijcdvWuwUlj0TtkdDaQ26Dmsmrp/TgQCcG3FvzSXFLQsmAGGt6/ccDQPqKBBRvDeTBcKsgbRgl7u5g1gLm5HfxUzRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SotWh6Jd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SotWh6Jd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20C32C19425;
	Tue, 28 Apr 2026 00:12:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777335137;
	bh=R2Ib8cHAyexDBlKWFOqwbeCPw+CRxn1PImkWFy87MBs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=SotWh6JdqCEK4ePXLJGAhUDLVrIzzhtugfhqj4FbO1s5HsR06uVPVsrRz+00IoDXL
	 YRXkOEvxlYT28fJncI8V7X4joJ63fgs25q8wqaZrGSGWqe9WzmXwhkWjso/kEOwwGa
	 FHiTjjR4e28xSpq5ibBhMMf1GMoL7L1LgYvAJ1wDrfKfbtOPQQHKfBP6Hgr9/BGHEz
	 yDpvpMcYacAjxPmZ1wJbbqWHQZzBZIn+w46DQWgzBwwIsj/3yyQdftlEutM+hmaQBE
	 s3lRqz9nY1NtY1dS4J2kGdDvN7OccYYPU9pRWWaSOVuPWJWG8FJdbQb81g550EXYS9
	 c+LXT7aX+IjLA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v3 1/2] net: add missing syncookie statistics
 for BPF custom syncookies
Reply-To: sashiko@lists.linux.dev
To: "Jiayuan Chen" <jiayuan.chen@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260427001006.14465-2-jiayuan.chen@linux.dev>
References: <20260427001006.14465-2-jiayuan.chen@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Apr 2026 00:12:16 +0000
Message-Id: <20260428001217.20C32C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Sashiko AI review found 1 potential issue(s):
- [Critical] Calling reqsk_free(req) leaves a dangling pointer in skb->sk, =
leading to a Use-After-Free and Double-Free during SKB destruction.
--

commit 8129f2cd328fc83b2ec7df7d84c626dcf9b375be
Author: Jiayuan Chen <jiayuan.chen@linux.dev>

net: add missing syncookie statistics for BPF custom syncookies

This commit updates BPF custom syncookie handling to use CONFIG_BPF_SYSCALL
instead of CONFIG_BPF, and adds a net parameter to cookie_bpf_check().
It also adds missing SNMP statistics for SYN cookie failures and receptions
in the BPF path.

> diff --git a/net/ipv4/syncookies.c b/net/ipv4/syncookies.c
> index df479277fb80..9251d4a15c88 100644
> --- a/net/ipv4/syncookies.c
> +++ b/net/ipv4/syncookies.c
[ ... ]
> @@ -305,6 +306,9 @@ struct request_sock *cookie_bpf_check(struct sock *sk=
, struct sk_buff *skb)
>  	if (cookie_tcp_reqsk_init(sk, skb, req)) {
>  		reqsk_free(req);
>  		req =3D NULL;
> +		__NET_INC_STATS(net, LINUX_MIB_SYNCOOKIESFAILED);

This isn't a bug introduced by this patch, but does freeing the request soc=
ket
here leave a dangling pointer in skb->sk that leads to a use-after-free and
double-free during SKB destruction?

When BPF assigns a syncookie request_sock to skb->sk via
bpf_sk_assign_tcp_reqsk(), it sets the SKB's destructor to sock_pfree().

In tcp_v4_rcv(), skb_steal_sock() extracts the listener socket but
intentionally leaves skb->sk and skb->destructor intact for syncookie
request sockets.

If cookie_tcp_reqsk_init() fails, reqsk_free() is called, but skb->sk is not
cleared. When cookie_bpf_check() returns NULL, the caller drops the SKB via
kfree_skb().

During SKB destruction, sock_pfree(skb) is invoked, which reads the already
freed memory via sk->sk_state and then calls reqsk_free() a second time,
causing a double-free.

> +	} else {
> +		__NET_INC_STATS(net, LINUX_MIB_SYNCOOKIESRECV);
>  	}
> =20
>  	return req;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260427001006.1446=
5-1-jiayuan.chen@linux.dev?part=3D1
