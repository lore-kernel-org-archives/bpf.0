Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 303303F9270;
	Wed, 27 May 2026 11:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779882079; cv=none; b=XdH/3Zu571OM9WuLM37BPGvE1ARYW+kNCv5Dq4nkIaU03/0h/+I+SC1nIAEydwp2KAKVEqzo82N0FKm+L81v3vceveHFkkBXbG8hwXOabY2mJNTkbY/nlmj/2G8EvsWM3zPLokI4NpB3xxT3Htu2TdEQmA9Dc/s8YrRDuydv4Jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779882079; c=relaxed/simple;
	bh=bTR4oxYA+F9NmTSwYOzfQoe0goAyxBrw88zAIRXeRTc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b0lKQ3ofyxfNUtr9QIVt5k1pNobQ3OMLu3uuZxvRO6eVVW3WuecQKLJ1ETH6+sXNtIxAaxZuGrlPttvvn3tgPKG1zq/8kx9nMND86fuGZZvoSaKywDTQrmlRNFYkTPpCROT7Ql957mxNsDurbnADMWief8UJndqRPtB5RORLUU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dh7B9dt1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dh7B9dt1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4BC91F000E9;
	Wed, 27 May 2026 11:41:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779882076;
	bh=DmygLWCAfWehd2T/8BJ9g5b5Ozq1qPHC3aZIFcJ8iKc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Dh7B9dt1wujY2L+bMDWgPUiQNTTO/xLm57U82FLp3LDc8v0llCQ9y4uh8OlTrN26H
	 FdZ55OAwZLd6RMe3sZeovGW5e+NFtXVwCDDEs2iW0UM7jfik/kTyQhroo9QSFbwJ8h
	 /zLQELuuWS0QAqZOn+5oefAyKke8N/GMQ/wuXmtHER5blW97Il7caz1O6iOKeTTDHF
	 RQyyZ3IBVF1s7P74Mo0VJoGdLrb6UlY5NeSv/rki/FL41lJyY7bv+lwDzHMTu1RU5r
	 eCpW880U6p2B4ozMD1UwudLOHzRyZJ0hq7ETV4POPpnmNOTC/svSAtd9xkKQX7uMss
	 Gazc8CUGBGMYw==
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
Subject: [PATCHv6 bpf-next 07/29] bpf: Add bpf_trampoline_add/remove_prog functions
Date: Wed, 27 May 2026 13:39:29 +0200
Message-ID: <20260527113951.46265-8-jolsa@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260527113951.46265-1-jolsa@kernel.org>
References: <20260527113951.46265-1-jolsa@kernel.org>
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
index 7661738c1bd0..70724b0d8fb8 100644
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
2.54.0

