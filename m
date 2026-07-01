Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEBA425DB1A
	for <bpf@vger.kernel.org>; Wed,  1 Jul 2026 07:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782890205; cv=none; b=mbIED+uEA57OBrplE25XvuNpmuB/fw+ZmYrQFWlcOPUyZiJMGYYoApZlL9zn+7s1EUX6OCkToZCDjBO+T58ESBCrVaqRC08t8f9j7W+qHHIdh4Z4Rxk3xLeY8tMVwDeNQs61lgopNz3ZZ8yFPdWp0q7kSEGpQrrrjMnKFMEF858=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782890205; c=relaxed/simple;
	bh=FwhlMUy38RO2ViVf+TjEs4NlIi1QCoyuDDK7euyvINE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XDIUGllfd2EY5cQmBBRm1MXAUBSCRVyvR1VAxz44KEXez69Bu1+p3rsM97/MDvNMmRi4GGrycSG8juEVg5/CmXI2d6yeSO+Yp27vGIKoBFNUOY0lvp/bzfQhlQJYk5mS+MJ1YK2sSUQCMFHi9SU7Om5GYFAv7oGRwzU1tylFRmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=aSc7npCz; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="aSc7npCz"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782890187;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=EHO+f3xxzW8WMzdZUPhW40lXHIoGdnm2ezjRxVBOIkU=;
	b=aSc7npCzGt29XXMGpY1lYL9lgU9+qQihxDnnXVMYAM3GYmlGJ6hEn7P9wwJSAJqsTtnISv
	w1FEdBUE+ad/tblv5UI9jIN4c38aFgOO7eCQi+BxbxzIDz+pI4SvWkRSIlhbGftzTSB+MM
	VyJ4pbchJrh1acFUz0l1BwFTAOOx+nE=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: bpf@vger.kernel.org
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Shuah Khan <shuah@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf v1] selftests/bpf: Fix test_maps sockmap failure
Date: Wed,  1 Jul 2026 15:14:22 +0800
Message-ID: <20260701071501.39628-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

test_maps fails in the sockmap test because sockmap_verdict_prog.c
drops the packet when the first 8 bytes are not directly accessible:
	  if (data + 8 > data_end)
			  return SK_DROP;

The blamed commit removed bpf_skb_pull_data() from the stream parser
program so that the parser no longer modifies the skb. That was needed,
but it also removed an implicit side effect: bpf_skb_pull_data()
linearized enough of the skb for later direct packet access.

In this test, the send side goes through the sockmap SK_MSG path. The
skb can have skb->len == 20 while its linear area is empty, so the
verdict program sees data == data_end and drops the packet even though
the payload length is sufficient.

Keep the parser read-only, and pull the first 8 bytes in the verdict
program before reading or writing them. Reload data/data_end after
bpf_skb_pull_data() as required.

Reported-by: Ihor Solodrai <ihor.solodrai@linux.dev>
Closes: https://lore.kernel.org/bpf/e3a91acd-2b4d-4e93-a3bb-a0e9ee5ede0f@linux.dev/
Fixes: 22a0cc10dacb ("selftests/bpf: don't modify the skb in the strparser parser prog")
Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
 .../selftests/bpf/progs/sockmap_verdict_prog.c     | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/sockmap_verdict_prog.c b/tools/testing/selftests/bpf/progs/sockmap_verdict_prog.c
index 0660f29dca955..3177bc5b733ac 100644
--- a/tools/testing/selftests/bpf/progs/sockmap_verdict_prog.c
+++ b/tools/testing/selftests/bpf/progs/sockmap_verdict_prog.c
@@ -44,8 +44,18 @@ int bpf_prog2(struct __sk_buff *skb)
 	__sink(lport);
 	__sink(rport);
 
-	if (data + 8 > data_end)
-		return SK_DROP;
+	if (data + 8 > data_end) {
+		if (bpf_skb_pull_data(skb, 8))
+			return SK_DROP;
+
+		data = (void *)(long)skb->data;
+		data_end = (void *)(long)skb->data_end;
+
+		if (data + 8 > data_end)
+			return SK_DROP;
+
+		d = data;
+	}
 
 	map = d[0];
 	sk = d[1];
-- 
2.43.0

