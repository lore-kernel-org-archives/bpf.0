Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E15E548123D
	for <bpf@vger.kernel.org>; Fri,  4 Sep 2026 10:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788519488; cv=none; b=Lok8Y5K2IwdK3HForoV5mxDmFu0ltW8Tz3KTIaI/wAGVme1fBZ0sraI4Dms54mLOEVRxtppd4meFvXWNMXHt2ZwduaevE+/bSdUShnoLFxd0AavGX/OZFOMZvxWuPGx9pTYBySjZJxwyUwyiZ5f6AzgESq2C1wsMpFr5EyrmBqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788519488; c=relaxed/simple;
	bh=JtFt4j8cgUgUtFZaywPAlg51vNEpvkwM47kq5mj/13w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WCg2iYP2C5OImtQw6lvySg2SOHkoNQnSyEXKHAJxxldmcaUf2MFpyOqkMQqFRUp+aQLKokUbmxHk4pLqGfNNT6c8Ht/r6xrPzvpdQoVkSW4L8gxk9RazlcEChkECR9zk/vwtGrf89nqzLK0GUDwd3RIbsyd06dTjAgh/l+Na5DU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rcMM6y/1; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rcMM6y/1"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-398c1101c1bso826716a91.1
        for <bpf@vger.kernel.org>; Fri, 04 Sep 2026 03:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788519486; x=1789124286; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gH9gg1qvejjX/sPdW+X7GvG6xfgdjVwQ/p+bz1yISpM=;
        b=rcMM6y/1ucHSX+6iiz7HwLBqExzo8lJDQ4RgBIDizaeik0/2JIr6b25Yjz1spzBPzy
         fq8mt8daUjrYqkuLXf+PXuqTz1oEtcHcsZuxRXwiKqcyA0kxP97sT9seewcZ2dfkQXvP
         7Py1HDncvINLHyONVPwqeWCVO01v1UxY+zbZf1kRCdUzJG5m9QVV03SCeMH02v28LUrZ
         DaxfmBrAn+pC80EXg4epAdpRKY/F8k8rA4DBZgUf64FwJ9dNgte/gsKxMvSUkSvEEovN
         9WIKcggsMoJ7aTrZ+bOy1B84ZtZ+EzH6Vi5F4CpXaHZf7eIvf7E5FtRV7w+97Y9M2ajO
         +m5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788519486; x=1789124286;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=gH9gg1qvejjX/sPdW+X7GvG6xfgdjVwQ/p+bz1yISpM=;
        b=ZAJumP/Eq4T41aMjBG4uJdHLCRDyzYNIr98pw91zJEhcTh+AlciTl8MX9xuX0lO4qo
         o2P17vGeTeshRjXMaiPFl+Fp+Xjzil763s+NLyJAJcGwrN23C+jhHqL3sRubOQOqwCaO
         W2x96mqMbMhkDsOemVc/2vL8NaMNlgegbjHFnWJ/T7DXTEgTny4KDiukvDUH+EbnxBxS
         jGB7STLAaf70RSUiXJXbRNA2Qdk9N/p8c7Kf8lWLlMetp9/We2Ioehgfj95wrK7cwZq0
         o4p/YaGsGqnNXYpJ9J+lzc6x8zMyk/k6NCP5El1YAT1qjzLJoelQg/w/z8v/cBqs3yLT
         xiXg==
X-Forwarded-Encrypted: i=1; AKwUvBwmFB6LkPkF6pD/qxMrF6aZ4MBLzIBEvPiHH4bixG7xHN0c0GtVUJ7gu+xizOa1b7HuT60=@vger.kernel.org
X-Gm-Message-State: AFuF++kqyokpFzNEDRplqOzQdygJPiL698/nBoCVO0dCUrjYw3h/cTat
	QWgoh7M535vBbqIq3rNCg3X2arrWDysaviJQS7lZYZ+RJY+gGfX+gWpR
X-Gm-Gg: AYBFou1cJYO8EiobXHtGyRUqODKSRCyjv/pciUJGCi0WHZg2vkGvVltUK3MOa7nAt1x
	639oHtB3NGRsHvuS8nA3MIpdPfVeqkVaWYEkoNibeOFvzjf6OIYSYLxYBE9DMS0DjQT0s4zVhop
	9wirEI41SJTkJs5Lk/R86eCLe+sQ3im6xe6d5kFvqgAFXHyzbXMmHIAn8TNELk4L/td85fZhTw7
	De7ZBNcqriLF49crFW27s3fa9Pfth3R6KphPMv/rFtKNrSVnBtLoVgH1GKAwJ717j+Kj/cX+DEX
	TuJt/tpNERUGQ0yhURDtCBI/0w/aoytMEDTJ9y/84YxKoXuAcLbuRZWKp0oWanvrUq4XP54Rs8v
	CJ6+zX71mp9adn7LttruqSdFvqzLpojaQBT2/1i/KwIY0grE1AZF1x293t0xUVS5TyvPYr1BCqQ
	VVxk6WQF/hgWL096d0TDAf2vFDTdrPxrfoGrR4kAV1E5MCHiDzmQiFztsq2OmbueK75d5HKwVNi
	/iHWFtqkcEXjlI=
X-Received: by 2002:a17:90b:3810:b0:398:9beb:5c18 with SMTP id 98e67ed59e1d1-39b26213a86mr7980524a91.19.1788519486242;
        Fri, 04 Sep 2026 03:58:06 -0700 (PDT)
Received: from volcano9f6e-hostos.amd.com ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339b123731sm5523091eec.18.2026.09.04.03.58.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 03:58:05 -0700 (PDT)
From: Hemanth Selam <hemanth.selam@gmail.com>
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
	Hari Bathini <hbathini@linux.ibm.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Naveen N Rao <naveen@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 3/7] powerpc: net: fix typo "upto" in comments
Date: Fri,  4 Sep 2026 16:27:33 +0530
Message-ID: <20260904105743.39799-4-hemanth.selam@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260904105743.39799-1-hemanth.selam@gmail.com>
References: <20260904105743.39799-1-hemanth.selam@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Correct "upto" to "up to", reported by scripts/checkpatch.pl using the
misspelling list in scripts/spelling.txt.  Only touches comments, no code
changes.

Assisted-by: Cursor:claude-opus-5
Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
---
 arch/powerpc/net/bpf_jit_comp32.c | 2 +-
 arch/powerpc/net/bpf_jit_comp64.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/net/bpf_jit_comp32.c b/arch/powerpc/net/bpf_jit_comp32.c
index bfdc50740da8..cf8c1b49da25 100644
--- a/arch/powerpc/net/bpf_jit_comp32.c
+++ b/arch/powerpc/net/bpf_jit_comp32.c
@@ -23,7 +23,7 @@
  *
  *		[	prev sp		] <-------------
  *		[   nv gpr save area	] 16 * 4	|
- * fp (r31) -->	[   ebpf stack space	] upto 512	|
+ * fp (r31) -->	[   ebpf stack space	] up to 512	|
  *		[     frame header	] 16		|
  * sp (r1) --->	[    stack pointer	] --------------
  */
diff --git a/arch/powerpc/net/bpf_jit_comp64.c b/arch/powerpc/net/bpf_jit_comp64.c
index fc9db691e820..8a1a00026c69 100644
--- a/arch/powerpc/net/bpf_jit_comp64.c
+++ b/arch/powerpc/net/bpf_jit_comp64.c
@@ -23,7 +23,7 @@
  * Stack layout with frame:
  * Layout when setting up our own stack frame.
  * Note: r1 at bottom, component offsets positive wrt r1.
- * Ensure the top half (upto local_tmp_var) stays consistent
+ * Ensure the top half (up to local_tmp_var) stays consistent
  * with our redzone usage.
  *
  * tail_call_info - stores tailcall count value in main program's
@@ -35,7 +35,7 @@
  *		[   nv gpr save area	] (6 * 8)	|
  *		[ addl. nv gpr save area] (12 * 8)	| <--- exception boundary/callback program
  *		[    local_tmp_var	] 24		|
- * fp (r31) -->	[   ebpf stack space	] upto 512	|
+ * fp (r31) -->	[   ebpf stack space	] up to 512	|
  *		[     frame header	] 32/112	|
  * sp (r1) --->	[    stack pointer	] --------------
  *
-- 
2.48.1

