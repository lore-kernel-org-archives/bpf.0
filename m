Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83C883EDE70
	for <bpf@vger.kernel.org>; Wed, 13 May 2026 04:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778646714; cv=none; b=AWVLbwAbiQPTwlsrDD18/gsFl00ZktxTN85TWYzktzz9V/ZeIOU/kq+P7oam5NuNQ5aOApWGZqODcAI6oP85p/OwZbbP+80m2XBmqSBWWNfozjatoUxGVeZBR0t1NdQRJddPSeAza0isf7C2lcLcZycYGrV6ojs5jwvJGeLMSEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778646714; c=relaxed/simple;
	bh=ZgY2y33kPFaBwz94rZtIYmpcyasXbsd0uqjmjGCFGzE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hrZqOH8TL+NQU5uXn4HDoLL8pThqdNKBMlvwXFhLfRZ7xZha8JdC5/sryVziR6KkWbxRR5I5UjI1gfqH37iGGCuKFNhVEteJExP78QDn+Aoz7U+Fl8fVSxL2JHS+pYgkq8p5wtpzCeulKkkqRR05BHLtB3jA6Ud4C7UMYsXddds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e0y/Xqao; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e0y/Xqao"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24483C2BCB7;
	Wed, 13 May 2026 04:31:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778646714;
	bh=ZgY2y33kPFaBwz94rZtIYmpcyasXbsd0uqjmjGCFGzE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=e0y/XqaoLOppZyQpTeefFCGAwNq9ucsVdxKyVD1MWUvkHcwW9GQU6mYc4qJhvWhps
	 BxK0gnsexnDwQfXft5QGaMCeSmCPp8SODbjGAiDbB3oPWWsVdULgNHcrllQVGbaoBA
	 6kugDGyt/jp+bWPorOy3tU9kY+g0YA+b6KTqSsTDrp24pzA3vchjmBs56IF2/VyLsI
	 UbIaD3zoJWAMPhpNeL5j+EDKM24uZPmbrKWPU5PQhcwNy9kJWBGVjObLtdSNOxqmTO
	 49AHc/HRQgwpvKduluD2WOX5N+QTJGQ9DPnfqCqjpzF/h4ewxJeOR8sVAG9MmEptlC
	 nXf5sgRr9DmpA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf v3 3/3] bpf: Cache build IDs in sleepable stackmap
 path
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ihor Solodrai" <ihor.solodrai@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260512032906.2670326-4-ihor.solodrai@linux.dev>
References: <20260512032906.2670326-4-ihor.solodrai@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 13 May 2026 04:31:53 +0000
Message-Id: <20260513043154.24483C2BCB7@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Incorrect VMA classification using `!vma->vm_file` instead of `vma=
_is_anonymous()`.
--

commit ce8ba4f759b0570ea69e4efa358a2ec6ddcc2fba
Author: Ihor Solodrai <ihor.solodrai@linux.dev>

bpf: Cache build IDs in sleepable stackmap path

This commit introduces a cache for the last successfully parsed build ID,
VMA range, and backing file in the sleepable stackmap path. This avoids
repeated VMA locking and file parsing for adjacent IPs.

> diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
> index c1e96df360c3f..318ce9ed0dd5c 100644
> --- a/kernel/bpf/stackmap.c
> +++ b/kernel/bpf/stackmap.c
[ ... ]
> @@ -226,13 +226,34 @@ static void stack_map_get_build_id_offset_sleepable=
(struct bpf_stack_build_id *i
[ ... ]
>  	for (u32 i =3D 0; i < trace_nr; i++) {
>  		ip =3D READ_ONCE(id_offs[i].ip);
[ ... ]
>  		vma =3D stack_map_lock_vma(&lock, ip);
>  		if (!vma || !vma->vm_file) {

While this specific check was not introduced by this patch, I notice the
code relies on !vma->vm_file to determine if a VMA is file-backed.

Can this cause issues with anonymous VMAs that still have a backing file?

For example, private mappings of /dev/zero or driver memory can have a
non-NULL vma->vm_file but are still considered anonymous.

If the stackmap path proceeds to parse the ELF build ID from these files,
could it trigger unintended side effects, such as consuming FIFO data or
altering hardware state when reading from character devices?

Would it be safer to check vma_is_anonymous(vma) here to properly classify
the VMA?

>  			stack_map_build_id_set_ip(&id_offs[i]);
>  			stack_map_unlock_vma(&lock);
>  			continue;
>  		}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260512032906.2670=
326-1-ihor.solodrai@linux.dev?part=3D3
