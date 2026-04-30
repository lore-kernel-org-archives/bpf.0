Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3541136495B
	for <bpf@vger.kernel.org>; Thu, 30 Apr 2026 18:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777574652; cv=none; b=dc1HDlI08roXiN+0lACB1qqCxGI+w2FiMRQNH5ZiV8GydECJifJR4zpzv9H6MmSL65JY9/YOiJRf4JM4IVNG4uhs6PbgHkmd2zhWJTvTna8dLZYAOGATIUBEDwVxJAVFqxHgLNdTrc5HmxP+f0kV5CcKiuAJt5FRkN8m3juAgSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777574652; c=relaxed/simple;
	bh=/PRIKgLfKPj4zMKorNmQ1wB3iJTK0C/w2vdDIs7PKVk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=OCQql1Nar8IXWkqIp0ail2Y6HI65K/UCTdK4OwMnifZthmx3RXq4A+oflxPnXr/AzVFAkhwF9QD9e65WJqVXaTsj8GITnaKVMb0FOqhLzafD3fHDoQcNRpCgUscoBBAlrzBXSstFzQUm8SjBAGhQAWO7c6j7ZPmgBns2O2sGn+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=U92MX/DK; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U92MX/DK"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-35da86144daso1447343a91.3
        for <bpf@vger.kernel.org>; Thu, 30 Apr 2026 11:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777574648; x=1778179448; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YSFg1U9KtAY77SgXkcle8/Z1smWtplMzJzd6qV/sqH0=;
        b=U92MX/DKFZjA2U0RpyT4OPLiMTkZnNo6UpEezgKpey9pTj0Q6ivtJLxfqhduwFs3Ny
         zdlynOq/yrfN3Slp7bs7J9F3057oey3DXssKn7IGNYBKC0mH+esBQkJo0O2hSsmc0xcV
         31Q3zlAaNFrpDNzBH7KXlWIx4SmbIQ5FUBAF/1RckuG0AH5Y3XHINvc+243mCQTwerki
         /C6O+U642gbXOj/zjmFQPGQitgIhajw+S79pyTo4xJR3ZB2WZYa/PqvuzDCUt9RwqBYr
         Zt39kVRAmq+72WC2phGfNeAanb6UpAXDxBGBD2jo67as8eyiLnmeGVD5A7QBoz09OsrG
         0tcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777574648; x=1778179448;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YSFg1U9KtAY77SgXkcle8/Z1smWtplMzJzd6qV/sqH0=;
        b=VhjIpRwa2BYZr+TW8mw9wG9XhSdZfdWkzfN1xQKfcx/lDSGbRZdoOhsCAJVDbI1o3Y
         4OT/Y8/suqtv86oV/lJQsF9oGpH40tJEmRqLrIyfffsselUiyU7c+s566lJEtmxo1VnL
         n4XccM9G3vTXJEzOn4CFwNHY9DVaPihWQrajgx9WAcNKyrruSQFd/qldJC34Fh1o52VZ
         ZHGPtmX8wahKPJSLZSRPErzcniz99MJehx6xN0BFhcF0/HynOTUhQE1cqdruPsYHXQs1
         9ib+SjZLGsDrFSzHbOXWfyfxKKdsn1gMwIoAoT02q4/Bc9R157oYN4jdLijiGuBhTRX4
         o01w==
X-Forwarded-Encrypted: i=1; AFNElJ/rQ8u8Gf5f/KPS5p6hMTG02ZngZ1gwGmW4NS7ydJOZsDl/ee6iOuoDWnh/wG/CSUAXUUA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwC5fKeVFshO7jSkIMCBTUBhMrqHvBm3wbHdN2ejwcmeOaL1Wb
	a3IBCePlMMPnKAXQoxSbkzFnQfWruTgE2Gl8aRvpfKyuI8jy2lqu9t1LNF7Kl3oLyOajL6ODbge
	vW5JY6Q==
X-Received: from pgbq1.prod.google.com ([2002:a63:5c01:0:b0:c74:664d:4080])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:6a0a:b0:39f:aa3:5e56
 with SMTP id adf61e73a8af0-3a3cf5e8cd2mr5001483637.14.1777574648207; Thu, 30
 Apr 2026 11:44:08 -0700 (PDT)
Date: Thu, 30 Apr 2026 18:43:50 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260430184405.1227386-1-kuniyu@google.com>
Subject: [PATCH v1 bpf 0/2] bpf: tcp: Fix type confusion in bpf_tcp_sock().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Martin KaFai Lau <martin.lau@linux.dev>, Daniel Borkmann <daniel@iogearbox.net>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

bpf_tcp_sock() only check if sk->sk_protocol is IPPROTO_TCP,
but RAW socket can bypass it:

  socket(AF_INET, SOCK_RAW, IPPROTO_TCP)

Patch 1 fixes it and Patch 2 adds a test.


Kuniyuki Iwashima (2):
  bpf: tcp: Fix type confusion in bpf_tcp_sock().
  selftest: bpf: Add test for bpf_tcp_sock() and RAW socket.

 net/core/filter.c                               |  2 +-
 .../selftests/bpf/prog_tests/sockopt_sk.c       | 17 ++++++++++++++++-
 tools/testing/selftests/bpf/progs/sockopt_sk.c  | 16 ++++++++++++++++
 3 files changed, 33 insertions(+), 2 deletions(-)

-- 
2.54.0.545.g6539524ca2-goog

