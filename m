Return-Path: <SRS0=Zphp=SL=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA873C10F0E
	for <bpf@archiver.kernel.org>; Tue,  9 Apr 2019 21:21:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF1BE20857
	for <bpf@archiver.kernel.org>; Tue,  9 Apr 2019 21:21:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbfDIVUg (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 9 Apr 2019 17:20:36 -0400
Received: from www62.your-server.de ([213.133.104.62]:51984 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726487AbfDIVUf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 9 Apr 2019 17:20:35 -0400
Received: from [178.197.248.24] (helo=localhost)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1hDyAO-0001bu-IU; Tue, 09 Apr 2019 23:20:28 +0200
From:   Daniel Borkmann <daniel@iogearbox.net>
To:     bpf@vger.kernel.org
Cc:     netdev@vger.kernel.org, ast@kernel.org, joe@wand.net.nz,
        yhs@fb.com, andrii.nakryiko@gmail.com, kafai@fb.com,
        jannh@google.com, Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH bpf-next v6 00/16] BPF support for global data
Date:   Tue,  9 Apr 2019 23:20:02 +0200
Message-Id: <20190409212018.32423-1-daniel@iogearbox.net>
X-Mailer: git-send-email 2.9.5
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.3/25414/Tue Apr  9 09:53:33 2019)
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
rodata sections' patch in this series.

Thanks a lot!

  v5 -> v6:
   - Removed synchronize_rcu() from map freeze (Jann)
   - Rest as-is
  v4 -> v5:
   - Removed index selection again for ldimm64 (Alexei)
   - Adapted related test cases and added new ones to test
     rejection of off != 0
  v3 -> v4:
   - Various fixes in BTF verification e.g. to disallow
     Var and DataSec to be an intermediate type during resolve (Martin)
   - More BTF test cases added
   - Few cleanups in key-less BTF commit (Martin)
   - Bump libbpf minor version from 2 to 3
   - Renamed and simplified read-only locking
   - Various minor improvements all over the place
  v2 -> v3:
   - Implement BTF support in kernel, libbpf, bpftool, add tests
   - Fix idx + off conversion (Andrii)
   - Document lower / higher bits for direct value access (Andrii)
   - Add tests with small value size (Andrii)
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

Daniel Borkmann (14):
  bpf: implement lookup-free direct value access for maps
  bpf: do not retain flags that are not tied to map lifetime
  bpf: add program side {rd, wr}only support for maps
  bpf: add syscall side map freeze support
  bpf: allow . char as part of the object name
  bpf: add specification for BTF Var and DataSec kinds
  bpf: kernel side support for BTF Var and DataSec
  bpf: allow for key-less BTF in array map
  bpf: sync {btf, bpf}.h uapi header from tools infrastructure
  bpf, libbpf: support global data/bss/rodata sections
  bpf, libbpf: add support for BTF Var and DataSec
  bpf: bpftool support for dumping data/bss/rodata sections
  bpf, selftest: test {rd, wr}only flags and direct value access
  bpf, selftest: add test cases for BTF Var and DataSec

Joe Stringer (2):
  bpf, libbpf: refactor relocation handling
  bpf, selftest: test global data/bss/rodata sections

 Documentation/bpf/btf.rst                     |  57 ++
 include/linux/bpf.h                           |  38 +-
 include/linux/bpf_verifier.h                  |   4 +
 include/linux/btf.h                           |   1 +
 include/uapi/linux/bpf.h                      |  20 +-
 include/uapi/linux/btf.h                      |  32 +-
 kernel/bpf/arraymap.c                         |  53 +-
 kernel/bpf/btf.c                              | 419 ++++++++++-
 kernel/bpf/core.c                             |   3 +-
 kernel/bpf/disasm.c                           |   5 +-
 kernel/bpf/hashtab.c                          |   6 +-
 kernel/bpf/local_storage.c                    |   6 +-
 kernel/bpf/lpm_trie.c                         |   3 +-
 kernel/bpf/queue_stack_maps.c                 |   6 +-
 kernel/bpf/syscall.c                          | 131 +++-
 kernel/bpf/verifier.c                         | 132 +++-
 tools/bpf/bpftool/btf_dumper.c                |  59 ++
 tools/bpf/bpftool/map.c                       |  10 +-
 tools/bpf/bpftool/xlated_dumper.c             |   3 +
 tools/include/linux/filter.h                  |  21 +-
 tools/include/uapi/linux/bpf.h                |  20 +-
 tools/include/uapi/linux/btf.h                |  32 +-
 tools/lib/bpf/Makefile                        |   2 +-
 tools/lib/bpf/bpf.c                           |  10 +
 tools/lib/bpf/bpf.h                           |   1 +
 tools/lib/bpf/btf.c                           |  97 ++-
 tools/lib/bpf/btf.h                           |   3 +
 tools/lib/bpf/libbpf.c                        | 546 +++++++++++---
 tools/lib/bpf/libbpf.h                        |   5 +
 tools/lib/bpf/libbpf.map                      |   7 +
 tools/testing/selftests/bpf/bpf_helpers.h     |   8 +-
 .../selftests/bpf/prog_tests/global_data.c    | 157 +++++
 .../selftests/bpf/progs/test_global_data.c    | 106 +++
 tools/testing/selftests/bpf/test_btf.c        | 665 +++++++++++++++++-
 tools/testing/selftests/bpf/test_verifier.c   |  51 +-
 .../selftests/bpf/verifier/array_access.c     | 159 +++++
 .../bpf/verifier/direct_value_access.c        | 347 +++++++++
 37 files changed, 3018 insertions(+), 207 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/global_data.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_global_data.c
 create mode 100644 tools/testing/selftests/bpf/verifier/direct_value_access.c

-- 
2.17.1

