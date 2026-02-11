Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFEA323BD1B;
	Wed, 11 Feb 2026 08:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770799775; cv=none; b=cG6nH572utHyRNtdQ4saMEd6NVDM2oiJQeXm1PBw+5Z1RAo1utsDmJ5/C3gaLTGuMhu3qukUovHdAU69icWA5aNE1xFzqtslqwxO1l2UbzN3fJ41sYsKxkLVXn5uOa5J6BaavQvVAs7dtnEzCNmx4sjGvuFjh0K+zIB2NuQVQZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770799775; c=relaxed/simple;
	bh=/e5FLaITB6aTJI/Ft1Jn5QjDQwpwtZrhk8oW4a8Zxes=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eHBl2hh3iEJ9lBRQ+X0B3opAG/7HF4Mf64XnxrNzXTTNKidUYEsj0R2rHOPVlcfJNU8VldZQ0YeSCTjLrHpaG6BetSJxeshQuCRjyTTC2/HwlsS++iO3QTzLDRjEpDNecndT8BURgpjmdXfb71+T0eSM5+X7/NIEfgI0JDq4TnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jYCU4cGC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jYCU4cGC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3D4EC4CEF7;
	Wed, 11 Feb 2026 08:49:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770799775;
	bh=/e5FLaITB6aTJI/Ft1Jn5QjDQwpwtZrhk8oW4a8Zxes=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jYCU4cGCa4nW3m/zHJPw33tugNASNyF9Snu4FBajL+qpoWv1L49BIhNnP/NWyD+cO
	 hVlQFREDGZW6pLbX27NwF2xXxRo/56y+J/V2R8+dX9/EfrdVrPG9SRRUV7ckTdxwbZ
	 oSSroDdh32+FluBFRPANkQmFO7BoMPJdg9OqwCwnV6G58ZOcVmU33cliEF5Nf9YxlD
	 aIHsT0uJPji4OosQlhF74l95ciF7WEaqj67/52JMiLmRptGtQQIwhh8Vp1ZY/cOjB2
	 Wr6jHbTW7R23AlSYmPRBTiYHid2BCjywm9OcG+jMR3caw9AuPeAvMgjf3iTeCcG6l/
	 /OCyHUyiPLzKA==
From: Jiri Olsa <jolsa@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>
Subject: [PATCHv3 bpf-next 3/5] libbpf: Add support to detect nop,nop5 instructions combo for usdt probe
Date: Wed, 11 Feb 2026 09:48:56 +0100
Message-ID: <20260211084858.750950-4-jolsa@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260211084858.750950-1-jolsa@kernel.org>
References: <20260211084858.750950-1-jolsa@kernel.org>
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

[1] https://github.com/libbpf/usdt
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/lib/bpf/usdt.c | 55 ++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 51 insertions(+), 4 deletions(-)

diff --git a/tools/lib/bpf/usdt.c b/tools/lib/bpf/usdt.c
index d1524f6f54ae..4e5f70bb4c31 100644
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
 
@@ -585,13 +593,42 @@ static int parse_usdt_note(GElf_Nhdr *nhdr, const char *data, size_t name_off,
 
 static int parse_usdt_spec(struct usdt_spec *spec, const struct usdt_note *note, __u64 usdt_cookie);
 
-static int collect_usdt_targets(struct usdt_manager *man, Elf *elf, const char *path, pid_t pid,
-				const char *usdt_provider, const char *usdt_name, __u64 usdt_cookie,
-				struct usdt_target **out_targets, size_t *out_target_cnt)
+#if defined(__x86_64__)
+static bool has_nop_combo(int fd, long off)
+{
+	static unsigned char nop_combo[6] = {
+		0x90, 0x0f, 0x1f, 0x44, 0x00, 0x00 /* nop,nop5 */
+	};
+	unsigned char buf[6] = {};
+
+	/*
+	 * We are using file descriptor that backs Elf object,
+	 * let's dup it to be on the safe side.
+	 */
+	fd = dup(fd);
+	if (fd < 0)
+		return false;
+	if (lseek(fd, off, SEEK_SET) == off)
+		read(fd, buf, 6);
+	close(fd);
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
@@ -784,6 +821,16 @@ static int collect_usdt_targets(struct usdt_manager *man, Elf *elf, const char *
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
@@ -998,7 +1045,7 @@ struct bpf_link *usdt_manager_attach_usdt(struct usdt_manager *man, const struct
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

