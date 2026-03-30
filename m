Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A80322B74
	for <bpf@vger.kernel.org>; Mon, 30 Mar 2026 14:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774881970; cv=pass; b=ApZ/F/H/XE9EEZMevb0aHvGbdOBaMw5w9Vx9VoWuYSNldKTqUJhMui/GW/1w3WRbOt7hvxITd4xQ0xnP0zmDLbvil4R3/pwtiSCvLd2J6r6viARIvzSB2OiZMFnxic0Ae/c6FntzudYLj01l41H7MdfLkEf5qOS893uJHu5reAU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774881970; c=relaxed/simple;
	bh=5MrZSHAXakbymRNUEFtIb9oqQvlqdFMD4jfogA8/bdA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VsRLfB5fwqHgD6YFHOFq6ikUFza0FQeHdCIUbpIee/n83ouFYy2G6ToxUSjYuF1T+7yiY4FbL0/t1tVg1+CkQYWGDsJcJgnScP5J8QvLAF4JaexeVxE955vwJMDTPcveS490VUtiCYd0Bw3hYr6lVner9RTBbuYYyQpjjnmx4x8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pwA5RscA; arc=pass smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pwA5RscA"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4852e9ca034so44007945e9.2
        for <bpf@vger.kernel.org>; Mon, 30 Mar 2026 07:46:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774881967; cv=none;
        d=google.com; s=arc-20240605;
        b=fsXpLZYATAyZ6aZD5gHrALW73b5GIUtmP6NKaE/BVx4mcuW3cg+T9WXVKBSamDMf/p
         CuEanJ7nqmAneoT8ZqeEUQwFOtvgLwldH7szYZoWYdqdj2XyxKx5p+Z1bsQw5dsnfKJY
         vgWX1fLZ96a6513+YrvdAp21VgN69EI8M+hp5mczOYXqAeb1vsPdgCx6hzTK6NXnqhm+
         ojtXGMS3EeaLtHnVrfEwd4HDXzYsbyeauVX/NHbvfl99NPPj9SdcH4Gjiys0ErB83i29
         gl0NQGifkkep25YQMfbifuJjGVmZeN/HWOT7Lg0num4KAhwegbtHmuklOPFx9tMFfqdi
         16rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gzzaO1/xii/cLyXLLPNz07EbOxbyXWIYjMmx2SEjssw=;
        fh=mggOYd+o9B6mV2d95yHOGJu5OXB1KjhM7EsZhOk1w4M=;
        b=kJfBt2ITejsvPJolS1LEuoaZ83iD1ba1J1hHDvyTt0Pw882lWZti7OGJxbGSPj3Q6U
         O4M8cy74tp3GSTQHH9UTrJTWQH4r1IZ+LQYjk2CZgk3lIOJeNsNM3EsbfvTlg87TtUHF
         T2qpEbs6pL1gJCzZGF3vozIPKrSy1bafngLamb0mTXU0JLJHrWs0QUqMfrHIKfsUCZwf
         BCkpN/QvQl2CX73nR4CaQ/QGDQcIrHEKTqzADJGpelf4CByxRG4U5ZFSlbiDPj2zn7dW
         S/I7uz3F+SOvjKSskGmZQfQEKSh2x5id2yTNV1jnjZS1ufl0rc8T4xNdiLHzow/hEDkd
         g8PA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774881967; x=1775486767; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gzzaO1/xii/cLyXLLPNz07EbOxbyXWIYjMmx2SEjssw=;
        b=pwA5RscAcKhu8yb468xCV71NQAuUSs33QiQyrZOrhmj2oWcs8ex3ZIgDPlYc3tuimR
         HgEQNDJHR6a1erh3NFjP4ZWByLieNzBKxGqTSk/dT7S2FtjM0TA4ooLdOJKv3O6CYqKC
         z6HSX6kR6RsbwMAtk5876OMqHDhDvzAuH+qLUyiVOuiEWfw94lo3XUMCDtbl5hlCHjpi
         CZSNvvaEeGLN1mJrqnAizB4VTGPN68pTygKV0b/D+xkjpjpfZkD+hIJq2CitT9UuZBJS
         bq8BkpJkfWvaDvXdjzxAMu+gxFUXkq0YFbvFDve85/mCrmim4UbIpofNmPAOnoQNxVNu
         wXAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774881967; x=1775486767;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gzzaO1/xii/cLyXLLPNz07EbOxbyXWIYjMmx2SEjssw=;
        b=sxY0YtAaNrAW3FSVThTqEI7GFoy40nQ6aRIPmdC1d0KwcIU9RdJYFxZbIxLH/+Mtoc
         MyNK9S69RqNJESdT0xVgX6dVg2e77K9IXhZZBpgVN1Fb23eynUQ4rwIavGNhM1m3QrAF
         ZYSLDHPU+eSvHow+Oykt9mgIe8affPhk8ihcYq1qShqLCcvY8bHicSJerBgXy0lhb4QK
         mE+/LJUo4Ct9sZmOluY1FzDQmNp2wVV2RJlYA7Nic0xRqn9lDPRJu8vtRlxUrUVgM6m2
         brClSON4ODUdACvn7mTDDbEqxL14UgWfV9ah+Wh9F851tXPjavxqYW++ApZeU5qAHeh9
         MM7w==
X-Forwarded-Encrypted: i=1; AJvYcCXjD0JRGDR49SSv5iT1AJjC8lymbRZQY1B8cNkNJFbz06rYx7Bvjl/ZWwV//jxg4YewXo8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywpb9ZEEjkMe1d0X8AS2HwiUS5K+QhoEeVPpP9G3A+DfGoBXd9F
	9TD28Ja5xaREfS5WD8wKIonW2gzsdHcHqC5fvrsT9YRLpU+/DNUhaEwp/D/rN81rZsBO0MdQcjC
	V5ZiFxznDVTkekaQrgAY2GPOY60Lq3qo=
X-Gm-Gg: ATEYQzz0cOn1tuAOT29BfbIi6EITp4UsRUSAo6TH/3v8p1nhtyACzwucAe1jApIP4Lc
	C61qYzWKKcYKnDpxQp2m911ymlJ7n+ln/eQObraUPJ9CBkcCDpWQ7OJiqjFxbGZmGPOsl1APbg+
	XuDAsi0kRapmaHrlM2jXuj4CCE9pMghdhcoBfzKsXqFnK3WJH65kzNTRiNp+ERmAoZHf954D7T9
	Bq/a8joUylkMP+3DLkXZhFaHn3i4V+npVHlBRkTPNw8rz761+/p0A2r1XmxePgXar1hnES9d4g6
	oTGWVlxzhladHmAMz2yPl8GOs5p8/vVW0+wFZgT/Py2S6vpDEWYM/fy8jHZp21IQmeUgQm7O0Re
	fmWzFzhmT54QQTIRw+U/AAWIL0A==
X-Received: by 2002:a05:600c:8b77:b0:486:ffa3:584 with SMTP id
 5b1f17b1804b1-48727f17035mr201012225e9.15.1774881967270; Mon, 30 Mar 2026
 07:46:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260330132750.377862-1-daniel@iogearbox.net>
In-Reply-To: <20260330132750.377862-1-daniel@iogearbox.net>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 30 Mar 2026 07:45:55 -0700
X-Gm-Features: AQROBzAj0QI0Ks9UMidwlTkRnSADisw196KED9cNVReTx8ZpjBttOkBpA7ZhCT4
Message-ID: <CAADnVQ+DtTmz2Z1mCQu31PaJKrWgOjt3FGydPfJtserwqVbuvw@mail.gmail.com>
Subject: Re: [PATCH bpf 1/2] bpf: Fix incorrect pruning due to atomic fetch
 precision tracking
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: Eduard <eddyz87@gmail.com>, Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>, 
	STAR Labs SG <info@starlabs.sg>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 30, 2026 at 6:27=E2=80=AFAM Daniel Borkmann <daniel@iogearbox.n=
et> wrote:
>
> When backtrack_insn encounters a BPF_STX instruction with BPF_ATOMIC
> and BPF_FETCH, the src register (or r0 for BPF_CMPXCHG) also acts as
> a destination, thus receiving the old value from the memory location.
>
> The current backtracking logic does not account for this. It treats
> atomic fetch operations the same as regular stores where the src
> register is only an input. This leads the backtrack_insn to fail to
> propagate precision to the stack location, which is then not marked
> as precise!
>
> Later, the verifier's path pruning can incorrectly consider two states
> equivalent when they differ in terms of stack state. Meaning, two
> branches can be treated as equivalent and thus get pruned when they
> should not be seen as such.
>
> Fix it as follows: When the fetch dst register is being tracked for
> precision, clear it and propagate precision over to the stack slot.
> This is similar to how BPF_LDX handles loads from the stack.
>
> Before:
>
>   0: (b7) r1 =3D 8                        ; R1=3D8
>   1: (7b) *(u64 *)(r10 -8) =3D r1         ; R1=3D8 R10=3Dfp0 fp-8=3D8
>   2: (b7) r2 =3D 0                        ; R2=3D0
>   3: (db) r2 =3D atomic64_fetch_add((u64 *)(r10 -8), r2)          ; R2=3D=
8 R10=3Dfp0 fp-8=3Dmmmmmmmm
>   4: (bf) r3 =3D r10                      ; R3=3Dfp0 R10=3Dfp0
>   5: (0f) r3 +=3D r2
>   mark_precise: frame0: last_idx 5 first_idx 0 subseq_idx -1
>   mark_precise: frame0: regs=3Dr2 stack=3D before 4: (bf) r3 =3D r10
>   mark_precise: frame0: regs=3Dr2 stack=3D before 3: (db) r2 =3D atomic64=
_fetch_add((u64 *)(r10 -8), r2)
>   mark_precise: frame0: regs=3Dr2 stack=3D before 2: (b7) r2 =3D 0
>   6: R2=3D8 R3=3Dfp8
>   6: (b7) r0 =3D 0                        ; R0=3D0
>   7: (95) exit
>
> After:
>
>   0: (b7) r1 =3D 8                        ; R1=3D8
>   1: (7b) *(u64 *)(r10 -8) =3D r1         ; R1=3D8 R10=3Dfp0 fp-8=3D8
>   2: (b7) r2 =3D 0                        ; R2=3D0
>   3: (db) r2 =3D atomic64_fetch_add((u64 *)(r10 -8), r2)          ; R2=3D=
8 R10=3Dfp0 fp-8=3Dmmmmmmmm
>   4: (bf) r3 =3D r10                      ; R3=3Dfp0 R10=3Dfp0
>   5: (0f) r3 +=3D r2
>   mark_precise: frame0: last_idx 5 first_idx 0 subseq_idx -1
>   mark_precise: frame0: regs=3Dr2 stack=3D before 4: (bf) r3 =3D r10
>   mark_precise: frame0: regs=3Dr2 stack=3D before 3: (db) r2 =3D atomic64=
_fetch_add((u64 *)(r10 -8), r2)
>   mark_precise: frame0: regs=3D stack=3D-8 before 2: (b7) r2 =3D 0
>   mark_precise: frame0: regs=3D stack=3D-8 before 1: (7b) *(u64 *)(r10 -8=
) =3D r1
>   mark_precise: frame0: regs=3Dr1 stack=3D before 0: (b7) r1 =3D 8
>   6: R2=3D8 R3=3Dfp8
>   6: (b7) r0 =3D 0                        ; R0=3D0
>   7: (95) exit
>
> Fixes: 5ffa25502b5a ("bpf: Add instructions for atomic_[cmp]xchg")
> Fixes: 5ca419f2864a ("bpf: Add BPF_FETCH field / create atomic_fetch_add =
instruction")
> Reported-by: STAR Labs SG <info@starlabs.sg>
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> ---
>  kernel/bpf/verifier.c | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index f108c01ff6d0..293aa957a5ff 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -4474,6 +4474,31 @@ static int backtrack_insn(struct bpf_verifier_env =
*env, int idx, int subseq_idx,
>                          * encountered a case of pointer subtraction.
>                          */
>                         return -ENOTSUPP;
> +
> +               /* atomic fetch operation writes the old value into a

kernel comment style pls.

> +                * register (sreg or r0) and if it was tracked for
> +                * precision, propagate to the stack slot like we do
> +                * in ldx.
> +                */
> +               if (class =3D=3D BPF_STX && mode =3D=3D BPF_ATOMIC &&
> +                   (insn->imm & BPF_FETCH)) {
> +                       u32 load_reg =3D insn->imm =3D=3D BPF_CMPXCHG ?
> +                                      BPF_REG_0 : sreg;
> +
> +                       if (bt_is_reg_set(bt, load_reg)) {

too much claude smell in here.
remove unnecessary indent pls.

> +                               bt_clear_reg(bt, load_reg);
> +                               /* atomic fetch from non-stack memory
> +                                * can't be further backtracked, same
> +                                * as for ldx.
> +                                */
> +                               if (!hist || !(hist->flags & INSN_F_STACK=
_ACCESS))
> +                                       return 0;

too much copy paste. I bet above can be combine with the same line below.

> +                               spi =3D insn_stack_access_spi(hist->flags=
);
> +                               fr =3D insn_stack_access_frameno(hist->fl=
ags);
> +                               bt_set_frame_slot(bt, fr, spi);
> +                               return 0;
> +                       }
> +               }
>                 /* scalars can only be spilled into stack */
>                 if (!hist || !(hist->flags & INSN_F_STACK_ACCESS))
>                         return 0;

Considering we're in rc6+, bpf-next is better.

pw-bot: cr
