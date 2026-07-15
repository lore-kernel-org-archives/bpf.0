Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B27753644C5
	for <bpf@vger.kernel.org>; Wed, 15 Jul 2026 11:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784114542; cv=none; b=hxi9oQG/d7HjtXo6J41QU0ne7j376Tv3j/cg4NN9tiUIeiV52sDOEo7gMVki39o3Sqj1j+iA/qRPQpCa0lEtWUrWY4CsBFkEL/k5HUaFwCujlnwOglnU4PM9L9OmSRcCHtmbT9vLcv85P2KYcds2dwLNUKZEnLUnK1hu4vUQxw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784114542; c=relaxed/simple;
	bh=0cYWPNKt+FVxd8PD0uc6qH/cdVGeEo7OA27IeY2Mg2s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=D01nPZRRFD9L3sdCcHu2VIDeIe7JrsPrQ3UrwfJY/fuvliipdBkNL9QTM7/C6Nhk+Bn7v4wdGpdPGagusWILorZOWdGkLh/HqAXxvS6T8BcfQrDYcQfo5wXzQaSky1mi10O9hR2O6DBGG7XypK6mPF2rYzYjgLFkm0MHp2CVyXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=B487fhYV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B487fhYV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784114539;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=4Es7JN/7emM3eNPq+2yAtpij7OwA+kPAzs4KTieUqX0=;
	b=B487fhYV51muUVQCFWnNixofhq2aCjKMsTRHjMcJaPmCWnVY3/B60/c93dOWCn7Z3DMJ62
	Hiv8CZck9pP512CbsZlgol70SDNomptB6d2EGOorW5wue55R4CkyE4jdIjUc8K4Ia/ybmV
	GfUBvA2k38X7NmxB8daYjUE2GGddOKY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-670-X8a0qAshPuGNPbc-5DiHPQ-1; Wed,
 15 Jul 2026 07:22:14 -0400
X-MC-Unique: X8a0qAshPuGNPbc-5DiHPQ-1
X-Mimecast-MFC-AGG-ID: X8a0qAshPuGNPbc-5DiHPQ_1784114532
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DDF631955F0C;
	Wed, 15 Jul 2026 11:22:11 +0000 (UTC)
Received: from vmalik-fedora.redhat.com (unknown [10.44.32.48])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2F11746E;
	Wed, 15 Jul 2026 11:22:06 +0000 (UTC)
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
Subject: [PATCH bpf-next 0/4] selftests/bpf: Fix compilation with RELEASE=1
Date: Wed, 15 Jul 2026 13:21:59 +0200
Message-ID: <cover.1784112948.git.vmalik@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

When compiling BPF selftests with RELEASE=1 (which most notably adds
-O2), GCC reports several warnings. These are by default treated as
errors and abort the compilation.

This series fixes all of the issues such that selftests can be compiled
with RELEASE=1.

Viktor Malik (4):
  selftests/bpf: Check malloc result with ASSERT_NEQ in test_loader
  selftests/bpf: Check malloc result with ASSERT_NEQ in test_sha256
  selftests/bpf: Silence array bounds warning in global_map_resize
  selftests/bpf: Silence maybe-uninitialized compiler warning in
    libarena

 .../selftests/bpf/libarena/include/libarena/userspace.h   | 2 +-
 .../testing/selftests/bpf/prog_tests/global_map_resize.c  | 8 ++++++--
 tools/testing/selftests/bpf/prog_tests/sha256.c           | 4 ++--
 tools/testing/selftests/bpf/test_loader.c                 | 2 +-
 4 files changed, 10 insertions(+), 6 deletions(-)

-- 
2.54.0

