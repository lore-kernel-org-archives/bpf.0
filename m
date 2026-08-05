Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C47E5363C77
	for <bpf@vger.kernel.org>; Wed,  5 Aug 2026 19:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785957078; cv=none; b=i7MTPcKDPJLtVkIyaJxYRVElb/4aTVLgUoKEg9rrG0c5ORYOD0HLxjO4y6l7yVbYCnWn5tCdqARkBy2Hzc48hjkh1eZcTv7eUw7/U7tFck+7sxX7cmjtziArymHiimaBN1Tvdy21Zkpsz6pSGA4qxEKEWkChiV/Ylu9d7QAVNyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785957078; c=relaxed/simple;
	bh=ABibOQhRKEkJ5Z7RlOGWN/W6GHglQEeBkb06ShZCBxQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NdgAReIzwbFaa+e8eIa1fJsd57f1mrz/roWo4dCZiJ0mfl1xXbrRw8ejpO1etBqOdYcbCM7KPwbFsHYC1yopElNZoX5ZsSGcxB+P1H3L1Jye6RDrefz1obwCOfIY/A2G7DOOSJel7KqJ+dT2IAAyNFM12ihWFuEamSiRwBuktXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kDw2i4SI; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kDw2i4SI"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-381c51fde6bso1647032a91.2
        for <bpf@vger.kernel.org>; Wed, 05 Aug 2026 12:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785957076; x=1786561876; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=I7hjVAHGdf1AofJ8dQPpNKe6ZkD0DreBSwgYMDrzLu4=;
        b=kDw2i4SIvrArPfDtqr+oHqIon2NDYmUGXHlSPiBGNy5FiMz8SIjRdL5go1Rzt49EMK
         xywousn5oGaAjQy5svF/69y4xBWN2t2ZeivGG4QiVVzHQIpw4hAR0ell6FGlTyz6GZaA
         pBjQvo7ySdulXKo5Ov96yODgXGL2Vp7BXYn1lt1ZD7rx3/ie9xq1t2FGhPqa200DnhCs
         sMcvnu2Ym03Ew+Hu6SVsQgpMaGz+VCvE77V2Wj+vx6enhENJ+cUss+Kw3UdRVhsHcL0M
         u83wcM3f8lIwIcwAQh2c8TIrq8r5nOFn4kjSRu0AomD8vRruSPlcOwGHzlIiwZoXPkXG
         8Fmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785957076; x=1786561876;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=I7hjVAHGdf1AofJ8dQPpNKe6ZkD0DreBSwgYMDrzLu4=;
        b=NncBVz32VdYZRS3Lg4BcCOK1yYrSSuOkY3u9E9v0qKTlRRKYJYbBvQokvmIyKu4d0Y
         Hce7DpGzvZ7YROF1K6nQs3z2x6fLtX2+ZljHQc7MzRgvOMWqv3/S3lefztER6SnzDFKN
         98aYk5zodoxMXQ+4dgEGh9NwBwCJpe/n9J0Mh8ZRX0Nkfr6WPSGt1Oy+BNNXFCDIuH14
         EOgjyLq5lPyN3dkzbk9TPU9oYoHZ7MdBwDpQvRXM2G4oDocXYDGQrt76r6p1q2OOTJt6
         txfA/u3EccDUVI3HxydvKXBVxTod0bKUGcjx5GDs7dOUNJY3vPTFjfZbU9xJrE7MdQ1Q
         9IxQ==
X-Forwarded-Encrypted: i=1; AHgh+Ro7pNaJhIlcs+81iy2rYstzZtsRAb+PktmUu1nPnAWj9ixZp2E75pYdwua/i2965pqCfRw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQAcFZtIp68y8K0SE/otueBTIhVUWNu3CZ3dKYBgbc87va7e3z
	hWFH/NfcnfVOkw5f2tc30cMTQEF36v0imj3GeGcgV+9hwRrf+zRi6MaAihJNlY0A
X-Gm-Gg: AR+sD11U6UVFpIZvf7bsy6nkJflZrHpKOB8iSciFEOU03XpuwFjenPcaQqQN8lgfWSb
	ycn+lJ4K3gwaa7FQ0Z7xXeXKRrS26w5n7jjXHA2u19IzhRu4q5+SknaB2wK6xVOHE/ZEeguVHdV
	yQ7qEDQDchdLk7zWkLLyRRnDcgLD++Hr6AbUiBId2TxuBCH8wbYuySJEbE7rBjoyNtY2lXqhZqZ
	7/VZELHLEQ/0tJdsz+9T/TzvW/urwTY7Q0f3zmQQBPHs1bSxbOXV2XF2kCRfj4B+6bqU11RQfPU
	IoFtmwhMlwN+Xv+sioHQW0D4C/97HOoq+2xphxtpg79OYbJTEoANTZbMZ8GE9w6iV0FqIHMhbL3
	cosi3ZZ8C6qHOGd3jCVuUo5minS9wh6mrSCQzkRcFqaB9DKSuGO3fRwTzU/KtMw2BOTUI9eNXBS
	n9sl64lnusG+C75AERD7CNE+IrY8q4QhV6/NOidawl0KOkqO6oX0shct1knkzlR0kxZAvUm/E6A
	gmQlk9gH4/Q5ata8EGioieM+VKKs2FKXcszDDirisu9pQ==
X-Received: by 2002:a05:6a20:d529:b0:3b1:cce5:9140 with SMTP id adf61e73a8af0-3cb85f4a5b8mr11485747637.33.1785957076060;
        Wed, 05 Aug 2026 12:11:16 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:9442:4c04:9302:a907? ([2620:10d:c090:500::5:6ebe])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13fca8df89asm30878776c88.9.2026.08.05.12.11.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 12:11:15 -0700 (PDT)
Message-ID: <d8c2a4de77327f4c3cde8aed4d95aacc915ffa18.camel@gmail.com>
Subject: Re: [PATCH bpf-next 1/4] bpf: Mark pending sub-register zero
 extension before pruning a state
From: Eduard Zingerman <eddyz87@gmail.com>
To: Daniel Borkmann <daniel@iogearbox.net>, memxor@gmail.com
Cc: puranjay@kernel.org, info@starlabs.sg, bpf@vger.kernel.org
Date: Wed, 05 Aug 2026 12:11:14 -0700
In-Reply-To: <20260805184444.292828-1-daniel@iogearbox.net>
References: <20260805184444.292828-1-daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-08-05 at 20:44 +0200, Daniel Borkmann wrote:
> A 32-bit write records the writing instruction in reg->subreg_def, and a
> later 64-bit read of that register calls mark_insn_zext() to record that
> the definition has to be zero extended. Architectures whose JIT sets
> bpf_jit_needs_zext() rely on that mark to emit the extension.
>=20
> The mark is produced by walking the path from the definition to the read.
> If the walk stops at a state equivalent to an already explored one, the
> reads the explored path performs from there on are not repeated for this
> path's registers, so a definition whose only 64-bit read lies beyond the
> pruning point never gets marked and keeps a garbage upper half.
>=20
> Example with BPF_F_TEST_STATE_FREQ making every instruction a checkpoint:
>=20
>       r7 =3D *(u32 *)(r1 + offsetof(struct __sk_buff, len))
>       r6 =3D 0        /* 64-bit define */
>       if r7 !=3D 0 goto l1
>       goto l0                              path A, explored first
>   l1: w6 =3D 0        /* 32-bit define */    path B, explored second
>   l0: r0 =3D r6       /* 64-bit read   */
>       r0 >>=3D 32
>       exit
>=20
> Now, path A is the fall-through of the conditional and is explored first.
> It reaches l0 with r6 defined by the 64-bit r6 =3D 0, so reg->subreg_def =
is
> DEF_NOT_SUBREG and the read marks nothing. The walk runs on to exit and
> leaves a checkpoint at every instruction along the way. Path B is explore=
d
> second. w6 =3D 0 sets r6->subreg_def to that instruction, so a zero exten=
sion
> is pending and only the 64-bit read at l0 can resolve it. B then arrives
> at l0, where bpf_is_state_visited() finds the checkpoint A left behind:
> r6 is the scalar 0 in both states, so they are equivalent and B is pruned
> before r0 =3D r6 is verified.
>=20
> Without the fix nothing happens at that point, so the one read that would
> have called mark_insn_zext() for w6 is never walked and the definition
> stays unmarked:
>=20
>   l1: w6 =3D 0        /* subreg_def =3D w6, pending */
>   l0: r0 =3D r6     <--- B pruned, read never walked, w6 stays unmarked
>=20
> The JIT of an architecture that needs explicit zero extension then emits
> none, and the upper half of w6's definition is left undefined (under
> BPF_F_TEST_RND_HI32 it holds the randomized half, which r0 >>=3D 32 retur=
ns).
> This used to be handled by the registers chain based liveness: the
> propagate_liveness() called mark_insn_zext() for every parent register
> whose read mark was REG_LIVE_READ64, which carried the requirement across
> a pruned state. Commit 107e16979905 ("bpf: disable and remove registers
> chain based liveness") removed that machinery and with it the propagation=
,
> leaving the mark dependent on the path actually being walked.
>=20
> Mark the pending definitions where the walk stops instead, i.e. on the wa=
y
> into the prune rather than at the read that is no longer reached:
>=20
>   l1: w6 =3D 0        /* subreg_def =3D w6, pending */
>   l0: r0 =3D r6     <--- mark w6, r6 is live here
>=20
> The set of registers to mark is the one the pruning decision was made on:
> func_states_equal() compares the registers live at the instruction, per
> insn_aux_data[].live_regs_before, and those are exactly the registers tha=
t
> can still be read. A register that is not live there is never read again
> and needs nothing. This is conservative in one direction: a live register
> whose remaining reads are all 32-bit also gets its definition marked,
> which costs a zero extension that is not needed. However, it never marks
> too little, and it does not weaken pruning. On x86-64 the effect is only
> observable with BPF_F_TEST_RND_HI32.
>=20
> The one live scalar whose subreg_def can point at a call insn is r0 of a
> kfunc returning a 32-bit value. Marking that one is harmless, the fixup p=
ass
> skips kfunc calls since their zero extension is done by the caller.
>=20
> Fixes: 107e16979905 ("bpf: disable and remove registers chain based liven=
ess")
> Reported-by: STAR Labs SG <info@starlabs.sg>
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> ---

Hi Daniel,

I have this series in progress:
https://lore.kernel.org/bpf/20260802-static-zext-v3-0-3456b2604574@gmail.co=
m/
Fixing that exact issue. It needs one more iteration.

...
