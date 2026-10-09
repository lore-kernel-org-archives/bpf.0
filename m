Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD743A6EEE
	for <bpf@vger.kernel.org>; Fri,  9 Oct 2026 17:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791567492; cv=none; b=oazY0ia3ym8bc1UmVxcwcp2lnihuKmELIw22IQVVsNheSfHAQzLUTbX2klXJbcahxVCbuHfBQdMqj0+bQb2LcV6e83tnuMTkymP7OL5XtAlupF988HX019epokxWpZJqkjUU4Sbu2Xr17cJluomPLEqyN3XQYwQUAa4YUnzkEXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791567492; c=relaxed/simple;
	bh=SoihR/1r5oIUijjdkzzmQKGpSTj9fP+xgs/rfmx4QBs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UWXZ+xGyak899MCYYOrshSBlzIs7HEoAOdMxyBQN48vhcgzSNoNgofiUM+SM9WhM/37nOztyd2XnD7mTUYPMLoT9y5GXb4r/V46UAaR24ztEeDFvYtRCOsBLDHQhDPqPugYB8JHvzGE1tyQ/W7RWBnJWH8ZXs/I9XtQ7/bbirqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=njW8wTG3; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="njW8wTG3"
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-824329dc1ecso45225a34.1
        for <bpf@vger.kernel.org>; Fri, 09 Oct 2026 10:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791567490; x=1792172290; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=QNIlTnHi+YxWylz7AkakSHgtCnUqszk6I0tbLDOt9L4=;
        b=njW8wTG3doCqQiFxPXey8XeWsGBgELLcY1y7I/bOIUEp8pMd6oa/QRFvzYFP2iEsLj
         QzfXpnam5qa/4/oRlLAxbV1OWXipOS32jhlIH8mfL+u2GqfCSKu9HU6KNeO5AoQG/Abh
         s/1uFou8vUTDc3AJl27fF92QBvDzf9UpB8jUB1JtI0dUR9i1hMUg+3IGN6wLvCKmlwM9
         cDM1HcrOFuhB/086eQVmWYunwQmBUgrcg/dg9PNAl6zQTq6D/52B8BkRuCd/Mu20s1UY
         R+cYU47S9IOUzARJLXgGPFDxRlr/pPPm/TdyKTLPVJveTf3be/f71kj29xKxjwt8WmaH
         DI0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791567490; x=1792172290;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QNIlTnHi+YxWylz7AkakSHgtCnUqszk6I0tbLDOt9L4=;
        b=oA2I4bvz0nfyU7DOITIQ8Rm+kN2JoONrNQTba+qU2IbqpfEY52CqAnQQsM5HLjx7Ei
         HwyiRrW97a7p2ylQJjy2CTc9XB0ubUSX2OGhLqeBcBhqt7WTLD9UyOqycIBc9AdpUofs
         BezXbxoaSgHTg6SMP08TgFb8CIGiiDnUK5pB1PhmOVOUVlA/Bho9xa0ePFeGmQICs5TT
         ghhpqk5BxaJ5dI8b6yWc6jROTQkmapSfQvIFwisBecl5kHiKTbAHmKTilN2azAuCGPAk
         qCfEIliiMNaKEePR/ENIyfaXbNC2vzVrUw8qmrvJOeZOmVi5FZbGPiFaQVUOs4YNr0so
         u3AA==
X-Forwarded-Encrypted: i=1; AKwUvBwCiQ3sEdTLyGLkcLUoC1DhZCh3FHVkcp8UdACe7y5vOBcRRKrF08x4V7ieEmEZS6kuxf0=@vger.kernel.org
X-Gm-Message-State: AFuF++kn+l1kkeefwGUniRnyG3aPJcJOnhuUurCZv6u/wE1RhZVuR3Ww
	tvFy9vsH20Sl1cCxH/QWZAm/cRehteNL+MYS2CT7kDPztEO0Qflxwk3Y
X-Gm-Gg: AYBFou0JqWEIA0XZ6UtlP6eQy8/3/vkSmN0MZ4BfRJRG4MfcFGcqzANcT+MkmPhh1PL
	SDJjn2yLb67ISZAPPujMp4kcLmNneQdTwlrlc3FypxG8zLKes4lNFWE6fjDSy075tZHCg0HZNPc
	XlVvgHvtAhCdEf5aj20qIuuBkvex355vFS7uvP2IVDiDVsDwn1LuD4YpK3Gx+t6pYSNpbz1+mc8
	q/gmfdKWRqzxKsmKfEffLW5Sz4TcY411bz5Y/wXpCaCyhnqHpJw5yI9jhz6iWFOa3mr03QRpMYf
	vKKYk1TICkRAr2VZKu2H67byYBqt7/uXi8HVy0subt+LCcS+ma2AJmLQopOB6lppmzmGRsglhgg
	4Z1A0QarN5i4UnVTUwXVIjU5yDB9yBrRfQetVCtnC2upoL1Unw3U3FVXwVHyj1KRCCJptGENrw3
	FAXs3HCbJnp0Z/8B/qnTuJ7rzQz1s8PCcsVb+g6NulYzrTAvgf6RpzcmZJPbsvjwCAT9KaGaIBK
	9KPFP4=
X-Received: by 2002:a05:6830:6502:b0:81b:9d18:761 with SMTP id 46e09a7af769-83095c2c6bcmr2158334a34.12.1791567489732;
        Fri, 09 Oct 2026 10:38:09 -0700 (PDT)
Received: from localhost ([2a03:2880:12ff:9::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-83039076dc3sm2620678a34.14.2026.10.09.10.38.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 10:38:09 -0700 (PDT)
From: Matthew Wood <thepacketgeek@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Puranjay Mohan <puranjay@kernel.org>,
	Xu Kuohai <xukuohai@huaweicloud.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>
Cc: Breno Leitao <leitao@debian.org>,
	bpf@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf v3] bpf, arm64: Fix racy plt target update in bpf_arch_text_poke()
Date: Fri,  9 Oct 2026 10:37:59 -0700
Message-ID: <20261009173802.1248441-1-thepacketgeek@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a long-jump trampoline is attached to or detached from a bpf prog,
bpf_arch_text_poke() updates the plt target at the end of the prog by
temporarily making the page writable:

	set_memory_rw(page);
	WRITE_ONCE(plt->target, plt_target);
	set_memory_ro(page);

Since commit 1dad391daef1 ("bpf, arm64: use bpf_prog_pack for memory
management"), bpf progs are allocated from the bpf prog pack, so
unrelated progs and their plts commonly share a page. The sequence
above is not serialized against other pokers, it runs before text_mutex
is taken and callers only hold the lock of the trampoline being
updated. Two CPUs attaching to or detaching from different target progs
in the same page can therefore race:

	CPU A                           CPU B
	set_memory_rw(page)
	                                set_memory_rw(page)
	                                WRITE_ONCE(plt_B->target, ...)
	                                set_memory_ro(page)
	WRITE_ONCE(plt_A->target, ...)  <- permission fault

This was hit on an arm64 server with 64K pages while attaching fentry
programs to bpf progs:

  Unable to handle kernel write to read-only memory at virtual address ffff80008f46d5f8
  ESR = 0x000000009600004f
  FSC = 0x0f: level 3 permission fault
  pte=00c00200ea5a0783
  Internal error: Oops: 000000009600004f [#1]  SMP
  pc : bpf_arch_text_poke+0x214/0x238
  lr : bpf_arch_text_poke+0x200/0x238
  Call trace:
   bpf_arch_text_poke+0x214/0x238 (P)
   __bpf_trampoline_link_prog+0x1c8/0x470
   bpf_trampoline_link_prog+0x64/0x90
   bpf_tracing_prog_attach+0x318/0x4a8
   bpf_raw_tp_link_attach+0x104/0x258
   bpf_raw_tracepoint_open+0x6c/0x90
   __sys_bpf+0x134c/0x3e10

Rather than serializing the permission changes, stop changing page
permissions altogether and write the plt target with
aarch64_insn_write_literal_u64(). It writes through the text patching
fixmap under patch_lock, the same way the rest of the prog pack is
written, and performs a single-copy atomic 64-bit store. The plt target
is naturally aligned (see build_plt()), so CPUs concurrently executing
the plt still observe either the old or the new target. This is the
same helper ftrace and static calls use to update 64-bit literals that
are loaded concurrently.

Fixes: 1dad391daef1 ("bpf, arm64: use bpf_prog_pack for memory management")
Signed-off-by: Matthew Wood <thepacketgeek@gmail.com>
---
Changes in v3:
- Consolidate nested if statements & merge comments
- Remove no-longer-used asm/set_memory.h include
- Link to v2: https://lore.kernel.org/linux-arm-kernel/20261002121233.561368-1-thepacketgeek@gmail.com/
Changes in v2:
- Replace page permissions change with call to aarch64_insn_write_literal_u64
- Link to v1: https://lore.kernel.org/linux-arm-kernel/20261002044050.1277356-1-thepacketgeek@gmail.com/
---
 arch/arm64/net/bpf_jit_comp.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index 475e70653454..cf356f0ce213 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -22,7 +22,6 @@
 #include <asm/debug-monitors.h>
 #include <asm/insn.h>
 #include <asm/text-patching.h>
-#include <asm/set_memory.h>

 #include "bpf_jit.h"

@@ -3338,21 +3337,22 @@ int bpf_arch_text_poke(void *ip, enum bpf_text_poke_type old_t,
 		 */
 		plt_target = (u64)&dummy_tramp;

-	if (plt_target) {
-		/* non-zero plt_target indicates we're patching a bpf prog,
-		 * which is read only.
-		 */
-		if (set_memory_rw(PAGE_MASK & ((uintptr_t)&plt->target), 1))
-			return -EFAULT;
-		WRITE_ONCE(plt->target, plt_target);
-		set_memory_ro(PAGE_MASK & ((uintptr_t)&plt->target), 1);
-		/* since plt target points to either the new trampoline
-		 * or dummy_tramp, even if another CPU reads the old plt
-		 * target value before fetching the bl instruction to plt,
-		 * it will be brought back by dummy_tramp, so no barrier is
-		 * required here.
-		 */
-	}
+	/*
+	 * non-zero plt_target indicates we're patching a bpf prog,
+	 * which is read only. The prog may share its page in the bpf
+	 * prog pack with other progs, so write the aligned target
+	 * through the text patching fixmap without flipping the
+	 * page permissions to avoid racing with concurrent pokers.
+	 *
+	 * since plt target points to either the new trampoline
+	 * or dummy_tramp, even if another CPU reads the old plt
+	 * target value before fetching the bl instruction to plt,
+	 * it will be brought back by dummy_tramp, so no barrier is
+	 * required here.
+	 */
+	if (plt_target &&
+	    aarch64_insn_write_literal_u64(&plt->target, plt_target))
+		return -EFAULT;

 	/* if the old target and the new target are both long jumps, no
 	 * patching is required
--
2.53.0-Meta
