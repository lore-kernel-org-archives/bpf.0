Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B017C33EAED
	for <bpf@vger.kernel.org>; Mon,  4 May 2026 21:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777928780; cv=none; b=Z0k+MtiIG+/1U6OzOtzZjW9KklnK6RU7IzP6tDYGFY9LQU05o23kgDzpyxd9LKbwHsshMuVSppsIfo3sA/2gq6suLfGUiFyyEJkv7uFEnLa2/Ew0inCY3HIu6y3yqxNg+/I6EQw21n3avAwec7MYS7v4mo+4ge+6UBVpOwCk91U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777928780; c=relaxed/simple;
	bh=cmn2WSZTNYGCpkywBNeAvhkC9f6GUFEKUwCc7EBVnK8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=F9o4qXaL9YNai6kDmdZUhYP7lGZTmr8guQFtmkCq7s1mh86YDSpwzWBoDcJqNVkybbMJKJm8xoVqdxmAcH6mRBYXYDOyyvGlrxrxiY+UHT0HEUXQ1UqwfXbgYTzvg0sy0MjmMY6Bu1N6iY3v0Ng6Am5YOiO1wW73ekWwsDCcLzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jnyU3p6r; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jnyU3p6r"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-82f9429f49cso5726335b3a.3
        for <bpf@vger.kernel.org>; Mon, 04 May 2026 14:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777928779; x=1778533579; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=uhJlx1wKuGc9b2//z9ZBMpryakhxff7H3kevgbt7OKQ=;
        b=jnyU3p6rIFeNyVvwlFGiMk8+0QGhcu2F2FuDL4uVB5x2mRQaDc/Pv1kWmlmGucIEe2
         wP6fPsTvR8v+TiHa2+5RtCk7bOgCdgGsvUAE/X0YMYVwYubBevtjn8ssJJnk9+Wa0BMy
         sgqJbuWtnE4SSh99MpjnGKz3LwGpL2RQtg+c36YzO8YUoq57pYoospGqE3R4niZfDHKu
         ZnLO3W1OM2tis7+2uuCXQxNwkRkO4x8xTOVTbzB9gcctvCbXia4GSp7xq3ZLHn2p/icW
         5Qd7Pcg1zrltFTkN82c/TdKD3o391bn4FHwuLrE22wEwQL1QvYHsxWZRqWX4lw/oC4II
         t8GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777928779; x=1778533579;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uhJlx1wKuGc9b2//z9ZBMpryakhxff7H3kevgbt7OKQ=;
        b=kbU8jZMaCUwdHmGHc57PUrA06ZeDzFTQO9IsIdEtW7dxBpxF3nnem15jmksz81EAHu
         X0fXVpNTjQM4dJCPgz4psPuwhPMrfm2FYR/UlyJpQVz49j7yWmgSThA9q1ivpGkVjfHG
         NaHsSo7BxX1g7OVZkcKkrnPTUYIZj8DvpPVlYq83rI3R2PTJfvo86o/GB3MiMEdhi4hy
         e5IPyfhDLA6nNuon5S4gX4icsGubtkDdz/gy5WhEUxUH/ZAfzg46D7Odns1mx6zq3jKk
         5Hqf8gSqFr0iveAz/+jwvOWIkdijlnxWmmIiunRv1+KFoCMFqR2E+n4C+2vGhpbPZTys
         E+6Q==
X-Forwarded-Encrypted: i=1; AFNElJ9Czu8ZmEYAPOH8uvjpTRp7TnnK/YbwEKKr4boLXcGu6PDrvNttGpkNyj1SrLh/CDv0g2I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxA8h+4V7+0EJ4q+jbrKr+93aOR/bmvVUzDZxJcuLCg/LGk1e2t
	44m/HgjDbW6IXmF6P0FcY06813TzAz7ScTugxMjmDsMiaY3WVNt314NDvGE0gezGhUl6Aw13hQ5
	9DFcFQQ==
X-Received: from pfbcd20.prod.google.com ([2002:a05:6a00:4214:b0:82f:d0ad:4d57])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2d11:b0:81f:5037:a317
 with SMTP id d2e1a72fcca58-8352d19f3ecmr11425299b3a.11.1777928778691; Mon, 04
 May 2026 14:06:18 -0700 (PDT)
Date: Mon,  4 May 2026 21:04:51 +0000
In-Reply-To: <20260504210610.180150-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260504210610.180150-1-kuniyu@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260504210610.180150-5-kuniyu@google.com>
Subject: [PATCH v2 bpf 4/6] bpf: tcp: Fix type confusion in bpf_skc_to_tcp_sock().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Martin KaFai Lau <martin.lau@linux.dev>, Daniel Borkmann <daniel@iogearbox.net>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

bpf_skc_to_tcp_sock() only checks if sk->sk_protocol is
IPPROTO_TCP, but RAW socket can bypass it:

  socket(AF_INET, SOCK_RAW, IPPROTO_TCP)

Let's use sk_is_tcp().

Fixes: 478cfbdf5f13 ("bpf: Add bpf_skc_to_{tcp, tcp_timewait, tcp_request}_sock() helpers")
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/core/filter.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index cd88633f8dc1..7d945dc2cb92 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -11963,7 +11963,7 @@ const struct bpf_func_proto bpf_skc_to_tcp6_sock_proto = {
 
 BPF_CALL_1(bpf_skc_to_tcp_sock, struct sock *, sk)
 {
-	if (sk && sk_fullsock(sk) && sk->sk_protocol == IPPROTO_TCP)
+	if (sk && sk_fullsock(sk) && sk_is_tcp(sk))
 		return (unsigned long)sk;
 
 	return (unsigned long)NULL;
-- 
2.54.0.545.g6539524ca2-goog

