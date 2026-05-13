Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54DC0184
	for <bpf@vger.kernel.org>; Wed, 13 May 2026 22:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778712280; cv=none; b=AwfsJrSmXZC7/Np2TeDIdhyCd/weE1boL0qwwVDQQPSuNBjppbOryJ/GxhSjdC43SPZnEm00Mxr/8OlCk+jo6BHiHp6q7vhWZKoIqSdRW62NxhXGtjAU9kUi3o5MN8pDV595bDa8EbOAQUxKXYUCmjepcFqbR3Sx6Qv60fJ7eI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778712280; c=relaxed/simple;
	bh=TlLb0BIxJcheCmiPd+f2nYp8sYauS/xnnA5yIQHkHPw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=eko/uHMti3AmL2Ucc1RUftR5fy2TlYN7yyEu9lULZds0wtXtz+cSHqCGkWR/jDLCinEaKEj/zbmQO1TA9V9K19Ogikyj0XvapDafoUACl7OKXCv8ekYOOJgp3FbrJ9kb+tDue1QRVoBlCbh04Tairv42wOiNmXO6hPGB3m6Rqhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YP/oMUsI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YP/oMUsI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C75C5C19425;
	Wed, 13 May 2026 22:44:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778712279;
	bh=TlLb0BIxJcheCmiPd+f2nYp8sYauS/xnnA5yIQHkHPw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=YP/oMUsIbb9ccTPiufO1Hq4UUxODryNyu88Tmi/fSDMtSUudSWLvy/R/5A0I+fjdp
	 eef4TqQHC5vLZBfvyyDafoq0OxOCXqBEtzjItw+w+qfR0ddMe8vV7ok9WGPf3fG0Vb
	 wpXUNUvhR4AuucrTcuWjNud6SgxZo/62p/mcoHOxxBB4GyTR577z0t6lEO9y5sf6Cu
	 HQ7vyOEe8nNCRWqUWro05gmPqhxXMwwUQ7zsL1gFRdZszPN9zmtGK0OiyMeFehibMg
	 RFDWtIgBfiAoGdbzg7iDq+hMk7X2BkyFzRYYBwgUUhB/ILPzAFkdU6Fbm+z5P1WDE4
	 +wjF7pxwSmykg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RESEND bpf-next v10 8/8] selftests/bpf: Add test cases
 for bpf_list_del/add/is_first/is_last/empty
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kaitao cheng" <kaitao.cheng@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260512055919.95716-9-kaitao.cheng@linux.dev>
References: <20260512055919.95716-9-kaitao.cheng@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 13 May 2026 22:44:39 +0000
Message-Id: <20260513224439.C75C5C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Latent verifier errors (use-after-release and memory leak) in the n=
egative test `list_add_without_lock_fail`.
--

commit 37523e4b94785be6995dc6c7cf660c200eca4aef
Author: Kaitao Cheng <chengkaitao@kylinos.cn>

selftests/bpf: Add test cases for bpf_list_del/add/is_first/is_last/empty

This commit extends the refcounted_kptr selftests by adding new test cases
for BPF linked list operations. It includes both successful path tests and
negative tests verifying that the verifier correctly rejects operations
made without holding the required spinlock.

> diff --git a/tools/testing/selftests/bpf/progs/refcounted_kptr.c b/tools/=
testing/selftests/bpf/progs/refcounted_kptr.c
> index c847398837ccd..21ae06797b183 100644
> --- a/tools/testing/selftests/bpf/progs/refcounted_kptr.c
> +++ b/tools/testing/selftests/bpf/progs/refcounted_kptr.c

[ ... ]

> +SEC("?tc")
> +__failure __msg("bpf_spin_lock at off=3D32 must be held for bpf_list_hea=
d")
> +long list_add_without_lock_fail(void *ctx)
> +{
> +	struct node_data *n, *prev;
> +
> +	n =3D bpf_obj_new(typeof(*n));
> +	if (!n)
> +		return -1;
> +
> +	prev =3D bpf_obj_new(typeof(*prev));
> +	if (!prev) {
> +		bpf_obj_drop(n);
> +		return -1;
> +	}
> +
> +	/* Error case: add list node without holding lock */
> +	if (bpf_list_add(&head, &n->l, &prev->l)) {
> +		bpf_obj_drop(prev);
> +		bpf_obj_drop(n);

Since bpf_list_add() consumes the newly added node (&n->l), would this
subsequent bpf_obj_drop(n) trigger a use-after-release error in the
verifier if it evaluates past the missing spinlock?

> +		return -2;
> +	}
> +
> +	return 0;

Similarly, prev is an owning reference acquired via bpf_obj_new(), but
bpf_list_add() accepts a non-owning reference for the prev argument. Does
this code leak the prev reference by returning 0 here without calling
bpf_obj_drop(prev)?

While the test correctly fails today due to the missing spinlock as
intended, these latent errors could make the test brittle and cause CI
flakes if the verifier's evaluation order changes in the future.

> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260512055919.9571=
6-1-kaitao.cheng@linux.dev?part=3D8
