Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE7F26290
	for <bpf@vger.kernel.org>; Fri, 22 May 2026 00:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779408798; cv=none; b=TZbYRhj9tw43V+tw+p2bZ+7Fbgm5Leun1ATGA1F2idR3V+/7sVzsSjUiko/04xGAve1r6mnK3GBx1yIwRPNO8qqjl492gctou1PI4/6VbebQ9h14gQe7AZLFUjp6q+EhZNzaDscwt6gO/aQJolQdCFHz/ek6czt7h9fK6MKoDD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779408798; c=relaxed/simple;
	bh=z15zuopjaohhxW6M0z8yg9Qw1IdO4jE0cUcZdDgXpNo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FXsGoE8TX6M1zcEGXJx8tuk/mb1OEdf+ReEibxPSFpcECiSHw5xYUB3uVNfYcjR1L4XxfwWgkaEoxRB6Urf121S4As74fMj2NPp5++1jnLrlXbHtjHzos8OlApCAEkYHUD9jR000xv0AzdXk47qlfhMOe8VFEgqkfzwI+M9+81A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KGlpe4AD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KGlpe4AD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E227C1F00A3D;
	Fri, 22 May 2026 00:13:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779408797;
	bh=wz8HxbY7iMFK6ExmTEZnV2bbXDLeJjyRSo1WOYg4V8E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KGlpe4ADdn3TovX63N6XNqinLE+PbemJcwo2bJnPZnhh7qpn0zu8/ycxzcr014TJF
	 4wx7dlskb1m7PjOpNbqUFEp6/3HN8Kuz3a5ndU46YOWuvCdcx45vCWbuddcykznRHF
	 hTMKvdhFcM9cOA3qIZtJb+jcauzIvo/e9TS+0wBTXN8kOCEL4osRkv8FDPT7JhSslZ
	 3lKoNTHN3pMaFZMOwcZMNWVn9EEp1BlyF+EbpnEzyRLL2MwQDALKc1JTqgD8+ex2cj
	 mGVhbpNEkXfQ/AetceNIAfPhLSySYXz+pHqSEtcbr3cObreLSFTn/6jJaLEtYEKCtx
	 /6aFsHAEG8Oog==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v6 3/3] bpf: Cache build IDs in sleepable
 stackmap path
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ihor Solodrai" <ihor.solodrai@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260521225022.2695755-4-ihor.solodrai@linux.dev>
References: <20260521225022.2695755-4-ihor.solodrai@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 22 May 2026 00:13:16 +0000
Message-Id: <20260522001316.E227C1F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The code incorrectly uses `!vma->vm_file` to determine if a VMA ha=
s a backing file instead of using `vma_is_anonymous()`.
--

commit 064bc7134cce521fa9fe6d8d8e8a26a362f8ccdb
Author: Ihor Solodrai <ihor.solodrai@linux.dev>

bpf: Cache build IDs in sleepable stackmap path

This commit adds caching for the last successfully parsed build ID,
VMA range, and backing file in the sleepable stackmap path to avoid
repeated VMA locking and file parsing.

> diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
> --- a/kernel/bpf/stackmap.c
> +++ b/kernel/bpf/stackmap.c
[ ... ]
> @@ -253,6 +261,17 @@ static void stack_map_get_build_id_offset_sleepable(=
struct bpf_stack_build_id *i
>  	for (u32 i =3D 0; i < trace_nr; i++) {
>  		ip =3D READ_ONCE(id_offs[i].ip);
[ ... ]
>  		vma =3D stack_map_lock_vma(&lock, ip);
>  		if (!vma || !vma->vm_file) {

[Severity: High]
This is a pre-existing issue, but using vma->vm_file as a proxy to check if
a VMA is file-backed or anonymous can be problematic. Anonymous VMAs (like
private mappings of /dev/zero or driver mmaps that call vma_set_anonymous())
can leave vma->vm_file set.

If this code treats such VMAs as standard file-backed VMAs, could
build_id_parse_file() end up invoking kernel_read() on character devices
like TTYs or input devices?=20

This might block indefinitely waiting for input, potentially leading to a
local denial of service in a sleepable BPF tracing program.

Should this check use vma_is_anonymous(vma) to accurately classify the VMA
instead of checking !vma->vm_file?

>  			stack_map_build_id_set_ip(&id_offs[i]);
>  			stack_map_unlock_vma(&lock);
>  			continue;
>  		}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260521225022.2695=
755-1-ihor.solodrai@linux.dev?part=3D3
