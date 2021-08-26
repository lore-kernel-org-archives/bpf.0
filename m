Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79A43C432BE
	for <bpf@archiver.kernel.org>; Thu, 26 Aug 2021 23:51:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 600C560F25
	for <bpf@archiver.kernel.org>; Thu, 26 Aug 2021 23:51:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243742AbhHZXwZ (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 26 Aug 2021 19:52:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:44418 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229710AbhHZXwZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 26 Aug 2021 19:52:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9A07760EBA;
        Thu, 26 Aug 2021 23:51:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630021897;
        bh=KYyF4MizoG9F5shZnJoaf+b3QUXOI46XUzqIH/apMwI=;
        h=From:To:Cc:Subject:Date:From;
        b=mbbSTGDfx8iqwFA2WpTpFpiNolA80CgBWei7pXVne+RDrNzvjrT+n7twt5rEUtLQW
         W1qWgqO/xyk5jmwunoHlkDD4ZAoOO0H8FuXkyKNev6lbrs0hposl627hzW+EUXa8Bt
         /o0U1OPBSGwXCT4yMYbFtAZjves+yupkHv4XHic40W8jeZmRA8gTAx1z8MEQHIdkaH
         RdMOTIZo8mlEUUH6EegemYEiKqeYXeGVAvpbsXYIH5U4Zks1I0V+Acimpi0NIM/RF8
         8wbiZzDo8Z5JI66e03Cbixxyx6tz/m4eEn6Sqief+6ZK+dBWbbBRrnDX2c0vWs1BgK
         uOwC36UTZUJtA==
From:   KP Singh <kpsingh@kernel.org>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Martin KaFai Lau <kafai@fb.com>
Subject: [PATCH bpf-next 0/2] Sleepable local storage
Date:   Thu, 26 Aug 2021 23:51:25 +0000
Message-Id: <20210826235127.303505-1-kpsingh@kernel.org>
X-Mailer: git-send-email 2.33.0.259.gc128427fd7-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Local storage is currently unusable in sleepable helpers. One of the
important use cases of local_storage is to attach security (or
performance) contextual information to kernel objects in LSM / tracing
programs to be used later in the life-cyle of the object.

Sometimes this context can only be gathered from sleepable programs
(because it needs accesing __user pointers or helpers like
bpf_ima_inode_hash). Allowing local storage to be used from sleepable
programs allows such context to be managed with the benefits of
local_storage.

KP Singh (2):
  bpf: Allow bpf_local_storage to be used by sleepable programs
  bpf/selftests: Update local storage selftest for sleepable programs

 include/linux/bpf_local_storage.h             |  5 +++
 kernel/bpf/bpf_inode_storage.c                |  9 +++-
 kernel/bpf/bpf_local_storage.c                | 43 +++++++++++++++----
 kernel/bpf/bpf_task_storage.c                 |  6 ++-
 kernel/bpf/verifier.c                         |  3 ++
 net/core/bpf_sk_storage.c                     |  8 +++-
 .../bpf/prog_tests/test_local_storage.c       | 20 +++------
 .../selftests/bpf/progs/local_storage.c       | 24 +++--------
 8 files changed, 72 insertions(+), 46 deletions(-)

-- 
2.33.0.259.gc128427fd7-goog

