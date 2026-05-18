Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9E1F3F20E0;
	Mon, 18 May 2026 11:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779102041; cv=none; b=LqiPmmMKbaoor6uebZy0kLgCjJV827+XLvLMY9eyZfIQffYHMVEYYbHTy9HhChRuN4/NtkfXbQTLrq785WPknGN+DqjooD52eQ5x7H6lBc421DV4rg2uJQcUF7TrNR0O471+UdF7SOqfl1s17Kbjyn9fb57lGg20J9Bd8PZYusw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779102041; c=relaxed/simple;
	bh=jkZjaMeB7hY2buD7BZ6cwVYXocVJBpBFvl4YSwI5dQ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QrAPZBLtQWgik0IgVD5+ev9QWuYBYrKmVRq8VRfpjKNSs6HgRRlHAbjlqVWMsPIcKNkT4R4rCmYj5qRqITlWO4RUIKQ1Qlol637cA/95vgSQW4q5pmQ3JzQRDlrBC0YKPzhtSvdjsZ3PgEyCsme7RE2KMyhps2WQpV2andDKDaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M8i7Z0b5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M8i7Z0b5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91BA7C2BCB7;
	Mon, 18 May 2026 11:00:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779102040;
	bh=jkZjaMeB7hY2buD7BZ6cwVYXocVJBpBFvl4YSwI5dQ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=M8i7Z0b58v/tUtvMY2ND0IdeFYj9gtqZ8yqQ6t81KN96cw+pY5bqa2egM8ym39P1g
	 OGeCgeuQp/tGl4s122El7pC/OIXdIpbKwyAAHxQKAc5hTVV3OEsBoT86P4uN6LL/KL
	 p8uubCmTBGrAGqQiJvhFiZPRfVxD/s2BdN8PZLzvc7ZRlIuM/JvV7wdKJFsPtOpFHz
	 vkX7ba9mj0Ra8VyaotadIqh6xXmJoLG5rTu6V3IsJXx7SCIAGefkCD9meuv+7GkmFD
	 uqyskykDeOWwSS80uWf+p3yqm4NpXrQ/WCegdnlyzH53OG6cYnzt13GX7+KzVKggkW
	 33a0TOGa1aRDQ==
From: Jiri Olsa <jolsa@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: Jakub Sitnicki <jakub@cloudflare.com>,
	bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCHv2 04/11] libbpf: Change has_nop_combo to work on top of nop10
Date: Mon, 18 May 2026 12:59:50 +0200
Message-ID: <20260518105957.123445-5-jolsa@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260518105957.123445-1-jolsa@kernel.org>
References: <20260518105957.123445-1-jolsa@kernel.org>
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

