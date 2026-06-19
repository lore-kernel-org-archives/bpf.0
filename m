Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C45AA2F851
	for <bpf@vger.kernel.org>; Fri, 19 Jun 2026 00:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781829960; cv=none; b=NPMfzQjvT6VZVWGiG/BXRcCFntQGySNt/PBbYlRwljeOnqpD5wGHKa5/jJXvP2EG73xpEtz1H0+tRzSNhTykey5nXQmj5fO+Mecz88t+9GFop3XZNUmAFH19DA7MC8NwvEkwm0CdbppEN/pg03C8pdnp5/BGsPOIMEN93kjWZoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781829960; c=relaxed/simple;
	bh=+0VRyFVPsJ4a7rS3cuRU6eqL566am4uM5xmSXoPk8aQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=o/xryScLLRTMLryp0jU/C1hTNwiaIInP11Z1BAQ7NXXE/PnmzNAgqybjZQuNsM2q/N1xkybY3YVveJ7pBJXSm40XYIuHHWtMg1SU2IRIpgjLtladPeqcBha/iAbMteBDex40EH0ZddOqBfzGPfTdF1OY5N7B13GNs207Nmu75BQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AIK1OgOm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AIK1OgOm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E1531F000E9;
	Fri, 19 Jun 2026 00:45:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781829959;
	bh=k4jE0Wl8X4KFsoQ3Rf+TI0+voqLbjqcK9ANqlKfVRmY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AIK1OgOmdYymBS6C7qzU5WB3mCuYiwQsqQ7DoCQ15rVhpgPtTXvPvMBdvxP0bnxW9
	 tNeZEfB6JyVCVMtlHbiARQEMzuCe70T7cb4XIU7McGPGsc+yCisEQysNm/8tM+L1G7
	 olzTip/Lsj6sA3nFFNMmVfdC3EPkzyjv6L0abzIUKYAkQ3zpqhEGzRUQLaQ8AOYIu4
	 LWX+DYWw0M+SZD74i0cdE+44k+p3TELIQEFnFVa+GOtlM+jPZ4VDUrYheE6iwHzp8f
	 ddQK7jFRpvftPHaN4ot7ksYst6Yw0rpew59EHzKqRnf/b9r+s+2pmQLXASPUA8N9SH
	 uQybkyWAGOzHg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf v2 5/8] bpf: ringbuf: Handle pending position wrap
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tamir Duberstein" <tamird@kernel.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260618-bpf-ringbuf-fixes-v2-5-33fde039ddf3@kernel.org>
References: <20260618-bpf-ringbuf-fixes-v2-0-33fde039ddf3@kernel.org>
 <20260618-bpf-ringbuf-fixes-v2-5-33fde039ddf3@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 19 Jun 2026 00:45:58 +0000
Message-Id: <20260619004559.4E1531F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] `ringbuf_avail_data_sz` incorrectly uses the `max()` macro on wrap=
ping `unsigned long` counters, leading to erroneous available data calculat=
ions on 32-bit systems.
--

commit c0d823f17573cdb3b8da49e472d0ae2b71115825
Author: Tamir Duberstein <tamird@kernel.org>

bpf: ringbuf: Handle pending position wrap

This commit fixes a counter wrapping issue on 32-bit systems in
__bpf_ringbuf_reserve(). It ensures the pending position continues to
advance after the producer position wraps by changing the loop condition
from a magnitude comparison to a check for equality.

Closes: https://lore.kernel.org/bpf/20260614020552.022A11F000E9@smtp.kernel=
.org/

> diff --git a/kernel/bpf/ringbuf.c b/kernel/bpf/ringbuf.c
> index 35ae64ade36b8..909880031fd38 100644
> --- a/kernel/bpf/ringbuf.c
> +++ b/kernel/bpf/ringbuf.c
> @@ -482,7 +482,8 @@ static void *__bpf_ringbuf_reserve(struct bpf_ringbuf=
 *rb, u64 size)
>  	prod_pos =3D rb->producer_pos;
>  	new_prod_pos =3D prod_pos + len;
> =20
> -	while (pend_pos < prod_pos) {
> +	/* Positions wrap; pending_pos cannot logically pass producer_pos. */
> +	while (pend_pos !=3D prod_pos) {

[Severity: High]
This is a pre-existing issue, but I noticed another problem with counter
wrapping on 32-bit systems.

kernel/bpf/ringbuf.c:ringbuf_avail_data_sz() {
    ...
    if (unlikely(rb->overwrite_mode)) {
        over_pos =3D smp_load_acquire(&rb->overwrite_pos);
        prod_pos =3D smp_load_acquire(&rb->producer_pos);
        return prod_pos - max(cons_pos, over_pos);
    ...
}

Does the use of max() on wrapping unsigned long counters here lead to
erroneous available data calculations?

If over_pos wraps and becomes numerically smaller than a stalled cons_pos,
max() will incorrectly evaluate cons_pos as larger. This evaluates the
available data as prod_pos - cons_pos instead of prod_pos - over_pos, which
could inflate the reported available data size up to 4GB.

Additionally, if prod_pos exactly laps cons_pos by a multiple of 4GB, the
calculation would yield 0. Could this cause ringbuf_map_poll_kern() to
erroneously block the consumer in an infinite wait despite the buffer being
full?

>  		hdr =3D (void *)rb->data + (pend_pos & rb->mask);
>  		hdr_len =3D READ_ONCE(hdr->len);
>  		if (hdr_len & BPF_RINGBUF_BUSY_BIT)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260618-bpf-ringbu=
f-fixes-v2-0-33fde039ddf3@kernel.org?part=3D5
