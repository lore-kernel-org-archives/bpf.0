Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B2243CF661
	for <bpf@vger.kernel.org>; Thu, 16 Jul 2026 08:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784191449; cv=none; b=jnBC5D9DAco+OtsQaIYJ7AzgayvSuK3fItzUt3iRWcBXi/WhheXb8i8QI2FkZ6XHdJTDN1GXgJACslBktB4L93CSgF4MQJ8FpH2kvHG5fVoG/05F+ti1bjpwhAlP2NjTw2YPKRgoW9U0GXiBodKYCRXMPFYZ6N2qiHRQx1ox0I4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784191449; c=relaxed/simple;
	bh=FNp0LF73oMrRqxmEDPZiDkxtu9dBbjdVTdY2tC98oGk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mVZ1eJbayzpA4dlrdqxDKWe5W2wllXTtR3kEp6j2UeeZM0FD10kTJtu0IjRVNRSSEgTmnG4Nq7zmGePR6K8Zn7d4Q/L4ya2IKBxXzM4mT/eOEXwZwu7uOhPBkhkd0RoZeo3szC3zrJSs5wdHz/YTFbXQ2Owh5E6bLnlJLwYh/7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FnJMyG5F; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FnJMyG5F"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784191443;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PSuxZuUD5WiJ17/GaOn+xt1UMmsQRqTvDVf84o+44Zk=;
	b=FnJMyG5FFs5hanxSpJ+odiCtKLwsTJsh4z5WnQOFAXEEsZdtv5cIoFG7FuBh31A/TTJYfn
	6B06XEiLueJ/M0jMPBmO8q8GtVLUjScSv4ogdnJfvkztRAEC6jQASlEIl9aGNK/mntT6r4
	LDwN+lUeNVtWK757J/1o3qyi/OjNvnI=
From: Hui Zhu <hui.zhu@linux.dev>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Hui Zhu <zhuhui@kylinos.cn>
Subject: [PATCH bpf-next 2/2] bpf: Fix UAF in bpf_trampoline_multi_detach when ftrace update fails
Date: Thu, 16 Jul 2026 16:43:39 +0800
Message-ID: <d1fcbede8f311db5cfa7cbe34371de7b63186ce5.1784191209.git.zhuhui@kylinos.cn>
In-Reply-To: <cover.1784191209.git.zhuhui@kylinos.cn>
References: <cover.1784191209.git.zhuhui@kylinos.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Hui Zhu <zhuhui@kylinos.cn>

After the per-mnode unlink loop, the return values of the batch
update_ftrace_direct_del()/update_ftrace_direct_mod() calls are only
WARN_ON_ONCE()'d, not checked. bpf_trampoline_multi_attach_free() is
then called unconditionally for every mnode, freeing old_image
whenever the single-point unlink succeeded (old_image != cur_image).

If the batch update fails, ftrace still points to old_image for the
affected IPs, so freeing it is a UAF.

Capture the two return values and, for mnodes whose single-point
unlink succeeded but whose batch update failed, call
bpf_trampoline_multi_attach_rollback() instead of
bpf_trampoline_multi_attach_free(). cur_image == NULL identifies the
unreg path (set by unregister_fentry_multi when total == 0),
cur_image != NULL identifies the modify path (set by
modify_fentry_multi when total > 0), so err_unreg/err_mod can be
matched to the right mnodes. Rollback restores cur_image = old_image,
the image ftrace is still actually calling.

This mirrors the existing error handling in
bpf_trampoline_multi_attach()'s rollback_unlink path.

Fixes: aef4dfa790b2 ("bpf: Add bpf_trampoline_multi_attach/detach functions")
Signed-off-by: Hui Zhu <zhuhui@kylinos.cn>
---
 kernel/bpf/trampoline.c | 42 ++++++++++++++++++++++++++++++++++-------
 1 file changed, 35 insertions(+), 7 deletions(-)

diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index a78fbf726fad..44ef25beb4cc 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -1723,7 +1723,7 @@ int bpf_trampoline_multi_detach(struct bpf_prog *prog, struct bpf_tracing_multi_
 {
 	struct bpf_tracing_multi_data *data = &link->data;
 	struct bpf_tracing_multi_node *mnode;
-	int i;
+	int i, err_unreg = 0, err_mod = 0;
 
 	trampoline_lock_all();
 
@@ -1734,13 +1734,41 @@ int bpf_trampoline_multi_detach(struct bpf_prog *prog, struct bpf_tracing_multi_
 					NULL, &trampoline_multi_ops, data));
 	}
 
-	if (ftrace_hash_count(data->unreg))
-		WARN_ON_ONCE(update_ftrace_direct_del(&direct_ops, data->unreg));
-	if (ftrace_hash_count(data->modify))
-		WARN_ON_ONCE(update_ftrace_direct_mod(&direct_ops, data->modify, true));
+	if (ftrace_hash_count(data->unreg)) {
+		err_unreg = update_ftrace_direct_del(&direct_ops, data->unreg);
+		WARN_ON_ONCE(err_unreg);
+	}
+	if (ftrace_hash_count(data->modify)) {
+		err_mod = update_ftrace_direct_mod(&direct_ops, data->modify, true);
+		WARN_ON_ONCE(err_mod);
+	}
 
-	for_each_mnode(mnode, link)
-		bpf_trampoline_multi_attach_free(mnode->trampoline);
+	for_each_mnode(mnode, link) {
+		struct bpf_trampoline *tr = mnode->trampoline;
+
+		/* If the batch ftrace update failed for this mnode's path,
+		 * ftrace still points to old_image. Use rollback to restore
+		 * cur_image to old_image (putting the new cur_image if any)
+		 * so the trampoline keeps the image ftrace is calling.
+		 *
+		 * This relies on update_ftrace_direct_del/mod being atomic:
+		 * on failure, NO IPs in the hash are modified in ftrace (all
+		 * validation/allocation happens before any ftrace record is
+		 * touched). If this assumption is broken in the future (i.e.,
+		 * partial success becomes possible), this rollback logic would
+		 * need to be revisited.
+		 *
+		 * cur_image == NULL indicates the unreg path (total == 0);
+		 * cur_image != NULL indicates the modify path (total > 0).
+		 */
+		if (tr->multi_attach.old_image &&
+		    tr->multi_attach.old_image != tr->cur_image &&
+		    ((err_unreg && !tr->cur_image) ||
+		     (err_mod && tr->cur_image)))
+			bpf_trampoline_multi_attach_rollback(tr);
+		else
+			bpf_trampoline_multi_attach_free(tr);
+	}
 
 	trampoline_unlock_all();
 
-- 
2.43.0

