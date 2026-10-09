Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F2263AD53F
	for <bpf@vger.kernel.org>; Fri,  9 Oct 2026 12:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791548464; cv=none; b=PtLNhJTp4v3jr4xazb2/OpbVWpcFolpsGwBh/JKTYh7oHHGf5tJuwp+8Ai66JFgP+kNHuYhXdll+LnAO2mkV+fFnzIidBYCFBxZxP8CX/V9Cyfkscp6X+nNOVoT2RggEzCT3pfwDGCBAU6/QDiNXXvkIohTttMLEJ4DuNoZp5Ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791548464; c=relaxed/simple;
	bh=MUn79RLViINWd56X9iqSJ33XnQ4X78ln2vdv6HtyOmk=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=CzDKlghEE97bCdv9rWP7xjxwdtCuBPGv8jLJiDmQp6JWxP1ZVDsXDICzQQzHrs9aicqKPfdJOBPGrACDXOJndqQgv0c9fztewzQMJbg+sGIM4/4x5TqwWBqOCTk9uuJnBf59eKDJfHbUd+uRgk3tPYo9Q2Sdcfpm6UCOVuILMQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JvDCNe7T; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JvDCNe7T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 845E71F000FF;
	Fri,  9 Oct 2026 12:20:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791548459;
	bh=X3FCm5djJS/J1jOz7zZOYXzfvsTap79I2iF0U47L5Z0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JvDCNe7TBTIpcxPiEYqFEeITsMQyCox/pFPhkPRFl/l0P06EpyWIouLRyzsDDTfr3
	 NlvuLI+c7hPTZK4nQZWx1+gxs+PfdYginFEnppEWUGfed6RzVqQsB8mRLbe338uhHO
	 2p8onzgmYjzseZ+tY9ZhFfECnbffdDgUH2TkriNqPQKrJaM3UyOcD8HhTVsGU9emJm
	 IyMJjFcX2zlrO3TTJVyUwMkKkKjgCo8eX8BL+mMZEkN1ET/r+RQfQFciJCkpQ+e3cl
	 rBbHH75jbPN/TvvJ1Ms6tAa6oCmm/ZCSN4x+rzfS8c5LARIyZrEKIbhVGUwrKKgLvx
	 30eHdSn3Q558w==
Message-ID: <sashiko-outbox-165521@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/6] mm/page_owner: add bpf_page_owner_get_nid() kfunc
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zhen Ni" <zhen.ni@easystack.cn>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261009112308.240769-5-zhen.ni@easystack.cn>
References: <20261009112308.240769-1-zhen.ni@easystack.cn>
 <20261009112308.240769-5-zhen.ni@easystack.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 12:20:59 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] bpf: arbitrary kernel memory read via page_owner_scan stack aliasi=
ng
- [High] bpf: bpf_page_owner_get_nid() oops on unmapped struct page
--

commit 86f6fa9f642d356a9518f6b22fec24555b1e1568
Author: Zhen Ni <zhen.ni@easystack.cn>

mm/page_owner: add bpf_page_owner_get_nid() kfunc

This commit extracts the NUMA node lookup from read_page_owner() into a sha=
red
page_owner_get_nid() helper. It then exposes this helper to BPF programs vi=
a a
new bpf_page_owner_get_nid() kfunc.

> diff --git a/mm/page_owner.c b/mm/page_owner.c
> index eb420803a434a..43a722678accf 100644
> --- a/mm/page_owner.c
> +++ b/mm/page_owner.c
[ ... ]
> @@ -711,6 +711,19 @@ void __dump_page_owner(const struct page *page)
>  	page_ext_put(page_ext);
>  }
> =20
> +/*
> + * NUMA node of @page, bypassing PF_POISONED_CHECK() in page_to_nid() to
> + * avoid VM_BUG_ON on poisoned pages; -1 for poisoned pages.
> + */
> +int page_owner_get_nid(struct page *page)
> +{
> +	memdesc_flags_t page_flags =3D READ_ONCE(page->flags);

[Severity: High]
Can this trigger a kernel oops on an unmapped struct page?

The KF_SLEEPABLE flag on bpf_iter_page_owner_next() allows the BPF program =
to
be preempted or to explicitly sleep while holding the scan object.

If memory is hot-removed while the program sleeps, the vmemmap region backi=
ng
the struct page pointer inside the scan object could be unmapped.

When the program wakes up and calls bpf_page_owner_get_nid(), this raw
READ_ONCE(page->flags) would dereference the potentially unmapped pointer a=
nd
crash the kernel.

Should bpf_page_owner_get_nid() use copy_from_kernel_nofault() or BPF probe
read semantics to safely probe the memory instead?

> +
> +	if (page_flags.f =3D=3D PAGE_POISON_PATTERN)
> +		return -1;
> +	return memdesc_nid(&page_flags);
> +}
> +

> diff --git a/mm/page_owner_iter.c b/mm/page_owner_iter.c
> index 80693d4174077..907517a291443 100644
> --- a/mm/page_owner_iter.c
> +++ b/mm/page_owner_iter.c
[ ... ]
> @@ -165,4 +165,9 @@ __bpf_kfunc int bpf_page_owner_stack_snprint(depot_st=
ack_handle_t handle,
>  	return stack_depot_snprint(handle, buf, buf_size, 0);
>  }
> =20
> +__bpf_kfunc int bpf_page_owner_get_nid(struct page_owner_scan *scan)
> +{
> +	return page_owner_get_nid(scan->page);
> +}

[Severity: High]
Is there a risk of an arbitrary kernel memory read here?

Because the scan object physically resides on the BPF program's stack (as
returned by bpf_iter_page_owner_next()), a BPF program can overwrite the
scan->page pointer with an arbitrary kernel address using normal BPF stack
pointers (PTR_TO_STACK).

If the program then passes the aliased PTR_TO_BTF_ID to
bpf_page_owner_get_nid(), wouldn't this kfunc blindly dereference the forged
pointer, bypassing verifier safety checks?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009112308.2407=
69-1-zhen.ni@easystack.cn?part=3D4
