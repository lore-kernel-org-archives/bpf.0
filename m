Received: from mta1.migadu.com (out-79.mta1.migadu.com [95.215.58.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57EC630E821
	for <bpf@vger.kernel.org>; Mon, 24 Aug 2026 09:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787563747; cv=none; b=E84CJWIBnh+RSz2/pm8WNUYzSRu4gP1D4fLp6HfGSNYTTE/FibWNz6a0272QWexmWR6KYBX4XUA86u78kq7IWk2vDdnLUCXpMVdjOThKb2+CwPd7SMb9emBPoVINupTpsR/RpWJw8b3C1TxwEntfcCzCYgh4jfB1bm4Efz5ADMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787563747; c=relaxed/simple;
	bh=kLRdD0D2c+K1LfqE4Njmmc4JGy4+lfEluyEPSDcw4FE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qVYPQ34+YYHAcmPDy4w9or42PcovLd/zTUNUKJs5ys6tBgem0vHFhsTVuUF7JH+aqPzk2SJ6JGQwVyXDyNTaaippfBGv8FNAbssctgbl1zZsss8aINHHiNWFdsi3fR7hPMgxcnXfrMgTBf+uBu9Lm78rVxFM6NuMbPCZxKOqYyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vL0YGqsX; arc=none smtp.client-ip=95.215.58.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vL0YGqsX"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=kLRdD0D2c+K1LfqE4Njmmc4JGy4+lfEluyEPSDcw4FE=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787563743; v=1; x=1788168543;
 b=vL0YGqsXXx6BEV7MStPuO0fmoISTRrSWLCEw9gevB0lXnQ9ar3bZlLvraCifHr42b/naawBN
 J1oXvOf6H4253aZGlEoPg/SsvK7zCpxO1h2RGBeN9At140Xv/25vnj7cu5n0m/bl5hcGcNl31V4
 7B5k2E8REYS6oMLLQpYkRYI8=
X-Envelope-To: bpf@vger.kernel.org
Received: from localhost.localdomain (147.136.157.3)
	by smtp.migadu.com with ESMTPS id 8c64b666e7ac6d23;
	Mon, 24 Aug 2026 09:29:03 +0000
X-Mizu-Trace-ID: 8c64b666e7ac6d23
X-Migadu-Flow: FLOW_OUT
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: bpf@vger.kernel.org
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
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
	Shuah Khan <shuah@kernel.org>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Jiawei Zhao <phoenix500526@163.com>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf 1/2] libbpf: Fix usdt attach failure when nop10 crosses page boundary
Date: Mon, 24 Aug 2026 17:28:36 +0800
Message-ID: <20260824092847.361683-1-jiayuan.chen@linux.dev>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The kernel refuses to attach to a nop10 that crosses a page boundary,
since it can't be atomically rewritten:

	/* can_optimize(), arch/x86/kernel/uprobes.c */
	/* We can't do cross page atomic writes yet. */
	return PAGE_SIZE - (vaddr & ~PAGE_MASK) >= OPT_INSN_SIZE;

Whether the nop10 crosses a page is purely up to the binary layout, so
this does happen in practice. libbpf doesn't check for it and blindly
shifts the uprobe onto the nop10, and the attach then fails with
-ENOTSUPP. Just keep the uprobe on the preceding 1-byte nop in that
case, it works everywhere as a regular int3 uprobe.

Fixes: 41a5c7df4466 ("libbpf: Add support to detect nop,nop5 instructions combo for usdt probe")
Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
 tools/lib/bpf/usdt.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/tools/lib/bpf/usdt.c b/tools/lib/bpf/usdt.c
index 2e56e3ab5b6c..c266ac93cbdd 100644
--- a/tools/lib/bpf/usdt.c
+++ b/tools/lib/bpf/usdt.c
@@ -614,11 +614,28 @@ static bool has_nop_combo(int fd, long off)
 		return false;
 	return memcmp(buf, nop_combo, 11) == 0;
 }
+
+/*
+ * The kernel refuses to attach to a nop10 that crosses a page boundary,
+ * as it can't be atomically rewritten. Page offset of the probe is the
+ * same in the file and in any mapping, so this can be checked statically.
+ */
+static bool nop10_within_page(long off)
+{
+	long page_sz = getpagesize();
+
+	return off % page_sz + 10 <= page_sz;
+}
 #else
 static bool has_nop_combo(int fd, long off)
 {
 	return false;
 }
+
+static bool nop10_within_page(long off)
+{
+	return false;
+}
 #endif
 
 static int collect_usdt_targets(struct usdt_manager *man, struct elf_fd *elf_fd, const char *path,
@@ -827,9 +844,11 @@ static int collect_usdt_targets(struct usdt_manager *man, struct elf_fd *elf_fd,
 		/*
 		 * We have uprobe syscall and usdt with nop,nop10 instructions combo,
 		 * so we can place the uprobe directly on nop10 (+1) and get this probe
-		 * optimized.
+		 * optimized. If the nop10 crosses a page boundary, keep the uprobe
+		 * on the preceding 1-byte nop, which the kernel accepts everywhere.
 		 */
-		if (man->has_uprobe_syscall && has_nop_combo(elf_fd->fd, usdt_rel_ip)) {
+		if (man->has_uprobe_syscall && has_nop_combo(elf_fd->fd, usdt_rel_ip) &&
+		    nop10_within_page(usdt_rel_ip + 1)) {
 			usdt_abs_ip++;
 			usdt_rel_ip++;
 		}
-- 
2.43.0

