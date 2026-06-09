Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 412E73DD518;
	Tue,  9 Jun 2026 07:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780990404; cv=none; b=exjwO/5iJHuGs4DI7dp7DYu64SsiVR4OucaZZMTdO+dSBx3buHovZwa3tblRw2WuvOF9QoV6/YoV0YEb9SbGno2xIdRjufIsHpm9VXU03km5gTGawha5z8zcwAe51ZnOGu3UqpnxbekK/0p3Nr/neR2z47AE5crUuaf9nAmVbyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780990404; c=relaxed/simple;
	bh=7He9jSv+lVf1SlCnCwLIzX0ObfUZZrsKDG/zPAvtmSo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-Id:
	 Content-Type:MIME-Version; b=XWnQAYuFc2JWE4qvHc9Gj3U4dA6s9WCrbG12q30Wf7Hyd3eoKHiB9Q6zXuCR0gIyUJelGrQWbd450APQGwP8byuoapcRkIkXcw2FAsFDQ6zmu3YM5CcqoLvUR201bR2siyTBstE0IHR5QVGj4rNNKkMrxsBPHXljvQa04kpR0QA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=BKSabAmU; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="BKSabAmU"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1780990397; h=From:To:Subject:Date:Message-Id:Content-Type:MIME-Version;
	bh=0LGIfJZm4xNx6I2uQDCvO/rOphVCwfUr0LmPFRvi+FE=;
	b=BKSabAmUNAobBGV9IRm4scVbNcpYGK5TH8BnXcAb4fDlWSjja4FAQR2KgpJ9WMYYYQIc7HW3OXY2k6gRDP1b2aN5o+Z/JNpf4EqLg0MleixJmshC9/IN7Eqv8JOB/C1OMaUSZWAoT9g0tPRtxONpm2s5kQwDDX55htqUr37tDAM=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=abaci@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0X4VUSk1_1780990395;
Received: from x31j01071.sqa.na131(mailfrom:abaci@linux.alibaba.com fp:SMTPD_---0X4VUSk1_1780990395 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 09 Jun 2026 15:33:16 +0800
From: abaci-kreproducer <abaci@linux.alibaba.com>
To: Sechang Lim <rhkrqnwk98@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Juntong Deng <juntong.deng@outlook.com>, Leon Hwang <leon.hwang@linux.dev>,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 Oliver <oliver.yang@linux.alibaba.com>
Subject:
 Re: [PATCH bpf v4] bpf: fix NULL pointer dereference in bpf_task_from_vpid()
In-Reply-To: <20260608050001.2545245-1-rhkrqnwk98@gmail.com>
References: <20260608050001.2545245-1-rhkrqnwk98@gmail.com>
Date: Tue, 09 Jun 2026 15:32:53 +0800
Message-Id: <178099037323.185647.2927220189885666113@linux.alibaba.com>
User-Agent: abaci-kreproducer (abaci-oracle mail_sender)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

From: abaci-kreproducer <abaci@linux.alibaba.com>

This is an AI-generated validation of this patch. AI successfully
reproduced the issue and confirmed the fix is valid.

Tested-by: abaci-kreproducer <abaci@linux.alibaba.com>
---
We reproduced this issue on the unpatched kernel:

`bpf_task_from_vpid()` triggered a NULL pointer dereference at address
`0x0000000000000010` in `idr_find()`, followed immediately by a kernel
panic ("Fatal exception in interrupt"). The crash occurred ~170 seconds
into the test run.

`task_active_pid_ns(current)` returns NULL when a task has passed
`__unhash_process()` in `do_exit()`, clearing `thread_pid`.
`find_task_by_vpid()` passes this NULL ns directly to `find_pid_ns()`,
which dereferences `&NULL->idr`. The crash was triggered via the egress
`cgroup_skb` path: `tcp_delack_timer` -> `ip_output` ->
`__cgroup_bpf_run_filter_skb` -> `bpf_task_from_vpid()`, confirming the
softirq interrupt window extends beyond the ingress path described in
the commit log.

The reproducer attaches a `cgroup_skb/ingress` and `cgroup_skb/egress`
BPF program that calls `bpf_task_from_vpid(1)` on every packet. Per-CPU
fork workers continuously fork children that open a TCP socket, connect
to a loopback server, and immediately call `SYS_exit` without closing
the socket fd. This keeps TCP state alive during `do_exit()`, ensuring
softirqs can fire while `current->thread_pid` is already NULL.

On the patched kernel, the reproducer ran for the full 300 seconds with
no NULL pointer dereference, no oops, and no panic in the serial log.
---
Key configuration
* kconfig:
CONFIG_BPF=3Dy
CONFIG_BPF_SYSCALL=3Dy
CONFIG_BPF_JIT=3Dy
CONFIG_CGROUP_BPF=3Dy
CONFIG_CGROUPS=3Dy
CONFIG_DEBUG_INFO=3Dy
CONFIG_DEBUG_INFO_NONE=3Dn
CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=3Dy
CONFIG_DEBUG_INFO_BTF=3Dy
CONFIG_NET=3Dy
CONFIG_INET=3Dy
* kernel_cmdline: -
* rpm package: -
--
run.sh
#!/bin/bash
# Reproducer for: bpf: fix NULL pointer dereference in bpf_task_from_vpid()
# Commit: d13148672f22de662597333189cf59868fa541a7
#
# This reproducer triggers a race between do_exit() and cgroup_skb BPF:
# A BPF program attached to cgroup_skb/ingress and cgroup_skb/egress calls
# bpf_task_from_vpid() on every packet. If the softirq fires on a CPU where
# the current task is in do_exit() after __unhash_process(), a NULL pointer
# dereference occurs in idr_find() via task_active_pid_ns().
#
# The reproducer includes pre-built bpftool (v7.8.0) and libbpf (v1.8.0)
# in bin/tools/ to avoid dependency on potentially outdated system versions.
set -x

SCRIPT_DIR=3D"$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BIN_DIR=3D"$SCRIPT_DIR/bin"
RESULTS_DIR=3D"$SCRIPT_DIR/results"
DURATION=3D"${DURATION:-300}"

mkdir -p "$RESULTS_DIR"

echo "=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D"
echo " bpf_task_from_vpid NULL pointer deref reproducer"
echo " Commit: d13148672f22de662597333189cf59868fa541a7"
echo "=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D"

# ---- Step 1: Check kernel config ----
echo ""
echo "[*] Checking kernel configuration..."

MISSING_CONFIG=3D0
for cfg in CONFIG_BPF_SYSCALL CONFIG_CGROUP_BPF CONFIG_DEBUG_INFO_BTF CONFIG_=
CGROUPS; do
    if zcat /proc/config.gz 2>/dev/null | grep -qE "${cfg}=3D[ym]"; then
        echo "    ${cfg} - OK"
    else
        echo "    ${cfg} - MISSING (required)"
        MISSING_CONFIG=3D1
    fi
done

if [ "$MISSING_CONFIG" -eq 1 ]; then
    echo ""
    echo "[!] Required kernel config options are missing."
    echo "    Please rebuild the kernel with:"
    echo "      CONFIG_BPF_SYSCALL=3Dy"
    echo "      CONFIG_CGROUP_BPF=3Dy"
    echo "      CONFIG_CGROUPS=3Dy"
    echo "      CONFIG_DEBUG_INFO_BTF=3Dy"
    echo "      CONFIG_DEBUG_INFO_NONE=3Dn"
    echo "      CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=3Dy"
    exit 1
fi

if [ ! -f /sys/kernel/btf/vmlinux ]; then
    echo "[!] /sys/kernel/btf/vmlinux not found"
    echo "    CONFIG_DEBUG_INFO_BTF=3Dy is required"
    exit 1
fi

# ---- Step 2: Verify bundled tools ----
echo ""
echo "[*] Verifying bundled tools..."

if [ ! -x "$BIN_DIR/tools/bpftool" ]; then
    echo "[!] Bundled bpftool not found at $BIN_DIR/tools/bpftool"
    exit 1
fi
echo "    bpftool: $($BIN_DIR/tools/bpftool version 2>&1 | head -1)"

if [ ! -f "$BIN_DIR/tools/libbpf.a" ]; then
    echo "[!] Bundled libbpf.a not found at $BIN_DIR/tools/libbpf.a"
    exit 1
fi
echo "    libbpf: bundled v1.8.0 (static)"

# ---- Step 3: Install build dependencies ----
echo ""
echo "[*] Installing build dependencies..."

install_pkg() {
    if command -v dnf >/dev/null 2>&1; then
        dnf install -y "$@" 2>/dev/null
    elif command -v yum >/dev/null 2>&1; then
        yum install -y "$@" 2>/dev/null
    elif command -v apt-get >/dev/null 2>&1; then
        apt-get install -y "$@" 2>/dev/null
    fi
}

NEED_INSTALL=3D0
command -v clang >/dev/null 2>&1 || NEED_INSTALL=3D1
command -v gcc >/dev/null 2>&1 || NEED_INSTALL=3D1
command -v make >/dev/null 2>&1 || NEED_INSTALL=3D1
[ -f /usr/include/libelf.h ] || NEED_INSTALL=3D1

if [ "$NEED_INSTALL" -eq 1 ]; then
    install_pkg clang gcc make elfutils-libelf-devel
fi

for pkg in clang gcc make; do
    if ! command -v "$pkg" >/dev/null 2>&1; then
        echo "[!] Required tool not found: $pkg"
        exit 1
    fi
done

if [ ! -f /usr/include/libelf.h ]; then
    echo "[!] libelf development headers not found"
    exit 1
fi

# ---- Step 4: Build reproducer ----
echo ""
echo "[*] Building reproducer (using bundled bpftool + libbpf)..."
cd "$BIN_DIR"
make clean
set -o pipefail
if ! make 2>&1 | tee "$RESULTS_DIR/build.log"; then
    echo "[!] Build failed"
    set +o pipefail
    exit 1
fi
set +o pipefail

# ---- Step 5: Save dmesg baseline ----
DMESG_BEFORE=3D$(mktemp)
dmesg > "$DMESG_BEFORE" 2>/dev/null || true

# ---- Step 6: Run reproducer ----
echo ""
echo "[*] Running reproducer for ${DURATION}s..."
echo "    Race: cgroup_skb BPF calls bpf_task_from_vpid()"
echo "    during softirq on CPU where do_exit() is running."
echo ""

set +e
"$BIN_DIR/reproducer" "$DURATION" 2>&1 | tee "$RESULTS_DIR/test-output.txt"
REPRO_EXIT=3D${PIPESTATUS[0]}
set -e

# ---- Step 7: Check results ----
echo ""
echo "[*] Checking dmesg for NULL pointer dereference..."

DMESG_AFTER=3D$(mktemp)
dmesg > "$DMESG_AFTER" 2>/dev/null || true

NEW_DMESG=3D$(mktemp)
diff "$DMESG_BEFORE" "$DMESG_AFTER" | grep "^>" | sed 's/^> //' > "$NEW_DMESG=
" 2>/dev/null || true

BUG_FOUND=3D0

if grep -qE "BUG: kernel NULL pointer dereference" "$NEW_DMESG" 2>/dev/null; =
then
    echo ""
    echo "=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D"
    echo " BUG REPRODUCED!"
    echo " NULL pointer dereference in bpf_task_from_vpid()"
    echo "=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D"
    echo ""
    grep -A 40 "BUG: kernel NULL pointer dereference" "$NEW_DMESG" | head -50
    BUG_FOUND=3D1
fi

if grep -qE "bpf_task_from_vpid|find_task_by_pid_ns.*NULL|idr_find" "$NEW_DME=
SG" 2>/dev/null; then
    echo ""
    echo "Related kernel trace:"
    grep -B 2 -A 15 "bpf_task_from_vpid\|find_task_by_pid_ns\|idr_find" "$NEW=
_DMESG" | head -40
    BUG_FOUND=3D1
fi

if grep -qiE "kernel panic|oops" "$NEW_DMESG" 2>/dev/null; then
    echo ""
    echo "Kernel panic/oops detected:"
    grep -iE "kernel panic|oops" "$NEW_DMESG" | head -5
    BUG_FOUND=3D1
fi

if [ "$BUG_FOUND" -eq 0 ]; then
    echo "[-] Bug not triggered in this run."
    echo ""
    echo "Tips:"
    echo "  - Increase duration: DURATION=3D600 $0"
    echo "  - Ensure multiple CPUs available"
    echo "  - Check CONFIG_CGROUP_BPF=3Dy and CONFIG_BPF_SYSCALL=3Dy"
fi

if [ -s "$NEW_DMESG" ]; then
    echo ""
    echo "New dmesg warnings/errors:"
    grep -iE "warning|error|bug|oops|fault" "$NEW_DMESG" | tail -20 || true
fi

# ---- Save results ----
cp "$NEW_DMESG" "$RESULTS_DIR/dmesg-errors.txt" 2>/dev/null || true
cp "$DMESG_AFTER" "$RESULTS_DIR/dmesg-after.txt" 2>/dev/null || true
zcat /proc/config.gz 2>/dev/null > "$RESULTS_DIR/kconfig" || true

echo "{\"exit_code\": $REPRO_EXIT, \"bug_found\": $BUG_FOUND, \"duration\": $=
DURATION}" > "$RESULTS_DIR/test-report.json"

# ---- Cleanup ----
rm -f "$DMESG_BEFORE" "$DMESG_AFTER" "$NEW_DMESG"
rm -rf /sys/fs/cgroup/bpf_vpid_race 2>/dev/null || true
rm -rf /tmp/cg_bpf_vpid_race 2>/dev/null || true

echo ""
echo "=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D"
if [ "$BUG_FOUND" -eq 1 ]; then
    echo " Result: REPRODUCED"
    exit 0
else
    echo " Result: NOT REPRODUCED (exit=3D$REPRO_EXIT)"
    exit 1
fi
--
reproducer.bpf.c
// SPDX-License-Identifier: GPL-2.0
/*
 * BPF program for reproducing NULL pointer dereference in bpf_task_from_vpid=
().
 * Commit: d13148672f22de662597333189cf59868fa541a7
 *
 * Attached to cgroup_skb/{ingress,egress}. For every packet processed, the
 * program calls bpf_task_from_vpid(1). If this executes in softirq context
 * while `current` is a task in do_exit() after __unhash_process() has cleared
 * its thread_pid, task_active_pid_ns(current) returns NULL and find_pid_ns()
 * dereferences &NULL->idr, causing a kernel NULL pointer dereference.
 */

#include "vmlinux.h"
#include <bpf/bpf_helpers.h>

#ifndef s32
typedef __s32 s32;
#endif

extern struct task_struct *bpf_task_from_vpid(s32 vpid) __weak __ksym;
extern void bpf_task_release(struct task_struct *p) __weak __ksym;

SEC("cgroup_skb/ingress")
int cg_skb_ingress(struct __sk_buff *skb)
{
	struct task_struct *task;

	task =3D bpf_task_from_vpid(1);
	if (task)
		bpf_task_release(task);

	return 1;
}

SEC("cgroup_skb/egress")
int cg_skb_egress(struct __sk_buff *skb)
{
	struct task_struct *task;

	task =3D bpf_task_from_vpid(1);
	if (task)
		bpf_task_release(task);

	return 1;
}

char _license[] SEC("license") =3D "GPL";
--
reproducer.c
// SPDX-License-Identifier: GPL-2.0
/*
 * Reproducer for: bpf: fix NULL pointer dereference in bpf_task_from_vpid()
 * Commit: d13148672f22de662597333189cf59868fa541a7
 *
 * Race condition: cgroup_skb BPF program calls bpf_task_from_vpid() during
 * softirq processing of TCP packets, while `current` is a task in do_exit()
 * after __unhash_process() has cleared its thread_pid.
 *
 * Strategy:
 * 1. Set up cgroup v2 with BPF program attached to cgroup_skb
 * 2. Spawn fork workers pinned to each CPU, rapidly forking children
 * 3. Each child connects to a TCP server and immediately exits
 * 4. Traffic generators flood the server to produce constant softirqs
 * 5. When a TCP packet's softirq fires on a CPU where a child is in
 *    do_exit() after __unhash_process(), bpf_task_from_vpid() dereferences
 *    NULL from task_active_pid_ns(current)
 */

#define _GNU_SOURCE
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <errno.h>
#include <signal.h>
#include <fcntl.h>
#include <sched.h>
#include <pthread.h>
#include <sys/socket.h>
#include <sys/wait.h>
#include <sys/stat.h>
#include <sys/mount.h>
#include <sys/syscall.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <bpf/bpf.h>
#include <bpf/libbpf.h>
#include "reproducer.skel.h"

#define CGROUP_PATH     "/sys/fs/cgroup/bpf_vpid_race"
#define SERVER_PORT     18765
#define NUM_WORKERS     16

static volatile int stop_flag =3D 0;
static char cg_work_path[512];
static int cg_mounted =3D 0;

static void sig_handler(int sig)
{
	(void)sig;
	stop_flag =3D 1;
}

static int write_file(const char *path, const char *val)
{
	int fd =3D open(path, O_WRONLY | O_TRUNC);
	int ret;

	if (fd < 0)
		return -errno;
	ret =3D write(fd, val, strlen(val));
	close(fd);
	return ret < 0 ? -errno : 0;
}

static int setup_cgroup_v2(void)
{
	struct stat st;
	char path[512];
	const char *base;

	if (stat("/sys/fs/cgroup/cgroup.controllers", &st) =3D=3D 0) {
		base =3D "/sys/fs/cgroup";
		cg_mounted =3D 0;
	} else {
		mkdir("/tmp/cg_bpf_vpid_race", 0755);
		if (mount("cgroup2", "/tmp/cg_bpf_vpid_race", "cgroup2",
			  0, NULL)) {
			fprintf(stderr, "Failed to mount cgroup2: %s\n",
				strerror(errno));
			return -1;
		}
		base =3D "/tmp/cg_bpf_vpid_race";
		cg_mounted =3D 1;
	}

	snprintf(path, sizeof(path), "%s/bpf_vpid_race", base);
	mkdir(path, 0755);
	snprintf(cg_work_path, sizeof(cg_work_path), "%s/work", path);
	mkdir(cg_work_path, 0755);

	snprintf(path, sizeof(path), "%s/bpf_vpid_race/cgroup.subtree_control",
		 base);
	write_file(path, "+bpf");

	char pid_str[32];
	snprintf(pid_str, sizeof(pid_str), "%d", getpid());
	snprintf(path, sizeof(path), "%s/cgroup.procs", cg_work_path);
	if (write_file(path, pid_str)) {
		fprintf(stderr, "Failed to join cgroup %s: %s\n",
			cg_work_path, strerror(errno));
		return -1;
	}

	fprintf(stderr, "[+] Cgroup: %s\n", cg_work_path);
	return 0;
}

static void cleanup_cgroup_v2(void)
{
	char path[512], buf[32];

	snprintf(path, sizeof(path), "%s/cgroup.procs", CGROUP_PATH);
	snprintf(buf, sizeof(buf), "%d", getpid());
	write_file(path, buf);

	rmdir(cg_work_path);
	rmdir(CGROUP_PATH);

	if (cg_mounted) {
		umount2("/tmp/cg_bpf_vpid_race", MNT_DETACH);
		rmdir("/tmp/cg_bpf_vpid_race");
	}
}

static void *tcp_server_thread(void *arg)
{
	(void)arg;
	int srv, cli, opt =3D 1;
	struct sockaddr_in addr =3D {
		.sin_family =3D AF_INET,
		.sin_port =3D htons(SERVER_PORT),
		.sin_addr.s_addr =3D htonl(INADDR_LOOPBACK),
	};

	srv =3D socket(AF_INET, SOCK_STREAM, 0);
	if (srv < 0)
		return NULL;
	setsockopt(srv, SOL_SOCKET, SO_REUSEADDR, &opt, sizeof(opt));

	if (bind(srv, (struct sockaddr *)&addr, sizeof(addr)) < 0) {
		perror("bind");
		close(srv);
		return NULL;
	}
	listen(srv, 4096);

	while (!stop_flag) {
		fd_set fds;
		struct timeval tv =3D { .tv_sec =3D 0, .tv_usec =3D 10000 };

		FD_ZERO(&fds);
		FD_SET(srv, &fds);
		if (select(srv + 1, &fds, NULL, NULL, &tv) <=3D 0)
			continue;

		cli =3D accept(srv, NULL, NULL);
		if (cli < 0)
			continue;

		char data[512];
		memset(data, 'A', sizeof(data));
		for (int i =3D 0; i < 32 && !stop_flag; i++)
			send(cli, data, sizeof(data), MSG_NOSIGNAL);
		shutdown(cli, SHUT_WR);
		close(cli);
	}

	close(srv);
	return NULL;
}

static void *fork_worker(void *arg)
{
	int cpu =3D (int)(long)arg;
	cpu_set_t mask;

	CPU_ZERO(&mask);
	CPU_SET(cpu, &mask);
	sched_setaffinity(0, sizeof(mask), &mask);

	while (!stop_flag) {
		pid_t pid =3D fork();
		if (pid =3D=3D 0) {
			/*
			 * Don't close(fd) here - let do_exit() -> exit_files()
			 * clean up the socket. This keeps TCP state active
			 * during do_exit(), so incoming data softirqs fire
			 * while current's thread_pid is already cleared.
			 */
			int fd =3D socket(AF_INET, SOCK_STREAM, 0);
			if (fd >=3D 0) {
				struct sockaddr_in a =3D {
					.sin_family =3D AF_INET,
					.sin_port =3D htons(SERVER_PORT),
					.sin_addr.s_addr =3D htonl(INADDR_LOOPBACK),
				};
				connect(fd, (struct sockaddr *)&a, sizeof(a));
			}
			syscall(SYS_exit, 0);
			__builtin_unreachable();
		}
	}
	return NULL;
}

static void *traffic_gen(void *arg)
{
	int cpu =3D (int)(long)arg;
	cpu_set_t mask;

	CPU_ZERO(&mask);
	CPU_SET(cpu, &mask);
	sched_setaffinity(0, sizeof(mask), &mask);

	while (!stop_flag) {
		int fd =3D socket(AF_INET, SOCK_STREAM, 0);
		if (fd >=3D 0) {
			struct sockaddr_in a =3D {
				.sin_family =3D AF_INET,
				.sin_port =3D htons(SERVER_PORT),
				.sin_addr.s_addr =3D htonl(INADDR_LOOPBACK),
			};
			if (connect(fd, (struct sockaddr *)&a, sizeof(a)) =3D=3D 0) {
				for (int i =3D 0; i < 8; i++)
					send(fd, "xxxxxxxx", 8, MSG_NOSIGNAL);
				char buf[256];
				recv(fd, buf, sizeof(buf), MSG_DONTWAIT);
			}
			close(fd);
		}
		usleep(1);
	}
	return NULL;
}

int main(int argc, char **argv)
{
	int duration =3D argc > 1 ? atoi(argv[1]) : 180;
	int cg_fd =3D -1, ret =3D 1;
	struct reproducer_bpf *skel =3D NULL;
	int ncpus =3D sysconf(_SC_NPROCESSORS_ONLN);

	if (ncpus < 1)
		ncpus =3D 1;

	signal(SIGINT, sig_handler);
	signal(SIGTERM, sig_handler);
	signal(SIGCHLD, SIG_IGN);

	fprintf(stderr, "[*] Setting up cgroup v2...\n");
	if (setup_cgroup_v2()) {
		fprintf(stderr, "ERROR: cgroup v2 setup failed\n");
		return 1;
	}

	fprintf(stderr, "[*] Loading BPF program...\n");
	skel =3D reproducer_bpf__open();
	if (!skel) {
		fprintf(stderr, "ERROR: BPF open: %s\n", strerror(errno));
		goto out;
	}

	if (reproducer_bpf__load(skel)) {
		fprintf(stderr, "ERROR: BPF load: %s\n", strerror(errno));
		goto out;
	}

	cg_fd =3D open(cg_work_path, O_RDONLY | O_DIRECTORY);
	if (cg_fd < 0) {
		fprintf(stderr, "ERROR: open cgroup: %s\n", strerror(errno));
		goto out;
	}

	skel->links.cg_skb_ingress =3D
		bpf_program__attach_cgroup(skel->progs.cg_skb_ingress, cg_fd);
	if (!skel->links.cg_skb_ingress) {
		fprintf(stderr, "ERROR: attach ingress: %s\n", strerror(errno));
		goto out;
	}

	skel->links.cg_skb_egress =3D
		bpf_program__attach_cgroup(skel->progs.cg_skb_egress, cg_fd);
	if (!skel->links.cg_skb_egress)
		fprintf(stderr, "WARNING: egress attach failed (continuing)\n");

	fprintf(stderr, "[+] BPF programs attached (cpus=3D%d)\n", ncpus);

	pthread_t srv_tid;
	pthread_create(&srv_tid, NULL, tcp_server_thread, NULL);
	usleep(50000);

	int nw =3D ncpus * 2;
	if (nw > NUM_WORKERS)
		nw =3D NUM_WORKERS;
	pthread_t fork_tid[NUM_WORKERS], traf_tid[NUM_WORKERS];

	for (int i =3D 0; i < nw; i++) {
		pthread_create(&fork_tid[i], NULL, fork_worker,
			       (void *)(long)(i % ncpus));
		pthread_create(&traf_tid[i], NULL, traffic_gen,
			       (void *)(long)(i % ncpus));
	}

	fprintf(stderr, "[*] Racing for %ds (fork+TCP vs do_exit)...\n",
		duration);
	sleep(duration);
	stop_flag =3D 1;

	for (int i =3D 0; i < nw; i++) {
		pthread_join(fork_tid[i], NULL);
		pthread_join(traf_tid[i], NULL);
	}
	pthread_join(srv_tid, NULL);

	fprintf(stderr, "[*] Checking dmesg...\n");
	int rc =3D system("dmesg | grep -E "
			"'BUG: kernel NULL pointer dereference"
			"|bpf_task_from_vpid"
			"|idr_find' | tail -30");

	if (rc =3D=3D 0) {
		fprintf(stderr, "\n[!] BUG REPRODUCED!\n");
		ret =3D 0;
	} else {
		fprintf(stderr, "[-] Bug not triggered this run\n");
	}

out:
	if (skel)
		reproducer_bpf__destroy(skel);
	if (cg_fd >=3D 0)
		close(cg_fd);
	cleanup_cgroup_v2();
	return ret;
}
