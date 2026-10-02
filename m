Received: from mail-oi2-f43.google.com (mail-oi2-f43.google.com [74.125.231.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B594F2D9EE7
	for <bpf@vger.kernel.org>; Fri,  2 Oct 2026 12:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790943157; cv=none; b=CCxoNtYkjknR2pmWZrSR6FGxvm8HEQphAECH90V264k1w1WzrFKXHI2j9NHo4+69yuLcELvg3NRlFU2VhtjemJkK7vCHXIMRuD00+RQoWK1SEjfOzu114OyzuRFcjt992kbYgU39nIbZ97xlRZZLGbbJpCfdBYXNo4z3A8fH8mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790943157; c=relaxed/simple;
	bh=E1TRzDYd12tNpsM0OfO5X8br7h+EQkP9n3ZjhaF1+1g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RuBfn3gkc2/MbKNTiDs4e9niiXiLRrWEdFjLm4CW6eUy0qbDu9JPssBam4UMiLFQ0V19jeEWVdkpl+GsismE/55YmqD7pMBDznC8nTNm+/24e8n0xfQUbqCdzoPkf9kVJSNXCOY40WMsy7jNKaCmc/TV2yRtB5pX3ycs1+xq9rQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IoX7YFxP; arc=none smtp.client-ip=74.125.231.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IoX7YFxP"
Received: by mail-oi2-f43.google.com with SMTP id 5614622812f47-4cdcfa4d904so1369148b6e.0
        for <bpf@vger.kernel.org>; Fri, 02 Oct 2026 05:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790943154; x=1791547954; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=81uGpmP7cmZ5oefPKsTcsvoJoAO1uuBsnrj4SEE2374=;
        b=IoX7YFxPIcdu3uyAc/OBm14rDWq9jy9NfO2PeXWWKQuOA3zJ5TLojDCHFu7LP1Kyid
         yaU5viRyfF7kEoJJIF1BI46UaRDlAJbdLHKaI4vE0EYhBjmwNEersaJarFRx9jUBYg8L
         x+lNMWW0KeCQwONNyDEvKO9T6WVEUkc2O43opBcf4E6YL5TFJCOOeV0fdqQXB0IDjn7U
         GOE7MuKx05sXbtlrxEpI4jb6/07yz/rkkmASm2HL3NFdUP+dxeLI5ptDWU5HXtcCVA4B
         Yk0QINjVcR/7gnYv29NF0lpJXfHoWs7vFScLg3IxrgwvbS6PIodBgWXob8s7ywFSALGt
         2URw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790943154; x=1791547954;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=81uGpmP7cmZ5oefPKsTcsvoJoAO1uuBsnrj4SEE2374=;
        b=loMEhoZeKHkckzBQKwuTtEBpc6mHRD31M9fVoaBgnRXIOKfvD9lPXuSbkMbuJRAUvd
         XktJ9BnXTxgNforaLNb4aXLE7CGXnF1pJBR7h08nqwhM0nvNdxUqyn5gP8ZbUy4pebJt
         0+Z3Z3xLUrzGFu8zejmERMPmFHipdz2KXqBKBPlEMITIgqTotk53x0HM9AwhHUN9Axh/
         fm2ego9xCHe0k9MsLFN0+YOkRk2uBgZS+Oj+2m1DhA50GgIFaUNY2/y1kABuaVRtVe04
         1GlyFMEEkCj0S8g3Z2/o1ZYgnl1tEeP4b9FAB3du9GU7aAFWGcndxCnBM99UsOKggNQZ
         +hZA==
X-Forwarded-Encrypted: i=1; AKwUvBxhr2mrExudmQegqOh83xbsgyoXiuhC/dWjwzAKNfmsm2lJ8pnOjOTV/dw9jaExER6PDs8=@vger.kernel.org
X-Gm-Message-State: AFuF++kGyCYhkKSbXImsR3kpxDljOfRS7cfDnuo/G671Yigt2StEt1eH
	HYyxeb4qbRgmWPAgssgUtJpeqYa02lajLawCg3Vp4/xj+GkKrQ+bIYZp
X-Gm-Gg: AYBFou3KjLBtkvKhhzxOlfTxtiQtVGOPcTi3y0WWlUr0pzanqczYTm9w98U1I8/jsyc
	3o6pc8PJabTNvBaPvXSHBoUQaJ7d78RFzKrXoClldWAz6m1caKQf5KnheS7ICUhWyAvwPH5/9gE
	YXd1wlDO+fKNWhe9UE21XubDo1pi6T4lGyeK3SqcQ0+NRx0FbpCfuTyGtCLul1NtXbygoi4S3CR
	igNLuiS4TYXTWGxSoSXNrryLzFtqyB8J7Ze1e8DVnITEj6dmbnK70pYQ8KzNuPQIZk1BDkct1k3
	3DW0aIoASNGCLEtrcUNGSg+YzhAwHkbYQyKBde+UNHuD5qfF0djW+cetM4i0JRypSYAU3RTz4mY
	tjvHKYMSKe71Q93O5WYG24WE28FT5pMMIO0pZKLOo3MdKOStbycEOD5X0MBiGp0L+6kj2GxNESY
	NuRIl15uMnEhiU+4vLmYbY/oUfbQ2SHQz2WV3wl1y7iq92UmLRKai78jtrPXB3KolAYLxr/g==
X-Received: by 2002:a05:6808:14c2:b0:4c3:cec9:fd18 with SMTP id 5614622812f47-4f528ccf57emr1327475b6e.11.1790943154581;
        Fri, 02 Oct 2026 05:12:34 -0700 (PDT)
Received: from localhost ([2a03:2880:12ff:43::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4f524cd09e2sm1963119b6e.14.2026.10.02.05.12.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 05:12:34 -0700 (PDT)
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
Subject: [PATCH v2] bpf, arm64: Fix racy plt target update in bpf_arch_text_poke()
Date: Fri,  2 Oct 2026 05:12:31 -0700
Message-ID: <20261002121233.561368-1-thepacketgeek@gmail.com>
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
Changes in v2:
- Replace page permissions change with call to aarch64_insn_write_literal_u64
- Link to v1: https://lore.kernel.org/linux-arm-kernel/CADvopvZPO1gDMDhDOPcArjRJ0cPpSUZ5suMg-1kwRi+_-Xeitw@mail.gmail.com/
---
 arch/arm64/net/bpf_jit_comp.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index 475e70653454..e353403cc1c3 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -3339,13 +3339,15 @@ int bpf_arch_text_poke(void *ip, enum bpf_text_poke_type old_t,
 		plt_target = (u64)&dummy_tramp;

 	if (plt_target) {
-		/* non-zero plt_target indicates we're patching a bpf prog,
-		 * which is read only.
+		/*
+		 * non-zero plt_target indicates we're patching a bpf prog,
+		 * which is read only. The prog shares its page in the bpf
+		 * prog pack with other progs, so write the aligned target
+		 * through the text patching fixmap without flipping the
+		 * page permissions to avoid racing with concurrent pokers.
 		 */
-		if (set_memory_rw(PAGE_MASK & ((uintptr_t)&plt->target), 1))
+		if (aarch64_insn_write_literal_u64(&plt->target, plt_target))
 			return -EFAULT;
-		WRITE_ONCE(plt->target, plt_target);
-		set_memory_ro(PAGE_MASK & ((uintptr_t)&plt->target), 1);
 		/* since plt target points to either the new trampoline
 		 * or dummy_tramp, even if another CPU reads the old plt
 		 * target value before fetching the bl instruction to plt,
--
2.53.0-Meta
