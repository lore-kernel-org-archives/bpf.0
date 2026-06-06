Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C3BD1B6D08;
	Sat,  6 Jun 2026 12:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780749662; cv=none; b=tyGGw3TFv79pHlI6xMDnrJzlPs1nseqHZufhrVpMrr0xezXDgrHiqKyYIDSzbB+SD5io+0jKw07T/olXwPOQ5EviCDvdbZ3FBAaI6nfXs8vhzkD2Fo9q2ZYBRHoO2B8rlfVg4K64dfpCCg0VU/tXMl8rEd36F4kTUDb5m9IWNVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780749662; c=relaxed/simple;
	bh=iQfSI80mdmQORZWYXdEYzH8k1rRvEI1BbW1PI6L+CPE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K8Vtnqf77wiyvTmBSiOZ2/GmZSQ7J7G3C2EcTc+QKEoEs+dj+DJYN/3pug3NJf3DXPqE4Vq+VeOoXo+5k53KJfMG7uCbrzKfpuWknni2Vxe5bx5K8yKekaecLYKrimU6vr9Wr7gAWazKvy7sW9oWDfsUdqw5+3F/weAuzx0NCMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TLyEVhaU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TLyEVhaU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66B621F00893;
	Sat,  6 Jun 2026 12:40:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780749661;
	bh=7D3JRekpS7qZoqPVhrSyP3f4CVsqD17S6vTuzpugTDY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TLyEVhaUQoL6EoqXnvplGg/GSVQlaYotIwqh4d1I1fN2KM/F7WpiGmFvkQTRNe45F
	 /pPwOD03DGIWKQ4l8sUYU46lpEv8QxccmPDVkTYuLrIfJneiGpyjWO/BMKzdgJZhCX
	 ivlODYc+nkN0y0wYKzUmGo9I4BTTmTaGM4sLuj7wj2XBYnK+7neOSwLVjAKUeDCvrS
	 9TYbdqWCyad6VNkSoMNZ/2dsBy/W7Gl0ky58M+nEn6EdW95DC4mChaOw7+HhZ8q9iy
	 ilaC45OWP85ywDVOvS94833CwLgkrtJrETHISzDc4H7CVe+BsdRBf3CNBkEwo5pP89
	 seBoCasI4W6OA==
From: Jiri Olsa <jolsa@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	Menglong Dong <menglong8.dong@gmail.com>,
	Steven Rostedt <rostedt@kernel.org>
Subject: [PATCHv8 bpf-next 06/29] bpf: Move trampoline image setup into bpf_trampoline_ops callbacks
Date: Sat,  6 Jun 2026 14:39:31 +0200
Message-ID: <20260606123955.345967-7-jolsa@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260606123955.345967-1-jolsa@kernel.org>
References: <20260606123955.345967-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Moving trampoline image setup into bpf_trampoline_ops callbacks,
so we can have different image handling for multi attachment which
is coming in following changes.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 kernel/bpf/trampoline.c | 66 ++++++++++++++++++++++++-----------------
 1 file changed, 38 insertions(+), 28 deletions(-)

diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index 5c943832fb9d..1006031ea021 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -60,11 +60,10 @@ static void trampoline_unlock(struct bpf_trampoline *tr)
 }
 
 struct bpf_trampoline_ops {
-	int (*register_fentry)(struct bpf_trampoline *tr, void *new_addr, void *data);
-	int (*unregister_fentry)(struct bpf_trampoline *tr, u32 orig_flags, void *old_addr,
-				 void *data);
-	int (*modify_fentry)(struct bpf_trampoline *tr, u32 orig_flags, void *old_addr,
-			     void *new_addr, bool lock_direct_mutex, void *data);
+	int (*register_fentry)(struct bpf_trampoline *tr, struct bpf_tramp_image *im, void *data);
+	int (*unregister_fentry)(struct bpf_trampoline *tr, u32 orig_flags, void *data);
+	int (*modify_fentry)(struct bpf_trampoline *tr, u32 orig_flags, struct bpf_tramp_image *im,
+			     bool lock_direct_mutex, void *data);
 };
 
 #ifdef CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
@@ -426,9 +425,11 @@ static int bpf_trampoline_update_fentry(struct bpf_trampoline *tr, u32 orig_flag
 	return bpf_arch_text_poke(ip, old_t, new_t, old_addr, new_addr);
 }
 
-static int unregister_fentry(struct bpf_trampoline *tr, u32 orig_flags,
-			     void *old_addr, void *data __maybe_unused)
+static void bpf_tramp_image_put(struct bpf_tramp_image *im);
+
+static int unregister_fentry(struct bpf_trampoline *tr, u32 orig_flags, void *data __maybe_unused)
 {
+	void *old_addr = tr->cur_image->image;
 	int ret;
 
 	if (tr->func.ftrace_managed)
@@ -436,13 +437,19 @@ static int unregister_fentry(struct bpf_trampoline *tr, u32 orig_flags,
 	else
 		ret = bpf_trampoline_update_fentry(tr, orig_flags, old_addr, NULL);
 
-	return ret;
+	if (ret)
+		return ret;
+
+	bpf_tramp_image_put(tr->cur_image);
+	tr->cur_image = NULL;
+	return 0;
 }
 
-static int modify_fentry(struct bpf_trampoline *tr, u32 orig_flags,
-			 void *old_addr, void *new_addr,
+static int modify_fentry(struct bpf_trampoline *tr, u32 orig_flags, struct bpf_tramp_image *im,
 			 bool lock_direct_mutex, void *data __maybe_unused)
 {
+	void *old_addr = tr->cur_image->image;
+	void *new_addr = im->image;
 	int ret;
 
 	if (tr->func.ftrace_managed) {
@@ -451,12 +458,20 @@ static int modify_fentry(struct bpf_trampoline *tr, u32 orig_flags,
 		ret = bpf_trampoline_update_fentry(tr, orig_flags, old_addr,
 						   new_addr);
 	}
-	return ret;
+
+	if (ret)
+		return ret;
+
+	bpf_tramp_image_put(tr->cur_image);
+	tr->cur_image = im;
+	return 0;
 }
 
 /* first time registering */
-static int register_fentry(struct bpf_trampoline *tr, void *new_addr, void *data __maybe_unused)
+static int register_fentry(struct bpf_trampoline *tr, struct bpf_tramp_image *im,
+			   void *data __maybe_unused)
 {
+	void *new_addr = im->image;
 	void *ip = tr->func.addr;
 	unsigned long faddr;
 	int ret;
@@ -474,7 +489,11 @@ static int register_fentry(struct bpf_trampoline *tr, void *new_addr, void *data
 		ret = bpf_trampoline_update_fentry(tr, 0, NULL, new_addr);
 	}
 
-	return ret;
+	if (ret)
+		return ret;
+
+	tr->cur_image = im;
+	return 0;
 }
 
 static const struct bpf_trampoline_ops trampoline_ops = {
@@ -664,9 +683,7 @@ static int bpf_trampoline_update(struct bpf_trampoline *tr, bool lock_direct_mut
 		return PTR_ERR(tlinks);
 
 	if (total == 0) {
-		err = ops->unregister_fentry(tr, orig_flags, tr->cur_image->image, data);
-		bpf_tramp_image_put(tr->cur_image);
-		tr->cur_image = NULL;
+		err = ops->unregister_fentry(tr, orig_flags, data);
 		goto out;
 	}
 
@@ -734,11 +751,10 @@ static int bpf_trampoline_update(struct bpf_trampoline *tr, bool lock_direct_mut
 
 	if (tr->cur_image)
 		/* progs already running at this address */
-		err = ops->modify_fentry(tr, orig_flags, tr->cur_image->image,
-					 im->image, lock_direct_mutex, data);
+		err = ops->modify_fentry(tr, orig_flags, im, lock_direct_mutex, data);
 	else
 		/* first time registering */
-		err = ops->register_fentry(tr, im->image, data);
+		err = ops->register_fentry(tr, im, data);
 
 #ifdef CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
 	if (err == -EAGAIN) {
@@ -750,22 +766,16 @@ static int bpf_trampoline_update(struct bpf_trampoline *tr, bool lock_direct_mut
 		goto again;
 	}
 #endif
-	if (err)
-		goto out_free;
 
-	if (tr->cur_image)
-		bpf_tramp_image_put(tr->cur_image);
-	tr->cur_image = im;
+out_free:
+	if (err)
+		bpf_tramp_image_free(im);
 out:
 	/* If any error happens, restore previous flags */
 	if (err)
 		tr->flags = orig_flags;
 	kfree(tlinks);
 	return err;
-
-out_free:
-	bpf_tramp_image_free(im);
-	goto out;
 }
 
 static enum bpf_tramp_prog_type bpf_attach_type_to_tramp(struct bpf_prog *prog)
-- 
2.54.0

