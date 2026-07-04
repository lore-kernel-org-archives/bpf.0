Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AC4012E1DC
	for <bpf@vger.kernel.org>; Sat,  4 Jul 2026 00:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783124480; cv=none; b=Q0+3kFcMJZQlE5TqGTHbBjzgyYgRj49CMtIuLDIM/yqrJUHuBNMM7AEWRyKnrYMBy6BFUgDs2XNqc6os/UoTENUdcYy8P9FpQh4pxLeXkog18xU3Oar3EfXjFqRtTzPwgDYDCVVtgxlDxXtjoxylbBObcwi7rnDUjvJTm8g7UAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783124480; c=relaxed/simple;
	bh=f76jRFpgejqJFWeencJb9MPjKDz0PXpP0sWhsFHsPbc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=m2LWC6qR/lr5pb4jj+3GssMRtKeCggxGOclc0pUuM29Sx4AI+xN+hs0mezWnyKh+G5fSOE+WRM9zJvJ7O9Y+TTTspdRZVgPMWl5yV0OunUMYdDKcIoj2z/eVH3yxNiWrh+lDidK3Td4DOYMTKh5R/rslbEAfLEkyRBg1h7yem28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BS4ui7F1; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="BS4ui7F1"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783124466;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=nhQI8qrC1+u/J9NZuv3XyN01AIsqOde2x76wYlNC8WM=;
	b=BS4ui7F1n8y9YLLRS7xGfVRmM9PrQ1NaYnwBB6b5ezq/2Xvv16B1OJ3GluXFE81Vado51k
	AHtaRNz/zcyvLaegy5t2p3Xc3fQTc2fiSnJl9w2/3IC2jWPaMs/40YWaJ/pxuSRFV9GOeC
	8G/QEIUtIp4tZY/kGkh09G9ZuKrmHXg=
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
Subject: [PATCH v1 0/5] x86/cpu: Refactor identify_cpu()
Date: Fri,  3 Jul 2026 17:20:41 -0700
Message-ID: <20260704002046.3859585-1-ihor.solodrai@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

This series refactors identify_cpu() machinery on x86 and then
implements a fix for a bug when cpu capabilities are temporarily
cleared within an interruptable window. For more details and
discussion see the relevant bug report [1].

Suggested-by: Borislav Petkov <bp@alien8.de>
Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>

[1] https://lore.kernel.org/bpf/20260610175651.647515-1-ihor.solodrai@linux.dev/

Ihor Solodrai (5):
  x86/cpu: Factor init_cpu_info() out of identify_cpu()
  x86/cpu: Inline generic_identify() into identify_cpu()
  x86/cpu: Introduce identify_cpu_32() helper
  x86/cpu: Set X86_BUG_ESPFIX in identify_cpu_32()
  x86/cpu: Don't reset boot CPU cpuinfo in identify_cpu()

 arch/x86/kernel/cpu/common.c | 114 +++++++++++++++++++----------------
 1 file changed, 61 insertions(+), 53 deletions(-)

-- 
2.54.0

