Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24DC536B042;
	Tue, 24 Feb 2026 10:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771929587; cv=none; b=LNo6N5cMMUANR7MMfh2l+XJslA9Km4HGnmM4dSYZxKTqoAFEuT5kYA+4wd932jwsd5LEKS4EIo19VXyLrGZl7bmHybqsvqRfSBxiEXkBG9j6GBwxVRW+uRFSF1Cy8lhZRDV9g6OVtDflPIXqCg8BjXAx42b8GDzUdCwCHxUcWfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771929587; c=relaxed/simple;
	bh=YBAss1AXFulyJXE+1UqkNKMBsJd/Obe6LLBaU3cldBA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kCUGeVlvSeJFxBkdaREvT7jPUtidHuIhnQYFaQF5eAO/94ilTJGp+LURmuh0P7mreGHEUuahBKbTp8oa2otd+Xc7v1ileaJVurMsGGOXy8asa6HCipSZC+qhfAO26tT+6xauChGU69/Qk08t0cmqDiAoaqYS9j1JyBuLhhXKkSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oDsw9/Ag; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oDsw9/Ag"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24D3AC116D0;
	Tue, 24 Feb 2026 10:39:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771929587;
	bh=YBAss1AXFulyJXE+1UqkNKMBsJd/Obe6LLBaU3cldBA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oDsw9/Ag1gFzapGGfvKzgvByP1BccZzYLMkwXR/VBs6n0b0fJqxe3MmYLKWn/PIOX
	 9CnV5GOGtMoS4glPc5NQnzJT0OgRRIwmMARLpgAdReAmg+mgJ6eirfIPC0OXJfbaO/
	 pFnzpNchEbwu5PXo8o5aLiBZPLr+7N5ENfmqnj6/boW7tCbLNVTcW9xx0VulpHIstd
	 4ZZzMx+MrEA7OEuWeNYMsrci9MDLufCw/bIDQujw9n/qBNL6l1HOSCoEU1EJBVkYCb
	 8g+jSQN/ktwu7C0WVD108LUKCKeh6rgA25yRdY/S+J0bPERlXZeTeBz9h14MN3Ooqc
	 AYlEPc4Zzbohg==
From: Jiri Olsa <jolsa@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>
Subject: [PATCHv5 bpf-next 2/5] libbpf: Add support to detect nop,nop5 instructions combo for usdt probe
Date: Tue, 24 Feb 2026 11:39:12 +0100
Message-ID: <20260224103915.1369690-3-jolsa@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260224103915.1369690-1-jolsa@kernel.org>
References: <20260224103915.1369690-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adding support to detect nop,nop5 instructions combo for usdt probe
by checking on probe's following nop5 instruction.

When the nop,nop5 combo is detected together with uprobe syscall,
we can place the probe on top of nop5 and get it optimized.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/lib/bpf/usdt.c | 47 ++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 43 insertions(+), 4 deletions(-)

diff --git a/tools/lib/bpf/usdt.c b/tools/lib/bpf/usdt.c
index d1524f6f54ae..e3710933fd52 100644
--- a/tools/lib/bpf/usdt.c
+++ b/tools/lib/bpf/usdt.c
@@ -262,6 +262,7 @@ struct usdt_manager {
 	bool has_bpf_cookie;
 	bool has_sema_refcnt;
 	bool has_uprobe_multi;
+	bool has_uprobe_syscall;
 };
 
 struct usdt_manager *usdt_manager_new(struct bpf_object *obj)
@@ -301,6 +302,13 @@ struct usdt_manager *usdt_manager_new(struct bpf_object *obj)
 	 * usdt probes.
 	 */
 	man->has_uprobe_multi = kernel_supports(obj, FEAT_UPROBE_MULTI_LINK);
+
+	/*
+	 * Detect kernel support for uprobe() syscall, it's presence means we can
+	 * take advantage of faster nop5 uprobe handling.
+	 * Added in: 56101b69c919 ("uprobes/x86: Add uprobe syscall to speed up uprobe")
+	 */
+	man->has_uprobe_syscall = kernel_supports(obj, FEAT_UPROBE_SYSCALL);
 	return man;
 }
 
@@ -585,13 +593,34 @@ static int parse_usdt_note(GElf_Nhdr *nhdr, const char *data, size_t name_off,
 
 static int parse_usdt_spec(struct usdt_spec *spec, const struct usdt_note *note, __u64 usdt_cookie);
 
-static int collect_usdt_targets(struct usdt_manager *man, Elf *elf, const char *path, pid_t pid,
-				const char *usdt_provider, const char *usdt_name, __u64 usdt_cookie,
-				struct usdt_target **out_targets, size_t *out_target_cnt)
+#if defined(__x86_64__)
+static bool has_nop_combo(int fd, long off)
+{
+	unsigned char nop_combo[6] = {
+		0x90, 0x0f, 0x1f, 0x44, 0x00, 0x00 /* nop,nop5 */
+	};
+	unsigned char buf[6];
+
+	if (pread(fd, buf, 6, off) != 6)
+		return false;
+	return memcmp(buf, nop_combo, 6) == 0;
+}
+#else
+static bool has_nop_combo(int fd, long off)
+{
+	return false;
+}
+#endif
+
+static int collect_usdt_targets(struct usdt_manager *man, struct elf_fd *elf_fd, const char *path,
+				pid_t pid, const char *usdt_provider, const char *usdt_name,
+				__u64 usdt_cookie, struct usdt_target **out_targets,
+				size_t *out_target_cnt)
 {
 	size_t off, name_off, desc_off, seg_cnt = 0, vma_seg_cnt = 0, target_cnt = 0;
 	struct elf_seg *segs = NULL, *vma_segs = NULL;
 	struct usdt_target *targets = NULL, *target;
+	Elf *elf = elf_fd->elf;
 	long base_addr = 0;
 	Elf_Scn *notes_scn, *base_scn;
 	GElf_Shdr base_shdr, notes_shdr;
@@ -784,6 +813,16 @@ static int collect_usdt_targets(struct usdt_manager *man, Elf *elf, const char *
 		target = &targets[target_cnt];
 		memset(target, 0, sizeof(*target));
 
+		/*
+		 * We have uprobe syscall and usdt with nop,nop5 instructions combo,
+		 * so we can place the uprobe directly on nop5 (+1) and get this probe
+		 * optimized.
+		 */
+		if (man->has_uprobe_syscall && has_nop_combo(elf_fd->fd, usdt_rel_ip)) {
+			usdt_abs_ip++;
+			usdt_rel_ip++;
+		}
+
 		target->abs_ip = usdt_abs_ip;
 		target->rel_ip = usdt_rel_ip;
 		target->sema_off = usdt_sema_off;
@@ -998,7 +1037,7 @@ struct bpf_link *usdt_manager_attach_usdt(struct usdt_manager *man, const struct
 	/* discover USDT in given binary, optionally limiting
 	 * activations to a given PID, if pid > 0
 	 */
-	err = collect_usdt_targets(man, elf_fd.elf, path, pid, usdt_provider, usdt_name,
+	err = collect_usdt_targets(man, &elf_fd, path, pid, usdt_provider, usdt_name,
 				   usdt_cookie, &targets, &target_cnt);
 	if (err <= 0) {
 		err = (err == 0) ? -ENOENT : err;
-- 
2.53.0

