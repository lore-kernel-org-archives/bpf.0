Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41E2B3DD869;
	Thu, 14 May 2026 13:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778766846; cv=none; b=ebItvXnbLMRi/Sz4IdX6O8EN0fcEDGP8jzI7OQ3rbFW7Si7jd9mFO6K20LAIXYRGmuWej7jh5v6AJ0mCGSLwxkPZnoiTrUOo1cf65N2i8yw5cea4zmPgdbFZwveQWf5YmhYFN2kC9BbERfOWxZQJeeestTOcdD8K/X1VZLvZwbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778766846; c=relaxed/simple;
	bh=HqwVdCDQ5PT4T0eOwYDAP/Ngm6gJlwORb493qxmzn5w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fzrzxp24OCkOVx80/ypekHBHWhy+zAPAk5zOG5qC+HN/TLn1eTPCk7RmKuBWBDZDJI7kCxHiWTX0XrutrVC70daOQPvj6+hB6BxGq6+9zKQ2jD7xi9rM1aonbNcY0GSJPHR/N7oCRLgexDbGeu1Jf6ibITsUUV2/31TXlRChDhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a2oJuChD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a2oJuChD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC873C2BCB3;
	Thu, 14 May 2026 13:54:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778766845;
	bh=HqwVdCDQ5PT4T0eOwYDAP/Ngm6gJlwORb493qxmzn5w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=a2oJuChDzeQnRFD8lpKzwqrVggp4DPJ2ybLs0VzfCXr0xKxuWsTA+PBsYsRo+YdRU
	 3/9i2P/BQ/4nri3+QfsFi5h2KlFK/zqcLwoAS8AzOblhvQOksXmpXX4cLsWQdh0oAj
	 c8JKi8ZJ2Sw2WVozu6G0dhHab0eBRXt3JzYN+CWhpcPMyM78c/94U/DtlOZTIWLQ28
	 QuZzmq6PXPWMkuPQ+aVEm3NlgaWkZnIRQ9Pz0gRlnpKiol/QE7JMAXdb0MFMA+kZRi
	 FSfJCzXE6np2yDSH0rGi9CT0xM2x8JNZudgDUl/lfplG4RI19zYULdi7DaV4DbUN8y
	 tLu5YX0VsLaSg==
From: Jiri Olsa <jolsa@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH 2/7] libbpf: Change has_nop_combo to work on top of nop10
Date: Thu, 14 May 2026 15:53:37 +0200
Message-ID: <20260514135342.22130-3-jolsa@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260514135342.22130-1-jolsa@kernel.org>
References: <20260514135342.22130-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We now expect nop combo with 10 bytes nop instead of 5 bytes nop,
fixing has_nop_combo to reflect that.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/lib/bpf/usdt.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/tools/lib/bpf/usdt.c b/tools/lib/bpf/usdt.c
index e3710933fd52..7e62e4d5bedd 100644
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
+		0x90, 0x66, 0x66, 0x0f, 0x1f, 0x84, 0x00, 0x00, 0x00, 0x00, 0x00,
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
2.53.0

