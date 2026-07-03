Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D3133CAE95;
	Fri,  3 Jul 2026 11:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783079436; cv=none; b=sar2ushkSO8GMBWaGyFprqIriVVG4Nrns7t6VifMNivEtIQDhi4O4TGHo5weC10Ft7Z0zuiFaxKPuKcKx9Bf/dyfg2Dgx5PMMeB8Fnvpm+N4zGMwn06EaObB8FMbfC7y3zUQ+HzS50V+Rta54QhjikaFRX5F9WBIzpZVvDAmMRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783079436; c=relaxed/simple;
	bh=CwecgW5/6M7LvChpWr6a2Xo1oJ+MlArrL+2UYuwURWc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BcwFADsTGpYebElPS2uK7wXBSc80qreg2z1/2JqOikIDId8YWIaYFlppiYhaDNrJMsQi461FNvG2mRWUT2+bG9IO22aX2hZMPpdf0vpnHxZHDPHKIW9ctEwnUsavMy7B8Jb0bkUDDNc7EkYOLvhyTH5wXZFLIhc5/FZzhpWP86o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VNi7iVUp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VNi7iVUp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93A9B1F000E9;
	Fri,  3 Jul 2026 11:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783079435;
	bh=dwVMLvvHoGI7pIKN4OuE4GEfim64SXVz0mN77ZbbPi0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VNi7iVUpTONrLEoH22HaTNuRiaCNx3FSWXN6ol4vW6/0upCXJFXia1Y/HCg/C/ViA
	 H6hjnVbQUQblxcH0uCORaSgBii3Ih62AWfbEop9ElKFiipy154M/D21g34Mq1jviKg
	 +9glAYZrWc7YBsKz5haqcNkFnY2w7AI1wafDRTG+s+tM/oK1e2CUY6HgcNVzMkLPsQ
	 gewJGg0JPVBsZXu3ghToZE5W+vOPPrMXr+W4XxY/xQWSyDCi+gALVffBr7od29fO3D
	 Nl0Ak4yYZCDYgo07Q8+qydHa8hEkc4mxx3OlsoLvcEni4OILG6jFYP+uYZUJf5NYDA
	 zdhgd9+Cysl8g==
From: Jiri Olsa <jolsa@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: Jakub Sitnicki <jakub@cloudflare.com>,
	bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCHv6 06/13] libbpf: Change has_nop_combo to work on top of nop10
Date: Fri,  3 Jul 2026 13:49:10 +0200
Message-ID: <20260703114917.238144-7-jolsa@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260703114917.238144-1-jolsa@kernel.org>
References: <20260703114917.238144-1-jolsa@kernel.org>
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
index db9432adb967..2e56e3ab5b6c 100644
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
@@ -605,14 +605,14 @@ static int parse_usdt_spec(struct usdt_spec *spec, const struct usdt_note *note,
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
@@ -825,8 +825,8 @@ static int collect_usdt_targets(struct usdt_manager *man, struct elf_fd *elf_fd,
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

