Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FE7621A447
	for <bpf@vger.kernel.org>; Thu, 15 Oct 2026 03:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792035420; cv=none; b=nwCPS5bMT01U0+b0dbpHzOjSkdDhJeEWdFo9ycKjAnLRm9HsmhWcT9e7HZlPzMJ5OF71sf4o/9zbN/3pqrPDiEbJK/GoUstzymZFP2uaFZsQoM7PV/5mH26R5EapILuv0TJMk7L7ATxgpFzAEJk6iuzhHjh+UK7h2txDMOmrjcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792035420; c=relaxed/simple;
	bh=wl78XntOxtS0v5cmuSFy2Rul8ehDfZ6ttebl81pR+6U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=snpgbW4+4BPde4J65TAXwBdNDO2wUgnmmfefegCSqlMdpzy0Kt3elrzdasnZs4UpDoFyQjU8632aYqTQCWYxJvqlfyhS4a7jILYpZ+FQvbKNvGTJbJ8B7owHb8Npt5LSD8vb6VIL9c8isLqNVs+IPEA6fm3gBsLl2wgVk6cw8Ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dvRd2D8v; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dvRd2D8v"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4a021c809e3so45626995e9.0
        for <bpf@vger.kernel.org>; Wed, 14 Oct 2026 20:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792035417; x=1792640217; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=pvsVhU4kPk1tZp2qz93jFIik1GpyvPqpcxvOW0J3Tx4=;
        b=dvRd2D8vT2ptimEjQ4/30lNKvl6hMYQxTvC4QQ6huKl4+rQ/Luy3VOd/iz4kEOxsHv
         fJECOnTSKS+Lrt3kR85xGKnGZKDsVGUVGxbRK7FbrR+n7fGv+18rBmbwbRLf4/upNgyK
         Civd/c30eZkWUgWY3wKvSpaYAmUQ3O8F3iHm13zSr905o0WAl4oDBYW1C3Zhei+looXo
         EvQLUvsTHfdMztl0APdpovwfmb1MZrcywgleEdKzofxGW1gkvfsNGsnjQUcOsQV2Z1/H
         n3GYI9iDoRCBjMl0NJVen9X7hQi4v61gv6FOkC9lzk5j4XtJgH9S8+vM+vh9bfGH68CA
         H4hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792035417; x=1792640217;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pvsVhU4kPk1tZp2qz93jFIik1GpyvPqpcxvOW0J3Tx4=;
        b=ak0+6SSdphuyd+/HtljXfgvclMvif6FAMcxJMv7DSSKMW0JFtTkWj+iOZpyGsy+Tbx
         Crd2py1OLAVWqbebGdRAj8ATF7OEA+7vYsWfdZLm0Vh8CMIVLDWHtYxwXxysYJGLOiyv
         E+U8VKlduO25teXTJg4DecOwC0eQq8EDLAcqUD15cZIdKWoJIf/LgxYcqofT1/+4P40f
         aRZ90Pc163VU0d8PBOKWKv7LoRJjxIkcT1loNQjalybykMbiot4GRv3Puk27OZoh97D0
         Aj4N4V7oVbDpWcs3IInqT433787ggnvT4veW0FxLEDIAFSJcedE8zwoMc3PIhaLqrRYK
         YUbw==
X-Forwarded-Encrypted: i=1; AKwUvByK4GC/L8szUVujz8MvaA5Ri+5s8IWtfsjkZ7VOOniM8WeYnTFSCLfp9kccDlXU9D1Tvko=@vger.kernel.org
X-Gm-Message-State: AFq9FYJg6L+BarNLVqRuyYWjNU/S3bGY5OyM4sT70jQe5FZC7HAoTnac
	9dM7RLim9fgKiZjVT8+o9NdEqQTfewBKymGHS1XxhIv9E56G4a/KSfXVM4A9G67Z
X-Gm-Gg: AYBFou0NDXsMoRJ/jdGHr+QOl7TXDwgv+JxR9pZzfRBtUrzbF9qIC2/3Q0lVLNJlvtG
	pBMD4g8DePzcRzMvAfhLaoFD33QL2x5nxHr2LRVpHNKsf45Hnr3A8t92MocqI1EBE9HnrdGSsKj
	IGD12usx2lg2vZFOoPAVD6f2+wt9WDnW+Bs5oVmziiW8NL9JnivfBlVsWCXRGqeW8ueiBM4Kj1o
	KYsYAi/07R/03ka2fjHETRyWuyT074NttqNyORQbOqWVu+zzlt9E7UmXaaT05O3s+VHrSYDKUe7
	b6qAE3JzuSOplcV3PZzxLuzI7I1xLJC3Cn1Qal8eLl266kdDzXosf+pU07Z2EGQ4CBclS1MlDR0
	e37NSE7ZvtHBEblxQ3REpoVd/9N+K4myhOfPi+h1d39no2pFhflDzXigpNRPp1g+h5c1ZxoLLqk
	v3iy8x9P4Ua8aFuSATmTCqZ2mFrrWxOCR6+N7RIrp4opitrISTnwa5SzwQGXdIPFpr3NAfLvD8k
	nCGT9BOaxoVJiSRBMQmb2U1cnsotquHKDOjFLgDZDcexwjYCUGprAvdaQegaerJW1q/coAstpjp
	jWloxkFgJti73AI22Bgp3F1OoN0Eru1NcVkAFmDPXntoos/LdHj68xuzfSSWpL4ElOLE9/3w2Y9
	UFBJGRAWGwFJVKeUdmw==
X-Received: by 2002:a05:600c:c3cc:10b0:4a1:a7f8:c12b with SMTP id 5b1f17b1804b1-4a1a7f8c219mr123205845e9.19.1792035417351;
        Wed, 14 Oct 2026 20:36:57 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-aeb3-cd01-f139-812c-65df-b930.310.pool.telefonica.de. [2a02:3100:aeb3:cd01:f139:812c:65df:b930])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48df5c3b89csm603500f8f.23.2026.10.14.20.36.55
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 14 Oct 2026 20:36:56 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Mike Rapoport <rppt@kernel.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	linux-riscv@lists.infradead.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] riscv: mm: Pre-allocate module page tables for execmem
Date: Thu, 15 Oct 2026 05:36:43 +0200
Message-Id: <20261015033643.84972-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

RV64 pre-allocates page-table levels for late kernel mappings. The module
range is guarded by CONFIG_MODULES, although execmem can use it without
modules.

With CONFIG_BPF_JIT=y and CONFIG_MODULES=n, execmem adds a mapping to
init_mm while the current process retains an empty PGD entry. Initializing
a BPF program pack then faults:

  Unable to handle kernel paging request ...
  [ffffffff78000000] pgd=0000000000000000
  ...
  bpf_jit_fill_hole_with_zero
  bpf_prog_pack_alloc

Use CONFIG_EXECMEM for the module-range pre-allocation, as powerpc does
for its execmem page-table setup. Both CONFIG_MODULES and CONFIG_BPF_JIT
select it.

Fixes: 2c9e5d4a0082 ("bpf: remove CONFIG_BPF_JIT dependency on CONFIG_MODULES of")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---

Notes:
    Tested on a BeagleV Ahead with matched LLVM 18.1.3 builds based on
    v7.3-rc7:
    
    - unpatched: a native XDP attach triggered the Oops above
    - patched: native XDP attach and detach completed without an Oops

 arch/riscv/mm/init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index fb37b0b67efe..d92342c162e2 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -1437,7 +1437,7 @@ static void __init preallocate_pgd_pages_range(unsigned long start, unsigned lon
 void __init pgtable_cache_init(void)
 {
 	preallocate_pgd_pages_range(VMALLOC_START, VMALLOC_END, "vmalloc");
-	if (IS_ENABLED(CONFIG_MODULES))
+	if (IS_ENABLED(CONFIG_EXECMEM))
 		preallocate_pgd_pages_range(MODULES_VADDR, MODULES_END, "bpf/modules");
 	if (IS_ENABLED(CONFIG_MEMORY_HOTPLUG)) {
 		preallocate_pgd_pages_range(VMEMMAP_START, VMEMMAP_END, "vmemmap");
-- 
2.43.0

