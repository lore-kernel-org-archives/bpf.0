Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF81C2F12A5;
	Tue,  7 Apr 2026 08:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775549406; cv=none; b=i1tBq/OOvlaJIUHLq2fC04aBzxHU690t3Ld0ISILqxJ3fR8f3H7ICzJHxVGU1lF7jn/rL81FuzyapFtTN8HS58ELk6zLDo2KWhAbK0XziIEYgnry16liX5itHsj8iLd89t08PRtpFhCm6X3usFv3LSDzpZefkayeT2PtQITN55M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775549406; c=relaxed/simple;
	bh=HTh5flCIajQqKXOoVyfX9YNla6Yo2emGmc9bYiV8K7Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Kohp2nEHvn+JP8I73SXaXE756tW/qcECP+sT+Aeb85BYaPkDMmPrZ0pAKUDKQVKEZ5HVuMpYYGFKmny2m2j/ilbnb1Dih1c7XLKonSJ97BLyoTU3u50pIS62XeOmYDrCCSA07y25iWokC9F9FBHtfzMsdG0WfFyR0/oOqopkLh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=lua23gAp; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="lua23gAp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=Lx
	mDIfwPfihXQbEuCrRaFWkCslsv1PD0ethiOsjyEWU=; b=lua23gApc8OKyOhPuE
	BHF37WfuJIdkIpdkpFnw+NzCv9e2vdjLc4S/GbVJ+u0W0J0R+W3AVj84mX8bEt1L
	Z90MEPQWDabZLaV2Ze9cuVDqACUu6+rh6KQ6Ko0o+4BSVaERCV4YVALmS5d764vF
	vVHchFp8QXUCreg6ffngRszhU=
Received: from nec8-i7 (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wD379ilu9RpZCL9Dg--.28629S2;
	Tue, 07 Apr 2026 16:09:11 +0800 (CST)
From: chenyuan_fl@163.com
To: martin.lau@linux.dev,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yuan Chen <chenyuan@kylinos.cn>
Subject: [PATCH] bpf: fix btf_types_are_same for cross-BTF type comparison
Date: Tue,  7 Apr 2026 04:09:00 -0400
Message-ID: <20260407080900.551797-1-chenyuan_fl@163.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD379ilu9RpZCL9Dg--.28629S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7WFWDKw1Utr1xWr1kZFyftFb_yoW5JrWfpr
	4fGr43Ar48Aw1fuFs7tF1rCF1ak3yfJws0ka4Yg34Syw1UXFZ8Xw4UKr1Fva4Yqr1DXa12
	qF4ayFyfCw17AFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UBCJdUUUUU=
X-CM-SenderInfo: xfkh05pxdqswro6rljoofrz/xtbDAgenZWnUu6fUfQAA3P

From: Yuan Chen <chenyuan@kylinos.cn>

When comparing types from different BTF objects (e.g., module BTF vs
vmlinux BTF), the original btf_types_are_same() returns false because:
  - Type IDs are local to each BTF
  - Pointer comparison of btf_type_by_id results always fails

This prevents kfuncs with KF_IMPLICIT_ARGS flag from modules (like
bpf_kfunc_multi_st_ops_test_1_assoc) from properly recognizing implicit
arguments such as 'struct bpf_prog_aux *', causing the verifier to not
inject the aux pointer value during fixup.

Fix by comparing actual type content (kind, size, name) when BTFs are
different instead of comparing pointers.

Signed-off-by: Yuan Chen <chenyuan@kylinos.cn>
---
 kernel/bpf/btf.c | 32 ++++++++++++++++++++++++++++----
 1 file changed, 28 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index a62d78581207..daad28ae32e5 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -7432,15 +7432,39 @@ int btf_struct_access(struct bpf_verifier_log *log,
  * the same. Trivial ID check is not enough due to module BTFs, because we can
  * end up with two different module BTFs, but IDs point to the common type in
  * vmlinux BTF.
+ *
+ * When comparing types across different BTF objects (e.g., module BTF vs
+ * vmlinux BTF), we need to compare the actual type content (name, kind, size)
+ * since type IDs may differ between BTF objects even for the same type.
  */
 bool btf_types_are_same(const struct btf *btf1, u32 id1,
 			const struct btf *btf2, u32 id2)
 {
-	if (id1 != id2)
-		return false;
+	const struct btf_type *t1, *t2;
+
+	/* If same BTF object, ID comparison is sufficient */
 	if (btf1 == btf2)
-		return true;
-	return btf_type_by_id(btf1, id1) == btf_type_by_id(btf2, id2);
+		return id1 == id2;
+
+	/* Different BTF objects - compare actual type content.
+	 * Type IDs may differ between module BTF and vmlinux BTF,
+	 * so we need to check if the types are semantically identical.
+	 */
+	t1 = btf_type_by_id(btf1, id1);
+	t2 = btf_type_by_id(btf2, id2);
+	if (!t1 || !t2)
+		return false;
+
+	/* Must be same kind and have same name */
+	if (BTF_INFO_KIND(t1->info) != BTF_INFO_KIND(t2->info))
+		return false;
+	if (t1->size != t2->size)
+		return false;
+	if (strcmp(__btf_name_by_offset(btf1, t1->name_off),
+		   __btf_name_by_offset(btf2, t2->name_off)) != 0)
+		return false;
+
+	return true;
 }
 
 bool btf_struct_ids_match(struct bpf_verifier_log *log,
-- 
2.53.0

