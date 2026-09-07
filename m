Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A69D48165E
	for <bpf@vger.kernel.org>; Mon,  7 Sep 2026 12:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788782484; cv=none; b=HoVm+IvqoineKuH5uxg+uNuvvfnPDv+JftMLHCMkghd4QKsRCFSEMHlRQEgd9yJxxnU2hGdQO4XRDbU4t6nr7iuSqQrUHH0Y71jDX3oWXp585Z6RUW1z8fEb4ut5xmFqxUtj4Rpm/jGdsyYf40buLs3at+6+0j5s3ZVJ6CkdgWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788782484; c=relaxed/simple;
	bh=JtFt4j8cgUgUtFZaywPAlg51vNEpvkwM47kq5mj/13w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TbVPxMgJWyLrY21YAqw3uTHxVUac2YwcL56tfRWSyOuvEMOLJ93sDtBftgdGY2pRhKOkDh4zHpVj4RsFf94bBe2yV0f3H7LLZWKbdtO/1YnH4oSfAs+8ZYq1Nu9eiPXecOx0/H301pZJSYkmq8QuZYpP3OTvNNolLIgnynNgT2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AFNPLVNd; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AFNPLVNd"
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-459281bc13bso2310967fac.2
        for <bpf@vger.kernel.org>; Mon, 07 Sep 2026 05:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788782482; x=1789387282; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gH9gg1qvejjX/sPdW+X7GvG6xfgdjVwQ/p+bz1yISpM=;
        b=AFNPLVNd4Lm+6lIv4uOnh94r/o9zZg5GHHTMpqPjjvPYd7EASDDZkCiEXtiBRhzT8i
         ca/Oqgh/H2n2GQJIQ5J438InETfBbwadtt6QyuQqGchrGl6OalA+fdvvUEMt1FKEbqDI
         WsFSSzlqqKNcqZECmehxN1NsH+uDmmRwljkYVJuZr4DcB5539Gmni0UHUDdqZqQyL+Ox
         5CUWcx2oLbufAYUViJ4OZbQaDHeCvu55Cu7yYUVpEDdxMqlmoiaAEIClX+qEh1ErTnMe
         Irsvu9wou18zaI6F6s82b3eBNy+eQN1dwPqaB+/bDrNJEd/eyf7OfBcrEi78v7G7FTNR
         HZrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788782482; x=1789387282;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=gH9gg1qvejjX/sPdW+X7GvG6xfgdjVwQ/p+bz1yISpM=;
        b=Hav269PJGYbf88wiwrjvUscFS0onW2ITdc+xiqaZFG0IFlAp9jNaYfv79zm7j+pkC9
         YP5mWWPA9T+mYXK5m5w5o99HmYlVUnbLFvSc8t+D14wxS46B3ERM1QyigxocWLtpsc38
         sJJjIgA7YyLQC8LbObLGgEPCOfDoU2hGhF6F2VGKxdYWdT4PIGI3ajciMsssbPTtpfSb
         MeYoY+Uob1CgWy5JYXu3xc5jNAA3Ncpi432JjeJHVdLZAba9VWcTGvOlc3j9wxQsUcR4
         T+mlQoTT6I6kFQoxTi/LkwT9eU6HYNZ0cgkIyL24r5jRzwu+2VrTSCoN6BQefmGRo3SD
         6Gxw==
X-Gm-Message-State: AFuF++nmGU/UD/o43HUKQRvI4qXiCHF87upTMeTREX3BXta+Frr2lcji
	YhyCWVtPUu6qRbbxuiOgLOGQ4KL7ECW0is7ZBM3Yq68cb5/ojKX5GFVU
X-Gm-Gg: AYBFou2E8qJmrnvxJhOGNCvBVKXs6BGgWNlWbrqgj7cvGUN0pQmysgWdoixJ0T9TFvP
	Xux143OQEZ3gKYXBljpIA8nYvElSQturl3+Xu267qbu8+dtNCisLuyp+iK5ADx+NaAWh2vdM+l5
	Z2yHQd/QY6dgaxzJSKdgXkAEMLQ4My0EQC/FITMHJBQ/XfcRkJFWrUrQu7fLfy8N4AtgSteJLKZ
	FmO6TfTcpCmBd8K/dvrvn9T3aFGy4yhkwBU/fwBPwYPr08EPJ9LEfAZ/j+NskFiItzckO9lWmJk
	YiZSF0zstyBzk9AlY2MD0vai5iHyMWcg5/Ul2A4t+x7loynt/GFcM2X5zdx01d8aUhdaUyVjC07
	+XHLpUpFzUeL/RhOjFk4MuVDTuW5aHSpXfByokiJSNIhkAh2v2EQ9zQdRgyf6+JNAbq7adWV6yY
	BagUJPe2InHLF8oijSlkXMc7oq+op+S7Q56keYd6zZzP5MeT6K6M8WlytA5Lg2Is6aVI7T4Mc/B
	v0pbWrfe6GZNA==
X-Received: by 2002:a05:6820:a0e:b0:6b6:d425:53f3 with SMTP id 006d021491bc7-6b6fddbd240mr13817787eaf.33.1788782481883;
        Mon, 07 Sep 2026 05:01:21 -0700 (PDT)
Received: from volcano9f6e-hostos.amd.com ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339885ca07sm31244462eec.1.2026.09.07.05.01.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 05:01:21 -0700 (PDT)
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
Subject: [PATCH bpf-next v3 3/7] powerpc: net: fix typo "upto" in comments
Date: Mon,  7 Sep 2026 17:30:39 +0530
Message-ID: <20260907120043.36894-4-hemanth.selam@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260907120043.36894-1-hemanth.selam@gmail.com>
References: <20260907120043.36894-1-hemanth.selam@gmail.com>
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

