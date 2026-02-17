Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E129463
	for <bpf@vger.kernel.org>; Tue, 17 Feb 2026 00:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771286827; cv=none; b=Q3wjmZXtdDzcn8PffuzQYSlZxIyG810vFp/qLXH8nviJXC3wZZwGjF8kII+QE5Ooml8RZl8DuVI3AVrwaESyGi7QjgaStVW49WoBSCVtUtfgkqk0PDwO4tCQ/j74xTjJ/gtYlaYNwu+cFEo4b6Y7XC94kU9FE6LNwxNsikp7aWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771286827; c=relaxed/simple;
	bh=8pCxpRyqM45J4HG13TljFBU1L/g23s6hvGeHJ/EXEmE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=EOEyn5cZlzC51QYTzZ+22RwCsIiehn44NcIpkWSFFKeYQWum+5SnX0xWo+ZDtC3be+GZIPGHNNYo03owaFtMuzW92Sb+MwrcgRVLXik/j5tTR6C16N63+l2F7iNAhp4/NZNfFRZFHCTVf416gOGHZCHw5U8UA54UbtK+yCqdB/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=d91ndUML; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d91ndUML"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-354c44bf176so3461798a91.0
        for <bpf@vger.kernel.org>; Mon, 16 Feb 2026 16:07:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771286824; x=1771891624; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kHogz3X18n3wVg8pGsHsR4TK5Q9EDl5Af3JaeD24/1s=;
        b=d91ndUMLg5jN3VZ5OsOmeH5a+BVbZvuWxHAsb2smbPoXA0tDozCsKz7aKKGLtlr73d
         6rm8MhLVJ53m1D0ro0sWP/bPXphlxbTViwHlgm7e6rOz52LZ91w6flAEENBwyDYkg5ab
         5hsyhOuc+RVY0DOVFQE5t69VS9/iS4TInsH/Q2oBuXQTnUhPTlPV/Aw7T8c5WwFdLqup
         V+pgCGEemLDs6Ic44BuTzgxO4BMhJlW+OnaAsiir3I00RA9YxenvjJxCdy1ZaMk1+3st
         Mh2YCO1lX15EtCLIT5kAzrWeECQlGeiq/d4cN8g+BAc0kduNfr701SDPKKFvbaHEn7Zp
         fkBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771286824; x=1771891624;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kHogz3X18n3wVg8pGsHsR4TK5Q9EDl5Af3JaeD24/1s=;
        b=fXcAK2y4z2VQtX2MQ0hSYtx5EbetQDHJHWrp98HaQxIblhMOiisRwDlwG0zb1oWKBM
         hUexOIeP47BXOqJaH091whTDyHoawdFTnJjj0853tCkQNnBD8d8+ju1jOD3DA0JZf0Hb
         N5Z07Tt3iB0RaE01Dd0lVhJ1YuF2POS7w3LqvG4hVz9QgqQ7Lu5/DslIMJKK0A+ZPDx1
         Wq1Qh7Yn8mzVtGFH4frQfuw/zvzDvadm/05rpESTRyQm34qNhhJazHZ92Z9V+SF2fN35
         6ufa2DfFZFRJ7wQVnvz88y3h4Bf9O20DPbNppj8XSvr7yvwpaM960ww4SAG3KgadzI/X
         pOjg==
X-Forwarded-Encrypted: i=1; AJvYcCU9dW/HKzdZakS4zColjMLrsz0GNgON+cC3hYNJm3gZykUdt5g6slHIcfKBRWwmPCNSVMg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyptvdKApcPRlVSNCPQrB62QbytrkvZBMokun4Cg9j6nBjrYEvU
	fMu5bORKcbkOEvebvX5UNWfKuZj8oJviLlUGUP2WwRtIOtTFwWeuYQyUF+5iXYkE9bbS36qymJX
	qvAm1dA==
X-Received: from pjbpc11.prod.google.com ([2002:a17:90b:3b8b:b0:352:ed03:9879])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4b43:b0:340:b912:536
 with SMTP id 98e67ed59e1d1-35844fcc0ebmr7982530a91.31.1771286824245; Mon, 16
 Feb 2026 16:07:04 -0800 (PST)
Date: Tue, 17 Feb 2026 00:05:12 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.310.g728cabbaf7-goog
Message-ID: <20260217000701.791189-1-kuniyu@google.com>
Subject: [PATCH v2 bpf/net 0/6] sockmap: Fix UAF and broken memory accounting
 for UDP.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: John Fastabend <john.fastabend@gmail.com>, Jakub Sitnicki <jakub@cloudflare.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

syzbot reported 3 issues in SOCKMAP for UDP.

Patch 1 - 2 fix lockless accesses to sk->sk_data_ready()
and sk->sk_write_space().

Patch 3 fixes UAF in sk_msg_recvmsg().

Patch 4 - 5 consolidate sk_psock_skb_ingress_self() into
sk_psock_skb_ingress() as prep.

Patch 6 fixes broken memory accounting.


Changes:
  v2:
    Patch 2: Cache sk->sk_write_space in sock_wfree()
    Patch 5: Keep msg->sk assignment
    Patch 6: Fix build failure when CONFIG_INET=n

  v1: https://lore.kernel.org/netdev/20260215204353.3645744-1-kuniyu@google.com/


Kuniyuki Iwashima (6):
  sockmap: Annotate sk->sk_data_ready() for UDP.
  sockmap: Annotate sk->sk_write_space() for UDP.
  sockmap: Fix use-after-free in udp_bpf_recvmsg().
  sockmap: Pass gfp_t flag to sk_psock_skb_ingress().
  sockmap: Consolidate sk_psock_skb_ingress_self().
  sockmap: Fix broken memory accounting for UDP.

 include/net/udp.h  |  9 +++++
 net/core/skmsg.c   | 97 ++++++++++++++++++++--------------------------
 net/core/sock.c    |  8 +++-
 net/ipv4/udp.c     | 11 +++++-
 net/ipv4/udp_bpf.c |  9 +++++
 5 files changed, 76 insertions(+), 58 deletions(-)

-- 
2.53.0.310.g728cabbaf7-goog

