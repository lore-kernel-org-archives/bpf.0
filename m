Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CED953D955B
	for <bpf@vger.kernel.org>; Thu, 27 Aug 2026 23:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787874918; cv=none; b=l0tT1rAQy4LABKRlTPNVLlS6r96XfW2ya9WPACmwbWWJWbSEHGENMuGCGWXMuYa6Ye/1DIVprBq6pZyZS9xVni6HkTD7H7Rl5JhcVAuviRMRyNQNmNIiPpSap/UBRSkC8tchSjrXbYxX2Z+QT4OYOUWiQ2kYuneHbvU7x6rg1XU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787874918; c=relaxed/simple;
	bh=povcfs+zEFwhtdLtyHZfkA0h8OxsjY5Ocq80rUw6ZxU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lTo0TvHCK2kcc6v6291K6+ogd6g6yXp0FtyC8M/B48xFomcTXls+LXYPvfaCdq5trOOYWsrn6JCZ4+0vtHOH9q8/POu7RN0HOWMA9McM7gURXhvP1qx24E8PrhXz/LFQUu8i8i7lKwjMRzxJUZQv18tw3mZs8rHgQMwfve+z5hQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iyVBhwaw; arc=none smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iyVBhwaw"
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-66ceaade3f1so557549d50.1
        for <bpf@vger.kernel.org>; Thu, 27 Aug 2026 16:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787874916; x=1788479716; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ibdqZhM5Iy57YHQTMa8QJ1pQX4PIL/iVkp9X2oZ/1hc=;
        b=iyVBhwawK3j7j6zJAioLy7GC6kEvCDiZAtyIqD/EbyZ8B3Y+6Si5wSw6vKsivaVHB0
         9v3OkTP/CLQtHsGp5V6NXwHa0bpekA4ofHKmPtlCiq+eehIqOizR1/LNWaIEyz+Hz25u
         koIl1h/AjpuLM+jGvB9J2zMYw7Z59NJIsdfi8hjuI/uIPHOSH1rBW6dHBg+Q8XD7/2cE
         G8Ow+Iyw9COr8y2BsPTiobbXv51AONgqcZudAlNQlo0uw/GktvAd6eDrwlBUMlxcXBvG
         9qRyvkNKrZR4RS43+erdgnpFZqPA+qiylerawQPQJeQEeAVVXJh6WpymObXTljW9vqUd
         agJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787874916; x=1788479716;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ibdqZhM5Iy57YHQTMa8QJ1pQX4PIL/iVkp9X2oZ/1hc=;
        b=p+naW0wMIcA3tNa4IEH5PRuidSk6H1aFnO0g438XQlrd3pJtwjHUuIPDWkt66lgoGz
         mVLs9cTVhOuYbpKNMvvX5qFE/XCULVPSl9gf3p/ZLEw/zK8uPtwmwxK0nvOa9NloNu/z
         YzvJK7Ad7LIR2lBbcF6/6ZX6W5c1GdYmoHuc6TZ43jH/4ksjBMzjMuU4vRCEH8Pw557Y
         2zA350ZkGgLlKxuAaOxV3QePl7OUiEmeSeMAcZJd2Y6nSSyXz9yzUWW6feR/nOiO0MJj
         G1lPWfT/FZsaSz4bzdCVDJDYFeOXsiBgEbubOVyqKSVsVmq58TnLKN3q23mSEPrKR64w
         76LQ==
X-Forwarded-Encrypted: i=1; AHgh+Rqk0Ynsm2EafKVW8QoN/+ALCcqmzIDUV958xOnWOrQTSEymtgRXYJFj29bXGyjsVwLbIUM=@vger.kernel.org
X-Gm-Message-State: AFuF++k99gP4MVzz7BKY8Rxxckq3r8ev8OwRoEgomA5qmWX+iypc4PYG
	nW6578GO+u5vr/NSbij63HyopJY8hnvxt9hqHn6tqpzQDDVZs/ghmj9O
X-Gm-Gg: AR+sD12nRVBnPm4q8Yvs9yBTu9Ll2nbrfiKvWF4mWbJSZyINrsoNulKiOu7C1HCzLRW
	hbbFmcTSzBEnR+jwmGN8Qchrp4idq+UWd6S3a1s24pKjjg/YAtPaC0Mxd2cUwskV4uIhJmc7xlx
	tPpcyYCg8pdbiDEUr+Rro5CkzDANXjFgUFn7NETO4TY5vk7nuQeX9VCs7NEiQr+y2lKIUQ4TsHB
	Iole0nGSDQoIqdBaH59PVikLSpWaBi6j2KwsjPGI9IQVXt9jmmGeRoigJ90BDTFXS/aDuq6jVNZ
	/R04dP5NoRQEB2H5G/AZGq5/57uPtbfbQlPojPZDzWCC+kvLewHbqMLxujh1IVf5+Nv/9u7vT3b
	nWDmLScz8wQkC+W8XwMLh4zyyDsfaToXi1zQIkxFn7geFhuQMGLHXDEbONwFTdSRA2dM9WCriVi
	Yp90dGaoELL5bNrUZycR9+wWWad+vDqSP74oJojpMZatv3N8Ln6goO4ulftXKDtati+VM=
X-Received: by 2002:a53:acdb:0:20b0:66c:f55f:cd9b with SMTP id 956f58d0204a3-66e4c75015cmr700353d50.46.1787874915812;
        Thu, 27 Aug 2026 16:55:15 -0700 (PDT)
Received: from mac.lan ([136.55.173.105])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66e4eb3dcdbsm55704d50.4.2026.08.27.16.55.15
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 27 Aug 2026 16:55:15 -0700 (PDT)
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
	blbllhy@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH net v3 2/2] tcp: fix use-after-free in do_tcp_getsockopt(TCP_CC_INFO)
Date: Thu, 27 Aug 2026 19:55:11 -0400
Message-ID: <65fd3816ed5d541d9edd4bf4fcf97104a2cf907a.1787870710.git.blbllhy@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1787870710.git.blbllhy@gmail.com>
References: <cover.1787870710.git.blbllhy@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Cen Zhang (Microsoft Security FORGE Labs)" <blbllhy@gmail.com>

do_tcp_getsockopt() reads icsk->icsk_ca_ops and dereferences the
get_info function pointer without rcu_read_lock(). With BPF struct_ops
congestion control, ca_ops can point to dynamically allocated memory
that is freed concurrently, resulting in a use-after-free when the
kernel dereferences or calls through the stale pointer.

  BUG: KASAN: slab-use-after-free in do_tcp_getsockopt+0x2037/0x23e0
  Read of size 8 at addr ffff888013701258 by task exploit/149
   do_tcp_getsockopt+0x2037/0x23e0 (net/ipv4/tcp.c:4564)
   tcp_getsockopt+0x91/0xf0
   __sys_getsockopt+0xf7/0x170

Fix this by wrapping the ca_ops load and get_info call within
rcu_read_lock()/rcu_read_unlock(), and using READ_ONCE() to load
the icsk_ca_ops pointer.

Fixes: 0baf26b0fcd7 ("bpf: tcp: Support tcp_congestion_ops in bpf")
Suggested-by: Eric Dumazet <edumazet@google.com>
Cc: AutonomousCodeSecurity@microsoft.com
Cc: stable@vger.kernel.org
Assisted-by: GitHub-Copilot:claude-opus-4.6
Reviewed-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Cen Zhang (Microsoft Security FORGE Labs) <blbllhy@gmail.com>
---
Link: https://lore.kernel.org/all/20260821182449.79785-3-blbllhy@gmail.com/ (v1)
Link: https://lore.kernel.org/all/20260826171344.4133-3-blbllhy@gmail.com/ (v2)
Changes in v3:
- Annotate dctcp_get_info()'s icsk_ca_ops comparison with READ_ONCE().
Changes in v2:
- Add READ_ONCE() for the icsk_ca_ops load.
---
 net/ipv4/tcp.c       | 4 +++-
 net/ipv4/tcp_dctcp.c | 2 +-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 55ca74f60..71d4c5e6b 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -4561,9 +4561,11 @@ int do_tcp_getsockopt(struct sock *sk, int level,
 		if (copy_from_sockptr(&len, optlen, sizeof(int)))
 			return -EFAULT;
 
-		ca_ops = icsk->icsk_ca_ops;
+		rcu_read_lock();
+		ca_ops = READ_ONCE(icsk->icsk_ca_ops);
 		if (ca_ops && ca_ops->get_info)
 			sz = ca_ops->get_info(sk, ~0U, &attr, &info);
+		rcu_read_unlock();
 
 		len = min_t(unsigned int, len, sz);
 		if (copy_to_sockptr(optlen, &len, sizeof(int)))
diff --git a/net/ipv4/tcp_dctcp.c b/net/ipv4/tcp_dctcp.c
index 99f68c299..5b457f68a 100644
--- a/net/ipv4/tcp_dctcp.c
+++ b/net/ipv4/tcp_dctcp.c
@@ -228,7 +228,7 @@ static size_t dctcp_get_info(struct sock *sk, u32 ext, int *attr,
 	if (ext & (1 << (INET_DIAG_DCTCPINFO - 1)) ||
 	    ext & (1 << (INET_DIAG_VEGASINFO - 1))) {
 		memset(&info->dctcp, 0, sizeof(info->dctcp));
-		if (inet_csk(sk)->icsk_ca_ops != &dctcp_reno) {
+		if (READ_ONCE(inet_csk(sk)->icsk_ca_ops) != &dctcp_reno) {
 			info->dctcp.dctcp_enabled = 1;
 			info->dctcp.dctcp_ce_state = (u16) ca->ce_state;
 			info->dctcp.dctcp_alpha = ca->dctcp_alpha;
-- 
2.43.0
