Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795206823;
	b=IfEN2IiFH9Y2ugELIRCOjOt0FBBxpYc85ysRqNwJxl1m92+igmj1DHdrJ+Q3xG9mtlkl
	 XVsfD7hAfFQpdbw6KKC2RTq/4fnOZbB+QPPGO+v7/be3TjV/inCjFcsVQbY6D8zk0slFA
	 UXaaJENOYYKS9kZ82ioCTOv+hm9dA2mvlWq5XI3dEmSDwCCisseISkIa/RLnjH5Kgccd+
	 HH7uPuxJ62J3H8ca0J82sD1e/HvUGGwIVg3uiGkP6S6BmYeMgKEubHnF0Q/0Zg7p3zjkz
	 Wc4BPc/CXuqvYkiaOuFP8uPxPa3vpdU6AMmA69X5taR8Jjfa6c76CMzwBuRKBjG4H+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795206823;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=nAfODRjsLIAeLMWeavhb8K8jBx8m4UlItOf7jPRMbxU=;
	b=bjMBIrSgknZaiBnrxYMeOsRlQJe1lZpkgd/cZQY4gZFILwvVqxkt82nQkV3EYXfVRS5Y
	 QU1I4XGaLxlPPNhLqO1vugOZk2QUli9GHkYItzW445Ab9i/+WCht5apWerGrs57GyIUUz
	 lVKwvIe9xEAbX8NJby0yZ4Svb3b9F+kdTNw/E3KLd6fhLvF3dJwyz1atQTIpFDr7mXmzU
	 BZOKfG79M6c0r9ulCy2m9vD/r4m+zIFurQdhflzFR6kxYjqneEyEBwqTYoJG2tSaQrBpw
	 hSnQPc5cDW2vNCvVkV7UDh/xmhSV2XxOcGvUQfEe9Hvn3bJm/F764LBzNxZeyVI5Kow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TrCTFleA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3004606A6CB;
	Fri, 20 Nov 2026 20:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TrCTFleA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B66241F000EB;
	Fri, 20 Nov 2026 20:33:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795206823;
	bh=nAfODRjsLIAeLMWeavhb8K8jBx8m4UlItOf7jPRMbxU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=TrCTFleA4zQKtzI+j2l6PL/Au4hvUYDO3rYOgXsDGDekrinpm+ciHXipi8loBM/E9
	 HpUjpPhDV11sHRaqpAQK3QYKNzC75FZOicyY7BnSiJ+2DXDuFNLVt2xP4b41G1ESgn
	 AWrJojeuFmlNQdkZ6CZQF03OaS+qeqLjuuT1QRqK/GLIymLE/lfttJ4wqoqkatp7qM
	 MFX18OeREqVYVcqp+uIpg++JzYxm0OcGxYUVoym9ZB4NcAch10ygQw+bAn0lsmL/VP
	 JrXVLQJwdTxypvjkZosMsfUAxqpGFqlDrDfO2UY490O7+yflE2tQOfLiS2tc3/Rr/X
	 DwQQ4qeYb/Vyw==
From: Tamir Duberstein <tamird@kernel.org>
Date: Fri, 20 Nov 2026 15:33:15 -0500
Subject: [PATCH bpf-next v3 2/8] libbpf: ringbuf: Use compiler atomics
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261120-bpf-ringbuf-fixes-v3-2-ff7ca15d6c37@kernel.org>
References: <20261120-bpf-ringbuf-fixes-v3-0-ff7ca15d6c37@kernel.org>
In-Reply-To: <20261120-bpf-ringbuf-fixes-v3-0-ff7ca15d6c37@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, Shuah Khan <shuah@kernel.org>, 
 Andrea Righi <arighi@nvidia.com>, Xu Kuohai <xukuohai@huawei.com>, 
 Andrea Righi <andrea.righi@canonical.com>, 
 Bing-Jhong Billy Jheng <billy@starlabs.sg>, 
 David Vernet <void@manifault.com>, Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Andrew Werner <awerner32@gmail.com>, 
 Zvi Effron <zeffron@riotgames.com>, Andrii Nakryiko <andriin@fb.com>, 
 Tamir Duberstein <tamird@kernel.org>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2695; i=tamird@kernel.org;
 h=from:subject:message-id; bh=tiJWSCTQrAnzCESoEaoBUS9OAytDFBLTgPyN5niMMSk=;
 b=owGbwMvMwCV2wYdPVfy60HTG02pJDNkM62Zy6f2JqkmTzX9W/mPdh+oLavVvZFuiVkXNm7Z49
 s+zv9c/65jIwiDGxWAppsiSKHpob3rq7T2yme+Ow8xhZQIZIi3SwAAELAx8uYl5pUY6Rnqm2oZ6
 hkY6BjrGDFycAjDVzmcZGXoTXSb+sXUN3HPI58R+MaWHv/Jd5k/+brgw/VLXNanb36QY/oq/M11
 npPu+7NWka7W7WVxW+K3YZFd2vDF+we7VE4wKGzgB
X-Developer-Key: i=tamird@kernel.org; a=openpgp;
 fpr=5A6714204D41EC844C50273C19D6FF6092365380

Consumer-side ring buffer code uses architecture-specific smp_* helpers
for shared memory accesses.

Use compiler atomics for shared-memory accesses so the wakeup protocol
can use portable compiler fences with the same atomic interface. Acquire
and release ordering is unchanged.

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
Signed-off-by: Tamir Duberstein <tamird@kernel.org>
---
 tools/lib/bpf/ringbuf.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/tools/lib/bpf/ringbuf.c b/tools/lib/bpf/ringbuf.c
index 78fcb3df243f..db67eb98f3e0 100644
--- a/tools/lib/bpf/ringbuf.c
+++ b/tools/lib/bpf/ringbuf.c
@@ -270,13 +270,13 @@ static int64_t ringbuf_process_ring(struct ring *r, size_t n)
 	if (n == 0)
 		return 0;
 
-	cons_pos = smp_load_acquire(r->consumer_pos);
+	cons_pos = __atomic_load_n(r->consumer_pos, __ATOMIC_ACQUIRE);
 	do {
 		got_new_data = false;
-		prod_pos = smp_load_acquire(r->producer_pos);
+		prod_pos = __atomic_load_n(r->producer_pos, __ATOMIC_ACQUIRE);
 		while (prod_pos - cons_pos > 0) {
 			len_ptr = r->data + (cons_pos & r->mask);
-			len = smp_load_acquire(len_ptr);
+			len = __atomic_load_n(len_ptr, __ATOMIC_ACQUIRE);
 
 			/* sample not committed yet, bail out for now */
 			if (len & BPF_RINGBUF_BUSY_BIT)
@@ -290,14 +290,13 @@ static int64_t ringbuf_process_ring(struct ring *r, size_t n)
 				err = r->sample_cb(r->ctx, sample, len);
 				if (err < 0) {
 					/* update consumer pos and bail out */
-					smp_store_release(r->consumer_pos,
-							  cons_pos);
+					__atomic_store_n(r->consumer_pos, cons_pos, __ATOMIC_RELEASE);
 					return err;
 				}
 				cnt++;
 			}
 
-			smp_store_release(r->consumer_pos, cons_pos);
+			__atomic_store_n(r->consumer_pos, cons_pos, __ATOMIC_RELEASE);
 
 			if (cnt >= n)
 				goto done;
@@ -412,8 +411,8 @@ struct ring *ring_buffer__ring(struct ring_buffer *rb, unsigned int idx)
 
 unsigned long ring__consumer_pos(const struct ring *r)
 {
-	/* Synchronizes with smp_store_release() in ringbuf_process_ring(). */
-	return smp_load_acquire(r->consumer_pos);
+	/* Synchronizes with the release store in ringbuf_process_ring(). */
+	return __atomic_load_n(r->consumer_pos, __ATOMIC_ACQUIRE);
 }
 
 unsigned long ring__producer_pos(const struct ring *r)
@@ -421,7 +420,7 @@ unsigned long ring__producer_pos(const struct ring *r)
 	/* Synchronizes with smp_store_release() in __bpf_ringbuf_reserve() in
 	 * the kernel.
 	 */
-	return smp_load_acquire(r->producer_pos);
+	return __atomic_load_n(r->producer_pos, __ATOMIC_ACQUIRE);
 }
 
 size_t ring__avail_data_size(const struct ring *r)

-- 
2.56.1

