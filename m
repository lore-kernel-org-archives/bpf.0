Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03008304BB2
	for <bpf@vger.kernel.org>; Sun, 15 Feb 2026 20:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771188241; cv=none; b=LvAhwTysOMISlFpVDLdttssSPrOM+W02xJRAQ4Lb4ZM0Dkmxl6qcHrEQHfXm7kNh/S4Udw3gighHTbm5MBXSmu0nn0SJAPDszSKNYTv9g1p5xpaI3AJvZ5V2ei1I+OdCgf3h60+gtkbvXjyLjIcKn6LGt9JWIgPKCNlsg6/G2Ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771188241; c=relaxed/simple;
	bh=j6HlvglSK/TSepIs8gUhrttyCe5YByeMo6FOdqtnSWs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ffbAXiZf7mbNV2M3Ja6HSfy3o82VeUwwgko7CAabBbExdWcz8DHZslY/22VQ/8dyg6Zd2olzdqprOuyA3+jAJMWFV3M6segZx2qLf7ptWX+KNh7+ue+za7xgI9ZCZj6jSyW3b3iIyV/JAfIG1gERd7miueSKn4Yghgb2vvFcx28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NmgH5gZT; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NmgH5gZT"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-354c65f69edso2835237a91.0
        for <bpf@vger.kernel.org>; Sun, 15 Feb 2026 12:43:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771188239; x=1771793039; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3hFapZBeUENdF611STozZJXhlIrkmUJy1sWUR+b5QcI=;
        b=NmgH5gZTjlcH8InLkr7nd8byOkj8rrwNHL60dqVd/mYnkOY7I7O65ExyErbwMwT+5U
         zwIAIUHJpzA+2eQhbyiybpcaVB1+mTF/edowVqQmJTNp9fWXalEsmMn5fnZS5p4TpEK0
         Qs3fqxx9RjZv2jsEIXAlGtnhR5bbHEjWDuB19hOmAV7nhqvptprWxXNW0G6hxd+1k51R
         ORrMar186YDlkH+DKcVzyARUnGf28JTNmG4OQJN5FL67n2FGkECD8kpKUBjTwrMQE5QY
         gVmgy7gWCIVlKhdTkV/2Smd4YbsXWxovKWmlF4CEN2sElWw1hk2+QnBw+lGgDqHt+WKx
         pkQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771188239; x=1771793039;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3hFapZBeUENdF611STozZJXhlIrkmUJy1sWUR+b5QcI=;
        b=JE/ni2LQig4ghLj9CCpY3Pbx903tyhfQUQbT6ZOtZXNK8Gv36KzquGilODNRNOCMIz
         GxkPRJ38UJ4p5p2uOfJCxULLfctPAZST2z0pJzcZ4CXDawdAF6O4sDTrkHYjEXHiKuo/
         yyx+tketmDNhMvYaW/Ik3fiuQFuFmDj//ppWaYvpATvUxgJlRkfrS6YQSvqDoUyB5B89
         7EjS2jBakFH47sOVXatwVtcT0/PnCv/MGobHgOPmYYcnXd/MT8FlhjcDB0TfIB/Muldp
         iz67fDbAZ5q41VQn/SrD5Yec2BqrM/fVAIjiLJacE5ZJdK1C/BPKqMRnu7nrABBS3v6m
         5YQQ==
X-Forwarded-Encrypted: i=1; AJvYcCUduKd9N2A6I7P/+xsdrgUKhmkcDflzCfkP6F6k63PMka83ZJ7fx5BQKwIWOWe5GabYSQ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdjEViPUSD2KFY4lZ5KtDeHK7HKHVQrv+ydFxPej36z6hN5mUX
	Rr6rDT+6oEUU/JC5+huvRErd0H+r/05XoAkztnEsGXoyV0OXnluUBtzCji3YonDjgEcanv7I8L+
	HzV53IQ==
X-Received: from pjbgl20.prod.google.com ([2002:a17:90b:1214:b0:354:c7ac:b03b])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4f8e:b0:343:7714:4caa
 with SMTP id 98e67ed59e1d1-356aaa98c0emr6167202a91.3.1771188239220; Sun, 15
 Feb 2026 12:43:59 -0800 (PST)
Date: Sun, 15 Feb 2026 20:41:37 +0000
In-Reply-To: <20260215204353.3645744-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260215204353.3645744-1-kuniyu@google.com>
X-Mailer: git-send-email 2.53.0.310.g728cabbaf7-goog
Message-ID: <20260215204353.3645744-3-kuniyu@google.com>
Subject: [PATCH v1 bpf/net 2/6] sockmap: Annotate sk->sk_write_space() for UDP.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: John Fastabend <john.fastabend@gmail.com>, Jakub Sitnicki <jakub@cloudflare.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Cong Wang <cong.wang@bytedance.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

UDP TX skb->destructor() is sock_wfree(), and UDP only
holds lock_sock() for UDP_CORK / MSG_MORE sendmsg().

Otherwise, sk->sk_write_space() is read locklessly.

Let's use WRITE_ONCE() and READ_ONCE() for sk->sk_write_space().

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/core/skmsg.c | 2 +-
 net/core/sock.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/core/skmsg.c b/net/core/skmsg.c
index 75fa94217e1e..3d7eb2f4ac98 100644
--- a/net/core/skmsg.c
+++ b/net/core/skmsg.c
@@ -1297,7 +1297,7 @@ void sk_psock_start_verdict(struct sock *sk, struct sk_psock *psock)
 
 	psock->saved_data_ready = sk->sk_data_ready;
 	WRITE_ONCE(sk->sk_data_ready, sk_psock_verdict_data_ready);
-	sk->sk_write_space = sk_psock_write_space;
+	WRITE_ONCE(sk->sk_write_space, sk_psock_write_space);
 }
 
 void sk_psock_stop_verdict(struct sock *sk, struct sk_psock *psock)
diff --git a/net/core/sock.c b/net/core/sock.c
index 693e6d80f501..d828f91be4e9 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -2690,7 +2690,7 @@ void sock_wfree(struct sk_buff *skb)
 		 * after sk_write_space() call
 		 */
 		WARN_ON(refcount_sub_and_test(len - 1, &sk->sk_wmem_alloc));
-		sk->sk_write_space(sk);
+		READ_ONCE(sk->sk_write_space)(sk);
 		len = 1;
 	}
 	/*
-- 
2.53.0.310.g728cabbaf7-goog

