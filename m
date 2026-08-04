Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D74847987A
	for <bpf@vger.kernel.org>; Tue,  4 Aug 2026 16:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785862045; cv=none; b=XoqNfOVPMjzp4ghoZ0SjCliIiVAgss1Hr2a/RjQsrTn507mUnXpvzYlKsgqOHhZUQoql9w74eulUYJT5NIF5KTrvF6ueKeWOzD/fdCWZYTojC3ix8qxqylagq+15vdHyaPy+kKckj5FrvER+Rf323QuvfVxtu5hXENHjY8/GI7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785862045; c=relaxed/simple;
	bh=kgxcMV/BFq5qS0DyPR0Zke058uNwv8lvJbXdshddwo8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TNB5ddGvM727HGKrETUz4AN62t6/fL4R9oZzUj+DA8D5T0U1sg4wXtKKDAxhI61k9Dr49oUXX7i7HHC7su73ZLMkVayQtYfTqFXBVe0u847bCnnInXbLLgXRx1O/Z6EpTAMaceMnwUO+yc0xsmFlUek0Xo4uhnnnKu6qkTDBO7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WTvAoeZv; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WTvAoeZv"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4954afac04bso428875e9.0
        for <bpf@vger.kernel.org>; Tue, 04 Aug 2026 09:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785862027; x=1786466827; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XSXW8Pk+y7DKjHN8V215urDwRXWhyOww9iA3Min2fPY=;
        b=WTvAoeZv9BSE/7+aZsdyWsM4Y0Xxgs6VQBTqwQv62j/lCXjitscLzJOB6E9F1Le+/s
         lPrbvLzu4F8Q13E02pzTJorauTl1Y3lFUOmnY3/kQi04iKh4hxNtD+6WNXXpovwo9/Id
         ed1te62OcY3+Zm/MB2+NfK19b/isSP9+4BDW3ULNm5HqA8Xu4NRBEIxnTiahrha02xNi
         dF1Nv960yPEtK8vTZBRbMIwXqxeb25B0/auqYtUbJ+j3KttyG7gFEVw5jNbgQg6DoBIE
         4Ty0f2zyI9Blsw67JtzIVSDR0z+U6M7Pb4taOFGCdzHQz53OgVnDA+1maUVUZc78dElQ
         wJ5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785862027; x=1786466827;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=XSXW8Pk+y7DKjHN8V215urDwRXWhyOww9iA3Min2fPY=;
        b=sNvYrV3c4CnnKPxmNGu/l53N4+shMhuvN2I+VJiMud+jK2K+x+yP8QU2Y9GU5+H8fW
         WWuYcyj226rEm5o3FjyStYqunYo3bHGM5OTWPuRZSptUvWOV+SfDfcZWZMIWVTus8Qa8
         XLqoCjFZpZupnEWrQMVpBkWfv10WuHUPhNNTnT4n0mMZMBcMta4jFo2IcA5PbVnk5MZl
         mLKu31PSlwovyO2aC2zvZ32e0bou3HMEHa9V4+uvicmduLRwIWkFcH/FVjxys5fawQnt
         xQkNgZj6y/TwbcKkDmGZw8HGYRmiXZLzWWVps7a4s1K/djWi0stss+epBuo1y5W1h5yx
         rN2Q==
X-Gm-Message-State: AOJu0YznytyCbxBqzrgJaIIonvH/87XbN/aMe1khOxRYRtrGaMztLDxe
	gPgXeHFdMbr1Vg/i9uq413nbOr3n6b+ooikn6oOY/WfNpabUD9bGeC6l5RgywYHgtew=
X-Gm-Gg: AR+sD12BZw/VNAa0S1pWnh6priacw8z64YtwNSOe93fcDR7WXaUFu6reco7SRfAAx9S
	2WdsJWtNOWBFtXG53j4vTXIUABSrcNuU/RqLC0I6a6eR/oaHQ7Mhv6EmpQYtkVvto/aEVWaauGq
	6ODVEygflO2JPxufT+ZeccOoIXxLcNLeSRj/sF0UT/IrX3i8qV9Jm7m48O4lslIgwiXb4BybG02
	MoJg2Mx4JSQmKtYdKZIy1QfHrVxcqN9AFCxbbKebeJz2LL5GV+2cj4bx9jPb/YbF+sFXaqAK7Yt
	TE2OZokbqZKeNTveA3U42pNzIPoCkWj4dEjTT3Hf6uYNTlSNLT6OwDmnwl7jVkgcDPqRi4x1DYE
	FADCcFrRreYGGUMaHRWibRHLyQ1bp2qbRJOfFpeE7vuVnqCyHj65IguUDXte9NK+2I4yItqu+Tn
	vge4XwEhaF5h1SLJpGo4ueyebOKj9mxoe0TC8/qTSkVDCpuP/5cKFrXhhNmCgd6vynF008PeLuY
	bDmG/q0dQ6iy/vHEcwDx5HwZn897NGjsQ==
X-Received: by 2002:a05:600c:8b17:b0:495:4491:b8c2 with SMTP id 5b1f17b1804b1-4980c66c926mr344765375e9.3.1785862026494;
        Tue, 04 Aug 2026 09:47:06 -0700 (PDT)
Received: from mtardy-friendly-lvh-runner.europe-west1-c.c.cilium-dev.internal ([2600:1900:4010:1a8::])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4994e04db3asm14229485e9.15.2026.08.04.09.47.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 09:47:06 -0700 (PDT)
From: Mahe Tardy <mahe.tardy@gmail.com>
To: bpf@vger.kernel.org
Cc: andrew+netdev@lunn.ch,
	andrii@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	davem@davemloft.net,
	eddyz87@gmail.com,
	edumazet@google.com,
	john.fastabend@gmail.com,
	kuba@kernel.org,
	liamwisehart@meta.com,
	martin.lau@linux.dev,
	pabeni@redhat.com,
	song@kernel.org,
	netdev@vger.kernel.org,
	sdf.kernel@gmail.com,
	ameryhung@gmail.com,
	kuniyu@google.com,
	Mahe Tardy <mahe.tardy@gmail.com>
Subject: [PATCH bpf-next v3 2/5] bpf: Add ksock kfuncs
Date: Tue,  4 Aug 2026 16:46:49 +0000
Message-Id: <20260804164652.296919-3-mahe.tardy@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260804164652.296919-1-mahe.tardy@gmail.com>
References: <20260804164652.296919-1-mahe.tardy@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add BPF kfuncs that allow BPF LSM programs to create and use sockets for
sending data. This provides a mechanism for BPF programs to emit
telemetry. For this first patch set, it's restricted to SOCK_DGRAM
socket types with IPPROTO_UDP protocol but could be easily extended to
SOCK_STREAM and IPPROTO_TCP in the future.

The API consists of five kfuncs:

  bpf_ksock_create()   - Create a socket (sleepable)
  bpf_ksock_connect()  - Connect socket to remote address (sleepable)
  bpf_ksock_send()     - Send data through the socket (sleepable)
  bpf_ksock_acquire()  - Acquire a reference to a socket context
  bpf_ksock_release()  - Release a reference (cleanup via
                         queue_rcu_work since sock_release sleeps)

The setup kfuncs bpf_ksock_create, bpf_ksock_connect, can be called from
SYSCALL programs only. While bpf_ksock_acquire, bpf_ksock_release and
bpf_ksock_send can be called from SYSCALL and LSM programs.

The implementation follows the established kfunc lifecycle pattern
(create/acquire/release with refcounting, kptr map storage, dtor
registration). The kernel socket is wrapped in a refcounted bpf_ksock
struct. Cleanup is deferred via queue_rcu_work() because sock_release()
may sleep.

The kfuncs are only compiled when CONFIG_INET is enabled, as they
specifically support AF_INET and AF_INET6 sockets.

The socket operations go through the expected LSM hooks instead of
by-passing them like many kernel sockets since those are created by BPF
programs and thus system users. Thus bpf_ksock_send() kfunc, which is
exposed to LSM progs, has a re-entering protection to avoid recursion.
Also, because of the LSM checks, we prevent the use of the kfuncs from
asynchronous workqueue as the current value would then be invalid.

In bpf_ksock_create(), we copy the arg values to avoid TOCTOU races
since the kfunc can sleep and the arg values could be stored in a map
that could be re-written by BPF progs or even userspace programs if the
map is mmaped.

Signed-off-by: Mahe Tardy <mahe.tardy@gmail.com>
---
 include/linux/bpf_ksock.h |  36 +++++
 include/linux/sched.h     |   4 +
 kernel/bpf/verifier.c     |   3 +
 net/core/Makefile         |   3 +
 net/core/bpf_ksock.c      | 329 ++++++++++++++++++++++++++++++++++++++
 5 files changed, 375 insertions(+)
 create mode 100644 include/linux/bpf_ksock.h
 create mode 100644 net/core/bpf_ksock.c

diff --git a/include/linux/bpf_ksock.h b/include/linux/bpf_ksock.h
new file mode 100644
index 000000000000..cb387fb75e43
--- /dev/null
+++ b/include/linux/bpf_ksock.h
@@ -0,0 +1,36 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright (c) 2026 Isovalent */
+
+#ifndef _BPF_KSOCK_H
+#define _BPF_KSOCK_H
+
+#include <linux/types.h>
+#include <linux/in.h>
+#include <linux/in6.h>
+
+/**
+ * struct bpf_ksock_create_opts - BPF kernel socket creation parameters
+ * @family:	Address family: AF_INET or AF_INET6.
+ * @type:	Socket type: only SOCK_DGRAM supported for now.
+ * @protocol:	Protocol number (e.g. IPPROTO_UDP), or 0 for the default protocol
+ *		of the given type.
+ * @reserved:	Must be zero. Reserved for future use.
+ */
+struct bpf_ksock_create_opts {
+	__u8 family;
+	__u8 type;
+	__u8 protocol;
+	__u8 reserved;
+};
+
+/**
+ * union bpf_ksock_addr - IPv4 or IPv6 socket address
+ * @sin: IPv4 socket address.
+ * @sin6: IPv6 socket address.
+ */
+union bpf_ksock_addr {
+	struct sockaddr_in sin;
+	struct sockaddr_in6 sin6;
+};
+
+#endif /* _BPF_KSOCK_H */
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 373bcc0598d1..334846df9238 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1050,6 +1050,10 @@ struct task_struct {
 	/* Recursion prevention for eventfd_signal() */
 	unsigned			in_eventfd:1;
 #endif
+#if defined(CONFIG_BPF_SYSCALL) && defined(CONFIG_INET)
+	/* Recursion prevention for bpf_ksock_send() */
+	unsigned			in_bpf_ksock_send:1;
+#endif
 #ifdef CONFIG_ARCH_HAS_CPU_PASID
 	unsigned			pasid_activated:1;
 #endif
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 52be0a118cce..4f3de0a4b0c1 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -4445,6 +4445,9 @@ BTF_ID(struct, task_struct)
 #ifdef CONFIG_CRYPTO
 BTF_ID(struct, bpf_crypto_ctx)
 #endif
+#ifdef CONFIG_INET
+BTF_ID(struct, bpf_ksock)
+#endif
 BTF_SET_END(rcu_protected_types)

 static bool rcu_protected_object(const struct btf *btf, u32 btf_id)
diff --git a/net/core/Makefile b/net/core/Makefile
index b3fdcb4e355f..a9295b785901 100644
--- a/net/core/Makefile
+++ b/net/core/Makefile
@@ -44,6 +44,9 @@ obj-$(CONFIG_FAILOVER) += failover.o
 obj-$(CONFIG_NET_SOCK_MSG) += skmsg.o
 obj-$(CONFIG_BPF_SYSCALL) += sock_map.o
 obj-$(CONFIG_BPF_SYSCALL) += bpf_sk_storage.o
+ifneq ($(CONFIG_INET),)
+obj-$(CONFIG_BPF_SYSCALL) += bpf_ksock.o
+endif
 obj-$(CONFIG_OF)	+= of_net.o
 obj-$(CONFIG_NET_TEST) += net_test.o
 obj-$(CONFIG_NET_DEVMEM) += devmem.o
diff --git a/net/core/bpf_ksock.c b/net/core/bpf_ksock.c
new file mode 100644
index 000000000000..fc1998887196
--- /dev/null
+++ b/net/core/bpf_ksock.c
@@ -0,0 +1,329 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (c) 2026 Isovalent */
+
+#include <linux/bpf.h>
+#include <linux/bpf_ksock.h>
+#include <linux/btf.h>
+#include <linux/btf_ids.h>
+#include <linux/in.h>
+#include <linux/in6.h>
+#include <linux/net.h>
+#include <linux/refcount.h>
+#include <linux/sched.h>
+#include <linux/slab.h>
+#include <linux/socket.h>
+#include <linux/unaligned.h>
+#include <linux/workqueue.h>
+#include <linux/ip.h>
+#include <net/sock.h>
+
+/**
+ * struct bpf_ksock - refcounted BPF kernel socket context
+ * @sock:	The underlying kernel socket.
+ * @usage:	Reference counter.
+ * @rwork:	RCU work for deferred cleanup (sock_release may sleep).
+ */
+struct bpf_ksock {
+	struct socket *sock;
+	refcount_t usage;
+	struct rcu_work rwork;
+};
+
+static void ksock_release_work_fn(struct work_struct *work)
+{
+	struct bpf_ksock *ks =
+		container_of(to_rcu_work(work), struct bpf_ksock, rwork);
+
+	sock_release(ks->sock);
+	kfree(ks);
+}
+
+static bool bpf_ksock_has_user_task_context(void)
+{
+	/*
+	 * Task work can run from do_exit() after exit_nsproxy_namespaces()
+	 * cleared current->nsproxy, while current is still not a kthread.
+	 */
+	return !(current->flags & PF_KTHREAD) && current->nsproxy;
+}
+
+__bpf_kfunc_start_defs();
+
+/**
+ * bpf_ksock_create() - Create a BPF kernel socket.
+ *
+ * Allocates and creates a kernel socket.
+ *
+ * The returned context must either be stored in a map as a kptr, or
+ * freed with bpf_ksock_release().
+ *
+ * This function may sleep (sock_create), so it can only be used
+ * in sleepable BPF programs (SYSCALL).
+ * It cannot be called from a BPF workqueue callback because that callback
+ * does not retain the invoking task's namespace or security context.
+ *
+ * @opts:	Pointer to struct bpf_ksock_create_opts with socket parameters.
+ * @opts__sz:	Size of the opts struct.
+ * @err__uninit:	Integer to store error code when NULL is returned.
+ */
+__bpf_kfunc struct bpf_ksock *
+bpf_ksock_create(const struct bpf_ksock_create_opts *opts, u32 opts__sz,
+		 int *err__uninit)
+{
+	struct bpf_ksock_create_opts opts_copy;
+	struct bpf_ksock *ks;
+	int err;
+
+	/*
+	 * sock_create() derives the network namespace, credentials, and cgroup
+	 * from current. Kernel threads, including BPF workqueue callbacks, do
+	 * not carry the context of the task that invoked the BPF program.
+	 */
+	if (!bpf_ksock_has_user_task_context()) {
+		err = -EOPNOTSUPP;
+		goto err_out;
+	}
+
+	if (!opts || opts__sz != sizeof(struct bpf_ksock_create_opts)) {
+		err = -EINVAL;
+		goto err_out;
+	}
+
+	opts_copy = (struct bpf_ksock_create_opts){
+		.family = READ_ONCE(opts->family),
+		.type = READ_ONCE(opts->type),
+		.protocol = READ_ONCE(opts->protocol),
+		.reserved = READ_ONCE(opts->reserved),
+	};
+
+	if (opts_copy.reserved) {
+		err = -EINVAL;
+		goto err_out;
+	}
+
+	if (opts_copy.family != AF_INET && opts_copy.family != AF_INET6) {
+		err = -EAFNOSUPPORT;
+		goto err_out;
+	}
+
+	if (opts_copy.type != SOCK_DGRAM) {
+		err = -EPROTONOSUPPORT;
+		goto err_out;
+	}
+
+	if (opts_copy.protocol != IPPROTO_UDP && opts_copy.protocol != 0) {
+		err = -EPROTONOSUPPORT;
+		goto err_out;
+	}
+
+	ks = kzalloc_obj(*ks);
+	if (!ks) {
+		err = -ENOMEM;
+		goto err_out;
+	}
+
+	/*
+	 * Use the normal current-task socket path so LSM/cgroup policy,
+	 * socket labels, and the active netns reference match a socket(2)
+	 * created by the BPF program's caller.
+	 */
+	err = sock_create(opts_copy.family, opts_copy.type, opts_copy.protocol,
+			  &ks->sock);
+	if (err)
+		goto err_free;
+
+	ks->sock->sk->sk_rcvbuf = SOCK_MIN_RCVBUF;
+	ks->sock->sk->sk_userlocks |= SOCK_RCVBUF_LOCK;
+
+	refcount_set(&ks->usage, 1);
+	put_unaligned(0, err__uninit);
+	return ks;
+
+err_free:
+	kfree(ks);
+err_out:
+	put_unaligned(err, err__uninit);
+	return NULL;
+}
+
+/**
+ * bpf_ksock_connect() - Connect a BPF kernel socket to a remote address.
+ * @ks:		The BPF kernel socket context.
+ * @addr:	Pointer to an IPv4 or IPv6 socket address.
+ * @addr__sz:	Size of the address union.
+ *
+ * Connects the socket to the specified remote address and port.
+ *
+ * This function may sleep while connecting the socket, so it can only be used
+ * in sleepable BPF programs (SYSCALL).
+ *
+ * Return: 0 on success, negative errno on error.
+ */
+__bpf_kfunc int bpf_ksock_connect(struct bpf_ksock *ks,
+				  const union bpf_ksock_addr *addr,
+				  u32 addr__sz)
+{
+	struct sockaddr_storage sa;
+	int addrlen;
+
+	if (!bpf_ksock_has_user_task_context())
+		return -EOPNOTSUPP;
+
+	if (!addr || addr__sz != sizeof(*addr))
+		return -EINVAL;
+
+	/* Kfunc memory arguments may be unaligned. */
+	memcpy(&sa, addr, sizeof(*addr));
+
+	switch (sa.ss_family) {
+	case AF_INET:
+		addrlen = sizeof(struct sockaddr_in);
+		break;
+#if IS_ENABLED(CONFIG_IPV6)
+	case AF_INET6:
+		addrlen = sizeof(struct sockaddr_in6);
+		break;
+#endif
+	default:
+		return -EAFNOSUPPORT;
+	}
+
+	return __sys_connect_socket(ks->sock, &sa, addrlen, 0);
+}
+
+/**
+ * bpf_ksock_acquire() - Acquire a reference to a BPF kernel socket.
+ * @ks:	The BPF kernel socket context to acquire. Must be a
+ *	trusted pointer (e.g. RCU-protected kptr from a map).
+ *
+ * The acquired context must either be stored in a map as a kptr, or
+ * freed with bpf_ksock_release().
+ */
+__bpf_kfunc struct bpf_ksock *bpf_ksock_acquire(struct bpf_ksock *ks)
+{
+	if (!refcount_inc_not_zero(&ks->usage))
+		return NULL;
+	return ks;
+}
+
+/**
+ * bpf_ksock_release() - Release a BPF kernel socket.
+ * @ks:	The BPF kernel socket context to release.
+ *
+ * When the final reference is released, the socket is cleaned up via
+ * queue_rcu_work() (since sock_release may sleep).
+ */
+__bpf_kfunc void bpf_ksock_release(struct bpf_ksock *ks)
+{
+	if (refcount_dec_and_test(&ks->usage)) {
+		INIT_RCU_WORK(&ks->rwork, ksock_release_work_fn);
+		queue_rcu_work(system_dfl_wq, &ks->rwork);
+	}
+}
+
+__bpf_kfunc void bpf_ksock_release_dtor(void *ks)
+{
+	bpf_ksock_release(ks);
+}
+CFI_NOSEAL(bpf_ksock_release_dtor);
+
+/**
+ * bpf_ksock_send() - Send data through a BPF kernel socket.
+ * @ks:		The BPF kernel socket context. Must be an acquired reference.
+ * @data:	Pointer to the data to send.
+ * @data__sz:	Size of the data to send (max 65535 bytes).
+ *
+ * Sends data on a connected socket, best-effort and nonblocking. This may sleep
+ * (kernel_sendmsg), so it can only be called from sleepable BPF programs.
+ *
+ * Return: Number of bytes sent on success, negative errno on error.
+ */
+__bpf_kfunc int bpf_ksock_send(struct bpf_ksock *ks, const void *data,
+			       u32 data__sz)
+{
+	struct msghdr msg = {
+		.msg_flags = MSG_DONTWAIT,
+	};
+	struct kvec iov = {
+		.iov_base = (void *)data,
+		.iov_len = data__sz,
+	};
+	int ret;
+
+	if (!bpf_ksock_has_user_task_context())
+		return -EOPNOTSUPP;
+
+	/* Early check for UDP. Exact limits enforced by kernel_sendmsg(). */
+	if (data__sz > IP_MAX_MTU)
+		return -EMSGSIZE;
+
+	if (current->in_bpf_ksock_send)
+		return -EBUSY;
+
+	current->in_bpf_ksock_send = true;
+	ret = kernel_sendmsg(ks->sock, &msg, &iov, 1, data__sz);
+	current->in_bpf_ksock_send = false;
+
+	return ret;
+}
+
+__bpf_kfunc_end_defs();
+
+BTF_KFUNCS_START(ksock_init_kfunc_btf_ids)
+BTF_ID_FLAGS(func, bpf_ksock_create, KF_ACQUIRE | KF_RET_NULL | KF_SLEEPABLE)
+BTF_ID_FLAGS(func, bpf_ksock_connect, KF_SLEEPABLE)
+BTF_KFUNCS_END(ksock_init_kfunc_btf_ids)
+
+static const struct btf_kfunc_id_set ksock_init_kfunc_set = {
+	.owner = THIS_MODULE,
+	.set = &ksock_init_kfunc_btf_ids,
+};
+
+BTF_KFUNCS_START(ksock_kfunc_btf_ids)
+BTF_ID_FLAGS(func, bpf_ksock_release, KF_RELEASE)
+BTF_ID_FLAGS(func, bpf_ksock_acquire, KF_ACQUIRE | KF_RCU | KF_RET_NULL)
+BTF_ID_FLAGS(func, bpf_ksock_send, KF_SLEEPABLE)
+BTF_KFUNCS_END(ksock_kfunc_btf_ids)
+
+static int bpf_ksock_kfunc_filter(const struct bpf_prog *prog, u32 kfunc_id)
+{
+	if (!btf_id_set8_contains(&ksock_kfunc_btf_ids, kfunc_id) ||
+	    prog->type == BPF_PROG_TYPE_SYSCALL ||
+	    prog->type == BPF_PROG_TYPE_LSM)
+		return 0;
+
+	return -EACCES;
+}
+
+static const struct btf_kfunc_id_set ksock_kfunc_set = {
+	.owner = THIS_MODULE,
+	.set = &ksock_kfunc_btf_ids,
+	.filter = bpf_ksock_kfunc_filter,
+};
+
+BTF_ID_LIST(bpf_ksock_dtor_ids)
+BTF_ID(struct, bpf_ksock)
+BTF_ID(func, bpf_ksock_release_dtor)
+
+static int __init bpf_ksock_kfunc_init(void)
+{
+	int ret;
+	const struct btf_id_dtor_kfunc bpf_ksock_dtors[] = {
+		{
+			.btf_id = bpf_ksock_dtor_ids[0],
+			.kfunc_btf_id = bpf_ksock_dtor_ids[1],
+		},
+	};
+
+	ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_SYSCALL,
+					&ksock_init_kfunc_set);
+	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SYSCALL,
+					       &ksock_kfunc_set);
+	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_LSM,
+					       &ksock_kfunc_set);
+	return ret ?: register_btf_id_dtor_kfuncs(bpf_ksock_dtors,
+						  ARRAY_SIZE(bpf_ksock_dtors),
+						  THIS_MODULE);
+}
+
+late_initcall(bpf_ksock_kfunc_init);
--
2.34.1

