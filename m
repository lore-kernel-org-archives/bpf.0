Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB6053C454E
	for <bpf@vger.kernel.org>; Mon, 15 Jun 2026 09:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781514510; cv=none; b=buG1pRYrjpAKxR5jSACP04otziuedkm3052ehQHjHmRSLiLBjAk8F3MOuGXnht9s2ht9M7R/RIhq+sHVSg0NW05TgcM3eJp6AkWcTeorQrN5tHsaEnxZ5+ZruqKyU81JB9wcsLyJ2tL2DVKKFDa5xfCv3DU3fK1dkoBhO/6c7E4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781514510; c=relaxed/simple;
	bh=R7p6E16k0VNq1ZpHV76mBycnecxb6edNFkj/8svE+to=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WmcCyk5H8SfIV2MSlBB7LOFPYe1AM7TleiSQN6H8U6AS9uyUubAvARROYiaef8sctLLjTbWVmcvA3i0t340Qu/Ed6++l+spHwsd1/eGRQMsNattne7MOdIamKlUW0NjeQa7to5ifiSK/nRxTgEji/CNDf65T9bOxb+qr6swYjJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZemJhi1U; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZemJhi1U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C6CC1F000E9;
	Mon, 15 Jun 2026 09:08:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781514507;
	bh=R7p6E16k0VNq1ZpHV76mBycnecxb6edNFkj/8svE+to=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZemJhi1Un0lVvstr9Y1U9I4Z80jO78+BuV/SCk0Vc1T5uroG0y+2uCCYZJfue9kvK
	 hT8eVgXAAE0zL/E7eNBm5Yc3OjFw1ygotVOW7UwgpPas1PmB6ivCxx9yNloN2C87rm
	 kTqspD23CljL76/FgwRmFFguxg6qk/fS0SW2HcwBLca0HqezK3CLBZgURHK3dKRdAs
	 vt3zEK5+A+USxsBaUtLYIbkCVMgzYGJeHMlDhzWgeoNzHZWQxWXmebyLidmupIQIrc
	 usTYuMjPIhkc9qhh5Xr8fYhxAUdZk9dXPqDHit967ceMGl+68bXERBfMob58Chk0or
	 DA6zuf8Em5TSQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf 2/2] selftests/bpf: Cover rdonly_cast dynptr slice
 lifetime
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nuoqi Gui" <gnq25@mails.tsinghua.edu.cn>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260615-f01-09-rdonly-cast-dynptr-lifetime-v1-2-2dd0a369e153@mails.tsinghua.edu.cn>
References: <20260615-f01-09-rdonly-cast-dynptr-lifetime-v1-2-2dd0a369e153@mails.tsinghua.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 15 Jun 2026 09:08:26 +0000
Message-Id: <20260615090827.0C6CC1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Multi-line comments do not follow the BPF subsystem comment style g=
uidelines. The opening `/*` must be on its own line.
--

commit 23e88c2468fdbcf78bd114cff5b73d79a87a4337
Author: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>

selftests/bpf: Cover rdonly_cast dynptr slice lifetime

This commit adds verifier tests for bpf_rdonly_cast() alias lifetime. It
covers casting a ringbuf dynptr slice, releasing the dynptr, reading through
the cast alias, and stack-overwrite invalidations.

> diff --git a/tools/testing/selftests/bpf/progs/dynptr_fail.c b/tools/test=
ing/selftests/bpf/progs/dynptr_fail.c
> index b62773ce5219b..7ffe55ba28663 100644
> --- a/tools/testing/selftests/bpf/progs/dynptr_fail.c
> +++ b/tools/testing/selftests/bpf/progs/dynptr_fail.c

[ ... ]

> +/* A read-only cast alias from an overwritten dynptr should be invalidat=
ed
> + * even when a clone still holds the underlying reference.
> + */
> +SEC("?raw_tp")
> +__failure __msg("invalid mem access 'scalar'")
> +int dynptr_rdonly_cast_slice_after_overwrite(void *ctx)

[Severity: Low]
This isn't a bug, but does this multi-line comment follow the preferred
BPF subsystem style? The opening /* is typically expected to be on its
own line.

[ ... ]

> +/* A read-only cast alias from a clone should remain valid after overwri=
ting
> + * the original dynptr while the clone still holds the reference.
> + */
> +SEC("?raw_tp")
> +__success
> +int dynptr_rdonly_cast_clone_slice_after_parent_overwrite(void *ctx)

[Severity: Low]
This isn't a bug, but similar to the comment above, should the opening /*
be placed on its own line to match the expected multi-line comment style
for the BPF subsystem?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260615-f01-09-rdo=
nly-cast-dynptr-lifetime-v1-0-2dd0a369e153@mails.tsinghua.edu.cn?part=3D2
