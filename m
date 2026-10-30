Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793361723;
	b=eKJw2UYvFVhIIQcDsm3An3lLbmgrrmffhLtYe4lEfOHUV4fzrqfKMzY1TjdvDn4UdtG/
	 gJnjejVpHESq6fcDHe07no+wQcGW0gnvCBw8PZrkLTSrNCnGHqHw5R+I+RQG9guEYCQlp
	 thuuibVJsWixMtp1v+oLI1fMql9QHW7SBfNHbRGKvl7vX/wNN+No53E5FKa+yrwRseBxE
	 IXCIHyEYREpEqZVLH7jIS92jKIZv/4QN1aGazi4O/gJU+8OCx4OGVkltX43uTx4Sv4fLO
	 eJD/mc1cKx4Jyhi6X5vhwgqXwg7Ury3n/B7JreF5jTHk6ueDvfwmo21BExQXCjuhnBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793361723;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer;
	bh=vMwZvawBiyShXBewO3K0dol5CkgA9oaHML9/XArfQDg=;
	b=lafiYNyL6oM2H1CYM+05lv+jKptPI2jpA2Ar7+u2faNrgCvJvlEGsBT+NPnaYwMot2IB
	 V1UUxbDqYqbj5QWs2afQU+dll4+nshHlWvASzrOHClOhUop/pAa3320g7/UGYXNb73C3K
	 4atfTYlLYawYWro1/uGsxnthEGgz6kbPMCjBIT8c1piLuHVX2/6LJSDQhXee1HZlnO6Sj
	 klB/jcG+1l4LlWR0npOc0PZXYicFwGD9rFpTY/idhO736YSzenPAeT6uH6nY9vLzBy1Qj
	 sVUxYcnwGNMWOhAReaxX7LR4dcev9e4XyG4Qd/V81nBUTDvoC6fSvRYF7ElsZGgRnGw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cloudflare.com;
	spf=pass smtp.mailfrom=cloudflare.com;
	dkim=pass header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=DRxY3OwX;
	arc=none smtp.remote-ip=209.85.208.49
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1CE5606A32E
	for <bpf@vger.kernel.org>; Fri, 30 Oct 2026 12:02:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F1CE5606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=DRxY3OwX
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6b488586facso716945a12.2
        for <bpf@vger.kernel.org>; Fri, 30 Oct 2026 05:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1793361721; x=1793966521; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vMwZvawBiyShXBewO3K0dol5CkgA9oaHML9/XArfQDg=;
        b=DRxY3OwXyfaaiay0YSbG0mi9ZjocAY7e59ETPcDqTJFexFmVR2lXQqKR1VbYP9xEpm
         jUNkn42kY5kiOzOxzdNHJfD3fc7MK2RV3wye1GWo/pdXpFVDQXDDadBsixZESzVKhvUj
         yC1AkEKyPgz2zGXRS1V8XXMh3jWvtTJrlQ+SSTbZQEzM3k2aFegAdLhtzpycKsKoJrSn
         iu7QUx3jD137RUZihYWV2ze3vTJqdedewn4+LC/Ib3Nr+gFTOILmTP7HSDiF3GZXdXO6
         EnyiZfYPUL/mO+IZHukqIRMWZGU4Xjuh/s1z5g5QgBO+RaKrIIHn2L/WAAVlnVuwVwkU
         TQ3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793361721; x=1793966521;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vMwZvawBiyShXBewO3K0dol5CkgA9oaHML9/XArfQDg=;
        b=NlsWkpIsCFr7/WNKRb78ydv2Si1Vg/D1Nb3oUpujw6axqp2jNgLvNXqIoUwHbbCV8r
         qPRyib5hBa6m+p+LZeWj4JfPvQwswURwx6N844KSATYkxA9ExLLFwFMhxz3p9b2UX33S
         zOtSHzRUh//s0jNzAG8zJwkbzagIK55I2zSXAKdmvGXtPvdzJWrs2M3ZJQoYg/gj+6J5
         ONlAH2aevOF8QzshtQXGMBJz+9aAbLt6byh5YCM7fcsfiTflooO8qP9J7HLI279zzny5
         kxtjIvNeGq76n+KH+KL1RmIeoCn+nqBrqgUGDSDdttD2W/eQunF7cFHmZLzoIYwAsbPQ
         XsFg==
X-Gm-Message-State: AFq9FYIHnzraO/W4cwFoBgK/FfX8NAXzsedJnOjy+p4ubFrrxXzLlBpO
	pq4AlzIP3uaVFyVMVsLBFp3ul+LWgm8bgt5Vd6rhyLAy4VWnDjDTehs0MDip8COCcNw=
X-Gm-Gg: AYBFou13LkEpuhwO+jJCwgyQ3EnOnyg9GgHxKaq62M9jNvYt1Sgf12pGxV0yQI8mdFu
	p1zYFNYklJ8a4VGbl/LWqt8fEqmEN5y+gozQ0inSZghSOndmUQ+A2pXwANeQaEwHkEFzGXPb8nq
	NhDPQXKlkRsAyCyx5TjqOSzcxthl+H5or1Y7grLiuXiptcmb+C0WprZolVuaNuC1RrZ6bEdwuth
	I7XC9gz/Ca3Opcb+c/FrLJaT01fRuq3J8B0Wx0wieq4mvP1EI0Ewa4Fjma4LaEBn5iPVZIuTgqn
	EFiYoVYb+Sb5ELwq4WrVIQ88Ss9/wiwY0fxatyGw+ZRLnvPMdUwEy+DPOodSckc5MyQvQHBF9df
	/zs8dxiiKKoH9Mt2e40XJRHuKFRs5NdSxo4S1IGskf2MIijR9mGoiTHwkud8/B1/uOi3EnxURNd
	WT2wYslJerLWHQP1lv/6UF/eQGoo/LDBIDiFuKOyIVIHpcA0RdbqLmyB9AYkBNFDRF9GeqBHos9
	OfO6oqLPYnnmw/ctp5TSFy1az+f2PwhP4W7jdGznIQMS7Nje76o/OoJ2hFrpLkzI8BGumCcuwXU
	gA3oqx+xX7kHvYaG/0K2KNkjreVVXy4n+bxkiw==
X-Received: by 2002:aa7:cd5c:0:b0:6b1:b5ea:2580 with SMTP id 4fb4d7f45d1cf-6b4d66a3ee6mr991534a12.44.1793361721111;
        Fri, 30 Oct 2026 05:02:01 -0700 (PDT)
Received: from cloudflare.com ([2a01:110f:491b:1300:7cff:6795:2d76:e9de])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b4d7b1c592sm548135a12.25.2026.10.30.05.01.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 05:01:59 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Fri, 30 Oct 2026 13:01:53 +0100
Subject: [PATCH bpf-next 1/2] selftests/bpf: Cover concurrent sockmap
 update and delete
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
Message-Id: <20261030-bpf-next-v1-1-035eabf8eae7@cloudflare.com>
References: <20261030-bpf-next-v1-0-035eabf8eae7@cloudflare.com>
In-Reply-To: <20261030-bpf-next-v1-0-035eabf8eae7@cloudflare.com>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, 
 Ihor Solodrai <ihor.solodrai@linux.dev>, Shuah Khan <shuah@kernel.org>, 
 Eric Dumazet <edumazet@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
 Paolo Abeni <pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Jiayuan Chen <jiayuan.chen@linux.dev>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Simon Horman <horms@kernel.org>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, kernel-team@cloudflare.com
X-Mailer: b4 0.16.0

Add a sockmap_listen subtest where one thread keeps inserting a TCP
socket into a sockmap with an attached verdict program while another
thread deletes the same map entry.

Without any synchronization between the insert and delete paths, both
end up racing on psock teardown and the socket's proto callbacks,
which KCSAN reports as:

    ==================================================================
    BUG: KCSAN: data-race in sock_map_link / tcp_bpf_update_proto

    write (marked) to 0xffff88810b1f42a8 of 8 bytes by task 198 on cpu 0:
     tcp_bpf_update_proto+0x278/0x400
     sock_map_unref+0x1d3/0x240
     sock_map_delete_elem+0x7b/0xb0
     map_delete_elem+0x1e1/0x270
     __sys_bpf+0x71a/0x870
     __x64_sys_bpf+0x69/0x80
     x64_sys_call+0xf26/0x2550
     do_syscall_64+0xb8/0x2f0
     entry_SYSCALL_64_after_hwframe+0x76/0x7e

    read to 0xffff88810b1f42a8 of 8 bytes by task 194 on cpu 3:
     sock_map_link+0x146/0x5b0
     sock_map_update_common+0x74/0x2b0
     sock_map_update_elem_sys+0x246/0x2d0
     bpf_map_update_value+0x80/0x400
     map_update_elem+0x35c/0x3e0
     __sys_bpf+0x540/0x870
     __x64_sys_bpf+0x69/0x80
     x64_sys_call+0xf26/0x2550
     do_syscall_64+0xb8/0x2f0
     entry_SYSCALL_64_after_hwframe+0x76/0x7e

    value changed: 0xffffffff857540c0 -> 0xffffffff8468fde8

    Reported by Kernel Concurrency Sanitizer on:
    CPU: 3 UID: 0 PID: 194 Comm: test_progs Tainted: G           OE        7.3.0+ #12 PREEMPT(full)
    Hardware name: Bochs Bochs, BIOS Bochs 01/01/2011
    ==================================================================

Deleting an entry that is already gone is expected: sockmap reports
EINVAL and sockhash reports ENOENT. Re-inserting a socket whose psock
still holds the verdict program from a concurrent delete fails with
EBUSY. Tolerate these errnos; the test relies on KCSAN as the witness.

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 .../selftests/bpf/prog_tests/sockmap_listen.c      | 77 ++++++++++++++++++++++
 1 file changed, 77 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c b/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
index 235e1d56f044..dca1f0de92e0 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
@@ -646,6 +646,82 @@ static void test_race_insert_listen(struct test_sockmap_listen *skel __always_un
 	xclose(s);
 }
 
+struct update_delete_ctx {
+	unsigned int nr_iter;
+	unsigned int done;
+	int mapfd;
+};
+
+static void *delete_elem_thread(void *arg)
+{
+	struct update_delete_ctx *ctx = arg;
+	unsigned int i;
+
+	for (i = 0; i < ctx->nr_iter; i++) {
+		/* Expecting EINVAL (sockmap) or ENOENT (sockhash) when the
+		 * entry is already gone.
+		 */
+		if (bpf_map_delete_elem(ctx->mapfd, &(u32){0}) &&
+		    errno != EINVAL && errno != ENOENT) {
+			FAIL_ERRNO("map_delete");
+			break;
+		}
+	}
+
+	WRITE_ONCE(ctx->done, 1);
+	return NULL;
+}
+
+/* One thread keeps inserting a socket into a sockmap with an attached
+ * verdict program while another thread deletes the same map entry.
+ */
+static void test_update_delete_with_prog(struct test_sockmap_listen *skel,
+					 int family, int sotype, int mapfd)
+{
+	struct update_delete_ctx ctx = { 0 };
+	int err, s, verdict;
+	pthread_t t;
+	u64 value;
+
+	verdict = bpf_program__fd(skel->progs.prog_skb_verdict);
+	err = xbpf_prog_attach(verdict, mapfd, BPF_SK_SKB_VERDICT, 0);
+	if (err)
+		return;
+
+	s = xsocket(family, sotype, 0);
+	if (s < 0)
+		goto detach;
+
+	err = xlisten(s, 1);
+	if (err)
+		goto close;
+
+	ctx.mapfd = mapfd;
+	ctx.nr_iter = 10000;
+
+	err = xpthread_create(&t, NULL, delete_elem_thread, &ctx);
+	if (err)
+		goto close;
+
+	value = s;
+	while (!READ_ONCE(ctx.done)) {
+		/* Expecting EBUSY while a deleted socket's psock still
+		 * holds the verdict program.
+		 */
+		err = bpf_map_update_elem(mapfd, &(u32){0}, &value, BPF_ANY);
+		if (err && errno != EBUSY) {
+			FAIL_ERRNO("map_update");
+			break;
+		}
+	}
+
+	xpthread_join(t, NULL);
+close:
+	xclose(s);
+detach:
+	xbpf_prog_detach2(verdict, mapfd, BPF_SK_SKB_VERDICT);
+}
+
 static void zero_verdict_count(int mapfd)
 {
 	unsigned int zero = 0;
@@ -1289,6 +1365,7 @@ static void test_ops(struct test_sockmap_listen *skel, struct bpf_map *map,
 		TEST(test_destroy_orphan_child, SOCK_STREAM),
 		TEST(test_syn_recv_insert_delete, SOCK_STREAM),
 		TEST(test_race_insert_listen, SOCK_STREAM),
+		TEST(test_update_delete_with_prog, SOCK_STREAM),
 		/* child clone */
 		TEST(test_clone_after_delete, SOCK_STREAM),
 		TEST(test_accept_after_delete, SOCK_STREAM),

-- 
2.43.0

