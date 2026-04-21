Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E9AA37CD4C
	for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 18:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776794975; cv=none; b=gCipKxtK4WboKTm8j7toEr+r9GjxADxEhxseoRNSfaGxYgJCiPLN/YfBSQtwHzu4H3KcxgSSixzysM+iw+F8pkiJmKrB+++AjtDtiDO/VS0ka8k+Sb7dxGLrH7y2W6QZNT6wqq++Y0HuuiAm6QIs+dM6EuhWQUiSiuc51p8g0fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776794975; c=relaxed/simple;
	bh=8dxZvT81dw5mL6kYssZUDmNIpqDjtKl+OZs+E+PycPc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=i1OTzWX5sjWCiJahZMI9DcTFfpCW4O9jgIDuUjnWE98yx7e7wbOWjWoUMoT7Maqd9dCdGcULq6sGjrFUsAXGAocMbo9agHseqCSBHa/Cw7SnQ1n4IdWoEfmvDPjudye8TqGro46DFHat7J6VGaTvfpnn8iV+c++drIRjQ4uH6Qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hk+JWmXv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hk+JWmXv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAADBC2BCB0;
	Tue, 21 Apr 2026 18:09:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776794974;
	bh=8dxZvT81dw5mL6kYssZUDmNIpqDjtKl+OZs+E+PycPc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=hk+JWmXvQYn7HO3AfXTTZoQHAYgJoMLsn2zqZJSjjhkJ3zAFV93/LxbEep6foxQMr
	 giPKoeWFGk1t2kDSwEqFyJnzVSPpRhXjQ8qM7Gz+q6PI7JxMkoRpHmIZL2xNZ1MY0E
	 nBYr7hwLxQB+maTo2qqdy+redqlcBFhdbj1VNvue8CBdRhpYT66X8k8Y5iqcdd0qLL
	 SR4QestmeYWWaln24V18uEMEmVomuNhj1YuUWZxPvA77H4UnYSvOqMOzJyE/p9a81R
	 5k+li5l6++u4x/pDufQB8YgfYUaLLn17z0htw0NUiwaiuRKrx09xY/HqHJWK+wAcCP
	 OQiPLq2uYrwFg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf] bpf: Fix NULL pointer dereference in
 bpf_sk_storage_clone and diag paths
Reply-To: sashiko@lists.linux.dev
To: "Weiming Shi" <bestswngs@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260420161432.3919396-2-bestswngs@gmail.com>
References: <20260420161432.3919396-2-bestswngs@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Apr 2026 18:09:34 +0000
Message-Id: <20260421180934.AAADBC2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Sashiko AI review found 1 potential issue(s):
- [Medium] diag_get() returns -EMSGSIZE when a storage element is concurren=
tly deleted, which falsely signals an out-of-buffer condition to the netlin=
k subsystem.
--

commit 522b6760e7969af1ad0bb15843d5c06084d686f7
Author: Weiming Shi <bestswngs@gmail.com>

bpf: Fix NULL pointer dereference in bpf_sk_storage_clone and diag paths

This commit addresses a NULL pointer dereference in bpf_sk_storage_clone
and diagnostic paths by adding checks for when a concurrent RCU reader
observes a storage element with a NULL smap.

> diff --git a/net/core/bpf_sk_storage.c b/net/core/bpf_sk_storage.c
> index 14eb7812bda4a..3e21d79558154 100644
> --- a/net/core/bpf_sk_storage.c
> +++ b/net/core/bpf_sk_storage.c

[ ... ]

> @@ -544,6 +544,8 @@ static int diag_get(struct bpf_local_storage_data *sd=
ata, struct sk_buff *skb)
>  		return -EMSGSIZE;
> =20
>  	smap =3D rcu_dereference(sdata->smap);
> +	if (!smap)
> +		goto errout;

When a storage element is concurrently deleted, smap evaluates to NULL here
and goes to errout, which returns -EMSGSIZE.

In netlink diagnostics, doesn't -EMSGSIZE specifically signal an
out-of-buffer condition?

Could propagating -EMSGSIZE for a concurrently deleted element cause socket
dumps to unnecessarily abort the current message and retry, or cause
exact-match diagnostic queries to falsely fail with an EMSGSIZE error
returned to userspace?

Would it be better to return 0 after cancelling the nested attribute to
gracefully skip the deleted element, or perhaps pass the already validated
smap from the caller directly into diag_get()?

>  	if (nla_put_u32(skb, SK_DIAG_BPF_STORAGE_MAP_ID, smap->map.id))
>  		goto errout;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260420161432.3919=
396-2-bestswngs@gmail.com?part=3D1
