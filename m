Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.38.64.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793081603;
	b=luQBWKpR9rDbWvcub0VPBDtsHwjVyWt5oerOMXpK6qhDD9NCA/I0CEn96r8coXqc+eG3
	 tDswGDiVY8Q2PfhmL8cdcESgc+FsB8UzETEJNe/AhpFrb/pYTKLGKvtdxt7orTbST3hfC
	 8LgOx+EAwe+7YAc7eAYOXOG1gGFFAO7+ndOTJDK3zgwLtBWtgG6NBe/NA+AuZDkRax7ew
	 W9UsAdnsjSnNEJDmZzGDntswJXKAihV3JdJi/SiYDppwdHyIKyIzVJ0TEAmGEJtQTCjvT
	 8nnxa+74BpDvV51dHvlSfBfPGQsJrUC/tKgRbVED0qZ+ZMd6OMLuc9YnPy4VC2YeO4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793081603;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=OQqGK0B+OAIhK0G4R50IEaOeHBXhgCO2i9UcOrUesE8=;
	b=ZE6WEKx5iZ9dNwxsE7h9hTJlZlPllmeXKz4GV1dAKcXUad2XQQH6SGpAJC5xYTxfpnby
	 gUbX9NKTGHMsTeg6bwMRMguinzwAbDnpLAga/fsN5VoRbrggD31Yb5fncBFSUJZuNWye2
	 DE6vnyZCMHaFvuA/SYofaZ8f1MtaqAwCmTiv2mhIEHIDPUozcJw9u60+HUT7IELUSzuQ6
	 lzW2lcXfG0w96A1fWEUTn1/IQw9Uom+rMZSaL/Q7KJECdzVN4NyQPByktG2OOqyMnphFd
	 LbIYl6NPgzIVcZ8Iuq8bD7oRJ+zZzG6c2b0eG/0lfv/HhXmq2dSIKfesTvsItugg0SA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mail.ustc.edu.cn;
	spf=pass smtp.mailfrom=mail.ustc.edu.cn;
	dkim=pass header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.a=rsa-sha256 header.s=dkim header.b=KZcsxnnM;
	arc=none smtp.remote-ip=202.38.64.46
Received: from ustc.edu.cn (smtp.ustc.edu.cn [202.38.64.46])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7A4B606A31B
	for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 06:13:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E7A4B606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.ustc.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.ustc.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.a=rsa-sha256 header.s=dkim header.b=KZcsxnnM
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mail.ustc.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-ID:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=OQqGK0B+OAIhK0G4R50IEaOeHBXhgCO2i9
	UcOrUesE8=; b=KZcsxnnM/fqIiR6DFxhftmHmEZXgf0uyl6iU45oUtl8L1Jn6ZS
	6KtTyDp0nwBKx4hxV0rtscVGQZcmX2qhbd0PiRG3sb0Sc/YcqMg7WL6lci7R85yA
	za930B5ViIUWYqbm8TN2d1bTk3HFt+0yn/VW3vd93WUN89U7zS9CH6S9U=
Received: from localhost (unknown [222.195.81.103])
	by mailimap2024 (Coremail) with SMTP id 3pYKCgAHgzf3QOBqHOBOAA--.313S2;
	Tue, 27 Oct 2026 14:13:11 +0800 (CST)
From: Xu Yunxiang <xyx2021@mail.ustc.edu.cn>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Yonghong Song <yonghong.song@linux.dev>
Subject: [PATCH bpf 1/2] bpf: Propagate scalar precision through stack arguments
Date: Tue, 27 Oct 2026 14:13:02 +0800
Message-ID: <20261027061303.1754535-2-xyx2021@mail.ustc.edu.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261027061303.1754535-1-xyx2021@mail.ustc.edu.cn>
References: <20261027061303.1754535-1-xyx2021@mail.ustc.edu.cn>
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
X-CM-TRANSID:3pYKCgAHgzf3QOBqHOBOAA--.313S2
X-Coremail-Antispam: 1UD129KBjvJXoWxCr13Xw4UZFy8WF1xAw4fZrb_yoW5XFWrpa
	s7GFnIqw48tF47uwnxAF109FW5Wan5Ar17GFWxAFySqF1jqryY9F4UtFyaya17tr97X3yY
	v3WqvFZ09a1kXFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9ab7Iv0xC_KF4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I
	8E87Iv6xkF7I0E14v26rxl6s0DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x2
	0xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15Mc
	Ij6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l
	c7CjxVAaw2AFwI0_JF0_Jw1lc2xSY4AK67AK6r47MxAIw28IcxkI7VAKI48JMxC20s026x
	CaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_
	JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r
	1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_
	Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8Jr
	UvcSsGvfC2KfnxnUUI43ZEXa7IU8WKZPUUUUU==
X-CM-SenderInfo: h010jiysr6zt1loo32lwfovvfxof0/

Outgoing stack arguments retain scalar verifier state separately from
registers and ordinary spills. State comparison uses their precision
marks, but propagate_precision() does not carry those dependencies from
a reused state to the current path's ancestors. A path can consequently
reuse a state without making earlier checkpoints distinguish scalar
values that will later be used as memory offsets.

Seed the existing backtracking batch with precise scalar argument slots
from every frame. Incoming arguments live in the caller's outgoing
slots, so include caller frames as well as the current frame.

Also cover scalar argument slots in bpf_mark_all_scalars_precise(), so
conservative fallback preserves the same invariant. Keep its existing
ancestor-only traversal and leave pointer and uninitialized slots alone.

AI assistance was used in preparing this patch.

Fixes: 0f6bd5e7a804 ("bpf: Support stack arguments for bpf functions")
Signed-off-by: Xu Yunxiang <xyx2021@mail.ustc.edu.cn>
---
 kernel/bpf/backtrack.c | 11 +++++++++++
 kernel/bpf/states.c    | 14 ++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/kernel/bpf/backtrack.c b/kernel/bpf/backtrack.c
index 43d5740034c0fdd53daf6ef572a56dce2eb78083..2d6535f271a67226ae972305033b0f7f19f58520 100644
--- a/kernel/bpf/backtrack.c
+++ b/kernel/bpf/backtrack.c
@@ -746,6 +746,17 @@ void bpf_mark_all_scalars_precise(struct bpf_verifier_env *env,
 						i, -(j + 1) * 8);
 				}
 			}
+			for (j = 0; j < func->out_stack_arg_cnt; j++) {
+				reg = &func->stack_arg_regs[j];
+				if (reg->type != SCALAR_VALUE || reg->precise)
+					continue;
+				reg->precise = true;
+				if (env->log.level & BPF_LOG_LEVEL2) {
+					verbose(env,
+						"force_precise: frame%d: forcing r11%d to be precise\n",
+						i, -(j + 1) * BPF_REG_SIZE);
+				}
+			}
 		}
 	}
 }
diff --git a/kernel/bpf/states.c b/kernel/bpf/states.c
index d7df6632a5c47a422e9de50edb1fd753378a755f..37b96296e8835a61903cfffeece6a087771cb82c 100644
--- a/kernel/bpf/states.c
+++ b/kernel/bpf/states.c
@@ -1116,6 +1116,20 @@ static int propagate_precision(struct bpf_verifier_env *env,
 			bpf_bt_set_frame_slot(&env->bt, fr, i);
 			first = false;
 		}
+		for (i = 0; i < state->out_stack_arg_cnt; i++) {
+			state_reg = &state->stack_arg_regs[i];
+			if (state_reg->type != SCALAR_VALUE || !state_reg->precise)
+				continue;
+			if (env->log.level & BPF_LOG_LEVEL2) {
+				if (first)
+					verbose(env, "frame %d: propagating r11%d",
+						fr, -(i + 1) * BPF_REG_SIZE);
+				else
+					verbose(env, ",r11%d", -(i + 1) * BPF_REG_SIZE);
+			}
+			bt_set_frame_stack_arg_slot(&env->bt, fr, i);
+			first = false;
+		}
 		if (!first && (env->log.level & BPF_LOG_LEVEL2))
 			verbose(env, "\n");
 	}
-- 
2.43.0

