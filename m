Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02235311597
	for <bpf@vger.kernel.org>; Thu,  8 Oct 2026 02:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791426637; cv=none; b=sZMgYDsdFA865mKIwfdg73uqyVDGia0MVC1KeUeKPASCacFMJDKtIV+nEzREfA8h+1u+FTajBqcJ2g4/CYDupr6x2YTr1lNB/yntvSH4xiRMVq2JuqbIpkgVyrWCmWFVkDNcN9Bx+t1si8EltzW4R+P6+Oe2uEDQ6H/yvWnM7Gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791426637; c=relaxed/simple;
	bh=+zYtguWatrWyIflqePQK6y02u6AwxFk3BoZDlKXZmL4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ucTY4/DF2RhgIyGrI5MV2LpjWvJ4iqmJh6Jt8GXl10E4SNIsgM410rY1hgRVI//wMZqv1dynlNVg6i6P+CntdTSYnvmO5XAkFEIyp3Selks1yJTsbiAdlFsDTbrQ71GEEkXq9D5jzCs+13rlYNRa0bLNHYy2t3DOMLs7DxQuOGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DVdl2+Wg; arc=none smtp.client-ip=74.125.82.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DVdl2+Wg"
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-30c0d568830so10349445eec.1
        for <bpf@vger.kernel.org>; Wed, 07 Oct 2026 19:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791426634; x=1792031434; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=nZL0mSdzCiqxdjcNFF6pKnqZLGjfb8O3XawG/UgZryY=;
        b=DVdl2+WgIWfl/HxUOKNmwcC/DpsL2QnlyAiBmTX2I7y/vjdyZTn7TFaXyRpntEu1Iz
         MnG1L+d+/PYgkLCxGwaWsJ5BmqgEqVLdL2tVcg8g/4pd9/eMp5rPiwnwy2pluxRiFinx
         D0VK4z5oaUwKuexe5r1Nim2U8cRksDmNi/9p8GpVqsKuBq2t2memWZumbfCPLFbIktBX
         sa4jmyP3Y9YDhYkJGU4vQbcQsgZEcjq7I3DWS+0HdgxJf2HFrvAEEAawaD9fkqgnFVmq
         +b4V5PXDWqyEQzmFpyVRdIEOMcWdhM9O19WVm9WrezLudY4aEF+a05u7WQmpGAhHgRtb
         PjNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791426634; x=1792031434;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nZL0mSdzCiqxdjcNFF6pKnqZLGjfb8O3XawG/UgZryY=;
        b=BsafTSLfThpcVnqzIKJ4ue2OCtYyYULHukb1ZIKOlQLXZTykBSqcPVWBmghZhlauDH
         GQXxJNR67qf0+jX6v6CcTtOFEGAcRUTz+ufy8G1ewqJYqyJX2t2WpIp1yDaxV/vUMKQU
         EO1za2ol/80wkP6Nv7eUjcLcB/Qui9/krQKzxyXSZrOpEe1PMWNO/YHp2uc6FPjSQgD/
         r+mCQsZdb2KhA9rs5JVM4qbEwYUvv5T3E3BspWc9uw/JzRUcvjiLVPDex7RTosgLx5k9
         fmkZSYh1g54k61CK0Kkr8TLYBVliXu4ddX0dlWrJ5ZOjB/zbFxrEQdscraRDhNAr2Z3H
         xO/g==
X-Forwarded-Encrypted: i=1; AKwUvBz+6RpcwhXmp+TKBAhZKYAIYYmW954oqeORRru0Y50YfShLO8UcE0XkGWG4Dmw5A61ms1o=@vger.kernel.org
X-Gm-Message-State: AFuF++nwJI+ANBnUv4cgXBFGf05jsVjoIdWEqs3QW5vs9bb8oU8TCgDE
	zUPedkEaMcxyVrY8HbIOFPPdCvjNOh/XLUjHts3aEGl0qwBAYwxMD6UKPRPeX7BeKiolMNobjme
	6JhUjjHiL6tgBUelAaKbyWOCmmw==
X-Received: from dlep17-n2.prod.google.com ([2002:a05:701b:4591:20b0:14a:c841:ce30])
 (user=almasrymina job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:701b:4506:10b0:144:c128:4c4d with SMTP id a92af1059eb24-162081524cdmr4103908c88.38.1791426633534;
 Wed, 07 Oct 2026 19:30:33 -0700 (PDT)
Date: Thu,  8 Oct 2026 02:30:18 +0000
In-Reply-To: <20261008023030.1089616-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261008023030.1089616-1-almasrymina@google.com>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
Message-ID: <20261008023030.1089616-3-almasrymina@google.com>
Subject: [PATCH net-next v2 2/2] docs: netmem: document netmem and memory
 provider design principles
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Cc: Mina Almasry <almasrymina@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Luigi Rizzo <lrizzo@google.com>, "=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?=" <bjorn@kernel.org>, 
	Pavel Begunkov <asml.silence@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Add a Design Principles section to Documentation/networking/netmem.rst
covering the netmem_ref abstraction, the prohibition on direct
downcasting in callers, decoupling memory providers from net_iov,
decoupling net_iov from unreadability, delegating provider/type logic to
memory_provider_ops and netmem helpers, and the homogeneous skb fragment
memory type invariant.

Cc: Luigi Rizzo <lrizzo@google.com>
Cc: Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org>
Cc: Stanislav Fomichev <sdf@fomichev.me>
Cc: Pavel Begunkov <asml.silence@gmail.com>
Signed-off-by: Mina Almasry <almasrymina@google.com>
---
v2:
- Document both current implementation status (mp returns net_iov,
  net_iov is unreadable) and target design principles in items 2 & 3,
  and note that new code should generalize existing limitations as much
  as possible (Stanislav Fomichev).
- Link to v1: https://lore.kernel.org/netdev/20261005004958.3603059-1-almas=
rymina@google.com/
---
 Documentation/networking/netmem.rst | 52 +++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/Documentation/networking/netmem.rst b/Documentation/networking=
/netmem.rst
index 217869d1108dd..e023f4c69d2a6 100644
--- a/Documentation/networking/netmem.rst
+++ b/Documentation/networking/netmem.rst
@@ -19,6 +19,58 @@ Benefits of Netmem :
 * Simplified Development: Drivers interact with a consistent API,
   regardless of the underlying memory implementation.
=20
+Design Principles
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Memory providers (or the default ``page_pool`` allocator) allocate underly=
ing
+memory (``struct net_iov`` or ``struct page``), cast it to ``netmem_ref``,=
 and
+supply it to ``page_pool``. The ``page_pool``, drivers, and networking sta=
ck
+operate on ``netmem_ref`` as the abstract type. Existing ``page_pool`` API=
s
+that allocate or free ``struct page`` are legacy compatibility wrappers fo=
r
+drivers that do not yet support ``netmem_ref``. Code that is not yet
+``netmem``-aware should be converted to ``netmem_ref`` unless it will neve=
r
+need to support ``netmem``.
+
+1. **Operate on netmem_ref, do not downcast**: ``page_pool``, drivers, and=
 the
+   core networking stack should deal with ``netmem_ref`` rather than
+   ``struct net_iov`` or ``struct page``. Downcasting ``netmem_ref`` to
+   ``struct net_iov`` or ``struct page`` is not allowed unless a code path
+   strictly cannot function without knowing the underlying memory type (fo=
r
+   example, ``kmap_local_page()``). In those cases, to keep call sites sim=
ple,
+   add a ``netmem`` helper that performs the operation on behalf of the ca=
ller,
+   cleanly handles all ``net_iov`` and ``page`` cases, and returns an erro=
r if
+   the ``netmem`` type cannot support the requested operation.
+
+2. **Decouple memory providers from net_iov**: Memory providers are not
+   architecturally limited to ``struct net_iov``; a memory provider that r=
eturns
+   ``struct page``-backed ``netmem_ref``\ s to upper layers is allowed. To=
day,
+   in-tree memory providers only supply ``struct net_iov`` and some existi=
ng
+   code still reflects that limitation, but new code must not assume that =
using
+   a memory provider implies ``net_iov`` memory and should, as much as pos=
sible,
+   generalize existing limitations to match the design principles.
+
+3. **Decouple net_iov from unreadability**: ``struct net_iov`` is flexible=
 and
+   has no inherent restrictions; it may represent either CPU-readable or
+   unreadable memory. Today, in-tree ``net_iov`` implementations are unrea=
dable
+   by the CPU (``netmem_address()`` returns ``NULL``) and some existing co=
de
+   still reflects that limitation, but new code must not assume ``net_iov`=
`
+   implies unreadable memory (check readability via ``netmem_address()`` o=
r
+   ``skb_frags_readable()`` instead) and should, as much as possible, gene=
ralize
+   existing limitations to match the design principles.
+
+4. **Delegate complexity to the lowest layer**: Each layer must respect it=
s
+   abstraction boundary. ``page_pool`` must not implement per-memory-provi=
der
+   custom logic in its main code; instead, it delegates provider-specific
+   handling to ``struct memory_provider_ops``. Similarly, core networking =
code
+   should avoid per-``netmem``-type branching and instead delegate operati=
ons
+   to ``netmem`` helpers that handle the underlying memory type.
+
+5. **Homogeneous skb fragment memory types**: An ``sk_buff``'s ``frags[]``=
 are
+   always backed by ``netmem_ref``\ s of the same memory type. Mixing frag=
ments
+   from different memory types within a single ``sk_buff`` is not allowed,
+   keeping ``sk_buff`` handling simple. Consequently, coalescing ``sk_buff=
``\ s
+   with different fragment memory types must not happen.
+
 Driver RX Requirements
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
--=20
2.56.0.385.gd3acb90ef8-goog

