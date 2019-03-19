Return-Path: <SRS0=wUMJ=RW=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C186C10F03
	for <bpf@archiver.kernel.org>; Tue, 19 Mar 2019 18:18:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0819213F2
	for <bpf@archiver.kernel.org>; Tue, 19 Mar 2019 18:18:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LFYQAyHL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727079AbfCSSSX (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 19 Mar 2019 14:18:23 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:46814 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726925AbfCSSSX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 19 Mar 2019 14:18:23 -0400
Received: by mail-oi1-f193.google.com with SMTP id x188so4553984oia.13;
        Tue, 19 Mar 2019 11:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NaU7VT662Z9FnRJaUKgLUQlM1K1KUNYxtBa/HGTdDwM=;
        b=LFYQAyHLtOhv0KmqHChZfLoAqyEOvol4cQZ8TY+f3ZvTZzp3y7OJo2zvAn4qciWcuQ
         q7ykSt+QR2kw0KZJ0Kx9jwG/8iKvDlLepxMEeHxL1MYnHYB4ecLcDIUtR7Kc3yum7c+T
         WEiMetSjvtaOf0EhVXPPOzErzjjCJTd+LzmEOs6SuV3dn1K2qeAmXIR7ggQ/pIQEd/4O
         TOePHF0f6bZRZHSKemNoGDeQ905Yjhf0aLhAN9r5HdDiPuXILu3ENdzvDQ0D1kKd+uV2
         pIO0fYpkKEDxKaEJIWkwUlnLeA/PKdCz0u1cwtF4lajD823bWKGHBAWxUGnhwKQz3HAt
         oDTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NaU7VT662Z9FnRJaUKgLUQlM1K1KUNYxtBa/HGTdDwM=;
        b=QrcUM6M0gfDbqAxQm6eQWY5lBQN7lE8FuMTv6ZsrJN1am2qaQ+UbZwBFXIcg3oWbsO
         tpnnMUnB50QU1gIc0/t8psfLHeW9W5vKoj8wBxMFOHd59d5nB6VrsfcEvJsRvAQdGDvW
         kcsHdbV1XbdMXE/BaL9FbizjxtbJZEEPwZjMfIgaPzjGO5GmYrp42eGy1Sw67/r74MYz
         +rGPuXy8q+X2ZoFtHRGc1BH+3a8DrzTCsl+ytGtuPT3qm9/yQys3m5H+DNuXJINn8LHH
         HrQIzUiWawOCWfEjZDDIR3gueJjgfJB8X0+QKntiOSEWULhzN4D/9fPJNKc+WflA9zBv
         9Pjg==
X-Gm-Message-State: APjAAAUIn+mKTWmDgJWvuaiWLQ1vC/aaUzrqjpwnItLK8N+/nV0AaNtI
        4+wusJ6mst4S5t0F60hPeoVzMBJBxYDujVxHQ+8=
X-Google-Smtp-Source: APXvYqz0fjuPRIUWMwkii/Eo1ZNW0x8hEW1LxliHJ6/9aupZem7LUt7Zg7p/4Wbm7wTbVyaNhplfSH9CO38ey6BEv6Q=
X-Received: by 2002:aca:3e54:: with SMTP id l81mr2260012oia.10.1553019502129;
 Tue, 19 Mar 2019 11:18:22 -0700 (PDT)
MIME-Version: 1.0
References: <20190311215125.17793-1-daniel@iogearbox.net> <20190311215125.17793-9-daniel@iogearbox.net>
In-Reply-To: <20190311215125.17793-9-daniel@iogearbox.net>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 19 Mar 2019 11:18:10 -0700
Message-ID: <CAEf4BzZFKRG945R=ZSribDYXgytm=4BQ4srFfkgD5qS_Yd9xRg@mail.gmail.com>
Subject: Re: [PATCH rfc v3 bpf-next 8/9] bpf, selftest: test {rd,wr}only flags
 and direct value access
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
> Extend test_verifier with various test cases around the two kernel
> extensions, that is, {rd,wr}only map support as well as direct map
> value access. All passing, one skipped due to xskmap not present
> on test machine:

It would be good to have few tests with value size < sizeof(long) to
catch bugs with not rounding up value size internally.

>
>   # ./test_verifier
>   [...]
>   #920/p XDP pkt read, pkt_data <= pkt_meta', bad access 1 OK
>   #921/p XDP pkt read, pkt_data <= pkt_meta', bad access 2 OK
>   Summary: 1366 PASSED, 1 SKIPPED, 0 FAILED
>
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> ---
>  tools/include/linux/filter.h                  |  14 ++
>  tools/testing/selftests/bpf/test_verifier.c   |  42 +++-
>  .../selftests/bpf/verifier/array_access.c     | 159 ++++++++++++
>  .../bpf/verifier/direct_value_access.c        | 226 ++++++++++++++++++
>  4 files changed, 436 insertions(+), 5 deletions(-)
>  create mode 100644 tools/testing/selftests/bpf/verifier/direct_value_access.c
>
> diff --git a/tools/include/linux/filter.h b/tools/include/linux/filter.h
> index cce0b02c0e28..d288576e0bcd 100644
> --- a/tools/include/linux/filter.h
> +++ b/tools/include/linux/filter.h
> @@ -283,6 +283,20 @@
>  #define BPF_LD_MAP_FD(DST, MAP_FD)                             \
>         BPF_LD_IMM64_RAW(DST, BPF_PSEUDO_MAP_FD, MAP_FD)
>
> +#define BPF_LD_MAP_VALUE(DST, MAP_FD, VALUE_IDX, VALUE_OFF)    \
> +       ((struct bpf_insn) {                                    \
> +               .code  = BPF_LD | BPF_DW | BPF_IMM,             \
> +               .dst_reg = DST,                                 \
> +               .src_reg = BPF_PSEUDO_MAP_VALUE,                \
> +               .off   = (__u16)(VALUE_IDX),                    \
> +               .imm   = MAP_FD }),                             \
> +       ((struct bpf_insn) {                                    \
> +               .code  = 0, /* zero is reserved opcode */       \
> +               .dst_reg = 0,                                   \
> +               .src_reg = 0,                                   \
> +               .off   = ((__u32)(VALUE_IDX)) >> 16,            \
> +               .imm   = VALUE_OFF })
> +
>  /* Relative call */
>
>  #define BPF_CALL_REL(TGT)                                      \
> diff --git a/tools/testing/selftests/bpf/test_verifier.c b/tools/testing/selftests/bpf/test_verifier.c
> index 477a9dcf9fff..7ef1991a5295 100644
> --- a/tools/testing/selftests/bpf/test_verifier.c
> +++ b/tools/testing/selftests/bpf/test_verifier.c
> @@ -51,7 +51,7 @@
>
>  #define MAX_INSNS      BPF_MAXINSNS
>  #define MAX_FIXUPS     8
> -#define MAX_NR_MAPS    14
> +#define MAX_NR_MAPS    16
>  #define MAX_TEST_RUNS  8
>  #define POINTER_VALUE  0xcafe4all
>  #define TEST_DATA_LEN  64
> @@ -80,6 +80,8 @@ struct bpf_test {
>         int fixup_cgroup_storage[MAX_FIXUPS];
>         int fixup_percpu_cgroup_storage[MAX_FIXUPS];
>         int fixup_map_spin_lock[MAX_FIXUPS];
> +       int fixup_map_array_ro[MAX_FIXUPS];
> +       int fixup_map_array_wo[MAX_FIXUPS];
>         const char *errstr;
>         const char *errstr_unpriv;
>         uint32_t retval, retval_unpriv, insn_processed;
> @@ -277,13 +279,15 @@ static bool skip_unsupported_map(enum bpf_map_type map_type)
>         return false;
>  }
>
> -static int create_map(uint32_t type, uint32_t size_key,
> -                     uint32_t size_value, uint32_t max_elem)
> +static int __create_map(uint32_t type, uint32_t size_key,
> +                       uint32_t size_value, uint32_t max_elem,
> +                       uint32_t extra_flags)
>  {
>         int fd;
>
>         fd = bpf_create_map(type, size_key, size_value, max_elem,
> -                           type == BPF_MAP_TYPE_HASH ? BPF_F_NO_PREALLOC : 0);
> +                           (type == BPF_MAP_TYPE_HASH ?
> +                            BPF_F_NO_PREALLOC : 0) | extra_flags);
>         if (fd < 0) {
>                 if (skip_unsupported_map(type))
>                         return -1;
> @@ -293,6 +297,12 @@ static int create_map(uint32_t type, uint32_t size_key,
>         return fd;
>  }
>
> +static int create_map(uint32_t type, uint32_t size_key,
> +                     uint32_t size_value, uint32_t max_elem)
> +{
> +       return __create_map(type, size_key, size_value, max_elem, 0);
> +}
> +
>  static void update_map(int fd, int index)
>  {
>         struct test_val value = {
> @@ -519,6 +529,8 @@ static void do_test_fixup(struct bpf_test *test, enum bpf_prog_type prog_type,
>         int *fixup_cgroup_storage = test->fixup_cgroup_storage;
>         int *fixup_percpu_cgroup_storage = test->fixup_percpu_cgroup_storage;
>         int *fixup_map_spin_lock = test->fixup_map_spin_lock;
> +       int *fixup_map_array_ro = test->fixup_map_array_ro;
> +       int *fixup_map_array_wo = test->fixup_map_array_wo;
>
>         if (test->fill_helper)
>                 test->fill_helper(test);
> @@ -556,7 +568,7 @@ static void do_test_fixup(struct bpf_test *test, enum bpf_prog_type prog_type,
>
>         if (*fixup_map_array_48b) {
>                 map_fds[3] = create_map(BPF_MAP_TYPE_ARRAY, sizeof(int),
> -                                       sizeof(struct test_val), 1);
> +                                       sizeof(struct test_val), 2);
>                 update_map(map_fds[3], 0);
>                 do {
>                         prog[*fixup_map_array_48b].imm = map_fds[3];
> @@ -642,6 +654,26 @@ static void do_test_fixup(struct bpf_test *test, enum bpf_prog_type prog_type,
>                         fixup_map_spin_lock++;
>                 } while (*fixup_map_spin_lock);
>         }
> +       if (*fixup_map_array_ro) {
> +               map_fds[14] = __create_map(BPF_MAP_TYPE_ARRAY, sizeof(int),
> +                                          sizeof(struct test_val), 1,
> +                                          BPF_F_RDONLY_PROG);
> +               update_map(map_fds[14], 0);
> +               do {
> +                       prog[*fixup_map_array_ro].imm = map_fds[14];
> +                       fixup_map_array_ro++;
> +               } while (*fixup_map_array_ro);
> +       }
> +       if (*fixup_map_array_wo) {
> +               map_fds[15] = __create_map(BPF_MAP_TYPE_ARRAY, sizeof(int),
> +                                          sizeof(struct test_val), 1,
> +                                          BPF_F_WRONLY_PROG);
> +               update_map(map_fds[15], 0);
> +               do {
> +                       prog[*fixup_map_array_wo].imm = map_fds[15];
> +                       fixup_map_array_wo++;
> +               } while (*fixup_map_array_wo);
> +       }
>  }
>
>  static int set_admin(bool admin)
> diff --git a/tools/testing/selftests/bpf/verifier/array_access.c b/tools/testing/selftests/bpf/verifier/array_access.c
> index 0dcecaf3ec6f..9a2b6f9b4414 100644
> --- a/tools/testing/selftests/bpf/verifier/array_access.c
> +++ b/tools/testing/selftests/bpf/verifier/array_access.c
> @@ -217,3 +217,162 @@
>         .result = REJECT,
>         .flags = F_NEEDS_EFFICIENT_UNALIGNED_ACCESS,
>  },
> +{
> +       "valid read map access into a read-only array 1",
> +       .insns = {
> +       BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
> +       BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
> +       BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
> +       BPF_LD_MAP_FD(BPF_REG_1, 0),
> +       BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
> +       BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 1),
> +       BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_0, 0),
> +       BPF_EXIT_INSN(),
> +       },
> +       .fixup_map_array_ro = { 3 },
> +       .result = ACCEPT,
> +       .retval = 28,
> +},
> +{
> +       "valid read map access into a read-only array 2",
> +       .insns = {
> +       BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
> +       BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
> +       BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
> +       BPF_LD_MAP_FD(BPF_REG_1, 0),
> +       BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
> +       BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 6),
> +
> +       BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
> +       BPF_MOV64_IMM(BPF_REG_2, 4),
> +       BPF_MOV64_IMM(BPF_REG_3, 0),
> +       BPF_MOV64_IMM(BPF_REG_4, 0),
> +       BPF_MOV64_IMM(BPF_REG_5, 0),
> +       BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0,
> +                    BPF_FUNC_csum_diff),
> +       BPF_EXIT_INSN(),
> +       },
> +       .prog_type = BPF_PROG_TYPE_SCHED_CLS,
> +       .fixup_map_array_ro = { 3 },
> +       .result = ACCEPT,
> +       .retval = -29,
> +},
> +{
> +       "invalid write map access into a read-only array 1",
> +       .insns = {
> +       BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
> +       BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
> +       BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
> +       BPF_LD_MAP_FD(BPF_REG_1, 0),
> +       BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
> +       BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 1),
> +       BPF_ST_MEM(BPF_DW, BPF_REG_0, 0, 42),
> +       BPF_EXIT_INSN(),
> +       },
> +       .fixup_map_array_ro = { 3 },
> +       .result = REJECT,
> +       .errstr = "write into map forbidden",
> +},
> +{
> +       "invalid write map access into a read-only array 2",
> +       .insns = {
> +       BPF_MOV64_REG(BPF_REG_6, BPF_REG_1),
> +       BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
> +       BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
> +       BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
> +       BPF_LD_MAP_FD(BPF_REG_1, 0),
> +       BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
> +       BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 5),
> +       BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
> +       BPF_MOV64_IMM(BPF_REG_2, 0),
> +       BPF_MOV64_REG(BPF_REG_3, BPF_REG_0),
> +       BPF_MOV64_IMM(BPF_REG_4, 8),
> +       BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0,
> +                    BPF_FUNC_skb_load_bytes),
> +       BPF_EXIT_INSN(),
> +       },
> +       .prog_type = BPF_PROG_TYPE_SCHED_CLS,
> +       .fixup_map_array_ro = { 4 },
> +       .result = REJECT,
> +       .errstr = "write into map forbidden",
> +},
> +{
> +       "valid write map access into a write-only array 1",
> +       .insns = {
> +       BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
> +       BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
> +       BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
> +       BPF_LD_MAP_FD(BPF_REG_1, 0),
> +       BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
> +       BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 1),
> +       BPF_ST_MEM(BPF_DW, BPF_REG_0, 0, 42),
> +       BPF_MOV64_IMM(BPF_REG_0, 1),
> +       BPF_EXIT_INSN(),
> +       },
> +       .fixup_map_array_wo = { 3 },
> +       .result = ACCEPT,
> +       .retval = 1,
> +},
> +{
> +       "valid write map access into a write-only array 2",
> +       .insns = {
> +       BPF_MOV64_REG(BPF_REG_6, BPF_REG_1),
> +       BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
> +       BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
> +       BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
> +       BPF_LD_MAP_FD(BPF_REG_1, 0),
> +       BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
> +       BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 5),
> +       BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
> +       BPF_MOV64_IMM(BPF_REG_2, 0),
> +       BPF_MOV64_REG(BPF_REG_3, BPF_REG_0),
> +       BPF_MOV64_IMM(BPF_REG_4, 8),
> +       BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0,
> +                    BPF_FUNC_skb_load_bytes),
> +       BPF_EXIT_INSN(),
> +       },
> +       .prog_type = BPF_PROG_TYPE_SCHED_CLS,
> +       .fixup_map_array_wo = { 4 },
> +       .result = ACCEPT,
> +       .retval = 0,
> +},
> +{
> +       "invalid read map access into a write-only array 1",
> +       .insns = {
> +       BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
> +       BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
> +       BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
> +       BPF_LD_MAP_FD(BPF_REG_1, 0),
> +       BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
> +       BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 1),
> +       BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_0, 0),
> +       BPF_EXIT_INSN(),
> +       },
> +       .fixup_map_array_wo = { 3 },
> +       .result = REJECT,
> +       .errstr = "read into map forbidden",
> +},
> +{
> +       "invalid read map access into a write-only array 2",
> +       .insns = {
> +       BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
> +       BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
> +       BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
> +       BPF_LD_MAP_FD(BPF_REG_1, 0),
> +       BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
> +       BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 6),
> +
> +       BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
> +       BPF_MOV64_IMM(BPF_REG_2, 4),
> +       BPF_MOV64_IMM(BPF_REG_3, 0),
> +       BPF_MOV64_IMM(BPF_REG_4, 0),
> +       BPF_MOV64_IMM(BPF_REG_5, 0),
> +       BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0,
> +                    BPF_FUNC_csum_diff),
> +       BPF_EXIT_INSN(),
> +       },
> +       .prog_type = BPF_PROG_TYPE_SCHED_CLS,
> +       .fixup_map_array_wo = { 3 },
> +       .result = REJECT,
> +       .errstr = "read into map forbidden",
> +},
> diff --git a/tools/testing/selftests/bpf/verifier/direct_value_access.c b/tools/testing/selftests/bpf/verifier/direct_value_access.c
> new file mode 100644
> index 000000000000..656c3675b735
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/verifier/direct_value_access.c
> @@ -0,0 +1,226 @@
> +{
> +       "direct map access, write test 1",
> +       .insns = {
> +       BPF_MOV64_IMM(BPF_REG_0, 1),
> +       BPF_LD_MAP_VALUE(BPF_REG_1, 0, 0, 0),
> +       BPF_ST_MEM(BPF_DW, BPF_REG_1, 0, 4242),
> +       BPF_EXIT_INSN(),
> +       },
> +       .fixup_map_array_48b = { 1 },
> +       .result = ACCEPT,
> +       .retval = 1,
> +},
> +{
> +       "direct map access, write test 2",
> +       .insns = {
> +       BPF_MOV64_IMM(BPF_REG_0, 1),
> +       BPF_LD_MAP_VALUE(BPF_REG_1, 0, 0, 8),
> +       BPF_ST_MEM(BPF_DW, BPF_REG_1, 0, 4242),
> +       BPF_EXIT_INSN(),
> +       },
> +       .fixup_map_array_48b = { 1 },
> +       .result = ACCEPT,
> +       .retval = 1,
> +},
> +{
> +       "direct map access, write test 3",
> +       .insns = {
> +       BPF_MOV64_IMM(BPF_REG_0, 1),
> +       BPF_LD_MAP_VALUE(BPF_REG_1, 0, 0, 8),
> +       BPF_ST_MEM(BPF_DW, BPF_REG_1, 8, 4242),
> +       BPF_EXIT_INSN(),
> +       },
> +       .fixup_map_array_48b = { 1 },
> +       .result = ACCEPT,
> +       .retval = 1,
> +},
> +{
> +       "direct map access, write test 4",
> +       .insns = {
> +       BPF_MOV64_IMM(BPF_REG_0, 1),
> +       BPF_LD_MAP_VALUE(BPF_REG_1, 0, 0, 40),
> +       BPF_ST_MEM(BPF_DW, BPF_REG_1, 0, 4242),
> +       BPF_EXIT_INSN(),
> +       },
> +       .fixup_map_array_48b = { 1 },
> +       .result = ACCEPT,
> +       .retval = 1,
> +},
> +{
> +       "direct map access, write test 5",
> +       .insns = {
> +       BPF_MOV64_IMM(BPF_REG_0, 1),
> +       BPF_LD_MAP_VALUE(BPF_REG_1, 0, 0, 32),
> +       BPF_ST_MEM(BPF_DW, BPF_REG_1, 8, 4242),
> +       BPF_EXIT_INSN(),
> +       },
> +       .fixup_map_array_48b = { 1 },
> +       .result = ACCEPT,
> +       .retval = 1,
> +},
> +{
> +       "direct map access, write test 6",
> +       .insns = {
> +       BPF_MOV64_IMM(BPF_REG_0, 1),
> +       BPF_LD_MAP_VALUE(BPF_REG_1, 0, 0, 40),
> +       BPF_ST_MEM(BPF_DW, BPF_REG_1, 4, 4242),
> +       BPF_EXIT_INSN(),
> +       },
> +       .fixup_map_array_48b = { 1 },
> +       .result = REJECT,
> +       .errstr = "R1 min value is outside of the array range",
> +},
> +{
> +       "direct map access, write test 7",
> +       .insns = {
> +       BPF_MOV64_IMM(BPF_REG_0, 1),
> +       BPF_LD_MAP_VALUE(BPF_REG_1, 0, 0, -1),
> +       BPF_ST_MEM(BPF_DW, BPF_REG_1, 4, 4242),
> +       BPF_EXIT_INSN(),
> +       },
> +       .fixup_map_array_48b = { 1 },
> +       .result = REJECT,
> +       .errstr = "direct value offset of 4294967295 is not allowed",
> +},
> +{
> +       "direct map access, write test 8",
> +       .insns = {
> +       BPF_MOV64_IMM(BPF_REG_0, 1),
> +       BPF_LD_MAP_VALUE(BPF_REG_1, 0, 0, 1),
> +       BPF_ST_MEM(BPF_DW, BPF_REG_1, -1, 4242),
> +       BPF_EXIT_INSN(),
> +       },
> +       .fixup_map_array_48b = { 1 },
> +       .result = ACCEPT,
> +       .retval = 1,
> +},
> +{
> +       "direct map access, write test 9",
> +       .insns = {
> +       BPF_MOV64_IMM(BPF_REG_0, 1),
> +       BPF_LD_MAP_VALUE(BPF_REG_1, 0, 0, 48),
> +       BPF_ST_MEM(BPF_DW, BPF_REG_1, 0, 4242),
> +       BPF_EXIT_INSN(),
> +       },
> +       .fixup_map_array_48b = { 1 },
> +       .result = REJECT,
> +       .errstr = "invalid access to map value pointer",
> +},
> +{
> +       "direct map access, write test 10",
> +       .insns = {
> +       BPF_MOV64_IMM(BPF_REG_0, 1),
> +       BPF_LD_MAP_VALUE(BPF_REG_1, 0, 0, 47),
> +       BPF_ST_MEM(BPF_B, BPF_REG_1, 0, 4),
> +       BPF_EXIT_INSN(),
> +       },
> +       .fixup_map_array_48b = { 1 },
> +       .result = ACCEPT,
> +       .retval = 1,
> +},
> +{
> +       "direct map access, write test 11",
> +       .insns = {
> +       BPF_MOV64_IMM(BPF_REG_0, 1),
> +       BPF_LD_MAP_VALUE(BPF_REG_1, 0, 0, 48),
> +       BPF_ST_MEM(BPF_B, BPF_REG_1, 0, 4),
> +       BPF_EXIT_INSN(),
> +       },
> +       .fixup_map_array_48b = { 1 },
> +       .result = REJECT,
> +       .errstr = "invalid access to map value pointer",
> +},
> +{
> +       "direct map access, write test 12",
> +       .insns = {
> +       BPF_MOV64_IMM(BPF_REG_0, 1),
> +       BPF_LD_MAP_VALUE(BPF_REG_1, 0, 0, (1<<29)),
> +       BPF_ST_MEM(BPF_B, BPF_REG_1, 0, 4),
> +       BPF_EXIT_INSN(),
> +       },
> +       .fixup_map_array_48b = { 1 },
> +       .result = REJECT,
> +       .errstr = "direct value offset of 536870912 is not allowed",
> +},
> +{
> +       "direct map access, write test 13",
> +       .insns = {
> +       BPF_MOV64_IMM(BPF_REG_0, 1),
> +       BPF_LD_MAP_VALUE(BPF_REG_1, 0, 0, (1<<29)-1),
> +       BPF_ST_MEM(BPF_B, BPF_REG_1, 0, 4),
> +       BPF_EXIT_INSN(),
> +       },
> +       .fixup_map_array_48b = { 1 },
> +       .result = REJECT,
> +       .errstr = "invalid access to map value pointer, value_size=48 index=0 off=536870911",
> +},
> +{
> +       "direct map access, write test 14",
> +       .insns = {
> +       BPF_MOV64_IMM(BPF_REG_0, 1),
> +       BPF_LD_MAP_VALUE(BPF_REG_1, 0, 0, 47),
> +       BPF_LD_MAP_VALUE(BPF_REG_2, 0, 0, 46),
> +       BPF_ST_MEM(BPF_H, BPF_REG_2, 0, 0xffff),
> +       BPF_LDX_MEM(BPF_B, BPF_REG_0, BPF_REG_1, 0),
> +       BPF_EXIT_INSN(),
> +       },
> +       .fixup_map_array_48b = { 1, 3 },
> +       .result = ACCEPT,
> +       .retval = 0xff,
> +},
> +{
> +       "direct map access, write test 15",
> +       .insns = {
> +       BPF_MOV64_IMM(BPF_REG_0, 1),
> +       BPF_LD_MAP_VALUE(BPF_REG_1, 0, 1, 47),
> +       BPF_LD_MAP_VALUE(BPF_REG_2, 0, 1, 46),
> +       BPF_ST_MEM(BPF_H, BPF_REG_2, 0, 0xffff),
> +       BPF_LDX_MEM(BPF_B, BPF_REG_0, BPF_REG_1, 0),
> +       BPF_EXIT_INSN(),
> +       },
> +       .fixup_map_array_48b = { 1, 3 },
> +       .result = ACCEPT,
> +       .retval = 0xff,
> +},
> +{
> +       "direct map access, write test 16",
> +       .insns = {
> +       BPF_MOV64_IMM(BPF_REG_0, 1),
> +       BPF_LD_MAP_VALUE(BPF_REG_1, 0, 1, 46),
> +       BPF_LD_MAP_VALUE(BPF_REG_2, 0, 0, 46),
> +       BPF_ST_MEM(BPF_H, BPF_REG_2, 0, 0xffff),
> +       BPF_LDX_MEM(BPF_H, BPF_REG_0, BPF_REG_1, 0),
> +       BPF_EXIT_INSN(),
> +       },
> +       .fixup_map_array_48b = { 1, 3 },
> +       .result = ACCEPT,
> +       .retval = 0,
> +},
> +{
> +       "direct map access, write test 17",
> +       .insns = {
> +       BPF_MOV64_IMM(BPF_REG_0, 1),
> +       BPF_LD_MAP_VALUE(BPF_REG_1, 0, 1, 46),
> +       BPF_LD_MAP_VALUE(BPF_REG_2, 0, 2, 46),
> +       BPF_ST_MEM(BPF_H, BPF_REG_2, 0, 0xffff),
> +       BPF_LDX_MEM(BPF_H, BPF_REG_0, BPF_REG_1, 0),
> +       BPF_EXIT_INSN(),
> +       },
> +       .fixup_map_array_48b = { 1, 3 },
> +       .result = REJECT,
> +       .errstr = "invalid access to map value pointer, value_size=48 index=2 off=46",
> +},
> +{
> +       "direct map access, write test 18",
> +       .insns = {
> +       BPF_MOV64_IMM(BPF_REG_0, 1),
> +       BPF_LD_MAP_VALUE(BPF_REG_1, 0, ~0, 46),
> +       BPF_LD_MAP_VALUE(BPF_REG_2, 0, ~0, 46),
> +       BPF_ST_MEM(BPF_H, BPF_REG_2, 0, 0xffff),
> +       BPF_LDX_MEM(BPF_H, BPF_REG_0, BPF_REG_1, 0),
> +       BPF_EXIT_INSN(),
> +       },
> +       .fixup_map_array_48b = { 1, 3 },
> +       .result = REJECT,
> +       .errstr = "invalid access to map value pointer, value_size=48 index=4294967295 off=46",
> +},
> --
> 2.17.1
>
