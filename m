Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87C5837BE73
	for <bpf@vger.kernel.org>; Thu, 30 Apr 2026 22:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777588291; cv=none; b=HBEIha/KnOfxUwgC1nYAD6H1BvBjQftBwZZ10KiljMiEmkb1F71HU1vMgRzrn2LnTkjAVWHxanCTic1PaL+Qp91p9RU2xCLakF9ISjuJYJji2c9v0tDd5mpINOfftTaCPqDNTPhCjSkNWlWiiIwi2YlcU2PIs2XrTQ9azVjY5Zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777588291; c=relaxed/simple;
	bh=mH57QCKGkn1L2tzDelsm+Z04qL5JqWlS9uyvjPjBH4k=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Yfh7WJCMYn8wlOA+3A+Asow/BiqE3mgHpBUzkL09gHj93q6czqQr0ZuuQxxfO5CnEofDtNJpKMpD2A45GqfgUMXynWdAg6eFeQz9JhG7iHNHlPq/DQCFgfqexxLH0NVoeFKYZnAbp23B102vWQB2WnzGRq0/2WUlaY4QA/25rjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PKHB7LKT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PKHB7LKT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33668C2BCB3;
	Thu, 30 Apr 2026 22:31:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777588291;
	bh=mH57QCKGkn1L2tzDelsm+Z04qL5JqWlS9uyvjPjBH4k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=PKHB7LKT9sZwTyI0mh5e5Mgmo+KvgaP5enChr61PLMJIRuzBd5SnZ9cLB4h4d1aQk
	 iJfCVtJCqPa5mAi1C3Jat63ZPp2Ly7Cyb4QYsPGIlnSnfEDIWhwzabJk7i7QGk/6ET
	 RM2vtEfIsEdf76dKiolONTIVdZ9i2ZqaK8cLHAXH+3v12zUv521BeN3A3PddD+SvrV
	 y1ikZ4EXCsjOA48Wl6vHiQi5Pqv7Ej9ixPP27lqaTFoO1pxOZkrMLml98byprFCawW
	 C0iLAq0LJ1PyerKfEzruc2sECYjgJecWm4XAlIQrfCg8xZsy+DtSh8L8mScj9FYLK5
	 wI7kt/1nYg4uw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net 3/7] net: tls: fix page pin leak on sendpage_ok()
 failure
Reply-To: sashiko@lists.linux.dev
To: "Jakub Kicinski" <kuba@kernel.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260429222944.2139041-4-kuba@kernel.org>
References: <20260429222944.2139041-4-kuba@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Apr 2026 22:31:30 +0000
Message-Id: <20260430223131.33668C2BCB3@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Incomplete fix for page pin leak: dead code in the error path and =
a permanent leak on the success path for user-backed iterators.
--

commit 6f0253d94e63d44e6e53f2c84d2aead405564b2b
Author: Jakub Kicinski <kuba@kernel.org>

net: tls: fix page pin leak on sendpage_ok() failure
   =20
When iov_iter_extract_pages() is called on a user-backed iterator, it
pins the extracted pages via pin_user_pages_fast(). If the subsequent
sendpage_ok() check fails, both tls_sw_sendmsg_splice() and
tls_push_data() (device offload path) call iov_iter_revert() to unwind
the iterator position, but iov_iter_revert() only adjusts the cursor -
it does not release the page pin taken by the extract.

> diff --git a/net/tls/tls_device.c b/net/tls/tls_device.c
> index 99c8eff9783e..77922e72c685 100644
> --- a/net/tls/tls_device.c
> +++ b/net/tls/tls_device.c
> @@ -508,6 +508,8 @@ static int tls_push_data(struct sock *sk,
>  			copy =3D rc;
> =20
>  			if (WARN_ON_ONCE(!sendpage_ok(zc_pfrag.page))) {
> +				if (iov_iter_extract_will_pin(iter))
> +					unpin_user_page(zc_pfrag.page);

Is this error path reachable for user-backed iterators?

sendpage_ok() only returns false for slab pages or pages with zero refcount.
User pages extracted via pin_user_pages_fast() will always have a positive
refcount and are never slab pages.

Additionally, does this code leak the page pin on the success path?

On success, the extracted page is passed to tls_append_frag(), which acquir=
es
an additional standard page reference via get_page(). The original FOLL_PIN
reference (which includes GUP_PIN_COUNTING_BIAS) is never released by TLS.

When the packet is eventually transmitted and freed, the network stack calls
standard put_page() (via __skb_frag_unref()), which drops only the standard
reference. The pin bias is never cleared, causing a permanent memory leak on
every successful extraction.

If the intent is to support user-backed iterators in MSG_SPLICE_PAGES paths,
this same unpin omission appears to exist in the core MSG_SPLICE_PAGES help=
er
skb_splice_from_iter() as well.

>  				iov_iter_revert(iter, copy);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260429222944.2139=
041-1-kuba@kernel.org?part=3D3
