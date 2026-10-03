Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA70021D3F5;
	Sat,  3 Oct 2026 19:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791056661; cv=none; b=oqcO8v3eDlUaAVGeSIyXzdONqd9+2ZFElBzocm41qFxBD3uBatYNNfNJaov5CDv6SXAu89nOWQuwp9bBtMwiGNpoIJE+ia/h/3X7exEluvlcfnphJ/n84/28M2OKVQfDhsy44ocjv0yqaCvLDUykQhLd+cMHP+kpnz8/W465Zus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791056661; c=relaxed/simple;
	bh=lX+2IxlL3qKz1+X/IJxPpFfOwZeUY+YZ3ifTWfaFvNk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bAD0RoHIqhFdtKWw3vx5QxnvlF6jDPj8KNZTubxy9WRGm/v5rQ8FTFvZTcBVw0IAIrSk6T62MlPoF6pYNMuSNXFeQ3flMHSUA4Fy7BO28D5LXCa+RoHZwHtKzrZiOsioWeuIoYf2YpcajaZWTuaxxBtimnsICFeZDYq3KU1FdcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=N+Re8h3P; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="N+Re8h3P"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 693JPUOK1912445;
	Sat, 3 Oct 2026 19:43:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=sCbIe
	iDr/xo0HG2mIXlPVnqOhvQem9l9UOGhlb9RXhU=; b=N+Re8h3P2EyGIpHgQjUnG
	tMmuImVSBSiEYYguEATuTsD8OUr+xHRxcdkRydalFy8lyH7VigLZF3dww777XKQ7
	Y/fz45dkOHetw8s9UJPnjJQG85nwVI3Df2K0U0HXEkyRe5MJR0V+Xm6zD/Y10vS+
	g8c86QfiZXzTe5r2m9ywHRaghxT8fsisMOLzaQoxfyo6JgPxuL/Lb8GmJMDepLfq
	8m5/HpfQYoNMA12kYErfZBmWjubl+3XjfDVM/x+mqytcKJ6dBkABGkjm0SE1G/r+
	LbLMxPMpibvnYx6N3h+Etk79vFazlm7z863zHfbDf5nz2coPz0tRRZMVdOXak3qU
	Q==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4h2sas0dg6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 03 Oct 2026 19:43:55 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 693JZ2VH005084;
	Sat, 3 Oct 2026 19:43:54 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4h2r58yys2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 03 Oct 2026 19:43:53 +0000 (GMT)
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 693JdEN1012617;
	Sat, 3 Oct 2026 19:43:53 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-83-182.vpn.oracle.com [10.154.83.182])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4h2r58yynt-5;
	Sat, 03 Oct 2026 19:43:52 +0000 (GMT)
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
Subject: [PATCH v3 bpf-next 4/7] btf: Preserve string relocation maps for split BTF
Date: Sat,  3 Oct 2026 20:43:20 +0100
Message-ID: <20261003194323.817885-5-alan.maguire@oracle.com>
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
X-Proofpoint-ORIG-GUID: jlestikieNL6c4mxs_6w1XKTO4CTpKqZ
X-Authority-Analysis: v=2.4 cv=RIMmjIi+ c=1 sm=1 tr=0 ts=6ac15afb cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=3I1J8UUJPc9JN9BFgKH3:22 a=yPCof4ZbAAAA:8 a=WqRZOxPutuYdU_N9530A:9
X-Proofpoint-GUID: jlestikieNL6c4mxs_6w1XKTO4CTpKqZ
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAzMDA3OCBTYWx0ZWRfX7wUJepxoJ/r2
 7/GJimz7oxtitn5vy+Y8uyaoLerBcFSi0IvBnfm3ns1r5+SRDRSrn0jGdVwu2p5TaCcVlC6U6AE
 6bmccnrvUtMAu8Epa6WGJmeCasPSAazvd3HDvKWvxKi5USUdLpJz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAzMDA3OCBTYWx0ZWRfX5CfvsyI9TFYg
 xACq6ED/8A4jrQcs+y3e7X1D9cRatTNZbb5lRlQWf1srhWtav73//lspwyxe2mD7Bw/GzCWbOU1
 QIqTHsGiko9ysp2WYrLY8GI0ggb8DzkheENBATDRbh5xmahU6m/KNA/Z0yYmCAZa/mnToouyX++
 l4kTT/FYP2I+0gQVjYZWnWe7OzozbExk24CvGSz23qrQLHyi2yBNg1aXL4FGv5BE/4LSiRVFS0N
 G4+qfaVUpzW+KS4jVSr7yTTS9XcdWT+fjFSgxhN7XehMln38+qcJQiUYf8VliN9AnPw86XxFgzY
 v/pezTxNYpVzVg5q8ACsJLk1LcoWb1QDxkiIaQPhsqrEfGyP5MN0qJAVj4sZxoYWt/q/AabyM/5
 TGuoDEgR342nNJahqfE+GmAk/QFcyRNglSw2/Pk4ffVtJK++elJPeOwawsaO96eUZ57MiGCI15T
 wFjmO0jnp/CaXI6fFYA==

Make btf_relocate() optionally return the string-offset map it builds
while relocating a BTF relative to a distilled base. A subsequent split
BTF object can use that map to rebase references to base strings.

Also account for the accumulated base string offset when assigning a
new BTF base. This is required when the base is itself split.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
Assisted-by: OpenAI Codex (GPT-5.6)
---
 include/linux/btf.h             | 5 +++--
 kernel/bpf/btf.c                | 4 ++--
 tools/lib/bpf/btf.c             | 2 +-
 tools/lib/bpf/btf_relocate.c    | 7 ++++++-
 tools/lib/bpf/libbpf_internal.h | 3 ++-
 5 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/include/linux/btf.h b/include/linux/btf.h
index f731c7a5f14c..b66e20a18c54 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -608,7 +608,8 @@ struct btf_field_iter {
 #ifdef CONFIG_BPF_SYSCALL
 const struct btf_type *btf_type_by_id(const struct btf *btf, u32 type_id);
 void btf_set_base_btf(struct btf *btf, const struct btf *base_btf);
-int btf_relocate(struct btf *btf, const struct btf *base_btf, __u32 **map_ids);
+int btf_relocate(struct btf *btf, const struct btf *base_btf, __u32 **map_ids,
+		 __u32 **map_strs);
 int btf_field_iter_init(struct btf_field_iter *it, struct btf_type *t,
 			enum btf_field_iter_kind iter_kind);
 __u32 *btf_field_iter_next(struct btf_field_iter *it);
@@ -682,7 +683,7 @@ static inline void btf_set_base_btf(struct btf *btf, const struct btf *base_btf)
 }
 
 static inline int btf_relocate(void *log, struct btf *btf, const struct btf *base_btf,
-			       __u32 **map_ids)
+			       __u32 **map_ids, __u32 **map_strs)
 {
 	return -EOPNOTSUPP;
 }
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 7aef2d662263..4242e00a3f7e 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -1945,7 +1945,7 @@ void btf_set_base_btf(struct btf *btf, const struct btf *base_btf)
 {
 	btf->base_btf = (struct btf *)base_btf;
 	btf->start_id = btf_nr_types(base_btf);
-	btf->start_str_off = base_btf->hdr.str_len;
+	btf->start_str_off = base_btf->start_str_off + base_btf->hdr.str_len;
 }
 
 static int env_resolve_init(struct btf_verifier_env *env)
@@ -6984,7 +6984,7 @@ static struct btf *btf_parse_module(const char *module_name, const void *data,
 		goto errout;
 
 	if (base_btf != vmlinux_btf) {
-		err = btf_relocate(btf, vmlinux_btf, &btf->base_id_map);
+		err = btf_relocate(btf, vmlinux_btf, &btf->base_id_map, NULL);
 		if (err)
 			goto errout;
 		btf_free(base_btf);
diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index 512b3962f75f..d2ff6f5d6d5b 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -6640,7 +6640,7 @@ void btf_set_base_btf(struct btf *btf, const struct btf *base_btf)
 
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
index 546f65b95cf4..4e45dfacb548 100644
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

