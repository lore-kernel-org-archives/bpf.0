Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1FEC37F00A
	for <bpf@vger.kernel.org>; Wed,  4 Mar 2026 19:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772652200; cv=none; b=AsWQKdi2S+uQFqOoQZVIb0QfZug3uJN/vxu1mPL13StbppTSaRJvMGbZ9tuT0oWthS1l59FtnZ3s7SImU0D7KSmu1ZGw6eLvWBPX1ldEddRE3wOXLgffcGtJcKJlYGUoS1P2qCbi57dJWU8AfjsfZzFj1WyFWYZvHhI2IUVNIxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772652200; c=relaxed/simple;
	bh=ZPUAlez0m+RFWzXkftiiUGJe6zY2BMTtynPWR344TgA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RJDeW9ERiLQo/y4TPg1jbQt3mYjI7k2rkxMBW38Lfdk7DyGzqj89cd9uzdwfexMBSu3g3kHygKnRoSHZX6S4MR66rPyEqOpay563/YJRb0DIAX0OM+1mtyGD+HcvYz0rV/3axqq+VHNCFga5TdJGBdzgykzXqsxKz7LnegaXVYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mC4PD/J4; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mC4PD/J4"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-8272a56b91cso6057541b3a.1
        for <bpf@vger.kernel.org>; Wed, 04 Mar 2026 11:23:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772652197; x=1773256997; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fU1U7bfciin8qRi/ihFmDDAULa/0oFMs1kOeD6wpMrA=;
        b=mC4PD/J4wvyB6JC8oovwtQjYKoJI7H3cOCGSZOU3VRVfeoZzRRkKXRLhRcoG0Y0wBi
         Z5XS42JzFUqSk0wZQOwCBLNMZpS7vj2DjukJnMpqeEZCG4jbQUotHXhcpL9Va8bdEeZ4
         SWqJpcI6D16e92UTcpT47Ie25HpY2r7BMcQTdAk3VpteQMqQZ79v6KmxJnMEek5wIv0y
         DnJZHdSCPnCV8vzmgiYKOlMdIQEuChvNaYlZqiJdSGJIY1zNSonxnucs3YdHC3xOrxG8
         WkpbEOJ/UcHSwQDtqsDR8HuriDVIVI5VoZO969HblVex1tNuQyQ1pSOt25yex1Q2FOC9
         GjRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772652197; x=1773256997;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fU1U7bfciin8qRi/ihFmDDAULa/0oFMs1kOeD6wpMrA=;
        b=Flf7XhdQTidvp9kkf1bPkPgY0Lzw9TpdJdLK/sT49pO6iX8qE5jzXXGss6Bz20R0Qv
         xqhI2u8usVpXNptWpXF6amSBLMbhvnSKOX9OZHMcyw9kTOLYBUY185PSz0r6NpLmwkPb
         JFbYFdT2OZfq81n8ID6fZ6NOJGCMWhz4VNnfKQgoIAY9LgZVAnc4A7QpbUJ3hxswpOoa
         sRPyCnBKFh3j5npW/30k416PeD/zsAtFJY/wPJXlX0gFvQCqPmRpIlklmjZF/5sjJyIU
         J2zlzXREX/3LWzR6QXWXPg6PNIKLjiQkxTOOOhz2x4pSY+EyPl1ys9Pg2WHarEULXD19
         t//Q==
X-Forwarded-Encrypted: i=1; AJvYcCUkac+/9fJv6u2s1tXZk41Q713293ifC+fyXQ0MeGCXYMdlZWi5gASZx4+L0Lqznisjcf0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3WvXDdezaNCUvvYJp4iM5WaUP2ATL/8kWOzpSp9CoYVViJNCf
	9f3PpG+UTa/mRdsP1vU//tjaN/twqSvIi9UG2audltNPDsbCG5LtG7pd
X-Gm-Gg: ATEYQzzTEreNUbEo5d9+V1i77F6JL2xmPolwsDfv6ZdzIS/mRdvAyvwN4xHorAQbD75
	T+nYd5xjeXv2wILsFUcDQeiRtGDdZ96VOt9X262zSR1B3EN8v08Vm/OLKf+lajl3w52zQCwQj/W
	VpJzsthBktcrAB0pf65wPpP5x3ZjMk4dwWVKO8lwF857m9ACWZxnZYk4ZEoBduz8YKvdXqcLvkM
	f/p5cSpIFKjME3MSXVlDVpwgEZX/R7avaZPG+e6h3CckY7DJ9z6V9pww+s9Q7vPoS9+zbG3b4lJ
	XPkcu5zA6kcEnytKpZLoN5HILiVtPjpdK3lg5nw5lZNQC84sXoeO3bYzXL2IO6H2NKxavhlljt0
	WDZmROyxZLOJqAapILrIq/EcKS4HVrV+a1XX2cnXFz8DT6h9zLI+/cwm/wjxBgvxf5bSrKR7mwP
	ntCfH6dkoJSHAu9jLP/XAADRO2z8oOoGYqSw2aQAsaK/5Sl1IZ2U72AdeW5jJq440=
X-Received: by 2002:a05:6a00:4f85:b0:823:943:391b with SMTP id d2e1a72fcca58-82972ce0e64mr2874609b3a.60.1772652196994;
        Wed, 04 Mar 2026 11:23:16 -0800 (PST)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8273a01054dsm24557417b3a.43.2026.03.04.11.23.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 11:23:16 -0800 (PST)
Message-ID: <e8cc28373cd122f041a71f5818e41b7e3e4cffa2.camel@gmail.com>
Subject: Re: [PATCH] bpf: Prevent invalid u32 bounds in
 __reg32_deduce_bounds()
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrea Righi <arighi@nvidia.com>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>
Cc: John Fastabend <john.fastabend@gmail.com>, Martin KaFai Lau	
 <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song	
 <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev	 <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>,  Emil Tsalapatis <emil@etsalapatis.com>,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 04 Mar 2026 11:23:13 -0800
In-Reply-To: <20260220190736.230329-1-arighi@nvidia.com>
References: <20260220190736.230329-1-arighi@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-02-20 at 20:07 +0100, Andrea Righi wrote:
> When refining register bounds, __reg32_deduce_bounds can derive u32
> min/max from 64-bit or s32 bounds and assign them with max_t/min_t.
>=20
> If the existing u32 range and the derived range do not overlap (e.g.,
> u64 says [0, 1] while u32 was [2, 2] from an earlier path), the
> intersection is empty and the new u32_min_value can end up greater than
> u32_max_value, triggering the following warning:
>=20
>   verifier bug: REG INVARIANTS VIOLATION (false_reg1): range bounds viola=
tion
>     u64=3D[0x0, 0x1] s64=3D[0x0, 0x1] u32=3D[0x3, 0x1] s32=3D[0x0, 0x1] v=
ar_off=3D(0x0, 0x1)
>   WARNING: kernel/bpf/verifier.c:2742 at reg_bounds_sanity_check
>   Call Trace:
>     reg_bounds_sanity_check+0xbc/0x1e0
>     reg_set_min_max+0x1a2/0x1f0
>     check_cond_jmp_op+0x5d2/0x1980
>     do_check_common+0x2b0f/0x3410
>     do_check_subprogs+0xcd/0x180
>     bpf_check+0x33fe/0x3850
>     bpf_prog_load+0x7d7/0xee0
>     __sys_bpf+0xea2/0x2e30
>=20
> This was triggered by the scx CI while loading the scx_layered sched_ext
> scheduler [1].
>=20
> Fix by only applying the derived u32 bounds when the resulting range is
> valid (u32_min <=3D u32_max).
>=20
> [1] https://github.com/sched-ext/scx/pull/3349
>=20
> Fixes: c1efab6468fd5 ("bpf: derive subreg bounds from full bounds when up=
per 32 bits are constant")
> Signed-off-by: Andrea Righi <arighi@nvidia.com>
> ---

Hi Andrea,

Sorry for delayed response.

Currently the assumption is that all ranges/tnum tracked as a part of
a register state are valid, and I don't think we'd like to sidestep
this assumption. Eventually is_scalar_branch_taken() and
adjust_scalar_min_max_vals() should be unified to avoid possibility
for mismatch between is_scalar_branch_taken() predictions (when it
assumes that some branch can be taken by failing to predict jump)
and adjust_scalar_min_max_vals() adjustments (when it infers that in
fact register state is empty for the branch).

As it turns out, the problem you report is a bit easier to fix.
After minimizing the failing file with Emil's help I derived the
following test case that captures the problem:

SEC("socket")
__success
__flag(BPF_F_TEST_REG_INVARIANTS)
__naked void signed_unsined_intersection32(void *ctx)
{
	asm volatile("			\
	call %[bpf_get_prandom_u32];	\
	w0 &=3D 0xffffffff;		\
	if w0 < 0x3 goto 1f;		\ /* on fall-through u32 range [3..U32_MAX] */
	if w0 s> 0x1 goto 1f;		\ /* on fall-through s32 range [S32_MIN..1] *
	if w0 s< 0x0 goto 1f;		\ /* the above ranges can be narrowed to [S32_MIN..=
-1] */
	r10 =3D 0;			\ /* meaning that condition can be predicted, */
1:	exit;				\ /* but verifier is not smart enough at the moment. */
"	:
	: __imm(bpf_get_prandom_u32)
	: __clobber_all);
}

This branch has verifier modifications making it smart enough to
process this case: https://github.com/eddyz87/bpf/tree/cnum-sync-bounds .
With some additional verification: https://github.com/eddyz87/cnum-verif .
I'm working towards submitting the fix, need to decide on what to do
with reg_bounds.c, as this test is now not smart enough.

Thanks,
Eduard

[...]
