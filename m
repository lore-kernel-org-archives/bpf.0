Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A208BE9
	for <bpf@vger.kernel.org>; Sun, 14 Jun 2026 01:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781402238; cv=none; b=AC4viEhxJnB1T7KmJL77r49J/zHjXWGUePq1icBQTd59qlaCHz+0h//VO+309nP5WnV9/txuHmBxE5zps4ff5s12MNyzL7IBjXsRf3ajNJNmzVzXptcPQ27OkpY2XwabQx0GK6F0isv0RbQ/i+L13qFit2n58h28nks8PdYvpjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781402238; c=relaxed/simple;
	bh=h+Med/dkD2K51u6dO6t4Wk1Z1LrFP3ES+ovk1n7HlAI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=iUzt81wLLA34pQJVHosMH/cWJBAD18EEiu0+b2OCXKrNWNSTfWM+SDlfn/pt32vmWqDbH9VQ+H9BXsSudFx0Os7Y2/kBrFedqRmMQSdD+0ej8odLL65HN8cZwGrQ1hghwTRP92omVPqYLS/cmmJxSf5Y5JQYtPYvqzHN7nuzYOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KobNB5rS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KobNB5rS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 945AF1F000E9;
	Sun, 14 Jun 2026 01:57:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781402236;
	bh=5Kl46FtC89N5uw3hlkMOVjQGVxYrtxXY/UEusNjF42U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KobNB5rSWIMr56EB0y9am5I2JWuQVtJK+l9s24hrdm7tHIPE1rXDE7fR+0hnu+dnD
	 ZlpRLIN0/buhI+4iQwatHVcaOjcJaikM1CyuXSSx92IsFF98kWZZzwP8wisKtP1vVZ
	 2t9iPomPKynVYGhg5aDJX3JtllKBu4arPdz0LUGKEtbeBBLOoc4uu1hJhfFQrQXlIE
	 ULlB7DVlv6eQH/pammNylPnibhlQ9hpRiPLbZMzwKFZvoutAtxqebXmLR/JfGt5mM5
	 pg4R2XO1zWOkCuYgG8gIbqMr6jom+TOI7Yc6wO/m3MPkInvHeUSWjBxJMwdGc+zrfq
	 u7sTzCtqDj/fw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf 5/6] libbpf: ringbuf: Prevent missed wakeups
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tamir Duberstein" <tamird@kernel.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260613-bpf-ringbuf-fixes-v1-5-e623481cb724@kernel.org>
References: <20260613-bpf-ringbuf-fixes-v1-5-e623481cb724@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 14 Jun 2026 01:57:16 +0000
Message-Id: <20260614015716.945AF1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Early returns in `ringbuf_process_ring()` bypass the newly added S=
toreLoad memory barrier, leaving bounded consumers vulnerable to missed wak=
eups.
- [Low] Multi-line comments introduced by the patch violate the BPF subsyst=
em comment style.
--

commit 1b4f252cfd5df3b60a00d140737f0f9bc3b4ad87
Author: Tamir Duberstein <tamird@kernel.org>
Subject: libbpf: ringbuf: Prevent missed wakeups

This commit addresses missed wakeups in the BPF ring buffer by adding a full
StoreLoad barrier before checking for new data. It ensures either the
consumer observes the producer's update, or the producer observes the
consumer's update and sends a notification. It also updates documentation
and adds a selftest.

> diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> index 9ba6b9ad34983..a3b8f606a91d0 100644
> --- a/tools/lib/bpf/libbpf.h
> +++ b/tools/lib/bpf/libbpf.h
> @@ -1439,6 +1439,10 @@ struct ring_buffer;
>  struct ring;
>  struct user_ring_buffer;
> =20
> +/* A negative return stops consumption; non-negative values continue. St=
opping
> + * can leave records queued without a new readiness notification. Before
> + * waiting for readiness again, consume until no records remain.
> + */

[Severity: Low]
This isn't a bug, but does this multi-line comment follow the BPF subsystem
style? The guidelines prefer the opening /* to be on its own line.

[ ... ]

> diff --git a/tools/lib/bpf/ringbuf.c b/tools/lib/bpf/ringbuf.c
> index 1c24a83f59d5c..ea8909fec4e98 100644
> --- a/tools/lib/bpf/ringbuf.c
> +++ b/tools/lib/bpf/ringbuf.c
[ ... ]
> @@ -267,14 +267,21 @@ static int64_t ringbuf_process_ring(struct ring *r,=
 size_t n)
>  	cons_pos =3D __atomic_load_n(r->consumer_pos, __ATOMIC_ACQUIRE);
>  	do {
>  		got_new_data =3D false;
> +		if (needs_wakeup) {
> +			/* Ensure either this sees a new record or its producer sees
> +			 * the updated consumer position and sends a notification.
> +			 */

[Severity: Low]
This isn't a bug, but should this multi-line comment have the opening /* on
its own line to match the BPF subsystem comment style?

> +			__atomic_thread_fence(__ATOMIC_SEQ_CST);
> +			needs_wakeup =3D false;
> +		}
>  		prod_pos =3D __atomic_load_n(r->producer_pos, __ATOMIC_ACQUIRE);
>  		while (cons_pos !=3D prod_pos) {
[ ... ]
> @@ -294,6 +301,7 @@ static int64_t ringbuf_process_ring(struct ring *r, s=
ize_t n)
> =20
>  			__atomic_store_n(r->consumer_pos, cons_pos,
>  					 __ATOMIC_RELEASE);
> +			needs_wakeup =3D true;
> =20
>  			if (cnt >=3D n)
>  				goto done;

[Severity: High]
If this loop terminates early by reaching the bound (cnt >=3D n) or due to a
negative callback return, consumer_pos is updated and the function returns,
discarding the local needs_wakeup variable.

When ring_buffer__consume() is called again to drain the remaining records
before sleeping, it will initialize needs_wakeup =3D false. This causes the
__ATOMIC_SEQ_CST fence to be skipped prior to loading producer_pos.

Could this allow the CPU to delay the visibility of the consumer_pos store
while reading a stale producer_pos, resulting in the consumer incorrectly
sleeping and the concurrent producer skipping the wakeup notification?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260613-bpf-ringbu=
f-fixes-v1-0-e623481cb724@kernel.org?part=3D5
