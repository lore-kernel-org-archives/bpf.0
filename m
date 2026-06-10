Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FFD421C9EA
	for <bpf@vger.kernel.org>; Wed, 10 Jun 2026 02:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781060353; cv=none; b=Nyrp/xi33aaL8dQZF3BASnM8zEn4QPNlNwJ9Nl6nrbFeKqTBNbqe2ozg1usuec26d39JM+BSBb2HLkCB2uD/ZuLRzgvMqNG9sI2ToQ+wEG2k0bv7PW31zG02uaIQiQTpFanx6Bh3FWm2JU4ES3Q/mQPNNE94ojChF9Bh+cAnzak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781060353; c=relaxed/simple;
	bh=UA4JhVkWYy8XwLmgG0LyX86/HvLKaMZ6/MpOLr7rf1Y=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=k6uPvIOy0zQ6VWFaclvmEFqrRlT4j1wP0eiTuKayu2s26tIBJmocPZuqY482QlcjcYg0MSjAqsKP7RLUZyA9VC27z1yR0OGO/8UMIDJoCRe3jukIqRpD6xYdzBn9J7FZpE3rydjX/su4z4/o/+gJk67rIh6tpgGR68p46PfrmoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BzQV3mfC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BzQV3mfC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E7E71F00893;
	Wed, 10 Jun 2026 02:59:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781060346;
	bh=ViR04EA7hz+qYNdcWdf/s6YzXUUdDuAR4NgI1JT4AXk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BzQV3mfCV9jN/oGr5HTgdsfbX9oDNIeQLEkZDdT6Lv0393KCIfZaZzrnFd3O/sgz1
	 ZQGAoo7GHJWhmqjCpjZ3WUECO0i8qG+QySXqh7Wqb4C39rBZwIS3p1GxI3mDVwxhSH
	 GZ+bSdwKQq+Ow24MzdScQOuvrApIfKh8P7IGcV6B17ObivftYzoaKw4zMmSJTrOHvt
	 mm2S96CiNKQ1Gj90C8AH4BmgOv2FgOugNIGbtiI/ad/iF0AHCkgvznFo12khDYxZvN
	 z7TXCJXSqfJLxri5oujxmHhrbK4ROo4CfjueCAjuOKOBEBGc86OXCaBEiad4oCzX01
	 D+gKjnJD513Sw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v4] bpf: Fix use-after-free on mm_struct in
 bpf_find_vma()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sanghyun Park" <sanghyun.park.cnu@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260610024637.343364-1-sanghyun.park.cnu@gmail.com>
References: <20260610024637.343364-1-sanghyun.park.cnu@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 10 Jun 2026 02:59:05 +0000
Message-Id: <20260610025906.3E7E71F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] bpf_find_vma() traverses the VMA tree of an external mm_struct (fr=
om a foreign task) without checking check_stable_address_space(mm).
--

commit f5292fedb813b822dd4346a72223c8122c445d8e
Author: Sanghyun Park <sanghyun.park.cnu@gmail.com>

bpf: Fix use-after-free on mm_struct in bpf_find_vma()

This commit prevents a use-after-free on the mm_struct of foreign tasks by
pinning it under task->alloc_lock and releasing it with mmput_async(). It
also uses spin_trylock() to ensure the BPF context does not block.

> diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
> index e791ae065c39b..77f90b887bf1e 100644
> --- a/kernel/bpf/task_iter.c
> +++ b/kernel/bpf/task_iter.c

[ ... ]

> @@ -765,14 +775,38 @@ BPF_CALL_5(bpf_find_vma, struct task_struct *, task=
, u64, start,

[ ... ]

>  	irq_work_busy =3D bpf_mmap_unlock_get_irq_work(&work);
> =20
> -	if (irq_work_busy || !mmap_read_trylock(mm))
> -		return -EBUSY;
> +	if (irq_work_busy || !mmap_read_trylock(mm)) {
> +		ret =3D -EBUSY;
> +		goto out;
> +	}
> =20
>  	vma =3D find_vma(mm, start);
> =20
>  	if (vma && vma->vm_start <=3D start && vma->vm_end > start) {

[Severity: High]
This is a pre-existing issue, but should bpf_find_vma() call
check_stable_address_space() on the mm_struct before calling find_vma()?

When inspecting a foreign task, the mm_struct could be flagged with
MMF_UNSTABLE if it was subject to an OOM reap or a dup_mmap() failure. In
this state, the maple tree can contain XA_ZERO_ENTRY markers.

If find_vma() returns one of these markers, does the subsequent check
using vma->vm_start dereference an internal integer value and cause a
kernel panic?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260610024637.3433=
64-1-sanghyun.park.cnu@gmail.com?part=3D1
