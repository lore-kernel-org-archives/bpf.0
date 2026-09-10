Received: from mail-oi2-f13.google.com (mail-oi2-f13.google.com [74.125.231.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76E844825B6
	for <bpf@vger.kernel.org>; Thu, 10 Sep 2026 17:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.231.205
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789061000; cv=pass; b=Zdv9Iqrd9pCtztootHUnXJPBoKcxJ9pgvq9i7k3ZiBq9cy0zmqGGv44OMNhk+ECh6q9j6i90uuZdepJI8fuFifoHGdeZ3+o9+5rM8CCZHCi4v3Ygk7qip/6pt1yrV4oo/z1A+2QraGPDYbIDeiKbsR26c10aXRbXvHp4I1E7Ejc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789061000; c=relaxed/simple;
	bh=QWzv6mMyKJ6F6smxvkkZE7MvMl7iLeK7FwhbVCg324E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ercZhNblSz40d3QgZKbJGj3SzGEOdqBx+fNSady8vgC/1Q2O0zsatdvFktbi9wSgL4VO5Cb7IAd4WSXRdcZZ6DFbmvcV3lYJUZAK/0jRfFaJUqm6JLOUAmVtDQjTZqxlku2eUmC6AwLuaDHu7RW0J/F+Q08r6buEChPUd92iYKU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e9lnSrgx; arc=pass smtp.client-ip=74.125.231.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e9lnSrgx"
Received: by mail-oi2-f13.google.com with SMTP id 5614622812f47-4c2c368cb3bso23451b6e.3
        for <bpf@vger.kernel.org>; Thu, 10 Sep 2026 10:23:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789060983; cv=none;
        d=google.com; s=arc-20260327;
        b=seVq9emGycYztrj52LAfgmFKl2N0ePd+9dUw+xrn2AnCB0TpJfYfbiDogP8Y0zfusf
         IkPt0yQR3wpUazkNZnTqULhCwrGQRRqlwmNsXhqQ41XmzkBqPduZIpNvEJOxQ+b6UMVO
         WQdwpThVm9CZ0K48WOrKupXiNH7FHl4+BO+IVbDxLBG2eQQXTXX7dnrxOFUF2iWMaOWh
         FWR2JoG68JJufa14gKJ1iKo3vqYelxaLWDR1kVp4ntW3tNjem3xV7KqTSn5GEIQ2vd0e
         5xJZvZmTvS0I265b0dC0hsXKLRVsulr1P/y5TVO8gNst7Plf1KBVPccFyrQKE2ti2Sz0
         o3Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WLlwZGr5iqfFUg5T5BdI7Tls4koASQtnx+Gj89diFcY=;
        fh=90koC9cS8SPgzGFpm6lzb6qmufhM53XtAD4j/yggld0=;
        b=LZZkjkz9wH7O0X9/vWt4BOeM8VL6rCH0QQUF79xQSI6ib0tk5nuCbXTLrv3uJkHnux
         M5c/KF8DkDwRUUhEzC7xyB6fuMTTXA0GjH/XcKxJ4Z85SVNXbadwqTAulDtqrmFNE52H
         d1US17jiTUkxMFp4yg4xzjfskm/cdI1sC9NcfhwtzOoY8xDDyLr3XkVNfDNEs5tYaQWI
         fB4XGGKf4LG70UiGqyYXgh9gStsXj1gNrS5fqvHSPQzg8Te8whlS3Ifvf80ic3Jz7KXh
         vVCpjT7AORRqjSdDy3FBGmSENsJau+fjfQ0+2DCFTw3fROQp1viTZgNDfsQ42jlPTAVD
         uXvQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789060983; x=1789665783; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WLlwZGr5iqfFUg5T5BdI7Tls4koASQtnx+Gj89diFcY=;
        b=e9lnSrgxRLxtOa1C9LB8aDTVSQUknWkOibxbFLx2McGCJaOfxYNZLwf0+Kz7WfY4So
         NqlC1+I0RlWNslgdifVftyHGo/Bm9fVuS3FT3riscDLXFUoNqlxu2QDGSKjLZiTeoqEC
         rmXFxtah/zF9T8ARQADC8SeFj3THdrEptShM+i8bmg9t+7gZaMXBPtalciqDmvhTHuho
         aKEYhXrHHS3v79/BwXtU5UVsdWlzbCGMaMBpHFqRdf/ANui2QG9LNtRPCG2RCume0CJh
         0unwMXYS+/nZ0LikA7t2k94IT0iEqbFYdNXjHpYJapNhZzeBX9WRfs09ydBbZTfwR98j
         vqJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789060983; x=1789665783;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WLlwZGr5iqfFUg5T5BdI7Tls4koASQtnx+Gj89diFcY=;
        b=Hz26dx7CLgzIyCniEYoDi1CU5sID0SViscLAPi1hSOFIzc4XsyQFpvGTDXfFvu66dA
         kYyz0q+EhPQpFYeLVe7G1s3oWVySAEGn+wZMWTJH16J7hAZpldwQ7CZ4HNmYa6rjoSj0
         C6jeykle7n7OnNDsaj24tacAUAU3W04kC7WtoxgIMFOcxcUwRFVkDepco1rY3yw/6JjW
         dZmYF2483a6vnkwC6gU7JMMRl5usWjvDtyZdu9mg69IB8t04hybHw6Qw1U0KjXiKTRD2
         HJThmbnXhPHBbQlb7VHK7l+1JPxpIbCQoS6e8xTnxy2gzjWIYELJ1FyxFLvp6fodCARv
         oUHQ==
X-Gm-Message-State: AFuF++lAWYoPj2hGQ06VQEhNB5sC5BSQlL9ARHe3Z7uqbbz9WzkJc1Bf
	QlWzxU4ytpG2X0jDkfjlXbVFAWUDEPuTHCpCQff5EiT6KLVMVBoc0PyXaidsI0JMIcbwMWX2XY7
	TpIElnIJTGwCzNpD6U0R7TXJwMdMxuVY=
X-Gm-Gg: AYBFou1KYB7efTsXmDVx+FSAzj82wCOoOpXgOI2VffxQ0klUkRBLSpwijhYwqgQ6QG/
	LUAddeojbawVa1Q5+Jrd9BoLjy1LWv1sD2Ryx/3IvsA5VGL9FCFm+EmXfcsL02MdemJuE4g7Gx9
	YPybKAdcHEdw3X5iTCi9jgq2aUvGjdIZ5D8wywCspSlizsRn4FJEjZkCHP54tkpnOXy0X06RWQ3
	pT+YxBOR5pLv1Z9jWSYF2BXQ2m29VWI+FUOwoPfnWPl9LI30pniTqFG4BnS1Er2e2R3mFXSQpDV
	MQLaexBfNuJGtuN1AYGNT4QDaC4CG13KtD6Jn9fZgfgwRbtqFgrx3T4=
X-Received: by 2002:a4a:e1cb:0:b0:6b1:9d40:836e with SMTP id
 006d021491bc7-6c0bc7c3d7dmr20346eaf.22.1789060983290; Thu, 10 Sep 2026
 10:23:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260910044006.2279547-1-xyx2021@mail.ustc.edu.cn> <20260910044006.2279547-2-xyx2021@mail.ustc.edu.cn>
In-Reply-To: <20260910044006.2279547-2-xyx2021@mail.ustc.edu.cn>
From: Amery Hung <ameryhung@gmail.com>
Date: Thu, 10 Sep 2026 10:22:52 -0700
X-Gm-Features: AcwNN1Vi7cmHtAHrtEoLxzdQ1Tui9W7d7r0__8GtP2QjUq5IQP4JRamPpR566yw
Message-ID: <CAMB2axOmdHwSrHihSRskDywkCmEGQOX+6dZPN_A9u-HhxY3UDA@mail.gmail.com>
Subject: Re: [PATCH bpf v2 1/2] bpf: Preserve escaped dynptr slice ancestry on
 subprog return
To: Xu Yunxiang <xyx2021@mail.ustc.edu.cn>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Sashiko <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 9, 2026 at 9:40=E2=80=AFPM Xu Yunxiang <xyx2021@mail.ustc.edu.c=
n> wrote:
>
> Dynptr slices use parent_id to link their lifetime to the dynptr that
> produced them. bpf_dynptr_clone() gives each clone a unique id while
> retaining the shared reference parent_id.
>
> Before the object relationship refactor, a slice also carried the shared
> reference id directly. The refactor instead made the slice a child of its
> source dynptr's unique id. If a callee derives a slice from a local clone
> and returns the slice to its caller, freeing the callee removes that clon=
e
> id from the verifier state. A later release of the original dynptr can no
> longer reach the escaped slice, so the verifier keeps accepting accesses
> after the ring buffer reservation has been released.
>
> A similar disconnect affects dynptrs constructed from referenced objects.
> For example, a qdisc skb dynptr records the skb reference as its parent,
> but the skb dynptr type itself does not own a reference.
>
> Before freeing a callee, reparent surviving PTR_TO_MEM slices of every
> dynptr with a parent to that parent. This preserves the lifetime link aft=
er
> the local dynptr disappears for both reference-owning dynptrs and dynptrs
> constructed from referenced objects.

Summarizing the problem: On subprogram return, free_func_state()
discards stack-based objects without applying their normal destruction
semantics. Surviving children may retain parent_ids to removed
objects, breaking later cascading invalidation.

The correct fix is to apply dynptr destruction semantics before
exiting the callee: scan its stack slots and reuse the teardown logic,
destroy_if_dynptr_stack_slot(). This rejects losing the last
release-capable dynptr and invalidates slices derived from local
clones.

Reparenting the slice is incorrect because it allows the slice to
outlive the specific parent dynptr. Consequently, the proposed success
test should be a failure test.

>
> Fixes: 308c7a0ae885 ("bpf: Refactor object relationship tracking and fix =
dynptr UAF bug")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/r/20260829040712.B1B511F000E9@smtp.kernel=
.org
> Assisted-by: LLM
> Signed-off-by: Xu Yunxiang <xyx2021@mail.ustc.edu.cn>
> ---
>  kernel/bpf/verifier.c | 34 ++++++++++++++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 72a3f5998dd27..ee41b7386f752 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -800,6 +800,39 @@ static int dynptr_ref_cnt(struct bpf_verifier_env *e=
nv, int v_parent_id)
>         return ref_cnt;
>  }
>
> +static void reparent_dynptr_slices_on_func_exit(struct bpf_verifier_env =
*env,
> +                                               struct bpf_func_state *ca=
llee)
> +{
> +       struct bpf_verifier_state *vstate =3D env->cur_state;
> +       struct bpf_func_state *state;
> +       struct bpf_reg_state *reg;
> +       int i;
> +
> +       for (i =3D 0; i < callee->allocated_stack / BPF_REG_SIZE; i++) {
> +               struct bpf_stack_state *slot =3D &callee->stack[i];
> +               struct bpf_reg_state *dynptr =3D &slot->spilled_ptr;
> +
> +               if (slot->slot_type[0] !=3D STACK_DYNPTR ||
> +                   !dynptr->dynptr.first_slot ||
> +                   !dynptr->parent_id)
> +                       continue;
> +
> +               /*
> +                * A callee can spill a slice derived from its local dynp=
tr into
> +                * the caller's stack. The slice then outlives the dynptr=
 id that
> +                * links it to the rest of the object tree. Preserve that=
 link by
> +                * making escaped slices children of the dynptr's parent =
before
> +                * the callee frame is freed.
> +                */
> +               bpf_for_each_reg_in_vstate(vstate, state, reg, ({
> +                       if (state =3D=3D callee || reg->parent_id !=3D dy=
nptr->id ||
> +                           base_type(reg->type) !=3D PTR_TO_MEM)
> +                               continue;
> +                       reg->parent_id =3D dynptr->parent_id;
> +               }));
> +       }
> +}
> +
>  static int destroy_if_dynptr_stack_slot(struct bpf_verifier_env *env,
>                                         struct bpf_func_state *state, int=
 spi)
>  {
> @@ -10399,6 +10432,7 @@ static int prepare_func_exit(struct bpf_verifier_=
env *env, int *insn_idx)
>                 print_verifier_state(env, state, caller->frameno, true);
>         }
>         account_processed_insns(env, callee, caller);
> +       reparent_dynptr_slices_on_func_exit(env, callee);
>         /* clear everything in the callee. In case of exceptional exits u=
sing
>          * bpf_throw, this will be done by copy_verifier_state for extra =
frames. */
>         free_func_state(callee);
> --
> 2.43.0
>
