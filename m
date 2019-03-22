Return-Path: <SRS0=YBMC=RZ=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FE74C43381
	for <bpf@archiver.kernel.org>; Fri, 22 Mar 2019 19:59:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39E1D21874
	for <bpf@archiver.kernel.org>; Fri, 22 Mar 2019 19:59:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EdhJmICG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726014AbfCVT7H (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 22 Mar 2019 15:59:07 -0400
Received: from mail-vk1-f202.google.com ([209.85.221.202]:43196 "EHLO
        mail-vk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725982AbfCVT7H (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 22 Mar 2019 15:59:07 -0400
Received: by mail-vk1-f202.google.com with SMTP id s11so1246729vkk.10
        for <bpf@vger.kernel.org>; Fri, 22 Mar 2019 12:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=zShM0RWqFlfrPUijnY1kNbwqoHuA2eXHgjycKhDvh0s=;
        b=EdhJmICGrjMjQ74HOZdU1XqWykhqpWpKp5yiVOqHvYR9p7sxSmsKvqksqcxvjnqTFZ
         f4VGTHkvfz+4l+0fIuetYkmNr9WMeF8lcP52QSoAGzhvyaJlTTV3iH+AF2tLtSM5zBhn
         YrFsfXACQ0SYRZ8RMhnsLnXDPhyqQ3bijUGCv1inSigLOUBlSQziHLCF2zg+6L2TKioQ
         abiltjF3FSacklfqYswbBlGiEdNTHjy98uXw2EdaoiJlUHkWFld8kwdelZcH4TjS35JE
         BOxqdTTmzzbQJ28YwPObLorYyAgzrhyz7wDlEZRMWjst507ZJBpxXJ8whZSPPD9aKzHL
         WbMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=zShM0RWqFlfrPUijnY1kNbwqoHuA2eXHgjycKhDvh0s=;
        b=iZ+ptsylpZrbtTiHrES1ULkuz1eRyH2W/TaFnjy7hqd8STjWk+wd5VQyhZQxMFBmHL
         llb5qmsCUsKwJUcQklh3DU3hjrUG5oeKkf0xvSVrOZsiy+L5ngOmzwFo1418FB/G81my
         2wprD+Zn5jo7XeCwaH4zrBVgeCewte0bxKpPrOcFPoDqoDA65qL87qqi4IZK82wY5UvX
         FaTmDK7xmFRUkiCatCtVtil38SThCWUWffR5LZxOco5+lCJPjpJ4KhIe1TayA3k+RERe
         osl7yuBwvE83vwTX804O7IPn96AVVMxqSWfQ4RjTwFaoPiPdtZUMRiSHx68Vy+ONVPRR
         SPFQ==
X-Gm-Message-State: APjAAAUQPcZ15NAjXMY4igqIbjP9s7uJGsKE85R90NslyqeSuSA1BGEB
        X3sRV0YtN0Ch4/HhvxbNUy0kGpU=
X-Google-Smtp-Source: APXvYqwbT9vrnxL2qVpxaMcdS099gbZ3tMbbtGfnBSLK/UmqNuZQdi34IscES//P7lsIcVelgeWF9qs=
X-Received: by 2002:a1f:1282:: with SMTP id 124mr7119344vks.45.1553284746270;
 Fri, 22 Mar 2019 12:59:06 -0700 (PDT)
Date:   Fri, 22 Mar 2019 12:58:55 -0700
Message-Id: <20190322195903.162516-1-sdf@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: [RFC bpf-next v3 0/8] net: flow_dissector: trigger BPF hook when
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
1. restrict access to a limited set of __sk_buff fields from flow
   dissector programs; in eth_get_headlen context, they don't
   make sense (for skb-context, they are also not relevant for
   flow dissector)
2. switch kernel context to new xdp_buff-like structure (struct
   bpf_flow_dissector) for flow dissector program
3. minor fix for nhoff clamping; doesn't affect anything besides tests
4. convert flow dissector BPF_PROG_TEST_RUN to skb-less mode to show that
   it works
5. add new optional network namespace argument to __skb_flow_dissect and
   plumb through the callers
6. handle __skb_flow_dissect with skb == NULL
7. add new net namespace argument to eth_get_headlen and adjust all users
8. add selftest that makes sure bpf_skb_load_bytes is prohibited in
   skb-less context

v3:
* new kernel xdp_buff-like context per Alexey suggestion
* drop skb_net helper
* properly clamp flow_keys->nhoff

v2:
* moved temporary skb from stack into percpu (avoids memset of ~200 bytes
  per packet)
* tightened down access to __sk_buff fields from flow dissector programs to
  avoid touching shinfo (whitelist only relevant fields)
* addressed suggestions from Willem

Stanislav Fomichev (8):
  flow_dissector: allow access only to a subset of __sk_buff fields
  flow_dissector: switch kernel context to struct bpf_flow_dissector
  flow_dissector: fix clamping of BPF flow_keys for non-zero nhoff
  bpf: when doing BPF_PROG_TEST_RUN for flow dissector use no-skb mode
  net: plumb network namespace into __skb_flow_dissect
  flow_dissector: handle no-skb use case
  net: pass net argument to the eth_get_headlen
  selftests/bpf: add flow dissector bpf_skb_load_bytes helper test

 drivers/net/ethernet/broadcom/bnxt/bnxt.c     |   2 +-
 drivers/net/ethernet/hisilicon/hns/hns_enet.c |   3 +-
 .../net/ethernet/hisilicon/hns3/hns3_enet.c   |   3 +-
 drivers/net/ethernet/intel/fm10k/fm10k_main.c |   2 +-
 drivers/net/ethernet/intel/i40e/i40e_txrx.c   |   3 +-
 drivers/net/ethernet/intel/iavf/iavf_txrx.c   |   3 +-
 drivers/net/ethernet/intel/ice/ice_txrx.c     |   2 +-
 drivers/net/ethernet/intel/igb/igb_main.c     |   3 +-
 drivers/net/ethernet/intel/igc/igc_main.c     |   3 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |   2 +-
 .../net/ethernet/intel/ixgbevf/ixgbevf_main.c |   3 +-
 .../net/ethernet/mellanox/mlx5/core/en_tx.c   |   3 +-
 drivers/net/tun.c                             |   3 +-
 include/linux/etherdevice.h                   |   2 +-
 include/linux/skbuff.h                        |  23 ++-
 include/net/flow_dissector.h                  |  11 ++
 include/net/sch_generic.h                     |  11 +-
 net/bpf/test_run.c                            |  51 ++----
 net/core/filter.c                             | 151 +++++++++++++-----
 net/core/flow_dissector.c                     |  85 +++++-----
 net/ethernet/eth.c                            |   8 +-
 .../prog_tests/flow_dissector_load_bytes.c    |  48 ++++++
 22 files changed, 280 insertions(+), 145 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/flow_dissector_load_bytes.c

-- 
2.21.0.392.gf8f6787159e-goog
