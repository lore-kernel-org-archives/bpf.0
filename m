Received: from mail-wm2-f10.google.com (mail-wm2-f10.google.com [74.125.225.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB3952D0C62
	for <bpf@vger.kernel.org>; Sat,  5 Sep 2026 09:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788599278; cv=none; b=nPkIxkrps3um0sfSyFtUXZdB8KDNsVFKFPHFmNmdY30CxRK+LFfvq166LZbbxeQBzHozmoNbmA2fys+j5OZv9Jyo9CSPDoJlkYIc0gSC6brqlsUs2xB7hpMfthNkHHdXrJWA375uZidM9AQJB0AJGZLgdLwaM1OUZzlwzntRxPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788599278; c=relaxed/simple;
	bh=NRPHqiVYduKfr4ZzTU/JYnD5Fh8z92fBeveERFWj6FQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bUwwVHQi7utDEx7ccY+XdEHJTDpGQGMZpj4icigeIjfLfS1VEm6V1IIYOBNqYwFip50zKOATOm9LUtlW91beVBMLYA8qvPSKqIhhONYoyQPdRjPw53tydYRD0+rKqv1qOMe34WFmTw6NKTkzn8dda+4tHSfLyw/CWpWMsJxMsH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hf6gPc5B; arc=none smtp.client-ip=74.125.225.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hf6gPc5B"
Received: by mail-wm2-f10.google.com with SMTP id 5b1f17b1804b1-49b46dc430fso3904685e9.0
        for <bpf@vger.kernel.org>; Sat, 05 Sep 2026 02:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788599275; x=1789204075; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=R6HveiuFRXMMmdn7NcaYJzmp7ypP/O7mRN38NQ6waI0=;
        b=Hf6gPc5BO6gxCMaRt/KWDx8bBFgB5Wm8Aciahq0o3pQiE9b9Aa0/NdBGO5O2/8AqyX
         3mP1indsmQFcHUuZqTNvFEi73izuEqXkkEVczKGGWfd6ZAfZzwZ6K+9i1Hgm7gCUF7n5
         3Px1Xgy+6Vlzy6/OX2H2g00yQapFwxW/Z+kteoiSfhFMr8Lz4rn2+0q3NHkIx2+4nxFI
         kQ8tnxdbPDdtwcn0QHeuxkGm6/odw/Mq4p+DT97iflld7aTZMQyiUZO6+FvNgzhrPGEw
         oiKRcLhv8wezBO8tn1Q9K0yrhpwpH6nl7P5nNAfLZ7+3IyGtYdqLEOn1OALz8JYNkHVD
         mBSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788599275; x=1789204075;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=R6HveiuFRXMMmdn7NcaYJzmp7ypP/O7mRN38NQ6waI0=;
        b=Zmtr1KFg4Zi23U+nsVJ6zrTf9GmzvyH2T5hS4fubdxk3sF4glUPZB/hYewPEUHeZFw
         cAyRmCmdBni8RJD9zk/b71nHBrIdRzqp17XivX9IaIpy/MlLUZ+OKCoT3etQ89FrEdSg
         gGddcOyLiS6kNCE0Nfy2E9qZv+h2YSK4cu7Csdtc1Qx4274GgkDw1UC9J5VfIPErjANI
         Qwd+OgLc4pZBgx/6mhQm6VxSyo7kystO53Vq664vjvBcJxEPzLiGHT62kD7xqvt2slOo
         0nwNXajLJh9FjYRjKqw7Oi9GGJIBH2ZK1Ndv9M6BwYPFYYpcF0ulHaIGG1JZPcjP79Mi
         izcA==
X-Gm-Message-State: AFuF++ngIUWSPLLhm12WF7U4QjevfNm0rZbd8BmZHGMtXICwvEUzUUPC
	y45bOVJ0k/64enbEfIkawj/qv9dSiSqk5kqUrU7U1JuCxTyMdjyrhYX2MUuFxP7r
X-Gm-Gg: AYBFou3W2gfIVzpjo7xWHqmp6q39w58JCc+0A3Ptyz5rgbMgcI8LYZ9R7zw4mI6rxtD
	mVQL9uw24kzhLscDtfok51HKDVcrop+XACJH9wLQqP5fZkwF87s2H3YhRpE5znVwTe82T5ejEeK
	IvlNxmhree7G0wteTSq/KxRGEByOPYy8J6rpoCS3E1/FUx80I/LXC5chY7a9nGlM9b6t48f8JJH
	l2/zSCFTbjnGrrtOeGXSWmoQcKzPIeOrxFyNzJErfBS6DLqqrggjkx/LOgtirX0SCDqWoe/lRKs
	NrpldGkcnYjSdkBQiIhb/MErskkRAPBUCB7kJzM8bn4CYqLy/pQybOpxdkizyEr1C5u5kIPvt8G
	6iMf2ygj0QbmUA9St+tSOQjqKXS2bRWdoTK5whmTCMD17bmz8XBBIGfwj+EUZ8MTQAmKQqKbIrj
	iHGLsUddWKa7OF3FW+e2QLQVcBnpcZhqMIhhDrJxnSn9jEZtZCU5NsCYrVM+uVWXwHjERjPFqQ2
	v8cA30yQpbLeWKFjI3lXrWHotZM/goTPq7ZwB1Pak061+jKOKz2ZCIea/JhcISiVxuArUOiOQEQ
	u9pOoDm2A+3+5WAesm+hkQ+H+wM=
X-Received: by 2002:a05:600c:3f08:b0:49c:fa20:cc04 with SMTP id 5b1f17b1804b1-49cfa20cd10mr87707295e9.27.1788599274882;
        Sat, 05 Sep 2026 02:07:54 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cf770fcf5sm131414695e9.6.2026.09.05.02.07.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2026 02:07:54 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Nicholas Carlini <npc@anthropic.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 2/3] bpf: Bound local kptr ownership depth
Date: Sat,  5 Sep 2026 11:07:47 +0200
Message-ID: <20260905090750.4064411-3-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260905090750.4064411-1-memxor@gmail.com>
References: <20260905090750.4064411-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3002; i=memxor@gmail.com; h=from:subject; bh=NRPHqiVYduKfr4ZzTU/JYnD5Fh8z92fBeveERFWj6FQ=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWv2rfebWRyWv/oUJWlieyRdgrH2xON2lSmMhy4zHsou3 /RVYKVrRykLgxgXg6yYIkvJ/31MxicqfwfaLuOGmcPKBDKEgYtTACayKJmR4ZXhGTuHKUwt0nsr 9fm3mkX2lB178ftJq82bly8W7E/OUGP4p3NxghWLw5msa9edk/dLRwQ1PT7Ov6PXsCfibvHGG7X G3AA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Program BTF records can own other program-allocated objects through local
referenced kptrs. Releasing such an object follows the kptr through
bpf_obj_free_fields() and __bpf_obj_drop_impl().

The ownership graph walk only follows list and rbtree roots because
referenced kptrs originally supported kernel types with registered
destructors. Support for exchanging program-allocated objects into local
kptrs invalidated that assumption. A self-referential local kptr lets a
CAP_BPF user build an arbitrarily deep object chain, and dropping its head
can exhaust the kernel stack and panic the kernel. A sufficiently long
acyclic chain has the same problem.

Extend the bounded ownership walk to program-local referenced kptrs. A
pointee without special fields is absent from the struct metadata table and
adds only a final non-recursing drop.

Also include local percpu kptrs even though bpf_percpu_obj_new() currently
rejects types with special-field metadata. Rejecting unsafe ownership graphs
now keeps the depth invariant intact if that restriction is relaxed later.
Kernel-BTF kptrs remain outside the walk because they do not recurse through
program BTF records.

Fixes: b0966c724584 ("bpf: Support bpf_kptr_xchg into local kptr")
Reported-by: Nicholas Carlini <npc@anthropic.com>
Suggested-by: Nicholas Carlini <npc@anthropic.com>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/btf.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 2a458499a236..3c508ebb2438 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -4313,20 +4313,28 @@ static int btf_owned_type_idx(const struct btf *btf, struct btf_struct_metas *ta
 	struct btf_struct_meta *meta;
 	u32 btf_id;
 
-	if (!(field->type & BPF_GRAPH_ROOT))
+	if (field->type & BPF_GRAPH_ROOT) {
+		btf_id = field->graph_root.value_btf_id;
+	} else if (field->type == BPF_KPTR_REF || field->type == BPF_KPTR_PERCPU) {
+		if (btf_is_kernel(field->kptr.btf))
+			return -ENOENT;
+		btf_id = field->kptr.btf_id;
+	} else {
 		return -ENOENT;
-	btf_id = field->graph_root.value_btf_id;
+	}
+
 	meta = btf_find_struct_meta(btf, btf_id);
 	if (!meta)
-		return -EFAULT;
+		return field->type & BPF_GRAPH_ROOT ? -EFAULT : -ENOENT;
 	return meta - tab->types;
 }
 
 /*
- * Each graph ownership edge adds kernel frames through
- * bpf_obj_free_fields() and __bpf_obj_drop_impl(). Keep the bound
- * deliberately small because object destruction can itself run below a BPF
- * call chain.
+ * Each ownership edge adds kernel frames through bpf_obj_free_fields() and
+ * __bpf_obj_drop_impl(). Keep the bound deliberately small because object
+ * destruction can itself run below a BPF call chain. A final pointee without
+ * special fields is not present in the struct metadata table and adds only a
+ * non-recursing drop.
  */
 #define BTF_MAX_OWNERSHIP_DEPTH 8
 
-- 
2.53.0

