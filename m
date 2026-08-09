Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E9212C534
	for <bpf@vger.kernel.org>; Sun,  9 Aug 2026 15:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786288636; cv=none; b=qWec1eAq9h6lXKjRXfV2J+s/J5wM6/pyA08n+5bYeRcNtqjv5GjuspDHS5Dt91is9iewYhyz9g3rNJzBnkzhL0Zmw9MAZ648sARrngTXjQHZRXN8MrGCahf6woScpts6e/ROLlCxpW8SFYG1xID+RO7InB5F3vbpuixLd7gD8kE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786288636; c=relaxed/simple;
	bh=jM9rr4XbYDiZ8tGqnIo9NO6lpR4xJv9hMZq03Z60bTU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jMA97+UPSK/WshUa+LY5SAAXRYMU0g6dTyE5+48d1vithEo3FpwZ9jaSVAOWOKs/hJg5rSAlO5XLvh5r/jh0XxBzIzy3Ikr3m2mhl9CC2YDkPHS3+ANNl+SEb4Qw6YV5CxYaw9M23h2PWeBlg43T0vqC0M9OASLtM2oPLcPBvV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WpIi0wG2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WpIi0wG2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 790681F000E9;
	Sun,  9 Aug 2026 15:17:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786288635;
	bh=tG/0KRp8Tva2HOu6PgI8oxu+VcVKsqX0M5cJPebzkRQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WpIi0wG2ILucKjCqgdAqfrR6yj/I+mNJHJjCkx7ibiB5S7kqK+sKpcJzyTuy+KwS8
	 UieGfqw4/Y98iSmtUCbQbqEljKrUqtHJYs5UlllAMDc1UZrwhx22O1q+Cctr0ihZLE
	 eIdnhBxs2eyAtON43GTlSxpVtyDatzSnebrNoKq61CNZGOTeLEfqJ8JGvNxOxE632B
	 yfZRbzcnhkVdM+7Zm4iBl+SfoHV/v7v7yOYbahE+t5YPu0CS6qFXviTe3htF30HVAz
	 BpR5n0Ahs07Eh8rR+cGyZL6+e5rXj+D1bblXTaZLRJEJwQSZUjG3CFTfL25HdXWhyZ
	 yJvBiCXHPfeCQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 09/13] selftests/bpf: Add tracing_multi bpf
 prog attach failure tests
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leon Hwang" <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260809150111.45000-10-leon.hwang@linux.dev>
References: <20260809150111.45000-1-leon.hwang@linux.dev>
 <20260809150111.45000-10-leon.hwang@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 09 Aug 2026 15:17:14 +0000
Message-Id: <20260809151715.790681F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Build failure due to undefined symbol `libbpf_find_prog_btf_id`.
--

--- Patch [9]: [PATCH bpf-next 09/13] selftests/bpf: Add tracing_multi bpf =
prog attach failure tests ---
commit c3b104cf9a90f8ddf11f23d2944ad76004fb3150
Author: Leon Hwang <leon.hwang@linux.dev>

selftests/bpf: Add tracing_multi bpf prog attach failure tests

This patch adds tests for tracing_multi BPF program attach failures,
covering both libbpf and kernel failure modes.

> diff --git a/tools/testing/selftests/bpf/prog_tests/tracing_multi.c b/too=
ls/testing/selftests/bpf/prog_tests/tracing_multi.c
> index 5ecb751af9be7..5cf11707eaf89 100644
> --- a/tools/testing/selftests/bpf/prog_tests/tracing_multi.c
> +++ b/tools/testing/selftests/bpf/prog_tests/tracing_multi.c
[ ... ]
> +	/* fail#4 (kernel) duplicate target through different fds */
> +	token_fd =3D bpf_object__token_fd(skel->obj);
> +	token_fd =3D token_fd < 0 ? 0 : token_fd;
> +	target_id =3D libbpf_find_prog_btf_id("target_1", fds[0], token_fd);

[Severity: Low]
Does this code compile successfully? libbpf_find_prog_btf_id is an
internal static function in libbpf, so calling it directly from selftests
seems like it would cause an implicit function declaration and undefined
reference linker error during the build.

> +	if (!ASSERT_GT(target_id, 0, "target_1_btf_id"))
> +		goto cleanup;
> +
> +	dup_fd =3D dup(fds[0]);
> +	if (!ASSERT_GE(dup_fd, 0, "dup_target_fd"))
> +		goto cleanup;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260809150111.4500=
0-1-leon.hwang@linux.dev?part=3D9
