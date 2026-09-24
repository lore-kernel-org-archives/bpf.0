Received: from mail-wm2-f7.google.com (mail-wm2-f7.google.com [74.125.225.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D04421231
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 08:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790238387; cv=none; b=Kj2onXOkDFh+lUREpg19CBVmjxuOJk5fU6eqXheGhnxvuXIrGh1sq8nmYPsS17dFfyc3ejiIdKIyztWHam8mjC7X8FNJ/0Ou7tCjPt6uDkM8qc3v/bSE1xmpVBRZcRpM2jbqZJsFAHGf6kvfindHrLVRT0IWGw2dGaPhG5Hbl/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790238387; c=relaxed/simple;
	bh=SGvY2ZUtnwziKTgLaOdgjx/vPpkpHJeP48CcfYPJKNs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=duknMazlIn2HTTYZCyqnR5XHB5poJBCq7StVeweeMN7479TwBzVulOH1xhL5oYI6yi4p0vP/PT9TwFqSAdCHrIS2TcIX0SzAq03f2GOW8oyuun71JatvxBNWnjD9ACQiSYg+d/eWNgS0vIzF5HtStIh820p+atg/pWTtT9AB+Zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HIXaIPia; arc=none smtp.client-ip=74.125.225.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HIXaIPia"
Received: by mail-wm2-f7.google.com with SMTP id 5b1f17b1804b1-49fd76faff2so543035e9.1
        for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 01:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790238384; x=1790843184; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=r+XgIwBToVYlNa7a4kGJvfnTDrTbJdXZt/KacnayhxY=;
        b=HIXaIPiaLvUM4N9uU3/4J4e8f/le+iYbG55WbwmHwaQ72d5duHroPaR6SBPcFoz8dp
         vLoRYnmi+4HP4Y1fBS6lFxSiK0Jelv7O32dkVdevwGoTaAhSki7avrjQJddagpF+JG1S
         grl0EApZJTzCteRrF9F07X6DhbJVXzDHL4vjeQQSh9BgHpKolnMMYRb8fygB3I6YaBTu
         VqRmu+HzoeNKldD5SMSAc4l3C1+3k3A/Xnmp76V+bkRk7UAzAxQRVTBSawukVNoQhAKs
         4Zr65C9bSnYW/diCIg5UBq8VXeX/ll1CB2qB8xvqUS9T7JHuAMsUDJDK8z78Ija4cJF5
         eATQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790238384; x=1790843184;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=r+XgIwBToVYlNa7a4kGJvfnTDrTbJdXZt/KacnayhxY=;
        b=a9QD4YqA4C6mRZX71OlHVAnnPKN3Sr9tAV2MUbMS0nt74TSxdtuF60/CtcdcMRcigN
         qGXelfqwrrAECVOqXZysTPHpUiBpJrZAC8LOc7h9y+fOgQW45f7kr2sLhcDhxq36a5J6
         fDEX76ByE2YQ+jTj94ceL3Eq5DKGBiuzGXu+D+O6trrABvfI8wSAyMJPOYD/fqfHfiIH
         f1cq0ytdqE7rDi/drLHTit+LpMebjvHGgPFqJTajyjhohHDd6cTKjJSixVjnavnWO+KN
         VybsKPWyFloymEM7uE0OUPYNAt73gqCs9qPhDBbI+fVAG8LS3uZvdwrkUmUY01llJh79
         SXQw==
X-Gm-Message-State: AFuF++nKo8PsxhCldlDGQ7d37iLTStu6jFcjpekKdSOXC0bBZ5ZmBrUg
	EVosvJi5YLoY7SdpMVyXybc7OwxV2lUPgpGMGaeW2GBem6MUxP8teY6dfPkCUa7c
X-Gm-Gg: AYBFou3OmqGBCrjSfYnryQw7AcorLtsxHaNO0h15hIX3CYBjTrewYBryf0CjZA/B1ZO
	CkmwncnooyTi91G2V3PQtQQENghvUdgMH65Jfjn6wtw1unCOTxF1rDGiI9JQFnDm5DNEwdc04/g
	PZDxmw/vT5lYiJel8kq+ayPsy3ln5op3fhZB9ibkV/3QBnKk8CH7KvintKYWG33TVIp0QU+n3lG
	kZYmoE8btCIdtXQxnLbjzr9Lde8sEka48EG9fz1AdqADqOSR3cMA9Z20BbhlLtu4tHDrdYCtpUR
	4Kdw+fJGiafy5uMXrsCA/boUjCDgKHu8jbm0tRrRgDMZgUFYsLynFjuhno0Og1jI2a+lHm2Yjyx
	jZS+Pz0x+JhN7L3916wd1idzJbN806c3CgdscDks9w0/ZI5Ia9DEz7sSmYWOajwhTqHJceO0nW4
	ORjOKQOzivMfx6PNVlOuPJnDv0nxWcPz46EpaVYjpJI8rF89UVs8gfrS1I5P1B10A4H4+MYLxNn
	MZXbfkJN/IRWIR34KbzNX/u2bXDy6DmKDxDEnvkhH/aMIw42JNX3Lp3eW47rFVjAQZ5EPDSX7l4
	UGss9ZJfdr9OKaCEIbdLqcBQsF5N0KVa950aWA==
X-Received: by 2002:a05:600c:8b5b:b0:49c:f13e:e4d with SMTP id 5b1f17b1804b1-49fe66f17damr26727975e9.10.1790238383569;
        Thu, 24 Sep 2026 01:26:23 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fe0c104a6sm108636525e9.0.2026.09.24.01.26.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 01:26:23 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Tejun Heo <tj@kernel.org>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 08/18] bpf: Grow the verifier id scratch on demand
Date: Thu, 24 Sep 2026 10:25:44 +0200
Message-ID: <20260924082607.2695649-9-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260924082607.2695649-1-memxor@gmail.com>
References: <20260924082607.2695649-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8207; i=memxor@gmail.com; h=from:subject; bh=SGvY2ZUtnwziKTgLaOdgjx/vPpkpHJeP48CcfYPJKNs=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWvLvWTdVb9Zrp9+aa4azeyexNYZUNbPdfzvq//PUzxsP IzTehU6SlkYxLgYZMUUWUr+72MyPlH5O9B2GTfMHFYmkCEMXJwCMBH+Pwx/uMW23v4of1VzKUec woc3EwU6D1btPGMj3qPGk3iE1fvbS0aGSXMF/LT5WLMupH2fv8200bZBY+qP4vqzErde+nHExN5 jBwA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

The id map used to compare the ids of two states, which also serves as
the id stack of release_reference() and as the id set of
bpf_clear_singular_ids(), is a fixed array embedded in struct
bpf_verifier_env and sized for the most registers and stack slots a
state can possibly hold: 1312 entries, 10 KiB, for 512-byte frames, and
four times that once frames may reach 2 KiB, which pushes the env
allocation from 64 KiB to 128 KiB for every program verified. States
compare a few dozen ids in practice.

Turn the map and the set into arrays grown on demand, starting at 64
entries and doubling, and free them with the env. A map that cannot
grow treats the states as different, an id set that cannot grow keeps
the id, and the id stack reports -ENOMEM, which release_reference()
hands to its callers. The iterator destroy path used to warn on any
failure of release_reference(), which could only come from a bug while
the id stack could not run out of room; it now returns -ENOMEM and
keeps warning about anything else. An allocation failure thus fails
the load and is never unsafe. This removes the last structure whose
size scaled with the stack bound and shrinks the env by 10 KiB.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/bpf_verifier.h | 29 ++++++++++++++----------
 kernel/bpf/states.c          | 44 +++++++++++++++++++++++++-----------
 kernel/bpf/verifier.c        | 30 +++++++++++++++---------
 3 files changed, 67 insertions(+), 36 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index b314b9425b86..3ff1d4f753d3 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -408,10 +408,7 @@ struct bpf_jmp_history_entry {
 static_assert(MAX_CALL_FRAMES <= (1 << 4));
 static_assert(MAX_BPF_STACK_SLOTS <= (1 << 12));
 
-/* Maximum number of bpf_reg_state objects that can exist at once */
 #define MAX_STACK_ARG_SLOTS (MAX_BPF_FUNC_ARGS - MAX_BPF_FUNC_REG_ARGS)
-#define BPF_ID_MAP_SIZE ((MAX_BPF_REG + MAX_BPF_STACK_SLOTS + MAX_STACK_ARG_SLOTS) * \
-			 MAX_CALL_FRAMES)
 struct bpf_verifier_state {
 	/* call stack tracking */
 	struct bpf_func_state *frame[MAX_CALL_FRAMES];
@@ -861,18 +858,27 @@ struct bpf_id_pair {
 	u32 cur;
 };
 
+/*
+ * Scratch map from the ids of one verifier state to those of another, also
+ * used as a stack of ids. Grown on demand by bpf_id_scratch_reserve().
+ */
 struct bpf_idmap {
 	u32 tmp_id_gen;
 	u32 cnt;
-	struct bpf_id_pair map[BPF_ID_MAP_SIZE];
+	u32 cap;
+	struct bpf_id_pair *map;
 };
 
+struct bpf_idset_entry {
+	u32 id;
+	u32 cnt;
+};
+
+/* Scratch set of ids with a use count each, grown on demand */
 struct bpf_idset {
 	u32 num_ids;
-	struct {
-		u32 id;
-		u32 cnt;
-	} entries[BPF_ID_MAP_SIZE];
+	u32 cap;
+	struct bpf_idset_entry *entries;
 };
 
 /* see verifier.c:compute_scc_callchain() */
@@ -981,10 +987,8 @@ struct bpf_verifier_env {
 	 * via callx. Allocated when the first such edge is recorded.
 	 */
 	unsigned long *callx_edges;
-	union {
-		struct bpf_idmap idmap_scratch;
-		struct bpf_idset idset_scratch;
-	};
+	struct bpf_idmap idmap_scratch;
+	struct bpf_idset idset_scratch;
 	struct {
 		int *insn_state;
 		int *insn_stack;
@@ -1248,6 +1252,7 @@ int bpf_copy_verifier_state(struct bpf_verifier_state *dst_state,
 struct list_head *bpf_explored_state(struct bpf_verifier_env *env, int idx);
 void bpf_free_verifier_state(struct bpf_verifier_state *state, bool free_self);
 void bpf_free_backedges(struct bpf_scc_visit *visit);
+bool bpf_id_scratch_reserve(void **arr, u32 *cap, u32 cnt, size_t elem_size);
 int bpf_push_jmp_history(struct bpf_verifier_env *env, struct bpf_verifier_state *cur,
 			 int insn_flags, int spi, int frame, const u16 *linked_regs,
 			 u8 linked_regs_cnt);
diff --git a/kernel/bpf/states.c b/kernel/bpf/states.c
index a7c87a1d8cc8..a07af8f11a5a 100644
--- a/kernel/bpf/states.c
+++ b/kernel/bpf/states.c
@@ -335,21 +335,18 @@ static bool check_ids(u32 old_id, u32 cur_id, struct bpf_idmap *idmap)
 			return false;
 	}
 
-	/* Reached the end of known mappings; haven't seen this id before */
-	if (idmap->cnt < BPF_ID_MAP_SIZE) {
-		map[idmap->cnt].old = old_id;
-		map[idmap->cnt].cur = cur_id;
-		idmap->cnt++;
-		return true;
-	}
-
 	/*
-	 * idmap slots are bounded by the number of registers and stack slots.
-	 * Since referenced dynptrs acquire intermediate references that do
-	 * not live in either, so the map can be exhausted. Since it is unlikely,
-	 * fail the verification by treating the states as not equivalent.
+	 * Reached the end of known mappings; haven't seen this id before. If
+	 * the map cannot grow, treat the states as not equivalent, which only
+	 * costs pruning.
 	 */
-	return false;
+	if (!bpf_id_scratch_reserve((void **)&idmap->map, &idmap->cap, idmap->cnt, sizeof(*map)))
+		return false;
+	map = idmap->map;
+	map[idmap->cnt].old = old_id;
+	map[idmap->cnt].cur = cur_id;
+	idmap->cnt++;
+	return true;
 }
 
 /*
@@ -965,6 +962,27 @@ static bool func_states_equal(struct bpf_verifier_env *env, struct bpf_func_stat
 	return true;
 }
 
+/*
+ * Make room for one more entry in an id scratch array, doubling it as needed.
+ * Returns false if it could not grow; callers then treat the id as unknown
+ * or the states as different, which is always safe.
+ */
+bool bpf_id_scratch_reserve(void **arr, u32 *cap, u32 cnt, size_t elem_size)
+{
+	u32 new_cap;
+	void *p;
+
+	if (cnt < *cap)
+		return true;
+	new_cap = *cap ? *cap * 2 : 64;
+	p = krealloc_array(*arr, new_cap, elem_size, GFP_KERNEL_ACCOUNT | __GFP_NOWARN);
+	if (!p)
+		return false;
+	*arr = p;
+	*cap = new_cap;
+	return true;
+}
+
 static void reset_idmap_scratch(struct bpf_verifier_env *env)
 {
 	struct bpf_idmap *idmap = &env->idmap_scratch;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 8b7f2c283e5a..aebe2e6b2a3d 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -1041,7 +1041,7 @@ static int unmark_stack_slots_iter(struct bpf_verifier_env *env,
 				   struct bpf_reg_state *reg, int nr_slots)
 {
 	struct bpf_func_state *state = bpf_func(env, reg);
-	int spi, i, j;
+	int spi, i, j, err;
 
 	spi = iter_get_spi(env, reg, nr_slots);
 	if (spi < 0)
@@ -1051,8 +1051,12 @@ static int unmark_stack_slots_iter(struct bpf_verifier_env *env,
 		struct bpf_stack_state *slot = bpf_stack_slot(state, spi - i);
 		struct bpf_reg_state *st = &slot->spilled_ptr;
 
-		if (i == 0)
-			WARN_ON_ONCE(release_reference(env, st->id));
+		if (i == 0) {
+			err = release_reference(env, st->id);
+			if (err == -ENOMEM)
+				return err;
+			WARN_ON_ONCE(err);
+		}
 
 		bpf_mark_reg_not_init(env, st);
 
@@ -10506,8 +10510,9 @@ static int idstack_push(struct bpf_idmap *idmap, u32 id)
 		if (idmap->map[i].old == id)
 			return 0;
 
-	if (WARN_ON_ONCE(idmap->cnt >= BPF_ID_MAP_SIZE))
-		return -EFAULT;
+	if (!bpf_id_scratch_reserve((void **)&idmap->map, &idmap->cap, idmap->cnt,
+				    sizeof(*idmap->map)))
+		return -ENOMEM;
 
 	idmap->map[idmap->cnt++].old = id;
 	return 0;
@@ -18898,12 +18903,13 @@ static void idset_cnt_inc(struct bpf_idset *idset, u32 id)
 			return;
 		}
 	}
-	/* New id */
-	if (idset->num_ids < BPF_ID_MAP_SIZE) {
-		idset->entries[idset->num_ids].id = id;
-		idset->entries[idset->num_ids].cnt = 1;
-		idset->num_ids++;
-	}
+	/* New id; one that cannot be recorded counts as shared and is kept */
+	if (!bpf_id_scratch_reserve((void **)&idset->entries, &idset->cap, idset->num_ids,
+				    sizeof(*idset->entries)))
+		return;
+	idset->entries[idset->num_ids].id = id;
+	idset->entries[idset->num_ids].cnt = 1;
+	idset->num_ids++;
 }
 
 /* Find id in idset and return its count, or 0 if not found */
@@ -22612,6 +22618,8 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr,
 	kvfree(env->gotox_tmp_buf);
 	kvfree(env->callx_edges);
 	kvfree(env->func_ptrs);
+	kfree(env->idmap_scratch.map);
+	kfree(env->idset_scratch.entries);
 	bpf_diag_free(env);
 	kvfree(env);
 	return ret;
-- 
2.53.0

