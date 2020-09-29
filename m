Return-Path: <SRS0=PNb+=DG=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C73BC4727C
	for <bpf@archiver.kernel.org>; Tue, 29 Sep 2020 10:17:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1DD2720C09
	for <bpf@archiver.kernel.org>; Tue, 29 Sep 2020 10:17:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725774AbgI2KRl (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 29 Sep 2020 06:17:41 -0400
Received: from mx2.suse.de ([195.135.220.15]:60428 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725536AbgI2KRj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 29 Sep 2020 06:17:39 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 2747BAD12;
        Tue, 29 Sep 2020 10:17:38 +0000 (UTC)
Received: by lion.mk-sys.cz (Postfix, from userid 1000)
        id DF10860787; Tue, 29 Sep 2020 12:17:37 +0200 (CEST)
Date:   Tue, 29 Sep 2020 12:17:37 +0200
From:   Michal Kubecek <mkubecek@suse.cz>
To:     bpf@vger.kernel.org
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yonghong Song <yhs@fb.com>
Subject: build failure (BTFIDS) with CONFIG_NET && !CONFIG_INET
Message-ID: <20200929101737.3ufw36bngkmzppqk@lion.mk-sys.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello,

our builds of s390x for zfcpdump fail since 5.9-rc1 with

    BTFIDS  vmlinux
  FAILED unresolved symbol tcp_timewait_sock
  make[1]: *** [/home/abuild/rpmbuild/BUILD/kernel-zfcpdump-5.9.rc7/linux-5.9-rc7/Makefile:1176: vmlinux] Error 255

I believe this is caused by commit fce557bcef11 ("bpf: Make btf_sock_ids
global") and the problem is caused by a specific configuration which has
CONFIG_NET enabled but CONFIG_INET disabled. IIUC there will be no user
of struct tcp_timewait_sock but btf_ids will try to generate BTF info
for it.

Michal
