Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 787603EC2EF
	for <bpf@vger.kernel.org>; Wed, 15 Jul 2026 11:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784114559; cv=none; b=hmmZUXvhIFWN5TFrw//MumTP0pHzofQpCzSl+3RE/UTKI4xlIjZPn+HXzgu7zwn4C+xAprUBv/hPCUJ6O8QNx7zvtVESMHrOdBYUgGxPFkWwsMZmPHyx7IIZNGBVEpfqEwk3oItlJR34sJiWbfcAZtA3ElFzl3cC0EwEwTLTl1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784114559; c=relaxed/simple;
	bh=bFttexQjsyqLp+T60V+mOqqZvnmTiv8LlTcjmqvATL0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Nh6xH602fv8JWwo3K7a4/SKtly8xe7Hbf0O97DM0C7MGn5yHfCdi5Gv93fMpzWsYr6hqnkYFnZlxfB6nc+sMw82c5+2ZFLDjLV148yxnT8yEReoew158JPFk9u8KQPb+QmMQbK8FxYYyTML+q1Rgz7t5sv5Q/LGU+oT4IksP4WI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UOK9AUDR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UOK9AUDR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784114555;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pOfdaZBghHclh3VAOu3barduxVjIt1eIkLYMLWCW7r8=;
	b=UOK9AUDRMRQBYSD2NQaeGfZqHUY32I+pqQA0whfD3ETuXf8e1myZvhQHeazLf1vaLbN/Zj
	oHt5FIXM2okNrZdRwzrSriE4NP76P/dluMQ3J5hjbfRa36rGgLuTXbamo5Hj875rVx5Vs4
	hzaVk30KHHsM/3eHN8s6iHjNHIs6P+U=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-468-lt_oF_hGN3qqG9uZZPpcqg-1; Wed,
 15 Jul 2026 07:22:29 -0400
X-MC-Unique: lt_oF_hGN3qqG9uZZPpcqg-1
X-Mimecast-MFC-AGG-ID: lt_oF_hGN3qqG9uZZPpcqg_1784114547
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 43ABC1955F14;
	Wed, 15 Jul 2026 11:22:27 +0000 (UTC)
Received: from vmalik-fedora.redhat.com (unknown [10.44.32.48])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3A239423;
	Wed, 15 Jul 2026 11:22:21 +0000 (UTC)
From: Viktor Malik <vmalik@redhat.com>
To: bpf@vger.kernel.org
Cc: Andrii Nakryiko <andrii@kernel.org>,
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
	Eric Biggers <ebiggers@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Viktor Malik <vmalik@redhat.com>
Subject: [PATCH bpf-next 3/4] selftests/bpf: Silence array bounds warning in global_map_resize
Date: Wed, 15 Jul 2026 13:22:02 +0200
Message-ID: <57765bc465a27923c3c093eba222cc24d08d8c40.1784112948.git.vmalik@redhat.com>
In-Reply-To: <cover.1784112948.git.vmalik@redhat.com>
References: <cover.1784112948.git.vmalik@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

When compiling BPF selftests with -O2, GCC reports an array bounds
violation warning in global_map_resize test:

    In function ‘global_map_resize_bss_subtest’,
        inlined from ‘test_global_map_resize’ at /bpf-next/tools/testing/selftests/bpf/prog_tests/global_map_resize.c:228:3:
    /bpf-next/tools/testing/selftests/bpf/prog_tests/global_map_resize.c:64:33: error: array subscript 1 is above array bounds of ‘int[1]’ [-Werror=array-bounds=]
       64 |                 skel->bss->array[i] = 1;
          |                 ~~~~~~~~~~~~~~~~^~~
    In file included from /bpf-next/tools/testing/selftests/bpf/prog_tests/global_map_resize.c:6:
    ./test_global_map_resize.skel.h: In function ‘test_global_map_resize’:
    ./test_global_map_resize.skel.h:44:21: note: while referencing ‘array’
       44 |                 int array[1];
          |                     ^~~~~

This is a false positive because `array` (a BPF map) has been resized
from within the BPF program. GCC doesn't know that so let us silence the
warning by accessing the array via a plain pointer.

Signed-off-by: Viktor Malik <vmalik@redhat.com>
Fixes: 08b089567573 ("libbpf: Selftests for resizing datasec maps")
---
 .../testing/selftests/bpf/prog_tests/global_map_resize.c  | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/global_map_resize.c b/tools/testing/selftests/bpf/prog_tests/global_map_resize.c
index 56b5baef35c8..602ce30f1720 100644
--- a/tools/testing/selftests/bpf/prog_tests/global_map_resize.c
+++ b/tools/testing/selftests/bpf/prog_tests/global_map_resize.c
@@ -23,6 +23,7 @@ static void global_map_resize_bss_subtest(void)
 	struct bpf_map *map;
 	const __u32 desired_sz = sizeof(skel->bss->sum) + sysconf(_SC_PAGE_SIZE) * 2;
 	size_t array_len, actual_sz, new_sz;
+	int *array;
 
 	skel = test_global_map_resize__open();
 	if (!ASSERT_OK_PTR(skel, "test_global_map_resize__open"))
@@ -58,10 +59,13 @@ static void global_map_resize_bss_subtest(void)
 		goto teardown;
 
 	/* fill the newly resized array with ones,
-	 * skipping the first element which was previously set
+	 * skipping the first element which was previously set;
+	 * access through a plain pointer to avoid -Warray-bounds
+	 * since the array was resized beyond its declared length.
 	 */
+	array = skel->bss->array;
 	for (int i = 1; i < array_len; i++)
-		skel->bss->array[i] = 1;
+		array[i] = 1;
 
 	/* set global const values before loading */
 	skel->rodata->pid = getpid();
-- 
2.54.0

