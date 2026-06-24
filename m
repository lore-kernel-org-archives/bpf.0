Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA9ED3321C2
	for <bpf@vger.kernel.org>; Wed, 24 Jun 2026 18:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782327378; cv=none; b=mWktUoe8S+PTerVftBWnfy1CsktaoapK3a1tLlI7WqbIoD7ccvuQVAshxFLj7FwqAqDSwszx27wW3biqK7k/iEmeU61MtAEdQ7EO8H3hwgbUErQUowImaJ7gTK8igtRNR3JujjeMs6vCj3Tpp0tunpPFWIWj6wKZa4NasDxKgzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782327378; c=relaxed/simple;
	bh=Kdx5Cvo80yBrE9miDoObIk1QFmrUE3vEdimxcx2Po2M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lIYS2d/fTmDD2UhOxGyMy2SEmrcXEAqFIalyVy4OsLOeygQDAe619l6DM9Lf49xzCH14UcCUctOX9C4jNz9gxgsnqHqnGbTxk/kKfQ4wdKuKPUA+TdQqd7SbAMp2FJHspNJZzMXxEZSYuiOo2XhSBdkytBG0/7YL1bkL+O4ERtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r6YhvxrB; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r6YhvxrB"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-490ace40f4bso14205345e9.3
        for <bpf@vger.kernel.org>; Wed, 24 Jun 2026 11:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782327375; x=1782932175; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rKSs+yVAmzkC+EEs8lh4IjRQg/Tw4ScAMPUAGK+bsF0=;
        b=r6YhvxrBFxUq3jWH/VLCeqFNLOky7P1PUtuHeQUv5PDFYJUjXFnc19RjoPuI3JJ0TT
         ChmAWt76xDYH5Hne3Z2nRGPtucwIWUpJxZpYbkiKEqEBOdFSvqkVVjqpftFc4BpB5A7/
         eZp6CTGBFv7ZeiSd2FyTK/KIR0f8/fQP/F/A0TlWCLOrC8PxRNC3Z5/O9Jb7mdllwE5T
         eToMQQBDx88RwGFxwaXMbMMnb5792mQt+T7D8p+U5IlKREi1YUYy0Yx8akgfTp+qhB3f
         9FimfQJi6sU1cPyV1EtzgSDRHDZIir7t3Tfs8zVIJnVpvN2yoTpKevRMlnieidNabh5T
         oXOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782327375; x=1782932175;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rKSs+yVAmzkC+EEs8lh4IjRQg/Tw4ScAMPUAGK+bsF0=;
        b=rnvzEY61U4k4VI3ZTYPbl7RLeeG53Vh/bVraWuwbA7+vYhUB69MjeHXLEiueJe3COw
         wC2Qsp+pfbMbTW+lbtmiQ9Hfqi54l35f49BvW1V/5JHSv7WVAqig9LBi1ze2ZaDsC8XV
         40dFlvCraROzcWX1FP9e9Cz0h4PNK3P4P0SRvwCsdGzG2x0pt4YE2xQANlSgrqpyzvTO
         /spiKuZBFRCRBIqoGMIiCTrgsrEFwzJFn6KwaM1s8MISdMP+mV+liPMMm/UBhtZ1ArPy
         keOZe01MOWcYdlXikxStXQCR/blIS+Qkgu5Xdl6/f4Kt6QHI8rwQORwMrHjz1c/bkoyp
         CjbQ==
X-Gm-Message-State: AOJu0YwBPn9Ki3Khug9v2aSbF/+ar2G/6B8s3PXxj1kfbx4ec0+dD2Nl
	TqxiHiXl7HntqAKwN0ZWDt1qp33yFMCtZEkJYnOwp9D9ewrytddmPfU/wNW8OapP
X-Gm-Gg: AfdE7clJgEHQ6lBPHzesXDhpW58iwR3xBx5JiQvKbK9YtCYkOYzuWFvyiy0ldM9zPqz
	vUTtOc2CAgTbvZI4ecdv0+FM5566nhmeP/dFd989WHKNznWhVzDYdZ8rEjNBZ54YtjONHhH7301
	irW79ZdewVABtX2YDCZVKDxRtjvjba4Ba5qACTTVkW9LpAAAtfqbpIe3M4Lb/zb/OA6iilA9TRg
	UQYCEOIS9sMDDHleOHewU6sN7JN++Agr3g1ecYoeQvuMisFUrcAaevQc62KtuBItt2GXBPPa9uT
	QM83vpD+cSbKolJrDwmaLrecM6eyiUF4XuiIEugUdPMuV3imStyZLfHLQ6NnSh1c2P471frIkOD
	Rq7Y4XPe+LpAIn0/JkIcwLDXqgvicwlHiFOTNH8u3KScqIkt9SQGoYs4yfG5A5J/WgmIyhPW+1d
	rzjd0nNNZmGeWTThru
X-Received: by 2002:a05:600c:c48e:b0:492:46c2:f5b4 with SMTP id 5b1f17b1804b1-4926087d300mr67148825e9.32.1782327374945;
        Wed, 24 Jun 2026 11:56:14 -0700 (PDT)
Received: from mtardy-friendly-lvh-runner.local ([2600:1900:4010:1a8::])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4926417f0c7sm9847805e9.14.2026.06.24.11.56.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 11:56:13 -0700 (PDT)
From: Mahe Tardy <mahe.tardy@gmail.com>
To: bpf@vger.kernel.org
Cc: andrii@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	jordan@jrife.io,
	martin.lau@linux.dev,
	yonghong.song@linux.dev,
	emil@etsalapatis.com,
	Mahe Tardy <mahe.tardy@gmail.com>
Subject: [PATCH bpf-next v9 0/5] bpf: add icmp_send kfunc
Date: Wed, 24 Jun 2026 18:55:49 +0000
Message-Id: <20260624185554.362555-1-mahe.tardy@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

This is v9 of adding the icmp_send kfunc, as suggested during LSF/MM/BPF
2025[^1]. The goal is to allow cgroup_skb programs to actively reject
east-west traffic, similarly to what is possible to do with netfilter
reject target. Applications can receive early feedback that something
went wrong during the TCP handshake.

The first step to implement this is using ICMP control messages, with
the ICMP_DEST_UNREACH type with various code ICMP_NET_UNREACH,
ICMP_HOST_UNREACH, ICMP_PROT_UNREACH, etc. This is easier to implement
than a TCP RST reply and will already hint the client TCP stack to abort
the connection and not retry extensively.

Note that this is different than the sock_destroy kfunc, that along
calls tcp_abort and thus sends a reset, destroying the underlying
socket.

Caveats of this kfunc design are that a program can call this function N
times, thus send N ICMP unreach control messages and that the program
can return from the BPF filter with pass leading to a potential
confusing situation where the TCP connection was established while the
client received ICMP_DEST_UNREACH messages.

v2 updates:
- fix a build error from a missing function call rename;
- avoid changing return line in bpf_kfunc_init;
- return SK_DROP from the kfunc (similarly to bpf_redirect);
- check the return value in the selftest.

v3 update:
- fix an undefined reference build error.

v4 updates:
- prevent the kfunc to be called recursively and add a test (thanks to
  Martin).
- do not fetch dst route when unnecessary (thanks to Martin).
- extend the test for IPv6 (thanks to Martin).
- use SK_DROP in examples and use non blocking sockets for testing
  (thanks to Martin).
- test when the kfunc returns -EINVAL (thanks to Jordan).
- add the kfunc to bpf_kfunc_set_skb as suggested by Alexei.
- guard the IPv4 parts with IS_ENABLED(CONFIG_INET).
- fix a wrong initial value for client_fd (thanks to Yonghong).
- add documentation to the kfunc.
- to Jordan: I couldn't include <linux/icmp.h> because of redefines from
  <network_helpers.h>.

v5 updates:
- kfunc name is now icmp_send and takes the control message type as
  parameter for future potential extension (daniel)
- drop the net patches to route packet since now the kfunc is limited to
  cgroup_skb and tc progs (daniel & martin)
- linearize skb headers (sashiko)
- zero SKB control block (sashiko)
- bind to port 0 instead of fixed port (sashiko)
- poll to wait for POLLERR event (sashiko)
- do not use ASSERT_EQ in CMSG_NXTHDR loop (sashiko)
- fix comment about byte order (sashiko)
- fix endianness IP address issue (sashiko)
- add forgotten cleanup_cgroup_environment (sashiko)
- let packets pass in recursion test (sashiko)
- clarify evaluation order for recursion test (sashiko)

v6 updates (all from sashiko):
- bring back the net patches to route packet since tc ingress needs it.
- rename the ip_route_reply helpers from fetch to fill.
- call pskb_network_may_pull on the cloned pkt.
- check explicitly that we received one and only one ICMP err ctrl msg.

v7 updates:
- use consume_skb on success path (stanislav)
- replace recursion protection with CPU_ARRAY by checking the nature of
  the sk (daniel, offline)
- use reverse xmas tree in read_icmp_errqueue (jordan)
- use ASSERT_OK_FD instead of ASSERT_GE whenever possible (jordan)
- add a test for tc (jordan)
- better filtering from host cgroup test progs (sashiko)

v8 updates:
- mostly a resend as it's been sitting as "New" in the queue for almost
  one month, fixed a few nits.
- on new bpf_icmp_send kfunc cgroup_skb test (patch 4/7):
  - guard a close fd with fd >= 0 (jordan)
  - use ASSERT_OK_FD instead of ASSERT_GE (jordan)
  - fixed comment style (sashiko)
- on recursion test (patch 7/7):
  - guard a close fd with fd >= 0 (jordan)
  - fixed comments style (sashiko)
  - filter bpf prog on pid and ICMP message types (sashiko)

v9 updates:
- first, there was a v8.5 that I discussed here[^2] with Emil
  Tsalapatis. I tried once again to make tc work but the ai review found
  something fundamentally wrong. This version removes the tc support for
  now and focuses on cgroup_skb.
- use helper get_socket_local_port instead of getsockname (sashiko)
- use if_nametoindex("lo") instead of value 1 (bpf-ci)
- fix IPV6_RECVERR appearance before IPv6 patch (bpf-ci)
- precise that 0 on success mean icmp_send was called but it was just an
  attempt since this function does not return anything (sashiko)
- explicitly consider ICMP_FRAG_NEEDED as invalid in bpf_icmp_send as
  it would miss the next-hop MTU info. Also test it. (sashiko)
- test for max_code + 1 for invalid (sashiko)
- add review-by tags from Jordan and Emil but remove it on the main
  patch as I have significantly changed it.
- check for rec_count in recursion test (sashiko)
- re-order setup_cgroup_environmment in test (sashiko)
- reset kfunc_ret on every test run (sashiko)
- check for skb route for icmp_send as the function would quietly fail
  and add a test (sashiko)

[^1]: https://lwn.net/Articles/1022034/
[^2]: https://lore.kernel.org/bpf/ajvDRCw8cPqXAqQq@gmail.com/

Link to v8: https://lore.kernel.org/bpf/20260622120515.137082-1-mahe.tardy@gmail.com/

Mahe Tardy (5):
  bpf: add bpf_icmp_send kfunc
  selftests/bpf: add bpf_icmp_send kfunc cgroup_skb tests
  selftests/bpf: add bpf_icmp_send kfunc cgroup_skb IPv6 tests
  selftests/bpf: add bpf_icmp_send recursion test
  selftests/bpf: add bpf_icmp_send no route test

 net/core/filter.c                             |  91 ++++++
 .../bpf/prog_tests/icmp_send_kfunc.c          | 269 ++++++++++++++++++
 tools/testing/selftests/bpf/progs/icmp_send.c | 123 ++++++++
 3 files changed, 483 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/icmp_send_kfunc.c
 create mode 100644 tools/testing/selftests/bpf/progs/icmp_send.c

--
2.34.1

