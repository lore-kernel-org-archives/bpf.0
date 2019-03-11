Return-Path: <SRS0=tULY=RO=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D69FC4360F
	for <bpf@archiver.kernel.org>; Mon, 11 Mar 2019 21:51:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15DF0214AF
	for <bpf@archiver.kernel.org>; Mon, 11 Mar 2019 21:51:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728317AbfCKVvp (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 11 Mar 2019 17:51:45 -0400
Received: from www62.your-server.de ([213.133.104.62]:41122 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727973AbfCKVvo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 11 Mar 2019 17:51:44 -0400
Received: from [178.197.248.21] (helo=localhost)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1h3Spd-0003Mr-Cj; Mon, 11 Mar 2019 22:51:37 +0100
From:   Daniel Borkmann <daniel@iogearbox.net>
To:     ast@kernel.org
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org, joe@wand.net.nz,
        john.fastabend@gmail.com, yhs@fb.com, andrii.nakryiko@gmail.com,
        jakub.kicinski@netronome.com, tgraf@suug.ch, lmb@cloudflare.com,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH rfc v3 bpf-next 0/9] BPF support for global data
Date:   Mon, 11 Mar 2019 22:51:16 +0100
Message-Id: <20190311215125.17793-1-daniel@iogearbox.net>
X-Mailer: git-send-email 2.9.5
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.2/25385/Mon Mar 11 08:43:35 2019)
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

Note, since merge window is still open, sending as rfc to dump
current progress I have from last v2 series, final v3 will go
out once bpf-next is open again.

  v2 -> rfc v3:
   - Add index selection into ldimm64 (Andrii)
   - Fix missing fdput() (Jann)
   - Reject invalid flags in BPF_F_*_PROG (Jakub)
   - Complete rework of libbpf support, includes:
    - Add objname to map name (Stanislav)
    - Make .rodata map full read-only after setup (Andrii)
    - Merge relocation handling into single one (Andrii)
    - Store global maps into obj->maps array (Andrii, Alexei)
    - Debug message when skipping section (Andrii)
    - Reject non-static global data till we have
      semantics for sharing them (Yonghong, Andrii, Alexei)
    - More test cases and completely reworked prog test (Alexei)
   - Fixes, cleanups, etc all over the set
   - Not yet addressed:
    - Make BTF mandatory for these maps (Alexei)
    -> Waiting till BTF support for these lands first
  v1 -> v2:
    - Instead of 32-bit static data, implement full global
      data support (Alexei)

  [0] https://patchwork.ozlabs.org/cover/1040290/
  [1] http://vger.kernel.org/lpc-bpf2018.html#session-3

Daniel Borkmann (7):
  bpf: implement lookup-free direct value access for maps
  bpf: add program side {rd,wr}only support for maps
  bpf: add syscall side map lock support
  bpf, obj: allow . char as part of the name
  bpf: sync bpf.h uapi header from tools infrastructure
  bpf, libbpf: support global data/bss/rodata sections
  bpf, selftest: test {rd,wr}only flags and direct value access

Joe Stringer (2):
  bpf, libbpf: refactor relocation handling
  bpf, selftest: test global data/bss/rodata sections

 include/linux/bpf.h                           |  35 +-
 include/linux/bpf_verifier.h                  |   4 +
 include/uapi/linux/bpf.h                      |  24 +-
 kernel/bpf/arraymap.c                         |  32 +-
 kernel/bpf/core.c                             |   3 +-
 kernel/bpf/disasm.c                           |   5 +-
 kernel/bpf/hashtab.c                          |   6 +-
 kernel/bpf/local_storage.c                    |   6 +-
 kernel/bpf/lpm_trie.c                         |   3 +-
 kernel/bpf/queue_stack_maps.c                 |   6 +-
 kernel/bpf/syscall.c                          | 111 ++++-
 kernel/bpf/verifier.c                         | 155 +++++--
 tools/bpf/bpftool/xlated_dumper.c             |   6 +
 tools/include/linux/filter.h                  |  14 +
 tools/include/uapi/linux/bpf.h                |  24 +-
 tools/lib/bpf/bpf.c                           |  10 +
 tools/lib/bpf/bpf.h                           |   1 +
 tools/lib/bpf/libbpf.c                        | 378 ++++++++++++++----
 tools/lib/bpf/libbpf.h                        |   1 +
 tools/lib/bpf/libbpf.map                      |   6 +
 tools/testing/selftests/bpf/bpf_helpers.h     |   8 +-
 .../selftests/bpf/prog_tests/global_data.c    | 157 ++++++++
 .../selftests/bpf/progs/test_global_data.c    | 106 +++++
 tools/testing/selftests/bpf/test_verifier.c   |  42 +-
 .../selftests/bpf/verifier/array_access.c     | 159 ++++++++
 .../bpf/verifier/direct_value_access.c        | 226 +++++++++++
 26 files changed, 1382 insertions(+), 146 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/global_data.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_global_data.c
 create mode 100644 tools/testing/selftests/bpf/verifier/direct_value_access.c

-- 
2.17.1

