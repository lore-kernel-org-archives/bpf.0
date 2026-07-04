Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5745D1F1537
	for <bpf@vger.kernel.org>; Sat,  4 Jul 2026 00:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783124485; cv=none; b=tRtvmZvPvoxYsR0sRcaOBNom4pTdSzjleVPO1ZwhCn2nDClx/+spK/qI2mcrqw7dJOAQJSbBB7oyKigzLbYdyosAZoZRBTsxuazqCwh4yVnCG4+//1DU7rWxKdrGPAoTYI1+/ww8kJi7QkDn3qW3k98cZw8He/t3wEOKPmv+UFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783124485; c=relaxed/simple;
	bh=d8esytshOxqR5lriWzZNvvJdyiVdj64hLQoV316XJ8o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=stj2yO183nyiQTcXd0KDrwQC8+CgR3RudCK0S3gN0iS/Vmnig2d/ZvQX2La73dnB2Gy7hlKpRvEI8esZgD+cITmiWicBk/bekK+jBg99Z+G4fok2I2ta5SwQWJyI/FL/SSVnishI7t6vmtJX2EXbDXOMzsaWlc5AlEIHZyd7xIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Bx+/rbkl; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Bx+/rbkl"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783124481;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zdrYYHrpsx+P80tgVW4Fs8Ygiy8h4jkJ/VS0hdKA83I=;
	b=Bx+/rbkl966Cw6MlCohyWVIf/IZfvZXlYuLgbVti/XOaa63KVOYwAeXbsakWLkU6TPJAnw
	o8CJHR9qB2tnnMBib/8skqUH2E0qx5EJaqeG/bmskJEAG7jhXdmD8PrptegdNX2sNxLAvJ
	x3oAR44UV31IQ7IxL9QOpHshhgPFnv4=
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	Thomas Gleixner <tglx@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	bpf@vger.kernel.org,
	kernel-team@meta.com,
	kasan-dev@googlegroups.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 4/5] x86/cpu: Set X86_BUG_ESPFIX in identify_cpu_32()
Date: Fri,  3 Jul 2026 17:20:45 -0700
Message-ID: <20260704002046.3859585-5-ihor.solodrai@linux.dev>
In-Reply-To: <20260704002046.3859585-1-ihor.solodrai@linux.dev>
References: <20260704002046.3859585-1-ihor.solodrai@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

X86_BUG_ESPFIX is 32-bit-only.  Move setting it into
identify_cpu_32(), next to the other 32-bit-only setup.

Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 arch/x86/kernel/cpu/common.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 519e495c4a14..8f093c6c7ccc 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -2005,23 +2005,6 @@ static void identify_cpu(struct cpuinfo_x86 *c)
 
 	get_model_name(c); /* Default name */
 
-	/*
-	 * ESPFIX is a strange bug.  All real CPUs have it.  Paravirt
-	 * systems that run Linux at CPL > 0 may or may not have the
-	 * issue, but, even if they have the issue, there's absolutely
-	 * nothing we can do about it because we can't use the real IRET
-	 * instruction.
-	 *
-	 * NB: For the time being, only 32-bit kernels support
-	 * X86_BUG_ESPFIX as such.  64-bit kernels directly choose
-	 * whether to apply espfix using paravirt hooks.  If any
-	 * non-paravirt system ever shows up that does *not* have the
-	 * ESPFIX issue, we can change this.
-	 */
-#ifdef CONFIG_X86_32
-	set_cpu_bug(c, X86_BUG_ESPFIX);
-#endif
-
 no_cpuid:
 	cpu_parse_topology(c);
 
@@ -2151,6 +2134,23 @@ static void identify_cpu_32(struct cpuinfo_x86 *c)
 	if (!IS_ENABLED(CONFIG_X86_32))
 		return;
 
+	/*
+	 * ESPFIX is a strange bug.  All real CPUs have it.  Paravirt
+	 * systems that run Linux at CPL > 0 may or may not have the
+	 * issue, but, even if they have the issue, there's absolutely
+	 * nothing we can do about it because we can't use the real IRET
+	 * instruction.
+	 *
+	 * NB: For the time being, only 32-bit kernels support
+	 * X86_BUG_ESPFIX as such.  64-bit kernels directly choose
+	 * whether to apply espfix using paravirt hooks.  If any
+	 * non-paravirt system ever shows up that does *not* have the
+	 * ESPFIX issue, we can change this.
+	 */
+#ifdef CONFIG_X86_32
+	set_cpu_bug(c, X86_BUG_ESPFIX);
+#endif
+
 	enable_sep_cpu();
 }
 
-- 
2.54.0

