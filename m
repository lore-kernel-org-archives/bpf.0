Received: from mail-oo2-f42.google.com (mail-oo2-f42.google.com [74.125.231.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18D42448D18
	for <bpf@vger.kernel.org>; Fri, 11 Sep 2026 20:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.231.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789159694; cv=pass; b=JwnLsqlrBgLKYCasqX3BS0cymQe3B0rb2imoLE86+is9Un9+2zX6RlfkWxIORSka4vrzhKu6B+afw8eDOFWBH1iGOb6l4qhddfjIB6YAlyXiaoh0DjQW5phsNrA7KexYyd+VxVA9sfzDExuK8Mg/WLUExhJPCZS/xmm38YIH3wY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789159694; c=relaxed/simple;
	bh=WJJUxMQnIYlqTY7weddpVLkgDOQJ2l1v5sv9+4HFY30=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Uo+uRFurtotc9xxEKNuc+sdxdgGIffyzlmbbpNRaESATKZtlajN/fOOBwyvq8K8uq9NfZsbihufjw5z1G3vqiFw15zU06P7gjBLTY6pqvZSDk0e6mmGqhNTRObn7poJh1YCmbtgZl/xiC5kAFmo5iL+qei5fHenJLT8zg2WxV3c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IJMzsuKb; arc=pass smtp.client-ip=74.125.231.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IJMzsuKb"
Received: by mail-oo2-f42.google.com with SMTP id 006d021491bc7-6bda350b708so13225eaf.1
        for <bpf@vger.kernel.org>; Fri, 11 Sep 2026 13:48:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789159692; cv=none;
        d=google.com; s=arc-20260327;
        b=NllZgEHxQzz/bIPjybGGsCB+NZ/hank52ARkxoTEypVM5t/iFurb67q378wba0t2ge
         P+6wFrCAGROCUWasA8b+y946nXNds70YQkqfEdZGANGVExYG+lYnD76PzfHe45JdOCla
         gC+umfHLDZ7PioFZLALTfpD2dErBHI55TCYW9SiXQ6nNM3w7UATP4iie35atJszTgSrW
         2N9R43yEDAoFD7T0ZFpj7mJsqLWpoqfrHtYMHiMW+Iq8ZmWi9to3i+UzxslSpMqKYJ9V
         A4TgsoiEAsJow0LUGH0ZRdnKjxWyNPzk7TWC6z7fiDkxjIiB8D68hx/YQLFvpRtARQYe
         tmYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gynqWXK1xgfql7bTl8aLcrJkuClGPb6RM+NHBdDTwcM=;
        fh=+iofH7kLhUIpDUAo/a2rUbKulXCH8Go9n65YHAt0kP0=;
        b=QUaCV+qSrdxPNMkkdcEv5cekWT81F70zhFhjr4yo4li6XDtEK419E2gk0pQ+YbPn+8
         jD1XR/SzHTniCZ8ulQwnFPMkoyKe/aJy3J+gbnW41R/qbtL6e1PPQ5D/DYoX9IBhm2ow
         NntZgm9Dh1/2YSQLvNLzEjH5K/WnrPL6W7fuatmHyT4aUqqZoGD+EVLcGIEmTU5lTWv4
         OH9Cn/z77aha3jhDtyP+9OpHUwX2G8xYzxQosx8qkw43vPveNklXxx9KQO126zdUkpMZ
         plB5roWhijSf3ifXBjZYxKmdbCcWlMYQCQlUvnSJgQTh0lxwDXqCMsK8Stn0pUqIAzWx
         YlOg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789159692; x=1789764492; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gynqWXK1xgfql7bTl8aLcrJkuClGPb6RM+NHBdDTwcM=;
        b=IJMzsuKbaFwByQExGl3ZkWCqlTwCjqbxjYo+TWomTU+jH7BUpg+kfAzG6r92Qvs9aC
         kZ7y0Ng9G9Lq9699EfQF/9jigUt5282LtiqPRI71jx3l56d1U6JbNzPxMa0xtuur8ZXS
         MV+Y2b7XNTPcNDa8+qRVKNiRfXx34kw7HuiJGeG7LBLn6VD+j4tMzXQOYjlGZr9gp+ER
         vB58RUTIdd70tOclCJTRrQOE3+CqpIQ60wkxqHv10pnZwOJdYiIvZ/RjnlLa447JonSE
         JuBQDYLcr2XVQpvx6IOX/MGo2OXKiKj37mm+HyEP6P8S3PXmb6TmuKMTZINGYEgJfLEq
         6c9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789159692; x=1789764492;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gynqWXK1xgfql7bTl8aLcrJkuClGPb6RM+NHBdDTwcM=;
        b=ZG698dcFbvTLA3pX0TyoLg3J4M1qc9wwWgFpGOGj9JVN5BojeRZASKy+RmIChaIO43
         PpURgu6x8/Jwe6d6QK0/3hyASXuBrT1zXBhkhDCZYz/0v/HYVDdSkkrgYR4280Y9/sw0
         Y3nwHLY9Ei8qRMHAhMn+q0DVS/YFa++TnqfVm4EwIFrbkh7acuuHFYwQqjDN0ptePny1
         STTaeE9HneHwUrgEg7UePWtVNC9CxnzzkRCeaZebCfLS2F99MZN+vJhHrH27/lpf9pLd
         Tyi3HCpA3D/OBQcDOvOKVEkesO4dpDlDk9Me4lGeeVXKq5+83F8f6vFbsahLWZ2GNc3F
         J5kw==
X-Gm-Message-State: AFuF++lTt1WFLZAmOQ6QmboW8lESOd+lAb3aCml+azWlUEak8P0g8Wpf
	3Y1/aiv7/S06Xiym4lZFSs4I3e3NB3GhWorZvbvk23o7jF7j+2HSvAcXEkTcRK7a+4+ENCquLcX
	+vlpjAp1v5My2bj9RXfyR6q/FbY/d0/A=
X-Gm-Gg: AYBFou33P1Y9uq4St9uYXDEDLZL4Mn5XxNE/QFm8WXAyBfBcNIE2kDGxJXONAwFH/Z4
	mNPUL8FmVQeSK9yyI4VjKqCiOaGE8UPyMjrNs0oDb+kMO+D60iW/AnCeCzFauepzKOSNnz2Cvki
	YcDeTCt/Ji7mRUqBipF4cXOitePLQsxRIxpnc33OIeCZ86jVJ4750JhenskDNDG2BebB1OS7F2X
	36aEe5zxmQXOssiB7KutdachPoYB5T/jVChnpns3cM7fzA7yoocVXLl44PNup4b5etnNsUCag9A
	ZnfMO1kzoLXUl5VAVHWWhh/m0Y5n0+kXahBBYpkfWcawL6PSLlXgNuIOckEzq9KOMFKh5znDKcC
	DgJFeAw==
X-Received: by 2002:a05:6820:1ca7:b0:6bd:5506:aadc with SMTP id
 006d021491bc7-6c24ec5982amr87583eaf.35.1789159691846; Fri, 11 Sep 2026
 13:48:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260905220117.922028-22-ameryhung@gmail.com> <2f4372e64739b68cece2725901e21e0a9437726f003a2c454edda97ee10d0cb7@mail.kernel.org>
In-Reply-To: <2f4372e64739b68cece2725901e21e0a9437726f003a2c454edda97ee10d0cb7@mail.kernel.org>
From: Amery Hung <ameryhung@gmail.com>
Date: Fri, 11 Sep 2026 13:47:58 -0700
X-Gm-Features: AcwNN1U5sm4yM-UVn0KzUiq0smL0hT-bv_XE4IDDipeq2oA-ld6C1OKuGT0jFaY
Message-ID: <CAMB2axNuEBgYnRyxo5+2XiB_QNoJgCOY+sQsQ5s7651KK3ixWg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 21/22] bpf: Consolidate release argument validation
To: bot+bpf-ci@kernel.org
Cc: bpf@vger.kernel.org, alexei.starovoitov@gmail.com, andrii@kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, memxor@gmail.com, 
	kernel-team@meta.com, ast@kernel.org, martin.lau@kernel.org, 
	yonghong.song@linux.dev, mason@kernel.org, ihor.solodrai@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 5, 2026 at 4:08=E2=80=AFPM <bot+bpf-ci@kernel.org> wrote:
>
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 487ad1ee4179..6c5d7e544f84 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
>
> [ ... ]
>
> > @@ -8825,29 +8862,9 @@ static int check_func_arg(struct bpf_verifier_en=
v *env, u32 arg,
> >               return err;
> >
> >  skip_type_check:
> > -     if (arg_type_is_release(arg_type)) {
> > -             if (type_may_be_null(reg->type)) {
> > -                     verbose(env, "Possibly NULL pointer passed to tru=
sted %s\n",
> > -                             reg_arg_name(env, argno));
> > -                     bpf_diag_call_arg(
> > -                             env, insn_idx, argno, meta->func_name,
> > -                             "the pointer may be NULL, but this call r=
equires a non-NULL pointer",
> > -                             "Add a NULL check and make the call only =
on the non-NULL path.");
> > -                     return -EACCES;
> > -             }
> > -
> > -             if (!arg_type_is_dynptr(arg_type) &&
> > -                 !reg_is_referenced(env, reg) && !bpf_register_is_null=
(reg)) {
> > -                     verbose(env,
> > -                             "release helper %s expects referenced PTR=
_TO_BTF_ID passed to %s\n",
> > -                             meta->func_name, reg_arg_name(env, argno)=
);
> > -                     bpf_diag_call_arg(
> > -                             env, insn_idx, argno, meta->func_name,
> > -                             "release helpers require a value that own=
s a live resource returned by a matching acquire helper",
> > -                             "Pass the resource-owning pointer returne=
d by the matching acquire helper, and avoid calling the release helper afte=
r ownership has already been transferred or released.");
> > -                     return -EINVAL;
> > -             }
> > -     }
> > +     err =3D check_func_arg_release(env, reg, argno, arg_type, meta, i=
nsn_idx);
> > +     if (err)
> > +             return err;
>
> Does removing the type_may_be_null() check here break the percpu kptr
> RCU conversion path?
>
> The deleted block rejected maybe-null registers passed to OBJ_RELEASE
> helper arguments. Only bpf_kptr_xchg() arg2 has ARG_PTR_TO_BTR_ID_OR_NULL
> | OBJ_RELEASE, so it is the only argument whose admission changes.
>
> check_func_arg_release() only keeps the ownership half of the test:
>
> kernel/bpf/verifier.c:check_func_arg_release() {
>     if (arg_type_is_dynptr(arg_type) || reg_is_referenced(env, reg) ||
>         bpf_register_is_null(reg))
>         return 0;
> }
>
> but for the percpu-kptr RCU conversion path, release_reg() assumes the
> released register is known non-NULL. In check_helper_call():
>
>     bool convert_rcu =3D (func_id =3D=3D BPF_FUNC_kptr_xchg) && in_rcu_cs=
(env) &&
>                        (reg->type & MEM_ALLOC) && (reg->type & MEM_PERCPU=
);
>     err =3D release_reg(env, reg, convert_rcu, !!meta.dynptr.id);
>
> release_reg() then calls ref_convert_alloc_rcu_protected(), which for
> every register carrying the id does:
>
>     reg->id =3D 0;
>     reg->type &=3D ~MEM_ALLOC;
>     reg->type |=3D MEM_RCU;
>
> PTR_MAYBE_NULL is deliberately not touched, and reg->id is zeroed. Before
> this patch that combination was unreachable because a maybe-null register
> could not be passed to bpf_kptr_xchg() at all. Now the verifier can
> produce PTR_TO_BTF_ID | MEM_PERCPU | MEM_RCU | PTR_MAYBE_NULL with
> reg->id =3D=3D 0.
>
> That state breaks NULL-check identity matching. check_cond_jmp_op() calls
> mark_ptr_or_null_regs() for any JEQ/JNE-against-0 on a maybe-null
> register, and mark_ptr_or_null_regs() uses u32 id =3D regs[regno].id, i.e=
.
> 0. mark_ptr_or_null_reg() then matches on:
>
>     if (type_may_be_null(reg->type) && reg->id =3D=3D id &&
>         (is_rcu_reg(reg) || !WARN_ON_ONCE(!reg->id))) {
>
> is_rcu_reg() is just "reg->type & MEM_RCU", so the id=3D=3D0 sanity WARN =
is
> bypassed and every maybe-null MEM_RCU register with id 0 in the state is
> marked non-NULL by a NULL check on any one of them.
>
> Concrete accepted-but-unsafe program with percpu kptr fields pc1/pc2 in a
> map value:
>
>     p1 =3D bpf_percpu_obj_new(struct val_t);
>       /* MEM_ALLOC|MEM_PERCPU|PTR_MAYBE_NULL, id=3DN1 */
>
>     p2 =3D bpf_percpu_obj_new(struct val_t);
>       /* MEM_ALLOC|MEM_PERCPU|PTR_MAYBE_NULL, id=3DN2 */
>
>     bpf_rcu_read_lock();
>
>     old =3D bpf_kptr_xchg(&v->pc1, p1);
>       /* p1 -> MEM_RCU|MEM_PERCPU|PTR_MAYBE_NULL, id=3D0 */
>
>     old =3D bpf_kptr_xchg(&v->pc2, p2);
>       /* p2 -> MEM_RCU|MEM_PERCPU|PTR_MAYBE_NULL, id=3D0 */
>
>     if (p1) {
>       /* clears PTR_MAYBE_NULL on p1 AND on p2 (both id 0, both MEM_RCU) =
*/
>
>       q =3D bpf_this_cpu_ptr(p2);
>       /* R1 now looks non-NULL, so ARG_PTR_TO_PERCPU_BTF_ID is accepted *=
/
>
>       q->field =3D 1;
>       /* q is PTR_TO_BTF_ID|MEM_ALLOC|MEM_RCU, non-NULL, writable */
>     }
>     bpf_rcu_read_unlock();
>
> If bpf_percpu_obj_new() for p2 returned NULL at runtime, the program
> stores NULL into the percpu kptr field and then executes
> this_cpu_ptr(NULL), which writes at NULL + __per_cpu_offset[cpu].
>
> This would be an unchecked write into the per-CPU area from a
> verifier-accepted program.
>
> Note that progs/map_kptr_fail.c:kptr_xchg_possibly_null was deliberately
> flipped from __failure to __success, so the relaxation is intentional,
> but the changelog does not address the percpu/RCU conversion path, and no
> test covers a nullable percpu source xchg'd inside an RCU critical
> section.
>
> Should the verifier keep rejecting type_may_be_null(reg->type) for
> OBJ_RELEASE helper arguments when the destination kptr field is
> BPF_KPTR_PERCPU, or should ref_convert_alloc_rcu_protected() leave a
> fresh non-zero reg->id so that maybe-null identity tracking stays intact?
>
> > diff --git a/tools/testing/selftests/bpf/prog_tests/cb_refs.c b/tools/t=
esting/selftests/bpf/prog_tests/cb_refs.c
> > index 50ea3d72d446..8743f52e755d 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/cb_refs.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/cb_refs.c
> > @@ -11,8 +11,8 @@ struct {
> >       const char *prog_name;
> >       const char *err_msg;
> >  } cb_refs_tests[] =3D {
> > -     { "underflow_prog", "release kfunc bpf_kfunc_call_test_release ex=
pects referenced PTR_TO_BTF_ID passed to R1" },
> > -     { "leak_prog", "Possibly NULL pointer passed to trusted R2" },
> > +     { "underflow_prog", "release function bpf_kfunc_call_test_release=
 expects referenced PTR_TO_BTF_ID passed to R1" },
> > +     { "leak_prog", "Unreleased reference id=3D4 alloc_insn=3D33" },
>
> This isn't a bug, but could the leak_prog expectation be more robust?
>
> The new expectation hard-codes a full instruction index, "Unreleased
> reference id=3D4 alloc_insn=3D33", which pins the test to one compiler's
> instruction layout for the callback subprog cb2().
>
> Every neighbouring expectation in the same table deliberately truncates
> the digits and documents why:
>
>     { "nested_cb", "Unreleased reference id=3D4 alloc_insn=3D2" },
>       /* alloc_insn=3D2{4,5} */
>
>     { "non_cb_transfer_ref", "Unreleased reference id=3D4 alloc_insn=3D1"=
 },
>       /* alloc_insn=3D1{1,2} */
>
> and the equivalent expectation added for the same verifier message in
> map_kptr_fail.c drops the number entirely:
>
>     __failure __msg("Unreleased reference id=3D4 alloc_insn=3D")
>
> Matching in test_cb_refs() is strstr(log_buf, cb_refs_tests[i].err_msg),
> so a truncated prefix such as "Unreleased reference id=3D4 alloc_insn=3D3=
"
> matches equally well while tolerating a one- or two-instruction shift fro=
m
> a different clang version.
>

Test. It should be { "leak_prog", "Unreleased reference id=3D4
alloc_insn=3D3" }, /* alloc_insn=3D3{2,3} */

> As written, the entry breaks with any layout change in cb2(), and unlike
> the two neighbours it carries no comment recording the observed range.
>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a =
bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/READM=
E.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/339954=
42755
