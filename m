Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA5F24334D8
	for <bpf@vger.kernel.org>; Tue, 25 Aug 2026 14:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787668799; cv=none; b=uRREVKGbjeVaW4AN/SEZx7HpYQsO5DHSbvuvmheo2Z2ccMVetSfD8uPROeqWLhRKiZj9CWz0TrsqFem4k/4V9t5AphxJRANbm7vIXDiMg8dlqwjRcj730BoUq3yyFG5pi4vDsCyCucc49NzrwnQwWdM/LVBYXVd7JtsRc/TxiXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787668799; c=relaxed/simple;
	bh=9mqyvlHOIsdG8cbieL0YlbSso/wif7FDYyaThTzQico=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BXSNqYxM/SbyjUy3t4CMvHi3o166UWY/s/AdtOKLhjamqrETrWzGncMRbCbeAqzKXAsKqYMcGh2xEhNHKgLu3vXks31+t1xUcega20BK2QGuHPkaOhd+q8pQmVfAixFeOmKZqbzjYny30nCHLe/lu7jYjdAXqVXbmr6ZmCFwtbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Oq/efxEF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oq/efxEF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6107D1F000E9;
	Tue, 25 Aug 2026 14:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787668797;
	bh=9njeG3JZ2SR4hIdxO+DytuCqMX7BMwMHiKNqg0ROl5Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Oq/efxEFvTxuWIY71jTO1kV+92nJ991J4cJrBa+oJzDMmHqGwvbjFghXAB/dqQKun
	 Vxz2HPIxGuXZdWeT6dn9zhiKW81VPPb6m1sii52vOAwt5aXBzAwUb704bj5ech+BSm
	 fb16+KD2XFJdKv1lrsp3UlGhM5/cPGMyGJXUWqfk2oj8uaVoikVxk9IW8So9vWf97M
	 qR646COJUhdiRK0eYUB8Wj2e93hzAXhmbaGvYllYI5dr9OTw+jyk39E88o+gxGDVPI
	 QBnF+6z5XB3HK2aPYHWJrd9MVVA6NsAp7qq4RHBeGMYzjqhlLfMihvBawCV6/vZdPC
	 jzHfAQqroRB6g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 01/11] bpf: Add a bpf keyring for program
 signature validation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Daniel Borkmann" <daniel@iogearbox.net>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260825142530.1329706-2-daniel@iogearbox.net>
References: <20260825142530.1329706-1-daniel@iogearbox.net>
 <20260825142530.1329706-2-daniel@iogearbox.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 25 Aug 2026 14:39:56 +0000
Message-Id: <20260825143957.6107D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The API constant VERIFY_USE_BPF_KEYRING (3) overlaps with valid =
dynamically assigned user keyring IDs.
--

--- Patch [1]: [PATCH bpf-next v2 01/11] bpf: Add a bpf keyring for program=
 signature validation ---
commit 00a710bc53ef8e389fd6606f84e48db8b5c743d5
Author: Daniel Borkmann <daniel@iogearbox.net>

bpf: Add a bpf keyring for program signature validation

This patch adds a dedicated bpf keyring for validating BPF program signatur=
es,
selected with VERIFY_USE_BPF_KEYRING. It allows userspace to provision keys
during boot before the keyring is restricted and becomes active.

> diff --git a/include/linux/verification.h b/include/linux/verification.h
> index dec7f2beabfd4..1cb59ddda2509 100644
> --- a/include/linux/verification.h
> +++ b/include/linux/verification.h
> @@ -18,6 +18,16 @@
>  #define VERIFY_USE_SECONDARY_KEYRING ((struct key *)1UL)
>  #define VERIFY_USE_PLATFORM_KEYRING  ((struct key *)2UL)
> =20
> +/*
> + * The id of BPF's ".bpf" keyring, reserved from the same space. It is
> + * explicitly not a sentinel like the two above as BPF resolves it to
> + * the keyring itself and passes that, so verify_pkcs7_signature() never
> + * sees this value, and system_keyring_id_check() must keep rejecting it.
> + * Left as a plain integer so that handing it over as @trusted_keys does
> + * not compile.
> + */
> +#define VERIFY_USE_BPF_KEYRING	3
> +
>  static inline int system_keyring_id_check(u64 id)
>  {

[ ... ]

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index e036ae20bf6b9..3be8d51d35ac4 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -21016,10 +21018,17 @@ static int bpf_prog_verify_signature(struct bpf=
_verifier_env *env,
>  	if (!attr->signature_size ||
>  	    attr->signature_size > KMALLOC_MAX_CACHE_SIZE)
>  		return -EINVAL;
> -	if (system_keyring_id_check(attr->keyring_id) =3D=3D 0)
> +	if (attr->keyring_id =3D=3D VERIFY_USE_BPF_KEYRING) {

[Severity: Medium]
Since VERIFY_USE_BPF_KEYRING is defined as 3, does this overlap with valid
dynamically assigned user keyring IDs?

If a user creates a custom keyring and the kernel dynamically assigns it
serial ID 3 (which key_alloc_serial() permits), would this check intercept
attr->keyring_id =3D=3D 3 and use the .bpf keyring instead of the user-prov=
ided
keyring?

> +		key =3D bpf_lookup_keyring();
> +		if (!key) {
> +			verbose(env, "the bpf keyring is empty or has not been restricted\n");
> +			return -ENOKEY;
> +		}
> +	} else if (system_keyring_id_check(attr->keyring_id) =3D=3D 0) {
>  		key =3D bpf_lookup_system_key(attr->keyring_id);
> -	else
> +	} else {
>  		key =3D bpf_lookup_user_key(attr->keyring_id, 0);
> +	}
>  	if (!key) {
>  		verbose(env, "cannot resolve signing keyring with keyring_id %d\n",
>  			attr->keyring_id);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260825142530.1329=
706-1-daniel@iogearbox.net?part=3D1
