Return-Path: <SRS0=w44S=Q3=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7037C43381
	for <bpf@archiver.kernel.org>; Wed, 20 Feb 2019 20:58:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D9AA2146E
	for <bpf@archiver.kernel.org>; Wed, 20 Feb 2019 20:58:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="g7dwJdlQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726166AbfBTU6C (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 20 Feb 2019 15:58:02 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:38720 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725881AbfBTU6C (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 20 Feb 2019 15:58:02 -0500
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.27/8.16.0.27) with SMTP id x1KKrqOc018184
        for <bpf@vger.kernel.org>; Wed, 20 Feb 2019 12:58:00 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=s2pEXgTbXC48yvjFSb8HN/IdabD+C4BOxma+JXRKtT4=;
 b=g7dwJdlQYUI0Llnyky6XuI1tG/0LRC8vB456Qo/lELdOMmeCyMnKYwQhtP1nTa1zGVFF
 wGWzPDoYyKJDNRZfNRiENRIYC9Bm+YdowJf3i9/7dg04E440aKEwbznwBkMyMubQRNiu
 wVUwRD0ezJS7EBsmLZyd8VUsZuJdzOScSaI= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by m0001303.ppops.net with ESMTP id 2qsax5rqr4-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 20 Feb 2019 12:58:00 -0800
Received: from mx-out.facebook.com (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::126) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1531.3;
 Wed, 20 Feb 2019 12:57:34 -0800
Received: by devvm7221.prn2.facebook.com (Postfix, from userid 137359)
        id 2EDD8B3AA4BB; Wed, 20 Feb 2019 12:57:34 -0800 (PST)
Smtp-Origin-Hostprefix: devvm
From:   Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Hostname: devvm7221.prn2.facebook.com
To:     <andrii.nakryiko@gmail.com>, <acme@kernel.org>,
        <dwarves@vger.kernel.org>, <bpf@vger.kernel.org>, <ast@fb.com>,
        <yhs@fb.com>
CC:     Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH pahole 1/3] btfdiff: support specifying custom pahole location
Date:   Wed, 20 Feb 2019 12:57:30 -0800
Message-ID: <20190220205732.2514975-2-andriin@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190220205732.2514975-1-andriin@fb.com>
References: <20190220205732.2514975-1-andriin@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-20_15:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

During development it's convenient to be able to specify custom location
of pahole binary, built locally.

E.g.:
$ PAHOLE=~/local/pahole/build/pahole ./btfdiff /tmp/vmlinux4

Signed-off-by: Andrii Nakryiko <andriin@fb.com>
---
 btfdiff | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/btfdiff b/btfdiff
index 2b7ae33..6289a42 100755
--- a/btfdiff
+++ b/btfdiff
@@ -14,9 +14,10 @@ fi
 file=$1
 btf_output=$(mktemp /tmp/btfdiff.btf.XXXXXX)
 dwarf_output=$(mktemp /tmp/btfdiff.dwarf.XXXXXX)
+pahole_bin=${PAHOLE-"pahole"}
 
-pahole -F dwarf --flat_arrays --show_private_classes $file > $dwarf_output
-pahole -F btf $file > $btf_output
+${pahole_bin} -F dwarf --flat_arrays --show_private_classes $file > $dwarf_output
+${pahole_bin} -F btf $file > $btf_output
 
 diff -up $dwarf_output $btf_output
 
-- 
2.17.1

