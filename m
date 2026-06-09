Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A842373BE4
	for <bpf@vger.kernel.org>; Tue,  9 Jun 2026 16:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781021648; cv=none; b=cjnmP0CUTpp9y0whpgklwZ6TuJVzlBbFRpFwuvG6ci2lBUS7cm34SOEwDZa9/SI8gey9Upho82qzWJd9DiqWwiORrdi8fjh+1ZM12gFNE+olKJWHHG2GEWsI3xtoBg5UUz5ozfiMaHTbat795WxMyX43sOABph7b8WVJGiaGpF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781021648; c=relaxed/simple;
	bh=0VHi3EqmTGQGIdYmf8CtToaxhs1X/yFGOXkpHgCtcqQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fuA7K26JqYjniFUOu7jvDTfWjPwZWJOu12Uu67907vIV39XNgOeGFOmstQMvHpmCkXtw+LwbMaHnSmQepYUJ7AwAr4F4bxi6ZBg3Ky8K6o1Y88ZteLsA5mcGh/3B9VySiX5uFbrYz1wdiUH58XbGXtARGmuVjhUnYdWYUPehFRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KvFZX7VP; arc=none smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KvFZX7VP"
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-66077e90382so5385866d50.3
        for <bpf@vger.kernel.org>; Tue, 09 Jun 2026 09:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781021645; x=1781626445; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4SkP+4hAsK48wZppobrk4e2uA0hYpVmcp+bslq+iUWI=;
        b=KvFZX7VP5T7r3GVLnobbtt0NKiTEY0E9hr8gdwq34DWix+BaxpugSeWN7zFO1b5Y+K
         zkr3rcn2yvxC6lgNzGEyClua+ehg11D+hU/EdXs0Tixb89j/pheacitC8zHiF2WAGPi7
         nK16PwBu3XscLW4DBmcGiSPhx2tXurAVxj0510Yag+Py/kGuapQ0GuaBOJma4OvtwEc3
         YBlgl/JYLXROWnCg/qc8vi7L7dbYs3892X7aG3pc2OLrK5CcTpW51mDNML09qPMO/O0F
         ZVZIkNZS3VxA6XrbVjhzOGaAgFibIVgox8b2n5SuTzDEDu2GXg1DQ5cWNIaw6WjosWoQ
         ji1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781021645; x=1781626445;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4SkP+4hAsK48wZppobrk4e2uA0hYpVmcp+bslq+iUWI=;
        b=nTYafbQzy4O99Qtk+g6CeQEY9wIjjxBdxZaKHmzzKaoYq5NHZTBoBqnnPRm6iCVBq2
         g4k2i5+adGoVt4rtj3wYD8VLh/au8AOgGLmTaaK40tcTw1Lx0ITzRhtnPND8/KhFv89S
         54w52ZAcPwbxHjIm8y3lwVhOcQyNSDHaFEHnXPwHc62x13PlctNGTdzls7Dtz4Zc1Ow4
         KeDTVRrcuyVGFJMapukb10wkqI0Ff7BtBlT2iuVMR9FejcqOnqJvmgw2wKyzMLPj/Qkv
         NxiuMVnQNzZ7u4qHMuMiyb8EglleSTPBXVDBik4twD/VwDQwJC7Wm+FGGok3QdxX/xxZ
         dpew==
X-Forwarded-Encrypted: i=1; AFNElJ/SZC7OMFXVwbaAZsGhw1mIcFoMo/F2RBPOYr3JYfvbdTxH1dEVIC4DUAelSgnHG9yvGa8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBrTIo5L9ERMlg8WUsuXWQyEwMqlQJC134qnv7gYKk/Qkjnd7n
	ishcrtu3HjdHKOdJIGper4NnOtzX7rEIoNxPynmnGdvMyjaQF+Qw37pr
X-Gm-Gg: Acq92OEgg1KsTphJLo3RTkZUzubikNRnppSR+2MO66IgVSwB3ecipsK710rPDbU6aAc
	rA12Y0zVCE7M8nL1juUNXxe0F8YPs/mk72esu4iu6+OSsDcnvsG0/J7+ovwmsnmjqQfUZyV0yEP
	lHAvs5px/e0Zh1Y1PH2HmAMaS+myuURihVHPTncAy72zJ73goBAetkWC3Ef54X6ItkvkFcCBOAx
	nFhV/NgE6q91cTbEUZvAsTHqV6U0s7QgcuJ9wHik8hv9Khh3RKCdtCqaby3AhLzHdHTnTG0Prd6
	+6XsQpmSbu7Ca+6ui6OpCWMPNimWq1iXb8yblisZaubHEmlRi4xSkw67m2/k5rxprMyqSFg9mA5
	IIfEDDrQzmbPP302SB8Y7C1CMOCGE8hOVi8QUFgmxlr5eMMlDZBI+LI5dtj6YtMxN6lQYiLCFE3
	K3f8+3W60Jsqx3Bw4hEARb17ssRz4QhFRoKopyRTLRJtjDb50WbryvtdAFoCK0CabjladM
X-Received: by 2002:a05:690e:1246:b0:660:6a0c:c734 with SMTP id 956f58d0204a3-6614f5f5611mr2748895d50.17.1781021645376;
        Tue, 09 Jun 2026 09:14:05 -0700 (PDT)
Received: from zenbox ([2600:1700:18fb:6011:d24f:b671:dfad:f318])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-660d62046fasm11141650d50.13.2026.06.09.09.14.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 09:14:04 -0700 (PDT)
Date: Tue, 9 Jun 2026 12:14:04 -0400
From: Justin Suess <utilityemal77@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf@vger.kernel.org, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman <eddyz87@gmail.com>, 
	Emil Tsalapatis <emil@etsalapatis.com>, kkd@meta.com, kernel-team@meta.com
Subject: Re: [PATCH bpf-next v2 1/4] bpf: Reject bpf_obj_drop() from tracing
 progs
Message-ID: <aigqmuXsSfIwyed3@zenbox>
References: <20260609093719.2858096-1-memxor@gmail.com>
 <20260609093719.2858096-2-memxor@gmail.com>
 <6461e40c-d5a9-41a5-aaba-bf063de67d3f@gmail.com>
 <DJ4KTKIMC9D2.29YWMVB0XFLSB@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DJ4KTKIMC9D2.29YWMVB0XFLSB@gmail.com>

On Tue, Jun 09, 2026 at 04:08:59PM +0200, Kumar Kartikeya Dwivedi wrote:
> On Tue Jun 9, 2026 at 3:31 PM CEST, Mykyta Yatsenko wrote:
> >
> >
> > On 6/9/26 10:37 AM, Kumar Kartikeya Dwivedi wrote:
> >> From: Justin Suess <utilityemal77@gmail.com>
> >>
> >> bpf_obj_drop() runs bpf_obj_free_fields() synchronously for
> >> program-allocated objects. When such an object contains NMI unsafe
> >> fields, a non-iterator tracing program can reach that destruction from
> >> arbitrary instrumented context, including NMI.
> >>
> >> NMI is likely one instance of this problem, and other instances would
> >> include possible unsafe reentrancy. Deferring bpf_obj_drop() is not
> >> appealing either: it would add delayed-free machinery to a release
> >> operation that otherwise has straightforward synchronous ownership
> >> semantics.
> >>
> >> Reject bpf_obj_drop() and bpf_percpu_obj_drop() from tracing programs
> >> unless every field in the object's BTF record is explicitly NMI safe.
> >> Note that while bpf_rb_root and bpf_list_head would be NMI safe on their
> >> own to free, the objects recursively held by them may not be; be
> >> conservative and just mark them as not NMI safe for now.
> >>
> >> Use a whitelist for the NMI-safe field set instead of listing only known
> >> NMI unsafe fields. Locks, async fields, unreferenced kptrs, and
> >> refcounts are known to be NMI safe because their destruction is either a
> >> no-op, simple state reset, or async cancellation. Referenced kptrs,
> >> percpu referenced kptrs, uptrs, graph roots, graph nodes, and any future
> >> field type are rejected until audited for arbitrary tracing and NMI
> >> contexts. This is less susceptible to future changes in fields that were
> >> previously safe by exclusion, and to new fields being added without
> >> updating this check.
> >>
> >> Convert the existing recursive local-object drop success case to a
> >> syscall program in the same commit, since this verifier change makes the
> >> old tracing program form invalid. The test still exercises
> >> bpf_obj_drop() releasing a referenced task kptr from a safe program
> >> type.
> >>
> >> Fixes: ac9f06050a35 ("bpf: Introduce bpf_obj_drop")
> >> Signed-off-by: Justin Suess <utilityemal77@gmail.com>
> >> Co-developed-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> >> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> >> ---
> >>  include/linux/bpf.h                           | 29 +++++++++++++
> >>  kernel/bpf/verifier.c                         | 16 +++++++
> >>  .../selftests/bpf/prog_tests/task_kfunc.c     | 42 ++++++++++++++++++-
> >>  .../selftests/bpf/progs/task_kfunc_success.c  | 13 +++---
> >>  4 files changed, 92 insertions(+), 8 deletions(-)
> >>
> >> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> >> index 62bba7a4876f..0654d2ffadc1 100644
> >> --- a/include/linux/bpf.h
> >> +++ b/include/linux/bpf.h
> >> @@ -492,6 +492,35 @@ static inline bool btf_record_has_field(const struct btf_record *rec, enum btf_f
> >>  	return rec->field_mask & type;
> >>  }
> >>
> >> +static inline bool btf_field_is_nmi_safe(enum btf_field_type type)
> >> +{
> >> +	switch (type) {
> >> +	case BPF_SPIN_LOCK:
> >> +	case BPF_RES_SPIN_LOCK:
> >> +	case BPF_TIMER:
> >> +	case BPF_WORKQUEUE:
> >> +	case BPF_TASK_WORK:
> >> +	case BPF_KPTR_UNREF:
> >> +	case BPF_REFCOUNT:
> >> +		return true;
> >> +	default:
> >> +		return false;
> >> +	}
> >> +}
> >> +
> >> +static inline bool btf_record_has_nmi_unsafe_fields(const struct btf_record *rec)
> >> +{
> >> +	int i;
> >> +
> >> +	if (IS_ERR_OR_NULL(rec))
> >> +		return false;
> >> +	for (i = 0; i < rec->cnt; i++) {
> >> +		if (!btf_field_is_nmi_safe(rec->fields[i].type))
> >> +			return true;
> >> +	}
> >> +	return false;
> >> +}
> >> +
> >
> > Do we need this stuff in the header file? Why not put it into the verifier.c?
> 
> No strong reason, I can move it to verifier.c too.
> 
> >
> >>  static inline void bpf_obj_init(const struct btf_record *rec, void *obj)
> >>  {
> >>  	int i;
> >> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> >> index ed7ba0e6a9ce..3b43e2bd0f2a 100644
> >> --- a/kernel/bpf/verifier.c
> >> +++ b/kernel/bpf/verifier.c
> >> @@ -205,6 +205,7 @@ static int release_reference_nomark(struct bpf_verifier_state *state, int id);
> >>  static int release_reference(struct bpf_verifier_env *env, int id);
> >>  static void invalidate_non_owning_refs(struct bpf_verifier_env *env);
> >>  static bool in_rbtree_lock_required_cb(struct bpf_verifier_env *env);
> >> +static bool is_tracing_prog_type(enum bpf_prog_type type);
> >>  static int ref_set_non_owning(struct bpf_verifier_env *env,
> >>  			      struct bpf_reg_state *reg);
> >>  static bool is_trusted_reg(struct bpf_verifier_env *env, const struct bpf_reg_state *reg);
> >> @@ -12881,6 +12882,7 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
> >>  			    int *insn_idx_p)
> >>  {
> >>  	bool sleepable, rcu_lock, rcu_unlock, preempt_disable, preempt_enable;
> >> +	enum bpf_prog_type prog_type = resolve_prog_type(env->prog);
> >>  	struct bpf_reg_state *regs = cur_regs(env);
> >>  	const char *func_name, *ptr_type_name;
> >>  	const struct btf_type *t, *ptr_type;
> >> @@ -12957,6 +12959,20 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
> >>  	if (err < 0)
> >>  		return err;
> >>
> >> +	if ((is_bpf_obj_drop_kfunc(meta.func_id) ||
> >> +	     is_bpf_percpu_obj_drop_kfunc(meta.func_id)) && (is_tracing_prog_type(prog_type) ||
> >
> > We have sleepable tracepoints, are we going to reject them as well? I wonder if there is a better way
> > to detect NMI context in verifier.
> >
> 
> NMI is probably one concern, reentrancy is another, though admiteddly sleepable
> tracepoints are probably fine for this case (I didn't think too hard).
> 
> That said, on the other bit about having better ways of detecting such things, I
> was wondering whether we should bite the bullet and decouple context information
> from prog type. We sort of use program types as a proxy for it, but we may have
> more clarity around expectations and safety checks if the context a program may
> run in is extracted from the type (+ more contextual information like attach BTF
> ID if available, otherwise falling back to the conservative set), and operations
> have their checks be done against the context. For helpers, kfuncs, except for
> specific special cases that require specific program hooks to function
> correctly, registration could move from program types to contexts it can be
> called in safely in general.
> 
> This is something I've been wondering for a while, and it's a substantial
> change, but it appears to better fit the way we reason about safety now and use
> various program types in checks and kfunc registration in practice anyway.
> 
> It would be nice to hear opinions on whether this makes sense to others.
>
For the NMI case, this seems like a function coloring problem.
Basically there's a subset of functions and tracepoints in the kernel
that are reachable in NMI.

We could naively through some instrumentation, tag any
function explicitly called by an NMI handler as NMI unsafe.

This doesn't work perfectly. Dynamic dispatch via function pointers
defeats this approach. This would also be prone to false positives,
where a function reachable from an NMI handler reachable function
could have a conditonal call that never triggers if called from NMI.

The problem here mirrors that which motivated the introduction of the
resilient spinlock. Statically analyzing the locking correctness
to prevent deadlock is impossible for all cases, therefore, the failure
state was moved to runtime. This is similar; we can't statically analyze
the interrupt state at the many programs/attach sites available to BPF
programs without overshooting or undershooting.

The approach here is the overshooting case.

*Bottom line is that statically analyzing interrupt state is impossible.*
Runtime detection is technically possible. But it opens up a different
can of worms: safely handling the error condition without causing
breakage.

I considered the following approaches, but decided against it.

For each of the below:

Introduce a helper meta attribute and a kfunc annotation (KF_NMI)
to whitelist the kfuncs and helpers that safely handle NMI. Think much
like KF_SLEEPABLE. There could be others, KF_SOFTIRQ, KF_HARDIRQ, etc.

KF_NMI could imply the lower ranked interrupt KF_HARDIRQ and KF_SOFTIRQ

Annotating the functions with the interrupt safety allows
us to determine a verdict on the highest interrupt level a given
program can be safely run in. For example, a program making a call to a
KF_NMI and a KF_HARDIRQ function could be known to be safe to run in
hardirq, but not safe in NMI. because KF_HARDIRQ < KF_NMI.

When we can determine at verification time that the program context is
safe for those contexts, we allow them to be called.

a) Require explicit guard against interrupt contexts

For cases where static analysis is impossible, we allow their emission
only in a branch that explicitly guards against that interrupt.

For a practical example:

We could allow bpf_obj_drop in fentry tracing progs if guarded

    if (bpf_in_nmi()) /* helper doesn't exist yet, hypothetical */
      bpf_obj_drop(some kptr);

Other kfuncs / helpers could be adjusted to move that check inside
the function call, exposing the failure through an error return code,
if the function's return type permits it.

   int err = some_nmi_unsafe_function();

Obviously this isn't possible for void returning functions.

b) Implicit guard of interrupt context

We implictly emit this conditional branch through a fix up.
Basically we allow the emission of these helpers/kfuncs, but generate
bytecode that skips the call if the context for calling it is unsafe

So in pseudocode when the user calls some non-KF_NMI function, we rewrite
it to

    if (bpf_in_nmi()) /* helper doesn't exist yet, hypothetical */
      bpf_obj_drop(some kptr);

The issue is that this conditional would be invisible to the user,
invokation of the function would be silently skipped.

c) Literally just drop the call

Insert a guard for the highest allowed interrupt level at the beginning
of the program's invokation. (our verdict)

If the guard fails abort the program / return 0 for fmodify.

This is the simplest approach, but the error condition is not
transparent to the user.

We could add a tracepoint that catches the condition, but this in itself
would run at the same interrupt context, so it would probably need to
*require* at verification time that all functions have KF_(Whatever
interrupt safety level)
...

All of these approaches are problematic at some level.
This is just some ideas to add.

Justin
> > [...]
