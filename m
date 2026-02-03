Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F7E4364EA9
	for <bpf@vger.kernel.org>; Tue,  3 Feb 2026 21:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770154489; cv=none; b=e7+47Rvy4LWQoWcVBnCXvbiA5BAfk2KnJov7XA7PpYSt4LIkfwXG5MsK6fDOiD5bexVN3xFSTaTE/XW+DgEa7xtWP34zqjZZNEv+LQL82NZAWS7OekoTk6YLbyn4yP66/jP2OuhFBE2ffABMZPMTZ/8kM0bAKBRGHnrabksEEOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770154489; c=relaxed/simple;
	bh=VumRnA+ZNrdfwd1X60h4D5hY0PyUrhrl45NhcE9EIyY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dr1n4nutHaDG0JW73i7Im4h74DdtcOneupmmNYnI8J/hravShx/mQPO/33Yg32fzEYdNzj9wtZHwbBMvU0MX8Xx/2BG3RKB7MsnRCyDfcXdMnxPMlqertgdBtO/d/mYJZuR15zcNYjawiCCTN+Sbfj8Jd1t257NxGrEkdyeqPDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LiNmgZN5; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LiNmgZN5"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-34ec823527eso11191340a91.2
        for <bpf@vger.kernel.org>; Tue, 03 Feb 2026 13:34:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770154488; x=1770759288; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=gssihM+M8rtTCDNcGtVpYjE9CLkPBtCcmBA/WAyl/B4=;
        b=LiNmgZN5yrkdFHW3d0xRaUzXIuoQ5Jb/DdVc+9fGaRi0J6WFotpJD1e9k542z2lkEx
         vT4/obc4TTsLGGrQ3VoUoGaKDpRj2rUDFaW9FWg5yaf2W286AY8ILYqdLlCVANQU40G9
         nibkCQvqjlZgzYVCQkssWAxd54AqePetWopA9Y8l1BrYdMCcrxdvcxC2oQI6W/9n8HLW
         h/tJbNAI8j1SWiFOmI/cNzRckZqDV+mfNufFvzLjDpgK5fJCn7MN1LPhQwsc1ApOZnNx
         kyi4OCS42Ts+Rv64/+nz+Oe4CPLr8+u4zzekcuReViV0tVmcf6ZRqMCasGyxojGF1ly6
         wbCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770154488; x=1770759288;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gssihM+M8rtTCDNcGtVpYjE9CLkPBtCcmBA/WAyl/B4=;
        b=cFuRRd/2si8Capl6XytnGacTYM92fYu+8f7yan0JnQ4jM6gtztLGGWHetFyP1MzIrf
         evtin6DkqxSVSGyJmcS4ConEVTO4FrUY3kSBG7nBBqianG55CTUY7kQgMa4T2UFKKwFG
         kFaX3VLMH+uUoqCi3hyxWiVzSHz6tVJkL2n7+cozh9z3VG7/mHdnzUHcS0Q1HtF8PZ6t
         txEtkCgDDRBKvUZIO//FHNDBJMmhDtVn+o07WSaR4QDQk+bJjtPr72OZH7A26eCR2xAS
         RZ0rlR3rcXKxFYGgPiJSYzOJ+A6aGxBxi3MUM74aqrsU5fdLLNZKnR2xGeJhqyI5fXhl
         xItw==
X-Forwarded-Encrypted: i=1; AJvYcCUthEn0jIRqDrdd2zjdMlyYm6gv1JPlehU+FCICiB3nRAEUxF2Ne2PvTsJHxoxab1R5aqE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1FHjIyy25khr3L+hwLhn9/uLaEROJtVXbhhPscSiUUxX4UhMV
	BVV+yB0P5jScTg/uUvZsj92eBJ1dWU8JcrxWV1KnAgcVc+BhVhtvOGC1EqIAdAzPFgyEcKWWK3Z
	kb2gD8A==
X-Received: from pjuj14.prod.google.com ([2002:a17:90a:d00e:b0:34a:b8e4:f1b9])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5808:b0:34f:62e7:4cf3
 with SMTP id 98e67ed59e1d1-354870d71d3mr655645a91.10.1770154487914; Tue, 03
 Feb 2026 13:34:47 -0800 (PST)
Date: Tue,  3 Feb 2026 21:30:07 +0000
In-Reply-To: <20260203213442.682838-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260203213442.682838-1-kuniyu@google.com>
X-Mailer: git-send-email 2.53.0.rc2.204.g2597b5adb4-goog
Message-ID: <20260203213442.682838-3-kuniyu@google.com>
Subject: [PATCH v1 bpf-next 2/2] bpf: Don't check sk_fullsock() in bpf_skc_to_unix_sock().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Martin KaFai Lau <martin.lau@linux.dev>, Daniel Borkmann <daniel@iogearbox.net>
Cc: Kuniyuki Iwashima <kuniyu@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

AF_UNIX does not use TCP_NEW_SYN_RECV nor TCP_TIME_WAIT and
checking sk->sk_family is sufficient.

Let's remove sk_fullsock() and use sk_is_unix() in
bpf_skc_to_unix_sock().

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/core/filter.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index f04982d79d72..90bfe5a6c1db 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -12021,7 +12021,7 @@ BPF_CALL_1(bpf_skc_to_unix_sock, struct sock *, sk)
 	 * trigger an explicit type generation here.
 	 */
 	BTF_TYPE_EMIT(struct unix_sock);
-	if (sk && sk_fullsock(sk) && sk->sk_family == AF_UNIX)
+	if (sk && sk_is_unix(sk))
 		return (unsigned long)sk;
 
 	return (unsigned long)NULL;
-- 
2.53.0.rc2.204.g2597b5adb4-goog

