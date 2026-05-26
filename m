Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D785E3C1974;
	Tue, 26 May 2026 20:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779829181; cv=none; b=mOcmO7szDfTO4hBLtRYLrB0uCNgcM4NR8VC5UZsliHV0Vz2j1CN4PpFFrrOzPzKCtP6+rvrYTHQKS3dnv7U3etjTwQy18fu0I0UKQiFtWvgdGZ3h/twtoYbSRMfdF72+08n/btoaTHVWzj6w92N71x2BIq1+NzF3JhzLjevuLzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779829181; c=relaxed/simple;
	bh=7zgEr4uh215R7P1vGUuPKm5KNdvDiDggw4invgaTpd4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rkfDIcxCLCusQldeGuhzv5SFO5CqIzyyx/15HkihzjzRjvdL3ZdUPHgORET1sQAdTVJngCf4xHhHkp57l0mvEQb9sE8mkyjNHgJmOmx8QIUuxu//3BjAdLm2rZZkDx90YhwF6yOBXSva5ZG8G87YcOGCtkHrAFaW3lIIrwsShF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CAFQxk2l; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CAFQxk2l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C01E1F000E9;
	Tue, 26 May 2026 20:59:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779829180;
	bh=L9EHbfdbb+FzdAOD0Z5VdRAEcQbXhH0b9mRAD9eTwkM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CAFQxk2lL9imQT1vry3eP/1l9voTHW/rmfE3w0GEU1l0GyDk1mxucPwpZDTby5dRf
	 6LIWJj9KDmuTXX5mEkUHkMRJ7U80h7HFFXVEM0aPnqhD5NZMVQy7YRbe9tNPn6J6Jj
	 iEXF0ygEChjb98DwxPp+3VKJ4vya8WLX8E1uV0RM2h/9+9MnqrOEltaFm9ND+7Jbna
	 ZyiujvuShbpwH4P9NfPmvLsqJOrgjrq7TnxJc2u6P9PQ+f+HANGvhXbd5S3BrxxMTW
	 BgZx6TX7Gvfx24S9GlHGyeSFaWuDy+rZsitXPUtoQP4QHC748xdwUOj1VlteRKJa4j
	 qMUP0KYld/b7g==
From: Jiri Olsa <jolsa@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: Jakub Sitnicki <jakub@cloudflare.com>,
	bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCHv4 06/13] libbpf: Change has_nop_combo to work on top of nop10
Date: Tue, 26 May 2026 22:58:33 +0200
Message-ID: <20260526205840.173790-7-jolsa@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260526205840.173790-1-jolsa@kernel.org>
References: <20260526205840.173790-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We now expect nop combo with 10 bytes nop instead of 5 bytes nop,
fixing has_nop_combo to reflect that.

Fixes: 41a5c7df4466 ("libbpf: Add support to detect nop,nop5 instructions combo for usdt probe")
Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/lib/bpf/usdt.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/tools/lib/bpf/usdt.c b/tools/lib/bpf/usdt.c
index e3710933fd52..484a4354e82b 100644
--- a/tools/lib/bpf/usdt.c
+++ b/tools/lib/bpf/usdt.c
@@ -305,7 +305,7 @@ struct usdt_manager *usdt_manager_new(struct bpf_object *obj)
 
 	/*
 	 * Detect kernel support for uprobe() syscall, it's presence means we can
-	 * take advantage of faster nop5 uprobe handling.
+	 * take advantage of faster nop10 uprobe handling.
 	 * Added in: 56101b69c919 ("uprobes/x86: Add uprobe syscall to speed up uprobe")
 	 */
 	man->has_uprobe_syscall = kernel_supports(obj, FEAT_UPROBE_SYSCALL);
@@ -596,14 +596,14 @@ static int parse_usdt_spec(struct usdt_spec *spec, const struct usdt_note *note,
 #if defined(__x86_64__)
 static bool has_nop_combo(int fd, long off)
 {
-	unsigned char nop_combo[6] = {
-		0x90, 0x0f, 0x1f, 0x44, 0x00, 0x00 /* nop,nop5 */
+	unsigned char nop_combo[11] = {
+		0x90, 0x66, 0x2e, 0x0f, 0x1f, 0x84, 0x00, 0x00, 0x00, 0x00, 0x00,
 	};
-	unsigned char buf[6];
+	unsigned char buf[11];
 
-	if (pread(fd, buf, 6, off) != 6)
+	if (pread(fd, buf, 11, off) != 11)
 		return false;
-	return memcmp(buf, nop_combo, 6) == 0;
+	return memcmp(buf, nop_combo, 11) == 0;
 }
 #else
 static bool has_nop_combo(int fd, long off)
@@ -814,8 +814,8 @@ static int collect_usdt_targets(struct usdt_manager *man, struct elf_fd *elf_fd,
 		memset(target, 0, sizeof(*target));
 
 		/*
-		 * We have uprobe syscall and usdt with nop,nop5 instructions combo,
-		 * so we can place the uprobe directly on nop5 (+1) and get this probe
+		 * We have uprobe syscall and usdt with nop,nop10 instructions combo,
+		 * so we can place the uprobe directly on nop10 (+1) and get this probe
 		 * optimized.
 		 */
 		if (man->has_uprobe_syscall && has_nop_combo(elf_fd->fd, usdt_rel_ip)) {
-- 
2.54.0

