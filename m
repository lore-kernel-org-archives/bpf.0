Received: from mta0.migadu.com (out-150.mta0.migadu.com [91.218.175.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8C0E446BF5
	for <bpf@vger.kernel.org>; Wed, 16 Sep 2026 19:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789588362; cv=none; b=XGaM1IGWa2B778+GZMUoeueub1v+GtRdKQc/EJ2BffPicTY/NV/ptxDSpDhcPH8MT9wkbdfE/whCvgIRoZKFalVugCnPthZnMZwsQyA65gI9nm9dBPGNxr0OwHmqSHW6QaSpu2fI1YTlLZL74Zp0XtkAyMinHSoAw0kl1GWgOMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789588362; c=relaxed/simple;
	bh=uezm5MFaGZMNvW+locU7R+duzoa5ZNNuKXadO7AJik4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=czxAyJPOC9GP/SurPWKcxEX2ro52M1IaUEvPfg6txLIXrA3/k4Rx48G/8qZgM7/2VJALb84Tp3pmdKBnXqFfbWRvCRCzr1t9dhWmagJY2+G6237OI7n8cossTX5lHYGsRjhr4Srh5jCYF0ht74RKwuXmQN2i1MOmAKUA+3LzO7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PxPEBXuP; arc=none smtp.client-ip=91.218.175.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PxPEBXuP"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=uezm5MFaGZMNvW+locU7R+duzoa5ZNNuKXadO7AJik4=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789588354; v=1; x=1790193154;
 b=PxPEBXuP1a0yKQW86JkSiyLOtwOD5WqldVHkYt76++OiT/AprvVmI+8fZ4gXHz704tn2ipjr
 ZvQYjWiQoiXq8J4+ez3qZMy9gKyKl3YM67sNSqPTPXsZQAmdZMLAjcz+TnsYMer3iaB5pBg62rO
 S4Uwl0ZYK0n+ThOSse1/W0L4=
X-Envelope-To: bpf@vger.kernel.org
Received: by mta11.migadu.com with ESMTPS id d4694686d251f010;
	Wed, 16 Sep 2026 19:52:34 +0000
X-Mizu-Trace-ID: d4694686d251f010
X-Migadu-Flow: FLOW_OUT
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
	linux-kernel@vger.kernel.org,
	x86@kernel.org,
	bpf@vger.kernel.org,
	kasan-dev@googlegroups.com,
	linux-mm@kvack.org,
	kernel-team@meta.com
Subject: [PATCH v3 2/5] x86/cpu: Initialize boot CPU cpuinfo defaults early
Date: Wed, 16 Sep 2026 12:52:00 -0700
Message-ID: <20260916195203.1099646-3-ihor.solodrai@linux.dev>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260916195203.1099646-1-ihor.solodrai@linux.dev>
References: <20260916195203.1099646-1-ihor.solodrai@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

early_identify_cpu() clears the capability array, the CPUID table and
extended_cpuid_level, but the architectural defaults for the rest of
struct cpuinfo_x86 are set only later, in identify_cpu().

Use the same defaults from the start, so that the boot CPU does not
depend on a later reset to end up with the right ones.

Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>

---

This change comes before the last patch because that one removes the
reset: without the defaults established here the boot CPU would be
left at 32 instead of 64 on an x86_64 CPU which does not enumerate
CLFLUSH.
---
 arch/x86/kernel/cpu/common.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index c3dce89ba590..66695addbdf3 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1812,16 +1812,15 @@ static void init_cpu_info(struct cpuinfo_x86 *c)
  * Do minimum CPU detection early.
  * Fields really needed: vendor, cpuid_level, family, model, mask,
  * cache alignment.
- * The others are not touched to avoid unwanted side effects.
+ * The others are reset to their defaults here and only filled in later,
+ * by identify_cpu().
  *
  * WARNING: this function is only called on the boot CPU.  Don't add code
  * here that is supposed to run on all CPUs.
  */
 static void __init early_identify_cpu(struct cpuinfo_x86 *c)
 {
-	memset(&c->x86_capability, 0, sizeof(c->x86_capability));
-	memset(&c->cpuid, 0, sizeof(c->cpuid));
-	c->extended_cpuid_level = 0;
+	init_cpu_info(c);
 
 	if (!cpuid_feature())
 		identify_cpu_without_cpuid(c);
-- 
2.55.0

