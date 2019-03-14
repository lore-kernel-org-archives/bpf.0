Return-Path: <SRS0=VVzb=RR=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91308C43381
	for <bpf@archiver.kernel.org>; Thu, 14 Mar 2019 19:26:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B9B92082F
	for <bpf@archiver.kernel.org>; Thu, 14 Mar 2019 19:26:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vsn5X8Zt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727111AbfCNT0Z (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 14 Mar 2019 15:26:25 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:34955 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726848AbfCNT0Z (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 14 Mar 2019 15:26:25 -0400
Received: by mail-oi1-f195.google.com with SMTP id j132so2352192oib.2;
        Thu, 14 Mar 2019 12:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r9jxfbiAFHfS2km2c5hu+RMWv1ssjOYLp3Do3MidUaU=;
        b=Vsn5X8ZtT7fP9emMILTNPBMz7W4/sV2xFBiZxxPNPR5syAguC4J1TmWnpKdvOsOpTM
         thI0WCkHWPZ13cVr84KMiBQZq6GvMXq6qm/k9woHtYQY2zRqvpBQXz5JyPetID1ZMMpx
         b35UT+OPpoZvfNkClMg2NwN6mA05THZ6fcj3nXEAJkV+2mPeIlvqE89KAPqVUe2mAjy8
         MTCTbQKiJWW4elHl+gl6RsrgvUW1Z/dcEAcGVDDwC+ePQIFtV1EuNJuLXE+DvwboEeWc
         5/0HK5M0HUuMgQlS6XTB2UEIqXeegFE6oGEpmmPqMH7fjAkPCYSW8wxKgslB46073Sle
         kbsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r9jxfbiAFHfS2km2c5hu+RMWv1ssjOYLp3Do3MidUaU=;
        b=QuXC4bqHy11itTpGr9HlIueIc0g6rfQb7awsdXcEOiW9M2Im5SrP/twnsEQIfNJAjq
         bM9+CrAyPEcMK4qrM/O+DoecQYjoQztuzzcrHV53Tg/CIAcK8x+bMaWcMXYzekBubXtk
         heIyk+dOIsq5ndH+b9GrYITEpAdGuWkRP8HaaQTz4AE0tQKII2yKVDk3C+l3srBLfagK
         96q7FidhIUZV4av+pgOOrq/suTD2xdMTTKYTpgV6Aru61WI/sXDI0DyAX1UZX7vfV9p4
         Dbr0Vlzc4DM0JWpSIfOKBTSVFDakNM1o2Oa1DguLR2axUn4QuQWECwRGGXpdC5gNeN5j
         k4Pg==
X-Gm-Message-State: APjAAAVVPIAD9q5GPUHwIcPEZzNhU0IOsORKDB+MYwlr7BSYlKqQduy6
        eFoPfFbFKpF4PWViDl2gDG0eHUvmVjvACdZoPDk=
X-Google-Smtp-Source: APXvYqzmsu70XXJBf40MDDG1OWafrFXCV8touFpVIRNcUNvNY1wpz7ZX6PkEiUuUrjPKFkr2Hao4tDZh0l3EM3wJQGo=
X-Received: by 2002:aca:3ed4:: with SMTP id l203mr88447oia.88.1552591584532;
 Thu, 14 Mar 2019 12:26:24 -0700 (PDT)
MIME-Version: 1.0
References: <20190311215125.17793-1-daniel@iogearbox.net> <20190311215125.17793-3-daniel@iogearbox.net>
In-Reply-To: <20190311215125.17793-3-daniel@iogearbox.net>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 14 Mar 2019 12:26:12 -0700
Message-ID: <CAEf4BzaDc2n662LcmjJoSir0G8YsrT_qKnfNyzEALy4mdJ-7Fw@mail.gmail.com>
Subject: Re: [PATCH rfc v3 bpf-next 2/9] bpf: add program side {rd,wr}only
 support for maps
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Alexei Starovoitov <ast@kernel.org>, bpf@vger.kernel.org,
        Networking <netdev@vger.kernel.org>,
        Joe Stringer <joe@wand.net.nz>,
        john fastabend <john.fastabend@gmail.com>,
        Yonghong Song <yhs@fb.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>, tgraf@suug.ch,
        lmb@cloudflare.com
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Mar 11, 2019 at 2:51 PM Daniel Borkmann <daniel@iogearbox.net> wrote:
>
> This work adds two new map creation flags BPF_F_RDONLY_PROG
> and BPF_F_WRONLY_PROG in order to allow for read-only or
> write-only BPF maps from a BPF program side.
>
> Today we have BPF_F_RDONLY and BPF_F_WRONLY, but this only
> applies to system call side, meaning the BPF program has full
> read/write access to the map as usual while bpf(2) calls with
> map fd can either only read or write into the map depending
> on the flags. BPF_F_RDONLY_PROG and BPF_F_WRONLY_PROG allows
> for the exact opposite such that verifier is going to reject
> program loads if write into a read-only map or a read into a
> write-only map is detected. For read-only map case also some
> helpers are forbidden for programs that would alter the map
> state such as map deletion, update, etc.
>
> We've enabled this generic map extension to various non-special
> maps holding normal user data: array, hash, lru, lpm, local
> storage, queue and stack. Further map types could be followed
> up in future depending on use-case. Main use case here is to
> forbid writes into .rodata map values from verifier side.
>
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> ---
>  include/linux/bpf.h           | 24 ++++++++++++++++++
>  include/uapi/linux/bpf.h      | 10 +++++++-
>  kernel/bpf/arraymap.c         |  3 ++-
>  kernel/bpf/hashtab.c          |  6 ++---
>  kernel/bpf/local_storage.c    |  6 ++---
>  kernel/bpf/lpm_trie.c         |  3 ++-
>  kernel/bpf/queue_stack_maps.c |  6 ++---
>  kernel/bpf/syscall.c          |  2 ++
>  kernel/bpf/verifier.c         | 46 +++++++++++++++++++++++++++++++++--
>  9 files changed, 92 insertions(+), 14 deletions(-)
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 85b6b5dc883f..bb80c78924b0 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -427,6 +427,30 @@ struct bpf_array {
>         };
>  };
>
> +#define BPF_MAP_CAN_READ       BIT(0)
> +#define BPF_MAP_CAN_WRITE      BIT(1)
> +
> +static inline u32 bpf_map_flags_to_cap(struct bpf_map *map)
> +{
> +       u32 access_flags = map->map_flags & (BPF_F_RDONLY_PROG | BPF_F_WRONLY_PROG);
> +
> +       /* Combination of BPF_F_RDONLY_PROG | BPF_F_WRONLY_PROG is
> +        * not possible.
> +        */
> +       if (access_flags & BPF_F_RDONLY_PROG)
> +               return BPF_MAP_CAN_READ;
> +       else if (access_flags & BPF_F_WRONLY_PROG)
> +               return BPF_MAP_CAN_WRITE;
> +       else
> +               return BPF_MAP_CAN_READ | BPF_MAP_CAN_WRITE;
> +}
> +
> +static inline bool bpf_map_flags_access_ok(u32 access_flags)
> +{
> +       return (access_flags & (BPF_F_RDONLY_PROG | BPF_F_WRONLY_PROG)) !=
> +              (BPF_F_RDONLY_PROG | BPF_F_WRONLY_PROG);
> +}
> +
>  #define MAX_TAIL_CALL_CNT 32
>
>  struct bpf_event_entry {
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index d0b80fce0fc9..e64fd9862e68 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -294,7 +294,7 @@ enum bpf_attach_type {
>
>  #define BPF_OBJ_NAME_LEN 16U
>
> -/* Flags for accessing BPF object */
> +/* Flags for accessing BPF object from syscall side. */
>  #define BPF_F_RDONLY           (1U << 3)
>  #define BPF_F_WRONLY           (1U << 4)
>
> @@ -304,6 +304,14 @@ enum bpf_attach_type {
>  /* Zero-initialize hash function seed. This should only be used for testing. */
>  #define BPF_F_ZERO_SEED                (1U << 6)
>
> +/* Flags for accessing BPF object from program side. */
> +#define BPF_F_RDONLY_PROG      (1U << 7)
> +#define BPF_F_WRONLY_PROG      (1U << 8)
> +#define BPF_F_ACCESS_MASK      (BPF_F_RDONLY |         \
> +                                BPF_F_RDONLY_PROG |    \
> +                                BPF_F_WRONLY |         \
> +                                BPF_F_WRONLY_PROG)
> +
>  /* flags for BPF_PROG_QUERY */
>  #define BPF_F_QUERY_EFFECTIVE  (1U << 0)
>
> diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
> index 862d20422ad1..6d2ce06485ae 100644
> --- a/kernel/bpf/arraymap.c
> +++ b/kernel/bpf/arraymap.c
> @@ -22,7 +22,7 @@
>  #include "map_in_map.h"
>
>  #define ARRAY_CREATE_FLAG_MASK \
> -       (BPF_F_NUMA_NODE | BPF_F_RDONLY | BPF_F_WRONLY)
> +       (BPF_F_NUMA_NODE | BPF_F_ACCESS_MASK)
>
>  static void bpf_array_free_percpu(struct bpf_array *array)
>  {
> @@ -63,6 +63,7 @@ int array_map_alloc_check(union bpf_attr *attr)
>         if (attr->max_entries == 0 || attr->key_size != 4 ||
>             attr->value_size == 0 ||
>             attr->map_flags & ~ARRAY_CREATE_FLAG_MASK ||
> +           !bpf_map_flags_access_ok(attr->map_flags) ||
>             (percpu && numa_node != NUMA_NO_NODE))
>                 return -EINVAL;
>
> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> index fed15cf94dca..192d32e77db3 100644
> --- a/kernel/bpf/hashtab.c
> +++ b/kernel/bpf/hashtab.c
> @@ -23,7 +23,7 @@
>
>  #define HTAB_CREATE_FLAG_MASK                                          \
>         (BPF_F_NO_PREALLOC | BPF_F_NO_COMMON_LRU | BPF_F_NUMA_NODE |    \
> -        BPF_F_RDONLY | BPF_F_WRONLY | BPF_F_ZERO_SEED)
> +        BPF_F_ACCESS_MASK | BPF_F_ZERO_SEED)
>
>  struct bucket {
>         struct hlist_nulls_head head;
> @@ -262,8 +262,8 @@ static int htab_map_alloc_check(union bpf_attr *attr)
>                 /* Guard against local DoS, and discourage production use. */
>                 return -EPERM;
>
> -       if (attr->map_flags & ~HTAB_CREATE_FLAG_MASK)
> -               /* reserved bits should not be used */
> +       if (attr->map_flags & ~HTAB_CREATE_FLAG_MASK ||
> +           !bpf_map_flags_access_ok(attr->map_flags))
>                 return -EINVAL;
>
>         if (!lru && percpu_lru)
> diff --git a/kernel/bpf/local_storage.c b/kernel/bpf/local_storage.c
> index 6b572e2de7fb..980e8f1f6cb5 100644
> --- a/kernel/bpf/local_storage.c
> +++ b/kernel/bpf/local_storage.c
> @@ -14,7 +14,7 @@ DEFINE_PER_CPU(struct bpf_cgroup_storage*, bpf_cgroup_storage[MAX_BPF_CGROUP_STO
>  #ifdef CONFIG_CGROUP_BPF
>
>  #define LOCAL_STORAGE_CREATE_FLAG_MASK                                 \
> -       (BPF_F_NUMA_NODE | BPF_F_RDONLY | BPF_F_WRONLY)
> +       (BPF_F_NUMA_NODE | BPF_F_ACCESS_MASK)
>
>  struct bpf_cgroup_storage_map {
>         struct bpf_map map;
> @@ -282,8 +282,8 @@ static struct bpf_map *cgroup_storage_map_alloc(union bpf_attr *attr)
>         if (attr->value_size > PAGE_SIZE)
>                 return ERR_PTR(-E2BIG);
>
> -       if (attr->map_flags & ~LOCAL_STORAGE_CREATE_FLAG_MASK)
> -               /* reserved bits should not be used */
> +       if (attr->map_flags & ~LOCAL_STORAGE_CREATE_FLAG_MASK ||
> +           !bpf_map_flags_access_ok(attr->map_flags))
>                 return ERR_PTR(-EINVAL);
>
>         if (attr->max_entries)
> diff --git a/kernel/bpf/lpm_trie.c b/kernel/bpf/lpm_trie.c
> index 93a5cbbde421..e61630c2e50b 100644
> --- a/kernel/bpf/lpm_trie.c
> +++ b/kernel/bpf/lpm_trie.c
> @@ -538,7 +538,7 @@ static int trie_delete_elem(struct bpf_map *map, void *_key)
>  #define LPM_KEY_SIZE_MIN       LPM_KEY_SIZE(LPM_DATA_SIZE_MIN)
>
>  #define LPM_CREATE_FLAG_MASK   (BPF_F_NO_PREALLOC | BPF_F_NUMA_NODE |  \
> -                                BPF_F_RDONLY | BPF_F_WRONLY)
> +                                BPF_F_ACCESS_MASK)
>
>  static struct bpf_map *trie_alloc(union bpf_attr *attr)
>  {
> @@ -553,6 +553,7 @@ static struct bpf_map *trie_alloc(union bpf_attr *attr)
>         if (attr->max_entries == 0 ||
>             !(attr->map_flags & BPF_F_NO_PREALLOC) ||
>             attr->map_flags & ~LPM_CREATE_FLAG_MASK ||
> +           !bpf_map_flags_access_ok(attr->map_flags) ||
>             attr->key_size < LPM_KEY_SIZE_MIN ||
>             attr->key_size > LPM_KEY_SIZE_MAX ||
>             attr->value_size < LPM_VAL_SIZE_MIN ||
> diff --git a/kernel/bpf/queue_stack_maps.c b/kernel/bpf/queue_stack_maps.c
> index b384ea9f3254..0b140d236889 100644
> --- a/kernel/bpf/queue_stack_maps.c
> +++ b/kernel/bpf/queue_stack_maps.c
> @@ -11,8 +11,7 @@
>  #include "percpu_freelist.h"
>
>  #define QUEUE_STACK_CREATE_FLAG_MASK \
> -       (BPF_F_NUMA_NODE | BPF_F_RDONLY | BPF_F_WRONLY)
> -
> +       (BPF_F_NUMA_NODE | BPF_F_ACCESS_MASK)
>
>  struct bpf_queue_stack {
>         struct bpf_map map;
> @@ -52,7 +51,8 @@ static int queue_stack_map_alloc_check(union bpf_attr *attr)
>         /* check sanity of attributes */
>         if (attr->max_entries == 0 || attr->key_size != 0 ||
>             attr->value_size == 0 ||
> -           attr->map_flags & ~QUEUE_STACK_CREATE_FLAG_MASK)
> +           attr->map_flags & ~QUEUE_STACK_CREATE_FLAG_MASK ||
> +           !bpf_map_flags_access_ok(attr->map_flags))
>                 return -EINVAL;
>
>         if (attr->value_size > KMALLOC_MAX_SIZE)
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index b0c7a6485c49..ba2fe4cfad09 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -481,6 +481,8 @@ static int map_check_btf(struct bpf_map *map, const struct btf *btf,
>         map->spin_lock_off = btf_find_spin_lock(btf, value_type);
>
>         if (map_value_has_spin_lock(map)) {
> +               if (map->map_flags & BPF_F_RDONLY_PROG)
> +                       return -EACCES;

Do we need to enforce this restriction? This would make sense if we
were enforcing that any element that has spinlock inside has to have a
lock taken, do we do that in verifier?

>                 if (map->map_type != BPF_MAP_TYPE_HASH &&
>                     map->map_type != BPF_MAP_TYPE_ARRAY &&
>                     map->map_type != BPF_MAP_TYPE_CGROUP_STORAGE)
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 57678cef9a2c..af3cddb18efb 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -1429,6 +1429,28 @@ static int check_stack_access(struct bpf_verifier_env *env,
>         return 0;
>  }
>
> +static int check_map_access_type(struct bpf_verifier_env *env, u32 regno,
> +                                int off, int size, enum bpf_access_type type)
> +{
> +       struct bpf_reg_state *regs = cur_regs(env);
> +       struct bpf_map *map = regs[regno].map_ptr;
> +       u32 cap = bpf_map_flags_to_cap(map);
> +
> +       if (type == BPF_WRITE && !(cap & BPF_MAP_CAN_WRITE)) {
> +               verbose(env, "write into map forbidden, value_size=%d off=%d size=%d\n",
> +                       map->value_size, off, size);
> +               return -EACCES;
> +       }
> +
> +       if (type == BPF_READ && !(cap & BPF_MAP_CAN_READ)) {
> +               verbose(env, "read into map forbidden, value_size=%d off=%d size=%d\n",

typo: "read from"?

> +                       map->value_size, off, size);
> +               return -EACCES;
> +       }
> +
> +       return 0;
> +}
> +
>  /* check read/write into map element returned by bpf_map_lookup_elem() */
>  static int __check_map_access(struct bpf_verifier_env *env, u32 regno, int off,
>                               int size, bool zero_size_allowed)
> @@ -2014,7 +2036,9 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, u32 regn
>                         verbose(env, "R%d leaks addr into map\n", value_regno);
>                         return -EACCES;
>                 }
> -
> +               err = check_map_access_type(env, regno, off, size, t);
> +               if (err)
> +                       return err;
>                 err = check_map_access(env, regno, off, size, false);
>                 if (!err && t == BPF_READ && value_regno >= 0)
>                         mark_reg_unknown(env, regs, value_regno);
> @@ -2250,6 +2274,10 @@ static int check_helper_mem_access(struct bpf_verifier_env *env, int regno,
>                 return check_packet_access(env, regno, reg->off, access_size,
>                                            zero_size_allowed);
>         case PTR_TO_MAP_VALUE:
> +               if (check_map_access_type(env, regno, reg->off, access_size,
> +                                         meta && meta->raw_mode ? BPF_WRITE :
> +                                         BPF_READ))
> +                       return -EACCES;
>                 return check_map_access(env, regno, reg->off, access_size,
>                                         zero_size_allowed);
>         default: /* scalar_value|ptr_to_stack or invalid ptr */
> @@ -2971,6 +2999,7 @@ record_func_map(struct bpf_verifier_env *env, struct bpf_call_arg_meta *meta,
>                 int func_id, int insn_idx)
>  {
>         struct bpf_insn_aux_data *aux = &env->insn_aux_data[insn_idx];
> +       struct bpf_map *map = meta->map_ptr;
>
>         if (func_id != BPF_FUNC_tail_call &&
>             func_id != BPF_FUNC_map_lookup_elem &&
> @@ -2981,11 +3010,24 @@ record_func_map(struct bpf_verifier_env *env, struct bpf_call_arg_meta *meta,
>             func_id != BPF_FUNC_map_peek_elem)
>                 return 0;
>
> -       if (meta->map_ptr == NULL) {
> +       if (map == NULL) {
>                 verbose(env, "kernel subsystem misconfigured verifier\n");
>                 return -EINVAL;
>         }
>
> +       /* In case of read-only, some additional restrictions
> +        * need to be applied in order to prevent altering the
> +        * state of the map from program side.
> +        */
> +       if ((map->map_flags & BPF_F_RDONLY_PROG) &&
> +           (func_id == BPF_FUNC_map_delete_elem ||
> +            func_id == BPF_FUNC_map_update_elem ||
> +            func_id == BPF_FUNC_map_push_elem ||
> +            func_id == BPF_FUNC_map_pop_elem)) {

Curious, what about tail_calls? Is it considered a read? Is this
checked as well?

> +               verbose(env, "write into map forbidden\n");
> +               return -EACCES;
> +       }
> +
>         if (!BPF_MAP_PTR(aux->map_state))
>                 bpf_map_ptr_store(aux, meta->map_ptr,
>                                   meta->map_ptr->unpriv_array);
> --
> 2.17.1
>
