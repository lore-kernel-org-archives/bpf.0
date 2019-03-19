Return-Path: <SRS0=wUMJ=RW=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFCC8C43381
	for <bpf@archiver.kernel.org>; Tue, 19 Mar 2019 22:19:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC1A22175B
	for <bpf@archiver.kernel.org>; Tue, 19 Mar 2019 22:19:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BvqXNq8A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727376AbfCSWTx (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 19 Mar 2019 18:19:53 -0400
Received: from mail-ua1-f74.google.com ([209.85.222.74]:37588 "EHLO
        mail-ua1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726912AbfCSWTx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 19 Mar 2019 18:19:53 -0400
Received: by mail-ua1-f74.google.com with SMTP id h9so61933uah.4
        for <bpf@vger.kernel.org>; Tue, 19 Mar 2019 15:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=Cuy4wFa51wcWdLukZFeiTuSUmejHRfPFpAu7Mcm3BIE=;
        b=BvqXNq8AaksCp/A6Yd+Hj2W5oozjTK07sjFjoT/wcxco1NIS0KvyyfUXHWUh6bPBWR
         Z1Enz9rkXTD5eOtofkvQJbuKKbMcMKqxzuIiwF2MqI5qWNHJ0R8lwdFu1G+R8aUIwwEj
         E8gxdLqpeO6ab45qRmJ5LrqlTAVgI8gg9MuBWOuqTTjhFyoufDq4hwwyFbEHjtb8FfA5
         335V2xmawIL1Cno9Zs4C+KaeJq4DM0fIKqNOlE8q2cDXKp4TRV45xTnV90NFiFXpjSPd
         byEvvvmhKnfbd+zz0Vw56szND59HCsR18f806G0AE2sslPduANz5tdQinlmvK3GFGxBG
         ptow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=Cuy4wFa51wcWdLukZFeiTuSUmejHRfPFpAu7Mcm3BIE=;
        b=WKNw1RArcBOIxi/3bmyK6qA5R/cWpNjLDKysivITL2YyegjeZL9JF8CJdn4i85/f7l
         aUZq9tvRr0RSPUUsB2csWiRf7b6xjNRqXNtHCiW+E/Mf0MfZMqNYDMicQZbLzxzUpBlL
         EFh5I56vzPWHlWJW0ntJiWd+7KK7tXDVVl/EgIUwp/+IwRdkDEsC4UuYXqFPf716zSev
         i9c12K+Q/4RVhre2hdWj7Aq0eu+qhISCNfbWlTsOVdwydeUhtJDN9p4IRXhbmRy5ZOb/
         ADLuyJxL1w/hi2O9jvY/aUmdVVHHxD/eq+uThmFbsMqL7y+WEH5NHN1ivmc2PgKLzN10
         3flw==
X-Gm-Message-State: APjAAAW/shQrZhOOaFeZpOSG2mRNg8WCn367PipAqt51ayJivtu/xIUU
        B0CgGVqKPh2oRJ965ihiFcZwKR0=
X-Google-Smtp-Source: APXvYqxangaAKpwKRPIwDFPxsXdAdZ42xI06m3HHXRmrhuVPrdATY3cecADEacIEU9PmmnxP1dXGH/8=
X-Received: by 2002:a67:d10a:: with SMTP id u10mr4155822vsi.5.1553033991766;
 Tue, 19 Mar 2019 15:19:51 -0700 (PDT)
Date:   Tue, 19 Mar 2019 15:19:39 -0700
Message-Id: <20190319221948.170441-1-sdf@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.21.0.225.g810b269d1ac-goog
Subject: [RFC bpf-next v2 0/9] net: flow_dissector: trigger BPF hook when
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
1. introduce a bunch of skb initialization helpers; those will be used to
   initialize temporary skb
2. introduce skb_net which can be used to get networking namespace
   associated with an skb
3. add new optional network namespace argument to __skb_flow_dissect and
   plumb through the callers
4. prepare for new bpf flow dissector flavor, create some common routines
   and do some renames
5. restrict access to a limited set of __sk_buff fields from flow
   dissector programs
6. add new bpf_flow_dissect which uses temporary per-cpu skb and calls
   BPF flow dissector program
7. convert flow dissector BPF_PROG_TEST_RUN to skb-less mode to show that
   it works
8. add selftest that makes sure going over the packet bounds in
   bpf_skb_load_bytes with shinfo-less skb doesn't cause any problems
9. add new net namespace argument to eth_get_headlen and convert the
   callers

v2:
* moved temporary skb from stack into percpu (avoids memset of ~200 bytes
  per packet)
* tightened down access to __sk_buff fields from flow dissector programs to
  avoid touching shinfo (whitelist only relevant fields)
* addressed suggestions from Willem

Stanislav Fomichev (9):
  net: introduce __init_skb{,_data,_shinfo} helpers
  net: introduce skb_net helper
  net: plumb network namespace into __skb_flow_dissect
  net: flow_dissector: prepare for no-skb use case
  flow_dissector: allow access only to a subset of __sk_buff fields
  net: flow_dissector: handle no-skb use case
  bpf: when doing BPF_PROG_TEST_RUN for flow dissector use no-skb mode
  selftests/bpf: add flow dissector bpf_skb_load_bytes helper test
  net: flow_dissector: pass net argument to the eth_get_headlen

 drivers/net/ethernet/broadcom/bnxt/bnxt.c     |   2 +-
 drivers/net/ethernet/hisilicon/hns/hns_enet.c |   3 +-
 .../net/ethernet/hisilicon/hns3/hns3_enet.c   |   3 +-
 drivers/net/ethernet/intel/fm10k/fm10k_main.c |   2 +-
 drivers/net/ethernet/intel/i40e/i40e_txrx.c   |   3 +-
 drivers/net/ethernet/intel/iavf/iavf_txrx.c   |   2 +-
 drivers/net/ethernet/intel/ice/ice_txrx.c     |   2 +-
 drivers/net/ethernet/intel/igb/igb_main.c     |   2 +-
 drivers/net/ethernet/intel/igc/igc_main.c     |   2 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |   2 +-
 .../net/ethernet/intel/ixgbevf/ixgbevf_main.c |   3 +-
 .../net/ethernet/mellanox/mlx5/core/en_tx.c   |   3 +-
 drivers/net/tun.c                             |   3 +-
 include/linux/etherdevice.h                   |   2 +-
 include/linux/skbuff.h                        |  48 +++++--
 net/bpf/test_run.c                            |  48 ++-----
 net/core/filter.c                             |  13 +-
 net/core/flow_dissector.c                     | 135 +++++++++++++-----
 net/core/skbuff.c                             |  76 +++++-----
 net/ethernet/eth.c                            |   8 +-
 .../prog_tests/flow_dissector_load_bytes.c    |  50 +++++++
 21 files changed, 269 insertions(+), 143 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/flow_dissector_load_bytes.c

-- 
2.21.0.225.g810b269d1ac-goog
