Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E1C2C433E6
	for <bpf@archiver.kernel.org>; Sat, 16 Jan 2021 18:23:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 625B9229C4
	for <bpf@archiver.kernel.org>; Sat, 16 Jan 2021 18:23:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727454AbhAPSWu (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Sat, 16 Jan 2021 13:22:50 -0500
Received: from foss.arm.com ([217.140.110.172]:56640 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727407AbhAPSWu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 16 Jan 2021 13:22:50 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5C76BD6E;
        Sat, 16 Jan 2021 10:22:04 -0800 (PST)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.194.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 083B03F70D;
        Sat, 16 Jan 2021 10:22:02 -0800 (PST)
From:   Qais Yousef <qais.yousef@arm.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Yonghong Song <yhs@fb.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Qais Yousef <qais.yousef@arm.com>
Subject: [PATCH v2 bpf-next 0/2] Allow attaching to bare tracepoints
Date:   Sat, 16 Jan 2021 18:21:31 +0000
Message-Id: <20210116182133.2286884-1-qais.yousef@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Changes in v2:
	* Fix compilation error.
	* Make the new test use write() instead of read()

Add some missing glue logic to teach bpf about bare tracepoints - tracepoints
without any trace event associated with them.

Bare tracepoints are declare with DECLARE_TRACE(). Full tracepoints are declare
with TRACE_EVENT().

BPF can attach to these tracepoints as RAW_TRACEPOINT() only as there're no
events in tracefs created with them.

Qais Yousef (2):
  trace: bpf: Allow bpf to attach to bare tracepoints
  selftests: bpf: Add a new test for bare tracepoints

 Documentation/bpf/bpf_design_QA.rst           |  6 +++++
 include/trace/bpf_probe.h                     | 12 +++++++--
 .../bpf/bpf_testmod/bpf_testmod-events.h      |  6 +++++
 .../selftests/bpf/bpf_testmod/bpf_testmod.c   | 21 ++++++++++++++-
 .../selftests/bpf/bpf_testmod/bpf_testmod.h   |  6 +++++
 .../selftests/bpf/prog_tests/module_attach.c  | 27 +++++++++++++++++++
 .../selftests/bpf/progs/test_module_attach.c  | 10 +++++++
 7 files changed, 85 insertions(+), 3 deletions(-)

-- 
2.25.1

