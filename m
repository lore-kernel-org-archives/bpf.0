Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58D85478E5E
	for <bpf@vger.kernel.org>; Tue, 30 Jun 2026 20:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782852659; cv=none; b=segAoCIvm3INycxbYtVbvu1i5sxssFDg0vhBdLPT0qrWvmsvV3ASXbacsQco+e+0TkTB7xESAh3NY1iPA605mkuKUZo8B7MmQ+rekSSW8+PDyf+SgGbh75cp+PJ3jo3TYmq6wZ4sh5ZLHltZAnPN075Eod/H9K/l3MQlYr6FvsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782852659; c=relaxed/simple;
	bh=fK/MWsPyhM/NRS8LN/G6f6zgJ3L/0Mw5pNSYTbRJMDc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FOW1WZkyYIhiJN0pB9kkzEhNJCICgwmLTN8+ZShhOVKV+d4mz2u5xwT1w/dkPgU7mr0l481x+zDEGOiNrWh2UZM8v0+bWjpwF4ymJ60SaSdbfrzt3lokZ/fpHYjgX8xoXBHdDtlNIEJhc5HZ4goQL84w0iWdGqoqGw+nSJ++Iuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T7HrGP7l; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T7HrGP7l"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2ca265d6ca1so7627015ad.1
        for <bpf@vger.kernel.org>; Tue, 30 Jun 2026 13:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782852656; x=1783457456; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bREOiO5mN7hLvS/DleneGMdLVSBD6LdzBp7bNvZIud4=;
        b=T7HrGP7l88Lf1REDsU3vyF3oRCp/Pkch1PeD4ax2pdQQwkIwEONhWil81pmpKg+8Ag
         rAoEgPzFMIlBHdH8bQVAlUP6DT9Hv3lkmxGGOxTMwa5nIb3V/Cg+dXfxkrBUFVBH8ZTA
         bnPxcGXUBS4htBKKIt3SYiz8x+AiWdAk4ICOzuwAHDKzF+dmAT/Ax0n0StzI6vRuUT1v
         iVhKD2JNRfZLzu2fOtnUw6gBXG5CoqT7JoeQ21IV666CD2uMW+g6RXk6ylt5PvnD5+v/
         43kOygdBxyCJzf29YkluGH4/hQ0NfcGYAH3DmmeVBln65uovZVShBQur4ipr8S+VGhpM
         3V8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782852656; x=1783457456;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bREOiO5mN7hLvS/DleneGMdLVSBD6LdzBp7bNvZIud4=;
        b=kyl1tiMLdp1urevkfbENc5KnuXiKzrXxhZ7IVn9NCvq+bwAMQXKlrrTlIKb837sMez
         1ghmBq74D3Bki8Sv+1gdwvjKrHXTLuBs76tPHsM2516D7eBfdPk3e2WXMsR6HEaWCmLd
         kW2F+O2/l2To5IYucjD8GTXOrOOQ2K2G7nEvH6xk54ZwQmyx88p3ZQ5BD507Xw9sJkE0
         D+uXZetpodBoqwV6c41P1Ga7xGcBTKXlfxv3ZeTeGintdTnQPiXr51LySm3xtwSGgura
         +61GBO2GFJ9scsEGE36wfekwuooudOjYO8+mOS41bOcASG0qwUTuvmtWyaUsrNhFlwti
         zNgQ==
X-Forwarded-Encrypted: i=1; AHgh+Rqn93IB3gEzwwJEeQzAEcnPUh58jsC+3pmITVurBO/Ov1jQvQ03qV92g7oAJMilnhpr4V4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtZGrbHjMbQbdiGnVwkGEmdwdR6ixvpPU97MRAOmD9pVGej6oE
	9QVzDhnMnhQEeHmX0UIkNfXEEc67Ba8Mh97BUSFziVbRrZblazWEVb9K
X-Gm-Gg: AfdE7ckgYgS4d3mTv6OfwzV9/n23HcQw9D70wAJTi41PVS7e9xXdHL0kuMs/ItDMjLi
	humt7msiyA6tiCUAJMGo3qsky/aob7KhL7jmnoG9u/NP0+ExK0XtZNq9tm6O5vJeLE4RBCoMIo4
	XriM7TwL/5iiqC0T/nLWdgFQ1n1OLijwO1cxXfmw+U04cSXTakrJ0BOLQLZHgwJQiG943IZ40Vd
	YXnII1lk7/FcklsrJUhoEUiRKV1V/BONQtak3t4b1eVkMGtUvFERVdkPyvRPdNnIIi+/cQlMs61
	1JokkCEs2vAupe7Z3DKWnpiFxcMQ/bWZQYJMBML41/mQkiTxlp9WvA2Xt/AqRijsI8louPIRIuF
	wSDrpYm4em85GXt7tpurxd+GDpPCcvEFk0c3h1GHm9wKwx8oWGwJIMxW7kiRcdUKJWGyKDl15iZ
	skXSMwJVlIHwNfAqe2YzAIoayoDrWwEZ+YsuOedNrakESlBH0E5yc=
X-Received: by 2002:a17:902:f54c:b0:2ca:d4f:adab with SMTP id d9443c01a7336-2ca44a060e1mr25125905ad.19.1782852656493;
        Tue, 30 Jun 2026 13:50:56 -0700 (PDT)
Received: from cps-manycore-1.. ([147.46.174.222])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ca382ba1ccsm20322305ad.66.2026.06.30.13.50.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 13:50:55 -0700 (PDT)
From: Sechang Lim <rhkrqnwk98@gmail.com>
To: Eric Dumazet <edumazet@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Shuah Khan <shuah@kernel.org>
Cc: Kuniyuki Iwashima <kuniyu@google.com>,
	Simon Horman <horms@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf 0/2] bpf, sockmap: fix copied_seq left behind when a stream parser is removed
Date: Tue, 30 Jun 2026 20:50:33 +0000
Message-ID: <20260630205043.184894-1-rhkrqnwk98@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A stream-parser sockmap socket can be removed with SK_PASS data still
parked on its ingress_msg queue. The copied_seq rollback for that data is
never repaid, leaving copied_seq behind sk_receive_queue, so the native
tcp_recvmsg() warns. Patch 1 settles copied_seq on removal. Patch 2 adds a
selftest.

Sechang Lim (2):
  bpf, sockmap: settle copied_seq when a stream parser is removed
  selftests/bpf: test sockmap strparser recover with undelivered ingress

 net/ipv4/tcp_bpf.c                            |  9 +++
 .../selftests/bpf/prog_tests/sockmap_basic.c  | 59 +++++++++++++++++++
 2 files changed, 68 insertions(+)

-- 
2.43.0

