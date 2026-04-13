Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFEAA397E6D
	for <bpf@vger.kernel.org>; Mon, 13 Apr 2026 21:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776117499; cv=none; b=TlxtB1hFSe2Grt2oZpMyKk0PsxvLvIV8OeuKEzR73NGIYFywsjay65FfSivxPhHi/chctIEfbWHDKDI30Foj/8jfs5e7IQT6f4Wsav7rYbuggq3SyEDYRiwYgPY7Ia3jXhoj+uHk4DhRQD/MuKhG8rCdtYTse2gWxeDBS2J1wEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776117499; c=relaxed/simple;
	bh=h18i0Avw7kbBAyqSEPEDvoVx/UnEXeymvi+CwH6NTxs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nz0BwHgFwH0wsVWehguMrhwC95SK62Y85INMsQyKuBmN6ufbo46tJqgqiklsQT5x4amemJUxC+nJ9lQjYIIOjML8nYhzDmSVUX/+bO4OvU0xzBExn1jqC/+w/Y8DX6kiI0QqOny7WVHC1QZTn/E9fUbg62UOWXvkObhbgVGBQtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j0r8Dk9r; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j0r8Dk9r"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2b461310af5so5612345ad.1
        for <bpf@vger.kernel.org>; Mon, 13 Apr 2026 14:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776117497; x=1776722297; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jZUNiqLjCMOpcMhy14RLNpm9rZ3XLPzi9jwrbH9eFgY=;
        b=j0r8Dk9rvuj5/k+0wiU5u7sAMaaon9P9sYt4iUomv+HZB4X3CWc2wRbYQK2QYY6PJ/
         N+d1VudH6BENZ6MsSn+ABBG4rL777Phews+aUM4uDL1H5xXBtTqvscPHcM+4lXmgpBLP
         3jruRB/CxKfrxQph3vv6O70eEyq89fPDSI13PViifIr0Mi1QThlPeLwXC+vucHvOETyw
         H4JCAS+hTOZhyO3XrmVygySN1nk6w6R89H+6V6xSp69KXSz3/eHHZiPb2zQOjIAGtvO6
         LJPTo6ABRDD439ZeOu2VRq7Is4tjUuQQ83woVG9z/GrEERAxccsfyRZDtPwKi1fEdHCy
         /53A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776117497; x=1776722297;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jZUNiqLjCMOpcMhy14RLNpm9rZ3XLPzi9jwrbH9eFgY=;
        b=P53xGmxf2GGd83iRISOB2oDafOLu8C/0TXXeFPy2X24CNzKwPL/peUT8k+o7Pf0ftw
         iQqjvOsOEwSOS6mC1/yyMAwhswgeo8RXALie8gu/tTUs7ZMhZJS/zUqoCUUmz6RUASrb
         X3+hbDRNmjS+EUC6rG1enLa+MLXcQcvxC7oFLiJYvMYSvParuNYp+hE1AsBVM85cTzzh
         j7oCPxyGHLybUjLi/iPoDNQkAkbNPvX9oa7wqvYKAOaTUj0utUlVqi26XPtJL0wlac0D
         i1kAeJWtc65cbGKkwOUOZt8G7PnetPkbxsxhiBIYqgiNVOwmpwA9GQParHrW7X9BSQEu
         f0hQ==
X-Gm-Message-State: AOJu0Yy6Y91uRzvteDNqycTnOWtzlpf+WZJ4Z/Bix7JnT10ftfwURUS9
	CBYLMdLel2eO5onNMk6WoG5c3hNYbMUb8UpZC52FqoT5tCFxe93PMpm0JkW7gQ==
X-Gm-Gg: AeBDiesa2h2ZnVNU0z52P8HxkB0yessZ7WymKImWEGmoSXZaA3Vp4vWTypicetK6gSX
	kW6EO62oQtahXAbS4yRp1LWK2lRX1oc+7QH67hYWxC3535MPrDBQBBdToTZWaJOxeh0hzjqo/v4
	wtGybO2M7L6nQdZ6sYoJ49y2zdeUGCLZSZ5rEentxqxg8bDHoOzFKFCtEF44Rm4D6xPXPPHnaSY
	3K+B+27qPspVOenGQjf/D8cRzJqdeH52zIRYjnpmM5310VGMOdcdffVDMkrkZGWBkQ6hfRxXFdi
	uX8e1NOsoA/U0og44pgARDWjCG5i1eqFC2povQsOSt4L2Kw3gQbH6i/bv8xAbie7IWJRDiX0ZB9
	jTyKPVTzpumIcfOsrSu7UZdvRbz6pQad09aEkreEGnoho/PPVyaf+gsniisYQPYWUdnwo9qIpqv
	2KgQ22hYznAbSzQI64tZs/uRh0mUtjuKSzGCctF7mUirm+8K+hDdMn3vKMlIp0NwiUbA8=
X-Received: by 2002:a17:903:120a:b0:2b2:6cab:3127 with SMTP id d9443c01a7336-2b2d5d7a278mr124314235ad.20.1776117496861;
        Mon, 13 Apr 2026 14:58:16 -0700 (PDT)
Received: from ezingerman-fedora-PF4V722J ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b45d1ab540sm62421215ad.40.2026.04.13.14.58.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 14:58:16 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com
Subject: [PATCH bpf-next v2 2/2] selftests/bpf: arg tracking for imprecise/multi-offset BPF_ST/STX
Date: Mon, 13 Apr 2026 14:58:03 -0700
Message-ID: <20260413-stacklive-fixes-v2-2-ff91c4f8d273@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413-stacklive-fixes-v2-0-ff91c4f8d273@gmail.com>
References: <20260413-stacklive-fixes-v2-0-ff91c4f8d273@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Add test cases for clear_stack_for_all_offs and dst_is_local_fp
handling of multi-offset and ARG_IMPRECISE stack pointers:

- st_imm_join_with_multi_off: BPF_ST through multi-offset dst should
  join at_stack with none instead of overwriting both candidate slots.
- st_imm_join_with_imprecise_off: BPF_ST through offset-imprecise dst
  should join at_stack with none instead of clearing all slots.
- st_imm_join_with_single_off: a canary checking that BPF_ST with a
  known offset overwrites slot instead of joining.
- imprecise_dst_spill_join: BPF_STX through ARG_IMPRECISE dst should
  be recognized as a local spill and join at_stack with the written
  value.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../selftests/bpf/progs/verifier_live_stack.c      | 194 +++++++++++++++++++++
 1 file changed, 194 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_live_stack.c b/tools/testing/selftests/bpf/progs/verifier_live_stack.c
index b7a9fa10e84d..536e214d0376 100644
--- a/tools/testing/selftests/bpf/progs/verifier_live_stack.c
+++ b/tools/testing/selftests/bpf/progs/verifier_live_stack.c
@@ -2647,3 +2647,197 @@ __naked void spill_join_with_imprecise_off(void)
 	"exit;"
 	::: __clobber_all);
 }
+
+/*
+ * Same as spill_join_with_multi_off but the write is BPF_ST (store
+ * immediate) instead of BPF_STX. BPF_ST goes through
+ * clear_stack_for_all_offs() rather than spill_to_stack(), and that
+ * path also needs to join instead of overwriting.
+ *
+ *   fp-8  = &fp-24
+ *   fp-16 = &fp-32
+ *   r1 = fp-8 or fp-16 (two offsets from branch)
+ *   *(u64 *)(r1 + 0) = 0        -- BPF_ST with immediate
+ *   r0 = *(u64 *)(r10 - 16)     -- fill from fp-16
+ *   r0 = *(u64 *)(r0 + 0)       -- deref: should produce use
+ */
+SEC("socket")
+__log_level(2)
+__failure
+__msg("15: (7a) *(u64 *)(r1 +0) = 0	fp-8: fp0-24 -> fp0-24|fp0+0	fp-16: fp0-32 -> fp0-32|fp0+0")
+__msg("17: (79) r0 = *(u64 *)(r0 +0)         ; use: fp0-32")
+__naked void st_imm_join_with_multi_off(void)
+{
+	asm volatile (
+	"*(u64 *)(r10 - 24) = 0;"
+	"*(u64 *)(r10 - 32) = 0;"
+	"r1 = r10;"
+	"r1 += -24;"
+	"*(u64 *)(r10 - 8) = r1;"
+	"r1 = r10;"
+	"r1 += -32;"
+	"*(u64 *)(r10 - 16) = r1;"
+	/* create r1 with two candidate offsets: fp-8 or fp-16 */
+	"call %[bpf_get_prandom_u32];"
+	"if r0 == 0 goto 1f;"
+	"r1 = r10;"
+	"r1 += -8;"
+	"goto 2f;"
+"1:"
+	"r1 = r10;"
+	"r1 += -16;"
+"2:"
+	/* BPF_ST: store immediate through multi-offset r1 */
+	"*(u64 *)(r1 + 0) = 0;"
+	/* read back fp-16 and deref */
+	"r0 = *(u64 *)(r10 - 16);"
+	"r0 = *(u64 *)(r0 + 0);"
+	"r0 = 0;"
+	"exit;"
+	:: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+/*
+ * Check that BPF_ST with a known offset fully overwrites stack slot
+ * from the arg tracking point of view.
+ */
+SEC("socket")
+__log_level(2)
+__success
+__msg("5: (7a) *(u64 *)(r1 +0) = 0	fp-8: fp0-16 -> _{{$}}")
+__naked void st_imm_join_with_single_off(void)
+{
+	asm volatile (
+	"r2 = r10;"
+	"r2 += -16;"
+	"*(u64 *)(r10 - 8) = r2;"
+	"r1 = r10;"
+	"r1 += -8;"
+	"*(u64 *)(r1 + 0) = 0;"
+	"r0 = 0;"
+	"exit;"
+	:: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+/*
+ * Same as spill_join_with_imprecise_off but the write is BPF_ST.
+ * Use "r2 = -8; r1 += r2" to make arg tracking lose offset
+ * precision while the main verifier keeps r1 as fixed-offset.
+ *
+ *   fp-8  = &fp-24
+ *   fp-16 = &fp-32
+ *   r1 = fp-8 (imprecise to arg tracking)
+ *   *(u64 *)(r1 + 0) = 0        -- BPF_ST with immediate
+ *   r0 = *(u64 *)(r10 - 16)     -- fill from fp-16
+ *   r0 = *(u64 *)(r0 + 0)       -- deref: should produce use
+ */
+SEC("socket")
+__log_level(2)
+__success
+__msg("13: (79) r0 = *(u64 *)(r0 +0)         ; use: fp0-32")
+__naked void st_imm_join_with_imprecise_off(void)
+{
+	asm volatile (
+	"*(u64 *)(r10 - 24) = 0;"
+	"*(u64 *)(r10 - 32) = 0;"
+	"r1 = r10;"
+	"r1 += -24;"
+	"*(u64 *)(r10 - 8) = r1;"
+	"r1 = r10;"
+	"r1 += -32;"
+	"*(u64 *)(r10 - 16) = r1;"
+	/* r1 = fp-8 but arg tracking sees off_cnt == 0 */
+	"r1 = r10;"
+	"r2 = -8;"
+	"r1 += r2;"
+	/* store immediate through imprecise r1 */
+	"*(u64 *)(r1 + 0) = 0;"
+	/* read back fp-16 */
+	"r0 = *(u64 *)(r10 - 16);"
+	/* deref: should produce use */
+	"r0 = *(u64 *)(r0 + 0);"
+	"r0 = 0;"
+	"exit;"
+	::: __clobber_all);
+}
+
+/*
+ * Test that spilling through an ARG_IMPRECISE pointer joins with
+ * existing at_stack values. Subprog receives r1 = fp0-24 and
+ * r2 = map_value, creates an ARG_IMPRECISE pointer by joining caller
+ * and callee FP on two branches.
+ *
+ * Setup: callee spills &fp1-16 to fp1-8 (precise, tracked).
+ * Then writes map_value through ARG_IMPRECISE r1 — on path A
+ * this hits fp1-8, on path B it hits caller stack.
+ * Since spill_to_stack is skipped for ARG_IMPRECISE dst,
+ * fp1-8 tracking isn't joined with none.
+ *
+ * Expected after the imprecise write:
+ * - arg tracking should show fp1-8 = fp1-16|fp1+0 (joined with none)
+ * - read from fp1-8 and deref should produce use for fp1-16
+ * - write through it should NOT produce def for fp1-16
+ */
+SEC("socket")
+__log_level(2)
+__success
+__msg("26: (79) r0 = *(u64 *)(r10 -8) // r1=IMP3 r6=fp0-24 r7=fp1-16 fp-8=fp1-16|fp1+0")
+__naked void imprecise_dst_spill_join(void)
+{
+	asm volatile (
+	"*(u64 *)(r10 - 24) = 0;"
+	/* map lookup for a valid non-FP pointer */
+	"*(u32 *)(r10 - 32) = 0;"
+	"r1 = %[map] ll;"
+	"r2 = r10;"
+	"r2 += -32;"
+	"call %[bpf_map_lookup_elem];"
+	"if r0 == 0 goto 1f;"
+	/* r1 = &caller_fp-24, r2 = map_value */
+	"r1 = r10;"
+	"r1 += -24;"
+	"r2 = r0;"
+	"call imprecise_dst_spill_join_sub;"
+"1:"
+	"r0 = 0;"
+	"exit;"
+	:: __imm_addr(map),
+	   __imm(bpf_map_lookup_elem)
+	: __clobber_all);
+}
+
+static __used __naked void imprecise_dst_spill_join_sub(void)
+{
+	asm volatile (
+	/* r6 = &caller_fp-24 (frame=0), r8 = map_value */
+	"r6 = r1;"
+	"r8 = r2;"
+	/* spill &fp1-16 to fp1-8: at_stack[0] = fp1-16 */
+	"*(u64 *)(r10 - 16) = 0;"
+	"r7 = r10;"
+	"r7 += -16;"
+	"*(u64 *)(r10 - 8) = r7;"
+	/* branch to create ARG_IMPRECISE pointer */
+	"call %[bpf_get_prandom_u32];"
+	/* path B: r1 = caller fp-24 (frame=0) */
+	"r1 = r6;"
+	"if r0 == 0 goto 1f;"
+	/* path A: r1 = callee fp-8 (frame=1) */
+	"r1 = r10;"
+	"r1 += -8;"
+"1:"
+	/* r1 = ARG_IMPRECISE{mask=BIT(0)|BIT(1)}.
+	 * Write map_value (non-FP) through r1. On path A this overwrites fp1-8.
+	 * Should join at_stack[0] with none: fp1-16|fp1+0.
+	 */
+	"*(u64 *)(r1 + 0) = r8;"
+	/* read fp1-8: should be fp1-16|fp1+0 (joined) */
+	"r0 = *(u64 *)(r10 - 8);"
+	"*(u64 *)(r0 + 0) = 42;"
+	"r0 = 0;"
+	"exit;"
+	:: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}

-- 
2.53.0
