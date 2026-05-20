Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B1243DA5B4
	for <bpf@vger.kernel.org>; Wed, 20 May 2026 11:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779275150; cv=none; b=Ao8mWqqmFIaATW3m2M0bOtUEutuR6/d4GM5aUP00a1kCasIFOXX+dl2hCw3z4sDgwv9+kPlB2pc6OvgF/LjUk41axBkgvArLhWe4RE3081CSyZdtepYdg5fNI4nasK+ZyNJeFBYhqrF8v3eaP/d2SF4GPNQRJfYVXSRMMg7oq4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779275150; c=relaxed/simple;
	bh=5LOlDBPKSoEynAlUJ+DSaFBjFlxJGbIr4HccS0LkZDo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OANqJaJulKs/o17+QiXsHWZ20nXoaPom/aTbJqfVOdHHG/NfSlhqCNXNKkf0hdNaImjeyI4KxUHjq+q4P9m8BTERou27LnKdnvH9Ve9ENF5SXkNIlAeu+RpaHraxTQ1QkZBlZMvvvPb/sn8lONB3ffVwN811jtoQ3JxFOpY/h40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mDipouo+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mDipouo+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADEE61F000E9;
	Wed, 20 May 2026 11:05:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779275148;
	bh=VXXf1PqFOw6wNXcQ9PBu0Xt0SLzAOTEvZBOS/3pxgk8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mDipouo+fcGRApw/FCDh+ecsYajS1scrUwWvSheiHPJ1bg4YDTBY/mauLxVg/PUER
	 nsnv6VrYPZNYZ5cjBqJ3Qn8M+rij5hhtmMB2ulCsojyfrxWSAxLXP6a+s+fgxOrr0V
	 D6FskJaYn8/4i8ZEIZKNrFEKK+vU0cHZuywwmyAG9wmdir2wwd/YZktolYuVeDfZzr
	 mrKgVQp/VAJ8t0i9lBGqqI9zujl6F4QVM2+W0PCEBQNery4aDDguR+RrNxPDiAKEpV
	 hFE4m0WyXJhY7QonojRJP4e99BQFm0rshVtlfN0ibANp19UTWY5g6qoIxvqigXVSCZ
	 pwQKoF0zWZP6w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] bpf, sockmap: keep sk_msg copy state in sync
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zhang Cen" <rollkingzzc@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260520102715.3033936-1-rollkingzzc@gmail.com>
References: <20260520102715.3033936-1-rollkingzzc@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 20 May 2026 11:05:48 +0000
Message-Id: <20260520110548.ADEE61F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Ring corruption in bpf_msg_push_data when appending to a full scat=
terlist.
--

commit c4e213a048393606104380e6b6ccec8ae3ad1422
Author: Zhang Cen <rollkingzzc@gmail.com>

bpf, sockmap: keep sk_msg copy state in sync

This commit synchronizes the msg->sg.copy bitmap with scatterlist element m=
oves
during bpf_msg_pull_data, bpf_msg_push_data, and bpf_msg_pop_data. It prese=
rves
the copy bit when an entry is split, and clears it when a helper replaces an
entry or vacates slots.

> diff --git a/net/core/filter.c b/net/core/filter.c
> index 9590877b0714f..223d787084863 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
[ ... ]
> @@ -2891,23 +2935,34 @@ BPF_CALL_4(bpf_msg_push_data, struct sk_msg *, ms=
g, u32, start,
>  	/* Shift one or two slots as needed */
>  	sge =3D sk_msg_elem_cpy(msg, new);
>  	sg_unmark_end(&sge);

[Severity: High]
This isn't a bug introduced by this patch, but is it possible for a BPF pro=
gram
appending data to a full scatterlist to corrupt the ring here?

When appending data (start =3D=3D msg->sg.size) and the scatterlist is full
(space =3D=3D 0), the earlier loop finding the start element terminates with
i =3D=3D msg->sg.end. At this point, msg->sg.data[msg->sg.end].length is
guaranteed to be 0 because inactive elements are zeroed.

Because the length is 0, the variable copy becomes 0, and the
fallback-to-copy branch (if (copy)) is skipped. The code falls through to t=
he
normal insertion path.

Just above this hunk, the normal insertion path executes:

	/* Slot(s) to place newly allocated data */
	sk_msg_iter_next(msg, end);

Since the ring is already full (sk_msg_elem_used(msg) =3D=3D MAX_MSG_FRAGS),
unconditionally advancing msg->sg.end causes it to overlap exactly with
msg->sg.start.

Doesn't this corrupt the scatterlist ring by making sk_msg_iter_dist()
calculate the distance as 0, which would make the message appear empty and
cause packets to be dropped?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260520102715.3033=
936-1-rollkingzzc@gmail.com?part=3D1
