Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com [209.85.221.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B943280A56
	for <bpf@vger.kernel.org>; Tue,  9 Jun 2026 14:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781014143; cv=none; b=II4LO6cv+V35kwfuq0j9aUW4QmfSRKXJfinO05OiZVqR/6TjYtvrcRZz7BbgC8YFiEw4H6SG/frRZbzzucKXHmfhs6+O5Blh618Bnsou3Q7I1ZCJARmDMmYD68Yvn8YxtYdC8nINrngKearDpbmGDqWd7JwPknfe86qeJ6BxjEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781014143; c=relaxed/simple;
	bh=XuFgL4VFwODLUPKmh9LEeR/tK+QFHxKfgslpxnFYZc4=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=EsWzjfhXzaxPZUNT2iy6OuJ/vV+dCubfybRSx43NuHNxL+eEfEZ1lT4iJbsUdA7eNrfbsfnVafHrs3WtDj3Y0U9KXlLZR6cTSQKtsoGqk2LLhPgsMTCqugqYB4J6f6cJQQdbArJ1EBqKmD7gFg388VURKVwHlo4h95vS5DvBo2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HbpRTE7r; arc=none smtp.client-ip=209.85.221.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HbpRTE7r"
Received: by mail-wr1-f66.google.com with SMTP id ffacd0b85a97d-45ef82204c6so3013182f8f.3
        for <bpf@vger.kernel.org>; Tue, 09 Jun 2026 07:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781014141; x=1781618941; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HdveGUbwBQldGitmszC+ZuwEmUgx5qJ9BeUsaFP4BCo=;
        b=HbpRTE7rwzj+npfMmpu2hWKRUqmzqQUMjRjyt/TuofGmJ+M5YPv0qQppEvuYHReAuY
         U3aiN0KW55M9+ofeG4l3C4uh4iqWzj8uBMVjtsn2NCZbtLS/Zt9f//ouF87aDZF3EwUI
         34vfGsF1UjNJwOAi42W782sRjPZLywMGnlmsM1mlfHOHrMTeKx0n5G++dsS7r63800ys
         RWmFr3TFYnBdHf5sLCy9grunHyMuKBYYBdxVmZ2Gh2c10iCvjT0Dc3o8aMqjHg4YTcmO
         J2C/Ue8MFwxNDJzI1G+eAIujtHh557r3I71tgowd5mKd0RZROY6E6RgFyrZtc6cg6Fwb
         RRCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781014141; x=1781618941;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HdveGUbwBQldGitmszC+ZuwEmUgx5qJ9BeUsaFP4BCo=;
        b=KRZ8QVbramPlVfL4+74FYohAW5r1pd0tw6mCQHC6evo3v+tZ95BzmeglxwYnaCu7Ua
         DzjXxyaQVx7cms5tqH5cwAD/tjKh/jYEabLb6tCnjS0Rqg69eibWP4UzwBKASn25/eZ6
         XtF62wmXl4OhzsGk9AdjFv3uHsDP15i05QknGVEjB7ka1KGJErVBNPBx3jDgABkirAzW
         c6mjJ2S/6bpJmacziu8bh7XKZUbNR7xPgu2yIFjvLC5D/JYkPncELChYGak2lgzIwI+u
         p1sRFItYp97rcba73YfhhP+rZP2aZutx3OFO9PZi74OrTaSx1OHFcaypovT5yMpN6lOQ
         CoUQ==
X-Forwarded-Encrypted: i=1; AFNElJ/man8M70YRfWP7ZXUdYDrWw0wwXQ9HW3Tx49cKjekEUXUhJMvCMe4tQJ0VlAG6x+qmAQw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCamDzCB8ugaVn+Olwv/e5CIWdcMijuqmeHH4OU1pMGfyvQrME
	oPjAFdLFNEnppPiiNbPvzbZLXtUN8yaI+eoMhT10fEUGNmB2R4HFCEzi
X-Gm-Gg: Acq92OG/GTWN5KA7gsILEyUo6rp2cD4c4/WC5AgBedAT5iFOmrc4aM5Wcufks365PXz
	DwChgFN8uv7rVVmus76vDwqEHePKaCyja764oBXbOWK3mNOgoylIL6xTt4GW49KfLKYbiiy5MQW
	J/2XLCBYEEqmsMod7S1PBHdd3rrRfX+aKSjt3eeZcMMQrEg8cZeW/E5h6LA7kWvDVO76nFI0VE2
	duk0yoeN/fuJtZX3gbgS8Utt5HCN1K4YR6lU+aKmEdzQtsJ+3uaptrXW8T9VhPsCohMT85qFfDP
	BDKEz+ByyxS5llVo+JRZEC/Ea9YgFI0yD9rxDYjw11yPkqUjiuUPpTjgJVKacUB7FZj3WiM2oAk
	KQowgTlxBHNjknP+9bajYgaak01rT8DgTnz7oXCjoKefKOBJ/+ks9kWWYCpgmlblz9yEW73ot52
	C0oiTR24+afSD3bLF2/I97ApxFbttsEIJF1CWMyGwByhT6xfhHCN4rX9tunTyxC0gGgcpE+O4Bh
	RG+7BxVQwJYB34aQtfpwPT46m1SZ99AWBpBhnZpxEsF04pgA1/w5FQK188lW0oGaNfSMiSAiLak
	BUhniQHIkGU=
X-Received: by 2002:a5d:534f:0:b0:45e:e3ea:1101 with SMTP id ffacd0b85a97d-460302ec223mr26040221f8f.17.1781014140466;
        Tue, 09 Jun 2026 07:09:00 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2dc412sm64880554f8f.4.2026.06.09.07.08.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 07:08:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 09 Jun 2026 16:08:59 +0200
Message-Id: <DJ4KTKIMC9D2.29YWMVB0XFLSB@gmail.com>
Cc: "Justin Suess" <utilityemal77@gmail.com>, "Alexei Starovoitov"
 <ast@kernel.org>, "Andrii Nakryiko" <andrii@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Eduard Zingerman" <eddyz87@gmail.com>, "Emil
 Tsalapatis" <emil@etsalapatis.com>, <kkd@meta.com>, <kernel-team@meta.com>
Subject: Re: [PATCH bpf-next v2 1/4] bpf: Reject bpf_obj_drop() from tracing
 progs
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: "Mykyta Yatsenko" <mykyta.yatsenko5@gmail.com>, "Kumar Kartikeya
 Dwivedi" <memxor@gmail.com>, <bpf@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <20260609093719.2858096-1-memxor@gmail.com>
 <20260609093719.2858096-2-memxor@gmail.com>
 <6461e40c-d5a9-41a5-aaba-bf063de67d3f@gmail.com>
In-Reply-To: <6461e40c-d5a9-41a5-aaba-bf063de67d3f@gmail.com>

On Tue Jun 9, 2026 at 3:31 PM CEST, Mykyta Yatsenko wrote:
>
>
> On 6/9/26 10:37 AM, Kumar Kartikeya Dwivedi wrote:
>> From: Justin Suess <utilityemal77@gmail.com>
>>
>> bpf_obj_drop() runs bpf_obj_free_fields() synchronously for
>> program-allocated objects. When such an object contains NMI unsafe
>> fields, a non-iterator tracing program can reach that destruction from
>> arbitrary instrumented context, including NMI.
>>
>> NMI is likely one instance of this problem, and other instances would
>> include possible unsafe reentrancy. Deferring bpf_obj_drop() is not
>> appealing either: it would add delayed-free machinery to a release
>> operation that otherwise has straightforward synchronous ownership
>> semantics.
>>
>> Reject bpf_obj_drop() and bpf_percpu_obj_drop() from tracing programs
>> unless every field in the object's BTF record is explicitly NMI safe.
>> Note that while bpf_rb_root and bpf_list_head would be NMI safe on their
>> own to free, the objects recursively held by them may not be; be
>> conservative and just mark them as not NMI safe for now.
>>
>> Use a whitelist for the NMI-safe field set instead of listing only known
>> NMI unsafe fields. Locks, async fields, unreferenced kptrs, and
>> refcounts are known to be NMI safe because their destruction is either a
>> no-op, simple state reset, or async cancellation. Referenced kptrs,
>> percpu referenced kptrs, uptrs, graph roots, graph nodes, and any future
>> field type are rejected until audited for arbitrary tracing and NMI
>> contexts. This is less susceptible to future changes in fields that were
>> previously safe by exclusion, and to new fields being added without
>> updating this check.
>>
>> Convert the existing recursive local-object drop success case to a
>> syscall program in the same commit, since this verifier change makes the
>> old tracing program form invalid. The test still exercises
>> bpf_obj_drop() releasing a referenced task kptr from a safe program
>> type.
>>
>> Fixes: ac9f06050a35 ("bpf: Introduce bpf_obj_drop")
>> Signed-off-by: Justin Suess <utilityemal77@gmail.com>
>> Co-developed-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
>> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
>> ---
>>  include/linux/bpf.h                           | 29 +++++++++++++
>>  kernel/bpf/verifier.c                         | 16 +++++++
>>  .../selftests/bpf/prog_tests/task_kfunc.c     | 42 ++++++++++++++++++-
>>  .../selftests/bpf/progs/task_kfunc_success.c  | 13 +++---
>>  4 files changed, 92 insertions(+), 8 deletions(-)
>>
>> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
>> index 62bba7a4876f..0654d2ffadc1 100644
>> --- a/include/linux/bpf.h
>> +++ b/include/linux/bpf.h
>> @@ -492,6 +492,35 @@ static inline bool btf_record_has_field(const struc=
t btf_record *rec, enum btf_f
>>  	return rec->field_mask & type;
>>  }
>>
>> +static inline bool btf_field_is_nmi_safe(enum btf_field_type type)
>> +{
>> +	switch (type) {
>> +	case BPF_SPIN_LOCK:
>> +	case BPF_RES_SPIN_LOCK:
>> +	case BPF_TIMER:
>> +	case BPF_WORKQUEUE:
>> +	case BPF_TASK_WORK:
>> +	case BPF_KPTR_UNREF:
>> +	case BPF_REFCOUNT:
>> +		return true;
>> +	default:
>> +		return false;
>> +	}
>> +}
>> +
>> +static inline bool btf_record_has_nmi_unsafe_fields(const struct btf_re=
cord *rec)
>> +{
>> +	int i;
>> +
>> +	if (IS_ERR_OR_NULL(rec))
>> +		return false;
>> +	for (i =3D 0; i < rec->cnt; i++) {
>> +		if (!btf_field_is_nmi_safe(rec->fields[i].type))
>> +			return true;
>> +	}
>> +	return false;
>> +}
>> +
>
> Do we need this stuff in the header file? Why not put it into the verifie=
r.c?

No strong reason, I can move it to verifier.c too.

>
>>  static inline void bpf_obj_init(const struct btf_record *rec, void *obj=
)
>>  {
>>  	int i;
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index ed7ba0e6a9ce..3b43e2bd0f2a 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -205,6 +205,7 @@ static int release_reference_nomark(struct bpf_verif=
ier_state *state, int id);
>>  static int release_reference(struct bpf_verifier_env *env, int id);
>>  static void invalidate_non_owning_refs(struct bpf_verifier_env *env);
>>  static bool in_rbtree_lock_required_cb(struct bpf_verifier_env *env);
>> +static bool is_tracing_prog_type(enum bpf_prog_type type);
>>  static int ref_set_non_owning(struct bpf_verifier_env *env,
>>  			      struct bpf_reg_state *reg);
>>  static bool is_trusted_reg(struct bpf_verifier_env *env, const struct b=
pf_reg_state *reg);
>> @@ -12881,6 +12882,7 @@ static int check_kfunc_call(struct bpf_verifier_=
env *env, struct bpf_insn *insn,
>>  			    int *insn_idx_p)
>>  {
>>  	bool sleepable, rcu_lock, rcu_unlock, preempt_disable, preempt_enable;
>> +	enum bpf_prog_type prog_type =3D resolve_prog_type(env->prog);
>>  	struct bpf_reg_state *regs =3D cur_regs(env);
>>  	const char *func_name, *ptr_type_name;
>>  	const struct btf_type *t, *ptr_type;
>> @@ -12957,6 +12959,20 @@ static int check_kfunc_call(struct bpf_verifier=
_env *env, struct bpf_insn *insn,
>>  	if (err < 0)
>>  		return err;
>>
>> +	if ((is_bpf_obj_drop_kfunc(meta.func_id) ||
>> +	     is_bpf_percpu_obj_drop_kfunc(meta.func_id)) && (is_tracing_prog_t=
ype(prog_type) ||
>
> We have sleepable tracepoints, are we going to reject them as well? I won=
der if there is a better way
> to detect NMI context in verifier.
>

NMI is probably one concern, reentrancy is another, though admiteddly sleep=
able
tracepoints are probably fine for this case (I didn't think too hard).

That said, on the other bit about having better ways of detecting such thin=
gs, I
was wondering whether we should bite the bullet and decouple context inform=
ation
from prog type. We sort of use program types as a proxy for it, but we may =
have
more clarity around expectations and safety checks if the context a program=
 may
run in is extracted from the type (+ more contextual information like attac=
h BTF
ID if available, otherwise falling back to the conservative set), and opera=
tions
have their checks be done against the context. For helpers, kfuncs, except =
for
specific special cases that require specific program hooks to function
correctly, registration could move from program types to contexts it can be
called in safely in general.

This is something I've been wondering for a while, and it's a substantial
change, but it appears to better fit the way we reason about safety now and=
 use
various program types in checks and kfunc registration in practice anyway.

It would be nice to hear opinions on whether this makes sense to others.

> [...]
