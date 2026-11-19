Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795056132;
	b=GH++eyPBM2y2wOd7yRfdcTOw1QaODim+pif9/zZ8pfzuV08yBqTMnAo0J+Df8rDtXOTx
	 w/h+8KQPuKqi5KTelGFBWTaYxSNBa7wCwoIaY0dnVbMtULxCcANjzV57oW8denC3LNWfo
	 uPYtYoeyjKAp0m1ixlbfLFan2M7dL5W9T+618VKiaMMpvErgA40nmmdEFEmZd7/yQmMxD
	 be1DpZjL/kLwZCPL8G25OPVLC4a2FBbss6k/VTTvr9u27dtOZ5YU5i/+7ieqZKnlXZ7OS
	 K26prCwX4i2HcaOObQPZu0zooFjV9w/Q6Cns9sYoYPoYHOe93/h/rZqWS5stdNSo2yw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795056132;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=H24Hjyj0HAmg9z6gZ8R4LHzeA++oJhSf0CGyWDhP9AU=;
	b=0DlLrK0+hjPKVAtHsnN7sapmzRR9+LmyAaKEOBtxXxM6nDP1l36xsN5DcaUge21yt/id
	 wCo4SeYhbJZ/ZqD5INYE+BVb9Gs0USwWhCb5zf8i4ZmHRL0R/O2mRQD4F4FNycfkxVxzH
	 RBM/LvfftAbrn88GbaSoXU5v9f9E31u0+kKtJXIFvI3QmArQdOuh6sayEfOg593EaW2kd
	 BwAwGsHsCEk1EBJgaYGPEPv6QBw1BRGJkkRgGIdKmssKWWg2YgMcqmqvuCPQc2cSuDdeL
	 Ihw2ekBaW7hvQIHxx/iavcLbwl5z7+kzEfiWNx8SyI8O4BIWIEiYvpcmJdAGnzLtnQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nebusec.ai;
	spf=pass smtp.mailfrom=nebusec.ai;
	dkim=pass header.d=nebusec.ai header.i=@nebusec.ai header.a=rsa-sha256 header.s=google header.b="Jo9k/M6K";
	arc=none smtp.remote-ip=209.85.216.50
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E1FC606A320
	for <bpf@vger.kernel.org>; Thu, 19 Nov 2026 02:42:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2E1FC606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nebusec.ai header.i=@nebusec.ai header.a=rsa-sha256 header.s=google header.b=Jo9k/M6K
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3b3e85baf7cso654948a91.0
        for <bpf@vger.kernel.org>; Wed, 18 Nov 2026 18:42:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1795056131; x=1795660931; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=H24Hjyj0HAmg9z6gZ8R4LHzeA++oJhSf0CGyWDhP9AU=;
        b=Jo9k/M6Ky4tITSrJav5dsKkKA5spuctkf/k8y6kYqot4E3tJwZ9xK/7l0BzhXf9hFi
         0R7x8rm6M0/pSxFt4Xr9VNr6mE9JkzO4ldOX5KMvV3aU5680riMmylNg1wFRu/+zYGLQ
         AhYm4dFikbWM3UqlHf6Xf4PmM4f0adhyRT68UxYkbzhvdyJpgY8tJUIacGNDdu1YC+mh
         bxdDnru5w8oH0uaJ9FC/bBqtrOwQZj4XMtCYey8XoUbjK2LvUyREqv3ohaKQDRUP9Xbi
         FE05dD5jlycb8VnRcnebVaeAYLt+pBU9OM1UJlsI7wOsKuZURJ7AElc9tRoVIlYbu05+
         PR5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795056131; x=1795660931;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=H24Hjyj0HAmg9z6gZ8R4LHzeA++oJhSf0CGyWDhP9AU=;
        b=a+97cY9x8AGxG51fbDeYgTgGZOH+1/ozvPMLOPKoj73LkoNQ/ktuMvftkD0+RQjodd
         Qod66sM81VMuIn+mGujBHDcs/lV9lrQUozYD7k0cdI/rLw1k7P0iWoTEk+TC01Yao/jj
         CABYd3B62PmL+/gQ6R6DpPZV1WQ3hCxVayZyP8ufGuY5rwi0oCVEyPhQHI/p4xFVV0Um
         FL9H24zyf2wyNUmciWDnPf0dQ6FwbUYdNBRewqCzUNiqieTvsVWpxrjR5ToSUqYfaV+R
         0fRjmvdzYOU4rj7deRWe8Vca7gYqjq9gswvTTebjHpDz+hw8dyoGz/SyBwUieMoFjFFt
         ddAw==
X-Gm-Message-State: APuU4Z8rQlaxhBtEHovQbBIDhuV5Yq1wjnxQ8EFKVdT+NQBgX4SKXB2n
	M1xbKf5/XUmDJ5qjTsxwvVBhmZ23LqKVVnhBAmW116m7uacwgTvZmqkXEZ7YO7J0ErecJn37nr8
	mm8+zig==
X-Gm-Gg: AZFdTZeXCrcZnqOKgTbf53e+RxZK2ZoM4ezfQbr0eCMv9055pXBgDvYYYlKr7LmX8Dx
	1nUI59IgDWTwe+dj2w3fUf5Z80bfOVth66pJyY2Z+4uiKvmDbZgaUyhmFp4WGGesuLeNJ4Kehz+
	mjg36XalsN/HPQ1q+LbZdZn0ZID7tMOUeT0EYc1I991BMwoJe07NlZmSyH5lhJu+gILTGICcQ5N
	4u66YOFKnhOjHzptTKjAdHE1R9l4DtaEcdvOS7nxehDZdrFReGnckiBttkwdSs8n5/KLDzs/3P8
	lLlc9rwlbAIjbY38JkwgyX79P0rdCPN9QwHoaDLHT2LgM08aSQrkvMuqEDW6uaAimcseOV3mmsg
	zlAc9hjptlafHWK8lHnLhLqC8yAgd8rsyIqhIo+YOcsQ3JQAjuUl4esgEO6cGGckucLU6WXCg9L
	2YQ/Sv2GWS+K1/YcVIogBu9xBXBA8hdCSedz/y6cDoMwjeM/9vlkT6Cu7pm2k7Pvcxqm0/gA+qa
	VoXyjIFFcmgdobW8xNceLo0/Wksd54DiHbaV5S/Q+0VI4f6rrWs9X597jng7xXNFx5N7wILxdGH
	McBqQAR1dlofkHDUXmMJFsMXdDIEGmNIzHMD
X-Received: by 2002:a17:90b:1a8d:b0:3b3:bb55:d9c with SMTP id 98e67ed59e1d1-3b3d0641333mr4513441a91.2.1795056131295;
        Wed, 18 Nov 2026 18:42:11 -0800 (PST)
Received: from enjou-Legion-Y7000P-2019 ([74.52.12.168])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b4028576e5sm242879a91.2.2026.11.18.18.42.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 18:42:10 -0800 (PST)
From: Ren Wei <weir@nebusec.ai>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	ihor.solodrai@linux.dev,
	revest@chromium.org,
	dingyihan@uniontech.com,
	bigeasy@linutronix.de,
	paul.chaignon@gmail.com,
	vega@nebusec.ai,
	sashiko-bot@kernel.org,
	rakukuip@gmail.com,
	weir@nebusec.ai
Subject: [PATCH bpf 0/2] bpf: Fix scratch buffer cursor overflow in bpf_bprintf_prepare()
Date: Thu, 19 Nov 2026 10:42:01 +0800
Message-ID: <cover.1794974103.git.rakukuip@gmail.com>
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

We found and validated an issue in kernel/bpf/helpers.c affecting
bpf_bprintf_prepare() and all BPF formatted-output helpers that rely on
it (bpf_snprintf(), bpf_trace_printk(), bpf_trace_vprintk(),
bpf_seq_printf(), bpf_stream_vprintk(), and scx_bpf_exit_bstr()).

This bug is tracked at: https://bugtracker.nebusec.ai/f/15629

Privilege requirements & reachability:
In our validation environment, unprivileged BPF is disabled at runtime
(kernel.unprivileged_bpf_disabled = 2). Loading the BPF raw tracepoint
program (SEC("raw_tp/sys_enter")) fails with EPERM (-1) for unprivileged
users (test_user) and requires root (UID 0) / CAP_BPF + CAP_PERFMON.
The reproducer therefore runs under UID 0.

Impact boundary (vulnerability & fix scope):
1. Vulnerability impact:
   When %pB or %pI4/%pI6 truncates in the 512-byte per-CPU bin_args
   scratch buffer, bpf_bprintf_prepare() advances tmp_buf by (err + 1)
   using the full untruncated length returned by snprintf(). Once
   tmp_buf moves past tmp_buf_end, subsequent specifiers compute a
   negative signed difference (tmp_buf_end - tmp_buf), which converts
   to a large unsigned size_t in later bounds checks and snprintf()
   calls. Follow-on specifiers can write past bin_args into adjacent
   per-CPU bpf_bprintf_buffers storage and trigger WARN_ON_ONCE(size >
   INT_MAX) in vsnprintf() (panicking when panic_on_warn=1).

2. Effect of the fix on non-target paths and all callers:
   - Load-time format verification (kernel/bpf/verifier.c:
     check_bpf_snprintf_call(), where data->get_bin_args is false and
     tmp_buf is NULL): completely unaffected. Both %pB and %pI4/%pI6
     only execute the snprintf() bounds checks when tmp_buf is non-NULL.
   - Valid in-bounds %pB / %pI4 / %pi4 / %pI6 / %pi6 calls: unchanged.
     The MAX_BPRINTF_BIN_ARGS (512-byte) buffer capacity is unchanged.
     Whenever the formatted string plus NUL fits within the remaining
     space (err < tmp_buf_end - tmp_buf), execution produces the exact
     same bin_args layout and formatted output as before.
   - Truncated %pB / %pI4 / %pi4 / %pI6 / %pi6 calls: instead of
     advancing tmp_buf past tmp_buf_end and leaving inconsistent cursor
     state, bpf_bprintf_prepare() now returns -ENOSPC immediately and
     releases the per-CPU buffers via bpf_bprintf_cleanup() at out:.
     (Note: %pI4/%pI6 already returned -ENOSPC when fewer than 4 or 16
     bytes remained.)
   - Other format specifiers (%s/%pks/%pus, %c, integers, plain/symbol
     pointers %p/%pK/%px/%ps/%pS): semantics are unchanged. %s continues
     to use bpf_trace_copy_string(), which safely bounds copies to
     tmp_buf_end - tmp_buf. Casting sizeof_cur_ip and sizeof_cur_arg to
     ptrdiff_t in the remaining-space checks is a no-op whenever
     tmp_buf <= tmp_buf_end and prevents signed/unsigned wraparound if a
     negative pointer difference were ever observed.
   - Runtime callers (bpf_snprintf(), bpf_trace_printk(),
     bpf_trace_vprintk(), bpf_seq_printf(), bpf_stream_vprintk(), and
     scx_bpf_exit_bstr()): all callers already check for negative return
     values from bpf_bprintf_prepare() and bail out without invoking
     bstr_printf()/seq_bprintf() or double-calling bpf_bprintf_cleanup().

This patch series resolves the issue in two commits:
- Patch 1/2 checks whether err >= tmp_buf_end - tmp_buf after snprintf()
  in both the %pB and %pI4/%pI6 branches of bpf_bprintf_prepare(),
  returning -ENOSPC when the formatted output does not fit, and casts
  sizeof_cur_ip and sizeof_cur_arg to ptrdiff_t in remaining-space
  comparisons to prevent signed/unsigned wraparound.
- Patch 2/2 adds regression test cases to tools/testing/selftests/bpf
  (progs/test_snprintf.c and prog_tests/snprintf.c) covering %pi4, %pI6,
  and %pB scratch buffer overflow and boundary conditions.

=== details below ===

Bug details:

In bpf_bprintf_prepare(), the %pB and %pI4/%pI6 branches pre-format
arguments into the 512-byte per-CPU bin_args scratch buffer via
snprintf(tmp_buf, tmp_buf_end - tmp_buf, ...) and unconditionally advance:

    tmp_buf += err + 1;

However:
1. The %pB branch performs no remaining-space check at all.
2. The %pI4/%pI6 branch only checks:

       if (tmp_buf_end - tmp_buf < sizeof_cur_ip)

   where sizeof_cur_ip is 4 or 16 bytes, whereas the formatted IP string
   is up to 16 bytes for IPv4 or 40 bytes for IPv6 (including NUL).

If snprintf() returns err >= tmp_buf_end - tmp_buf, tmp_buf jumps past
tmp_buf_end. Subsequent checks (such as tmp_buf_end - tmp_buf <
sizeof_cur_arg or tmp_buf_end == tmp_buf) either underflow when
converted to size_t or fail to match, allowing out-of-bounds writes past
bin_args and causing subsequent snprintf() calls to pass a wrapped size
to vsnprintf(), hitting WARN_ON_ONCE(size > INT_MAX).

Testing & Validation:
We validated both the baseline reproduction and the fix in an x86_64
QEMU guest (2 vCPUs, 2GB RAM, CONFIG_KASAN=y, CONFIG_BPF_EVENTS=y,
panic_on_warn=0) built from bpf/master (4b4eb7f44ee0).

1. Pre-fix verification:
   Running poc_warn triggers the cursor overflow across %pI6, %pI4, and
   %pB, followed by a WARNING in vsnprintf() (size > INT_MAX with
   R09 = -19 = 0xffffffffffffffed) and out-of-bounds %lld writes:
   - case=0 (%s 449B + %pI6 + %s): ret=499 tail=present
   - case=1 (%s 500B + %pI6 + %s): ret=-28 (-ENOSPC, pre-existing <16 check)
   - case=2 (%s 491B + %pI6 + %pI6): ret=511 + WARNING at lib/vsprintf.c:2875
   - case=3 (%s 505B + %pi4/%pI4 + %pI4): ret=511
   - case=4 (%s 505B + %pB + %pB): ret=511
   - case=5 (%s 491B + %pI6 + %lld): ret=512 (wrote 8B past bin_args)

2. Post-fix verification:
   - Running poc_warn returns -28 (-ENOSPC) cleanly for cases 1..5 while
     preserving case=0 (ret=499 tail=present), with zero kernel warnings
     or KASAN reports in dmesg.
   - Running the updated snprintf selftest (snprintf_positive and
     snprintf_negative) passes all assertions with zero dmesg warnings.

3. Style and patch checks:
   - git diff --check HEAD~2..HEAD: 0 issues
   - git apply --check on unpatched bpf/master: clean
   - scripts/checkpatch.pl --strict: 0 errors

=== BEGIN poc_warn.bpf.c ===
// SPDX-License-Identifier: GPL-2.0
#include <linux/bpf.h>
#include <linux/types.h>
#include <bpf/bpf_helpers.h>

#define CHUNK64 "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA"
#define CHUNK42 "BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB"

extern const void schedule __ksym;

struct res_entry {
	__s32 ret;
	char buf[1024];
};

struct {
	__uint(type, BPF_MAP_TYPE_ARRAY);
	__uint(max_entries, 6);
	__type(key, __u32);
	__type(value, struct res_entry);
} results SEC(".maps");

static const char fill_448[] =
	CHUNK64 CHUNK64 CHUNK64 CHUNK64 CHUNK64 CHUNK64 CHUNK64;
static const char fill_490[] =
	CHUNK64 CHUNK64 CHUNK64 CHUNK64 CHUNK64 CHUNK64 CHUNK64 CHUNK42;
static const char fill_499[] =
	CHUNK64 CHUNK64 CHUNK64 CHUNK64 CHUNK64 CHUNK64 CHUNK64 "CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC";
static const char fill_504[] =
	CHUNK64 CHUNK64 CHUNK64 CHUNK64 CHUNK64 CHUNK64 CHUNK64 CHUNK42 "CCCCCCCCCCCCCC";
static const char tail_str[] = "TAIL_MARKER";

static const unsigned char ip6[16] = {
	0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
	0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
};
static const unsigned char ip4[4] = { 255, 255, 255, 255 };

__u32 target_pid = 0;

SEC("raw_tp/sys_enter")
int test_bprintf_warn(void *ctx)
{
	__u32 pid = bpf_get_current_pid_tgid() >> 32;
	unsigned long long args[3];
	struct res_entry *r;
	__u32 k;

	if (pid != target_pid)
		return 0;

	/* case 0: control %s (449B) + %pI6 (40B) + %s (12B) = 501B <= 512B */
	k = 0;
	r = bpf_map_lookup_elem(&results, &k);
	if (r) {
		args[0] = (unsigned long long)(long)fill_448;
		args[1] = (unsigned long long)(long)ip6;
		args[2] = (unsigned long long)(long)tail_str;
		barrier_var(args[0]);
		r->ret = bpf_snprintf(r->buf, sizeof(r->buf), "%s%pI6%s", args, sizeof(args));
	}

	/* case 1: %s (500B) + %pI6 (12B left < 16) + %s -> -ENOSPC (-28) */
	k = 1;
	r = bpf_map_lookup_elem(&results, &k);
	if (r) {
		args[0] = (unsigned long long)(long)fill_499;
		args[1] = (unsigned long long)(long)ip6;
		args[2] = (unsigned long long)(long)tail_str;
		barrier_var(args[0]);
		r->ret = bpf_snprintf(r->buf, sizeof(r->buf), "%s%pI6%s", args, sizeof(args));
	}

	/* case 2: %s (491B) + %pI6 (needs 40B, 21B left >= 16 -> jumps past end!) + %pI6 (WARN!) */
	k = 2;
	r = bpf_map_lookup_elem(&results, &k);
	if (r) {
		args[0] = (unsigned long long)(long)fill_490;
		args[1] = (unsigned long long)(long)ip6;
		args[2] = (unsigned long long)(long)ip6;
		barrier_var(args[0]);
		r->ret = bpf_snprintf(r->buf, sizeof(r->buf), "%s%pI6%pI6", args, sizeof(args));
	}

	/* case 3: %s (505B) + %pI4 (needs 16B, 7B left >= 4 -> jumps past end!) + %pI4 (WARN!) */
	k = 3;
	r = bpf_map_lookup_elem(&results, &k);
	if (r) {
		args[0] = (unsigned long long)(long)fill_504;
		args[1] = (unsigned long long)(long)ip4;
		args[2] = (unsigned long long)(long)ip4;
		barrier_var(args[0]);
		r->ret = bpf_snprintf(r->buf, sizeof(r->buf), "%s%pI4%pI4", args, sizeof(args));
	}

	/* case 4: %s (505B) + %pB (7B left -> jumps past end!) + %pB (WARN!) */
	k = 4;
	r = bpf_map_lookup_elem(&results, &k);
	if (r) {
		args[0] = (unsigned long long)(long)fill_504;
		args[1] = (unsigned long long)(long)&schedule;
		args[2] = (unsigned long long)(long)&schedule;
		barrier_var(args[0]);
		r->ret = bpf_snprintf(r->buf, sizeof(r->buf), "%s%pB%pB", args, sizeof(args));
	}

	/* case 5: %s (491B) + %pI6 (21B left -> jumps -19B past end!) + %lld (writes 8B OOB!) */
	k = 5;
	r = bpf_map_lookup_elem(&results, &k);
	if (r) {
		args[0] = (unsigned long long)(long)fill_490;
		args[1] = (unsigned long long)(long)ip6;
		args[2] = 0x1122334455667788ULL;
		barrier_var(args[0]);
		r->ret = bpf_snprintf(r->buf, sizeof(r->buf), "%s%pI6%lld", args, sizeof(args));
	}

	return 0;
}

char LICENSE[] SEC("license") = "GPL";
=== END poc_warn.bpf.c ===

=== BEGIN poc_warn.c ===
// SPDX-License-Identifier: GPL-2.0
#define _GNU_SOURCE
#include <errno.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/syscall.h>
#include <unistd.h>
#include <bpf/bpf.h>
#include <bpf/libbpf.h>

struct res_entry {
	int ret;
	char buf[1024];
};

int main(int argc, char **argv)
{
	const char *obj_path = argc > 1 ? argv[1] : "./poc_warn.bpf.o";
	struct bpf_object *obj;
	struct bpf_program *prog;
	struct bpf_link *link;
	struct bpf_map *map;
	int map_fd, key;

	obj = bpf_object__open_file(obj_path, NULL);
	if (libbpf_get_error(obj)) {
		fprintf(stderr, "open failed\n");
		return 1;
	}
	if (bpf_object__load(obj)) {
		fprintf(stderr, "load failed\n");
		return 1;
	}
	map = bpf_object__find_map_by_name(obj, ".bss");
	if (map) {
		__u32 zero = 0;
		__u32 pid = getpid();
		bpf_map_update_elem(bpf_map__fd(map), &zero, &pid, BPF_ANY);
	}
	prog = bpf_object__find_program_by_name(obj, "test_bprintf_warn");
	link = bpf_program__attach_raw_tracepoint(prog, "sys_enter");
	if (libbpf_get_error(link)) {
		fprintf(stderr, "attach failed: %ld\n", libbpf_get_error(link));
		return 1;
	}
	syscall(SYS_getpid);
	map = bpf_object__find_map_by_name(obj, "results");
	map_fd = bpf_map__fd(map);
	for (key = 0; key < 6; key++) {
		struct res_entry e = {};
		bpf_map_lookup_elem(map_fd, &key, &e);
		printf("case=%d ret=%d tail=%s buf=%.32s\n", key, e.ret,
		       strstr(e.buf, "TAIL_MARKER") ? "present" : "missing", e.buf);
	}
	bpf_link__destroy(link);
	bpf_object__close(obj);
	return 0;
}
=== END poc_warn.c ===

=== BEGIN warning log ===
[  319.177942] ------------[ cut here ]------------
[  319.177950] size > INT_MAX
[  319.177965] WARNING: lib/vsprintf.c:2875 at vsnprintf+0xfab/0x12a0, CPU#1: poc_warn/9504
[  319.179703] Modules linked in:
[  319.180253] CPU: 1 UID: 0 PID: 9504 Comm: poc_warn Not tainted 7.4.0-rc1-00171-g4b4eb7f44ee0 #1 PREEMPT(full)
[  319.181229] Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arch_caps fix, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[  319.182420] RIP: 0010:vsnprintf+0xfab/0x12a0
[  319.182902] Code: 0f b6 74 24 18 4c 01 6c 24 40 e8 30 a6 01 f6 c7 44 24 74 00 00 00 00 c7 44 24 18 00 00 00 00 e9 15 f8 ff ff e8 16 a6 01 f6 90 <0f> 0b 90 31 db e9 7a f4 ff ff e8 06 a6 01 f6 90 0f 0b 90 bb ff ff
[  319.184667] RSP: 0018:ffffc9000419fa28 EFLAGS: 00010293
[  319.185245] RAX: 0000000000000000 RBX: fffff52000833f62 RCX: 0000000000000001
[  319.185978] RDX: ffff8880262cddc0 RSI: ffffffff8bc3d6da RDI: 0000000000000007
[  319.186663] RBP: ffffc9000419fb00 R08: 000000007fffffff R09: ffffffffffffffed
[  319.187387] R10: ffff8880262cddc7 R11: 66663a666666663a R12: ffff88806a932833
[  319.188128] R13: ffffc9000419fc80 R14: ffffffffffffffed R15: ffff88806a932833
[  319.189247] FS:  0000000030fad380(0000) GS:ffff8880d62e4000(0000) knlGS:0000000000000000
[  319.190229] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  319.190858] CR2: 00007fc8691e9000 CR3: 000000004b566000 CR4: 00000000000506f0
[  319.191797] Call Trace:
[  319.192173]  <TASK>
[  319.192444]  ? __pfx_vsnprintf+0x10/0x10
[  319.192868]  ? __sys_bpf+0x218/0x4b40
[  319.193272]  ? widen_string+0xdc/0x2d0
[  319.193742]  snprintf+0xc7/0x100
[  319.194111]  ? __pfx_snprintf+0x10/0x10
[  319.194527]  ? string+0x2c1/0x4f0
[  319.194936]  ? copy_from_kernel_nofault_allowed+0xf8/0x130
[  319.195514]  bpf_bprintf_prepare+0x1181/0x13e0
[  319.196009]  ? __pfx_bpf_bprintf_prepare+0x10/0x10
[  319.196512]  ? __pfx_bstr_printf+0x10/0x10
[  319.196957]  ? __lock_acquire+0x5a5/0x1f70
[  319.197434]  bpf_snprintf+0x120/0x1e0
[  319.197855]  ? __pfx_bpf_snprintf+0x10/0x10
[  319.198332]  ? lock_acquire+0x1cb/0x370
[  319.198782]  ? bpf_trace_run2+0x5e4/0xd40
[  319.199220]  ? bpf_prog_5c039b4ee422ddd3_test_bprintf_warn+0x23c/0x557
[  319.199981]  bpf_prog_5c039b4ee422ddd3_test_bprintf_warn+0x2b3/0x557
[  319.200648]  bpf_trace_run2+0x332/0xd40
[  319.201103]  ? __pfx_bpf_trace_run2+0x10/0x10
[  319.201594]  ? __might_fault+0xbc/0x130
[  319.202088]  ? __might_fault+0x103/0x130
[  319.202519]  trace_syscall_enter+0xad/0x120
[  319.202964]  do_syscall_64+0x6c7/0x770
[  319.203374]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
=== END warning log ===

Best regards,
Luxiao Xu

Luxiao Xu (2):
  bpf: Fix scratch buffer cursor overflow in bpf_bprintf_prepare()
  selftests/bpf: Test bpf_bprintf_prepare() scratch buffer overflow

 kernel/bpf/helpers.c                          | 12 +++++++++--
 .../selftests/bpf/prog_tests/snprintf.c       |  6 ++++++
 .../selftests/bpf/progs/test_snprintf.c       | 21 +++++++++++++++++++
 3 files changed, 37 insertions(+), 2 deletions(-)

-- 
2.43.0
