Received: from mail-24430.protonmail.ch (mail-24430.protonmail.ch [109.224.244.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B38FE3769F4
	for <bpf@vger.kernel.org>; Sat, 17 Oct 2026 05:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792215715; cv=none; b=bOyYm/H+FjcjVjor22qlLdW0aYFxyVBeE9m8bV1Ov008o27v4mZ+uN010xQeYWYE6lscijgrpQn4NalPS2qGyqRUvRIvUNlCxXcoiAfdvngly7GmWXscUJsKnWhIk5lNODaR+zSOiN/pqzHY6a50+YA08Rrg7dzRJ2rqU9DwNQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792215715; c=relaxed/simple;
	bh=oWP3CqfdKkrmUn2Fd9aCN1Hyf60aN5vW+HfRq/d7rFE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Oh7t/ple9//jaWZ/JneJskYbCXdwhTfifARwgeOTjcSYrvYz9quxSi3SwP7UZ6O7gL8va2o1KsX32xHj6GK1PE5xyUpeakBXYBxegn4LaadkkB+gmLHcI3WZ6gfx9qR4HmN6Jyl24de7zBWIVGdiFY4jOj+P9vGOs+fF112LKtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=D6/E31TR; arc=none smtp.client-ip=109.224.244.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="D6/E31TR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail2; t=1792215702; x=1792474902;
	bh=oWP3CqfdKkrmUn2Fd9aCN1Hyf60aN5vW+HfRq/d7rFE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=D6/E31TRwTP1tAd5S/DtmzkSI+rEA9VnjMTkn4h349sXjZzcM82r5Q4LaOynE5j61
	 CdPLqqCGlt6Brfcp24j8/PHrUinuTZeeVV9r2HpyrsuEIazjyUJqs0YsfJ7MAzqJT4
	 OavgscVzOW5afc7p9+UXFNSVwYoH1XqnLbzNrv069RYX92SREz15Z1xnqPN7r7ffxn
	 uDoMf9l9rvD9JHlEtpAG+mBP/MayOTm3L0y+Yhr9bS/JJTTN29fYs8dxVU+AIgrXVp
	 9pCA0A+tw47DZKWVpET0hILd3LbNmhy9AP0vQ0hrF/lJ1GVirF3Yfj66OL3dwkLwZM
	 UZF7QzxEh5zxg==
Date: Sat, 17 Oct 2026 05:41:39 +0000
To: sashiko-reviews@lists.linux.dev
From: quanyeyang <quanyeyang@proton.me>
Cc: bpf@vger.kernel.org
Subject: Re: [PATCH net-next v4 1/2] tls: annotate lockless access to sk->sk_err
Message-ID: <0f_f65bKzWrIKpD02o0Zog8DXgvCojjB6E0_p64jFcUQXJf6eKe3LZ_r2AyAMoKP5m0rnzWidmndN0la2vYX7POrm0tVKb1QZJlj_FcCXGs=@proton.me>
In-Reply-To: <sashiko-outbox-175251@kernel.org>
References: <20261015-tls-fix-sk-kcsan-err-v4-0-391d788327f3@proton.me> <20261015-tls-fix-sk-kcsan-err-v4-1-391d788327f3@proton.me> <sashiko-outbox-175251@kernel.org>
Feedback-ID: 206494642:user:proton
X-Pm-Message-ID: 97b58392f95c42aed3c0916396b98545d01989af
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Friday, October 16th, 2026 at PM 8:31, sashiko-bot@kernel.org <sashiko-b=
ot@kernel.org> wrote:

> Can a concurrent lockless call to getsockopt(SO_ERROR) clear the
> error state here?

Yes, sock_error() can xchg() sk_err to 0 without the socket lock.
That window is pre-existing. tls_encrypt_done() still keys off the
crypto completion's err for this record's own failure; a stolen
prior abort is the same as the old unmarked load seeing 0.

> If a concurrent lockless call to getsockopt(SO_ERROR) consumes
> and clears the error, the READ_ONCE() here might return 0
> instead of EBADMSG.

Also pre-existing. tls_push_record() still reports a synchronous
encrypt failure only by tls_err_abort() and returns the raw crypto
rc. The caller then peeks sk_err =3D=3D EBADMSG to free the chained
open record. Folding the two loads into one READ_ONCE() does not
open that steal; closing it means returning the failure to the
caller instead of round-tripping through sk_err, which is a
separate change.

