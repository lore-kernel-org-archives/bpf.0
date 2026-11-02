Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.38.64.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793646244;
	b=ol86P38o/HPPEL1xV6a1qVd5zuFx3TnENX0w2uCC67sd6WOrcW6ZZk9wd14zS2bbUyMb
	 0NDl+Kj4GDibtq3WCvB8x82ioiTIAath+9lj9ejO5mvgpzmqLGZriK+qxpfTFWkMqIyq2
	 uFPyL5fqQoD14ijwupWL07ljwz+IwniQYSplkMYci31ZC5wUyGKrAkncVu4OI1ePkdU5O
	 MWIzY4McfBV2Ei4RIaT0+97kjE7wCQWEXKxIBC5/BgUvP27jqv4x5LmhDRu/oVYVqFfRs
	 fu0/s5N0VZaUwBO/hFMeYBbg1LFpumI+fYG0nknD8R4acV1eKiz7lal82Omtxx4iT6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793646244;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=dDvsp6aJlGEKeDcATsJhzvMBBTR1XxWiEUqe9sFTARk=;
	b=lSlW8nVgAMzyFQRZzOvtKzrgAQUe87LLp5mUKroMxPpN1v4y6gpCys6OskjekXQA9QRs
	 G/z/zxf1eKUXL3zqVmxpRd97NMqA3DhpO8zNUywH1X0BTHgWCXDDJ9cvolRLwK3PETLxF
	 rz1P28YRa+40A+u97YM/Qafv+QInzy0O0omUoaqHjqVFzwoa7oFPNLko6srNxxShl+014
	 XPaWAY5N39SsfA2INxcx/fBYUuXQTjYxCo9nxzvbHhG1qLCj9WO3jX+bcNyynotRMGo5u
	 QW4DDiVOnOxYGeGnXc8/7AJ6o8VepHoEkLWjg/Lor4BtNnDQVWRjiWHow5gmbMVJS6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mail.ustc.edu.cn;
	spf=pass smtp.mailfrom=mail.ustc.edu.cn;
	dkim=pass header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.a=rsa-sha256 header.s=dkim header.b=nAEtmD4v;
	arc=none smtp.remote-ip=202.38.64.46
Received: from ustc.edu.cn (smtp.ustc.edu.cn [202.38.64.46])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E51BB606A326
	for <bpf@vger.kernel.org>; Mon,  2 Nov 2026 19:04:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E51BB606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.ustc.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.ustc.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.a=rsa-sha256 header.s=dkim header.b=nAEtmD4v
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mail.ustc.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-ID:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=dDvsp6aJlGEKeDcATsJhzvMBBTR1XxWiEU
	qe9sFTARk=; b=nAEtmD4vui31bBk3Bf6NwEby375p+K1n3YGwCe/KzKVbI9R0yb
	OpKv2zYGSdoAkGV5+EiEBaTyP4o1vV3xfzECzCTjxomUuWX0aKOKfv99VuOtcIou
	ahrgtaAczxzz21vi8nlVKcCvH8iTetjEiJAPv4BWc3iWFPANZM4KEn1GI=
Received: from localhost (unknown [222.195.81.114])
	by mailimap2024 (Coremail) with SMTP id 3pYKCgBHzECd3uhqVMx4AA--.1452S2;
	Tue, 03 Nov 2026 03:03:57 +0800 (CST)
From: Xu Yunxiang <xyx2021@mail.ustc.edu.cn>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: [PATCH bpf v2 1/2] bpf: Propagate scalar precision through stack arguments
Date: Tue,  3 Nov 2026 03:03:49 +0800
Message-ID: <20261102190350.788433-2-xyx2021@mail.ustc.edu.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261102190350.788433-1-xyx2021@mail.ustc.edu.cn>
References: <20261102190350.788433-1-xyx2021@mail.ustc.edu.cn>
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
X-CM-TRANSID:3pYKCgBHzECd3uhqVMx4AA--.1452S2
X-Coremail-Antispam: 1UD129KBjvJXoWxCr13Xw4UZFy8WF1xAw4fZrb_yoW5Wr4fpa
	s7GFnIqw48JFW7uwnxAF48AFW5Wan5Ar1UGFWxAFyIqF1jqryY9F4UtFyayF47trWkX3yY
	vFn0vrZ0va1kXFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9qb7Iv0xC_KF4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwV
	C2z280aVCY1x0267AKxVW8Jr0_Cr1UM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq
	07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r
	15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vI
	r41lc7CjxVAaw2AFwI0_JF0_Jw1lc2xSY4AK67AK6rWl42xK82IYc2Ij64vIr41l4I8I3I
	0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWU
	GVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI
	0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0
	rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r
	4UJbIYCTnIWIevJa73UjIFyTuYvjxUxcdjDUUUU
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
index a6ae86f973e359da688d51a3b3872f60c2ffa27c..50480c42bcad1e88fcb03146a9a876e06786bd9f 100644
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

base-commit: 03b013897454064e0a2d84a8ba9a24753eb02f2b

