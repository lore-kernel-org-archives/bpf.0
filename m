Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4116A168BD
	for <bpf@vger.kernel.org>; Tue,  9 Jun 2026 21:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781040012; cv=none; b=Y4pcdWSXoRrGwFCWVFKha2F+RS0RSS9eyjKfwTgZsanpeHDxkDTXqL/13SmSIEfqZssaysZEoMtEJUQFrhM5Ol9t0q4NuXd96Su7E5CwVqSYkQ6Zp8XtmfoouTmwf8P7Gtghab8R+73Nx+Nxf/J3y7ZpIz4IcRcGPA18jG2CGCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781040012; c=relaxed/simple;
	bh=S9URf/vCebhUTu2slqn+OUK/db7crvGK94C1IfDOlEQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Niq6xN8kXIHS/qAc5HrXqmG9w1kf/QIF5EDCtjw22m/66t4hsUKnfoSQIeRkpxwHI1NkD0ZkvNTWy1Ve8KCNTiqz9CgDcef8h9a1KVtGaw5zd+L47+GGwjNiuTck4VQ+1zXFqHptpeugZgp1nSTx8L9+WPENPUGvUK89v7RNQdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gPV5MsWS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gPV5MsWS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC2331F00893;
	Tue,  9 Jun 2026 21:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781040010;
	bh=92Sb9wOaJxLzCq46MjRQoqDk/34iTvq8QEsEutFVbYE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gPV5MsWSmgvell4ggde6z1XKbLKi9PA5gHis/1t2qN+Yg9toZ8VUY4IuNcG5nhPRl
	 BwqBoomYYNP/GBpsFuJnrw75O8IAiug9a9Z97XNoZulkj41ZkDx2ds6z5r3gXS/rH/
	 CKYOPDmjXO4eTo0Ytpm0K8OYIrEkVZwBbEMPteD2igFQFQdiSl6VNYDsC9GuhUGMS7
	 VMw6P+szO/M2MAa9rLYsYSMp7voBh6fLc9B4eTUSo5grOBuwSSl4L8isTGVoo7w8Tt
	 TGc5mUj6Dmr3ljX0fcmKABk+fnaCl05tYs3hwIvDYflAktV+uHKR3di40aNJLDUD4a
	 a8eGrsPH5HRng==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v1] bpf: Better build_id caching in
 stack_map_get_build_id_offset()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ihor Solodrai" <ihor.solodrai@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260609210749.3448062-1-ihor.solodrai@linux.dev>
References: <20260609210749.3448062-1-ihor.solodrai@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Jun 2026 21:20:10 +0000
Message-Id: <20260609212010.AC2331F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] In the non-sleepable path, stack trace IPs falling into unmapped h=
oles are incorrectly associated with the next adjacent VMA, producing bogus=
 build IDs and out-of-bounds offsets.
--

commit 1e578af5039b6e5b0dc36373f9670148568cdb2a
Author: Ihor Solodrai <ihor.solodrai@linux.dev>

bpf: Better build_id caching in stack_map_get_build_id_offset()

This commit introduces a shared caching mechanism for build IDs between the
sleepable and non-sleepable paths of stack_map_get_build_id_offset(). It
tracks both resolved and unresolved VMAs to avoid repeating lookups and
parses for adjacent stack frames.

Link: https://lore.kernel.org/bpf/20260525223948.1920986-1-ihor.solodrai@li=
nux.dev/
Link: https://lore.kernel.org/bpf/CAEf4Bza2fRDGhLQoPE-EzM7F34xaEJfi5Exmxb-i=
WVUN3F06=3Dg@mail.gmail.com/
Link: https://lore.kernel.org/bpf/CAEf4BzZXJFr=3D1iiVx937ht=3D4PYQkQHg=3DeF=
k810zhMDzXQG3ihw@mail.gmail.com/

> diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
> index 77ba03216c09f..6a642d6526c02 100644
> --- a/kernel/bpf/stackmap.c
> +++ b/kernel/bpf/stackmap.c

[ ... ]

> @@ -365,27 +430,29 @@ static void stack_map_get_build_id_offset(struct bp=
f_stack_build_id *id_offs,
> =20
>  	for (i =3D 0; i < trace_nr; i++) {
>  		u64 ip =3D READ_ONCE(id_offs[i].ip);
> -		u64 offset;
> =20
> -		if (prev_build_id && range_in_vma(prev_vma, ip, ip)) {
> -			vma =3D prev_vma;
> -			offset =3D stack_map_build_id_offset(vma->vm_pgoff, vma->vm_start, ip=
);
> -			stack_map_build_id_set_valid(&id_offs[i], offset, prev_build_id);
> +		if (!stack_map_build_id_set_from_cache(&cache, &id_offs[i], ip))
>  			continue;
> -		}
> +
>  		vma =3D find_vma(current->mm, ip);
>  		if (!vma || vma_is_anonymous(vma) ||
>  		    fetch_build_id(vma, id_offs[i].build_id, may_fault)) {

[Severity: High]
This is a pre-existing issue, but does using find_vma() here allow IPs from
unmapped regions to incorrectly bind to the next adjacent VMA?

Since find_vma() returns the first VMA where vm_end > ip without checking
if ip >=3D vm_start, an unmapped IP could incorrectly fall into this path.
If that happens, computing the file offset later in the loop via
stack_map_build_id_offset() does:

    (vm_pgoff << PAGE_SHIFT) + ip - vm_start;

Could this calculation underflow and produce a massive out-of-bounds offset
if ip < vma->vm_start?

The sleepable variant avoids this because stack_map_lock_vma() uses
vma_lookup() internally, which guarantees the IP falls strictly within the =
VMA
boundaries. Should this non-sleepable path also be converted to use
vma_lookup(), or explicitly check if ip >=3D vma->vm_start?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260609210749.3448=
062-1-ihor.solodrai@linux.dev?part=3D1
