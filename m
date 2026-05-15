Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5BFA3E4C6D
	for <bpf@vger.kernel.org>; Fri, 15 May 2026 07:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778829312; cv=none; b=e4J07wBgeYIp/NUOpUTkd90e6dgpM6qh1oc5PHVJrqi5GjYf2oGf+4tgQYxdUmwOhPunkNYiEseOugN8URqgck06hufEu/L0j6pnTa72av3pRDaDgJuvnCdDip47qjaF0eexVUbEpAKbKWmW2YfruDQQv+29bSGwFWLuT0QWweo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778829312; c=relaxed/simple;
	bh=Axb/0pbJ/VyfIOcxWuDbeeOEwg2vW6Bh+JuU1OIKTHY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=HbZOG3aasvX8KiPbtxrLwunn9gkqkinWTpYoi50UU8MkoApA2N6dzPVAG//jDovawk7rEwmVrn2ZdHPnyMrqSMEMo8A6qtst1hAxYr3Idi6HH17HLiFU482isxxhq8fciQY8bnNOVML/bAv3ijQRm+HbotlWKhpyHSNdrnFJc0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yuyanghuang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KMhiRBKB; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yuyanghuang.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KMhiRBKB"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-82f6b984b3aso4648172b3a.3
        for <bpf@vger.kernel.org>; Fri, 15 May 2026 00:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778829310; x=1779434110; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=b60C8WdQQr2ioruztJqeYk2pAgOPDbQ8o/5tZldjQqs=;
        b=KMhiRBKBuCsaUIrMFo9FpT82Q6PLHFoa0GAcDSwXqvcIhV83SpMgaI24TLAXe94FqJ
         ZtRw3nnNuzDrwU5uq6G6LNwiY2lkdvsBsG7ND5hBCtQpqfVIqv7khruS8b4DWgOVuVdm
         ThwyyrvNCrxGa+SkLFv+7uEty1kiG3FcHz5KanBduR6lYLiMv4JGyG26zqSD/2l2UjCt
         aRHSebOSeX48UBX/KdpG7/8t4ufdB5wSchfRy9Qfp8S70oifdiqjZa7K1+1K6WqVTAbG
         SoSV49I0KNkZgaJxul014XBBGNzN2K5IwRlLiXDqpr5oDVEOxI1erOxZbR8LTrDKs8uZ
         Yq4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778829310; x=1779434110;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b60C8WdQQr2ioruztJqeYk2pAgOPDbQ8o/5tZldjQqs=;
        b=l2o9rNp82hoKk6bzF+fuqJzTdf/cdxVm03x0uBSFVg/cKpCRTrfYXJ9bg8aBerGrH3
         MPcJl7X+i0no5ZA5Ncjf08/584udLzm2+eaO0mZuwhjml5H5jfcbkleGa0ACXo+NyuNy
         dTxq4nK/Z0f/zLQsc7u/tEbY5xAZuQEm3jqSE6ylCIxbwVVokZAZ1jSXZq7XLi1w2yYQ
         SOVuZ0S0CZXxntMznjcFq/LM89kaBH00igHEJD7Zprxa490grK3acL3tNHdRn40LwiBz
         DoSO90dMruRc76IxgAlTIyGa8tN7OiL/DyZXwCUEZh1BVFXHEupbk9khA+z/dxvA7L3q
         /buA==
X-Forwarded-Encrypted: i=1; AFNElJ9VrpS6N/dgdUjN7MrFSYnFCJdRxvKiD7qte0tHXOIj6MqZ06l3iRs9tie8Sn/BNAA4H4E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7HM0sAL2nIv77O1B/EIPawSOIr+6L41sKZ+F1hMoChKXskrDS
	GX7RmsIY79uMMgdb/uK4zTZeJy89dBB5Q6aXrcTKrlmkJXqCegI+GXKynfkPvYD/yYZgzLyy/aj
	Tb82N6EqU3acrqnXnnBkvKt4Cmg==
X-Received: from pfay22.prod.google.com ([2002:a05:6a00:1816:b0:82f:7ce1:182])
 (user=yuyanghuang job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:3a01:b0:838:c01a:7a46 with SMTP id d2e1a72fcca58-83f33d8cd6bmr3035462b3a.26.1778829309681;
 Fri, 15 May 2026 00:15:09 -0700 (PDT)
Date: Fri, 15 May 2026 16:15:02 +0900
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260515071504.2054786-1-yuyanghuang@google.com>
Subject: [PATCH bpf-next 0/2] bpf: Align syscall writeback behavior with
 user-declared size
From: Yuyang Huang <yuyanghuang@google.com>
To: Yuyang Huang <yuyanghuang@google.com>
Cc: "David S. Miller" <davem@davemloft.net>, Alexei Starovoitov <ast@kernel.org>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman <eddyz87@gmail.com>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Nikolay Aleksandrov <razor@blackwall.org>, 
	Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>, 
	Song Liu <song@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, 
	Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The bpf(cmd, attr, size) syscall copies up to 'size' bytes on input, but
several commands write outputs back to userspace unconditionally. If the
caller passes a short buffer, this can lead to out-of-bounds writes,
potentially overwriting adjacent userspace memory.

This series addresses this by introducing size-gating based on field type:

1) Mandatory fields (original ABI): Return -EINVAL in __sys_bpf() if the
   user-provided buffer size is smaller than the minimum size required to
   cover these fields. This hardens the syscall entry point for several
   commands.
2) Optional fields (later revisions): Skip writeback if the user-provided
   buffer size is too small to cover them. This is applied to
   'query.revision' in BPF_PROG_QUERY.

The first patch implements the plumbing and enforcement in the kernel.
The second patch adds a selftest to verify the behavior.

Yuyang Huang (2):
  bpf: align syscall writeback behavior with caller-declared size
  selftests/bpf: Add verification for BPF_PROG_QUERY attr size
    boundaries

 drivers/net/netkit.c                          |  5 +-
 include/linux/bpf-cgroup.h                    |  5 +-
 include/linux/bpf_mprog.h                     |  4 +-
 include/net/netkit.h                          |  6 +-
 include/net/tcx.h                             |  5 +-
 kernel/bpf/cgroup.c                           | 13 +--
 kernel/bpf/mprog.c                            |  5 +-
 kernel/bpf/syscall.c                          | 34 ++++++--
 kernel/bpf/tcx.c                              |  5 +-
 .../selftests/bpf/prog_tests/bpf_attr_size.c  | 84 +++++++++++++++++++
 10 files changed, 141 insertions(+), 25 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/bpf_attr_size.c

-- 
2.54.0.563.g4f69b47b94-goog

