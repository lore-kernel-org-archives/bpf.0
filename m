Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794461181;
	b=4km+CsyuB07UTSFXPUq8VVxqQlKohHN5W3WSPJVDuyqLixAqRQ8Y4dJ2wnUF+0WYflsd
	 7B4TL9KMnl2UY/BMPUvT8g6t720lQXQ3QwONDx4M90d5iaC7EDkJrutlConA/SOxg0khD
	 zJ7BGNg67JOe6TV1lwH9Q9C6zrz0AjeQmHe2lZDqFdCkmUxjBpAOUi3ttcWwAMTSqUH3m
	 tXQ7PHM/JwglQSZwH2ZFU6AX6Nkx+KeLNpAgNxNdZtvR3sp5UsKnIs713FEIY6rHaWniB
	 ezZWUZ2m6ZscE7CRUrjTB4CtxEWYbwmSgqFL5dHIyqp9742lB4uUGF/SEAQ7q7srXLA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794461181;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=2+bd0lclXJFZZ9odaFbNz2RPwwgq5nV2oUMBTYnLjs0=;
	b=AboIcMVGgN59VbfnTg9TGOJSNny2DaWLoeH5xCOukGYmMfhxPaoJLFeKUmoXJY3Zdp6y
	 7BI9xKdV0QU7EJx4GJZVxTDKr8gqeBxxoL6HSE11G2hyuAMhajQjJKG9sN2b4Ej8rQjle
	 wovi5Lm40hcVJGjQfodSexKVOMMh58RN8rgM30DD1L850ZrUgNptwLMd+bJhqacaX5Mwa
	 1W+2SJ/+Ay/LW0qH67xwRhAI0r3lHAgfrOWC3hsLSLgQbl9G4kieaHN5LNZMlpxvvYE/J
	 8EUhWduvN3i4BZA8fBXL37VhdvMtJrkB1Vl8Zh7UWwBOQB8aAY9/R/5uGAaw7HrLwoA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JGHaQ7FJ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B0DD606A32E;
	Thu, 12 Nov 2026 05:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JGHaQ7FJ
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794461180;
	b=j9/YNr7eyoNxFIDxoS9YMpNgJ3tcm58HmcTWtuhkk5j9jZ8tgY0Dtk2w7lYkLN8FmZcG
	 RIdZ+hATrM0XZ0rIeFpzj9JDSaF9Bw1Eqg/3m7/bW3yYiEdSYN9bNFEBeCbX4DxWY7kUX
	 XqG2EHKUSPZ5FGeP0MTJbRtfKcxQS05pQAoNiw23tRlK/6Xf6DTZGdb0RspR8KnKz1Toq
	 c4izU/raeoVzqwp1XV9t3xI2dICLDCeocPIcU/w6YPJXPAHfzcqCrxk/evZKXlVxm4UpK
	 PKSpXNhp7wHlRf+gcnk/bMY1+sdbZRw1oQUIjOoa4VGlY+kpNIbLWjWWyLnWiCze1/w==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794461180;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=2+bd0lclXJFZZ9odaFbNz2RPwwgq5nV2oUMBTYnLjs0=;
	b=IkmWsrF+t/qZ++kzcCzGwQpeOoWdgXOsBNIvzdorOHxLo22+FV6RnmLY3ARiM5vJQYqs
	 POy20+tlPklDIU0S4AhfHvKyUIya65aYmyYm8GGqipI63klNsVKHYomslewZ2d5DiNyxy
	 6wF/3JNraXetOkYqBhI5kam9K3ZF0PI+MkgzG0JRmhVRr0ysyeBuZ3WY/bjumTSjgPRPh
	 YkpbtfoUR8dDTZXIVb25t8wGgSyu9J2ssJBZ3jVyNtK726Tj/akhB5tc6HR3+/ZKlPCLu
	 IpNWPoH8OXK2/JumZKGgf6bf5IPw19KQcUyFRYRX2nL0dCgB9sFBdkpBXwwn5sN9ytg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id D8FB61F00A07;
	Thu, 12 Nov 2026 05:26:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794461180;
	bh=2+bd0lclXJFZZ9odaFbNz2RPwwgq5nV2oUMBTYnLjs0=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=JGHaQ7FJtNZrTzDKX+gZa+c6FlIT1I7rJpEnoXL8DNaBKNXUJI6jV/SE30EoY4LdP
	 mb2WJLBNvLL+bmhszYxKLYkJhsxNThpZ+JbDFje9KMJoMljj9QuqRsbvA8jUZQynoE
	 usWYptV01o6/NbAilHRwfS9YZfe7GapyRxi5KALBL+frkA1WXLH5UprMYsiyE8oKjf
	 WWlXEcmqg0h0y2G8rUL13yD0o79K+2FTd5jgfJSs8Dxd9ZocbBZLUKb1I7R25D3YUd
	 e6jowfgqNbxwkAkfgs+Pi9mGwFt98JQEk6nh/C7W0fVywJRD8J9tsUwEPj0Tk/8rMJ
	 BFW3LqKECmJFQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 3A964492C4;
	Thu, 12 Nov 2026 05:26:19 +0000 (UTC)
From: Hang Zhengyang via B4 Relay <devnull+hang.zhengyang1010.gmail.com@kernel.org>
Date: Thu, 12 Nov 2026 13:26:18 +0800
Subject: [PATCH] uprobes/x86: Emulate ENDBR as a NOP
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261112-uprobe-endbr-v1-1-284a47a5ae3e@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MPQqAMAxA4atIZgumg0WvIg79iZqlLSmKUHp3i
 +M3vFehkDAVWIcKQg8XTrEDxwH8ZeNJikM36EnPiKjVnSU5UhSDE2W8sQ6dtbgg9CQLHfz+u21
 v7QN5bbihXgAAAA==
X-Change-ID: 20261112-uprobe-endbr-7c7ab1baa191
To: Masami Hiramatsu <mhiramat@kernel.org>, Oleg Nesterov <oleg@redhat.com>, 
 Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@kernel.org>, 
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
 "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>, 
 Jiri Olsa <jolsa@kernel.org>, Hang Zhengyang <hang.zhengyang1010@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794461178; l=3044;
 i=hang.zhengyang1010@gmail.com; s=20261008; h=from:subject:message-id;
 bh=Me7MxAd288UOXLmc+8UseLP8mB9LDZJcffXOE/7xdVk=;
 b=TYjmkiZhMPeL5rzT4xkvGnJ3DrsPvjpjIzFhdsZncNT4coF1yOvINPkolyEN3eedeLaarMkxV
 TvgA7qBX2+nADm5DZKncRYHiVsy1Wxkr1FyW/V8C3gZGGVMbd/cTrPZ
X-Developer-Key: i=hang.zhengyang1010@gmail.com; a=ed25519;
 pk=5drRny3PqRPLhKVB0YIQXN5YyD8miKCpXWhnEPvafAI=
X-Endpoint-Received: by B4 Relay for hang.zhengyang1010@gmail.com/20261008
 with auth_id=1133
X-Original-From: Hang Zhengyang <hang.zhengyang1010@gmail.com>
Reply-To: hang.zhengyang1010@gmail.com
Content-Transfer-Encoding: 7bit

From: Hang Zhengyang <hang.zhengyang1010@gmail.com>

A uprobe on ENDBR64 is single-stepped, so it takes two traps instead of
one: insn_is_nop() doesn't recognize ENDBR, and it isn't a branch or a
push either.  That makes the most common case slow.  With
-fcf-protection, the default for gcc on Ubuntu, every function starts
with ENDBR64, so every uprobe on a function entry pays for the
single-step.  PUSH had the same problem until commit e7ed9d9bd037
("uprobes/x86: Emulate push insns for uprobe on x86").

Userspace IBT is not supported, so ENDBR is just a NOP in user mode.
Emulate it like the other NOPs.  Don't use is_endbr() for the check: it
always returns false without CONFIG_X86_KERNEL_IBT.  If userspace IBT
is ever enabled, uprobes on ENDBR will need rework anyway, since the
int3 replaces the ENDBR at an indirect branch target.

The numbers below are from the selftests/bpf trigger benchmarks, with
an extra target that starts with ENDBR64 (the existing ones are built
with __nocf_check, so they don't have it).  On a Ryzen 7 PRO 5850U,
without this patch, a probe on ENDBR64 is as slow as a single-stepped
one:

             nop       endbr64   ret (single-step)
  uprobe     1.33 M/s  0.65 M/s  0.65 M/s
  uretprobe  0.66 M/s  0.43 M/s  0.43 M/s

With this patch ENDBR64 is emulated like a NOP.  I could only boot the
patched kernel in a KVM guest, where uprobe went from 0.19 to 0.99 M/s
(nop: 1.00) and uretprobe from 0.17 to 0.61 M/s (nop: 0.61).

Signed-off-by: Hang Zhengyang <hang.zhengyang1010@gmail.com>
---
Found and measured with Claude; I reviewed it and ran the measurement.
---
 arch/x86/kernel/uprobes.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
index 0f60c0d076b6..879ce918ebea 100644
--- a/arch/x86/kernel/uprobes.c
+++ b/arch/x86/kernel/uprobes.c
@@ -1484,13 +1484,28 @@ static const struct uprobe_xol_ops push_xol_ops = {
 	.emulate  = push_emulate_op,
 };
 
+/*
+ * ENDBR64/ENDBR32 (f3 0f 1e fa/fb).  Userspace IBT is not supported, so
+ * in a user task they are NOPs, and they start most functions in
+ * binaries built with -fcf-protection.  Revisit if userspace IBT is
+ * ever enabled.
+ */
+static bool insn_is_endbr(struct insn *insn)
+{
+	return insn->length == 4 &&
+	       insn->prefixes.nbytes == 1 && insn->prefixes.bytes[0] == 0xf3 &&
+	       insn->opcode.nbytes == 2 && insn->opcode.bytes[0] == 0x0f &&
+	       insn->opcode.bytes[1] == 0x1e &&
+	       (insn->modrm.bytes[0] & ~1) == 0xfa;
+}
+
 /* Returns -ENOSYS if branch_xol_ops doesn't handle this insn */
 static int branch_setup_xol_ops(struct arch_uprobe *auprobe, struct insn *insn)
 {
 	u8 opc1 = OPCODE1(insn);
 	insn_byte_t p;
 
-	if (insn_is_nop(insn))
+	if (insn_is_nop(insn) || insn_is_endbr(insn))
 		goto setup;
 
 	switch (opc1) {

---
base-commit: 9d66f26fefacebfeed15de31c1123451a17ff119
change-id: 20261112-uprobe-endbr-7c7ab1baa191

Best regards,
-- 
Hang Zhengyang <hang.zhengyang1010@gmail.com>


