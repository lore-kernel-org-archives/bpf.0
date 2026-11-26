Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795672450;
	b=S3e3j0goMnf61xccujsLxKnUsREtdFSrQWFNjwgauaFEEmcYJTx+ebU43hT9/UoJlaCj
	 8meiK7GQtEI9NIgA/uejHhcXuqg1D0aNRhDCJujjzU0kBKDaPQFg1XIPnINIVgRYzBHek
	 SO5hjetatOx41F9sIb0IUCX3cnsWemQ6lgY/VXCT7lcvN3IOP9GKFTIX9MhF27Uth4HCb
	 TIptrlemoF+xa7j3qIA8kzV6Fw2/PZgbsQpvdvl+qjIjqsqagDGBTr/5FhlWrupiNTYlv
	 fXoQznBhDr5uydyOwAU6TPUMDRx5YYuDUcHAsUzcn8G7yn1ecisIKZfKb3aw+xIbJCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795672450;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=j2bY7HxpteDRIW54QOotBSCLRb4icQwz1aDhsZT0FEI=;
	b=rMJ6KLTqsmfU7UNKdZ/6c2+u67GZ8uhm6qQL80rFACHiFaYf+VVmEFOzyNtbWD1Tw502
	 Juu+m0eJTXgff8zxg7UYxnn5DI5eSqsOMS8z5b38PjKYCrm7Q/1dK0rT3EI9Yh/XanO3T
	 NLllp0UKYkwaB6Y+bzIBX4j5DLqUNtr/bK0pXB6F8oGvFPGxlg9JI4h6TlJu4OGv7zfjv
	 fa57hsnbqM00/CydYH2PA6bdEaU1DFclzvNVR1LpOEEdFy5r2vkbfjOHKijDVGM3J9HBA
	 nyzT4l5J3ihA0ilpYFYFmrFgDgEqbnWEm8laBB123Z/Pp3hNcdInaYDGDBPA8S8cB5g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=LsaQaQ59;
	arc=none smtp.remote-ip=91.218.175.108
Received: from mta0.migadu.com (out-108.mta0.migadu.com [91.218.175.108])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE77F606A327
	for <bpf@vger.kernel.org>; Thu, 26 Nov 2026 05:54:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BE77F606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=LsaQaQ59
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=jmsocC4qJVABqWJH7IQKprNF8T0xRVsWcdRSae8/Y4I=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795672446; v=1; x=1796277246;
 b=LsaQaQ596Qt8LzZZJxBXX4Ig2nSyKwU/DZuasjRqDh5/cdNDzQNHuMWjqQxG41pdCP3c5lgX
 D7KxtLtcubaq0HzCLPcmIATKTs/vowo3gfTlKh38nK5LZlE0XJiB6VtjGxUQCEOyvPxOQn9ZeJ0
 MVO166TxfXdFZRCEAwQKjgd0=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 05cc57f00654abf7;
	Thu, 26 Nov 2026 05:54:06 +0000
X-Mizu-Trace-ID: 05cc57f00654abf7
X-Migadu-Flow: FLOW_OUT
From: George Guo <dongtai.guo@linux.dev>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Cc: bpf@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	George Guo <guodongtai@kylinos.cn>
Subject: [PATCH bpf-next v1 1/5] selftests/bpf: Use unsigned loop counter in test_buddy_alloc_free
Date: Thu, 26 Nov 2026 14:53:50 +0900
Message-ID: <20261126055355.9967-2-dongtai.guo@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261126055355.9967-1-dongtai.guo@linux.dev>
References: <20261126055355.9967-1-dongtai.guo@linux.dev>
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

From: George Guo <guodongtai@kylinos.cn>

test_buddy_alloc_free() picks an allocation size with
alloc_free_sizes[(i * 5) % 8], where i is a signed int. That is a
signed remainder, which clang 19 refuses to compile for BPF without
-mcpu=v4:

  test_buddy.bpf.c:80:54: error: unsupported signed division, please convert to unsigned div/mod.

i only counts up from zero, so make it a u32, like the loop counter in
test_buddy_alloc_multiple() and the u32 zero it starts from. The
remainder becomes unsigned and the selected sizes are unchanged.

Fixes: b1487dc1b181 ("selftests/bpf: Add selftests for libarena buddy allocator")
Signed-off-by: George Guo <guodongtai@kylinos.cn>
---
 .../testing/selftests/bpf/libarena/selftests/test_buddy.bpf.c  | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/libarena/selftests/test_buddy.bpf.c b/tools/testing/selftests/bpf/libarena/selftests/test_buddy.bpf.c
index 886a09019566..00f1efe931af 100644
--- a/tools/testing/selftests/bpf/libarena/selftests/test_buddy.bpf.c
+++ b/tools/testing/selftests/bpf/libarena/selftests/test_buddy.bpf.c
@@ -99,7 +99,8 @@ __weak int test_buddy_alloc_free(void)
 {
 	const int iters = 800;
 	void __arena *mem;
-	int ret, i;
+	int ret;
+	u32 i;
 
 	ret = buddy_init(&buddy);
 	if (ret)
-- 
2.53.0

