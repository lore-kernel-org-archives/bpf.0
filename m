Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFEFF471266
	for <bpf@vger.kernel.org>; Wed, 26 Aug 2026 17:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787764471; cv=none; b=txRgc08+GyI0XxcOg5AGb14WUxEyn9NUEmomyCMryo87liz7Fs/Mw/jWZB094vpXpN+osXdpNMY7atT79P8aATCW61HWuzqr5rV8KTVs5y6ZWJcugXGyQab/h3woH+2FaJSss2t72ug22pkhSXrGuTlwhMZ8zDmp92zFNvDDUU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787764471; c=relaxed/simple;
	bh=FYU7KMAFHEMK0a2QdB7zYECmQAGqWOP3hrjJRZA4Zgw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bphr0mOt0hRicguAmdCdryPgLPL8RqW74w6m1OGPg2MzruVP5hL+2bRf/jYvioZH3NC1xYy1maij/NSLecMoplL2U0tjMKLm5hfR0SGAATjwzP7llp7xMtosMRbUcdvgG8lvxvkkc+ydrSOvVpiXEMhobfnhxnPR5dUUPm36Ppk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JuR4/rWj; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JuR4/rWj"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-841f1dfc30fso2082727b3.1
        for <bpf@vger.kernel.org>; Wed, 26 Aug 2026 10:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787764449; x=1788369249; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=3I8jJPf0z07/GaYv+UyScI71SC+rAjjfZUq3HdGlVP8=;
        b=JuR4/rWjJUesPnZfDT/1zN3cjhdoD0V0U7YXK1F0UaT3bdRqLn+DgngjRvhz8M2d0d
         3Ij9iqlGcXI7NkC2ssdAQU1nymvvubqUmFxe9IlOG1kBQTLb40w1WfU44B/2q7QuIcgQ
         fXg/XA33t0uTwdfI2BtwEdylwBXe6Wh8Y9dVHdPvjMDstipah0KWO+AVarwceptPpaMh
         YYfu6UJYZWvlNpGltpZxU8nXjZIB68KXVoDOcaYOdpWEfNl6iadiiKICdDZYJYwLoXjC
         7LoEuKVHAidJOmGHxx4YFaivCS66009mce7/cUpILPiyfZOu78ZOleF2vHGJQlq901bo
         cCAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787764449; x=1788369249;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3I8jJPf0z07/GaYv+UyScI71SC+rAjjfZUq3HdGlVP8=;
        b=LDY5bW8IdV0fkgX+UIHrFoAPBVylDmqc31ThZcDRbtQIeklcW4h1V1ah1I6RpppGUt
         QF9HKGlfVWU1pSgCMf17r/pKMVR1jorXHlM4JjomOpDLDs08eA6V1PmWD7jWeAqrxAPs
         8MmRHM6+5IFfGEPwCBpOp8kkkbIIuDUQS42pzjjIGD9zzwv8mygj6TnsC3zCFfZh83dH
         YGlFNhFMyDxJY842kbzK1x8a97HbFTxOs4HM96IxSNwPhataPwLK0gP7OIcgEc467IBl
         lUomtkUNsB7+taRn3GMYSKhu5s+4SMmYg2xsohyQmSW/4R9sTe+rOITwNhANlDGmF9ti
         xIyg==
X-Forwarded-Encrypted: i=1; AHgh+Rr5xb/q3MhM91CK/mlqi7xJjIn828VTHlGdjAqfrO5yjJtoyGWZ5OTocns0cT1UNYVoV20=@vger.kernel.org
X-Gm-Message-State: AFuF++ntUzRlx9qxTLLFbFmYQzHX3V9g0i9138Pt8vHpvYdMCCdkNvWJ
	0DUYgT45qdXTRKxM92e7iw9GnwjqRkEil+78orKsIloE49DlcjAeYbgl
X-Gm-Gg: AR+sD13Z22SJg/GsNtiRS3MxnM9T9rFy/5Wn2kgSRkbharbVat9KmJXBVs9+bHQ/ET8
	RlpMSLUwRtlZpYQLnZ/JKI3vYEcGw36Sked0A1Irf2k6CwFRQogwUETylww2twIuuZkonQMicYv
	/Zqap4d3zFFs1mK7H1Q/MXpnqFz2wlneDQUu+uwLc7LafmOMbX6UKRO/ZGjqSCjZ14rm7tMvq9A
	CdVpeRia+Kz1qNAh/akhK7zovu6rTvuaQTbW00dGI9fh9YjgI2At0BhlNwKFpqWFwHrSz/otl53
	0oDiMc9B0N+iTjQAXwIAgvsYEqBd56AfioKL0zz6ghJL1ChHrsdxAf1ZYgTwBS71ShT9igwva37
	nAPgpucxs9GghtvI+cMPy6PvEU62Y/RNfKAvmWPZqlOJ2Oe7SmhryNz8qZgI6BSE56zR480Yofn
	zSKI+P5A8lxPVElnsuFeGougbY9dHMuw2r7lJ9RVkG3qWblNBFGa4Qe3z8eMD8ZXuXSYU=
X-Received: by 2002:a05:690c:3709:b0:826:f78b:8462 with SMTP id 00721157ae682-85a9ee40bd0mr3306087b3.7.1787764449016;
        Wed, 26 Aug 2026 10:14:09 -0700 (PDT)
Received: from mac.lan ([136.55.173.105])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8570d620433sm19313287b3.42.2026.08.26.10.14.08
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 26 Aug 2026 10:14:08 -0700 (PDT)
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
Subject: [PATCH net v2 0/2] tcp: fix use-after-free in do_tcp_getsockopt()
Date: Wed, 26 Aug 2026 13:13:42 -0400
Message-ID: <20260826171344.4133-1-blbllhy@gmail.com>
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
for the lockless load and annotates every explicit icsk_ca_ops store
with WRITE_ONCE().

Patch 2 fixes the TCP_CC_INFO path by keeping the READ_ONCE() load,
ca_ops->get_info lookup, and call inside an RCU read-side critical
section.

Changes since v1 [1]:
- Add READ_ONCE() to both lockless icsk_ca_ops loads.
- Add WRITE_ONCE() to all six explicit icsk_ca_ops stores.
- Include the data-race annotations in the UAF series as requested
  by Eric Dumazet [2].

[1] https://lore.kernel.org/all/20260821182449.79785-1-blbllhy@gmail.com/
[2] https://lore.kernel.org/all/CANn89iKr1ypEFeL+7te3xWoNaK5AFyYQmr+pDh2zSZAxfgNKjw@mail.gmail.com/

Cen Zhang (Microsoft Security FORGE Labs) (2):
  tcp: fix use-after-free in do_tcp_getsockopt(TCP_CONGESTION)
  tcp: fix use-after-free in do_tcp_getsockopt(TCP_CC_INFO)

 net/ipv4/tcp.c           | 18 ++++++++++++++----
 net/ipv4/tcp_cong.c      |  4 ++--
 net/ipv4/tcp_dctcp.c     |  2 +-
 net/ipv4/tcp_minisocks.c |  2 +-
 net/ipv4/tcp_output.c    |  2 +-
 net/mptcp/protocol.c     |  2 +-
 6 files changed, 20 insertions(+), 10 deletions(-)


base-commit: f967455fb2a5a2079b9eb5823e9ccf359174bf9f
-- 
2.55.0
