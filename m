Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B6C31F98E
	for <bpf@vger.kernel.org>; Thu, 21 May 2026 23:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779406925; cv=none; b=NKoQI9/JMQMO6HR35NWMksY6eoAJS0I4AZQcvA5wL5pOHxfsKyxK2s5UGY0c3Ksi9bh4Iun3zR4eSH0BaW91SlfZutiOtVAcm1k6LPZ/BjDqVIjeOhrVK3Ja1Vw47CpLLCu7opoctF2hdkaopsYtTmlMskzWnvq76+GYA/Gqc+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779406925; c=relaxed/simple;
	bh=safALfY9fftVVm5srsoWwQmQJ4DdcBqFLAo9s/+0TKA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SJeowFbBmPIg5UiA/1cwTuCIrK+UcH1ABJvew7mdJQiS3Q5ALlCm+oJdGnMyk6nHupwzIEjHeNph0Y6yPexKyIQrHVq8iBYZ1+izkbRWCRbBubeQAkoDaUNGNc8GJjrPdyeLRabBOJz+KwZMp0OrUmizp2SAnC3fXYjPigKhz1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ksx8G5pT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ksx8G5pT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9431E1F00A3B;
	Thu, 21 May 2026 23:42:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779406920;
	bh=jgW6evO69ovwWsz9q4BQEWdaRsLqhPLrqecKt5NidZw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ksx8G5pTfCI58HJAf5ZQdPZxLkTmknNHS6/CSyukXjHDnZNKn0ipwaBjjxdN89koH
	 /LgpR+FLzu1aSrZBPxM5XshMC9mK5u4NGnMlcp4VSwr2+7PzmMsnPDRZzQBAx6WqnN
	 /V9twlG3KtjYZI9ASitwUnz4v0y5L70G+T51GCS+1iwDRa96M6DOXad9RWcTn6rAGz
	 EyUdOEYLpzkzwtGgjAEpJhFPltGlCREtH7979TAM2S/5yPDbS6aokMASzmHdG2oGWS
	 8sdRXhtpqKh8GdE2V8mhByddelsmI9enKgBo5xk+A3XRBODMWoiJSTMNOidZ3KSq8G
	 fDxKWzQaUd2qg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v6 2/3] bpf: Avoid faultable build ID reads
 under mm locks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ihor Solodrai" <ihor.solodrai@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260521225022.2695755-3-ihor.solodrai@linux.dev>
References: <20260521225022.2695755-3-ihor.solodrai@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 21 May 2026 23:41:59 +0000
Message-Id: <20260521234200.9431E1F00A3B@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] The lock fallback path unconditionally fails when CONFIG_PER_VMA_L=
OCK is not set, silently breaking build ID parsing in sleepable BPF program=
s.
- [Medium] Incorrect check for file-backed VMAs using `vma->vm_file` instea=
d of `!vma_is_anonymous(vma)`.
--

commit 84d83effb87030cad9aaab2d51c0df334f8c48df
Author: Ihor Solodrai <ihor.solodrai@linux.dev>

bpf: Avoid faultable build ID reads under mm locks

This commit avoids calling sleepable build ID parsing while holding mmap_lo=
ck
or a per-VMA read lock to prevent blocking. It introduces a new function to
resolve VMAs and acquire references, dropping the VMA lock before parsing.

Link: https://lore.kernel.org/all/20251218005818.614819-1-shakeel.butt@linu=
x.dev/
Link: https://lore.kernel.org/all/20260128183232.2854138-1-andrii@kernel.or=
g/
Link: https://lore.kernel.org/bpf/2895ecd8-df1e-4cc0-b9f9-aef893dc2360@linu=
x.dev/

> diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
> --- a/kernel/bpf/stackmap.c
> +++ b/kernel/bpf/stackmap.c
[ ... ]
> @@ -174,6 +175,107 @@ static inline void stack_map_build_id_set_valid(str=
uct bpf_stack_build_id *id,
[ ... ]
> +static struct vm_area_struct *stack_map_lock_vma(struct stack_map_vma_lo=
ck *lock, unsigned long ip)
> +{
> +	struct mm_struct *mm =3D lock->mm;
> +	struct vm_area_struct *vma;
> +
> +	if (WARN_ON_ONCE(!mm))
> +		return NULL;
> +
> +	vma =3D lock_vma_under_rcu(mm, ip);
> +	if (vma)
> +		goto vma_locked;
> +
> +	/*
> +	 * Taking mmap_read_lock() is unsafe here, because the caller
> +	 * BPF program might already hold it, causing a deadlock.
> +	 */
> +	if (!mmap_read_trylock(mm))
> +		return NULL;
> +
> +	vma =3D vma_lookup(mm, ip);
> +	if (!vma) {
> +		mmap_read_unlock(mm);
> +		return NULL;
> +	}
> +
> +#ifdef CONFIG_PER_VMA_LOCK
> +	if (!vma_start_read_locked(vma)) {
> +		mmap_read_unlock(mm);
> +		return NULL;
> +	}
> +	mmap_read_unlock(mm);
> +#else
> +	mmap_read_unlock(mm);
> +	return NULL;
> +#endif

[Severity: High]
Does this unconditionally break sleepable build ID parsing when
CONFIG_PER_VMA_LOCK is not enabled?

Because lock_vma_under_rcu() returns NULL without per-VMA locks, the code
falls back to mmap_read_trylock() and vma_lookup(). However, when it reaches
the #else block here, it always unlocks and returns NULL, causing the
sleepable path to fail and degrade to raw IPs.

Prior to this patch, mmap_read_trylock() was used successfully regardless
of CONFIG_PER_VMA_LOCK. Could we retain the mmap_read_lock protected fallba=
ck
for kernels without per-VMA locks, or is there another way to keep this
feature working?

> +vma_locked:
> +	lock->vma_locked =3D true;
> +	lock->vma =3D vma;
> +	return vma;
> +}
[ ... ]
> +static void stack_map_get_build_id_offset_sleepable(struct bpf_stack_bui=
ld_id *id_offs,
> +						    u32 trace_nr)
> +{
> +	struct mm_struct *mm =3D current->mm;
> +	struct stack_map_vma_lock lock =3D {
> +		.vma_locked =3D false,
> +		.vma =3D NULL,
> +		.mm =3D mm,
> +	};
> +	struct vm_area_struct *vma;
> +	struct file *file;
> +	u64 offset;
> +	u64 ip;
> +
> +	for (u32 i =3D 0; i < trace_nr; i++) {
> +		ip =3D READ_ONCE(id_offs[i].ip);
> +
> +		vma =3D stack_map_lock_vma(&lock, ip);
> +		if (!vma || !vma->vm_file) {

[Severity: Medium]
Is it possible for anonymous VMAs (such as private mappings of /dev/zero) to
bypass this check?

According to the MM guidelines, vma->vm_file can be non-NULL even for
anonymous VMAs, which might lead to taking unnecessary file references and
calling build_id_parse_file() on them.

Should this use !vma_is_anonymous(vma) instead of checking vma->vm_file
directly to ensure we only process properly file-backed VMAs?

> +			stack_map_build_id_set_ip(&id_offs[i]);
> +			stack_map_unlock_vma(&lock);
> +			continue;
> +		}
> +
> +		file =3D get_file(vma->vm_file);
> +		offset =3D stack_map_build_id_offset(vma->vm_pgoff, vma->vm_start, ip);
> +		stack_map_unlock_vma(&lock);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260521225022.2695=
755-1-ihor.solodrai@linux.dev?part=3D2
