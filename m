Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 317DC33C1A3;
	Wed, 28 Jan 2026 09:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769590937; cv=none; b=k9UoHDa+OAOAoxidPqC/GZg0BOf1APaCyPMtkwU9KjonBrEXxbC9Mi6OJG5DPb4OzIsCaH77kjIGLA+JnOWI7ydM8Xo+upv+bdwAZXZY2rLv1/+/T/4z5q91zStMTfDyeVWpzFzvvSYCfn603FYWbuUsFp/vgqBT/aADwFxsZ+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769590937; c=relaxed/simple;
	bh=j46GHytLjoWsbfyq64Hgc8EURXjiyuGy+aDopIfpkbU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XV3fY8wg5Hdtv/KDPnuozh5ZFUnpiDDaVWtCgE04wSW5Rv1itx1BsINxK7osJxqdSdDot9DaXhycn8wJ4O9GmXLEEJdxOXUAtVjRdUykwsocvK0nKu5wXvockWrV+wkxf/Fl869aGrZnQYEkkBFBmimDhP9c8j/7dy33aY0gjKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=WJaG/9mB; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="WJaG/9mB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=ZJ
	NKw7okhxvN7RcLqFUME6R6A7z9tx1aLf2/7RUnGQE=; b=WJaG/9mBCSnbeVAjc2
	kMT4AehEPCpcGyo2TEXttAGgplbxh7aYcKqU9Que89geBdYc1Rt0ggVZZzZq3Ufn
	N/6mhzZ3HUdpV/yIV8DbNhuZ2wtZ8S38EJOHrLSi4ZCk0BrKytyziYQL3os2MI85
	ZBtotLpvSdyUU4e8CvIePw1lc=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wBH_aXDz3lpf1QxIA--.1077S2;
	Wed, 28 Jan 2026 16:58:45 +0800 (CST)
From: Feng Yang <yangfeng59949@163.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next] bpf: Add the missing types in the logs
Date: Wed, 28 Jan 2026 16:58:42 +0800
Message-Id: <20260128085842.145057-1-yangfeng59949@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBH_aXDz3lpf1QxIA--.1077S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7AFyftrW8AF4UtFWxZr1fJFb_yoW8WF48pa
	1Fyw17X39agr1xJw45J3yxArnxZw1rWr4UGrW8urW8tFs5Ca4qyryFyryaqwn5tw4vqFy3
	Aw4kKr9Iv3WDGrUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jjuWLUUUUU=
X-CM-SenderInfo: p1dqww5hqjkmqzuzqiywtou0bp/xtbCzwXdVml5z8U3uQAA3V

From: Feng Yang <yangfeng@kylinos.cn>

Add the missing types to avoid such uninformative errors as shown below:
R1 type=ptr_ expected=ptr_

Signed-off-by: Feng Yang <yangfeng@kylinos.cn>
---
 kernel/bpf/log.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/log.c b/kernel/bpf/log.c
index a0c3b35de2ce..6fee3d8b3703 100644
--- a/kernel/bpf/log.c
+++ b/kernel/bpf/log.c
@@ -473,14 +473,26 @@ const char *reg_type_str(struct bpf_verifier_env *env, enum bpf_reg_type type)
 			strscpy(postfix, "_or_null");
 	}
 
-	snprintf(prefix, sizeof(prefix), "%s%s%s%s%s%s%s",
+	snprintf(prefix, sizeof(prefix), "%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s",
 		 type & MEM_RDONLY ? "rdonly_" : "",
 		 type & MEM_RINGBUF ? "ringbuf_" : "",
 		 type & MEM_USER ? "user_" : "",
 		 type & MEM_PERCPU ? "percpu_" : "",
 		 type & MEM_RCU ? "rcu_" : "",
 		 type & PTR_UNTRUSTED ? "untrusted_" : "",
-		 type & PTR_TRUSTED ? "trusted_" : ""
+		 type & PTR_TRUSTED ? "trusted_" : "",
+		 type & MEM_UNINIT ? "uninit_" : "",
+		 type & DYNPTR_TYPE_LOCAL ? "dynptr_local_" : "",
+		 type & DYNPTR_TYPE_RINGBUF ? "dynptr_ringbuf_" : "",
+		 type & MEM_FIXED_SIZE ? "fixed_size_" : "",
+		 type & MEM_ALLOC ? "alloc_" : "",
+		 type & NON_OWN_REF ? "non_own_ref_" : "",
+		 type & DYNPTR_TYPE_SKB ? "dynptr_skb_" : "",
+		 type & DYNPTR_TYPE_XDP ? "dynptr_xdp_" : "",
+		 type & MEM_ALIGNED ? "aligned_" : "",
+		 type & MEM_WRITE ? "write_" : "",
+		 type & DYNPTR_TYPE_SKB_META ? "dynptr_skb_meta_" : "",
+		 type & DYNPTR_TYPE_FILE ? "dynptr_file_" : ""
 	);
 
 	snprintf(env->tmp_str_buf, TMP_STR_BUF_LEN, "%s%s%s",
-- 
2.43.0

