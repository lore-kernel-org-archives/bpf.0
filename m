Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C72F54F402E
	for <bpf@vger.kernel.org>; Tue, 13 Oct 2026 12:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791894973; cv=none; b=s28cnxWzKlLdMK/+fesRpMN7CJa6/VeWYWqCFahJM03SMiMw0iqiBdcUz82iMp/1a+osdwMFvu4ZhIyqztK9d0BTw/cjb2aNsbjDb3Ay+A476YE0xsIlxm+UAeSglquyWLyitkoUI8OeXAzvHawu2a1159W6+2I6slqZJIfaIQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791894973; c=relaxed/simple;
	bh=AzQaNg0fjQgv6k016+Da5Obiw21oy6b5Rb/Z3eP9AjU=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=hYZsi2CZvdRSKwqAk7q+gMaGIDG/7sQzXAQAk2538+Vy5ifiVMgYMcFTA7/bY5sf3DFFKoV/EN9rZFKKPyG1D5R+zgM69yRLQOk11ycEYZ4KX2LV2d/N8dk98iza2DGAbRaUZTxvpXtfqpthJm/UNc5GJ7rF5sMuRiPc4MAo5k0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kOn0Ig1W; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kOn0Ig1W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8010D1F00893;
	Tue, 13 Oct 2026 12:36:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791894972;
	bh=cxkP7IJS4g7a7R/o0EFsicyWNeVBNJl/PoYJ8Tr8iB0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kOn0Ig1WsBlyyZYyY70JF3g2jb2GCTni0SJtW1/agAZBUadd9Eh59id7ZnJ35wR2B
	 XYCaqJWdRzkQ3E9W+sOEwgPGh+GOiD20sWYnBtPLlhmR7MsIBOJ2RVR7KtY8y75vVz
	 ykYGV7Vou5S1+3F4ydaG2/0Al360wDwNnNtXBhK4P3OYeqn+ei9yloeaRsBFGHm05g
	 Gnz4xBUR09Zc5EZ0AliBbZVfVak2Xaf3hXvmRKzJ7cJ1EqIKzb+yqQDnHOTE5H3h9T
	 SP26onzZzTAoBaJ/hfTqnaTA3s5t2fmNEYGrQTMZ09QCYUboLsp9l4XxOf6WaF5RxC
	 d3xGFgkxQ9Pfw==
Message-ID: <sashiko-outbox-169722@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/6] mm/page_owner: record the NUMA node in the scan
 cursor
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zhen Ni" <zhen.ni@easystack.cn>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261013122125.843451-5-zhen.ni@easystack.cn>
References: <20261013122125.843451-1-zhen.ni@easystack.cn>
 <20261013122125.843451-5-zhen.ni@easystack.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 12:36:12 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] mm: incomplete fix leaves page_owner vulnerable to unmapped page d=
ereference
--

commit 7b174b26adeea5712aaa10bd465514b5ce7dbe36
Author: Zhen Ni <zhen.ni@easystack.cn>
Subject: mm/page_owner: record the NUMA node in the scan cursor

This commit computes the page's NUMA node in page_owner_next_eligible()
and stores it in the scan cursor to avoid dereferencing a potentially
unmapped page later. It updates the debugfs nid filter and BPF program
to use this stored node value.

> diff --git a/mm/page_owner.c b/mm/page_owner.c
> index 617346a4ab22a..113e4e7e0b3a1 100644
> --- a/mm/page_owner.c
> +++ b/mm/page_owner.c
[ ... ]
> @@ -810,18 +824,8 @@ read_page_owner(struct file *file, char __user *buf,=
 size_t count, loff_t *ppos)
>  	/* Find an allocated page */
>  	while (page_owner_next_eligible(&scan)) {
>  		if (state->nid_filter_enabled) {
> -			int nid;
> -			memdesc_flags_t page_flags =3D
> -				READ_ONCE(scan.page->flags);
> -
> -			/*
> -			 * Bypass PF_POISONED_CHECK() in page_to_nid() to avoid
> -			 * VM_BUG_ON when accessing poisoned pages.
> -			 */
> -			if (page_flags.f =3D=3D PAGE_POISON_PATTERN)
> -				goto skip_continue;
> -			nid =3D memdesc_nid(&page_flags);
> -			if (!node_isset(nid, state->nid_filter))
> +			if (scan.nid < 0 ||
> +			    !node_isset(scan.nid, state->nid_filter))
>  				goto skip_continue;
>  		}
> =20

[Severity: High]
Does this fix leave scan.page vulnerable to an unmapped page dereference
shortly after this block?

Although this patch successfully avoids dereferencing scan.page when checki=
ng
the node filter, page_owner_next_eligible() drops the RCU lock via
page_ext_put() before returning.

Just below the quoted block in read_page_owner(), scan.page is still
passed directly to print_page_owner():

read_page_owner() {
    ...
    while (page_owner_next_eligible(&scan)) {
        ...
        return print_page_owner(buf, count, scan.pfn, scan.page,
                                &scan.po_snap, scan.po_snap.handle, state);
    ...
}

Inside print_page_owner(), the pointer is dereferenced by scnprintf using
the %pGp formatter on &page->flags.f.

If a concurrent memory hot-remove operation frees the vmemmap backing this
struct page after the RCU lock is dropped, will this %pGp format access
trigger a kernel panic?

Additionally, a follow-up patch in this series (Patch 5) appears to introdu=
ce
get_page_memcg_info() which also unconditionally dereferences scan.page
outside the RCU lock from read_page_owner(). Does that face the same
use-after-free risk?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013122125.8434=
51-1-zhen.ni@easystack.cn?part=3D4
