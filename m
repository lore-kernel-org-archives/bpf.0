Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794998405;
	b=cFDWVkoOAJKmj6bPhIPbG8ZyqmgS3hNPpA/nu3CmxMKI03um7GDdyNCOP1eTkMoZ5Kdq
	 a1miDH6UYIizPD4XJnFg0OVTyUJayT+laJdd8RMDN1fSrOi2IgfcfdIID8hAJwiDyMc8y
	 GsT4+FCK2Uq+JeopqHnw91YV2UDKyIiR0MDfMT0CmZyblIT8Snb4+JZLDxNIN/E3klJYE
	 jXfNPKrifRsWu6TPq0n+Fghv8GQt4oTal1ZK3/By7W1ldcXnJYZHDBt6IsRd8HlLz+Zi6
	 SYiFbvKlrC9XE4sPYahB35DG+8UZER7fYXTixTknDAySJw+erv0MrFnMdZDRi44PCrg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794998405;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=g1G50zB28iYtNxbQC5l03eH5UyoTDEu4PAr5hFzKdjI=;
	b=oprpffiCwoHGv8eB/2Or9Gj1MhB14wCnKd96xuIjvT/3cwnZYmBkZNkNu8Yv3EKxBCVV
	 OMKfBYPudWINgeuYyvKhiVR87W7ufpsuM/9g9lZ5IYTJ8glJ7MtPNtk/s3SjRw4AJeIBk
	 1AK/omNzoAypzYFWj3joxEhDrHnnOoKHtwEpqc9kJfG/tElQGwNwW1KwH1oZZHIvlHtBT
	 blF6NTBpF+WcKVeua3Cg/7Jbd36yKJjbqkJBZsLxXHc4x5EfibmA2nxfAsjQTUrIzgBRt
	 IAedTDfrULVtjW7EM9XT1Zv5t2ZsS5KlqAwMxr+gXRb3Fsy5is3By5sxx41KucMLqnA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nWE91an8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6E7E606A32F
	for <bpf@vger.kernel.org>; Wed, 18 Nov 2026 10:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nWE91an8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13CC31F000D0;
	Wed, 18 Nov 2026 10:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794998405;
	bh=g1G50zB28iYtNxbQC5l03eH5UyoTDEu4PAr5hFzKdjI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nWE91an8rv3xHR5gb+N8ipPHBBkXQr7mIo+hdU60AcjGTQWhSynZ9lFumHqpSYBtC
	 Jm5UHqhtuTCnxgBxAaJLfH7CybPo7AFjfbuJLlQIRwBCHezqkZ5E5dkEflkydNabmv
	 TA62q2yRfjPlDzj+md6wFnjjqJfzOp8p+A31f1ayeOaZ1aUC2MO5Ea4dwWOfi3UaIG
	 rWxSkXwR7plSo3cB5Ct/lRZxkK99bgfeq7beWQsiF6Ge9bQI04XPvJHormE5yVspwl
	 T9vMAcurC0S2kGA07+AmW89P4+T4mxqmFu/0sKN7zfUA3/+KZXVBxFXi158LuAoISM
	 2Sl6rBbjKIEIQ==
Message-ID: <sashiko-outbox-220728@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 6.18.y 1/1] bpf: Reject NULL arguments to four
 kfuncs
Reply-To: sashiko-reviews@lists.linux.dev
To: asatsuyu.liu@gmail.com
Cc: bpf@vger.kernel.org
In-Reply-To: <20261118101748.2335815-2-asatsuyu.liu@gmail.com>
References: <20261118101748.2335815-1-asatsuyu.liu@gmail.com>
 <20261118101748.2335815-2-asatsuyu.liu@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 10:40:04 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] bpf: redundant is_kfunc_arg_ignore() check in check_kfunc_args()
--

commit ddaa1152b113559b77a39d01057a7c747399f22a
Author: Yi Liu <asatsuyu.liu@gmail.com>

bpf: Reject NULL arguments to four kfuncs

This commit marks bpf_copy_from_user_str(), bpf_copy_from_user_task_str(),
bpf_crypto_ctx_create(), and bpf_rbtree_remove() with KF_TRUSTED_ARGS so
the verifier rejects NULL or nullable pointer arguments to them.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index b89a5d717e422..aac687b81b84c 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -13494,6 +13494,7 @@ static int check_kfunc_args(struct bpf_verifier_e=
nv *env, struct bpf_kfunc_call_
>  		}
> =20
>  		if ((is_kfunc_trusted_args(meta) || is_kfunc_rcu(meta)) &&
> +		    !is_kfunc_arg_ignore(meta->btf, &args[i]) &&
>  		    (register_is_null(reg) || type_may_be_null(reg->type)) &&
>  			!is_kfunc_arg_nullable(meta->btf, &args[i])) {
>  			verbose(env, "Possibly NULL pointer passed to trusted arg%d\n", i);

[Severity: Low]
Is this new is_kfunc_arg_ignore() check reachable?  check_kfunc_args()
already skips __ign parameters at the start of the argument loop (where btf
is meta->btf):

kernel/bpf/verifier.c:check_kfunc_args() {
	...
	for (i =3D 0; i < nargs; i++) {
		...
		if (is_kfunc_arg_ignore(btf, &args[i]))
			continue;
	...
}

Because __ign arguments never reach the NULL-pointer check, both this hunk
and the commit message paragraph describing it appear unnecessary.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118101748.2335=
815-1-asatsuyu.liu@gmail.com?part=3D1
