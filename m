Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A9224483B0
	for <bpf@vger.kernel.org>; Wed, 15 Jul 2026 11:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784114546; cv=none; b=CvjxRWnXSl03tr0h5ehEfw72Pl2GxyCdXDng3zt0kwd8+42KUwPp+Jo5XDsnO3ntEHTKLvPoMxKZZSyYSx8i5yg2H+2DhcyKKLXPtAvd1IgQls5IPzudzqi8bu4jqCtfTzAkN2ufwghFjt9FwdZcxWmsyXILjjsT0A2TeDG2KcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784114546; c=relaxed/simple;
	bh=Xp/U7L2LMKMK57FeZr9v9VOxSsyJhIULsMcjFpiXKCA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TDXO1u1ajh6uKjhjdYh0DzOA96GG6HrH/Mn+X/dmzma6kNDwA1/R6zizvbSfwthdmuz6t7XbeFk5xNBaVwsFYzamm5GGFVJiQ9MZA8LsCx/nBYtQQliZcGww825SCdPGHFCEjKb96JSS920TyrhrdVNx4V2l4qECSOg8qkH7g1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WDoPUbHT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WDoPUbHT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784114543;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B8ZrvVuIQZqlV24gdXBkKgufVTdKlK63bjKOvfqwD9k=;
	b=WDoPUbHTujC+5YV5oUi96ChM7IwVk/8EpKPwqJoqe2GXJ6c2oZR/Eufuh6s2seww6Goqhp
	2JXvZnpcjnUoNf26ECH1I7wzVlHg89PilMrCcdskvEo9DCKwXqTiEodNNbjN6cEIJNDtRl
	fmE6EC5tFk7OWwZQl6GIzkgUV9PeOuM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-401-9qZUUDWkP3-A6c7R9ETYew-1; Wed,
 15 Jul 2026 07:22:19 -0400
X-MC-Unique: 9qZUUDWkP3-A6c7R9ETYew-1
X-Mimecast-MFC-AGG-ID: 9qZUUDWkP3-A6c7R9ETYew_1784114537
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E4B111955E89;
	Wed, 15 Jul 2026 11:22:16 +0000 (UTC)
Received: from vmalik-fedora.redhat.com (unknown [10.44.32.48])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4CDA5424;
	Wed, 15 Jul 2026 11:22:12 +0000 (UTC)
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
Subject: [PATCH bpf-next 1/4] selftests/bpf: Check malloc result with ASSERT_NEQ in test_loader
Date: Wed, 15 Jul 2026 13:22:00 +0200
Message-ID: <e25d50805fbcb3632f24b488568ab5ba49b82094.1784112948.git.vmalik@redhat.com>
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

    In file included from test_loader.c:6:
    test_loader.c: In function ‘verify_stderr’:
    /bpf-next/tools/testing/selftests/bpf/test_progs.h:393:22: error: ‘buf’ may be used uninitialized [-Werror=maybe-uninitialized]
      393 |         int ___err = libbpf_get_error(___res);                          \
          |                      ^~~~~~~~~~~~~~~~~~~~~~~~
    test_loader.c:810:14: note: in expansion of macro ‘ASSERT_OK_PTR’
      810 |         if (!ASSERT_OK_PTR(buf, "malloc"))
          |              ^~~~~~~~~~~~~
    In file included from /bpf-next/tools/testing/selftests/bpf/tools/include/bpf/bpf.h:32,
                     from /bpf-next/tools/testing/selftests/bpf/test_progs.h:37:
    /bpf-next/tools/testing/selftests/bpf/tools/include/bpf/libbpf_legacy.h:113:17: note: by argument 1 of type ‘const void *’ to ‘libbpf_get_error’ declared here
      113 | LIBBPF_API long libbpf_get_error(const void *ptr);
          |                 ^~~~~~~~~~~~~~~~

Signed-off-by: Viktor Malik <vmalik@redhat.com>
Fixes: 554e4eb9e4b7 ("selftests/bpf: Reuse stderr parsing for libarena ASAN tests")
---
 tools/testing/selftests/bpf/test_loader.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/test_loader.c b/tools/testing/selftests/bpf/test_loader.c
index 3ce32d134e2c..07807757b518 100644
--- a/tools/testing/selftests/bpf/test_loader.c
+++ b/tools/testing/selftests/bpf/test_loader.c
@@ -807,7 +807,7 @@ static void verify_stderr(int prog_fd, struct expected_msgs *msgs)
 		return;
 
 	buf = malloc(TEST_LOADER_LOG_BUF_SZ);
-	if (!ASSERT_OK_PTR(buf, "malloc"))
+	if (!ASSERT_NEQ(buf, NULL, "malloc"))
 		return;
 
 	ret = bpf_prog_stream_read(prog_fd, 2, buf, TEST_LOADER_LOG_BUF_SZ - 1,
-- 
2.54.0

