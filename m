Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FD0D3769FE
	for <bpf@vger.kernel.org>; Mon, 13 Jul 2026 23:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783985556; cv=none; b=HX/ZJ1iuUFytcqBoA4+PGvPE+qY9vcPxWa2gI/9MrGAGPlcJVqyojL142SnWlol0AYUms0WZJMMQmwKQGEl5pc23DgBXg18AB907hZg2yWg26Ewq/ppM9aKzvkkNqmq5tnAJIAO+KKuYkuOcL8iN0JPqTEZRucah2dZ3EyI8GQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783985556; c=relaxed/simple;
	bh=I8cVX0/mSzLFIdIg9RF+8d27raSzMYxFSQj1EqVpbcI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=N3GXS/l+ZURrXurjvIQ1koMzbnw0ijUk8yxUMPEt5wxtDT+SV2xQgpxVqexMInf4RdxigfeFj2qMhq2oYyVGipUy9PoHTeK1kUyKjelEzxznIR1uH/c4gCWMifZT5NPc04aCEXmn7akOi19bKEVJnWkpEDD/dLDEUAWGg8UZYw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=FH5Wd08z; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="FH5Wd08z"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-38dfe910e9dso1265314a91.3
        for <bpf@vger.kernel.org>; Mon, 13 Jul 2026 16:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1783985553; x=1784590353; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=qnqTky8wONGeiH1Gjpg0s2khivj3YtWdqTGDCWAoFvc=;
        b=FH5Wd08zO5yTrpsQlVjNAP2cU0nZJ7T2Brms80ecwbjWAhau+qKsDrWrcwyerI3sSB
         lp9fv932Z8xCOwKr+69IxAtHChcEw1O+1XXUVMYLVE3Jwo1+6oIGobP1zxNB+8UmNSIK
         wEUh60zXXY1N3jtqlX12CJL8E3LPvQGp1QL4uWIMUVbxGvy2Vv7yNRog/4o5kQLy1x6i
         2POgAgbXxE9/KABUybmpp4YOmjzm8smRz32i+q+UHY3IUmXJf9bvuZEbTsWqmlQQCYqa
         XbNta21lW8mKHG6X3aBWsttFU9WoANsjcH/zaGcd9O+T3TSD2IXrhd4yAoDeOsUfnhtN
         GL3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783985553; x=1784590353;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qnqTky8wONGeiH1Gjpg0s2khivj3YtWdqTGDCWAoFvc=;
        b=Y/nPyKDYQNqTm9YJfklU5/xIAo6743Dnaxi5PoaqGUJQPP1pUIDEbDP8Bc9+/W8KbC
         LmjLyiOPpQ3mMKRqq/smEfMkiEDZjMOe8XCuzU8qNEYL5USoM225lr6BP8X6wrf1/Zud
         L2w4bB7du65KraEeYHRNVDW96lQQCky77i9PtkPaNkms4uge2HWhyUtAtSFUwC1AlIhS
         ftba0Wvys+geNIMMSjQoM1DeG4IjX7EvsrIOgXXUfEjyOQ0ssmIeQ877NV6X2WMlRV/x
         DbcaqVaSP46KNj6es2sfH2LCUUZjRT/dNyrY9diS0yvayg91dLvnbMUJn9NsOMV8+HNb
         PURQ==
X-Forwarded-Encrypted: i=1; AHgh+RpKg7S9FPkcso48vxdBPGbBe/+yCobUcSEyCibDRIa6LErqHfZZ070qKsTrn8qDsoDJZ2Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsGNKfC1BPwipipKs+9/zoa+zhlQCo6gWu6Gx1dFUS8hgHkGkW
	3Ma4rfIg/IwYmf8Ay1bGsMQDGUFcKZrTT7LHWjGTUtPhZiD0jrA/mz/AWjh5mBXJVA==
X-Gm-Gg: AfdE7ckmnTKqwJfIIIGAOWNt8FUgJrDVCJW3K9pIDRPYqLmKO+Ppkz9B1G5M05JgTr/
	L4buQIpogRrkYA6lYSC3hwfVJoCk62eI4NN88ODjB26osJfH7iHKfwjP1m3zGrfTwd1eEof46oh
	R8tqd1pgEYrIyqHoMwN2iXKLqU+IIv4+sGNgUP74+P5DuAHlfj+wlijC+ah7LtGD5N4goE5vweA
	FI0ySI2N/xA4owZpt79zabXoKAAyawTy478nX7VRGOvUfTNamyS/7LyhrOOL/prxCJZFVoZ8DH7
	l0GxibTzwHqJLWxb2zxojFpQXAGITZ6ydtV91ubPZMMmd1Q4l2jBQ9hseihsFVa4mdDzoOAMl3u
	hv8mlw3UIy0OGo9QuItgLdrAyWG1Naj2HAbTiuO6XaO6lrYZfxDbO82wMxF90M4LEUEzzU6yOXM
	NFV5zigLHCL7ajLjeNiw==
X-Received: by 2002:a17:90a:ec8d:b0:380:9d0d:7ade with SMTP id 98e67ed59e1d1-38e17c7f921mr894108a91.0.1783985552902;
        Mon, 13 Jul 2026 16:32:32 -0700 (PDT)
Received: from xiang.tailc0aff1.ts.net ([20.171.14.70])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-311b00048a3sm44507367eec.5.2026.07.13.16.32.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 16:32:32 -0700 (PDT)
From: "Xiang Mei (Microsoft)" <xmei5@asu.edu>
To: Eric Dumazet <edumazet@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Jordan Rife <jordan@jrife.io>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	AutonomousCodeSecurity@microsoft.com,
	tgopinath@linux.microsoft.com,
	kys@microsoft.com,
	"Xiang Mei (Microsoft)" <xmei5@asu.edu>
Subject: [PATCH net] bpf: tcp: fix double sock release on batch realloc
Date: Mon, 13 Jul 2026 23:32:30 +0000
Message-ID: <20260713233230.3553593-1-xmei5@asu.edu>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bpf_iter_tcp_batch() releases the current batch via
bpf_iter_tcp_put_batch(), which drops the socket refs and rewrites
each slot with the socket cookie, then grows the batch. cur_sk/end_sk
are kept for bpf_iter_tcp_resume(), but on realloc failure the function
returns ERR_PTR() before resume runs, leaving cur_sk < end_sk over
slots that now hold cookies rather than sock pointers.
bpf_iter_tcp_seq_stop() then calls bpf_iter_tcp_put_batch() again and
dereferences a cookie as a struct sock.

Empty the batch on the failure path so stop() does not release it
again. The sockets were already freed by the first
bpf_iter_tcp_put_batch(), so nothing leaks, and a later read() rescans
the bucket from the start instead of skipping it. The sibling
GFP_NOWAIT failure path still holds real socket references and is left
for stop() to release.

  BUG: KASAN: null-ptr-deref in __sock_gen_cookie
  Read of size 8 at addr 0000000000000059 by task exploit
   ...
   __sock_gen_cookie (net/core/sock_diag.c:28)
   bpf_iter_tcp_put_batch (net/ipv4/tcp_ipv4.c:2918)
   bpf_iter_tcp_seq_stop (net/ipv4/tcp_ipv4.c:3270)
   bpf_seq_read (kernel/bpf/bpf_iter.c:205)
   vfs_read (fs/read_write.c:572)
   ksys_read (fs/read_write.c:716)
   do_syscall_64
   entry_SYSCALL_64_after_hwframe
  Kernel panic - not syncing: Fatal exception

Fixes: cdec67a489d4 ("bpf: tcp: Make sure iter->batch always contains a full bucket snapshot")
Reported-by: AutonomousCodeSecurity@microsoft.com
Signed-off-by: Xiang Mei (Microsoft) <xmei5@asu.edu>
---
 net/ipv4/tcp_ipv4.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 209ef7522508..dd3ed62704f9 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -3141,8 +3141,11 @@ static struct sock *bpf_iter_tcp_batch(struct seq_file *seq)
 	bpf_iter_tcp_put_batch(iter);
 	err = bpf_iter_tcp_realloc_batch(iter, expected * 3 / 2,
 					 GFP_USER);
-	if (err)
+	if (err) {
+		iter->cur_sk = 0;
+		iter->end_sk = 0;
 		return ERR_PTR(err);
+	}
 
 	sk = bpf_iter_tcp_resume(seq);
 	if (!sk)
-- 
2.43.0

