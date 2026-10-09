Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 284634C651A;
	Fri,  9 Oct 2026 11:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791545070; cv=none; b=LUQQu3sVofUIJoFtd/KzvuJ9ZTgMplavV/ifWAZoW2ik4U2Irfp/MjRqcFZ64AsZA1R9OZk55KXxLWtt2/3AF6Q8eUMMSqzUV3+ej0svEKHav022TFKx1QaPlYGxkRApGiPLevUVdgYsgyPgG2v58wJ2YKIjDa6n9pCZJIJvbUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791545070; c=relaxed/simple;
	bh=sSqfAdnir2NX1Cin+qaHIljxaxf8xs0ePMG8kCkj1yI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tu8UjLCnaGztFbRRoVmOG44hA5yBp2BVdcL9avstgWuCWIgxG4SoEm/0UC3bSIKKqEfXrAyEla5vxbZxlst87UjOee8Q9TtjHsU3vcCDZIgAwensTfCsJVUtiwBpmpOPM7NDrbKq1DShwH+VbFUQ3XY1MVXCKC1xuQa4UyGAha8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=X29Kxo3v; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="X29Kxo3v"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6990G41R3546660;
	Fri, 9 Oct 2026 11:23:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=JvRZ6
	uLjJzvsO0QAbhnWL4ypmrdKjLGySTZgM4gaR1k=; b=X29Kxo3vAjZ5iM6RIlMCb
	DZQY+RFfDsUedGYtzonUkn/AEzMrSPDSS20r3S0g7x7OfcnAoFyGyCUdMewZVREo
	Bur8f3rk5rmrPIido2brE5w26XkTQp5NTpmhg1v2tBVUBRm4OxGnUkgBZAnT6vj3
	qVkZscNqYqOuy9OL24etQyxvrZlI+M7k9p6C8IY7wLnXoZJ1yunSIHCarr2rYzVG
	TcZtXI8+rpD52FIS27HukhQ79iimxCFkugcLWxX42Jczn6OgqLQ5Kl6sKFIjvqok
	lQ9v+l+WmmbfI4cooOukbJ6OBi+K3vota1ftpapvpzK/BIeRTFGRhtPyyGyvHGpA
	w==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4h5xefu2qu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 09 Oct 2026 11:23:47 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 699BLkJ3039969;
	Fri, 9 Oct 2026 11:23:46 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4h5xfcsnf3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 09 Oct 2026 11:23:46 +0000 (GMT)
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 699BNRka006543;
	Fri, 9 Oct 2026 11:23:45 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-85-231.vpn.oracle.com [10.154.85.231])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4h5xfcsn8m-6;
	Fri, 09 Oct 2026 11:23:45 +0000 (GMT)
From: Alan Maguire <alan.maguire@oracle.com>
To: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, eddyz87@gmail.com,
        jolsa@kernel.org
Cc: ihor.solodrai@linux.dev, yonghong.song@linux.dev, song@kernel.org,
        qmo@kernel.org, martin.lau@linux.dev, memxor@gmail.com,
        emil@etsalapatis.com, mcgrof@kernel.org, petr.pavlu@suse.com,
        tj@kernel.org, kees@kernel.org, nathan@kernel.org, arnd@arndb.de,
        puranjay@kernel.org, yatsenko@meta.com, atenart@kernel.org,
        ojeda@kernel.org, linux-modules@vger.kernel.org,
        arnaldo.melo@gmail.com, bpf@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v4 bpf-next 5/7] btf: Relocate and expose module inline BTF
Date: Fri,  9 Oct 2026 12:23:22 +0100
Message-ID: <20261009112324.1442319-6-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20261009112324.1442319-1-alan.maguire@oracle.com>
References: <20261009112324.1442319-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_03,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 suspectscore=0 spamscore=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 phishscore=0 lowpriorityscore=0 malwarescore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2610020000 definitions=main-2610090045
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDA0NSBTYWx0ZWRfX2zJAilv+bAiJ
 Xv02P08lDPpymWVDt+ZVYOEW29YzpQvlPRO367RyYGL3hmD3mzqyt7ZvOCsKc716ZDpXZ/R5fKu
 92xh5P5IrkQy2CUMlVZ3M2APOJ/YwF+ypbiu5BKhu7oO716uz90r
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDA0NSBTYWx0ZWRfX8ptgWF6+22K6
 wngH0FcO4wT3pIHnGDlD5dPgOXzWfg9DSZib6VXuL45NWKlk6ueRNME0Fp198z5viK8UAHXJrwl
 bZi4f3G4Dsn5jvc5XtN86I0l+DOEtNi6RJJk7KJI8LneS/lvmdNcBJCPWD1yUm6RH81icu00hjC
 UpN/PzbcsuVlI3lYAgKobguBn7O9I1Djdq8FrJMhKPsqjGmZEWybPvWdrzH1dT3G/bMXpV3Fu0K
 aQmn0fe3JeJecclDE5EPmeNUYqdUqeXCjHRRsfEO15u5UU4IZVpYWPurXXMSfpXS6qdF3qRJP8k
 P9jxKkcKk3zrlr7V6t9dJ5ah8Oe1oG7lQgTKVY3BoGyW/Nxufq+EIeZpMAuHPvmhR+Tz5OEkNm/
 ePfRrwswkfI1UNSJChnon5OSjsfq5kFElExZ8xjfkD7JPWeU2BpO1s377xo0rcV06Z1QTlJe9zm
 Z3C/Ypz6gMdEILfEJIgJH5ElIPr6lOCdfaU7WhQ8=
X-Authority-Analysis: v=2.4 cv=AewkjHXG c=1 sm=1 tr=0 ts=6ac8cec3 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=BqU2WV_vvsyTyxaotp0D:22 a=yPCof4ZbAAAA:8 a=3kx-2w9HvSMfnrkAd5kA:9
 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:12108
X-Proofpoint-GUID: xmRtr7-ru8XwMqYhvfSMYOogi91fFHxZ
X-Proofpoint-ORIG-GUID: xmRtr7-ru8XwMqYhvfSMYOogi91fFHxZ

Module .BTF.inline is split relative to its module BTF. For external
modules, module BTF can instead be split relative to a distilled
.BTF.base and is relocated against vmlinux when the module loads.

Parse ordinary module inline BTF relative to the pre-relocation
module BTF. Retain the module relocation ID and string maps, then
rebase inline type IDs and string offsets onto the final
vmlinux/module BTF space before exposing the result through sysfs.

Malformed or unrelocatable optional inline BTF is warned about and
omitted without preventing normal module BTF registration. The
btf_vmlinux_inline carrier remains on its existing hash-checked,
vmalloc-backed publishing path, preserving mmap support for
vmlinux.inline when delivered by a module.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
Assisted-by: OpenAI Codex (GPT-5.6)
---
 kernel/bpf/btf.c   | 243 +++++++++++++++++++++++++++++++++++++--------
 scripts/gen-btf.sh |   7 +-
 2 files changed, 201 insertions(+), 49 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 22dd123450c3..29599ab7449e 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -6922,15 +6922,137 @@ __u32 btf_relocate_id(const struct btf *btf, __u32 id)
 
 #ifdef CONFIG_DEBUG_INFO_BTF_MODULES
 
+static struct btf *btf_parse_split(struct btf_verifier_env *env,
+				   const char *name, const void *data,
+				   unsigned int data_size, struct btf *base_btf)
+{
+	struct btf *btf;
+	int err;
+
+	btf = kzalloc_obj(*btf, GFP_KERNEL | __GFP_NOWARN);
+	if (!btf)
+		return ERR_PTR(-ENOMEM);
+	env->btf = btf;
+
+	btf_set_base_btf(btf, base_btf);
+	btf->kernel_btf = true;
+	btf->named_start_id = 0;
+	strscpy(btf->name, name);
+
+	btf->data = kvmemdup(data, data_size, GFP_KERNEL | __GFP_NOWARN);
+	if (!btf->data) {
+		err = -ENOMEM;
+		goto errout;
+	}
+	btf->data_size = data_size;
+
+	err = btf_parse_hdr(env);
+	if (err)
+		goto errout;
+
+	btf->nohdr_data = btf->data + btf->hdr.hdr_len;
+
+	err = btf_parse_str_sec(env);
+	if (err)
+		goto errout;
+
+	err = btf_check_all_metas(env);
+	if (err)
+		goto errout;
+
+	err = btf_check_modifier_chain_length(env, btf, btf_nr_types(base_btf));
+	if (err)
+		goto errout;
+
+	return btf;
+
+errout:
+	btf_free(btf);
+	return ERR_PTR(err);
+}
+
+static int btf_rebase_inline(struct btf *inline_btf,
+			     const struct btf *module_btf,
+			     const u32 *module_id_map,
+			     const u32 *module_str_map,
+			     u32 old_module_type_cnt)
+{
+	u32 old_start_id = inline_btf->start_id;
+	u32 old_start_str_off = inline_btf->start_str_off;
+	u32 old_module_start_str_off = old_start_str_off - module_btf->hdr.str_len;
+	u32 new_start_id = btf_nr_types(module_btf);
+	u32 new_start_str_off = module_btf->start_str_off + module_btf->hdr.str_len;
+	s64 id_delta = (s64)new_start_id - old_start_id;
+	s64 str_delta = (s64)new_start_str_off - old_start_str_off;
+	u32 i;
+
+	/*
+	 * The inline BTF was parsed relative to the original module BTF. Its
+	 * base IDs must therefore use the map generated when that BTF was
+	 * relocated, while IDs for inline-local types only move by the change
+	 * in the module BTF's starting ID.
+	 */
+	for (i = 0; i < inline_btf->nr_types; i++) {
+		struct btf_field_iter it;
+		struct btf_type *t = inline_btf->types[i];
+		u32 *id, *str_off;
+		int err;
+
+		err = btf_field_iter_init(&it, t, BTF_FIELD_ITER_IDS);
+		if (err)
+			return err;
+		while ((id = btf_field_iter_next(&it))) {
+			if (!*id)
+				continue;
+			if (*id < old_module_type_cnt) {
+				if (module_id_map)
+					*id = module_id_map[*id];
+			} else if (*id >= old_start_id) {
+				*id += id_delta;
+			} else {
+				return -EINVAL;
+			}
+		}
+
+		err = btf_field_iter_init(&it, t, BTF_FIELD_ITER_STRS);
+		if (err)
+			return err;
+		while ((str_off = btf_field_iter_next(&it))) {
+			if (!*str_off)
+				continue;
+			if (*str_off < old_module_start_str_off) {
+				/* Vmlinux strings retain their offsets for in-tree modules. */
+				if (!module_id_map)
+					continue;
+				if (!module_str_map || !module_str_map[*str_off])
+					return -EINVAL;
+				*str_off = module_str_map[*str_off];
+				continue;
+			}
+			*str_off += str_delta;
+		}
+	}
+
+	btf_set_base_btf(inline_btf, module_btf);
+	btf_check_sorted(inline_btf);
+	return 0;
+}
+
 static struct btf *btf_parse_module(const char *module_name, const void *data,
 				    unsigned int data_size, void *base_data,
-				    unsigned int base_data_size)
+				    unsigned int base_data_size,
+				    const void *inline_data,
+				    unsigned int inline_data_size,
+				    void **relocated_inline_data)
 {
-	struct btf *btf = NULL, *vmlinux_btf, *base_btf = NULL;
+	struct btf *btf = NULL, *inline_btf = NULL, *vmlinux_btf, *base_btf = NULL;
 	struct btf_verifier_env *env = NULL;
 	struct bpf_verifier_log *log;
+	u32 *module_str_map = NULL;
+	u32 old_module_type_cnt;
 	int err = 0;
 
+	*relocated_inline_data = NULL;
 	vmlinux_btf = bpf_get_btf_vmlinux();
 	if (IS_ERR(vmlinux_btf))
 		return vmlinux_btf;
@@ -6954,67 +7076,68 @@ static struct btf *btf_parse_module(const char *module_name, const void *data,
 		base_btf = vmlinux_btf;
 	}
 
-	btf = kzalloc_obj(*btf, GFP_KERNEL | __GFP_NOWARN);
-	if (!btf) {
-		err = -ENOMEM;
+	btf = btf_parse_split(env, module_name, data, data_size, base_btf);
+	if (IS_ERR(btf)) {
+		err = PTR_ERR(btf);
+		btf = NULL;
 		goto errout;
 	}
-	env->btf = btf;
+	old_module_type_cnt = btf_nr_types(btf);
 
-	btf->base_btf = base_btf;
-	btf->start_id = base_btf->nr_types;
-	btf->start_str_off = base_btf->hdr.str_len;
-	btf->kernel_btf = true;
-	btf->named_start_id = 0;
-	strscpy(btf->name, module_name);
-
-	btf->data = kvmemdup(data, data_size, GFP_KERNEL | __GFP_NOWARN);
-	if (!btf->data) {
-		err = -ENOMEM;
-		goto errout;
+	if (inline_data_size) {
+		inline_btf = btf_parse_split(env, module_name, inline_data,
+					     inline_data_size, btf);
+		if (IS_ERR(inline_btf)) {
+			pr_warn("failed to validate module [%s] inline BTF: %ld\n",
+				module_name, PTR_ERR(inline_btf));
+			inline_btf = NULL;
+		}
 	}
-	btf->data_size = data_size;
-
-	err = btf_parse_hdr(env);
-	if (err)
-		goto errout;
-
-	btf->nohdr_data = btf->data + btf->hdr.hdr_len;
-
-	err = btf_parse_str_sec(env);
-	if (err)
-		goto errout;
-
-	err = btf_check_all_metas(env);
-	if (err)
-		goto errout;
-
-	err = btf_check_modifier_chain_length(env, btf, btf_nr_types(base_btf));
-	if (err)
-		goto errout;
 
 	if (base_btf != vmlinux_btf) {
-		err = btf_relocate(btf, vmlinux_btf, &btf->base_id_map, NULL);
+		err = btf_relocate(btf, vmlinux_btf, &btf->base_id_map,
+				   &module_str_map);
 		if (err)
 			goto errout;
 		btf_free(base_btf);
 		base_btf = vmlinux_btf;
 	}
 
-	btf_verifier_env_free(env);
+	if (inline_btf) {
+		err = btf_rebase_inline(inline_btf, btf, btf->base_id_map,
+					module_str_map, old_module_type_cnt);
+		if (err) {
+			pr_warn("failed to relocate module [%s] inline BTF: %d\n",
+				module_name, err);
+			btf_free(inline_btf);
+		} else {
+			*relocated_inline_data = inline_btf->data;
+			inline_btf->data = NULL;
+			btf_free(inline_btf);
+		}
+	}
+
+	/*
+	 * With a distilled base, btf_relocate() replaces the base BTF and
+	 * rewrites string offsets. Check ordering only after that final BTF
+	 * view has been established, so named_start_id describes the BTF used
+	 * by name lookups.
+	 */
 	btf_check_sorted(btf);
+	btf_verifier_env_free(env);
+	kvfree(module_str_map);
 	refcount_set(&btf->refcnt, 1);
 	return btf;
 
 errout:
+	kvfree(module_str_map);
 	btf_verifier_env_free(env);
+	if (inline_btf)
+		btf_free(inline_btf);
 	if (!IS_ERR(base_btf) && base_btf != vmlinux_btf)
 		btf_free(base_btf);
-	if (btf) {
-		kvfree(btf->data);
-		kvfree(btf->types);
-		kfree(btf);
-	}
+	if (btf)
+		btf_free(btf);
 	return ERR_PTR(err);
 }
 
@@ -9008,6 +9131,8 @@ struct btf_module {
 	struct module *module;
 	struct btf *btf;
 	struct bin_attribute *sysfs_attr;
+	struct bin_attribute *sysfs_inline_attr;
+	void *btf_inline_data;
 	int flags;
 };
 
@@ -9127,6 +9252,8 @@ static int btf_module_notify(struct notifier_block *nb, unsigned long op,
 	struct module *mod = module;
 	struct bin_attribute *attr;
 	struct btf *btf;
+	void *inline_data = NULL, *relocated_inline_data = NULL;
+	unsigned int inline_data_size = 0;
 	int err = 0;
 
 	if (op != MODULE_STATE_COMING && op != MODULE_STATE_LIVE &&
@@ -9140,6 +9267,12 @@ static int btf_module_notify(struct notifier_block *nb, unsigned long op,
 			break;
 		}
 
+#if IS_ENABLED(CONFIG_DEBUG_INFO_BTF_INLINE)
+		if (mod->btf_inline_data_size) {
+			inline_data = mod->btf_inline_data;
+			inline_data_size = mod->btf_inline_data_size;
+		}
+#endif
 		if (!mod->btf_data_size)
 			break;
 		btf_mod = kzalloc_obj(*btf_mod);
@@ -9148,7 +9281,9 @@ static int btf_module_notify(struct notifier_block *nb, unsigned long op,
 			goto out;
 		}
 		btf = btf_parse_module(mod->name, mod->btf_data, mod->btf_data_size,
-				       mod->btf_base_data, mod->btf_base_data_size);
+				       mod->btf_base_data, mod->btf_base_data_size,
+				       inline_data, inline_data_size,
+				       &relocated_inline_data);
 		if (IS_ERR(btf)) {
 			kfree(btf_mod);
 			if (!IS_ENABLED(CONFIG_MODULE_ALLOW_BTF_MISMATCH)) {
@@ -9163,6 +9298,7 @@ static int btf_module_notify(struct notifier_block *nb, unsigned long op,
 		err = btf_alloc_id(btf);
 		if (err) {
 			btf_free(btf);
+			kvfree(relocated_inline_data);
 			kfree(btf_mod);
 			goto out;
 		}
@@ -9171,6 +9307,7 @@ static int btf_module_notify(struct notifier_block *nb, unsigned long op,
 		mutex_lock(&btf_module_mutex);
 		btf_mod->module = module;
 		btf_mod->btf = btf;
+		btf_mod->btf_inline_data = relocated_inline_data;
 		list_add(&btf_mod->list, &btf_modules);
 		mutex_unlock(&btf_module_mutex);
 
@@ -9180,6 +9317,21 @@ static int btf_module_notify(struct notifier_block *nb, unsigned long op,
 			goto out;
 		}
 		btf_mod->sysfs_attr = attr;
+
+		if (relocated_inline_data) {
+			char name[MODULE_NAME_LEN + sizeof(".inline")];
+
+			snprintf(name, sizeof(name), "%s.inline", mod->name);
+			attr = sysfs_btf_add(name, relocated_inline_data,
+					     inline_data_size, false, NULL);
+			if (IS_ERR(attr)) {
+				kvfree(relocated_inline_data);
+				btf_mod->btf_inline_data = NULL;
+				err = 0;
+				break;
+			}
+			btf_mod->sysfs_inline_attr = attr;
+		}
 		break;
 	case MODULE_STATE_LIVE:
 		if (!mod->btf_data_size)
@@ -9212,6 +9364,9 @@ static int btf_module_notify(struct notifier_block *nb, unsigned long op,
 			list_del(&btf_mod->list);
 			if (btf_mod->sysfs_attr)
 				sysfs_btf_remove(btf_mod->sysfs_attr);
+			if (btf_mod->sysfs_inline_attr)
+				sysfs_btf_remove(btf_mod->sysfs_inline_attr);
+			kvfree(btf_mod->btf_inline_data);
 			purge_cand_cache(btf_mod->btf);
 			btf_put(btf_mod->btf);
 			kfree(btf_mod);
diff --git a/scripts/gen-btf.sh b/scripts/gen-btf.sh
index e638291753d0..b17f1189298a 100755
--- a/scripts/gen-btf.sh
+++ b/scripts/gen-btf.sh
@@ -68,10 +68,7 @@ esac
 
 gen_btf_data()
 {
-	inline=""
-	if [ -n "${BTF_INLINE}" ] && [ -z "${BTF_BASE}" ]; then
-		inline="--inline"
-	fi
+	inline=${BTF_INLINE:+--inline}
 	btf1="${ELF_FILE}.BTF.1"
 	${PAHOLE} -J ${PAHOLE_FLAGS}			\
 		${BTF_BASE:+--btf_base ${BTF_BASE}}	\
@@ -130,7 +127,7 @@ embed_btf_data()
 	if [ -f "${btf_base}" ]; then
 		${OBJCOPY} --add-section .BTF.base=${btf_base} ${ELF_FILE}
 	fi
-	btf_inline=""
+	btf_inline=${ELF_FILE}.BTF.inline
 	case "${ELF_FILE}" in
 	*/btf_vmlinux_inline.ko)
 		btf_inline=${BTF_BASE}.BTF.inline
-- 
2.43.5

