Return-Path: <SRS0=vda1=SD=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F4E2C43381
	for <bpf@archiver.kernel.org>; Mon,  1 Apr 2019 20:57:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF519208E4
	for <bpf@archiver.kernel.org>; Mon,  1 Apr 2019 20:57:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OmzeKW9c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726924AbfDAU5h (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 1 Apr 2019 16:57:37 -0400
Received: from mail-pg1-f202.google.com ([209.85.215.202]:41902 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726501AbfDAU5h (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 1 Apr 2019 16:57:37 -0400
Received: by mail-pg1-f202.google.com with SMTP id d128so8278094pgc.8
        for <bpf@vger.kernel.org>; Mon, 01 Apr 2019 13:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=/hO2swCT/dAb+7x40RO0XOsciP2aFMhIU3XXHhd61wc=;
        b=OmzeKW9cyOt4gazS8xCNm76Qzm3dM60BrSbRpMlbKMs5iaOKu1T4tHAk/8dvXbSF0P
         bxLMZVabVsdSvFGBsgsGwaCLdMm7mapJrzzdXnagz/7tTD3Fyhs3OOZmZV7PJHbs3aTC
         ClPaNSJAmLTJvVItA5wteVvhEp7OW8LHMUTQVufWVAjb2qZ7DSnc5pTjfs783JnA8iZm
         ns2gqE0SUEc2yZPzwe3BM0gNFuN5pl82kFrgbgtpQLke1bwZxVDBIU+cMR5KGQ7icV7H
         ME7r3FRJGKodACvQNVkIMF7a02R6A4dFzjxiGKchNFTlqeaer7haG3O6hg4rcoOYRs9O
         e+DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=/hO2swCT/dAb+7x40RO0XOsciP2aFMhIU3XXHhd61wc=;
        b=uDZM57y19wWWXDaQQeAabGkyHucX1yEWd1ssQhwXjUm3cEFF+Kb82cawfv2CWzb9mo
         A+yU5Ly7PUju4sDO6bLcnszRuD8AQbWrDPzJtj6eP5t5zWiIzjdKk7pG6cogTfu3l0sX
         cmu9M6jJxUE8oVr2Neb2MmI2nP8WHHC4fd5ZijOW083eAKvxVaXdsA9FingKzZ2QOzfZ
         tAXB7REcmh2Nv2/7iFO+GxX5X9YuvkyE58+bo5S6TEZ3cLr4Bjht72Ywb0YqZD6EjQLK
         aSHM7BDzJfaUNcWVO7JqmDlL6N7EKA//OfWxABIIixsr233J/FMBSBF/6+wVjY9Oqt0B
         VIZQ==
X-Gm-Message-State: APjAAAWZ03zSY8a7LzVtJxMqY95udPcDCCkLZ6nG90utvaTJQXwlr5ZU
        YwiXa3/FixvJ4rOrVzMubQD/unk=
X-Google-Smtp-Source: APXvYqwn4NY8e76Q6KE+TcqUMQwA141gZAWD9GFEO3Z9EkhOjkE62Wac3Xh80EWg+U89T6RUE6Gglpw=
X-Received: by 2002:a62:4ecc:: with SMTP id c195mr1386994pfb.44.1554152256894;
 Mon, 01 Apr 2019 13:57:36 -0700 (PDT)
Date:   Mon,  1 Apr 2019 13:57:29 -0700
Message-Id: <20190401205734.4400-1-sdf@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: [PATCH bpf 0/5] flow_dissector: lay groundwork for calling BPF hook
 from eth_get_headlen
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

This patch series fixes the existing BPF flow dissector API to
support calling BPF progs from the eth_get_headlen context (the support
itself will be added in bpf-next tree).

The summary of the changes:
  * fix VLAN handling in bpf_flow.c, we don't need to peek back and look
    at skb->vlan_present; add selftests
  * pass and use flow_keys->n_proto instead of skb->protocol
  * fix clamping of flow_keys->nhoff for packets with nhoff > 0
  * prohibit access to most of the __sk_buff fields from BPF flow
    dissector progs; only data/data_end/flow_keys are allowed (all input
    is now passed via flow_keys)
  * finally, document BPF flow dissector program environment

Stanislav Fomichev (5):
  selftests/bpf: fix vlan handling in flow dissector program
  net/flow_dissector: pass flow_keys->n_proto to BPF programs
  flow_dissector: fix clamping of BPF flow_keys for non-zero nhoff
  flow_dissector: allow access only to a subset of __sk_buff fields
  flow_dissector: document BPF flow dissector environment

 .../networking/bpf_flow_dissector.txt         | 115 ++++++++++++++++++
 net/core/filter.c                             |  16 +--
 net/core/flow_dissector.c                     |   4 +-
 .../selftests/bpf/prog_tests/flow_dissector.c |  68 +++++++++++
 tools/testing/selftests/bpf/progs/bpf_flow.c  |  19 ++-
 5 files changed, 196 insertions(+), 26 deletions(-)
 create mode 100644 Documentation/networking/bpf_flow_dissector.txt

-- 
2.21.0.392.gf8f6787159e-goog
