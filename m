Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EB494483BE
	for <bpf@vger.kernel.org>; Wed, 15 Jul 2026 11:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784114561; cv=none; b=cB6s8bIqydo8CDB1EFlBDzSijfVcFLDOxFLCqNuDHvAfYrLbgF5Gt4F2MSBHZEP3jME9O/6zf6tuYAz7mG3dWBqhMqNWTp5l7ckjxuNyP3j/QINTmURW9KvGo8S4jMjczz7PJkSgP/swbyThfFL11M1sLbg9+opPLK5mxXrNWkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784114561; c=relaxed/simple;
	bh=naJzMbFeJgeoIuKdJdsKliRq6EFNRRgM5nZxnrFpAuE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aBJbfrhiVYLf07pdNFrml4rlcRIaG02cVLP1Eb7HawhiUmsVZGpZ2q/gRaF3bsQ9piIByX/Jryx0Q8+WtxvQ/QjEl3gSNGW/s8KDT659fu+JOcjYJ12Wd/Sd4L1YX9wntIelVIgsNEGl/se/GVM97TRZHjufDx+5Ab8TlU728qE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MNqfKJsx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MNqfKJsx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784114557;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HHoEkHdDkuy9QyUVyj2LJVsRZX0SgCrv1sYkyXgUu2E=;
	b=MNqfKJsxs2Dyy0OiiSEDcmVCki6fo7xs06JGiCK7HPlX1Pw9bOqQH5egrOcLjhLr1CeIhL
	XqEXHftIs/Rq99zZvNhbuWSSMm4ouaXYZ6L5m6c+xgEfvurU+BgwzxzjJV/3S2u0iPU0b3
	2NAcdMoL6UaRYzucj972mtrsZ3VcQ24=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-625-Pw6Urz7aOX-gSevZj-_Osg-1; Wed,
 15 Jul 2026 07:22:34 -0400
X-MC-Unique: Pw6Urz7aOX-gSevZj-_Osg-1
X-Mimecast-MFC-AGG-ID: Pw6Urz7aOX-gSevZj-_Osg_1784114552
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 156881800576;
	Wed, 15 Jul 2026 11:22:32 +0000 (UTC)
Received: from vmalik-fedora.redhat.com (unknown [10.44.32.48])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BB96B46E;
	Wed, 15 Jul 2026 11:22:27 +0000 (UTC)
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
Subject: [PATCH bpf-next 4/4] selftests/bpf: Silence maybe-uninitialized compiler warning in libarena
Date: Wed, 15 Jul 2026 13:22:03 +0200
Message-ID: <9f77a5c05c3c731ab2655fd66716ab9de4478b15.1784112948.git.vmalik@redhat.com>
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

When compiling BPF selftests with -O2, GCC reports a maybe-uninitialized
warning in libarena code:

    In file included from /bpf-next/tools/testing/selftests/bpf/prog_tests/libarena_asan.c:11:
    In function ‘libarena_asan_init’,
        inlined from ‘run_test’ at /bpf-next/tools/testing/selftests/bpf/prog_tests/libarena_asan.c:59:8,
        inlined from ‘test_libarena_asan’ at /bpf-next/tools/testing/selftests/bpf/prog_tests/libarena_asan.c:91:2:
    /bpf-next/tools/testing/selftests/bpf/libarena/include/libarena/userspace.h:126:14: error: ‘globals_pages’ may be used uninitialized [-Werror=maybe-uninitialized]
      126 |         args = (struct asan_init_args){
          |         ~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~
      127 |                 .arena_all_pages = arena_all_pages,
          |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      128 |                 .arena_globals_pages = globals_pages,
          |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      129 |         };
          |         ~
    /bpf-next/tools/testing/selftests/bpf/libarena/include/libarena/userspace.h: In function ‘test_libarena_asan’:
    /bpf-next/tools/testing/selftests/bpf/libarena/include/libarena/userspace.h:118:13: note: ‘globals_pages’ was declared here
      118 |         u64 globals_pages;
          |             ^~~~~~~~~~~~~

Silence the warning by initializing globals_pages to 0.

Signed-off-by: Viktor Malik <vmalik@redhat.com>
Fixes: cfc00618b9df ("selftests/bpf: Add ASAN support for libarena selftests")
---
 .../testing/selftests/bpf/libarena/include/libarena/userspace.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/libarena/include/libarena/userspace.h b/tools/testing/selftests/bpf/libarena/include/libarena/userspace.h
index fc27a4bcf5d7..b6676dd67bc0 100644
--- a/tools/testing/selftests/bpf/libarena/include/libarena/userspace.h
+++ b/tools/testing/selftests/bpf/libarena/include/libarena/userspace.h
@@ -115,7 +115,7 @@ static inline int libarena_asan_init(int arena_asan_init_fd,
 {
 	LIBBPF_OPTS(bpf_test_run_opts, opts);
 	struct asan_init_args args;
-	u64 globals_pages;
+	u64 globals_pages = 0;
 	int ret;
 
 	ret = libarena_get_globals_pages(arena_asan_init_fd,
-- 
2.54.0

