Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9054B43B6E3
	for <bpf@vger.kernel.org>; Wed, 15 Jul 2026 11:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784114552; cv=none; b=DXrqoe+bRGrYYYa0jMgxNAdJzVPyHWItTzGLRPh3+t2TvbYuqae7gjtA+ro5hG6N+lObT2IG+0MgMNRLCqj6V3AKXbxzyGsmnwCJtxn40Pw2wvl9HWgriGfGW8QLsZq83rTjjFFclKTEisKov9hYLPRYodzM2OzrC5vGRw3+uVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784114552; c=relaxed/simple;
	bh=FVX3OatVj1mu9GU4CNyK65Cq1ziA3NS1YX436KHZSnI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uUzOzJGwv/+dptOD8S+tQECVfuJcyXFk6VZFUcNl52iWO8l+UoD3F/0jKDdlu2XKw2jaal38Ux8e0SW6QC3tORhgwRWOzQFolQ4pSw96mhjb67AbxjbmQtrpquoOL6da70bSEflIaNAYQP1vIPU1ShatfyW8kQuB5UCxQprGpPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SCE6SqaE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SCE6SqaE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784114549;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eQUPe9cFdcZ5xXKhozylhkAdgOEeurllUwNZPf5WlP8=;
	b=SCE6SqaE+lGZbqNmtuWVAXb/OH1mddZB8TvI8FNRf8yNI03FOLDe1AoxrEEi1wINqPuR31
	gxSQ7bDHDO/zhjj540i+eamV/wk42MmqQSW4y7/sWpR71e4BDFgqMBzBMTCWSdBdojTbCg
	NsO7xkX5bjjbaaWZG+h3PU/VX+36h14=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-624-rkroGjMyN2isB8nxhUy0SA-1; Wed,
 15 Jul 2026 07:22:23 -0400
X-MC-Unique: rkroGjMyN2isB8nxhUy0SA-1
X-Mimecast-MFC-AGG-ID: rkroGjMyN2isB8nxhUy0SA_1784114542
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B69931955F11;
	Wed, 15 Jul 2026 11:22:21 +0000 (UTC)
Received: from vmalik-fedora.redhat.com (unknown [10.44.32.48])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6A600424;
	Wed, 15 Jul 2026 11:22:17 +0000 (UTC)
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
Subject: [PATCH bpf-next 2/4] selftests/bpf: Check malloc result with ASSERT_NEQ in test_sha256
Date: Wed, 15 Jul 2026 13:22:01 +0200
Message-ID: <f9dec09cca0c2aa5eeb4fdcd400a13aa19e2c073.1784112948.git.vmalik@redhat.com>
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

Replace ASSERT_OK_PTR by ASSERT_NEQ(res, NULL, ...) when checking the
result of malloc. It is more accurate since malloc returns NULL, not an
error code, on failure and it also prevents the following false GCC
warning when compiling BPF selftests with -O2:

    In file included from /bpf-next/tools/testing/selftests/bpf/prog_tests/sha256.c:4:
    /bpf-next/tools/testing/selftests/bpf/prog_tests/sha256.c: In function ‘test_sha256’:
    ./test_progs.h:393:22: error: ‘data’ may be used uninitialized [-Werror=maybe-uninitialized]
      393 |         int ___err = libbpf_get_error(___res);                          \
          |                      ^~~~~~~~~~~~~~~~~~~~~~~~
    /bpf-next/tools/testing/selftests/bpf/prog_tests/sha256.c:28:14: note: in expansion of macro ‘ASSERT_OK_PTR’
       28 |         if (!ASSERT_OK_PTR(data, "malloc"))
          |              ^~~~~~~~~~~~~
    In file included from /bpf-next/tools/testing/selftests/bpf/tools/include/bpf/bpf.h:32,
                     from ./test_progs.h:37:
    /bpf-next/tools/testing/selftests/bpf/tools/include/bpf/libbpf_legacy.h:113:17: note: by argument 1 of type ‘const void *’ to ‘libbpf_get_error’ declared here
      113 | LIBBPF_API long libbpf_get_error(const void *ptr);
          |                 ^~~~~~~~~~~~~~~~

Signed-off-by: Viktor Malik <vmalik@redhat.com>
Fixes: f09f57c74677 ("selftests/bpf: Add test for libbpf_sha256()")
---
 tools/testing/selftests/bpf/prog_tests/sha256.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sha256.c b/tools/testing/selftests/bpf/prog_tests/sha256.c
index 604a0b1423d5..5edbc6194b07 100644
--- a/tools/testing/selftests/bpf/prog_tests/sha256.c
+++ b/tools/testing/selftests/bpf/prog_tests/sha256.c
@@ -25,10 +25,10 @@ void test_sha256(void)
 	size_t i;
 
 	data = malloc(MAX_LEN);
-	if (!ASSERT_OK_PTR(data, "malloc"))
+	if (!ASSERT_NEQ(data, NULL, "malloc"))
 		goto out;
 	digests = malloc((MAX_LEN + 1) * SHA256_DIGEST_LENGTH);
-	if (!ASSERT_OK_PTR(digests, "malloc"))
+	if (!ASSERT_NEQ(digests, NULL, "malloc"))
 		goto out;
 
 	/* Generate MAX_LEN bytes of "random" data deterministically. */
-- 
2.54.0

