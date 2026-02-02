Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9314E21773F
	for <bpf@vger.kernel.org>; Mon,  2 Feb 2026 03:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770001954; cv=none; b=sthCbGMfcxywQUBBxGazaxq3K3i8NbnDDb5JH9zx/PB8Omk2qqkzRwZV0UVH7BEdQvzJmfw/ufYiA2DUedcizPQ3yycEFt8S66Et8nJy4PRxD+ZtgBG0WR+ql+N5qf7pWEgcwe9qP93FUBDXIEnuw4QJ+U2j+CLWywMGkeMoAXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770001954; c=relaxed/simple;
	bh=uUL3+hIqzzN4FF56+RZlxBho1NEz93n03uZmaBVx188=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kMbEXnzRX1COOBCJZC2CxqrxH1junNqq1UD4QwSjZZTyu0TVNo7u2C8d9jBdmJrKyyWYus1aWiuGdNxFsId8grNNU+cOnKkIo1QZLbCqIf5ovwRhyyKHfTaPXaH8cB13iJoXN9GvqhG9PVYxlcwaVc16wrjSLQr17UCRe5elsXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SHwwIgNn; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SHwwIgNn"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2a0c20ee83dso36118775ad.2
        for <bpf@vger.kernel.org>; Sun, 01 Feb 2026 19:12:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770001953; x=1770606753; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=32rXQW4BVZZQ4FbVA0RQJRaOaveBTs70Lc0Lq+KuBq8=;
        b=SHwwIgNnn78XcIg6m3UTC8P9YwRIQzpXnk25sUtVYgIVjxdLrWQFXpDFq0rMxmZ4Ab
         cMEBwKNDiDvY0/DnrhnOw5defh+EFgBdJaHwNlZEg2AX+x2Sx+KvoFfghltdb4itWHwX
         KiTqSLa9GDtVAPaAva2Wt9afutoi9NlHICjDoSq/mw6bLleiwWRJ3mhEA4yxI0iywYGl
         qawm660wiD4HPR7iR/0nJnzFTfIfxdmgbzf/lajN3WR54Dt5mWXIkbvM+mbPq4OH5AfU
         0MkeIfOZSjSnkzoC6I4ew9Qs3GvGY0B5YLI6r9pU8ZNIHwajhECb9hG6nCfLLy1+jJ9r
         twGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770001953; x=1770606753;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=32rXQW4BVZZQ4FbVA0RQJRaOaveBTs70Lc0Lq+KuBq8=;
        b=CaSs4wdoXAfJzD6psCQqA3V//kctfi7RT6GSpTH7fwcG3BuOy3PZG4NQ6Pc//bJ1ka
         NMQcLtfNfSLDj2jt4xyy8/2lkiilpODOCAiM1i6PkUeCpmpNhIddOlTGJID0gGhZpyDp
         q1nMdsoh6ke16fqMOG0KIp6D0I7HwGILte6ieLK2BHBXqqQKBusbEKc2lAYI0hG0WZyE
         BoBgFCYTZAhD6B0Ec/p739U1hgUNnZ0QUD9k887BidkdvsLjiP57EWOANPIw/lccI4K+
         lwPk7Icbp7LwNBaR2aLM3Z8jd//I8uxIV0jyKhjPoaUXOTdVGb80iL4Yv0j6MLYMj9GN
         DMVQ==
X-Forwarded-Encrypted: i=1; AJvYcCUVfU5t16o8XKMjgWJUtuThW1hyravDqKfXDu2ZXTqtEDQrQClTlSYCinsx24UgJkCnlQI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywp9VLA+zIPLR8j7hqo5Aa7h9f0pfMrWmyqPAqkUau9szrbM8bH
	T51o6xcgj6kKW/M11k5RQV0bs0YYLkpZUc8U5m+lk018ApRnXdjY6xK7
X-Gm-Gg: AZuq6aJYmWN2GYHLXw36KUVgPhBfBXz+3/SaAk94+Hq52NpecYGm61MsmzBL0HcaJO/
	dCsW0Ck0YqJXppFhp2FLjXiTUKWh0dBNCr8dniNhUFmszB3yRyGOAIsLtIl2eMeWaEs6Io6wdbF
	5GCqd/56snxvmkgJOP1kGTITGg4ouW8fujGToQ7tjWCqm0YClUg8CLZqFBptT6BbJQKdsbpRKPB
	xb4BY9uBldHGXFfB9WpwGPwzHIBLBOykVzAqGHf55oFtuz2stPbpiQaREM3m/NQvqxy3+7pjAHi
	t2K+/OGrOdxi3Glwab6uAGAiUVsbbmLEbOxFFb/XqUbWbuIKh3GrZ6dhAzC69F9MmyqQzYo3GsB
	9Jxvih+EentaqI+lHUqWwYQfCqbyXtPlAxaRXaRxWyJE9FYzHakyz1eaD7dhHGvxTJgutQwE4X+
	M2f6Tn/d64gMCnFu/G3aoM0vT6uRbwZvd2R/MyM2FoMw==
X-Received: by 2002:a17:903:24e:b0:2a0:7fa0:7b5c with SMTP id d9443c01a7336-2a8d9a55246mr98411885ad.55.1770001952899;
        Sun, 01 Feb 2026 19:12:32 -0800 (PST)
Received: from localhost.localdomain ([116.128.244.171])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a88b6e4110sm124318605ad.84.2026.02.01.19.12.26
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 01 Feb 2026 19:12:32 -0800 (PST)
From: chengkaitao <pilgrimtao@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	shuah@kernel.org,
	yangfeng@kylinos.cn,
	alexei.starovoitov@gmail.com
Cc: linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Chengkaitao <chengkaitao@kylinos.cn>
Subject: [PATCH v3 1/3] bpf/verifier: allow calling bpf_kptr_xchg while holding a lock
Date: Mon,  2 Feb 2026 11:12:13 +0800
Message-ID: <20260202031214.69958-2-pilgrimtao@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260202031214.69958-1-pilgrimtao@gmail.com>
References: <20260202031214.69958-1-pilgrimtao@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chengkaitao <chengkaitao@kylinos.cn>

For the following scenario:
struct tree_node {
    struct bpf_rb_node node;
    struct request __kptr *req;
    u64 key;
};
struct bpf_rb_root tree_root __contains(tree_node, node);
struct bpf_spin_lock tree_lock;

If we need to traverse all nodes in the rbtree, retrieve the __kptr
pointer from each node, and read kernel data from the referenced
object, using bpf_kptr_xchg appears unavoidable.

This patch skips the BPF verifier checks for bpf_kptr_xchg when
called while holding a lock.

Signed-off-by: Chengkaitao <chengkaitao@kylinos.cn>
---
 kernel/bpf/verifier.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 3135643d5695..05a6a6606b6c 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -20387,7 +20387,8 @@ static int do_check_insn(struct bpf_verifier_env *env, bool *do_print_state)
 
 			if (env->cur_state->active_locks) {
 				if ((insn->src_reg == BPF_REG_0 &&
-				     insn->imm != BPF_FUNC_spin_unlock) ||
+				     insn->imm != BPF_FUNC_spin_unlock &&
+				     insn->imm != BPF_FUNC_kptr_xchg) ||
 				    (insn->src_reg == BPF_PSEUDO_KFUNC_CALL &&
 				     (insn->off != 0 || !kfunc_spin_allowed(insn->imm)))) {
 					verbose(env,
-- 
2.50.1 (Apple Git-155)

