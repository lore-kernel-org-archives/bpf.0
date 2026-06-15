Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 826683C0A16;
	Mon, 15 Jun 2026 08:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.164.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781511012; cv=none; b=UB20jaTgqbTcNhWuyr9UtWe9daQNu57ryuDgnRpp644TLH/E0n0/tnoYW2zFUzxLOC7DRgMLzyPL7xqd4Zka4tIT4PNjl/d0kmDt/YiR8S+LBh6IZT0IqUc4OhnuzrogrhJWStPpYe21GIXUmpP+3AjwvkX5i/mhR+Yi2RaI2H0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781511012; c=relaxed/simple;
	bh=uORuALk+uTPXVC4G/DmCc3zHesRqlCytr+WfQU8HQrs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OgMqu7uJ9Lw7AirlNODUP7er1R35FaHx28GGezvjq5OPtloY5T/bD7IDElWkVp3hKKt6+9kaCHDFaJxgdVLrCtPL7RwUpcucjLp8ENllN38+hRQZuW4rC9Gq3ltu7lSLVkQWibFcsbZDdwGhw9UqZRsXejFZc72RAd7FQBUD5oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=dSUsOvp4; arc=none smtp.client-ip=162.243.164.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b="dSUsOvp4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:Date:Subject:
	MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	References:In-Reply-To:To:Cc; bh=TOjQORQFh9NCz0+U4YFbAtKq5Cs7dfL
	OwKv18hFTr9s=; b=dSUsOvp45uiSFb8iIdKv4Tpqm+oURHpARByTa6gZs+66cDx
	FOew56ltOZA3GUO/bJTPtg/e9C6DZ3nfopbrwZGMPV9BWxNdb+CAL+eakJZAC1+4
	HumGoJ+Kq/YxevgtSRC+QhscJidNvTrC8URbhbirdBD7vuJhX8dIWlr+K6i8=
Received: from [127.0.0.1] (unknown [101.6.30.195])
	by web4 (Coremail) with SMTP id ywQGZQC3y6BWsy9qKJVJAg--.52153S3;
	Mon, 15 Jun 2026 16:09:59 +0800 (CST)
From: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
Date: Mon, 15 Jun 2026 16:09:53 +0800
Subject: [PATCH bpf-next 1/2] bpf: Preserve pointer spill metadata during
 half-slot cleanup
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260615-f01-06-half-slot-pointer-spill-v1-1-47f1c18a8965@mails.tsinghua.edu.cn>
References: <20260615-f01-06-half-slot-pointer-spill-v1-0-47f1c18a8965@mails.tsinghua.edu.cn>
In-Reply-To: <20260615-f01-06-half-slot-pointer-spill-v1-0-47f1c18a8965@mails.tsinghua.edu.cn>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, Shuah Khan <shuah@kernel.org>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781511000; l=2173;
 i=gnq25@mails.tsinghua.edu.cn; s=20260605; h=from:subject:message-id;
 bh=uORuALk+uTPXVC4G/DmCc3zHesRqlCytr+WfQU8HQrs=;
 b=6RR7bMd57EzU7sLiVhygpbPl6Fr+IUm+pV51NKW5TbgwPfhVpap7MDjRa7SLAgu0c2/p52yc7
 Dbq4LJLH9iHADUEi5Lo2TyfuOYn+7mxZB/Wf30vhRU/Ntk+Pf1T8DUz
X-Developer-Key: i=gnq25@mails.tsinghua.edu.cn; a=ed25519;
 pk=nqQ48fAxVTDp3z/IUmqv6BB+agXPpd8tQjDOBxwlgZo=
X-CM-TRANSID:ywQGZQC3y6BWsy9qKJVJAg--.52153S3
X-Coremail-Antispam: 1UD129KBjvJXoW7KFyxuFWfGw1UGr1Dur1ftFb_yoW8ur45pF
	yDG3W7Gr4kJw1I93ZFvF1kKryDGF4kXw42kF1UGryIgFyrGry2vFs09ayrAa1aqFykA3yr
	ArWFqrZ0k3WDuFJanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9v1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l8cAvFVAK
	0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4
	x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJr0_GcWl84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2
	z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4
	CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E74AGY7Cv6cx26r4r
	Kr1UJr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc
	8vx2IErcIFxwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCY02Av
	z4vE14v_GFyl42xK82IYc2Ij64vIr41l42xK82IY6x8ErcxFaVAv8VW8Ww4UJr1UMxC20s
	026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_
	JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14
	v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xva
	j40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JV
	W8JrUvcSsGvfC2KfnxnUUI43ZEXa7VU0Ysj5UUUUU==
X-CM-SenderInfo: xjqtjko6pdxz3vow2x5qjk3toohg3hdfq/1tbiAgATA2ovr8QHzQAAs2

__clean_func_state() cleans dead stack slots in 4-byte halves. When the
high half of a STACK_SPILL slot is dead and the low half remains live,
cleanup converts the live low half to STACK_MISC or STACK_ZERO and clears
the saved spilled_ptr metadata.

That conversion is safe only for scalar spills. For a pointer spill, this
metadata clear lets a later 32-bit fill from the still-live half avoid the
normal non-scalar register-fill check and be treated as an ordinary scalar
stack read.

Leave non-scalar spill slots intact in this half-live shape. This is
conservative for pruning and preserves the existing
check_stack_read_fixed_off() rejection path for partial fills from pointer
spills.

Fixes: 2cb27158adb3 ("bpf: poison dead stack slots")
Signed-off-by: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
---
 kernel/bpf/states.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/kernel/bpf/states.c b/kernel/bpf/states.c
index 32f346ce3ffc..ea2153cf28d0 100644
--- a/kernel/bpf/states.c
+++ b/kernel/bpf/states.c
@@ -436,12 +436,10 @@ static void __clean_func_state(struct bpf_verifier_env *env,
 				continue;
 
 			/*
-			 * Only destroy spilled_ptr when hi half is dead.
-			 * If hi half is still live with STACK_SPILL, the
-			 * spilled_ptr metadata is needed for correct state
-			 * comparison in stacksafe().
-			 * is_spilled_reg() is using slot_type[7], but
-			 * is_spilled_scalar_after() check either slot_type[0] or [4]
+			 * Only scalar spills can be degraded to raw stack bytes
+			 * when their high half is dead. Pointer spills need the
+			 * saved spilled_ptr metadata so partial fills keep
+			 * rejecting as non-scalar register fills.
 			 */
 			if (!hi_live) {
 				struct bpf_reg_state *spill = &st->stack[i].spilled_ptr;
@@ -449,6 +447,9 @@ static void __clean_func_state(struct bpf_verifier_env *env,
 				if (lo_live && stype == STACK_SPILL) {
 					u8 val = STACK_MISC;
 
+					if (spill->type != SCALAR_VALUE)
+						continue;
+
 					/*
 					 * 8 byte spill of scalar 0 where half slot is dead
 					 * should become STACK_ZERO in lo 4 bytes.

-- 
2.34.1

