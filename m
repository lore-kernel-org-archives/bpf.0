Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC0A501F5E
	for <bpf@vger.kernel.org>; Tue, 13 Oct 2026 12:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791895790; cv=none; b=eazxMvpoDymu/yxB/XiUn02qsAKWYrB2aMWf0vls7MRKjVVox8A8dfdY4fxv4XEGCtaX5IfC1oash8AvhEWIT5ilEmuWUEW03XnurQlw+Yx+ipKBNTOwX1AkG3aO+6BQWRAVuWnRBWqHjJ8lCFHSjcW9Z2b3RyPxWyafBQCVAcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791895790; c=relaxed/simple;
	bh=+VmW637AITOCP3CffhvcLBHKx1Jkcd0wo3pSk2TQj3o=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=FupxvSFgYrWra7WItwvS/ZmyCuIeA9qGU+eVdF3fUoHgSXO/aRZFvMrQlm29VO3o/wegAQAmYfYRxUPbj7TN0N8J1tDyErf/RWnqsBOipZmarHePlL5UJDwhsz6XEtqngbLDCcd0vTHnpKz+QW3iZ6TShI7bvdluWgThFECj4ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NYuHWDNQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NYuHWDNQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 578241F00898;
	Tue, 13 Oct 2026 12:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791895788;
	bh=W9rMK2MnX0gS+6rPJc6zoy/A7TDiJV1ndZxhZIc1fBY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NYuHWDNQDrBoq1OkV6pqxzx0t+grbRnoqKvODCSDWS/3UU1+0sHxK/adEsHp0/gh4
	 khWasBdpBtW3YhYbm9uMr31NZtAXWSIhBPnH9gT+x4fn7PF+krCu0FIXyEqMx7LwEm
	 YOCXVv8vaEN6vs/LhLcoEaKS3Ny82CyPufvy4K0TUs7S1F5CFq4k30ajTAd2IP38NB
	 X14heac995ArLp+5Dxc+8wuroHQLMaBafX+9AwyWa4FipJiO6YpA6V0ZxEim4vsJYj
	 95XcltSPCu5NlYIuH6ydNKAtJ60aqWaAlXP35DFmq9fDsR/aXS1AH1PbJoxjyqquhr
	 8Wtriqe439vig==
Message-ID: <sashiko-outbox-169742@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/6] mm/page_owner: add open-coded page_owner
 iterator
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zhen Ni" <zhen.ni@easystack.cn>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261013122125.843451-4-zhen.ni@easystack.cn>
References: <20261013122125.843451-1-zhen.ni@easystack.cn>
 <20261013122125.843451-4-zhen.ni@easystack.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 12:49:47 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] mm: soft lockup in page_owner_next_eligible via BPF iter
--

commit b7f01516d35223b7a6800ce695c29a9203809699
Author: Zhen Ni <zhen.ni@easystack.cn>

mm/page_owner: add open-coded page_owner iterator

This patch adds an open-coded bpf_iter over the pages eligible for
page_owner output, reusing page_owner_next_eligible(). It also provides a
sleepable BPF program to drive the iterator and retrieve stack traces.

> diff --git a/mm/page_owner_iter.c b/mm/page_owner_iter.c
> index 938cb42ab7d79..ac7e69ba0cef3 100644
> --- a/mm/page_owner_iter.c
> +++ b/mm/page_owner_iter.c
[ ... ]
> @@ -122,3 +123,55 @@ int page_owner_iter_register(void)
> =20
>  	return bpf_iter_reg_target(&page_owner_iter_reg_info);
>  }
> +
> +/* opaque to BPF programs */
> +struct bpf_iter_page_owner {
> +	__u64 __opaque[16];
> +} __attribute__((aligned(8)));
> +
> +struct bpf_iter_page_owner_kern {
> +	struct page_owner_scan scan;
> +} __attribute__((aligned(8)));
> +
> +__bpf_kfunc_start_defs();
[ ... ]
> +__bpf_kfunc struct page_owner_scan *
> +bpf_iter_page_owner_next(struct bpf_iter_page_owner *it)
> +{
> +	struct bpf_iter_page_owner_kern *kit =3D (void *)it;
> +
> +	cond_resched();
> +
> +	if (kit->scan.page)
> +		kit->scan.pfn++;
> +
> +	if (!page_owner_next_eligible(&kit->scan))
> +		return NULL;

[Severity: High]
Can this iterator cause a soft lockup or RCU stall?

If page_owner is disabled, page_ext_get() inside page_owner_next_eligible()
constantly returns NULL, triggering a continue on every single page up to
max_pfn:

mm/page_owner.c:page_owner_next_eligible() {
	...
	for (; pfn < max_pfn; pfn++) {
		...
		page_ext =3D page_ext_get(page);
		if (unlikely(!page_ext))
			continue;
		...
ext_put_continue:
		page_ext_put(page_ext);
		cond_resched();
	}
	...
}

Because the continue statement skips the ext_put_continue block, the loop
never calls cond_resched(). When called from this new sleepable BPF
iterator, won't it spin over the entire physical memory space in a tight
loop without yielding?

> +
> +	return &kit->scan;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013122125.8434=
51-1-zhen.ni@easystack.cn?part=3D3
