Return-Path: <SRS0=RZwz=SR=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1B87C10F0E
	for <bpf@archiver.kernel.org>; Mon, 15 Apr 2019 17:38:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD4E62073F
	for <bpf@archiver.kernel.org>; Mon, 15 Apr 2019 17:38:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AiinhzaG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727844AbfDORiF (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 15 Apr 2019 13:38:05 -0400
Received: from mail-yb1-f201.google.com ([209.85.219.201]:32913 "EHLO
        mail-yb1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727490AbfDORiF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 15 Apr 2019 13:38:05 -0400
Received: by mail-yb1-f201.google.com with SMTP id k76so13748628ybk.0
        for <bpf@vger.kernel.org>; Mon, 15 Apr 2019 10:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=8OZWyLbntVLAx8NjP0nfocaXalVuTQ4aYxgNYzILyxY=;
        b=AiinhzaGXAhDX332hUNSgjaYxejtxhKVon0f64P4fkX5awOU+7GAfKHF3p/O4Mbx4S
         lr/eCmUaeoHdnXmpHzhC0cDaerfLTyUylK8VfWaSn7GXeRIPR5lE9R4nE2/1ZiA6qN1p
         pSA3BgN0T5AsrH0OVw7l0gsEV6jYfdWLm20E+DFqCCF3ceeYxcL9ntsL3J8i6XgE7n/m
         N4ibzghzdxQYWmBqi2U9NeNIeKSgZqT+0Bcm7lcOKVXYr2yi3kfNNztQGgA1lsUZcfdc
         cGvTUKLs7v1cDMzHdax4/l2lPcNGB3jt5lznXq2PfeQWFFSgz9XsOx4SEpGbSYl9+jv/
         w8sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=8OZWyLbntVLAx8NjP0nfocaXalVuTQ4aYxgNYzILyxY=;
        b=lMF20VGOyCHLQZ/6YFIK8hpiA0ys+gVFw8C9ormjlbyOYUO/Opm9RvGeA/hVqrZgyk
         YrIqob844jIPKxoh9UKw/vWjzLzQJtICGRiW8P4SwbKmGAPVigW70a8+/fEyuhW64QY5
         vrxLn5J8PC3Xtam2VtFQQK4TWmGrRDhQRTHvrK2HZJMlq8Yx9KgEoQYTZoa6kh74nIG5
         Ze5y3ZiqxgulTzN+x9EdsnN6Kt9caStBGWzmOhEeqHNoXmZHhtDXbZVfpzIw9qkmxxhs
         ucAceK1/IuygLB6RqekqOtayB4MQ7Nls5EOYcjvyGVnk7fspIPO7iRP4Y+HaQ3qEV8ss
         6Icw==
X-Gm-Message-State: APjAAAUJmO5WayNLTyO82q+8Npcn+vwzUVo5vsVwtr9yNhH8cWvVqtCt
        yX+iJ/iWepiihyvu7Naaadm7Ur0=
X-Google-Smtp-Source: APXvYqxgYTYBEOSY3avJO/dkMiJ+naINnzUBGBXe/SI/EjQdQHiuNJW1XS+DuzgeRsuLvyR8KrS10wU=
X-Received: by 2002:a25:fd6:: with SMTP id 205mr13749456ybp.32.1555349884367;
 Mon, 15 Apr 2019 10:38:04 -0700 (PDT)
Date:   Mon, 15 Apr 2019 10:37:55 -0700
Message-Id: <20190415173801.257254-1-sdf@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: [PATCH bpf-next v5 0/6] net: flow_dissector: trigger BPF hook when
 called from eth_get_headlen
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     davem@davemloft.net, ast@kernel.org, daniel@iogearbox.net,
        simon.horman@netronome.com, willemb@google.com,
        peterpenkov96@gmail.com, Stanislav Fomichev <sdf@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Currently, when eth_get_headlen calls flow dissector, it doesn't pass any
skb. Because we use passed skb to lookup associated networking namespace
to find whether we have a BPF program attached or not, we always use
C-based flow dissector in this case.

The goal of this patch series is to add new networking namespace argument
to the eth_get_headlen and make BPF flow dissector programs be able to
work in the skb-less case.

The series goes like this:
* use new kernel context (struct bpf_flow_dissector) for flow dissector
  programs; this makes it easy to distinguish between skb and no-skb
  case and supports calling BPF flow dissector on a chunk of raw data
* convert BPF_PROG_TEST_RUN to use raw data
* plumb network namespace into __skb_flow_dissect from all callers
* handle no-skb case in __skb_flow_dissect
* update eth_get_headlen to include net namespace argument and
  convert all existing users
* add selftest to make sure bpf_skb_load_bytes is not allowed in
  the no-skb mode

v5:
* API changes have been submitted via bpf/stable tree

v4:
* prohibit access to vlan fields as well (otherwise, inconsistent
  between skb/skb-less cases)
* drop extra unneeded check for skb->vlan_present in bpf_flow.c

v3:
* new kernel xdp_buff-like context per Alexei suggestion
* drop skb_net helper
* properly clamp flow_keys->nhoff

v2:
* moved temporary skb from stack into percpu (avoids memset of ~200 bytes
  per packet)
* tightened down access to __sk_buff fields from flow dissector programs to
  avoid touching shinfo (whitelist only relevant fields)
* addressed suggestions from Willem

Stanislav Fomichev (6):
  flow_dissector: switch kernel context to struct bpf_flow_dissector
  bpf: when doing BPF_PROG_TEST_RUN for flow dissector use no-skb mode
  net: plumb network namespace into __skb_flow_dissect
  flow_dissector: handle no-skb use case
  net: pass net argument to the eth_get_headlen
  selftests/bpf: add flow dissector bpf_skb_load_bytes helper test

 .../net/ethernet/aquantia/atlantic/aq_ring.c  |   3 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     |   2 +-
 drivers/net/ethernet/hisilicon/hns/hns_enet.c |   3 +-
 .../net/ethernet/hisilicon/hns3/hns3_enet.c   |   3 +-
 drivers/net/ethernet/intel/fm10k/fm10k_main.c |   2 +-
 drivers/net/ethernet/intel/i40e/i40e_txrx.c   |   3 +-
 drivers/net/ethernet/intel/iavf/iavf_txrx.c   |   3 +-
 drivers/net/ethernet/intel/ice/ice_txrx.c     |   3 +-
 drivers/net/ethernet/intel/igb/igb_main.c     |   3 +-
 drivers/net/ethernet/intel/igc/igc_main.c     |   3 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |   2 +-
 .../net/ethernet/intel/ixgbevf/ixgbevf_main.c |   3 +-
 .../net/ethernet/mellanox/mlx5/core/en_tx.c   |   3 +-
 drivers/net/tun.c                             |   3 +-
 include/linux/etherdevice.h                   |   2 +-
 include/linux/skbuff.h                        |  28 ++---
 include/net/flow_dissector.h                  |   7 ++
 include/net/sch_generic.h                     |  11 +-
 net/bpf/test_run.c                            |  51 +++------
 net/core/filter.c                             | 105 ++++++++++++++----
 net/core/flow_dissector.c                     |  90 +++++++--------
 net/ethernet/eth.c                            |   8 +-
 .../prog_tests/flow_dissector_load_bytes.c    |  48 ++++++++
 23 files changed, 249 insertions(+), 140 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/flow_dissector_load_bytes.c

-- 
2.21.0.392.gf8f6787159e-goog
