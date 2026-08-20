Received: from extorris.mess.org (extorris.mess.org [92.243.27.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74BE63DA5DC;
	Thu, 20 Aug 2026 21:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.243.27.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787259730; cv=none; b=mp4ixxJaSNxSWRJj7E+WsTYLz0RfFQgGEYI+Xz40Nw4CA1rrBCiVnm1YIV2ri+Ux6hIaaIt2DFB7rO4KeD4t2gm9BifEOvWMr3588yHnJg3BRbG/4AAgFaDJChKeM6ph1Uyf74hjj7kXoCjlk0LJNdgGLElkXBvtHaJxz3GEhVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787259730; c=relaxed/simple;
	bh=cm0vLWo1qcrimBzA2DAmVR1Cq2xP2T9QGWK+OlE8NYM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZvypebCYz/+07zxK5LaOK1qrFWuXCsnF6f4PpfYtQhn709b+hWjS4PRzuAGg33GLe+tEwl/ZCOgbybFkzsbQci9KE7s0WST79VJkvij8+G8jgnpQBitmp0yZWiWbOI5dPkH4T+z4ej68OxnRpdmUB+ue2U5k9qE1Ut81O/fIGIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org; spf=pass smtp.mailfrom=mess.org; dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b=gLEQCxMe; dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b=c924YB7D; arc=none smtp.client-ip=92.243.27.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mess.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="gLEQCxMe";
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="c924YB7D"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1787259725; bh=cm0vLWo1qcrimBzA2DAmVR1Cq2xP2T9QGWK+OlE8NYM=;
	h=From:To:Cc:Subject:Date:From;
	b=gLEQCxMe7YAuL6MjgVlWlIDCWl9FoW5giiX5n9x3ElfCehUHMWjVECRCqrODSMepZ
	 7sDKzKzVyJjeRWvVWB2KOCho6yF8zot4obs4X/S0Wvh7isYxry5/SPYdYkVFrmjjTt
	 4VweVn4UEPQinIRWPv6iEl9SKfpEgp/OYS2O5rMqs4lst0DHLmBhqP+Df3Rp0zIrtn
	 nPgEAvwY0gxuWYlogEkWHOR6eWP4rPhwRv/7oFL7MnH07d+IHyyrynQ7TdYz1XDYiu
	 i266PHdsNxwgdpQ2xyURcTdlf4DWSR5X0O8uqrIM7kpfmz+/+d43YTxqLeDDUZHVvD
	 TfsZVMfE5lJag==
Received: by extorris.mess.org (Postfix, from userid 1004)
	id 5F1E9408C1; Thu, 20 Aug 2026 22:02:05 +0100 (BST)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1787259721; bh=cm0vLWo1qcrimBzA2DAmVR1Cq2xP2T9QGWK+OlE8NYM=;
	h=From:To:Cc:Subject:Date:From;
	b=c924YB7DD9d75lreVCUrJ+gyGTeFIfJ4GHCPbcSyoAuqPf062Bp4OH3RymAfi8bFC
	 ha21DVNSZu/ZERAQP8Mb0LWB/v1MIcZ7qdzkfMh3JPTbrHOhIL1z3T1cWythyrSKgz
	 qiOeY6f8mMRLpOtQMyDWuJAeoZAcozn07EKM1JRv7OOjU2T4/Ie/vkMWql7bMmlJan
	 bQFqFfmWy9PNoLnZGI2+ikjI3nsFJ/ufhJtxFIGvUI+aOBJeOY4rRP99eABVhW35Ve
	 IgrUJnJynXFUIkeXVCjyr08fMNARqh3Twmtc23MSxMUul7E2GvBHMf5v6tLrkQ8TZE
	 Zm/8h6bpq13Vg==
Received: from maru.home (host86-154-188-238.range86-154.btcentralplus.com [86.154.188.238])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by extorris.mess.org (Postfix) with ESMTPSA id 58A3540170;
	Thu, 20 Aug 2026 22:02:01 +0100 (BST)
From: Sean Young <sean@mess.org>
To: linux-kernel@vger.kernel.org,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Shuah Khan <shuah@kernel.org>
Cc: Sean Young <sean@mess.org>,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v2] selftests/bpf: convert lirc_mode2 to prog_tests and extend coverage
Date: Thu, 20 Aug 2026 22:01:52 +0100
Message-ID: <20260820210156.50603-1-sean@mess.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While porting, extend coverage of the BPF_LIRC_MODE2 attach/detach/
query API:

 - bpf_prog_attach() with invalid flags is rejected with -EINVAL
   and does not attach the program
 - bpf_prog_query() with invalid flags is rejected with -EINVAL
   without disturbing existing attachments
 - bpf_prog_query() reports the correct program id, not just count,
   at each step, via bpf_prog_get_info_by_fd()
 - a lirc chardev can hold more than one attached program: load a
   second, independent instance, attach it alongside the first,
   confirm both are reported by bpf_prog_query(), then detach it
   without disturbing the first program's attachment
 - detaching an already-detached program consistently fails with
   -ENOENT, for both the first and second program

Signed-off-by: Sean Young <sean@mess.org>
Assisted-by: Claude:claude-sonnet-5
---
Since v1:
 - Remove obsolete test_lirc_mode2_user.c file
 - Use SYS_NOFAIL() rather than system()
 - Fix comment formatting
 - Fix leaks in error paths
    
 tools/testing/selftests/bpf/.gitignore        |   1 -
 tools/testing/selftests/bpf/Makefile          |   3 -
 .../selftests/bpf/prog_tests/lirc_mode2.c     | 334 ++++++++++++++++++
 .../testing/selftests/bpf/progs/lirc_mode2.c  |  32 ++
 .../bpf/progs/test_lirc_mode2_kern.c          |  26 --
 .../testing/selftests/bpf/test_lirc_mode2.sh  |  41 ---
 .../selftests/bpf/test_lirc_mode2_user.c      | 177 ----------
 7 files changed, 366 insertions(+), 248 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/lirc_mode2.c
 create mode 100644 tools/testing/selftests/bpf/progs/lirc_mode2.c
 delete mode 100644 tools/testing/selftests/bpf/progs/test_lirc_mode2_kern.c
 delete mode 100755 tools/testing/selftests/bpf/test_lirc_mode2.sh
 delete mode 100644 tools/testing/selftests/bpf/test_lirc_mode2_user.c

diff --git a/tools/testing/selftests/bpf/.gitignore b/tools/testing/selftests/bpf/.gitignore
index 986a6389186b..b815bf0d8877 100644
--- a/tools/testing/selftests/bpf/.gitignore
+++ b/tools/testing/selftests/bpf/.gitignore
@@ -17,7 +17,6 @@ test_verifier_log
 feature
 urandom_read
 test_sockmap
-test_lirc_mode2_user
 flow_dissector_load
 test_tcpnotify_user
 test_libbpf
diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 2b2f93dec474..f8ec0f574559 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -123,7 +123,6 @@ TEST_FILES = xsk_prereqs.sh $(wildcard progs/btf_dump_test_case_*.c)
 
 # Order correspond to 'make run_tests' order
 TEST_PROGS := test_kmod.sh \
-	test_lirc_mode2.sh \
 	test_bpftool_build.sh \
 	test_doc_build.sh \
 	test_xsk.sh \
@@ -141,7 +140,6 @@ TEST_GEN_PROGS_EXTENDED = \
 	bench \
 	flow_dissector_load \
 	test_cpp \
-	test_lirc_mode2_user \
 	veristat \
 	xdp_features \
 	xdp_hw_metadata \
@@ -338,7 +336,6 @@ $(OUTPUT)/test_sockmap: $(CGROUP_HELPERS) $(TESTING_HELPERS)
 $(OUTPUT)/test_tcpnotify_user: $(CGROUP_HELPERS) $(TESTING_HELPERS) $(TRACE_HELPERS)
 $(OUTPUT)/test_sock_fields: $(CGROUP_HELPERS) $(TESTING_HELPERS)
 $(OUTPUT)/test_tag: $(TESTING_HELPERS)
-$(OUTPUT)/test_lirc_mode2_user: $(TESTING_HELPERS)
 $(OUTPUT)/flow_dissector_load: $(TESTING_HELPERS)
 $(OUTPUT)/test_maps: $(TESTING_HELPERS)
 $(OUTPUT)/test_verifier: $(TESTING_HELPERS) $(CAP_HELPERS) $(UNPRIV_HELPERS)
diff --git a/tools/testing/selftests/bpf/prog_tests/lirc_mode2.c b/tools/testing/selftests/bpf/prog_tests/lirc_mode2.c
new file mode 100644
index 000000000000..8e485db70b78
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/lirc_mode2.c
@@ -0,0 +1,334 @@
+// SPDX-License-Identifier: GPL-2.0
+// test ir decoder
+//
+// Copyright (C) 2018 Sean Young <sean@mess.org>
+
+// A lirc chardev is a device representing a consumer IR (cir) device which
+// can receive infrared signals from remote control and/or transmit IR.
+//
+// IR is sent as a series of pulses and space somewhat like morse code. The
+// BPF program can decode this into scancodes so that rc-core can translate
+// this into input key codes using the rc keymap.
+//
+// This test works by sending IR over rc-loopback, so the IR is processed by
+// BPF and then decoded into scancodes. The lirc chardev must be the one
+// associated with rc-loopback, see the output of ir-keytable(1).
+//
+// The following CONFIG options must be enabled for the test to succeed:
+// CONFIG_RC_CORE=y
+// CONFIG_BPF_RAWIR_EVENT=y
+// CONFIG_RC_LOOPBACK=y
+// CONFIG_LIRC=y
+
+#include <linux/input.h>
+#include <linux/lirc.h>
+#include <glob.h>
+#include <limits.h>
+#include <poll.h>
+#include <test_progs.h>
+#include "lirc_mode2.skel.h"
+
+/*
+ * Read the DEVNAME= line out of the first uevent file that matches
+ * pattern, and turn it into a /dev/<name> path.
+ */
+static bool find_devname(const char *pattern, char *path, size_t path_sz)
+{
+	glob_t gl = {};
+	bool found = false;
+	FILE *f;
+
+	if (glob(pattern, 0, NULL, &gl) || gl.gl_pathc == 0)
+		goto out;
+
+	f = fopen(gl.gl_pathv[0], "r");
+	if (!f)
+		goto out;
+
+	char line[256];
+
+	while (fgets(line, sizeof(line), f)) {
+		char *val;
+
+		if (strncmp(line, "DEVNAME=", 8))
+			continue;
+
+		val = line + 8;
+		val[strcspn(val, "\n")] = '\0';
+		snprintf(path, path_sz, "/dev/%s", val);
+		found = true;
+		break;
+	}
+
+	fclose(f);
+out:
+	globfree(&gl);
+	return found;
+}
+
+/* Load rc-loopback and find the lirc and input chardevs it created. */
+static bool find_loopback_devices(char *lirc_path, char *input_path,
+				  size_t path_sz)
+{
+	glob_t gl = {};
+	bool found = false;
+
+	/* Ignore failure, we check for the resulting devices below. */
+	SYS_NOFAIL("modprobe rc-loopback > /dev/null 2>&1");
+
+	if (glob("/sys/class/rc/rc*", 0, NULL, &gl))
+		goto out;
+
+	for (size_t i = 0; i < gl.gl_pathc; i++) {
+		const char *rcdir = gl.gl_pathv[i];
+		char uevent_path[PATH_MAX];
+		char uevent[4096];
+		char pattern[PATH_MAX];
+		FILE *f;
+		size_t n;
+
+		snprintf(uevent_path, sizeof(uevent_path), "%s/uevent", rcdir);
+		f = fopen(uevent_path, "r");
+		if (!f)
+			continue;
+		n = fread(uevent, 1, sizeof(uevent) - 1, f);
+		fclose(f);
+		uevent[n] = '\0';
+
+		if (!strstr(uevent, "DRV_NAME=rc-loopback"))
+			continue;
+
+		snprintf(pattern, sizeof(pattern), "%s/lirc*/uevent", rcdir);
+		if (!find_devname(pattern, lirc_path, path_sz))
+			continue;
+
+		snprintf(pattern, sizeof(pattern), "%s/input*/event*/uevent", rcdir);
+		if (!find_devname(pattern, input_path, path_sz))
+			continue;
+
+		found = true;
+		break;
+	}
+
+out:
+	if (!found) {
+		fprintf(stderr, "No rc devices found\n");
+		fprintf(stderr, "Enable CONFIG_RC_LOOPBACK, CONFIG_RC_LOOPBACK, and CONFIG_LIRC\n");
+?	}
+
+	globfree(&gl);
+	return found;
+}
+
+void test_lirc_mode2(void)
+{
+	char lirc_path[PATH_MAX], input_path[PATH_MAX];
+	int lircfd = -1, inputfd = -1, progfd, progfd2 = -1;
+	struct lirc_mode2 *skel = NULL, *skel2 = NULL;
+	__u32 prog_ids[10], prog_flags[10], prog_cnt;
+	struct bpf_prog_info info;
+	__u32 info_len, prog_id, prog_id2;
+	int testir1 = 0x8ead;	/* keydown flag (0x8000) | scancode 0xead */
+	int testir2 = 0x4081;	/* pointer_rel flag (0x4000) | rel_x=1 | rel_y=1 */
+	struct input_event event;
+	struct pollfd pfd = {};
+	int ret;
+
+	if (getuid() != 0) {
+		test__skip();
+		return;
+	}
+
+	if (!find_loopback_devices(lirc_path, input_path, sizeof(lirc_path))) {
+		test__skip();
+		return;
+	}
+
+	skel = lirc_mode2__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "lirc_mode2__open_and_load"))
+		return;
+
+	progfd = bpf_program__fd(skel->progs.bpf_decoder);
+
+	memset(&info, 0, sizeof(info));
+	info_len = sizeof(info);
+	ret = bpf_prog_get_info_by_fd(progfd, &info, &info_len);
+	if (!ASSERT_OK(ret, "get first program's info"))
+		goto out;
+	prog_id = info.id;
+
+	lircfd = open(lirc_path, O_RDWR | O_NONBLOCK);
+	if (!ASSERT_GE(lircfd, 0, "open lirc device"))
+		goto out;
+
+	/* Try to detach it before it was ever attached, should fail. */
+	ret = bpf_prog_detach2(progfd, lircfd, BPF_LIRC_MODE2);
+	if (!ASSERT_EQ(ret, -ENOENT, "detach unattached program"))
+		goto out;
+
+	inputfd = open(input_path, O_RDONLY | O_NONBLOCK);
+	if (!ASSERT_GE(inputfd, 0, "open input device"))
+		goto out;
+
+	prog_cnt = ARRAY_SIZE(prog_ids);
+	ret = bpf_prog_query(lircfd, BPF_LIRC_MODE2, 0, prog_flags, prog_ids,
+			     &prog_cnt);
+	if (!ASSERT_OK(ret, "query programs before attach"))
+		goto out;
+	if (!ASSERT_EQ(prog_cnt, 0, "no programs should be attached yet"))
+		goto out;
+
+	/* Invalid attach flags must be rejected, and must not attach. */
+	ret = bpf_prog_attach(progfd, lircfd, BPF_LIRC_MODE2, 1);
+	if (!ASSERT_EQ(ret, -EINVAL, "attach with invalid flags"))
+		goto out;
+
+	prog_cnt = ARRAY_SIZE(prog_ids);
+	ret = bpf_prog_query(lircfd, BPF_LIRC_MODE2, 0, prog_flags, prog_ids,
+			     &prog_cnt);
+	if (!ASSERT_OK(ret, "query programs after rejected attach"))
+		goto out;
+	if (!ASSERT_EQ(prog_cnt, 0, "rejected attach should not attach"))
+		goto out;
+
+	ret = bpf_prog_attach(progfd, lircfd, BPF_LIRC_MODE2, 0);
+	if (!ASSERT_OK(ret, "attach program to lirc device"))
+		goto out;
+
+	/* Invalid query flags must be rejected too, without upsetting state. */
+	prog_cnt = ARRAY_SIZE(prog_ids);
+	ret = bpf_prog_query(lircfd, BPF_LIRC_MODE2, 1, prog_flags, prog_ids,
+			     &prog_cnt);
+	ASSERT_EQ(ret, -EINVAL, "query with invalid flags");
+
+	prog_cnt = ARRAY_SIZE(prog_ids);
+	ret = bpf_prog_query(lircfd, BPF_LIRC_MODE2, 0, prog_flags, prog_ids,
+			     &prog_cnt);
+	if (!ASSERT_OK(ret, "query programs after attach"))
+		goto out_detach;
+	if (!ASSERT_EQ(prog_cnt, 1, "one program should be attached"))
+		goto out_detach;
+	ASSERT_EQ(prog_ids[0], prog_id, "queried id should match attached program");
+
+	/* Write raw IR */
+	ret = write(lircfd, &testir1, sizeof(testir1));
+	if (!ASSERT_EQ(ret, sizeof(testir1), "send test IR message 1"))
+		goto out_detach;
+
+	pfd.fd = inputfd;
+	pfd.events = POLLIN;
+
+	for (;;) {
+		poll(&pfd, 1, 100);
+
+		/* Read decoded IR */
+		ret = read(inputfd, &event, sizeof(event));
+		if (!ASSERT_EQ(ret, sizeof(event), "read decoded IR 1"))
+			goto out_detach;
+
+		if (event.type == EV_MSC && event.code == MSC_SCAN &&
+		    event.value == 0xead)
+			break;
+	}
+
+	/* Write raw IR */
+	ret = write(lircfd, &testir2, sizeof(testir2));
+	if (!ASSERT_EQ(ret, sizeof(testir2), "send test IR message 2"))
+		goto out_detach;
+
+	for (;;) {
+		poll(&pfd, 1, 100);
+
+		/* Read decoded IR */
+		ret = read(inputfd, &event, sizeof(event));
+		if (!ASSERT_EQ(ret, sizeof(event), "read decoded IR 2"))
+			goto out_detach;
+
+		if (event.type == EV_REL && event.code == REL_Y &&
+		    event.value == 1)
+			break;
+	}
+
+	prog_cnt = ARRAY_SIZE(prog_ids);
+	ret = bpf_prog_query(lircfd, BPF_LIRC_MODE2, 0, prog_flags, prog_ids,
+			     &prog_cnt);
+	if (!ASSERT_OK(ret, "query programs after IR was decoded"))
+		goto out_detach;
+	if (!ASSERT_EQ(prog_cnt, 1, "one program should still be attached"))
+		goto out_detach;
+
+	/*
+	 * The lirc chardev can hold more than one attached program at once.
+	 * Load a second, independent instance and check it can be attached
+	 * alongside the first, queried, and then detached on its own
+	 * without disturbing the first program's attachment.
+	 */
+	skel2 = lirc_mode2__open_and_load();
+	if (!ASSERT_OK_PTR(skel2, "lirc_mode2__open_and_load (2nd)"))
+		goto out_detach;
+
+	progfd2 = bpf_program__fd(skel2->progs.bpf_decoder);
+
+	memset(&info, 0, sizeof(info));
+	info_len = sizeof(info);
+	ret = bpf_prog_get_info_by_fd(progfd2, &info, &info_len);
+	if (!ASSERT_OK(ret, "get second program's info"))
+		goto out_detach;
+	prog_id2 = info.id;
+
+	ret = bpf_prog_attach(progfd2, lircfd, BPF_LIRC_MODE2, 0);
+	if (!ASSERT_OK(ret, "attach second program to lirc device"))
+		goto out_detach;
+
+	prog_cnt = ARRAY_SIZE(prog_ids);
+	ret = bpf_prog_query(lircfd, BPF_LIRC_MODE2, 0, prog_flags, prog_ids,
+			     &prog_cnt);
+	if (!ASSERT_OK(ret, "query programs after second attach"))
+		goto out_detach2;
+	if (!ASSERT_EQ(prog_cnt, 2, "two programs should be attached"))
+		goto out_detach2;
+	ASSERT_TRUE((prog_ids[0] == prog_id && prog_ids[1] == prog_id2) ||
+		    (prog_ids[0] == prog_id2 && prog_ids[1] == prog_id),
+		    "queried ids should be the two attached programs");
+
+	/* Detach the second program; the first should remain attached. */
+	ret = bpf_prog_detach2(progfd2, lircfd, BPF_LIRC_MODE2);
+	if (!ASSERT_OK(ret, "detach second program"))
+		goto out_detach2;
+
+	/* Detaching an already-detached program should now fail. */
+	ret = bpf_prog_detach2(progfd2, lircfd, BPF_LIRC_MODE2);
+	ASSERT_EQ(ret, -ENOENT, "detach second program again");
+
+	prog_cnt = ARRAY_SIZE(prog_ids);
+	ret = bpf_prog_query(lircfd, BPF_LIRC_MODE2, 0, prog_flags, prog_ids,
+			     &prog_cnt);
+	if (!ASSERT_OK(ret, "query programs after second detach"))
+		goto out_detach;
+	if (!ASSERT_EQ(prog_cnt, 1, "one program should remain attached"))
+		goto out_detach;
+	ASSERT_EQ(prog_ids[0], prog_id, "remaining program should be the first one");
+
+out_detach:
+	/* Let's try detaching it now it is actually attached. */
+	ret = bpf_prog_detach2(progfd, lircfd, BPF_LIRC_MODE2);
+	ASSERT_OK(ret, "detach program from lirc device");
+
+	/* Detaching it again should now fail the same way. */
+	ret = bpf_prog_detach2(progfd, lircfd, BPF_LIRC_MODE2);
+	ASSERT_EQ(ret, -ENOENT, "detach program from lirc device again");
+	goto out;
+
+out_detach2:
+	/* Best-effort cleanup of the second program before bailing out. */
+	bpf_prog_detach2(progfd2, lircfd, BPF_LIRC_MODE2);
+	goto out_detach;
+
+out:
+	if (inputfd >= 0)
+		close(inputfd);
+	if (lircfd >= 0)
+		close(lircfd);
+	lirc_mode2__destroy(skel2);
+	lirc_mode2__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/lirc_mode2.c b/tools/testing/selftests/bpf/progs/lirc_mode2.c
new file mode 100644
index 000000000000..98137f3c5c03
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/lirc_mode2.c
@@ -0,0 +1,32 @@
+// SPDX-License-Identifier: GPL-2.0
+// test ir decoder
+//
+// Copyright (C) 2018 Sean Young <sean@mess.org>
+
+#include <linux/bpf.h>
+#include <linux/lirc.h>
+#include <bpf/bpf_helpers.h>
+
+SEC("lirc_mode2")
+int bpf_decoder(unsigned int *sample)
+{
+	if (LIRC_IS_PULSE(*sample)) {
+		unsigned int duration = LIRC_VALUE(*sample);
+
+		/*
+		 * Flag bits picked deliberately low: rc-loopback simulates
+		 * a receiver overflow for any pulse over MS_TO_US(50) (see
+		 * loop_tx_ir() in rc-loopback.c), which would silently
+		 * swallow the sample before it ever reaches this decoder.
+		 */
+		if (duration & 0x8000)
+			bpf_rc_keydown(sample, 0x40, duration & 0x3fff, 0);
+		if (duration & 0x4000)
+			bpf_rc_pointer_rel(sample, (duration >> 7) & 0x7f,
+					   duration & 0x7f);
+	}
+
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/test_lirc_mode2_kern.c b/tools/testing/selftests/bpf/progs/test_lirc_mode2_kern.c
deleted file mode 100644
index cbe4284c032f..000000000000
--- a/tools/testing/selftests/bpf/progs/test_lirc_mode2_kern.c
+++ /dev/null
@@ -1,26 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-// test ir decoder
-//
-// Copyright (C) 2018 Sean Young <sean@mess.org>
-
-#include <linux/bpf.h>
-#include <linux/lirc.h>
-#include <bpf/bpf_helpers.h>
-
-SEC("lirc_mode2")
-int bpf_decoder(unsigned int *sample)
-{
-	if (LIRC_IS_PULSE(*sample)) {
-		unsigned int duration = LIRC_VALUE(*sample);
-
-		if (duration & 0x1000)
-			bpf_rc_keydown(sample, 0x40, duration & 0xffff, 0);
-		if (duration & 0x2000)
-			bpf_rc_pointer_rel(sample, (duration >> 8) & 0xff,
-					   duration & 0xff);
-	}
-
-	return 0;
-}
-
-char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/test_lirc_mode2.sh b/tools/testing/selftests/bpf/test_lirc_mode2.sh
deleted file mode 100755
index 5252b91f48a1..000000000000
--- a/tools/testing/selftests/bpf/test_lirc_mode2.sh
+++ /dev/null
@@ -1,41 +0,0 @@
-#!/bin/bash
-# SPDX-License-Identifier: GPL-2.0
-
-# Kselftest framework requirement - SKIP code is 4.
-ksft_skip=4
-ret=$ksft_skip
-
-msg="skip all tests:"
-if [ $UID != 0 ]; then
-	echo $msg please run this as root >&2
-	exit $ksft_skip
-fi
-
-GREEN='\033[0;92m'
-RED='\033[0;31m'
-NC='\033[0m' # No Color
-
-modprobe rc-loopback
-
-for i in /sys/class/rc/rc*
-do
-	if grep -q DRV_NAME=rc-loopback $i/uevent
-	then
-		LIRCDEV=$(grep DEVNAME= $i/lirc*/uevent | sed sQDEVNAME=Q/dev/Q)
-		INPUTDEV=$(grep DEVNAME= $i/input*/event*/uevent | sed sQDEVNAME=Q/dev/Q)
-	fi
-done
-
-if [ -n "$LIRCDEV" ];
-then
-	TYPE=lirc_mode2
-	./test_lirc_mode2_user $LIRCDEV $INPUTDEV
-	ret=$?
-	if [ $ret -ne 0 ]; then
-		echo -e ${RED}"FAIL: $TYPE"${NC}
-	else
-		echo -e ${GREEN}"PASS: $TYPE"${NC}
-	fi
-fi
-
-exit $ret
diff --git a/tools/testing/selftests/bpf/test_lirc_mode2_user.c b/tools/testing/selftests/bpf/test_lirc_mode2_user.c
deleted file mode 100644
index cd191da20d14..000000000000
--- a/tools/testing/selftests/bpf/test_lirc_mode2_user.c
+++ /dev/null
@@ -1,177 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-// test ir decoder
-//
-// Copyright (C) 2018 Sean Young <sean@mess.org>
-
-// A lirc chardev is a device representing a consumer IR (cir) device which
-// can receive infrared signals from remote control and/or transmit IR.
-//
-// IR is sent as a series of pulses and space somewhat like morse code. The
-// BPF program can decode this into scancodes so that rc-core can translate
-// this into input key codes using the rc keymap.
-//
-// This test works by sending IR over rc-loopback, so the IR is processed by
-// BPF and then decoded into scancodes. The lirc chardev must be the one
-// associated with rc-loopback, see the output of ir-keytable(1).
-//
-// The following CONFIG options must be enabled for the test to succeed:
-// CONFIG_RC_CORE=y
-// CONFIG_BPF_RAWIR_EVENT=y
-// CONFIG_RC_LOOPBACK=y
-
-// Steps:
-// 1. Open the /dev/lircN device for rc-loopback (given on command line)
-// 2. Attach bpf_lirc_mode2 program which decodes some IR.
-// 3. Send some IR to the same IR device; since it is loopback, this will
-//    end up in the bpf program
-// 4. bpf program should decode IR and report keycode
-// 5. We can read keycode from same /dev/lirc device
-
-#include <linux/bpf.h>
-#include <linux/input.h>
-#include <errno.h>
-#include <stdio.h>
-#include <stdlib.h>
-#include <string.h>
-#include <unistd.h>
-#include <poll.h>
-#include <sys/types.h>
-#include <sys/ioctl.h>
-#include <sys/stat.h>
-#include <fcntl.h>
-
-#include "bpf_util.h"
-#include <bpf/bpf.h>
-#include <bpf/libbpf.h>
-
-#include "testing_helpers.h"
-
-int main(int argc, char **argv)
-{
-	struct bpf_object *obj;
-	int ret, lircfd, progfd, inputfd;
-	int testir1 = 0x1ead;
-	int testir2 = 0x2101;
-	u32 prog_ids[10], prog_flags[10], prog_cnt;
-
-	if (argc != 3) {
-		printf("Usage: %s /dev/lircN /dev/input/eventM\n", argv[0]);
-		return 2;
-	}
-
-	ret = bpf_prog_test_load("test_lirc_mode2_kern.bpf.o",
-				 BPF_PROG_TYPE_LIRC_MODE2, &obj, &progfd);
-	if (ret) {
-		printf("Failed to load bpf program\n");
-		return 1;
-	}
-
-	lircfd = open(argv[1], O_RDWR | O_NONBLOCK);
-	if (lircfd == -1) {
-		printf("failed to open lirc device %s: %m\n", argv[1]);
-		return 1;
-	}
-
-	/* Let's try detach it before it was ever attached */
-	ret = bpf_prog_detach2(progfd, lircfd, BPF_LIRC_MODE2);
-	if (ret != -ENOENT) {
-		printf("bpf_prog_detach2 not attached should fail: %m\n");
-		return 1;
-	}
-
-	inputfd = open(argv[2], O_RDONLY | O_NONBLOCK);
-	if (inputfd == -1) {
-		printf("failed to open input device %s: %m\n", argv[1]);
-		return 1;
-	}
-
-	prog_cnt = 10;
-	ret = bpf_prog_query(lircfd, BPF_LIRC_MODE2, 0, prog_flags, prog_ids,
-			     &prog_cnt);
-	if (ret) {
-		printf("Failed to query bpf programs on lirc device: %m\n");
-		return 1;
-	}
-
-	if (prog_cnt != 0) {
-		printf("Expected nothing to be attached\n");
-		return 1;
-	}
-
-	ret = bpf_prog_attach(progfd, lircfd, BPF_LIRC_MODE2, 0);
-	if (ret) {
-		printf("Failed to attach bpf to lirc device: %m\n");
-		return 1;
-	}
-
-	/* Write raw IR */
-	ret = write(lircfd, &testir1, sizeof(testir1));
-	if (ret != sizeof(testir1)) {
-		printf("Failed to send test IR message: %m\n");
-		return 1;
-	}
-
-	struct pollfd pfd = { .fd = inputfd, .events = POLLIN };
-	struct input_event event;
-
-	for (;;) {
-		poll(&pfd, 1, 100);
-
-		/* Read decoded IR */
-		ret = read(inputfd, &event, sizeof(event));
-		if (ret != sizeof(event)) {
-			printf("Failed to read decoded IR: %m\n");
-			return 1;
-		}
-
-		if (event.type == EV_MSC && event.code == MSC_SCAN &&
-		    event.value == 0x1ead) {
-			break;
-		}
-	}
-
-	/* Write raw IR */
-	ret = write(lircfd, &testir2, sizeof(testir2));
-	if (ret != sizeof(testir2)) {
-		printf("Failed to send test IR message: %m\n");
-		return 1;
-	}
-
-	for (;;) {
-		poll(&pfd, 1, 100);
-
-		/* Read decoded IR */
-		ret = read(inputfd, &event, sizeof(event));
-		if (ret != sizeof(event)) {
-			printf("Failed to read decoded IR: %m\n");
-			return 1;
-		}
-
-		if (event.type == EV_REL && event.code == REL_Y &&
-		    event.value == 1 ) {
-			break;
-		}
-	}
-
-	prog_cnt = 10;
-	ret = bpf_prog_query(lircfd, BPF_LIRC_MODE2, 0, prog_flags, prog_ids,
-			     &prog_cnt);
-	if (ret) {
-		printf("Failed to query bpf programs on lirc device: %m\n");
-		return 1;
-	}
-
-	if (prog_cnt != 1) {
-		printf("Expected one program to be attached\n");
-		return 1;
-	}
-
-	/* Let's try detaching it now it is actually attached */
-	ret = bpf_prog_detach2(progfd, lircfd, BPF_LIRC_MODE2);
-	if (ret) {
-		printf("bpf_prog_detach2: returned %m\n");
-		return 1;
-	}
-
-	return 0;
-}
-- 
2.55.0

