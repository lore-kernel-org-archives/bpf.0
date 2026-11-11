Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794419893;
	b=ouWiIYDJbSY3ixkTKjyhFpjQj3LYgE9jsfBdAz2RtnYDXLfc1lxNLxRCJFaNA85ZGiil
	 2nJvtEApDrNMU+h1cW2tr1Zy6PTM8pWsLiJX+GhokDcNpBDD4BHrD91IP0D33Uy7m6EOd
	 BtTL1GvVqjO0/pZPcfp4fHfgnhaPCnWiI5+cIQe7gF9tcpe8EW5h7M/qctaVQWY8mvfCs
	 LPeXvBGixJwc8CfsgKXay+bpfqJxBZUFNJnz/SORTT8nZsIzD8tDzuxj/hxzN50xRqWcy
	 UttCWgQ5JcvKqogKxwk1OOUMMsSUqQFbFh0DIO8bqBipyT0uVIslt+JnsXaCeEoPAGQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794419893;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=A+Da06DJ5nfj8/rZa2/j0Y3DUtJSVbvxdkvtoZb8mPY=;
	b=kVanoe72Xc22Tipwy+7aXW5cO2NEwlLLCHeb0L67oQmBhPfdNSwam0SudCA2K4WyJJHT
	 FljWtyEJTCpNVp51dWsvK39pORT+LHIN9Vrqlwd8HMpByF8g7EtsLBKT3Tfat0/WeN1qP
	 s+56zK99gdVf1lbGNsjLi3Sj+uGmgqjbz9vgeTz9VO50rf5A61amuYfOL9xNseEguM3tr
	 5oNwcgo/qpkyc82RcwxBpVWqFTB8rCvsbRz9AfqC0uKS9ZnkkOyTWDaNhjkPP7+BKu0I8
	 NC8ehpofpvXAysmMGqIq9NQ38namC6uYuS+NvP/0IijqBkSGmW0IEPa7iWhxWd19W9A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QFILj+UG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2718606A88E
	for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 17:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QFILj+UG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACD881F00A06;
	Wed, 11 Nov 2026 17:58:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794419893;
	bh=A+Da06DJ5nfj8/rZa2/j0Y3DUtJSVbvxdkvtoZb8mPY=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=QFILj+UGmtL+/B8mvPz+VrRvxejxwXyBd57407lM/AEc7GGGBf8ZknLu699rjFxz4
	 aKAhRy4QWszpKkXbVq26s+ARNcej0SHkwQfN1jC6PirJFrPcHvwlA91+WQYI4KYABH
	 vzPXLFmxsO0PXJddj6ZVFjCpJKmZ7e9VeC+Itx+exnGmFCdiFtHAcVNLgIFgF3KanO
	 TGRiepfRp4a/fT/J8RpKEvNRUC5Cqi6o4CfBEn8SE9iv/KM1zOOqWQmpXtEpmjttPY
	 vKamfw6S2QdHMmCW7EQB4np4NzRP7XOT4R+Dw00bUHdz1YhRWJcixgQ+SzyS+EMs96
	 fGJMYaJSvSPEA==
Content-Type: multipart/mixed; boundary="===============6208320440275240206=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <962cb28810515350c592215aeb2c8a18e01d2e328a611454a546bcac614af171@mail.kernel.org>
In-Reply-To: <20261111164557.2659679-12-alexei.starovoitov@gmail.com>
References: <20261111164557.2659679-12-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH bpf-next v3 11/29] bpf: Don't treat half of a 64-bit spill as a 32-bit spill on big endian
From: bot+bpf-ci@kernel.org
To: alexei.starovoitov@gmail.com,bpf@vger.kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Wed, 11 Nov 2026 17:58:12 +0000 (UTC)

--===============6208320440275240206==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Don't treat half of a 64-bit spill as a 32-bit spill on big endian

TL;DR: Commit message only: the stacksafe() big-endian bug may predate the
cited 6715df8d5d24 and date to 354e8f1970f8 (v5.16), so the Fixes tag may omit
stable trees v5.16-v6.3, such as 6.1.y on s390x.

>     bpf: Don't treat half of a 64-bit spill as a 32-bit spill on big endian
>
>     A fix of the main pass for big endian that stands alone. The patches that
>     follow refine more registers and stack slots at conditional jumps, so more
>     progs would run into it.
>
>             *(u64 *)(r10 - 8) = r1
>             r2 = *(u32 *)(r10 - 8)
>
>     r2 gets the low 32 bits of r1 on little endian and the upper 32 bits on big
>     endian. In two cases the verifier gives r2 the range of the low 32 bits on
>     big endian too.
>
>     [ ... ]
>
>      - stacksafe() skips the bytes that are STACK_MISC in the old state. An old
>        32-bit spill and a current 64-bit spill are then compared by regsafe()
>        of spilled_ptr.
>
>     [ ... ]
>
>     Fixes: be23266b4a08 ("bpf: 4-byte precise clean_verifier_state")
>     Fixes: 6715df8d5d24 ("bpf: Allow reads from uninit stack")
>     Signed-off-by: Alexei Starovoitov <ast@kernel.org>

The second Fixes: tag and the description of the stacksafe() half of the
bug blame the STACK_MISC skip added by 6715df8d5d24 ("bpf: Allow reads
from uninit stack"). Is the stacksafe() problem older than that?

6715df8d5d24 added its MISC skip directly below a skip that already
existed:

    if (old->stack[spi].slot_type[i % BPF_REG_SIZE] == STACK_INVALID)
        continue;

Since 354e8f1970f8 ("bpf: Support <8-byte scalar spill and refill"),
save_register_state() handles the unspilled bytes of a narrow spill with
scrub_spilled_slot(), which leaves STACK_INVALID bytes as they are:

    if (*stype != STACK_INVALID)
        *stype = STACK_MISC;

So '*(u32 *)(r10 - 8) = r6' into a slot that was never written leaves
slot_type[0..3] as STACK_INVALID and slot_type[4..7] as STACK_SPILL.

Before 6715df8d5d24, a current state with a 64-bit spill in that slot would
be matched only by regsafe() on the whole spilled_ptr, at slot_type[7].
On big endian that prunes even though r10 - 8 holds the upper 32 bits.

This needs only CAP_BPF, and allow_uninit_stack, and so the MISC skip, is
not involved.  The new test spill_of_64_bits_vs_spill_of_32_bits shows
this: at label 2, slot_type[0..3] of the old state are STACK_POISON
(STACK_INVALID before cleaning), not STACK_MISC.

So the stacksafe() part looks broken on big endian since 354e8f1970f8
(v5.16), not since 6715df8d5d24 (v6.4).  Should the tag be:

  Fixes: 354e8f1970f8 ("bpf: Support <8-byte scalar spill and refill")

and should the message say that STACK_INVALID and STACK_POISON bytes in
the old state are skipped as well?  As written, the tag leaves out stable
trees between v5.16 and v6.3, such as 6.1.y on s390x.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/43066992582
--===============6208320440275240206==--
