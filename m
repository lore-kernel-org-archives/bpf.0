Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40C2E223DE7
	for <bpf@vger.kernel.org>; Wed, 22 Apr 2026 22:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776895528; cv=none; b=LulVJ/mkzYGc7Yly6dWinFbhPRyBwt7roDvyIK3cfgDmhzB27kpQmMst/Phpaapej9hpiJugDDElr8dgklTZ1tg9QSWzZvQdZ5uETBn0J1daQvSkI70fIIISHUGn0dOuNSzUI00FwEnnddyGY5HPzcAyxNz0CDd3+rmsWNpau7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776895528; c=relaxed/simple;
	bh=u9kfH2bbAUtMhePNCpvGigccnbDCJuBRA3baUxwOVEU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fYo3Cv1O+vPpPMn/ll0yZFYSwQIHcQdJU6v35OkaS44OqFPPbU17ogerLNxh21QJA53LEAXcZbZHCPADK0wmg1YE9UfpEHwcwCr5w0mTliLMtNq8VpIilw4E7kHuaV3Mni931VpP1dX1azvpLovT97SMedNdFmp3cfALm3foBTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NnPgK3uR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NnPgK3uR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1FA4C19425;
	Wed, 22 Apr 2026 22:05:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776895527;
	bh=u9kfH2bbAUtMhePNCpvGigccnbDCJuBRA3baUxwOVEU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=NnPgK3uRKho2uOJl5yO7YCIkcMdoXGUZKLOvSWfL12SZFv1Ls02TaW3/nZ5YFi9N+
	 NGQbyRLnhm9DTaqKIMfAjH1+C0GzFPeKBY0tkaZfkllX7tknuN0xymjz7GmvJbzvtD
	 kdJ8pOMqpoPEBvW/prjioFCCj63R/w3qUNVanDNABI8+uORF5IJpPKTY+mZFJ/XK33
	 OgkwJd4qI6k5Ggjzr8z/7zwhaX1SP0Wl618VqsMO4BslxMtYMxU5ugbPJYoMng+uN4
	 5ghFo2Pjl4HJr/U9Okjtg8+sCggweeX4y8q4qI2olIdfDw9J2I2a+wwVIfGGiLW7bb
	 V2EK2fGePU8Kw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] selftests/bpf: replace bpf_probe_read_kernel with
 direct access
Reply-To: sashiko@lists.linux.dev
To: "Suchit Karunakaran" <suchitkarunakaran@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260422183757.15069-1-suchitkarunakaran@gmail.com>
References: <20260422183757.15069-1-suchitkarunakaran@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 Apr 2026 22:05:27 +0000
Message-Id: <20260422220527.C1FA4C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Sashiko AI review found 2 potential issue(s):
- [Medium] BPF verifier will reject the program due to an out-of-bounds acc=
ess on `SOCK_INODE(sk)->i_ino`.
- [Medium] BPF verifier will reject the program due to an invalid memory ac=
cess when dereferencing `nlk->groups[0]`.
--

commit 9c46bc4644e11b2c3abf78e2ca55fa73028182f8
Author: Suchit Karunakaran <suchitkarunakaran@gmail.com>

selftests/bpf: replace bpf_probe_read_kernel with direct access

Use direct field access instead of bpf_probe_read_kernel() for
nlk->groups[0] and inode->i_ino, and clean up related code.

> diff --git a/tools/testing/selftests/bpf/progs/bpf_iter_netlink.c b/tools=
/testing/selftests/bpf/progs/bpf_iter_netlink.c
> index 00b2ceae81fb0..5930bf8899d21 100644
> --- a/tools/testing/selftests/bpf/progs/bpf_iter_netlink.c
> +++ b/tools/testing/selftests/bpf/progs/bpf_iter_netlink.c
> @@ -35,10 +34,7 @@ int dump_netlink(struct bpf_iter__netlink *ctx)
>  	if (!nlk->groups)  {
>  		group =3D 0;
>  	} else {
> -		/* FIXME: temporary use bpf_probe_read_kernel here, needs
> -		 * verifier support to do direct access.
> -		 */
> -		bpf_probe_read_kernel(&group, sizeof(group), &nlk->groups[0]);
> +		group =3D nlk->groups[0];

Does the verifier know the size of the memory pointed to by nlk->groups?

The groups field in struct netlink_sock is a pointer to a scalar
(unsigned long *). When the BPF program reads this pointer from the struct,
the verifier tracks it as a generic pointer with a known memory size of 0,
because BTF does not encode the size of the dynamically allocated array.

Will the direct array access nlk->groups[0] be rejected by the verifier's
bounds check?

>  	}
>  	BPF_SEQ_PRINTF(seq, "%-10u %08x %-8d %-8d %-5d %-8d ",
>  		       nlk->portid, (u32)group,
> @@ -50,12 +46,7 @@ int dump_netlink(struct bpf_iter__netlink *ctx)
>  	if (!sk) {
>  		ino =3D 0;
>  	} else {
> -		/* FIXME: container_of inside SOCK_INODE has a forced
> -		 * type conversion, and direct access cannot be used
> -		 * with current verifier.
> -		 */
> -		inode =3D SOCK_INODE(sk);
> -		bpf_probe_read_kernel(&ino, sizeof(ino), &inode->i_ino);
> +		ino =3D SOCK_INODE(sk)->i_ino;

Will the verifier reject this as an out-of-bounds access?

The SOCK_INODE macro relies on container_of to cast a struct socket pointer
to a struct socket_alloc. In BPF, standard C pointer arithmetic does not
implicitly update the BTF type tracked by the verifier.

The verifier will still track sk as a struct socket, but with an added
offset. Because vfs_inode sits after socket in struct socket_alloc,
accessing i_ino uses an offset that exceeds sizeof(struct socket).

Should this use bpf_core_cast(sk, struct socket_alloc) to update the
verifier's tracked BTF type instead?

>  	}
>  	BPF_SEQ_PRINTF(seq, "%-8u %-8lu\n", s->sk_drops.counter, ino);
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260422183757.1506=
9-1-suchitkarunakaran@gmail.com?part=3D1
