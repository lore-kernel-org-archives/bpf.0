Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B2392475E3
	for <bpf@vger.kernel.org>; Sun, 19 Jul 2026 15:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784474230; cv=none; b=Cxw/4AswJ6xn0ZY/0WJe8c6dLUQm+Qe/2FcnvX5Aw1yhz9RSdwoznPGJabbClAO16omXxZwrudmWwaU1XbPRDPV2V2Ak166NnpjQFxt+E4zaFiJchra6Gwd05d7MliWmWtd/5ALYfhJFBb7pOhQ5AzfMCdwChgJs3m6ewgjvJ/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784474230; c=relaxed/simple;
	bh=Lb9J4TclQVhEIpAWWQhCl3lHAlYnFQmA37+QOm3aY5I=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=E8h/sCwvzJ/1u9vMWY5Ta8C0R32SY5vnLIgNdsLBPcradzZQr8w6pSHzpCoqofXVIEiaGlFb3D5zc99oRKInwlgHfzwCXIwBIyR/Wr0+HOXVdNXFTBjHZ+m3QS4ulzkm7PRhWB4Ur6P5MfTiLADpxucrDJdctCHwFLVXwAofuC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z8SloZFd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z8SloZFd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB0451F000E9;
	Sun, 19 Jul 2026 15:17:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784474229;
	bh=vGPsvXh3M582ddgggNN5/PvA4YdPxrJlw+qgSkTBELM=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=Z8SloZFdmLks086qAfjEkgu04MSu2ExRCmw2jtNIcKY5R5S3TaZFE9WkEATfl4ydE
	 B8cBwVO2zLQGVry1fs/8jESvyPAFL1wT0JqmGEs5NfsL/OIsTaKWCXT/2rndIfgXpO
	 uu+3OtZrjW9m7fPn1Ut7HURZTZKKjGUZ6FJ1KItEsa0X+cQ+BC0WVX57i4ttjXvFTF
	 K+4gTgyeZmzpfFCIDK/b+8uIFMMoq/9p+qPYV5ioWCKYRwRyOanMGHG89OVRiS24QZ
	 txtsWHxoOFPzu77Mra/VpONQ1vvIlqtr2a0o6cxuzXghVDwfci4x+0ICTSiuebAP1q
	 n5NecjnPx0Xrw==
Content-Type: multipart/mixed; boundary="===============5425157506032083260=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <3df1d0ba82e7245ddc7d7607f733fd53b8bf5e21e8f9702c5a0160fce4d1889b@mail.kernel.org>
In-Reply-To: <20260719142401.2420111-3-memxor@gmail.com>
References: <20260719142401.2420111-3-memxor@gmail.com>
Subject: Re: [PATCH bpf-next v1 2/2] selftests/bpf: Test duplicate unique fields in nested structs
From: bot+bpf-ci@kernel.org
To: memxor@gmail.com,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,emil@etsalapatis.com,kkd@meta.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Sun, 19 Jul 2026 15:17:08 +0000 (UTC)

--===============5425157506032083260==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> selftests/bpf: Test duplicate unique fields in nested structs
>
>     Add a raw BTF test with a spin lock directly in a struct and another in a
>     nested struct. The duplicate must now be rejected during BTF loading.
>
>     Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

This test exercises the case where a duplicate unique special field
(bpf_spin_lock) is split across a struct and a nested struct, which
before the fix could reach btf_parse_fields() and trip an invariant
WARN_ON_ONCE().

The buggy behaviour was introduced when btf_find_nested_struct() began
recursing into btf_find_struct_field() with a per-level seen_mask, so
uniqueness state was not preserved across nested structs.

The companion fix commit already carries this tag, so should this test
carry the same one so the two are backported together?

  Fixes: 64e8ee814819 ("bpf: look into the types of the fields of a struct type recursively.")


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/29691561692
--===============5425157506032083260==--
