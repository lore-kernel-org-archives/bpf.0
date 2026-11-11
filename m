Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794367311;
	b=KkpqH9hTHX0qhCRPr8HZD79zRobz8UKWJXvWgkDQCyYT+OTudA78wNPcEEuWmQO8ATsU
	 YGELEA4yfDezM+QOolj18ewjU4urQHIBUO5QQxB+3inWStQtT+zAJ5eqI+4ZU1pi2g//Z
	 OJykh3FR4jxS9ivC3/BsYkXHMXa/cJYo1bgpVfHLYYEXkpSTpmrRZszcnZb/7/l9XTVzB
	 YxMaYEKWHsWaqCJYkOMG3uHg4yXPJJ42uVHmDyURJzSpWsGPl9Uk9MtJLnExpCWG/to+K
	 4mw49BVXkmhVMOB+JSV3geul95RN0QYf1/ieB+AEhcyyiTC7HEUoI4oGYXQEDNfIHIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794367311;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=HHekPeqyGWTFP/9TlxTpM6xiARKQpfozn60WBx5Zas4=;
	b=0Yv8j7bdKQouslGXHgnqNUnyHW4IfHpBBlayspH5sNr3CzQsTpu3ND4Z4YhVR85dhQZj
	 WWPM5AbbVsoLpOBLXLtazJbb15+fVBn0PyhnYwA7BDpfNoXMAcCBzWB2vd5YrRzoU6XJv
	 nj/lrX2aoCcRXTYuFb8iiy4chDjEpygSxLaE8GA+pvQvDTbRN1DhMt8yZboL3UIfu4Epo
	 tVkmYxMgJsTyTmoS9+SYxTqc5HrtIBlbbHaq6GHVr+NWgln6e0U6eqYstrC8n9E5TDtMr
	 9B5nh7BWpRKHXYSEsu5EGmK7Qv+s+hUwoKIBvb6IhDuUL9EV+Uc3GKvFqHM7HAHRVkQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nCxf1X6m;
	arc=none smtp.remote-ip=74.125.82.169
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 962CD606A31C
	for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 03:21:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 962CD606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nCxf1X6m
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-36e99cf7bb3so4266302eec.0
        for <bpf@vger.kernel.org>; Tue, 10 Nov 2026 19:21:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794367310; x=1794972110; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=HHekPeqyGWTFP/9TlxTpM6xiARKQpfozn60WBx5Zas4=;
        b=nCxf1X6msrsrraBBBnOXfN/6taGnH+s/MLA5+HPoXXI+E7nv+EdZCuCv6bOptJwEhu
         xClAJvpHsRiq1/Si55X3QH+ntDagSvTeSR49DqvCulozxuL3DdwPB50PVfle1JA1r8k3
         VyN3DdLRB9NhsFNewq8C9WRuNUbFB/dn8P1xHnQ4InQAMDMX1dmnWmyc2bcKT+/7ZSMk
         hxtXl6dQdD46KD48dzLer+LvI4sl5M9FZqrEH+INLwS1ZY5LPH4iVQ2eqjDa6Mgk43uM
         3eLYVRFfNEmhy6X3UaRbDVtyIW7REMyFKCBIMD5xnhjqJBgNOxIAF/qAnjN+P8r7+Ewz
         i6MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794367310; x=1794972110;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HHekPeqyGWTFP/9TlxTpM6xiARKQpfozn60WBx5Zas4=;
        b=ZDsxMyTuyWByl3SltO8W9s/A/SQdfc1oNLc42PRd6t5ylmDM4xy9pMSeD/jmsxyIYw
         kW8ItmNlQGYgIy6YhKH7dR8NOcrpeSnmzVYMacbYFP8u6wYYd7ftgKk7bbDuTD0+AqJg
         Blbx4F/iYYzdKhOWQ9a2gqNTDkYCxTCJZKrmz6MDP5AyCVXE6CEk1xeEjZToKo/pAvzF
         /DlMMSorD0uGWqAP/wYpv9J/FnpztcFuKWtZ0kvTzIwGnR8Fdl5QQSp5issz24WdkHK7
         YgoJSnCJ3YMwBHr2bnYq+VSi2hMnXcry4oJ+24dmdHwV7FwYjVodSzBU8ilROhRBm9Qk
         VtjQ==
X-Gm-Message-State: APuU4Z9XGvrbrZMCmU+HK5hDFutq5qSg0aZijsZVW2VJKLTntgXlYi2S
	ptKSLUQPHbDA2KRIpQtst+t9cmNCOYNeQNp6gdZXLnSiTLK3xlHqdfgLE6nqpg==
X-Gm-Gg: AYBFou1grMIFJQdvzCKcdqL/nCOig6ZBLlx3RIqiiTuWIaFBddANhaVKZCR5oD3Xpld
	g5+xn8Oop3mUn1EQbN5XvfUt72zjG4mS4oYhlOJmTbT1dUVazVD79egmer9Ns+X77PMgm8F3tDy
	+rhh2Uf3aKmF+JHQbCQZOAs9X54SrydrvH38/Yh5xckhUw4LkkZZG+aUCcQEcc2PE+MUBDOp8W0
	YLzjpXbJ9exLQ2XrWFJq1IXyw5jx6jteM7xAF0K7+SFBW6EckTb4hmK72a8wlRbW9WmLXXC1Ihh
	sQdDX8D53Bxk4se2onDBG5Ux9MDX7q09OnCqQmVap62tQvsj1KXio1JCzDiPZMb4j/0N5FX6YhW
	f10CEPdc4jCpAmsCfSY5CbZMPp0l7t7Za8ahDEZwXFojj1KRQo9uDu1vFpCkQKIJkkU7JR9+5Ri
	pAyqCew5K0YV/I98mtH2q5+vAJc2rsyfMHiTjB7HfuK+MuM2e1nmpHYIWT1iuuHNHb5NZfiffRJ
	Eo0c7geh6BWEAb+snlKFk0Eu4luX58em4lBggiag+5t4Uq2oZIod2JlrV9wOBhAvVmWCP4IUGpk
	kbH2jtOdoumO8OhXZPK6Gx1TrIjDGSKMQ9QSsiWFsyErbCR0e8pDLYn8QSRqs2Z4KwyOArAJOEq
	BwAvIV8NF
X-Received: by 2002:a05:7301:6589:b0:369:e8b0:af85 with SMTP id 5a478bee46e88-3768701ccdfmr2376910eec.36.1794367309538;
        Tue, 10 Nov 2026 19:21:49 -0800 (PST)
Received: from build2026.lan (67.230.168.206.16clouds.com. [67.230.168.206])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3751ad6f11csm9801896eec.0.2026.11.10.19.21.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 19:21:49 -0800 (PST)
From: ThisSeanZhang <thisseanzhang@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	netdev@vger.kernel.org,
	Nick Hudson <nhudson@akamai.com>,
	Felix Fietkau <nbd@nbd.name>
Subject: [RFC bpf-next v3 0/3] bpf: Add PPPoE encap/decap kfuncs
Date: Tue, 10 Nov 2026 22:21:38 -0500
Message-ID: <20261111032141.525444-1-thisseanzhang@gmail.com>
X-Mailer: git-send-email 2.47.3
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

The motivating use case is a TC BPF PPPoE forwarding path. When such a
path forwards a GSO packet larger than the negotiated PPPoE MTU,
inserting the PPPoE header manually leaves skb->protocol set to the
original IP protocol, so the stack cannot select the PPPoE GSO path
and the packet may be dropped.

The kernel already supports PPPoE GRO/GSO for ETH_P_PPP_SES
(introduced by commit 55a5d8fca836 ("net: pppoe: implement GRO/GSO
support")), but a TC BPF program has no direct way to update
skb->protocol and the associated skb metadata when adding or removing
a PPPoE header, and bpf_skb_adjust_room() cannot decapsulate PPPoE
packets either, as it only accepts ETH_P_IP and ETH_P_IPV6. The
current workaround uses BPF_F_ADJ_ROOM_ENCAP_L3_IPV4/IPV6, which
marks the skb as IP-in-IP even though the wire format is PPPoE. The
BPF program must also adjust gso_size manually [1].

This series adds bpf_skb_pppoe_encap() and bpf_skb_pppoe_decap(),
which insert or remove the PPPoE session header and keep the skb
metadata consistent with the kernel's PPPoE GRO/GSO handlers; the
encap kfunc writes the PPPoE session header itself, mirroring
pppoe_xmit(), and the BPF program sets the MAC header's EtherType, as
with the existing BPF_F_ADJ_ROOM_ENCAP_* flags:

    bpf_skb_pppoe_encap(skb, sid, flags);
    bpf_skb_pppoe_decap(skb, flags);

Based on the v1 discussion about whether new UAPI flags were
warranted, this version uses kfuncs instead, following the existing
bpf_skb_set_fou_encap() interface. No UAPI changes are needed.

Since the kfuncs may reallocate the skb head, patch 1 adds the
KF_CHANGES_PKT flag so the verifier invalidates packet pointers after
calls to packet-modifying kfuncs, analogous to its handling of
packet-modifying helpers. bpf_xdp_pull_data() and dynptr writes retain
their existing handling.

The selftests cover IPv4 and IPv6 round trips, the PPPoE header fields
written by the encap kfunc, rejection of non-IP encapsulation input,
non-PPPoE decapsulation input, unsupported PPP protocols and truncated
input, and verifier rejection of packet pointers held across a kfunc
call. All 9 subtests pass in QEMU/KVM.

[1] https://github.com/ThisSeanZhang/landscape/blob/80bc43eef7143ad029283fe2a8d510718c22af12/landscape-ebpf/src/bpf/tc_chain/tc_pppoe.bpf.c#L38-L47

ThisSeanZhang (3):
  bpf: Add KF_CHANGES_PKT kfunc flag
  bpf: Add PPPoE encap/decap kfuncs
  selftests/bpf: Add a test for the PPPoE encap/decap kfuncs

 include/linux/btf.h                           |   1 +
 kernel/bpf/verifier.c                         |   1 +
 net/core/filter.c                             | 192 +++++++++++++
 .../selftests/bpf/prog_tests/tc_pppoe.c       | 269 ++++++++++++++++++
 tools/testing/selftests/bpf/progs/tc_pppoe.c  |  77 +++++
 .../selftests/bpf/progs/tc_pppoe_fail.c       |  36 +++
 6 files changed, 576 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/tc_pppoe.c
 create mode 100644 tools/testing/selftests/bpf/progs/tc_pppoe.c
 create mode 100644 tools/testing/selftests/bpf/progs/tc_pppoe_fail.c

---

Changes since v2:
- Replace the proposed BPF_F_ADJ_ROOM_ENCAP_PPPOE and
  BPF_F_ADJ_ROOM_DECAP_PPPOE UAPI flags with
  bpf_skb_pppoe_encap() and bpf_skb_pppoe_decap() kfuncs.
- Add KF_CHANGES_PKT so the verifier invalidates packet pointers
  across calls to packet-modifying kfuncs. bpf_xdp_pull_data() and
  dynptr writes retain their existing handling.
- Make the encap kfunc write the PPPoE session header itself,
  mirroring pppoe_xmit().
- Rebase onto the current bpf-next.

v2: https://lore.kernel.org/bpf/20261003193347.1137527-1-thisseanzhang@gmail.com/
v1: https://lore.kernel.org/bpf/20260926210757.2152159-1-thisseanzhang@gmail.com/

base-commit: 0fb18ce8a2e9de830433923cf65838933d615359
-- 
2.47.3

