Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07F1B3A8F7
	for <bpf@vger.kernel.org>; Wed,  8 Apr 2026 17:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775670454; cv=pass; b=Wl31q02n6TbF7iX3Id/sBHosFG4Z2kvj2dwyAZfVp9yKqygOcMKwYyJS4nXFz04s5JOXcl5PcK/DSv1zF614y8hORl239aCh8AWmTlXNtJxxs5+si9SEG7tF8QBoG5g74ApAgcsZvACOv4sDsd0vAGgZjssHPeTDMI11Mazkr48=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775670454; c=relaxed/simple;
	bh=6D7xZEwuAOpUUX33CCrlezKUHz8tZirmPI+OQ3coSio=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bkmxSAR7osxEb9fWpVH57S1l+PTYdtWcWKf7eWM6GSkqT85x64KpJkdPlORLkrqgTppsPBtNN5i7UK8kCergwH4EGkXT7e666oo9qoEctm1+vGbmBMxGS70ZQNhqxQ6wwQwg23KkYBvQZXdzsxt1ebrFicis6UY/bacAbo/ln0U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jhpr46Sr; arc=pass smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jhpr46Sr"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-488a9033b2cso882555e9.2
        for <bpf@vger.kernel.org>; Wed, 08 Apr 2026 10:47:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775670451; cv=none;
        d=google.com; s=arc-20240605;
        b=EBSx5Gh4n1d0OI1GiRQvX7FaB7X7X6EldW89J6idJ4NRzqJk+Kp/YV6SD6vW7+PsMB
         xvCoODFBF8GNi/sMsT568TydhCz/ldtZnHEgaUuqgLYjaKHsKw0AkJ4IgCp8xhtCpdQ1
         3Zvbu0d+Dq6hOXLTNnA+wK6G0VvDziWs0njJCsAavPG3kAHHHky8tBRkyo+8KgDJiVZk
         sR/95vRniRsK3AVq/wGl5JgyOA9e7ZtcosgtLXh/z7nNOZcgGMmHtsEdoa3IQtYqKuQC
         k1obeb8NT5seh+fdamWYq/aBULlGy4Z5uLzQ5XruwUr5px+5LP/jEfBI6YfiJbT6Vej3
         tccQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WyObzYDLbSdUq16AytO8s0Wzd2RwSGq0XlA7UMsdCso=;
        fh=CY4ub6tm4dU9Q9M/cvte17bmSVJcYAt67JYy2EieC4I=;
        b=hqY9b/nnNtTkMkCXcS62f9wQsjGrcHynQDKbEhwn2XCvINemBsI64IusXlkWiuXLIx
         LMvNeFA7SdRwL2W3aSYHv0ramPmXGs3YwRHSOEvQXfbKaRAMa40l+m52SSM15PV5gggG
         oeEHeFlz65D+9zZoNnr0ckrFMkMP+6LsQu+1ERpDa2urtL1Z+bA5KdwHfsBnREktltt+
         Z6SdsLOKSuwMkugvrF+9TQUt0FOpjmv6awe56uI+a8OVO7670gaBmOSx8HTBFyWtVQ4P
         a3xTTgQWAYGHUB2UkkXLEAZao8eDy+WILrJjBPSReQvooQXtcWl46UknYmmspWBTgQIp
         wTjQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775670451; x=1776275251; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WyObzYDLbSdUq16AytO8s0Wzd2RwSGq0XlA7UMsdCso=;
        b=Jhpr46SrV39yvS8h+ohX8BJW105YC9YFx5BO/0MUv1ZDGaKNiHgwPimYZKEgGC/9KC
         cnuApBUZO1yYX7KLpoIKtfX7jYjFHFohu1A5TDmuMjd+kFWDbH3A28dG+csaJpG+cF07
         6IXhP3nByo++OECgTvpM455isMWQzyj9tuFSIq0x7dsXAOEFWvLfve9M0ydfUz1u8Wtu
         NqBTPU8t373wQtCp5SvJvuPOlHAT21NK3Hxd/Hf2Sr8RnbtJHeQmiVWgR/BC8S2EU+Cr
         7jQWk4ZbigTZHjNKBVEiFaet1I2DcSsvEQx3Q58LWQH08OP9SpAQ4l/mHR9wLAo22uAc
         NZBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775670451; x=1776275251;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WyObzYDLbSdUq16AytO8s0Wzd2RwSGq0XlA7UMsdCso=;
        b=P85rKtkDIoLc8j0Agpb39UOIwOMQMh8onKoMoPf938efxLmD2UMo/RLoBSc13fzb0a
         RrWX9mPNUTsebUKJia7cPuJ8tOySRUpoZN8ScdMvJN3lZVaWRRJfg1R5se0HlBG8RMl4
         z20yizVYb0xCb0Z1LxddhhuVnLfaKxkAEa7DIZOMvPjZpBfPaxQomHDd8GZLsIGVjRRS
         BpvSe6M3OQfuOSxgDfEjJtMTkLLrRVO3PY0Ys+Hl3AiFBiyzsC5EGRdwg6JhQPRh4DPy
         DlB2eeRPLNtzgY9wuosbRiqXXWMMjfFC1htdkFUTK3chSFwRIOE9Gci629aYkghpAbkV
         lOhA==
X-Gm-Message-State: AOJu0YxBtLuULmYrAL3zZu/il0UwwxVtKXpONYBKAo6v+2sxEoHtq+8p
	9r0mFye2Oiwj7hy+vRyg35ofubfHXM9EKb4HUNs+cPDR83yqIDkC7WcHO5gJ4orGVH3VJ0mFTVz
	ajpUTTuvOoNEYQo2qX+i5EolrBzdkgjo=
X-Gm-Gg: AeBDievHFb1mqvNN+9BbwhCmsKuiVqmPNG8eQwgSmLSnDbJU0ji2P03msUSJCp5m1S+
	Nrx9Q0a7oOGLgBF1J6G84aZCDKBTzcKNo5Bb/XNAb/8+YWeCHRGm+5HvvrmJWRj8lbNg/NjbA8s
	K4zraK0DCwzksi5r8RFW9186s4RJ5Dr9KB5HhCtacl48dhzakdraq3OOqiArIVHrnR2zHSdy7km
	4I6k8HaUcRRe9D8p8C68rFinrZeU3W/O3Yc8U1QECV6zgkvAZES5to1HmCNcZ+MViQcyWZXy6WY
	A8DzkUutYwbebSUpNZzaMftmqLyy8s8gpqiHx7UHEb/J98JQ2ISbgB+mAYzdgmDmvTP6zYJmFUc
	2hIqivzNdEaIAM6O8e+GVWGgPxLZxEjMwX3R/
X-Received: by 2002:a05:600c:a47:b0:487:1108:48bc with SMTP id
 5b1f17b1804b1-48899775d9amr328448365e9.17.1775670451184; Wed, 08 Apr 2026
 10:47:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260408153712.523124-1-daniel@iogearbox.net> <20260408153712.523124-2-daniel@iogearbox.net>
 <CAADnVQ+tLKiH2a_1mOFZ7aZ3jN+9_vLxOxxPqqBc8QEYUwCgVg@mail.gmail.com> <a4190f97-b171-4a7f-9722-9e7bc73a57ca@iogearbox.net>
In-Reply-To: <a4190f97-b171-4a7f-9722-9e7bc73a57ca@iogearbox.net>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 8 Apr 2026 10:47:20 -0700
X-Gm-Features: AQROBzDWsBCfWgQ4x8d1XDg4LcRe-HiVEe_KGJn-po5bqeJHqG_OSdR4_ht9MWw
Message-ID: <CAADnVQKuAXW3T3spcYFSc7SVbbBHGfbiV=XR0QdNfuJtCbG5fA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/4] bpf: Fix ld_{abs,ind} failure path analysis
 in subprogs
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, Eduard <eddyz87@gmail.com>, 
	STAR Labs SG <info@starlabs.sg>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 8, 2026 at 10:04=E2=80=AFAM Daniel Borkmann <daniel@iogearbox.n=
et> wrote:
>
> On 4/8/26 6:20 PM, Alexei Starovoitov wrote:
> > On Wed, Apr 8, 2026 at 8:37=E2=80=AFAM Daniel Borkmann <daniel@iogearbo=
x.net> wrote:
> >>
> >> Usage of ld_{abs,ind} instructions got extended into subprogs some tim=
e
> >> ago via commit 09b28d76eac4 ("bpf: Add abnormal return checks."). Thes=
e
> >> are only allowed in subprograms when the latter are BTF annotated and
> >> have scalar return types.
> >>
> >> The code generator in bpf_gen_ld_abs() has an abnormal exit path (r0=
=3D0 +
> >> exit) from legacy cBPF times. While the enforcement is on scalar retur=
n
> >> types, the verifier must also simulate the path of abnormal exit if th=
e
> >> packet data load via ld_{abs,ind} failed.
> >>
> >> This is currently not the case. Fix it by having the verifier simulate
> >> both success and failure paths, and extend it in similar ways as we do
> >> for tail calls. The success path (r0=3Dunknown, continue to next insn)=
 is
> >> pushed onto stack for later validation and the r0=3D0 and return to th=
e
> >> caller is done on the fall-through side.
> >>
> >> Fixes: 09b28d76eac4 ("bpf: Add abnormal return checks.")
> >> Reported-by: STAR Labs SG <info@starlabs.sg>
> >> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> >> ---
> >>   kernel/bpf/verifier.c | 32 ++++++++++++++++++++++++++++++--
> >>   1 file changed, 30 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> >> index db009d509ade..46f55ea6684e 100644
> >> --- a/kernel/bpf/verifier.c
> >> +++ b/kernel/bpf/verifier.c
> >> @@ -18357,6 +18357,22 @@ static int check_ld_abs(struct bpf_verifier_e=
nv *env, struct bpf_insn *insn)
> >>          mark_reg_unknown(env, regs, BPF_REG_0);
> >>          /* ld_abs load up to 32-bit skb data. */
> >>          regs[BPF_REG_0].subreg_def =3D env->insn_idx + 1;
> >> +       /*
> >> +        * See bpf_gen_ld_abs() which emits a hidden BPF_EXIT with r0=
=3D0
> >> +        * which must be explored by the verifier when in a subprog.
> >> +        */
> >> +       if (env->cur_state->curframe) {
> >> +               struct bpf_verifier_state *branch;
> >> +
> >> +               branch =3D push_stack(env, env->insn_idx + 1, env->ins=
n_idx, false);
> >> +               if (IS_ERR(branch))
> >> +                       return PTR_ERR(branch);
> >> +               mark_reg_known_zero(env, regs, BPF_REG_0);
> >> +               err =3D prepare_func_exit(env, &env->insn_idx);
> >> +               if (err)
> >> +                       return err;
> >> +               env->insn_idx--;
> >
> > similar code in check_helper_call() for tail_call
> > also does mark_reg_scratched() and clear_all_pkt_pointers()
> > which are missing here.
>
> The clear_all_pkt_pointers() is only relevant for the cases where we
> modify/pull/push skb data, but in ld_{abs,ind} we either read skb
> packet data directly in linear section or via skb_copy_bits.
>
> I'll add the mark_reg_scratched(env, BPF_REG_0). Not sure how much
> this really suits to move into a common helper: the tail call case
> calls clear_all_pkt_pointers() and marks r0 unknown right after
> push_stack(), the ld_{abs,ind} case does not clear the packet
> pointers and marks r0 as known 0. imo its fine to leave it separate.

Ahh. Known zero vs unknown. I missed that. Makes sense.

btw what is the point of env->insn_idx--; ?
This and tail_call case are doing it, but why?
