Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 087203F9F35;
	Wed, 27 May 2026 11:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779882014; cv=none; b=nQBOwsXmfcovrIsGD5Bx0jkEubON/LTWy4c7QB8S/jU2sAkXZ9H/pJ53hOIcQ9xV2uFaYS2ClgwUQ0GgbVc7Hxsnhc0vHSP06/2TawMwq/0lrwFs2COniikFRPxmH5qZgQYvTPeDWMbhJB5AKskIgU0gkOQoH919fMbf7eddkhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779882014; c=relaxed/simple;
	bh=ywpshhhTIWXl8kCn9cpVuVQ+ZwwZrpxjyq0Oq+kYG54=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dD/DRA8vuJ9aCdYRdnVopDQrqvvvvz1IU92/c0UO9ZZjt0H4paYRyhUiTkXQ4CkpkaG5gB+4JnOBjupp1er7WRmKPiF1t3AfqSESbARcBgeWWM8FU9HBswZs62bDyEINBLPg+8IQnFDz4CjoDF/iG0kH8jpt6fLSl8oEvKq/7yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VuMJ/aet; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VuMJ/aet"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 543871F000E9;
	Wed, 27 May 2026 11:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779882011;
	bh=g9ZqadcY/NjSm1TT/nNyr9mvKD6IcZNGDjboDTYbj84=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VuMJ/aet1pDWq0hVYPQsZ+2OjJ5PWJEqZHO3ef/kpKl7vMvTEN9/9rkQcnMI88N2N
	 27ssvgatVYooTpElgX/IPqrbods/tA0QxRDjDbNIyUY8qHzIFrgUt2zvhcVL5P4+JT
	 v2b0O9w9igb+wVxofLQXOqrvZyQRVbX1ZkSrshhYGiXd9Kpm+x5f6spq/jrfUT0NTo
	 vtbK9A93coO/Q8C6LiseMy7kDDgefGzwwKhPsswyboN4cp3eIBS87zhBmfOg/bKyXI
	 LSE9M1RA2QjnPrwEWQeVE1z5aCfdXuk07qo5kuTbsw3jp2mXLu51u12WbM9N3fsI9x
	 mE+jKGLtXevOA==
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
Subject: [PATCHv6 bpf-next 01/29] ftrace: Add ftrace_hash_count function
Date: Wed, 27 May 2026 13:39:23 +0200
Message-ID: <20260527113951.46265-2-jolsa@kernel.org>
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

Adding external ftrace_hash_count function so we could get hash
count outside of ftrace object.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 include/linux/ftrace.h | 2 ++
 kernel/trace/ftrace.c  | 7 ++++++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index 28b30c6f1031..282da661f131 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -551,6 +551,8 @@ int update_ftrace_direct_mod(struct ftrace_ops *ops, struct ftrace_hash *hash, b
 
 void ftrace_stub_direct_tramp(void);
 
+unsigned long ftrace_hash_count(struct ftrace_hash *hash);
+
 #else
 struct ftrace_ops;
 static inline unsigned long ftrace_find_rec_direct(unsigned long ip)
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index b2611de3f594..57ab01fd00bd 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -6288,11 +6288,16 @@ int modify_ftrace_direct(struct ftrace_ops *ops, unsigned long addr)
 }
 EXPORT_SYMBOL_GPL(modify_ftrace_direct);
 
-static unsigned long hash_count(struct ftrace_hash *hash)
+static inline unsigned long hash_count(struct ftrace_hash *hash)
 {
 	return hash ? hash->count : 0;
 }
 
+unsigned long ftrace_hash_count(struct ftrace_hash *hash)
+{
+	return hash_count(hash);
+}
+
 /**
  * hash_add - adds two struct ftrace_hash and returns the result
  * @a: struct ftrace_hash object
-- 
2.54.0

