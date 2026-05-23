Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8955035AC3E
	for <bpf@vger.kernel.org>; Sat, 23 May 2026 08:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779525015; cv=none; b=gO4jvCeiKdWbvKX2BeKDx4EKj2L5fGIsISYjRNE4LivbcTL65E3UFt0W/QobImQKRDYQYMqOijP2fI971bfzzPeKV/oAeVZRV3ulZm3qS6G2GLWwdPpCoJDrBPNX1r4wBsWvWqDTM4+Ev61KLIQtFRg75Y9byvho+pAdVY07G7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779525015; c=relaxed/simple;
	bh=LQDpdnjoLZYsNy6KOVpx5tVW1GPtQFRAAgqYXGZAff4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jBB3zQj27Q3ICKjHfvPrL7JQOCqNC2MXVEXb4pH/MCxfY+5dU17/p6jUQGYo5uhNg3rJrJPxJGRk0kkxq7emSw4wVZsewOlnzZ/mUtBxD3ySurgmwWaB9BsBvJyxjRn2nxOkFoYrqZ5hAk8TvqgCGjmoqSXPaRB2E6h5uoh6KQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=c7MsV/0r; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="c7MsV/0r"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2bd04e4fe3dso150971565ad.3
        for <bpf@vger.kernel.org>; Sat, 23 May 2026 01:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779525011; x=1780129811; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=YvNz1WBZQHLaTYhJaNJh4Rde3P3k0f6Og7tKddJIGXk=;
        b=c7MsV/0rmOV4ClcHRM/rwbSbPt/STXIHJiYLoj8IdNh4Z7Do9lDScjkaK19ngrFnw7
         Dx7d5yatbYMo63/4IXDPoHUF0F49EaKDQhOgom4ZtWXEahCadKl5BLmIm/zTr5IchSlh
         gG+c9l9fnhwdHOUujI58CCt7mtVjIssoCxq3+AmsDnu/48JFiwET4q1vkIqysJHkDnmX
         QU9hDRQCmw/cbYOCgsZkAR7RxQUS6PoGGs8NxcDwM79B9q/F2/uEm91e8PqxxgnK+xaO
         RNvO9E7OmNdClVaHsCAIYMeSMMiuTA7oXfdBczdxTSGZgQAKg4x8WpwIpWitcBJEVp6i
         ZL2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779525011; x=1780129811;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YvNz1WBZQHLaTYhJaNJh4Rde3P3k0f6Og7tKddJIGXk=;
        b=KCfq9pzrwaKkPUvtN6KxyHb1Z4dTTOs9uWrfgSLKgBGZDCBeBlFTTj2HbTyU0dO2cO
         FXqH0pFNIXUfrLJFaguy0A1xvgSiO2ZwJcEUB7rV+j4FDeNYKcyMdEsN0H2tO/m1fMMd
         C3YLBngUl92VBJAPeZ2QQdOEJy6ygdDJF+M4u06yRQBFZQpXtZIhORg1xe2REkmj+Q4V
         BHs5dq78gbvQ6T3tj0g83k+186jDuVEjhrQPaGx3N7IqKJlstG6lqulgbh5vCVUdLxoo
         B3eRNiLGX7Yi9dDBnYmIjiTBptsSrTj+Rktr8x1usFmWJ+3hNPI862OwbB9jIFwWJb3i
         3HaA==
X-Forwarded-Encrypted: i=1; AFNElJ+eNblRqmiXNzt72XkFApUH5qCqldNCfeHfCaLmpS9T4D49NvsFg9106m6+pXiuPP4fAMs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpWmo+w+aEY/JM2+kUER0yz1as/j6vzq9orPIvRP6L2QuJviFX
	kFcxxNqtNHzyCIAqYYahAj6PxWcLUdy5w1R2QHY025YIGMLY1xzjwQzBhicwyI46304/urzEXfb
	SkaIjHA==
X-Received: from plsq6.prod.google.com ([2002:a17:902:bd86:b0:2bd:34d1:ea8])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1a2b:b0:2bd:ef12:14d6
 with SMTP id d9443c01a7336-2beb06cfc33mr77317705ad.34.1779525010724; Sat, 23
 May 2026 01:30:10 -0700 (PDT)
Date: Sat, 23 May 2026 08:29:37 +0000
In-Reply-To: <20260523083001.2911931-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260523083001.2911931-1-kuniyu@google.com>
X-Mailer: git-send-email 2.54.0.746.g67dd491aae-goog
Message-ID: <20260523083001.2911931-9-kuniyu@google.com>
Subject: [PATCH v3 bpf-next 08/11] bpf: tcp: Reject BPF_SOCK_OPS_RCVQ_CB if
 receive queue is not empty.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Eric Dumazet <edumazet@google.com>, 
	Neal Cardwell <ncardwell@google.com>, Willem de Bruijn <willemb@google.com>, 
	Tenzin Ukyab <ukyab@berkeley.edu>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Unlike SOCKMAP, BPF_SOCK_OPS_RCVQ_CB does not iterate existing
skbs in the receive queue when it is enabled for the first time.

In practical production use cases, this behavior is usually not
a problem.

We can safely assume that the upper-layer protocol is designed
with specific synchronisation points where the connection is
temporarily quiet.

At these points, the application can completely drain the receive
queue and safely enable BPF_SOCK_OPS_RCVQ_CB while no skbs are
pending.

A prime example is an application transitioning from HTTP to an
RPC protocol:

     Client                                Server
       |                                     |
       | --- HTTP Upgrade request ---------> |
       |                                     | [Drain all skbs]
       |                                     | [Enable BPF_SOCK_OPS_RCVQ_CB]
       | <-- HTTP 200/Switching protocol --- |
       |                                     |
       | --- RPC Frame 1 ------------------> |

However, to strictly prevent any potential race conditions arising
from unconventional upper-layer protocol designs, let's explicitly
signal a failure if BPF_SOCK_OPS_RCVQ_CB is enabled while the receive
queue is not empty.

-EUCLEAN is chosen to indicate that the caller needs to clean up
the receive queue before enabling the feature.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/core/filter.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/core/filter.c b/net/core/filter.c
index 82ec2291d6f0..4041b9fc1c74 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -5390,6 +5390,9 @@ static int __bpf_sock_ops_cb_flags_set(struct sock *sk, int val)
 		return 0;
 	}
 
+	if (!skb_queue_empty(&sk->sk_receive_queue))
+		return -EUCLEAN;
+
 	if (unlikely(sk_is_mptcp(sk)))
 		return -EOPNOTSUPP;
 
-- 
2.54.0.746.g67dd491aae-goog

