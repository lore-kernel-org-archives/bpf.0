Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2B85209F43
	for <bpf@vger.kernel.org>; Tue, 30 Jun 2026 15:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782831856; cv=none; b=lzHPJyXk1bur8NYJt0j5uYX32VQ//Td23LtR96DT48wBBrpMDbnEKK4LLmd+2k4FMCB7oTIzsm820ybM3LzSTY7yUlXDfsfX0Ksv4w2I3F8RY6X8UWfvgJy2Im/++KJgAkCciCP/wrQewK+H50Kpf3oCVxHu2DmsOhumUQes5Mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782831856; c=relaxed/simple;
	bh=OtKrkWDEmvuo3r8TFhbIuQI1ewQCe5oF+FdWYL+Vxt8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=saWrNL6YsZ9btfyp42IZa4/4NTmwJekTkXKhHs6xM2H8q1DSyh0DgYbuX6GVsykfhpxYET/+aoHPtDnccGEqM+hI8vLOMgN9r+WNpdJuVo4jNmpE5OZ/EkpMjuzgYGL1JvM1r36ZEG5O30RrzghOzhPhEdPFFhc17dIsKtwLC2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X9nv0PxD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X9nv0PxD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D2B21F000E9;
	Tue, 30 Jun 2026 15:04:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782831855;
	bh=OtKrkWDEmvuo3r8TFhbIuQI1ewQCe5oF+FdWYL+Vxt8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=X9nv0PxDJZ8++qr+YaewWxoC6+pPbImcZPUZiHL2D1EL0JDcEJ7tDQPWtCYqVWUfn
	 5O1rG/Aog0xQciVzeuqNeOdw+1iMBkCM3Ll4mxt5m0dQux5JSYPhf1wCsEZbP5FBjT
	 e7Qv8wBv4dPu34b3buixw0IcMO4b0NTnH5f+XQOoSCr6XCstHV+DLHcwey1Js6IBTr
	 16iFKwt34ZBTlvcYydAfh6RBqQlCqFXTqaeNbrjqleaC0w8yTSmcj9m/pV242mEDbB
	 IOb4WJRauWIxoTDz5l3Cog+b25jx1wRgsqeuDKA4KjiZtgOSWzYruw892QUv5tmeHt
	 /bmYDRfWoBJJA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v4 2/2] selftests/bpf: drop
 tc/xdp/flow_dissector/socket_filter sockmap mutation tests
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sechang Lim" <rhkrqnwk98@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260630145410.3648099-3-rhkrqnwk98@gmail.com>
References: <20260630145410.3648099-1-rhkrqnwk98@gmail.com>
 <20260630145410.3648099-3-rhkrqnwk98@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 30 Jun 2026 15:04:14 +0000
Message-Id: <20260630150414.7D2B21F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Stale references and dangling links to the deleted file `test_sockm=
ap_update.c` in BPF documentation.
--

commit ce41dd2fcf64eeb09dfffd2596dead28c4261583
Author: Sechang Lim <rhkrqnwk98@gmail.com>

selftests/bpf: drop tc/xdp/flow_dissector/socket_filter sockmap mutation te=
sts

The commit removes test cases where tc, xdp, socket_filter, and
flow_dissector programs attempt to update or delete a sockmap, as these
operations are no longer allowed. It also removes the now unused
test_sockmap_update.c and freplace_cls_redirect.c files.

> diff --git a/tools/testing/selftests/bpf/progs/test_sockmap_update.c b/to=
ols/testing/selftests/bpf/progs/test_sockmap_update.c
> deleted file mode 100644
> index 6d64ea536e3d8..0000000000000
> --- a/tools/testing/selftests/bpf/progs/test_sockmap_update.c
> +++ /dev/null
> @@ -1,48 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0

[Severity: Low]
Should we also update the BPF documentation to remove references to this
deleted file?

Documentation/bpf/map_sockmap.rst appears to reference it as an
example of kernel BPF sockmap usage, and includes a hyperlink target
that will now be broken:

.. _`tools/testing/selftests/bpf/progs/test_sockmap_update.c`: https://git.=
kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/testing/s=
elftests/bpf/progs/test_sockmap_update.c

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260630145410.3648=
099-1-rhkrqnwk98@gmail.com?part=3D2
