Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794918272;
	b=TxyQMB1ryAPBMZSBHxYpsnJoGxpob5spPrU1hSgrNY6gMS88pz8ZnF3fuc655ANaTuLu
	 uZALQI3KYfmbPAK0MmneEd3QfFKeUDOpzowZ8IHYr8TG5tHotDPq9oVMAzdX1TysB0Doz
	 HTislbrft7av3N/wqipE+FTJ751a7Ug4XMFGOWKl+Whkhjy0UzphmOVFy1FjauqRwEiyO
	 HG8gpZd3TC1g/ZcFtn8gV1exTImQactVianq7i8q6Qalm32fQ9vpEeDe4VKN7cORinVJG
	 SNUHZIxS6RCzsukC7n8tSrJmGelSilrMxXQm75Hwf52WgHQGjSSXsnlHkFxu/vIMmHA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794918272;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=DCpu+Hq5xQeJszgIeoHmZoIg86kcDoEMxUxHmN2abjs=;
	b=r0rFGQa7h9l5z+C/Zdx4fBIelyGmjTKLq/ZJhPN9Gt0dRU5S6zB2L0oEvPm3iOBM4WkM
	 BruZDFxib2uJjNbG0zV+ie4j3eyfZXamK9QMjduaClagQ8ZbvaBWZn6VuUZtzENWNsAiC
	 ROHofnLrSBWFrVSE/o9I0Gkezq8XTMYsAUSxx3H7Yv6i6yffqr2VgGqs2uy3E21Ck7Yxs
	 /Ru7DDaRfJzyg8flDhnlttgPI4enL8A5Ot0OtMBJ6XnFzN0zbL5EOl5PpWMhlcp3dtZmK
	 Z9rBN/u3cjRVmKDU7pQHB0+SkFlnAdfiZ3e1Azeey/Vom2GxCyL/ylKIJTF0bEEoApw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=ugVJQVtE;
	arc=none smtp.remote-ip=91.218.175.15
Received: from mta0.migadu.com (out-15.mta0.migadu.com [91.218.175.15])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60411606A31C
	for <bpf@vger.kernel.org>; Tue, 17 Nov 2026 12:24:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 60411606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=ugVJQVtE
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=3vM0O1dJswiN9N8gqBgAgWRmPD44k2JkjuKN6dhc+5s=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794918269; v=1; x=1795523069;
 b=ugVJQVtEFegxsdAPplHrLvIIMoLGDHtWyhnX6a7Ry7Hl/47jxjo4G8h/ItdzXkqbEhhLYSdZ
 hzWVSncUUtM4pm8ye0UyxQHwIO9gf8cNXyJ15GxFKsxjg98MT6DWzuN+WmmRAyA6VtvZ6gAvp6u
 hBEY7xESuScRyr/ZvKW4Aw8E=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 953c64e80f13473e;
	Tue, 17 Nov 2026 12:24:29 +0000
X-Mizu-Trace-ID: 953c64e80f13473e
X-Migadu-Flow: FLOW_OUT
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Shuah Khan <shuah@kernel.org>,
	Sechang Lim <rhkrqnwk98@gmail.com>,
	Michal Luczaj <mhal@rbox.co>,
	John Fastabend <john.fastabend@gmail.com>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf v2] selftests/bpf: Fix bpf-gcc CO-RE relocation in verifier_sockmap_mutate
Date: Tue, 17 Nov 2026 20:24:13 +0800
Message-ID: <20261117122417.340562-1-jiayuan.chen@linux.dev>
X-Mailer: git-send-email 2.43.0
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

bpf-gcc fails to load test_trace_iter_unix:

  Error: #766/6 verifier_sockmap_mutate/test_trace_iter_unix
  libbpf: elf: skipping section(3) .data (size 0)
  libbpf: elf: skipping unrecognized data section(18) .comment
  run_subtest:PASS:obj_open_mem 0 nsec
  libbpf: prog 'test_trace_iter_unix': relo #0: insn #0 (LDX/ST/STX) accesses field incorrectly. ...
  libbpf: prog 'test_trace_iter_unix': BPF program load failed: -EINVAL
  libbpf: prog 'test_trace_iter_unix': failed to load: -EINVAL
  libbpf: failed to load object 'verifier_sockmap_mutate'
  run_subtest:PASS:unexpected_load_success 0 nsec
  validate_msgs:FAIL:1014 expect_msg
  VERIFIER LOG:
  =============
  0: R1=ctx() R10=fp0
  ;  @ verifier_sockmap_mutate.c:124
  0: <invalid CO-RE relocation>
  failed to resolve CO-RE relocation <byte_off> [4] struct bpf_iter__unix (0:0 @ offset 0)
  processed 1 insns (limit 1000000) max_states_per_insn 0 total_states 0 peak_states 0 mark_read 0
  =============
  EXPECTED   SUBSTR: 'cannot update sockmap in this context'

GCC only applies preserve_access_index to types that carry the attribute
themselves. The anonymous union holding the sock pointer doesn't, so the
CO-RE access stops at the union ("0:0") instead of reaching the pointer
("0:0:0"), and libbpf rejects the relocation.

Fixes: e16c83fa764f ("selftests/bpf: Add negative test for sockmap update from non-sockmap iter")
Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
v1 : https://lore.kernel.org/bpf/20261117094544.148437-1-jiayuan.chen@linux.dev/
---
 .../selftests/bpf/progs/verifier_sockmap_mutate.c     | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/verifier_sockmap_mutate.c b/tools/testing/selftests/bpf/progs/verifier_sockmap_mutate.c
index 1516fe1524bb..0dbbc5ad1de9 100644
--- a/tools/testing/selftests/bpf/progs/verifier_sockmap_mutate.c
+++ b/tools/testing/selftests/bpf/progs/verifier_sockmap_mutate.c
@@ -10,19 +10,12 @@
 
 char _license[] SEC("license") = "GPL";
 
-struct sock {
-} __attribute__((preserve_access_index));
-
 struct bpf_iter__sockmap {
-	union {
-		struct sock *sk;
-	};
+	struct sock *sk;
 } __attribute__((preserve_access_index));
 
 struct bpf_iter__unix {
-	union {
-		struct sock *unix_sk;
-	};
+	struct sock *unix_sk;
 } __attribute__((preserve_access_index));
 
 struct {
-- 
2.43.0

