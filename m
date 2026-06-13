Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4D6117A2EA
	for <bpf@vger.kernel.org>; Sat, 13 Jun 2026 22:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781390909; cv=none; b=UEu+x3OVjEb3kLkOBd44bcq4D9yIbRFLPNXf9v4IOIbPe8WAZ+xooVvBiCjvGLdrAyBBl15Z48IZWeyhC1PP77OR9VpayioFEkEsbEQ6uWtnl43NC3rW86V8a47IJtQtuVZXDKqL8AGtXcSYHncbYGOzgJrwW5DTRVftC265CSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781390909; c=relaxed/simple;
	bh=d5fX4qIbgXRNZdaC9K1ucEiP0A07xoskHV2sDuv0M1A=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=aE9DHhzz6uTFB2/8y44gYAGrA3XHOvQiq3DrsW6xsVSgc5j3b3AkgPE26pdGoTwuDUyhe8NGEg+JgLYc2fIQuhvLZZPbBA3Hxvu+rmJ9+apIzghq2pNRI6gNt5ZMSdsqZmRDrovDuwDYAExC/cE8fclOPAP0uQlQ7ZxfDx/2EvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fSEu+eaw; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fSEu+eaw"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-84256bee9a9so1435545b3a.1
        for <bpf@vger.kernel.org>; Sat, 13 Jun 2026 15:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781390907; x=1781995707; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=aL2b3deTS0RPd2vEcIj2m3DwJ9yZbae4RFnSu+99SDA=;
        b=fSEu+eawRWzqBETMeUVuZAaPjkt9iYC+zVGVXjwKLpd0bWLK+Rg6of8TQLWH3TOmSF
         6uFZ6vftj4eImdI3KG4OkeTFzqA/gcFjmNKuEeCZ3InzcWdkr/WzRvRpqFr8BtTH6Cqk
         i4GZnMJl4rvrDc6UVTqLJ57Xgt04OaTIIhbUyVEn3gILGBoFaxCek8X9L/uqE136zNh5
         fw5amXC8IljP4OdxkIfT7XcSMqz9CXTUPdQt5SZe6GZd5vDdolIXUl3adca61tlZBctf
         ShQ0ZPA0FFdMnRtqlbA+9K+qRdrf2lvzvzdROR6DQ72wbkGDXdbPZPnFbF6TLYzKh9R6
         dfxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781390907; x=1781995707;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aL2b3deTS0RPd2vEcIj2m3DwJ9yZbae4RFnSu+99SDA=;
        b=pJPJDvIKWDxnZk5aw6MeuWDmwdnxIlVeGpE+Fqxy/VAUn1lpsKQiB2WvSCOBcTd0vI
         3x6x78Gb6qCyEKOdRG64IK/hlbBbpnwafvaBnrT3dQUv3D9yzzCAjCjceOiEMHXek+xi
         0IDTvcoNvih8L3xQwNvRkh1snRmu1SB6/MAn2/xfDpJ94wG+sm96XzP6MDz8tNXGB0zC
         1W4lNwgXs7LsHri+HhNcgsBmCIvg73W1O7SvVC6405W6eKQmM/IRoOIHq2ArxElhP2GF
         yp7wsMgt5A701C3xRhFVCqPjCr/tsTarOam0b49CI7nG5kzAp59u/dDR7s9DITOVJTvM
         SPKQ==
X-Forwarded-Encrypted: i=1; AFNElJ9Xk7Sxqv0RptRSahe2kek8eBoj3WwTHagshWauyriVhsqv/9Oe3aV6zyds8Dr3ZXZ877g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFhjgBIrWpU6uzbwe/u/4bix2mCd2wSj4+8A51lu4aC6gS9Bvn
	kfd0W5Rg97iCBQMBjPaZYQ0L+QHLVH5vb9UiIu1UKRhM+9IYVycBRfnKwWbUMK59i24f37kliHR
	aLI08ng==
X-Received: from pfbea27.prod.google.com ([2002:a05:6a00:4c1b:b0:842:3b3a:5198])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:198d:b0:842:66af:5bf2
 with SMTP id d2e1a72fcca58-844e1a98edcmr5092893b3a.38.1781390906763; Sat, 13
 Jun 2026 15:48:26 -0700 (PDT)
Date: Sat, 13 Jun 2026 22:48:04 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260613224823.2399535-1-kuniyu@google.com>
Subject: [PATCH v3 bpf-next 0/4] bpf: Support RX/TX HW timestamp proxy.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Stanislav Fomichev <sdf@fomichev.me>, 
	Andrii Nakryiko <andrii@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Eduard Zingerman <eddyz87@gmail.com>
Cc: Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	Jiri Olsa <jolsa@kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Willem de Bruijn <willemb@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

We have some hosts where packets come from special hardware
and are provided directly to userspace, bypassing the kernel
networking stack.

When standard socket applications are run on these hosts,
a userspace proxy is required to mediate traffic between the
hardware and the applications.

            +---------+                 +----------------------+
            |  proxy  |                 |  socket application  |
            +---------+                 +----------------------+
              ^     ^                               ^
  userspace   |     |                               |
  -----------| |-----------------------------------------------
             | |    |    +---------------------+    | skb
             | |    `--->|  virtual interface  |<---'
  kernel     | |   skb   +---------------------+
  -----------| |-----------------------------------------------
              |
              v
       +------------+
       |  hardware  |
       +------------+

However, even though the hardware fully supports timestamping,
the HW timestamps are not directly accessible to the socket
applications because the skb is consumed/injected by the proxy.

This series extends ethtool and adds BPF kfuncs to transparently
support HW timestamp on such a setup.

Patch 1 is misc cleanup.

Patch 2 & 3 add kfunc to proxy RX/TX hwtstamp.

Patch 4 is selftest to demonstrate how it works.

Note the test requires this iproute2 commit:
https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=c9a9f12aa619288fd3d4e16bc4b3c73b655a4efe


Changes:
  v3:
    * Drop ethtool patch and rebase on bpf-next.git
    * Patch 4: Drop bpf_kfunc.h change

  v2: https://lore.kernel.org/bpf/20260613010039.1362312-1-kuniyu@google.com/
    * Patch 3:
      * Remove __packed and use unnamed bit-field in struct bpf_hwtstamp (Alexei Starovoitov)
      * Use skb_unclone() instead of skb_heaeder_clone() (Sashiko)

    * Patch 4
      * Remove __packed and use unnamed bit-field in struct bpf_tx_tstamp_cmpl (Alexei Starovoitov)
      * Check !skb_at_tc_ingress() in bpf_skb_complete_tx_tstamp() (Sashiko)
      * Use skb_unclone() instead of skb_heaeder_clone() (Sashiko)

    * Patch 5
      * Use scm_timestamping64 (Sashiko)
      * Correct saw_tskey check (Sashiko)
      * Fix retval check for bpf_skb_get_tunnel_opt() with (int) cast (Sashiko)
      * bpf-style comment

  v1: https://lore.kernel.org/bpf/20260612001803.23341-1-kuniyu@google.com/


Kuniyuki Iwashima (4):
  bpf: Rename bpf_kfunc_set_tcp_reqsk to bpf_kfunc_set_sched_cls.
  bpf: Add bpf_skb_set_hwtstamp().
  bpf: Add kfunc to proxy TX HW Timestamp.
  selftest: bpf: Add test for hwtstamp proxy.

 include/linux/filter.h                        |   2 +
 include/linux/skbuff.h                        |  13 +
 include/net/tcx.h                             |   1 +
 include/uapi/linux/bpf.h                      |   1 +
 include/uapi/linux/pkt_cls.h                  |   3 +-
 kernel/bpf/verifier.c                         |  13 +-
 net/core/dev.c                                |  39 ++
 net/core/filter.c                             |  98 ++-
 .../selftests/bpf/prog_tests/proxy_hwtstamp.c | 588 ++++++++++++++++++
 .../selftests/bpf/progs/bpf_tracing_net.h     |   1 +
 .../selftests/bpf/progs/proxy_hwtstamp.c      | 236 +++++++
 11 files changed, 988 insertions(+), 7 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/proxy_hwtstamp.c
 create mode 100644 tools/testing/selftests/bpf/progs/proxy_hwtstamp.c

-- 
2.54.0.1136.gdb2ca164c4-goog

