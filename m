Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D84D24676D
	for <bpf@vger.kernel.org>; Sun, 20 Sep 2026 08:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789894570; cv=none; b=jrkCN3def++48X3eY7djuu32I55WgQ7RjsMLjAw6bm4Q2HXtcTU3cwMA2JMkU+ilnS4oFfbZ30x8Ld2Fmi3q/coEapWsm+TR3E8dStbKcoc/zeMu3+h+usxsBhi4NKo+GMIFPZ7nWzlAeNp9ZXv5eUNRX35fwJjik12tbKBD19I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789894570; c=relaxed/simple;
	bh=8cKFAgpgqhS+17SJQQKIYTCM7mizfHIf1eAUYCkryRc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cvfssTnRrLaqyyO25Q3oYs/t7dWeG6/36xwDylka4Z9s2O1pz6cWbRM7BGE9bzN10/ulYyxnlgtnBUmUxXEkM3AKjeKDzuFaQHNxDVAwnPV6huUnhBkNmpaD8AGZEg3Q6nlxKd+bCEQqjp4/Wj4snvWdO5i2uHBQ27bwC+jid1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IJrL9eL8; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IJrL9eL8"
Received: by mail-pz2-f12.google.com with SMTP id d2e1a72fcca58-85469e211a3so1792594b3a.2
        for <bpf@vger.kernel.org>; Sun, 20 Sep 2026 01:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789894569; x=1790499369; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ksHOnUlot+h0QG2tWISkabaiPA1ToC05lg3IcvETRK4=;
        b=IJrL9eL8LN9h+jBBEOv4Z3veSO+c0zbufw+xXL5CsVQb0k1BLQ3K/V1hRDRVVDMe2h
         cEAPuHNomzBSjQouXbc1jK0XwpveTZ6hXotPSJ1BaXToMZpeIXGHguHEroZUNuVUqxe1
         X8WtOC0LrsYoSNBC43LOC4t3XbB8GFw06eelxSd+NcpyGR02Cy2VfX4ALC3RSiDsLWXB
         ljwsGB4489bfkUGIKx72MScIhMTM6IIDu+cV9XxsFYoWXUI95JghpiDKTfpoahRYhOQG
         T3UluY3CiH3y48lFIizCIzfs3uIA8Vvrt92bl4g0JOsVwIeWtOvjgsaB5xHXnqQg8Cgq
         pq+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789894569; x=1790499369;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ksHOnUlot+h0QG2tWISkabaiPA1ToC05lg3IcvETRK4=;
        b=U+oIBv+MkAS6uns11U8aDMAaoKVKZt3Hk0dpwXTU5g4HoCInmCx2zZ+C8KLQkYuy74
         JiR6EFnkcqdETXqRduvpq5DFllyXT2GO4xjxrb6EK4aL8n33nhPtnkpQF18sk5HX9tUX
         hWU2KT03HfMLS+AL6i1OrWUNRKI89b/P3WAW/Gs6LWdPB1Apn43Z6LdrRJBrak1zZK8l
         vz393lDjMKxRiF+bQCIO/aREcA1tPS8hYcR+4GfTObVV1ghBMT3m6yC2902qgZY4XKUV
         x89z+vXr4rxrCHpjeWSMkDQpUYbzKPM+7lDOJiaEXWEzVqs+wLoJeKcxVWGlERGXo0eG
         zkHg==
X-Gm-Message-State: AFuF++kvXMH/LZgPFhpOoBpThk1FEByoJh+d+5q+krUx245GbQfCl5si
	zGAiwmXf0j554kcvNvs9zNquvci0G+jvRSfXR0MD1qQoJ8fc5injnOZs
X-Gm-Gg: AYBFou3zIS+TrHXhfjQDOlaDbZpfme8vCOCcYgpgfGIX8U8JZd2pvydFE/wPQK+QOnr
	B/lR4kMwEw0OZfxzYgfNel+4IU5eJf1lfRdlYP2oxzXw+kWeJveRv5KADZXgXbALvWETR3N6Stu
	k3RlhsN1jMJEgzP4E57j/AF7Qg/xJC0Gkgj72tSlAr62pmQ4QPOkLrHqqS62IYax+L273OHmLVp
	/rqvb5rWw4r9ieJ1kUHHQnchEsPqNSL2m0lhgJHzySHdgEevQ19hNMwD7VtxJ2q26htNRSCYbbt
	Mx8Hl3e9zQrAVnTiDtcuqJ3Ds+V6ok0cg+ViBfVe/lcKW6NPTgf+u3H60sl7GHbjoTMIB1VgPwj
	HFWqUcKGXtB9lClkMFPPWbIUC9fOKiHByVwqihQuTRn3JMb2G2AJxDryDWE8J9FsQKWoquxxMDT
	5kN5ofP3hrLapV92IaPcNvCqjjq0vKgRS7NiQnK3FAtQpSOT8qVdhs9i7OH8P9FjMZ591Nw/ELw
	HI+NC/4q44PXeCxPdh/zSSkn1BcrF5b5554SkLUfXVoUrzCx4tpLgtD7g0cm6LpZ1JfFOhU9l5U
	AIk8L+JSkMprFUex4I5Jpg==
X-Received: by 2002:a05:6a00:44cb:b0:869:2b72:525d with SMTP id d2e1a72fcca58-874db7f1b4bmr11472071b3a.7.1789894568618;
        Sun, 20 Sep 2026 01:56:08 -0700 (PDT)
Received: from blackbox ([2401:4900:8838:4a03:4141:6b61:e799:72f6])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-877aa1099e5sm1758732b3a.49.2026.09.20.01.56.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 01:56:08 -0700 (PDT)
From: Madhav Khosla <madhav.khoslaa@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org
Cc: bpf@vger.kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	ihor.solodrai@linux.dev,
	sdf@fomichev.me,
	=?UTF-8?q?Alexis=20Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
	Madhav Khosla <madhav.khoslaa@gmail.com>
Subject: [PATCH bpf-next v3] selftests/bpf: Fix csum_partial() dropping trailing byte on odd length
Date: Sun, 20 Sep 2026 14:25:49 +0530
Message-ID: <20260920085549.867099-1-madhav.khoslaa@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

csum_partial() computes num_u16 = len >> 1 and only sums that many
16-bit words, so the last byte of an odd-length buffer never gets
added to the checksum. RFC 1071 says it should be padded with a zero
byte and summed as one more word, not dropped.

This backs build_ip_csum(), build_udp_v4_csum() and
build_udp_v6_csum(), used by flow_dissector_classification.c and
xdp_metadata.c to hand-build packets. No current caller builds an
odd-length payload, so nothing fails today, but a future one would
get a silently wrong checksum.

Also bump flow_dissector_classification's TEST_PACKET_LEN from 100 to
99 so this actually gets exercised instead of staying latent.

f4504af68575 wrote the len >> 1 division, but it only ever passed
sizeof(iphdr), always even, so it couldn't hit the bug. Tagging
bcc00987bc56 instead, since it added the first caller,
build_udp_v4_csum()/build_udp_v6_csum(), that can pass an odd length.

Verified with test_progs under vmtest.sh: without the fix, an odd
TEST_PACKET_LEN makes the kernel drop the packet over a bad checksum
and flow_dissector_classification fails; with the fix, both
flow_dissector_classification and xdp_metadata pass.

Fixes: bcc00987bc56 ("selftests/bpf: add network helpers to generate udp checksums")
Signed-off-by: Madhav Khosla <madhav.khoslaa@gmail.com>
---
v2 -> v3:
- Move the revision changelog and sample test output below --- so
  they don't end up in the permanent commit history (Alexis)
- Drop the Link tag; one is added automatically on merge (Alexis)
- Paste a passing run too, not just the failure (Alexis)
- Also run xdp_metadata, since it uses the same helpers (Alexis)

v1 -> v2:
- comment style: opening /* on its own line, per BPF selftests style
- Retarget the Fixes tag to bcc00987bc56. commit f4504af68575
  ("selftests/bpf: move ip checksum helper to network helpers") moved
  the helper, but sizeof(iphdr) is always a multiple of 32 bit words /
  4 Bytes (iph->ihl counts in 4-byte words), so the odd-length path
  was never reachable through build_ip_csum(). csum_partial() first
  gets called with a length that isn't guaranteed even in
  bcc00987bc56, via build_udp_v4_csum()/build_udp_v6_csum().
- TEST_PACKET_LEN 100 -> 99 so an existing test catches this instead
  of the bug staying unexercised

Without the fix and with TEST_PACKET_LEN=99, flow_dissector_classification
fails under vmtest.sh:

    test_flow_dissector_classification:FAIL:test third port unexpected
    test third port: actual 0 != expected 10
    #137/6   flow_dissector_classification/ipv6:FAIL
    #137     flow_dissector_classification:FAIL
    Summary: 1/0 PASSED, 0 SKIPPED, 1/6 FAILED

With the fix, ./test_progs -t flow_dissector_classification passes under
vmtest.sh:

    #137/1   flow_dissector_classification/ipv4:OK
    #137/2   flow_dissector_classification/ipv4_continue_dissect:OK
    #137/3   flow_dissector_classification/ipip:OK
    #137/4   flow_dissector_classification/gre:OK
    #137/5   flow_dissector_classification/port_range:OK
    #137/6   flow_dissector_classification/ipv6:OK
    #137     flow_dissector_classification:OK
    Summary: 1/6 PASSED, 0 SKIPPED, 0/0 FAILED

TEST_PACKET_LEN is 99 by default now, so no need to force it anymore.
Ran alongside xdp_metadata too, since it's the other user of
build_udp_v4_csum()/build_udp_v6_csum():

    #137/1   flow_dissector_classification/ipv4:OK
    #137/2   flow_dissector_classification/ipv4_continue_dissect:OK
    #137/3   flow_dissector_classification/ipip:OK
    #137/4   flow_dissector_classification/gre:OK
    #137/5   flow_dissector_classification/port_range:OK
    #137/6   flow_dissector_classification/ipv6:OK
    #137     flow_dissector_classification:OK
    #755     xdp_metadata:OK
    Summary: 2/6 PASSED, 0 SKIPPED, 0/0 FAILED
---
 tools/testing/selftests/bpf/network_helpers.h     | 15 +++++++++++++--
 .../prog_tests/flow_dissector_classification.c    |  2 +-
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/network_helpers.h b/tools/testing/selftests/bpf/network_helpers.h
index 75133119c04a..878c9fc5c37c 100644
--- a/tools/testing/selftests/bpf/network_helpers.h
+++ b/tools/testing/selftests/bpf/network_helpers.h
@@ -129,12 +129,23 @@ static __u16 csum_fold(__u32 csum)
 
 static __wsum csum_partial(const void *buf, int len, __wsum sum)
 {
-	__u16 *p = (__u16 *)buf;
+	const __u8 *p = buf;
 	int num_u16 = len >> 1;
 	int i;
 
 	for (i = 0; i < num_u16; i++)
-		sum += p[i];
+		sum += ((const __u16 *)p)[i];
+
+	/*
+	 * RFC 1071: an odd-length buffer's trailing byte is paired with
+	 * a zero pad byte to form the final 16-bit word.
+	 */
+	if (len & 1) {
+		__u16 tail = 0;
+
+		__builtin_memcpy(&tail, p + len - 1, 1);
+		sum += tail;
+	}
 
 	return sum;
 }
diff --git a/tools/testing/selftests/bpf/prog_tests/flow_dissector_classification.c b/tools/testing/selftests/bpf/prog_tests/flow_dissector_classification.c
index 80b153d3ddec..421dfa6c4ea3 100644
--- a/tools/testing/selftests/bpf/prog_tests/flow_dissector_classification.c
+++ b/tools/testing/selftests/bpf/prog_tests/flow_dissector_classification.c
@@ -27,7 +27,7 @@
 #define TEST_NAME_MAX_LEN (32 + SUBTEST_NAME_MAX_LEN)
 #define MAX_SOURCE_PORTS 3
 #define TEST_PACKETS_COUNT 10
-#define TEST_PACKET_LEN 100
+#define TEST_PACKET_LEN 99
 #define TEST_PACKET_PATTERN 'a'
 #define TEST_IPV4 "192.168.0.1/32"
 #define TEST_IPV6 "100::a/128"
-- 
2.55.0

