Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2A0B3B4EA4;
	Sat, 27 Jun 2026 14:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782571984; cv=none; b=U3mvIdnt0mxA5p67Irj/d8CVZXRSKfYjgp77NWMAKMhvwffOcpuGuB7lm/IeMFctzaJnxQkRiOASvm7zoOfwtAev6QZrMSI4cLrrR/3KMRTchpGKMHut8t5cn2dVFYa6YBO8f3lsClSSW6xBWrOMgwNl43/AW9ca1c62vfEk4zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782571984; c=relaxed/simple;
	bh=vRhbzhTQGmpkEvUopB6nUTPratHi5g3QJBXw7jQ2WMM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YFfAG3V1dYF4lVTeyhvKW+s7U09O8J8QnHP2E8pt2OnmGgm/JrRFFKEUh0mE5PX9AgFxiubx3HUOijki2GFFLocZxFIK70ePJkVo7AoOonEdP8ZbexxWk3Y+O2HUAeUVMYZszKG3Aaj6AInWx2HguuRJVvDz5crW+HNFHdlo4BU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4gnbB35gcRzKHMPQ;
	Sat, 27 Jun 2026 22:52:43 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 2386D40570;
	Sat, 27 Jun 2026 22:52:47 +0800 (CST)
Received: from localhost.huawei.com (unknown [10.67.174.243])
	by APP3 (Coremail) with UTF8SMTPA id _Ch0CgAHPCa94z9qh0oVAA--.10903S9;
	Sat, 27 Jun 2026 22:52:47 +0800 (CST)
From: Xu Kuohai <xukuohai@huaweicloud.com>
To: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	KP Singh <kpsingh@kernel.org>,
	Anton Protopopov <a.s.protopopov@gmail.com>,
	Amery Hung <ameryhung@gmail.com>,
	Eyal Birger <eyal.birger@gmail.com>,
	Rong Tao <rongtao@cestc.cn>
Subject: [RFC PATCH bpf-next 07/12] bpf: Record probe name in SDT map
Date: Sat, 27 Jun 2026 22:51:41 +0000
Message-ID: <43eaa2bc686c9f8309d37b96f15646eaa9e51899.1782571533.git.xukuohai@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1782571533.git.xukuohai@huawei.com>
References: <cover.1782571533.git.xukuohai@huawei.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgAHPCa94z9qh0oVAA--.10903S9
X-Coremail-Antispam: 1UD129KBjvJXoWxGryrurWfAr45JFy3trW3Awb_yoW5tw4xpF
	s5Cr1xCF4UXF47Zr95GayF93y5Wr4q9F1UKayqq3yUZFy2qas5XF4IgF4ayF13Xw4qyw1x
	XF4Y9rWrK34xZr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmKb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M280x2IEY4vEnII2IxkI6r1a6r45M2
	8IrcIa0xkI8VA2jI8067AKxVWUAVCq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAv
	FVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJw
	A2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE
	3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr2
	1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv
	67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7
	CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E
	4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGV
	WUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_
	JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1lIxAIcVCF04k26cxKx2IYs7
	xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j
	6F4UJbIYCTnIWIevJa73UjIFyTuYvjxUIJ5rDUUUU
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

From: Xu Kuohai <xukuohai@huawei.com>

When an SDT observer program is loaded, kernel needs to know the target
program and the target probe site. As user specifies probe site by probe
name, record probe name in SDT map for kernel to find the probe.

The max probe name length is set to 64. Programs with probe name longer
than 64 will be denied by libbpf.

Assisted-by: OpenCode:GLM-5.2
Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
---
 include/uapi/linux/bpf.h       | 2 ++
 kernel/bpf/bpf_insn_array.c    | 2 ++
 tools/include/uapi/linux/bpf.h | 2 ++
 tools/lib/bpf/libbpf.c         | 7 +++++++
 4 files changed, 13 insertions(+)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 773a7def0fbd..95ca41bf7501 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1521,6 +1521,7 @@ struct bpf_common_attr {
 };
 
 #define BPF_OBJ_NAME_LEN 16U
+#define BPF_SDT_MAX_NAME_LEN 64
 
 enum {
 	BPF_STREAM_STDOUT = 1,
@@ -7743,6 +7744,7 @@ struct bpf_insn_array_value {
 	__u8  nargs;		/* argument count (0..5) */
 	__u8  arg_reg[5];	/* BPF register for each argument */
 	__u8  pad[2];
+	char  name[BPF_SDT_MAX_NAME_LEN]; /* probe name */
 };
 
 #endif /* _UAPI__LINUX_BPF_H__ */
diff --git a/kernel/bpf/bpf_insn_array.c b/kernel/bpf/bpf_insn_array.c
index fe30b08712ff..a9564ef4b2ef 100644
--- a/kernel/bpf/bpf_insn_array.c
+++ b/kernel/bpf/bpf_insn_array.c
@@ -3,6 +3,7 @@
 
 #include <linux/bpf.h>
 #include <linux/bpf_verifier.h>
+#include <linux/string.h>
 
 struct bpf_insn_array {
 	struct bpf_map map;
@@ -107,6 +108,7 @@ static long insn_array_update_elem(struct bpf_map *map, void *key, void *value,
 		insn_array->values[index].btf_id = val.btf_id;
 		insn_array->values[index].nargs = val.nargs;
 		memcpy(insn_array->values[index].arg_reg, val.arg_reg, sizeof(val.arg_reg));
+		strscpy(insn_array->values[index].name, val.name, sizeof(val.name));
 	}
 
 	return 0;
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 773a7def0fbd..95ca41bf7501 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -1521,6 +1521,7 @@ struct bpf_common_attr {
 };
 
 #define BPF_OBJ_NAME_LEN 16U
+#define BPF_SDT_MAX_NAME_LEN 64
 
 enum {
 	BPF_STREAM_STDOUT = 1,
@@ -7743,6 +7744,7 @@ struct bpf_insn_array_value {
 	__u8  nargs;		/* argument count (0..5) */
 	__u8  arg_reg[5];	/* BPF register for each argument */
 	__u8  pad[2];
+	char  name[BPF_SDT_MAX_NAME_LEN]; /* probe name */
 };
 
 #endif /* _UAPI__LINUX_BPF_H__ */
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index badac128e8ad..dbc08a193101 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -4146,6 +4146,12 @@ static int bpf_object__collect_sdt_notes(struct bpf_object *obj)
 			err = -ENOMEM;
 			goto out;
 		}
+		if (strlen(e->name) >= BPF_SDT_MAX_NAME_LEN) {
+			pr_warn("sdt: probe name '%s' too long (max %d chars)\n",
+				e->name, BPF_SDT_MAX_NAME_LEN - 1);
+			err = -EINVAL;
+			goto out;
+		}
 		e->sec_idx = sec_idx;
 		e->insn_idx = nop_idx;
 		e->nargs = nargs;
@@ -6843,6 +6849,7 @@ static int bpf_object__create_sdt_maps(struct bpf_object *obj)
 		val.nargs = e->nargs;
 		val.orig_off = e->insn_idx - prog->sec_insn_off;
 		memcpy(val.arg_reg, e->arg_reg, sizeof(val.arg_reg));
+		strncpy(val.name, e->name, sizeof(val.name) - 1);
 
 		err = bpf_map_update_elem(prog->sdt_map_fd, &key, &val, 0);
 		if (err)
-- 
2.47.3

