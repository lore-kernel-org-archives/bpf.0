Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 027CC38A733
	for <bpf@vger.kernel.org>; Mon, 20 Apr 2026 10:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776682713; cv=none; b=VUfB/Rz5Mc/v6oSAIooqfatEqX8qOqtoI+RMw0kCuaLQtmKVzyjUrE2org3e12/cfk+gdQvPHu6cPKN3OLKaAQKWPxJbukvujpopNI86CbctozYoYJK9djywB3pLSizXJLyLPP15PeCXGHsvBWM7NPH0FS+qVypIAhzyA1F7R8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776682713; c=relaxed/simple;
	bh=jeNe6hoVFvSWp1WGUu4CvjQgGHlygFkkp2Jz+ownf9E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Oro3u6O9syvl1mYqz+GRzGvZ4afsEqL9Mxgg0R7M13Du02HTFAOt+I6m3Y4J8zt3Kv07fH1ET6jQRD3mXnvb4LztRzAcUodrxhZqCxK1LM2VXP8vhvWWRi3iHSFkftXSMdjrX6AkbOyOdrpz0Xj775vMU4PYGUAllDVSksjd2w4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TqqLys1i; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TqqLys1i"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-488e1a8ac40so38967435e9.2
        for <bpf@vger.kernel.org>; Mon, 20 Apr 2026 03:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776682710; x=1777287510; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mSip2mFo5UpUa5K/ga6S7Tqbsc6g4uU5VZLY4tip40A=;
        b=TqqLys1iJM4sTOPZfTjaqobStjkvZ/Zpiln+pUcYqaiSTBaK8amwfTrhA5c3N4DP/A
         yqEtJdQ2jnXB8Do28HaagK3G+WSgmqcNdOvZ6jGEqOul3tlAnFtLPTOV7OID865vcU8n
         u641aYqnr7amhEY9t5qBHFtnXWlE88jhRB52ThSCGm1fJ3v5YOf114t4JNabJ0G+pTSX
         DCCy8ajmrI48NF+FQE07lw7UXRKESBeCWDU1OjJ2nqIqHxKeNa2+B2I5gOX5BqzXt/BL
         J1k/XwXmNeO6CmQGksPfr3QbDMphxDIgllEjAXtfSEXCKtqZm5v8h7NE+C0OEcOKmBm9
         PNTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776682710; x=1777287510;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mSip2mFo5UpUa5K/ga6S7Tqbsc6g4uU5VZLY4tip40A=;
        b=rA7qsAwz/28WNlx8MuCfuPpwO9T6iZj/s+cuOmc7EODSWp1CTDs5eyiYnBheSysLlL
         aclBvKgKy31IOZC+N964XZzLsDb5o8VUc4qEZtztJ/U4wzSClg+jkqsSDHdIVmKQWG4t
         7GsG0/HsVD0WLiwRHIZzeyBkyepvFmNlC2XgPmw508/lx5yWBcYJriJqTuuabnRtNzrG
         lm5iuOlAzGkgMTHVjnDk6ScmeU4YKv0xKHnXoVDoHX+rdZBF2RtUCeQLMs5/g16UiyuA
         tyvHXnofj44AN9+eB0K8uFDh5xKIUdSwgYa0SbmBcSCzuWC6laY+JTsI/PPzVjg/2xnt
         NpaQ==
X-Forwarded-Encrypted: i=1; AFNElJ/Dutz+bgyfYZcRTcJdZtf/t70RrM9ebbM0E0VV9RR7zS72gS11r0Lbm6xE4jQcmOYjyk0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyB5K8+fYucHHOd5pdCeL1KDvYFv4WWRtK+gN1moPOQvJucWCB7
	GI7/A5ypxW6mc9OfE3E6R15zz/c1uWG6JRcFxOqpNSg/nqtGPfmLzsV6XgBw5slHEAg=
X-Gm-Gg: AeBDiev6DdsXxgwqWBKIxiwpOxaWMaaMv9RXSe7K8uSz325k7ajjvqNsMG8t75cuZ/C
	OF+wrgff6caTfiDjFkw+HkDqAtwd69pare94IDiAiEgrC+ZBYsro1/zfBiqIb6yIhqCmRhKKVTX
	9V+SBGtPCTtEG610nSUFIzuATFvM+aJITPB1vEv3uzv7tL4gyt30B7JAeR8iaEk6LT2tIgdDuC0
	gglixqjMJVXEo+xjAcYH70D5Re1tUfbm0z62jxFG0BXfCJVDY8H5FCSCGGc1mq1tjH5wMz6ry6u
	Fc1/S/0k8FrZQT35Qzchlq2fQavrMqRcH76fIbAYf2BPk8ls+yuAp0vz6zYdiDrhYHMbsfylo6W
	9DNDur0V8Ro1Ug4pVijzbt13M14U6Mhy0YV7QVBFKbse0UuEYDeWNOIobfHn1qOY3cki/pY1ncp
	/2zl/FaOzyFXODSGHK2wnurddyHRfykTTbCsQpKg==
X-Received: by 2002:a05:600c:c108:b0:488:a82f:bbb6 with SMTP id 5b1f17b1804b1-488fb78e576mr125872725e9.27.1776682710104;
        Mon, 20 Apr 2026 03:58:30 -0700 (PDT)
Received: from mtardy-friendly-lvh-runner.local ([2600:1900:4010:1a8::])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-488fc1cfbf2sm290929495e9.15.2026.04.20.03.58.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 03:58:29 -0700 (PDT)
From: Mahe Tardy <mahe.tardy@gmail.com>
To: mahe.tardy@gmail.com
Cc: alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	coreteam@netfilter.org,
	daniel@iogearbox.net,
	fw@strlen.de,
	john.fastabend@gmail.com,
	lkp@intel.com,
	martin.lau@linux.dev,
	netdev@vger.kernel.org,
	netfilter-devel@vger.kernel.org,
	oe-kbuild-all@lists.linux.dev,
	pablo@netfilter.org
Subject: [PATCH bpf-next v4 0/6] bpf: add icmp_send_unreach kfunc
Date: Mon, 20 Apr 2026 10:58:10 +0000
Message-Id: <20260420105816.72168-1-mahe.tardy@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <aI0MkNvWlE4FXMV8@gmail.com>
References: <aI0MkNvWlE4FXMV8@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

This is v4 of adding the icmp_send_unreach kfunc, as suggested during
LSF/MM/BPF 2025[^1]. The goal is to allow cgroup_skb programs to
actively reject east-west traffic, similarly to what is possible to do
with netfilter reject target.

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

Initially, this kfunc was added only to cgroup_skb programs, Alexei
suggested not creating its own kfunc set and adding it to the more
global bpf_kfunc_set_skb. Now that recursion is handled and I realized,
thanks to Martin, that fetching the dst route might be only useful in
situation in which the packet was not yet routed, I decided to extend
the kfunc to more program types and route the packet only if needed.

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

[^1]: https://lwn.net/Articles/1022034/

Mahe Tardy (6):
  net: move netfilter nf_reject_fill_skb_dst to core ipv4
  net: move netfilter nf_reject6_fill_skb_dst to core ipv6
  bpf: add bpf_icmp_send_unreach kfunc
  selftests/bpf: add icmp_send_unreach kfunc tests
  selftests/bpf: add icmp_send_unreach kfunc IPv6 tests
  selftests/bpf: add icmp_send_unreach_recursion test

 include/net/ip6_route.h                       |   2 +
 include/net/route.h                           |   1 +
 net/core/filter.c                             |  85 ++++++++
 net/ipv4/netfilter/nf_reject_ipv4.c           |  19 +-
 net/ipv4/route.c                              |  15 ++
 net/ipv6/netfilter/nf_reject_ipv6.c           |  17 +-
 net/ipv6/route.c                              |  18 ++
 .../bpf/prog_tests/icmp_send_unreach_kfunc.c  | 202 ++++++++++++++++++
 .../selftests/bpf/progs/icmp_send_unreach.c   | 100 +++++++++
 9 files changed, 426 insertions(+), 33 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/icmp_send_unreach_kfunc.c
 create mode 100644 tools/testing/selftests/bpf/progs/icmp_send_unreach.c

--
2.34.1

