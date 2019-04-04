Return-Path: <SRS0=+eov=SG=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67F68C4360F
	for <bpf@archiver.kernel.org>; Thu,  4 Apr 2019 15:21:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 322E32147C
	for <bpf@archiver.kernel.org>; Thu,  4 Apr 2019 15:21:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727165AbfDDPVo (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 4 Apr 2019 11:21:44 -0400
Received: from www62.your-server.de ([213.133.104.62]:47698 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726952AbfDDPVn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 4 Apr 2019 11:21:43 -0400
Received: from [2a02:120b:c3fc:feb0:dda7:bd28:a848:50e2] (helo=localhost)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1hC4BR-0006hY-GL; Thu, 04 Apr 2019 17:21:41 +0200
From:   Daniel Borkmann <daniel@iogearbox.net>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, ast@kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: pull-request: bpf 2019-04-04
Date:   Thu,  4 Apr 2019 17:21:41 +0200
Message-Id: <20190404152141.19803-1-daniel@iogearbox.net>
X-Mailer: git-send-email 2.9.5
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.3/25409/Thu Apr  4 09:53:59 2019)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi David,

The following pull-request contains BPF updates for your *net* tree.

The main changes are:

1) Batch of fixes to the existing BPF flow dissector API to support
   calling BPF programs from the eth_get_headlen context (support for
   latter is planned to be added in bpf-next), from Stanislav.

Please consider pulling these changes from:

  git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git

Thanks a lot!

----------------------------------------------------------------

The following changes since commit b2e54b09a3d29c4db883b920274ca8dca4d9f04d:

  ip6_tunnel: Match to ARPHRD_TUNNEL6 for dev type (2019-04-02 13:19:34 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git 

for you to fetch changes up to 5eed7898626bedd6405421550c0c6e8ab9591bb2:

  flow_dissector: rst'ify documentation (2019-04-04 15:25:23 +0200)

----------------------------------------------------------------
Daniel Borkmann (1):
      Merge branch 'bpf-flow-dissector-fixes'

Stanislav Fomichev (6):
      selftests/bpf: fix vlan handling in flow dissector program
      net/flow_dissector: pass flow_keys->n_proto to BPF programs
      flow_dissector: fix clamping of BPF flow_keys for non-zero nhoff
      flow_dissector: allow access only to a subset of __sk_buff fields
      flow_dissector: document BPF flow dissector environment
      flow_dissector: rst'ify documentation

 Documentation/networking/bpf_flow_dissector.rst    | 126 +++++++++++++++++++++
 Documentation/networking/index.rst                 |   1 +
 net/core/filter.c                                  |  16 +--
 net/core/flow_dissector.c                          |   4 +-
 .../selftests/bpf/prog_tests/flow_dissector.c      |  68 +++++++++++
 tools/testing/selftests/bpf/progs/bpf_flow.c       |  19 ++--
 6 files changed, 208 insertions(+), 26 deletions(-)
 create mode 100644 Documentation/networking/bpf_flow_dissector.rst
