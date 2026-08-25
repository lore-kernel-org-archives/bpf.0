Received: from mta0.migadu.com (out-39.mta0.migadu.com [91.218.175.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89EDC488215
	for <bpf@vger.kernel.org>; Tue, 25 Aug 2026 15:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787670308; cv=none; b=agATB3bTG94xzQvjyb6do3yc/0jaYbCSZToOmRlX7Gu3DSb0QpeKyMk7oG8B3NEwKAxORITPsZGW4uwlwVx9JCYbC+6tGyz0EYPc/95kTz6myAFgJ2G2vpBvN6KaGpJYcZUpa/m26t//TBTKgeZvd605wzWAStdM+lyLvN5z2aY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787670308; c=relaxed/simple;
	bh=ArBbAiSJotIb8hE7Pfi2XmR5kO5/NegQVH+7ACq+8bs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HB8wTVresIkZE3R7gOIKkIhqKmzEKFiVsJ6cUo9IEpLLhZqZVnitzmWO11FCJTo2Ys2J0m2x32U4LHvLEkHrSnRzjWKHwjtMxpe0nri+dB3qbqljbSGZ7xLJoodiFXUAW4m+E7Pvj72QMgDdc+IFF5H5All8sZexDWZYxyn3jJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CE2l/zeM; arc=none smtp.client-ip=91.218.175.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CE2l/zeM"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=ArBbAiSJotIb8hE7Pfi2XmR5kO5/NegQVH+7ACq+8bs=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787670301; v=1; x=1788275101;
 b=CE2l/zeMcL6o259A8iAT0oVSf3Z3LFOzIo631/N+2CYt3AsJ0BzWG5KGLLA7dkxp+tup5mPw
 xLEHXz/RNyu5Ge9GVZ1f8iukJGrcA/trvESoAmx6JTGGOl5SGMjbk3FQp0QwAHJrPF2VWJW55Ki
 0bj4swu8hGd7UDWpvtPfS5KE=
X-Envelope-To: bpf@vger.kernel.org
Received: from localhost.localdomain (147.136.157.2)
	by smtp.migadu.com with ESMTPS id 8af23868c579f1e7;
	Tue, 25 Aug 2026 15:05:00 +0000
X-Mizu-Trace-ID: 8af23868c579f1e7
X-Migadu-Flow: FLOW_OUT
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: bpf@vger.kernel.org,
	jolsa@kernel.org
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Shuah Khan <shuah@kernel.org>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	Ingo Molnar <mingo@kernel.org>,
	Jiawei Zhao <phoenix500526@163.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf v2 1/2] libbpf: Fix usdt attach failure when nop10 crosses page boundary
Date: Tue, 25 Aug 2026 23:04:33 +0800
Message-ID: <20260825150444.31603-1-jiayuan.chen@linux.dev>
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

Fixes: ee2862439e5c ("libbpf: Change has_nop_combo to work on top of nop10")
Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>

---
v1 -> v2: move check into has_nop_combo.
v1: https://lore.kernel.org/bpf/20260824092847.361683-1-jiayuan.chen@linux.dev/
---
 tools/lib/bpf/usdt.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/lib/bpf/usdt.c b/tools/lib/bpf/usdt.c
index 2e56e3ab5b6c..ee9d1b614883 100644
--- a/tools/lib/bpf/usdt.c
+++ b/tools/lib/bpf/usdt.c
@@ -608,8 +608,12 @@ static bool has_nop_combo(int fd, long off)
 	unsigned char nop_combo[11] = {
 		0x90, 0x66, 0x2e, 0x0f, 0x1f, 0x84, 0x00, 0x00, 0x00, 0x00, 0x00,
 	};
+	long page_sz = getpagesize();
 	unsigned char buf[11];
 
+	/* the kernel can't attach to a nop10 that crosses a page boundary */
+	if ((off + 1) % page_sz + 10 > page_sz)
+		return false;
 	if (pread(fd, buf, 11, off) != 11)
 		return false;
 	return memcmp(buf, nop_combo, 11) == 0;
-- 
2.43.0

