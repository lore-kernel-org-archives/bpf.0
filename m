Received: from mail-wm2-f1.google.com (mail-wm2-f1.google.com [74.125.225.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51E87392C50
	for <bpf@vger.kernel.org>; Sun, 19 Jul 2026 14:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784470373; cv=none; b=IHCNeFK3b5URIXI0EaDbSCoV4auOjQ2C/PuQk6ZUxS7Rmq1C5aqx+joeQFLDq/rin2nKMkgKxoPIPxck5AZ1OU7J6s2xedPesjPkIQ99kB60p8hgXjhLC8IVTvCqGs+C1ZI+0pINYVOUBXcOUgNKOJ1ctLmnUewjbKLliYol3GA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784470373; c=relaxed/simple;
	bh=2zIrfuz01/FGvh1lFqnXgmUf55GEVHiVi03jG3ANMBw=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=hbSTSNw8PRH0GsFkzUAonmxtzqr7oHbOq43FAXR/3m9JiEK7zBGsp+DxzN+C3shSRcsVNG433lNDv7xYD32eqK5p5yp2MXyTxE8X9rQ9Dx/hDt7XgkPH4lYRk7E9qXCVMwIVtQ4/QrplVuhNTv2ATEkQZsrpT70staqDGIUB7ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q2WDPxGP; arc=none smtp.client-ip=74.125.225.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q2WDPxGP"
Received: by mail-wm2-f1.google.com with SMTP id 5b1f17b1804b1-492367f3094so37711795e9.0
        for <bpf@vger.kernel.org>; Sun, 19 Jul 2026 07:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784470369; x=1785075169; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=40mWyOx/mzLTWFJfohBO+thfZUMfWunh0r6Ei65k100=;
        b=Q2WDPxGPxmFrH1NYj7BgdrMHSPXbENuXA9BHmiWgw7xNT/q6+R1c2OEkJaX7hoLjbE
         7fSw2fe02HhZca9xV2isWgNe0RXqajxvoewWieUJvugeQ6DRGxjUDVs/57mnfH4zCboc
         yt8mBjeWNLSIwTaLiR9m5YCpTd6BcFYuF9aYupyPs60VKRF+2cq5k4MK6FcCYJk7HwVL
         XdbB9H9OpA7gbG7y4kTKy6zjSNpbrYpWBu3RBEAjdbLehc+2KPR0nsgVfQNMkzmkRBB8
         SRrD6VIm43aYtFRJnvPcp0hdAHi8duUyaZayZW90kULcjx2OrslWSPho55R2e116uKXW
         4nFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784470369; x=1785075169;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=40mWyOx/mzLTWFJfohBO+thfZUMfWunh0r6Ei65k100=;
        b=bBPI057CuaHkswQYS1qKjxYByVF078VIK/VmqDv++HQsudz3eiJuWYaHkbYCAAO/UF
         t7mEVUIO8UDQeIVdficFg3yGvNtqYnIfuiOhwBvmDaJDiJasJsCmwbFOkM1/lqPrzaVq
         OGmiliiRMYlbazAWPddPl00YbF/Ywx+7H4FVpQsYf/7o8IaCmilkliEiqUt6akIPu/Rs
         R3cppM7JOLs29qAv9t7l5qGqw+/FnHTGs2xodpFwuCWtxiIV8KRuQhkZhldEs/EZSJUP
         jcPxiw8XE8rp9MaLTFcPUVq5hnJjUsQVEeYuPufdWPCg0+kJ5c4RafpvJFSybcE/viB1
         FTZQ==
X-Gm-Message-State: AOJu0YznoNm3cvBYBEvCOrD4g/8m1ePcKLVLNuAa5kPgYSr86Y4rglg5
	anZD1X6ZZ16Ce9c6Gj9RT0OIbh5pqYB86CJydFlv++dReNfJ2BIz8yYi
X-Gm-Gg: AfdE7clhLDk/SXDNeRCQ6/R2CyyeBS1E1c8rH0Sk+Y2EW834c0J30DC1lvOBul1F9vd
	S/ehPPVF/mPB2RJgannspm69RXgcbs0DkgwgvKw9RhchdASHoqUFOT5HGhWu3J6sj9k3tf6xuSn
	aCTvQNV6v5siOjJ4Sp/FKKfDK5L7l3TCn9ipr6BNUlU9PsJiIpYM6NnITdoomtSzGuqJjPk9ASN
	8vlV+KrfMKUAOdcIhoj1hrSmzqKXGa8jqxfj63Lkwrv5WvPhgiSDU/XkkWDDMnHgfYnwO0Eq9eL
	WYXkjx7v7mIEE1hjT9SGlhkOwIGvxT8t/GDLepVO3xedY0DvWYlTjW16u7kvjogbFU0+DTCoNj6
	VURLh5tYcjbojiwFxx0k6vhRlwuMBFgaEeRuACdgBcmRYkErTTNz9Pr8fvROYVQIoQonqhSMmsy
	zqq9Es9HhFKeNiktCNY40z2k0suRo9siileZzx5LnbIrbTBA/3DLpH09pYlVWWYfC/R3z5ZgHGO
	wFAjLnS0xvUTXttmHNZdnd3VsgsbyOOeBexvux7OS/E
X-Received: by 2002:a05:600c:1c09:b0:495:4fd4:f7b6 with SMTP id 5b1f17b1804b1-4954fd4fbdbmr81909595e9.37.1784470369058;
        Sun, 19 Jul 2026 07:12:49 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4955df8492csm8267995e9.3.2026.07.19.07.12.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2026 07:12:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 19 Jul 2026 16:12:48 +0200
Message-Id: <DK2LYA47H73R.9BSEG52IRM7K@gmail.com>
Cc: <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf-next v1 2/2] bpf: Fix is_tracing_prog_type() to
 cover fentry/fexit/fmod_ret
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: <sashiko-reviews@lists.linux.dev>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>
X-Mailer: aerc 0.21.0
References: <20260719113551.1294284-1-memxor@gmail.com>
 <20260719113551.1294284-3-memxor@gmail.com>
 <20260719140909.ED6E81F000E9@smtp.kernel.org>
In-Reply-To: <20260719140909.ED6E81F000E9@smtp.kernel.org>

On Sun Jul 19, 2026 at 4:09 PM CEST, sashiko-bot wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential issu=
e(s) to consider:
>
> New issues:
> - [High] Tracing programs can bypass the bpf_spin_lock restriction using =
bpf_map_update_elem() with BPF_F_LOCK, leading to per-CPU IRQ state corrupt=
ion.
> - [Medium] EXT programs extending iterators are incorrectly classified as=
 tracing programs, restricting them from using spin locks, lists, and rbtre=
es.
>
> Pre-existing issues:
> - [High] Kernel warning and memory leak in `bpf_obj_free_fields` when fre=
eing map elements containing lists or rbtrees protected by `bpf_res_spin_lo=
ck`.
> --
>
> --- Patch [2]: [PATCH bpf-next v1 2/2] bpf: Fix is_tracing_prog_type() to=
 cover fentry/fexit/fmod_ret ---
> commit 94d71df738bb27d6ad27a15a0ce402fd7032420d
> Author: Kumar Kartikeya Dwivedi <memxor@gmail.com>
>
> bpf: Fix is_tracing_prog_type() to cover fentry/fexit/fmod_ret
>
> This patch tightens the tracing program type checks and delays the evalua=
tion
> of map spin lock and list restrictions to the point of use rather than du=
ring
> map compatibility checks.
>
>> Fix this by tightening the check, and moving predicates checking for the
>> restriction closer to the point of use. This change might affect
>> existing programs using them in unsafe contexts, but in such cases, it
>> is recommended for users to switch over to bpf_res_spin_lock instead.
>
> [Severity: High]
> This is a pre-existing issue, but recommending users switch to
> bpf_res_spin_lock exposes an issue in bpf_obj_free_fields() when freeing
> map elements containing lists or rbtrees.
>
> When btf_parse_fields() encounters BPF_RES_SPIN_LOCK, it sets
> res_spin_lock_off but leaves spin_lock_off as -EINVAL:
>
> kernel/bpf/btf.c:btf_parse_fields() {
>     ...
>     rec->spin_lock_off =3D -EINVAL;
>     rec->res_spin_lock_off =3D -EINVAL;
>     ...
> }
>
> Later, bpf_obj_free_fields() unconditionally checks spin_lock_off:
>
> kernel/bpf/syscall.c:bpf_obj_free_fields() {
>     ...
>     if (WARN_ON_ONCE(rec->spin_lock_off < 0))
>         continue;
>     ...
> }
>
> Could this trigger a WARN_ON_ONCE and leak memory for list/rbtree nodes
> because the check skips the freeing logic when a bpf_res_spin_lock is
> used instead of a standard bpf_spin_lock?
>

Sent fix for this.

>
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -17769,9 +17780,11 @@ static int check_pseudo_btf_id(struct bpf_verif=
ier_env *env,
> [ ... ]
>> -static bool is_tracing_prog_type(enum bpf_prog_type type)
>> +static bool is_tracing_prog_type(struct bpf_prog *prog)
>>  {
>> -	switch (type) {
>> +	switch (resolve_prog_type(prog)) {
>> +	case BPF_PROG_TYPE_TRACING:
>> +		return prog->expected_attach_type !=3D BPF_TRACE_ITER;
>
> [Severity: Medium]
> Does this check correctly handle extension programs (BPF_PROG_TYPE_EXT)?
>
> For an extension program, the resolved type is BPF_PROG_TYPE_TRACING, but
> its expected_attach_type is its own attach type (typically 0), not the
> target's attach type which is stored in saved_dst_attach_type.
>
> Could this cause valid extension programs that extend iterators to be
> erroneously rejected by the verifier when trying to use spin locks, lists=
,
> or rbtrees?
>

This is a separate problem in multiple places, let's keep this one as is fo=
r
now, bpf_prog_check_recur() has similar issue. We need audit and fix all pl=
aces
properly.

>
>> @@ -17802,14 +17815,6 @@ static int check_map_prog_compatibility(struct =
bpf_verifier_env *env,
> [ ... ]
>> -	if (btf_record_has_field(map->record, BPF_SPIN_LOCK)) {
>> -		if (is_tracing_prog_type(prog_type)) {
>> -			verbose(env, "tracing progs cannot use bpf_spin_lock yet\n");
>> -			return -EINVAL;
>> -		}
>> -	}
>> +	/*
>> +	 * Restrictions on using BPF list,rbtree,spin_lock is checked later up=
on
>> +	 * use, since rejecting accesing map containing them in programs is to=
o
>> +	 * conservative.
>> +	 */
>
> [Severity: High]
> Does removing this map-level check allow tracing programs to bypass the
> lock restriction using bpf_map_update_elem() with the BPF_F_LOCK flag?
>
> While the explicit lock helper calls are now blocked in process_spin_lock=
(),
> the BPF_F_LOCK flag bypasses those verifier checks and executes
> copy_map_value_locked():
>
> kernel/bpf/helpers.c:copy_map_value_locked() {
>     ...
>     __bpf_spin_lock_irqsave(lock);
>     ...
> }
>
> Can this corrupt the irqsave_flags per-CPU variable when tracing programs
> execute in NMI or arbitrary IRQ contexts, potentially leading to deadlock=
s?

Hmm, valid point. Let me think about this, I might have to keep it during m=
ap
compatibility checks, and see how tests should be adjusted.
