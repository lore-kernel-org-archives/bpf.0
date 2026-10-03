Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83D3D38F65D;
	Sat,  3 Oct 2026 19:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791056671; cv=none; b=LbVXOt095Y6q5vubB+yjEnYqE2s68TchQNW+TYiRI9dnFY69NLWmgby/bDo1yShMHDdZ0hXnCaYyRJ/upiftWADLmB2UIZ4nUkRDTFFoA/6cGnWv0ra3r/Kn83nFVpX9kFK6FeI4m6m7bppVwWZz28UZJxLrb6yc9ZImwPGI/5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791056671; c=relaxed/simple;
	bh=HmFFty7gIb4GgjQ/4DHBLsBuwrF4RZFwQk0mXFP+txI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AlOYr+mWIgXHVPDhb825ZN+5uhZsbIwqv+b6b2GkEv44UwqsPWZ/upsKOhfML1FWW9y9kI7nV8X+QZdbtcnoLsMSHhAHxQoAUHneNxonv68tGIt+Y6pea0mDQATcXA5Ge3fWMdlXnYh2qvgJ0Fn+e8eIQ6zXmhG7HgDYSDVz2TY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=De8ZQch0; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="De8ZQch0"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 693JdrDR3572851;
	Sat, 3 Oct 2026 19:44:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=XXVTj
	feSU5E1YW79NMvuu75/j54ybu1XB4BgdHEugQk=; b=De8ZQch0nrfacSwXcNGew
	63K6F0iHoSv5zTWugdMdjZxFzG4miQQkW+zPQbh+srHkIqqoiHBgtuLp6UC4+fLk
	oQstVH2gHqz/dQlaIjiImAV/yAhxAfOsYAF2VCtnwyJcwXyNjX/bCAHTNai0Kluy
	pJ+kjqSEcK/2udq6OwciG60TBNcRJ9Pu75owqMVOO94j9v8ph7KI0OklaaT0fZO0
	pjZ190RU/z2HOEwYRCP9RoMJslXp5HJ3dlLPM3dBdGOzBtu/9a07OhAEtU8cV1Rp
	AiSwcIJAyjtUB2nU5jqOVTqOi1lXbMJ7lA4UiEgMGxsyUR4L6qf59G/ltTaMggv2
	Q==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4h2srcrdc2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 03 Oct 2026 19:44:00 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 693JZ17o005057;
	Sat, 3 Oct 2026 19:43:59 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4h2r58yysu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 03 Oct 2026 19:43:59 +0000 (GMT)
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 693JdEN3012617;
	Sat, 3 Oct 2026 19:43:58 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-83-182.vpn.oracle.com [10.154.83.182])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4h2r58yynt-6;
	Sat, 03 Oct 2026 19:43:58 +0000 (GMT)
From: Alan Maguire <alan.maguire@oracle.com>
To: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, eddyz87@gmail.com
Cc: jolsa@kernel.org, ihor.solodrai@linux.dev, yonghong.song@linux.dev,
        song@kernel.org, qmo@kernel.org, martin.lau@linux.dev,
        memxor@gmail.com, emil@etsalapatis.com, mcgrof@kernel.org,
        petr.pavlu@suse.com, tj@kernel.org, kees@kernel.org, nathan@kernel.org,
        arnd@arndb.de, puranjay@kernel.org, yatsenko@meta.com,
        atenart@kernel.org, ojeda@kernel.org, linux-modules@vger.kernel.org,
        arnaldo.melo@gmail.com, bpf@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v3 bpf-next 5/7] btf: Relocate and expose module inline BTF
Date: Sat,  3 Oct 2026 20:43:21 +0100
Message-ID: <20261003194323.817885-6-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20261003194323.817885-1-alan.maguire@oracle.com>
References: <20261003194323.817885-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-03_03,2026-10-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 spamscore=0 suspectscore=0 phishscore=0 malwarescore=0 mlxscore=0 bulkscore=0
 adultscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2609040000 definitions=main-2610030078
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAzMDA3OCBTYWx0ZWRfX/OLHhwHDTkQg
 PqGolUxXN3AZjcn4bZczOzJAduNHvmrsedbGwWjfqnq5AcXM0kHluhhKiH2pW7qrl/tkcZzjNS0
 Kp+lMSdYP8zUQMK+g5d8Ha1d4tm3Vkz+FXJ4Yhrlr73yUBQFAlYB
X-Authority-Analysis: v=2.4 cv=d/dgWhjE c=1 sm=1 tr=0 ts=6ac15b00 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=BqU2WV_vvsyTyxaotp0D:22 a=yPCof4ZbAAAA:8 a=3kx-2w9HvSMfnrkAd5kA:9
X-Proofpoint-ORIG-GUID: 4MLcYMQoSCTv5WYyiibeEHH9O-yvJnJI
X-Proofpoint-GUID: 4MLcYMQoSCTv5WYyiibeEHH9O-yvJnJI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAzMDA3OCBTYWx0ZWRfX8yYOksjpLkuS
 ROo8LNh71Fmbyhs6Ve4KRiKH9iXvWL8KyJzUyJfGLHEXhAttp0dFyNcwUilGgdLwpSFozRIhJBg
 VhlS/i4L2hBTQefymvj29rCQ+c0mYdLlMj+Bs7LOxi+BBfIOLHYRBA/1l7OsfkU7+W04CuDSnN3
 dcBTzmAcfbbeufR6Xm2yOmFv5QCdErMHpUxCYCgMqOC0Pz1IlX7T7jXYlaFlxsT4qx2pWPfxYs2
 3ZT6/Zuq5JJDuxKX9AMvtSXfE3GOoMZQncysAFOqZ21Gi2ouup263wa3AQNoEWEZReC/Zc15kku
 +n272BKPkUCQ4CVvwk3BDmKfP7+rQhgUAksWeQzKsBii/wlBBjnsocbN8Ca6nzX9erXdUbrvric
 djaudNACjCxOEozkD+4jJ557eyRAIYAXtvxxeofpI6ss8FSXyDWRbJWDmzoQkgHZrzvdc1Vnerg
 mB17ZNWvLjqn6+ulmxA==

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
 kernel/bpf/btf.c   | 244 ++++++++++++++++++++++++++++++++++++---------
 scripts/gen-btf.sh |   7 +-
 2 files changed, 201 insertions(+), 50 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 4242e00a3f7e..a9c46c731602 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -6912,15 +6912,137 @@ __u32 btf_relocate_id(const struct btf *btf, __u32 id)
 
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
+	u32 old_module_type_cnt;
+	u32 *module_str_map = NULL;
 	int err = 0;
 
+	*relocated_inline_data = NULL;
 	vmlinux_btf = bpf_get_btf_vmlinux();
 	if (IS_ERR(vmlinux_btf))
 		return vmlinux_btf;
@@ -6944,67 +7066,66 @@ static struct btf *btf_parse_module(const char *module_name, const void *data,
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
 
+	old_module_type_cnt = btf_nr_types(btf);
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
 
@@ -8998,6 +9119,8 @@ struct btf_module {
 	struct module *module;
 	struct btf *btf;
 	struct bin_attribute *sysfs_attr;
+	struct bin_attribute *sysfs_inline_attr;
+	void *btf_inline_data;
 	int flags;
 };
 
@@ -9072,7 +9195,8 @@ static int btf_module_handle_vmlinux_inline(const struct module *mod)
 {
 	void *data = NULL;
 
-	if (!vmlinux_inline_link || strcmp(mod->name, vmlinux_inline_link->module_name))
+	if (!vmlinux_inline_link ||
+	    strcmp(mod->name, vmlinux_inline_link->module_name))
 		return -ENOENT;
 
 	data = vmalloc_user(mod->btf_inline_data_size);
@@ -9107,6 +9231,8 @@ static int btf_module_notify(struct notifier_block *nb, unsigned long op,
 	struct module *mod = module;
 	struct bin_attribute *attr;
 	struct btf *btf;
+	void *inline_data = NULL, *relocated_inline_data = NULL;
+	unsigned int inline_data_size = 0;
 	int err = 0;
 
 	if (op != MODULE_STATE_COMING && op != MODULE_STATE_LIVE &&
@@ -9120,6 +9246,12 @@ static int btf_module_notify(struct notifier_block *nb, unsigned long op,
 			err = 0;
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
@@ -9128,7 +9260,9 @@ static int btf_module_notify(struct notifier_block *nb, unsigned long op,
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
@@ -9143,6 +9277,7 @@ static int btf_module_notify(struct notifier_block *nb, unsigned long op,
 		err = btf_alloc_id(btf);
 		if (err) {
 			btf_free(btf);
+			kvfree(relocated_inline_data);
 			kfree(btf_mod);
 			goto out;
 		}
@@ -9151,6 +9286,7 @@ static int btf_module_notify(struct notifier_block *nb, unsigned long op,
 		mutex_lock(&btf_module_mutex);
 		btf_mod->module = module;
 		btf_mod->btf = btf;
+		btf_mod->btf_inline_data = relocated_inline_data;
 		list_add(&btf_mod->list, &btf_modules);
 		mutex_unlock(&btf_module_mutex);
 
@@ -9160,6 +9296,21 @@ static int btf_module_notify(struct notifier_block *nb, unsigned long op,
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
@@ -9192,6 +9343,9 @@ static int btf_module_notify(struct notifier_block *nb, unsigned long op,
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

