Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.69
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793996423;
	b=X2gjeZJYGoc4+K+KL6ahDjmZ/TSvp9NQSpadI4kZOsQI6/LLlgA/8yvrteaBZ9t1oLfY
	 nH01AwvYPQuk0EorpXypFMWZ5eXVnFXCGZ3kWDWImGNiWvrc5efO18qCkLMA5n9uJuFO8
	 21stbfgRmSBduORM4xrHyKfxE9tzV98SufGDyLR7NiEIo9ZbE7x/OrwN30DK5k01/oEzM
	 ITqzTY7LS0Rb1lEfHEEMu0Xo6oJFf5IZM4usVK19BwNKrYUTqVGX0TImH3dEnWMyb8UIn
	 RL30XfH59LFFvAMOot9f3htha8SrZWv6kZTJ4jXiTfGAV33Q/aCmxQGTnC/gfoooYgw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793996423;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=K1sGHNV060QXqvoYM3K0orPPht5P734++yZ6XL1HQug=;
	b=E4EqZAvKqzdadaUc6jKwBtktLai9knIV+PfowWkflP107swOu2cF+hsUGBYUsLYIKdnV
	 8z49glDxuu+oyfYE3C+dW3YxZGGL8WjuKsJbeoDILJZUcAFBu1SjkGbtc1egCDaHSTEGi
	 KvCUzKdConQNivLcR7cruh6OXTJb738E3LVKtHJSF1gSPa5zNhMs0a2Kx+EfoMKgfS8w9
	 R/NKLLg9IY+nwktjVdf63hhIP+vd/u0Zej2z18p+840r0yt/CII09ZpyM9OnRATBjIk/A
	 aX3fAa40aBrirkgIoMX+E5gnj+pCUT8GWAoKTc9GddfCw8d8HEuJuAHRS8z2DUZ8Zlg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--sidnayyar.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ebw6RDKk;
	arc=none smtp.remote-ip=209.85.216.69
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38A54606D81C
	for <bpf@vger.kernel.org>; Fri,  6 Nov 2026 20:20:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 38A54606D81C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sidnayyar.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ebw6RDKk
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3aed37745bcso15112a91.1
        for <bpf@vger.kernel.org>; Fri, 06 Nov 2026 12:20:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793996422; x=1794601222; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=K1sGHNV060QXqvoYM3K0orPPht5P734++yZ6XL1HQug=;
        b=ebw6RDKkcjg882fzi1Z+Zdl4oglJClpfPn38raYqe9n6lGczb1D7h63+mwKE/2tYHH
         Dgi/YgrDABxsAsm7c6FOZP/5mgr/sKFXbq48Tk5RE2xstwH6XJQiIHfqxDHu3RLyEnIh
         0/cePF29X13v9nsDotcnqGF5l4BEawAA7ZsLmsT1G+rJgBVbRIW1gptfSWziEFV5qQgG
         NItSsQoV5wDu72X+FLGQ8H5g7GT9sZqIPRosRSIdJukHMbJH3rhYpyLNKPGKF3aP7m6V
         IANKWhP1zwxhtYzxZkXCZDnBo/yImuzaBPp8nTV0nePOCDlAuy1eHIRwjcncwtqNeRMJ
         YQBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793996422; x=1794601222;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=K1sGHNV060QXqvoYM3K0orPPht5P734++yZ6XL1HQug=;
        b=EAc5njtt706NboOeMPzxMk5qT89MviAxi1qBDHIEKJAgnrycnehhUY4wRa23j87WTg
         PwGOFzJ+Uaphkf0dwu+sOYK0dQyItJHJp6GH1fDPHqMNPpNlAvnZFBvP3zL1sjs3BaAu
         0TdfpWEeerIwXUAohcwghEfe+6knQ1z/aZZ5SRWoQjbGYJNvCK+s605LE1/G6h5jJ+cl
         D1Rm1OX1UIKZacufWByV9pHljtH73SYKPOeu2D2pRPe2iWYGxI6ViJZ4JRM72TsXJH/j
         fqtPUONrjLKLu7yFwWAOpAYfLNztuj8mAo4+uZsIgImH3lOAC2WnqRPvZrZMq0ceSQbP
         P4Jg==
X-Gm-Message-State: APuU4Z+sSyvVv3mBMRzUnowlaEpFv8XIxghlT+kLVvt038PP2IMmbdQ2
	VG/ZqUdBg2ga4utn3YOXqWnDeVQiTZSHZaO8diW3tHw9ZP4Ia//63ajzjpZLnWLDUl3cs5el+45
	vZRc39lLqKudfiz8rkw==
X-Received: from pjbmq2.prod.google.com ([2002:a17:90b:3802:b0:3b0:c476:aabc])
 (user=sidnayyar job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:3cc6:b0:3a8:786a:cfed with SMTP id 98e67ed59e1d1-3b10659feaemr50585a91.37.1793996422174;
 Fri, 06 Nov 2026 12:20:22 -0800 (PST)
Date: Fri, 06 Nov 2026 20:19:54 +0000
In-Reply-To: <20261106-lskel-struct-ops-v1-0-a4486ffc79cb@google.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261106-lskel-struct-ops-v1-0-a4486ffc79cb@google.com>
X-Mailer: b4 0.14.3
Message-ID: <20261106-lskel-struct-ops-v1-7-a4486ffc79cb@google.com>
Subject: [PATCH RFC bpf-next 7/7] selftests/bpf: Add light skeleton struct_ops tests
From: Siddharth Nayyar <sidnayyar@google.com>
To: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	Quentin Monnet <qmo@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Giuliano Procida <gprocida@google.com>, 
	Neill Kapron <nkapron@google.com>, "=?utf-8?q?Thi=C3=A9baud_Weksteen?=" <tweek@google.com>, 
	Maxime Ripard <mripard@kernel.org>, Siddharth Nayyar <sidnayyar@google.com>
Content-Type: text/plain; charset="utf-8"

Add selftests exercising BPF_MAP_TYPE_STRUCT_OPS support in light
skeletons across both vmlinux and kernel module BTF targets:

- struct_ops_vmlinux.c defines a SEC(".struct_ops.link")
  tcp_congestion_ops map in vmlinux BTF, testing open/load, link
  attachment, callback invocation over a loopback TCP connection,
  and unregistration upon detach.
- struct_ops_mod.c defines two SEC(".struct_ops.link") maps targeting
  bpf_testmod_ops in module BTF (including a reordered subset struct
  bpf_testmod_ops___v2 sharing a callback), testing module BTF FD
  resolution, runtime member offset/index lookup via
  bpf_btf_get_struct_member_info(), scalar member copying, detach,
  and per-map re-attachment.

Signed-off-by: Siddharth Nayyar <sidnayyar@google.com>
---
 tools/testing/selftests/bpf/Makefile.skel          |   3 +-
 .../selftests/bpf/prog_tests/struct_ops_lskel.c    | 122 +++++++++++++++++++++
 tools/testing/selftests/bpf/progs/struct_ops_mod.c |  51 +++++++++
 .../selftests/bpf/progs/struct_ops_vmlinux.c       |  42 +++++++
 4 files changed, 217 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/Makefile.skel b/tools/testing/selftests/bpf/Makefile.skel
index b8eaecc7f429..2726f9081e35 100644
--- a/tools/testing/selftests/bpf/Makefile.skel
+++ b/tools/testing/selftests/bpf/Makefile.skel
@@ -34,7 +34,8 @@ LINKED_SKELS := test_static_linked.skel.h linked_funcs.skel.h		\
 LSKELS := fexit_sleep.c trace_printk.c trace_vprintk.c map_ptr_kern.c 	\
 	core_kern.c core_kern_overflow.c test_ringbuf.c			\
 	test_ringbuf_n.c test_ringbuf_map_key.c test_ringbuf_write.c    \
-	test_ringbuf_overwrite.c callx_rodata.c
+	test_ringbuf_overwrite.c callx_rodata.c struct_ops_vmlinux.c	\
+	struct_ops_mod.c
 
 LSKELS_SIGNED := fentry_test.c fexit_test.c atomics.c
 
diff --git a/tools/testing/selftests/bpf/prog_tests/struct_ops_lskel.c b/tools/testing/selftests/bpf/prog_tests/struct_ops_lskel.c
new file mode 100644
index 000000000000..4e9bac460953
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/struct_ops_lskel.c
@@ -0,0 +1,122 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <test_progs.h>
+#include "network_helpers.h"
+#include "struct_ops_vmlinux.lskel.h"
+#include "struct_ops_mod.lskel.h"
+
+static int set_tcp_ca_cb(int fd, void *opts)
+{
+	const char *tcp_ca = opts;
+
+	if (!ASSERT_OK(setsockopt(fd, IPPROTO_TCP, TCP_CONGESTION,
+				  tcp_ca, strlen(tcp_ca)), "setsockopt"))
+		return -1;
+	return 0;
+}
+
+static void test_vmlinux(void)
+{
+	char tcp_ca[] = "bpf_lskel_ca";
+	struct network_helper_opts opts = {
+		.post_socket_cb	= set_tcp_ca_cb,
+		.cb_opts	= tcp_ca,
+	};
+	struct struct_ops_vmlinux_lskel *skel;
+	int srv_fd = -1, cli_fd = -1, sock_fd = -1;
+	int err;
+
+	skel = struct_ops_vmlinux_lskel__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "open_and_load"))
+		return;
+
+	err = struct_ops_vmlinux_lskel__attach(skel);
+	if (!ASSERT_OK(err, "attach"))
+		goto cleanup;
+
+	srv_fd = start_server_str(AF_INET6, SOCK_STREAM, NULL, 0, &opts);
+	if (!ASSERT_NEQ(srv_fd, -1, "start_server_str"))
+		goto cleanup;
+
+	cli_fd = connect_to_fd_opts(srv_fd, &opts);
+	if (!ASSERT_NEQ(cli_fd, -1, "connect_to_fd_opts"))
+		goto cleanup;
+
+	ASSERT_GT(skel->bss->ca_init_cnt, 0, "ca_init_cnt");
+
+	close(cli_fd);
+	cli_fd = -1;
+	close(srv_fd);
+	srv_fd = -1;
+
+	struct_ops_vmlinux_lskel__detach(skel);
+	skel->links.lskel_ca_fd = 0;
+
+	/* Verify congestion control was unregistered on detach */
+	sock_fd = socket(AF_INET6, SOCK_STREAM, 0);
+	if (!ASSERT_GE(sock_fd, 0, "socket"))
+		goto cleanup;
+
+	err = setsockopt(sock_fd, IPPROTO_TCP, TCP_CONGESTION,
+			 tcp_ca, strlen(tcp_ca));
+	ASSERT_EQ(err, -1, "setsockopt_after_detach");
+	ASSERT_EQ(errno, ENOENT, "errno_after_detach");
+
+cleanup:
+	if (sock_fd != -1)
+		close(sock_fd);
+	if (cli_fd != -1)
+		close(cli_fd);
+	if (srv_fd != -1)
+		close(srv_fd);
+	struct_ops_vmlinux_lskel__destroy(skel);
+}
+
+static void test_module(void)
+{
+	struct struct_ops_mod_lskel *skel;
+	int err, link_fd;
+
+	if (!env.has_testmod) {
+		test__skip();
+		return;
+	}
+
+	skel = struct_ops_mod_lskel__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "open_and_load"))
+		return;
+
+	err = struct_ops_mod_lskel__attach(skel);
+	if (!ASSERT_OK(err, "attach"))
+		goto cleanup;
+
+	ASSERT_GT(skel->links.testmod_1_fd, 0, "testmod_1_fd");
+	ASSERT_GT(skel->links.testmod_2_fd, 0, "testmod_2_fd");
+	ASSERT_EQ(skel->bss->test_1_cnt, 2, "test_1_cnt");
+	ASSERT_EQ(skel->bss->testmod_1_result, 17, "testmod_1_result");
+	ASSERT_EQ(skel->bss->testmod_2_result, 28, "testmod_2_result");
+
+	struct_ops_mod_lskel__detach(skel);
+	skel->links.testmod_1_fd = 0;
+	skel->links.testmod_2_fd = 0;
+	memset(skel->bss, 0, sizeof(*skel->bss));
+
+	link_fd = struct_ops_mod_lskel__testmod_1__attach(skel);
+	if (!ASSERT_GT(link_fd, 0, "testmod_1_attach"))
+		goto cleanup;
+
+	ASSERT_EQ(skel->bss->test_1_cnt, 1, "reattach_test_1_cnt");
+	ASSERT_EQ(skel->bss->testmod_1_result, 17, "reattach_testmod_1_result");
+	ASSERT_EQ(skel->bss->testmod_2_result, 0, "reattach_testmod_2_result");
+
+cleanup:
+	struct_ops_mod_lskel__destroy(skel);
+}
+
+void test_struct_ops_lskel(void)
+{
+	if (test__start_subtest("vmlinux"))
+		test_vmlinux();
+	if (test__start_subtest("module"))
+		test_module();
+}
diff --git a/tools/testing/selftests/bpf/progs/struct_ops_mod.c b/tools/testing/selftests/bpf/progs/struct_ops_mod.c
new file mode 100644
index 000000000000..b1bd7429149d
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/struct_ops_mod.c
@@ -0,0 +1,51 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include "../test_kmods/bpf_testmod.h"
+
+char _license[] SEC("license") = "GPL";
+
+int test_1_cnt = 0;
+int testmod_1_result = 0;
+int testmod_2_result = 0;
+
+SEC("struct_ops/test_1")
+int BPF_PROG(test_1)
+{
+	test_1_cnt++;
+	return 0;
+}
+
+SEC("struct_ops/test_2")
+void BPF_PROG(test_2, int a, int b)
+{
+	testmod_1_result = a + b;
+}
+
+SEC("struct_ops/test_2_v2")
+void BPF_PROG(test_2_v2, int a, int b)
+{
+	testmod_2_result = a * b;
+}
+
+SEC(".struct_ops.link")
+struct bpf_testmod_ops testmod_1 = {
+	.test_1 = (void *)test_1,
+	.test_2 = (void *)test_2,
+	.data = 13,
+};
+
+struct bpf_testmod_ops___v2 {
+	int data;
+	void (*test_2)(int a, int b);
+	int (*test_1)(void);
+};
+
+SEC(".struct_ops.link")
+struct bpf_testmod_ops___v2 testmod_2 = {
+	.data = 7,
+	.test_2 = (void *)test_2_v2,
+	.test_1 = (void *)test_1,
+};
diff --git a/tools/testing/selftests/bpf/progs/struct_ops_vmlinux.c b/tools/testing/selftests/bpf/progs/struct_ops_vmlinux.c
new file mode 100644
index 000000000000..1d8b573ad799
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/struct_ops_vmlinux.c
@@ -0,0 +1,42 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include "bpf_tracing_net.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+char _license[] SEC("license") = "GPL";
+
+int ca_init_cnt = 0;
+
+SEC("struct_ops/ca_lskel_init")
+void BPF_PROG(ca_lskel_init, struct sock *sk)
+{
+	ca_init_cnt++;
+}
+
+SEC("struct_ops/ca_lskel_cong_control")
+void BPF_PROG(ca_lskel_cong_control, struct sock *sk, __u32 ack, int flag,
+	      const struct rate_sample *rs)
+{
+}
+
+SEC("struct_ops/ca_lskel_ssthresh")
+__u32 BPF_PROG(ca_lskel_ssthresh, struct sock *sk)
+{
+	return tcp_sk(sk)->snd_ssthresh;
+}
+
+SEC("struct_ops/ca_lskel_undo_cwnd")
+__u32 BPF_PROG(ca_lskel_undo_cwnd, struct sock *sk)
+{
+	return tcp_sk(sk)->snd_cwnd;
+}
+
+SEC(".struct_ops.link")
+struct tcp_congestion_ops lskel_ca = {
+	.init = (void *)ca_lskel_init,
+	.cong_control = (void *)ca_lskel_cong_control,
+	.ssthresh = (void *)ca_lskel_ssthresh,
+	.undo_cwnd = (void *)ca_lskel_undo_cwnd,
+	.name = "bpf_lskel_ca",
+};

-- 
2.56.0.455.g6c5a503b38-goog

