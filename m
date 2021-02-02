Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA783C433DB
	for <bpf@archiver.kernel.org>; Tue,  2 Feb 2021 22:16:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9529D64DDB
	for <bpf@archiver.kernel.org>; Tue,  2 Feb 2021 22:16:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233205AbhBBWQn (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 2 Feb 2021 17:16:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:34428 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233184AbhBBWQm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 2 Feb 2021 17:16:42 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 74A2764DDB;
        Tue,  2 Feb 2021 22:16:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612304161;
        bh=Ji6nL6OEqP9/WI2ViRhQ6MpdfS09HUG35m3I2gorebA=;
        h=From:To:Cc:Subject:Date:From;
        b=sa+H7c3f6paovMIukITmd8g73V4d0c4j496slDaeLqa1GyACzTtFMStvQddb2+SRR
         pOtU//DSBAg3KfGnauJnW22Q7SbkgsQM0b/q4IgQhfHk3AejoEZUm/dZpqFn+TIdo/
         7KwfpiQrLoDnwhnFERgvExtAgS+24Gqwv887/dtVCUgJbYhVOP4zsGFU8L/T9j9e4T
         ocWcNVc+7UGYhDgcF4D9ON2oJiu/FGTeDILOJB7wN4NNi6O0I7k5fU1YUXcrTrJDww
         97/sMmZ0n2SO+6EFu7Ohr1bUMUAt+Op8u5zudspjKXPTfqHkTRX1WWMviTroU0dn9J
         QU0iC5Z5PhCNA==
From:   KP Singh <kpsingh@kernel.org>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>
Subject: [PATCH bpf-next v4 0/2] BPF selftest helper script
Date:   Tue,  2 Feb 2021 22:15:55 +0000
Message-Id: <20210202221557.2039173-1-kpsingh@kernel.org>
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

# v3 -> v4

- Fix logic for updating kernel config to not download the file
  if there are no upstream modifications and avoid extraneous
  kernel compilation as suggested by Andrii.
- This also removes the need for the -k flag.

# v2 -> v3

- Fixes to silence verbose commands
- Fixed output buffering without being teed out
- Fixed the clobbered error code of the script
- Other fixes suggested by Andrii

# v1 -> v2

- The script now compiles the kernel by default, and the -k option
  implies "keep the kernel"
- Pointer to the script in the docs.
- Some minor simplifications.

Allow developers and contributors to understand if their changes would
end up breaking the BPF CI and avoid the back and forth required for
fixing the test cases in the CI environment. The series also adds a
pointer in tools/testing/selftests/bpf/README.rst.


KP Singh (2):
  bpf: Helper script for running BPF presubmit tests
  bpf/selftests: Add a short note about run_in_vm.sh in README.rst

 tools/testing/selftests/bpf/README.rst   |  24 ++
 tools/testing/selftests/bpf/run_in_vm.sh | 368 +++++++++++++++++++++++
 2 files changed, 392 insertions(+)
 create mode 100755 tools/testing/selftests/bpf/run_in_vm.sh

-- 
2.30.0.365.g02bc693789-goog

