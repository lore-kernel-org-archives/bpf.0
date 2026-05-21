Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 197CE34E746;
	Thu, 21 May 2026 23:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779406415; cv=none; b=WGeEAjxCk0TJkSN/sVaP2ClZ4uIoP+6qL6dSSfVYWR46mRozL5Y6oQtoIlYsFSAXHAH/kcSkI0YfDdR2liQ3dTy6CVtsfhRtafp4zRl+rsahhBdCXQlYLFWsFQReRWe1PMRZJyVKJqQlg/zqzAQeKDVbtTl34xbT2YfChA2UxsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779406415; c=relaxed/simple;
	bh=p/eT2ES4g1OtNMBBJtz4Ei7qPxF+kkiPDjmAU7ctm8w=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=kamsVZGjUR9GRR5j4PZpnyj62Grp9mJKbVqP23H2nuAPnD6fWh+VuUUcb5Ue/Hic/qoXKX2tpqaY3YqXDToDru7/TZi7eXHQAkiRZh3ErSx8dk9+xDRNMYWoNQvLqkFZ70KtSMhl2WfdG/Sn3O5aVb+LvAFW95r/J8rMjDDkanE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m9UnGRvh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m9UnGRvh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A11A1F000E9;
	Thu, 21 May 2026 23:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779406413;
	bh=7jZRoF9HgYcVl17myB5JjUZbtv6mU1dVLl+Gk3KEKcY=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=m9UnGRvh5ZURLXOhw9ODxcu45PdlxsRuSP3RKWr6ljKwZ49HQna/UAg9/ZgpkqXDe
	 ktJQhSOU8+IbTo7RTdlKJ/kO8roP2gP9EH4UhJVpeDJjVN8ecSro9yQfyVsSLZYSaj
	 ubb2jtpsV4QBsAt7I4F+cFdOiyfPrGW/spgCmwre981W/e5re6nNinhueFAPhK0jca
	 7AHvAxRBrOU9o4gFrNQiC+yVZn2cLatuSAeuvcpTMCOal6dt/AVRlCZlJxVVKsw+DO
	 sgoegCtc0LnAge566f8drmMbiKYFy6nAEyxksymoZQI1iLQyGpwWdwwuF0yo68wijt
	 zJ3AVpw2OpzfQ==
Content-Type: multipart/mixed; boundary="===============8845870231642385149=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <4dfa1f3ecf6354e9de5fa0341c248eac18132447d452446a7e9ad9fe67142118@mail.kernel.org>
In-Reply-To: <20260521225022.2695755-4-ihor.solodrai@linux.dev>
References: <20260521225022.2695755-4-ihor.solodrai@linux.dev>
Subject: Re: [PATCH bpf-next v6 3/3] bpf: Cache build IDs in sleepable stackmap path
From: bot+bpf-ci@kernel.org
To: ihor.solodrai@linux.dev,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,memxor@gmail.com
Cc: puranjay@kernel.org,shakeel.butt@linux.dev,mykyta.yatsenko5@gmail.com,bpf@vger.kernel.org,linux-kernel@vger.kernel.org,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu, 21 May 2026 23:33:33 +0000 (UTC)

--===============8845870231642385149==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
> index 95336c0e8b56..0d641ac39227 100644
> --- a/kernel/bpf/stackmap.c
> +++ b/kernel/bpf/stackmap.c

[ ... ]

> @@ -253,6 +261,17 @@ static void stack_map_get_build_id_offset_sleepable(struct bpf_stack_build_id *i
>  	for (u32 i = 0; i < trace_nr; i++) {
>  		ip = READ_ONCE(id_offs[i].ip);
>
> +		/*
> +		 * Range cache fast path: if ip falls within the previously
> +		 * resolved VMA range, reuse the cache build_id without
> +		 * re-acquiring the VMA lock.
> +		 */
> +		if (cache.build_id && ip >= cache.vm_start && ip < cache.vm_end) {
> +			offset = stack_map_build_id_offset(cache.vm_pgoff, cache.vm_start, ip);
> +			stack_map_build_id_set_valid(&id_offs[i], offset, cache.build_id);
> +			continue;
> +		}
> +
>  		vma = stack_map_lock_vma(&lock, ip);
>  		if (!vma || !vma->vm_file) {
>  			stack_map_build_id_set_ip(&id_offs[i]);

sashiko-bot@kernel.org raised a concern in v3 (repeated in v4 and v5 by
bpf-ci) about the VMA classification here using !vma->vm_file. While
this check predates your patch series, it's worth addressing for the
context this code now operates in.

Can private mappings of /dev/zero or driver memory cause issues? These
mappings can have a non-NULL vma->vm_file but are still considered
anonymous. If the stackmap path proceeds to parse the ELF build ID from
these files, could it trigger unintended side effects?

For example, reading from a character device might alter hardware state,
or reading from a FIFO could consume data.

Would checking vma_is_anonymous(vma) here be safer to properly classify
the VMA?

Reference: https://lore.kernel.org/bpf/20260513043154.24483C2BCB7@smtp.kernel.org/

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/26258400944
--===============8845870231642385149==--
