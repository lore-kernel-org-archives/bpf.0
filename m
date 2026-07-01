Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E304443637D;
	Wed,  1 Jul 2026 11:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782904489; cv=none; b=oJZ/yZDawesmdaj0L3oI5ocP/TJsCwDXzF1OnF7O+YfOvAuREfjSGOrGRNaISdq3ZoVyLTJoIze/93zJjxUtiQui7rcupMauxdfHHHPcLpDfCDzKvuQ3HjQ2MABcFPfwIr8wJL6gk31pY4krwX3EPI0Sdc74KWWGBlKvNs9YCyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782904489; c=relaxed/simple;
	bh=CwecgW5/6M7LvChpWr6a2Xo1oJ+MlArrL+2UYuwURWc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QCLEqkD9FFVfrv0D4bhoaPzt0rPvfEMfQ1IY7+ae5qw2d0sFg/mrAEkKYqskTkQ0xLbuZnLv+TG54/w+AbsSeOqVFAzjKcGj7DTRhcOZFVnCv71mla2aRITivnc2fvkrcIkhGoetfWnbR/z0k4tefPUv0SGVmkQPF2HkNvv94VY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hoafMXNj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hoafMXNj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A5B91F00A3D;
	Wed,  1 Jul 2026 11:14:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782904488;
	bh=dwVMLvvHoGI7pIKN4OuE4GEfim64SXVz0mN77ZbbPi0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hoafMXNjND5RKwOqaBO9qSuKcbQv9xtGrGkikecfB/jTQiR9KDsM22VVclfvqWY16
	 8UP/Qmk2AIWJsBkTePlAMnp3K8GsxCw61BCzIwolUCo4iz5UKq4vaM+cUibxiUsHzY
	 JBqJw7kY56zDyU/FcAChCssNT6uBRjmWin1krAY6PCa3QZKsz8C7MhmBqunjyBxww9
	 U5aJqhF3Cvs0qrwtu0drYeIdmjcJSqS60f6XRRTGaVQ/vnaCSgLIheCDwSsHdoJ8XN
	 nv/FY5q6BWDUTKg1EqbrRw1v9Fi6rjO8gq20hfTMvb7UwWpYHGtpzIhIFVtlBDY0BN
	 KRhXz20zAku9w==
From: Jiri Olsa <jolsa@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: Jakub Sitnicki <jakub@cloudflare.com>,
	bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCHv5 06/13] libbpf: Change has_nop_combo to work on top of nop10
Date: Wed,  1 Jul 2026 13:13:30 +0200
Message-ID: <20260701111337.53943-7-jolsa@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260701111337.53943-1-jolsa@kernel.org>
References: <20260701111337.53943-1-jolsa@kernel.org>
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

