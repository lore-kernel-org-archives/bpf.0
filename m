Return-Path: <SRS0=COpY=6U=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBABDC47256
	for <bpf@archiver.kernel.org>; Wed,  6 May 2020 13:30:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A65CE20746
	for <bpf@archiver.kernel.org>; Wed,  6 May 2020 13:30:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588771803;
	bh=8UVLRrEHDsyBqeBFpC4SA6532Xwe/HIw33IyYSgKtHM=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=ccN3yylQCE8kLWt3anOzRoMTIQnmgfrZKHxZYFIPyec6HcPKrMc7yZWbvWN6rCJGK
	 QwhHBpKzYNVbeSqK/FvOPMMu//99M120JB0CdeyFxIBYgy+hAOsmZo5KpKBpkxS5Eo
	 4xwj9vloLHM9ThvhCvHQi4ztksfuHa9oIx7uOJOk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728081AbgEFNaD convert rfc822-to-8bit (ORCPT
        <rfc822;bpf@archiver.kernel.org>); Wed, 6 May 2020 09:30:03 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:59774 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728455AbgEFNaC (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 6 May 2020 09:30:02 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-147-pFw9-MQOOZm0HegEa3po5A-1; Wed, 06 May 2020 09:29:53 -0400
X-MC-Unique: pFw9-MQOOZm0HegEa3po5A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 84FAF835B45;
        Wed,  6 May 2020 13:29:51 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.192.32])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E0EAB64441;
        Wed,  6 May 2020 13:29:47 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        Yonghong Song <yhs@fb.com>, Martin KaFai Lau <kafai@fb.com>,
        David Miller <davem@redhat.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Wenbo Zhang <ethercflow@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Andrii Nakryiko <andriin@fb.com>, bgregg@netflix.com,
        Florent Revest <revest@chromium.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: [RFCv2 0/9] bpf: Add d_path helper
Date:   Wed,  6 May 2020 15:29:37 +0200
Message-Id: <20200506132946.2164578-1-jolsa@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kernel.org
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

hi,
adding d_path helper to return full path for 'path' object.

I originally added and used 'file_path' helper, which did the same,
but used 'struct file' object. Then realized that file_path is just
a wrapper for d_path, so we'd cover more calling sites if we add
d_path helper and allowed resolving BTF object within another object,
so we could call d_path also with file pointer, like:

  bpf_d_path(&file->f_path, buf, size);

This feature is mainly to be able to add dpath (filepath originally)
function to bpftrace, which seems to work nicely now, like:

  # bpftrace -e 'kfunc:vfs_open { printf("%s\n", dpath(args->path)); }'


RFC v2 changes:

  - added whitelist support, d_path helper is allowed only for
    list of functions, the whitelist checking works as follows:

      - helper's whitelist is defined as list of functions in file:
        kernel/bpf/helpers-whitelist/helper
      - at vmlinux linking time, the bpfwl tool reads the whitelist
        and translates functions into BTF IDs, which are then compiled
        as following data section into vmlinux object:

          .BTF_whitelist
              BTF_whitelist_<helper1>
              BTF_whitelist_<helper2>
              BTF_whitelist_<helper3>

        Each BTF_whitelist_<helperX> data is a sorted array of BTF ids.
      - new 'allowed' function is added to 'struct bpf_func_proto',
        which is used by verifier code to check (if defined) on whether
        the helper is called from allowed function (from whitelist).

    Currently it's needed and implemented only for d_path helper,
    but it's easy to add support for another helper.

  - I don't change the btf_id value in check_func_arg as suggested by Alexei
  - added new test_verifier test

Also available at:
  https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
  bpf/d_path

thoughts? thanks,
jirka


---
Jiri Olsa (9):
      bpf: Add d_path helper
      bpf: Add d_path whitelist
      bpf: Add bpfwl tool to construct bpf whitelists
      bpf: Allow nested BTF object to be refferenced by BTF object + offset
      bpf: Add support to check on BTF id whitelist for d_path helper
      bpf: Compile bpfwl tool at kernel compilation start
      bpf: Compile the BTF id whitelist data in vmlinux
      selftests/bpf: Add test for d_path helper
      selftests/bpf: Add verifier test for d_path helper

 Makefile                                        |  24 +++++++--
 include/asm-generic/vmlinux.lds.h               |   5 ++
 include/linux/bpf.h                             |   4 ++
 include/uapi/linux/bpf.h                        |  14 +++++-
 kernel/bpf/btf.c                                |  69 +++++++++++++++++++++++++
 kernel/bpf/helpers-whitelist/d_path             |   8 +++
 kernel/bpf/verifier.c                           |  37 ++++++++++----
 kernel/trace/bpf_trace.c                        |  54 ++++++++++++++++++++
 scripts/bpf_helpers_doc.py                      |   2 +
 scripts/link-vmlinux.sh                         |  20 ++++++--
 tools/Makefile                                  |   3 ++
 tools/bpf/Makefile                              |   5 +-
 tools/bpf/bpfwl/Build                           |  11 ++++
 tools/bpf/bpfwl/Makefile                        |  60 ++++++++++++++++++++++
 tools/bpf/bpfwl/bpfwl.c                         | 285 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tools/include/uapi/linux/bpf.h                  |  14 +++++-
 tools/testing/selftests/bpf/prog_tests/d_path.c | 196 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tools/testing/selftests/bpf/progs/test_d_path.c |  71 ++++++++++++++++++++++++++
 tools/testing/selftests/bpf/test_verifier.c     |  13 ++++-
 tools/testing/selftests/bpf/verifier/d_path.c   |  37 ++++++++++++++
 20 files changed, 908 insertions(+), 24 deletions(-)
 create mode 100644 kernel/bpf/helpers-whitelist/d_path
 create mode 100644 tools/bpf/bpfwl/Build
 create mode 100644 tools/bpf/bpfwl/Makefile
 create mode 100644 tools/bpf/bpfwl/bpfwl.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/d_path.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_d_path.c
 create mode 100644 tools/testing/selftests/bpf/verifier/d_path.c

