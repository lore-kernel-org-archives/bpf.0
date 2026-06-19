Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3197617A305;
	Fri, 19 Jun 2026 00:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781828847; cv=none; b=VN8y2V3Fi5Ngiw3Sg2SKAeq4+4mjl6cNfXFtv33xNcA+HF+/i8zjrS5kSemWf9/ciJlxy2ZSwqsYKi+fuANKx0rCw2ssxGQZpFq7t1Bu70KUSh+hYam1mUbkX7MuRSAE5mjPEsaqLiSXRVi2yJksNG7fx45yBckCY238QSl+QIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781828847; c=relaxed/simple;
	bh=N5XifisHN3nS4YI7Gx7dcpOUkKbPumxrjtJXP2wrHOg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dEOQE0OhIK0aloo6rEGLm3Skod/PphYx/VJOIcC3RWzjhB0HEjLGJxKvrgHqqY0mmufWJYGL/7wtkJlLOIyaiLN/aB6G5tbkHo+y2vgVcYIF3r+Vua0Ycy9HnqA+W70gdDrF8Oxn+sXSeXDYh6YeCsdV34ba9BTK4wQg/rw3hXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iRCVgr3l; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iRCVgr3l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96DA41F00A3A;
	Fri, 19 Jun 2026 00:27:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781828846;
	bh=CL2kfO0YaZ3LrY3n9ruy4IxSrOCHi1fzSmxILQP3SrA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=iRCVgr3lMRuuvoUo721gmryrkp6A6GSkYd5GF2XwJQjYJ53XYw+LvoEnEqVyooXb/
	 4Gu9Zjt2sCEov52vuHtp/HqOnL7tJDNkl9D7/cJoKn3fwWKBsnT6jUw/bdSPWHb9sA
	 IgmofFkGeatJmOkOwmI0v1pZhJVBEnqGKE1AwWtD29VV78AJRkHAb71aTdI88oKUJh
	 v8yCAAJOgYgScc3rWRoMiRX5c63FXI/PL4Fd9c8DhLikiOjO6mBtp5hAavokwqwCS0
	 DBUBBjwW+MDVRuahChf/z7RuftbcD0cjHhet3rc6CQco/155EbyoxIhfmop9pGjUGc
	 Iv5H+XoDKNymA==
From: Tamir Duberstein <tamird@kernel.org>
Date: Thu, 18 Jun 2026 20:26:45 -0400
Subject: [PATCH bpf v2 7/8] libbpf: ringbuf: Use compiler atomics
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260618-bpf-ringbuf-fixes-v2-7-33fde039ddf3@kernel.org>
References: <20260618-bpf-ringbuf-fixes-v2-0-33fde039ddf3@kernel.org>
In-Reply-To: <20260618-bpf-ringbuf-fixes-v2-0-33fde039ddf3@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Shuah Khan <shuah@kernel.org>, Andrea Righi <arighi@nvidia.com>, 
 Xu Kuohai <xukuohai@huawei.com>, Andrea Righi <andrea.righi@canonical.com>, 
 Bing-Jhong Billy Jheng <billy@starlabs.sg>, 
 David Vernet <void@manifault.com>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Andrew Werner <awerner32@gmail.com>, 
 Zvi Effron <zeffron@riotgames.com>, Andrii Nakryiko <andriin@fb.com>, 
 Emil Tsalapatis <emil@etsalapatis.com>, 
 Tamir Duberstein <tamird@kernel.org>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2897; i=tamird@kernel.org;
 h=from:subject:message-id; bh=N5XifisHN3nS4YI7Gx7dcpOUkKbPumxrjtJXP2wrHOg=;
 b=owGbwMvMwCV2wYdPVfy60HTG02pJDFkmPTc+cp69K37v/pSbL+y1WHnnze1MbO7Q+95QpfFXW
 JRz/Z8tHRNZGMS4GCzFFFkSRQ/tTU+9vUc2891xmDmsTCBDpEUaGICAhYEvNzGv1EjHSM9U21DP
 0EjHQMeYgYtTAKZaK4KRYZYQ21PfD8kPgzvYZ1mmF6yd/OBC0a2/Trm8p/pvnbs+3Yjhn0ZTYv7
 +0q9zE4p39+66snTD5kBF3mm7AnzuGgWHv1bs5QIA
X-Developer-Key: i=tamird@kernel.org; a=openpgp;
 fpr=5A6714204D41EC844C50273C19D6FF6092365380

Consumer-side ring buffer code uses architecture-specific smp_* helpers
for shared memory accesses.

Use compiler atomics instead. They provide equivalent acquire and
release ordering through a portable userspace interface and allow the
next commit to use compiler fences in the wakeup protocol without mixing
atomic interfaces.

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
Assisted-by: Codex:gpt-5.5
Signed-off-by: Tamir Duberstein <tamird@kernel.org>
---
 tools/lib/bpf/ringbuf.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/tools/lib/bpf/ringbuf.c b/tools/lib/bpf/ringbuf.c
index 1c5bce2b5e12..141f2cbe56eb 100644
--- a/tools/lib/bpf/ringbuf.c
+++ b/tools/lib/bpf/ringbuf.c
@@ -270,14 +270,14 @@ static int64_t ringbuf_process_ring(struct ring *r, size_t n)
 	if (n == 0)
 		return 0;
 
-	cons_pos = smp_load_acquire(r->consumer_pos);
+	cons_pos = __atomic_load_n(r->consumer_pos, __ATOMIC_ACQUIRE);
 	do {
 		got_new_data = false;
-		prod_pos = smp_load_acquire(r->producer_pos);
+		prod_pos = __atomic_load_n(r->producer_pos, __ATOMIC_ACQUIRE);
 		/* Positions wrap; the consumer cannot logically pass the producer. */
 		while (cons_pos != prod_pos) {
 			len_ptr = r->data + (cons_pos & r->mask);
-			len = smp_load_acquire(len_ptr);
+			len = __atomic_load_n(len_ptr, __ATOMIC_ACQUIRE);
 
 			/* sample not committed yet, bail out for now */
 			if (len & BPF_RINGBUF_BUSY_BIT)
@@ -291,14 +291,16 @@ static int64_t ringbuf_process_ring(struct ring *r, size_t n)
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
@@ -413,8 +415,8 @@ struct ring *ring_buffer__ring(struct ring_buffer *rb, unsigned int idx)
 
 unsigned long ring__consumer_pos(const struct ring *r)
 {
-	/* Synchronizes with smp_store_release() in ringbuf_process_ring(). */
-	return smp_load_acquire(r->consumer_pos);
+	/* Synchronizes with the release store in ringbuf_process_ring(). */
+	return __atomic_load_n(r->consumer_pos, __ATOMIC_ACQUIRE);
 }
 
 unsigned long ring__producer_pos(const struct ring *r)
@@ -422,7 +424,7 @@ unsigned long ring__producer_pos(const struct ring *r)
 	/* Synchronizes with smp_store_release() in __bpf_ringbuf_reserve() in
 	 * the kernel.
 	 */
-	return smp_load_acquire(r->producer_pos);
+	return __atomic_load_n(r->producer_pos, __ATOMIC_ACQUIRE);
 }
 
 size_t ring__avail_data_size(const struct ring *r)

-- 
2.55.0.rc0.159.gbe5d7338c2

