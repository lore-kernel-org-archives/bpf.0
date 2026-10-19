Received: from mail-oo2-f5.google.com (mail-oo2-f5.google.com [74.125.231.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50D04409623
	for <bpf@vger.kernel.org>; Mon, 19 Oct 2026 13:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792416143; cv=none; b=ZTTknhTH8OJVz7AKR87/QzSGoFNMsrqQkIxuxeZBAKAXunng18DFJNWSO4+1hOnLEHe1iQNQLBVD9Igyb7BH6CQTqoij/a1tnX1BjkRM/vg7kOX1i0i8tyffSjZPtgKWKwl3P0FKsZCoco8lcW96epJMueB4NioFuqxs3q7lZn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792416143; c=relaxed/simple;
	bh=An2lPq5GJoEtpPlx78EEh85Czi/YtMsoji95nHL5xy4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EkN8scIhJHwT5zhhz+gmCTvAFSrFW7xOofSILbhFXPu6YcWRbpMDiAjaIpPykxRmGZ1C0PqtZkZTnJBvqRpuQhiPqKnURFbnn5Fa+UEwcXzSsvRAWkElY7Z0j+N9OXLOl3RidssKBiaDEqidUTZ9R983BRNq9aVCZYaCLeNbfZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yf3SLM0V; arc=none smtp.client-ip=74.125.231.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yf3SLM0V"
Received: by mail-oo2-f5.google.com with SMTP id 46e09a7af769-84585465aabso468465a34.1
        for <bpf@vger.kernel.org>; Mon, 19 Oct 2026 06:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792416141; x=1793020941; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=t5zZfPljFbBSjJQeQz+Dmo5DUnM65THe9CEIaweqKdo=;
        b=Yf3SLM0VbNKFxIVEhvGeSbYpj/rTvB5JPsXRxXt36iFRxOWWslQpYfvMyDJua5sdhj
         VahoJoGm1GfqC4CH/27vKF+qoMARGyv3iUeKpBNBt6EbaycSAyp5UlBait9/k0Z5Ph+R
         bL8/MhJ+MfMITIxFNgDoeQxT02IlJPxZ76W2au4CkjlGCHUyLiLqByDoWg/CpBVwGoAJ
         etK23YjDvbG0sUl0fo7aRxQrCOdO8fXTt+cOwK6OptJieiqNesj4C9QLbW537SUTxNvT
         DUDonDLmPahNSwn9kxc4TzojnhXiM76/9tz4aXMAQCH+c9ZUiqM60TsV4saDj0pWl8ag
         9J+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792416141; x=1793020941;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=t5zZfPljFbBSjJQeQz+Dmo5DUnM65THe9CEIaweqKdo=;
        b=IbtaWA88shcXa+WpygqvFcNJDUHmiP2lAnGrzZKBosDyzu5KqyX855t6CgN2VqRbSg
         IJ5GkpJgb+J9HgZCY+bfTnhcPEZZJybA7jlwWC/5xa1fO1hwru7EmF5Ko5ZD7LvtG1oN
         ofqZ1atWjY7URVDKzJjKK1lACLw9mT3cNwhRoi6se8M8lOgWOkAKx+RC/Pz/Xohzs1eZ
         eJq1ZsmsA9ewXXHcGT2gI1H1zVh4pNX4QaA8Fp0MBYYA9hwunj6Ol3n3RAFt88O+HPJs
         ecwKjjlara6kxHh1LR9eYx3cY7uVwldyb+U4/IKD1al5PYcO2NWIh2vNjsWnVGQsT3EK
         KpqA==
X-Gm-Message-State: AFq9FYJ7D0w13jPzmpZZ/Rc3uz2BZEnpHL2JjY1JY4qKxuNQQuGYC2CC
	0GHJde4JwFxdkbQ9z0MeBGFgl3Ysf036LM2QJcIoz2oti72x9SPY05LTRTqEhOq9h04=
X-Gm-Gg: AYBFou2GBgBQmlGxI/jtlbsySkMjxkhnA0tDZN1SUpN12hRsgUUlk/kjNDddwOMpiCF
	0IKboAY5MYUmQsm3mif4t0NTAA95pZl2mMoWnTWuZW3DNQ/Y+J0dRvec8GjjllPaqZ5Iza3gY6m
	PdZBOMlBNQXHGKCfXy9E70ZBUQbkiQoDaWSvVAGniFeyQqKcnfkPD6CQ71ZyjkJU6cKw71QAQz3
	SBoMg5u9mNClSRP8aRbxxRxeSofrcijP7bCCD4AwVWUm6u3chmf3MwowKHi4bRHgadc7fj3e74I
	ipAqoy5UY6h0Nuv/V9ohrsuZjmoJ5EpjhpnXX8Y/jeO9QB44oPCVykNEdOvXFuafs5keWtzz3J7
	3JGA9+IkLAZbcf62PfUxK2bDcFpnyrjvN3+OKSju4qrwvhuKDS8qjYguszRIjb5N18AXbLEUcG0
	kFbC5IId9KQYRZxFCcxzgY5pD/nov4p26Bw5dIQyG8h98CG94Hb60myb9pptQ/MIjP1kYD0ILhw
	SlAHJvgPL4Q7rIngSXlId/8PbETJvlHGu15B46GZwSud9kgGz9g40Y3HuDXgj6OMhR8BbW1NDRP
	HJv3
X-Received: by 2002:a05:6820:55d0:10b0:6cd:3fdc:266c with SMTP id 006d021491bc7-7035709e9bbmr2464247eaf.45.1792416140623;
        Mon, 19 Oct 2026 06:22:20 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:55::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-8487c3cdacdsm3662069a34.22.2026.10.19.06.22.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 06:22:19 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Tejun Heo <tj@kernel.org>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v5 05/16] bpf: Add the __arena and __nullable BTF type tags
Date: Mon, 19 Oct 2026 15:21:47 +0200
Message-ID: <20261019132203.3034698-6-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261019132203.3034698-1-memxor@gmail.com>
References: <20261019132203.3034698-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2273; h=from:subject; bh=An2lPq5GJoEtpPlx78EEh85Czi/YtMsoji95nHL5xy4=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIeuaxJEtnct2K9aK+x173siuXbvdQJ8vy/z0H7vnXfe+Zt5+ /f9rRykLgxgXg6yYIkvJ/31MxicqfwfaLuOGmcPKBDKEgYtTACay8CnDXzn9eScXfN52cU/3nWlXvo pKKFoe3qjHk9cv3NT9oZjp7lJGhs+bPs4uO1q1MGuhfNP1FXu8olW+LYn+wrbx8L+C+Cf/DdkA
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Kernel structures increasingly want to publish pointers into a BPF arena
to the BPF programs they are shared with, and some pointer members that
reach programs as trusted are legitimately NULL at times. Neither can be
expressed today: a pointer member reaches the program as an ordinary
kernel pointer, and sched_ext resorts to a plain u64 holding a
pre-translated arena address that programs cast before use.

Define __arena and __nullable as BTF type tags, the way __user, __rcu
and __percpu already are, so that tagged members survive into vmlinux
and module BTF and the verifier can act on them. To kernel code and to
sparse the qualifiers are empty: the pointers are ordinary kernel
pointers. The verifier side follows in the next patches.

The tags live in a header of their own, bpf_compiler_types.h, rather
than in compiler_types.h. They mean something to the BPF verifier only,
and only the few structures shared with BPF programs that want to
publish such a pointer carry them, so the code that declares such a
structure includes the header and the rest of the kernel never sees the
qualifiers.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/bpf_compiler_types.h | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)
 create mode 100644 include/linux/bpf_compiler_types.h

diff --git a/include/linux/bpf_compiler_types.h b/include/linux/bpf_compiler_types.h
new file mode 100644
index 000000000000..5c9e71acfdac
--- /dev/null
+++ b/include/linux/bpf_compiler_types.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __LINUX_BPF_COMPILER_TYPES_H
+#define __LINUX_BPF_COMPILER_TYPES_H
+
+#include <linux/compiler_types.h>
+
+/*
+ * Qualifiers for the BPF verifier rather than address spaces: __arena marks a
+ * pointer into a BPF arena, __nullable a pointer that may be NULL. They reach
+ * BPF programs as BTF type tags on the members of kernel structs shared with
+ * them; to kernel code and to sparse the pointers are ordinary.
+ */
+#ifdef __CHECKER__
+# define __arena
+# define __nullable
+#else
+# define __arena	BTF_TYPE_TAG(arena)
+# define __nullable	BTF_TYPE_TAG(nullable)
+#endif
+
+#endif /* __LINUX_BPF_COMPILER_TYPES_H */
-- 
2.53.0-Meta

