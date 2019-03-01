Return-Path: <SRS0=adOE=RE=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC8ADC4360F
	for <bpf@archiver.kernel.org>; Fri,  1 Mar 2019 01:12:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB025218AE
	for <bpf@archiver.kernel.org>; Fri,  1 Mar 2019 01:12:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="Arv+H+Zn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728147AbfCABMc (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 28 Feb 2019 20:12:32 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:40408 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1733044AbfCABMa (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 28 Feb 2019 20:12:30 -0500
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2110Fs7005804
        for <bpf@vger.kernel.org>; Thu, 28 Feb 2019 17:12:29 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=tcoldpO56bCr3y3Sc3Kgmu4itDd7Ce9MZbI5BS5q1rY=;
 b=Arv+H+ZnE7q/RAknPdBqdoIG499GDEkSOIqfBc1eLdYQPFXpG/FDlgzviQOyn6ZRHP+s
 uy8YVG87EmYOt0XisUG6Z+UXT1Bjfx2vHjnqVSWKQ3roOd3/heCIsP2jp52NEmJFQl2W
 f0p7JexlDdI8aqlb/zKoA1TvT4ZpeqgIBas= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2qxqw2gjmm-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 28 Feb 2019 17:12:29 -0800
Received: from mx-out.facebook.com (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::130) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1531.3;
 Thu, 28 Feb 2019 17:12:25 -0800
Received: by devvm7221.prn2.facebook.com (Postfix, from userid 137359)
        id 7A9E5C168024; Thu, 28 Feb 2019 17:12:25 -0800 (PST)
Smtp-Origin-Hostprefix: devvm
From:   Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Hostname: devvm7221.prn2.facebook.com
To:     <andrii.nakryiko@gmail.com>, <ast@fb.com>, <yhs@fb.com>,
        <netdev@vger.kernel.org>, <bpf@vger.kernel.org>,
        <daniel@iogearbox.net>, <songliubraving@fb.com>
CC:     Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH v2 bpf-next 3/3] docs/bpf: minor casing/punctuation fixes
Date:   Thu, 28 Feb 2019 17:12:21 -0800
Message-ID: <20190301011221.1290474-4-andriin@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190301011221.1290474-1-andriin@fb.com>
References: <20190301011221.1290474-1-andriin@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-01_01:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Fix few casing and punctuation glitches.

Signed-off-by: Andrii Nakryiko <andriin@fb.com>
---
 Documentation/bpf/bpf_design_QA.rst | 24 ++++++++++++------------
 Documentation/networking/filter.txt |  2 +-
 2 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/Documentation/bpf/bpf_design_QA.rst b/Documentation/bpf/bpf_design_QA.rst
index 7cc9e368c1e9..10453c627135 100644
--- a/Documentation/bpf/bpf_design_QA.rst
+++ b/Documentation/bpf/bpf_design_QA.rst
@@ -36,27 +36,27 @@ consideration important quirks of other architectures) and
 defines calling convention that is compatible with C calling
 convention of the linux kernel on those architectures.
 
-Q: can multiple return values be supported in the future?
+Q: Can multiple return values be supported in the future?
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 A: NO. BPF allows only register R0 to be used as return value.
 
-Q: can more than 5 function arguments be supported in the future?
+Q: Can more than 5 function arguments be supported in the future?
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 A: NO. BPF calling convention only allows registers R1-R5 to be used
 as arguments. BPF is not a standalone instruction set.
 (unlike x64 ISA that allows msft, cdecl and other conventions)
 
-Q: can BPF programs access instruction pointer or return address?
+Q: Can BPF programs access instruction pointer or return address?
 -----------------------------------------------------------------
 A: NO.
 
-Q: can BPF programs access stack pointer ?
+Q: Can BPF programs access stack pointer ?
 ------------------------------------------
 A: NO.
 
 Only frame pointer (register R10) is accessible.
 From compiler point of view it's necessary to have stack pointer.
-For example LLVM defines register R11 as stack pointer in its
+For example, LLVM defines register R11 as stack pointer in its
 BPF backend, but it makes sure that generated code never uses it.
 
 Q: Does C-calling convention diminishes possible use cases?
@@ -66,8 +66,8 @@ A: YES.
 BPF design forces addition of major functionality in the form
 of kernel helper functions and kernel objects like BPF maps with
 seamless interoperability between them. It lets kernel call into
-BPF programs and programs call kernel helpers with zero overhead.
-As all of them were native C code. That is particularly the case
+BPF programs and programs call kernel helpers with zero overhead,
+as all of them were native C code. That is particularly the case
 for JITed BPF programs that are indistinguishable from
 native kernel C code.
 
@@ -75,9 +75,9 @@ Q: Does it mean that 'innovative' extensions to BPF code are disallowed?
 ------------------------------------------------------------------------
 A: Soft yes.
 
-At least for now until BPF core has support for
+At least for now, until BPF core has support for
 bpf-to-bpf calls, indirect calls, loops, global variables,
-jump tables, read only sections and all other normal constructs
+jump tables, read-only sections, and all other normal constructs
 that C code can produce.
 
 Q: Can loops be supported in a safe way?
@@ -109,16 +109,16 @@ For example why BPF_JNE and other compare and jumps are not cpu-like?
 A: This was necessary to avoid introducing flags into ISA which are
 impossible to make generic and efficient across CPU architectures.
 
-Q: why BPF_DIV instruction doesn't map to x64 div?
+Q: Why BPF_DIV instruction doesn't map to x64 div?
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 A: Because if we picked one-to-one relationship to x64 it would have made
 it more complicated to support on arm64 and other archs. Also it
 needs div-by-zero runtime check.
 
-Q: why there is no BPF_SDIV for signed divide operation?
+Q: Why there is no BPF_SDIV for signed divide operation?
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 A: Because it would be rarely used. llvm errors in such case and
-prints a suggestion to use unsigned divide instead
+prints a suggestion to use unsigned divide instead.
 
 Q: Why BPF has implicit prologue and epilogue?
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
diff --git a/Documentation/networking/filter.txt b/Documentation/networking/filter.txt
index b5e060edfc38..319e5e041f38 100644
--- a/Documentation/networking/filter.txt
+++ b/Documentation/networking/filter.txt
@@ -829,7 +829,7 @@ tracing filters may do to maintain counters of events, for example. Register R9
 is not used by socket filters either, but more complex filters may be running
 out of registers and would have to resort to spill/fill to stack.
 
-Internal BPF can used as generic assembler for last step performance
+Internal BPF can be used as a generic assembler for last step performance
 optimizations, socket filters and seccomp are using it as assembler. Tracing
 filters may use it as assembler to generate code from kernel. In kernel usage
 may not be bounded by security considerations, since generated internal BPF code
-- 
2.17.1

