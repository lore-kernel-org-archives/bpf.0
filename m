Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 239D240DFC2;
	Fri, 17 Apr 2026 19:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776453982; cv=none; b=AIs8U2eTySSNf/TuADtW7oJEWPnP94F/9mqm7H7qxmm16Yco/QY006GBypVG3qe0EOMba+nxdYO3MnaPVKMJPjvqVxuQ57TZC1xgmcaYAJGFDMhJVwf7GMQ4AT8+mC9XH9XubFsqDYg/2i8dnYofrT5ab53qUgCGPY43jKdEZqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776453982; c=relaxed/simple;
	bh=HD1y6+OoID8sNc0HjzA+R7FJ+D03rmtfhHEmP5JHskM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BLGwCWyjQwayWUaBFMf2cZ0NnGB+vBbDigjkwg7SCOTF1XBUiDkC/ctAU7E7LT1rXeG20uFCAlkgQ9nNS/BBidAKb7wsQUnus1Yd8+j2snTV7cAQUCDIUhBMgmR9cGgE4jaucMceaTu5z+/uE9on8IW4bo1a5asTTt5xug0rRdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n7cPm2JT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n7cPm2JT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA2B3C19425;
	Fri, 17 Apr 2026 19:26:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776453981;
	bh=HD1y6+OoID8sNc0HjzA+R7FJ+D03rmtfhHEmP5JHskM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=n7cPm2JTNluHhHY/AaM4R5x8GhpnrLka0oo+9ZGPgPRMVWskPasB8AMdOUuQvKlHQ
	 XcMUdC3bHdt8HZTU212604dNJT+gkkZZE/Xv/rn6P8l1/tz97BxuMkrT6WC5LX0Jz/
	 Z/7C0NgJFtbZ/Lu7cSkH22n/wWIkaw/OlV0TQYjUvdrjkukPmouieR7FV9T0walgjG
	 xsYbUPZSpvPelnfVgwyheSvugm9n1lzMlU+Z1x7kV69kndXBPp1fYGvTfuq7vBejsS
	 W6P/3LKJNhqZ3Cvogx3Uy0mEiXpHKHtuS4UP13tYVK6nLrd9JReDTtdM2aMdUtZvJm
	 CnmEygXcqsmdA==
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
Subject: [PATCHv5 bpf-next 06/28] bpf: Move trampoline image setup into bpf_trampoline_ops callbacks
Date: Fri, 17 Apr 2026 21:24:40 +0200
Message-ID: <20260417192502.194548-7-jolsa@kernel.org>
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

Moving trampoline image setup into bpf_trampoline_ops callbacks,
so we can have different image handling for multi attachment which
is coming in following changes.

There's slight functional change for the unregister path, where we
currently free the image unconditionally even if the detach fails.
The new code keeps the image in place, possibly preventing the crash.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 kernel/bpf/trampoline.c | 66 ++++++++++++++++++++++++-----------------
 1 file changed, 38 insertions(+), 28 deletions(-)

diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index e3b4e504fdb2..ad4ddb62d22f 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -59,11 +59,10 @@ static void trampoline_unlock(struct bpf_trampoline *tr)
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
@@ -425,9 +424,11 @@ static int bpf_trampoline_update_fentry(struct bpf_trampoline *tr, u32 orig_flag
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
@@ -435,13 +436,19 @@ static int unregister_fentry(struct bpf_trampoline *tr, u32 orig_flags,
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
@@ -450,12 +457,20 @@ static int modify_fentry(struct bpf_trampoline *tr, u32 orig_flags,
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
@@ -473,7 +488,11 @@ static int register_fentry(struct bpf_trampoline *tr, void *new_addr, void *data
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
@@ -663,9 +682,7 @@ static int bpf_trampoline_update(struct bpf_trampoline *tr, bool lock_direct_mut
 		return PTR_ERR(tlinks);
 
 	if (total == 0) {
-		err = ops->unregister_fentry(tr, orig_flags, tr->cur_image->image, data);
-		bpf_tramp_image_put(tr->cur_image);
-		tr->cur_image = NULL;
+		err = ops->unregister_fentry(tr, orig_flags, data);
 		goto out;
 	}
 
@@ -734,11 +751,10 @@ static int bpf_trampoline_update(struct bpf_trampoline *tr, bool lock_direct_mut
 	WARN_ON(tr->cur_image && total == 0);
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
2.53.0

