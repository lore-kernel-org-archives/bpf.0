Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D08AB544D5F
	for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 13:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790082572; cv=none; b=TcK29E05jaqba4QltTjqmDN52ONE3cD7Abn3fWi5/boUrsH6XUMgMihHJnjJz29fT+kh1/2LgUxn/sTUtE2xq5y2BVseW60g3qc8WHzdWDxvsYoAM9+dwgbfI+cdtkANQ4R16+U01lvc7ZwLDB3vK/gHNOsfXj4kAjzNr7EoasY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790082572; c=relaxed/simple;
	bh=mxFdb9DhEoxvID3PHdOx9RZd/MFmjB45cayVkb6tYUc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BPmEpXmqvFjjxqKLgEkMQAYc6EpToTs+4ZV+GAibxKCk22BovoIwEEVRmWIPhV6/mVUlAvwXuMT8DaTaxKzckPZ3i8po2o+5JWEg3MdX6dFJiihKwlkHtVldy0jPoP3q/S0/in7wPYiHht340D97XrGEJIqLglDPtfy4L0NGn7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=OU04iyCd; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="OU04iyCd"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e6c0fce17so21573815e9.1
        for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 06:09:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1790082567; x=1790687367; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YBWc941sAI+gZg6+h/vlg5P6+DffOCdBEo9RcnEXIgA=;
        b=OU04iyCdTmkWFMqsQkGmrxQ8WcGVBaD9s7WVxz6maxmhJL9HJAfE1ohlYhbWT3+q3M
         QvdCUalDsRevwVP6y/qFKh8bDxJwvB74qSZEnZKPRUrQ5InUR+aAYT+y3Pfv39F5pIs+
         tXKzIwQn+vbZpdDO7xjJXu2zJkl7cyCPOBBrokJeeByyV2JNZbRHrUIFriNJvKVr8fHH
         v5yDMdt4YwOCe7+G7Zjyw95PhH2ov6KLsMsMMj87bqrb9cC9+G7p5kWPoMX8978Hqgcr
         US2icvp/1ZK7h1vsF/lNrQEF/wpYrOV7iVr2M3sUIg5xerflIPaUfU8cTJjTs8wCXOXU
         vC7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790082567; x=1790687367;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YBWc941sAI+gZg6+h/vlg5P6+DffOCdBEo9RcnEXIgA=;
        b=DnHWd3yo8zjma/CEuuysh2UlGAgNvna7szAhpm39pTEaEUpBQs2w5NLgemKC6LG/gn
         0Yn41dfao8ViF5XmOhHBTbtRXpUW/0Syb5QK+GLTBjVUkE9/wtxvEcqNESCpunzXQ5/X
         EXvpdva34+X09SWXR1A5ZQLN+cFos5KVJzrszL2a0+6GImEUxCdioZ8WeqkM9/1/DQKv
         DTlYI/JjY4Fi8v7HiPKZo1yTA8uvcpuBcOAFNzYN4gULR7uvlBzX8mwp4mC87FgjTL1Y
         08qsaU3ioZIR57nq1e8caEe8D1qR0N9wUx/RD9f+pStcRgu4zJbmaDGTb0NJ6WoVGLTD
         j5Yw==
X-Forwarded-Encrypted: i=1; AKwUvByzT9O+FzQ2WlihD4ChpLOWlZ3OptJNiQRJmc9dx7b6015UkqXRwtZaugxpMSLJ7Yjwj1w=@vger.kernel.org
X-Gm-Message-State: AFuF++nbqZIIhtmsOQz1vp91iwXvQYwQHSJINiJR+Yl5+8EAGPB2pnzB
	cz+WXPBO8l+XuzqYVzvaG9DL+KPIoOrBnpLHgMoNO64109zo+CPYaCcif7MvPgVPXZ0=
X-Gm-Gg: AYBFou0qsMA4+ZekkYURh5AoFrgADiOaR4RfHjlQYUFvVU1Px5R0BiTYOiQeLn9bbqu
	6o5s9WXZcwZXkeyMCInZrS2Nyo7UVYmJIEimb2j0aZ4NddU44eyHQQ9UYRNrvS7DDKSnPfZx8Vc
	/Kz1uICwlELAxhbTjGlPecCj71MiimKSQWwE/SpZOLF6BANlSZEL3RPV0EGcHofVKimCn5GJZeE
	n2toFAGdINecB45MmTav+YsLJD15QYMeGrZD9+7M2ywCiSFrYcAXZxo5THzmCtzOJAsubcE6oQ8
	m8wAJOfPFNWOtRhhvE0tqyfsrXTTIXbz7xr7I6bFNTWdqkS8+RSWgAg6jiyWA5EhhxuAvKmnH/R
	YbwuIji8N52Z8VAtPLV9edthgcwl5sxXs/sORJvqfj+7Lriz9dVK+mYLFyySFOqRh3xZrlJ8sjQ
	EQfys+fod7brGtK51lk1AbEPS8LjgtHlSQ3nxQUe654d97MqzBB7ruMpOTPefguWtEXry4GIAI6
	aQZf8Jais+O21K/EFk3nQvny1yYO/vW5+t/y909x0aU9ghTM/LQGFN2V36ZFrhft/dN5Ms=
X-Received: by 2002:a05:600c:310d:b0:49d:15b9:2a2a with SMTP id 5b1f17b1804b1-49fc5721b9dmr210051475e9.10.1790082566983;
        Tue, 22 Sep 2026 06:09:26 -0700 (PDT)
Received: from zovi.suse.cz (dynamic-2a00-1028-838d-271e-8e3b-4aff-fe4c-a100.ipv6.o2.cz. [2a00:1028:838d:271e:8e3b:4aff:fe4c:a100])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fdab3070asm25001075e9.4.2026.09.22.06.09.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 06:09:26 -0700 (PDT)
From: Petr Pavlu <petr.pavlu@suse.com>
To: Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>
Cc: Aaron Tomlin <atomlin@atomlin.com>,
	John Fastabend <john.fastabend@gmail.com>,
	linux-modules@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] module: Add stubs.c for CONFIG_MODULES=n module_put_and_kthread_exit()
Date: Tue, 22 Sep 2026 15:08:17 +0200
Message-ID: <20260922-module-stubs-v1-1-abe465a24879@suse.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Change-ID: 20260918-module-stubs-dccefe41dace
Content-Transfer-Encoding: 8bit

Module-related stubs for CONFIG_MODULES=n can normally live in
linux/module.h. This works well when the stub does nothing or simply
returns a constant. However, some non-module implementations may be more
expensive, either because they have a real implementation or because they
require additional dependencies to be pulled into linux/module.h. This
header appears in roughly 15k #include directives across the kernel, so it
should avoid bringing in unnecessary definitions.

Specifically, linux/module.h defines module_put_and_kthread_exit() as an
alias for kthread_exit() when CONFIG_MODULES=n. That in turn requires
linux/kthread.h, even though linux/module.h otherwise has no need for it.
Note that linux/module.h currently doesn't include linux/kthread.h and
requires its users to pick it up through other paths, which is itself not
quite right.

Introduce kernel/module/stubs.c to hold such stubs, built only for
CONFIG_MODULES=n. This mirrors kernel/time/posix-stubs.c, which is used for
CONFIG_POSIX_TIMERS=n.

Define module_put_and_kthread_exit() in both CONFIG_MODULES configurations
to call __module_put_and_kthread_exit() and add a CONFIG_MODULES=n
implementation of that function to kernel/module/stubs.c. Since
__module_put_and_kthread_exit() is now implemented even when
CONFIG_MODULES=n, remove the corresponding '#ifdef CONFIG_MODULES' from the
noreturn_deny BPF list.

Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
---
kernel/module/stubs.c should also be used for add_taint_module() [1] in the
future.

[1] https://lore.kernel.org/linux-modules/a79a6a06-cc48-4036-882d-95e9b4cc01cf@suse.com/
---
 include/linux/module.h |  9 +++------
 kernel/Makefile        |  2 +-
 kernel/bpf/verifier.c  |  2 --
 kernel/module/Makefile |  4 ++++
 kernel/module/main.c   |  1 +
 kernel/module/stubs.c  | 11 +++++++++++
 6 files changed, 20 insertions(+), 9 deletions(-)

diff --git a/include/linux/module.h b/include/linux/module.h
index 96cc98568eea..4c7bd7f9f889 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -658,10 +658,6 @@ static inline bool within_module(unsigned long addr, const struct module *mod)
 /* Search for module by name: must be in a RCU critical section. */
 struct module *find_module(const char *name);
 
-extern void __noreturn __module_put_and_kthread_exit(struct module *mod,
-			long code);
-#define module_put_and_kthread_exit(code) __module_put_and_kthread_exit(THIS_MODULE, code)
-
 #ifdef CONFIG_MODULE_UNLOAD
 int module_refcount(struct module *mod);
 void __symbol_put(const char *symbol);
@@ -850,8 +846,6 @@ static inline int unregister_module_notifier(struct notifier_block *nb)
 	return 0;
 }
 
-#define module_put_and_kthread_exit(code) kthread_exit(code)
-
 static inline void print_modules(void)
 {
 }
@@ -879,6 +873,9 @@ static inline void module_for_each_mod(int(*func)(struct module *mod, void *data
 }
 #endif /* CONFIG_MODULES */
 
+void __noreturn __module_put_and_kthread_exit(struct module *mod, long code);
+#define module_put_and_kthread_exit(code) __module_put_and_kthread_exit(THIS_MODULE, code)
+
 #ifdef CONFIG_SYSFS
 extern struct kset *module_kset;
 extern const struct kobj_type module_ktype;
diff --git a/kernel/Makefile b/kernel/Makefile
index 1e1a31673577..08a94594975d 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -58,7 +58,7 @@ obj-y += liveupdate/
 obj-y += dma/
 obj-y += entry/
 obj-y += unwind/
-obj-$(CONFIG_MODULES) += module/
+obj-y += module/
 
 obj-$(CONFIG_KCMP) += kcmp.o
 obj-$(CONFIG_FREEZER) += freezer.o
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 72a3f5998dd2..be70f10e4968 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -20417,9 +20417,7 @@ BTF_ID(func, __ia32_sys_exit_group)
 BTF_ID(func, __kunit_abort)
 BTF_ID(func, kunit_try_catch_throw)
 #endif
-#ifdef CONFIG_MODULES
 BTF_ID(func, __module_put_and_kthread_exit)
-#endif
 #ifdef CONFIG_X86_64
 BTF_ID(func, __x64_sys_exit)
 BTF_ID(func, __x64_sys_exit_group)
diff --git a/kernel/module/Makefile b/kernel/module/Makefile
index 50ffcc413b54..72fd2972eacf 100644
--- a/kernel/module/Makefile
+++ b/kernel/module/Makefile
@@ -7,6 +7,7 @@
 # and produce insane amounts of uninteresting coverage.
 KCOV_INSTRUMENT_main.o := n
 
+ifeq ($(CONFIG_MODULES),y)
 obj-y += main.o
 obj-y += strict_rwx.o
 obj-y += kmod.o
@@ -23,3 +24,6 @@ obj-$(CONFIG_KGDB_KDB) += kdb.o
 obj-$(CONFIG_MODVERSIONS) += version.o
 obj-$(CONFIG_MODULE_UNLOAD_TAINT_TRACKING) += tracking.o
 obj-$(CONFIG_MODULE_STATS) += stats.o
+else
+obj-y += stubs.o
+endif
diff --git a/kernel/module/main.c b/kernel/module/main.c
index d0e1e0bd2ad0..a8bf803afa81 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -60,6 +60,7 @@
 #include <linux/codetag.h>
 #include <linux/debugfs.h>
 #include <linux/execmem.h>
+#include <linux/kthread.h>
 #include <uapi/linux/module.h>
 #include "internal.h"
 
diff --git a/kernel/module/stubs.c b/kernel/module/stubs.c
new file mode 100644
index 000000000000..81e66c02260c
--- /dev/null
+++ b/kernel/module/stubs.c
@@ -0,0 +1,11 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+#include <linux/kthread.h>
+#include <linux/module.h>
+#include "internal.h"
+
+void __noreturn __module_put_and_kthread_exit(struct module *mod, long code)
+{
+	kthread_exit(code);
+}
+EXPORT_SYMBOL(__module_put_and_kthread_exit);

---
base-commit: 93f51579e7df248780214094418f205253383cc5
change-id: 20260918-module-stubs-dccefe41dace
