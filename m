Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 503DC356A06
	for <bpf@vger.kernel.org>; Wed, 11 Feb 2026 23:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770853870; cv=none; b=V7zKoOn0b26Y8BaFVnrm1AMSy3qBLifyEQ/alkNZh9WPQKxzWTfbZQLydvcHzBnDYjQO/GLWhMwvzTM3Zy1vWFEDao1Yvl/I42sVVdA+oy2X0fK6MTMIDgLqwRLxd6hob3Btb7hoOEL7B48Mrxop01lZ/Wt94uq7wG9qBMhM424=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770853870; c=relaxed/simple;
	bh=+1KcqupX6etUCLQJk8kuCUWzV1I33Wa2MkghmLrkPWk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KAClAReSTNAwdKbUJxe0XCaq9JY+2H550WEW9Juz3vTfjBy4IXxvhm6bM9FxTsYjOvOyOc+0Icr4ljg1kK9Ilbh2Q+xka1gUhaACqKaFlw84LSx83dRgV0Yd45AjkV6KsM/JfKdq0eJeHMpPnScHAFJ7GQzi3Q6NnPFEH70eBoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--wusamuel.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OMZzWMQt; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wusamuel.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OMZzWMQt"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2ba9f033a5bso7677851eec.0
        for <bpf@vger.kernel.org>; Wed, 11 Feb 2026 15:51:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770853868; x=1771458668; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=K8Hrf36BiZaAs7CHgOxMpyfCjX4AKMisq9UkmecHKPY=;
        b=OMZzWMQtlXTo9suh48PEgAUrIHZGnbjVvMnatpgmEQDWTIuC9r89TBSSYQA5HQ0akl
         mp1u3bLbYzNbJ/2/+bqtxFLq4HgVSMaC+uL0I3t93v9NTtDEVvPRs+S6tZnSbyu06ZG2
         XQKErSPavKzDYhbjHI9QBcu11xwZiubpCkO1A9JwrtbXcRO5oIStNOxSOr1h1nfSm54I
         HJwF3HWZPyFL2yVLRnfLnjWQYTy6V4j9LDKGs0YkoegH1T5/IB1ndCbxwN0amJxULc2Q
         gKuZQCwoJ2ItKzFL/IL9TsrlQ8GWA8Kwm/2OM1dr0/Tlt80O2WoFM4DvzcC6Pxm5gM5z
         3K2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770853868; x=1771458668;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K8Hrf36BiZaAs7CHgOxMpyfCjX4AKMisq9UkmecHKPY=;
        b=UhSmO9vItlFIyoj+Vlh9E2uyW9b4AVP4mZMuSvn6ScNcH58Ti1bNZLrsN7UQV+qSGv
         0R5FEgPK2DQAhO97Vpix13nMkxKyW7UDN4euDT+Y3gX7stf+3pDCwKGhlhHb9zlBjwUI
         6VfF+JH6AdIgyR8SOVU+ZveFJx7tPm5CWYtsMzOIWr5nVrV7+NK1LPulcCOUoa16TB+O
         SlCc7o2U5+Bfd1XWY1V+6zZyPzy5ZipYf0WlVZq4hO6xuiR3iam9xzZjaiB47kDwbVVo
         Y/BRu9aRVRTGhkg/qzTpWIhiS6LNf1XRFWWwkVKSNLm21gr/4lGT4z2sNkoYu/BkNEg5
         inuA==
X-Forwarded-Encrypted: i=1; AJvYcCU8/APhW3v27tv/YtTDt0Qo3TaPArWHgqV94CKE+kV4jqeuOMylZDCjWtA9Ij0UbnPmUio=@vger.kernel.org
X-Gm-Message-State: AOJu0YyG4ghkD6ZA450LUi2EEk4nQ57Loi06DubCjqQSncTB1V8r5q+L
	jJ96+bCCFDGOBYPNMIbONDNHobkLwwq5LE0qfayVx/GDV9HkhJjTEUrGOwnxu6LGijGg2H5xSJW
	a21jlUPhxXaHLpA==
X-Received: from dygf1.prod.google.com ([2002:a05:7300:1341:b0:2b7:880:7a40])
 (user=wusamuel job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:693c:2c15:b0:2ba:a6e5:4ba7 with SMTP id 5a478bee46e88-2baa808cc3dmr436703eec.40.1770853868465;
 Wed, 11 Feb 2026 15:51:08 -0800 (PST)
Date: Wed, 11 Feb 2026 15:50:53 -0800
In-Reply-To: <20260211235055.239024-1-wusamuel@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260211235055.239024-1-wusamuel@google.com>
X-Mailer: git-send-email 2.53.0.273.g2a3d683680-goog
Message-ID: <20260211235055.239024-2-wusamuel@google.com>
Subject: [PATCH bpf-next v4 1/2] bpf: Add wakeup_source iterator
From: Samuel Wu <wusamuel@google.com>
To: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: Samuel Wu <wusamuel@google.com>, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Add a BPF iterator for traversing through wakeup_sources.

Setup iterators to traverse through a SRCUs of wakeup_sources. This is a
more elegant and efficient traversal than going through the options
today, such as at /sys/class/wakeup, or through debugfs.

Signed-off-by: Samuel Wu <wusamuel@google.com>
---
 kernel/bpf/Makefile             |   3 +
 kernel/bpf/wakeup_source_iter.c | 103 ++++++++++++++++++++++++++++++++
 2 files changed, 106 insertions(+)
 create mode 100644 kernel/bpf/wakeup_source_iter.c

diff --git a/kernel/bpf/Makefile b/kernel/bpf/Makefile
index 79cf22860a99..1259373298e1 100644
--- a/kernel/bpf/Makefile
+++ b/kernel/bpf/Makefile
@@ -66,6 +66,9 @@ obj-$(CONFIG_BPF_SYSCALL) += kmem_cache_iter.o
 ifeq ($(CONFIG_DMA_SHARED_BUFFER),y)
 obj-$(CONFIG_BPF_SYSCALL) += dmabuf_iter.o
 endif
+ifeq ($(CONFIG_PM_SLEEP),y)
+obj-$(CONFIG_BPF_SYSCALL) += wakeup_source_iter.o
+endif
 
 CFLAGS_REMOVE_percpu_freelist.o = $(CC_FLAGS_FTRACE)
 CFLAGS_REMOVE_bpf_lru_list.o = $(CC_FLAGS_FTRACE)
diff --git a/kernel/bpf/wakeup_source_iter.c b/kernel/bpf/wakeup_source_iter.c
new file mode 100644
index 000000000000..ab83d212a1f9
--- /dev/null
+++ b/kernel/bpf/wakeup_source_iter.c
@@ -0,0 +1,103 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (c) 2026 Google LLC */
+#include <linux/bpf.h>
+#include <linux/btf_ids.h>
+#include <linux/kernel.h>
+#include <linux/pm_wakeup.h>
+#include <linux/seq_file.h>
+
+struct bpf_iter__wakeup_source {
+	__bpf_md_ptr(struct bpf_iter_meta *, meta);
+	__bpf_md_ptr(struct wakeup_source *, wakeup_source);
+};
+
+static void *wakeup_source_iter_seq_start(struct seq_file *seq, loff_t *pos)
+{
+	int *srcuidx = seq->private;
+	struct wakeup_source *ws;
+	loff_t i;
+
+	*srcuidx = wakeup_sources_read_lock();
+
+	ws = wakeup_sources_walk_start();
+	for (i = 0; ws && i < *pos; i++)
+		ws = wakeup_sources_walk_next(ws);
+
+	return ws;
+}
+
+static void *wakeup_source_iter_seq_next(struct seq_file *seq, void *v, loff_t *pos)
+{
+	struct wakeup_source *ws = v;
+
+	++*pos;
+
+	return wakeup_sources_walk_next(ws);
+}
+
+static void wakeup_source_iter_seq_stop(struct seq_file *seq, void *v)
+{
+	int *srcuidx = seq->private;
+
+	if (*srcuidx >= 0)
+		wakeup_sources_read_unlock(*srcuidx);
+	*srcuidx = -1;
+}
+
+static int __wakeup_source_seq_show(struct seq_file *seq, void *v, bool in_stop)
+{
+	struct bpf_iter_meta meta = {
+		.seq = seq,
+	};
+	struct bpf_iter__wakeup_source ctx = {
+		.meta = &meta,
+		.wakeup_source = v,
+	};
+	struct bpf_prog *prog = bpf_iter_get_info(&meta, in_stop);
+
+	if (prog)
+		return bpf_iter_run_prog(prog, &ctx);
+
+	return 0;
+}
+
+static int wakeup_source_iter_seq_show(struct seq_file *seq, void *v)
+{
+	return __wakeup_source_seq_show(seq, v, false);
+}
+
+static const struct seq_operations wakeup_source_iter_seq_ops = {
+	.start	= wakeup_source_iter_seq_start,
+	.next	= wakeup_source_iter_seq_next,
+	.stop	= wakeup_source_iter_seq_stop,
+	.show	= wakeup_source_iter_seq_show,
+};
+
+static const struct bpf_iter_seq_info wakeup_source_iter_seq_info = {
+	.seq_ops		= &wakeup_source_iter_seq_ops,
+	.seq_priv_size		= sizeof(int),
+};
+
+static struct bpf_iter_reg bpf_wakeup_source_reg_info = {
+	.target			= "wakeup_source",
+	.ctx_arg_info_size	= 1,
+	.ctx_arg_info		= {
+		{
+			offsetof(struct bpf_iter__wakeup_source, wakeup_source),
+			PTR_TO_BTF_ID_OR_NULL
+		},
+	},
+	.seq_info		= &wakeup_source_iter_seq_info,
+};
+
+DEFINE_BPF_ITER_FUNC(wakeup_source, struct bpf_iter_meta *meta,
+		     struct wakeup_source *wakeup_source)
+BTF_ID_LIST_SINGLE(bpf_wakeup_source_btf_id, struct, wakeup_source)
+
+static int __init wakeup_source_iter_init(void)
+{
+	bpf_wakeup_source_reg_info.ctx_arg_info[0].btf_id = bpf_wakeup_source_btf_id[0];
+	return bpf_iter_reg_target(&bpf_wakeup_source_reg_info);
+}
+
+late_initcall(wakeup_source_iter_init);
-- 
2.53.0.273.g2a3d683680-goog

