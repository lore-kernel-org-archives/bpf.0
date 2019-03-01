Return-Path: <SRS0=adOE=RE=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD94AC10F00
	for <bpf@archiver.kernel.org>; Fri,  1 Mar 2019 01:37:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 925E3218AE
	for <bpf@archiver.kernel.org>; Fri,  1 Mar 2019 01:37:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="jVixvy9P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731008AbfCABhY (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 28 Feb 2019 20:37:24 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:55316 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387418AbfCABhX (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 28 Feb 2019 20:37:23 -0500
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x211SLdf000686
        for <bpf@vger.kernel.org>; Thu, 28 Feb 2019 17:37:22 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=CfykuYPFs5oLn6IPMSmiIuKJIh3DLTfa/OskSKjn7eY=;
 b=jVixvy9PaE/+QJyjZh2GLBATKK2RDGIPsr+H906PsYyJehKEM5SMBBS0KNE1ZCFf8scA
 Ga8dcWXq8NzVgu4aq2HCZIH+9+/t+OMPCXZrY+lB/7E03lJkRKNy/CBeWAZlIgUKmDIZ
 fxjbkbutOt57YHWE5CMzBIc7mR+4LU0UAcQ= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2qxr150m6w-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 28 Feb 2019 17:37:22 -0800
Received: from mx-out.facebook.com (2620:10d:c0a1:3::13) by
 mail.thefacebook.com (2620:10d:c021:18::173) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Thu, 28 Feb 2019 17:37:20 -0800
Received: by devvm7221.prn2.facebook.com (Postfix, from userid 137359)
        id 38628C16CA37; Thu, 28 Feb 2019 17:37:19 -0800 (PST)
Smtp-Origin-Hostprefix: devvm
From:   Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Hostname: devvm7221.prn2.facebook.com
To:     <andrii.nakryiko@gmail.com>, <ast@fb.com>, <yhs@fb.com>,
        <netdev@vger.kernel.org>, <bpf@vger.kernel.org>,
        <daniel@iogearbox.net>, <songliubraving@fb.com>
CC:     Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH bpf-next 3/4] bpf/verifier: typo fixes and reflow verifier overview comment
Date:   Thu, 28 Feb 2019 17:37:15 -0800
Message-ID: <20190301013716.1370014-4-andriin@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190301013716.1370014-1-andriin@fb.com>
References: <20190301013716.1370014-1-andriin@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-01_01:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Fix few typos and reflow text in long high-level verifier comment.

Signed-off-by: Andrii Nakryiko <andriin@fb.com>
---
 kernel/bpf/verifier.c | 94 +++++++++++++++++++++----------------------
 1 file changed, 47 insertions(+), 47 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index c09ec3222d13..c6911ede94af 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -39,9 +39,9 @@ static const struct bpf_verifier_ops * const bpf_verifier_ops[] = {
 #undef BPF_MAP_TYPE
 };
 
-/* bpf_check() is a static code analyzer that walks eBPF program
- * instruction by instruction and updates register/stack state.
- * All paths of conditional branches are analyzed until 'bpf_exit' insn.
+/* bpf_check() is a static code analyzer that walks eBPF program instruction by
+ * instruction and updates register/stack state. All paths of conditional
+ * branches are analyzed until 'bpf_exit' insn.
  *
  * The first pass is depth-first-search to check that the program is a DAG.
  * It rejects the following programs:
@@ -49,15 +49,15 @@ static const struct bpf_verifier_ops * const bpf_verifier_ops[] = {
  * - if loop is present (detected via back-edge)
  * - unreachable insns exist (shouldn't be a forest. program = one function)
  * - out of bounds or malformed jumps
- * The second pass is all possible path descent from the 1st insn.
- * Since it's analyzing all pathes through the program, the length of the
- * analysis is limited to 64k insn, which may be hit even if total number of
- * insn is less then 4K, but there are too many branches that change stack/regs.
- * Number of 'branches to be analyzed' is limited to 1k
+ * The second pass is all possible path descent from the 1st insn. Since it's
+ * analyzing all pathes through the program, the length of the analysis is
+ * limited to 64k insn, which may be hit even if total number of insn is less
+ * than 4K, but there are too many branches that change stack/regs. Number of
+ * 'branches to be analyzed' is limited to 1k.
  *
  * On entry to each instruction, each register has a type, and the instruction
- * changes the types of the registers depending on instruction semantics.
- * If instruction is BPF_MOV64_REG(BPF_REG_1, BPF_REG_5), then type of R5 is
+ * changes the types of the registers depending on instruction semantics. If
+ * instruction is BPF_MOV64_REG(BPF_REG_1, BPF_REG_5), then type of R5 is
  * copied to R1.
  *
  * All registers are 64-bit.
@@ -66,37 +66,36 @@ static const struct bpf_verifier_ops * const bpf_verifier_ops[] = {
  * R6-R9 callee saved registers
  * R10 - frame pointer read-only
  *
- * At the start of BPF program the register R1 contains a pointer to bpf_context
- * and has type PTR_TO_CTX.
+ * At the start of BPF program the register R1 contains a pointer to
+ * bpf_context and has type PTR_TO_CTX.
  *
  * Verifier tracks arithmetic operations on pointers in case:
  *    BPF_MOV64_REG(BPF_REG_1, BPF_REG_10),
  *    BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, -20),
- * 1st insn copies R10 (which has FRAME_PTR) type into R1
- * and 2nd arithmetic instruction is pattern matched to recognize
- * that it wants to construct a pointer to some element within stack.
- * So after 2nd insn, the register R1 has type PTR_TO_STACK
- * (and -20 constant is saved for further stack bounds checking).
- * Meaning that this reg is a pointer to stack plus known immediate constant.
+ * 1st insn copies R10 (which has FRAME_PTR) type into R1 and 2nd arithmetic
+ * instruction is pattern matched to recognize that it wants to construct
+ * a pointer to some element within stack. So after 2nd insn, the register R1
+ * has type PTR_TO_STACK (and -20 constant is saved for further stack bounds
+ * checking). Meaning that this reg is a pointer to stack plus known immediate
+ * constant.
  *
- * Most of the time the registers have SCALAR_VALUE type, which
- * means the register has some value, but it's not a valid pointer.
- * (like pointer plus pointer becomes SCALAR_VALUE type)
+ * Most of the time the registers have SCALAR_VALUE type, which means the
+ * register has some value, but it's not a valid pointer (like pointer plus
+ * pointer becomes SCALAR_VALUE type).
  *
- * When verifier sees load or store instructions the type of base register
- * can be: PTR_TO_MAP_VALUE, PTR_TO_CTX, PTR_TO_STACK, PTR_TO_SOCKET. These are
+ * When verifier sees load or store instructions the type of base register can
+ * be: PTR_TO_MAP_VALUE, PTR_TO_CTX, PTR_TO_STACK, PTR_TO_SOCKET. These are
  * four pointer types recognized by check_mem_access() function.
  *
  * PTR_TO_MAP_VALUE means that this register is pointing to 'map element value'
  * and the range of [ptr, ptr + map's value_size) is accessible.
  *
- * registers used to pass values to function calls are checked against
+ * Registers used to pass values to function calls are checked against
  * function argument constraints.
  *
- * ARG_PTR_TO_MAP_KEY is one of such argument constraints.
- * It means that the register type passed to this function must be
- * PTR_TO_STACK and it will be used inside the function as
- * 'pointer to map element key'
+ * ARG_PTR_TO_MAP_KEY is one of such argument constraints. It means that the
+ * register type passed to this function must be PTR_TO_STACK and it will be
+ * used inside the function as 'pointer to map element key'
  *
  * For example the argument constraints for bpf_map_lookup_elem():
  *   .ret_type = RET_PTR_TO_MAP_VALUE_OR_NULL,
@@ -105,8 +104,8 @@ static const struct bpf_verifier_ops * const bpf_verifier_ops[] = {
  *
  * ret_type says that this function returns 'pointer to map elem value or null'
  * function expects 1st argument to be a const pointer to 'struct bpf_map' and
- * 2nd argument should be a pointer to stack, which will be used inside
- * the helper function as a pointer to map element key.
+ * 2nd argument should be a pointer to stack, which will be used inside the
+ * helper function as a pointer to map element key.
  *
  * On the kernel side the helper function looks like:
  * u64 bpf_map_lookup_elem(u64 r1, u64 r2, u64 r3, u64 r4, u64 r5)
@@ -115,9 +114,9 @@ static const struct bpf_verifier_ops * const bpf_verifier_ops[] = {
  *    void *key = (void *) (unsigned long) r2;
  *    void *value;
  *
- *    here kernel can access 'key' and 'map' pointers safely, knowing that
- *    [key, key + map->key_size) bytes are valid and were initialized on
- *    the stack of eBPF program.
+ *    Here kernel can access 'key' and 'map' pointers safely, knowing that
+ *    [key, key + map->key_size) bytes are valid and were initialized on the
+ *    stack of eBPF program.
  * }
  *
  * Corresponding eBPF program may look like:
@@ -126,21 +125,21 @@ static const struct bpf_verifier_ops * const bpf_verifier_ops[] = {
  *    BPF_LD_MAP_FD(BPF_REG_1, map_fd),      // after this insn R1 type is CONST_PTR_TO_MAP
  *    BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
  * here verifier looks at prototype of map_lookup_elem() and sees:
- * .arg1_type == ARG_CONST_MAP_PTR and R1->type == CONST_PTR_TO_MAP, which is ok,
- * Now verifier knows that this map has key of R1->map_ptr->key_size bytes
+ * .arg1_type == ARG_CONST_MAP_PTR and R1->type == CONST_PTR_TO_MAP, which is
+ * ok. Now verifier knows that this map has key of R1->map_ptr->key_size bytes.
  *
- * Then .arg2_type == ARG_PTR_TO_MAP_KEY and R2->type == PTR_TO_STACK, ok so far,
- * Now verifier checks that [R2, R2 + map's key_size) are within stack limits
- * and were initialized prior to this call.
- * If it's ok, then verifier allows this BPF_CALL insn and looks at
- * .ret_type which is RET_PTR_TO_MAP_VALUE_OR_NULL, so it sets
- * R0->type = PTR_TO_MAP_VALUE_OR_NULL which means bpf_map_lookup_elem() function
- * returns ether pointer to map value or NULL.
+ * Then .arg2_type == ARG_PTR_TO_MAP_KEY and R2->type == PTR_TO_STACK, ok so
+ * far. Now verifier checks that [R2, R2 + map's key_size) are within stack
+ * limits and were initialized prior to this call. If it's ok, then verifier
+ * allows this BPF_CALL insn and looks at .ret_type which is
+ * RET_PTR_TO_MAP_VALUE_OR_NULL, so it sets R0->type = PTR_TO_MAP_VALUE_OR_NULL
+ * which means bpf_map_lookup_elem() function returns either pointer to a map
+ * value or NULL.
  *
  * When type PTR_TO_MAP_VALUE_OR_NULL passes through 'if (reg != 0) goto +off'
  * insn, the register holding that pointer in the true branch changes state to
- * PTR_TO_MAP_VALUE and the same register changes state to CONST_IMM in the false
- * branch. See check_cond_jmp_op().
+ * PTR_TO_MAP_VALUE and the same register changes state to CONST_IMM in the
+ * false branch. See check_cond_jmp_op().
  *
  * After the call R0 is set to return type of the function and registers R1-R5
  * are set to NOT_INIT to indicate that they are no longer readable.
@@ -148,10 +147,11 @@ static const struct bpf_verifier_ops * const bpf_verifier_ops[] = {
  * The following reference types represent a potential reference to a kernel
  * resource which, after first being allocated, must be checked and freed by
  * the BPF program:
- * - PTR_TO_SOCKET_OR_NULL, PTR_TO_SOCKET
+ * - PTR_TO_SOCKET_OR_NULL
+ * - PTR_TO_SOCKET
  *
- * When the verifier sees a helper call return a reference type, it allocates a
- * pointer id for the reference and stores it in the current function state.
+ * When the verifier sees a helper call return a reference type, it allocates
+ * a pointer id for the reference and stores it in the current function state.
  * Similar to the way that PTR_TO_MAP_VALUE_OR_NULL is converted into
  * PTR_TO_MAP_VALUE, PTR_TO_SOCKET_OR_NULL becomes PTR_TO_SOCKET when the type
  * passes through a NULL-check conditional. For the branch wherein the state is
-- 
2.17.1

