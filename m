Return-Path: <SRS0=mLKS=3O=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C7C8C2D0DB
	for <bpf@archiver.kernel.org>; Sat, 25 Jan 2020 22:31:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D94672071E
	for <bpf@archiver.kernel.org>; Sat, 25 Jan 2020 22:31:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="my3L4jdg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gPOacjv6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727440AbgAYWbh (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Sat, 25 Jan 2020 17:31:37 -0500
Received: from wnew2-smtp.messagingengine.com ([64.147.123.27]:44603 "EHLO
        wnew2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727250AbgAYWbh (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sat, 25 Jan 2020 17:31:37 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id 509203C5;
        Sat, 25 Jan 2020 17:31:35 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Sat, 25 Jan 2020 17:31:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm2; bh=edZb6HITt6UVr7I2c+OC+aO2Zr
        bIvBHqXyYPhj4LQBA=; b=my3L4jdgk6Hl3D7In3J0I2kHX6jwtxFEqZLxGRHHDy
        WUQnlLKXla97sggu0RljKOEGqgtfLziX18B3L1wuG096HlupVUiJrQ+962z4OSKP
        kuThRhY3XhWmWiCq0P35LaHMtC8abCyM+9xvYnThJTNOo76LermpopmfI+w+62Se
        97B8R83UfUQ/Q1IxLlCygFFjvYl6Y+cyZ5wo14NcmYXuIb3zv2MsCQurpnochjBo
        XvZNJ7z95xsBIZffcZ7ykv3R124NcweXUSMO/YYQhrVKBR47YiJ+8YYowa5MafEs
        X8GyKntIOBUNKJPM98IptfpCwUDFkvpA63CdgaE1my9w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=edZb6HITt6UVr7I2c
        +OC+aO2ZrbIvBHqXyYPhj4LQBA=; b=gPOacjv6hIYa/F6QNNnY21LO5sux3ktI4
        vdiUPtqjV+n2zvr41tTUDRs39hM3rCz04mahW3cBr8zhfARMUZDPi8pxj0o2uKrj
        n22yLZNSwEPDoJYk9eLcWGwbPzERWsuEd2LJ1vtBOFJKx0JgYJUhszJzE17BWHBN
        i3h2fwEriBFPHhShbmfolZvJDXVAhdd/80Asg5kFmu+Kpp70Bq/9imNdk03I2XcA
        j3kylFrHDG1sRGLTiQ146/KTHZZLNecip7c9TusIL1zH/s2Orkw0ECEcOC3Qd0B0
        mnVG8zo3GEUPijBsWhH3fW9bu/tM1JBce6Xj7kPZt3wu6w2kSxs7A==
X-ME-Sender: <xms:xcEsXtO7wTiT27MnIcU_XrhZRtOPEIkae0Pt6KMATkxq6ARdvssPdw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrvdekgddviecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecufghrlhcuvffnffculdejtddmnecujfgurhephffvuf
    ffkffoggfgsedtkeertdertddtnecuhfhrohhmpeffrghnihgvlhcuighuuceougiguhes
    ugiguhhuuhdrgiihiieqnecukfhppeduleelrddvtddurdeigedrfeenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegugihusegugihuuhhurdig
    hiii
X-ME-Proxy: <xmx:xcEsXgcSJ92Sd47LYdLNWCEeyhdxuiRCbCvTVFTM8cJsts3sbWfNow>
    <xmx:xcEsXt_gsA3ZGI2TmchHp87mYQ-1itXyth5mHlviEaZhKgmPM8VmrQ>
    <xmx:xcEsXlFOjQDtcE5ZJ3eDNp09snUMzxK0Uiv0v0uBTTcKOn6GBqJ5dA>
    <xmx:xsEsXvvhQid8YTy28ZrSdk4xqVxqWeW8ptACCZl1mwDOuaTIURFhjOZpIyI>
Received: from dlxu-fedora-R90QNFJV.thefacebook.com (prn-fbagreements-ext.thefacebook.com [199.201.64.3])
        by mail.messagingengine.com (Postfix) with ESMTPA id 0F94A328005A;
        Sat, 25 Jan 2020 17:31:31 -0500 (EST)
From:   Daniel Xu <dxu@dxuuu.xyz>
To:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        songliubraving@fb.com, yhs@fb.com, andriin@fb.com
Cc:     Daniel Xu <dxu@dxuuu.xyz>, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org
Subject: [PATCH v5 bpf-next 0/2] Add bpf_read_branch_records() helper
Date:   Sat, 25 Jan 2020 14:31:15 -0800
Message-Id: <20200125223117.20813-1-dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Branch records are a CPU feature that can be configured to record
certain branches that are taken during code execution. This data is
particularly interesting for profile guided optimizations. perf has had
branch record support for a while but the data collection can be a bit
coarse grained.

We (Facebook) have seen in experiments that associating metadata with
branch records can improve results (after postprocessing). We generally
use bpf_probe_read_*() to get metadata out of userspace. That's why bpf
support for branch records is useful.

Aside from this particular use case, having branch data available to bpf
progs can be useful to get stack traces out of userspace applications
that omit frame pointers.

Changes in v5:
- Rename bpf_perf_prog_read_branches() -> bpf_read_branch_records()
- Rename BPF_F_GET_BR_SIZE -> BPF_F_GET_BRANCH_RECORDS_SIZE
- Squash tools/ bpf.h sync into selftest commit

Changes in v4:
- Add BPF_F_GET_BR_SIZE flag
- Return -ENOENT on unsupported architectures
- Only accept initialized memory in helper
- Check buffer size is multiple of sizeof(struct perf_branch_entry)
- Use bpf skeleton in selftest
- Add commit messages
- Spelling and formatting

Changes in v3:
- Document filling unused buffer with zero
- Formatting fixes
- Rebase

Changes in v2:
- Change to a bpf helper instead of context access
- Avoid mentioning Intel specific things

Daniel Xu (2):
  bpf: Add bpf_read_branch_records() helper
  selftests/bpf: add bpf_read_branch_records() selftest

 include/uapi/linux/bpf.h                      |  25 +++-
 kernel/trace/bpf_trace.c                      |  41 +++++++
 tools/include/uapi/linux/bpf.h                |  25 +++-
 .../selftests/bpf/prog_tests/perf_branches.c  | 112 ++++++++++++++++++
 .../selftests/bpf/progs/test_perf_branches.c  |  74 ++++++++++++
 5 files changed, 275 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/perf_branches.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_perf_branches.c

-- 
2.21.1

