Return-Path: <SRS0=ACyN=SY=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E436C282CE
	for <bpf@archiver.kernel.org>; Mon, 22 Apr 2019 15:55:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69D4320881
	for <bpf@archiver.kernel.org>; Mon, 22 Apr 2019 15:55:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jwJj50Uz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727378AbfDVPz4 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 22 Apr 2019 11:55:56 -0400
Received: from mail-qk1-f202.google.com ([209.85.222.202]:37918 "EHLO
        mail-qk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726801AbfDVPzz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 22 Apr 2019 11:55:55 -0400
Received: by mail-qk1-f202.google.com with SMTP id z19so7989914qkj.5
        for <bpf@vger.kernel.org>; Mon, 22 Apr 2019 08:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=ADpMg3msJaksYk/oEzJiV15O012gPbUWLyrQdThd2a8=;
        b=jwJj50Uzybj5jHEsKc+j9lUuUAu9eZ5v6tyJmgiaZM1QJIy7ghCHPfYxqWsDdqhFjy
         3iCh4r6EaUAhJVTb/tCjtUCGZyJRWNQZ4geg+S9WSLGa/EgQ34Qanmq/iK53HCagXlPe
         mJuIGzFXI+jrVc9QDe4ZT7qkuaPAehpn43Ku1AnaGTvSnWFZrjIUr/jWWoHk7hKUisKf
         zrYbh76q9mQOCzUsp80HJuHlmGXDOx6V0n58oDP3oClmRyzGXG8d+y1CgExZGfbre5Br
         WxiS6rfQJ/Tk44S7CCw87pZfvEaHf8qPe1A159fXDRekJ3C+Pws5cjb+k3QSfY/xSfpZ
         CnAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=ADpMg3msJaksYk/oEzJiV15O012gPbUWLyrQdThd2a8=;
        b=AO0Z2eUfT5QeUPYNRpBFOQ5U1YGbDS92LHn3T53Me2x4atjpwklEmv/+pCFZ3+15dj
         bxkv94kd5zFII31RNUP/WxkvRlUu8PD0wlUyDNNFmV9HmCwFNJQmH+Na9sR01o5+oB9L
         Fw6RPZP597M2yMgAD7nnzk+YauB3PxeYIuCfSxJhxRbx1JLk5GnonD0tRhqO4KZ9VMWr
         GS8FbBCLFPZJJ3hoTTIQlRSLma43mktcpMNzu8VRXmQ+I/MQacG9NScu2M1/UqraLTpp
         iML7dXsW/YM49pMYnfkzag+IJxkIBnS0+Um4CjJbQKnEPboZVxdN7OLjo3YgnmhU6aGt
         MhsA==
X-Gm-Message-State: APjAAAU7WTIqzaHJpKXmQbwZLQIapo6RMubNxiQZ6/r3oUC74yEkW/RV
        fYCpA5SPB1MfTDNgMllGl5FDjLE=
X-Google-Smtp-Source: APXvYqzQCq/7+jTxlpn1gxEgkjxAD/gNPGJH1T5Aewq4tDX5LjzDFg3wLIs9ZnKN9Ipnrx59dLa0/tk=
X-Received: by 2002:a37:5b42:: with SMTP id p63mr15902136qkb.325.1555948554689;
 Mon, 22 Apr 2019 08:55:54 -0700 (PDT)
Date:   Mon, 22 Apr 2019 08:55:43 -0700
Message-Id: <20190422155552.222910-1-sdf@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.21.0.593.g511ec345e18-goog
Subject: [PATCH bpf-next v6 0/9] net: flow_dissector: trigger BPF hook when
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
* extend test_progs to exercise skb-less flow dissection as well
* stop adjusting nhoff/thoff by ETH_HLEN in BPF_PROG_TEST_RUN

v6:
* more suggestions by Alexei:
  * eth_get_headlen now takes net dev, not net namespace
  * test skb-less case via tun eth_get_headlen
* fix return errors in bpf_flow_load
* don't adjust nhoff/thoff by ETH_HLEN

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

Stanislav Fomichev (9):
  flow_dissector: switch kernel context to struct bpf_flow_dissector
  bpf: when doing BPF_PROG_TEST_RUN for flow dissector use no-skb mode
  net: plumb network namespace into __skb_flow_dissect
  flow_dissector: handle no-skb use case
  net: pass net_device argument to the eth_get_headlen
  selftests/bpf: add flow dissector bpf_skb_load_bytes helper test
  selftests/bpf: run flow dissector tests in skb-less mode
  selftests/bpf: properly return error from bpf_flow_load
  bpf/flow_dissector: don't adjust nhoff by ETH_HLEN in
    BPF_PROG_TEST_RUN

 .../net/ethernet/aquantia/atlantic/aq_ring.c  |   3 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     |   2 +-
 drivers/net/ethernet/hisilicon/hns/hns_enet.c |   2 +-
 .../net/ethernet/hisilicon/hns3/hns3_enet.c   |   2 +-
 drivers/net/ethernet/intel/fm10k/fm10k_main.c |   2 +-
 drivers/net/ethernet/intel/i40e/i40e_txrx.c   |   3 +-
 drivers/net/ethernet/intel/iavf/iavf_txrx.c   |   2 +-
 drivers/net/ethernet/intel/ice/ice_txrx.c     |   2 +-
 drivers/net/ethernet/intel/igb/igb_main.c     |   2 +-
 drivers/net/ethernet/intel/igc/igc_main.c     |   2 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |   2 +-
 .../net/ethernet/intel/ixgbevf/ixgbevf_main.c |   3 +-
 .../net/ethernet/mellanox/mlx5/core/en_tx.c   |   2 +-
 drivers/net/tun.c                             |   3 +-
 include/linux/etherdevice.h                   |   2 +-
 include/linux/skbuff.h                        |  28 +++--
 include/net/flow_dissector.h                  |   7 ++
 include/net/sch_generic.h                     |  11 +-
 net/bpf/test_run.c                            |  48 +++-----
 net/core/filter.c                             | 105 ++++++++++++----
 net/core/flow_dissector.c                     |  90 +++++++-------
 net/ethernet/eth.c                            |   8 +-
 .../selftests/bpf/flow_dissector_load.c       |   2 +-
 .../selftests/bpf/flow_dissector_load.h       |  24 +++-
 .../selftests/bpf/prog_tests/flow_dissector.c | 113 ++++++++++++++++--
 .../prog_tests/flow_dissector_load_bytes.c    |  48 ++++++++
 tools/testing/selftests/bpf/progs/bpf_flow.c  |  79 +++++++-----
 27 files changed, 411 insertions(+), 186 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/flow_dissector_load_bytes.c

-- 
2.21.0.593.g511ec345e18-goog
