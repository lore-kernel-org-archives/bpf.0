Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1CCD3B14C3
	for <bpf@vger.kernel.org>; Tue,  9 Jun 2026 18:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781029025; cv=none; b=BhROLEOaId4mDWTxRTWbMt0PXsMm072d/0ORYmgEh1vwlVDaRaOKfGSfuMIby9mai4JYiZdET26b0PVgmUjBi6cgh+YZNQcil7615R9rgEtGCFTcPWC4DcVqqkfLA+ojuF6qVc72Ik9w0P8y/SBEyOo0ODbQgA/2sptZMN4jSOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781029025; c=relaxed/simple;
	bh=AWPWUSOIV6khduVlcOEF32yrHFhgr4C8DqyR+l9zGgk=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=CrFwiIW5z4pLC+tAIigx+Xc52aq8X+MK65j+ON3I5dMLSLxPE/P8cWhzauULVUGMoKvAUr4UFaUn6DDkwta8q3dbVqOWImjxNpyYMPm07HzDvXcxCVaQBNjSnG8VkWlzgMSaf466YZV82w7Qxwjf/ZBd2Drk3zrhI8RjXaa8kqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KefHIs02; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KefHIs02"
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7e6e9408e30so4575900a34.2
        for <bpf@vger.kernel.org>; Tue, 09 Jun 2026 11:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781029022; x=1781633822; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wWFM+Ee+4PTpJMAT/Eu2DM3qaDwipPsLMwbM0vco5nQ=;
        b=KefHIs02VlJZMrqLZivn5NESR90F4B9jlS0McrfmyFPtP5fccbJSiuAF1KZCVKtEQf
         7DOoBpKX8WRq7u7rWakN+zjfC7xNB7HifkDe6p+0IGl1LrwrAV9CXOgfDzTE18h/KLFI
         FRerAb+HVsLvuNhMPGqhgRrtltBUjMbK1b1Gpl+T+gygKeyfY95Mrrb58izLpiYVbsKr
         UW1JtzFsGuzJs3Uxr+MNBKo+bLDL3daNa2bzQOg6LACuqkTggQxuTZUTegAOhm8chl1G
         Esqj4TGHdGIW8ecJG79QePbVqQVWLHqvj4Al/6cTDDELJNl6T3qBb5S296QVS1jzpmHE
         QhRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781029022; x=1781633822;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wWFM+Ee+4PTpJMAT/Eu2DM3qaDwipPsLMwbM0vco5nQ=;
        b=f2iRJcGiqHhiEQPnBEDwPoWQZIL53yWJYm2IVqUjTWccGIoQ7/rbMKWw1d2rRqCWQF
         Uybg+A9tP4LfpSjnhtycrqJWxbuqAzJgAd+PygxNZSAmCPB/XStJh8b5/iwCLtkUlvXz
         VFmWHE1ZX3iuogWJ/qgwZ/UtZUdF8g8CRm8u0HNWSEDHXvRwV8pGP9cAKkbVVsW2pz7r
         MpHjj8uXwJYMbM31iegTGmlYxnsyDk8+NtmtG3MCAJ6pjBbwpchoyrESTvoCb12MVLpP
         q1AfZ79RYPcbvDKGjDrA0VYh3rask0oS3+9JcCfXBAAunXibjS4HY+57rdZbiBQQ16Pl
         LzZg==
X-Forwarded-Encrypted: i=1; AFNElJ8NI++TKS4xAlPCZgeZy0DFplTSmuV/EkG+JL63IdR5174GvhDTmJvZenjRcfqcBBsZe4s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyimmk9baq5J5Rk3SKO/+Jp6ATmTE5bhdLl5y018l+zg3Z3LYG5
	F0Nvu3qX8jTPUNk96HSDdWNbLVnzusKV+hi4sg1Z4xN3v8Q9cJeJI5j0
X-Gm-Gg: Acq92OGlTVKwPBKp66NP0DP3gXicpEfaFXI+z059x7OGNudKnyq7So3SqpIqOBaALyJ
	Z2veKENm+Eg3gjQEb9trRvjjKHr/rx4+i2gnHrA76uXscohyaBHfs2gTKx0x7lVBmlsfK9EpzLY
	dENBUhuOaz9s5jNhT+KObs0Gx9LCVnk46J6FxjP70wNrwKNhUFTd5sCpn+szZtK/kAC1VlXI0ga
	Gg1GKDy4M/M+hWOXnUukrGAWaNLh3rIgn/tW7HhO2UXZNuA7Uw4s8FO484P20fM4/bd+TD25UmK
	fgCAhapz0hHP9E+wvLo5BArR2A9Oth0tETsPm21bOAxUhg4KrO2t8TRmje2sjJZt2apvpSPCm3t
	MgLWoSwb3crgnPYkoZIo5ejuP9hhZI0Ms5YIGvCY4wh9a5ku8c+jGrHZoJ+KsIt7kaPMq/7tOuX
	evBjmDSlDP2nrCRnoZQPlkIbtw73S+537W9V6f/s+3cTTofcyUao/rX22NoPrA+QLg//7v5Zg3x
	qH52GSwt9K8lIgANAaA9PJqDsbLNApDWYCKjVk=
X-Received: by 2002:a05:6830:2703:b0:7e7:aac:4cc9 with SMTP id 46e09a7af769-7e70c63cc95mr13656464a34.3.1781029022313;
        Tue, 09 Jun 2026 11:17:02 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:48::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e6e7468f8fsm15118728a34.6.2026.06.09.11.17.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jun 2026 11:17:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 09 Jun 2026 11:17:00 -0700
Message-Id: <DJ4Q3GQQZV3Y.3CV449ZDL4ISM@gmail.com>
Cc: "Justin Suess" <utilityemal77@gmail.com>, "Alexei Starovoitov"
 <ast@kernel.org>, "Andrii Nakryiko" <andrii@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Eduard Zingerman" <eddyz87@gmail.com>, "Emil
 Tsalapatis" <emil@etsalapatis.com>, <kkd@meta.com>, <kernel-team@meta.com>
Subject: Re: [PATCH bpf-next v2 1/4] bpf: Reject bpf_obj_drop() from tracing
 progs
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, "Mykyta Yatsenko"
 <mykyta.yatsenko5@gmail.com>, <bpf@vger.kernel.org>
X-Mailer: aerc
References: <20260609093719.2858096-1-memxor@gmail.com>
 <20260609093719.2858096-2-memxor@gmail.com>
 <6461e40c-d5a9-41a5-aaba-bf063de67d3f@gmail.com>
 <DJ4KTKIMC9D2.29YWMVB0XFLSB@gmail.com>
In-Reply-To: <DJ4KTKIMC9D2.29YWMVB0XFLSB@gmail.com>

On Tue Jun 9, 2026 at 7:08 AM PDT, Kumar Kartikeya Dwivedi wrote:
> On Tue Jun 9, 2026 at 3:31 PM CEST, Mykyta Yatsenko wrote:
>>
>>
>> On 6/9/26 10:37 AM, Kumar Kartikeya Dwivedi wrote:
>>> From: Justin Suess <utilityemal77@gmail.com>
>>>
>>> bpf_obj_drop() runs bpf_obj_free_fields() synchronously for
>>> program-allocated objects. When such an object contains NMI unsafe
>>> fields, a non-iterator tracing program can reach that destruction from
>>> arbitrary instrumented context, including NMI.
>>>
>>> NMI is likely one instance of this problem, and other instances would
>>> include possible unsafe reentrancy. Deferring bpf_obj_drop() is not
>>> appealing either: it would add delayed-free machinery to a release
>>> operation that otherwise has straightforward synchronous ownership
>>> semantics.
>>>
>>> Reject bpf_obj_drop() and bpf_percpu_obj_drop() from tracing programs
>>> unless every field in the object's BTF record is explicitly NMI safe.
>>> Note that while bpf_rb_root and bpf_list_head would be NMI safe on thei=
r
>>> own to free, the objects recursively held by them may not be; be
>>> conservative and just mark them as not NMI safe for now.
>>>
>>> Use a whitelist for the NMI-safe field set instead of listing only know=
n
>>> NMI unsafe fields. Locks, async fields, unreferenced kptrs, and
>>> refcounts are known to be NMI safe because their destruction is either =
a
>>> no-op, simple state reset, or async cancellation. Referenced kptrs,
>>> percpu referenced kptrs, uptrs, graph roots, graph nodes, and any futur=
e
>>> field type are rejected until audited for arbitrary tracing and NMI
>>> contexts. This is less susceptible to future changes in fields that wer=
e
>>> previously safe by exclusion, and to new fields being added without
>>> updating this check.
>>>
>>> Convert the existing recursive local-object drop success case to a
>>> syscall program in the same commit, since this verifier change makes th=
e
>>> old tracing program form invalid. The test still exercises
>>> bpf_obj_drop() releasing a referenced task kptr from a safe program
>>> type.
>>>
>>> Fixes: ac9f06050a35 ("bpf: Introduce bpf_obj_drop")
>>> Signed-off-by: Justin Suess <utilityemal77@gmail.com>
>>> Co-developed-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
>>> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
>>> ---
>>>  include/linux/bpf.h                           | 29 +++++++++++++
>>>  kernel/bpf/verifier.c                         | 16 +++++++
>>>  .../selftests/bpf/prog_tests/task_kfunc.c     | 42 ++++++++++++++++++-
>>>  .../selftests/bpf/progs/task_kfunc_success.c  | 13 +++---
>>>  4 files changed, 92 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
>>> index 62bba7a4876f..0654d2ffadc1 100644
>>> --- a/include/linux/bpf.h
>>> +++ b/include/linux/bpf.h
>>> @@ -492,6 +492,35 @@ static inline bool btf_record_has_field(const stru=
ct btf_record *rec, enum btf_f
>>>  	return rec->field_mask & type;
>>>  }
>>>
>>> +static inline bool btf_field_is_nmi_safe(enum btf_field_type type)
>>> +{
>>> +	switch (type) {
>>> +	case BPF_SPIN_LOCK:
>>> +	case BPF_RES_SPIN_LOCK:
>>> +	case BPF_TIMER:
>>> +	case BPF_WORKQUEUE:
>>> +	case BPF_TASK_WORK:
>>> +	case BPF_KPTR_UNREF:
>>> +	case BPF_REFCOUNT:
>>> +		return true;
>>> +	default:
>>> +		return false;
>>> +	}
>>> +}
>>> +
>>> +static inline bool btf_record_has_nmi_unsafe_fields(const struct btf_r=
ecord *rec)
>>> +{
>>> +	int i;
>>> +
>>> +	if (IS_ERR_OR_NULL(rec))
>>> +		return false;
>>> +	for (i =3D 0; i < rec->cnt; i++) {
>>> +		if (!btf_field_is_nmi_safe(rec->fields[i].type))
>>> +			return true;
>>> +	}
>>> +	return false;
>>> +}
>>> +
>>
>> Do we need this stuff in the header file? Why not put it into the verifi=
er.c?
>
> No strong reason, I can move it to verifier.c too.
>
>>
>>>  static inline void bpf_obj_init(const struct btf_record *rec, void *ob=
j)
>>>  {
>>>  	int i;
>>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>>> index ed7ba0e6a9ce..3b43e2bd0f2a 100644
>>> --- a/kernel/bpf/verifier.c
>>> +++ b/kernel/bpf/verifier.c
>>> @@ -205,6 +205,7 @@ static int release_reference_nomark(struct bpf_veri=
fier_state *state, int id);
>>>  static int release_reference(struct bpf_verifier_env *env, int id);
>>>  static void invalidate_non_owning_refs(struct bpf_verifier_env *env);
>>>  static bool in_rbtree_lock_required_cb(struct bpf_verifier_env *env);
>>> +static bool is_tracing_prog_type(enum bpf_prog_type type);
>>>  static int ref_set_non_owning(struct bpf_verifier_env *env,
>>>  			      struct bpf_reg_state *reg);
>>>  static bool is_trusted_reg(struct bpf_verifier_env *env, const struct =
bpf_reg_state *reg);
>>> @@ -12881,6 +12882,7 @@ static int check_kfunc_call(struct bpf_verifier=
_env *env, struct bpf_insn *insn,
>>>  			    int *insn_idx_p)
>>>  {
>>>  	bool sleepable, rcu_lock, rcu_unlock, preempt_disable, preempt_enable=
;
>>> +	enum bpf_prog_type prog_type =3D resolve_prog_type(env->prog);
>>>  	struct bpf_reg_state *regs =3D cur_regs(env);
>>>  	const char *func_name, *ptr_type_name;
>>>  	const struct btf_type *t, *ptr_type;
>>> @@ -12957,6 +12959,20 @@ static int check_kfunc_call(struct bpf_verifie=
r_env *env, struct bpf_insn *insn,
>>>  	if (err < 0)
>>>  		return err;
>>>
>>> +	if ((is_bpf_obj_drop_kfunc(meta.func_id) ||
>>> +	     is_bpf_percpu_obj_drop_kfunc(meta.func_id)) && (is_tracing_prog_=
type(prog_type) ||
>>
>> We have sleepable tracepoints, are we going to reject them as well? I wo=
nder if there is a better way
>> to detect NMI context in verifier.
>>
>
> NMI is probably one concern, reentrancy is another, though admiteddly sle=
epable
> tracepoints are probably fine for this case (I didn't think too hard).

sleepable tracepoints are fine.
Could you adjust the check to allow it?

> That said, on the other bit about having better ways of detecting such th=
ings, I
> was wondering whether we should bite the bullet and decouple context info=
rmation
> from prog type. We sort of use program types as a proxy for it, but we ma=
y have
> more clarity around expectations and safety checks if the context a progr=
am may
> run in is extracted from the type (+ more contextual information like att=
ach BTF
> ID if available, otherwise falling back to the conservative set), and ope=
rations
> have their checks be done against the context. For helpers, kfuncs, excep=
t for
> specific special cases that require specific program hooks to function
> correctly, registration could move from program types to contexts it can =
be
> called in safely in general.
>
> This is something I've been wondering for a while, and it's a substantial
> change, but it appears to better fit the way we reason about safety now a=
nd use
> various program types in checks and kfunc registration in practice anyway=
.

Long term it's the right approach, but lets fix what we can for now.
