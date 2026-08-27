Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 191EC3DB64B
	for <bpf@vger.kernel.org>; Thu, 27 Aug 2026 23:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787874915; cv=none; b=lgsxWFXQYuYx7/8t0ZD8AMLIjFRyhCGlGGSCsBOwV5XN1h1Uo1wNvf0UuQSiBx5xg5mG3D1qG9FklrA94mVLm4W9SfBwY01lVN/r8MPTjGc82cB+PgCAfxcB8Q8IqF70R3ftiaOB0LYLqUBqyMyqXUlLnSs8/7jaN7x7lUC5tf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787874915; c=relaxed/simple;
	bh=h27YVKK/TYuusXE6taFKqIAn5VyxSn/kotJtG8PpEoM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GzoyD0s6LgvXIXaGMhDFvjQ0gGtoSD0EdVbrg23qPGVttunG4q9jCjFA0bJ/env1mQ9W6gINNUf6kJtzRGFVMaO9tsvnBe13Bbz6iZfssrNDKlQrDUdZHmDLF8Ns7a8joDwFtZpE3OVZhCYU7mEFlOMm5FuzNO1OFBkBj480E7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kLQV9XvF; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kLQV9XvF"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-85a50f6a7f7so3086367b3.2
        for <bpf@vger.kernel.org>; Thu, 27 Aug 2026 16:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787874913; x=1788479713; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=oCfWHkIpmLvJEZNt0kO4ZWyCArHHxMdSOeCJ5Kkvn7k=;
        b=kLQV9XvFAFdSVgqCBBMav4u7yyVUl9B106WF7pEaIjoaVjR36RWCvJOyFkKOYLwSYC
         XeTjjTaHxmqjDWR9V3NPoLvqLmtt6Z43dU/wjEfOtshfAXQrZ0acatlEscg6uy2h714x
         d7uiB1SffbO0UaJvTFWYOFBPnyVgYBphj5pkPEBwhX/fFUGSzugmKjvacgX+ztmQvtuD
         5kPA4sjnGAaHD9jPPMTaJ80IMryuuWysV95/8WfYDlQusgtTTyXCjA9yWJOkeI3A/v8h
         rPXPUvsw2q0lK1W8YWFvsCKJspoHf5e1LYwy3zt/R37idJBkGJfnZ+Id4DHjwD2a/gK+
         yCIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787874913; x=1788479713;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oCfWHkIpmLvJEZNt0kO4ZWyCArHHxMdSOeCJ5Kkvn7k=;
        b=gZKCD0A9a0Q9RJYLcgn2WEGegmb1UGBnIHccFykTnzsx0wWxtbWZdb4iO4bn39tkMV
         Un2NkepioFg/FR8XjDvjgLvtSa2kLZQHzoe/R8I92sIf6ACBOa7kH5pgpXnnpTWs5Gq8
         l4b15TEDTqhPyhKvbcWJOEJaZq/YB/djtFjTbzdtASc8Dd3gAxCKepAO9FsJ1IQ//d48
         ulrsgSkZh8D47mTdhwi68AnyGvx6+LRrVcIJ6KpUKq6kMa6QjCXbhT3XIJR1NDLh8xrA
         EIjeM4feoRGVIpwG2cSwNQ8KgwSOQtyA+zC4xJkh060D8kx+MhjWFLMS9Dbkl/IsLW78
         4cyg==
X-Forwarded-Encrypted: i=1; AHgh+RonVxRhHQxPkvV3SohNYreUhKypYUDQPzK8AvtI9cT4gDAlkwDDG27X6+RmMX/rq3RLTMQ=@vger.kernel.org
X-Gm-Message-State: AFuF++kpJWK9U17T/1LtHEa1EjIdIijkcPXNrrWY3q1/IydLBGdoAdx5
	rbdvCIUlTUURJc7pGy57egTUqnXtzMzimP5pjB/FLP1YQVMySE7peoTA
X-Gm-Gg: AR+sD10by3saFaxwMA/Qrioxi9YKaw5SBqYAZyOL9JyjQHSLbEq7CMaY+7+2YHsRir4
	QT2PAKSAVhBWq4pS3DA5u3VOVTSv3lE+1YD1yIlVa3VDvvwouNs2Z20WGyORg6ZyqXvzZWVgxSq
	V2R0D/WRWidJkCRbZE4ruCMh8OVTHWZuTQoSvPU/DgWFDNrP98dCgLatHbmMmWRFq7fPbJ3HrTw
	cvuquA8TlZ1WwmpasfBi0FmaetgYm1iV9C6WxJIG94cgazRBYo6a+QL4cNdKY8M3Ovx8oGK5uuC
	j+xHE3bSuRiDsNkW757xodZ5cHyp/mXeIEac+CMovmqZSeeELxmF/a8C0TwB0w1kBZZ3P1/ZT0F
	J+9zFXosjYdQIB2I2hwEa1A0dTe54SGCZ3rL9XoD9bZPoIlb18HbWGC9G8U8Wt0KezYZqg/3/WO
	FMUa7Yua7s7HRlqB9osuVBLG3nmEgLBs/S7bBpkjC8hLZKPgEdoAV86LfI4PP66UwUi6o=
X-Received: by 2002:a05:690e:428b:10b0:66c:d353:948a with SMTP id 956f58d0204a3-66e4c7645d8mr742101d50.39.1787874913018;
        Thu, 27 Aug 2026 16:55:13 -0700 (PDT)
Received: from mac.lan ([136.55.173.105])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66e4eb3dcdbsm55704d50.4.2026.08.27.16.55.12
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 27 Aug 2026 16:55:12 -0700 (PDT)
From: "Cen Zhang (Microsoft)" <blbllhy@gmail.com>
To: edumazet@google.com,
	ncardwell@google.com,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: kuniyu@google.com,
	horms@kernel.org,
	matttbe@kernel.org,
	martineau@kernel.org,
	geliang@kernel.org,
	yhs@fb.com,
	kafai@fb.com,
	andriin@fb.com,
	ast@kernel.org,
	netdev@vger.kernel.org,
	mptcp@lists.linux.dev,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	AutonomousCodeSecurity@microsoft.com,
	xmei5@asu.edu,
	tgopinath@linux.microsoft.com,
	kys@microsoft.com,
	blbllhy@gmail.com
Subject: [PATCH net v3 0/2] tcp: fix use-after-free in do_tcp_getsockopt()
Date: Thu, 27 Aug 2026 19:55:09 -0400
Message-ID: <cover.1787870710.git.blbllhy@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Cen Zhang (Microsoft Security FORGE Labs)" <blbllhy@gmail.com>

do_tcp_getsockopt() has two lockless reads of icsk_ca_ops. Since BPF
struct_ops congestion control made icsk_ca_ops point to dynamically
allocated memory, a concurrent setsockopt(TCP_CONGESTION) can replace
the pointer and free the old object while either reader is using it.

Patch 1 fixes the TCP_CONGESTION path by copying ca_ops->name to a
stack buffer while holding rcu_read_lock(). It also uses READ_ONCE()
for the lockless load and annotates the relevant icsk_ca_ops stores
with WRITE_ONCE().

Patch 2 fixes the TCP_CC_INFO path by keeping the READ_ONCE() load,
ca_ops->get_info lookup, and call inside an RCU read-side critical
section.

Changes since v2 [1]:
- Fix the TCP_CONGESTION build failure by loading icsk_ca_ops inline.
- Drop the unrelated WRITE_ONCE() conversion in mptcp_ca_reset().
- Add READ_ONCE() to dctcp_get_info()'s icsk_ca_ops comparison.

Changes in v2 [2]:
- Add READ_ONCE() to both lockless icsk_ca_ops loads.
- Add WRITE_ONCE() to all six explicit icsk_ca_ops stores.
- Include the data-race annotations in the UAF series as requested
  by Eric Dumazet [3].

[1] https://lore.kernel.org/all/20260826171344.4133-1-blbllhy@gmail.com/
[2] https://lore.kernel.org/all/20260821182449.79785-1-blbllhy@gmail.com/
[3] https://lore.kernel.org/all/CANn89iKr1ypEFeL+7te3xWoNaK5AFyYQmr+pDh2zSZAxfgNKjw@mail.gmail.com/

Cen Zhang (Microsoft Security FORGE Labs) (2):
  tcp: fix use-after-free in do_tcp_getsockopt(TCP_CONGESTION)
  tcp: fix use-after-free in do_tcp_getsockopt(TCP_CC_INFO)

 net/ipv4/tcp.c           | 18 ++++++++++++++----
 net/ipv4/tcp_cong.c      |  4 ++--
 net/ipv4/tcp_dctcp.c     |  4 ++--
 net/ipv4/tcp_minisocks.c |  2 +-
 net/ipv4/tcp_output.c    |  2 +-
 5 files changed, 20 insertions(+), 10 deletions(-)


base-commit: a3dee9bb902ee4357fa02e49b415d7724ee0140a
-- 
2.43.0
