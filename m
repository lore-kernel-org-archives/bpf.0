Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B105A37CD5F
	for <bpf@vger.kernel.org>; Wed, 22 Apr 2026 16:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776876183; cv=none; b=NyqO+/GiqhC8yCktO71WelRCRCh514ozjzcB4mOYo+saiQa2lrAqP9xLKCc7zqqXzHrvvWc02ra0m2mGCV1llVtqKTw+0rkG+4UxRSSuEwTzP6YUxhDw9JDgX6yyRDdDVzRyDAs0vmI5K4k/IJodcw4g6kYYD9WW+cDquPcp0nY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776876183; c=relaxed/simple;
	bh=4Mun20cppC5tI3fTqM5+TZPhHzhTUNNEfAuoZOSH8Hs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Ul8Hhwt9UgFAN5coTVkyq27DolWT1NmVpg06OeiEUOajVOJ+z3OftGaHmyLVdRdRREsng+RolckCmt9cp4/EjziB/BSITHr89/4cpmw5Mc51wYc+9iwfdle4olSmNLLQT0/1IshmleJXXCW3w8pcLsEVX9jFvN5gmMzJ26iZhQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qwy7479Z; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qwy7479Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 475A8C19425;
	Wed, 22 Apr 2026 16:43:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776876183;
	bh=4Mun20cppC5tI3fTqM5+TZPhHzhTUNNEfAuoZOSH8Hs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=qwy7479ZoidlCElQjcfZEe4J1pXbxjcxtf46w3Q8iOUyQ1Fj4S3u9jLn4dfFv/PRk
	 xxLANDLcWUsRZsBTCmfi7SDclGTp/ZuVHfk3lCY8lVZlnHYH4PLMph2EJlJhcol6OV
	 X8LGhF7ryP71JQ4nXjFydgak1OrWTTDDF2a7oL9cJfIazMExvNfDHBc2m2QgCxhUKK
	 NHODGxC3j6ke3cvztF2Fuie0id2xx9AfvIQ7DxCaZMQ+9737lOiBuJDcvnSLipnviu
	 fLPgUt1gWjPSp4yCHjj9OboHm3R2r5kfcDNslWrBpmE0uXpw3v9MIcZKmLosftNFTW
	 kpmOeXr6X3TBw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf v2] bpf: Fix NULL pointer dereference in
 bpf_sk_storage_clone and diag paths
Reply-To: sashiko@lists.linux.dev
To: "Weiming Shi" <bestswngs@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260421155024.997077-2-bestswngs@gmail.com>
References: <20260421155024.997077-2-bestswngs@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 Apr 2026 16:43:02 +0000
Message-Id: <20260422164303.475A8C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Sashiko AI review found 1 potential issue(s):
- [High] The NULL pointer dereference fix in the diag paths is incomplete d=
ue to a Time-Of-Check to Time-Of-Use (TOCTOU) race condition in `diag_get()=
`.
--

commit 89ba4092c0928afed16ec4db32d2b5ffaa88889b
Author: Weiming Shi <bestswngs@gmail.com>

bpf: Fix NULL pointer dereference in bpf_sk_storage_clone and diag paths

This commit adds NULL checks for the storage map pointer in
bpf_sk_storage_clone() and bpf_sk_storage_diag_put_all() to prevent a
NULL pointer dereference when racing with a concurrent storage map removal.

> diff --git a/net/core/bpf_sk_storage.c b/net/core/bpf_sk_storage.c
> index 14eb7812bda4a..b2cd2b0292cb6 100644
> --- a/net/core/bpf_sk_storage.c
> +++ b/net/core/bpf_sk_storage.c

[ ... ]

> @@ -596,6 +596,8 @@ static int bpf_sk_storage_diag_put_all(struct sock *s=
k, struct sk_buff *skb,
>  	saved_len =3D skb->len;
>  	hlist_for_each_entry_rcu(selem, &sk_storage->list, snode) {
>  		smap =3D rcu_dereference(SDATA(selem)->smap);
> +		if (!smap)
> +			continue;
>  		diag_size +=3D nla_value_size(smap->map.value_size);
> =20
>  		if (nla_stgs && diag_get(SDATA(selem), skb))

Can this still trigger a NULL pointer dereference due to a race condition?

If a concurrent unlinking operation sets the storage map pointer to NULL
after the check above, but before diag_get() executes, it looks like
diag_get() could still read the NULL pointer:

net/core/bpf_sk_storage.c:diag_get() {
    ...
    smap =3D rcu_dereference(sdata->smap);
    if (nla_put_u32(skb, SK_DIAG_BPF_STORAGE_MAP_ID, smap->map.id))
    ...
}

Because rcu_dereference() re-fetches the pointer from memory, it could now
return NULL, leading to a crash on the smap->map.id access.

Would it be safer to pass the already-validated smap pointer directly to
diag_get() as an argument, or add a NULL check inside diag_get() itself?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260421155024.9970=
77-2-bestswngs@gmail.com?part=3D1
