Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5816E3D7A03
	for <bpf@vger.kernel.org>; Wed, 20 May 2026 12:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779279558; cv=none; b=JItRDJnBxUKVpRQntozlEwnr5OAT2SVxMg97KQbyHNkSjNhf2VS5OKofkmU29OetDYhIA7D0tZVVhF2Fu0PBghXKeHFRPwooQX90SXj/3Vl/YAI/3fTHfjSdqrxLRG3RSHaSpLN9EYLx/BvkguftvkCG8jUF9JPyB2j8j2IQHwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779279558; c=relaxed/simple;
	bh=IJMx+i8Mu6WHU+cDuWdCFwHJMt7oGNCG5Om9dpsMNxs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=IRJOw6iXe4hgvv693ovoVBBwlDnY0PIy9pa+S9mLBoGKW/HAI9XJEFgR/CvkDFEi4yRmn5jYCH2dcjICMHf+QsRtOTgIZPZrXDM9gf1oUMASP12jvj/m+UDq2XFKUweUGKmJTYZQagtUU1VGDux2tvTesQneCZbz75hcx02y7KE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LE78MR/V; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LE78MR/V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6A401F00893;
	Wed, 20 May 2026 12:19:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779279557;
	bh=NY+eesJZmdl6r/job1ByzVn4+zsjBUwmiTwMpfEiBaE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LE78MR/VX4HuxLfkO85nCq+LfYP2Jj+mvHsqs5FS80f1NiQqznni9rqDxXqDQrKGX
	 0L3AYZr73v1126KbCDYcYq2lw8IWzbooi73nBmN9FHVabjc0rAHaD3xwTBIbH2kiZG
	 jZMjbCDBgoUziAyKFN04NbkPaiwx0gbaKw8CGMivxPB2toriCzHOInX3kGDBnVcEus
	 vJiUkarAtkKRQJcSSAqKkzn1QAZxWI3PjWkpWpehWb5gwhHX68M+Jtt+D1eWadnuUZ
	 SEc8ZUucpU8qNnvNUlAL1bomou+b43wHRWn6IGa1boB4iQtyz+bXG2JIeWE5ptb12v
	 kxCOY2lowwoAg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf] bpf, sockmap: keep sk_msg copy bitmap in sync
Reply-To: sashiko-reviews@lists.linux.dev
To: "Junxi Qian" <qjx1298677004@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260520112327.189660-1-qjx1298677004@gmail.com>
References: <20260520112327.189660-1-qjx1298677004@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 20 May 2026 12:19:16 +0000
Message-Id: <20260520121916.E6A401F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Incorrect page offset calculation when splitting a scatterlist=
 element in bpf_msg_push_data() causes out-of-bounds memory access.
--

commit 68cddb5ca40528f94f0edb5061db37a66f108a6a
Author: Junxi Qian <qjx1298677004@gmail.com>

bpf, sockmap: keep sk_msg copy bitmap in sync

The sk_msg scatterlist ring stores the actual page descriptors in sg.data[]
and stores the copy-required state for each slot in the parallel sg.copy
bitmap. Several SK_MSG helpers move or split sg.data[] entries without
moving the matching sg.copy bit. This patch keeps sg.copy synchronized
whenever these helpers move, split, replace or remove scatterlist entries.

> diff --git a/net/core/filter.c b/net/core/filter.c
> index 9590877b0714f..cb8628300ac66 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c

[ ... ]

> @@ -2866,6 +2871,7 @@ BPF_CALL_4(bpf_msg_push_data, struct sk_msg *, msg,=
 u32, start,
>  			sk_msg_iter_var_prev(i);
>  		psge =3D sk_msg_elem(msg, i);
>  		rsge =3D sk_msg_elem_cpy(msg, i);
> +		rsge_copy =3D test_bit(i, msg->sg.copy);
> =20
>  		psge->length =3D start - offset;
>  		rsge.length -=3D psge->length;

[Severity: Critical]
This is a pre-existing issue, but when splitting the scatterlist element he=
re,
does the code immediately following this hunk incorrectly advance the physi=
cal
page offset?

net/core/filter.c:bpf_msg_push_data() {
    ...
		psge->length =3D start - offset;
		rsge.length -=3D psge->length;
		rsge.offset +=3D start;
    ...
}

Does this incorrectly advance the physical page offset by the absolute byte
offset (start) instead of the fragment's consumed length (start - offset)?

If the element being split is not the first in the message (offset > 0),
could adding the absolute start offset push rsge.offset beyond the valid
bounds of the physical page, leading to an out-of-bounds memory access?

Should this be rsge.offset +=3D start - offset; or rsge.offset +=3D psge->l=
ength;
instead?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260520112327.1896=
60-1-qjx1298677004@gmail.com?part=3D1
