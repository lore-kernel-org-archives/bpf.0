Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F40FC433DB
	for <bpf@archiver.kernel.org>; Mon, 11 Jan 2021 21:24:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3130522BED
	for <bpf@archiver.kernel.org>; Mon, 11 Jan 2021 21:24:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728605AbhAKVYZ (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 11 Jan 2021 16:24:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:45344 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727525AbhAKVYZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 11 Jan 2021 16:24:25 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9CF4D22CB2;
        Mon, 11 Jan 2021 21:23:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610400224;
        bh=L0oHmXyzyu9jBXHht79UJ0wZWMLrCnskYRSWfs5H5ws=;
        h=From:To:Cc:Subject:Date:From;
        b=q7gu/VNTFlfs8rT0PSTQ0ZSRd1mBm5YmOBBYkHWRYIjudKlWTiRFRsU+SA9MLEEOn
         WXLka4gzZrteDZwWzGUI2esO3NM4+pr+2ujFIax5gk3N3HzKE4oaxIIpDEpURWn0bU
         h53QWcWLfADdnKJMa0uTY0eZOKrT1/8wY3K6POyRkrW0/SQpw0ctgy540VMN1L4jRH
         ndVITGUXQu2AfqNCZsggay/aImhY2Zkc8daCnfFZk347q6AnBDwzf9FmAkqOBDBMDO
         Je9YpN3w7yHa4zfOgEdSU2Wb1fkheK4MXgrdJEPQl3ljb6ofr4+pdDVFC2PrX4F01t
         sgsYrhzR9R7/Q==
From:   KP Singh <kpsingh@kernel.org>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>
Subject: [PATCH bpf v2 0/3] Fix local storage helper OOPs
Date:   Mon, 11 Jan 2021 21:23:37 +0000
Message-Id: <20210111212340.86393-1-kpsingh@kernel.org>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

It was noted in
https://lore.kernel.org/bpf/CACYkzJ55X8Tp2q4+EFf2hOM_Lysoim1xJY1YdA3k=T3woMW6mg@mail.gmail.com/T/#t
that the local storage helpers do not handle null owner pointers
correctly. This patch fixes the task and inode storage helpers with a
null check. In order to keep the check explicit, it's kept in the body
of the helpers similar to sk_storage and also fixes a minor typo in
bpf_inode_storage.c [I did not add a fixes and reported tag to the
patch that fixes the typo since it's a non-functional change].

The series also incorporates the example posted by Gilad into the
selftest. The selftest, without the fix reproduces the oops and the
subsequent patch fixes it.

KP Singh (3):
  bpf: update local storage test to check handling of null ptrs
  bpf: local storage helpers should check nullness of owner ptr passed
  bpf: Fix typo in bpf_inode_storage.c

 kernel/bpf/bpf_inode_storage.c                |  9 +-
 kernel/bpf/bpf_task_storage.c                 |  5 +-
 .../bpf/prog_tests/test_local_storage.c       | 96 +++++--------------
 .../selftests/bpf/progs/local_storage.c       | 62 ++++++------
 4 files changed, 71 insertions(+), 101 deletions(-)

-- 
2.30.0.284.gd98b1dd5eaa7-goog

