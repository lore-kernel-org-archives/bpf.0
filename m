Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794117817;
	b=Z9MBvmJOvpJi6qCTFhumS/4JxpnJnlEdKU+eVSrvbEISqVdYDFyWeDvugf03dE74HZEZ
	 v3L4uDaH1FAmgcnrUR/+o50TFb5So1iezzVfNWweV/CV9l9Lo5LcC6STByEVesgqvQtO5
	 yCLskXwMrMd3+YjaA4OE7McNNR8fzJ0KFHxCJH/bjuvRTbTeclhXYCn+3k/Ljx96vij/l
	 sxgse/CATCkrVKFTdvNYiis9danXOm5JdKzDU2GNeutqhwjfJ7UpVY769L033V6l5sBvR
	 JLHjZ9Zz2scEkhDeLQo1rEI0b3byYrMFYmZvpPwNc91ZDDiiA+qhTKinUioZD3TPfOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794117817;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=pn04r+CxxQfFBcY2E/mrXMo112h8EUm1UiRUAJTxpSs=;
	b=DS6x81bMOqK58EHutLC8A0SG+yXJ2F2XEVaOSZfKgWw+VqVR/QnvtB7/zRqee+H//+Xu
	 gG+iUyCloBrq/q2gdbv06z40lxVSx9WFOm2lmPXW47AZU0Z9b/UJKAXf73holHjenK0J1
	 HBYB/734rZouYMqy9Mg74wRnEU47qxQOWb9niombS3p3uW2EU6EYxRTPzAJXVKhTPKRTa
	 E9WawrIW8GVJsVRiEfBHjMx2/d67mkyG8j+6gtTLSpVh95dMfRrJTOi/FecAOIDpPYl2S
	 C95wD9VtYVCvbEO0e3UZgZFQoqzTIIO3qvgKipZjbJqTfjY70h79E2KFoKszYOpntgw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fsZo+zLR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FDD1606A31A
	for <bpf@vger.kernel.org>; Sun,  8 Nov 2026 06:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fsZo+zLR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 033901F0089F;
	Sun,  8 Nov 2026 06:03:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794117817;
	bh=pn04r+CxxQfFBcY2E/mrXMo112h8EUm1UiRUAJTxpSs=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=fsZo+zLRV5EFMPM5ef5SgjlrS9T6ogpRbKtLnJYMEyslZS53be2KEHkte8nPVRmRx
	 a1XHvhgDxnGrnJnwqzplirF2d4yaSMrqnmqgUHL+VN2ClmzBHQo0hcJ0VP9tviICre
	 3wugTHWFOP97cZn1zqhY/FPN1/YDvcVpRgblcIJqll/giKeaYL7atdoTDCwqn9qUnK
	 lur4KNSsyLYGxOyh5/LLc1yZ1zoKWXL6MQQ7PX9cpdUsI1MVCAboF2xKMP2+NqHMk4
	 6mvx+xxAIl4SMkZ2Y1vjglNwZmGRJKy7DRABp9zQOulrZYz+DvLQJ3dqw+NrX2gbvc
	 Cu74DBoM0aqnw==
Message-ID: <sashiko-outbox-203595@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 1/2] bpf: Take the end of the verifier log out
 and append it later
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
In-Reply-To: <20261108053937.4134138-2-alexei.starovoitov@gmail.com>
References: <20261108053937.4134138-1-alexei.starovoitov@gmail.com>
 <20261108053937.4134138-2-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 08 Nov 2026 06:03:36 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] bpf: rolling log window corruption and bad NUL cut in
  bpf_vlog_unstash()
--

commit 77a6b70f8e6a46314ce083390eb008b9b5d0b118
Author: Alexei Starovoitov <ast@kernel.org>

bpf: Take the end of the verifier log out and append it later

This commit adds bpf_vlog_stash() and bpf_vlog_unstash() to copy the tail
of the verifier log out of the user buffer, reset the log position, and
append the stashed text later.

> diff --git a/kernel/bpf/log.c b/kernel/bpf/log.c
> index 1253118dfd051..84659a757b43c 100644
> --- a/kernel/bpf/log.c
> +++ b/kernel/bpf/log.c
> @@ -177,6 +177,53 @@ void bpf_vlog_reset(struct bpf_verifier_log *log, u6=
4 new_pos)
>  		log->ubuf =3D NULL;
>  }
> =20
> +/*
> + * Take what was written since @pos out of the log. bpf_vlog_unstash() a=
ppends it to what is
> + * written in between. The text is in the buffer of the user and nowhere=
 else. What the buffer
> + * doesn't hold, the start of the text if it's rolling and the end if it=
's fixed, is counted.
> + */
> +int bpf_vlog_stash(struct bpf_verifier_log *log, u64 pos, struct bpf_vlo=
g_stash *stash)
> +{
> +	u64 from =3D max(pos, log->start_pos), to =3D log->end_pos, i;
> +	u32 off, n;
> +
> +	if (!log->ubuf)
> +		from =3D to;
> +	else if (log->level & BPF_LOG_FIXED)
> +		to =3D clamp(log->len_total - 1ULL, from, to);
> +	stash->lost_start =3D from - pos;
> +	stash->lost_end =3D log->end_pos - to;
> +	stash->len =3D to - from;
> +	/* as large as the buffer at worst: fail before the OOM killer is calle=
d */
> +	stash->buf =3D kvzalloc(stash->len, GFP_KERNEL_ACCOUNT | __GFP_NOWARN |=
 __GFP_RETRY_MAYFAIL);
> +	if (!stash->buf)
> +		return -ENOMEM;
> +	/* two pieces if it wraps around */
> +	for (i =3D from; i < to && log->ubuf; i +=3D n) {
> +		div_u64_rem(i, log->len_total, &off);
> +		n =3D min(to - i, log->len_total - off);
> +		if (copy_from_user(stash->buf + (i - from), log->ubuf + off, n))
> +			log->ubuf =3D NULL;
> +	}
> +	bpf_vlog_reset(log, pos);
> +	return 0;
> +}
> +
> +void bpf_vlog_unstash(struct bpf_verifier_log *log, struct bpf_vlog_stas=
h *stash)
> +{
> +	u64 i, n;
> +
> +	log->end_pos +=3D stash->lost_start;
> +	for (i =3D 0; i < stash->len; i +=3D n) {
> +		n =3D min(stash->len - i, sizeof(log->kbuf) - 1);
> +		bpf_log(log, "%.*s", (int)n, stash->buf + i);
> +		cond_resched();
> +	}

[Severity: Medium]
Can advancing log->end_pos by stash->lost_start without updating
log->start_pos leave an unwritten gap inside the rolling log window?

When a rolling log has wrapped past pos (log->start_pos > pos),
bpf_vlog_stash() records stash->lost_start =3D log->start_pos - pos and cal=
ls
bpf_vlog_reset(log, pos), which resets both log->start_pos and log->end_pos
to pos.  After intermediate text is logged up to E1, bpf_vlog_unstash()
adds stash->lost_start to log->end_pos (advancing it to E2) without
writing to log->ubuf in [E1, E2) or advancing log->start_pos.

This relies on the replay loop emitting log->len_total - 1 bytes so
bpf_verifier_vlog() pushes log->start_pos up to E2.  If the loop emits
fewer bytes (for example, because another thread wrote a zero byte into the
user buffer, or bpf_vlog_reset() earlier shrank log->end_pos -
log->start_pos below log->len_total - 1), log->start_pos stays below E2 and
bpf_vlog_finalize() rotates the NUL terminator at E1 and stale bytes in
[E1, E2) into the middle of the caller's log buffer.

In addition, because the replay loop formats stash->buf in chunks of
sizeof(log->kbuf) - 1 bytes via "%.*s", a zero byte in one chunk only
truncates that chunk in vscnprintf() instead of cutting the rest of
stash->buf, while still advancing log->end_pos by fewer than stash->len
bytes.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261108053937.4134=
138-1-alexei.starovoitov@gmail.com?part=3D1
