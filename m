Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.225.133
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794253664;
	b=0Je8xa50jYQp5FqsN9O2mryfkuzO71JbSKUDRfTehfGd2tub/1sXmpvzpc0sUJvYFw0I
	 kLyCSdQQknrXCJrFwnfyiLET1tIrRoN6OaEDqInrjhoVpm9Nhe4Dpm/Q2/cXhkmQ9tDvD
	 yCGjOBDxJv7b09v9+Ayx/H6pfpLDoNZvlg6wV/qVQ8f8AA8ark8niM+NiYrNx7ebiuABR
	 mmNYtbcUbFNa92nv8g49yYsJ2DZZrKVAcWGGtVtA4OC8oYN0H7gmYwATeLVb3MV7T9Gte
	 HnRF63gLm8+AzNGX8Mm4CzZjmfK13rpDMvI4RcZxJbKUo+eom8xvlQMWViUgne1RBkg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794253664;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 X-Developer-Signature:X-Developer-Key:Content-Transfer-Encoding;
	bh=rout1XrTa1KRxoOyMIrcw92IQTm8UnABKxobV4gTerQ=;
	b=ghpqu2v/+Im67HqK/6OtwQfnKwOqF1wpGNGdbUUEAQfrCjUfnP2G+lW/K1/q0IMzKQRi
	 4WTNZWSpYViKjECXabF0odFItbPr6aSe9NSThoYzQOgswEci5micEgMrY03R8uMINBI/H
	 zlEIuXfKnFUlv6ws4o1pTH/KipCHj+TtBqYddL9d+PuXml4mWDrR9/SfozRGPlnDEzRfJ
	 frzUbigxDVeosmlWo6bLKCcQo3ZlWGVS/OgMxOdN8xitq8wMU01aCAZkpcPakY9TvDJZu
	 erkDgU/irncECbYo2phAN75SKZRlxyTuxfXMeuWOGWF8SSChELdDJth/Tl0KryBSZaA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NWfGQ+75;
	arc=none smtp.remote-ip=74.125.225.133
Received: from mail-wm2-f5.google.com (mail-wm2-f5.google.com [74.125.225.133])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ECE6606A31C
	for <bpf@vger.kernel.org>; Mon,  9 Nov 2026 19:47:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3ECE6606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NWfGQ+75
Received: by mail-wm2-f5.google.com with SMTP id 5b1f17b1804b1-49e7b06acb8so4975035e9.1
        for <bpf@vger.kernel.org>; Mon, 09 Nov 2026 11:47:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794253662; x=1794858462; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rout1XrTa1KRxoOyMIrcw92IQTm8UnABKxobV4gTerQ=;
        b=NWfGQ+75pJ+49HY9Mcj73t2Knp7FtFVRvdHgJNIAIs7LET+HD8dkHfGDCL243YqibT
         KkF+o4SadsRKJNminAat1jjGVUQUeXdu7+0I22192YOJB0y4uxW3JNcwMeclBTOb23dZ
         K7MMauoscsA29pnyIQBKXL10Z5gAsB9Cyghhh89lR5rk7dK52Us118HH9atooS2qIWHu
         Ry1rQznx6xCPb7MQD/BZz4GRyrmc5DbsrQi7CHmervloMzAJTeRs9S6gZayjhM9VL2Yk
         jnFNQWaG2HuQn0s1cZgEqx2mN+w1qItzcGQXZBE7/TxqDWRBRZxzQUGSXxvJvic3Spmf
         YhdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794253662; x=1794858462;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=rout1XrTa1KRxoOyMIrcw92IQTm8UnABKxobV4gTerQ=;
        b=vIYOH0ucg4NM6/9X8bLeWw5yeZVfV3Cd/it95g9sJ0VVQWIKDZba5IpFBG8zbvtBSM
         5T560WwxHW9EtubsJ+b0jooDukxyKbu6DlWJmLCzOhwMwLaxQtUrbnbe6i3pYSGPCZXV
         1p9k/1vmVXK56E50vz5wm5Excvpi9hvtMFla3QA0ubjsiuj2UBW1GbXYkj7SrgIaQk5U
         Om3CzHK+K9noScUUdXBhf6Dlkml9Ca9e8vSYbUhn20CL04l7d6cuIKeIgXa61CZPP1Ys
         iuXIjzxgBU67PItf5ZMrkYurtghbrMZww4atPDIF0CQBOgeoCQs83TkKOsKZzvV7zIg+
         Af6w==
X-Gm-Message-State: APuU4Z+Uz0XU9lyBa1vaoZhzq6iwPNglofEYklLcj1s3u2GFSqqa75Pk
	DD+w2veTVvl24NOpPH6Rs+tY+R3g0TxB9gEwh71r2Y8mEpTuDmyjVYRDhCcHwNul
X-Gm-Gg: AYBFou1KDpftplxyqnaYuMJ11zyTkivb3WTQaUMvd0j9i7VpnmiA0OWFveMPUxlnyzC
	y6bOe23XPs55tZZXPLR9ySOFd+4mnSy+aRUSVVzIHyd+vO07/1kVPQEhJP1qEsbyT4kbB9Wltdk
	CE4esVA4dZqz9/i+A4EBCHIBXdV7NSS7su742sQNlb+9LmEP7xElxiZxG8GOH6LldlXT4302cuE
	H+K5hrbvEI8SnbydTw2xrDu2W8XCWXjdZxKP0qDvw1FG+O7x/G3nrl0/D3XqEwo+yLeYJ002cM3
	FkPKb1GcizDdj2SzCcHfRNIfTgCsCvBjRuXm1FobCEnpWH6kTumuH7K1v74CZR8K8aMCnfdhAjP
	ji9t5abeZmNulz5e9Y7I/gL0bQUjeauL9elQKT+42J+S67c2J//3RqBWNlJ+FPGAfJJr9kWSCkJ
	qnINFW3dXctzfSyPLyAohtksEcg1tC/jAG4cEvZEBNxN1Q8YKzKAOXLJkreEDNCpwRb65xLuRxa
	RTwnSxngcGpTvmKddo7Kly44BA7JfawKCwAUzLgjX+4mfX4Sc1Edf/Qp+djOT9iJrLKaDBPtAVA
	VBbOpM+n6snEQzMNqTVSY66KuWF/UugZ34tAzVseap6RktAETkjkZIeBoNamP6+RCOlYnjNwowi
	Kp0l4snLufBD9uvYt4+PE+t3or8OPcug7OmVTXqxddh0XhNguD+kSH3fl5Ru+WVKpcQU5
X-Received: by 2002:a05:600c:3ba1:b0:4a1:e92b:ae4a with SMTP id 5b1f17b1804b1-4ba0234bc69mr5115975e9.21.1794253662519;
        Mon, 09 Nov 2026 11:47:42 -0800 (PST)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-498362eb158sm705618f8f.36.2026.11.09.11.47.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 11:47:41 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Tamir Duberstein <tamird@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 5/6] selftests/bpf: Test the ring buffer consumer with a NULL sample callback
Date: Mon,  9 Nov 2026 20:47:31 +0100
Message-ID: <3ce9a291ae3f9c33e1a731148dd4e390f6864405.1794253561.git.memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1794253561.git.memxor@gmail.com>
References: <cover.1794253561.git.memxor@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4507; i=memxor@gmail.com; h=from:subject:message-id; bh=UUkYTRU6iTqLFa9UVbtB0cwzPhKAAEOPoc0D3kCSND8=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIeuT0u80b+Wd7xsVuG61tqopcsabRsg5+BbnJj2q/nTv7 Y5nYf87SlkYxLgYZMUUWUr+72MyPlH5O9B2GTfMHFYmkCEMXJwCMBHb24wMr/pqxAw3TntR9tN4 8k/rrJMXIp7++/U9+frKFSLMq3qEShgZHjXOOav7tIPlwSfnSR/kmy6EdwgXPW5fGJNQMstpinI xDwA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

From: Tamir Duberstein <tamird@kernel.org>

Add the ringbuf_null_cb subtest. A manager holding a ring with a sample
callback and one added without must return -EINVAL from
ring_buffer__consume_n(), ring_buffer__consume() and ring_buffer__poll()
and leave the consumer position of the valid ring alone, since the checks
run before any ring is consumed. A manager created with a NULL callback
must return -EINVAL from the same entry points and from ring__consume_n()
and ring__consume() on its ring, instead of calling through the NULL
pointer.

[kkd: split out of "libbpf: Prevent NULL callback crash" (Eduard)]
Signed-off-by: Tamir Duberstein <tamird@kernel.org>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../selftests/bpf/prog_tests/ringbuf.c        | 93 +++++++++++++++++++
 1 file changed, 93 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/ringbuf.c b/tools/testing/selftests/bpf/prog_tests/ringbuf.c
index 4f0558f14847..9ce996bcea8c 100644
--- a/tools/testing/selftests/bpf/prog_tests/ringbuf.c
+++ b/tools/testing/selftests/bpf/prog_tests/ringbuf.c
@@ -401,6 +401,97 @@ static int process_n_sample(void *ctx, void *data, size_t len)
 	return 0;
 }
 
+static int process_noop_sample(void *ctx, void *data, size_t len)
+{
+	return 0;
+}
+
+static void ringbuf_null_cb_subtest(void)
+{
+	struct test_ringbuf_n_lskel *skel_n;
+	struct ring_buffer *ringbuf = NULL;
+	struct ring *ring;
+	unsigned long consumer_pos;
+	int no_cb_map_fd = -1;
+	int err;
+
+	skel_n = test_ringbuf_n_lskel__open();
+	if (!ASSERT_OK_PTR(skel_n, "test_ringbuf_n_lskel__open"))
+		return;
+
+	skel_n->maps.ringbuf.max_entries = getpagesize();
+	skel_n->bss->pid = getpid();
+	skel_n->bss->value = SAMPLE_VALUE;
+
+	err = test_ringbuf_n_lskel__load(skel_n);
+	if (!ASSERT_OK(err, "test_ringbuf_n_lskel__load"))
+		goto cleanup;
+
+	err = test_ringbuf_n_lskel__attach(skel_n);
+	if (!ASSERT_OK(err, "test_ringbuf_n_lskel__attach"))
+		goto cleanup;
+
+	syscall(__NR_getpgid);
+
+	no_cb_map_fd = bpf_map_create(BPF_MAP_TYPE_RINGBUF, NULL, 0, 0,
+				      getpagesize(), NULL);
+	if (!ASSERT_OK_FD(no_cb_map_fd, "bpf_map_create"))
+		goto cleanup;
+
+	/* Manager APIs must validate all rings before consuming any of them. */
+	ringbuf = ring_buffer__new(skel_n->maps.ringbuf.map_fd,
+				   process_noop_sample, NULL, NULL);
+	if (!ASSERT_OK_PTR(ringbuf, "ring_buffer__new"))
+		goto cleanup_fd;
+
+	ring = ring_buffer__ring(ringbuf, 0);
+	if (!ASSERT_OK_PTR(ring, "ring_buffer__ring"))
+		goto cleanup_ringbuf;
+
+	err = ring_buffer__add(ringbuf, no_cb_map_fd, NULL, NULL);
+	if (!ASSERT_OK(err, "ring_buffer__add_no_cb"))
+		goto cleanup_ringbuf;
+
+	consumer_pos = ring__consumer_pos(ring);
+	ASSERT_GT(ring__producer_pos(ring), consumer_pos,
+		  "producer_pos_mixed_cb");
+
+	err = ring_buffer__consume_n(ringbuf, 0);
+	ASSERT_EQ(err, -EINVAL, "ringbuf_consume_zero_mixed_cb");
+	err = ring_buffer__consume(ringbuf);
+	ASSERT_EQ(err, -EINVAL, "ringbuf_consume_mixed_cb");
+	err = ring_buffer__poll(ringbuf, 0);
+	ASSERT_EQ(err, -EINVAL, "ringbuf_poll_mixed_cb");
+	ASSERT_EQ(ring__consumer_pos(ring), consumer_pos,
+		  "consumer_pos_mixed_cb");
+
+	ring_buffer__free(ringbuf);
+	ringbuf =
+		ring_buffer__new(skel_n->maps.ringbuf.map_fd, NULL, NULL, NULL);
+	if (!ASSERT_OK_PTR(ringbuf, "ring_buffer__new_no_cb"))
+		goto cleanup_fd;
+
+	ring = ring_buffer__ring(ringbuf, 0);
+	if (!ASSERT_OK_PTR(ring, "ring_buffer__ring_no_cb"))
+		goto cleanup_ringbuf;
+	consumer_pos = ring__consumer_pos(ring);
+
+	err = ring_buffer__consume_n(ringbuf, 0);
+	ASSERT_EQ(err, -EINVAL, "ringbuf_consume_zero_no_cb");
+	err = ring__consume_n(ring, 0);
+	ASSERT_EQ(err, -EINVAL, "ring_consume_zero_no_cb");
+	err = ring__consume(ring);
+	ASSERT_EQ(err, -EINVAL, "ring_consume_no_cb");
+	ASSERT_EQ(ring__consumer_pos(ring), consumer_pos, "consumer_pos_no_cb");
+
+cleanup_ringbuf:
+	ring_buffer__free(ringbuf);
+cleanup_fd:
+	close(no_cb_map_fd);
+cleanup:
+	test_ringbuf_n_lskel__destroy(skel_n);
+}
+
 static void ringbuf_n_subtest(void)
 {
 	struct test_ringbuf_n_lskel *skel_n;
@@ -579,6 +670,8 @@ void test_ringbuf(void)
 		ringbuf_subtest();
 	if (test__start_subtest("ringbuf_n"))
 		ringbuf_n_subtest();
+	if (test__start_subtest("ringbuf_null_cb"))
+		ringbuf_null_cb_subtest();
 	if (test__start_subtest("ringbuf_map_key"))
 		ringbuf_map_key_subtest();
 	if (test__start_subtest("ringbuf_write"))
-- 
2.53.0

