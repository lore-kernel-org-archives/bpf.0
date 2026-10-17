Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2244C36F91F
	for <bpf@vger.kernel.org>; Sat, 17 Oct 2026 01:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792201156; cv=none; b=g4W6VNcJoKhr6HyxWGXz9KXgE4s1a2eXaJ/FnXmgsiEbApHI0vRExQTyzgYSCANa2VZvpCSgTNLdAY+LxsdXrRmd6zpHIKHk3SLPQdvTgKxxvuINqHxZxF5fSyh+fzIjXC6ttNmCQyafB8E8Qj5mEh+bnFm5Z2fnsPbxoc8NKnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792201156; c=relaxed/simple;
	bh=I37pMbBMK09fuZLQxk+ge/8C15QqmUXK4gTQH+hCLlA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LeUw9qe77i7HJhOWiW199fWGjsffLl4GyeAE+gtjSnALoVw6CKrIm7uaTzaCzvOnJk7FlH9YvR+TaJCE4Rd+GqiYwLZwk3H/ti2sBAdrBn2k5XSEJc4df+rMRPSrnQTK0fL6+l87XXy+kX2EfJAUz0/wOnJNJBdjwxdZEYVqNk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HPLmUEPz; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HPLmUEPz"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3ac677668a9so406025a91.2
        for <bpf@vger.kernel.org>; Fri, 16 Oct 2026 18:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792201154; x=1792805954; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=+u3iWGfpZx0OzA6csEp3TZcwFGh8ku/nVnLWwC25+E4=;
        b=HPLmUEPzOzwh3aRIYVmr8fnzqMMuoeKHq2kGW7mopaYWdHqXNiHnxi+3lViuwpxBuP
         xXvlFsnv2MirfLzUgNH2AmI9Kh9lo1T5naqsBYryhiw2KKuvj6QPnD2Fd/HF0HabPmi3
         geCh36Kt5/iNyC58+owV751atYOtZyfoZ6hkzy047Ai+FkVWNAKX2UUeKTKBnmAZSbbp
         A9K5N3ltnUvjXMim+Ow1hbQtFT20is2/TUPEu/vqkrurNSzMJf5ne8phQsCqZxsk1sdG
         m+4Ij7ouQxMBfgm1o0vIfEsrmWu6v3kftMANH/BjZqwZ0v0qnILmasRYDCTsizB9837o
         CfFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792201154; x=1792805954;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+u3iWGfpZx0OzA6csEp3TZcwFGh8ku/nVnLWwC25+E4=;
        b=InLwfF0YGsSuvkqDTiNmQAz08hSESA6DOh1Y3CMoM2lxivxDp3v9EuB11z1gMPw8u1
         tb7MsuNhZHohbh1i+5RBeshq1vuq4etbsoqiJDAKAotDdrQgi4PsQMglaUXGoQeL3zJt
         0YGizVa+sSRwuxDVXLbbwMGCKmFJ3p87pQPzfqUgX1TlUMpjqf3QjrLsuBh4vR0N0cWu
         utacIpWNBINv9Trhu2MMm1xqUyCl0+frWd4EGBznFDmv3pqzit57vdb0jkB8+3HjYkiw
         3VZNyGTqPrJNnOahJqEUc9ywF6s30HIYdvkO9Y8taoTe3B74HZAQiGE9DnCGFa6TPWFI
         ZFuw==
X-Gm-Message-State: AFq9FYIZa3lCQKj8D6TxBuhmNbDzKJLTrhI4Tr5gQD0ewicN6ZcaawYg
	OEq3KnU7/eEyZ7Fe0DZJK3vsIhxnonqfVZViyId4544TgyaznbGGbb9N
X-Gm-Gg: AYBFou01lYiLEM2tyhxN3JrO//Qftmt+9fyjQ4zDgH0Rd1z6u6Q1l0JuwU5T2rKKvth
	eZlXCtfi3wQBykGRoYMw11szSzAFD6bbAVhhj8KGlcMaxQ/tMsyilWJV233f4uwIPj9UBZ4aOae
	LxUIScjfmDyv46nRGL2RWknDqtcQfwN8x1OfKdfvOj3kAEfc5ntDFtqBwWpGxuQdrNpKnHpwNRW
	lyN6myiDrglmOeHH1OfPsMQ59iS4Tx22UhltQV46UBNHQor9y/baSENKmQsTp1oOhWWwZYo6ozH
	OI7fXC9SQBBb1ZnrNlGNshQuL5iFCJpHXbChHcoM8MvAkjnYkVCbwM/wpOp/PHs93BXEFB8Gjlf
	PwyIMkAeeCAreCORV56xAt4CKuSLRAkn48BWjyretbxR/D6mL6p3eDfMZS9bJbLjAbAOvy9f6M+
	Djd4j1APeM8BYjybi0TgbrH3nu1KGMeYmWnINF5b7TQd0/tDskObdfi7iy7o9MGygtefAOgj/CF
	/akPKgTU+g3OoKmuUSVD83f4cLbV6KXc7VWgovS7oD5EYwiPht4JsO7GxpExTWZmcWY9/+MnYTX
	VnyjDEYVb1TG+J5N1hrom+fBQHLH79I0IzGEhsFR8Aw=
X-Received: by 2002:a17:90b:1f91:b0:3ac:b3e5:426c with SMTP id 98e67ed59e1d1-3acef10e078mr1178226a91.26.1792201154417;
        Fri, 16 Oct 2026 18:39:14 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.241])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd6549fb556sm1985639a12.22.2026.10.16.18.39.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 18:39:13 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	josef@toxicpanda.com,
	mason@kernel.org,
	steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au
Subject: [PATCH net] net: free the policies if a socket's clone fails late
Date: Sat, 17 Oct 2026 01:39:12 +0000
Message-ID: <20261017013912.396296-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Josef Bacik <josef@toxicpanda.com>

sk_clone() clones the IPsec policies of the parent and then its BPF socket
storage. If the latter fails, the new socket is freed with sk_destruct
cleared, as it is still a raw copy of the parent. No code which knows about
the policies of a socket gets to see it, and the two policies which have
just been cloned are lost. They also stay on the list of all policies of
the network namespace and in its count of socket policies.

bpf_sk_storage_clone() fails if memory is short, or if the storage doesn't
fit into net.core.optmem_max.

Free the policies before leaving. This can't be done for all users of the
label: if the socket filter could not be charged, sk_policy[] still holds
the pointers of the parent.

Fixes: 8f51dfc73bf1 ("bpf: support cloning sk storage on accept()")
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 net/core/sock.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/core/sock.c b/net/core/sock.c
index e8551df8330f..d311f56803ed 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -2577,8 +2577,10 @@ struct sock *sk_clone(const struct sock *sk, const gfp_t priority,
 		goto free;
 	}
 
-	if (bpf_sk_storage_clone(sk, newsk))
+	if (bpf_sk_storage_clone(sk, newsk)) {
+		xfrm_sk_free_policy(newsk);
 		goto free;
+	}
 
 	/* Clear sk_user_data if parent had the pointer tagged
 	 * as not suitable for copying when cloning.
-- 
2.55.0

