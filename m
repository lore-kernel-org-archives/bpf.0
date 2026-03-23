Received: from zg8tmja5ljk3lje4mi4ymjia.icoremail.net (zg8tmja5ljk3lje4mi4ymjia.icoremail.net [209.97.182.222])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 440DE1C84D0;
	Mon, 23 Mar 2026 09:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.97.182.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774256746; cv=none; b=m9yLKxdmudBb1dSLd2ATPOoErYvsxj5lMIR2GKEo6445Mylm+fiTCIlO7BLHI0gYKYoj57pU/SN3FBojSSZdBFtjDLpJajuTWUzvIBV3c8cmG26X11HzyrEhh5uFTlse75DJyhm6Ts4p6AykkBVmPmb9nWu5/s7ZA/AJ8qrKilc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774256746; c=relaxed/simple;
	bh=ySQT3VAd4GrzZ/qxZpEQCJLETt9VD7VMobrWDjrekX0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XP9xYl8yh1rkGg/omY8N1qlhj9ASmPi5OrMTPS81pWW3lz8Q6y4RVvyjO1vXFnmaN9o6kqipS5/0oP7Ps3ykgNhFmxDhAhtU1uwxH51qU4VqLRIdrhTORzC1501p8p0Zc2ZEz+209js/oxNesfRMKHK3h1hEBkayIdfO8ClaIzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=209.97.182.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [183.157.163.122])
	by mtasvr (Coremail) with SMTP id _____wDX36dNAsFp7Q5HAA--.1593S3;
	Mon, 23 Mar 2026 17:05:18 +0800 (CST)
Received: from localhost.localdomain (unknown [183.157.163.122])
	by mail-app3 (Coremail) with SMTP id zS_KCgDnYnhMAsFpPmANAA--.52582S2;
	Mon, 23 Mar 2026 17:05:16 +0800 (CST)
From: Tianci Cao <ziye@zju.edu.cn>
To: ast@kernel.org,
	daniel@iogearbox.net,
	bpf@vger.kernel.org
Cc: john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	linux-kernel@vger.kernel.org,
	tangyazhou518@outlook.com,
	shenghaoyuan0928@163.com,
	Tianci Cao <ziye@zju.edu.cn>
Subject: [PATCH bpf-next] bpf: Drop redundant CONT_JMP alias
Date: Mon, 23 Mar 2026 17:05:08 +0800
Message-Id: <20260323090508.18986-1-ziye@zju.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zS_KCgDnYnhMAsFpPmANAA--.52582S2
X-CM-SenderInfo: qtstiiaquyiko62m3hxhgxhubq/
X-CM-DELIVERINFO: =?B?1RWa0AXKKxbFmtjJiESix3B1w3tzYfmPt4q7bPP17nv9Zvsme7sPvU0377+RBBKdO8
	083jO/wNhIP+pglnkLd0BnOseIfBBxyRSDqjPjmxamLaW9G05G95BHjzxGP+S8SpmV3VmT
	I5RpmYpxt4LJp3yeaBcZxzycEOt/T1pzLTdgCNOH
X-Coremail-Antispam: 1Uk129KBj93XoW7CFyrKFW5KF48ZryfuFy3trc_yoW8ZFW3p3
	Z5Ww1jya1Sgr47ZFZ8JrZ7Ar15JFZrXFyxG3ykC34ftF45Ka4fK34jgFn0qFWfXw1IkFW3
	Jr9I9r1jk3WUZFXCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9Eb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AK
	xVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc
	02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAF
	wI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0Y48IcxkI7V
	AKI48G6xCjnVAKz4kxM4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28IcxkI7VAKI48JMxC2
	0s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI
	0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE
	14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20x
	vaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8
	JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8YFAJUUUUU==

Historically, the classic BPF interpreter distinguished between taken
conditional branches and fall-through paths by using CONT_JMP and CONT,
respectively.

After the interpreter was migrated from net/core/filter.c to
kernel/bpf/core.c, this naming split remained as a historical artifact.
However, both macros have long expanded to the exact same sequence:
"{ insn++; goto select_insn; }".

To simplify the code and remove unnecessary abstractions, replace all
remaining CONT_JMP with CONT, and drop the redundant CONT_JMP definition
entirely.

No functional change intended.

Co-developed-by: Yazhou Tang <tangyazhou518@outlook.com>
Signed-off-by: Yazhou Tang <tangyazhou518@outlook.com>
Co-developed-by: Shenghao Yuan <shenghaoyuan0928@163.com>
Signed-off-by: Shenghao Yuan <shenghaoyuan0928@163.com>
Signed-off-by: Tianci Cao <ziye@zju.edu.cn>
---
 kernel/bpf/core.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 229c74f3d6ae..040ce44ba0dd 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -1770,7 +1770,6 @@ static u64 ___bpf_prog_run(u64 *regs, const struct bpf_insn *insn)
 	u32 tail_call_cnt = 0;
 
 #define CONT	 ({ insn++; goto select_insn; })
-#define CONT_JMP ({ insn++; goto select_insn; })
 
 select_insn:
 	goto *jumptable[insn->code];
@@ -2089,25 +2088,25 @@ static u64 ___bpf_prog_run(u64 *regs, const struct bpf_insn *insn)
 	JMP_##OPCODE##_X:					\
 		if ((SIGN##64) DST CMP_OP (SIGN##64) SRC) {	\
 			insn += insn->off;			\
-			CONT_JMP;				\
+			CONT;					\
 		}						\
 		CONT;						\
 	JMP32_##OPCODE##_X:					\
 		if ((SIGN##32) DST CMP_OP (SIGN##32) SRC) {	\
 			insn += insn->off;			\
-			CONT_JMP;				\
+			CONT;					\
 		}						\
 		CONT;						\
 	JMP_##OPCODE##_K:					\
 		if ((SIGN##64) DST CMP_OP (SIGN##64) IMM) {	\
 			insn += insn->off;			\
-			CONT_JMP;				\
+			CONT;					\
 		}						\
 		CONT;						\
 	JMP32_##OPCODE##_K:					\
 		if ((SIGN##32) DST CMP_OP (SIGN##32) IMM) {	\
 			insn += insn->off;			\
-			CONT_JMP;				\
+			CONT;					\
 		}						\
 		CONT;
 	COND_JMP(u, JEQ, ==)
-- 
2.34.1

