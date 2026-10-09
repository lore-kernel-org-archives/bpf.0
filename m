Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 023054C6531
	for <bpf@vger.kernel.org>; Fri,  9 Oct 2026 10:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791542924; cv=none; b=XkBtyNCqy1PvH28B28b3qfan/Ia42u/kKgR/G8q1DMy/P6cztLEJEnCNKKPPELeErXxWPPF1uUeNt46yosO2AYxK/RXJO5xYfjESQx+vSgA3SzdGfGkFyB8Ip5FN4EmDzPJ9IHLTKOvae60mNwq4i0tbCh/fq3R85K7i11hi5Os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791542924; c=relaxed/simple;
	bh=IQwsFkcW9oS/4Ckta/Qx9Ds62lvNaPDGjSRSpZEtjyA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PiLcGBvtKHvtY4gY/THLsG4tAFzhGq/wfkHpLjsVmFpqqMkgigJ+uHw+AxQ6NT3K4S9UtMKZ9KDCzVooaa1eQdlg1s00vUqW+tpfIhckXZvzF6Ojyx5fkkaYkGw/P5Y4vpIJM+y8eppHnKA9b8VbpV38TlRJr/m+8uwjVhKJ4CU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fQBZdTRi; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fQBZdTRi"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-381b831d535so6250219a91.0
        for <bpf@vger.kernel.org>; Fri, 09 Oct 2026 03:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791542910; x=1792147710; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WtGQ+WqgXKrFef+L9zxfGghIHt/+lb5ctIYIomiT8os=;
        b=fQBZdTRi5eCWpY74U81OQDQyULBOIqGJsECC60IA2HcnXTZgi/c8ArZ+vOOncSOQpB
         so1iWPY0SZh2/7b0Vu6CoSP3zqdBBwQnyE7pL7aFClzVC6d+np9NW7WtFQqUulJdqJRD
         wLGNP9ZSS9rEngn1giLOeIPgH5/cUvKEPaau39Ufx8DALabkN8WXIDC2tdg1rI4ZHT4n
         +bLW884aIQLbwteJRdUaYWrYbSRbVNxshVfzqE8KTN36ehLtPmMDHjxWK6mQqeNNLC1w
         /bFBtFmZ+XNVKatxOWTEFuuka4q0Ykp3ZHyKJbWqJUBNBUsycYsapUYz/eEXOmkp7Tes
         s+WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791542910; x=1792147710;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WtGQ+WqgXKrFef+L9zxfGghIHt/+lb5ctIYIomiT8os=;
        b=nOhEAnWQZqgbaEyb9O9qhImSfAEGdNbsUvxWXw05bmAyN4AgW8SIG4b4wWKh0GVY7A
         9hGifm07KEXCyOk8vgAQoVM35CRipAWTzY/NqfnNhmQfOJIy5T7ljmrgQRrx+T1Dwq8J
         kKT2lywWd/2fCiaMz8zzlVa5Jl6HGMNpMrvqlQv4FGSirtcUv8lAf8bCdbGydLlcDWVb
         hEZITv8KU1+/1coPOa7It4RF1JCnhA/zXJzU5HP2oFoVf6TKFlZVD+NraMuOqnuEd4Ba
         UiWJLYGYtYvt7YxmVOpCE0meB4E0svCs9ckkm1CfcSc1bLVO24GNgciqmyWuQm/Wqw/b
         kpQw==
X-Gm-Message-State: AFq9FYJACZvllbghQcRxJxtfFUsrQ+lIC5gWwjHG7QJ5vMcB48Jfu3NI
	toIEMWzCsxgkewOjPUvgrElyfXrV2LQx6kYEKCaErQHaq23bVWkR8EMlRbOxBA==
X-Gm-Gg: AYBFou2xfYrn2b44VOMx2qJvAlQf2CZdaktgLGS8lDdJncMSAYPZ9FI+VCBNQc1WQc/
	k+6siDB67CsbNeqEYwnUSu88xGRC4BR4ngnwLHwa+q4jGKsnzYVFxc+p7i0Fjy7AVvfuRAKlSc4
	iPFufSwKsej56Ch0QzmNW9bGb5ustyG+WnlL5vmRcZX2PaL8R5ysQYrLOsP5yPEKgIJ8lFyZPu6
	eNgjPOQtAdSHVvLhvwanpSrIKHUT16RBLoq22rCro0aP2KKVfvbonMl+swEmDuviKvy9pUA/btH
	cMSMy57fAks43dJEE6R8HJxQzxEaif9g6ipMS0A0nJK+Xu3n7Vkd6sBGnG91idZrMiA1czDSVgE
	p9eBdHdiJBO0jZipc9/z9KxFK6+pbiamRFqEuyLk0QWq4koACIVKroBWUeFK/njyp4w1hIvxtKK
	jAwx+RFMJZceypkfza+y6d60GE78rRDesbsNRVIX6xxEhsS5LEm9XPOt4X+RhowFMD1hIkfDb8Z
	5bEU0MWK5V7HXU=
X-Received: by 2002:a17:90b:224c:b0:3a8:bbc2:5551 with SMTP id 98e67ed59e1d1-3ab3a0f0a1dmr1589395a91.0.1791542910250;
        Fri, 09 Oct 2026 03:48:30 -0700 (PDT)
Received: from badger ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab36ed053csm3050107a91.4.2026.10.09.03.48.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 03:48:30 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v3 16/51] bpf: expose bpf_grow_stack_state()
Date: Fri,  9 Oct 2026 03:47:34 -0700
Message-ID: <20261009-scev-minimal-rebase-v3-16-bcba9bc53ac9@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261009-scev-minimal-rebase-v3-0-bcba9bc53ac9@gmail.com>
References: <20261009-scev-minimal-rebase-v3-0-bcba9bc53ac9@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

When windening SCEV expressions like *fp-8 -> (any *fp-8 *fp-16),
fp-8 might be not yet allocated. Expose a utility function such
that widening logic can handle this.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 include/linux/bpf_verifier.h | 3 ++-
 kernel/bpf/verifier.c        | 4 ++--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 5ec9495d42b1..ab86b75888c3 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -522,7 +522,7 @@ static inline u32 bpf_stack_nr_slots(const struct bpf_func_state *frame)
 
 /*
  * Stack slot @spi of @frame, covering bytes [fp - (spi + 1) * 8, fp - spi * 8).
- * The caller must ensure spi < bpf_stack_nr_slots(frame), see grow_stack_state().
+ * The caller must ensure spi < bpf_stack_nr_slots(frame), see bpf_grow_stack_state().
  */
 static inline struct bpf_stack_state *bpf_stack_slot(const struct bpf_func_state *frame, u32 spi)
 {
@@ -1297,6 +1297,7 @@ void bpf_bt_sync_linked_regs(struct backtrack_state *bt, struct bpf_jmp_history_
 void bpf_mark_reg_not_init(const struct bpf_verifier_env *env,
 			   struct bpf_reg_state *reg);
 void bpf_mark_reg_unknown_imprecise(struct bpf_reg_state *reg);
+int bpf_grow_stack_state(struct bpf_verifier_env *env, struct bpf_func_state *state, int size);
 void bpf_mark_all_scalars_precise(struct bpf_verifier_env *env,
 				  struct bpf_verifier_state *st);
 void bpf_clear_singular_ids(struct bpf_verifier_env *env, struct bpf_verifier_state *st);
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index e317cdae749e..47a632a6749a 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -1456,7 +1456,7 @@ static int resize_reference_state(struct bpf_verifier_state *state, size_t n)
 /* Possibly update state->allocated_stack to be at least size bytes. Also
  * possibly update the function's high-water mark in its bpf_subprog_info.
  */
-static int grow_stack_state(struct bpf_verifier_env *env, struct bpf_func_state *state, int size)
+int bpf_grow_stack_state(struct bpf_verifier_env *env, struct bpf_func_state *state, int size)
 {
 	size_t old_n = bpf_stack_nr_slots(state), n;
 
@@ -6705,7 +6705,7 @@ static int check_stack_access_within_bounds(
 	/* Note that there is no stack access with offset zero, so the needed stack
 	 * size is -min_off, not -min_off+1.
 	 */
-	return grow_stack_state(env, state, -min_off /* size */);
+	return bpf_grow_stack_state(env, state, -min_off /* size */);
 }
 
 static bool get_func_retval_range(struct bpf_prog *prog,

-- 
2.53.0
