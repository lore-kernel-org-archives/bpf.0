Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.231.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795468451;
	b=wai0kwvnkyVYRQiLE9RmUOfvArgdBqkfQ89NsgcOtGUinOP1F/9gWzp22QmLP9YAo+Rg
	 dpjxB2ipPP7gMMHTwkyPCMPyqBfrK37ZRgUaiD4YDiBhoaF2ziCZa4L5UFFFNVvYC2o9Y
	 /RyteqeSgOybZhF/FSRS2P/qRUUCQlv9LnaN7CAIB4mK3EGCaUhrL/V7Lkeahk+yMJoiP
	 0ew/LH06hEYn6H4lTgpZ6FWY7aHBcP0yffe+3B3lBGqmsAmIC23+ysIpwWLr2KybHNUke
	 qs2wkxdovAgV7a49ou4LwHQGBLWcou1iFFJls022fukMmAVY8KtrptfJEjjkJhJ1xsA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795468451;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 X-Developer-Signature:X-Developer-Key:Content-Transfer-Encoding;
	bh=2hxLRmcarSYMfSdQ2V9MhbpOfDyFYGJ5mU8BBWyovwE=;
	b=Vrq9W6uIrnT+7OfWjX+xWfjMboY0xYUobO7XwrynDZUig0AWWZTbemOCWv2ogIl5BbR1
	 j0hRRUvMH7vvcfevouxvY09cK00vTP0AHNRgmhQg25QaCRTFLhch+5mkWhw+DuWF1K5/T
	 v6zLNzLWcissIo9PlkZARG6luMB0YOAjBP6chsp5pSljRZIqyM/HduIpwaQbksvgFIY2z
	 b4Z9U2T2svsoaEHHJC9klRm+XN43zBe3Q0WCcomya2u63jvG4yCSKJHtmky4b9DCsWdOG
	 OFM0jCxGbcsKIfe6k/ImbmbDjxWvwQjvGg53W355aeWrrCsota4tQ0jTjfn7a/dXj/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GGSrGfTN;
	arc=none smtp.remote-ip=74.125.231.130
Received: from mail-oo2-f2.google.com (mail-oo2-f2.google.com [74.125.231.130])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E37606A31E
	for <bpf@vger.kernel.org>; Mon, 23 Nov 2026 21:14:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A6E37606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GGSrGfTN
Received: by mail-oo2-f2.google.com with SMTP id 46e09a7af769-862a50e0f92so533078a34.1
        for <bpf@vger.kernel.org>; Mon, 23 Nov 2026 13:14:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795468449; x=1796073249; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2hxLRmcarSYMfSdQ2V9MhbpOfDyFYGJ5mU8BBWyovwE=;
        b=GGSrGfTNuG6Gg4c/Xy8AW2DYnvyGPpcAiwtu5Q1tGbdegsOtVsAYB3jguZU0qrqU0t
         DD6KVlGrZ3wxQMfNtMuicZ/nuXhdDiWCCNVU9GU2gEPob7pqK5TE7j8Xo4+WjLdfH7cV
         Mwj+533GIdU6zhV4xrEd59+K/lXuuHHV3wt/RFXJvDaLLgVjTWzPbi2S8WIHUOEcMGAD
         YcXJU2dN2CqFiCu2hRHSq4vhJhWN5JhQBd8LDnnqtFuZBTTtpZPwbzm+vvFcxiUC5vqx
         I89+kJgVrJAkMbVlgDKHN7MJE8bnlpND7v5zXPsNEnKZzmfeJGNaw6xKr5UIO0wAL/Mp
         7jIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795468449; x=1796073249;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2hxLRmcarSYMfSdQ2V9MhbpOfDyFYGJ5mU8BBWyovwE=;
        b=BcMnxJHbuZ4cdOQ3MPEgPzCYTrvlQbKalGVDeaL50neglDX4CPUfIG75s7GvTfa24m
         aKaaO6ezyC/XenSqn7LEv39X7s6vZgC3YdCHrH5kFnhe8biLfH8n5meGJ5++4542FRpD
         QgORdAxXJYQqjng1k6sm8RQse7Jf0NeqABQPsro/eXFSRmIBXVXU5ioiZ6htuByJIFxA
         vLZwqKdQlTaSs5L4h+a/1uT2QyNaj6Vpm2+7URBGUD3cA7oYoJTxVjq2Jq3I9jg1m48B
         Phg0t1t7qA+cfxjBNhUeFxWySfdFUrIoFS13YjUJId3zR+fQq4dGVfAv20onItS05FxO
         EEFA==
X-Gm-Message-State: APuU4Z8jGvcz2+nzU7peOGMSoe8GfFqxVPEzUhhaATqvC0gFJWhmM4Ju
	MeyIMZ+Lx2mSqoJgu8EalB+3/y8S45SvzEc8znWfW1YlwRV2tDFc2leEJG4gHWF5Suc=
X-Gm-Gg: AZFdTZeC5xZt9PweytjeXayaz9iI6GelwBeXtFyG8Or65QneQ+4OYIZhZK3vy47NIdN
	oxWiO3m2BYbnh0Qvx2oSvLGIJAi3qz77Df08s8OJm2VEIDv9aNYJSJz9L9n9oh0UnqcNOKzrgZf
	YLda64gii8ohb/27ZuZrUIk8eh2BZ+cXxhAMogIzD8d9tHVaPTLufJtPf6xit6QMnokM3wk9BTM
	izxqnEQfdSZxLwMa7qaOdLsQQU/Gls1B0cViMUIafhaUMGMddgUW+ZOp/5xpA7NFIFQK6x3xtZ/
	4zFcFpfg8rUA82b1xnUY+qJcwOwxmbRE2C27CjZMBzepTKWL9gFz7tbH6DsPNCS/Ssck7BfCDNP
	MDGyw7UhYwR/zhnRdIwfZBCWLtdsCdc9Fb/MOkO+VlSDPrfu7C0ukhsagSZ8Vmqir3xEtngCanI
	0Lt97K1ZNCUi28rEFmEAx/t55D4OlbQFqJW2ameWb+AEmMmrEKMXOYUGJqhLG/JETO5jtCsDGdg
	wmZBKB0Aj3zFPS5NPpPg+dy0N8nG4RtL+dPgpiUhUFphF3aY/MuSJuB9Q9VJfxbb1IH9uXCdhnN
	kDUEqp9kKifj//zXUD+7JJwO4SWigYkuUVNhL2H3TKOUq7h42ZV6gSryLsH3sn+Z5wP8shVcEAo
	6+ple+KPeG0ndyYvFPC1fy6X8EGmTGjF0ul02zQzZjgWWymOuLsEKYo+Dog==
X-Received: by 2002:a05:6808:10d0:b0:579:7ac6:3a80 with SMTP id 5614622812f47-57a06b2355amr14270788b6e.1.1795468449417;
        Mon, 23 Nov 2026 13:14:09 -0800 (PST)
Received: from localhost ([2a03:2880:10ff:4e::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-57a3575f5bfsm9967370b6e.14.2026.11.23.13.14.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 13:14:07 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Xu Kuohai <xukuohai@huawei.com>,
	Tamir Duberstein <tamird@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 10/10] selftests/bpf: Add tests for the ring buffer record API
Date: Mon, 23 Nov 2026 22:13:33 +0100
Message-ID: <107b5d4cfd8911f388ccfb2cd06e08185f1bb60c.1795467315.git.memxor@gmail.com>
X-Mailer: git-send-email 2.53.1
In-Reply-To: <cover.1795467315.git.memxor@gmail.com>
References: <cover.1795467315.git.memxor@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=22683; h=from:subject:message-id; bh=6OIhur2woY28NqCLkyvKTKUfpIRRDnklIQ1nisExp0Y=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIZtlham0v906e6kZy201Dy4w4koPFHbl47RTvJYR9+zhxvmL t/t3lLIwiHExyIopspT838dkfKLyd6DtMm6YOaxMIEMYuDgFYCJ/8hgZVszrz/a/cOCK9vonyfP3/s oJfitybsKvhSo5FxZI3Jd+u4KRYU3Yk+hHz+LfccTX39i96uCV27M/SKjOeOm6nZMro5D7Mw8A
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Add tests for ring__next(), ring__release(), ring__rewind(),
ring__invalidated(), ring__new(), ring__free() and ring_buffer__wait().
Records are produced by a syscall program run with
bpf_prog_test_run_opts(), and every 8-byte word of a record holds its
sequence number, so that the tests can check all of the data they read.

 - basic: records of different sizes, release after all and after only
   some of the available records were returned.
 - rewind_discard: rewind, discarded records.
 - manager: ring_buffer__wait() with rings with and without a callback,
   ring__next() on a ring with a callback, ring__free() on a ring owned by
   the manager.
 - standalone: ring__new() and ring__free(), edge-triggered epoll on the
   map fd.
 - overwrite_basic: only the most recent records are returned from an
   overwritable ring buffer. The API doesn't report overwritten bytes; the
   test computes them from the positions of consecutive records.
 - overwrite_batch: ring__invalidated() covers the records returned since
   the last release or rewind.
 - overwrite_race: consume while a thread keeps producing for 1.5 seconds.
   Every record that passes ring__invalidated() must have valid data and
   sequence numbers must only increase.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../selftests/bpf/prog_tests/ringbuf_iter.c   | 586 ++++++++++++++++++
 .../selftests/bpf/progs/test_ringbuf_iter.c   |  66 ++
 2 files changed, 652 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/ringbuf_iter.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_ringbuf_iter.c

diff --git a/tools/testing/selftests/bpf/prog_tests/ringbuf_iter.c b/tools/testing/selftests/bpf/prog_tests/ringbuf_iter.c
new file mode 100644
index 000000000000..d416bb19d101
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/ringbuf_iter.c
@@ -0,0 +1,586 @@
+// SPDX-License-Identifier: GPL-2.0
+#define _GNU_SOURCE
+#include <test_progs.h>
+#include <sys/epoll.h>
+#include <pthread.h>
+#include "test_ringbuf_iter.skel.h"
+
+/* Mirrors the context of the producer programs. */
+struct produce_args {
+	__u64 seq;
+	__u32 count;
+	__u32 size;
+	__u32 discard_mod;
+	__u32 flags;
+	__u32 produced;
+};
+
+static int page_size;
+
+static int produce(int prog_fd, struct produce_args *args)
+{
+	/* Syscall programs copy the context back into ctx_in. */
+	LIBBPF_OPTS(bpf_test_run_opts, opts,
+		.ctx_in = args,
+		.ctx_size_in = sizeof(*args),
+	);
+	int err;
+
+	args->produced = 0;
+	err = bpf_prog_test_run_opts(prog_fd, &opts);
+	if (!ASSERT_OK(err, "produce_run") || !ASSERT_OK(opts.retval, "produce_retval") ||
+	    !ASSERT_EQ(args->produced, args->count, "produced"))
+		return -1;
+	return 0;
+}
+
+/*
+ * Produce `count` records of `size` bytes. Every 8-byte word of a record holds
+ * its sequence number, and sequence numbers start at `seq`.
+ */
+static int produce_n(int prog_fd, __u64 seq, __u32 count, __u32 size)
+{
+	struct produce_args args = { .seq = seq, .count = count, .size = size };
+
+	return produce(prog_fd, &args);
+}
+
+/* Check that every 8-byte word of a record holds `seq`. */
+static bool record_ok(const void *data, __u32 len, __u64 seq)
+{
+	const __u64 *w = data;
+	__u32 i;
+
+	if (len % 8)
+		return false;
+	for (i = 0; i < len / 8; i++) {
+		if (w[i] != seq)
+			return false;
+	}
+	return true;
+}
+
+/* ASSERT_OK_PTR() passes for NULL when errno is 0, and an empty ring doesn't set errno */
+static const struct ring_rec *next_rec(struct ring *r, const char *name)
+{
+	const struct ring_rec *rec = ring__next(r);
+
+	ASSERT_TRUE(rec != NULL, name);
+	return rec;
+}
+
+static int count_cb(void *ctx, void *data, size_t len)
+{
+	(*(int *)ctx)++;
+	return 0;
+}
+
+static struct test_ringbuf_iter *open_load(size_t normal_sz, size_t overwrite_sz)
+{
+	struct test_ringbuf_iter *skel;
+	int err;
+
+	skel = test_ringbuf_iter__open();
+	if (!ASSERT_OK_PTR(skel, "skel_open"))
+		return NULL;
+	bpf_map__set_max_entries(skel->maps.ringbuf, normal_sz);
+	bpf_map__set_max_entries(skel->maps.ringbuf_ow, overwrite_sz);
+	err = test_ringbuf_iter__load(skel);
+	if (!ASSERT_OK(err, "skel_load")) {
+		test_ringbuf_iter__destroy(skel);
+		return NULL;
+	}
+	return skel;
+}
+
+static void subtest_basic(void)
+{
+	struct test_ringbuf_iter *skel;
+	const struct ring_rec *rec;
+	struct ring_rec first = {};
+	struct ring_buffer *rb;
+	unsigned long cons;
+	struct ring *r;
+	int prog_fd, i;
+
+	skel = open_load(4 * page_size, page_size);
+	if (!skel)
+		return;
+	prog_fd = bpf_program__fd(skel->progs.produce_normal);
+
+	rb = ring_buffer__new(bpf_map__fd(skel->maps.ringbuf), NULL, NULL, NULL);
+	if (!ASSERT_OK_PTR(rb, "ring_buffer__new"))
+		goto out;
+	r = ring_buffer__ring(rb, 0);
+
+	/* Nothing to consume in an empty ring, and that is not an error. */
+	errno = 0;
+	ASSERT_NULL(ring__next(r), "next_empty");
+	ASSERT_EQ(errno, 0, "next_empty_errno");
+	ASSERT_EQ(ring__release(r), 0, "release_empty");
+
+	/* Records of different sizes, including empty ones. */
+	if (produce_n(prog_fd, 0, 10, 8) || produce_n(prog_fd, 10, 10, 0) ||
+	    produce_n(prog_fd, 20, 10, 120) || produce_n(prog_fd, 30, 10, 256))
+		goto out_rb;
+
+	cons = ring__consumer_pos(r);
+	for (i = 0; i < 40; i++) {
+		rec = next_rec(r, "next");
+		if (!rec)
+			goto out_rb;
+		ASSERT_EQ(rec->len, i < 10 ? 8 : i < 20 ? 0 : i < 30 ? 120 : 256, "rec_len");
+		ASSERT_TRUE(record_ok(rec->data, rec->len, i), "rec_data");
+		if (i == 0)
+			first = *rec;
+	}
+	ASSERT_NULL(ring__next(r), "next_drained");
+	/* Records are not consumed until they are released, and stay valid until then. */
+	ASSERT_EQ(ring__consumer_pos(r), cons, "cons_unchanged");
+	ASSERT_EQ(first.pos, cons, "first_rec_pos");
+	ASSERT_TRUE(record_ok(first.data, first.len, 0), "first_rec_data");
+	/* Records of a regular ring are never overwritten. */
+	ASSERT_FALSE(ring__invalidated(r), "invalidated");
+
+	ASSERT_EQ(ring__release(r), 0, "release");
+	ASSERT_EQ(ring__consumer_pos(r), ring__producer_pos(r), "cons_caught_up");
+
+	/* ring__release() consumes only the returned records, and tells if there are more. */
+	if (produce_n(prog_fd, 40, 2, 16))
+		goto out_rb;
+	rec = next_rec(r, "next_partial");
+	if (!rec)
+		goto out_rb;
+	ASSERT_EQ(ring__release(r), 1, "release_partial");
+	ASSERT_EQ(ring__consumer_pos(r), rec->pos + BPF_RINGBUF_HDR_SZ + 16, "cons_partial");
+	rec = next_rec(r, "next_rest");
+	if (rec)
+		ASSERT_TRUE(record_ok(rec->data, rec->len, 41), "rest_data");
+	ASSERT_NULL(ring__next(r), "next_rest_end");
+	ASSERT_EQ(ring__release(r), 0, "release_rest");
+
+out_rb:
+	ring_buffer__free(rb);
+out:
+	test_ringbuf_iter__destroy(skel);
+}
+
+static void subtest_rewind_discard(void)
+{
+	struct produce_args args = { .seq = 0, .count = 20, .size = 32, .discard_mod = 4 };
+	struct test_ringbuf_iter *skel;
+	const struct ring_rec *rec;
+	struct ring_buffer *rb;
+	struct ring *r;
+	int prog_fd, i;
+	__u64 seq;
+
+	skel = open_load(4 * page_size, page_size);
+	if (!skel)
+		return;
+	prog_fd = bpf_program__fd(skel->progs.produce_normal);
+
+	rb = ring_buffer__new(bpf_map__fd(skel->maps.ringbuf), NULL, NULL, NULL);
+	if (!ASSERT_OK_PTR(rb, "ring_buffer__new"))
+		goto out;
+	r = ring_buffer__ring(rb, 0);
+
+	/* Every 4th record is discarded: seq 0, 4, 8, 12, 16 never show up. */
+	if (produce(prog_fd, &args))
+		goto out_rb;
+
+	/* Rewind after three records, and get all records from the first one again. */
+	for (i = 0; i < 3; i++)
+		ASSERT_TRUE(ring__next(r) != NULL, "next_before_rewind");
+	ring__rewind(r);
+	for (seq = 1; seq < 20; seq++) {
+		if (seq % 4 == 0)
+			continue;
+		rec = next_rec(r, "next");
+		if (!rec)
+			goto out_rb;
+		ASSERT_TRUE(record_ok(rec->data, rec->len, seq), "rec_data");
+	}
+	ASSERT_NULL(ring__next(r), "next_end");
+	ASSERT_EQ(ring__release(r), 0, "release");
+	ASSERT_EQ(ring__consumer_pos(r), ring__producer_pos(r), "cons_caught_up");
+
+	/* A discarded record at the end is skipped and consumed as well. */
+	args.seq = 20;
+	args.count = 1;
+	args.discard_mod = 1;
+	if (produce(prog_fd, &args))
+		goto out_rb;
+	ASSERT_NULL(ring__next(r), "next_only_discarded");
+	ASSERT_EQ(ring__release(r), 0, "release_discarded");
+	ASSERT_EQ(ring__consumer_pos(r), ring__producer_pos(r), "cons_past_discarded");
+
+out_rb:
+	ring_buffer__free(rb);
+out:
+	test_ringbuf_iter__destroy(skel);
+}
+
+/* Wait with ring_buffer__wait() and consume with ring__next(). */
+static void subtest_manager(void)
+{
+	struct test_ringbuf_iter *skel;
+	struct ring_buffer *rb;
+	struct ring *r_cb, *r_ow;
+	int normal_fd, ow_fd, cb_cnt = 0;
+
+	skel = open_load(page_size, page_size);
+	if (!skel)
+		return;
+	normal_fd = bpf_program__fd(skel->progs.produce_normal);
+	ow_fd = bpf_program__fd(skel->progs.produce_overwrite);
+
+	/* The regular ring has a callback, the overwritable one doesn't. */
+	rb = ring_buffer__new(bpf_map__fd(skel->maps.ringbuf), count_cb, &cb_cnt, NULL);
+	if (!ASSERT_OK_PTR(rb, "ring_buffer__new"))
+		goto out;
+	if (!ASSERT_OK(ring_buffer__add(rb, bpf_map__fd(skel->maps.ringbuf_ow), NULL, NULL),
+		       "ring_buffer__add"))
+		goto out_rb;
+	r_cb = ring_buffer__ring(rb, 0);
+	r_ow = ring_buffer__ring(rb, 1);
+
+	/* A ring with a callback can't be used with ring__next(). */
+	errno = 0;
+	ASSERT_NULL(ring__next(r_cb), "next_cb_ring");
+	ASSERT_EQ(errno, EINVAL, "next_cb_ring_errno");
+	ASSERT_EQ(ring__release(r_cb), -EINVAL, "release_cb_ring");
+
+	/* ring__free() only warns for a ring that is owned by a manager; r_ow is used below. */
+	ring__free(r_ow);
+
+	/* ring_buffer__wait() returns the number of rings with data and consumes nothing. */
+	ASSERT_EQ(ring_buffer__wait(rb, 0), 0, "wait_empty");
+	if (produce_n(ow_fd, 0, 2, 16))
+		goto out_rb;
+	ASSERT_EQ(ring_buffer__wait(rb, 1000), 1, "wait_one");
+	if (produce_n(normal_fd, 0, 3, 16))
+		goto out_rb;
+	ASSERT_EQ(ring_buffer__wait(rb, 1000), 2, "wait_both");
+	ASSERT_EQ(cb_cnt, 0, "wait_cb_not_called");
+
+	/* The data is consumed afterwards, through the callback or with ring__next(). */
+	ASSERT_EQ(ring__consume(r_cb), 3, "consume");
+	ASSERT_EQ(cb_cnt, 3, "consume_cb");
+	ASSERT_TRUE(ring__next(r_ow) != NULL, "next1");
+	ASSERT_TRUE(ring__next(r_ow) != NULL, "next2");
+	ASSERT_NULL(ring__next(r_ow), "next_end");
+	/* A ring has data until its records are released. */
+	ASSERT_EQ(ring_buffer__wait(rb, 0), 1, "wait_unreleased");
+	ASSERT_EQ(ring__release(r_ow), 0, "release");
+	ASSERT_EQ(ring_buffer__wait(rb, 0), 0, "wait_released");
+
+out_rb:
+	ring_buffer__free(rb);
+out:
+	test_ringbuf_iter__destroy(skel);
+}
+
+static void subtest_standalone(void)
+{
+	struct epoll_event ev = { .events = EPOLLIN | EPOLLET };
+	struct test_ringbuf_iter *skel;
+	const struct ring_rec *rec;
+	int prog_fd, epfd, arr_fd;
+	struct ring *r, *bad;
+	__u64 seq = 0;
+
+	skel = open_load(page_size, page_size);
+	if (!skel)
+		return;
+	prog_fd = bpf_program__fd(skel->progs.produce_normal);
+
+	/* ring__new() only takes ring buffer maps. */
+	arr_fd = bpf_map_create(BPF_MAP_TYPE_ARRAY, NULL, 4, 4, 1, NULL);
+	if (!ASSERT_OK_FD(arr_fd, "array_create"))
+		goto out;
+	bad = ring__new(arr_fd, NULL);
+	ASSERT_ERR_PTR(bad, "ring__new_array");
+	ASSERT_EQ(errno, EINVAL, "ring__new_array_errno");
+	close(arr_fd);
+
+	r = ring__new(bpf_map__fd(skel->maps.ringbuf), NULL);
+	if (!ASSERT_OK_PTR(r, "ring__new"))
+		goto out;
+
+	/* Wait with edge-triggered epoll on the map fd. */
+	epfd = epoll_create1(EPOLL_CLOEXEC);
+	if (!ASSERT_OK_FD(epfd, "epoll_create1"))
+		goto out_ring;
+	if (!ASSERT_OK(epoll_ctl(epfd, EPOLL_CTL_ADD, ring__map_fd(r), &ev), "epoll_ctl"))
+		goto out_epoll;
+
+	if (produce_n(prog_fd, 0, 5, 16))
+		goto out_epoll;
+	ASSERT_EQ(epoll_wait(epfd, &ev, 1, 1000), 1, "epoll_ready");
+	do {
+		while ((rec = ring__next(r)))
+			ASSERT_TRUE(record_ok(rec->data, rec->len, seq++), "rec_data");
+	} while (ring__release(r) > 0);
+	ASSERT_EQ(ring__consumer_pos(r), ring__producer_pos(r), "cons_caught_up");
+
+	/* The records were released, so the next record wakes us up again. */
+	if (produce_n(prog_fd, 5, 1, 16))
+		goto out_epoll;
+	ASSERT_EQ(epoll_wait(epfd, &ev, 1, 1000), 1, "epoll_ready_again");
+
+out_epoll:
+	close(epfd);
+out_ring:
+	ring__free(r);
+out:
+	test_ringbuf_iter__destroy(skel);
+}
+
+/* Only the most recent records are left in an overwritable ring. */
+static void subtest_overwrite_basic(void)
+{
+	__u32 size = 120, rec_sz = size + BPF_RINGBUF_HDR_SZ, per_ring = page_size / rec_sz;
+	struct test_ringbuf_iter *skel;
+	unsigned long next_pos, lost;
+	const struct ring_rec *rec;
+	struct ring *r;
+	int prog_fd, n = 0;
+	__u64 seq = 0;
+
+	skel = open_load(page_size, page_size);
+	if (!skel)
+		return;
+	prog_fd = bpf_program__fd(skel->progs.produce_overwrite);
+	r = ring__new(bpf_map__fd(skel->maps.ringbuf_ow), NULL);
+	if (!ASSERT_OK_PTR(r, "ring__new"))
+		goto out;
+
+	/* Fill the ring 3 times over. */
+	if (produce_n(prog_fd, 0, 3 * per_ring, size))
+		goto out_ring;
+	ASSERT_LE(ring__avail_data_size(r), page_size, "avail_data_size");
+
+	next_pos = ring__consumer_pos(r);
+	while ((rec = ring__next(r))) {
+		/*
+		 * The API doesn't report how many bytes were overwritten before a
+		 * record. It is the distance from the end of the previous record.
+		 */
+		lost = rec->pos - next_pos;
+		next_pos = rec->pos + rec_sz;
+		/* All records before the first one that is left were overwritten. */
+		if (n++ == 0)
+			seq = lost / rec_sz;
+		else
+			ASSERT_EQ(lost, 0, "lost_bytes");
+		ASSERT_TRUE(record_ok(rec->data, rec->len, seq++), "rec_data");
+	}
+	/* The ring holds at most per_ring records, and the last one is the newest. */
+	ASSERT_GT(n, 0, "records");
+	ASSERT_LE(n, per_ring, "records_in_ring");
+	ASSERT_EQ(seq, 3 * per_ring, "newest_record");
+	ASSERT_FALSE(ring__invalidated(r), "invalidated");
+	ASSERT_EQ(ring__release(r), 0, "release");
+	ASSERT_EQ(ring__consumer_pos(r), ring__producer_pos(r), "cons_caught_up");
+
+out_ring:
+	ring__free(r);
+out:
+	test_ringbuf_iter__destroy(skel);
+}
+
+/*
+ * ring__invalidated() covers all records returned since the last release or
+ * rewind. Records take 64 bytes. The kernel keeps less than a ring size of
+ * records, so the ring is full with per_ring of them, and every new record
+ * overwrites the oldest one.
+ */
+static void subtest_overwrite_batch(void)
+{
+	__u32 size = 56, rec_sz = size + BPF_RINGBUF_HDR_SZ, per_ring = page_size / rec_sz - 1;
+	struct test_ringbuf_iter *skel;
+	const struct ring_rec *rec;
+	__u64 seq, next_seq;
+	struct ring *r;
+	int prog_fd, i;
+
+	skel = open_load(page_size, page_size);
+	if (!skel)
+		return;
+	prog_fd = bpf_program__fd(skel->progs.produce_overwrite);
+	r = ring__new(bpf_map__fd(skel->maps.ringbuf_ow), NULL);
+	if (!ASSERT_OK_PTR(r, "ring__new"))
+		goto out;
+
+	if (produce_n(prog_fd, 0, per_ring, size))
+		goto out_ring;
+	seq = per_ring;
+
+	/* No records were returned yet. */
+	ASSERT_FALSE(ring__invalidated(r), "invalidated_nothing");
+
+	for (i = 0; i < 4; i++)
+		ASSERT_TRUE(ring__next(r) != NULL, "batch1_next");
+	ASSERT_FALSE(ring__invalidated(r), "batch1_invalidated");
+
+	/* Records 0 and 1 get overwritten. Getting more records doesn't change the result. */
+	if (produce_n(prog_fd, seq, 2, size))
+		goto out_ring;
+	seq += 2;
+	ASSERT_TRUE(ring__invalidated(r), "batch1_overwritten");
+	for (i = 4; i < 8; i++)
+		ASSERT_TRUE(ring__next(r) != NULL, "batch1_next_more");
+	ASSERT_TRUE(ring__invalidated(r), "batch1_still_overwritten");
+
+	/* Records returned before a release are not checked anymore. */
+	ASSERT_EQ(ring__release(r), 1, "release");
+	ASSERT_FALSE(ring__invalidated(r), "invalidated_after_release");
+	for (i = 8; i < 10; i++)
+		ASSERT_TRUE(ring__next(r) != NULL, "batch2_next");
+	ASSERT_FALSE(ring__invalidated(r), "batch2_invalidated");
+
+	/* Records 2 to 10 get overwritten, which includes the two returned last. */
+	if (produce_n(prog_fd, seq, 9, size))
+		goto out_ring;
+	seq += 9;
+	ASSERT_TRUE(ring__invalidated(r), "batch2_overwritten");
+
+	/* After a rewind ring__next() continues from the oldest record that is left. */
+	ring__rewind(r);
+	ASSERT_FALSE(ring__invalidated(r), "invalidated_after_rewind");
+	next_seq = 11;
+	while ((rec = ring__next(r))) {
+		ASSERT_EQ(rec->pos, next_seq * rec_sz, "batch3_pos");
+		ASSERT_TRUE(record_ok(rec->data, rec->len, next_seq), "batch3_data");
+		next_seq++;
+	}
+	ASSERT_EQ(next_seq, seq, "batch3_all_records");
+	ASSERT_FALSE(ring__invalidated(r), "batch3_invalidated");
+	ASSERT_EQ(ring__release(r), 0, "release_end");
+
+out_ring:
+	ring__free(r);
+out:
+	test_ringbuf_iter__destroy(skel);
+}
+
+struct race_ctx {
+	int prog_fd;
+	volatile bool stop;
+};
+
+static void *race_producer(void *arg)
+{
+	static const __u32 sizes[] = { 8, 24, 64, 120, 256, 16 };
+	struct race_ctx *ctx = arg;
+	struct produce_args args = { .count = 16, .flags = BPF_RB_NO_WAKEUP };
+	LIBBPF_OPTS(bpf_test_run_opts, opts,
+		.ctx_in = &args,
+		.ctx_size_in = sizeof(args),
+	);
+	int i = 0;
+
+	while (!ctx->stop) {
+		args.size = sizes[i++ % ARRAY_SIZE(sizes)];
+		if (bpf_prog_test_run_opts(ctx->prog_fd, &opts))
+			break;
+	}
+	return NULL;
+}
+
+#define RACE_BATCH	8
+#define RACE_MAX_LEN	256
+
+/*
+ * Consume an overwritable ring while a thread keeps producing into it. Records
+ * that were not overwritten must have valid data and increasing sequence
+ * numbers. The length of a record must be valid even if it was overwritten.
+ *
+ * The checks run for every record, so they don't use ASSERT_*(), which logs
+ * every pass.
+ */
+static void subtest_overwrite_race(void)
+{
+	__u64 copy[RACE_BATCH][RACE_MAX_LEN / 8];
+	__u64 end, pause, iter, seq, next_seq = 0;
+	struct test_ringbuf_iter *skel;
+	const struct ring_rec *rec;
+	struct race_ctx ctx = {};
+	__u32 len[RACE_BATCH];
+	pthread_t thread;
+	struct ring *r;
+	int i, n;
+
+	skel = open_load(page_size, page_size);
+	if (!skel)
+		return;
+	ctx.prog_fd = bpf_program__fd(skel->progs.produce_overwrite);
+	r = ring__new(bpf_map__fd(skel->maps.ringbuf_ow), NULL);
+	if (!ASSERT_OK_PTR(r, "ring__new"))
+		goto out;
+
+	if (!ASSERT_OK(pthread_create(&thread, NULL, race_producer, &ctx), "pthread_create"))
+		goto out_ring;
+
+	end = get_time_ns() + 1500000000ULL;
+	for (iter = 0; get_time_ns() < end; iter++) {
+		/* Copy a batch of records, then check that none of them was overwritten. */
+		for (n = 0; n < RACE_BATCH && (rec = ring__next(r)); n++) {
+			if (rec->len < 8 || rec->len > RACE_MAX_LEN || rec->len % 8) {
+				PRINT_FAIL("record at %lu has length %u\n", rec->pos, rec->len);
+				goto out_thread;
+			}
+			memcpy(copy[n], rec->data, rec->len);
+			len[n] = rec->len;
+		}
+		/* Sometimes wait before the check, so that the producer laps us. */
+		if (iter % 32 == 0) {
+			pause = get_time_ns() + 50000;
+			while (get_time_ns() < pause)
+				;
+		}
+		if (ring__invalidated(r))
+			n = 0;
+		for (i = 0; i < n; i++) {
+			seq = copy[i][0];
+			if (!record_ok(copy[i], len[i], seq) || seq < next_seq) {
+				PRINT_FAIL("bad record %llu, expected %llu or more\n",
+					   seq, next_seq);
+				goto out_thread;
+			}
+			next_seq = seq + 1;
+		}
+		ring__release(r);
+	}
+
+out_thread:
+	ctx.stop = true;
+	pthread_join(thread, NULL);
+	ASSERT_GT(next_seq, 0, "valid_records");
+
+out_ring:
+	ring__free(r);
+out:
+	test_ringbuf_iter__destroy(skel);
+}
+
+void test_ringbuf_iter(void)
+{
+	page_size = getpagesize();
+
+	if (test__start_subtest("basic"))
+		subtest_basic();
+	if (test__start_subtest("rewind_discard"))
+		subtest_rewind_discard();
+	if (test__start_subtest("manager"))
+		subtest_manager();
+	if (test__start_subtest("standalone"))
+		subtest_standalone();
+	if (test__start_subtest("overwrite_basic"))
+		subtest_overwrite_basic();
+	if (test__start_subtest("overwrite_batch"))
+		subtest_overwrite_batch();
+	if (test__start_subtest("overwrite_race"))
+		subtest_overwrite_race();
+}
diff --git a/tools/testing/selftests/bpf/progs/test_ringbuf_iter.c b/tools/testing/selftests/bpf/progs/test_ringbuf_iter.c
new file mode 100644
index 000000000000..10c146ec6a70
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_ringbuf_iter.c
@@ -0,0 +1,66 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+
+char _license[] SEC("license") = "GPL";
+
+struct {
+	__uint(type, BPF_MAP_TYPE_RINGBUF);
+} ringbuf SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_RINGBUF);
+	__uint(map_flags, BPF_F_RB_OVERWRITE);
+} ringbuf_ow SEC(".maps");
+
+/*
+ * Context of the producer programs, which are run with
+ * bpf_prog_test_run_opts(). Every 8-byte word of a record holds its sequence
+ * number, so that the consumer can check all of its data.
+ */
+struct produce_args {
+	__u64 seq;		/* in: first sequence number, out: next one */
+	__u32 count;		/* records to produce */
+	__u32 size;		/* record size in bytes */
+	__u32 discard_mod;	/* discard records whose seq is a multiple of this, 0: none */
+	__u32 flags;		/* submit/discard flags, e.g. BPF_RB_NO_WAKEUP */
+	__u32 produced;		/* out: records produced */
+};
+
+static __always_inline int produce(void *map, struct produce_args *args)
+{
+	__u32 size = args->size, words = size / 8;
+	__u64 seq = args->seq;
+	struct bpf_dynptr ptr;
+	int i, j;
+
+	bpf_for(i, 0, args->count) {
+		if (bpf_ringbuf_reserve_dynptr(map, size, 0, &ptr)) {
+			bpf_ringbuf_discard_dynptr(&ptr, 0);
+			continue;
+		}
+		bpf_for(j, 0, words)
+			bpf_dynptr_write(&ptr, j * 8, &seq, 8, 0);
+		if (args->discard_mod && seq % args->discard_mod == 0)
+			bpf_ringbuf_discard_dynptr(&ptr, args->flags);
+		else
+			bpf_ringbuf_submit_dynptr(&ptr, args->flags);
+		args->produced++;
+		seq++;
+	}
+	args->seq = seq;
+	return 0;
+}
+
+SEC("syscall")
+int produce_normal(struct produce_args *args)
+{
+	return produce(&ringbuf, args);
+}
+
+SEC("syscall")
+int produce_overwrite(struct produce_args *args)
+{
+	return produce(&ringbuf_ow, args);
+}
-- 
2.53.1-Meta

