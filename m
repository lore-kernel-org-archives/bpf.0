Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792520045;
	b=Nk31ZrPo1pvSb7CN/9Ff8dvY7zJhn/Mnvwfzkyno551rl/eSrd+w02kqIDIQIq1rQhi+
	 9kJm8QI4i954EsB65B3xtN4501bgV0AhuCWcDBB3F5UWIbbNMT620eK9mUnrSq29j3mVz
	 tZZZumJyynRYJd6gCgbQ/Kh3iUOHMyaTmdG4rdLLyYyOSA8hCeNOLC3roWgnln0gqlXP+
	 EbggtawDmGnJEfWfayyszrJY663K5PU24H/5GwHdIFivJBUakmOuqPIDozzVxWaYN8bX6
	 a/E1RDYo1oG13sWZMp8KiSL0YwdiCfyssayPRs275UgVDksEWuWnSbhg4VJ0pK6CPOw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792520045;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=uAvw4I24i/UQt3NYdzZuDVdK+G5b7cGd/+ZaImXN604=;
	b=ahpKd7qqJa2v92Yc/n2+3dro7j98gGLX/VNl1blaLYuVaGbR/S0qn+abCnqCD1u3YZEC
	 DaoxNRnqoDgUy8UhSojuahSf5QTBI9Dd3f52kD9iTHTXd7DFQgenhvZpz4zKZmfObIm1h
	 uzxjZP5Pfr1sAWWnXrD/Vb2TToKDzTVei4j2bikrzZjDdYtHyThitV67aAddYmd/2Ktpa
	 0VTUE5oGXB1kUJaIagtf8znNj9SuvoRG80zR2tYrng6rfKnsr3dJ23xPx6T4P34ZmN5rs
	 IO88aaGMiPK5vvCXP+V096w8Ld4/XaXJNJ9Sj+7CYV2rrXs8vnO07wOXJJdN3hohCGA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=N8HFFei0;
	arc=none smtp.remote-ip=209.85.215.169
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD8BE606A319
	for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 18:14:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AD8BE606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=N8HFFei0
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-cd5c9e52398so1301542a12.1
        for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 11:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792520044; x=1793124844; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uAvw4I24i/UQt3NYdzZuDVdK+G5b7cGd/+ZaImXN604=;
        b=N8HFFei04U5R4DQzb/Xzu1bn2M8tfSSmN9paeLiyLl3GQdWVFW2QfdNTuSYyfh/QT/
         bKm9sb+WMG4NukpXhYeTAvCUIt6o32n8Gx5b7tKvkWDM2fTD0rXUotBSKHeq1AcdcswV
         /y4g6etWRePn+Uhd6Wbub/hzEAZpAIQeFM6G8FrT1Z8uxA+B4v+2+ShXWcwpttlJe6vq
         RtS0FHPd6eMXMJlMm9D7siq318PyOFEhUXmWuyXqlIvmiODCmuwW1EM8YyFk06MN3Xxi
         E7MG6phejAO3ksLjF/KRnsvdS72grh2NOBQxdNERX+29/5U6qfD6tVODysJBZVZ4Wjs0
         VXQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792520044; x=1793124844;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=uAvw4I24i/UQt3NYdzZuDVdK+G5b7cGd/+ZaImXN604=;
        b=KDtoJ64z6t4LM9IkIm9g3AUUbJk/SGyqFYGyt723WwktvueJmHTPvy0MhTCg2Uymhs
         ao+BNp1ZrZsXTXEuzseK56vWCEvfka6TrZ7hjsDkuQOU3mhHuLAuQJWXfo2HiK0fsQEV
         rnPKXZMMv4HZFrTploNkZs3Zjci8teot5W2vDJ8xw2d7Z90YCydbzwU4e+zlCAp3MC7V
         M06H8Hvalh56jdR0eASELUpoDvhFFEz8l3pVpM/3WncDpDmxmk1qfSemYJNo5NL1CKER
         gCOdrSDlpLhkLrAQPSDVLwGBPGAEcbAFwBHQvWAypNXnJ+WFzYR1khvHyEQZ1xVftGAw
         awNQ==
X-Gm-Message-State: AFq9FYLgez29e917kYj0j5NOzfFY4EieQcBoXkoE8A3BPW8aZjT3rMt2
	Or0CX23s2NE17J9DWDufKKKbuCpylh86K7jvsu/EjjFRL9CrvkzdMkvrzF8UKg==
X-Gm-Gg: AYBFou2Ll1UDFiZ7ErYflMWGVMZcfNIxIJLoOG6U0J8gFk0yWIys3Va4z34jfvPNhaM
	LdqkU7kOYvU3hgk/V5aM2krsvD2xbktrsOhL3NvmAjdU3fv8N1Aw1cDGAimNQDPIHh+uTSOlmSu
	NIcTGuUzw5xCvBSTkUcctBBfUQJVrAyAlY8MGkE+2dQC5RS0M+KDBy74/c9e398VtuXKRa8JtVu
	YMM2jDqGZQDyXrjrePNSaXmRtkpIlP4DJ7FTVSVzF6+E2X3ljgJAYL667+cSkCkhJ+rkWe9YysZ
	1vacZvVwrOLthZqNPYl6/P98PdiEkXURMEXUL5QnVgq57cORdm2poHkwfsnU1enUsQO0nwqZoAc
	LqgCiHMA/H/fxpQJCAtxA6pQUIXy5g1ih9PhGTbnZauJ/oT5vnAtwCQFsOySSC4PjYdabdHS23f
	bHiZO/fa8k57M/sowVxT3dwk5Xa5IXypR3p6eTDhRq2/atB1KMqKpTExVX5U2ApWe8fmoz7tP/v
	rPNiUQoO/aVeOw6AOH3ilgaW2crcIOFDc9nVv6btnYjxEaykNTmi63Z5gNzrAIm8itv2oYBMWTX
	g/PdGamY99lIvnSuFIBuVPyNLjNJ23JwFYfVvoDpIac=
X-Received: by 2002:a17:90b:380f:b0:3ac:a1c7:20fd with SMTP id 98e67ed59e1d1-3acee97ae24mr10198095a91.4.1792520043911;
        Tue, 20 Oct 2026 11:14:03 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.252])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ad8035c42fsm583610a91.17.2026.10.20.11.14.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 11:14:03 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	yonghong.song@linux.dev
Subject: [PATCH v4 bpf-next 6/6] selftests/bpf: Test unwinding from R0:R2 subprog
Date: Tue, 20 Oct 2026 18:13:20 +0000
Message-ID: <20261020181320.1284798-7-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261020181320.1284798-1-alexei.starovoitov@gmail.com>
References: <20261020181320.1284798-1-alexei.starovoitov@gmail.com>
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

From: Kumar Kartikeya Dwivedi <memxor@gmail.com>

Global subprograms returning a 16-byte scalar use R0:R2. The
verifier therefore checks both registers at every ordinary and unwind
exit.

LLVM lowers a resume to "r0 = 0; unwind_exit". If cleanup code does not
happen to initialize R2, the verifier rejects the unwind path with:

  R2 !read_ok

Extend unwind_cxx with a global unsigned __int128-returning subprogram
whose cleanup only releases its RCU read lock. Load it separately so
the existing cases continue to run and the failure is attributed to
this case. Check both the normal aggregate return and caught exception.
The test passes once LLVM defines R2 before emitting unwind_exit.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 .../selftests/bpf/prog_tests/unwind_cxx.c     | 24 ++++++++++++-
 .../selftests/bpf/progs/unwind_cxx.cpp        | 35 +++++++++++++++++++
 2 files changed, 58 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/unwind_cxx.c b/tools/testing/selftests/bpf/prog_tests/unwind_cxx.c
index a049a807cd04..9faba99133ad 100644
--- a/tools/testing/selftests/bpf/prog_tests/unwind_cxx.c
+++ b/tools/testing/selftests/bpf/prog_tests/unwind_cxx.c
@@ -38,7 +38,8 @@ void test_unwind_cxx(void)
 {
 	const char *file = "./unwind_cxx.bpf.o";
 	struct bpf_object *obj;
-	int err;
+	struct bpf_program *prog;
+	int err = -EINVAL;
 
 	if (access(file, R_OK)) {
 		printf("%s:SKIP:gcc doesn't build %s\n", __func__, file);
@@ -58,6 +59,10 @@ void test_unwind_cxx(void)
 	obj = bpf_object__open_file(file, NULL);
 	if (!ASSERT_OK_PTR(obj, "open"))
 		return;
+	prog = bpf_object__find_program_by_name(obj, "catches_aggregate");
+	if (!ASSERT_OK_PTR(prog, "catches_aggregate"))
+		goto out;
+	bpf_program__set_autoload(prog, false);
 	err = bpf_object__load(obj);
 	if (err == -ENOTSUPP) {
 		printf("%s:SKIP:JIT does not support unwinding\n", __func__);
@@ -74,4 +79,21 @@ void test_unwind_cxx(void)
 	run(obj, "does_not_catch", 200, 0, 12);
 out:
 	bpf_object__close(obj);
+	if (err)
+		return;
+
+	if (!test__start_subtest("aggregate_return"))
+		return;
+	obj = bpf_object__open_file(file, NULL);
+	if (!ASSERT_OK_PTR(obj, "open_aggregate"))
+		return;
+	bpf_object__for_each_program(prog, obj)
+		bpf_program__set_autoload(prog,
+					 strcmp(bpf_program__name(prog), "catches_aggregate") == 0);
+	if (!ASSERT_OK(bpf_object__load(obj), "load_aggregate"))
+		goto out_aggregate;
+	run(obj, "catches_aggregate", 64, 71, 0);
+	run(obj, "catches_aggregate", 200, 42, 0);
+out_aggregate:
+	bpf_object__close(obj);
 }
diff --git a/tools/testing/selftests/bpf/progs/unwind_cxx.cpp b/tools/testing/selftests/bpf/progs/unwind_cxx.cpp
index d46ee41fef85..3a113ffea29c 100644
--- a/tools/testing/selftests/bpf/progs/unwind_cxx.cpp
+++ b/tools/testing/selftests/bpf/progs/unwind_cxx.cpp
@@ -67,6 +67,17 @@ struct rcu_guard {
 	}
 };
 
+struct plain_rcu_guard {
+	__always_inline plain_rcu_guard()
+	{
+		bpf_rcu_read_lock();
+	}
+	__always_inline ~plain_rcu_guard()
+	{
+		bpf_rcu_read_unlock();
+	}
+};
+
 struct preempt_guard {
 	__always_inline preempt_guard()
 	{
@@ -95,6 +106,18 @@ static __noinline int middle(int len)
 	return inner(len) + 1;
 }
 
+using u128 = unsigned __int128;
+
+/* Global subprogs returning 16 bytes use R0:R2, including unwind exits. */
+extern "C" __noinline u128 aggregate_return(int len)
+{
+	plain_rcu_guard guard;
+
+	if (len > 100)
+		throw 1;
+	return (static_cast<u128>(len) << 64) | 7;
+}
+
 extern "C" SEC("tc") int catches(struct __sk_buff *skb)
 {
 	try {
@@ -110,6 +133,18 @@ extern "C" SEC("tc") int does_not_catch(struct __sk_buff *skb)
 	return middle(skb->len);
 }
 
+extern "C" SEC("tc") int catches_aggregate(struct __sk_buff *skb)
+{
+	try {
+		u128 value = aggregate_return(skb->len);
+
+		return static_cast<unsigned long>(value) +
+		       static_cast<unsigned long>(value >> 64);
+	} catch (...) {
+		return 42;
+	}
+}
+
 #endif
 
 char _license[] SEC("license") = "GPL";
-- 
2.55.0

