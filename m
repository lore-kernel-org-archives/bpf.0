Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EAD8265623
	for <bpf@vger.kernel.org>; Mon, 18 May 2026 15:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779117834; cv=none; b=Kjpc/1zrb4TsMJDpstX3idB9U5cixkbfu20a7HsI2CkA8VMaPS9IlYvPkD8+JIsnqJ8p6H2qwf9OuzTfv5kXLsSG3P2d7lkzV35MueAKzTtaxPbYrPXkMNCVVLBxGl+ESSwv22diTAayCf3DC8kLj9/SvLanobyd5E9iygwK/Iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779117834; c=relaxed/simple;
	bh=JWnfkRj7acypCRgQ2P3N5GkPCBgIa6ihDg7aONdlJeU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jG4tSlJ4Bzur5whOY7AcE6yyoNL1cAVp8sAIowhmxncDcee6+JYDHwXtGBP+qOOY2lvQEDzpy/U07EKHgiY0CE0mh9dyK2yCG24WTfDAf5jpkaeisVaxv5Cje5uqPPZUfMXAxMQ0VRpHcHUUCjUktOZ1O98pfw0cG65VwBxru+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KljCT0aC; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KljCT0aC"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-67929ff6dbfso4038215a12.2
        for <bpf@vger.kernel.org>; Mon, 18 May 2026 08:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779117829; x=1779722629; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Jfecon1+FJouMr7NxpfhMU7AiOyZ4t581UhDPjWKcQc=;
        b=KljCT0aCiOfl44C5ptct4fQ9qv4lTB1OO6hhR93P3UhpT4QTIIkquHUGQycE28VkFX
         9VEgyeVj4fN8YbPHgxydD5q1NZyncV8J4V4v5j6hjEq4xyxnd1atnb9jzlwE/Pq/MNg1
         6sJXhKsm4I/Wzcw8gV45Y4S+UXrr7C4xJdkdqD9Nj/KI1cSVFf4NfW2hoA0XMi+iERVO
         jeCBoZ2hgiTZuBMwPCzm5qJNQKtJmnEjoz4OSjLJ0BrqgapLzChyxzZmpxvLyN5w432a
         hNCPNSnnqik+4xwgPUNSlnFp1mdgQISScCK57W6G69TpWtOHNM35Il9ubSr/9lm2tAh4
         cKtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779117829; x=1779722629;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Jfecon1+FJouMr7NxpfhMU7AiOyZ4t581UhDPjWKcQc=;
        b=g4h867hH9o3V21YbVeHcKD3LzwH36MCiSQxLRSEy3z+6BXlhe4nqUCojXFzt5nr71Q
         wFBkgsGWbxW4yAysk/SszjrV+CMeIcMs+nkV5JJRsHFAvkJ38jRZ3YycEDId+p4KnDQX
         +6bChuPDA//sURuBn8lv5CdWI9iKplmy0mo9LAEWizBJTxmsHkjI/kJe9QOBvnzDM24f
         9Y6WSqNxIJvyKAT2zMxLGvei6pXnCoTBLiHwyc8ubkVw6mJd8dqprPPngADn1awjW8cZ
         b7Tf7vOCXfcYFAUMHJNCc/7I61zNrFngCneZ4vyPh1KcjXBscVyxQWzVwsMDslQnrDaG
         x9+Q==
X-Gm-Message-State: AOJu0YzNCsknqvIeZ4ORGuRpqp29KA49GBAPBYgnGE9m36VmUSzZfnXL
	QAF0OFfnYcdopKy787TMix7T1FZai+5bgXDxUSzVlrZHEfg591FrdQPV
X-Gm-Gg: Acq92OFGh+cewdTXbZhjNSd5h6o6iDO/TBuN4uuuvMJdQiYy/34ggBV/plb0aVDM6dp
	OVpYyncGjEJ5HXoWwmCo0yI/123qc0/JYUBUSMzFQtGMcjsKD19sEArlnXs0m0XSdzp27XVFPmG
	9rT2+Mw130kgJJ+nzRS0WcIyWWrTI3vH1NhxzW3NapgFrVzs5kFGQ95bG6pVZE7ODNk+kpgElzM
	qSKymVQMu0XsP6pk9Q0ekv9X65ltdmgYGzxNVg63JJ3JVJWcfRciJUgBeCK7VTYjgaUPjtiim58
	ve2N7XblWWdI4o0buWxv2/E9PpzzwDbILya23EtoQCVq/mP0UUA0RfT7+BHsbKuV7uvRvxZCNRq
	OrTP0Jw6kpTaa3CqzrmZIIVPx31r8BpSgTC9p9pjR01r9/spH2P6Wcg9uAAHPhcD/dWThCCkfs1
	3KcfPzdHeuc20qfQ==
X-Received: by 2002:a05:6402:1945:b0:67c:a6d1:c48b with SMTP id 4fb4d7f45d1cf-683bc8ac76dmr7075011a12.11.1779117829305;
        Mon, 18 May 2026 08:23:49 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:45::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-68310d510fasm5402669a12.11.2026.05.18.08.23.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 08:23:48 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Mon, 18 May 2026 08:23:17 -0700
Subject: [PATCH bpf-next v2 3/3] selftests/bpf: Add test for tracepoint
 btf_ids tracefs file
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260518-generic_tracepoint-v2-3-b755a5cf67bb@meta.com>
References: <20260518-generic_tracepoint-v2-0-b755a5cf67bb@meta.com>
In-Reply-To: <20260518-generic_tracepoint-v2-0-b755a5cf67bb@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 eddyz87@gmail.com, memxor@gmail.com, rostedt@goodmis.org
Cc: Mykyta Yatsenko <yatsenko@meta.com>, linux-trace-kernel@vger.kernel.org
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779117822; l=4942;
 i=yatsenko@meta.com; s=20260324; h=from:subject:message-id;
 bh=vclZkPuWenN7wMDirKYWTTYHLEsDjraiMxch1UNCmV8=;
 b=bshb2F7IT4OVbQohWyRg8xxKOs0RG79TDSCfWA4ZFmVAyV1gpgVor1q28xCF7iU8MgeL13zv9
 LgKbsv1FatjAW5YKc8PZ8ln9KEt8fRh9Ra2RKg+LQasa9bumsHOT5g7
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=1zCUBXUa66KmzfjNsG8YNlMj2ckPdqBPvFq2ww3/YaA=

From: Mykyta Yatsenko <yatsenko@meta.com>

Read events/bpf_testmod/bpf_testmod_test_read/btf_ids and verify the
exported FUNC_PROTO matches the testmod tracepoint signature
(__data, struct task_struct *task, struct bpf_testmod_test_read_ctx
*ctx) and the record struct trace_event_raw_bpf_testmod_test_read
carries the fields declared by TP_STRUCT__entry.

Use the testmod tracepoint so the test exercises the module/split-BTF
path (btf_relocate_id) rather than vmlinux only, and falls back from
/sys/kernel/tracing to /sys/kernel/debug/tracing when tracefs is not
mounted at the new location.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 .../testing/selftests/bpf/prog_tests/tp_btf_ids.c  | 132 +++++++++++++++++++++
 1 file changed, 132 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/tp_btf_ids.c b/tools/testing/selftests/bpf/prog_tests/tp_btf_ids.c
new file mode 100644
index 000000000000..c0e7e11e71b8
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/tp_btf_ids.c
@@ -0,0 +1,132 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <test_progs.h>
+#include <bpf/btf.h>
+
+#define TRACEFS		"/sys/kernel/tracing"
+#define DEBUGFS_TRACING	"/sys/kernel/debug/tracing"
+#define EVENT_SUBPATH	"events/bpf_testmod/bpf_testmod_test_read/btf_ids"
+
+struct btf_ids_info {
+	__u32 obj_id;
+	__u32 raw_id;
+	__u32 tp_id;
+};
+
+static const char *btf_ids_path(char *buf, size_t sz)
+{
+	if (access(TRACEFS "/trace", F_OK) == 0)
+		snprintf(buf, sz, "%s/%s", TRACEFS, EVENT_SUBPATH);
+	else
+		snprintf(buf, sz, "%s/%s", DEBUGFS_TRACING, EVENT_SUBPATH);
+	return buf;
+}
+
+static int read_btf_ids(struct btf_ids_info *info)
+{
+	char path[256], buf[256];
+	int fd, n;
+
+	fd = open(btf_ids_path(path, sizeof(path)), O_RDONLY);
+	if (fd < 0)
+		return -errno;
+
+	n = read(fd, buf, sizeof(buf) - 1);
+	close(fd);
+	if (n <= 0)
+		return -EIO;
+	buf[n] = '\0';
+
+	if (sscanf(buf,
+		   "btf_obj_id: %u\nraw_btf_id: %u\ntp_btf_id: %u\n",
+		   &info->obj_id, &info->raw_id, &info->tp_id) != 3)
+		return -EINVAL;
+	return 0;
+}
+
+static const char *param_name(struct btf *btf, const struct btf_param *p)
+{
+	return btf__name_by_offset(btf, p->name_off);
+}
+
+static const char *member_name(struct btf *btf, const struct btf_member *m)
+{
+	return btf__name_by_offset(btf, m->name_off);
+}
+
+void test_tp_btf_ids(void)
+{
+	const struct btf_type *proto_t, *rec_t;
+	const struct btf_param *params;
+	const struct btf_member *members;
+	struct btf_ids_info info;
+	struct btf *vmlinux_btf, *btf;
+	const char *name;
+	int err;
+
+	if (!env.has_testmod) {
+		test__skip();
+		return;
+	}
+
+	err = read_btf_ids(&info);
+	if (!ASSERT_OK(err, "read btf_ids"))
+		return;
+
+	ASSERT_GT(info.obj_id, 0, "obj_id non-zero");
+	ASSERT_GT(info.raw_id, 0, "raw_id non-zero");
+	ASSERT_GT(info.tp_id, 0, "tp_id non-zero");
+
+	vmlinux_btf = btf__load_vmlinux_btf();
+	if (!ASSERT_OK_PTR(vmlinux_btf, "load vmlinux BTF"))
+		return;
+
+	/* Module BTF is split BTF; load with vmlinux as base. */
+	btf = btf__load_from_kernel_by_id_split(info.obj_id, vmlinux_btf);
+	if (!ASSERT_OK_PTR(btf, "load module BTF")) {
+		btf__free(vmlinux_btf);
+		return;
+	}
+
+	/*
+	 * raw_btf_id should be the FUNC_PROTO of __bpf_trace_<call>:
+	 *   void *__data, struct task_struct *task,
+	 *   struct bpf_testmod_test_read_ctx *ctx
+	 */
+	proto_t = btf__type_by_id(btf, info.raw_id);
+	if (!ASSERT_OK_PTR(proto_t, "raw type_by_id"))
+		goto out;
+	if (!ASSERT_TRUE(btf_is_func_proto(proto_t), "raw is FUNC_PROTO"))
+		goto out;
+	if (!ASSERT_EQ(btf_vlen(proto_t), 3, "func_proto arg count"))
+		goto out;
+
+	params = btf_params(proto_t);
+	ASSERT_STREQ(param_name(btf, &params[0]), "__data", "arg0 name");
+	ASSERT_STREQ(param_name(btf, &params[1]), "task", "arg1 name");
+	ASSERT_STREQ(param_name(btf, &params[2]), "ctx", "arg2 name");
+
+	/*
+	 * tp_btf_id should be STRUCT trace_event_raw_<call> with the
+	 * fields declared by TP_STRUCT__entry plus the common header.
+	 */
+	rec_t = btf__type_by_id(btf, info.tp_id);
+	if (!ASSERT_OK_PTR(rec_t, "tp type_by_id"))
+		goto out;
+	if (!ASSERT_TRUE(btf_is_struct(rec_t), "tp is STRUCT"))
+		goto out;
+	name = btf__name_by_offset(btf, rec_t->name_off);
+	ASSERT_STREQ(name, "trace_event_raw_bpf_testmod_test_read",
+		     "tp struct name");
+	if (!ASSERT_GE(btf_vlen(rec_t), 5, "tp struct field count"))
+		goto out;
+
+	members = btf_members(rec_t);
+	ASSERT_STREQ(member_name(btf, &members[0]), "ent", "field0 name");
+	ASSERT_STREQ(member_name(btf, &members[1]), "pid", "field1 name");
+	ASSERT_STREQ(member_name(btf, &members[2]), "comm", "field2 name");
+	ASSERT_STREQ(member_name(btf, &members[3]), "off", "field3 name");
+	ASSERT_STREQ(member_name(btf, &members[4]), "len", "field4 name");
+out:
+	btf__free(btf);
+	btf__free(vmlinux_btf);
+}

-- 
2.53.0-Meta

