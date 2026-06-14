Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC7C82C21F1;
	Sun, 14 Jun 2026 01:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781401748; cv=none; b=UhZi0NNkoLZbXZzPHGaedtbuP6qql+q/MH23N3CtsvTQWZH5v5gAvogyy9I36/2tc+IWr5BcTzBlw7ICZdJuFByw+rLTEBCVR3p0yRmCDPY1hdcrb3ohyF0nCtT3LNTmTo2ndy6OZMn7hjirhuRtkXYGebBRA8FRnqptg6t403c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781401748; c=relaxed/simple;
	bh=8dz6/SaOc+F+Uw4uQoNwuNT0SOhzqBTepT6Zbf/lkRY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mV3RGIS9iaHGxnvD51NO2HJVonBtbRxDJaZrGUnTI/aOZdyKRr3zwrXjZrinkdx875wcxE14YxBJGBZ2AC68F5LPL3qY985AwpbpT5V0EmQqk+119rB4d6vID84s5PNWmAik6Z6jeg0B2u+Gc7NlmBxiis2oSc0LG8m2o391H/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PDmFKxwo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PDmFKxwo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C5751F00AC4;
	Sun, 14 Jun 2026 01:49:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781401745;
	bh=pVlAB0niwxQq8SW/aQUHkK5p0Bl8aaDn/Fg5ktLe2nw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=PDmFKxwozMpmyo8+ujtaLp5jiwOmq/gvSIIN7hDwgBUQSPQOAzdVasmnGt/LEWzFM
	 UrhA0tCnYtt18NFNlDms3qWDiVQecr/qCYE3pCCn68atvMvbYkRAk5Stf6Aya5hteI
	 7xbVKqmxgkn/xVD17pJ/XvhbEn6I6cmZ3n4W3jwZrkk8OH7NvwlXyK2VaIWzqMFE2t
	 G1Jsxd8+GtGGWtLm1T+tfdnOenYJYt99zmWDQKwlfmZa4t4DOWQc12taz8d6pIH7y/
	 /FsOEiGMwKXXx66Q6Bvv77RRbmaTyvsqURMxdo507OualQu0O4gkNT4ZxxkxEi0cxI
	 SAJb5mjnERE/Q==
From: Tamir Duberstein <tamird@kernel.org>
Date: Sat, 13 Jun 2026 21:48:47 -0400
Subject: [PATCH bpf 4/6] libbpf: ringbuf: Use compiler atomics
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260613-bpf-ringbuf-fixes-v1-4-e623481cb724@kernel.org>
References: <20260613-bpf-ringbuf-fixes-v1-0-e623481cb724@kernel.org>
In-Reply-To: <20260613-bpf-ringbuf-fixes-v1-0-e623481cb724@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Shuah Khan <shuah@kernel.org>, Andrea Righi <arighi@nvidia.com>, 
 Xu Kuohai <xukuohai@huawei.com>, Andrea Righi <andrea.righi@canonical.com>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Andrew Werner <awerner32@gmail.com>, 
 Zvi Effron <zeffron@riotgames.com>, Andrii Nakryiko <andriin@fb.com>, 
 Tamir Duberstein <tamird@kernel.org>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2768; i=tamird@kernel.org;
 h=from:subject:message-id; bh=8dz6/SaOc+F+Uw4uQoNwuNT0SOhzqBTepT6Zbf/lkRY=;
 b=owGbwMvMwCV2wYdPVfy60HTG02pJDFl6HG3Oi27VMdyeyckqPPO4fOrpGU/n//uXcZxRw/Wea
 oRIlIJ4x0QWBjEuBksxRZZE0UN701Nv75HNfHccZg4rE8gQaZEGBiBgYeDLTcwrNdIx0jPVNtQz
 NNIx0DFm4OIUgKlefJPhf8IHxVVG4uXhvzzLbqeKnT12WcztSNKOs1J6j+Vv1GctrmT4Hyn2MUH
 VavMK1pzzHUJCRuKnVAoM7JxaJS1M3e+rav/hBQA=
X-Developer-Key: i=tamird@kernel.org; a=openpgp;
 fpr=5A6714204D41EC844C50273C19D6FF6092365380

Consumer-side ring buffer code uses architecture-specific smp_* helpers
for shared memory accesses.

Use compiler atomics instead. They provide equivalent acquire and
release ordering through a portable userspace interface and allow the
next commit to use compiler fences in the wakeup protocol without mixing
atomic interfaces.

Assisted-by: Codex:gpt-5.5
Signed-off-by: Tamir Duberstein <tamird@kernel.org>
---
 tools/lib/bpf/ringbuf.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/tools/lib/bpf/ringbuf.c b/tools/lib/bpf/ringbuf.c
index b7adce37b519..1c24a83f59d5 100644
--- a/tools/lib/bpf/ringbuf.c
+++ b/tools/lib/bpf/ringbuf.c
@@ -264,13 +264,13 @@ static int64_t ringbuf_process_ring(struct ring *r, size_t n)
 	if (n == 0)
 		return 0;
 
-	cons_pos = smp_load_acquire(r->consumer_pos);
+	cons_pos = __atomic_load_n(r->consumer_pos, __ATOMIC_ACQUIRE);
 	do {
 		got_new_data = false;
-		prod_pos = smp_load_acquire(r->producer_pos);
+		prod_pos = __atomic_load_n(r->producer_pos, __ATOMIC_ACQUIRE);
 		while (cons_pos != prod_pos) {
 			len_ptr = r->data + (cons_pos & r->mask);
-			len = smp_load_acquire(len_ptr);
+			len = __atomic_load_n(len_ptr, __ATOMIC_ACQUIRE);
 
 			/* sample not committed yet, bail out for now */
 			if (len & BPF_RINGBUF_BUSY_BIT)
@@ -284,14 +284,16 @@ static int64_t ringbuf_process_ring(struct ring *r, size_t n)
 				err = r->sample_cb(r->ctx, sample, len);
 				if (err < 0) {
 					/* update consumer pos and bail out */
-					smp_store_release(r->consumer_pos,
-							  cons_pos);
+					__atomic_store_n(r->consumer_pos,
+							 cons_pos,
+							 __ATOMIC_RELEASE);
 					return err;
 				}
 				cnt++;
 			}
 
-			smp_store_release(r->consumer_pos, cons_pos);
+			__atomic_store_n(r->consumer_pos, cons_pos,
+					 __ATOMIC_RELEASE);
 
 			if (cnt >= n)
 				goto done;
@@ -406,8 +408,8 @@ struct ring *ring_buffer__ring(struct ring_buffer *rb, unsigned int idx)
 
 unsigned long ring__consumer_pos(const struct ring *r)
 {
-	/* Synchronizes with smp_store_release() in ringbuf_process_ring(). */
-	return smp_load_acquire(r->consumer_pos);
+	/* Synchronizes with the release store in ringbuf_process_ring(). */
+	return __atomic_load_n(r->consumer_pos, __ATOMIC_ACQUIRE);
 }
 
 unsigned long ring__producer_pos(const struct ring *r)
@@ -415,7 +417,7 @@ unsigned long ring__producer_pos(const struct ring *r)
 	/* Synchronizes with smp_store_release() in __bpf_ringbuf_reserve() in
 	 * the kernel.
 	 */
-	return smp_load_acquire(r->producer_pos);
+	return __atomic_load_n(r->producer_pos, __ATOMIC_ACQUIRE);
 }
 
 size_t ring__avail_data_size(const struct ring *r)

-- 
2.55.0.rc0.96.gc050c23164

