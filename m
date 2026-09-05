Received: from mail-wr2-f10.google.com (mail-wr2-f10.google.com [74.125.225.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCE3A39A071
	for <bpf@vger.kernel.org>; Sat,  5 Sep 2026 07:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788591624; cv=none; b=oYENbelOPAlVWY00yiWRpSfUOfsy3xx1M4I3vWubMFneXEG84sPlChRBRh6Rqc5wTEJPXc71ZPB/fUFyVY7ZQZJiEI1cBWYH4Kme91pWMxeQK0g55U3mRVMPu6pjfNbCYuuu2W6s1BH6eV/xoMzeAhDo3tMiRijIXHWjjEW05QY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788591624; c=relaxed/simple;
	bh=/89BJ7WZqAjd7o2yg7uUpnUuGTtcWinWvlEQNM8fi5Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GdSnLGHuwBmXW53263fbqmJSi0wHTAaamsjz84JdH/BmZmCZJWssadsBneMBF7I8LT81Ojlh8XWXXH5Hz3MQdoEsHTtvni3o4wL9pT77ezjJO6SIdIU5D0yHObuq6uB1m2IfHFcQ2Yh/1jm3PI+LVuC9mZZZRd52aIPFR55JIPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=muOFsaN4; arc=none smtp.client-ip=74.125.225.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="muOFsaN4"
Received: by mail-wr2-f10.google.com with SMTP id ffacd0b85a97d-48436370540so768836f8f.0
        for <bpf@vger.kernel.org>; Sat, 05 Sep 2026 00:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788591606; x=1789196406; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sanM8pAvYD9UXQAIsezMKfd1IAM3Tm6GuCbktBO34MQ=;
        b=muOFsaN4vnAXM+bHckwRbPmQE/Tx1qz8+18ZmsDwn4H0XuWwZLH95d/5FzGJTeHTy3
         /0Dy42hZbAfzjc83yxgvgETDncI0W/xIV+xxCQYwk6BORnTMLU5pZxtzP6KYwpEdvFcN
         zd4FDoMBfIEHEnNXrIEq2stW1YkZT3bONvPM+r7EMYKxLZ2aAMrjb+rDhpoe9hyDBH3u
         1U3jmYc+fePzWTQ+ZXbQlTjwAXQ657L2N3ywqO2Al56YSpkRcOpYsx61uH+5p/2lzfv2
         pXxcEFmSUw8eZTSte6hOmg89F0RM+MT71/zIbRwrw7FLNdff6EQNbUfoZs7Tw3jIU9EC
         F1eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788591606; x=1789196406;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=sanM8pAvYD9UXQAIsezMKfd1IAM3Tm6GuCbktBO34MQ=;
        b=oPxFuMs9eAXYHA3KauG8nkxncY5lWFbZVIMWSmXm2+xL3M2hzLfa86BCaL65hZvn3t
         6DWTyrJFkYTpQfWV9atQjBgge2EPK5gYGjENmf5eU6Av8p14rqjRLBkdvNmK0aeqifHd
         UV5DuYaJCzKYleRSWS5NKtfPWSEZyg/nVAUiwqWQLMCoV18ITTATo//nEkyQwh6UNhs8
         o7KGEhvCyFfeZ+u6uOdPBCm0cPIXgeXz6pDFaFcZCpt2Jwsx1cIDAO4/yWQ/R4poap7+
         2m81muaEjs/XpaVFQcSjAHt/TN/mbCYB2FujrDNgHK7qqlS8xhxGDXvDlBhzucFWiV6K
         LhZQ==
X-Gm-Message-State: AFuF++kFnU2iaOopow7Qeg2rYdmbxvlM7YkgjD/CvCpHD9yfdSBI1DIl
	kPAO+XPepc641c0N7vL+6X+6Hsg4IYRG9PdlA8KiGRlFAM3vObZFUVUSV48tKl2j
X-Gm-Gg: AYBFou08Z9awKEwUDHsqH3NKXVorafPs3nX1/uJhy0tP+z45A6vipqYFcLR/G9MImRM
	Mw1dQXcRvfNZoaU8KLnjSDJj+/dFTjOqzVDeBK1xxGuanXdUx2V8IjCViyBqiwEbVhv91/WELDS
	eN8JlM025tVjMn7/19vBwloew8SMBo6adBhxaUeeIUlfPRkWqAbUnetGxVvtDtfwgxXJ0e6Nt6a
	JTlbRJkBhQr40VVFL3KOEhdrXQa5HSqaGGthCLd8quZ8szd95JXfxz+LF+VP7r6kMeN7z3Zb5sJ
	Kos2EI43ECFtqIZZQhqDHNW37eVC2s5InmM4JHemrc293O9ppMwa2PhwI0X8zE2vhibKh/u9JKc
	M99WQej43sdPTyumWDykCC7hse1Jt2R8p+Mz3rsC8cgnuWTqBujmGB9jUSj4iiraW7Y+RcZofE5
	N3sgRd6JXtDS+Ss1QYW9U1Ie20kN9nbGEWYTQYrjQkA0BgjxYM4QBf2FvI/hc95bLSYtR1bYt3j
	ThB1FowWZXsI1QkyMCFyv/r4f0LcAWLhZeLfPv5XhzhhI8eW+d0t5j3AU9LkdpWxVsAnkTfFMdh
	4ai17MtXuQNrW122gz1/7cG4Qbg=
X-Received: by 2002:a05:6000:25fb:b0:485:85d5:7ac7 with SMTP id ffacd0b85a97d-485872d57e0mr15157842f8f.26.1788591605866;
        Sat, 05 Sep 2026 00:00:05 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485885bfdf6sm11987680f8f.34.2026.09.05.00.00.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2026 00:00:05 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Nicholas Carlini <npc@anthropic.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf v1 1/8] bpf: Make post-verification instruction rewrites killable
Date: Sat,  5 Sep 2026 08:59:52 +0200
Message-ID: <20260905070003.3193366-2-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260905070003.3193366-1-memxor@gmail.com>
References: <20260905070003.3193366-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3110; i=memxor@gmail.com; h=from:subject; bh=/89BJ7WZqAjd7o2yg7uUpnUuGTtcWinWvlEQNM8fi5Q=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWv23qWFQq9/xH222rHeXs36T25/l4ia31S7iVMblvddr n9weseZjlIWBjEuBlkxRZaS//uYjE9U/g60XcYNM4eVCWQIAxenAEyko4WR4U6QNPsJzhl/YqKe 89x7Ll4T4qhVMllbeGvCdyWTF4fO+TH8M7V7IufZ+6jp07mTHipnq2ZF6Pet+rnN3Gi77VLr5Z/ mMgEA
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

After do_check() returns, the verifier runs several instruction rewrite
passes. Some of them patch or remove one instruction at a time. Each
operation moves the remaining instruction and auxiliary-data arrays and
adjusts all branch offsets, making the overall work quadratic in the
program length.

A privileged loader can submit 131072 unconditional jumps by zero followed
by a valid return. Verification finishes quickly, but bpf_opt_remove_nops()
then spends a long time removing each jump separately. Since this
post-verification work neither checks for signals nor reschedules, a pending
SIGKILL cannot terminate the task until the rewrite finishes.

Make bpf_patch_insn_data() and verifier_remove_insns() common cancellation
and rescheduling points. These helpers run from BPF_PROG_LOAD process
context, and bpf_patch_insn_data() can already sleep while reallocating
auxiliary data. Callers already handle NULL or propagate an error, so a
fatal signal can abort without leaving a partially accepted program visible.

This does not reduce the quadratic cost of the rewrite passes, but it makes
the work preemptible and allows a killed loader to be torn down promptly.

Fixes: 52875a04f4b2 ("bpf: verifier: remove dead code")
Reported-by: Nicholas Carlini <npc@anthropic.com>
Suggested-by: Nicholas Carlini <npc@anthropic.com>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/fixups.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
index 52d3cec33672..9401fffcedfd 100644
--- a/kernel/bpf/fixups.c
+++ b/kernel/bpf/fixups.c
@@ -8,6 +8,7 @@
 #include <linux/bsearch.h>
 #include <linux/sort.h>
 #include <linux/perf_event.h>
+#include <linux/sched/signal.h>
 #include <net/xdp.h>
 #include "disasm.h"
 
@@ -306,12 +307,28 @@ static void adjust_poke_descs(struct bpf_prog *prog, u32 off, u32 len)
 	}
 }
 
+/*
+ * Some post-verification instruction rewriting passes require an
+ * O(prog->len) operation per instruction. Keep their shared primitives
+ * killable and preemptible.
+ */
+static bool bpf_rewrite_must_abort(void)
+{
+	if (fatal_signal_pending(current))
+		return true;
+	cond_resched();
+	return false;
+}
+
 struct bpf_prog *bpf_patch_insn_data(struct bpf_verifier_env *env, u32 off,
 				     const struct bpf_insn *patch, u32 len)
 {
 	struct bpf_prog *new_prog;
 	struct bpf_insn_aux_data *new_data = NULL;
 
+	if (bpf_rewrite_must_abort())
+		return NULL;
+
 	if (len > 1) {
 		new_data = vrealloc(env->insn_aux_data,
 				    array_size(env->prog->len + len - 1,
@@ -523,6 +540,9 @@ static int verifier_remove_insns(struct bpf_verifier_env *env, u32 off, u32 cnt)
 	unsigned int orig_prog_len = env->prog->len;
 	int err;
 
+	if (bpf_rewrite_must_abort())
+		return -EINTR;
+
 	if (bpf_prog_is_offloaded(env->prog->aux))
 		bpf_prog_offload_remove_insns(env, off, cnt);
 
@@ -2666,4 +2686,3 @@ int bpf_remove_fastcall_spills_fills(struct bpf_verifier_env *env)
 
 	return 0;
 }
-
-- 
2.53.0

