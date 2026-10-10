Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7245635DA53
	for <bpf@vger.kernel.org>; Sat, 10 Oct 2026 03:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791603394; cv=none; b=tH+UlTlOXYoqjP7EJ64VSvJSNNBDwpF8158baQqSEYMkToPCm6qu6N0haroUrG9ARZ5XfA9Nh4hBXHcLTfkVbONZhQekr4SRjWyUbrb6wa+weoSEFFaH443s+5oT5Mfyjzr+8IbBzvuyDkPN4LEMsfobDl0+AyKS/o5NLchRZDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791603394; c=relaxed/simple;
	bh=70YgM1Mt4Z5YsyjAZUstuPenINMCxDg+GnCsfmv86Gg=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=TSh6vkHozD+qdaAdLcV9ieg6cP2HMnR4hvhd3Xx4DzuVu9Q9vzQ9fRcmc1IxxPw0RcBKFqMcuF6PrtgMGrxqmMB4yJPhThYQfPfipXxpAlo4K1hdBgUr3iqHzLnzWDrj5vJJjz0SH50XvH7phF7I7ze604NB7Y5d7NIBuyxrRMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BAv4n9k7; arc=none smtp.client-ip=74.125.82.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BAv4n9k7"
Received: by mail-dl1-f69.google.com with SMTP id a92af1059eb24-139b62317d0so1637712c88.0
        for <bpf@vger.kernel.org>; Fri, 09 Oct 2026 20:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791603391; x=1792208191; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:mime-version:date:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=FN3jzVFTvR1bxiOc6QpulyJ81OKLo+adR8/+V0xSoVo=;
        b=BAv4n9k7qo0iGS78shwAnpM0hJ0JrIvnLuJe+dQEzMYB1WdD13FKwuUtCLuiknAeY8
         NY5CJqaRrlSGV3qcZGmIzkUAWHrJg9UQkrWOR9p5sDgEg5rPq5Kj/KYA3CJ1zmGUSVTN
         W90ROwzX28DJFAby2WC7s7gKa4YPkysX7KmlZs8aRSLB+8mBQ08FmIu8rCiK4PT6cMUh
         FFCo+2FlGR8he+DM4lohEJMbTvv9mkECL2U5CgqdWlgt35hi68lwSqwU92JC2hZTmdE5
         yRDI9FRoQ1HfV/3AtUMauF15SxcXeRV82Bp9L2sN+/ovMtNPvgAeoCBs68+DmCenegfU
         dc5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791603391; x=1792208191;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:mime-version:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FN3jzVFTvR1bxiOc6QpulyJ81OKLo+adR8/+V0xSoVo=;
        b=yiTaDAk5NcMotRfTFYCm+4hcSyrVdrQu3XOX9zc16nvQ7yBLAur0PgoVLOUBDWtPrl
         Lyi3kEYTtaIxTv8a+tlTT+tVzmY70foJKZkPqBSAg6mrCml3VvEZok8mMQERiyG2o9uH
         UT74TcicuFSFTJjyuBNTnXPWm3YVkmfM8KxdTX4w+7yjERTeFqgUtZk72Qi3MnuWxtNO
         OwJ3GiziQ79RKz5IlX78Tfw3MXlPnb3jI1BACiwgEpmwH3cmEW47Yo2Nx/A95jPH2EY9
         pVDB0oWMIGKICaiALfoAfuOfNisiBBj5qJqhR8BkfZ7eWldbRS96gW2sDuPE3yGUuZmu
         CYww==
X-Forwarded-Encrypted: i=1; AKwUvBzv6y/b+GwaSrmcRWKL4PoouoCAGGj8VMi9VtzCE/iTePQqAIx95S9jPFxnXWAgO1A9u88=@vger.kernel.org
X-Gm-Message-State: AFq9FYIiVh1ZvvfqaZ2drmU0dQpb8c71Fmb2+PKlEOgJYDWexfohjylA
	Qw70G96HWi1gCG8na4LcLH2Kpg2ATDkGo1lHx7rEjJHBt0N/NfsfGk3+sZ+6OIYxNtJlbpGSriL
	I0aYm+HX/DSeRTe217V1sHGDHsQ==
X-Received: from dlep17-n2.prod.google.com ([2002:a05:701b:4591:20b0:14a:c841:ce30])
 (user=almasrymina job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7022:e11:b0:145:3a5:d918 with SMTP id a92af1059eb24-16a640fd0admr7318681c88.33.1791603391029;
 Fri, 09 Oct 2026 20:36:31 -0700 (PDT)
Date: Sat, 10 Oct 2026 03:36:07 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
Message-ID: <20261010033630.1171692-1-almasrymina@google.com>
Subject: [PATCH net-next v3 0/2] net: netmem: document design principles and
 intended direction
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

Because the networking stack and drivers are only partially converted to
netmem_ref and current memory providers only supply unreadable net_iovs,
automated code review and analysis tools (such as LLMs) frequently infer
the wrong architectural invariants from existing code. Specifically,
they often assume that page_pool's struct page APIs are primary rather
than legacy wrappers, that memory providers always imply net_iov, that
net_iov is inherently unreadable, or that callers should branch on or
downcast netmem_ref directly.

Document the intended netmem, memory provider, page_pool, and skb
fragment design principles concisely in the relevant headers, code
comments, and netmem documentation so both developers and automated
tools follow the intended abstractions. This series adds comments and
documentation rather than performing a large refactor all at once, so
that future incremental changes nudge the codebase in the intended
direction.

This reflects my mental model of the netmem, page_pool, and memory
provider architecture; I welcome feedback and disagreements,
particularly from major contributors to page_pool and memory providers.

Cc: Luigi Rizzo <lrizzo@google.com>
Cc: Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org>
Cc: Stanislav Fomichev <sdf@fomichev.me>
Cc: Pavel Begunkov <asml.silence@gmail.com>
---
v3:
- Collect Reviewed-by/Acked-by tags from Bj=C3=B6rn, Pavel, and Stanislav.
- Clarify skb fragment homogeneity rule: all frags in an skb must either
  be struct page-backed or belong to the same memory provider instance
  (Pavel Begunkov).
- Link to v2: https://lore.kernel.org/netdev/20261008023030.1089616-1-almas=
rymina@google.com/
v2:
- Document both current implementation status (memory providers currently
  supply net_iov, and net_iov is currently unreadable) and target design
  principles, and clarify that new code should generalize existing
  limitations as much as possible (Stanislav Fomichev).
- Link to v1: https://lore.kernel.org/netdev/20261005004958.3603059-1-almas=
rymina@google.com/

Mina Almasry (2):
  net: netmem: document netmem and memory provider design in comments
  docs: netmem: document netmem and memory provider design principles

 Documentation/networking/netmem.rst     | 53 +++++++++++++++++++++++++
 include/linux/skbuff.h                  |  6 +++
 include/net/netmem.h                    | 30 +++++++++-----
 include/net/page_pool/helpers.h         | 18 ++++++---
 include/net/page_pool/memory_provider.h | 10 +++++
 include/net/page_pool/types.h           |  6 +--
 net/core/skbuff.c                       |  4 ++
 7 files changed, 109 insertions(+), 18 deletions(-)


base-commit: d8674294aefef02266c4d47ad10131f1bffbe534
--=20
2.56.0.385.gd3acb90ef8-goog

