Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D7261AA7A6
	for <bpf@vger.kernel.org>; Fri, 19 Jun 2026 00:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781829609; cv=none; b=Ep8EjDvc+dTpTCZJiNdaTWbTUrLDaO2UL5aEWiVUy7uPlcQJbY4x4RyroRgnGyj9HAi3G/TyBPKrzlp1oDaejLoXXAwQ7I42sM2InT0mxQTHisB3TkRf74vTSCoWgDwg184nWUzyesKKa8PxJP8S7OYh7kJCNN8VmS0WUtfJAiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781829609; c=relaxed/simple;
	bh=EXIT5RGyfuhoS/WkIWWuPRTwkA00jZ8ZWI15RPpLiGI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dM9fzJpTO8JdrhFq9JHZlrzOWn4HmXkVLgb6F6NJVMVCCIVta6piBaw6Se/WtQXSE4C2MwbSboHWXjtC0S8Mk/tuv1/GV2bD8uUef31445BVH9Ey7ut+sibUQsoMz4qnjcjjeyRHe6guOwAHfqybc+z/nc2/cnf/aRPpIpvpLe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MgEYMAG1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MgEYMAG1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA5461F000E9;
	Fri, 19 Jun 2026 00:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781829608;
	bh=yUI01W4q1O+dt7pUc4JlyMuCeRk3PPshNukGA+XVS+U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MgEYMAG1jActOqfJ0BBTqxenTIDCGgtA6tSivL5L9/ofoJjKHPmusf4HsoIHdqeos
	 VXXOTvPvQuwO2iXHr9GkJLE+W/ic6V8Z0lxqgqn4YIzPb8GKpwp5SA+8cxuD3kbKym
	 LBB0WcpMYtSUEufRYJ7YSpc6C7K+9qlDsBhpEWTTpdgAK/0lHP8zJPfaXgG/WYi7YY
	 Tj9qk1W5v9f1BPAa7jJ9rJjIrot84hDlIa199nNw6u0HyiybUunZYTDpHT/IM925XE
	 qBuzA6UX91uUqOZqAqDSiTPvTVURrJ65sBChd8+tB3B77NIJ5OVT7Ghust7dmKmKis
	 GQthvAIkH6RXw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf v2 6/8] bpf: user_ringbuf: Handle position wrap
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tamir Duberstein" <tamird@kernel.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260618-bpf-ringbuf-fixes-v2-6-33fde039ddf3@kernel.org>
References: <20260618-bpf-ringbuf-fixes-v2-0-33fde039ddf3@kernel.org>
 <20260618-bpf-ringbuf-fixes-v2-6-33fde039ddf3@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 19 Jun 2026 00:40:07 +0000
Message-Id: <20260619004007.EA5461F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] ringbuf_avail_data_sz() uses max() for wrapping counters, yielding=
 incorrect availability estimates after wrap-around on 32-bit systems.
- [High] 32-bit user-space processes on a 64-bit kernel will permanently st=
all the ring buffer upon crossing the 4GB counter boundary.
--

commit ffd4323e55c15970e65b2c3f90be01a022bf7ad4
Author: Tamir Duberstein <tamird@kernel.org>

bpf: user_ringbuf: Handle position wrap

This commit fixes an issue where user ring buffer positions are widened to =
u64
before comparing and subtracting them. This caused producer_pos wrapping be=
low
consumer_pos on 32-bit systems to appear as backward movement, permanently
stalling the ring. The patch keeps the positions word-sized and derives
available data using word-sized subtraction so arithmetic wraps with the
counters.

Closes: https://lore.kernel.org/bpf/20260614020552.022A11F000E9@smtp.kernel=
.org/

> diff --git a/kernel/bpf/ringbuf.c b/kernel/bpf/ringbuf.c
> index 909880031fd38..19cbb9b74ee7c 100644
> --- a/kernel/bpf/ringbuf.c
> +++ b/kernel/bpf/ringbuf.c

[ ... ]

> @@ -759,8 +759,11 @@ static int __bpf_user_ringbuf_peek(struct bpf_ringbu=
f *rb, void **sample, u32 *s
> =20
>  	/* Synchronizes with smp_store_release() in __bpf_user_ringbuf_sample_r=
elease() */
>  	cons_pos =3D smp_load_acquire(&rb->consumer_pos);
> -	if (cons_pos >=3D prod_pos)
> +	avail =3D prod_pos - cons_pos;

[Severity: High]
This isn't a bug introduced by this patch, but does this 64-bit subtraction
fail to account for the 32-bit wrapping behavior of a compat userspace
producer?

The shared producer_pos and consumer_pos counters in struct bpf_ringbuf are
defined as unsigned long, making them 8 bytes on a 64-bit kernel but 4 bytes
for a 32-bit user-space process.

When a 32-bit user-space process updates the counter, it only updates the
lower 4 bytes. Upon reaching 4GB, it wraps to 0, leaving the upper 4 bytes
as 0. The 64-bit kernel reads this as a massive backward jump to 0.

Since avail is evaluated as an 8-byte unsigned long here, the subtraction
underflows to a huge 64-bit number (e.g., 0xFFFFFFFF00000020).

> +	if (!avail)
>  		return -ENODATA;
> +	if (avail > ringbuf_total_data_sz(rb))
> +		return -EINVAL;

[Severity: High]
This isn't a bug introduced by this patch, but will a 32-bit user-space
process on a 64-bit kernel permanently stall the ring buffer upon crossing
the 4GB counter boundary here?

Due to the underflow mentioned above, the massively inflated avail value
fails this bounds check. This causes __bpf_user_ringbuf_peek() to
permanently return -EINVAL.

Could we use (u32)prod_pos - (u32)cons_pos to natively wrap at 32-bits,
mitigating the issue for compat userspace since the ring size is inherently
bounded by 32 bits?

[ ... ]

[Severity: High]
This isn't a bug introduced by this patch, but does ringbuf_avail_data_sz()
yield incorrect availability estimates after wrap-around on 32-bit systems?

In ringbuf_avail_data_sz():

kernel/bpf/ringbuf.c:ringbuf_avail_data_sz() {
    ...
    if (unlikely(rb->overwrite_mode)) {
        over_pos =3D smp_load_acquire(&rb->overwrite_pos);
        prod_pos =3D smp_load_acquire(&rb->producer_pos);
        return prod_pos - max(cons_pos, over_pos);
    ...
}

The available data calculation for overwrite mode uses max(cons_pos,
over_pos). Because these counters wrap around at 4GB on 32-bit systems,
the max() macro will incorrectly evaluate a wrapped counter (e.g.,
0x0000000A) as smaller than an unwrapped one (e.g., 0xFFFFFFF0), even
though it is logically ahead.

This causes the function to calculate the difference from the wrong
offset, resulting in inaccurate data availability metrics, which can
lead to spurious or missed epoll wakeups and garbage values returned by
bpf_ringbuf_query(BPF_RB_AVAIL_DATA).

Should a wrap-safe macro like time_after() or simple signed modulo
arithmetic be used instead?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260618-bpf-ringbu=
f-fixes-v2-0-33fde039ddf3@kernel.org?part=3D6
