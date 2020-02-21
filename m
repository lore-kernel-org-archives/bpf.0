Return-Path: <SRS0=DBDY=4J=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FE6EC35669
	for <bpf@archiver.kernel.org>; Fri, 21 Feb 2020 20:34:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F1432072C
	for <bpf@archiver.kernel.org>; Fri, 21 Feb 2020 20:34:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726731AbgBUUen (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 21 Feb 2020 15:34:43 -0500
Received: from 2.mo173.mail-out.ovh.net ([178.33.251.49]:39292 "EHLO
        2.mo173.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726483AbgBUUen (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 21 Feb 2020 15:34:43 -0500
X-Greylist: delayed 4200 seconds by postgrey-1.27 at vger.kernel.org; Fri, 21 Feb 2020 15:34:42 EST
Received: from player791.ha.ovh.net (unknown [10.108.54.74])
        by mo173.mail-out.ovh.net (Postfix) with ESMTP id 6BDA0132AE0
        for <bpf@vger.kernel.org>; Fri, 21 Feb 2020 17:58:19 +0100 (CET)
Received: from sk2.org (82-65-25-201.subs.proxad.net [82.65.25.201])
        (Authenticated sender: steve@sk2.org)
        by player791.ha.ovh.net (Postfix) with ESMTPSA id 473BFF972430;
        Fri, 21 Feb 2020 16:58:08 +0000 (UTC)
From:   Stephen Kitt <steve@sk2.org>
To:     Jonathan Corbet <corbet@lwn.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>, bpf@vger.kernel.org,
        linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Stephen Kitt <steve@sk2.org>
Subject: [PATCH] docs: sysctl/kernel: document BPF entries
Date:   Fri, 21 Feb 2020 17:58:01 +0100
Message-Id: <20200221165801.32687-1-steve@sk2.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 876794555126336901
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedugedrkeeggdelhecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomhepufhtvghphhgvnhcumfhithhtuceoshhtvghvvgesshhkvddrohhrgheqnecukfhppedtrddtrddtrddtpdekvddrieehrddvhedrvddtudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejledurdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepshhtvghvvgesshhkvddrohhrghdprhgtphhtthhopegsphhfsehvghgvrhdrkhgvrhhnvghlrdhorhhg
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Based on the implementation in kernel/bpf/syscall.c,
kernel/bpf/trampoline.c, include/linux/filter.h, and the documentation
in bpftool-prog.rst.

Signed-off-by: Stephen Kitt <steve@sk2.org>
---
 Documentation/admin-guide/sysctl/kernel.rst | 24 +++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
index 1c48ab4bfe30..89c70ea7de7c 100644
--- a/Documentation/admin-guide/sysctl/kernel.rst
+++ b/Documentation/admin-guide/sysctl/kernel.rst
@@ -102,6 +102,20 @@ See the ``type_of_loader`` and ``ext_loader_ver`` fields in
 :doc:`/x86/boot` for additional information.
 
 
+bpf_stats_enabled
+=================
+
+Controls whether the kernel should collect statistics on BPF programs
+(total time spent running, number of times run...). Enabling
+statistics causes a slight reduction in performance on each program
+run. The statistics can be seen using ``bpftool``.
+
+= ===================================
+0 Don't collect statistics (default).
+1 Collect statistics.
+= ===================================
+
+
 cap_last_cap
 ============
 
@@ -1152,6 +1166,16 @@ NMI switch that most IA32 servers have fires unknown NMI up, for
 example.  If a system hangs up, try pressing the NMI switch.
 
 
+unprivileged_bpf_disabled
+=========================
+
+Writing 1 to this entry will disabled unprivileged calls to ``bpf()``;
+once disabled, calling ``bpf()`` without ``CAP_SYS_ADMIN`` will return
+``-EPERM``.
+
+Once set, this can't be cleared.
+
+
 watchdog
 ========
 
-- 
2.20.1

