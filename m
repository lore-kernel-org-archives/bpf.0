Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A760A265CD9;
	Sun, 10 May 2026 03:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778382183; cv=none; b=ro+nE1+jvuWHPiN0RbQ6oS0M/5P3W6KAyBlGPDsDPxDfGcHD7brZN/2e7h39PeF0RONJRhSvQTrdjcQdDt1+k+T+VJmqWGzXBBCGOFs2P1vptFZaJgxJklmiZ70q5i/DrtCjiqLlyary1gb03SyXxoMqVzxADmzm+2XAhAK9ZCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778382183; c=relaxed/simple;
	bh=fCWAZtPLwXDYJcqCoBIUgakH314RwHBbtXEOR9b00i4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uXnzmJrJxAG4FXwjZMDjyEMuuCe1H/xTyz5pKxsNCJohfyZhoIigRg1XfgxF4gMRBQRwSRg+sj1jzGbOkEpYvAajQxLYrfobPIJBYMaaE1FkODJkWin0VfFz1VP7ew7Br6qp+gSEvLcnXlRAlEFGmULaxLKw261aI3UFKDoJqGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=TNJUyEUH; arc=none smtp.client-ip=220.197.31.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="TNJUyEUH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=+8
	6Dzy10uVzSvNyA0ux8agEg4kL6VPjyGsJA7Z8CANQ=; b=TNJUyEUH53QLIweB7R
	etfpSyp7v9INELst9vM4GghfEotSEr6Bh6zoxv8vCxS07Eywdiq2zAZzw7zp3jiZ
	q9j7X1HRY/vYUqnHsQN96xl9FFOqcklVf9w8SrklCbo3+W3nvxoQ3LBPPKageUQx
	n0WlpmA4GA4rCWDAfmTDbYKsY=
Received: from song-MS-7E28.. (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wD3vzcc9f9pqXvKBA--.54835S2;
	Sun, 10 May 2026 11:01:49 +0800 (CST)
From: Song Chen <chensong_2000@126.com>
To: andrii@kernel.org,
	eddyz87@gmail.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	alexei.starovoitov@gmail.com
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Song Chen <chensong_2000@126.com>
Subject: [PATCH V2 2/2] kernel/bpf/verifier: Support module kfunc resolution via instruction offset
Date: Sun, 10 May 2026 11:01:47 +0800
Message-ID: <20260510030147.27900-1-chensong_2000@126.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3vzcc9f9pqXvKBA--.54835S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7AFyDuFyrXF43uF13WF17KFg_yoW8uF4fpF
	48GFZI9F40vw43uanrAF40vFy7Ga1ktw47Kas8C3yakryaqr1DZF40kryYv3s0yryjyw1I
	yFWIvay2qa4jvFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zEGYLJUUUUU=
X-CM-SenderInfo: xfkh02prqjsjqqqqqiyswou0bp/xtbBpR3eXmn-9R1ObAAA3k

Use the instruction's 'off' field to indicate the source of a kfunc.
When libbpf resolves a kfunc, it sets insn->off to 0 for vmlinux
kfuncs or a non-zero module ID for module kfuncs.

The verifier now checks insn->off to determine where to look up the
kfunc address: off == 0 searches in vmlinux, while off > 0 searches
in the corresponding module BTF. This enables proper resolution of
module kfuncs that may override vmlinux kfuncs with the same name.

This works in conjunction with the libbpf change that prioritizes
module kfuncs during BTF resolution.

Suggested-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Signed-off-by: Song Chen <chensong_2000@126.com>

---
changelog:
v1 --- v2:
libbpf has already specified which module this kfunc belongs to as
ebpf code onwer's expectation, then verifier uses
find_kallsyms_symbol_value to search kfunc's addr.
---
 kernel/bpf/verifier.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)
 mode change 100644 => 100755 kernel/bpf/verifier.c

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
old mode 100644
new mode 100755
index 159b25f8269d..3b2e4552a3d4
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3303,6 +3303,7 @@ static struct btf *__find_kfunc_desc_btf(struct bpf_verifier_env *env,
 		 */
 		sort(tab->descs, tab->nr_descs, sizeof(tab->descs[0]),
 		     kfunc_btf_cmp_by_off, NULL);
+
 	} else {
 		btf = b->btf;
 	}
@@ -3498,7 +3499,16 @@ static int add_kfunc_call(struct bpf_verifier_env *env, u32 func_id, s16 offset)
 	if (err)
 		return err;
 
-	addr = kallsyms_lookup_name(kfunc.name);
+	if (offset) {
+		struct bpf_kfunc_btf kf_btf = { .offset = offset };
+		struct module *mod;
+		struct bpf_kfunc_btf *b;
+		b = bsearch(&kf_btf, btf_tab->descs, btf_tab->nr_descs,
+            sizeof(btf_tab->descs[0]), kfunc_btf_cmp_by_off);
+		mod = b->module;
+		addr = find_kallsyms_symbol_value(mod, kfunc.name);
+	} else
+		addr = kallsyms_lookup_name(kfunc.name);
 	if (!addr) {
 		verbose(env, "cannot find address for kernel function %s\n", kfunc.name);
 		return -EINVAL;
-- 
2.43.0

