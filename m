Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6BE93AE193;
	Sat, 27 Jun 2026 14:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782571974; cv=none; b=QTMW8guFHvb7VxSAhVCc2ITxdgHyLJE8axoYfkmllTsmDo+btG4zx39jL32eG6TkduqI9BjuniqDgsa5GlB8dWk4dw2M5a8QKLBNxAKwhWOxX79iDwzP5rwJQBw1m42egzCt+6dXQPFLkvlpx+KcsfFIlu8VMpCctKO5cF5370w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782571974; c=relaxed/simple;
	bh=D7PIKPgBLkeGljrx+zAKQVv+HQLpJcgZ3c+P/oTieUI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PA5R4A5rbsR6c3K0Kp+/vc3UPtkGsQ3JukEDN+gzFBLrSt6t2xNd1iARm5XLNqO8NfyLc4LxbaJHEOkLQ+KNCu0aUx5vaM4aXmpVYy/NcsDapgtDMWJxtjv2R/dfc6ywqv8ZKXJAtUYd2lljxEqe3z8fWGfN5otOhIpQFbi18tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4gnb9C2x1czYQtkw;
	Sat, 27 Jun 2026 22:51:59 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 35050408F6;
	Sat, 27 Jun 2026 22:52:47 +0800 (CST)
Received: from localhost.huawei.com (unknown [10.67.174.243])
	by APP3 (Coremail) with UTF8SMTPA id _Ch0CgAHPCa94z9qh0oVAA--.10903S10;
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
Subject: [RFC PATCH bpf-next 08/12] libbpf: Add libbpf support to load SDT observer program
Date: Sat, 27 Jun 2026 22:51:42 +0000
Message-ID: <b097ab082dc6cdde03ace4ad53e9e52b567a976d.1782571533.git.xukuohai@huawei.com>
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
X-CM-TRANSID:_Ch0CgAHPCa94z9qh0oVAA--.10903S10
X-Coremail-Antispam: 1UD129KBjvJXoWxtFWUuw4ruFy3tFWkWFy5CFg_yoW3WF15pF
	s0qFWkCF4FqFW3urWkCayF934rCr1kWry2krZxJr4rua1fXw4rWr42kF4akry3XFWDAa1f
	Z3WY9ryDW345ZFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

Add libbpf support to load SDT observer program. To ensure the
verifier can find which probe the observer program is attached,
the target bpf prog fd and probe name are passed to the kernel.
Kernel looks up probe against the target program's SDT map using
the probe name.

Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
---
 include/uapi/linux/bpf.h       |  7 +++++++
 tools/include/uapi/linux/bpf.h |  7 +++++++
 tools/lib/bpf/bpf.c            |  9 ++++++++-
 tools/lib/bpf/bpf.h            |  7 ++++++-
 tools/lib/bpf/libbpf.c         | 20 ++++++++++++++++++++
 5 files changed, 48 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 95ca41bf7501..6490eb5dfb68 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1159,6 +1159,7 @@ enum bpf_attach_type {
 	BPF_TRACE_FENTRY_MULTI,
 	BPF_TRACE_FEXIT_MULTI,
 	BPF_TRACE_FSESSION_MULTI,
+	BPF_TRACE_SDT,
 	__MAX_BPF_ATTACH_TYPE
 };
 
@@ -1184,6 +1185,7 @@ enum bpf_link_type {
 	BPF_LINK_TYPE_NETKIT = 13,
 	BPF_LINK_TYPE_SOCKMAP = 14,
 	BPF_LINK_TYPE_TRACING_MULTI = 15,
+	BPF_LINK_TYPE_SDT,
 	__MAX_BPF_LINK_TYPE,
 };
 
@@ -1677,6 +1679,11 @@ union bpf_attr {
 		 * BPF_F_INSN_ARRAY_SDT, used for SDT probe
 		 */
 		__u32		sdt_map_fd;
+		/* Kernel looks up the probe using target prog and probe name */
+		struct {
+			__u32	target_prog_fd;
+			char	name[BPF_SDT_MAX_NAME_LEN]; /* probe name */
+		} sdt;
 	};
 
 	struct { /* anonymous struct used by BPF_OBJ_* commands */
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 95ca41bf7501..6490eb5dfb68 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -1159,6 +1159,7 @@ enum bpf_attach_type {
 	BPF_TRACE_FENTRY_MULTI,
 	BPF_TRACE_FEXIT_MULTI,
 	BPF_TRACE_FSESSION_MULTI,
+	BPF_TRACE_SDT,
 	__MAX_BPF_ATTACH_TYPE
 };
 
@@ -1184,6 +1185,7 @@ enum bpf_link_type {
 	BPF_LINK_TYPE_NETKIT = 13,
 	BPF_LINK_TYPE_SOCKMAP = 14,
 	BPF_LINK_TYPE_TRACING_MULTI = 15,
+	BPF_LINK_TYPE_SDT,
 	__MAX_BPF_LINK_TYPE,
 };
 
@@ -1677,6 +1679,11 @@ union bpf_attr {
 		 * BPF_F_INSN_ARRAY_SDT, used for SDT probe
 		 */
 		__u32		sdt_map_fd;
+		/* Kernel looks up the probe using target prog and probe name */
+		struct {
+			__u32	target_prog_fd;
+			char	name[BPF_SDT_MAX_NAME_LEN]; /* probe name */
+		} sdt;
 	};
 
 	struct { /* anonymous struct used by BPF_OBJ_* commands */
diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index cb006bca97c6..adf951df6a3e 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -295,7 +295,7 @@ int bpf_prog_load(enum bpf_prog_type prog_type,
 		  const struct bpf_insn *insns, size_t insn_cnt,
 		  struct bpf_prog_load_opts *opts)
 {
-	const size_t attr_sz = offsetofend(union bpf_attr, sdt_map_fd);
+	const size_t attr_sz = offsetofend(union bpf_attr, sdt.name);
 	void *finfo = NULL, *linfo = NULL;
 	const char *func_info, *line_info;
 	__u32 log_size, log_level, attach_prog_fd, attach_btf_obj_fd;
@@ -303,6 +303,7 @@ int bpf_prog_load(enum bpf_prog_type prog_type,
 	int fd, attempts;
 	union bpf_attr attr;
 	char *log_buf;
+	const char *sdt_name;
 
 	bump_rlimit_memlock();
 
@@ -370,6 +371,11 @@ int bpf_prog_load(enum bpf_prog_type prog_type,
 	attr.fd_array = ptr_to_u64(OPTS_GET(opts, fd_array, NULL));
 	attr.fd_array_cnt = OPTS_GET(opts, fd_array_cnt, 0);
 	attr.sdt_map_fd = OPTS_GET(opts, sdt_map_fd, 0);
+	attr.sdt.target_prog_fd = OPTS_GET(opts, sdt.target_prog_fd, 0);
+
+	sdt_name = OPTS_GET(opts, sdt.name, NULL);
+	if (sdt_name)
+		snprintf(attr.sdt.name, sizeof(attr.sdt.name), "%s", sdt_name);
 
 	if (log_level) {
 		attr.log_buf = ptr_to_u64(log_buf);
@@ -862,6 +868,7 @@ int bpf_link_create(int prog_fd, int target_fd,
 	case BPF_MODIFY_RETURN:
 	case BPF_TRACE_FSESSION:
 	case BPF_LSM_MAC:
+	case BPF_TRACE_SDT:
 		attr.link_create.tracing.cookie = OPTS_GET(opts, tracing.cookie, 0);
 		if (!OPTS_ZEROED(opts, tracing))
 			return libbpf_err(-EINVAL);
diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
index 88294bb6b120..bf3665789420 100644
--- a/tools/lib/bpf/bpf.h
+++ b/tools/lib/bpf/bpf.h
@@ -130,9 +130,14 @@ struct bpf_prog_load_opts {
 	__u32 fd_array_cnt;
 	/* if set, FD of the program's BPF_MAP_TYPE_INSN_ARRAY SDT map */
 	__u32 sdt_map_fd;
+	/* target program fd and probe name for SDT observer program */
+	struct {
+		__u32 target_prog_fd;
+		const char *name;
+	} sdt;
 	size_t :0;
 };
-#define bpf_prog_load_opts__last_field sdt_map_fd
+#define bpf_prog_load_opts__last_field sdt.name
 
 LIBBPF_API int bpf_prog_load(enum bpf_prog_type prog_type,
 			     const char *prog_name, const char *license,
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index dbc08a193101..273991b80f8f 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -139,6 +139,7 @@ static const char * const attach_type_name[] = {
 	[BPF_TRACE_FENTRY_MULTI]	= "trace_fentry_multi",
 	[BPF_TRACE_FEXIT_MULTI]		= "trace_fexit_multi",
 	[BPF_TRACE_FSESSION_MULTI]	= "trace_fsession_multi",
+	[BPF_TRACE_SDT]			= "trace_sdt",
 };
 
 static const char * const link_type_name[] = {
@@ -158,6 +159,7 @@ static const char * const link_type_name[] = {
 	[BPF_LINK_TYPE_NETKIT]			= "netkit",
 	[BPF_LINK_TYPE_SOCKMAP]			= "sockmap",
 	[BPF_LINK_TYPE_TRACING_MULTI]		= "tracing_multi",
+	[BPF_LINK_TYPE_SDT]			= "sdt",
 };
 
 static const char * const map_type_name[] = {
@@ -507,6 +509,7 @@ struct bpf_program {
 	__u32 attach_btf_obj_fd;
 	__u32 attach_btf_id;
 	__u32 attach_prog_fd;
+	char *sdt_probe_name;
 
 	void *func_info;
 	__u32 func_info_rec_size;
@@ -836,6 +839,7 @@ static void bpf_program__exit(struct bpf_program *prog)
 	zfree(&prog->sec_name);
 	zfree(&prog->insns);
 	zfree(&prog->reloc_desc);
+	zfree(&prog->sdt_probe_name);
 
 	prog->nr_reloc = 0;
 	prog->insns_cnt = 0;
@@ -8451,6 +8455,10 @@ static int bpf_object_load_prog(struct bpf_object *obj, struct bpf_program *prog
 	load_attr.fd_array = obj->fd_array;
 	if (prog->sdt_map_fd >= 0)
 		load_attr.sdt_map_fd = prog->sdt_map_fd;
+	if (prog->expected_attach_type == BPF_TRACE_SDT && prog->sdt_probe_name) {
+		load_attr.sdt.target_prog_fd = prog->attach_prog_fd;
+		load_attr.sdt.name = prog->sdt_probe_name;
+	}
 
 	load_attr.token_fd = obj->token_fd;
 	if (obj->token_fd)
@@ -10587,6 +10595,7 @@ static const struct bpf_sec_def section_defs[] = {
 	SEC_DEF("kretsyscall+",		KPROBE, 0, SEC_NONE, attach_ksyscall),
 	SEC_DEF("usdt+",		KPROBE,	0, SEC_USDT, attach_usdt),
 	SEC_DEF("usdt.s+",		KPROBE,	0, SEC_USDT | SEC_SLEEPABLE, attach_usdt),
+	SEC_DEF("bpf_sdt",		TRACING, BPF_TRACE_SDT, SEC_NONE),
 	SEC_DEF("tc/ingress",		SCHED_CLS, BPF_TCX_INGRESS, SEC_NONE), /* alias for tcx */
 	SEC_DEF("tc/egress",		SCHED_CLS, BPF_TCX_EGRESS, SEC_NONE),  /* alias for tcx */
 	SEC_DEF("tcx/ingress",		SCHED_CLS, BPF_TCX_INGRESS, SEC_NONE),
@@ -15203,6 +15212,17 @@ int bpf_program__set_attach_target(struct bpf_program *prog,
 	if (prog->obj->state >= OBJ_LOADED)
 		return libbpf_err(-EINVAL);
 
+	if (prog->expected_attach_type == BPF_TRACE_SDT) {
+		if (!attach_func_name)
+			return libbpf_err(-EINVAL);
+		free(prog->sdt_probe_name);
+		prog->sdt_probe_name = strdup(attach_func_name);
+		if (!prog->sdt_probe_name)
+			return libbpf_err(-ENOMEM);
+		prog->attach_prog_fd = attach_prog_fd;
+		return 0;
+	}
+
 	if (attach_prog_fd && !attach_func_name) {
 		/* Store attach_prog_fd. The BTF ID will be resolved later during
 		 * the normal object/program load phase.
-- 
2.47.3

