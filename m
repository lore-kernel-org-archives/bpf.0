Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 385161F4180
	for <bpf@vger.kernel.org>; Sat,  4 Jul 2026 00:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783124474; cv=none; b=Iwk0Hb41X0gTouPmQUh7oV/nIUJF5WHtuMu6Uuczmij0untp7ZnDXUy1Uogb9nSl5U4355YvSM7dDh9b5/y/Y6viBcq+GWD3lfAR5htEWjyLj/RHwODbwj7fVZsC7R+qCMp2E2yiZppkfRHEvbh2n53VeSCMb5vZ0LTMwhHELso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783124474; c=relaxed/simple;
	bh=fKltV4Y+yZ3RtlRnAo6JgqcNqdNi6M84iLyYMi2L39s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lRfSubAji6z5pa+YoyGOCPP/M/h+wUYQ/chEY614WsMS0z6/91fH/sMTq+nWZ99UYOzu/gzKHuTqPL8R2FSSH0t/6T4KJOPxu2egUHRsGXRB/ufBayC1tXfNHeyOHqtxDluSmoegBrJuejeuG7cekZgf1dZ55G5r85Nn/V0VIWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=HcaGkuOa; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HcaGkuOa"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783124469;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WiUU8XneX3wvcz7OpmI3CTa/dG6YwidrHTie7rRQSHk=;
	b=HcaGkuOa07EpTs7KKOWH02bgZhWCBWxLbjhy8OjFqA5IBd/aw5BDMW+iMnkeBfiZQySvJR
	6ffc5jM0Vqk1Nn+jkZeC/nOxJDtE3tmBVuoi1fKn4T9zhgOLkRi+wq9wM2KI9bnaCdqAX6
	KFj/Tmvnm3kep/RgJHs8aEpNgIlxzXY=
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
Subject: [PATCH v1 1/5] x86/cpu: Factor init_cpu_info() out of identify_cpu()
Date: Fri,  3 Jul 2026 17:20:42 -0700
Message-ID: <20260704002046.3859585-2-ihor.solodrai@linux.dev>
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

identify_cpu() begins by resetting the struct cpuinfo_x86 fields to
their unknown/default values and clearing the capability arrays with
memset().

Move that reset into a new helper: init_cpu_info(). This is
preparation for letting the callers decide whether the reset is
needed.

Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 arch/x86/kernel/cpu/common.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index a3df21d26460..505ce329e821 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1993,14 +1993,8 @@ static void generic_identify(struct cpuinfo_x86 *c)
 #endif
 }
 
-/*
- * This does the hard work of actually picking apart the CPU stuff...
- */
-static void identify_cpu(struct cpuinfo_x86 *c)
+static void init_cpu_info(struct cpuinfo_x86 *c)
 {
-	int i;
-
-	c->loops_per_jiffy = loops_per_jiffy;
 	c->x86_cache_size = 0;
 	c->x86_vendor = X86_VENDOR_UNKNOWN;
 	c->x86_model = c->x86_stepping = 0;	/* So far unknown... */
@@ -2022,6 +2016,15 @@ static void identify_cpu(struct cpuinfo_x86 *c)
 #ifdef CONFIG_X86_VMX_FEATURE_NAMES
 	memset(&c->vmx_capability, 0, sizeof(c->vmx_capability));
 #endif
+}
+
+static void identify_cpu(struct cpuinfo_x86 *c)
+{
+	int i;
+
+	c->loops_per_jiffy = loops_per_jiffy;
+
+	init_cpu_info(c);
 
 	generic_identify(c);
 
-- 
2.54.0

