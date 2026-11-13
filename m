Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794608071;
	b=rBh0clXYDDxCBx6PR90xKg+pdeFjrUTL17tk0qy/M+JbTWTNG111njnEOrqd5cCDSuAV
	 hrNShoxVOGJg3im8MiXQ4u7Gw2tnHdKAVoidVjet1ItedFYSQfXHRDLSrVlZH0xny5jny
	 v7cSGZa3QGJof3B0zxEMTF5XxYmKAY7lzDa+yCNFU+rNTHApKAQoVew5a2t4UFkqNGHqj
	 TfYMVRiw+QRyvjtkp+lTX+NLw3ILi3lv4YuqT/35S0bHYfDYJfzN9wU1463Ars2afl18x
	 0JGLAAr9d2Yq2JsNRSl4x4IwNJCxdlrfcOJ3dvpMSlnUqqCc6lpWOD+iPuVHjgCF3zw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794608071;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=RQEzDvHEvvVvQ1qVVf3m8J9tQxy8VhbPqMNtOkf2W64=;
	b=Set94X/dNrDi0qtk3kX0ZXG+ZdxOPVOAH3HJnJ0EhECjQy5gROUrXtarYi3IR5HkiHKE
	 xeuNyIBzXt1FiDMPVENXUdZVdWce6fJNsmU5O8/5fd6FC9xoqZHsb/bWTbopGQmU2jN8R
	 393ij801fz4H3yJvPwT+NN1bbyBRr8py6nVvdxKXZJjcCNt+OAn1ZTit1deCEpcdZ//aU
	 suM25QknSawrKQivsUyHn/MtdsLsNSfuNicAUOdMObUbXqSs+Hzdyq01WCxiMXQ78terj
	 v9mpR9/i193+43qtWcKQv4q8uy+cBX9TG6P7PXAZUXk2pYzsML7udy0CXmAjJ6+NgkA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--wusamuel.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=kSTdm4cw;
	arc=none smtp.remote-ip=74.125.82.198
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E836A606A332
	for <bpf@vger.kernel.org>; Fri, 13 Nov 2026 22:14:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E836A606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wusamuel.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=kSTdm4cw
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-33713e5e6daso1357115eec.0
        for <bpf@vger.kernel.org>; Fri, 13 Nov 2026 14:14:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794608070; x=1795212870; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RQEzDvHEvvVvQ1qVVf3m8J9tQxy8VhbPqMNtOkf2W64=;
        b=kSTdm4cwrtwVBcbeXSEgRVdC9FYi0CsFOhzjN9w9hezdy3TgKeC/BLev8OPkk1jDHv
         3BptnIxicseeFTM8z5xNkFl1lzsMtR4VT9SPzQygsfINcbnN78Ktx1LDku/nBk/h4PSf
         QHZIwS7H8xtfdJF7jq5o/ZTbgcO3QfTYvgn3oG8J1GpywjE5KbMfTQHVdUgz6fyOP8al
         QzIB8KYUtJ0Xb/zBc1CZfIh6/WKKCdZcxs1kfSLR6gFTl5B5TCQLWU6UkHBQXlqM+j9y
         csa6/LPUdjZYTxUtb1bUlQDxKKNYLMsorIk3BKfAFc9an4dj6VXsJDp//h4YDxOR9LfF
         ZUKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794608070; x=1795212870;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RQEzDvHEvvVvQ1qVVf3m8J9tQxy8VhbPqMNtOkf2W64=;
        b=ueqyha/z7IvCcV02KgDodV1DUifu3JxUY4IHA7QyWsnQYAOrlVwl9B+zFUI7tqNzo4
         SX0i0Xx6kyUqqurapPJvNw3sEaCRG/VsZfHeZ56NCd9VBYXbMcLELtc2tI8xlZTknwS4
         5DKl7RhIdLjwhrqJjV3ijprS1kk8R9XRXlryth0/PVUdrgT5TgUGXhiq7hSY1aPCe8x/
         FbdZhKheaBspcf5KAAlllvCXLAoeZb5gjD+nk/yALoZo+Ms5r6uM8tka8/TDS8vY8xzc
         eHKfKb7qnYh2nedcEw5fkynZx6KKY316EzjbQINB8DmK14RtEt0cR7NRPTNkcrr7an/+
         aEJw==
X-Forwarded-Encrypted: i=1; AL+hErFTgBRyLw7Z9mjJE+SseMeCvhg9VlQNRv51oZNrTX0uuHSztNzfzpxMSum09dUxJePWLEg=@vger.kernel.org
X-Gm-Message-State: APuU4Z+hIYMcqi/zkjgLHkagFVLop02nVyaKQcUsnvFu//+DbZ1HM8kw
	L4B6e2x8oaWrfoAukwWtT7UytIBFkOOnyAenWMxWzN4ANl1RYzZuNUlo7fLXTJ6S575AxZrmIzn
	uUOjeQjRGFpfbCQ==
X-Received: from dycnl13.prod.google.com ([2002:a05:7300:d10d:b0:36d:461b:fa1f])
 (user=wusamuel job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7300:fd0d:b0:36a:1f:9b74 with SMTP id 5a478bee46e88-37967ed53d3mr4702535eec.27.1794608069745;
 Fri, 13 Nov 2026 14:14:29 -0800 (PST)
Date: Fri, 13 Nov 2026 14:12:51 -0800
In-Reply-To: <20261113221248.3535369-11-wusamuel@google.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261113221248.3535369-11-wusamuel@google.com>
X-Mailer: git-send-email 2.56.0.679.gc527c65306-goog
Message-ID: <20261113221248.3535369-17-wusamuel@google.com>
Subject: [PATCH bpf-next v3 6/9] tools: Copy KALLSYMS_QUERY_* definitions to linux/fs.h
From: Samuel Wu <wusamuel@google.com>
To: Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>, 
	Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Petr Mladek <pmladek@suse.com>, 
	David Laight <david.laight.linux@gmail.com>, Samuel Wu <wusamuel@google.com>, 
	kernel-team@android.com, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-modules@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Copy the KALLSYMS_QUERY_* definitions from include/uapi/linux/fs.h for
the proc selftests.

Signed-off-by: Samuel Wu <wusamuel@google.com>
---
 tools/include/uapi/linux/fs.h | 56 +++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/tools/include/uapi/linux/fs.h b/tools/include/uapi/linux/fs.h
index f0a26309b6d5..286e82c61189 100644
--- a/tools/include/uapi/linux/fs.h
+++ b/tools/include/uapi/linux/fs.h
@@ -567,4 +567,60 @@ struct procmap_query {
 	__u64 build_id_addr;		/* in */
 };
 
+/* /proc/kallsyms ioctls. -EPERM if the opener cannot see kernel addresses. */
+#define KALLSYMS_QUERY_BY_NAME	_IOC(_IOC_READ | _IOC_WRITE, PROCFS_IOCTL_MAGIC, 48, 0)
+#define KALLSYMS_QUERY_BY_ADDR	_IOC(_IOC_READ | _IOC_WRITE, PROCFS_IOCTL_MAGIC, 49, 0)
+
+enum kallsyms_query_flags {
+	/* Match query_name as a prefix. */
+	KALLSYMS_QUERY_NAME_PREFIX = 0x01,
+};
+
+/*
+ * Symbol returned by a query. Each buffer pointer and its *_len must both be
+ * set or both be 0. When set, the kernel sets *_len to the string size
+ * including the NUL, even if the buffer is too small and the ioctl fails with
+ * -ENAMETOOLONG. The module name of a vmlinux symbol is "".
+ */
+struct kallsyms_query_sym {
+	__u64 sym_addr;		/* out - start address */
+	__u64 sym_size;		/* out - bytes to next symbol, 0 if unknown */
+	__u64 sym_name;		/* in - user ptr to name buffer, or 0 */
+	__u64 sym_name_len;	/* in/out - buffer size / string size */
+	__u64 sym_module;	/* in - user ptr to module name buffer, or 0 */
+	__u64 sym_module_len;	/* in/out - buffer size / string size */
+};
+
+/*
+ * Find a symbol by exact name, or by prefix with KALLSYMS_QUERY_NAME_PREFIX,
+ * in the entries of /proc/kallsyms, except undefined module symbols. vmlinux
+ * matches come first. A module_filter of "vmlinux" selects the core kernel.
+ *
+ * Each call returns one match and sets pos to its position, even on
+ * -ENAMETOOLONG. Start with pos 0 and use pos + 1 for the next match, until
+ * -ENOENT. Use pos only with the same query. Matches can be skipped or
+ * repeated if symbols change between calls.
+ */
+struct kallsyms_query_by_name {
+	__u64 size;		/* in - sizeof(struct kallsyms_query_by_name) */
+	__u64 query_flags;	/* in - enum kallsyms_query_flags */
+	__u64 query_name;	/* in - user ptr to name or prefix */
+	__u64 module_filter;	/* in - user ptr to loaded module name, or 0 */
+	__u64 pos;		/* in/out - start position / match position */
+	__u64 sym;		/* in - user ptr to struct kallsyms_query_sym */
+	__u64 sym_struct_size;	/* in - sizeof(struct kallsyms_query_sym) */
+};
+
+/*
+ * Find the /proc/kallsyms entry that covers query_addr, or return -ENOENT.
+ * ftrace trampolines and kprobe pages are not resolved yet.
+ */
+struct kallsyms_query_by_addr {
+	__u64 size;		/* in - sizeof(struct kallsyms_query_by_addr) */
+	__u64 query_flags;	/* in - must be 0 */
+	__u64 query_addr;	/* in - kernel address */
+	__u64 sym;		/* in - user ptr to struct kallsyms_query_sym */
+	__u64 sym_struct_size;	/* in - sizeof(struct kallsyms_query_sym) */
+};
+
 #endif /* _UAPI_LINUX_FS_H */
-- 
2.56.0.679.gc527c65306-goog

