Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AD573806C1
	for <bpf@vger.kernel.org>; Fri, 17 Apr 2026 07:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776411835; cv=none; b=eaC+wm0vQFPGd5Gg/DXVqNSDgRwOo81NQAEZ2vnBd86JK5WFrKmHO+ze3gTtt6dC08feGB1FSXeuvrzcElWHE9EN4GjNZA9SZ3KCPFx+6rKfX+6V6udKF+gxAb8j6rqLcSQascRwOu6ZtAPaRQyVmsoq5YqG6pzqAIWeazdbKKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776411835; c=relaxed/simple;
	bh=HPVraUh1JoVP651IBRGx+S2UHOpsA3idB5Bb/pekxIg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pbu8l8wyH6ibMvCtv3csspzZxMLCLg39IWLIuKg1XCa5giYKz5HPZSaKlNFpg7U4CInctPjnS54cyBaF4PJhIOMVNhRvauh4lPt5Y+f0L4XBGWT4fwwe81gDQaauQaKmbDG/35FcdqCgDR7IN+UUP8TgVWffd56nKJo/Vi7Y+A8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OVnAmW+3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OVnAmW+3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D843BC19425;
	Fri, 17 Apr 2026 07:43:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776411834;
	bh=HPVraUh1JoVP651IBRGx+S2UHOpsA3idB5Bb/pekxIg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=OVnAmW+3SqjU9eG9t9agsceN5BU3N2bYiYlj8VbDmXgli/mSr6m1lVKXgn7Pv1pG+
	 IQOdcgs0BpfXyqvOpsdgarmuSwR8dv6HN+zxsEtYbjj/UvVd/fnq4an5o9JSHS9oGz
	 N5UMfT163vfuRsJYrB4YEUtRPbZhFGvSf0luhmTmMNuJ3IY2uJ/890YYMuISp+rv6a
	 ss4N2LLzoy8hqMN3pTxz/qK16F5MbUpAR7H1d6ZP23dz86NGnnXkqGpQsRGNcsfmt6
	 gnSIN54Q8fsbn1w1uMxG/5r48bJwlHJ+3s6/UuXbZncSpRFja9mgu/X7MymOG8wQI/
	 zMOfjQyUs5l0A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] bpf: crypto: reject unterminated type and algorithm
 names
Reply-To: sashiko@lists.linux.dev
To: "Pengpeng Hou" <pengpeng@iscas.ac.cn>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260417073128.91029-1-pengpeng@iscas.ac.cn>
References: <20260417073128.91029-1-pengpeng@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 17 Apr 2026 07:43:53 +0000
Message-Id: <20260417074353.D843BC19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Sashiko AI review found 1 potential issue(s):
- [Critical] In-place validation of `struct bpf_crypto_params` is vulnerabl=
e to Time-of-Check to Time-of-Use (TOCTOU) race conditions, allowing bypass=
ing of bounds checks and leading to NULL pointer dereferences and out-of-bo=
unds reads.
--

commit 3ccfc91c2a01e60f8c9cc4188d35f3073228f1db
Author: Pengpeng Hou <pengpeng@iscas.ac.cn>

bpf: crypto: reject unterminated type and algorithm names

This commit attempts to fix out-of-bounds reads by adding string length che=
cks
for the type and algo fields in bpf_crypto_ctx_create(). It returns -EINVAL=
 if
the strings are not NUL-terminated.

> diff --git a/kernel/bpf/crypto.c b/kernel/bpf/crypto.c
> --- a/kernel/bpf/crypto.c
> +++ b/kernel/bpf/crypto.c
[ ... ]
> @@ -155,6 +155,12 @@ bpf_crypto_ctx_create(const struct bpf_crypto_params=
 *params, u32 params__sz,
>  		return NULL;
>  	}
> =20
> +	if (strnlen(params->type, sizeof(params->type)) =3D=3D sizeof(params->t=
ype) ||
> +	    strnlen(params->algo, sizeof(params->algo)) =3D=3D sizeof(params->a=
lgo)) {

Is there a potential time-of-check to time-of-use race condition here?
If the params pointer refers to a BPF map value, user space or other CPUs
could concurrently modify the map data.

Could the NUL terminator be overwritten immediately after these strnlen()
checks pass, causing downstream consumers like bpf_crypto_get_type() to sti=
ll
read out-of-bounds?

> +		*err =3D -EINVAL;
> +		return NULL;
> +	}
> +
>  	type =3D bpf_crypto_get_type(params->type);

Looking at the rest of bpf_crypto_ctx_create() in the original code, the sa=
me
in-place validation pattern appears to affect other fields:

kernel/bpf/crypto.c:bpf_crypto_ctx_create() {
    ...
    if (!!params->authsize ^ !!type->setauthsize) {
        ...
    }
    ...
    if (params->authsize) {
        *err =3D type->setauthsize(ctx->tfm, params->authsize);
    ...
}

If type->setauthsize is NULL, and params->authsize is initially 0, the XOR
check passes. If params->authsize is concurrently modified to a non-zero
value right after, does the later if (params->authsize) condition evaluate
to true and dereference a NULL pointer?

Similarly, params->key_len is validated against sizeof(params->key):

kernel/bpf/crypto.c:bpf_crypto_ctx_create() {
    ...
    if (!params->key_len || params->key_len > sizeof(params->key)) {
        ...
    }
    ...
    *err =3D type->setkey(ctx->tfm, params->key, params->key_len);
    ...
}

Could a concurrent modification to params->key_len after the check lead to =
an
out-of-bounds read in type->setkey()?

Should the entire struct bpf_crypto_params be copied to a local stack buffer
before any validation is performed to prevent these races?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260417073128.9102=
9-1-pengpeng@iscas.ac.cn?part=3D1
