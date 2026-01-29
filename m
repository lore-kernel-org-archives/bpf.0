Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 694EA2C21EC;
	Thu, 29 Jan 2026 07:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769672226; cv=none; b=LdkfDl+zehEOFE+fgqsfZOo9RpO+PYYWFHDW1XLHiLYxZ8V9JJISvoEZtzsVmed7HF+/Iv3UB2ktxK4qpETWvAcGQKF0i5CrZBGuBKHma5vpcpLESsRES70RTt4mgFd5ea/QCA/UBjoZs+F1UnqrpTgGNR3hmFhuSUa4bPzQ8Hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769672226; c=relaxed/simple;
	bh=gu/lTP+dYmWX05TFEluF6SvX7ZgxVkbgvaUKcvj0Bso=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=atq89lOumk00jyOq5aGvY9045Dlk3DsROGI4fSd0HAU5I64Ow0xIIqEdrVBk5U0Cu28AmFsi8Eg9PAoKTxjQxwhLUtjo70oRTYsOthI75+/9IwFFfLDyqkLcoOhdaF908kt86lzvY0aTHGWNfVMTdbitj2BEAwObZcVAciR3vFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=mHu8s+AZ; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="mHu8s+AZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=1B
	BWOQbR8sN5Zym+M+qeFuJTkFM0irIhsnywGDoD8JA=; b=mHu8s+AZlShqRp48DB
	3VnfOlPpVpLBUx9cfKiVUeAYvIQ9wmg1+Xed5Af4nLUHY3QPtxItdVT7uBGVkB0f
	VyPGjYYH+/Fpe2h0jiRtoyPma9rKj4nkdfOOR9Z+Jg3Nhcu4Xo7qzBXpUdRGoF6w
	WQVReueVBkgvFxWvcmtJNzgRg=
Received: from localhost.localdomain (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSgvCgDXv_DuDXtpd7O6PA--.50412S2;
	Thu, 29 Jan 2026 15:36:16 +0800 (CST)
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
	jolsa@kernel.org,
	mykyta.yatsenko5@gmail.com
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 bpf-next] bpf: Add the missing types in the logs
Date: Thu, 29 Jan 2026 15:36:14 +0800
Message-Id: <20260129073614.113380-1-yangfeng59949@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PSgvCgDXv_DuDXtpd7O6PA--.50412S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxGFykJryUtrykJFykXryfCrg_yoW5AFWkpr
	s8ArW3ArWSgr4fJw4ftrs3Ar15uw1fXrW8KrWfu34IkFs3X3s8CF4Ykr1aqwn5WF9Yg34a
	yr4rJr92kanrCrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jjuWLUUUUU=
X-CM-SenderInfo: p1dqww5hqjkmqzuzqiywtou0bp/xtbC8hG4MWl7DfEATAAA3I

From: Feng Yang <yangfeng@kylinos.cn>

Add the missing types to avoid such uninformative errors as shown below:
R1 type=ptr_ expected=ptr_

Signed-off-by: Feng Yang <yangfeng@kylinos.cn>
---
Changes in v2:
- Group together those for which only 0 or 1 can be selected. thanks, Mykyta Yatsenko.
- Link to v1: https://lore.kernel.org/all/20260128085842.145057-1-yangfeng59949@163.com/
---
 kernel/bpf/log.c | 53 +++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 48 insertions(+), 5 deletions(-)

diff --git a/kernel/bpf/log.c b/kernel/bpf/log.c
index a0c3b35de2ce..c7d08b1ba96f 100644
--- a/kernel/bpf/log.c
+++ b/kernel/bpf/log.c
@@ -432,6 +432,44 @@ static const char *btf_type_name(const struct btf *btf, u32 id)
 	return btf_name_by_offset(btf, btf_type_by_id(btf, id)->name_off);
 }
 
+static const char *dynptr_reg_type(enum bpf_reg_type type)
+{
+	if (type & DYNPTR_TYPE_LOCAL)
+		return "dynptr_local_";
+	if (type & DYNPTR_TYPE_RINGBUF)
+		return "dynptr_ringbuf_";
+	if (type & DYNPTR_TYPE_SKB)
+		return "dynptr_skb_";
+	if (type & DYNPTR_TYPE_XDP)
+		return "dynptr_xdp_";
+	if (type & DYNPTR_TYPE_SKB_META)
+		return "dynptr_skb_meta_";
+	if (type & DYNPTR_TYPE_FILE)
+		return "dynptr_file_";
+
+	return "";
+}
+
+static const char *trusted_reg_type(enum bpf_reg_type type)
+{
+	if (type & PTR_TRUSTED)
+		return "trusted_";
+	if (type & PTR_UNTRUSTED)
+		return "untrusted_";
+
+	return "";
+}
+
+static const char *rw_reg_type(enum bpf_reg_type type)
+{
+	if (type & MEM_RDONLY)
+		return "rdonly_";
+	if (type & MEM_WRITE)
+		return "write_";
+
+	return "";
+}
+
 /* string representation of 'enum bpf_reg_type'
  *
  * Note that reg_type_str() can not appear more than once in a single verbose()
@@ -439,7 +477,7 @@ static const char *btf_type_name(const struct btf *btf, u32 id)
  */
 const char *reg_type_str(struct bpf_verifier_env *env, enum bpf_reg_type type)
 {
-	char postfix[16] = {0}, prefix[64] = {0};
+	char postfix[16] = {0}, prefix[128] = {0};
 	static const char * const str[] = {
 		[NOT_INIT]		= "?",
 		[SCALAR_VALUE]		= "scalar",
@@ -473,14 +511,19 @@ const char *reg_type_str(struct bpf_verifier_env *env, enum bpf_reg_type type)
 			strscpy(postfix, "_or_null");
 	}
 
-	snprintf(prefix, sizeof(prefix), "%s%s%s%s%s%s%s",
-		 type & MEM_RDONLY ? "rdonly_" : "",
+	snprintf(prefix, sizeof(prefix), "%s%s%s%s%s%s%s%s%s%s%s%s",
+		 rw_reg_type(type),
+		 trusted_reg_type(type),
+		 dynptr_reg_type(type),
 		 type & MEM_RINGBUF ? "ringbuf_" : "",
 		 type & MEM_USER ? "user_" : "",
 		 type & MEM_PERCPU ? "percpu_" : "",
 		 type & MEM_RCU ? "rcu_" : "",
-		 type & PTR_UNTRUSTED ? "untrusted_" : "",
-		 type & PTR_TRUSTED ? "trusted_" : ""
+		 type & MEM_UNINIT ? "uninit_" : "",
+		 type & MEM_FIXED_SIZE ? "fixed_size_" : "",
+		 type & MEM_ALLOC ? "alloc_" : "",
+		 type & NON_OWN_REF ? "non_own_ref_" : "",
+		 type & MEM_ALIGNED ? "aligned_" : ""
 	);
 
 	snprintf(env->tmp_str_buf, TMP_STR_BUF_LEN, "%s%s%s",
-- 
2.43.0

