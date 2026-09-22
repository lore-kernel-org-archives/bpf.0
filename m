Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB22C4078ED
	for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 20:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790108988; cv=none; b=lL1MVphgHI/OB1kvs1rgfG3cG5rjM15SDABlG2sJgCWC/tbzyQqqF+KaBZBuIUM1x0/XfbxEl+wq86i0HhACIK82th1TU1bddvOuwY4JnqWjtY4KHVgCG76/LwjitfNevkgfAGVWNRbZo4Dq07sl1WYsV6LXgLBmXKFZzKxSrwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790108988; c=relaxed/simple;
	bh=Ee22KWiRYao1lKApmUekh9IxTs2YfqEPVpWAJMqP0Is=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=iYj+NDWMRsGmUrX4/nmrzbBw1dG5gYBuK4InuHCNG/vUegQ3XPTRbR68JJIDcBwOT+6KP1ngABBL+ML9GcVqcDY3YCc34ianmhUTemsQoUL4rjIoKB3XZ2LQRH+vYgEJJkn3CXhn88uD9/ZujAEqZWWmB8UlTWmITrLfEx3CB1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=pRSCA67X; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="pRSCA67X"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e7bcb94d3so1272155e9.2
        for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 13:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1790108974; x=1790713774; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=bhuZkFkjAv5pmqD3J5DZhx2ag4XfpnmA8RxKM8znkiE=;
        b=pRSCA67Xcibw/OynTZE+anC4Z4pVYTqs2iqVB8dg34tU7W+R0X1rxsdsGwCVcE9pY5
         9Y0fBFTnAOqyUa210OaHu9iFjRI1BQi5OjPG1Rhk6zMs5AfwD81PXbSt47oRZyzLIamO
         BBXm/CPliIlvf5Gsc0JJgD39zVtPhm/OEur4Hnej1/NvX3wGBNnnpRf7Uayx+e+Bvxl/
         y+0TADixS0nXnS/6bSe/xU5U/CK0Z0QCRUMgAYgUHZJmEVtB2La22h0zcAoGoWCKjZWn
         upNt4lozkEF0CT/meUYA8oqW0mSvMFLRtT199Ki7Ri8QJ4u1IHiR+5Uy9QqGsnvzVEzP
         6ytA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790108974; x=1790713774;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bhuZkFkjAv5pmqD3J5DZhx2ag4XfpnmA8RxKM8znkiE=;
        b=TRi4y1Gm61XV9vLrsiwFVYGnNo4D6c4ztBIjEXU5yI2AZh1Vgz3SohRfJfTokcsCmG
         PtQ7c2Y7MNL/APw4lbXYRVjKN0eChapj2qxD4Cgz+4c/zx9MxIyxQs7NOqI3zQTLFT+j
         W+4LvT9l3XlaBfd4S1KqTB4571woTLsSU6fYrVsiLOq268K5B1EIUx2CD7Al3g+/wFGB
         NNwr2/RynGuCsqHTAoeSjXCyI3yVJZ5qwA49og2Ba7E+LPliceIp3cRNHcEtRdnK3z4p
         20vn77oPKTv1iMWcTWG98szR8bE8J/LDN66waEszxh5+1V8GbAfRt/BFve935dmX4uro
         OHQg==
X-Gm-Message-State: AFuF++nNfQlBv1CuYT3YswybQNf0Id8bbAy4R7+XxhABYTHUU3JTBV7f
	vh35mku+tBB4gy1bSm5iNOUN9UX03R1vmX0fwBI1miVtMCaDcT/HVhKSFweIQpW9l2M=
X-Gm-Gg: AYBFou1caHtp7J/g4CtIEbUdaVTmG+3CFujLMG6K3qX8qNia9UlPzZkjCexXxg9uEZx
	sCjrSgWS/9xU3WpHDXhyTX0kvLMc4a600j5ymjdwYcgiC5LojjAKc7/nhJd5R9HRpD3Ri0EPy/a
	PIB6/ljZYwOfCa/YIaGSoVnaGtoJ7xvJSOYx8/9J/f993aQuICNP1NWofmv888pY00XNv3Y4CAg
	3psJzR8ATrrp8At6JF7bEd/VR1w2DEfvrCyn2wXhtKSdj1ZYwZtPS3d9UQSOoiyDF39x3fqQhjK
	nSEEBlai1zQ6xg500GK5rykw08s90/M6+dN/yUd5YIKn+SE6FaH1Y5G5KB/jz7QePyZbp1WzlWT
	GtIU3/OmfHgvjibK02nvNqzABsnojZ2NfEBf2xKtkfox+Px3Yzb8VbaDeEQx1WDRKfUR5WQ/oSh
	Y61KJeEsuX2IroZYgVbvYrC0qtyFvoZ+bMx2jMK2twl5JXAQAOgdUEpMZksNaoEUDF/g==
X-Received: by 2002:a05:600c:3b92:b0:49f:c432:2e50 with SMTP id 5b1f17b1804b1-49fdf1399d7mr5064765e9.25.1790108974144;
        Tue, 22 Sep 2026 13:29:34 -0700 (PDT)
Received: from localhost ([2620:10d:c090:600::1:2ba4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fde1ec8a1sm19883145e9.15.2026.09.22.13.29.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Sep 2026 13:29:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 22 Sep 2026 20:29:27 +0000
Message-Id: <DLM4O2QP87FM.1F2UYDTP6VY7V@etsalapatis.com>
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Amery Hung" <ameryhung@gmail.com>, "Emil Tsalapatis"
 <emil@etsalapatis.com>
Cc: <bpf@vger.kernel.org>, <ast@kernel.org>, <andrii@kernel.org>,
 <eddyz87@gmail.com>, <memxor@gmail.com>, <daniel@iogearbox.net>,
 <netdev@vger.kernel.org>, "Nicholas Carlini" <nicholas@carlini.com>
Subject: Re: [PATCH bpf v2 10/11] bpf: Track skb memory invalidation by
 packet-backed dynptrs
X-Mailer: aerc 0.21.0
References: <20260922172028.6269-1-emil@etsalapatis.com>
 <20260922172028.6269-11-emil@etsalapatis.com>
 <CAMB2axMWU469XKFGEkvp46R7y+Uw0p4gAK8nT9-o2zdFGu0Vng@mail.gmail.com>
In-Reply-To: <CAMB2axMWU469XKFGEkvp46R7y+Uw0p4gAK8nT9-o2zdFGu0Vng@mail.gmail.com>

On Tue Sep 22, 2026 at 8:06 PM UTC, Amery Hung wrote:
> On Tue, Sep 22, 2026 at 10:24=E2=80=AFAM Emil Tsalapatis <emil@etsalapati=
s.com> wrote:
>>
>> A dynptr can be backed by skb memory, and kfuncs that
>> write but also read the underlying area may reallocate
>> the backing memory in the process of pulling the skb.
>> However, the verifier does not track these calls as
>> possibly invalidating packet pointers, and does not
>> do so after their call site.
>>
>> Expand the verifier to track dynptr kfuncs for packet
>> invalidation.
>>
>> Fixes: 5fc5d8fded57 ("bpf: Add bpf_dynptr_memset() kfunc")
>> Fixes: a498ee7576de ("bpf: Implement dynptr copy kfuncs")
>> Fixes: daec295a7094 ("bpf/helpers: Introduce bpf_dynptr_copy kfunc")
>> Reported-by: Nicholas Carlini <nicholas@carlini.com>
>> Suggested-by: Nicholas Carlini <nicholas@carlini.com>
>> Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
>> ---
>>  include/linux/bpf_verifier.h |  2 ++
>>  kernel/bpf/cfg.c             | 10 +++++--
>>  kernel/bpf/verifier.c        | 51 ++++++++++++++++++++++++++++++++++--
>>  3 files changed, 59 insertions(+), 4 deletions(-)
>>
>> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
>> index f57730d1d..8a9b7a2f2 100644
>> --- a/include/linux/bpf_verifier.h
>> +++ b/include/linux/bpf_verifier.h
>> @@ -1589,6 +1589,7 @@ struct bpf_call_arg_meta {
>>
>>         /* Only set by kfunc */
>>         bool r0_rdonly;
>> +       bool dynptr_may_clobber_pkt_ptr;
>
> I would suggest making it common to helper and kfunc and not specific to =
dynptr:
>
> bool pkt_changed;
>
> Then, helper and kfunc and all share this following block:
>
>         if (meta->pkt_changed)
>                 clear_all_pkt_pointers(env);
>
> This also matches the existing changes_pkt_data terminology.

This and the point below both make sense to me, thank you. I will adjust ac=
cordingly.

>
>>         u32 kfunc_flags;
>>         const struct btf_type *func_proto;
>>         const char *func_name;
>> @@ -1642,6 +1643,7 @@ static inline bool bpf_is_kfunc_sleepable(struct b=
pf_call_arg_meta *meta)
>>         return meta->kfunc_flags & KF_SLEEPABLE;
>>  }
>>  bool bpf_is_kfunc_pkt_changing(struct bpf_call_arg_meta *meta);
>> +bool bpf_is_kfunc_maybe_pkt_changing(struct bpf_call_arg_meta *meta);
>>  struct bpf_iarray *bpf_iarray_realloc(struct bpf_iarray *old, size_t n_=
elem);
>>  int bpf_copy_insn_array_uniq(struct bpf_map *map, u32 start, u32 end, u=
32 *off);
>>  bool bpf_insn_is_cond_jump(u8 code);
>> diff --git a/kernel/bpf/cfg.c b/kernel/bpf/cfg.c
>> index 842c7d1ea..cb499d19d 100644
>> --- a/kernel/bpf/cfg.c
>> +++ b/kernel/bpf/cfg.c
>> @@ -73,6 +73,12 @@ static void mark_subprog_might_throw(struct bpf_verif=
ier_env *env, int off)
>>         subprog->might_throw =3D true;
>>  }
>>
>> +static bool bpf_helper_maybe_changes_pkt_data(enum bpf_func_id func_id)
>> +{
>> +       return bpf_helper_changes_pkt_data(func_id) ||
>> +              func_id =3D=3D BPF_FUNC_dynptr_write;
>> +}
>> +
>>  /* 't' is an index of a call-site.
>>   * 'w' is a callee entry point.
>>   * Eventually this function would be called when env->cfg.insn_state[w]=
 =3D=3D EXPLORED.
>> @@ -510,7 +516,7 @@ static int visit_insn(int t, struct bpf_verifier_env=
 *env)
>>                          */
>>                         if (ret =3D=3D 0 && fp->might_sleep)
>>                                 mark_subprog_might_sleep(env, t);
>> -                       if (bpf_helper_changes_pkt_data(insn->imm))
>> +                       if (bpf_helper_maybe_changes_pkt_data(insn->imm)=
)
>>                                 mark_subprog_changes_pkt_data(env, t);
>>                         if (insn->imm =3D=3D BPF_FUNC_tail_call) {
>>                                 ret =3D visit_abnormal_return_insn(env, =
t);
>> @@ -543,7 +549,7 @@ static int visit_insn(int t, struct bpf_verifier_env=
 *env)
>>                          */
>>                         if (ret =3D=3D 0 && bpf_is_kfunc_sleepable(&meta=
))
>>                                 mark_subprog_might_sleep(env, t);
>> -                       if (ret =3D=3D 0 && bpf_is_kfunc_pkt_changing(&m=
eta))
>> +                       if (ret =3D=3D 0 && bpf_is_kfunc_maybe_pkt_chang=
ing(&meta))
>>                                 mark_subprog_changes_pkt_data(env, t);
>>                         if (ret =3D=3D 0 && bpf_is_throw_kfunc(insn))
>>                                 mark_subprog_might_throw(env, t);
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index da110cdbc..e916ce89c 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -8278,6 +8278,7 @@ static bool is_kfunc_arg_scalar_with_name(const st=
ruct btf *btf,
>>                                           const char *name);
>>  static bool is_bpf_cast_to_kern_ctx_kfunc(const struct bpf_call_arg_met=
a *meta);
>>  static bool is_bpf_dynptr_clone_kfunc(const struct bpf_call_arg_meta *m=
eta);
>> +static bool is_kfunc_dynptr_may_clobber_pkt_ptr(struct bpf_call_arg_met=
a *meta);
>>  static bool is_bpf_iter_css_task_new_kfunc(const struct bpf_call_arg_me=
ta *meta);
>>  static bool is_bpf_obj_drop_kfunc(u32 func_id);
>>  static bool is_bpf_percpu_obj_drop_kfunc(u32 func_id);
>> @@ -9320,6 +9321,15 @@ static int check_func_arg(struct bpf_verifier_env=
 *env, u32 arg, u32 slot, u32 p
>>                 err =3D process_dynptr_func(env, reg, argno, insn_idx, a=
rg_type, meta);
>>                 if (err)
>>                         return err;
>> +               /*
>> +                * These kfuncs only clobber packet pointers when their
>> +                * destination dynptr, argument 0, is backed by skb pack=
et data.
>> +                */
>> +               if (arg =3D=3D 0 && is_kfunc_dynptr_may_clobber_pkt_ptr(=
meta) &&
>> +                   (meta->dynptr.type_unknown ||
>> +                    meta->dynptr.type =3D=3D BPF_DYNPTR_TYPE_SKB ||
>> +                    meta->dynptr.type =3D=3D BPF_DYNPTR_TYPE_SKB_META))
>> +                       meta->dynptr_may_clobber_pkt_ptr =3D true;
>>                 break;
>>         }
>>         case ARG_PTR_TO_ITER:
>> @@ -11759,7 +11769,8 @@ static int check_helper_call(struct bpf_verifier=
_env *env, struct bpf_insn *insn
>>                 if (dynptr_type =3D=3D BPF_DYNPTR_TYPE_INVALID)
>>                         return -EFAULT;
>>
>> -               if (dynptr_type =3D=3D BPF_DYNPTR_TYPE_SKB ||
>> +               if (meta.dynptr.type_unknown ||
>> +                   dynptr_type =3D=3D BPF_DYNPTR_TYPE_SKB ||
>>                     dynptr_type =3D=3D BPF_DYNPTR_TYPE_SKB_META)
>>                         /* this will trigger clear_all_pkt_pointers(), w=
hich will
>>                          * invalidate all dynptr slices associated with =
the skb
>> @@ -12787,9 +12798,45 @@ static bool is_kfunc_bpf_preempt_enable(struct =
bpf_call_arg_meta *meta)
>>         return is_kfunc_call(meta, special_kfunc_list[KF_bpf_preempt_ena=
ble]);
>>  }
>>
>> +/*
>> + * Dynptr kfuncs that may clobber packet pointers when called with an s=
kb or
>> + * skb_meta backed destination dynptr by pulling the packet.
>> + */
>> +BTF_SET_START(dynptr_may_clobber_pkt_ptr_kfuncs)
>
> This set identifies kfuncs that write to dynptr-backed memory. Whether
> such a write can invalidate packet pointers is determined separately
> from the destination dynptr type. How about:
>
>   BTF_SET_START(dynptr_memory_write_kfuncs)
>
>> +BTF_ID(func, bpf_dynptr_memset)
>> +BTF_ID(func, bpf_dynptr_copy)
>> +#ifdef CONFIG_BPF_EVENTS
>> +BTF_ID(func, bpf_probe_read_user_dynptr)
>> +BTF_ID(func, bpf_probe_read_kernel_dynptr)
>> +BTF_ID(func, bpf_probe_read_user_str_dynptr)
>> +BTF_ID(func, bpf_probe_read_kernel_str_dynptr)
>> +BTF_ID(func, bpf_copy_from_user_dynptr)
>> +BTF_ID(func, bpf_copy_from_user_str_dynptr)
>> +BTF_ID(func, bpf_copy_from_user_task_dynptr)
>> +BTF_ID(func, bpf_copy_from_user_task_str_dynptr)
>> +#endif
>> +BTF_SET_END(dynptr_may_clobber_pkt_ptr_kfuncs)
>> +
>> +static bool is_kfunc_dynptr_may_clobber_pkt_ptr(struct bpf_call_arg_met=
a *meta)
>
> Likewise, perhaps:
>
>   static bool is_kfunc_dynptr_memory_write(...)
>
> This keeps the two concepts separate: the set classifies the
> operation, while meta.changes_pkt_data records the effect for this
> particular call.
>
>> +{
>> +       return meta->btf && btf_id_set_contains(&dynptr_may_clobber_pkt_=
ptr_kfuncs,
>> +                                               meta->func_id);
>> +}
>> +
>>  bool bpf_is_kfunc_pkt_changing(struct bpf_call_arg_meta *meta)
>>  {
>> -       return is_kfunc_call(meta, special_kfunc_list[KF_bpf_xdp_pull_da=
ta]);
>> +       return is_kfunc_call(meta, special_kfunc_list[KF_bpf_xdp_pull_da=
ta]) ||
>> +              meta->dynptr_may_clobber_pkt_ptr;
>> +}
>> +
>> +/*
>> + * More conservative version of the above used in check_cfg(),
>> + * where no register state exists and the dynptr type is unknown.
>> + */
>> +bool bpf_is_kfunc_maybe_pkt_changing(struct bpf_call_arg_meta *meta)
>> +{
>> +       return bpf_is_kfunc_pkt_changing(meta) ||
>> +              is_kfunc_dynptr_may_clobber_pkt_ptr(meta);
>>  }
>>
>>  static u32 kfunc_abi_slots(const struct btf_func_model *fm)
>> --
>> 2.54.0
>>
>>

