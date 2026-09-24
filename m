Received: from mail-wm2-f11.google.com (mail-wm2-f11.google.com [74.125.225.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 755D63FD960
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 09:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790243777; cv=none; b=nf4lKlvy0U1bQrqFD085fs3NWVcR5rXEstUfXiBQDwco+MFbDzohJnVdGd0eeq4CzgG1z4dJ9AkSqESJVh+L1sEijTz4xLLpjP15uWlVRkwqybl+FvcwoGWRy2xBT+6TsCdcW7FW7DeNWmgJe6Tb1cUko5rwgc4nU8E+tVuY2iM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790243777; c=relaxed/simple;
	bh=oI15Js5UuAWKH+fY+yv3F5ozdjH/DiW8mhu3eNouS1Q=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=MladCqfWY05peXKP7AE9zWbE1ezTQUsY/iObleUb6POGPSYzJS6FW7zufn5U0w+DSle70gbLcQe7UAhtYs3o/SGfi61WcJRPbcPbSKUmYX76kZBwU9x4Oq9dvmuJQOzNTRqIMkAUH3/PNGljWdNAKmZgWu8MMnV61msvKvlSZYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F4uPKsmj; arc=none smtp.client-ip=74.125.225.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F4uPKsmj"
Received: by mail-wm2-f11.google.com with SMTP id 5b1f17b1804b1-49e78a58e17so6622765e9.0
        for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 02:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790243765; x=1790848565; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=H2abjC/8zePgKz7jIIPKyU3gxSIw7OMyUEA0grUQL+U=;
        b=F4uPKsmjFaE/tAcA9tPGxgM1GYhbINDV85MDeBPCceKad2ILRtG9Huqv7xuAkLf2Hu
         vjBFD1ipNqWFvrAdJDhsvNmJ2HJR5w/poIAIoDLXk8yvcZvIBrwbgn6Cv5hSFwuHNwNz
         +8PbkXhHYAuGn7sgZQ9gAEfQM+EySTOC4Ai8wZCPViOHy1xk2Zxn19imr1NzXzX9P1Ml
         AWSRwCFk0/Xo+K/IFQmUvtSqaNJsjxUzGcaNm7PEBFONJuvehW+vOpumpW7W4U6Jwzpo
         ZhdBkQ9VZLfwNKnoeOdVIZMBMUH6XTIPsLvdjK9uCb2NVdMpcf+60dAfV3BPkFhJwYxb
         govQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790243765; x=1790848565;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=H2abjC/8zePgKz7jIIPKyU3gxSIw7OMyUEA0grUQL+U=;
        b=AchmZJqxfErvlYtdedKKYDdqTF41D5V0mqCcOX0j/hTFiTneUQAZiX5f/kVmnzDjVc
         aHvW29hybEhedUTghwUuwQ23sH95s1lOObnuJEcuyLCYGAv0tsLv5R6H2tY4Eu4+VNRc
         rsj0pq5czZB4rXCCpZU532t0oGrFPf2MCHZw3ug1X+gVBeuxfk6eakK5fsfPRKibgjuz
         mLTyI3LEwbSExmKditarLZCJLgqsuCzNsabUEdj3QlZT6jH9ND0fSpw5yv5QtPw/JZgB
         yfKJFWv02FufyuDyP0GZskL4BDxKOStXbKyY9Bz/31sMQ/IjpZcSY/E1Gd7ZSLzhCpBG
         VntA==
X-Forwarded-Encrypted: i=1; AKwUvBzU0QXMYNMuuxhycdsk7A2C9nv8ZVHSpxr8ItyBf/jyOePz1d/5LdDvzv0LCJhYPDIodPM=@vger.kernel.org
X-Gm-Message-State: AFuF++mBAeVRAyibLxyNBuf8+rJPucuiBCkGYjKsmlij/YcWCSMRmAUK
	vKdlsTi0z1iEnI2LYadJpEVGw5aQa11Xu90dJe+t/J0lynxSQkSFvsUn
X-Gm-Gg: AYBFou1FM8b48ui2WO7KkS2wp9eEVPSZQM8P4s2+i6TABdbb3D5s8BPrMsOArWIaLFa
	7GZoS9lu8c8jCe20kXiVC0n2MD+qEkghwFn0E+tpuYlJvL1yN6J+mnj3P/uojZkoD0BrF6XF0w6
	LjBHifVNSum3SnU5WOtEYRZegQPMhGdFOHx4mDNSVSgkB7iVjA7IlMgOKc0AdWKM/BeM0EHoYe+
	+R8wFTqIgizRKGrac1J0TpXhdeMKn2mXhZr6hB+ZwoZjQNdsQ8y12J9PVRQEXQwANHu+TbMZh9G
	Xbr1Bj3/jp0PF/V3NhC44FrJx9rc+6x/4aJH7F3LI5CCOwrpL4vcCd0mCXJYL7ji+Xx/F0yBEnI
	U0CraBzlnNihnMAARwylAQzRIhHJAR773VL2WMK+hA8RHGEySxxXAwHgIUgkHfDDIY+Fc9/nwau
	feWP0/uolcPZYQ/6HPbEXzlTr5ZzelIk6Xiv+0bWtnrh2sKsh/OX7U6A1pxPBHMTU8IR0LZ+n7T
	TneM9/jZDfLIw9/jl7qySLRBTThXnS4Iu9DwvNONyk2FwIONT/2qyokWqbLi9cHk8rnF3cKzPYs
	MZ5ksmMPbYrQPI+3iEzZ5KOKow4/wuVQIELpOQ==
X-Received: by 2002:a05:600c:6290:b0:49e:799a:8969 with SMTP id 5b1f17b1804b1-49fe6707bb7mr33596205e9.30.1790243765139;
        Thu, 24 Sep 2026 02:56:05 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fe0c4b51bsm104878895e9.4.2026.09.24.02.56.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Sep 2026 02:56:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 24 Sep 2026 11:56:04 +0200
Message-Id: <DLNGG7IL1128.218X5WAMO8MKP@gmail.com>
Cc: <ast@kernel.org>, <andrii@kernel.org>, <daniel@iogearbox.net>,
 <eddyz87@gmail.com>, <emil@etsalapatis.com>, <tj@kernel.org>,
 <kkd@meta.com>, <kernel-team@meta.com>, <martin.lau@kernel.org>,
 <yonghong.song@linux.dev>, <mason@kernel.org>, <ihor.solodrai@linux.dev>
Subject: Re: [PATCH bpf-next v2 12/18] bpf: Size the per-frame verifier
 structures for a 2 KiB stack
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: <bot+bpf-ci@kernel.org>, <bpf@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <20260924082607.2695649-13-memxor@gmail.com>
 <56e4ad0131706000fe1c09e8212e0fe834f91653a1090a9cf04011b2187c8e10@mail.kernel.org>
In-Reply-To: <56e4ad0131706000fe1c09e8212e0fe834f91653a1090a9cf04011b2187c8e10@mail.kernel.org>

On Thu Sep 24, 2026 at 11:13 AM CEST, bot+bpf-ci wrote:
>> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
>> index 3ff1d4f753d3..f7964410f330 100644
>> --- a/include/linux/bpf_verifier.h
>> +++ b/include/linux/bpf_verifier.h
>
> [ ... ]
>
>> @@ -243,12 +244,13 @@ enum bpf_stack_slot_type {
>>  #define BPF_REG_SIZE 8	/* size of eBPF register in bytes */
>>
>>  /*
>> - * Largest number of BPF_REG_SIZE stack slots a single frame can have. =
A frame
>> - * may use any part of the MAX_BPF_STACK budget; check_max_stack_depth(=
)
>> - * enforces the bound on the combined depth of frames sharing the kerne=
l stack
>> - * and on each frame using a private stack.
>> + * Largest number of BPF_REG_SIZE stack slots a single frame can have, =
sized
>> + * for the largest stack budget any JIT supports. A frame may use any p=
art of
>> + * its program's budget; check_max_stack_depth() enforces the budget on=
 the
>> + * combined depth of frames sharing the kernel stack and on each frame =
using
>> + * a private stack.
>>   */
>> -#define MAX_BPF_STACK_SLOTS	(MAX_BPF_STACK / BPF_REG_SIZE)
>> +#define MAX_BPF_STACK_SLOTS	(MAX_BPF_STACK_JIT / BPF_REG_SIZE)
>
> Can raising MAX_BPF_STACK_SLOTS to 256 cause an allocation overflow in
> the arg tracker?
>
> This change affects subprog_spill_slots() in kernel/bpf/liveness.c, which
> sizes the per-instruction stack tracking:
>
> kernel/bpf/liveness.c:subprog_spill_slots() {
>     return clamp_t(u32, DIV_ROUND_UP(deepest, 8),
>                    MAX_BPF_STACK / BPF_REG_SIZE, MAX_BPF_STACK_SLOTS);
> }
>
> Before this patch that was clamp(x, 64, 64), always returning 64. Now any
> BPF_DW instruction with base R10 and a negative offset can push nslots up
> to 256. The value feeds compute_subprog_args():
>
> kernel/bpf/liveness.c:compute_subprog_args() {
>     at_stack_in =3D kvmalloc_objs(*at_stack_in, (size_t)len * nslots,
>                                  GFP_KERNEL_ACCOUNT);
> }
>
> with sizeof(struct arg_track) =3D=3D 10.
>
> This runs from bpf_compute_live_registers() before do_check_main().
> The instruction checks in check_and_resolve_insns() and check_insn_fields=
()
> do not validate R10 offsets, so an instruction such as
> '*(u64 *)(r10 - 2048) =3D 0' in a program the main pass would later rejec=
t
> still reaches this allocation with nslots =3D=3D 256.
>
> A bpf_capable loader may submit up to BPF_COMPLEXITY_LIMIT_INSNS
> (1,000,000) instructions. For a single subprog with len >=3D 838,861 and
> nslots =3D=3D 256, or len =3D=3D 1,000,000 and offset <=3D -1713 (nslots =
>=3D 215),
> the size becomes len * nslots * 10 > INT_MAX.
>
> The kvmalloc path checks this:
>
> mm/util.c:__kvmalloc_node_noprof() {
>     if (unlikely(size > INT_MAX)) {
>         WARN_ON_ONCE(!(flags & __GFP_NOWARN));
>         return NULL;
>     }
> }
>
> GFP_KERNEL_ACCOUNT has no __GFP_NOWARN, so userspace can trigger a kernel
> WARN (a panic with panic_on_warn). The load then fails with -ENOMEM inste=
ad
> of the expected -EACCES or -EINVAL. The old worst case was
> 1,000,000 * 64 * 10 =3D 640 MB, below INT_MAX.
>
> Even below the WARN threshold, the arg tracker now allocates and iterates
> up to 4x more stack state (up to about 2 GB) for programs that will be
> rejected at the 512-byte budget anyway.
>
> Could the clamp bound nslots by the program's stack budget instead of
> MAX_BPF_STACK_SLOTS, to match what the main pass will eventually allow?
>

Fixed for v3: the tracker is bounded by the program's stack budget, so a
512-byte program is back to the old 64-slot worst case, and the allocation =
uses
__GFP_NOWARN so the remaining pathological 2 KiB case fails the load with
-ENOMEM instead of warning.

> [ ... ]
>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a =
bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/READM=
E.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/359763=
22553

