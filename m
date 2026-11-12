Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794498834;
	b=3oy8Ltqf3YLcJfGncrEzwluYAQhu6+tK56jmD5T70mn/IxNpgvVK36U2cbvSQtPez9iZ
	 m/w+Kqw7yJkoYREtqRNrUdlmJBft09PbB7BL3wpz4Z2/A1w7Bkof2+bC0BgxdNwC2fVVo
	 4OSOE6dzRzJNy6IkUBVz/ostu8VhPsE/e3ig/4pPokYjjhaq9P8U5wbyvicu8kEcFJiv2
	 /X56Ky1R5iqV9eJaQ0iSkOvEEMBvxCraUxQwRH3pRKkwJH/O5K6lXGX6Ga6GccUaygL/s
	 54AUU7fAPQHGhUy5621X1ibdGc2VKlP9yhWW6OsVpzjgjkz8kIQVobV1UNdSmW1AoGQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794498834;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ajZlV/lVuLUAK33ALtOUYW3npnVcgo27KI3wSmCO5jc=;
	b=akXrOO3pHxhzEBmpKMGzwNm8UxKUCynAR2+n/sXQfzMoj2APLXtuC1iqqylZ+xm4iKv+
	 XzGzwNDEMMUZvawfdmdBkvtUNZIBYCajZOTOiLKVY54lLZCOSbrcKbo+Uva0snQbTRclc
	 duy2lARS4Ay/8XaAtjZbHSbPKeNUiYvPYkjDdStX8MhcIKU4uLSlmyDXA7S7fbOURq5Og
	 f2Dr0cmfx5ROpTGErdRvzE81gLUS02um/ikIFdvY6y4Uyk4BCAHdiIWLqxFQ0/xrMlflF
	 waRNEN1DBGcPfiPhq/XjDVbpEAE5q3xAusP2f2Z67CDU0tLGZ2loKRgtRYW74B5xhBQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="AbocOJi/";
	arc=none smtp.remote-ip=209.85.216.50
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A527F606A32D
	for <bpf@vger.kernel.org>; Thu, 12 Nov 2026 15:53:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A527F606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AbocOJi/
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3b0b3754f57so2641395a91.0
        for <bpf@vger.kernel.org>; Thu, 12 Nov 2026 07:53:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794498833; x=1795103633; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ajZlV/lVuLUAK33ALtOUYW3npnVcgo27KI3wSmCO5jc=;
        b=AbocOJi/kGHQzLaSyihviGisR42Vr8lBgCRax4g6b8K/cwaZoaOgu+f6tfCvywu/YY
         Wcrw/fCDioenCrdv8jEro9cGcj2VIfT5Y4n06NsbOTgbGDqxwSWTFoycNPVFZuaEjNBN
         HxlGhRf3JhuJHmqvw3JQdJu9slxbup26ATb23CKynbcgwQb3aAajdON4OiORIFVOEDic
         CiB+PmQRZeh4mqrUC/4w7eCCq1bLlhODoKnMNPdtvo9RtBTmRHW+a1LCaA5Mn/IXkDt1
         D4ISCu6ReQL23Qoe2MLz6mzl6tZfqc3UqGN8oj40Fr5GhGZ457jmZ0AwE2d0hyDhTl2R
         39eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794498833; x=1795103633;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ajZlV/lVuLUAK33ALtOUYW3npnVcgo27KI3wSmCO5jc=;
        b=O7snd5XYXOPEi7C39aqBRJyDHhqdHsu5dOxjVQWZDLxFWtvPFMcvge+gfNt7e/iJo5
         hJjmTfTiMBSCwXcoW54v1AlljmIJgOrgmoB8mFa4M+Ai+1wpHGZ/FlI5vAgUoD1gPnRX
         18evAMCwtGwcvb2dRpHhSD7bDihgElcUoZEYIi87xUiYgpwiCYA7KEJke8S111oP4TYm
         ibCSx5aZe2rm/OvnNjXAZedA2pAdoZWNwORym3Eo0/6BznA15C5jLRn/WbI//jvTSZ+G
         nf2b2soUQgSCLU5mDvuTrSac/C6TIs8gPugovlOTkbynSVSkXjEPBCVZ7a2u3jxa1mV/
         svPw==
X-Gm-Message-State: APuU4Z9DTXid+NSLsvHRK6k3dqNqU+s9yH2fBbGdYxtlbTfrDJcrKPOm
	+H2YljnU3DVJ6ZgPAlwBH4pDYwPz8CcRAR3M/XPopgfmdkgXCUh1t+u+vf9dNQ==
X-Gm-Gg: AYBFou0DEWL7t9IBPFn0yBaPftPkVXNrBpn6RQIA9PBx+53WHnS/DXKhDZe6JKRPqYv
	jbqoBgi4uq9b/lIT0BGRPGwEL9XWcNl/5rA1JAMCbbIU8ubQUwmFNY4GpjUOwqJYOqKxtWnrHks
	HZ717BLG8aIBx0VjnaJ6jwDZJigSjrCU0hL94FKwzw3QoeGzJuMhVvnaY/rqLE6RjO5On8yFfim
	7PfN0jyv1gGvdPtijCHVvLk3/kINkKTm37fdpr+FIC0OQnsxtprY5tQQqy3cDJpsqi8BcQOaDfX
	ryvBF6yCJX0pub0C7SHB7VpkfFAAIYIC9dFPkOgN9qxa3E5SedlKT+UdAKBL/av0Nf1RwY38nxr
	/LcALDkpSbR3wxNLjZBwPYmeef/HWopC2BDYkH/VzyP3R4S0Rf/UUXiYXWeUliV96Kmucp/paYQ
	cVOljK4uA3cvQcubCXd5B5dXlQqXhGQNdjr1TwJHnoi4QMCU2D4QsH/yt2LMAMegdtF2eJILhzp
	iMG8K60iRCTy5ItunsJ8i3JP6QM/qhe8kuQ52G338cxqk9a9PNBEDVlMgpT5lPXDyf6w9di0sxq
	ecbSr7Xyi0VonLeTINeZrtCKg8Zt5pNoXf5vj5636NmQ9eykaJEIdbf+NFhGdpmxn3czn9D/c2+
	9m5XcBn/h/wBipPud5wDbPplVEPhYaU5t5NOAH2kTJrReROEQGwXD5AkSYe3FM4DS+u8Q+KwRTA
	==
X-Received: by 2002:a17:90b:3fcb:b0:3b0:a7e7:68f5 with SMTP id 98e67ed59e1d1-3b182dea8a5mr5718233a91.7.1794498832671;
        Thu, 12 Nov 2026 07:53:52 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.242])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cdd8d697799sm3017225a12.16.2026.11.12.07.53.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 07:53:52 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 02/12] selftests/bpf: Test spilled pointers that only bytewise reads can reach
Date: Thu, 12 Nov 2026 15:53:27 +0000
Message-ID: <20261112155337.1040699-3-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261112155337.1040699-1-alexei.starovoitov@gmail.com>
References: <20261112155337.1040699-1-alexei.starovoitov@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

Two paths spill different pointers to one slot and meet. The states are
equal if only these reads can reach the slot: a load of a byte in a subprog
at an offset that the liveness pass does not know, and a helper that reads
memory. A load of 4 bytes from the slot at an offset that only the main
pass knows reads unknown bytes. A byte of the slot is an unknown number:
a prog that takes it for an index into the stack is rejected.

Without CAP_PERFMON the pointer stays: the helper and the load of 4 bytes
are rejected. The pointer stays for callx too: the callee fills it.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 .../selftests/bpf/progs/verifier_live_stack.c | 143 ++++++++++++++++++
 1 file changed, 143 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_live_stack.c b/tools/testing/selftests/bpf/progs/verifier_live_stack.c
index d6a6420d219d..2d31868bcfdb 100644
--- a/tools/testing/selftests/bpf/progs/verifier_live_stack.c
+++ b/tools/testing/selftests/bpf/progs/verifier_live_stack.c
@@ -1396,6 +1396,149 @@ __naked void dead_spill_at_merge_enables_pruning(void)
 	: __clobber_all);
 }
 
+/*
+ * Two paths meet at insn 10. fp-8 holds a pointer to fp-16 on one of them and a pointer to fp-24
+ * on the other one: no join. r6 is in [0, 15].
+ */
+#define SPILL_ONE_OF_TWO_PTRS			\
+	"call %[bpf_get_prandom_u32];"		\
+	"r6 = r0;"				\
+	"r6 &= 15;"				\
+	"*(u64 *)(r10 - 16) = r6;"		\
+	"r7 = r10;"				\
+	"r7 += -16;"				\
+	"*(u64 *)(r10 - 8) = r7;"		\
+	"if r0 & 16 goto +2;"			\
+	"r7 += -8;"				\
+	"*(u64 *)(r10 - 8) = r7;"
+
+/* Liveness doesn't know the offset of the load. A byte doesn't tell the pointers apart. */
+SEC("socket")
+__success
+__log_level(2)
+__msg("from 9 to 10: within")
+__naked void byte_load_in_subprog_keeps_no_spilled_ptr(void)
+{
+	asm volatile (
+	SPILL_ONE_OF_TWO_PTRS
+	"r1 = r10;"
+	"r1 += -16;"
+	"r2 = r6;"
+	"call load_byte;"
+	"exit;"
+	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+static __used __naked void load_byte(void)
+{
+	asm volatile (
+	"r1 += r2;"
+	"r0 = *(u8 *)(r1 + 0);"
+	"exit;"
+	::: __clobber_all);
+}
+
+/* The bytes of a pointer that was replaced are not known: r0 is in [0, 255]. */
+SEC("socket")
+__failure
+__msg("invalid variable-offset read from stack R1")
+__naked void byte_of_replaced_ptr_is_unknown(void)
+{
+	asm volatile (
+	SPILL_ONE_OF_TWO_PTRS
+	"r6 &= 7;"
+	"r1 = r10;"
+	"r1 += -8;"
+	"r1 += r6;"
+	"r0 = *(u8 *)(r1 + 0);"
+	"r1 = r10;"
+	"r1 += -1;"
+	"r1 += r0;"
+	"r0 = *(u8 *)(r1 + 0);"
+	"exit;"
+	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+/* A helper reads memory. Without CAP_PERFMON it must not find a pointer there. */
+SEC("socket")
+__success
+__log_level(2)
+__msg("from 9 to 10: within")
+__failure_unpriv
+__msg_unpriv("invalid read from stack R3 off -8+0 size 8")
+__naked void helper_keeps_no_spilled_ptr(void)
+{
+	asm volatile (
+	SPILL_ONE_OF_TWO_PTRS
+	"r1 = %[map] ll;"
+	"r2 = r10;"
+	"r2 += -16;"
+	"r3 = r10;"
+	"r3 += -8;"
+	"r4 = 0;"
+	"call %[bpf_map_update_elem];"
+	"r0 = 0;"
+	"exit;"
+	:
+	: __imm(bpf_get_prandom_u32),
+	  __imm(bpf_map_update_elem),
+	  __imm_addr(map)
+	: __clobber_all);
+}
+
+#ifdef CAN_USE_CALLX
+static __used __naked void load_ptr(void)
+{
+	asm volatile (
+	"r1 = *(u64 *)(r1 + 0);"
+	"r0 = *(u64 *)(r1 + 0);"
+	"exit;"
+	::: __clobber_all);
+}
+
+/* Liveness doesn't know the callee, which fills the pointer. */
+SEC("socket")
+__success
+__load_if_JITed()
+__naked void callx_keeps_spilled_ptr(void)
+{
+	asm volatile (
+	SPILL_ONE_OF_TWO_PTRS
+	"r1 = r10;"
+	"r1 += -8;"
+	"r2 = %[load_ptr] ll;"
+	"callx r2;"
+	"exit;"
+	:
+	: __imm(bpf_get_prandom_u32),
+	  __imm_addr(load_ptr)
+	: __clobber_all);
+}
+#endif /* CAN_USE_CALLX */
+
+/* Only the main pass knows the offset of the load. The pointer was replaced at insn 10. */
+SEC("socket")
+__success
+__failure_unpriv __msg_unpriv("invalid size of register fill")
+__naked void short_load_at_lost_offset_keeps_no_spilled_ptr(void)
+{
+	asm volatile (
+	SPILL_ONE_OF_TWO_PTRS
+	"r2 = 8;"
+	"r1 = r10;"
+	"r1 += -16;"
+	"r1 += r2;"
+	"r0 = *(u32 *)(r1 + 0);"
+	"exit;"
+	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
 /*
  * FP-offset tracking loses precision on second ADD, killing all liveness.
  *
-- 
2.55.0

