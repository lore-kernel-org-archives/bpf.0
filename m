Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792714657;
	b=wHpVUFhpFJutIg2Sy+W4Jn2Phc+ZlFC1MNAuNC5Qv7pTOI4MhuoJ/3cf7iC8AGWXikW1
	 2VFg0qnJNoXqgmlKcA6kb+yJOI0C50KEi6I4YxTMHqJwnAqZY9u1XZS91xLI9VGT54n11
	 GrHr7m6X7GjuNHwIQXvms1ZsJz8flEvoJR0jKOcopxoDTg0XmF5XcufsA2oj1+n7LPyFl
	 tc7KW3EOchD0RMFHGG9cDSwUCLg7Nf7dkh0Ui97QC259NHvihQq7AHIcyWn1zBs8OMuMu
	 Qec3f0UTLAhgSPoreEqj4KVJ1YcABTeHMW55HNGBQQairvcgGOBs0SzBrqi476nw3ow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792714657;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=mqQD9sWG8+vWfCqZxa70vmXbtgsPIof4sQ6+arRUS4U=;
	b=jyhyQLrjERGFnOXkwP0HovJ7KRgElTnzNEWAnFgV3zflwMxeTDgDM2DnXvnuUHu01YzP
	 7WZbRzU6kYCcdA005uSe1RT+03Wo+pB8lojQUXIutHoImeDnKWjC8qcQggP+VGZI8aStW
	 YgxeRBTWE3EcJAfoI7MBqEkore4hHJjCuWqBv3+xFj4eA2auwfvuX4vuV2QPuAXbck4Ci
	 ++lSmFfpm83Ol1gDNsVR9CXg8xai/4ghiOcQPK5hAmcN8xuFVD2/bPKq6W/kqngDyyWmV
	 EUs7PYmxdchZX5eBiKrcanzvbMxzG3D1O2KhODmysBIiDG89m4gNaqb2+l6i9WyRtxA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--wusamuel.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=aeDksMLe;
	arc=none smtp.remote-ip=209.85.216.70
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ADCA606A325
	for <bpf@vger.kernel.org>; Fri, 23 Oct 2026 00:17:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9ADCA606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wusamuel.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=aeDksMLe
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3adad90c894so391086a91.1
        for <bpf@vger.kernel.org>; Thu, 22 Oct 2026 17:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792714656; x=1793319456; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mqQD9sWG8+vWfCqZxa70vmXbtgsPIof4sQ6+arRUS4U=;
        b=aeDksMLe2btkYRZOxMHUQviK57R6wmtewTzR/ukEN7yWIMiOIVnwubLVIonPcPVcAE
         OjSKmAT+6nkzTNqkIWcxRFDWwfWooH4lSGig76pht8gAySx1a+yibLcyqDH4t26xGpTA
         TcMDCCOWptYvXWX9GmvruSC4kilXFYVR6tf524Dz7fjsThTChHjEuzroY6xAfrJ/DVM8
         7oQF2SrnkWv7cefUakTzeNg8jzzKgOdoAHWxZrhJamYd1Huz9BYgOxvpfkZK8OyCJDmk
         ouAn3ldUz9TyueLQwC+k2OM/MYAAw7+a/obHpXlNkzcgYcxZiwRlG6Sws+6LyRezCJnl
         /9Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792714656; x=1793319456;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mqQD9sWG8+vWfCqZxa70vmXbtgsPIof4sQ6+arRUS4U=;
        b=wQXx2XyGMn26TVxSJKKQva4YLkQUpK/eNL32G8Gpd6hooa5QxlKP0ih2ta3Hzm6jRt
         njf363RQSdhNIV6avxx4aW/s5DBHsSM7YwmUrIUVTU9pY5oPGldi5WC21pJjSEousfGa
         hfBZkLXCy2Yo1vMNqpP+AozjsQdjS+5POUEcZD51jEGTyjD1o1qGzveNgOohftTMf+xK
         ykCeZy/ET4GkiqDwoudGYHorFe6WicekyP608qEs73BwsC6ajSQeQ+uV3R/eI/3CW/KT
         xW4AOQfa51lFhP63RE4lSN5CXPwzX1AETmyUC+F8R1Rst87hWhrqhRkC/yN3o1/fLq0t
         yTgQ==
X-Forwarded-Encrypted: i=1; AKwUvBwsZbP/CKyJfcXsv2dbkkhiW36PPWPAVQ2ErFa4ZUAHsbVIkvcWuh2/8VNxYyEyQ2nSfnk=@vger.kernel.org
X-Gm-Message-State: AFq9FYIpvQYfvbt3Zn0qUL48ta9HWoLs/VV27ENTGJAl0VnEhqTs0P3H
	vGOb4tYaJfKVnBlXJQ1PRyV+e+M6r47GJgY9JSLAkqy6tn22B5Z8n17lVRV+3jWTPOkwZN63L6M
	whesBAVvXYZRvXQ==
X-Received: from pjbst6.prod.google.com ([2002:a17:90b:1fc6:b0:3ab:133b:49b6])
 (user=wusamuel job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90a:d2ce:b0:3ad:c14:35ce with SMTP id 98e67ed59e1d1-3adce884e5bmr420016a91.64.1792714655871;
 Thu, 22 Oct 2026 17:17:35 -0700 (PDT)
Date: Thu, 22 Oct 2026 17:16:05 -0700
In-Reply-To: <20261023001603.560210-8-wusamuel@google.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261023001603.560210-8-wusamuel@google.com>
X-Mailer: git-send-email 2.56.0.257.gf7497c7d27-goog
Message-ID: <20261023001603.560210-12-wusamuel@google.com>
Subject: [PATCH bpf-next v2 4/6] libbpf: Resolve typeless ksyms via
 KALLSYMS_QUERY ioctl
From: Samuel Wu <wusamuel@google.com>
To: Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>
Cc: Samuel Wu <wusamuel@google.com>, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-doc@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

When resolving typeless extern ksyms (!ext->ksym.type_id), libbpf
currently reads and parses the entire /proc/kallsyms text file via
libbpf_kallsyms_parse(). The kallsyms text file is commonly and quite
easily several MB, which means with 4kB page sizes, parsing the file
requires a few thousand read() syscalls. This is inefficient, especially
in the common case when only a few symbols are needed.

Add bpf_object__query_ksyms() to resolve typeless extern ksyms via the
KALLSYMS_QUERY ioctl on /proc/kallsyms. Modules are still searched if a
symbol is not found in vmlinux, and ambiguous symbols are still an
error. The lookup follows kallsyms_lookup_name() semantics, so there
are two differences from parsing the text file:
- A name that exists in both vmlinux and a module resolves to the
  vmlinux symbol, instead of failing as ambiguous.
- Names are matched exactly, so an extern does not match a
  <name>.llvm.<hash> symbol on CONFIG_LTO_CLANG kernels.

Fall back to reading and parsing the full text kallsyms only if the
ioctl is not accessible: -ENOTTY on older kernels without the ioctl, or
-EPERM if kallsyms addresses are hidden from the opener (e.g.
kptr_restrict). A symbol that is not found is left unresolved, so a
missing strong extern still fails with -ESRCH and a missing weak extern
still defaults to zero, without a full text scan.

Signed-off-by: Samuel Wu <wusamuel@google.com>
---
 tools/lib/bpf/libbpf.c | 78 ++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 76 insertions(+), 2 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 8fcb8cf39cc0..0e94d2335bd7 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -31,6 +31,7 @@
 #include <linux/bpf.h>
 #include <linux/btf.h>
 #include <linux/filter.h>
+#include <linux/fs.h>
 #include <linux/limits.h>
 #include <linux/perf_event.h>
 #include <linux/bpf_perf_event.h>
@@ -59,6 +60,23 @@
 #define BPF_FS_MAGIC		0xcafe4a11
 #endif
 
+#ifndef KALLSYMS_QUERY
+/* 'f' corresponds to PROCFS_IOCTL_MAGIC (include/uapi/linux/fs.h) */
+#define KALLSYMS_QUERY		_IOWR('f', 18, struct kallsyms_query)
+
+enum kallsyms_query_flags {
+	KALLSYMS_QUERY_BY_SYMBOL = 0x01,
+};
+
+struct kallsyms_query {
+	__u64 size;
+	__u64 query_flags;
+	__u64 sym_name_addr;
+	__u64 sym_addr;
+	__u64 sym_name_size;
+};
+#endif
+
 #define MAX_EVENT_NAME_LEN	64
 
 #define BPF_FS_DEFAULT_PATH "/sys/fs/bpf"
@@ -9644,8 +9662,64 @@ static int kallsyms_cb(unsigned long long sym_addr, char sym_type,
 	return 0;
 }
 
-static int bpf_object__read_kallsyms_file(struct bpf_object *obj)
+static int bpf_object__query_ksyms(struct bpf_object *obj)
+{
+	struct kallsyms_query q;
+	struct extern_desc *ext;
+	int err = 0;
+	int fd;
+	int i;
+
+	fd = open("/proc/kallsyms", O_RDONLY | O_CLOEXEC);
+	if (fd < 0)
+		return -errno;
+
+	for (i = 0; i < obj->nr_extern; i++) {
+		ext = &obj->externs[i];
+		if (ext->type != EXT_KSYM || ext->ksym.type_id)
+			continue;
+
+		q = (struct kallsyms_query){
+			.size = sizeof(q),
+			.query_flags = KALLSYMS_QUERY_BY_SYMBOL,
+			.sym_name_addr = ptr_to_u64(ext->name),
+		};
+
+		if (ioctl(fd, KALLSYMS_QUERY, &q) < 0) {
+			err = -errno;
+			if (err == -ENOENT) {
+				err = 0;
+				continue;
+			}
+			if (err == -EADDRNOTAVAIL)
+				pr_warn("extern (ksym) '%s': resolution is ambiguous\n",
+					ext->name);
+			break;
+		}
+		ext->is_set = true;
+		ext->ksym.addr = q.sym_addr;
+		pr_debug("extern (ksym) '%s': resolved in kernel to 0x%llx\n",
+			 ext->name, ext->ksym.addr);
+	}
+	close(fd);
+	return err;
+}
+
+static int bpf_object__resolve_typeless_ksyms(struct bpf_object *obj)
 {
+	int err;
+
+	err = bpf_object__query_ksyms(obj);
+	/*
+	 * Fall back to parsing /proc/kallsyms only if the ioctl is not
+	 * accessible: not present (-ENOTTY on older kernels) or kallsyms
+	 * addresses hidden from this opener (-EPERM, e.g. kptr_restrict).
+	 */
+	if (err != -ENOTTY && err != -EPERM)
+		return err;
+
+	pr_debug("KALLSYMS_QUERY unavailable (%s), falling back to /proc/kallsyms\n",
+		 errstr(err));
 	return libbpf_kallsyms_parse(kallsyms_cb, obj);
 }
 
@@ -9922,7 +9996,7 @@ static int bpf_object__resolve_externs(struct bpf_object *obj,
 			return -EINVAL;
 	}
 	if (need_kallsyms) {
-		err = bpf_object__read_kallsyms_file(obj);
+		err = bpf_object__resolve_typeless_ksyms(obj);
 		if (err)
 			return -EINVAL;
 	}
-- 
2.56.0.257.gf7497c7d27-goog

