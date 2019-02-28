Return-Path: <SRS0=vk/n=RD=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 747C6C43381
	for <bpf@archiver.kernel.org>; Thu, 28 Feb 2019 22:40:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B1452133D
	for <bpf@archiver.kernel.org>; Thu, 28 Feb 2019 22:40:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aX8TrWkC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726088AbfB1Wkn (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 28 Feb 2019 17:40:43 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:43816 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726087AbfB1Wkm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 28 Feb 2019 17:40:42 -0500
Received: by mail-qk1-f196.google.com with SMTP id f196so13147833qke.10;
        Thu, 28 Feb 2019 14:40:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XP1Dk868nN7SmykmuwvcXhAda/Hm4YzTrfo6Cbl0hEk=;
        b=aX8TrWkC5wFckmQ+LDKyUJtGl9yxEcb52ZcMUZ03iRBKDgDPJj6Hfn+6ZbEqzyJy/G
         zIETQf/KVyXUIr6ccV/Jau1UDyjUec4h/pq9Bi9Tw01GUW35SPmjbPzEsjJUsssByVz4
         PaLDTndMl/LPk1pnzrBbKjCA4iHY3xWUlsr85ISEyuEhZa4knuHui2AwXxuCHvmoXmTp
         opOIx+WoaCXlZTSN9HoAsEfKKDSC3Ue4armW5gSq3euxY03tNHr+zdcih9mY3KtYze4f
         KYkq02NqIOt0GTKUtXL4cHCkPAZyMNkyKLBM83hbZl9UtQJeq4isV+DGaP64SFcFnUB2
         R28g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XP1Dk868nN7SmykmuwvcXhAda/Hm4YzTrfo6Cbl0hEk=;
        b=ePm9lO9+ze0+nff28OFF6Ox7vjA+yURxl45xCYfXTildEzqWweX9huFqNVT2aQnlIZ
         NufYKMK16+blf3MI1vx+b7rI51+++8QcDW4L/maAo6Tby/E72zFHsbJfaKeB+vwMeLa6
         kzxb0bU0CXhjQVi4CaW1MPMlPVVG9D+f6EDK26rGEtUW/7MsTbffRy+ZM7FRTfi6rtrX
         CndJCe3waFOHnAq/8Mwfv2i2wVkaq8FkcnCo4RhlKz4bqZ4FbDtMY9d+K7XidxR3DEdY
         r72psNxfXNAIrD2B9ScxihssoVbplW7Cbj4HG9fWoJICrHao42T2Zzw1HMrvo8QO3OZ1
         J7aw==
X-Gm-Message-State: APjAAAVBos/j5mD/G48UNmuefSBYsXp/zpSO5WZpnoCXjAIdDzua39hU
        pvyGNMRv0630yG3pg9qB4qvMGkxYygDLjB2cbNI=
X-Google-Smtp-Source: APXvYqwkCiCoL5z40a5OIg3/DnlUCPNZKrGOjl7GDIDZP+YfkKkkPVq3a4cn8m+yixLSALF529mpAW1fG6xF0nPW3bU=
X-Received: by 2002:a37:a38e:: with SMTP id m136mr1517496qke.120.1551393640660;
 Thu, 28 Feb 2019 14:40:40 -0800 (PST)
MIME-Version: 1.0
References: <20190228184512.198075-1-andriin@fb.com> <20190228184512.198075-4-andriin@fb.com>
In-Reply-To: <20190228184512.198075-4-andriin@fb.com>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Thu, 28 Feb 2019 14:40:29 -0800
Message-ID: <CAPhsuW6tDGhi3ROVsLU4j37_Xp7xbV=jnEQ5ce-fV=vdCaJ-BQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 3/4] bpf: fix formatting, typos, reflow comments
 in syscall.c, verifier.c
To:     Andrii Nakryiko <andriin@fb.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>, ast@fb.com,
        yhs@fb.com, Networking <netdev@vger.kernel.org>,
        bpf@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Feb 28, 2019 at 10:59 AM Andrii Nakryiko <andriin@fb.com> wrote:
>
> Fix few formatting errors. Fix few typos and reflow long descriptive
> comments for more even text fill.
>
> Signed-off-by: Andrii Nakryiko <andriin@fb.com>

I think we should not change the code for formatting, as these changes make
git-blame more difficult. How about we only make changes to comments?

Thanks,
Song

> ---
>  kernel/bpf/syscall.c  |   5 +-
>  kernel/bpf/verifier.c | 169 +++++++++++++++++++++---------------------
>  2 files changed, 87 insertions(+), 87 deletions(-)
>
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 174581dfe225..5272ba491e00 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -214,6 +214,7 @@ static int bpf_map_init_memlock(struct bpf_map *map)
>  static void bpf_map_release_memlock(struct bpf_map *map)
>  {
>         struct user_struct *user = map->user;
> +
>         bpf_uncharge_memlock(user, map->pages);
>         free_uid(user);
>  }
> @@ -299,7 +300,7 @@ static void bpf_map_put_uref(struct bpf_map *map)
>  }
>
>  /* decrement map refcnt and schedule it for freeing via workqueue
> - * (unrelying map implementation ops->map_free() might sleep)
> + * (underlying map implementation ops->map_free() might sleep)
>   */
>  static void __bpf_map_put(struct bpf_map *map, bool do_idr_lock)
>  {
> @@ -1414,7 +1415,7 @@ struct bpf_prog *bpf_prog_inc_not_zero(struct bpf_prog *prog)
>  EXPORT_SYMBOL_GPL(bpf_prog_inc_not_zero);
>
>  bool bpf_prog_get_ok(struct bpf_prog *prog,
> -                           enum bpf_prog_type *attach_type, bool attach_drv)
> +                    enum bpf_prog_type *attach_type, bool attach_drv)
>  {
>         /* not an attachment, just a refcount inc, always allow */
>         if (!attach_type)
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 0e4edd7e3c5f..0ee788bfd462 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -39,9 +39,9 @@ static const struct bpf_verifier_ops * const bpf_verifier_ops[] = {
>  #undef BPF_MAP_TYPE
>  };
>
> -/* bpf_check() is a static code analyzer that walks eBPF program
> - * instruction by instruction and updates register/stack state.
> - * All paths of conditional branches are analyzed until 'bpf_exit' insn.
> +/* bpf_check() is a static code analyzer that walks eBPF program instruction by
> + * instruction and updates register/stack state. All paths of conditional
> + * branches are analyzed until 'bpf_exit' insn.
>   *
>   * The first pass is depth-first-search to check that the program is a DAG.
>   * It rejects the following programs:
> @@ -49,15 +49,15 @@ static const struct bpf_verifier_ops * const bpf_verifier_ops[] = {
>   * - if loop is present (detected via back-edge)
>   * - unreachable insns exist (shouldn't be a forest. program = one function)
>   * - out of bounds or malformed jumps
> - * The second pass is all possible path descent from the 1st insn.
> - * Since it's analyzing all pathes through the program, the length of the
> - * analysis is limited to 64k insn, which may be hit even if total number of
> - * insn is less then 4K, but there are too many branches that change stack/regs.
> - * Number of 'branches to be analyzed' is limited to 1k
> + * The second pass is all possible path descent from the 1st insn. Since it's
> + * analyzing all pathes through the program, the length of the analysis is
> + * limited to 64k insn, which may be hit even if total number of insn is less
> + * than 4K, but there are too many branches that change stack/regs. Number of
> + * 'branches to be analyzed' is limited to 1k.
>   *
>   * On entry to each instruction, each register has a type, and the instruction
> - * changes the types of the registers depending on instruction semantics.
> - * If instruction is BPF_MOV64_REG(BPF_REG_1, BPF_REG_5), then type of R5 is
> + * changes the types of the registers depending on instruction semantics. If
> + * instruction is BPF_MOV64_REG(BPF_REG_1, BPF_REG_5), then type of R5 is
>   * copied to R1.
>   *
>   * All registers are 64-bit.
> @@ -66,37 +66,36 @@ static const struct bpf_verifier_ops * const bpf_verifier_ops[] = {
>   * R6-R9 callee saved registers
>   * R10 - frame pointer read-only
>   *
> - * At the start of BPF program the register R1 contains a pointer to bpf_context
> - * and has type PTR_TO_CTX.
> + * At the start of BPF program the register R1 contains a pointer to
> + * bpf_context and has type PTR_TO_CTX.
>   *
>   * Verifier tracks arithmetic operations on pointers in case:
>   *    BPF_MOV64_REG(BPF_REG_1, BPF_REG_10),
>   *    BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, -20),
> - * 1st insn copies R10 (which has FRAME_PTR) type into R1
> - * and 2nd arithmetic instruction is pattern matched to recognize
> - * that it wants to construct a pointer to some element within stack.
> - * So after 2nd insn, the register R1 has type PTR_TO_STACK
> - * (and -20 constant is saved for further stack bounds checking).
> - * Meaning that this reg is a pointer to stack plus known immediate constant.
> + * 1st insn copies R10 (which has FRAME_PTR) type into R1 and 2nd arithmetic
> + * instruction is pattern matched to recognize that it wants to construct
> + * a pointer to some element within stack. So after 2nd insn, the register R1
> + * has type PTR_TO_STACK (and -20 constant is saved for further stack bounds
> + * checking). Meaning that this reg is a pointer to stack plus known immediate
> + * constant.
>   *
> - * Most of the time the registers have SCALAR_VALUE type, which
> - * means the register has some value, but it's not a valid pointer.
> - * (like pointer plus pointer becomes SCALAR_VALUE type)
> + * Most of the time the registers have SCALAR_VALUE type, which means the
> + * register has some value, but it's not a valid pointer (like pointer plus
> + * pointer becomes SCALAR_VALUE type).
>   *
> - * When verifier sees load or store instructions the type of base register
> - * can be: PTR_TO_MAP_VALUE, PTR_TO_CTX, PTR_TO_STACK, PTR_TO_SOCKET. These are
> + * When verifier sees load or store instructions the type of base register can
> + * be: PTR_TO_MAP_VALUE, PTR_TO_CTX, PTR_TO_STACK, PTR_TO_SOCKET. These are
>   * four pointer types recognized by check_mem_access() function.
>   *
>   * PTR_TO_MAP_VALUE means that this register is pointing to 'map element value'
>   * and the range of [ptr, ptr + map's value_size) is accessible.
>   *
> - * registers used to pass values to function calls are checked against
> + * Registers used to pass values to function calls are checked against
>   * function argument constraints.
>   *
> - * ARG_PTR_TO_MAP_KEY is one of such argument constraints.
> - * It means that the register type passed to this function must be
> - * PTR_TO_STACK and it will be used inside the function as
> - * 'pointer to map element key'
> + * ARG_PTR_TO_MAP_KEY is one of such argument constraints. It means that the
> + * register type passed to this function must be PTR_TO_STACK and it will be
> + * used inside the function as 'pointer to map element key'
>   *
>   * For example the argument constraints for bpf_map_lookup_elem():
>   *   .ret_type = RET_PTR_TO_MAP_VALUE_OR_NULL,
> @@ -105,8 +104,8 @@ static const struct bpf_verifier_ops * const bpf_verifier_ops[] = {
>   *
>   * ret_type says that this function returns 'pointer to map elem value or null'
>   * function expects 1st argument to be a const pointer to 'struct bpf_map' and
> - * 2nd argument should be a pointer to stack, which will be used inside
> - * the helper function as a pointer to map element key.
> + * 2nd argument should be a pointer to stack, which will be used inside the
> + * helper function as a pointer to map element key.
>   *
>   * On the kernel side the helper function looks like:
>   * u64 bpf_map_lookup_elem(u64 r1, u64 r2, u64 r3, u64 r4, u64 r5)
> @@ -115,9 +114,9 @@ static const struct bpf_verifier_ops * const bpf_verifier_ops[] = {
>   *    void *key = (void *) (unsigned long) r2;
>   *    void *value;
>   *
> - *    here kernel can access 'key' and 'map' pointers safely, knowing that
> - *    [key, key + map->key_size) bytes are valid and were initialized on
> - *    the stack of eBPF program.
> + *    Here kernel can access 'key' and 'map' pointers safely, knowing that
> + *    [key, key + map->key_size) bytes are valid and were initialized on the
> + *    stack of eBPF program.
>   * }
>   *
>   * Corresponding eBPF program may look like:
> @@ -126,21 +125,21 @@ static const struct bpf_verifier_ops * const bpf_verifier_ops[] = {
>   *    BPF_LD_MAP_FD(BPF_REG_1, map_fd),      // after this insn R1 type is CONST_PTR_TO_MAP
>   *    BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
>   * here verifier looks at prototype of map_lookup_elem() and sees:
> - * .arg1_type == ARG_CONST_MAP_PTR and R1->type == CONST_PTR_TO_MAP, which is ok,
> - * Now verifier knows that this map has key of R1->map_ptr->key_size bytes
> + * .arg1_type == ARG_CONST_MAP_PTR and R1->type == CONST_PTR_TO_MAP, which is
> + * ok. Now verifier knows that this map has key of R1->map_ptr->key_size bytes.
>   *
> - * Then .arg2_type == ARG_PTR_TO_MAP_KEY and R2->type == PTR_TO_STACK, ok so far,
> - * Now verifier checks that [R2, R2 + map's key_size) are within stack limits
> - * and were initialized prior to this call.
> - * If it's ok, then verifier allows this BPF_CALL insn and looks at
> - * .ret_type which is RET_PTR_TO_MAP_VALUE_OR_NULL, so it sets
> - * R0->type = PTR_TO_MAP_VALUE_OR_NULL which means bpf_map_lookup_elem() function
> - * returns ether pointer to map value or NULL.
> + * Then .arg2_type == ARG_PTR_TO_MAP_KEY and R2->type == PTR_TO_STACK, ok so
> + * far. Now verifier checks that [R2, R2 + map's key_size) are within stack
> + * limits and were initialized prior to this call. If it's ok, then verifier
> + * allows this BPF_CALL insn and looks at .ret_type which is
> + * RET_PTR_TO_MAP_VALUE_OR_NULL, so it sets R0->type = PTR_TO_MAP_VALUE_OR_NULL
> + * which means bpf_map_lookup_elem() function returns either pointer to a map
> + * value or NULL.
>   *
>   * When type PTR_TO_MAP_VALUE_OR_NULL passes through 'if (reg != 0) goto +off'
>   * insn, the register holding that pointer in the true branch changes state to
> - * PTR_TO_MAP_VALUE and the same register changes state to CONST_IMM in the false
> - * branch. See check_cond_jmp_op().
> + * PTR_TO_MAP_VALUE and the same register changes state to CONST_IMM in the
> + * false branch. See check_cond_jmp_op().
>   *
>   * After the call R0 is set to return type of the function and registers R1-R5
>   * are set to NOT_INIT to indicate that they are no longer readable.
> @@ -148,10 +147,11 @@ static const struct bpf_verifier_ops * const bpf_verifier_ops[] = {
>   * The following reference types represent a potential reference to a kernel
>   * resource which, after first being allocated, must be checked and freed by
>   * the BPF program:
> - * - PTR_TO_SOCKET_OR_NULL, PTR_TO_SOCKET
> + * - PTR_TO_SOCKET_OR_NULL
> + * - PTR_TO_SOCKET
>   *
> - * When the verifier sees a helper call return a reference type, it allocates a
> - * pointer id for the reference and stores it in the current function state.
> + * When the verifier sees a helper call return a reference type, it allocates
> + * a pointer id for the reference and stores it in the current function state.
>   * Similar to the way that PTR_TO_MAP_VALUE_OR_NULL is converted into
>   * PTR_TO_MAP_VALUE, PTR_TO_SOCKET_OR_NULL becomes PTR_TO_SOCKET when the type
>   * passes through a NULL-check conditional. For the branch wherein the state is
> @@ -258,7 +258,7 @@ void bpf_verifier_vlog(struct bpf_verifier_log *log, const char *fmt,
>                 log->ubuf = NULL;
>  }
>
> -/* log_level controls verbosity level of eBPF verifier.
> +/* env->log.level controls verbosity level of eBPF verifier.
>   * bpf_verifier_log_write() is used to dump the verification trace to the log,
>   * so the user can figure out what's wrong with the program
>   */
> @@ -389,7 +389,7 @@ static bool is_release_function(enum bpf_func_id func_id)
>  static bool is_acquire_function(enum bpf_func_id func_id)
>  {
>         return func_id == BPF_FUNC_sk_lookup_tcp ||
> -               func_id == BPF_FUNC_sk_lookup_udp;
> +              func_id == BPF_FUNC_sk_lookup_udp;
>  }
>
>  /* string representation of 'enum bpf_reg_type' */
> @@ -559,39 +559,39 @@ COPY_STATE_FN(reference, acquired_refs, refs, 1)
>  COPY_STATE_FN(stack, allocated_stack, stack, BPF_REG_SIZE)
>  #undef COPY_STATE_FN
>
> -#define REALLOC_STATE_FN(NAME, COUNT, FIELD, SIZE)                     \
> -static int realloc_##NAME##_state(struct bpf_func_state *state, int size, \
> -                                 bool copy_old)                        \
> -{                                                                      \
> -       u32 old_size = state->COUNT;                                    \
> -       struct bpf_##NAME##_state *new_##FIELD;                         \
> -       int slot = size / SIZE;                                         \
> -                                                                       \
> -       if (size <= old_size || !size) {                                \
> -               if (copy_old)                                           \
> -                       return 0;                                       \
> -               state->COUNT = slot * SIZE;                             \
> -               if (!size && old_size) {                                \
> -                       kfree(state->FIELD);                            \
> -                       state->FIELD = NULL;                            \
> -               }                                                       \
> -               return 0;                                               \
> -       }                                                               \
> +#define REALLOC_STATE_FN(NAME, COUNT, FIELD, SIZE)                          \
> +static int realloc_##NAME##_state(struct bpf_func_state *state, int size,    \
> +                                 bool copy_old)                             \
> +{                                                                           \
> +       u32 old_size = state->COUNT;                                         \
> +       struct bpf_##NAME##_state *new_##FIELD;                              \
> +       int slot = size / SIZE;                                              \
> +                                                                            \
> +       if (size <= old_size || !size) {                                     \
> +               if (copy_old)                                                \
> +                       return 0;                                            \
> +               state->COUNT = slot * SIZE;                                  \
> +               if (!size && old_size) {                                     \
> +                       kfree(state->FIELD);                                 \
> +                       state->FIELD = NULL;                                 \
> +               }                                                            \
> +               return 0;                                                    \
> +       }                                                                    \
>         new_##FIELD = kmalloc_array(slot, sizeof(struct bpf_##NAME##_state), \
> -                                   GFP_KERNEL);                        \
> -       if (!new_##FIELD)                                               \
> -               return -ENOMEM;                                         \
> -       if (copy_old) {                                                 \
> -               if (state->FIELD)                                       \
> -                       memcpy(new_##FIELD, state->FIELD,               \
> -                              sizeof(*new_##FIELD) * (old_size / SIZE)); \
> -               memset(new_##FIELD + old_size / SIZE, 0,                \
> -                      sizeof(*new_##FIELD) * (size - old_size) / SIZE); \
> -       }                                                               \
> -       state->COUNT = slot * SIZE;                                     \
> -       kfree(state->FIELD);                                            \
> -       state->FIELD = new_##FIELD;                                     \
> -       return 0;                                                       \
> +                                   GFP_KERNEL);                             \
> +       if (!new_##FIELD)                                                    \
> +               return -ENOMEM;                                              \
> +       if (copy_old) {                                                      \
> +               if (state->FIELD)                                            \
> +                       memcpy(new_##FIELD, state->FIELD,                    \
> +                              sizeof(*new_##FIELD) * (old_size / SIZE));    \
> +               memset(new_##FIELD + old_size / SIZE, 0,                     \
> +                      sizeof(*new_##FIELD) * (size - old_size) / SIZE);     \
> +       }                                                                    \
> +       state->COUNT = slot * SIZE;                                          \
> +       kfree(state->FIELD);                                                 \
> +       state->FIELD = new_##FIELD;                                          \
> +       return 0;                                                            \
>  }
>  /* realloc_reference_state() */
>  REALLOC_STATE_FN(reference, acquired_refs, refs, 1)
> @@ -617,7 +617,7 @@ static int realloc_func_state(struct bpf_func_state *state, int stack_size,
>
>  /* Acquire a pointer id from the env and update the state->refs to include
>   * this new pointer reference.
> - * On success, returns a valid pointer id to associate with the register
> + * On success, returns a valid pointer id to associate with the register.
>   * On failure, returns a negative errno.
>   */
>  static int acquire_reference_state(struct bpf_verifier_env *env, int insn_idx)
> @@ -714,7 +714,7 @@ static int copy_verifier_state(struct bpf_verifier_state *dst_state,
>         struct bpf_func_state *dst;
>         int i, err;
>
> -       /* if dst has more stack frames then src frame, free them */
> +       /* if dst has more stack frames than src frame, free them */
>         for (i = src->curframe + 1; i <= dst_state->curframe; i++) {
>                 free_func_state(dst_state->frame[i]);
>                 dst_state->frame[i] = NULL;
> @@ -863,8 +863,7 @@ static bool reg_is_init_pkt_pointer(const struct bpf_reg_state *reg,
>                                     enum bpf_reg_type which)
>  {
>         /* The register can already have a range from prior markings.
> -        * This is fine as long as it hasn't been advanced from its
> -        * origin.
> +        * This is fine as long as it hasn't been advanced from its origin.
>          */
>         return reg->type == which &&
>                reg->id == 0 &&
> --
> 2.17.1
>
