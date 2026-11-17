Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.196
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794908760;
	b=Kc+AY+dkeI7VbAHFe6KAc7HmEk0WTDpx7CMPSliCeK+ob40BmNFfUgJYPW+5ztsGDzke
	 t6s9kP6cM9St0jtkSyBSEeDqnPjwWATIvkyqzgT7oHqu3Ela1nII0d1Y+qw+7goLmxTAy
	 68LsVU6YD7EcqqkWl+oNZ2CHWtEmqSJ2EbXGSISA75GBdfQpS5AovXrLgulYy5/axEjAj
	 Bpw69G6U7Y1D+UOahUSOV/i/DRmn18u94pVrQUzIUNHx9v1tWx1fyOiwi31j5kIgRe6NJ
	 V7SkFHLONNIAs520+o/cAWZcjV/LZv+WKCZZLJZcCwK659xUxBMF/zyXpDIn8CByJHw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794908760;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=AQAqYl2tn6009DL8HqBJOMfPKmQERaYIFx8LZttnag8=;
	b=g2eQ+YMm8BwzULYgB98lPENRWNC1d5QHCzv/ZnlbRcIgOJ7XVyfNKnQNUodvqws6yTMt
	 MSM8qLnUXSlHGCt4kW5G38jYpw7gS2aTK7x7pUnaKEl52LbSAdCqcRXARdiPO/lQZdgCN
	 6qXmLgZ6cJKBAke/WPoq/1pG3SltL8Vw7OV3rk1Rniqd9x1Y86FpbU7a6A99DBZz2grMq
	 TEBV2TEq1K5qSUBr49H4q53bP5nUB4iC/hMdNUS8IMlsKAodCRBxvmSFHeyePWL+jX/dl
	 NxVkQK3FTXqLgTTDjYBCIStCdKykVmgtZMXG9yy2ZTvfscpXQnwVoIazLcSJat4W1cA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=An4M923y;
	arc=none smtp.remote-ip=91.218.175.196
Received: from mta0.migadu.com (out-196.mta0.migadu.com [91.218.175.196])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA299606A32C
	for <bpf@vger.kernel.org>; Tue, 17 Nov 2026 09:45:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AA299606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=An4M923y
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=eNKitI6OumQU1ILYmuf2OVKQGpBdNX+qex8fxTVDt9Y=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794908757; v=1; x=1795513557;
 b=An4M923y6tVn0cvQtIzVOW56SKglefgWaW93LqGgzrJqjKExXFLQ0jBl3o5vFrr/wvt0mgoM
 4AX9Rm+HK1foBGutlL7uY3ul6opAvQtQojpevrKVzGmQIKdqUXZbN2LNIK/X3iYYnm49+NffUyT
 NZJ8Jpo5++xKyQvjLcTu4rQo=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id dac5996b5fb42819;
	Tue, 17 Nov 2026 09:45:57 +0000
X-Mizu-Trace-ID: dac5996b5fb42819
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
	John Fastabend <john.fastabend@gmail.com>,
	Michal Luczaj <mhal@rbox.co>,
	Sechang Lim <rhkrqnwk98@gmail.com>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf v1] selftests/bpf: Fix CO-RE relocation of anonymous unions for bpf-gcc
Date: Tue, 17 Nov 2026 17:45:38 +0800
Message-ID: <20261117094544.148437-1-jiayuan.chen@linux.dev>
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
("0:0:0"), and libbpf rejects the relocation. Mark the unions too.

Fixes: e16c83fa764f ("selftests/bpf: Add negative test for sockmap update from non-sockmap iter")
Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
 tools/testing/selftests/bpf/progs/verifier_sockmap_mutate.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/verifier_sockmap_mutate.c b/tools/testing/selftests/bpf/progs/verifier_sockmap_mutate.c
index 1516fe1524bb..68b1a5323470 100644
--- a/tools/testing/selftests/bpf/progs/verifier_sockmap_mutate.c
+++ b/tools/testing/selftests/bpf/progs/verifier_sockmap_mutate.c
@@ -16,13 +16,13 @@ struct sock {
 struct bpf_iter__sockmap {
 	union {
 		struct sock *sk;
-	};
+	} __attribute__((preserve_access_index));
 } __attribute__((preserve_access_index));
 
 struct bpf_iter__unix {
 	union {
 		struct sock *unix_sk;
-	};
+	} __attribute__((preserve_access_index));
 } __attribute__((preserve_access_index));
 
 struct {
-- 
2.43.0

