Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B495303A04
	for <bpf@vger.kernel.org>; Wed, 25 Feb 2026 21:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772053731; cv=none; b=n/LMveQswpH2f+O6jh2mO4n0IZX6XZJNdMvVHtoPo1WrHyTqPDhiTkI9Mm2TX3+0AEclOPtFJRe/N8MN2fBNMF7JTwvbJ5xSB+U8KDoVbGWrWFCjnXH/8D3EGPHypRdLox/EI/gPxS7vOz3N80Rjgg5U+us5CNVdNJQNsoKm6jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772053731; c=relaxed/simple;
	bh=oECk2GSjLxevTPHxMFT3evHAkKvGrITJcUAznsv3I1c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NlLQTHGARqLy2ha2VmUaZutfTcPu2uQqLHopvn35SIZVOPtePmjKUZ7RQJJ2jCqhIHvtOGaO3Vc4JaSdzf4xVAuLg0Mp77twu+mmSxEHsJCFo98VAjxIaX3XoJj2QBM5kvuDK5ftR7w6av1BG/vqqFrff6B2ehEvPiEbpz8JdPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--wusamuel.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4lmrYA0X; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wusamuel.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4lmrYA0X"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2ba7e98178fso142986eec.0
        for <bpf@vger.kernel.org>; Wed, 25 Feb 2026 13:08:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772053727; x=1772658527; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=VnO+r1rZZjM9sBZjGFwen0orvSPCFPS7yOGiimnlGMc=;
        b=4lmrYA0Xl5lYxRaxDMi/YHl8xtwe4+5UMf3zBeM5ABFVRiyLCt3EYVNpjePec50diZ
         lwQQFh9rfPWNw7vuKP7A60ZNoOmpUalK2fbea/IIRx3FvMYa4Nrcscxr3ch8JG2yl1Jq
         +FBOvpMfSSj1osClJxgQdJ43kkDctQiVe+c55nVZXyRADdusrYynWdk0RAZoP2naxz9f
         VLBXuG20RHMX1XiarKpQAzg76oQHgKrW/mLFemUz2DcaXUOj/XrwDLVnOvwWXf4FxZ/4
         DtYwsK6U4839T0WiU9QUZ/fL+sHvvk0OeP64YmsT2FgZaIaM/32dqGKuNPLpgo8EMVgi
         M2sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772053727; x=1772658527;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VnO+r1rZZjM9sBZjGFwen0orvSPCFPS7yOGiimnlGMc=;
        b=QteJ/jtOOhswX039xubm87zNw2GfcC2bJFxxNSqmUBstFgXb7UDTPpxPYo6o/cId2u
         s9K7jg87a3kJDBymdWw2mMeYr4CABW6Bi7ddCUT6m6TQMoOeNsaT7AOZyNJXJVLD+c7k
         5OnAqyEZRc7IPZLQtx76it45p4D1NKs70Ewo4XFdUrjp7f/k5PFh2APCR8CrBJiQJ4Ne
         LNr6QmrsIcHHo8x3n/1aMBXD5FERkrxtzt9D32iGaUlsIaZ5BUhdF1Ip7RC2ZWDae8E9
         zBfOLfSBIcShjFIxsPd6JYsA8fYhRwmWWj16iLCTXxG8tVvDezcEuVcRWtE2yFeQ9/Xr
         phHA==
X-Forwarded-Encrypted: i=1; AJvYcCWSXeWj3c7+0a6k2mfdmgpDOL4CooAxydVy7WNWqjjQhN4IOuuvmFQgRwW/+4jC9+fz6QI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3QeXXoUXMbytCAc4vJawG/aj+c0x+eC/MTG9NomSYwOb/RhcK
	4xrCzelaIBfTVilx67B8dddq5aPlJTAZrLHIn0XswNRL03zzRd0oyLLqHR1CMu6URaLTGKz+WPX
	iO5jE+CTZwTkIew==
X-Received: from dycuf4.prod.google.com ([2002:a05:7300:104:b0:2ba:2119:629c])
 (user=wusamuel job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7300:aca5:b0:2b8:6ad3:804e with SMTP id 5a478bee46e88-2bdcc03b2acmr798987eec.22.1772053726742;
 Wed, 25 Feb 2026 13:08:46 -0800 (PST)
Date: Wed, 25 Feb 2026 13:08:17 -0800
In-Reply-To: <20260225210820.177674-1-wusamuel@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260225210820.177674-1-wusamuel@google.com>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260225210820.177674-2-wusamuel@google.com>
Subject: [PATCH bpf-next v5 1/2] bpf: Add wakeup_source iterator
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
2.53.0.473.g4a7958ca14-goog

