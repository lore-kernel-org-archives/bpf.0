Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE0FE48A8A7;
	Tue,  1 Sep 2026 16:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788281968; cv=none; b=Stij9cmYCDxwq6t9LcTHWNjMrUDGgKI141STXAmpqishVF8BH8Vx2E22cM+cjFjvWdEa3hsLUdTv6W9id5hua46kgwjxu7Zb7xBRJs60FkfXDTpiaMZgCL2ljteaRPViO/xfA0XC9R61qvi/gp7L7mibGKIyctG+Un8pkUl/BJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788281968; c=relaxed/simple;
	bh=JyMcPXVF8oFwb8qomYhN+W67kZIv6Iha51RUQ6kHjvI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J7ZUN4ZI3vqNAjB42tr47BomIj8rxGN3X5Z/UJJ3FlmKxTwi2n21KfaUeuqM8h6QJH2gc+E0A/vxywu5tpPOVlo5oeNsZsY7kuQ9Frff0PRjocQz9URy9jcSmhXnGlOxbFxfH/DPr1kdhZHLQRGfjXzGuGorwJYe0eg2/+vGIaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=WPsovI82; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WPsovI82"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 681EQBZ5231363;
	Tue, 1 Sep 2026 16:59:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=EE3csnnBq4xpaClhErTPVGIgHvYaCBFWNRL7VdR3BZ0=; b=
	WPsovI820ByzZ0ndxM1SF3Z7KUPYJgbti9i7CWiebY2Vhnas5DnAzWNGKSgrHkhV
	2XV0tF8zSJOqjOS8Ec0jpsUA5K0RX6io3d+jysuYn1FcvOHTfUxRQLkCsBDPMu1T
	xKMj+N3aCJBktWn0VyNC3bTlarikpEQScfJONbKtjisuEqdJtSe2lBFFxQUtCdO+
	aYKOXIUG0FiodNbFo/IGkuXMTpoH0+Tu78SzWBQVE75rfnkpnAobtlPjsFKzeP5i
	zip8bKlC4o3zOIQj3N/WDnleYPk6nitu9Ney2r6JQoupaDa+dPTz5dmeI2kJw22+
	CGOXKam/lCiql40TrD+RsA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4gbqa7n3vq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 01 Sep 2026 16:59:01 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 681GjWkE002025;
	Tue, 1 Sep 2026 16:59:00 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4gdymtg999-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 01 Sep 2026 16:59:00 +0000 (GMT)
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 681Gw1WN011129;
	Tue, 1 Sep 2026 16:58:59 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-52-250.vpn.oracle.com [10.154.52.250])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4gdymtg8f6-17;
	Tue, 01 Sep 2026 16:58:59 +0000 (GMT)
From: Alan Maguire <alan.maguire@oracle.com>
To: ast@kernel.org, andrii@kernel.org
Cc: daniel@iogearbox.net, eddyz87@gmail.com, jolsa@kernel.org,
        ihor.solodrai@linux.dev, yonghong.song@linux.dev, song@kernel.org,
        qmo@kernel.org, martin.lau@linux.dev, memxor@gmail.com,
        emil@etsalapatis.com, mcgrof@kernel.org, petr.pavlu@suse.com,
        tj@kernel.org, kees@kernel.org, bpf@vger.kernel.org, nathan@kernel.org,
        nsc@kernel.org, arnd@arndb.de, puranjay@kernel.org, yatsenko@meta.com,
        atenart@kernel.org, ojeda@kernel.org, linux-modules@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v2 bpf-next 16/18] btf: Relocate inline BTF for modules with distilled base BTF
Date: Tue,  1 Sep 2026 17:57:55 +0100
Message-ID: <20260901165757.801449-17-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260901165757.801449-1-alan.maguire@oracle.com>
References: <20260901165757.801449-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-01_04,2026-09-01_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 adultscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=0
 bulkscore=0 mlxlogscore=999 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2606160000 definitions=main-2609010148
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAxMDE1MCBTYWx0ZWRfXx/4o1i0tCaPo
 TmT9Iludvq3vEiDg8gxP1sOMNNZS9rFsbDS3KB5ssGUcbi1iCl7D9KDzEKuuJPEeCJ7sfGbblEm
 kRoCdMFn2y36ylkwav/zgUrenyefRUa71LyrmCIAhnpWhbH7EW5z
X-Proofpoint-GUID: FtBRVqDIz7jz0hUBuP9_eK4g7vGljhfB
X-Authority-Analysis: v=2.4 cv=DPu/JSNb c=1 sm=1 tr=0 ts=6a970455 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=EIcjfB9IiI4px24ztqRk:22 a=yPCof4ZbAAAA:8
 a=P2eN7qpJbXAWXnC2rDAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:13521
X-Proofpoint-ORIG-GUID: FtBRVqDIz7jz0hUBuP9_eK4g7vGljhfB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAxMDE1MCBTYWx0ZWRfXyCR5wCMn71BF
 DB0g3r2nFOOuPvUy/K05FnP79DQTr51kop50tSXlRRtKRMHQNFcQwGAehntIPJhEbGmxXwsGcuh
 d28gyNQElqGO5PyAItqMXIaEXzwwYlTyKsf2wLttcfQ+QClHRJGdv2QhW0sF61m5hPxZnbT9PaJ
 9c8r9UwTQGZ/F4DcRGcOeM6lZ7R3RoHJYOGM5S/xhy4//93eITXTRTo+c4XSq8GCxUdF6J2Ip3P
 ocOSSvOwpzYO/iz1Mj0JXBrC1lwUxkeSlkWwp2gG4C5Tn+cUb/cv+I9gr0OfBQW380nMZEPDAL0
 mpscCL1v5vBP98StK0zdi2C6+m1O3ScZt7xclhfLGQSI23dd8OKJ8tpoRgqk5aWK3kcsGR1pt4E
 sMPeEJ+0CuntOrM/BJcQasKNE2xvCVBOc8sIbmPYiWGEao+KJGUmiw8gZnggyT5ZbwfWkqvNheR
 SfvPNFMGoXxk3jCQrVWhuP1Qsl7yYymCsBzfXJEs=

Module .BTF.inline is split relative to the module BTF. For external
modules, the module BTF is initially split relative to a distilled
.BTF.base and is relocated to vmlinux when the module is loaded.

Add a common split-BTF parser that accepts an explicit base BTF. Parse
ordinary module inline BTF relative to the original module BTF, retain the
module relocation ID map, then rewrite inline type IDs and string offsets
for the relocated vmlinux/module ID space before publishing it in sysfs.

A failure to parse or relocate optional inline BTF must not prevent
regular module BTF from being registered. Warn and omit only the inline
sysfs representation in that case.

This supports valid inline BTF for cases:

  vmlinux -> module BTF -> module inline BTF

  distilled vmlinux base -> module BTF -> module inline BTF

and:

  vmlinux -> vmlinux inline BTF

Inline BTF can also inherit strings from an external module’s distilled
.BTF.base.  Preserve the string-relocation map produced while relocating
the module BTF, and use it to rewrite those inherited inline string
offsets to their vmlinux equivalents.  Without this, any shared
distilled-base string causes inline-BTF relocation to fail and its sysfs
representation to be omitted.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
Assisted-by: OpenAI Codex (gpt-5.6)
---
 include/linux/btf.h             |   5 +-
 kernel/bpf/btf.c                | 263 ++++++++++++++++++++++++--------
 tools/lib/bpf/btf.c             |   2 +-
 tools/lib/bpf/btf_relocate.c    |   7 +-
 tools/lib/bpf/libbpf_internal.h |   3 +-
 5 files changed, 213 insertions(+), 67 deletions(-)

diff --git a/include/linux/btf.h b/include/linux/btf.h
index 93f10d3ccabe..702ae246052f 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -588,7 +588,8 @@ struct btf_field_iter {
 #ifdef CONFIG_BPF_SYSCALL
 const struct btf_type *btf_type_by_id(const struct btf *btf, u32 type_id);
 void btf_set_base_btf(struct btf *btf, const struct btf *base_btf);
-int btf_relocate(struct btf *btf, const struct btf *base_btf, __u32 **map_ids);
+int btf_relocate(struct btf *btf, const struct btf *base_btf, __u32 **map_ids,
+		 __u32 **map_strs);
 int btf_field_iter_init(struct btf_field_iter *it, struct btf_type *t,
 			enum btf_field_iter_kind iter_kind);
 __u32 *btf_field_iter_next(struct btf_field_iter *it);
@@ -640,7 +641,7 @@ static inline void btf_set_base_btf(struct btf *btf, const struct btf *base_btf)
 }
 
 static inline int btf_relocate(void *log, struct btf *btf, const struct btf *base_btf,
-			       __u32 **map_ids)
+			       __u32 **map_ids, __u32 **map_strs)
 {
 	return -EOPNOTSUPP;
 }
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 2ac1f1d39660..2f3e8cea7dfc 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -1943,7 +1943,7 @@ void btf_set_base_btf(struct btf *btf, const struct btf *base_btf)
 {
 	btf->base_btf = (struct btf *)base_btf;
 	btf->start_id = btf_nr_types(base_btf);
-	btf->start_str_off = base_btf->hdr.str_len;
+	btf->start_str_off = base_btf->start_str_off + base_btf->hdr.str_len;
 }
 
 static int env_resolve_init(struct btf_verifier_env *env)
@@ -6727,15 +6727,140 @@ __u32 btf_relocate_id(const struct btf *btf, __u32 id)
 
 #ifdef CONFIG_DEBUG_INFO_BTF_MODULES
 
+static struct btf *btf_parse_split(struct btf_verifier_env *env, const char *name,
+				   const void *data, unsigned int data_size,
+				   struct btf *base_btf)
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
+static int btf_rebase_inline(struct btf *inline_btf, const struct btf *module_btf,
+			     const u32 *module_id_map, const u32 *module_str_map,
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
+			/*
+			 * LOCSEC names its code section in the module BTF's string
+			 * section. Shift those inherited strings together with
+			 * inline-local strings when replacing a distilled base BTF.
+			 */
+			if (*str_off < old_module_start_str_off) {
+				/* vmlinux strings retain their offsets for in-tree modules. */
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
+				    unsigned int base_data_size, const void *inline_data,
+				    unsigned int inline_data_size, bool vmlinux_inline,
+				    void **relocated_inline_data)
 {
-	struct btf *btf = NULL, *vmlinux_btf, *base_btf = NULL;
+	struct btf *btf = NULL, *inline_btf = NULL, *vmlinux_btf, *base_btf = NULL;
+	struct btf *inline_base_btf;
 	struct btf_verifier_env *env = NULL;
 	struct bpf_verifier_log *log;
+	u32 old_module_type_cnt;
+	u32 *module_str_map = NULL;
 	int err = 0;
 
+	*relocated_inline_data = NULL;
 	vmlinux_btf = bpf_get_btf_vmlinux();
 	if (IS_ERR(vmlinux_btf))
 		return vmlinux_btf;
@@ -6759,67 +6884,75 @@ static struct btf *btf_parse_module(const char *module_name, const void *data,
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
-
-	btf->base_btf = base_btf;
-	btf->start_id = base_btf->nr_types;
-	btf->start_str_off = base_btf->hdr.str_len;
-	btf->kernel_btf = true;
-	btf->named_start_id = 0;
-	strscpy(btf->name, module_name);
 
-	btf->data = kvmemdup(data, data_size, GFP_KERNEL | __GFP_NOWARN);
-	if (!btf->data) {
-		err = -ENOMEM;
-		goto errout;
+	if (inline_data_size) {
+		/*
+		 * Ordinary module inline BTF is split relative to the module BTF.
+		 * The btf_vmlinux_inline delivery module instead carries BTF split
+		 * directly relative to vmlinux.
+		 */
+		inline_base_btf = vmlinux_inline ? vmlinux_btf : btf;
+		inline_btf = btf_parse_split(env, module_name, inline_data,
+					     inline_data_size, inline_base_btf);
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
 
+	old_module_type_cnt = btf_nr_types(btf);
 	if (base_btf != vmlinux_btf) {
-		err = btf_relocate(btf, vmlinux_btf, &btf->base_id_map);
+		err = btf_relocate(btf, vmlinux_btf, &btf->base_id_map, &module_str_map);
 		if (err)
 			goto errout;
 		btf_free(base_btf);
 		base_btf = vmlinux_btf;
 	}
 
-	btf_verifier_env_free(env);
+	if (inline_btf) {
+		if (!vmlinux_inline) {
+			err = btf_rebase_inline(inline_btf, btf, btf->base_id_map,
+						module_str_map, old_module_type_cnt);
+			if (err) {
+				pr_warn("failed to relocate module [%s] inline BTF: %d\n",
+					module_name, err);
+				btf_free(inline_btf);
+				inline_btf = NULL;
+			}
+		}
+		if (inline_btf) {
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
+	btf_free(inline_btf);
 	if (!IS_ERR(base_btf) && base_btf != vmlinux_btf)
 		btf_free(base_btf);
-	if (btf) {
-		kvfree(btf->data);
-		kvfree(btf->types);
-		kfree(btf);
-	}
+	btf_free(btf);
 	return ERR_PTR(err);
 }
 
@@ -8909,6 +9042,8 @@ static int btf_module_notify(struct notifier_block *nb, unsigned long op,
 	struct module *mod = module;
 	struct bin_attribute *attr;
 	struct btf *btf;
+	void *inline_data = NULL, *relocated_inline_data = NULL;
+	unsigned int inline_data_size = 0;
 	int err = 0;
 
 	if (mod->btf_data_size == 0 ||
@@ -8918,13 +9053,20 @@ static int btf_module_notify(struct notifier_block *nb, unsigned long op,
 
 	switch (op) {
 	case MODULE_STATE_COMING:
+#if IS_ENABLED(CONFIG_DEBUG_INFO_BTF_INLINE)
+		inline_data = mod->btf_inline_data;
+		inline_data_size = mod->btf_inline_data_size;
+#endif
 		btf_mod = kzalloc_obj(*btf_mod);
 		if (!btf_mod) {
 			err = -ENOMEM;
 			goto out;
 		}
 		btf = btf_parse_module(mod->name, mod->btf_data, mod->btf_data_size,
-				       mod->btf_base_data, mod->btf_base_data_size);
+				       mod->btf_base_data, mod->btf_base_data_size,
+				       inline_data, inline_data_size,
+				       strcmp(mod->name, "btf_vmlinux_inline") == 0,
+				       &relocated_inline_data);
 		if (IS_ERR(btf)) {
 			kfree(btf_mod);
 			if (!IS_ENABLED(CONFIG_MODULE_ALLOW_BTF_MISMATCH)) {
@@ -8939,6 +9081,7 @@ static int btf_module_notify(struct notifier_block *nb, unsigned long op,
 		err = btf_alloc_id(btf);
 		if (err) {
 			btf_free(btf);
+			kvfree(relocated_inline_data);
 			kfree(btf_mod);
 			goto out;
 		}
@@ -8947,6 +9090,9 @@ static int btf_module_notify(struct notifier_block *nb, unsigned long op,
 		mutex_lock(&btf_module_mutex);
 		btf_mod->module = module;
 		btf_mod->btf = btf;
+#if IS_ENABLED(CONFIG_DEBUG_INFO_BTF_INLINE)
+		btf_mod->btf_inline_data = relocated_inline_data;
+#endif
 		list_add(&btf_mod->list, &btf_modules);
 		mutex_unlock(&btf_module_mutex);
 
@@ -8958,32 +9104,26 @@ static int btf_module_notify(struct notifier_block *nb, unsigned long op,
 		btf_mod->sysfs_attr = attr;
 
 #if IS_ENABLED(CONFIG_DEBUG_INFO_BTF_INLINE)
-		if (mod->btf_inline_data_size > 0) {
+		if (relocated_inline_data) {
 			char name[MODULE_NAME_LEN + sizeof(".inline")];
-			void *data;
 
-			data = kvmemdup(mod->btf_inline_data, mod->btf_inline_data_size,
-					GFP_KERNEL | __GFP_NOWARN);
-			if (!data) {
-				err = 0;
-				goto out;
-			}
 			if (strcmp(mod->name, "btf_vmlinux_inline") == 0) {
 				if (vmlinux_inline_attr)
-					sysfs_btf_update(vmlinux_inline_attr, data,
-							 mod->btf_inline_data_size);
+					sysfs_btf_update(vmlinux_inline_attr,
+							 relocated_inline_data, inline_data_size);
 				else
-					kvfree(data);
+					kvfree(relocated_inline_data);
+				btf_mod->btf_inline_data = NULL;
 				break;
 			}
 			snprintf(name, sizeof(name), "%s.inline", mod->name);
-			attr = sysfs_btf_add(name, data, mod->btf_inline_data_size);
+			attr = sysfs_btf_add(name, relocated_inline_data, inline_data_size);
 			if (IS_ERR(attr)) {
 				err = 0;
-				kvfree(data);
+				kvfree(relocated_inline_data);
+				btf_mod->btf_inline_data = NULL;
 				goto out;
 			}
-			btf_mod->btf_inline_data = data;
 			btf_mod->sysfs_inline_attr = attr;
 		}
 #endif
@@ -9017,10 +9157,9 @@ static int btf_module_notify(struct notifier_block *nb, unsigned long op,
 			if (btf_mod->sysfs_attr)
 				sysfs_btf_remove(btf_mod->sysfs_attr);
 #if IS_ENABLED(CONFIG_DEBUG_INFO_BTF_INLINE)
-			if (btf_mod->sysfs_inline_attr) {
+			if (btf_mod->sysfs_inline_attr)
 				sysfs_btf_remove(btf_mod->sysfs_inline_attr);
-				kvfree(btf_mod->btf_inline_data);
-			}
+			kvfree(btf_mod->btf_inline_data);
 #endif
 			purge_cand_cache(btf_mod->btf);
 			btf_put(btf_mod->btf);
diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index 30f8c426d145..eea325ccf768 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -6630,7 +6630,7 @@ void btf_set_base_btf(struct btf *btf, const struct btf *base_btf)
 
 int btf__relocate(struct btf *btf, const struct btf *base_btf)
 {
-	int err = btf_relocate(btf, base_btf, NULL);
+	int err = btf_relocate(btf, base_btf, NULL, NULL);
 
 	if (!err)
 		btf->owns_base = false;
diff --git a/tools/lib/bpf/btf_relocate.c b/tools/lib/bpf/btf_relocate.c
index df5fa4bd87d6..e55dd75f6c95 100644
--- a/tools/lib/bpf/btf_relocate.c
+++ b/tools/lib/bpf/btf_relocate.c
@@ -441,7 +441,8 @@ static int btf_relocate_rewrite_strs(struct btf_relocate *r, __u32 i)
 /* If successful, output of relocation is updated BTF with base BTF pointing
  * at base_btf, and type ids, strings adjusted accordingly.
  */
-int btf_relocate(struct btf *btf, const struct btf *base_btf, __u32 **id_map)
+int btf_relocate(struct btf *btf, const struct btf *base_btf, __u32 **id_map,
+		 __u32 **str_map)
 {
 	unsigned int nr_types = btf__type_cnt(btf);
 	const struct btf_header *dist_base_hdr;
@@ -512,6 +513,10 @@ int btf_relocate(struct btf *btf, const struct btf *base_btf, __u32 **id_map)
 		*id_map = r.id_map;
 		r.id_map = NULL;
 	}
+	if (str_map) {
+		*str_map = r.str_map;
+		r.str_map = NULL;
+	}
 err_out:
 	free(r.id_map);
 	free(r.str_map);
diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_internal.h
index ebac8db1ccfd..e7a6219374a9 100644
--- a/tools/lib/bpf/libbpf_internal.h
+++ b/tools/lib/bpf/libbpf_internal.h
@@ -249,7 +249,8 @@ const char *btf_kind_str(const struct btf_type *t);
 const struct btf_type *skip_mods_and_typedefs(const struct btf *btf, __u32 id, __u32 *res_id);
 const struct btf_header *btf_header(const struct btf *btf);
 void btf_set_base_btf(struct btf *btf, const struct btf *base_btf);
-int btf_relocate(struct btf *btf, const struct btf *base_btf, __u32 **id_map);
+int btf_relocate(struct btf *btf, const struct btf *base_btf, __u32 **id_map,
+		 __u32 **str_map);
 bool btf_type_is_traceable_func(const struct btf *btf, const struct btf_type *t);
 
 static inline enum btf_func_linkage btf_func_linkage(const struct btf_type *t)
-- 
2.43.5

