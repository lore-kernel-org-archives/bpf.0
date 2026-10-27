Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793118519;
	b=CeGIjhol1KbxN9/1O0vc7pWqXsg++sAmixsvD8vB1sP5CH++geR2/aSeFcEdnRy8AP5v
	 j97/Z4C7ZYzM7zXJ0+QuIcDZxN5Gg5HDACG5RQy8S0DibLjvZtfTbdCamo0G/AI/Ax47r
	 U0kMWuGA0XEFy8l7fLjlMqVDT11ig5MARUqjLnLc94RoMG+gInjTslyhHeh24XkWyJA7c
	 h1QJTEPJRq5fOMSFkV8JsxRPSdxpnOypZAZbwBQL9h96cLFJsBToieYqa+CGjNSRru7H/
	 VDYVzWQsQI4nOOzbPQvC+yIMPCZRSI8ebK/akXnmWg1ZFuq1teoBZ0DtT5wrEhTO/iQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793118519;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=k8pu/THFSN4y+cH+X6WZ/khTsl0ZbZSu/FGlQoAVfXI=;
	b=rg1bZXRVnI5N+qhWYAIZnDobavbXa6KIiHdlBEKZPiT5tugnINJPcRdhvgi/WQjT/O+T
	 Hi+7zelcmYEM3GhQHzWD3aTOvDyk10Obd+GWs4HU/wV74iwbLSolPULwOqDPCZkYCbgTH
	 ctzqYUI/GhB7lkpaRGxt3RK5f1wd+sNBbKibjFFQnYghxGqNQPqe4/57xTWAiXHiaMmHM
	 zXbMP0dqnHU3ho2eUoR42ETCXi9lXnXZJAEyyGUIFaOskOd04DZdM887MOfhFOipR2S8a
	 Palno18nru50dJGszqKL1cYqinRD951b5h3z5RsPhLPvyXMJZiLjC61mVCAVUKufsPA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=etsalapatis.com;
	spf=pass smtp.mailfrom=etsalapatis.com;
	dkim=pass header.d=etsalapatis.com header.i=@etsalapatis.com header.a=rsa-sha256 header.s=google header.b=a9u4gQqV;
	arc=none smtp.remote-ip=209.85.210.180
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D602606A32F
	for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 16:28:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4D602606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=etsalapatis.com header.i=@etsalapatis.com header.a=rsa-sha256 header.s=google header.b=a9u4gQqV
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-8a058315c79so41610b3a.3
        for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 09:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis.com; s=google; t=1793118519; x=1793723319; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=k8pu/THFSN4y+cH+X6WZ/khTsl0ZbZSu/FGlQoAVfXI=;
        b=a9u4gQqVl3k7FOBTD2t4AfEEFyVF2hSZ0GK41Kw8thsK04vamsm+M4jDZ957LISB/e
         nrSuNSpi3nFC+xArZkCeSDlpeDCBTw7f789if4kV7x5+XRQpU3UNDQmC99iWP7RkE5V9
         yGtMCn33ulHgigiDKJeVaNCZsjCpaOd/Whh0FJcDYIEF9C0S2U/Q+NQpd8Ra5U4wc/6b
         QCWO5vmbp2+2wXSAL+2aVO/dtfDvcen2yvnw5IFqD3vK7e+ld7kiLQW2FEKnTG2Qh2Oi
         tqZ4lhTvZR8QFDhBJVaQqfV8CZXwgoRv0u59sX7KGnzsdppFujN8z7/bBwx6RkjDy3d+
         33Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793118519; x=1793723319;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=k8pu/THFSN4y+cH+X6WZ/khTsl0ZbZSu/FGlQoAVfXI=;
        b=Q19avmpX5nja/fdqbVXNwI6Ir9ZJWPdJMXQlxiGFUMIy7wdFFa/biKPbfQmLaM72/F
         eoXv/HtDQbDtOz1DdfJ3748Si2L6d/RRTDiPQR6dpxQ4q0tl+Ylsph26Ki6GRkBKPR+P
         v1JcjlGWGR0PYCaShy0+eagREPQD3l0+Ty+IX5q+chlR3kOGwprWx2vCTL8BKdbrNc7Y
         KnI2S1858pasxKqCxWwnS7iuVRyXMX8PBg8hpURUqKdtQZVlg2ybbrDMrN6Q6ZDPE6AN
         AFiaVu2tCn/1wGbWhG+WFKxhVAupHgF7DAeQVmDSwIUCpCwiafhp5oocBz9jaKvpnwlM
         Ob/g==
X-Gm-Message-State: AFq9FYIpXReAlkrg59/d3CV9zEm4T5mg9TQeOPF7/N5XwV3zuuzfrEEh
	l2nX++DCjgfT9SNbTbaVIrah4+cLRaXXtWAeDR/iUVRd5r9VVA4WRZZE6r9P4wjI8ZMu4rZCRJy
	F1bgI2yc=
X-Gm-Gg: AYBFou3r2X/xYFB2j5Fr4IEMpF7uXPnzy4IEeN4Y3yvtCgk2LgQYIlR78QeFYI8dqms
	cfEhkcx4fbGDTZBJdJCoB6L3G304V+BUsrAmY5JzHeCiwR3i+9FHtIg97+P7ctsINOh/CgUoN3Q
	soC3T5RciVrJPdAJrlyvDAP6ps8N3R9G0FQSYgPgoAIHjQKPFJiTVifFdju8GqbOekLju98YQtx
	Y4CDz06o4vNO+4f6+c8tRI8UW3P4HWuQo6mqoCvCNUO4GU1+s5mrjerqMc7j7EPOim+eB73wK6T
	vUTpKH8SLX1WYaNliZ9iAQeiqkpEJs5CCtlgPG+7T9z6dcRJdApKMmooDRC6rB1uXxul9LiT+WR
	1XWWOent2U4JxVVI3xkzo5rjo2yo9NegeoLlTRrCLatt8A5Ijg2L3PBLdMuKLu3J7hfzlEULdjp
	mHnCXVBuvB0fyqpSOOlzAVe3kNetZabK44zyC6a9p8WpSlDsmYEZz4VW77/igFgx1j1EQ3KFnbv
	D2couBx14zoCHSdAsPfIAs913mLjcDXKfvfDYWdNKtYoNTIFLJ60xk4GLyfn2yd8ldX87LJxxNC
	AnZJc7A0Dp9oFpMltQ==
X-Received: by 2002:a05:6a00:1c89:b0:89d:f19f:5dd1 with SMTP id d2e1a72fcca58-8a366c7d95amr7324250b3a.33.1793118518613;
        Tue, 27 Oct 2026 09:28:38 -0700 (PDT)
Received: from alpine05.ht.home (107-190-31-93.cpe.teksavvy.com. [107.190.31.93])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8a6a662c913sm257286b3a.31.2026.10.27.09.28.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 09:28:38 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	daniel@iogearbox.net,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf-next 7/7] selftests/bpf: Verify register preservation for IRQ fastcalls
Date: Tue, 27 Oct 2026 16:28:20 +0000
Message-ID: <20261027162820.10887-8-emil@etsalapatis.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261027162820.10887-1-emil@etsalapatis.com>
References: <20261027162820.10887-1-emil@etsalapatis.com>
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

Keep distinct runtime-derived values in R0 and R2-R5 across local IRQ
save and restore calls, and check all ten captured register values.
These void, single-argument kfuncs must preserve those registers when
their BPF caller compatibility spills are removed during inlining.

Provide matching stack spills and reloads around each call so the same
program remains correct on configurations that use native kfunc calls.
Check that the translated program either contains two internal IRQ
instructions and no compatibility memory instructions, or retains all
twenty compatibility instructions when the calls are not inlined.

Run the program with context marks zero and one and sixteen repeats
per mark. Always check the translated instructions and captured register
values, without changing the system's JIT hardening configuration.

Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 .../selftests/bpf/prog_tests/irq_fastcall.c   | 71 +++++++++++++++++++
 .../selftests/bpf/progs/irq_fastcall.c        | 56 +++++++++++++++
 2 files changed, 127 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/irq_fastcall.c
 create mode 100644 tools/testing/selftests/bpf/progs/irq_fastcall.c

diff --git a/tools/testing/selftests/bpf/prog_tests/irq_fastcall.c b/tools/testing/selftests/bpf/prog_tests/irq_fastcall.c
new file mode 100644
index 000000000000..3c1073bc1e49
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/irq_fastcall.c
@@ -0,0 +1,71 @@
+#include <test_progs.h>
+#include <network_helpers.h>
+#include "irq_fastcall.skel.h"
+
+static void check_spills(int prog_fd)
+{
+	struct bpf_prog_info info = {};
+	__u32 info_len = sizeof(info), xlated_len;
+	struct bpf_insn *insns;
+	int err, spill_count = 0, irq_count = 0;
+
+	err = bpf_prog_get_info_by_fd(prog_fd, &info, &info_len);
+	if (!ASSERT_OK(err, "prog_info"))
+		return;
+	xlated_len = info.xlated_prog_len;
+	insns = malloc(xlated_len);
+	if (!ASSERT_OK_PTR(insns, "insns"))
+		return;
+	memset(&info, 0, sizeof(info));
+	info.xlated_prog_len = xlated_len;
+	info.xlated_prog_insns = ptr_to_u64(insns);
+	err = bpf_prog_get_info_by_fd(prog_fd, &info, &info_len);
+	if (!ASSERT_OK(err, "xlated_info"))
+		goto out;
+	for (size_t insn_idx = 0; insn_idx < xlated_len / sizeof(*insns); insn_idx++) {
+		struct bpf_insn *insn = &insns[insn_idx];
+
+		if (insn->code == (BPF_ST | 0xe0))
+			irq_count++;
+		if ((insn->code == (BPF_STX | BPF_MEM | BPF_DW) &&
+		     insn->dst_reg == BPF_REG_10 && insn->off <= -16) ||
+		    (insn->code == (BPF_LDX | BPF_MEM | BPF_DW) &&
+		     insn->src_reg == BPF_REG_10 && insn->off <= -16))
+			spill_count++;
+	}
+	ASSERT_TRUE(irq_count == 0 || irq_count == 2, "irq_inlining");
+	ASSERT_EQ(spill_count, irq_count ? 0 : 20, "compatibility_spills");
+out:
+	free(insns);
+}
+
+void test_irq_fastcall(void)
+{
+	struct irq_fastcall *skel;
+	int prog_fd, err;
+
+	skel = irq_fastcall__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "open_and_load"))
+		return;
+	prog_fd = bpf_program__fd(skel->progs.irq_fastcall_preserve);
+	check_spills(prog_fd);
+	for (int mark = 0; mark < 2; mark++) {
+		struct __sk_buff ctx = { .mark = mark };
+
+		LIBBPF_OPTS(bpf_test_run_opts, opts,
+			.data_in = &pkt_v4,
+			.data_size_in = sizeof(pkt_v4),
+			.ctx_in = &ctx,
+			.ctx_size_in = sizeof(ctx),
+			.repeat = 16,
+		);
+
+		err = bpf_prog_test_run_opts(prog_fd, &opts);
+		ASSERT_OK(err, "test_run");
+		ASSERT_EQ(opts.retval, 0, "retval");
+		for (int reg_idx = 0; reg_idx < 10; reg_idx++)
+			ASSERT_EQ(skel->bss->saved_regs[reg_idx],
+				  mark + 17 * (reg_idx % 5 + 1), "preserved_register");
+	}
+	irq_fastcall__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/irq_fastcall.c b/tools/testing/selftests/bpf/progs/irq_fastcall.c
new file mode 100644
index 000000000000..3988e489c14f
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/irq_fastcall.c
@@ -0,0 +1,56 @@
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+
+extern void bpf_local_irq_save(unsigned long *) __ksym __bpf_fastcall;
+extern void bpf_local_irq_restore(unsigned long *) __ksym __bpf_fastcall;
+
+__u64 saved_regs[10];
+
+void __kfunc_btf_root(void)
+{
+	asm volatile ("" : : "r"(&bpf_local_irq_save), "r"(&bpf_local_irq_restore));
+}
+
+#define IRQ_SET_REGS \
+	"r0 = r7; r0 += 17; r2 = r7; r2 += 34;" \
+	"r3 = r7; r3 += 51; r4 = r7; r4 += 68; r5 = r7; r5 += 85;"
+#define IRQ_SPILLS \
+	"*(u64 *)(r10 - 16) = r0;" \
+	"*(u64 *)(r10 - 24) = r2;" \
+	"*(u64 *)(r10 - 32) = r3;" \
+	"*(u64 *)(r10 - 40) = r4;" \
+	"*(u64 *)(r10 - 48) = r5;"
+#define IRQ_FILLS \
+	"r5 = *(u64 *)(r10 - 48);" \
+	"r4 = *(u64 *)(r10 - 40);" \
+	"r3 = *(u64 *)(r10 - 32);" \
+	"r2 = *(u64 *)(r10 - 24);" \
+	"r0 = *(u64 *)(r10 - 16);"
+#define IRQ_CAPTURE_REGS \
+	"*(u64 *)(r6 + 0) = r0;" \
+	"*(u64 *)(r6 + 8) = r2;" \
+	"*(u64 *)(r6 + 16) = r3;" \
+	"*(u64 *)(r6 + 24) = r4;" \
+	"*(u64 *)(r6 + 32) = r5;"
+
+SEC("tc")
+__naked int irq_fastcall_preserve(void)
+{
+	asm volatile (
+		"r7 = *(u32 *)(r1 + 8); r6 = %[saved_regs] ll;"
+		"r1 = r10; r1 += -8;"
+		IRQ_SET_REGS IRQ_SPILLS
+		"call %[bpf_local_irq_save];"
+		IRQ_FILLS IRQ_CAPTURE_REGS
+		"r6 += 40; r1 = r10; r1 += -8;"
+		IRQ_SET_REGS IRQ_SPILLS
+		"call %[bpf_local_irq_restore];"
+		IRQ_FILLS IRQ_CAPTURE_REGS
+		"r0 = 0; exit;"
+		:
+		: __imm(bpf_local_irq_save), __imm(bpf_local_irq_restore), __imm_addr(saved_regs)
+		: __clobber_all);
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.52.0

