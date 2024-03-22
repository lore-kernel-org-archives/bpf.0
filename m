Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 617CE4C79
	for <bpf@vger.kernel.org>; Fri, 22 Mar 2024 10:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711103134; cv=none; b=Cig5GakwbcKVfqH9FTRyPi5R08a5yPQS6KZ+nI857lzWyPgpqm91txHaLX7NGCaWn982ixYUs7UNRIVEHCplrYMYf6iAdRtbz/5Aw80MdxtnYxdyQbZgKMD51ZtT/QtLQHt8zasTz59ZPnjUMnCL9yYTNHDiWWwsSVzcX8WuuyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711103134; c=relaxed/simple;
	bh=8L6CCu9t2Z0jmihUNAyIYP6LNChlXz2KymyZpz06+jY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WVCPpB/XibJEOyalKGm8zqQXGo27ZoBxmt/r/WKw9fSd1+4blPT8/2qpPiF0FHc1LleLalk3+9fraYu9lCXhleNrOcPCijYGFFa71Zv7XY2leBEBOFvM80ShJItKuIQXE5HAbqM+O7m2FKXZvwGFSpWvv81+CkjuZzqWm2mXhH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=XI7QPD87; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XI7QPD87"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42M7Y71t004069;
	Fri, 22 Mar 2024 10:25:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-11-20;
 bh=GLQ2Mt4Xv2nwtzeUxbpqpdegk0L73VruNTMVGMONfRg=;
 b=XI7QPD875JRu0GmXJS3AP1etDD5L/0239zRdME67irPO3VgThxMOLCur+k1xg7+1yvrx
 XN4FwMFTjy/x7aL4eOZbAceRorQmTnjVoEOK1Y/3Dw1leJYuAG3WlFSjYN3f5MmfNz/n
 rQKBV3v2gf5trdqR8A3hOqgBTnzD0GOVXTFhc1Ai+QX/cO0z8hyPi2+DAn9gorEBUnoL
 doRW8lnWP0j6GUpqFxexRb0V3JwFsy1UEpF05wkzN0kxfxuCrSgR3Hm6GDjAbVbkfpA4
 ZwLzOkvB1l+RQ1fWGrFvlP3PR6BbUKpUvBTZHYo3YKqzoSox8yAL48veuO0HPCu6DOgT Kw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3x0wvk8tah-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 Mar 2024 10:25:08 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42M9KQpU014859;
	Fri, 22 Mar 2024 10:25:07 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3x0wvk2hbk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 Mar 2024 10:25:07 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 42MAK0kP030399;
	Fri, 22 Mar 2024 10:25:06 GMT
Received: from bpf.uk.oracle.com (dhcp-10-175-192-105.vpn.oracle.com [10.175.192.105])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3x0wvk2h75-2;
	Fri, 22 Mar 2024 10:25:06 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: andrii@kernel.org, jolsa@kernel.org, acme@redhat.com,
        quentin@isovalent.com
Cc: eddyz87@gmail.com, mykolal@fb.com, ast@kernel.org, daniel@iogearbox.net,
        martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, houtao1@huawei.com, bpf@vger.kernel.org,
        masahiroy@kernel.org, mcgrof@kernel.org, nathan@kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [RFC dwarves] btf_encoder: add base_ref BTF feature to generate split BTF with base refs
Date: Fri, 22 Mar 2024 10:24:42 +0000
Message-Id: <20240322102455.98558-2-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240322102455.98558-1-alan.maguire@oracle.com>
References: <20240322102455.98558-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-22_06,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 mlxscore=0
 malwarescore=0 suspectscore=0 spamscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2403210000
 definitions=main-2403220074
X-Proofpoint-GUID: 3tndxS458lLVhaGk-yg8hw6Vf_cnvPCa
X-Proofpoint-ORIG-GUID: 3tndxS458lLVhaGk-yg8hw6Vf_cnvPCa

Adding "base_ref" to --btf_features when generating split BTF will generate
split and base reference BTF - the latter allows us to map references from
split BTF to base BTF, even if that base BTF has changed.  It does this
by providing just enough information about the base types in the
.BTF.base_ref section.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 btf_encoder.c | 43 ++++++++++++++++++++++++++++++-------------
 dwarves.h     |  1 +
 pahole.c      | 28 ++++++++++++++++------------
 3 files changed, 47 insertions(+), 25 deletions(-)

diff --git a/btf_encoder.c b/btf_encoder.c
index e1e3529..ec5fa87 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -75,7 +75,8 @@ struct btf_encoder {
 			  verbose,
 			  force,
 			  gen_floats,
-			  is_rel;
+			  is_rel,
+			  gen_base_ref;
 	uint32_t	  array_index_id;
 	struct {
 		struct var_info *vars;
@@ -1255,9 +1256,9 @@ static int btf_encoder__write_raw_file(struct btf_encoder *encoder)
 	return err;
 }
 
-static int btf_encoder__write_elf(struct btf_encoder *encoder)
+static int btf_encoder__write_elf(struct btf_encoder *encoder, const struct btf *btf,
+				  const char *btf_secname)
 {
-	struct btf *btf = encoder->btf;
 	const char *filename = encoder->filename;
 	GElf_Shdr shdr_mem, *shdr;
 	Elf_Data *btf_data = NULL;
@@ -1297,7 +1298,7 @@ static int btf_encoder__write_elf(struct btf_encoder *encoder)
 		if (shdr == NULL)
 			continue;
 		char *secname = elf_strptr(elf, strndx, shdr->sh_name);
-		if (strcmp(secname, ".BTF") == 0) {
+		if (strcmp(secname, btf_secname) == 0) {
 			btf_data = elf_getdata(scn, btf_data);
 			break;
 		}
@@ -1341,11 +1342,11 @@ static int btf_encoder__write_elf(struct btf_encoder *encoder)
 			goto unlink;
 		}
 
-		snprintf(cmd, sizeof(cmd), "%s --add-section .BTF=%s %s",
-			 llvm_objcopy, tmp_fn, filename);
+		snprintf(cmd, sizeof(cmd), "%s --add-section %s=%s %s",
+			 llvm_objcopy, btf_secname, tmp_fn, filename);
 		if (system(cmd)) {
-			fprintf(stderr, "%s: failed to add .BTF section to '%s': %d!\n",
-				__func__, filename, errno);
+			fprintf(stderr, "%s: failed to add %s section to '%s': %d!\n",
+				__func__, btf_secname, filename, errno);
 			goto unlink;
 		}
 
@@ -1380,12 +1381,27 @@ int btf_encoder__encode(struct btf_encoder *encoder)
 		fprintf(stderr, "%s: btf__dedup failed!\n", __func__);
 		return -1;
 	}
-
-	if (encoder->raw_output)
+	if (encoder->raw_output) {
 		err = btf_encoder__write_raw_file(encoder);
-	else
-		err = btf_encoder__write_elf(encoder);
-
+	} else {
+		struct btf *btf = encoder->btf;
+
+		if (encoder->gen_base_ref) {
+			btf = btf__new_split_base_ref(encoder->btf);
+			if (!btf) {
+				fprintf(stderr, "could not generate base reference split BTF: %s\n",
+					strerror(errno));
+				return -1;
+			}
+		}
+		err = btf_encoder__write_elf(encoder, btf, BTF_ELF_SEC);
+		if (!err && encoder->gen_base_ref)
+			err = btf_encoder__write_elf(encoder, btf__base_btf(btf), BTF_BASE_REF_ELF_SEC);
+		if (btf != encoder->btf) {
+			btf__free((struct btf *)btf__base_btf(btf));
+			btf__free(btf);
+		}
+	}
 	return err;
 }
 
@@ -1659,6 +1675,7 @@ struct btf_encoder *btf_encoder__new(struct cu *cu, const char *detached_filenam
 		encoder->force		 = conf_load->btf_encode_force;
 		encoder->gen_floats	 = conf_load->btf_gen_floats;
 		encoder->skip_encoding_vars = conf_load->skip_encoding_btf_vars;
+		encoder->gen_base_ref = conf_load->btf_gen_base_ref;
 		encoder->verbose	 = verbose;
 		encoder->has_index_type  = false;
 		encoder->need_index_type = false;
diff --git a/dwarves.h b/dwarves.h
index be0e29a..ad01979 100644
--- a/dwarves.h
+++ b/dwarves.h
@@ -87,6 +87,7 @@ struct conf_load {
 	bool			skip_encoding_btf_vars;
 	bool			btf_gen_floats;
 	bool			btf_encode_force;
+	bool			btf_gen_base_ref;
 	uint8_t			hashtable_bits;
 	uint8_t			max_hashtable_bits;
 	uint16_t		kabi_prefix_len;
diff --git a/pahole.c b/pahole.c
index 0b9c2de..965285d 100644
--- a/pahole.c
+++ b/pahole.c
@@ -1264,23 +1264,25 @@ ARGP_PROGRAM_VERSION_HOOK_DEF = dwarves_print_version;
  * BTF encoding apply; we encode type/decl tags, do not encode
  * floats, etc.  This ensures backwards compatibility.
  */
-#define BTF_FEATURE(name, alias, default_value)			\
-	{ #name, #alias, &conf_load.alias, default_value }
+#define BTF_FEATURE(name, alias, default_value, enable_for_all)		\
+	{ #name, #alias, &conf_load.alias, default_value, enable_for_all }
 
 struct btf_feature {
 	const char      *name;
 	const char      *option_alias;
 	bool		*conf_value;
 	bool		default_value;
+	bool		enable_for_all;
 } btf_features[] = {
-	BTF_FEATURE(encode_force, btf_encode_force, false),
-	BTF_FEATURE(var, skip_encoding_btf_vars, true),
-	BTF_FEATURE(float, btf_gen_floats, false),
-	BTF_FEATURE(decl_tag, skip_encoding_btf_decl_tag, true),
-	BTF_FEATURE(type_tag, skip_encoding_btf_type_tag, true),
-	BTF_FEATURE(enum64, skip_encoding_btf_enum64, true),
-	BTF_FEATURE(optimized_func, btf_gen_optimized, false),
-	BTF_FEATURE(consistent_func, skip_encoding_btf_inconsistent_proto, false),
+	BTF_FEATURE(encode_force, btf_encode_force, false, true),
+	BTF_FEATURE(var, skip_encoding_btf_vars, true, true),
+	BTF_FEATURE(float, btf_gen_floats, false, true),
+	BTF_FEATURE(decl_tag, skip_encoding_btf_decl_tag, true, true),
+	BTF_FEATURE(type_tag, skip_encoding_btf_type_tag, true, true),
+	BTF_FEATURE(enum64, skip_encoding_btf_enum64, true, true),
+	BTF_FEATURE(optimized_func, btf_gen_optimized, false, true),
+	BTF_FEATURE(consistent_func, skip_encoding_btf_inconsistent_proto, false, true),
+	BTF_FEATURE(base_ref, btf_gen_base_ref, false, false),
 };
 
 #define BTF_MAX_FEATURE_STR	1024
@@ -1348,8 +1350,10 @@ static void parse_btf_features(const char *features, bool strict)
 	if (strcmp(features, "all") == 0) {
 		int i;
 
-		for (i = 0; i < ARRAY_SIZE(btf_features); i++)
-			enable_btf_feature(&btf_features[i]);
+		for (i = 0; i < ARRAY_SIZE(btf_features); i++) {
+			if (btf_features[i].enable_for_all)
+				enable_btf_feature(&btf_features[i]);
+		}
 		return;
 	}
 
-- 
2.39.3

