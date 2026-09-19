Received: from out-2z4y-a165.jellyfish.systems (out-2z4y-a165.jellyfish.systems [198.54.127.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D8AE39A047
	for <bpf@vger.kernel.org>; Sat, 19 Sep 2026 11:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.54.127.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789816400; cv=none; b=MhVYIqcelxLn9n+FgjUdkqIgoNnfJ7f9k01YHn8ewR6SxQMQrNTmCiuDrtfQk5N/xwbdY14Xk35hdbHi4/GqNIGo0XGg8j47uzoSWhzsXktEVuLen1As1PGhm3mMndT2kTbHM8D5+xMpmMg2uFRZbHfSDMLVWcigorNrnSKNP9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789816400; c=relaxed/simple;
	bh=8ZqzPKBrNXlkaFStyUiGwHAoIgPxs6Js4dZXgYnqmZI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=czE5Dk/ve8RmIwnEtXyZsJijHRlMOUO5Shq7VGFpMGILgOGZbBLcDdK4caJDiBGbefHo5PS7H1dDGD3eYTaPHzx44Tepk4ia/oz9y18PckV+yI6GPlePjnPWqllCD5f0UWq+Eg8eygrigxrs0VVREKcRsKpIMMqRpnPaYk/r5EY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tychen.cc; spf=pass smtp.mailfrom=tychen.cc; dkim=pass (2048-bit key) header.d=tychen.cc header.i=@tychen.cc header.b=gXJS6LFF; arc=none smtp.client-ip=198.54.127.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tychen.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tychen.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tychen.cc header.i=@tychen.cc header.b="gXJS6LFF"
Received: from fedora (unknown [39.144.124.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.spacemail.com (Postfix) with ESMTPSA id 4hn6Cd31NYz8sWP;
	Sat, 19 Sep 2026 11:07:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tychen.cc;
	s=spacemail; t=1789816069;
	bh=nzrM1vpCJqEySvD6t7CjbcRpxbldiz3X3cLc5IrTfjQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gXJS6LFFC9wjxkY0MFR625Sx7uXZ0dLlwC0pfsto3TH++fXYhaiK73/lx2lHW2WcW
	 5iP7NY7Om/QXINXW1X+tbsUFe1VJZIXmLOy6kE7KpMEkNiKd4XMuh1VeaR0jUBYGA9
	 /2pX4it8psueb2fxaoVI3iyx8+b3zqcy1sPUOd7d6gACok7KUKo4h22ett7UlD4fFJ
	 HIjEQ7HhOMxwPhoUsf00w8kke0PtvHX1MjZ00VQZEG3Uoqch6rG49oq7ZLcav+ABuZ
	 3XS3Lm8v4sa7JDr8yBsRq8UTE4HWehKPJWmH7Ksb3Mu2Do5eZVzYfzbfiCbDXngYSl
	 1SzmonM7s1Igg==
From: Tianyi Chen <hi@tychen.cc>
To: bpf@vger.kernel.org
Cc: qmo@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	ihor.solodrai@linux.dev,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next v4 2/2] selftests/bpf: Cover bpftool ring buffer event_pipe
Date: Sat, 19 Sep 2026 19:07:21 +0800
Message-ID: <20260919110721.1230756-3-hi@tychen.cc>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260919110721.1230756-1-hi@tychen.cc>
References: <20260919110721.1230756-1-hi@tychen.cc>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Envelope-From: hi@tychen.cc

Produce known ring buffer records and check complete plain, JSON and
pretty JSON output. Exercise ID and pinned map selection, SIGINT and
SIGTERM shutdown, empty streams and invalid map types or selectors.

Also produce a perf event sample and check its existing header and raw
payload output. Use a payload whose size plus the raw sample length
field is aligned to eight bytes so the expected bytes exclude implicit
perf padding.

Assisted-by: LLM
Signed-off-by: Tianyi Chen <hi@tychen.cc>
---
 tools/testing/selftests/bpf/bpftool_helpers.c |   2 +-
 tools/testing/selftests/bpf/bpftool_helpers.h |   1 +
 .../bpf/prog_tests/bpftool_ringbuf.c          | 417 ++++++++++++++++++
 .../selftests/bpf/progs/bpftool_ringbuf.c     |  47 ++
 4 files changed, 466 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/bpftool_ringbuf.c
 create mode 100644 tools/testing/selftests/bpf/progs/bpftool_ringbuf.c

diff --git a/tools/testing/selftests/bpf/bpftool_helpers.c b/tools/testing/selftests/bpf/bpftool_helpers.c
index c49fdd90eb03..9380b24bbf52 100644
--- a/tools/testing/selftests/bpf/bpftool_helpers.c
+++ b/tools/testing/selftests/bpf/bpftool_helpers.c
@@ -11,7 +11,7 @@
 
 #define BPFTOOL_DEFAULT_PATH		"tools/sbin/bpftool"
 
-static int detect_bpftool_path(char *buffer, size_t size)
+int detect_bpftool_path(char *buffer, size_t size)
 {
 	char tmp[PATH_MAX];
 	const char *env_path;
diff --git a/tools/testing/selftests/bpf/bpftool_helpers.h b/tools/testing/selftests/bpf/bpftool_helpers.h
index dec1ba201410..17e3be8e7073 100644
--- a/tools/testing/selftests/bpf/bpftool_helpers.h
+++ b/tools/testing/selftests/bpf/bpftool_helpers.h
@@ -7,5 +7,6 @@
 
 #define MAX_BPFTOOL_CMD_LEN	(256)
 
+int detect_bpftool_path(char *buffer, size_t size);
 int run_bpftool_command(char *args);
 int get_bpftool_command_output(char *args, char *output_buf, size_t output_max_len);
diff --git a/tools/testing/selftests/bpf/prog_tests/bpftool_ringbuf.c b/tools/testing/selftests/bpf/prog_tests/bpftool_ringbuf.c
new file mode 100644
index 000000000000..e9724c55d1dc
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/bpftool_ringbuf.c
@@ -0,0 +1,417 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <ctype.h>
+#include <fcntl.h>
+#include <poll.h>
+#include <signal.h>
+#include <sys/mman.h>
+#include <sys/wait.h>
+#include <test_progs.h>
+#include "bpftool_helpers.h"
+#include "bpftool_ringbuf.skel.h"
+
+#define WAIT_STEPS 500
+#define WAIT_US 10000
+
+struct consumer {
+	pid_t pid;
+	int fd;
+};
+
+static void consumer_cleanup(struct consumer *child)
+{
+	if (child->pid > 0) {
+		kill(child->pid, SIGKILL);
+		while (waitpid(child->pid, NULL, 0) < 0 && errno == EINTR)
+			;
+		child->pid = -1;
+	}
+	if (child->fd >= 0) {
+		close(child->fd);
+		child->fd = -1;
+	}
+}
+
+static bool consumer_start(struct consumer *child, int map_fd, const char *format,
+			   const char *pin_path, const char *option,
+			   bool pair, bool capture_errors)
+{
+	struct bpf_map_info info = {};
+	__u32 len = sizeof(info);
+	char path[PATH_MAX];
+	char *argv[12], id[16];
+	int out[2], ready[2], n = 0, err, err_fd;
+	struct pollfd pfd;
+
+	if (!ASSERT_OK(detect_bpftool_path(path, sizeof(path)), "bpftool path") ||
+	    !ASSERT_OK(bpf_map_get_info_by_fd(map_fd, &info, &len), "map info"))
+		return false;
+	snprintf(id, sizeof(id), "%u", info.id);
+	argv[n++] = path;
+	if (format)
+		argv[n++] = (char *)format;
+	argv[n++] = "map";
+	argv[n++] = "event_pipe";
+	argv[n++] = pin_path ? "pinned" : "id";
+	argv[n++] = pin_path ? (char *)pin_path : id;
+	if (option) {
+		argv[n++] = (char *)option;
+		argv[n++] = "0";
+		if (pair) {
+			argv[n++] = "index";
+			argv[n++] = "0";
+		}
+	}
+	argv[n] = NULL;
+	if (!ASSERT_OK(pipe2(out, O_CLOEXEC), "output pipe"))
+		return false;
+	if (!ASSERT_OK(pipe2(ready, O_CLOEXEC), "exec pipe")) {
+		close(out[0]);
+		close(out[1]);
+		return false;
+	}
+	child->pid = fork();
+	if (!child->pid) {
+		close(out[0]);
+		close(ready[0]);
+		err_fd = capture_errors ? out[1] : open("/dev/null", O_WRONLY);
+		if (dup2(out[1], STDOUT_FILENO) < 0 ||
+		    dup2(err_fd, STDERR_FILENO) < 0)
+			goto exec_fail;
+		if (!capture_errors)
+			close(err_fd);
+		close(out[1]);
+		execv(path, argv);
+exec_fail:
+		err = errno;
+		if (write(ready[1], &err, sizeof(err)) != sizeof(err))
+			_exit(126);
+		_exit(127);
+	}
+	close(out[1]);
+	close(ready[1]);
+	child->fd = out[0];
+	pfd = (struct pollfd) { .fd = ready[0], .events = POLLIN };
+	/* EOF on the close-on-exec pipe distinguishes exec from inherited handlers. */
+	err = child->pid > 0 ? poll(&pfd, 1, WAIT_STEPS * WAIT_US / 1000) : -1;
+	if (!ASSERT_GT(child->pid, 0, "fork") ||
+	    !ASSERT_GT(err, 0, "exec timeout") ||
+	    !ASSERT_EQ(read(ready[0], &err, sizeof(err)), 0, "exec")) {
+		close(ready[0]);
+		consumer_cleanup(child);
+		return false;
+	}
+	close(ready[0]);
+	return true;
+}
+
+static bool consumer_finish(struct consumer *child, int signo, bool success,
+			    char *output, size_t size)
+{
+	int status = 0, i;
+	pid_t ret = 0;
+	ssize_t n;
+	size_t used = 0;
+
+	if (!ASSERT_OK(fcntl(child->fd, F_SETFL, O_NONBLOCK), "nonblocking output"))
+		return false;
+	if (signo && !ASSERT_OK(kill(child->pid, signo), "signal consumer"))
+		return false;
+	for (i = 0; i < WAIT_STEPS; i++) {
+		while (used < size - 1 &&
+		       (n = read(child->fd, output + used, size - 1 - used)) > 0)
+			used += n;
+		ret = waitpid(child->pid, &status, WNOHANG);
+		if (ret == child->pid)
+			break;
+		if (ret < 0 && errno != EINTR)
+			break;
+		usleep(WAIT_US);
+	}
+	if (!ASSERT_EQ(ret, child->pid, "bounded consumer exit"))
+		return false;
+	child->pid = -1;
+	while (used < size - 1 && (n = read(child->fd, output + used, size - 1 - used)) > 0)
+		used += n;
+	output[used] = '\0';
+	return ASSERT_TRUE(WIFEXITED(status), "normal exit") &&
+	       ASSERT_EQ(WEXITSTATUS(status) == 0, success, "exit status");
+}
+
+static bool consumer_ready(struct consumer *child)
+{
+	unsigned long long caught;
+	char path[64], line[256];
+	int i;
+	FILE *f;
+
+	snprintf(path, sizeof(path), "/proc/%d/status", child->pid);
+	for (i = 0; i < WAIT_STEPS; i++) {
+		f = fopen(path, "r");
+		if (!f)
+			break;
+		while (fgets(line, sizeof(line), f)) {
+			if (sscanf(line, "SigCgt: %llx", &caught) == 1 &&
+			    (caught & (1ULL << (SIGINT - 1))) &&
+			    (caught & (1ULL << (SIGTERM - 1)))) {
+				fclose(f);
+				return true;
+			}
+		}
+		fclose(f);
+		usleep(WAIT_US);
+	}
+	return ASSERT_TRUE(false, "consumer signal handlers ready");
+}
+
+static bool emit_record(struct bpftool_ringbuf *skel, int record)
+{
+	char packet[64] = {};
+
+	LIBBPF_OPTS(bpf_test_run_opts, opts,
+		    .data_in = packet,
+		    .data_size_in = sizeof(packet),
+	);
+
+	skel->bss->record = record;
+	return ASSERT_OK(bpf_prog_test_run_opts(bpf_program__fd(skel->progs.produce),
+					      &opts), "produce record") &&
+	       ASSERT_OK(skel->bss->output_err, "ringbuf output");
+}
+
+static bool consumed(unsigned long *position, unsigned long expected)
+{
+	int i;
+
+	for (i = 0; i < WAIT_STEPS; i++) {
+		if (__atomic_load_n(position, __ATOMIC_ACQUIRE) == expected)
+			return true;
+		usleep(WAIT_US);
+	}
+	return ASSERT_EQ(*position, expected, "consumer position");
+}
+
+static void check_json(char *output, const char *expected)
+{
+	char *src = output, *dst = output;
+	bool quoted = false, escaped = false;
+
+	/* Ignore formatting whitespace while checking the entire JSON document. */
+	while (*src) {
+		if (quoted || !isspace((unsigned char)*src))
+			*dst++ = *src;
+		if (!escaped && *src == '"')
+			quoted = !quoted;
+		escaped = !escaped && quoted && *src == '\\';
+		src++;
+	}
+	*dst = '\0';
+	ASSERT_STREQ(output, expected, "JSON records");
+}
+
+static void test_consumer(const char *format, bool idle, int signo, bool pinned)
+{
+	struct consumer child = { .pid = -1, .fd = -1 };
+	struct bpftool_ringbuf *skel;
+	unsigned long *position = MAP_FAILED;
+	int page_size = getpagesize(), fd;
+	char pin_dir[] = "/sys/fs/bpf/bpftool_ringbuf_XXXXXX";
+	char pin_path[sizeof(pin_dir) + sizeof("/map")];
+	bool dir_created = false, map_pinned = false;
+	char output[4096];
+	struct pollfd pfd;
+
+	skel = bpftool_ringbuf__open();
+	if (!ASSERT_OK_PTR(skel, "open"))
+		return;
+	bpf_map__set_max_entries(skel->maps.ringbuf, page_size);
+	if (!ASSERT_OK(bpftool_ringbuf__load(skel), "load"))
+		goto out;
+	fd = bpf_map__fd(skel->maps.ringbuf);
+	if (pinned) {
+		if (!ASSERT_OK_PTR(mkdtemp(pin_dir), "create pin directory"))
+			goto out;
+		dir_created = true;
+		snprintf(pin_path, sizeof(pin_path), "%s/map", pin_dir);
+		if (!ASSERT_OK(bpf_obj_pin(fd, pin_path), "pin ringbuf"))
+			goto out;
+		map_pinned = true;
+	}
+	position = mmap(NULL, page_size, PROT_READ, MAP_SHARED, fd, 0);
+	if (!ASSERT_NEQ(position, MAP_FAILED, "consumer mmap"))
+		goto out;
+	if (!idle && (!emit_record(skel, 0) || !emit_record(skel, 1)))
+		goto out;
+	if (!consumer_start(&child, fd, format, pinned ? pin_path : NULL,
+			    NULL, false, false) ||
+	    !consumer_ready(&child))
+		goto out;
+	if (!idle) {
+		/* Both prefilled records occupy 16 bytes including their headers. */
+		if (!consumed(position, 32))
+			goto out;
+		pfd = (struct pollfd) { .fd = child.fd, .events = POLLIN };
+		if (!ASSERT_GT(poll(&pfd, 1, WAIT_STEPS * WAIT_US / 1000), 0,
+			       "records flushed before exit") ||
+		    !ASSERT_TRUE(pfd.revents & POLLIN, "record output readable") ||
+		    !emit_record(skel, 2) || !consumed(position, 64))
+			goto out;
+	}
+	if (!consumer_finish(&child, signo, true, output, sizeof(output)))
+		goto out;
+	if (format && !strcmp(format, "-p"))
+		ASSERT_STREQ(output, idle ? "[]\n" :
+			     "[{\n"
+			     "        \"size\": 2,\n"
+			     "        \"data\": [0,255\n"
+			     "        ]\n"
+			     "    },{\n"
+			     "        \"size\": 5,\n"
+			     "        \"data\": [1,2,3,4,5\n"
+			     "        ]\n"
+			     "    },{\n"
+			     "        \"size\": 17,\n"
+			     "        \"data\": [16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32\n"
+			     "        ]\n"
+			     "    }\n"
+			     "]\n", "pretty JSON records");
+	else if (format)
+		check_json(output, idle ? "[]" :
+			   "[{\"size\":2,\"data\":[0,255]},"
+			   "{\"size\":5,\"data\":[1,2,3,4,5]},"
+			   "{\"size\":17,\"data\":[16,17,18,19,20,21,22,23,"
+			   "24,25,26,27,28,29,30,31,32]}]");
+	else
+		ASSERT_STREQ(output, idle ? "" :
+			     "== size: 2 =====\n00 ff\n"
+			     "== size: 5 =====\n01 02 03 04 05\n"
+			     "== size: 17 =====\n10 11 12 13 14 15 16 17  "
+			     "18 19 1a 1b 1c 1d 1e 1f\n20\n", "plain records");
+out:
+	consumer_cleanup(&child);
+	if (position != MAP_FAILED)
+		munmap(position, page_size);
+	if (map_pinned)
+		ASSERT_OK(unlink(pin_path), "unpin ringbuf");
+	if (dir_created)
+		ASSERT_OK(rmdir(pin_dir), "remove pin directory");
+	bpftool_ringbuf__destroy(skel);
+}
+
+static void test_perf_consumer(void)
+{
+	struct consumer child = { .pid = -1, .fd = -1 };
+	unsigned long long seconds, nanoseconds;
+	struct bpftool_ringbuf *skel;
+	char output[16384], expected[16384];
+	int nr_cpus, cpu, index, offset = 0, i, used = 0, fields;
+	struct pollfd pfd;
+
+	nr_cpus = libbpf_num_possible_cpus();
+	if (!ASSERT_GT(nr_cpus, 0, "possible cpus"))
+		return;
+	skel = bpftool_ringbuf__open();
+	if (!ASSERT_OK_PTR(skel, "open"))
+		return;
+	bpf_map__set_max_entries(skel->maps.ringbuf, getpagesize());
+	bpf_map__set_max_entries(skel->maps.perfbuf, nr_cpus);
+	if (!ASSERT_OK(bpftool_ringbuf__load(skel), "load") ||
+	    !consumer_start(&child, bpf_map__fd(skel->maps.perfbuf), NULL,
+			    NULL, NULL, false, false) || !consumer_ready(&child) ||
+	    !emit_record(skel, 3))
+		goto out;
+	/* One large record flushes the existing buffered perf output callback. */
+	pfd = (struct pollfd) { .fd = child.fd, .events = POLLIN };
+	if (!ASSERT_GT(poll(&pfd, 1, WAIT_STEPS * WAIT_US / 1000), 0,
+		       "perf record output") ||
+	    !ASSERT_TRUE(pfd.revents & POLLIN, "perf output readable") ||
+	    !consumer_finish(&child, SIGINT, true, output, sizeof(output)))
+		goto out;
+	fields = sscanf(output, "== @%llu.%llu CPU: %d index: %d =====\n%n",
+			&seconds, &nanoseconds, &cpu, &index, &offset);
+	if (!ASSERT_EQ(fields, 4, "perf header") ||
+	    !ASSERT_GT(offset, 0, "perf payload offset"))
+		goto out;
+	ASSERT_GT(seconds * 1000000000ULL + nanoseconds, 0, "perf timestamp");
+	ASSERT_LT(nanoseconds, 1000000000ULL, "perf timestamp nanoseconds");
+	ASSERT_GE(cpu, 0, "perf cpu");
+	ASSERT_LT(cpu, nr_cpus, "perf cpu range");
+	ASSERT_EQ(index, cpu, "perf index");
+	for (i = 0; i < sizeof(skel->rodata->perf_payload); i++) {
+		const char *separator = !i ? "" : !(i % 16) ? "\n" :
+					!(i % 8) ? "  " : " ";
+
+		used += snprintf(expected + used, sizeof(expected) - used,
+				 "%s%02x", separator, i == 1 ? 0xff : 0);
+	}
+	snprintf(expected + used, sizeof(expected) - used, "\n");
+	ASSERT_STREQ(output + offset, expected, "perf payload");
+out:
+	consumer_cleanup(&child);
+	bpftool_ringbuf__destroy(skel);
+}
+
+static void test_reject(enum bpf_map_type type, const char *option, bool pair, bool json)
+{
+	struct consumer child = { .pid = -1, .fd = -1 };
+	bool ring = type == BPF_MAP_TYPE_RINGBUF || type == BPF_MAP_TYPE_USER_RINGBUF;
+	const char *expected = option && !strcmp(option, "foobar") ?
+		"{\"error\":\"what is 'foobar'?\"}" : option ?
+		"{\"error\":\"ring buffer maps do not support cpu or index arguments\"}" :
+		"{\"error\":\"map is not a perf event array or ring buffer\"}";
+	char output[4096];
+	int fd;
+
+	fd = bpf_map_create(type, NULL, ring ? 0 : 4, ring ? 0 : 4,
+			    ring ? getpagesize() : 1, NULL);
+	if (!ASSERT_GE(fd, 0, "create map"))
+		return;
+	if (consumer_start(&child, fd, json ? "-j" : NULL, NULL, option, pair, true) &&
+	    consumer_finish(&child, 0, false, output, sizeof(output))) {
+		if (json)
+			check_json(output, expected);
+		else
+			ASSERT_GT(strlen(output), 0, "error diagnostic");
+	}
+	consumer_cleanup(&child);
+	close(fd);
+}
+
+void test_bpftool_ringbuf(void)
+{
+	if (test__start_subtest("perf_event_array"))
+		test_perf_consumer();
+	if (test__start_subtest("plain"))
+		test_consumer(NULL, false, SIGINT, false);
+	if (test__start_subtest("json"))
+		test_consumer("-j", false, SIGTERM, false);
+	if (test__start_subtest("pretty_json"))
+		test_consumer("-p", false, SIGINT, false);
+	if (test__start_subtest("pinned_plain"))
+		test_consumer(NULL, false, SIGTERM, true);
+	if (test__start_subtest("pinned_json"))
+		test_consumer("-j", false, SIGINT, true);
+	if (test__start_subtest("pinned_pretty_json"))
+		test_consumer("-p", false, SIGTERM, true);
+	if (test__start_subtest("idle_sigint"))
+		test_consumer(NULL, true, SIGINT, false);
+	if (test__start_subtest("idle_sigterm_json"))
+		test_consumer("-j", true, SIGTERM, false);
+	if (test__start_subtest("idle_sigint_pretty_json"))
+		test_consumer("-p", true, SIGINT, false);
+	if (test__start_subtest("reject_array"))
+		test_reject(BPF_MAP_TYPE_ARRAY, NULL, false, false);
+	if (test__start_subtest("reject_user_ringbuf"))
+		test_reject(BPF_MAP_TYPE_USER_RINGBUF, NULL, false, false);
+	if (test__start_subtest("reject_cpu"))
+		test_reject(BPF_MAP_TYPE_RINGBUF, "cpu", false, false);
+	if (test__start_subtest("reject_index"))
+		test_reject(BPF_MAP_TYPE_RINGBUF, "index", false, false);
+	if (test__start_subtest("reject_cpu_index"))
+		test_reject(BPF_MAP_TYPE_RINGBUF, "cpu", true, false);
+	if (test__start_subtest("reject_user_ringbuf_json"))
+		test_reject(BPF_MAP_TYPE_USER_RINGBUF, NULL, false, true);
+	if (test__start_subtest("reject_unknown_json"))
+		test_reject(BPF_MAP_TYPE_RINGBUF, "foobar", false, true);
+	if (test__start_subtest("reject_cpu_index_json"))
+		test_reject(BPF_MAP_TYPE_RINGBUF, "cpu", true, true);
+}
diff --git a/tools/testing/selftests/bpf/progs/bpftool_ringbuf.c b/tools/testing/selftests/bpf/progs/bpftool_ringbuf.c
new file mode 100644
index 000000000000..bbbc93c30a83
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/bpftool_ringbuf.c
@@ -0,0 +1,47 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+
+struct {
+	__uint(type, BPF_MAP_TYPE_RINGBUF);
+} ringbuf SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_PERF_EVENT_ARRAY);
+	__uint(key_size, sizeof(__u32));
+	__uint(value_size, sizeof(__u32));
+	__uint(max_entries, 1);
+} perfbuf SEC(".maps");
+
+/*
+ * Include the u32 raw size in perf's 8-byte alignment to avoid padding.
+ * Keep plain output large enough to flush stdio before the consumer exits.
+ */
+const unsigned char perf_payload[4092] = { 0x00, 0xff };
+
+int record;
+int output_err;
+
+SEC("socket")
+int produce(struct __sk_buff *skb)
+{
+	unsigned char first[] = { 0x00, 0xff };
+	unsigned char second[] = { 1, 2, 3, 4, 5 };
+	unsigned char third[] = {
+		0x10, 0x11, 0x12, 0x13, 0x14, 0x15, 0x16, 0x17,
+		0x18, 0x19, 0x1a, 0x1b, 0x1c, 0x1d, 0x1e, 0x1f, 0x20,
+	};
+
+	if (record == 0)
+		output_err = bpf_ringbuf_output(&ringbuf, first, sizeof(first), 0);
+	else if (record == 1)
+		output_err = bpf_ringbuf_output(&ringbuf, second, sizeof(second), 0);
+	else if (record == 2)
+		output_err = bpf_ringbuf_output(&ringbuf, third, sizeof(third), 0);
+	else
+		output_err = bpf_perf_event_output(skb, &perfbuf, BPF_F_CURRENT_CPU,
+						   (void *)perf_payload, sizeof(perf_payload));
+	return 0;
+}
+
+char LICENSE[] SEC("license") = "GPL";
-- 
2.55.0

