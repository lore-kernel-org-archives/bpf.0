Return-Path: <SRS0=He8s=BM=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01B53C433DF
	for <bpf@archiver.kernel.org>; Sun,  2 Aug 2020 18:26:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 902672065E
	for <bpf@archiver.kernel.org>; Sun,  2 Aug 2020 18:26:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="m8aFnUC8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726903AbgHBS0r (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Sun, 2 Aug 2020 14:26:47 -0400
Received: from forwardcorp1p.mail.yandex.net ([77.88.29.217]:33878 "EHLO
        forwardcorp1p.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725917AbgHBS0r (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sun, 2 Aug 2020 14:26:47 -0400
Received: from vla1-fdfb804fb3f3.qloud-c.yandex.net (vla1-fdfb804fb3f3.qloud-c.yandex.net [IPv6:2a02:6b8:c0d:3199:0:640:fdfb:804f])
        by forwardcorp1p.mail.yandex.net (Yandex) with ESMTP id 580972E144E;
        Sun,  2 Aug 2020 21:26:44 +0300 (MSK)
Received: from vla5-58875c36c028.qloud-c.yandex.net (vla5-58875c36c028.qloud-c.yandex.net [2a02:6b8:c18:340b:0:640:5887:5c36])
        by vla1-fdfb804fb3f3.qloud-c.yandex.net (mxbackcorp/Yandex) with ESMTP id fmwsqNLfCx-Qhq8P9N4;
        Sun, 02 Aug 2020 21:26:44 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1596392804; bh=e54p5M/cZFr8ghKYlv7mU4LLd8JuKfGLHBFOaeiKgnA=;
        h=Message-Id:Date:Subject:To:From:Cc;
        b=m8aFnUC8set/wAARdznHmWER91/qtENLAdPSMOGHtb0xghxYEQYHRFzdDPXbP0ZSc
         G7fai8R/iVjpahIWzmCzTpie3X690YODF/RtVjOs8/+ZOUYlCeD+KyUANMybhxxytP
         rlLgONUU7jI8r68awleS5jQKp1oa8JVYT3jGd8Jg=
Authentication-Results: vla1-fdfb804fb3f3.qloud-c.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from unknown (unknown [178.154.220.66])
        by vla5-58875c36c028.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id BgDnkfhBPV-Qhj4sNT2;
        Sun, 02 Aug 2020 21:26:43 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
From:   Dmitry Yakunin <zeil@yandex-team.ru>
To:     alexei.starovoitov@gmail.com, daniel@iogearbox.net,
        netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     sdf@google.com
Subject: [PATCH bpf-next v4 0/2] bpf: cgroup skb improvements for bpf_prog_test_run
Date:   Sun,  2 Aug 2020 21:26:36 +0300
Message-Id: <20200802182638.77377-1-zeil@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patchset contains some improvements for testing cgroup/skb programs
through BPF_PROG_TEST_RUN command.

v2:
  - fix build without CONFIG_CGROUP_BPF (kernel test robot <lkp@intel.com>)

v3:
  - fix build without CONFIG_IPV6 (kernel test robot <lkp@intel.com>)

v4:
  - remove cgroup storage related commits for future rework (Daniel Borkmann)

Dmitry Yakunin (2):
  bpf: setup socket family and addresses in bpf_prog_test_run_skb
  bpf: allow to specify ifindex for skb in bpf_prog_test_run_skb

 net/bpf/test_run.c                               | 39 ++++++++++++++++++++++--
 tools/testing/selftests/bpf/prog_tests/skb_ctx.c |  5 +++
 2 files changed, 42 insertions(+), 2 deletions(-)

-- 
2.7.4

