Return-Path: <SRS0=vk/n=RD=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36981C43381
	for <bpf@archiver.kernel.org>; Thu, 28 Feb 2019 23:19:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09D1120663
	for <bpf@archiver.kernel.org>; Thu, 28 Feb 2019 23:19:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729483AbfB1XTI (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 28 Feb 2019 18:19:08 -0500
Received: from www62.your-server.de ([213.133.104.62]:52334 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728823AbfB1XTI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 28 Feb 2019 18:19:08 -0500
Received: from [178.197.248.21] (helo=localhost)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1gzUxC-0000lH-EH; Fri, 01 Mar 2019 00:19:02 +0100
From:   Daniel Borkmann <daniel@iogearbox.net>
To:     ast@fb.com
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org, joe@wand.net.nz,
        john.fastabend@gmail.com, tgraf@suug.ch, yhs@fb.com,
        andriin@fb.com, jakub.kicinski@netronome.com, lmb@cloudflare.com,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH bpf-next v2 0/7] BPF support for global data
Date:   Fri,  1 Mar 2019 00:18:22 +0100
Message-Id: <20190228231829.11993-1-daniel@iogearbox.net>
X-Mailer: git-send-email 2.9.5
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.2/25374/Thu Feb 28 11:38:05 2019)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This series is a major rework of previously submitted libbpf
patches [0] in order to add global data support for BPF. The
kernel has been extended to add proper infrastructure that allows
for full .bss/.data/.rodata sections on BPF loader side based
upon feedback from LPC discussions [1]. Latter support is then
also added into libbpf in this series which allows for more
natural C-like programming of BPF programs. For more information
on loader, please refer to 'bpf, libbpf: support global data/bss/
rodata sections' patch in this series. Joint work with Joe Stringer.

Thanks a lot!

  v1 -> v2:
    - Instead of 32-bit static data, implement full global
      data support.

  [0] https://patchwork.ozlabs.org/cover/1040290/
  [1] http://vger.kernel.org/lpc-bpf2018.html#session-3

Daniel Borkmann (5):
  bpf: implement lookup-free direct value access
  bpf: add program side {rd,wr}only support
  bpf, obj: allow . char as part of the name
  bpf, libbpf: support global data/bss/rodata sections
  bpf, selftest: test {rd,wr}only flags and direct value access

Joe Stringer (2):
  bpf, libbpf: refactor relocation handling
  bpf, selftest: test global data/bss/rodata sections

 include/linux/bpf.h                           |  24 ++
 include/linux/bpf_verifier.h                  |   4 +
 include/uapi/linux/bpf.h                      |  16 +-
 kernel/bpf/arraymap.c                         |  35 +-
 kernel/bpf/core.c                             |   3 +-
 kernel/bpf/disasm.c                           |   5 +-
 kernel/bpf/hashtab.c                          |   2 +-
 kernel/bpf/local_storage.c                    |   2 +-
 kernel/bpf/lpm_trie.c                         |   2 +-
 kernel/bpf/queue_stack_maps.c                 |   3 +-
 kernel/bpf/syscall.c                          |  35 +-
 kernel/bpf/verifier.c                         | 103 ++++--
 tools/bpf/bpftool/xlated_dumper.c             |   3 +
 tools/include/linux/filter.h                  |  19 +-
 tools/include/uapi/linux/bpf.h                |  16 +-
 tools/lib/bpf/libbpf.c                        | 321 ++++++++++++++----
 tools/testing/selftests/bpf/bpf_helpers.h     |   2 +-
 .../selftests/bpf/progs/test_global_data.c    |  61 ++++
 tools/testing/selftests/bpf/test_progs.c      |  50 +++
 tools/testing/selftests/bpf/test_verifier.c   |  40 ++-
 .../selftests/bpf/verifier/array_access.c     | 159 +++++++++
 .../bpf/verifier/direct_value_access.c        | 170 ++++++++++
 22 files changed, 955 insertions(+), 120 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/test_global_data.c
 create mode 100644 tools/testing/selftests/bpf/verifier/direct_value_access.c

-- 
2.17.1

