Received: from mta1.migadu.com (out-31.mta1.migadu.com [95.215.58.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FBE23DC4AE
	for <bpf@vger.kernel.org>; Fri, 14 Aug 2026 23:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786751546; cv=none; b=u7EmSbDyvLhMxY2wN+QSE4t6riaQDMT8rg9ZPXHyAQMTAPTp6LQ9Cll7HTy6qnv/gUQnaIzTZDxCQozfynLXCkEtCMWAiACKzXixtwHGWR0p+NzfjfjH1qJR6AIrXsUl21TET6Y3NBDfT7qeNm6pH/B00PIH2Ln4CAkwbnyiRJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786751546; c=relaxed/simple;
	bh=yq/CIHMCUVnry977n31c6YewS1Nzi92h3o7DFyzp5zk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BvYRa4kHJr2qnSSII363CtmPwQqc/TSE++MA+huKPZP/d4zjR5ZP9BfJ6DcsGcTqe6hhOCPG7NAckuJlPswYAMQVE90mRtyM1rAUchqiCwBCmVaTgApX9jA6Ujd+sC7DOrEoDKEtuZTTlAnTkX3ZeE37ldYnScqVX6HWk+KRH3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hzjUZGZP; arc=none smtp.client-ip=95.215.58.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hzjUZGZP"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=yq/CIHMCUVnry977n31c6YewS1Nzi92h3o7DFyzp5zk=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786751542; v=1; x=1787356342;
 b=hzjUZGZPgTDAYqCRp3nH7iE9jPdsDl3QlhgEDD9Wd+JdiOWbR5A520JOlrob9OcTPgNKNZC0
 6WH+vVIiBYo6u5ZmluHObwcQoJwU0glpCxkQNmr0UMr9lmtDYbOYZ92IFVfhG7Z5mVs2IdMowvW
 2MXvzMML6LkJBwx7esyHjIhI=
X-Envelope-To: bpf@vger.kernel.org
Received: from isolodrai-fedora-MJ0FVMD1.thefacebook.com (2620:10d:c090:500::4:b8fe)
	by mta10.migadu.com with ESMTPS id dd5d91714fb7a918;
	Fri, 14 Aug 2026 23:52:12 +0000
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
Subject: [PATCH v2 0/5] x86/cpu: Refactor identify_cpu()
Date: Fri, 14 Aug 2026 16:51:29 -0700
Message-ID: <20260814235134.3461435-1-ihor.solodrai@linux.dev>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series refactors identify_cpu() machinery on x86 and then
implements a fix for a bug when cpu capabilities are temporarily
cleared within an interruptable window. For more details and
discussion see the relevant bug report [1] and patch #5.

Suggested-by: Borislav Petkov <bp@alien8.de>
Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>

[1] https://lore.kernel.org/bpf/20260610175651.647515-1-ihor.solodrai@linux.dev/

---

v1->v2:
  * Rewrite commit messages to fit more conventional structure (Boris)
  * Drop identify_cpu_32() helper, it's unnecessary (Boris)
  * New patch (#2): now early_identify_cpu() resets boot_cpu_data
    through init_cpu_info() as well
  * The boot CPU reset is now skipped on 32-bit too (sashiko)

v1: https://lore.kernel.org/bpf/20260704002046.3859585-1-ihor.solodrai@linux.dev/

---

Ihor Solodrai (5):
  x86/cpu: Factor init_cpu_info() out of identify_cpu()
  x86/cpu: Initialize boot CPU cpuinfo defaults early
  x86/cpu: Inline generic_identify() into identify_cpu()
  x86/cpu: Move 32-bit SEP setup into identify_cpu()
  x86/cpu: Don't transiently clear the boot CPU's capabilities

 arch/x86/kernel/cpu/common.c | 92 +++++++++++++++++-------------------
 1 file changed, 44 insertions(+), 48 deletions(-)

base-commit: db2ddb87143519e20a95aa36c60b36107b736a58
-- 
2.55.0

