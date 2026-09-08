Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22BFB25EF87
	for <bpf@vger.kernel.org>; Tue,  8 Sep 2026 05:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788846572; cv=none; b=qp4gZMN/kweSOnI/PIlax68JRnS75wlKmb7VzcgeKzNjbIJntZKNB2v2I+uerKyhaqFX3p8+mROX7B4CiliHweT2JwxgQk53I26TZgKkS+84yZFp+7CcQohY60qj7qAwEo1iQGR/ZnrW7nhol/f6p8mOM8tBwM5KPmZKwvu8eDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788846572; c=relaxed/simple;
	bh=JtFt4j8cgUgUtFZaywPAlg51vNEpvkwM47kq5mj/13w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ct36Zd4FnGPvlKJyBkv0ijEtOAUPR6AIiqidaxDnG+HPoTwYCWsTOUESc+c7c7vocP3G1dVMNUAok30IjWk+Wm9v1Sy/AgMYhkCg3MyRGlZ03ijr8lJ6g1CMe8GGu4MQLUXj1VRhsssnj3kLpXfJjGG7lBKq1gb402/XJV0KLOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KxYQMfKr; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KxYQMfKr"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2d6efd73032so43044435ad.0
        for <bpf@vger.kernel.org>; Mon, 07 Sep 2026 22:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788846570; x=1789451370; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gH9gg1qvejjX/sPdW+X7GvG6xfgdjVwQ/p+bz1yISpM=;
        b=KxYQMfKrV74qPkPPM2bTlOxktmSdRfJItAr9ECsa7mcdulNiD/1sRiZpIPybzG4X8x
         cKourTIHCnXxJq4krYsX1Sv+5oSuP9vIThqjwEjBWsv17n1NRGvhl23um9eZFxdgQGOh
         yRJu3vI+8JV4/i/QeysZtlUtxF84a7j6V2B8tC+Mrg6mw7dzkR+oP/6ZDMmRJXtubNlA
         hxS8oqgrEjmMmx5BjN7B8uDKWWQikmEvKWGW83G+FO5CngfJpcjN2fk4Xntem8J2xH5q
         KZ0ETPRM/tE7aBuYmeP8NpCTp+ItxUS2o6936fR9dYo4Us8XkAU+3LDMDINnfm6LM3Mx
         T58A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788846570; x=1789451370;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=gH9gg1qvejjX/sPdW+X7GvG6xfgdjVwQ/p+bz1yISpM=;
        b=qI7Iq4M6accsL306zD1ILx4QVOOYQGrqCWXbujjlEG86Yey/0i89F34RPVn5v2JLL0
         KOFSV4LYpXuiJ6ke2FQgGnysPidyLXb8d9fsmX8DfrSq2Y6x+btDu3lTIW3/BPuYIUGf
         LV4VLVL5mfkd4jdHIesU/Y8DKdpAPM+HZdbOlafCNC5YWGS5fKAwntJAiwttAuekI8hE
         nOUIcr1dJph2K/Tzwbw9KJKs2t01GbKKpPKIRHpWR9nUjcPLjJUK4jO21/v4lijSd1NF
         ucRADv+Fb9aT3IZUKTwhT8ko/uCyTrmBkwA9KgDfIaV+lmyZUcZuSxNF7NRfuGVVgm+a
         yXtw==
X-Gm-Message-State: AFuF++nLYMg/Mtw3KSrGWY3VCUcm6xE3rFRbXP4rzAmkG1EJuIjjkXAA
	VcPBwMwHaITERrFogmzAugfgXr06OxrJV43+2QhY2e6h7zKJBU3diZp7NMkbenPnmJU=
X-Gm-Gg: AYBFou0zdLOnjpyuqredr5DVjscoPbn9V8CzVGg9TqyQ80MiI1aRGmBBzQH48U2fdax
	8SujXV5AaMFrrcpj/7wIDLr+u3VIzUBq2S5oCgpHQT/wrFjYHawonzuTj9QwkycK7o5zU0plZl+
	A55VdKYTRXi0AuVIVjQ9Rmd1PVdBZqomrfV4h+IqH8XV3Ixc53n5BgoqSD/j2UXEwIjq7cLt9ol
	4dlcds+6jHpGkYZXJC8EwM77XMtC4ASjzwYJTGJhCtrdjSCWcTccsjvqhlCLjZYr27tsxqfwwON
	XMoK60yPYhsdruHh8oDikiqND9rwk1HtnsKCtpPhRyXBRtajJhsYWaKYyfgnj0jIkdSUwpG0EeA
	WDeDJsmzDItQXQWlJeGTfQ3Rfsp92CTQ/47byxLLSP+aAzwtPdImGI0amXlkM9zmlOeR/Rl54Y4
	V6pFmkctIRLrCi2oBto/7QjeIqi3SxlHdI/7Egfkip7w7kpLZ2B4XlZz2HJ/NYW5OUGjNzdst5B
	AeuaINqchdikw==
X-Received: by 2002:a17:90b:28ce:b0:398:a649:8fa3 with SMTP id 98e67ed59e1d1-39b08799871mr33943718a91.23.1788846570489;
        Mon, 07 Sep 2026 22:49:30 -0700 (PDT)
Received: from volcano9f6e-hostos.amd.com ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-334fbd5e6f6sm25690109eec.23.2026.09.07.22.49.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 22:49:30 -0700 (PDT)
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
	Russell King <linux@armlinux.org.uk>,
	Puranjay Mohan <puranjay@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Hari Bathini <hbathini@linux.ibm.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Naveen N Rao <naveen@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Shuah Khan <shuah@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>
Cc: bpf@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kselftest@vger.kernel.org,
	sparclinux@vger.kernel.org
Subject: [PATCH bpf-next v4 3/7] powerpc: net: fix typo "upto" in comments
Date: Tue,  8 Sep 2026 11:18:49 +0530
Message-ID: <20260908054853.13820-4-hemanth.selam@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260908054853.13820-1-hemanth.selam@gmail.com>
References: <20260908054853.13820-1-hemanth.selam@gmail.com>
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

