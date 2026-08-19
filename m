Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 576753191CA;
	Wed, 19 Aug 2026 16:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787158195; cv=none; b=llyB/7aO1SkuRR/+P/EdMoUNSnudyTN/W7yiz8G5UpflSi2E8oLU0ymwSRNBelxszeXHZ5jfCs2GKYNfthbG4iCsWwfe/OSvK6EFCasU787umm54wMA9BxvmI51nWWiQFsQ1EIjXKrX+8ek3m6aiCWE/GkHX+Exe55n4jOC8OyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787158195; c=relaxed/simple;
	bh=fzM/V9DS/EFdTFsVCqwAIO6JYDnIcVQh+xAcCsnn0NI=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=POtrLLqMTubc/ha+T4EsDiqwOYJ/H0f0lP+yTUvXCIDQDXF0DcFV6qHx/RvE5dGa4bEc0laPRxxmEWkjGys4jrZvUMZwji5sFxIJ8Qi5H1BUVB0oUvyYCiBVJ77axQROgRZwEdBCAo7b9E03GM9/fHRp6AJUeX2mO83Vny2gq/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XO2r5kDA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XO2r5kDA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A32301F000E9;
	Wed, 19 Aug 2026 16:49:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787158194;
	bh=eeseiYbVUBFAnoEx0H/BodnFVjkrBOO2bOFg4rATqS0=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=XO2r5kDAhVr/e4Nqhuq5CVfLugyEC0rajTGDYJqqloCFn7KJ7ISv0AHGG3+LWe5VY
	 VlIi3xi6b6RXY3V7dsBViDQQyxn4WmM6ALe4TNvIoTSKwLAroEptYexnDt27vWnc7l
	 glLVWjVkXKG9Eefimn5QBEINdV6FJe71+tF2VUMt63Ub3uxZxsTA96JtBksElGQGZi
	 nRwrId7+ygHq1WBkRhsDiyYu9GO0apQD8LR3cSAES8Sw/lR7RKjEeZziyrFerwmzB3
	 tVZlwXdMCH5szsMDd8RKPwpyk2gC2g3GQDKAtUKl16wWnmlp17gfHsFyoZezQf4oxK
	 oHhLDou57tIrQ==
Content-Type: multipart/mixed; boundary="===============0014506347071189457=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <b8673f98d427261daf188214c07b0df994a1dae3bbd3e6ff7ef2d65df75292d2@mail.kernel.org>
In-Reply-To: <20260820-bpf-kcsan-obj-memcpy-v1-1-372c59462268@proton.me>
References: <20260820-bpf-kcsan-obj-memcpy-v1-1-372c59462268@proton.me>
Subject: Re: [PATCH] bpf: Annotate bpf_obj_memcpy with data_race
From: bot+bpf-ci@kernel.org
To: quanyeyang@proton.me,ast@kernel.org,daniel@iogearbox.net,john.fastabend@gmail.com,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com
Cc: bpf@vger.kernel.org,linux-kernel@vger.kernel.org,syzbot+44044637ef892e79ca2b@syzkaller.appspotmail.com,quanyeyang@proton.me,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed, 19 Aug 2026 16:49:53 +0000 (UTC)

--===============0014506347071189457==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> syzbot reported KCSAN write-write races when two tasks concurrently
> update the same map value. Both accesses reach the ordinary memcpy()
> paths in bpf_obj_memcpy() through copy_map_value().
>
> Unlocked map value updates are intentionally not serialized. Therefore,
> a concurrent update may result in a torn value. Callers requiring
> consistency must provide external synchronization or use BPF_F_LOCK
> where supported. bpf_long_memcpy() already documents and annotates the
> same behavior for long-aligned copies.

The BPF_F_LOCK remedy is mentioned here, but does it actually apply to
the map type in the syzbot report? The report shows
BPF_MAP_TYPE_PERCPU_ARRAY, which rejects BPF_F_LOCK in
bpf_percpu_array_update() and cannot have a bpf_spin_lock field per
map_check_btf(). Would it be more accurate to say that external
synchronization is the only option for per-cpu arrays, and that
BPF_F_LOCK is available for other map types where supported?

> Annotate the ordinary memcpy() operations in bpf_obj_memcpy() with
> data_race() as well. This documents the existing concurrency semantics
> and prevents KCSAN from reporting these intentional races. It does not
> add synchronization or change map update behavior.
>
> Place the annotations at the memcpy() sites in the common helper, matching
> bpf_long_memcpy(), without changing the existing copy helper interfaces.

This isn't a bug, but the last two paragraphs both describe where the
data_race() annotations were placed. Would folding them together keep
the changelog tighter without losing the rationale?

> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index ffa5626411ac..68f022810fbc 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -560,7 +560,16 @@ static inline void bpf_long_memcpy(void *dst, const void *src, u32 size)
>  		data_race(*ldst++ = *lsrc++);
>  }
>
> -/* copy everything but bpf_spin_lock, bpf_timer, and kptrs. There could be one of each. */
> +/*
> + * Copy everything but bpf_spin_lock, bpf_timer, and kptrs. There could
> + * be one of each.
> + *
> + * Map value copies can race with unlocked updates from BPF programs or
> + * syscalls. Such copies are best effort and may be torn, so annotate the
> + * ordinary byte copies as intentional data races. Callers that require a
> + * consistent value must provide synchronization or use BPF_F_LOCK where
> + * supported.
> + */

The comment states that all map value copies "are best effort and may be
torn", but is that accurate for every bpf_obj_memcpy() caller? Several
callers copy into freshly allocated, not-yet-published elements
(alloc_htab_elem, bpf_selem_alloc, bpf_sk_storage_clone_elem) or into
private syscall buffers (bpf_map_copy_value), where no other writer can
reach the destination. Would scoping the comment to in-place updates of
published map values be more precise?

Also, the BPF_F_LOCK advice appears again here. As with the commit
message, this doesn't apply to per-cpu arrays - bpf_percpu_array_update()
rejects the flag, and map_check_btf() won't allow a bpf_spin_lock field.
Should the comment mention that per-cpu maps have no BPF_F_LOCK option?

>  static inline void bpf_obj_memcpy(struct btf_record *rec,
>  				  void *dst, void *src, u32 size,
>  				  bool long_memcpy)

[ ... ]

>  		if (long_memcpy)
>  			bpf_long_memcpy(dst, src, size);
>  		else
> -			memcpy(dst, src, size);
> +			data_race(memcpy(dst, src, size));
>  		return;
>  	}
>
> @@ -580,10 +589,10 @@ static inline void bpf_obj_memcpy(struct btf_record *rec,
>  		u32 next_off = rec->fields[i].offset;
>  		u32 sz = next_off - curr_off;
>
> -		memcpy(dst + curr_off, src + curr_off, sz);
> +		data_race(memcpy(dst + curr_off, src + curr_off, sz));
>  		curr_off += rec->fields[i].size + sz;
>  	}
> -	memcpy(dst + curr_off, src + curr_off, size - curr_off);
> +	data_race(memcpy(dst + curr_off, src + curr_off, size - curr_off));
>  }

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/32275499243
--===============0014506347071189457==--
