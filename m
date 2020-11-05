Return-Path: <SRS0=NbGg=EL=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80F88C388F7
	for <bpf@archiver.kernel.org>; Thu,  5 Nov 2020 00:26:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24B8F206DC
	for <bpf@archiver.kernel.org>; Thu,  5 Nov 2020 00:26:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DEVDRcJ2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732848AbgKEAYo (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 4 Nov 2020 19:24:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:28107 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728323AbgKEAOR (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 4 Nov 2020 19:14:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604535255;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WgNzPrMRWMTkptqOa05ejOci8goRgD8ij+h1kCV7zHo=;
        b=DEVDRcJ2OJJ1Fj5C432+51FWBKZUWSWYTMrXI8BlzhDC3u2b4e3kpHtXO1g2hLdMva3tHK
        wLulOJJ5eO/tEGIC0uG29l8Hb3RI7pgbEssTWXHENgFpGS/5kVfnQ74IgZ6TZleGGEoRTu
        44nzSx8WRsy7fjMrZQBk/qG1USMF1Ug=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-244-ex9LEUj8M7ub4_d0L-DgDQ-1; Wed, 04 Nov 2020 19:14:13 -0500
X-MC-Unique: ex9LEUj8M7ub4_d0L-DgDQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2481C10082E8;
        Thu,  5 Nov 2020 00:14:11 +0000 (UTC)
Received: from mail (ovpn-116-241.rdu2.redhat.com [10.10.116.241])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B3E1D1007600;
        Thu,  5 Nov 2020 00:14:06 +0000 (UTC)
From:   Andrea Arcangeli <aarcange@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     YiFei Zhu <zhuyifei1999@gmail.com>,
        Linux Containers <containers@lists.linux-foundation.org>,
        YiFei Zhu <yifeifz2@illinois.edu>, bpf <bpf@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Andy Lutomirski <luto@amacapital.net>,
        David Laight <David.Laight@aculab.com>,
        Dimitrios Skarlatos <dskarlat@cs.cmu.edu>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Hubertus Franke <frankeh@us.ibm.com>,
        Jack Chen <jianyan2@illinois.edu>,
        Jann Horn <jannh@google.com>,
        Josep Torrellas <torrella@illinois.edu>,
        Tianyin Xu <tyxu@illinois.edu>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Tycho Andersen <tycho@tycho.pizza>,
        Valentin Rothberg <vrothber@redhat.com>,
        Will Drewry <wad@chromium.org>, Jiri Kosina <jikos@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: [PATCH 1/1] x86: deduplicate the spectre_v2_user documentation
Date:   Wed,  4 Nov 2020 19:14:06 -0500
Message-Id: <20201105001406.13005-2-aarcange@redhat.com>
In-Reply-To: <20201105001406.13005-1-aarcange@redhat.com>
References: <20201104234047.GA18850@redhat.com>
 <20201105001406.13005-1-aarcange@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This would need updating to make prctl be the new default, but it's
simpler to delete it and refer to the dup.

Signed-off-by: Andrea Arcangeli <aarcange@redhat.com>
---
 Documentation/admin-guide/hw-vuln/spectre.rst | 51 +------------------
 1 file changed, 2 insertions(+), 49 deletions(-)

diff --git a/Documentation/admin-guide/hw-vuln/spectre.rst b/Documentation/admin-guide/hw-vuln/spectre.rst
index 19b897cb1d45..ab7d402c1677 100644
--- a/Documentation/admin-guide/hw-vuln/spectre.rst
+++ b/Documentation/admin-guide/hw-vuln/spectre.rst
@@ -593,61 +593,14 @@ kernel command line.
 		Not specifying this option is equivalent to
 		spectre_v2=auto.
 
-For user space mitigation:
-
-        spectre_v2_user=
-
-		[X86] Control mitigation of Spectre variant 2
-		(indirect branch speculation) vulnerability between
-		user space tasks
-
-		on
-			Unconditionally enable mitigations. Is
-			enforced by spectre_v2=on
-
-		off
-			Unconditionally disable mitigations. Is
-			enforced by spectre_v2=off
-
-		prctl
-			Indirect branch speculation is enabled,
-			but mitigation can be enabled via prctl
-			per thread. The mitigation control state
-			is inherited on fork.
-
-		prctl,ibpb
-			Like "prctl" above, but only STIBP is
-			controlled per thread. IBPB is issued
-			always when switching between different user
-			space processes.
-
-		seccomp
-			Same as "prctl" above, but all seccomp
-			threads will enable the mitigation unless
-			they explicitly opt out.
-
-		seccomp,ibpb
-			Like "seccomp" above, but only STIBP is
-			controlled per thread. IBPB is issued
-			always when switching between different
-			user space processes.
-
-		auto
-			Kernel selects the mitigation depending on
-			the available CPU features and vulnerability.
-
-		Default mitigation:
-		If CONFIG_SECCOMP=y then "seccomp", otherwise "prctl"
-
-		Not specifying this option is equivalent to
-		spectre_v2_user=auto.
-
 		In general the kernel by default selects
 		reasonable mitigations for the current CPU. To
 		disable Spectre variant 2 mitigations, boot with
 		spectre_v2=off. Spectre variant 1 mitigations
 		cannot be disabled.
 
+For spectre_v2_user see :doc:`/admin-guide/kernel-parameters`.
+
 Mitigation selection guide
 --------------------------
 

