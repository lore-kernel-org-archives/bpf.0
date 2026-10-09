Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 865FC4E2F18
	for <bpf@vger.kernel.org>; Fri,  9 Oct 2026 11:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791546632; cv=none; b=UapnEPTu7AA/y/2EEuE3Eksn+CPdJRQ/teClUwYLiZhz2b89lv8krzb+1rMfZhDzpZ0zBrfOCITu6coOhqHhQvNB4MLLY6K3KQ0xEgs03bA9x10paabUpMIyoZDJKQcOJPcsQzc6telUFDWAhvE/1b0LqmWb2qfwKdK0Z+q//lU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791546632; c=relaxed/simple;
	bh=mzMSPObuZDbbHg1VlLEG1vruvJiHDMhk0bllk9INB7s=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=qlEVI4ZaWtQ52pHmUaNq1pzcrCRIzyDcCwDPS/elRLKxTUS81s3V7O82wF7x3EDRqV+0pNH5/E5Rcs8kwKdoyp4fhzy0ggvkhPCpYVUaOwH6LwMOcBQY6WFIFRItxLH9PBVAUQHk0Qx1obJv2VawmqrsZwND7CQtZRNtoJ4JjN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K5mCLfkn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K5mCLfkn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D16C91F000FF;
	Fri,  9 Oct 2026 11:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791546624;
	bh=x/WguONcJshC045xtqrEo+z6H1RhhVI+IxdVJUjeKyA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=K5mCLfknhHrPlC0Na2PY+twbj+0otZAutMECxR8/rOc3cUTsQDLOVBDsfwo/vKR99
	 u2QpF0lmvG/LkkAIXbdP773kuaYuwJ7a+cNEttrOYmjccqxhTCshZ5Qen4sQHtrJfK
	 sW6aaUdR1tsGgiuueQuT/IPeS54UMD9NLu0POUJ2psJSrBa6jC62UdR1UNYpaHtqIE
	 uDv+o9+Z7zZ8Z6Z506CbDanApmhesS+AC/QxqqECb94MexXeQSDi2RfTK0pKzfSAv4
	 G/njkGfSgTUsBna/os+q/NY4cHi8055Hck5nQ340dTnJizxylrKwqGxgujZvnhoGN0
	 ZqNQCSmClZmdQ==
Message-ID: <sashiko-outbox-165432@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/6] mm/page_owner: add bpf_iter target "page_owner"
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zhen Ni" <zhen.ni@easystack.cn>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261009112308.240769-3-zhen.ni@easystack.cn>
References: <20261009112308.240769-1-zhen.ni@easystack.cn>
 <20261009112308.240769-3-zhen.ni@easystack.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 11:50:23 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [High] mm: vmemmap use-after-free in page_owner_next_eligible() during me=
mory hot-remove
- [Medium] mm: bpf_iter page_owner skips pages when seq_file buffer fills
- [Medium] bpf: missing EOF notification for page_owner bpf_iter
- [Medium] bpf: page_owner_iter skips records during chunked seq_read
- [Medium] bpf: page_owner_iter lacks EOF notification and yields stale po_=
snap
--

commit fd543af9dd8ff743b641757854c444d98608421d
Author: Zhen Ni <zhen.ni@easystack.cn>
Subject: mm/page_owner: add bpf_iter target "page_owner"

This commit registers a bpf_iter target page_owner that walks the pages
eligible for page_owner output. The attached BPF program receives the pfn,
the page, and the page_owner record to filter and format the output.

> diff --git a/mm/page_owner.c b/mm/page_owner.c
> index bafe474f33602..eb420803a434a 100644
> --- a/mm/page_owner.c
> +++ b/mm/page_owner.c
[ ... ]
> @@ -741,7 +717,7 @@ void __dump_page_owner(const struct page *page)
>   * must advance scan->pfn past the hit before calling again to resume
>   * the scan.
>   */
> -static bool page_owner_next_eligible(struct page_owner_scan *scan)
> +bool page_owner_next_eligible(struct page_owner_scan *scan)

[Severity: High]
Does exposing this function to the BPF iterator API introduce a use-after-f=
ree
regression during memory hot-remove?

Inside page_owner_next_eligible(), pfn_valid() is used to verify memory
sections. However, since the iteration runs without holding memory hotplug
locks or a continuous rcu_read_lock(), the memory section can be
concurrently hot-removed by another CPU as soon as pfn_valid() returns.

If the vmemmap pages backing the page struct are unmapped and freed during
this race, the subsequent call will dereference the unmapped page struct:

	page =3D pfn_to_page(pfn);
	if (skip_buddy_pages(&pfn, page))
		continue;

Can this cause a kernel page fault and panic?

While this logic already existed in the /sys/kernel/debug/page_owner read
path, this patch relies on it and exposes the buggy code path to the new
BPF iterator API.

> diff --git a/mm/page_owner_iter.c b/mm/page_owner_iter.c
> new file mode 100644
> index 0000000000000..33dc9dcd59dec
> --- /dev/null
> +++ b/mm/page_owner_iter.c
[ ... ]
> +static void *page_owner_seq_start(struct seq_file *seq, loff_t *posp)
> +{
> +	struct page_owner_scan *scan =3D seq->private;
> +
> +	if (*posp =3D=3D 0)
> +		scan->pfn =3D min_low_pfn;
> +	else
> +		scan->pfn++;

[Severity: Medium]
Can this unconditionally skip elements during chunked reads?

During a seq_read iteration, if a formatted record overflows the output
buffer, the iterator discards the overflowed record, returns to userspace,
and later resumes by calling start() with *posp > 0.

Since next() already advanced scan->pfn to point to the overflowed record,
start() increments it again here. Does this mean userspace tools reading
the iterator output in chunks (like cat or bpftool iter) will silently
drop one valid page owner record at every buffer chunk boundary?

> +
> +	if (!page_owner_next_eligible(scan))
> +		return NULL;
> +	return scan->page;
> +}
> +
[ ... ]
> +static void page_owner_seq_stop(struct seq_file *seq, void *v)
> +{
> +}

[Severity: Medium]
Are we missing an EOF notification here?

Standard bpf_iter implementations invoke the BPF program with v =3D=3D NULL
during seq_ops->stop() to notify the program of EOF, enabling summary
aggregate output. Because this function is empty, BPF programs attached to
the page_owner iterator cannot detect the end of iteration.

Does this mean any logic relying on the standard EOF signal to output
summary statistics or perform cleanup will never execute?

> +
> +static int page_owner_prog_seq_show(struct bpf_prog *prog,
> +				    struct bpf_iter_meta *meta, void *v)
> +{
> +	struct page_owner_scan *scan =3D meta->seq->private;
> +	struct bpf_iter__page_owner ctx;
> +
> +	/* @po: hit-time snapshot, no RCU window needed. */
> +	ctx.meta =3D meta;
> +	ctx.page =3D (struct page *)v;
> +	ctx.po =3D &scan->po_snap;

[Severity: Medium]
If EOF were properly signaled with v =3D=3D NULL, would this unconditional
assignment provide stale data to the BPF program?

By unconditionally assigning ctx.po to the snapshot pointer, ctx.po is
never NULL, even when v (the page) is NULL. Does this mean BPF programs
cannot reliably use if (!ctx->po) to detect EOF, and might operate on stale
snapshot data from the last valid page?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009112308.2407=
69-1-zhen.ni@easystack.cn?part=3D2
