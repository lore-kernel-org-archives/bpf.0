Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793998344;
	b=GZ1ckzTxJ4zPQfM4Y2jwXOeMy+mzYdRU4LLkN+zMq1T5L+DPOPKNwGN/tycQTbT7Hm0B
	 Nf5CL5NzDSk7lrVXtEy7ZCb1P98VdBb4uMUEnxJkiDlZPj5k5BBKXxigZS3T3477D00jo
	 QztHHrCBfUoQ+01RJQlCBs4gm8ICjmuoEjtk7Rwi2vx5tLQK9Ff6oFm5+4n6TpvFwMntO
	 XY6ZVGX0y3AZ6JMHoWihTl591r2z19KfpoBw7YVmkT5RDWSB4FHSOoC3CTXmuMgq9deVC
	 zF+qEnhnkSNN90zpvhdWl3ASGSvTxuuSqtICbamQm7LS/5SjVfXaFCd5jInz6O46WHQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793998344;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=xJq8gOBHZVhkpcEsEbk1DDy0GIXDlvqUxtZC/mSnMLk=;
	b=ghqiYMPShnTlK+Q1xHsDaA32B1iQxDyEXvLFt5GrHnqwHM0kurD+/E5rqL9qRZxczYcp
	 gk2J2AsVmpm1faD7Idt7Hj2vGPtpL+eWx7Gz+6d73j0okJC5RfSAW9gfbZMYqHzHiRUJ5
	 pmpbBeC0IibVFQggBnjNT5izUSDG66VdRPZAoBLq4ySbV703xGoDzVfEzvNKgLfia2pLx
	 1GtgasNb/IKqPauZrSGs3VCHFjayiAJj0B3fIy6fNbX6Xr0o/Ou79ZvtT6m/L2kjJZ8Ed
	 d/Kj1IVqbR25SqxLw92MOfZndm92vpL7YTX0c6jh3/687hzRFYTW6LF81ksg0BXEk7g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ca4O9wTp;
	arc=none smtp.remote-ip=209.85.128.51
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6CF3606D80F
	for <bpf@vger.kernel.org>; Fri,  6 Nov 2026 20:52:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A6CF3606D80F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ca4O9wTp
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4a5087a5348so8365705e9.0
        for <bpf@vger.kernel.org>; Fri, 06 Nov 2026 12:52:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793998342; x=1794603142; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xJq8gOBHZVhkpcEsEbk1DDy0GIXDlvqUxtZC/mSnMLk=;
        b=Ca4O9wTpyfuKMimgJS3gqtcdVPil00Cx3DDOz5+rBjfRa07I3Nw9OtvLWWD+XyrYvC
         vENsUawh13k5gtQeOLuqyD89w9DEAdurCTOJWKesPsT8yelBDHcUmGSjKgV5mGZXjZcs
         vapTxA0I3JmNrrmJ1tPswlOKRcBN9oXPx2ERYi795FljnFh8wzc0s78KWTDZfGpA4s7e
         4eIHySCQjDSdmpONYAjFYNC+0pP/GOi0U9sVBf9pH+RhiIo6hfR5hmhi6wb3A6Quvqdc
         JnaEuAvrujS0W4jEkaGEaxy942LM7DZDHFnf9lEFJJZV8HWrRcTGlVwOi1rphXffbwxZ
         xn6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793998342; x=1794603142;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xJq8gOBHZVhkpcEsEbk1DDy0GIXDlvqUxtZC/mSnMLk=;
        b=PR8oHXG9IhMEEB2u71bMvHUtVERWmahEOhDezfAexVlmPD04vfEaakEmIkNJQnxOj4
         PXHXwPKolyJfeBDinzjn07WyPOOVbuOAxLq4oaebPlPokjQlUCFjQ1kEVTQ9UZobtUFR
         +fprHjvY8XKHFwOMgmOj5Wvo9pgzTgD3Ilg2xRW9oAb9wGaVay3Jqtrae8rzTjDSZiSb
         Y9Y9r7IkaJ6kxWsUHlFKDqDBtvj4LucLU9JPQOGrftQLZsF9K0TondaqFylMso3T2Mh9
         ricfQiWX8aK4qq1Qc2d7jCZTZMnjUiWATHAmuQBWM0jUGCL38ywroaKuxHX0o2s2Vexn
         T8hQ==
X-Forwarded-Encrypted: i=1; AKwUvBwk+rs0xLawKKnjNdcieRhfDCx/53xdVTPVi+q0sA7nzS4+sGGNQ0JyAm0Rgu2bkyflHtE=@vger.kernel.org
X-Gm-Message-State: APuU4Z94kuwWS9/4N12G+VWaGlCI3f01nm3ihcAX8p30tt/mukTttg82
	P00bDHaSyjURVzbHMEjNyNM5wuIxkIPYAhWX+W3CRMcaFNzMfaojsu/I
X-Gm-Gg: AYBFou2zBdTvEOxo0cWKrIJf/Mh+R4RqUP0QElx0Lm4cfrJpnaexsvnnp49iocWScMf
	KCLeoMKL1Fceyp/B5uxLC0jSssL031IDAYv8TvTwfCc1Q/OvtHKNl1d2Kr68R5KzHDUv4ffNG3a
	Ud6IJWnlC2DBSs1jTD69evMQVT0umTLV9yCVYBvFCEcKgyIIWx0CloQVZlA8O4rJ00eYARqVR8z
	MbMpZ8s5a/BhH9AqxuvycYzQOitMdxIyxwohFgSU4dA17eFiqYDFdWQFPtY1wStQ/dW3b2Iv66d
	y6J6QIc4oUBVP8IZvnTHTxTbyBCzDDZxlnl2Un59keyPKxnsXE16QTBdx/kTEidHYVsJrh4XCfG
	3EDGUCC2Teg54dRPrZgX8BgFHn2BnGQkiQbyd+RgFzxuIUXZ5SjJ8vq2riUjdRHtYkfxzgQADyG
	n7tDBR1nEq6YnGQODSofcl6/FHhtctYu+K29srGEdIcr3SXsuRr6IK+CyptKZFEU3fiDIydjEQ6
	d/mFk+D951EU5ZKOwKIsdT9GDi1nWV0c29FM6Cj8+CqHHd/gt3Z0rZsak2ej+699Xh0rCyuB3Y0
	RUGIunr645yVYSKmT0jaXCfQbHjX/+hM2apjdu8+fYMOQRI=
X-Received: by 2002:a05:600c:4454:b0:4a0:1b21:2628 with SMTP id 5b1f17b1804b1-4b6dfba8640mr65257045e9.23.1793998341899;
        Fri, 06 Nov 2026 12:52:21 -0800 (PST)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b7da62edb4sm9075425e9.1.2026.11.06.12.52.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 12:52:21 -0800 (PST)
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Alan Maguire <almagui@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Quentin Monnet <qmo@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	KP Singh <kpsingh@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Sasha Levin <sashal@kernel.org>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Anton Protopopov <a.s.protopopov@gmail.com>
Subject: [PATCH v1 bpf-next 18/18] bpftool: List and show fmod_ret targets
Date: Fri,  6 Nov 2026 21:03:07 +0000
Message-ID: <20261106210314.1767267-18-a.s.protopopov@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: 20261106205523.1765622-1-a.s.protopopov@gmail.com
References: <20261106210314.1767267-1-a.s.protopopov@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Most fmod_ret targets are now found by the kernel build and only exist
as BTF decl tags. Add a bpftool fmodret command to see them.

The `bpftool fmodret list` command prints the functions tagged with
"bpf_fmodret" in vmlinux and in the loaded modules, and marks the ones
which sleepable programs may attach to.

The `bpftool fmodret show` command prints a function in detail: its
prototype, if it was declared as a target or found by the build, and the
values which fmod_ret programs may return. A function is given by name
or BTF ID.

Both commands read BTF from /sys/kernel/btf or from a file and support
JSON output.

Functions which the verifier allows by its static rules, such as the
security hooks, may also have the tags and be listed. Even if they are
listed, the restrictions of the tags do not apply to them. This may
change in the future by either not listing them, or listing them without
restrictions.

Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
---
 .../bpftool/Documentation/bpftool-fmodret.rst | 111 +++
 tools/bpf/bpftool/Documentation/bpftool.rst   |   2 +-
 tools/bpf/bpftool/bash-completion/bpftool     |  31 +
 tools/bpf/bpftool/fmodret.c                   | 906 ++++++++++++++++++
 tools/bpf/bpftool/main.c                      |   3 +-
 tools/bpf/bpftool/main.h                      |   1 +
 6 files changed, 1052 insertions(+), 2 deletions(-)
 create mode 100644 tools/bpf/bpftool/Documentation/bpftool-fmodret.rst
 create mode 100644 tools/bpf/bpftool/fmodret.c

diff --git a/tools/bpf/bpftool/Documentation/bpftool-fmodret.rst b/tools/bpf/bpftool/Documentation/bpftool-fmodret.rst
new file mode 100644
index 000000000000..eef34c18de1b
--- /dev/null
+++ b/tools/bpf/bpftool/Documentation/bpftool-fmodret.rst
@@ -0,0 +1,111 @@
+.. SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+
+===============
+bpftool-fmodret
+===============
+-------------------------------------------------------------------------------
+tool to inspect BPF fmod_ret targets
+-------------------------------------------------------------------------------
+
+:Manual section: 8
+
+.. include:: substitutions.rst
+
+SYNOPSIS
+========
+
+**bpftool** [*OPTIONS*] **fmodret** *COMMAND*
+
+*OPTIONS* := { |COMMON_OPTIONS| | { **-B** | **--base-btf** } *FILE* }
+
+*COMMANDS* := { **list** | **show** | **help** }
+
+FMODRET COMMANDS
+================
+
+| **bpftool** **fmodret list** [*OBJECT*]
+| **bpftool** **fmodret show** *FUNC* [*OBJECT*]
+| **bpftool** **fmodret help**
+|
+| *FUNC* := { **name** *NAME* | **id** *BTF_ID* }
+| *OBJECT* := { **file** *FILE* | **vmlinux** | **module** *NAME* }
+
+DESCRIPTION
+===========
+
+bpftool fmodret list [*OBJECT*]
+    List the fmod_ret targets, the functions which the kernel build tags with
+    the **bpf_fmodret** BTF decl tag, in vmlinux and in loaded modules. Each
+    entry contains the BTF ID of the function, its name and the name of the
+    object it belongs to. Targets which sleepable programs may attach to are
+    marked **sleepable**.
+
+    With **file**, read the BTF from *FILE* (for example a vmlinux image or a
+    **BTF** file) instead of the running kernel. With **vmlinux** or
+    **module**, list only the targets of vmlinux or of the module *NAME*.
+
+    With **--json**, each entry contains **btf_id**, **name**, **owner** and
+    **sleepable** fields.
+
+    The verifier also accepts functions by its static rules, such as the error
+    injection list or **security_** hooks. Such functions are listed only if
+    the kernel build tagged them. Even if they are listed, the restrictions of
+    their **bpf_fmodret_retval:** tags do not apply to them: programs may
+    return any value, and sleepable programs may attach to some of them without
+    the **sleepable** mark. This may change in the future by either not listing
+    them, or listing them without restrictions. Normal verifier and tracing
+    checks apply to all of them.
+
+bpftool fmodret show *FUNC* [*OBJECT*]
+    Show the function named *NAME* or with BTF ID *BTF_ID* in detail. It does
+    not have to be a target. A name may belong to several functions, for
+    example to functions of different modules. A BTF ID is looked up in
+    vmlinux, unless **module** or **file** is given. *OBJECT* is as for
+    **list**.
+
+    Besides the BTF ID, the name and the object, show the prototype of the
+    function and if it is a target: **found by the kernel build**, **declared**
+    or **not tagged**. For a target show if sleepable programs may attach to it
+    and the values which programs may return: 0 and the values of its
+    **bpf_fmodret_retval:** tag with the names of the errors on the host, or
+    **any** for a declared target. A tag which the verifier would reject,
+    malformed, not the only one or with values which the return type cannot
+    hold, is shown as invalid. The values do not apply to a function which the
+    static rules allow, see **list**. For the running kernel, also show the
+    type of the entry of the function in the error injection list, if the list
+    is available in debugfs.
+
+    With **--json**, each function contains **btf_id**, **name**, **owner**,
+    **prototype**, **target** (**found**, **declared** or **none**) and
+    **sleepable** fields, a **retval** array for a target found by the build
+    with the values programs may return, 0 included, or a **retval_error**
+    string if its tag is invalid, and an **error_injection** field if the
+    function is in the error injection list. A BTF ID gives one function, a
+    name an array of them.
+
+bpftool fmodret help
+    Print short help message.
+
+OPTIONS
+========
+
+.. include:: common_options.rst
+
+-B, --base-btf *FILE*
+    Pass the base BTF of a split BTF *FILE*, usually the BTF of vmlinux. Raw
+    BTF of a module needs it. A module image may carry the base it was built
+    against in its **.BTF.base** section instead, but its BTF IDs then differ
+    from those of the running kernel.
+
+EXAMPLES
+========
+
+**# bpftool fmodret show name bpf_testmod_retval_join module bpf_testmod**
+
+::
+
+  123456  bpf_testmod_retval_join (bpf_testmod)
+          int bpf_testmod_retval_join(int *result, int value)
+          target: found by the kernel build
+          sleepable: no
+          retval: 0, -34 (ERANGE), -22 (EINVAL)
diff --git a/tools/bpf/bpftool/Documentation/bpftool.rst b/tools/bpf/bpftool/Documentation/bpftool.rst
index f38ae5c40439..2c64c22a5026 100644
--- a/tools/bpf/bpftool/Documentation/bpftool.rst
+++ b/tools/bpf/bpftool/Documentation/bpftool.rst
@@ -21,7 +21,7 @@ SYNOPSIS
 **bpftool** **version**
 
 *OBJECT* := { **map** | **prog** | **link** | **cgroup** | **perf** | **net** | **feature** |
-**btf** | **gen** | **struct_ops** | **iter** }
+**btf** | **gen** | **struct_ops** | **iter** | **fmodret** }
 
 *OPTIONS* := { { **-V** | **--version** } | |COMMON_OPTIONS| }
 
diff --git a/tools/bpf/bpftool/bash-completion/bpftool b/tools/bpf/bpftool/bash-completion/bpftool
index a28af31937ad..83288c22b3d3 100644
--- a/tools/bpf/bpftool/bash-completion/bpftool
+++ b/tools/bpf/bpftool/bash-completion/bpftool
@@ -675,6 +675,37 @@ _bpftool()
                     ;;
             esac
             ;;
+        fmodret)
+            case $command in
+                list|show)
+                    case $prev in
+                        file)
+                            _filedir
+                            ;;
+                        module)
+                            COMPREPLY=( $( compgen -W "$( command ls \
+                                /sys/kernel/btf 2>/dev/null | \
+                                command grep -vx -e vmlinux -e '.*\.inline' )" \
+                                -- "$cur" ) )
+                            ;;
+                        name|id)
+                            ;;
+                        *)
+                            if [[ $prev == show ]]; then
+                                COMPREPLY=( $( compgen -W 'name id' -- "$cur" ) )
+                            else
+                                _bpftool_one_of_list 'file vmlinux module'
+                            fi
+                            ;;
+                    esac
+                    return 0
+                    ;;
+                *)
+                    [[ $prev == $object ]] && \
+                        COMPREPLY=( $( compgen -W 'help list show' -- "$cur" ) )
+                    ;;
+            esac
+            ;;
         map)
             case $command in
                 show|list|dump|peek|pop|dequeue|freeze)
diff --git a/tools/bpf/bpftool/fmodret.c b/tools/bpf/bpftool/fmodret.c
new file mode 100644
index 000000000000..0d2714ef861e
--- /dev/null
+++ b/tools/bpf/bpftool/fmodret.c
@@ -0,0 +1,906 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+
+#ifndef _GNU_SOURCE
+#define _GNU_SOURCE
+#endif
+#include <dirent.h>
+#include <errno.h>
+#include <limits.h>
+#include <stdarg.h>
+#include <stdbool.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+
+#include <bpf/btf.h>
+#include <bpf/libbpf.h>
+
+#include "main.h"
+
+/*
+ * Decl tags added by resolve_btfids to functions in BTF_FMODRET sets. A target
+ * which sleepable programs may attach to has both tags. A target which the
+ * build found by analysing its code has a "bpf_fmodret_retval:" tag with the
+ * values programs may return, such as "bpf_fmodret_retval:-22,-12".
+ */
+#define TAG_FMODRET		"bpf_fmodret"
+#define TAG_FMODRET_SLEEPABLE	"bpf_fmodret_sleepable"
+#define TAG_FMODRET_RETVAL	"bpf_fmodret_retval:"
+
+#define SYS_BTF_DIR		"/sys/kernel/btf"
+#define ERROR_INJECTION_LIST	"/sys/kernel/debug/error_injection/list"
+
+struct fmodret_entry {
+	__u32 btf_id;
+	bool target;
+	bool sleepable;
+	const char *retval;
+	/* More than one "bpf_fmodret_retval:" tag, which the verifier rejects */
+	bool retval_dup;
+};
+
+struct fmodret_filter {
+	/* Only vmlinux, or only the module with this name */
+	bool vmlinux;
+	const char *module;
+	/* The function to show, by name or by BTF ID */
+	const char *name;
+	__u32 btf_id;
+	unsigned int found;
+	/* The BTF is the one of the running kernel */
+	bool live;
+};
+
+typedef int (*btf_cb)(const char *owner, const struct btf *btf,
+		      struct fmodret_filter *filter);
+
+#define ERRNO_NAME(e) { e, #e }
+
+/* The errors of the uapi and the kernel internal ones, which libc lacks */
+static const struct {
+	int value;
+	const char *name;
+} errno_names[] = {
+	ERRNO_NAME(EPERM),
+	ERRNO_NAME(ENOENT),
+	ERRNO_NAME(ESRCH),
+	ERRNO_NAME(EINTR),
+	ERRNO_NAME(EIO),
+	ERRNO_NAME(ENXIO),
+	ERRNO_NAME(E2BIG),
+	ERRNO_NAME(ENOEXEC),
+	ERRNO_NAME(EBADF),
+	ERRNO_NAME(ECHILD),
+	ERRNO_NAME(EAGAIN),
+	ERRNO_NAME(ENOMEM),
+	ERRNO_NAME(EACCES),
+	ERRNO_NAME(EFAULT),
+	ERRNO_NAME(ENOTBLK),
+	ERRNO_NAME(EBUSY),
+	ERRNO_NAME(EEXIST),
+	ERRNO_NAME(EXDEV),
+	ERRNO_NAME(ENODEV),
+	ERRNO_NAME(ENOTDIR),
+	ERRNO_NAME(EISDIR),
+	ERRNO_NAME(EINVAL),
+	ERRNO_NAME(ENFILE),
+	ERRNO_NAME(EMFILE),
+	ERRNO_NAME(ENOTTY),
+	ERRNO_NAME(ETXTBSY),
+	ERRNO_NAME(EFBIG),
+	ERRNO_NAME(ENOSPC),
+	ERRNO_NAME(ESPIPE),
+	ERRNO_NAME(EROFS),
+	ERRNO_NAME(EMLINK),
+	ERRNO_NAME(EPIPE),
+	ERRNO_NAME(EDOM),
+	ERRNO_NAME(ERANGE),
+	ERRNO_NAME(EDEADLK),
+#if defined(EDEADLOCK) && EDEADLOCK != EDEADLK
+	ERRNO_NAME(EDEADLOCK),
+#endif
+	ERRNO_NAME(ENAMETOOLONG),
+	ERRNO_NAME(ENOLCK),
+	ERRNO_NAME(ENOSYS),
+	ERRNO_NAME(ENOTEMPTY),
+	ERRNO_NAME(ELOOP),
+	ERRNO_NAME(ENOMSG),
+	ERRNO_NAME(EIDRM),
+	ERRNO_NAME(ECHRNG),
+	ERRNO_NAME(EL2NSYNC),
+	ERRNO_NAME(EL3HLT),
+	ERRNO_NAME(EL3RST),
+	ERRNO_NAME(ELNRNG),
+	ERRNO_NAME(EUNATCH),
+	ERRNO_NAME(ENOCSI),
+	ERRNO_NAME(EL2HLT),
+	ERRNO_NAME(EBADE),
+	ERRNO_NAME(EBADR),
+	ERRNO_NAME(EXFULL),
+	ERRNO_NAME(ENOANO),
+	ERRNO_NAME(EBADRQC),
+	ERRNO_NAME(EBADSLT),
+	ERRNO_NAME(EBFONT),
+	ERRNO_NAME(ENOSTR),
+	ERRNO_NAME(ENODATA),
+	ERRNO_NAME(ETIME),
+	ERRNO_NAME(ENOSR),
+	ERRNO_NAME(ENONET),
+	ERRNO_NAME(ENOPKG),
+	ERRNO_NAME(EREMOTE),
+	ERRNO_NAME(ENOLINK),
+	ERRNO_NAME(EADV),
+	ERRNO_NAME(ESRMNT),
+	ERRNO_NAME(ECOMM),
+	ERRNO_NAME(EPROTO),
+	ERRNO_NAME(EMULTIHOP),
+	ERRNO_NAME(EDOTDOT),
+	ERRNO_NAME(EBADMSG),
+	ERRNO_NAME(EOVERFLOW),
+	ERRNO_NAME(ENOTUNIQ),
+	ERRNO_NAME(EBADFD),
+	ERRNO_NAME(EREMCHG),
+	ERRNO_NAME(ELIBACC),
+	ERRNO_NAME(ELIBBAD),
+	ERRNO_NAME(ELIBSCN),
+	ERRNO_NAME(ELIBMAX),
+	ERRNO_NAME(ELIBEXEC),
+	ERRNO_NAME(EILSEQ),
+	ERRNO_NAME(ERESTART),
+	ERRNO_NAME(ESTRPIPE),
+	ERRNO_NAME(EUSERS),
+	ERRNO_NAME(ENOTSOCK),
+	ERRNO_NAME(EDESTADDRREQ),
+	ERRNO_NAME(EMSGSIZE),
+	ERRNO_NAME(EPROTOTYPE),
+	ERRNO_NAME(ENOPROTOOPT),
+	ERRNO_NAME(EPROTONOSUPPORT),
+	ERRNO_NAME(ESOCKTNOSUPPORT),
+	ERRNO_NAME(EOPNOTSUPP),
+	ERRNO_NAME(EPFNOSUPPORT),
+	ERRNO_NAME(EAFNOSUPPORT),
+	ERRNO_NAME(EADDRINUSE),
+	ERRNO_NAME(EADDRNOTAVAIL),
+	ERRNO_NAME(ENETDOWN),
+	ERRNO_NAME(ENETUNREACH),
+	ERRNO_NAME(ENETRESET),
+	ERRNO_NAME(ECONNABORTED),
+	ERRNO_NAME(ECONNRESET),
+	ERRNO_NAME(ENOBUFS),
+	ERRNO_NAME(EISCONN),
+	ERRNO_NAME(ENOTCONN),
+	ERRNO_NAME(ESHUTDOWN),
+	ERRNO_NAME(ETOOMANYREFS),
+	ERRNO_NAME(ETIMEDOUT),
+	ERRNO_NAME(ECONNREFUSED),
+	ERRNO_NAME(EHOSTDOWN),
+	ERRNO_NAME(EHOSTUNREACH),
+	ERRNO_NAME(EALREADY),
+	ERRNO_NAME(EINPROGRESS),
+	ERRNO_NAME(ESTALE),
+	ERRNO_NAME(EUCLEAN),
+	ERRNO_NAME(ENOTNAM),
+	ERRNO_NAME(ENAVAIL),
+	ERRNO_NAME(EISNAM),
+	ERRNO_NAME(EREMOTEIO),
+	ERRNO_NAME(EDQUOT),
+	ERRNO_NAME(ENOMEDIUM),
+	ERRNO_NAME(EMEDIUMTYPE),
+	ERRNO_NAME(ECANCELED),
+	ERRNO_NAME(ENOKEY),
+	ERRNO_NAME(EKEYEXPIRED),
+	ERRNO_NAME(EKEYREVOKED),
+	ERRNO_NAME(EKEYREJECTED),
+	ERRNO_NAME(EOWNERDEAD),
+	ERRNO_NAME(ENOTRECOVERABLE),
+	ERRNO_NAME(ERFKILL),
+	ERRNO_NAME(EHWPOISON),
+#ifdef EFTYPE
+	ERRNO_NAME(EFTYPE),
+#endif
+	{ 512, "ERESTARTSYS" },
+	{ 513, "ERESTARTNOINTR" },
+	{ 514, "ERESTARTNOHAND" },
+	{ 515, "ENOIOCTLCMD" },
+	{ 516, "ERESTART_RESTARTBLOCK" },
+	{ 517, "EPROBE_DEFER" },
+	{ 518, "EOPENSTALE" },
+	{ 519, "ENOPARAM" },
+	{ 521, "EBADHANDLE" },
+	{ 522, "ENOTSYNC" },
+	{ 523, "EBADCOOKIE" },
+	{ 524, "ENOTSUPP" },
+	{ 525, "ETOOSMALL" },
+	{ 526, "ESERVERFAULT" },
+	{ 527, "EBADTYPE" },
+	{ 528, "EJUKEBOX" },
+	{ 529, "EIOCBQUEUED" },
+	{ 530, "ERECALLCONFLICT" },
+	{ 531, "ENOGRACE" },
+};
+
+static const char *errno_name(long long value)
+{
+	size_t i;
+
+	for (i = 0; i < ARRAY_SIZE(errno_names); i++)
+		if (-(long long)errno_names[i].value == value)
+			return errno_names[i].name;
+	return NULL;
+}
+
+static int cmp_entry(const void *a, const void *b)
+{
+	const struct fmodret_entry *x = a, *y = b;
+
+	return (x->btf_id > y->btf_id) - (x->btf_id < y->btf_id);
+}
+
+/* The first type ID which belongs to BTF and not to its base */
+static __u32 first_own_type(const struct btf *btf)
+{
+	const struct btf *base = btf__base_btf(btf);
+
+	return base ? btf__type_cnt(base) : 1;
+}
+
+/*
+ * Return the function which T tags with decl tag NAME, or 0. A NAME which ends
+ * with ':' matches the tags which start with it.
+ */
+static __u32 tag_func(const struct btf *btf, const struct btf_type *t, const char *name)
+{
+	size_t len = strlen(name);
+	const char *tag;
+
+	if (!btf_is_decl_tag(t) || btf_decl_tag(t)->component_idx != -1)
+		return 0;
+	tag = btf__name_by_offset(btf, t->name_off);
+	if (strncmp(tag, name, len) || (name[len - 1] != ':' && tag[len]))
+		return 0;
+	if (!btf_is_func(btf__type_by_id(btf, t->type)))
+		return 0;
+	return t->type;
+}
+
+/* Return the fmod_ret targets of BTF, sorted by BTF ID */
+static int collect_targets(const struct btf *btf, struct fmodret_entry **targets,
+			   size_t *target_cnt)
+{
+	__u32 id, func_id, start_id = first_own_type(btf);
+	__u32 nr_types = btf__type_cnt(btf);
+	struct fmodret_entry *entries = NULL, *entry, *tmp;
+	size_t cnt = 0, capacity = 0;
+
+	for (id = start_id; id < nr_types; id++) {
+		func_id = tag_func(btf, btf__type_by_id(btf, id), TAG_FMODRET);
+		if (!func_id)
+			continue;
+
+		if (cnt == capacity) {
+			capacity = capacity ? 2 * capacity : 64;
+			tmp = realloc(entries, capacity * sizeof(*entries));
+			if (!tmp) {
+				free(entries);
+				return -ENOMEM;
+			}
+			entries = tmp;
+		}
+		entries[cnt].btf_id = func_id;
+		entries[cnt].target = true;
+		entries[cnt].sleepable = false;
+		entries[cnt].retval = NULL;
+		cnt++;
+	}
+	if (cnt)
+		qsort(entries, cnt, sizeof(*entries), cmp_entry);
+
+	/* The other tags mark functions which are already targets */
+	for (id = start_id; cnt && id < nr_types; id++) {
+		const struct btf_type *t = btf__type_by_id(btf, id);
+		struct fmodret_entry key = {};
+
+		key.btf_id = tag_func(btf, t, TAG_FMODRET_SLEEPABLE);
+		if (key.btf_id) {
+			entry = bsearch(&key, entries, cnt, sizeof(*entries), cmp_entry);
+			if (entry)
+				entry->sleepable = true;
+			continue;
+		}
+		key.btf_id = tag_func(btf, t, TAG_FMODRET_RETVAL);
+		if (key.btf_id) {
+			entry = bsearch(&key, entries, cnt, sizeof(*entries), cmp_entry);
+			if (entry)
+				entry->retval = btf__name_by_offset(btf, t->name_off) +
+						strlen(TAG_FMODRET_RETVAL);
+		}
+	}
+
+	*targets = entries;
+	*target_cnt = cnt;
+	return 0;
+}
+
+/* Fill ENTRY from the decl tags of function FUNC_ID */
+static void func_entry(const struct btf *btf, __u32 func_id, struct fmodret_entry *entry)
+{
+	__u32 id, nr_types = btf__type_cnt(btf);
+
+	memset(entry, 0, sizeof(*entry));
+	entry->btf_id = func_id;
+	for (id = first_own_type(btf); id < nr_types; id++) {
+		const struct btf_type *t = btf__type_by_id(btf, id);
+
+		if (tag_func(btf, t, TAG_FMODRET) == func_id)
+			entry->target = true;
+		else if (tag_func(btf, t, TAG_FMODRET_SLEEPABLE) == func_id)
+			entry->sleepable = true;
+		else if (tag_func(btf, t, TAG_FMODRET_RETVAL) == func_id) {
+			entry->retval_dup = entry->retval;
+			entry->retval = btf__name_by_offset(btf, t->name_off) +
+					strlen(TAG_FMODRET_RETVAL);
+		}
+	}
+}
+
+static void list_target(const char *owner, const struct btf *btf,
+			const struct fmodret_entry *entry)
+{
+	const struct btf_type *t = btf__type_by_id(btf, entry->btf_id);
+	const char *name = btf__name_by_offset(btf, t->name_off);
+
+	if (json_output) {
+		jsonw_start_object(json_wtr);
+		jsonw_uint_field(json_wtr, "btf_id", entry->btf_id);
+		jsonw_string_field(json_wtr, "name", name);
+		jsonw_string_field(json_wtr, "owner", owner);
+		jsonw_bool_field(json_wtr, "sleepable", entry->sleepable);
+		jsonw_end_object(json_wtr);
+	} else {
+		printf("%u  %s (%s)%s\n", entry->btf_id, name, owner,
+		       entry->sleepable ? " sleepable" : "");
+	}
+}
+
+static int list_btf(const char *owner, const struct btf *btf,
+		    struct fmodret_filter *filter)
+{
+	struct fmodret_entry *targets = NULL;
+	size_t cnt = 0, i;
+	int err;
+
+	err = collect_targets(btf, &targets, &cnt);
+	if (err) {
+		p_err("failed to collect fmod_ret targets of %s: %s", owner,
+		      strerror(-err));
+		return err;
+	}
+	for (i = 0; i < cnt; i++)
+		list_target(owner, btf, &targets[i]);
+	free(targets);
+	return 0;
+}
+
+struct error_injection {
+	char *name;
+	char *module;
+	char *type;
+};
+
+static struct error_injection *error_injections;
+static size_t error_injection_cnt;
+
+/*
+ * Read the error injection list of the running kernel. Its lines are
+ * "FUNC\tTYPE" and "FUNC [MODULE]\tTYPE". Without debugfs the list is empty.
+ */
+static void read_error_injection_list(void)
+{
+	struct error_injection *tmp;
+	char *line = NULL;
+	size_t len = 0;
+	FILE *f;
+
+	f = fopen(ERROR_INJECTION_LIST, "r");
+	if (!f)
+		return;
+	while (getline(&line, &len, f) > 0) {
+		char *name, *module = NULL, *type, *save;
+
+		/* "NAME [MODULE]\tTYPE" or "NAME\tTYPE" */
+		name = strtok_r(line, " \t\n", &save);
+		type = strtok_r(NULL, " \t\n", &save);
+		if (type && type[0] == '[') {
+			module = type + 1;
+			module[strcspn(module, "]")] = '\0';
+			type = strtok_r(NULL, " \t\n", &save);
+		}
+		if (!name || !type)
+			continue;
+		tmp = realloc(error_injections,
+			      (error_injection_cnt + 1) * sizeof(*error_injections));
+		if (!tmp)
+			break;
+		error_injections = tmp;
+		tmp = &error_injections[error_injection_cnt];
+		tmp->name = strdup(name);
+		tmp->module = strdup(module ?: "");
+		tmp->type = strdup(type);
+		if (!tmp->name || !tmp->module || !tmp->type) {
+			free(tmp->name);
+			free(tmp->module);
+			free(tmp->type);
+			break;
+		}
+		error_injection_cnt++;
+	}
+	free(line);
+	fclose(f);
+}
+
+static void free_error_injection_list(void)
+{
+	size_t i;
+
+	for (i = 0; i < error_injection_cnt; i++) {
+		free(error_injections[i].name);
+		free(error_injections[i].module);
+		free(error_injections[i].type);
+	}
+	free(error_injections);
+	error_injections = NULL;
+	error_injection_cnt = 0;
+}
+
+/* Return the error injection type of function NAME of OWNER, or NULL */
+static const char *error_injection_type(const char *name, const char *owner)
+{
+	const char *module = strcmp(owner, "vmlinux") ? owner : "";
+	size_t i;
+
+	for (i = 0; i < error_injection_cnt; i++)
+		if (!strcmp(error_injections[i].name, name) &&
+		    !strcmp(error_injections[i].module, module))
+			return error_injections[i].type;
+	return NULL;
+}
+
+static void __printf(2, 0) prototype_printf(void *ctx, const char *fmt, va_list args)
+{
+	vfprintf(ctx, fmt, args);
+}
+
+/* Return the declaration of function FUNC_ID, or NULL */
+static char *func_prototype(const struct btf *btf, __u32 func_id)
+{
+	const struct btf_type *t = btf__type_by_id(btf, func_id);
+	LIBBPF_OPTS(btf_dump_emit_type_decl_opts, opts,
+		.field_name = btf__name_by_offset(btf, t->name_off),
+	);
+	struct btf_dump *d;
+	char *buf = NULL;
+	size_t size = 0;
+	FILE *f;
+	int err;
+
+	f = open_memstream(&buf, &size);
+	if (!f)
+		return NULL;
+	d = btf_dump__new(btf, prototype_printf, f, NULL);
+	err = libbpf_get_error(d);
+	if (!err) {
+		err = btf_dump__emit_type_decl(d, t->type, &opts);
+		btf_dump__free(d);
+	}
+	fclose(f);
+	if (err) {
+		free(buf);
+		return NULL;
+	}
+	return buf;
+}
+
+/* Show 0 and the values of a "bpf_fmodret_retval:" tag as a JSON array */
+static void show_retval_json(const char *retval)
+{
+	const char *p = retval;
+	char *end;
+
+	jsonw_name(json_wtr, "retval");
+	jsonw_start_array(json_wtr);
+	jsonw_int(json_wtr, 0);
+	while (*p) {
+		long long value;
+
+		errno = 0;
+		value = strtoll(p, &end, 10);
+		if (end == p || errno)
+			break;
+		jsonw_int(json_wtr, value);
+		p = *end == ',' ? end + 1 : end;
+	}
+	jsonw_end_array(json_wtr);
+}
+
+/*
+ * Check the "bpf_fmodret_retval:" tag of FUNC_ID as the verifier does: negative
+ * decimal numbers separated by commas, which the integer or enum of 4 or 8 bytes
+ * that the function returns can hold. Return why it is invalid, or NULL.
+ */
+static const char *retval_invalid(const struct btf *btf, __u32 func_id,
+				  const char *retval)
+{
+	const struct btf_type *t = btf__type_by_id(btf, func_id);
+	const char *p = retval;
+	int ret_id;
+	char *end;
+
+	t = btf__type_by_id(btf, t->type);
+	ret_id = t ? btf__resolve_type(btf, t->type) : -EINVAL;
+	t = ret_id > 0 ? btf__type_by_id(btf, ret_id) : NULL;
+	if (!t || !(btf_is_int(t) || btf_is_any_enum(t)) || (t->size != 4 && t->size != 8))
+		return "the function does not return an integer of 4 or 8 bytes";
+	for (;;) {
+		long long value;
+
+		if (*p != '-')
+			return "malformed tag";
+		errno = 0;
+		value = strtoll(p, &end, 10);
+		if (end == p || errno || value >= 0)
+			return "malformed tag";
+		if (t->size == 4 && value < INT_MIN)
+			return "a value does not fit the return type";
+		if (!*end)
+			return NULL;
+		if (*end != ',')
+			return "malformed tag";
+		p = end + 1;
+	}
+}
+
+/* Show the values of a "bpf_fmodret_retval:" tag with the names of errors */
+static void show_retval_plain(const char *retval)
+{
+	const char *p = retval, *name;
+	char *end;
+
+	printf("\tretval: 0");
+	while (*p) {
+		long long value;
+
+		errno = 0;
+		value = strtoll(p, &end, 10);
+		if (end == p || errno)
+			break;
+		printf(", %lld", value);
+		name = errno_name(value);
+		if (name)
+			printf(" (%s)", name);
+		p = *end == ',' ? end + 1 : end;
+	}
+	printf("\n");
+}
+
+static int show_function(const char *owner, const struct btf *btf,
+			 const struct fmodret_entry *entry,
+			 struct fmodret_filter *filter)
+{
+	const struct btf_type *t = btf__type_by_id(btf, entry->btf_id);
+	const char *name = btf__name_by_offset(btf, t->name_off);
+	const char *injection = NULL, *invalid = NULL;
+	char *prototype;
+
+	/* The verifier rejects programs on a function with an invalid tag */
+	if (entry->target && entry->retval_dup)
+		invalid = "more than one tag";
+	else if (entry->target && entry->retval)
+		invalid = retval_invalid(btf, entry->btf_id, entry->retval);
+	prototype = func_prototype(btf, entry->btf_id);
+	if (!prototype) {
+		p_err("failed to print the prototype of %s", name);
+		return -EINVAL;
+	}
+	if (filter->live)
+		injection = error_injection_type(name, owner);
+
+	if (json_output) {
+		jsonw_start_object(json_wtr);
+		jsonw_uint_field(json_wtr, "btf_id", entry->btf_id);
+		jsonw_string_field(json_wtr, "name", name);
+		jsonw_string_field(json_wtr, "owner", owner);
+		jsonw_string_field(json_wtr, "prototype", prototype);
+		jsonw_string_field(json_wtr, "target", !entry->target ? "none" :
+				   entry->retval ? "found" : "declared");
+		jsonw_bool_field(json_wtr, "sleepable", entry->target && entry->sleepable);
+		if (invalid)
+			jsonw_string_field(json_wtr, "retval_error", invalid);
+		else if (entry->target && entry->retval)
+			show_retval_json(entry->retval);
+		if (injection)
+			jsonw_string_field(json_wtr, "error_injection", injection);
+		jsonw_end_object(json_wtr);
+	} else {
+		printf("%u  %s (%s)\n", entry->btf_id, name, owner);
+		printf("\t%s\n", prototype);
+		if (entry->target) {
+			printf("\ttarget: %s\n", entry->retval ? "found by the kernel build" :
+			       "declared");
+			printf("\tsleepable: %s\n", entry->sleepable ? "yes" : "no");
+			if (invalid)
+				printf("\tretval: invalid, %s\n", invalid);
+			else if (entry->retval)
+				show_retval_plain(entry->retval);
+			else
+				printf("\tretval: any\n");
+		} else {
+			printf("\ttarget: not tagged, the verifier may accept it by other rules\n");
+		}
+		if (injection)
+			printf("\terror injection: %s\n", injection);
+	}
+	free(prototype);
+	filter->found++;
+	return 0;
+}
+
+static int show_btf(const char *owner, const struct btf *btf,
+		    struct fmodret_filter *filter)
+{
+	__u32 id, nr_types = btf__type_cnt(btf);
+	struct fmodret_entry entry;
+	int err;
+
+	if (filter->btf_id) {
+		if (filter->btf_id < first_own_type(btf) || filter->btf_id >= nr_types ||
+		    !btf_is_func(btf__type_by_id(btf, filter->btf_id)))
+			return 0;
+		func_entry(btf, filter->btf_id, &entry);
+		return show_function(owner, btf, &entry, filter);
+	}
+
+	for (id = first_own_type(btf); id < nr_types; id++) {
+		const struct btf_type *t = btf__type_by_id(btf, id);
+
+		if (!btf_is_func(t) ||
+		    strcmp(btf__name_by_offset(btf, t->name_off), filter->name))
+			continue;
+		func_entry(btf, id, &entry);
+		err = show_function(owner, btf, &entry, filter);
+		if (err)
+			return err;
+	}
+	return 0;
+}
+
+static int filter_module(const struct dirent *entry)
+{
+	size_t len = strlen(entry->d_name);
+
+	/* Skip ".", "..", vmlinux and the ".inline" companions of modules */
+	return entry->d_name[0] != '.' && strcmp(entry->d_name, "vmlinux") &&
+	       !(len > 7 && !strcmp(entry->d_name + len - 7, ".inline"));
+}
+
+static int walk_modules(struct btf *vmlinux, struct fmodret_filter *filter, btf_cb cb)
+{
+	struct dirent **modules = NULL;
+	int i, nr_modules, err = 0;
+
+	if (filter->module) {
+		struct btf *btf;
+
+		btf = btf__load_module_btf(filter->module, vmlinux);
+		err = libbpf_get_error(btf);
+		if (err) {
+			p_err("failed to load BTF of module %s: %s", filter->module,
+			      strerror(-err));
+			return err;
+		}
+		err = cb(filter->module, btf, filter);
+		btf__free(btf);
+		return err;
+	}
+
+	nr_modules = scandir(SYS_BTF_DIR, &modules, filter_module, alphasort);
+	if (nr_modules < 0) {
+		/* There is no module directory without module BTF, which is fine */
+		if (errno == ENOENT)
+			return 0;
+		err = -errno;
+		p_err("failed to read %s: %s", SYS_BTF_DIR, strerror(errno));
+		return err;
+	}
+	for (i = 0; i < nr_modules; i++) {
+		const char *name = modules[i]->d_name;
+		struct btf *btf;
+
+		btf = btf__load_module_btf(name, vmlinux);
+		err = libbpf_get_error(btf);
+		if (err == -ENOENT) {
+			/* The module was unloaded meanwhile */
+			err = 0;
+			continue;
+		}
+		if (err) {
+			p_err("failed to load BTF of module %s: %s", name, strerror(-err));
+			break;
+		}
+		err = cb(name, btf, filter);
+		btf__free(btf);
+		if (err)
+			break;
+	}
+	for (i = 0; i < nr_modules; i++)
+		free(modules[i]);
+	free(modules);
+	return err;
+}
+
+static int walk_live_btf(struct fmodret_filter *filter, btf_cb cb)
+{
+	struct btf *vmlinux;
+	int err = 0;
+
+	vmlinux = btf__load_vmlinux_btf();
+	err = libbpf_get_error(vmlinux);
+	if (err) {
+		p_err("failed to load vmlinux BTF: %s", strerror(-err));
+		return err;
+	}
+	if (!filter->module)
+		err = cb("vmlinux", vmlinux, filter);
+	if (!err && !filter->vmlinux)
+		err = walk_modules(vmlinux, filter, cb);
+	btf__free(vmlinux);
+	return err;
+}
+
+static int walk_file_btf(const char *path, struct fmodret_filter *filter, btf_cb cb)
+{
+	struct btf *btf;
+	int err;
+
+	btf = base_btf ? btf__parse_split(path, base_btf) : btf__parse(path, NULL);
+	err = libbpf_get_error(btf);
+	if (err) {
+		p_err("failed to parse BTF from %s: %s", path, strerror(-err));
+		return err;
+	}
+	err = cb(path, btf, filter);
+	btf__free(btf);
+	return err;
+}
+
+/* Parse the optional OBJECT := { file FILE | vmlinux | module NAME } */
+static int parse_object(int argc, char **argv, const char **path,
+			struct fmodret_filter *filter)
+{
+	if (!argc)
+		return 0;
+	if (is_prefix(*argv, "vmlinux")) {
+		filter->vmlinux = true;
+		NEXT_ARG();
+	} else if (is_prefix(*argv, "file")) {
+		NEXT_ARG();
+		if (!REQ_ARGS(1))
+			return -1;
+		*path = GET_ARG();
+	} else if (is_prefix(*argv, "module")) {
+		NEXT_ARG();
+		if (!REQ_ARGS(1))
+			return -1;
+		filter->module = GET_ARG();
+	}
+	if (argc)
+		return BAD_ARG();
+	return 0;
+}
+
+static int walk_btf(const char *path, struct fmodret_filter *filter, btf_cb cb)
+{
+	return path ? walk_file_btf(path, filter, cb) : walk_live_btf(filter, cb);
+}
+
+static int do_list(int argc, char **argv)
+{
+	struct fmodret_filter filter = {};
+	const char *path = NULL;
+	int err;
+
+	if (parse_object(argc, argv, &path, &filter))
+		return -1;
+
+	if (json_output)
+		jsonw_start_array(json_wtr);
+	err = walk_btf(path, &filter, list_btf);
+	if (json_output)
+		jsonw_end_array(json_wtr);
+	return err;
+}
+
+static int do_show(int argc, char **argv)
+{
+	struct fmodret_filter filter = {};
+	const char *path = NULL;
+	unsigned long id;
+	char *endptr;
+	int err;
+
+	if (!REQ_ARGS(2))
+		return -1;
+	if (is_prefix(*argv, "name")) {
+		NEXT_ARG();
+		filter.name = GET_ARG();
+	} else if (is_prefix(*argv, "id")) {
+		NEXT_ARG();
+		errno = 0;
+		id = strtoul(*argv, &endptr, 0);
+		if (errno || *endptr || !id || id > UINT_MAX || **argv == '-') {
+			p_err("can't parse %s as BTF ID", *argv);
+			return -1;
+		}
+		filter.btf_id = id;
+		NEXT_ARG();
+	} else {
+		p_err("expected 'name' or 'id', got: '%s'", *argv);
+		return -1;
+	}
+	if (parse_object(argc, argv, &path, &filter))
+		return -1;
+	/* The BTF IDs of different modules overlap */
+	if (filter.btf_id && !path && !filter.module)
+		filter.vmlinux = true;
+
+	filter.live = !path;
+	if (filter.live)
+		read_error_injection_list();
+	/* A BTF ID gives one function, a name an array of them */
+	if (json_output && !filter.btf_id)
+		jsonw_start_array(json_wtr);
+	err = walk_btf(path, &filter, show_btf);
+	if (!err && !filter.found) {
+		if (filter.name)
+			p_err("no function named %s", filter.name);
+		else
+			p_err("no function with BTF ID %u", filter.btf_id);
+		err = -ENOENT;
+	}
+	if (json_output && !filter.btf_id)
+		jsonw_end_array(json_wtr);
+	free_error_injection_list();
+	return err;
+}
+
+static int do_help(int argc, char **argv)
+{
+	if (json_output) {
+		jsonw_null(json_wtr);
+		return 0;
+	}
+
+	fprintf(stderr,
+		"Usage: %1$s %2$s list [OBJECT]\n"
+		"       %1$s %2$s show FUNC [OBJECT]\n"
+		"       %1$s %2$s help\n"
+		"\n"
+		"       FUNC := { name NAME | id BTF_ID }\n"
+		"       OBJECT := { file FILE | vmlinux | module NAME }\n"
+		"       " HELP_SPEC_OPTIONS " |\n"
+		"                    {-B|--base-btf} FILE }\n"
+		"\n",
+		bin_name, "fmodret");
+	return 0;
+}
+
+static const struct cmd cmds[] = {
+	{ "list",	do_list },
+	{ "show",	do_show },
+	{ "help",	do_help },
+	{ 0 }
+};
+
+int do_fmodret(int argc, char **argv)
+{
+	return cmd_select(cmds, argc, argv, do_help);
+}
diff --git a/tools/bpf/bpftool/main.c b/tools/bpf/bpftool/main.c
index d15fec71b64e..e2a7571b097c 100644
--- a/tools/bpf/bpftool/main.c
+++ b/tools/bpf/bpftool/main.c
@@ -65,7 +65,7 @@ static int do_help(int argc, char **argv)
 		"       %s batch file FILE\n"
 		"       %s version\n"
 		"\n"
-		"       OBJECT := { prog | map | link | cgroup | perf | net | feature | btf | gen | struct_ops | iter | token }\n"
+		"       OBJECT := { prog | map | link | cgroup | perf | net | feature | btf | gen | struct_ops | iter | fmodret | token }\n"
 		"       " HELP_SPEC_OPTIONS " |\n"
 		"                    {-V|--version} }\n"
 		"",
@@ -91,6 +91,7 @@ static const struct cmd commands[] = {
 	{ "gen",	do_gen },
 	{ "struct_ops",	do_struct_ops },
 	{ "iter",	do_iter },
+	{ "fmodret",	do_fmodret },
 	{ "token",	do_token },
 	{ "version",	do_version },
 	{ 0 }
diff --git a/tools/bpf/bpftool/main.h b/tools/bpf/bpftool/main.h
index b1eb4b5d991b..4d877b803b47 100644
--- a/tools/bpf/bpftool/main.h
+++ b/tools/bpf/bpftool/main.h
@@ -178,6 +178,7 @@ int do_tracelog(int argc, char **arg) __weak;
 int do_feature(int argc, char **argv) __weak;
 int do_struct_ops(int argc, char **argv) __weak;
 int do_iter(int argc, char **argv) __weak;
+int do_fmodret(int argc, char **argv) __weak;
 int do_token(int argc, char **argv) __weak;
 
 int parse_u32_arg(int *argc, char ***argv, __u32 *val, const char *what);
-- 
2.43.0

