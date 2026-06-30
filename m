Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 469BE32D0FC
	for <bpf@vger.kernel.org>; Tue, 30 Jun 2026 03:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782790667; cv=none; b=XT0zX3uDC2Er3PK3oc9jfU5V1o9AOZ0R+g01Q2p43nfKoVxmJHT41MZZtBTCKAS77OfKNcp6OLD2yCDooTJdIOQzBGCAw1UI/zdoZcbTjljb+OLKse6e1IHgMJSmGx6VuFvXuw1OT8Fb4K26OAjeiOQOyh7lIuhMl1XkFd1/HHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782790667; c=relaxed/simple;
	bh=e9y8n3p5vXjWlZT/SbeMDcWgi1cGT63tA4MUsB0TrtQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=paJcdQfAEJ6OK4GjdmUq8mgU6KvLI4cV2JDwcfGFS/uiWteSGndi5UT3W488Stq3s6FPmilznN+SZXHTnsSpnbZv6LTFl8vdGZfejTiEDsqdnowm6eYq/umMuiOLfjO6TrTjovF6BX5ZJXnb64ZNh1oELOJU2SdiZ5MjIud7mOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R28KzKaO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R28KzKaO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B80201F000E9;
	Tue, 30 Jun 2026 03:37:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782790665;
	bh=KjU0e4DgXeqbQ4Pew36cHU0Of4N7HmODVk3dJHzYXbI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=R28KzKaOaBMO5VnWgfXhcQ5NusjMxNTkQfxYup2NGzPnK8KxF1pUBi70+HwndJh+Z
	 Kr1XKixf6vBCPAyr63JhY0Fc5Gm6BbI/5wKD/YIO8CFGgfgSBrL4l9Rcr4SjeQPHp1
	 xXNcGstABz5/RKAXtaKi86kyJcdTYYXr9zJw1MZzIQ6rNBeYJwF//HpIVVATvlgX/8
	 7nX7muoL47bo6QI0kLaXKAuljbYZPnqT4maZPbvZI4QxAX69DROnuQN2fcbJpcmkLh
	 l6cFOiNrVIhidUSg6oJVQPh61lcsK5Cl65jldwfKSatVC4zL3iGUd5PnCgHXU+Ae+7
	 aqMtFEiD7vS9Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v6] bpf: Fix use-after-free on mm_struct in
 bpf_find_vma()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sanghyun Park" <sanghyun.park.cnu@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260630032543.3165720-1-sanghyun.park.cnu@gmail.com>
References: <20260630032543.3165720-1-sanghyun.park.cnu@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 30 Jun 2026 03:37:44 +0000
Message-Id: <20260630033745.B80201F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Pre-existing race condition between concurrent NMIs and HW IRQs le=
ading to a leaked mmap_read_trylock() in bpf_find_vma().
--

commit 4672ecd9d6bd9a98e0de397e206fa5c87190b657
Author: Sanghyun Park <sanghyun.park.cnu@gmail.com>

bpf: Fix use-after-free on mm_struct in bpf_find_vma()
   =20
This commit fixes a use-after-free on mm_struct in bpf_find_vma() by pinning
the mm_struct via task->alloc_lock for foreign tasks. It introduces a trylo=
ck
and mmput_async() path to safely handle the mm lifecycle when interacting
with tasks other than current.

> diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
> index e791ae065c39b..22db3fcedd2fb 100644
> --- a/kernel/bpf/task_iter.c
> +++ b/kernel/bpf/task_iter.c

[ ... ]

> @@ -765,14 +766,38 @@ BPF_CALL_5(bpf_find_vma, struct task_struct *, task=
, u64, start,

[ ... ]

>  	if (!mm)
>  		return -ENOENT;
> =20
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
> @@ -782,6 +807,11 @@ BPF_CALL_5(bpf_find_vma, struct task_struct *, task,=
 u64, start,
>  		ret =3D 0;
>  	}
>  	bpf_mmap_unlock_mm(work, mm);

[Severity: High]
This isn't a bug introduced by this patch, but could a race condition betwe=
en
concurrent NMIs and hardware IRQs leak the mmap read lock here?

If a hardware IRQ calls bpf_find_vma(), it fetches the per-CPU
mmap_unlock_irq_work structure via bpf_mmap_unlock_get_irq_work(). If an NMI
interrupts execution before bpf_mmap_unlock_mm() is called and queues the
work, an NMI tracing program could also call bpf_find_vma().

Because irqs_disabled() is true in the NMI, it fetches the exact same per-C=
PU
work structure. The NMI would successfully acquire mmap_read_trylock(), set
work->mm to its mm, queue the work, and return.

When the hardware IRQ resumes, it takes its own mmap_read_trylock(), calls
bpf_mmap_unlock_mm(), overwrites work->mm with the hardware IRQ's mm, and
attempts to queue the already-pending work. When the irq_work later execute=
s,
it only drops the lock for the hardware IRQ's mm, permanently leaking the
read lock for the NMI's mm.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260630032543.3165=
720-1-sanghyun.park.cnu@gmail.com?part=3D1
