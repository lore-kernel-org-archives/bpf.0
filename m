Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8370830BF4F;
	Sat, 23 May 2026 17:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779555912; cv=none; b=DU4vtEAHPGOdQK+iZXE68St88ZMUTpcXfJYtqFFVg+R0Gze/ZhoLKAmNZ3+vCilf3gmTIH8yGKLKYB4Qm9oHXkgTbvOtiaJHHg8EqAxBUBYOwaCYxhWrjp/EEJxVM9XRDflMwmWjFShD86qQxDHKpJ4xbDGXNxvXUYQGQH/QAUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779555912; c=relaxed/simple;
	bh=onX9zQ1spS/mSWAVbKWsIMn4/sI9Ekdyqd0bIqixNVI=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=SFCQtNC1flfFHcseS5Bqmiw2VOLoM7eY3FirsDO+KU20KO18ZKVvHRMCCdxMXt+wmdLLOByWjl/1ZWhHwm0zDANPmSEy8kRLrKRNqP/YYkCRBPictJ+kT3V1SWGJ1zWl2WUwLMzhNiY9oTEfQK5dqyX6FloR/hiZMr0pqOfpBLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CeY9+inN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CeY9+inN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D37AB1F000E9;
	Sat, 23 May 2026 17:05:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779555911;
	bh=cyagchc+kw2OslMdfkJZxkXMgAfRo9BAeFphUwryhZg=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=CeY9+inNutTviQaB+CKacJ7gSaPXHGUcF2PtZgmBgNM5h+uqEYTxbi82miEh1qYK5
	 CrRVzwScyYXiTsofjaZKKsG+91XmOvoDHfcgc9aTWju/vKTAn+964HsmQBZGAS7lr3
	 zTCgTnEktWw1FdkW885zm/KuK7gWaPRxixbR8xDy+siTsyxQrCd77eBW6+iCPR13Th
	 Y6HSri8/oGdlJGggetQc0Ft3bTG9NHLurzDykQwn2Q2lhj0keOrHyiAyatZ9em0vmx
	 LZ/QoT16w3P+yrgfKabnSGtaf0Dawcv5akkg/P/jjypD04/8XkheWmO7ruZb3M9neI
	 WxFDrFzYBNIdA==
Content-Type: multipart/mixed; boundary="===============2686473054313733903=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <69de57e1bd8a95a848f06b6acc9f105e80a87a27ae206afd83a6d5f1004bd9b5@mail.kernel.org>
In-Reply-To: <20260523162722.2718940-1-cmllamas@google.com>
References: <20260523162722.2718940-1-cmllamas@google.com>
Subject: Re: [PATCH v4] libbpf: fix UAF in strset__add_str()
From: bot+bpf-ci@kernel.org
To: cmllamas@google.com,mykyta.yatsenko5@gmail.com,andrii.nakryiko@gmail.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,memxor@gmail.com,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org
Cc: kernel-team@android.com,linux-kernel@vger.kernel.org,cmllamas@google.com,yatsenko@meta.com,bpf@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Sat, 23 May 2026 17:05:10 +0000 (UTC)

--===============2686473054313733903==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/lib/bpf/strset.c b/tools/lib/bpf/strset.c
> index 2464bcbd04e0..b9faca828f09 100644
> --- a/tools/lib/bpf/strset.c
> +++ b/tools/lib/bpf/strset.c
> @@ -107,6 +107,38 @@ static void *strset_add_str_mem(struct strset *set, size_t add_sz)
>  			      set->strs_data_len, set->strs_data_max_len, add_sz);
>  }
>
> +static long strset_str_append(struct strset *set, const char *s)
> +{
> +	uintptr_t old_data = (uintptr_t)set->strs_data;
> +	uintptr_t old_s = (uintptr_t)s;
> +	long len = strlen(s) + 1;
> +	void *p;
> +
> +	/* Hashmap keys are always offsets within set->strs_data, so to even
> +	 * look up some string from the "outside", we need to first append it
> +	 * at the end, so that it can be addressed with an offset. Luckily,
> +	 * until set->strs_data_len is incremented, that string is just a piece
> +	 * of garbage for the rest of the code, so no harm, no foul. On the
> +	 * other hand, if the string is unique, it's already appended and
> +	 * ready to be used, only a simple set->strs_data_len increment away.
> +	 */
> +	p = strset_add_str_mem(set, len);
> +	if (!p)
> +		return -ENOMEM;
> +
> +	/* The set->strs_data might have reallocated and if 's' pointed
> +	 * to an internal string within the old buffer, then it became
> +	 * dangling and needs to be reconstructed before the copy.
> +	 */
> +	if (old_data && old_data != (uintptr_t)set->strs_data &&
> +	    old_s >= old_data && old_s < old_data + set->strs_data_len)
> +		s = set->strs_data + (old_s - old_data);
> +
> +	memcpy(p, s, len);
> +
> +	return len;
> +}

Does a similar use-after-free still exist in the btf__add_* APIs (e.g.
btf__add_str) when called with strings from btf__name_by_offset() on an
unmodifiable BTF?

If a user passes a string retrieved via btf__name_by_offset(), the
string pointer points directly into btf->raw_data. Inside the btf__add_*
APIs, btf_ensure_modifiable(btf) is called first, which calls
btf_invalidate_raw_data() and frees btf->raw_data.

Could this leave the s pointer dangling before it even reaches this
check? The check added here uses old_data which corresponds to
btf->strs_set, not the freed btf->raw_data, so it wouldn't rescue the
pointer.

This concern was raised by sashiko-bot@kernel.org on lore but was not
addressed in subsequent patch versions.

Reference: https://lore.kernel.org/all/20260518053124.2EF28C2BCB7@smtp.kernel.org/

> +
>  /* Find string offset that corresponds to a given string *s*.
>   * Returns:
>   *   - >0 offset into string data, if string is found;

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/26338132147
--===============2686473054313733903==--
