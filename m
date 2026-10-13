Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89493198A17
	for <bpf@vger.kernel.org>; Tue, 13 Oct 2026 12:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791895742; cv=none; b=b3AAFiZ7j7dwiheqk+lySl67gCH0Xc8BSFvxxs0BWyUTMu2a8bXEqacyTB6K2DCPfboeMVKQ/0NpGneNEArWRD0HF/Z3D0iyc1hdzia553Ope7iMEdjkWZFS2rbfi0nIHj9mEVIOpzPU6ePs8ye2PBsIso+7+mfie17wves2/mA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791895742; c=relaxed/simple;
	bh=qe3nz3aKewxfGjZqzOkwgkL7YBNm7/+RQVegX+A9O7k=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=rafToFhw8FpJW+J8smFf+61Q99j+2LQf7sZJ7HVc7YQ5oA3Vaa4j2p1p9F29+sBwE6NrkxRlD4/Zr7ypTVbtmWhnhtiqucQyFf6PFP1uKGmD8AT3myGxS8+uJ2KcMBfACHKKscaWRVlsO9wLDwsVNpCRf7qJwX/sGubQq34RkxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VHUaaeN2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VHUaaeN2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4302B1F00893;
	Tue, 13 Oct 2026 12:49:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791895741;
	bh=xrIWN5v2632Sn9LIj9Of0JDvKjrydFsiKDvaxJ2mCCM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VHUaaeN2AFIeAkkNOG6zjBJWVR/xx3KArrC2QbM7eF7jD41M28TO18zHRoDq+W1iN
	 24ME+f9rwWs5N/D6ulEooOYyM/smG3S4RuzfWmix2E97sUwEfoX8np8FqnpTwjVu8L
	 qx1XGlLs1vxP2uOiBE/U2Z39dfYf9RG6kyYYhB7xFYX0y7GWOifSC7BZopWOTzYFOf
	 xtRT97AMQNn+u5viVGmQXErAapj5drBxRYqen3aGH2+ChSbWlFFEXzq2xxMe5Ms+Wa
	 8j5bMwMFBghXTShffWHqeGxKn5v4s98wMPNc5GrqmQIGSjsNcKlZpCQedKp8SCbItr
	 W7gDHohL5vVVQ==
Message-ID: <sashiko-outbox-169738@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 5/6] mm/page_owner: add
 bpf_page_owner_get_memcg_info() kfunc
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zhen Ni" <zhen.ni@easystack.cn>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261013122125.843451-6-zhen.ni@easystack.cn>
References: <20261013122125.843451-1-zhen.ni@easystack.cn>
 <20261013122125.843451-6-zhen.ni@easystack.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 12:49:00 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] bpf: TOCTOU race in bpf_page_owner_get_memcg_info() leads to page =
fault
- [High] mm: wild pointer dereference in get_page_memcg_info() for tail pag=
es
--

commit ab0ccc33a4ab8ccdaacb5f6b2dca8722bf6d6123
Author: Zhen Ni <zhen.ni@easystack.cn>

mm/page_owner: add bpf_page_owner_get_memcg_info() kfunc

This commit exposes per-page memcg information to BPF programs.
It splits memcg info collection out of print_page_owner_memcg() into
a new get_page_memcg_info() function and adds the
bpf_page_owner_get_memcg_info() kfunc.

Link: https://lore.kernel.org/linux-mm/20261009112308.240769-6-zhen.ni@easy=
stack.cn/

> diff --git a/mm/page_owner.c b/mm/page_owner.c
> index 113e4e7e0b3a1..664121be66863 100644
> --- a/mm/page_owner.c
> +++ b/mm/page_owner.c
> @@ -538,16 +538,22 @@ void pagetypeinfo_showmixedcount_print(struct seq_f=
ile *m,

[ ... ]

> +int get_page_memcg_info(struct page *page, struct memcg_info *info,
> +			char *buf, int size)
>  {
>  	unsigned long memcg_data;
>  	struct obj_cgroup *objcg;
>  	struct mem_cgroup *memcg;
> +	int ret =3D -ENODATA;
> +
> +	*info =3D (struct memcg_info){};
> =20
>  	rcu_read_lock();
>  	memcg_data =3D READ_ONCE(page->memcg_data);
> +	if (!memcg_data)
> +		goto out_unlock;

[Severity: High]
Does removing the PageTail() guard here expose a wild pointer dereference?

In struct folio, the first tail page's _nr_pages field aliases exactly with
the memcg_data offset when CONFIG_MEMCG is enabled. Due to a lack of memory
barriers in __update_page_owner_handle(), page_owner_next_eligible() can
observe PAGE_EXT_OWNER_ALLOCATED before page_owner->order is updated,
yielding a tail page.

If a tail page is passed here, the non-zero _nr_pages value (e.g., 512 for a
large folio) will bypass the !memcg_data check and be dereferenced as an
obj_cgroup pointer later in the function, leading to a kernel panic.

[ ... ]

> diff --git a/mm/page_owner_iter.c b/mm/page_owner_iter.c
> index a2b90c8748520..86e0b4b52bfc7 100644
> --- a/mm/page_owner_iter.c
> +++ b/mm/page_owner_iter.c
> @@ -177,4 +177,21 @@ __bpf_kfunc int bpf_page_owner_stack_snprint(struct =
page_owner_scan *scan,
>  				   0);
>  }
> =20
> +__bpf_kfunc int bpf_page_owner_get_memcg_info(struct page_owner_scan *sc=
an,
> +					      struct memcg_info *info__uninit,
> +					      char *buf__uninit, u32 buf__sz)
> +{
> +	/* Guard against the section being offlined after scan. */
> +	struct page *page =3D pfn_to_online_page(scan->pfn);
> +
> +	if (!page) {
> +		*info__uninit =3D (struct memcg_info){};
> +		if (buf__uninit && buf__sz)
> +			buf__uninit[0] =3D '\0';
> +		return -ENODATA;
> +	}
> +
> +	return get_page_memcg_info(page, info__uninit, buf__uninit, buf__sz);
> +}

[Severity: High]
Is this vulnerable to a time-of-check to time-of-use race with memory
hot-remove?

The pfn_to_online_page() check and subsequent get_page_memcg_info()
dereference occur without holding get_online_mems(). Because this is a
sleepable BPF kfunc (KF_SLEEPABLE), the thread can be preempted between the
check and the dereference.

If memory hot-remove offlines and removes the memory section concurrently, =
it
tears down the vmemmap backing the struct page. When the thread resumes and
get_page_memcg_info() attempts to read page->memcg_data, it will fault on t=
he
unmapped address.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013122125.8434=
51-1-zhen.ni@easystack.cn?part=3D5
