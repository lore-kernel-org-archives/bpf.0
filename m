Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795206843;
	b=mxQfDnqeWR/ooZeTyigMV/yAEn1PD7+GnvqWwAFy5UwuCH6sgjDXcUpjHXg5mNT2KEny
	 6D+pGmqQCqYWoFG0THiieZQf3I5ncypKwzbq4daJSaKoLCz0QwkJx87bTLWo3+o6lePAD
	 y+RtjulfLoCR2/nTLt5osDHeyDRbTGH28HbCxN+IKl0sH8hce2PGTespidIRHHnFXhX5c
	 ADmsF6bDoAzGfxAH8jwdZHPSbi/L7pzczhEPhuYMYf+yaKzNeoLuBjTsfSSHoDv7ovoZk
	 QtJJewcott9EobxKDRXmlQAB2bAmWuTmWgLVmOnkSLHE0qhl08NcWzKitg0ktMEGXLA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795206843;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=Gqy4EFAQEByMql0TkIDnnIkbN1f27mHDZntMk+x4fzs=;
	b=Bjsvnl9nBq5XVXQIDw7uRb3vtD0Vu5g/OBIoIAWLnGz9oiiSHKo0CReXbun/bAnchn//
	 OoT7vMbhMPphOUKER9VLFl3SOBA74p7KmumJuFmKFESjVURFt2wcoW0kviPyP+VXN866w
	 jdB6uJu1M0rcI6IJXXXchq/4E3YZCCizXKx1qRBo3god4WauwO4B2lt3NOK7nZH7/DlUJ
	 shgWvbblrSTOSulCi3JnVL5sNOLwdrGAhv83AcsTr25RipIXWEZ4pZuN1N2OcyUaG55ML
	 7E0GRnkWaTcuXCat6lFY4KFqL75bzvFvUPADnXxyXve3333sogs2tGmVy4Xv3fOV+oQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aDlY4SjL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A0E9606A333;
	Fri, 20 Nov 2026 20:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aDlY4SjL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 560271F008B2;
	Fri, 20 Nov 2026 20:33:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795206842;
	bh=Gqy4EFAQEByMql0TkIDnnIkbN1f27mHDZntMk+x4fzs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=aDlY4SjLAOkRzu7ZTUUDaEhux1me4f4srArnWdbyQ+bULwiYszbGSXQzKDOsFZsIo
	 ErA1FplW9F9W6QbiP6JvcNoiuHbFMYi6U8K6OP402ftTjBf73bUBzuAjCZs5+LMn/x
	 8/3Cum4ftKsg9qeUzmk47Wkmq1/H3xtqjfgFmUfy23OZ3UKvt7LKxPLyQVlegSPdVZ
	 ZAVcTXjpqFv+TkrYkhEHfCF9LGGvIhhIRavLqvPC3rAXF3z8y44ncLcnuN0LUSAFf7
	 8lJ+Hh9JtWMQ10x5RKkyyQk2w9sJptxkEwuBGEQUBMRT2h9uOiBcgZhm2DXDgG9Z86
	 sIq6Mwr+TdnfQ==
From: Tamir Duberstein <tamird@kernel.org>
Date: Fri, 20 Nov 2026 15:33:21 -0500
Subject: [PATCH bpf-next v3 8/8] selftests/bpf: Test caller-owned ring
 iterators
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261120-bpf-ringbuf-fixes-v3-8-ff7ca15d6c37@kernel.org>
References: <20261120-bpf-ringbuf-fixes-v3-0-ff7ca15d6c37@kernel.org>
In-Reply-To: <20261120-bpf-ringbuf-fixes-v3-0-ff7ca15d6c37@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, Shuah Khan <shuah@kernel.org>, 
 Andrea Righi <arighi@nvidia.com>, Xu Kuohai <xukuohai@huawei.com>, 
 Andrea Righi <andrea.righi@canonical.com>, 
 Bing-Jhong Billy Jheng <billy@starlabs.sg>, 
 David Vernet <void@manifault.com>, Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Andrew Werner <awerner32@gmail.com>, 
 Zvi Effron <zeffron@riotgames.com>, Andrii Nakryiko <andriin@fb.com>, 
 Tamir Duberstein <tamird@kernel.org>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=8828; i=tamird@kernel.org;
 h=from:subject:message-id; bh=nDInK/pWiEsRlNGXgfkklwS744vQStXKJeJ/wZfgnQ4=;
 b=owGbwMvMwCV2wYdPVfy60HTG02pJDNkM62YVbP/tX/V/Ufxdm0pmq5MMaz/nKxjcLpFadPqs3
 POmb4caOiayMIhxMViKKbIkih7am556e49s5rvjMHNYmUCGSIs0MAABCwNfbmJeqZGOkZ6ptqGe
 oZGOgY4xAxenAEy11EyG/0FKzlz8hdVzu5y+inKsn8+x7HtS17yPpZ/15CK5mE0mxjMyHNFbVrd
 d6FlDyWeGeXuXWn+xSWto2PG5eN9PhvZ9PNeesQIA
X-Developer-Key: i=tamird@kernel.org; a=openpgp;
 fpr=5A6714204D41EC844C50273C19D6FF6092365380

Verify borrowed-record lifetime, exhaustion, destruction, discard
handling, batched publication, and callback-free iteration. Exercise
edge-triggered epoll while draining through one iterator and while
destroying and recreating the iterator after each record. Observe
exhaustion before waiting for another notification.

Allow the BPF producer to discard a record between returned records, so
the batching test also checks deferred publication across discards.

Signed-off-by: Tamir Duberstein <tamird@kernel.org>
---
 tools/testing/selftests/bpf/prog_tests/ringbuf.c   | 167 +++++++++++++++++++++
 tools/testing/selftests/bpf/progs/test_ringbuf_n.c |   7 +-
 2 files changed, 173 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/ringbuf.c b/tools/testing/selftests/bpf/prog_tests/ringbuf.c
index cfc357dfd1e9..3e5bb241e799 100644
--- a/tools/testing/selftests/bpf/prog_tests/ringbuf.c
+++ b/tools/testing/selftests/bpf/prog_tests/ringbuf.c
@@ -635,6 +635,10 @@ static void ringbuf_wakeup_subtest(void)
 					 process_noop_sample, NULL, NULL);
 	if (!ASSERT_OK_PTR(ringbuf, "ring_buffer__new"))
 		return;
+	struct ring *ring = ring_buffer__ring(ringbuf, 0);
+
+	if (!ASSERT_OK_PTR(ring, "ring_buffer__ring"))
+		return;
 
 	struct epoll_event event = {
 		.events = EPOLLIN | EPOLLET,
@@ -673,6 +677,41 @@ static void ringbuf_wakeup_subtest(void)
 		if (!ASSERT_OK(err, "ring_buffer__consume_n"))
 			return;
 	}
+
+	total = 0;
+	while (total < N_WAKEUP_SAMPLES) {
+		err = epoll_wait(epoll_fd, &event, 1, 1000);
+		if (!ASSERT_EQ(err, 1, "iterator_epoll_wait"))
+			return;
+
+		struct ring_buffer_iter iter
+			__attribute__((cleanup(ring_buffer_iter_destroy))) = {};
+		err = ring_buffer_iter_new(&iter, ring);
+		if (!ASSERT_OK(err, "ring_buffer_iter_new"))
+			return;
+		while (ring_buffer_iter_next(&iter, NULL, false))
+			total++;
+	}
+
+	/* Release each record through destruction before creating a new iterator. */
+	total = 0;
+	while (total < N_WAKEUP_SAMPLES) {
+		err = epoll_wait(epoll_fd, &event, 1, 1000);
+		if (!ASSERT_EQ(err, 1, "iterator_release_epoll_wait"))
+			return;
+
+		for (;;) {
+			struct ring_buffer_iter iter __attribute__((
+				cleanup(ring_buffer_iter_destroy))) = {};
+
+			err = ring_buffer_iter_new(&iter, ring);
+			if (!ASSERT_OK(err, "ring_buffer_iter_new"))
+				return;
+			if (!ring_buffer_iter_next(&iter, NULL, false))
+				break;
+			total++;
+		}
+	}
 }
 
 static void ringbuf_n_subtest(void)
@@ -733,6 +772,127 @@ static void ringbuf_n_subtest(void)
 		  "positive_callback");
 }
 
+static void ringbuf_iterator_subtest(void)
+{
+	struct test_ringbuf_n_lskel *skel_n
+		__attribute__((cleanup(cleanup_test_ringbuf_n_lskel))) =
+			test_ringbuf_n_lskel__open();
+	const struct sample_n *sample;
+	size_t sample_size;
+	int err, i;
+
+	if (!ASSERT_OK_PTR(skel_n, "test_ringbuf_n_lskel__open"))
+		return;
+
+	skel_n->maps.ringbuf.max_entries = getpagesize();
+	skel_n->bss->pid = getpid();
+	skel_n->bss->value = SAMPLE_VALUE;
+
+	err = test_ringbuf_n_lskel__load(skel_n);
+	if (!ASSERT_OK(err, "test_ringbuf_n_lskel__load"))
+		return;
+
+	err = test_ringbuf_n_lskel__attach(skel_n);
+	if (!ASSERT_OK(err, "test_ringbuf_n_lskel__attach"))
+		return;
+
+	struct ring_buffer *ringbuf
+		__attribute__((cleanup(cleanup_ring_buffer))) =
+			ring_buffer__new(skel_n->maps.ringbuf.map_fd, NULL,
+					 NULL, NULL);
+	if (!ASSERT_OK_PTR(ringbuf, "ring_buffer__new"))
+		return;
+
+	struct ring *ring = ring_buffer__ring(ringbuf, 0);
+
+	if (!ASSERT_OK_PTR(ring, "ring_buffer__ring"))
+		return;
+
+	struct ring_buffer_iter iter
+		__attribute__((cleanup(ring_buffer_iter_destroy))) = {};
+
+	for (i = 0; i < 3; i++)
+		syscall(__NR_getpgid);
+
+	unsigned long consumer_pos = ring__consumer_pos(ring);
+
+	err = ring_buffer_iter_new(&iter, ring);
+	if (!ASSERT_OK(err, "ring_buffer_iter_new"))
+		return;
+	sample = ring_buffer_iter_next(&iter, &sample_size, true);
+	if (!ASSERT_OK_PTR(sample, "ring_buffer_iter_next"))
+		return;
+	ASSERT_EQ(sample_size, sizeof(*sample), "sample_size");
+	ASSERT_EQ(sample->value, SAMPLE_VALUE, "sample_value");
+	ASSERT_EQ(ring__consumer_pos(ring), consumer_pos,
+		  "consumer_pos_iter_held");
+
+	ring_buffer_iter_destroy(&iter);
+	ASSERT_GT(ring__consumer_pos(ring), consumer_pos,
+		  "consumer_pos_released");
+
+	err = ring_buffer_iter_new(&iter, ring);
+	if (!ASSERT_OK(err, "ring_buffer_iter_new_remaining"))
+		return;
+	consumer_pos = ring__consumer_pos(ring);
+	for (i = 0; (sample = ring_buffer_iter_next(&iter, &sample_size, true));
+	     i++) {
+		ASSERT_EQ(sample_size, sizeof(*sample),
+			  "remaining_sample_size");
+		ASSERT_EQ(sample->value, SAMPLE_VALUE,
+			  "remaining_sample_value");
+		if (i)
+			ASSERT_GT(ring__consumer_pos(ring), consumer_pos,
+				  "consumer_pos_released_next");
+		consumer_pos = ring__consumer_pos(ring);
+	}
+	ASSERT_EQ(i, 2, "remaining_samples");
+	ASSERT_GT(ring__consumer_pos(ring), consumer_pos,
+		  "consumer_pos_released_null");
+
+	syscall(__NR_getpgid);
+	sample = ring_buffer_iter_next(&iter, &sample_size, true);
+	ASSERT_NULL(sample, "exhausted_iterator");
+	ring_buffer_iter_destroy(&iter);
+
+	err = ring_buffer_iter_new(&iter, ring);
+	if (!ASSERT_OK(err, "ring_buffer_iter_new_again"))
+		return;
+	sample = ring_buffer_iter_next(&iter, &sample_size, true);
+	if (!ASSERT_OK_PTR(sample, "ring_buffer_iter_next_again"))
+		return;
+	ASSERT_EQ(sample->value, SAMPLE_VALUE, "new_sample_value");
+	ring_buffer_iter_destroy(&iter);
+
+	for (i = 0; i < 4; i++) {
+		skel_n->bss->discard = i == 1;
+		syscall(__NR_getpgid);
+	}
+	skel_n->bss->discard = false;
+	consumer_pos = ring__consumer_pos(ring);
+	err = ring_buffer_iter_new(&iter, ring);
+	if (!ASSERT_OK(err, "ring_buffer_iter_new_batch"))
+		return;
+	for (i = 0; i < 2; i++) {
+		sample = ring_buffer_iter_next(&iter, &sample_size, false);
+		if (!ASSERT_OK_PTR(sample, "batch_sample"))
+			return;
+		ASSERT_EQ(ring__consumer_pos(ring), consumer_pos,
+			  "consumer_pos_deferred");
+	}
+	sample = ring_buffer_iter_next(&iter, &sample_size, true);
+	if (!ASSERT_OK_PTR(sample, "batch_sync_sample"))
+		return;
+	ASSERT_EQ(ring__consumer_pos(ring),
+		  ring__producer_pos(ring) - sizeof(*sample) -
+			  BPF_RINGBUF_HDR_SZ,
+		  "consumer_pos_batch_published");
+	sample = ring_buffer_iter_next(&iter, &sample_size, false);
+	ASSERT_NULL(sample, "batch_exhausted");
+	ASSERT_EQ(ring__consumer_pos(ring), ring__producer_pos(ring),
+		  "consumer_pos_batch_exhausted");
+}
+
 static int process_map_key_sample(void *ctx, void *data, size_t len)
 {
 	struct test_ringbuf_map_key_lskel *skel_map_key = ctx;
@@ -809,6 +969,9 @@ static void ringbuf_overwrite_callback_subtest(void)
 	if (!ASSERT_OK_PTR(ring, "ring_buffer__ring"))
 		return;
 
+	struct ring_buffer_iter iter
+		__attribute__((cleanup(ring_buffer_iter_destroy))) = {};
+
 	err = ring_buffer__consume_n(ringbuf, 0);
 	ASSERT_EQ(err, -EOPNOTSUPP, "ringbuf_consume_zero");
 	err = ring_buffer__consume(ringbuf);
@@ -819,6 +982,8 @@ static void ringbuf_overwrite_callback_subtest(void)
 	ASSERT_EQ(err, -EOPNOTSUPP, "ring_consume_zero");
 	err = ring__consume(ring);
 	ASSERT_EQ(err, -EOPNOTSUPP, "ring_consume");
+	err = ring_buffer_iter_new(&iter, ring);
+	ASSERT_EQ(err, -EOPNOTSUPP, "ring_buffer_iter_new");
 }
 
 static void ringbuf_overwrite_mode_subtest(void)
@@ -886,6 +1051,8 @@ void test_ringbuf(void)
 		ringbuf_subtest();
 	if (test__start_subtest("ringbuf_n"))
 		ringbuf_n_subtest();
+	if (test__start_subtest("ringbuf_iterator"))
+		ringbuf_iterator_subtest();
 	if (test__start_subtest("ringbuf_null_cb"))
 		ringbuf_null_cb_subtest();
 	if (test__start_subtest("ringbuf_wakeup"))
diff --git a/tools/testing/selftests/bpf/progs/test_ringbuf_n.c b/tools/testing/selftests/bpf/progs/test_ringbuf_n.c
index a95d4f597175..1727a2c32812 100644
--- a/tools/testing/selftests/bpf/progs/test_ringbuf_n.c
+++ b/tools/testing/selftests/bpf/progs/test_ringbuf_n.c
@@ -3,6 +3,7 @@
 
 #include <linux/bpf.h>
 #include <sched.h>
+#include <stdbool.h>
 #include <unistd.h>
 #include <bpf/bpf_helpers.h>
 #include "bpf_misc.h"
@@ -23,6 +24,7 @@ struct {
 
 int pid = 0;
 __s64 value = 0;
+bool discard = false;
 
 SEC("fentry/" SYS_PREFIX "sys_getpgid")
 int test_ringbuf_n(void *ctx)
@@ -41,7 +43,10 @@ int test_ringbuf_n(void *ctx)
 	sample->value = value;
 	bpf_get_current_comm(sample->comm, sizeof(sample->comm));
 
-	bpf_ringbuf_submit(sample, 0);
+	if (discard)
+		bpf_ringbuf_discard(sample, 0);
+	else
+		bpf_ringbuf_submit(sample, 0);
 
 	return 0;
 }

-- 
2.56.1

