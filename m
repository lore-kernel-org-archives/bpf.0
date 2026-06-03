Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA2AE43DA4F
	for <bpf@vger.kernel.org>; Wed,  3 Jun 2026 09:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780480328; cv=none; b=tYOaMtLGvHnekCeOyseUYklIb2qC8MrrGRrMjVORgnCA7KqqXTpB+Xy6OJk4tkDli4i50qLp2SoQOFUWnGjdLwT6XMx01DSXz+b0Y1nQ+r42Gdw5d/5SLBzcYe7XbbPnmhS8uO9+Lb6xtxwE5mojweol4wvGJcqEJYRMkWNFZ+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780480328; c=relaxed/simple;
	bh=uJq/CXERTulo75CMfp1b5fPsCsPrsRBdwXdbdYOPz6k=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jtLZdScSPoG9Gf8cB+pIFlBkdX7xMVQ5MO9Y1H5kmyPlJ34clIm1RhYry8KuAveIVrRbJoIM6huHrQUx+LwZO3upHgyFQNNn66QZ4qU6lllEjeoH7IxzKSDRTdQhiOA3Juiki92arCOujg/Ocyf210uSCIZ9q7OOHiPrtS6bbfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TA33BZWN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TA33BZWN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25A651F0089B;
	Wed,  3 Jun 2026 09:52:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780480327;
	bh=dW8Z1Vx/WKAcWnsVdgPCTxFkpdJhuB3ZdYePCA3Pw0U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TA33BZWNICr8VP/UmQMBZCOMtb/SWQtHU0Y6P0J47q7Mm60m1UX+c+7a/3T72DOC1
	 PGv1HjRfUGV2L76++RXHTjI+O+N6ousxcamFYernenUrhctpeIySCwWPJmV8x0tfTM
	 YT1h/8WZhdydiSqNBWM8q8PdM8hhxCa8bjJH4+5KZuB9W/Owi2+C10tW6HE0Qg64t3
	 miZX6g6qnIsnyqydxRqmjCBrgaTWxponaIdfiTT0lHdR83hE2UAoez6JSYxhV1oB5y
	 pyBNk3aapAjD4JUVwI9zFOnG7o6ECHjq4i3lMiahDk0t5ppbFavnwpcSgBO4RY0ZlN
	 NR+B+X+2jf/xA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next] selftests/bpf: add test for arena vma split
 and fork rejection
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ruslan Valiyev" <linuxoid@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260603094428.2597058-1-linuxoid@gmail.com>
References: <20260603094428.2597058-1-linuxoid@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 03 Jun 2026 09:52:06 +0000
Message-Id: <20260603095207.25A651F0089B@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Multi-line comments do not follow the BPF subsystem style guide.
--

commit 68912cf41a7e5ee9f6445ed2bc4cecbbb14bad14
Author: Ruslan Valiyev <linuxoid@gmail.com>

selftests/bpf: add test for arena vma split and fork rejection

This commit adds a selftest to verify that an arena map's mmap()ed VMA
cannot be split with a partial munmap() or inherited across fork().

> diff --git a/tools/testing/selftests/bpf/prog_tests/arena_fork.c b/tools/=
testing/selftests/bpf/prog_tests/arena_fork.c
> new file mode 100644
> index 0000000000000..f3d5218c9e071
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/arena_fork.c
> @@ -0,0 +1,58 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <test_progs.h>
> +#include <errno.h>
> +#include <sys/mman.h>
> +#include <sys/wait.h>
> +
> +/* Regression test for commit 4fddde2a732d ("bpf: Fix use-after-free in
> + * arena_vm_close on fork"): an arena VMA must reject a splitting munmap=
()
> + * (.may_split) and must not be inherited across fork() (VM_DONTCOPY). On
> + * an unfixed kernel both operations succeed.
> + */

[Severity: Low]
This isn't a bug, but does this multi-line comment format follow the BPF
subsystem style? The subsystem guidelines state that multi-line comments
should have the opening /* on its own line.

[ ... ]

> +	/* A split of the arena VMA must be rejected (.may_split). */
> +	ret =3D munmap((char *)area + ps, ps);
> +	err =3D errno;
> +	ASSERT_ERR(ret, "split munmap rejected");
> +	ASSERT_EQ(err, EINVAL, "split munmap errno");
> +
> +	/* The child of a fork() must not inherit the arena VMA (VM_DONTCOPY);
> +	 * mincore() returns ENOMEM for the unmapped range.
> +	 */

[Severity: Low]
This isn't a bug, but does this comment also need the opening /* on its own
line to match the preferred BPF multi-line comment style?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260603094428.2597=
058-1-linuxoid@gmail.com?part=3D1
