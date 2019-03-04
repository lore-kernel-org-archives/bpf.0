Return-Path: <SRS0=/NIo=RH=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA778C10F06
	for <bpf@archiver.kernel.org>; Mon,  4 Mar 2019 06:10:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88B332082F
	for <bpf@archiver.kernel.org>; Mon,  4 Mar 2019 06:10:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KkHQ2ZQ4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726061AbfCDGDr (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 4 Mar 2019 01:03:47 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:37571 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725938AbfCDGDr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 4 Mar 2019 01:03:47 -0500
Received: by mail-ot1-f68.google.com with SMTP id b3so3269649otp.4;
        Sun, 03 Mar 2019 22:03:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tcuUJwiWxv3Xw/IXKhUh6BmgeQC1ZuJGXr+DpHrtmW0=;
        b=KkHQ2ZQ4HfRnBJrfpPuxFizmJQMmDHPk70CXXrmqaDGANDbY1c0tVfx7q9gb0zbAXk
         NfJhqxq5MvTakcORR9VV9GdWrFuMctZB3qqnTzhUWpKmWBSwCO3dhaMCeNObA1yFi13C
         I6yP4GGVLzOReywrLY7O3WuJ/TuMF6fSSyOafWLpODdsfscrWlmg+aSA9Dgb8GpHVK1F
         hyOqjdR8MUfEjvPzZbsbnS6KWn2JpXhvgtphxDzLwfE94aHqWVA5ZgXASBfHyHUkMAWM
         SrksjdzvUpOGkJ8cEyjnvoKJTGCc98uPK4dxOe4k8B47WNI6t3Jj3FP7rQ75recbnF8j
         tFpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tcuUJwiWxv3Xw/IXKhUh6BmgeQC1ZuJGXr+DpHrtmW0=;
        b=FrZEctEcq4exkmwa8txS1vUxJOQt2QwSSoDCbdo6nN6MIqG6RvLrssxgG2yTJn7FKr
         joyfxzsK1FFpzORAzvoaujuy6Xul53JAPefEA0tjdlKei/TlR/KUToIcFU7Z8p90oUzB
         I5P8rKTa/Kw6vfTIMvGISOA/t/gnLKgzn5/9SxiUBtgrGcDF66gMk80KSwLNkWzdVnH6
         B1tmyac3dOWIzEoin+So0dLcuVXJ4K90KMxNZhFuapt9PIVw+7d56t1XonrjrZRZGzUn
         /aPXEcLvbCtRSHXgSU/sUM6PNLdN9eOoYwfYlplCexeH0xExGp4gZxcDuhTfD3G0kfOA
         LXng==
X-Gm-Message-State: APjAAAXdM124DsmqbwyUMePQIWvy5ril0Cjz0gRUl5Y0Za4/eLrXJFY8
        Krwq68KLUFtwY3euyeXb+k/3IvhJVSpguB2m+7M=
X-Google-Smtp-Source: APXvYqzwpp7U9T6QaLeaqhrS2vI9rzD9ridIa5aNxc3e6lr7n4nRZhB+UQvP52URSp37VHP7aCVtfDpvL7ymlpAAoCA=
X-Received: by 2002:a9d:d88:: with SMTP id 8mr12064419ots.164.1551679425272;
 Sun, 03 Mar 2019 22:03:45 -0800 (PST)
MIME-Version: 1.0
References: <20190228231829.11993-1-daniel@iogearbox.net> <20190228231829.11993-2-daniel@iogearbox.net>
In-Reply-To: <20190228231829.11993-2-daniel@iogearbox.net>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Sun, 3 Mar 2019 22:03:32 -0800
Message-ID: <CAEf4BzZr1OQhiXS6+jraq_=HtjhTPvsNqcbizKKQvxPmOgZgXg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/7] bpf: implement lookup-free direct value access
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Alexei Starovoitov <ast@fb.com>, bpf@vger.kernel.org,
        Networking <netdev@vger.kernel.org>,
        Joe Stringer <joe@wand.net.nz>,
        john fastabend <john.fastabend@gmail.com>, tgraf@suug.ch,
        Yonghong Song <yhs@fb.com>, Andrii Nakryiko <andriin@fb.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        lmb@cloudflare.com
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Feb 28, 2019 at 3:31 PM Daniel Borkmann <daniel@iogearbox.net> wrote:
>
> This generic extension to BPF maps allows for directly loading an
> address residing inside a BPF map value as a single BPF ldimm64
> instruction.
>
> The idea is similar to what BPF_PSEUDO_MAP_FD does today, which
> is a special src_reg flag for ldimm64 instruction that indicates
> that inside the first part of the double insns's imm field is a
> file descriptor which the verifier then replaces as a full 64bit
> address of the map into both imm parts.
>
> For the newly added BPF_PSEUDO_MAP_VALUE src_reg flag, the idea
> is similar: the first part of the double insns's imm field is
> again a file descriptor corresponding to the map, and the second
> part of the imm field is an offset. The verifier will then replace
> both imm parts with an address that points into the BPF map value
> for maps that support this operation. BPF_PSEUDO_MAP_VALUE is a
> distinct flag as otherwise with BPF_PSEUDO_MAP_FD we could not
> differ offset 0 between load of map pointer versus load of map's
> value at offset 0.
>
> This allows for efficiently retrieving an address to a map value
> memory area without having to issue a helper call which needs to
> prepare registers according to calling convention, etc, without
> needing the extra NULL test, and without having to add the offset
> in an additional instruction to the value base pointer.
>
> The verifier then treats the destination register as PTR_TO_MAP_VALUE
> with constant reg->off from the user passed offset from the second
> imm field, and guarantees that this is within bounds of the map
> value. Any subsequent operations are normally treated as typical
> map value handling without anything else needed for verification.
>
> The two map operations for direct value access have been added to
> array map for now. In future other types could be supported as
> well depending on the use case. The main use case for this commit
> is to allow for BPF loader support for global variables that
> reside in .data/.rodata/.bss sections such that we can directly
> load the address of them with minimal additional infrastructure
> required. Loader support has been added in subsequent commits for
> libbpf library.
>
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> ---
>  include/linux/bpf.h               |  6 +++
>  include/linux/bpf_verifier.h      |  4 ++
>  include/uapi/linux/bpf.h          |  6 ++-
>  kernel/bpf/arraymap.c             | 33 ++++++++++++++
>  kernel/bpf/core.c                 |  3 +-
>  kernel/bpf/disasm.c               |  5 ++-
>  kernel/bpf/syscall.c              | 29 +++++++++---
>  kernel/bpf/verifier.c             | 73 +++++++++++++++++++++++--------
>  tools/bpf/bpftool/xlated_dumper.c |  3 ++
>  tools/include/uapi/linux/bpf.h    |  6 ++-
>  10 files changed, 138 insertions(+), 30 deletions(-)
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index a2132e09dc1c..bdcc6e2a9977 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -57,6 +57,12 @@ struct bpf_map_ops {
>                              const struct btf *btf,
>                              const struct btf_type *key_type,
>                              const struct btf_type *value_type);
> +
> +       /* Direct value access helpers. */
> +       int (*map_direct_value_access)(const struct bpf_map *map,
> +                                      u32 off, u64 *imm);
> +       int (*map_direct_value_offset)(const struct bpf_map *map,
> +                                      u64 imm, u32 *off);
>  };
>
>  struct bpf_map {
> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index 69f7a3449eda..6e28f1c24710 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -183,6 +183,10 @@ struct bpf_insn_aux_data {
>                 unsigned long map_state;        /* pointer/poison value for maps */
>                 s32 call_imm;                   /* saved imm field of call insn */
>                 u32 alu_limit;                  /* limit for add/sub register with pointer */
> +               struct {
> +                       u32 map_index;          /* index into used_maps[] */
> +                       u32 map_off;            /* offset from value base address */
> +               };
>         };
>         int ctx_field_size; /* the ctx field size for load insn, maybe 0 */
>         int sanitize_stack_off; /* stack slot to be cleared */
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 2e308e90ffea..8884072e1a46 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -255,8 +255,12 @@ enum bpf_attach_type {
>   */
>  #define BPF_F_ANY_ALIGNMENT    (1U << 1)
>
> -/* when bpf_ldimm64->src_reg == BPF_PSEUDO_MAP_FD, bpf_ldimm64->imm == fd */
> +/* When bpf_ldimm64->src_reg == BPF_PSEUDO_MAP_{FD,VALUE}, then
> + * bpf_ldimm64's insn[0]->imm == fd in both cases. Additionally,
> + * for BPF_PSEUDO_MAP_VALUE, insn[1]->imm == offset into value.
> + */
>  #define BPF_PSEUDO_MAP_FD      1
> +#define BPF_PSEUDO_MAP_VALUE   2
>
>  /* when bpf_call->src_reg == BPF_PSEUDO_CALL, bpf_call->imm == pc-relative
>   * offset to another bpf function
> diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
> index c72e0d8e1e65..3e5969c0c979 100644
> --- a/kernel/bpf/arraymap.c
> +++ b/kernel/bpf/arraymap.c
> @@ -160,6 +160,37 @@ static void *array_map_lookup_elem(struct bpf_map *map, void *key)
>         return array->value + array->elem_size * (index & array->index_mask);
>  }
>
> +static int array_map_direct_value_access(const struct bpf_map *map, u32 off,
> +                                        u64 *imm)
> +{
> +       struct bpf_array *array = container_of(map, struct bpf_array, map);
> +
> +       if (map->max_entries != 1)
> +               return -ENOTSUPP;
> +       if (off >= map->value_size)
> +               return -EINVAL;
> +
> +       *imm = (unsigned long)array->value;
> +       return 0;
> +}
> +
> +static int array_map_direct_value_offset(const struct bpf_map *map, u64 imm,
> +                                        u32 *off)
> +{
> +       struct bpf_array *array = container_of(map, struct bpf_array, map);
> +       unsigned long range = map->value_size;
> +       unsigned long base  = array->value;
> +       unsigned long addr  = imm;
> +
> +       if (map->max_entries != 1)
> +               return -ENOENT;
> +       if (addr < base || addr >= base + range)
> +               return -ENOENT;
> +
> +       *off = addr - base;
> +       return 0;
> +}
> +
>  /* emit BPF instructions equivalent to C code of array_map_lookup_elem() */
>  static u32 array_map_gen_lookup(struct bpf_map *map, struct bpf_insn *insn_buf)
>  {
> @@ -419,6 +450,8 @@ const struct bpf_map_ops array_map_ops = {
>         .map_update_elem = array_map_update_elem,
>         .map_delete_elem = array_map_delete_elem,
>         .map_gen_lookup = array_map_gen_lookup,
> +       .map_direct_value_access = array_map_direct_value_access,
> +       .map_direct_value_offset = array_map_direct_value_offset,
>         .map_seq_show_elem = array_map_seq_show_elem,
>         .map_check_btf = array_map_check_btf,
>  };
> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index 1c14c347f3cf..49fc0ff14537 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -286,7 +286,8 @@ int bpf_prog_calc_tag(struct bpf_prog *fp)
>                 dst[i] = fp->insnsi[i];
>                 if (!was_ld_map &&
>                     dst[i].code == (BPF_LD | BPF_IMM | BPF_DW) &&
> -                   dst[i].src_reg == BPF_PSEUDO_MAP_FD) {
> +                   (dst[i].src_reg == BPF_PSEUDO_MAP_FD ||
> +                    dst[i].src_reg == BPF_PSEUDO_MAP_VALUE)) {
>                         was_ld_map = true;
>                         dst[i].imm = 0;
>                 } else if (was_ld_map &&
> diff --git a/kernel/bpf/disasm.c b/kernel/bpf/disasm.c
> index de73f55e42fd..d9ce383c0f9c 100644
> --- a/kernel/bpf/disasm.c
> +++ b/kernel/bpf/disasm.c
> @@ -205,10 +205,11 @@ void print_bpf_insn(const struct bpf_insn_cbs *cbs,
>                          * part of the ldimm64 insn is accessible.
>                          */
>                         u64 imm = ((u64)(insn + 1)->imm << 32) | (u32)insn->imm;
> -                       bool map_ptr = insn->src_reg == BPF_PSEUDO_MAP_FD;
> +                       bool is_ptr = insn->src_reg == BPF_PSEUDO_MAP_FD ||
> +                                     insn->src_reg == BPF_PSEUDO_MAP_VALUE;
>                         char tmp[64];
>
> -                       if (map_ptr && !allow_ptr_leaks)
> +                       if (is_ptr && !allow_ptr_leaks)
>                                 imm = 0;
>
>                         verbose(cbs->private_data, "(%02x) r%d = %s\n",
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 174581dfe225..d3ef45e01d7a 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -2061,13 +2061,27 @@ static int bpf_map_get_fd_by_id(const union bpf_attr *attr)
>  }
>
>  static const struct bpf_map *bpf_map_from_imm(const struct bpf_prog *prog,
> -                                             unsigned long addr)
> +                                             unsigned long addr, u32 *off,
> +                                             u32 *type)
>  {
> +       const struct bpf_map *map;
>         int i;
>
> -       for (i = 0; i < prog->aux->used_map_cnt; i++)
> -               if (prog->aux->used_maps[i] == (void *)addr)
> -                       return prog->aux->used_maps[i];
> +       *off = *type = 0;
> +       for (i = 0; i < prog->aux->used_map_cnt; i++) {
> +               map = prog->aux->used_maps[i];
> +               if (map == (void *)addr) {
> +                       *type = BPF_PSEUDO_MAP_FD;
> +                       return map;
> +               }
> +               if (!map->ops->map_direct_value_offset)
> +                       continue;
> +               if (!map->ops->map_direct_value_offset(map, addr, off)) {
> +                       *type = BPF_PSEUDO_MAP_VALUE;
> +                       return map;
> +               }
> +       }
> +
>         return NULL;
>  }
>
> @@ -2075,6 +2089,7 @@ static struct bpf_insn *bpf_insn_prepare_dump(const struct bpf_prog *prog)
>  {
>         const struct bpf_map *map;
>         struct bpf_insn *insns;
> +       u32 off, type;
>         u64 imm;
>         int i;
>
> @@ -2102,11 +2117,11 @@ static struct bpf_insn *bpf_insn_prepare_dump(const struct bpf_prog *prog)
>                         continue;
>
>                 imm = ((u64)insns[i + 1].imm << 32) | (u32)insns[i].imm;
> -               map = bpf_map_from_imm(prog, imm);
> +               map = bpf_map_from_imm(prog, imm, &off, &type);
>                 if (map) {
> -                       insns[i].src_reg = BPF_PSEUDO_MAP_FD;
> +                       insns[i].src_reg = type;
>                         insns[i].imm = map->id;
> -                       insns[i + 1].imm = 0;
> +                       insns[i + 1].imm = off;
>                         continue;
>                 }
>         }
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 0e4edd7e3c5f..3ad05dda6e9d 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -4944,18 +4944,12 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,
>         return 0;
>  }
>
> -/* return the map pointer stored inside BPF_LD_IMM64 instruction */
> -static struct bpf_map *ld_imm64_to_map_ptr(struct bpf_insn *insn)
> -{
> -       u64 imm64 = ((u64) (u32) insn[0].imm) | ((u64) (u32) insn[1].imm) << 32;
> -
> -       return (struct bpf_map *) (unsigned long) imm64;
> -}
> -
>  /* verify BPF_LD_IMM64 instruction */
>  static int check_ld_imm(struct bpf_verifier_env *env, struct bpf_insn *insn)
>  {
> +       struct bpf_insn_aux_data *aux = cur_aux(env);
>         struct bpf_reg_state *regs = cur_regs(env);
> +       struct bpf_map *map;
>         int err;
>
>         if (BPF_SIZE(insn->code) != BPF_DW) {
> @@ -4979,11 +4973,22 @@ static int check_ld_imm(struct bpf_verifier_env *env, struct bpf_insn *insn)
>                 return 0;
>         }
>
> -       /* replace_map_fd_with_map_ptr() should have caught bad ld_imm64 */
> -       BUG_ON(insn->src_reg != BPF_PSEUDO_MAP_FD);
> +       map = env->used_maps[aux->map_index];
> +       mark_reg_known_zero(env, regs, insn->dst_reg);
> +       regs[insn->dst_reg].map_ptr = map;
> +
> +       if (insn->src_reg == BPF_PSEUDO_MAP_VALUE) {
> +               regs[insn->dst_reg].type = PTR_TO_MAP_VALUE;
> +               regs[insn->dst_reg].off = aux->map_off;
> +               if (map_value_has_spin_lock(map))
> +                       regs[insn->dst_reg].id = ++env->id_gen;
> +       } else if (insn->src_reg == BPF_PSEUDO_MAP_FD) {
> +               regs[insn->dst_reg].type = CONST_PTR_TO_MAP;
> +       } else {
> +               verbose(env, "bpf verifier is misconfigured\n");
> +               return -EINVAL;
> +       }
>
> -       regs[insn->dst_reg].type = CONST_PTR_TO_MAP;
> -       regs[insn->dst_reg].map_ptr = ld_imm64_to_map_ptr(insn);
>         return 0;
>  }
>
> @@ -6664,8 +6669,10 @@ static int replace_map_fd_with_map_ptr(struct bpf_verifier_env *env)
>                 }
>
>                 if (insn[0].code == (BPF_LD | BPF_IMM | BPF_DW)) {
> +                       struct bpf_insn_aux_data *aux;
>                         struct bpf_map *map;
>                         struct fd f;
> +                       u64 addr;
>
>                         if (i == insn_cnt - 1 || insn[1].code != 0 ||
>                             insn[1].dst_reg != 0 || insn[1].src_reg != 0 ||

Next line after this one rejects ldimm64 instructions with off != 0.
This check needs to be changed, depending on whether src_reg ==
BPF_PSEUDO_MAP_VALUE, right?

This is also to the previously discussed question of not enforcing
offset (imm=0 in 2nd part of insn) for BPF_PSEUDO_MAP_FD. Seems like
verifier *does* enforce that (not that I'm advocating for re-using
BPF_PSEUDO_MAP_FD, just stumbled on this bit when going through
verifier code).

> @@ -6677,8 +6684,8 @@ static int replace_map_fd_with_map_ptr(struct bpf_verifier_env *env)
>                         if (insn->src_reg == 0)
>                                 /* valid generic load 64-bit imm */
>                                 goto next_insn;
> -
> -                       if (insn->src_reg != BPF_PSEUDO_MAP_FD) {
> +                       if (insn->src_reg != BPF_PSEUDO_MAP_FD &&
> +                           insn->src_reg != BPF_PSEUDO_MAP_VALUE) {
>                                 verbose(env,
>                                         "unrecognized bpf_ld_imm64 insn\n");
>                                 return -EINVAL;
> @@ -6698,16 +6705,44 @@ static int replace_map_fd_with_map_ptr(struct bpf_verifier_env *env)
>                                 return err;
>                         }
>
> -                       /* store map pointer inside BPF_LD_IMM64 instruction */
> -                       insn[0].imm = (u32) (unsigned long) map;
> -                       insn[1].imm = ((u64) (unsigned long) map) >> 32;
> +                       aux = &env->insn_aux_data[i];
> +                       if (insn->src_reg == BPF_PSEUDO_MAP_FD) {
> +                               addr = (unsigned long)map;
> +                       } else {
> +                               u32 off = insn[1].imm;
> +
> +                               if (off >= BPF_MAX_VAR_OFF) {
> +                                       verbose(env, "direct value offset of %u is not allowed\n",
> +                                               off);
> +                                       return -EINVAL;
> +                               }
> +                               if (!map->ops->map_direct_value_access) {
> +                                       verbose(env, "no direct value access support for this map type\n");
> +                                       return -EINVAL;
> +                               }
> +
> +                               err = map->ops->map_direct_value_access(map, off, &addr);
> +                               if (err) {
> +                                       verbose(env, "invalid access to map value pointer, value_size=%u off=%u\n",
> +                                               map->value_size, off);
> +                                       return err;
> +                               }
> +
> +                               aux->map_off = off;
> +                               addr += off;
> +                       }
> +
> +                       insn[0].imm = (u32)addr;
> +                       insn[1].imm = addr >> 32;
>
>                         /* check whether we recorded this map already */
> -                       for (j = 0; j < env->used_map_cnt; j++)
> +                       for (j = 0; j < env->used_map_cnt; j++) {
>                                 if (env->used_maps[j] == map) {
> +                                       aux->map_index = j;
>                                         fdput(f);
>                                         goto next_insn;
>                                 }
> +                       }
>
>                         if (env->used_map_cnt >= MAX_USED_MAPS) {
>                                 fdput(f);
> @@ -6724,6 +6759,8 @@ static int replace_map_fd_with_map_ptr(struct bpf_verifier_env *env)
>                                 fdput(f);
>                                 return PTR_ERR(map);
>                         }
> +
> +                       aux->map_index = env->used_map_cnt;
>                         env->used_maps[env->used_map_cnt++] = map;
>
>                         if (bpf_map_is_cgroup_storage(map) &&
> diff --git a/tools/bpf/bpftool/xlated_dumper.c b/tools/bpf/bpftool/xlated_dumper.c
> index 7073dbe1ff27..0bb17bf88b18 100644
> --- a/tools/bpf/bpftool/xlated_dumper.c
> +++ b/tools/bpf/bpftool/xlated_dumper.c
> @@ -195,6 +195,9 @@ static const char *print_imm(void *private_data,
>         if (insn->src_reg == BPF_PSEUDO_MAP_FD)
>                 snprintf(dd->scratch_buff, sizeof(dd->scratch_buff),
>                          "map[id:%u]", insn->imm);
> +       else if (insn->src_reg == BPF_PSEUDO_MAP_VALUE)
> +               snprintf(dd->scratch_buff, sizeof(dd->scratch_buff),
> +                        "map[id:%u][0]+%u", insn->imm, (insn + 1)->imm);
>         else
>                 snprintf(dd->scratch_buff, sizeof(dd->scratch_buff),
>                          "0x%llx", (unsigned long long)full_imm);
> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
> index 2e308e90ffea..8884072e1a46 100644
> --- a/tools/include/uapi/linux/bpf.h
> +++ b/tools/include/uapi/linux/bpf.h
> @@ -255,8 +255,12 @@ enum bpf_attach_type {
>   */
>  #define BPF_F_ANY_ALIGNMENT    (1U << 1)
>
> -/* when bpf_ldimm64->src_reg == BPF_PSEUDO_MAP_FD, bpf_ldimm64->imm == fd */
> +/* When bpf_ldimm64->src_reg == BPF_PSEUDO_MAP_{FD,VALUE}, then
> + * bpf_ldimm64's insn[0]->imm == fd in both cases. Additionally,
> + * for BPF_PSEUDO_MAP_VALUE, insn[1]->imm == offset into value.
> + */
>  #define BPF_PSEUDO_MAP_FD      1
> +#define BPF_PSEUDO_MAP_VALUE   2
>
>  /* when bpf_call->src_reg == BPF_PSEUDO_CALL, bpf_call->imm == pc-relative
>   * offset to another bpf function
> --
> 2.17.1
>
