Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE613F8703
	for <bpf@vger.kernel.org>; Fri, 15 May 2026 16:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778863303; cv=none; b=Ow7ZnOPH8/5lKX/jYwejMY/7juPsZi7+zyRJSQ7VuJZArgoNCPszVqG09fggoSusVdGxyqsNRYADqV7qWOmUKAdEiGgBMlGE9dVTfDw6q3EScwtVZEFuoffl9RKmZZTELKuJzfYGwPYstIxSucOkWXeukbw/xqnBdqMmO67saGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778863303; c=relaxed/simple;
	bh=Ipjgw9wkUjdT1QJaAiv8GEHjtmFa0RuplGAz1gJOw38=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YyZh/Pav0WE3P52AprpHbLXxwdjpUim/9RIxgVOMUrmZsPwDJEZnJH1aivd+JKc6PbYFY+vHS/2o8EAYh24/YtpymKWINspJGhrqHu4+C/KcMmiCVuBXCfOEGyREc6AULH1UAHMAbK5AnRb/Ki7N3ok6ocWZewfxY/do/YROla0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GoVXPbwd; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GoVXPbwd"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-44a5174670eso5289950f8f.1
        for <bpf@vger.kernel.org>; Fri, 15 May 2026 09:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778863299; x=1779468099; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MdFCjEy8biK7whdFbIIbtvUjS/1FT/VL0LkBBDVBKUg=;
        b=GoVXPbwd1CB54af1VZwlY++gdKcwYBiJwx7+63uh5sEsFU5A7fEnZPhFgkW8daOQzt
         Q+gIidYYUKbVm6EYdeHS5+Owe8qBYZnvGWm8Y+BzKfzCYT8d3zyMedkbIoxghTRvXOOE
         TccQbj1Ywee290Cyh4ct9Xs0vcRjPa+/ZaEcnQZCzBdwKoENMFQQpeI9YX/pqpuJe40o
         p6KqQdiTvPSdqZ/sdUymjVPoU6WEwOqVXhFTaNmkwj6EbfSRxr8837laBXR3OWgLfXNN
         O9P1BvvHdnfaZp8+75x6ByRoovMCHpoId4TcvGG2X7azt/zeISnb3lObUGHLzQgNtMD/
         dLLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778863299; x=1779468099;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MdFCjEy8biK7whdFbIIbtvUjS/1FT/VL0LkBBDVBKUg=;
        b=tW+th1eg66hxu10QAJhLfCoDb5k9uHoXFHpM0fq3iiw75TU/tGz1mDv8gzInJeViqs
         Oy8Ov7nuao9r47Wp6bXZ8tR3uP8AoqI/cesoLVrOC6GgES5f/niWWjOVRz47V5M7Jm5r
         bEN+uEtzErsUYiJDqwI9UvWHhfPCIZyo8HbOgrIG6Kw1LjFc/ONbk8k4BBDgn0weMGsR
         jGDILViISVifugPtIY4hW0CiKST9EGCSDjI1K5SYckkZjLh/Un+UsBn/+CinX/gzIZGv
         zbNWJxWIILe/z9tZ9OF3YYNeA8ZaB6jfLP9axs6S+ivetW7nxMa8QF4V7JVWBoPFYr+6
         ifVA==
X-Gm-Message-State: AOJu0Ywex2riNW3qpx0dZhxzvRIFjIC4pW50E9/HhpNQDmbX8rasMUur
	6ozmDBeN61Kx7alzeE3Y4EH9Vun1BOdMDgyvJiMAq+EMF7GgdbcX5aIBT1I4nqLi
X-Gm-Gg: Acq92OG6vm5WyQfmvQJme75/fk0kRj09GYraVvU3FvndiIjwLCL6N5yB5YL5/pcdEAj
	Q3n4TKEtxe/SZRN0/KiexClpNtnGADdmjeIV5CUeRfB63WxsDkG8Nk7Uj2ome5yiAr4nJAM6Bfh
	yHokqEBVQwAwh8HD+Q5Cat/2cgKS81Spdjhg8KI2XICVlhl25kWuJjqdRmBQJSe//QhXan9ro1o
	6Xb2t2yYIofy3wrl7RpyPeDfy4sini61g+ijXgIMRjtCYjMwFlwF8sUh11l0Kdx7zBuroTLWRVR
	066iCVUUTMOZSYArv7vLVbDyHOdv8HfRwhczTdqENQu+iMcHNcdS77XuYB4ZTmxDgs3fWC12jci
	hEVa4Zdwy39FKiFIE9dBhc+pFuAk/Hb16+pZLda+LkYFc2iB/4/cvEi0BXHfPYgxivLP6LlKUrM
	KZm7dPz1Q5RKjsOQ==
X-Received: by 2002:a5d:5850:0:b0:44d:1338:46b4 with SMTP id ffacd0b85a97d-45e5c58fb66mr6559177f8f.9.1778863298738;
        Fri, 15 May 2026 09:41:38 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:74::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45d9ed2f738sm15722635f8f.16.2026.05.15.09.41.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 09:41:38 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Fri, 15 May 2026 09:41:03 -0700
Subject: [PATCH bpf-next 3/3] selftests/bpf: Add test for tracepoint
 btf_ids tracefs file
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260515-generic_tracepoint-v1-3-aa619fa94132@meta.com>
References: <20260515-generic_tracepoint-v1-0-aa619fa94132@meta.com>
In-Reply-To: <20260515-generic_tracepoint-v1-0-aa619fa94132@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 eddyz87@gmail.com, memxor@gmail.com, peterz@infradead.org, 
 rostedt@goodmis.org
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778863293; l=4780;
 i=yatsenko@meta.com; s=20260324; h=from:subject:message-id;
 bh=6UVSI/QyQvHved++RBWOTRFTQSo5Q4yVKDQt9agbtUI=;
 b=0a+wGYl7X2ngld0qePjokGK/W3zFPq/7+xK/lehQnnPWoEMKxBDMnNLhg7KT5SQYUrcFNtmOT
 uNshC7w2d6iBJ5ZohyVG9Oqs/0LaQ6r5z4x3sA4uMsoZtUX0ctmLd2r
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
 .../testing/selftests/bpf/prog_tests/tp_btf_ids.c  | 124 +++++++++++++++++++++
 1 file changed, 124 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/tp_btf_ids.c b/tools/testing/selftests/bpf/prog_tests/tp_btf_ids.c
new file mode 100644
index 000000000000..7a893ae523e0
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/tp_btf_ids.c
@@ -0,0 +1,124 @@
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
+	ASSERT_EQ(btf_vlen(proto_t), 3, "func_proto arg count");
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

