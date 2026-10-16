Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97461455173;
	Fri, 16 Oct 2026 22:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792188051; cv=none; b=iVzQkKktkM9EyK45SNq2LKrOlx0UJ8RjOwC/0Xi/asHdnzLXsuGz+6FzodMzs6MaGEnIgi45GyXGdQtNOQI+sfCzZPUWEbLKGHH/mLyI8BqjG4DleK+CVCJ61YLl7aPYs8ZaR1d40DcZRKvytGzVLtKPe/d05IFCV7tAarQ++nQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792188051; c=relaxed/simple;
	bh=Muq1C7Q17CMEZRfqjh8Kg0wS9PVegLFs/SjnSsVZ4IQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uUmg6LJQwYhDbGHLIQJkiUlxBvDYv/l6gHJ0R31RRU/KcxqqNRBoMRkTJfHAiljIhOvhv7PhR1q4V7rKbeaw+kjlZZzYCyZoPXfuKZr6kMxt0HDT9Xui7rOhpGt4cQDO1mIYlxDglq0f3dMkS9riI4HLsv7OH8pjU8b/0Oh6WQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=VC6RE+Hf; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="VC6RE+Hf"
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1xHpC3-00DhZY-Js; Fri, 16 Oct 2026 23:10:23 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector1; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From;
	bh=+cJ3MC7LUXBbC4N5bF/0Djg1Hg9lFmBTuLmxj+Rq3SI=; b=VC6RE+Hf/CQAN6SvbN9TkC0I87
	e7HCrBw4imwSrlqZhEfo7a6qb5JI1QKMHVL6G4Gg3S4HkhZxOB+fSnKEcoBP9oiCJdxTa6WkSkihT
	51mw/ADq6SqqizmDSarqjKpbn8Sujw5zpku5oPj3A/1uer6g9VloU7QreX+JL0F7KJpU8elwAmi2q
	WCVJ088s/OSHB4+H5+75Uy/6sQZflF8CM4PNMqaQEYyeL25on2Uz0PF13nrCq1qBlQWZTcV+STGMe
	yt1J8KK5g1L8hhMY5gRmIDMDIcmHsD/HmvPFJkzxG+Rq7VX++TpT9owZLcUhHs8r2so4MRaUhVZfM
	GYpyOFBA==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1xHpC1-0000vo-21; Fri, 16 Oct 2026 23:10:21 +0200
Received: by submission01.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1xHpBp-00G3o2-IB;
	Fri, 16 Oct 2026 23:10:09 +0200
From: Michal Luczaj <mhal@rbox.co>
Date: Fri, 16 Oct 2026 23:09:15 +0200
Subject: [PATCH bpf-next 3/3] selftests/bpf: Add negative test for sockmap
 update from non-sockmap iter
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261016-sockmap-update-limit-iter-v1-3-23fa946db59e@rbox.co>
References: <20261016-sockmap-update-limit-iter-v1-0-23fa946db59e@rbox.co>
In-Reply-To: <20261016-sockmap-update-limit-iter-v1-0-23fa946db59e@rbox.co>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, 
 Ihor Solodrai <ihor.solodrai@linux.dev>, Shuah Khan <shuah@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Lorenz Bauer <lmb@cloudflare.com>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Michal Luczaj <mhal@rbox.co>
X-Mailer: b4 0.15.2

Iterator-context sockmap updates are now restricted to iter/sockmap. Add a
test that attempts an update from iter/unix and expects it to fail.

Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
 .../testing/selftests/bpf/progs/verifier_sockmap_mutate.c  | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_sockmap_mutate.c b/tools/testing/selftests/bpf/progs/verifier_sockmap_mutate.c
index 20332a731d4e..1516fe1524bb 100644
--- a/tools/testing/selftests/bpf/progs/verifier_sockmap_mutate.c
+++ b/tools/testing/selftests/bpf/progs/verifier_sockmap_mutate.c
@@ -19,6 +19,12 @@ struct bpf_iter__sockmap {
 	};
 } __attribute__((preserve_access_index));
 
+struct bpf_iter__unix {
+	union {
+		struct sock *unix_sk;
+	};
+} __attribute__((preserve_access_index));
+
 struct {
 	__uint(type, BPF_MAP_TYPE_SOCKHASH);
 	__uint(max_entries, 1);
@@ -113,6 +119,14 @@ int test_trace_iter(struct bpf_iter__sockmap *ctx)
 	return 0;
 }
 
+SEC("iter/unix")
+__failure __msg("cannot update sockmap in this context")
+int test_trace_iter_unix(struct bpf_iter__unix *ctx)
+{
+	test_sockmap_mutate(ctx->unix_sk);
+	return 0;
+}
+
 SEC("raw_tp/kfree")
 __failure __msg("cannot update sockmap in this context")
 int test_raw_tp_delete(const void *ctx __always_unused)

-- 
2.56.0

