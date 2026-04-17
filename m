Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D13362C08DC;
	Fri, 17 Apr 2026 19:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776453992; cv=none; b=szVHK60qFZwbLFKTJDRjM/nAvo2EZQxAmwxJeRlKTd+WN612YzSnCjFib4cDDGLBdfqkUrIUyf6UKr3JIrYttHGafrNRkN9UUMKtjmYH5G+KlND+UTgVwruYjsV6uspagXMAsLTd1DA2RoaVWg/xheYh4HgqsDqr8Ib7Zb2fdGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776453992; c=relaxed/simple;
	bh=/sMtOgdLB+5EvoAgh/Svbdi7UwqLp2zxoU+6Zyl822o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W2gTozIxib8ST1nYpVbDqp40lhZEL1rLUMZiN/A5sjZ34+AMxzMgcVmviFmg72nuYnkqN/1JAZO145lUW2LGJ2alJTcQ1YUnAdLnZnf8COLeuvsODor+97glMeOLbvEIs3GwZYb/FxJZv21uuTiS/REECrkrt2UCZ0ZqEMTGbl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JVVDKu0u; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JVVDKu0u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04D6EC19425;
	Fri, 17 Apr 2026 19:26:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776453992;
	bh=/sMtOgdLB+5EvoAgh/Svbdi7UwqLp2zxoU+6Zyl822o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JVVDKu0up8GZwA6nfh4YOY5I8Irf7EgE9CL6Fv1sBd2nBzH/PdHf7xbt8T9G/2aE8
	 PJrR8W72qz9aVtmHtzTMZsPJVwtSCVjhSeFVHMWjNlgzjGNtC3JkteMi9eez85bKii
	 t8YLaDlD6jaO67Tldk+3KGtimXa3RWA9xdhlxSVnZrHq4eX40XqsFp5yUfzyU6wYUX
	 JuVDnO3gceRzJ6V91bsBP6cuD+nFrvg6YaLJ5V1BnMvWQYGGEbJwAQWsIypWFqkeiy
	 OXede7HNI3qYFkowHBAkEM3TWk4ALxE0BUutlF+qvSYzae3Winsa9LNWS96KTN0KHp
	 BKKjRN6gwCotw==
From: Jiri Olsa <jolsa@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	Menglong Dong <menglong8.dong@gmail.com>,
	Steven Rostedt <rostedt@kernel.org>
Subject: [PATCHv5 bpf-next 07/28] bpf: Add bpf_trampoline_add/remove_prog functions
Date: Fri, 17 Apr 2026 21:24:41 +0200
Message-ID: <20260417192502.194548-8-jolsa@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260417192502.194548-1-jolsa@kernel.org>
References: <20260417192502.194548-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Separate bpf_trampoline_add/remove_prog functions from
__bpf_trampoline_link/unlink functions to be able to add/remove
trampoline programs without the image being updated in following
changes. No functional change is intended.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 kernel/bpf/trampoline.c | 108 +++++++++++++++++++++++-----------------
 1 file changed, 61 insertions(+), 47 deletions(-)

diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index ad4ddb62d22f..71e5a121c2fd 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -820,41 +820,16 @@ static int bpf_freplace_check_tgt_prog(struct bpf_prog *tgt_prog)
 	return 0;
 }
 
-static int __bpf_trampoline_link_prog(struct bpf_tramp_link *link,
-				      struct bpf_trampoline *tr,
-				      struct bpf_prog *tgt_prog,
-				      const struct bpf_trampoline_ops *ops,
-				      void *data)
+static int bpf_trampoline_add_prog(struct bpf_trampoline *tr,
+				   struct bpf_tramp_link *link,
+				   int cnt)
 {
 	struct bpf_fsession_link *fslink = NULL;
 	enum bpf_tramp_prog_type kind;
 	struct bpf_tramp_link *link_exiting;
 	struct hlist_head *prog_list;
-	int err = 0;
-	int cnt = 0, i;
 
 	kind = bpf_attach_type_to_tramp(link->link.prog);
-	if (tr->extension_prog)
-		/* cannot attach fentry/fexit if extension prog is attached.
-		 * cannot overwrite extension prog either.
-		 */
-		return -EBUSY;
-
-	for (i = 0; i < BPF_TRAMP_MAX; i++)
-		cnt += tr->progs_cnt[i];
-
-	if (kind == BPF_TRAMP_REPLACE) {
-		/* Cannot attach extension if fentry/fexit are in use. */
-		if (cnt)
-			return -EBUSY;
-		err = bpf_freplace_check_tgt_prog(tgt_prog);
-		if (err)
-			return err;
-		tr->extension_prog = link->link.prog;
-		return bpf_arch_text_poke(tr->func.addr, BPF_MOD_NOP,
-					  BPF_MOD_JUMP, NULL,
-					  link->link.prog->bpf_func);
-	}
 	if (kind == BPF_TRAMP_FSESSION) {
 		prog_list = &tr->progs_hlist[BPF_TRAMP_FENTRY];
 		cnt++;
@@ -882,17 +857,64 @@ static int __bpf_trampoline_link_prog(struct bpf_tramp_link *link,
 	} else {
 		tr->progs_cnt[kind]++;
 	}
-	err = bpf_trampoline_update(tr, true /* lock_direct_mutex */, ops, data);
-	if (err) {
-		hlist_del_init(&link->tramp_hlist);
-		if (kind == BPF_TRAMP_FSESSION) {
-			tr->progs_cnt[BPF_TRAMP_FENTRY]--;
-			hlist_del_init(&fslink->fexit.tramp_hlist);
-			tr->progs_cnt[BPF_TRAMP_FEXIT]--;
-		} else {
-			tr->progs_cnt[kind]--;
-		}
+	return 0;
+}
+
+static void bpf_trampoline_remove_prog(struct bpf_trampoline *tr,
+				    struct bpf_tramp_link *link)
+{
+	struct bpf_fsession_link *fslink;
+	enum bpf_tramp_prog_type kind;
+
+	kind = bpf_attach_type_to_tramp(link->link.prog);
+	if (kind == BPF_TRAMP_FSESSION) {
+		fslink = container_of(link, struct bpf_fsession_link, link.link);
+		hlist_del_init(&fslink->fexit.tramp_hlist);
+		tr->progs_cnt[BPF_TRAMP_FEXIT]--;
+		kind = BPF_TRAMP_FENTRY;
+	}
+	hlist_del_init(&link->tramp_hlist);
+	tr->progs_cnt[kind]--;
+}
+
+static int __bpf_trampoline_link_prog(struct bpf_tramp_link *link,
+				      struct bpf_trampoline *tr,
+				      struct bpf_prog *tgt_prog,
+				      const struct bpf_trampoline_ops *ops,
+				      void *data)
+{
+	enum bpf_tramp_prog_type kind;
+	int err = 0;
+	int cnt = 0, i;
+
+	kind = bpf_attach_type_to_tramp(link->link.prog);
+	if (tr->extension_prog)
+		/* cannot attach fentry/fexit if extension prog is attached.
+		 * cannot overwrite extension prog either.
+		 */
+		return -EBUSY;
+
+	for (i = 0; i < BPF_TRAMP_MAX; i++)
+		cnt += tr->progs_cnt[i];
+
+	if (kind == BPF_TRAMP_REPLACE) {
+		/* Cannot attach extension if fentry/fexit are in use. */
+		if (cnt)
+			return -EBUSY;
+		err = bpf_freplace_check_tgt_prog(tgt_prog);
+		if (err)
+			return err;
+		tr->extension_prog = link->link.prog;
+		return bpf_arch_text_poke(tr->func.addr, BPF_MOD_NOP,
+					  BPF_MOD_JUMP, NULL,
+					  link->link.prog->bpf_func);
 	}
+	err = bpf_trampoline_add_prog(tr, link, cnt);
+	if (err)
+		return err;
+	err = bpf_trampoline_update(tr, true /* lock_direct_mutex */, ops, data);
+	if (err)
+		bpf_trampoline_remove_prog(tr, link);
 	return err;
 }
 
@@ -927,16 +949,8 @@ static int __bpf_trampoline_unlink_prog(struct bpf_tramp_link *link,
 		guard(mutex)(&tgt_prog->aux->ext_mutex);
 		tgt_prog->aux->is_extended = false;
 		return err;
-	} else if (kind == BPF_TRAMP_FSESSION) {
-		struct bpf_fsession_link *fslink =
-			container_of(link, struct bpf_fsession_link, link.link);
-
-		hlist_del_init(&fslink->fexit.tramp_hlist);
-		tr->progs_cnt[BPF_TRAMP_FEXIT]--;
-		kind = BPF_TRAMP_FENTRY;
 	}
-	hlist_del_init(&link->tramp_hlist);
-	tr->progs_cnt[kind]--;
+	bpf_trampoline_remove_prog(tr, link);
 	return bpf_trampoline_update(tr, true /* lock_direct_mutex */, ops, data);
 }
 
-- 
2.53.0

