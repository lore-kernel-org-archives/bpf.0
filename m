Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F48F329371
	for <bpf@vger.kernel.org>; Fri, 30 Jan 2026 15:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769788001; cv=none; b=GXDvS97LfmhJUZfqkc1pNimkuR25TjGm/GPzco013JbW4IEji2hiazrDGOG4SytTaes/qfoZ4r9bWawGsjlWJAJ8KL0mzjBVkWNNsBKRyGrTpJGiJbc5/EbO48RhXFlSjC5HqK6lOKFSB3InurbCft+7FgzPHcTqPqoUDE71AGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769788001; c=relaxed/simple;
	bh=Oxumq/LSshvz15teGs6n2kUpFrusuXv2LUnq/gyQSgU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dq4qFpkXFl5x/CU6aADMkBBD+b+5fewGWRj3+R5W+UHKNMirSbTuQFeQ8GDU6EL+MuEv/faQ1uWDdKBpn8EDSDiCLtZ8bcTAlrMD2JZSBq4oAmSFt5Tp92h4JcgqMXC8jcsQmdMBLRLDDcWWJJi8H7j89Vtbvw583RMCSjYHLMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CvW0CWO8; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CvW0CWO8"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4806dffc64cso17431335e9.1
        for <bpf@vger.kernel.org>; Fri, 30 Jan 2026 07:46:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769787997; x=1770392797; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7MaodujlQVDbNcJvPde3l5Dt0oyNinYTVpuz++xfb2U=;
        b=CvW0CWO8q4iGc473W2oPPnUJt4DTah6bDJ9a5FAdSNKNY3waQSCnjiwvODI6ugo2ss
         cBcKr8QL0gfSidzAcU4s5p/Wd/RjmNAI50Um8i0plH7ivGZ/bmZTsiPchcSJemM2rF3a
         fxMf17m4K4t1S6BSvD4dNEUHIuO3D7bbtBKkTY9AHnvW1KujfmcgUYJz/HmQRqdts7fx
         HNyaejf5Uihh5DlPcYBqqxVoFh8OBdIdNSG12mtNyXcJsPvsxxdrtiCxV6SMRlmiOmg8
         zaTAXmjJQ9GeDq87RXtngge+8DucLJOl4J/7eOcFZ+vSxKIX8w/Gd9sknUY346pm+RbM
         wZCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769787997; x=1770392797;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7MaodujlQVDbNcJvPde3l5Dt0oyNinYTVpuz++xfb2U=;
        b=VwT2dOFDUSTRcNeN2lnKaFBWHIyRWwnVEZ9WFkfR3/UAiSZql/n6affsffcKgxdoXI
         oEEJJvCZhNIYUDj1OM6YwE3ZZRf7TgmXxbrirfNH5It7Y0eEPiQdlo2ZW+7iziD5nDhv
         kv4ydPDNynmgWa/jACxEYeBCAdRXqLt2PSb2RPl7terQ1S8nm1Wsi0Zg0I0i3hIyefN6
         GfRoWCRJGBV6u1suAD1BUIB65AXUjq/crS3tcjCInapoPDtx7LUZMntW0a1c+opvHimW
         AXB9rtMQW4DAhGbLE2uR0Zi0uv0Iy/IEBmPhM2+qX9Bey6SYcipNp1b74TupEqbyys4b
         fRMQ==
X-Gm-Message-State: AOJu0YxFIVIOb01xyehXzw4nHBvyi2cTmZw6X43xqPD8U9qgbsBFvIhl
	fo8+XYbQQwrwODSpU4hLLv3w1/u2NWy6FC15Wc0N/UXLtfy1Y9j6MyWb
X-Gm-Gg: AZuq6aL5bLXg5bjt232CE80EdB1yVoZlukakJ6SmjryHgdxEAqtSoSwtFrimGxdsViE
	UfnfyCL+Buo4lCPirG0UyS17P2S23AkLLNzDGKfIyYkd487dxFbq0/5gGEYGwwBSZ85gW/D4V7H
	0n7x0EOn66CgcCsHfJHGooT9RDgVCVfM/pymU9uv3ixRTt/Y1SaONIKXSR/1R4dQxwsRiaP2v8P
	oDKYzKzwSVDmFvaIL+7kMBjFbz6gUxNYuzO5bWMvEDXZV5zNxegHiPiiHtFU6jHwXwHt3KQAm14
	Ex0NXCrxzOUnuM9M1zlDIT6hxQfq6ksKfSGt/FMZQpQiYvutIn0lGRHsejUOcDuYCj8jCsIjnDV
	MKorsm8u7JT+jjLMrd6PTp31RG+ZVKd322aegFxdLTJopVEB51WD4LcjV9U4EY9CCTFv4zlmw1v
	srpNQUSOCnkhDXF7MyIdHADE2lEzePd7hPnbY=
X-Received: by 2002:a05:600c:b99:b0:47a:8154:33e3 with SMTP id 5b1f17b1804b1-482db49a483mr37974875e9.28.1769787997244;
        Fri, 30 Jan 2026 07:46:37 -0800 (PST)
Received: from ?IPV6:2620:10d:c0c3:1130::11e3? ([2620:10d:c092:400::5:cab1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4806cddffe9sm290149805e9.4.2026.01.30.07.46.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Jan 2026 07:46:36 -0800 (PST)
Message-ID: <8de50202-a580-4d6d-b4e1-9d7c2bbfb841@gmail.com>
Date: Fri, 30 Jan 2026 15:46:36 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 1/2] bpf: Introduce struct bpf_map_desc in
 verifier
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com,
 eddyz87@gmail.com, Mykyta Yatsenko <yatsenko@meta.com>
References: <20260129-verif_special_fields-v1-0-d310b7f146c8@meta.com>
 <20260129-verif_special_fields-v1-1-d310b7f146c8@meta.com>
 <CAMB2axOYwGFzB3eO8=pmAhF6qPJrZpgLEO-qWMUdTZcM4L+08g@mail.gmail.com>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <CAMB2axOYwGFzB3eO8=pmAhF6qPJrZpgLEO-qWMUdTZcM4L+08g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 1/29/26 18:09, Amery Hung wrote:
> On Thu, Jan 29, 2026 at 9:38 AM Mykyta Yatsenko
> <mykyta.yatsenko5@gmail.com> wrote:
>> From: Mykyta Yatsenko <yatsenko@meta.com>
>>
>> Introduce struct bpf_map_desc to hold bpf_map pointer and map uid. Use
>> this struct in both bpf_call_arg_meta and bpf_kfunc_call_arg_meta
>> instead of having different representations:
>>   - bpf_call_arg_meta had separate map_ptr and map_uid fields
>>   - bpf_kfunc_call_arg_meta had an anonymous inline struct
>>
>> This unifies the map fields layout across both metadata structures,
>> making the code more consistent and preparing for further refactoring of
>> map field pointer validation.
>>
>> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
>> ---
>>   kernel/bpf/verifier.c | 79 ++++++++++++++++++++++++++-------------------------
>>   1 file changed, 40 insertions(+), 39 deletions(-)
>>
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index c2f2650db9fdf71737eecd56febbe3cbf8fe42b4..2c5fb7be73923b9f8395a6fae53209f002c48fd1 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -272,8 +272,13 @@ static bool bpf_pseudo_kfunc_call(const struct bpf_insn *insn)
>>                 insn->src_reg == BPF_PSEUDO_KFUNC_CALL;
>>   }
>>
>> +struct bpf_map_desc {
>> +       struct bpf_map *ptr;
>> +       int uid;
>> +};
>> +
>>   struct bpf_call_arg_meta {
>> -       struct bpf_map *map_ptr;
>> +       struct bpf_map_desc map;
>>          bool raw_mode;
>>          bool pkt_access;
>>          u8 release_regno;
>> @@ -283,7 +288,6 @@ struct bpf_call_arg_meta {
>>          u64 msize_max_value;
>>          int ref_obj_id;
>>          int dynptr_id;
>> -       int map_uid;
>>          int func_id;
>>          struct btf *btf;
>>          u32 btf_id;
>> @@ -351,10 +355,7 @@ struct bpf_kfunc_call_arg_meta {
>>                  u8 spi;
>>                  u8 frameno;
>>          } iter;
>> -       struct {
>> -               struct bpf_map *ptr;
>> -               int uid;
>> -       } map;
>> +       struct bpf_map_desc map;
>>          u64 mem_size;
>>   };
>>
>> @@ -8666,7 +8667,7 @@ static int process_timer_func(struct bpf_verifier_env *env, int regno,
>>          if (err)
>>                  return err;
>>
>> -       if (meta->map_ptr) {
>> +       if (meta->map.ptr) {
>>                  verifier_bug(env, "Two map pointers in a timer helper");
>>                  return -EFAULT;
>>          }
>> @@ -8674,8 +8675,8 @@ static int process_timer_func(struct bpf_verifier_env *env, int regno,
>>                  verbose(env, "bpf_timer cannot be used for PREEMPT_RT.\n");
>>                  return -EOPNOTSUPP;
>>          }
>> -       meta->map_uid = reg->map_uid;
>> -       meta->map_ptr = map;
>> +       meta->map.uid = reg->map_uid;
>> +       meta->map.ptr = map;
>>          return 0;
>>   }
>>
>> @@ -8739,7 +8740,7 @@ static int process_kptr_func(struct bpf_verifier_env *env, int regno,
>>                          return -EINVAL;
>>                  }
>>                  rec = map_ptr->record;
>> -               meta->map_ptr = map_ptr;
>> +               meta->map.ptr = map_ptr;
>>          }
>>
>>          if (!tnum_is_const(reg->var_off)) {
>> @@ -9246,13 +9247,13 @@ static int resolve_map_arg_type(struct bpf_verifier_env *env,
>>                                   const struct bpf_call_arg_meta *meta,
>>                                   enum bpf_arg_type *arg_type)
>>   {
>> -       if (!meta->map_ptr) {
>> +       if (!meta->map.ptr) {
>>                  /* kernel subsystem misconfigured verifier */
>>                  verifier_bug(env, "invalid map_ptr to access map->type");
>>                  return -EFAULT;
>>          }
>>
>> -       switch (meta->map_ptr->map_type) {
>> +       switch (meta->map.ptr->map_type) {
>>          case BPF_MAP_TYPE_SOCKMAP:
>>          case BPF_MAP_TYPE_SOCKHASH:
>>                  if (*arg_type == ARG_PTR_TO_MAP_VALUE) {
>> @@ -9906,7 +9907,7 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
>>          switch (base_type(arg_type)) {
>>          case ARG_CONST_MAP_PTR:
>>                  /* bpf_map_xxx(map_ptr) call: remember that map_ptr */
>> -               if (meta->map_ptr) {
>> +               if (meta->map.ptr) {
>>                          /* Use map_uid (which is unique id of inner map) to reject:
>>                           * inner_map1 = bpf_map_lookup_elem(outer_map, key1)
>>                           * inner_map2 = bpf_map_lookup_elem(outer_map, key2)
>> @@ -9919,23 +9920,23 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
>>                           *
>>                           * Comparing map_ptr is enough to distinguish normal and outer maps.
>>                           */
>> -                       if (meta->map_ptr != reg->map_ptr ||
>> -                           meta->map_uid != reg->map_uid) {
>> +                       if (meta->map.ptr != reg->map_ptr ||
>> +                           meta->map.uid != reg->map_uid) {
>>                                  verbose(env,
>>                                          "timer pointer in R1 map_uid=%d doesn't match map pointer in R2 map_uid=%d\n",
>> -                                       meta->map_uid, reg->map_uid);
>> +                                       meta->map.uid, reg->map_uid);
>>                                  return -EINVAL;
>>                          }
>>                  }
>> -               meta->map_ptr = reg->map_ptr;
>> -               meta->map_uid = reg->map_uid;
>> +               meta->map.ptr = reg->map_ptr;
>> +               meta->map.uid = reg->map_uid;
> I was also working on this part when unifying bpf_call_arg_meta and
> bpf_kfunc_call_arg_meta. The check and setting bpf_map_desc is almost
> the same for kfunc and helper. Maybe extract this part out as a
> function?
Not sure if extracting to the function worth it, with this refactoring,
we're left with just 2 places where we do this copy, and now we can write it
as a single line:
meta->map = (struct bpf_map_desc){.ptr = reg->map_ptr, .uid = reg->map_uid};

Or maybe we can use struct bpf_map_desc in struct bpf_reg_state, so 
assignment just works?
>
>>                  break;
>>          case ARG_PTR_TO_MAP_KEY:
>>                  /* bpf_map_xxx(..., map_ptr, ..., key) call:
>>                   * check that [key, key + map->key_size) are within
>>                   * stack limits and initialized
>>                   */
>> -               if (!meta->map_ptr) {
>> +               if (!meta->map.ptr) {
>>                          /* in function declaration map_ptr must come before
>>                           * map_key, so that it's verified and known before
>>                           * we have to check map_key here. Otherwise it means
>> @@ -9944,11 +9945,11 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
>>                          verifier_bug(env, "invalid map_ptr to access map->key");
>>                          return -EFAULT;
>>                  }
>> -               key_size = meta->map_ptr->key_size;
>> +               key_size = meta->map.ptr->key_size;
>>                  err = check_helper_mem_access(env, regno, key_size, BPF_READ, false, NULL);
>>                  if (err)
>>                          return err;
>> -               if (can_elide_value_nullness(meta->map_ptr->map_type)) {
>> +               if (can_elide_value_nullness(meta->map.ptr->map_type)) {
>>                          err = get_constant_map_key(env, reg, key_size, &meta->const_map_key);
>>                          if (err < 0) {
>>                                  meta->const_map_key = -1;
>> @@ -9966,13 +9967,13 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
>>                  /* bpf_map_xxx(..., map_ptr, ..., value) call:
>>                   * check [value, value + map->value_size) validity
>>                   */
>> -               if (!meta->map_ptr) {
>> +               if (!meta->map.ptr) {
>>                          /* kernel subsystem misconfigured verifier */
>>                          verifier_bug(env, "invalid map_ptr to access map->value");
>>                          return -EFAULT;
>>                  }
>>                  meta->raw_mode = arg_type & MEM_UNINIT;
>> -               err = check_helper_mem_access(env, regno, meta->map_ptr->value_size,
>> +               err = check_helper_mem_access(env, regno, meta->map.ptr->value_size,
>>                                                arg_type & MEM_WRITE ? BPF_WRITE : BPF_READ,
>>                                                false, meta);
>>                  break;
>> @@ -11310,7 +11311,7 @@ record_func_map(struct bpf_verifier_env *env, struct bpf_call_arg_meta *meta,
>>                  int func_id, int insn_idx)
>>   {
>>          struct bpf_insn_aux_data *aux = &env->insn_aux_data[insn_idx];
>> -       struct bpf_map *map = meta->map_ptr;
>> +       struct bpf_map *map = meta->map.ptr;
>>
>>          if (func_id != BPF_FUNC_tail_call &&
>>              func_id != BPF_FUNC_map_lookup_elem &&
>> @@ -11343,11 +11344,11 @@ record_func_map(struct bpf_verifier_env *env, struct bpf_call_arg_meta *meta,
>>          }
>>
>>          if (!aux->map_ptr_state.map_ptr)
>> -               bpf_map_ptr_store(aux, meta->map_ptr,
>> -                                 !meta->map_ptr->bypass_spec_v1, false);
>> -       else if (aux->map_ptr_state.map_ptr != meta->map_ptr)
>> -               bpf_map_ptr_store(aux, meta->map_ptr,
>> -                                 !meta->map_ptr->bypass_spec_v1, true);
>> +               bpf_map_ptr_store(aux, meta->map.ptr,
>> +                                 !meta->map.ptr->bypass_spec_v1, false);
>> +       else if (aux->map_ptr_state.map_ptr != meta->map.ptr)
>> +               bpf_map_ptr_store(aux, meta->map.ptr,
>> +                                 !meta->map.ptr->bypass_spec_v1, true);
>>          return 0;
>>   }
>>
>> @@ -11357,7 +11358,7 @@ record_func_key(struct bpf_verifier_env *env, struct bpf_call_arg_meta *meta,
>>   {
>>          struct bpf_insn_aux_data *aux = &env->insn_aux_data[insn_idx];
>>          struct bpf_reg_state *reg;
>> -       struct bpf_map *map = meta->map_ptr;
>> +       struct bpf_map *map = meta->map.ptr;
>>          u64 val, max;
>>          int err;
>>
>> @@ -11913,22 +11914,22 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
>>                   * can check 'value_size' boundary of memory access
>>                   * to map element returned from bpf_map_lookup_elem()
>>                   */
>> -               if (meta.map_ptr == NULL) {
>> +               if (meta.map.ptr == NULL) {
>>                          verifier_bug(env, "unexpected null map_ptr");
>>                          return -EFAULT;
>>                  }
>>
>>                  if (func_id == BPF_FUNC_map_lookup_elem &&
>> -                   can_elide_value_nullness(meta.map_ptr->map_type) &&
>> +                   can_elide_value_nullness(meta.map.ptr->map_type) &&
>>                      meta.const_map_key >= 0 &&
>> -                   meta.const_map_key < meta.map_ptr->max_entries)
>> +                   meta.const_map_key < meta.map.ptr->max_entries)
>>                          ret_flag &= ~PTR_MAYBE_NULL;
>>
>> -               regs[BPF_REG_0].map_ptr = meta.map_ptr;
>> -               regs[BPF_REG_0].map_uid = meta.map_uid;
>> +               regs[BPF_REG_0].map_ptr = meta.map.ptr;
>> +               regs[BPF_REG_0].map_uid = meta.map.uid;
>>                  regs[BPF_REG_0].type = PTR_TO_MAP_VALUE | ret_flag;
>>                  if (!type_may_be_null(ret_flag) &&
>> -                   btf_record_has_field(meta.map_ptr->record, BPF_SPIN_LOCK | BPF_RES_SPIN_LOCK)) {
>> +                   btf_record_has_field(meta.map.ptr->record, BPF_SPIN_LOCK | BPF_RES_SPIN_LOCK)) {
>>                          regs[BPF_REG_0].id = ++env->id_gen;
>>                  }
>>                  break;
>> @@ -12031,7 +12032,7 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
>>          if (type_may_be_null(regs[BPF_REG_0].type))
>>                  regs[BPF_REG_0].id = ++env->id_gen;
>>
>> -       if (helper_multiple_ref_obj_use(func_id, meta.map_ptr)) {
>> +       if (helper_multiple_ref_obj_use(func_id, meta.map.ptr)) {
>>                  verifier_bug(env, "func %s#%d sets ref_obj_id more than once",
>>                               func_id_name(func_id), func_id);
>>                  return -EFAULT;
>> @@ -12043,7 +12044,7 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
>>          if (is_ptr_cast_function(func_id) || is_dynptr_ref_function(func_id)) {
>>                  /* For release_reference() */
>>                  regs[BPF_REG_0].ref_obj_id = meta.ref_obj_id;
>> -       } else if (is_acquire_function(func_id, meta.map_ptr)) {
>> +       } else if (is_acquire_function(func_id, meta.map.ptr)) {
>>                  int id = acquire_reference(env, insn_idx);
>>
>>                  if (id < 0)
>> @@ -12058,7 +12059,7 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
>>          if (err)
>>                  return err;
>>
>> -       err = check_map_func_compatibility(env, meta.map_ptr, func_id);
>> +       err = check_map_func_compatibility(env, meta.map.ptr, func_id);
>>          if (err)
>>                  return err;
>>
>>
>> --
>> 2.52.0
>>

