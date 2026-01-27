Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A603133B6CE
	for <bpf@vger.kernel.org>; Tue, 27 Jan 2026 10:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769508878; cv=none; b=tbICdDOvAUYDnbENU01sjSpFmKiqJI1sxE8C6NoVGxLDtY6LHEYUM0gCbRhrda6CUxPNdAADlN1dP2KYw7aNP+MtEW1xZKmKaG974cAYKcuk/3uKvue+AZ5iwhj1SjAQYModCi7O9xjk7WJ25mBM0YtwXjHeRa3F5J8ATPigb3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769508878; c=relaxed/simple;
	bh=/1szb2H6Xx/lKih2kRWMs7yZOT8bB/k1n9BqMnkRSek=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fqPGD8f3mAwg45ip27BIEVCv7hd3+XxW/U4o/QCROW0bJH3/VelFT3xd/CNt3yWrN9XDvPhn/k17vdfT61hbdzTDU0UgcvaxyIHPBjW4aDL3UoKF33A8klkjJspqaVnoLAq4KqeWoI/F+6Vuhzg1lxZ2xupgwCrrUhb2YgkOQ0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KJZF5TJt; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KJZF5TJt"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-43596062728so3937609f8f.1
        for <bpf@vger.kernel.org>; Tue, 27 Jan 2026 02:14:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769508875; x=1770113675; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YmgizQ3Ze6W0FH3pKqbOeHCA2/VzsLuCznhuAnbTU7E=;
        b=KJZF5TJtrxRzoPy4lYe45OI0XBuocZqLAx1D5oJp3nu6n+8CrpY5cnvEzMKYAcnX9F
         qRa6wAjx7RKpL4u8uLi1rZf3gZlwRhCAARvmSf+2KKZLBwt62SfVkTZjxPOu2SjCNksm
         yILyW3qAMlDy66AVTnamUy9GZMpP72HNyR+8PiYSNQBFBe0AR/wQSVMFhmvPXrRNr/9i
         f+2e1wqq03zcsPBl5dnEuMP1rhlhXiYxEWf5/UfP4OsiLjYJ8TsEZr3sH1hKTOeFpGMb
         kvb6srdFbbjKNtO5oAuVPADXFIdAKxsYEuEtWe5hOitpk9Nho4graN9yS6hFV3cs2VQ/
         W4vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769508875; x=1770113675;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YmgizQ3Ze6W0FH3pKqbOeHCA2/VzsLuCznhuAnbTU7E=;
        b=HfXR164UBIFqtk+RZOnCNXqwRdrH5epUSbUcZV4KXE7+PGl7dQvkIqkGSaONXuxqrc
         S7757KRrNJdmPwtBNlQKvfBJEIwPVags+dpintX9/EiuzJlSYMnmwbd0P1VKsUT9YRrz
         ehKnsjv8EZ8LeEohUTVb/KZZKCOUEjpTmmgZwC3n6QkkpvozPnW38Qc4OhuDCySXKQQe
         +sDLDYtUucg6qBVwp2k+2XSpY1V3VJIUXkT2dgajZKRydghipzX0QN0F+rE5eFZnBwx4
         OWjeO76SFRVX3anibOn0XJ1xMUJykCH80+gxd0kn+P5AudTmK27NTWOXPYrqR4rVDmKG
         S5wg==
X-Forwarded-Encrypted: i=1; AJvYcCWWV58CeJweH392DYVWgJDzICcB5zuhkFssOlS+1wsCZ9iCis5Tcg00xwawJ8f1lScezHY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxb1KolI6+vz8FXL//4A/p5Y+Z+HVT5D+meL2aW09AsgpKGfYdX
	l21hq/A2ylYaC96aqr0zrHY8IpNLk4qpuMC8r/3QbYaWrGRRscRTh819KAhqUpgv
X-Gm-Gg: AZuq6aJvNpPzOJ4bqXlSne/hOxnWmbICH6oxXdpvNcTXyxsAsyWcPfJkXSMKKe6V5Us
	+5ja6GDzOUtQ2iR07uR8nciF35M8It5kF2u3YjL1/sfICpYKyjMpe8DvBmNtVn3NJJwiQdQ2IJq
	E7CJrkmo3hyKGj8KumJo/N8v7jsuDXeWsVpnFNYZii7rQakSvCr2d9MPJ1j19w7y5KSPpV4BEQt
	tIv6bSjgZM9dbYNyvyqluQ5TYYA/SYfPTLIjYX8YCj7r9BNUhCqYzIasd40Jc/gg+BpxpEw3uTV
	sOwJcmwR8Uiy5QG1UUhUGUvGyqHYUWTXKkIWjLME38bXmJDXDO71s4FbWgSecZ6hIdAl2G1MLqZ
	zyWGR7vnb0WEJiCWUiQ81NcWCUJXaJQF1C62Flr/KRmZaS8SHVBkyv6rYSkbvjDEln2sTDxFBoU
	k15SolKYOsNE8YZcPyiy4cCZOcl1wacE2Yvx8WBnMAH2s8EFCKRsfdEekgxxD1Zjo8zRWUrvNaN
	nOGlzISKwTeINyo1Apk/0igg88O
X-Received: by 2002:a05:6000:26c7:b0:435:db93:7311 with SMTP id ffacd0b85a97d-435dd1f0a91mr1567584f8f.18.1769508874742;
        Tue, 27 Jan 2026 02:14:34 -0800 (PST)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435b1c24acdsm38190407f8f.13.2026.01.27.02.14.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jan 2026 02:14:34 -0800 (PST)
From: Pavel Begunkov <asml.silence@gmail.com>
To: io-uring@vger.kernel.org
Cc: asml.silence@gmail.com,
	bpf@vger.kernel.org
Subject: [PATCH v4 2/6] io_uring/bpf-ops: add basic bpf struct_ops boilerplate
Date: Tue, 27 Jan 2026 10:14:06 +0000
Message-ID: <4d5bd945d68c6505443daa83329da766d886370d.1769470552.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1769470552.git.asml.silence@gmail.com>
References: <cover.1769470552.git.asml.silence@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add boilerplate code with a basic bpf_struct_ops implementation and
related files and definitions. It'll be used in following patches to add
support for io_uring bpf ops.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 io_uring/Kconfig    |  5 +++
 io_uring/Makefile   |  1 +
 io_uring/bpf-ops.c  | 91 +++++++++++++++++++++++++++++++++++++++++++++
 io_uring/bpf-ops.h  | 10 +++++
 io_uring/io_uring.c |  1 +
 5 files changed, 108 insertions(+)
 create mode 100644 io_uring/bpf-ops.c
 create mode 100644 io_uring/bpf-ops.h

diff --git a/io_uring/Kconfig b/io_uring/Kconfig
index 4b949c42c0bf..b4dad9b74544 100644
--- a/io_uring/Kconfig
+++ b/io_uring/Kconfig
@@ -9,3 +9,8 @@ config IO_URING_ZCRX
 	depends on PAGE_POOL
 	depends on INET
 	depends on NET_RX_BUSY_POLL
+
+config IO_URING_BPF
+	def_bool y
+	depends on IO_URING
+	depends on BPF_SYSCALL && BPF_JIT && DEBUG_INFO_BTF
diff --git a/io_uring/Makefile b/io_uring/Makefile
index d4dbc16a58a5..675865ddb906 100644
--- a/io_uring/Makefile
+++ b/io_uring/Makefile
@@ -24,3 +24,4 @@ obj-$(CONFIG_NET_RX_BUSY_POLL)	+= napi.o
 obj-$(CONFIG_NET) += net.o cmd_net.o
 obj-$(CONFIG_PROC_FS) += fdinfo.o
 obj-$(CONFIG_IO_URING_MOCK_FILE) += mock_file.o
+obj-$(CONFIG_IO_URING_BPF)	+= bpf-ops.o
diff --git a/io_uring/bpf-ops.c b/io_uring/bpf-ops.c
new file mode 100644
index 000000000000..a89d1dea60c7
--- /dev/null
+++ b/io_uring/bpf-ops.c
@@ -0,0 +1,91 @@
+#include <linux/mutex.h>
+#include <linux/bpf.h>
+
+#include "io_uring.h"
+#include "register.h"
+#include "bpf-ops.h"
+
+static struct io_uring_bpf_ops io_bpf_ops_stubs = {
+};
+
+static bool bpf_io_is_valid_access(int off, int size,
+				    enum bpf_access_type type,
+				    const struct bpf_prog *prog,
+				    struct bpf_insn_access_aux *info)
+{
+	if (type != BPF_READ)
+		return false;
+	if (off < 0 || off >= sizeof(__u64) * MAX_BPF_FUNC_ARGS)
+		return false;
+	if (off % size != 0)
+		return false;
+
+	return btf_ctx_access(off, size, type, prog, info);
+}
+
+static int bpf_io_btf_struct_access(struct bpf_verifier_log *log,
+				    const struct bpf_reg_state *reg, int off,
+				    int size)
+{
+	return -EACCES;
+}
+
+static const struct bpf_verifier_ops bpf_io_verifier_ops = {
+	.get_func_proto = bpf_base_func_proto,
+	.is_valid_access = bpf_io_is_valid_access,
+	.btf_struct_access = bpf_io_btf_struct_access,
+};
+
+static int bpf_io_init(struct btf *btf)
+{
+	return 0;
+}
+
+static int bpf_io_check_member(const struct btf_type *t,
+				const struct btf_member *member,
+				const struct bpf_prog *prog)
+{
+	return 0;
+}
+
+static int bpf_io_init_member(const struct btf_type *t,
+			       const struct btf_member *member,
+			       void *kdata, const void *udata)
+{
+	return 0;
+}
+
+static int bpf_io_reg(void *kdata, struct bpf_link *link)
+{
+	return -EOPNOTSUPP;
+}
+
+static void bpf_io_unreg(void *kdata, struct bpf_link *link)
+{
+}
+
+static struct bpf_struct_ops bpf_ring_ops = {
+	.verifier_ops = &bpf_io_verifier_ops,
+	.reg = bpf_io_reg,
+	.unreg = bpf_io_unreg,
+	.check_member = bpf_io_check_member,
+	.init_member = bpf_io_init_member,
+	.init = bpf_io_init,
+	.cfi_stubs = &io_bpf_ops_stubs,
+	.name = "io_uring_bpf_ops",
+	.owner = THIS_MODULE,
+};
+
+static int __init io_uring_bpf_init(void)
+{
+	int ret;
+
+	ret = register_bpf_struct_ops(&bpf_ring_ops, io_uring_bpf_ops);
+	if (ret) {
+		pr_err("io_uring: Failed to register struct_ops (%d)\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+__initcall(io_uring_bpf_init);
diff --git a/io_uring/bpf-ops.h b/io_uring/bpf-ops.h
new file mode 100644
index 000000000000..a6756b391387
--- /dev/null
+++ b/io_uring/bpf-ops.h
@@ -0,0 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
+#ifndef IOU_BPF_OPS_H
+#define IOU_BPF_OPS_H
+
+#include <linux/io_uring_types.h>
+
+struct io_uring_bpf_ops {
+};
+
+#endif /* IOU_BPF_OPS_H */
diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index aea27e3538bb..09920e56c9c9 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -87,6 +87,7 @@
 #include "msg_ring.h"
 #include "memmap.h"
 #include "zcrx.h"
+#include "bpf-ops.h"
 
 #include "timeout.h"
 #include "poll.h"
-- 
2.52.0

