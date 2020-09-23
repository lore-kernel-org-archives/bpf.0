Return-Path: <SRS0=NOCw=DA=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2753CC2D0A8
	for <bpf@archiver.kernel.org>; Wed, 23 Sep 2020 18:57:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CADC9221EF
	for <bpf@archiver.kernel.org>; Wed, 23 Sep 2020 18:57:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1600887470;
	bh=G2delI6KsNPZ5BZPqhkerWB9kV0wE3sKfMgz21IdHsw=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=kq3N1BDBpwhbGXueP9zFoPvhC9ZDrSQbQ6YxTPy0QdnqcTWCT7/ymqYBxD/Wen8Oz
	 qQ8THnqBkR1Nr+Z8Y9yUs+bAtir1JYsSkrtQjIdI1Td4wcKsfST6zCp+qZQjKJ3NX4
	 khPizGbq7yN4t8BP16lOMt1QKGbgSSXzmYjptncg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726460AbgIWS5u convert rfc822-to-8bit (ORCPT
        <rfc822;bpf@archiver.kernel.org>); Wed, 23 Sep 2020 14:57:50 -0400
Received: from us-smtp-delivery-44.mimecast.com ([207.211.30.44]:47415 "EHLO
        us-smtp-delivery-44.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726572AbgIWS5u (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 23 Sep 2020 14:57:50 -0400
X-Greylist: delayed 17557 seconds by postgrey-1.27 at vger.kernel.org; Wed, 23 Sep 2020 14:57:49 EDT
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-81-m7qyszekNRuf3Cc-lH48mA-1; Wed, 23 Sep 2020 14:57:42 -0400
X-MC-Unique: m7qyszekNRuf3Cc-lH48mA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A7A63640AE;
        Wed, 23 Sep 2020 18:57:39 +0000 (UTC)
Received: from krava.redhat.com (ovpn-112-117.ams2.redhat.com [10.36.112.117])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DA3F33782;
        Wed, 23 Sep 2020 18:57:36 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andriin@fb.com>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Seth Forshee <seth.forshee@canonical.com>
Subject: [PATCHv3 bpf-next 1/2] bpf: Check CONFIG_BPF option for resolve_btfids
Date:   Wed, 23 Sep 2020 20:57:34 +0200
Message-Id: <20200923185735.3048198-1-jolsa@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jolsa@kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kernel.org
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=WINDOWS-1252
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Currently all the resolve_btfids 'users' are under CONFIG_BPF
code, so if we have CONFIG_BPF disabled, resolve_btfids will
fail, because there's no data to resolve.

Disabling resolve_btfids if there's CONFIG_BPF disabled,
so we won't fail such builds.

Suggested-by: Andrii Nakryiko <andriin@fb.com>
Acked-by: Andrii Nakryiko <andriin@fb.com>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
v3 changes:
  - updated subject, added ack

 Makefile                | 4 +++-
 scripts/link-vmlinux.sh | 6 +++---
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/Makefile b/Makefile
index c4470a4e131f..b05682eea2c0 100644
--- a/Makefile
+++ b/Makefile
@@ -1084,13 +1084,15 @@ ifdef CONFIG_STACK_VALIDATION
   endif
 endif
 
+ifdef CONFIG_BPF
 ifdef CONFIG_DEBUG_INFO_BTF
   ifeq ($(has_libelf),1)
     resolve_btfids_target := tools/bpf/resolve_btfids FORCE
   else
     ERROR_RESOLVE_BTFIDS := 1
   endif
-endif
+endif # CONFIG_DEBUG_INFO_BTF
+endif # CONFIG_BPF
 
 PHONY += prepare0
 
diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
index e6e2d9e5ff48..dbde59d343b1 100755
--- a/scripts/link-vmlinux.sh
+++ b/scripts/link-vmlinux.sh
@@ -341,9 +341,9 @@ fi
 vmlinux_link vmlinux "${kallsymso}" ${btf_vmlinux_bin_o}
 
 # fill in BTF IDs
-if [ -n "${CONFIG_DEBUG_INFO_BTF}" ]; then
-info BTFIDS vmlinux
-${RESOLVE_BTFIDS} vmlinux
+if [ -n "${CONFIG_DEBUG_INFO_BTF}" -a -n "${CONFIG_BPF}" ]; then
+	info BTFIDS vmlinux
+	${RESOLVE_BTFIDS} vmlinux
 fi
 
 if [ -n "${CONFIG_BUILDTIME_TABLE_SORT}" ]; then
-- 
2.26.2

