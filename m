Return-Path: <SRS0=COpY=6U=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC4BAC47256
	for <bpf@archiver.kernel.org>; Wed,  6 May 2020 13:30:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6A3A20746
	for <bpf@archiver.kernel.org>; Wed,  6 May 2020 13:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588771809;
	bh=JGeQVhP8lxix/7g/41r02swM3p2tuTReh1DTZVsHC5A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PJc4WVtqG7b9vBizomWzIKpQ9SPPCEnnD9L3ibxgE6FefXvsJxgsN7To+48zFphZ3
	 JYQ1UlwV5q1SDjiC21gI59bgDeKG+WnPv6Q74QeUD6b3tefWeIxa7AVPHoZtO+0Uu9
	 CGC2Bkeu8PQVHMmmLOJv+I5SFJZXdThmGLRqzNl8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728616AbgEFNaJ convert rfc822-to-8bit (ORCPT
        <rfc822;bpf@archiver.kernel.org>); Wed, 6 May 2020 09:30:09 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:47915 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728592AbgEFNaI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 6 May 2020 09:30:08 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-414-Z2uYOvmOPFir5JhdXVpm0Q-1; Wed, 06 May 2020 09:30:00 -0400
X-MC-Unique: Z2uYOvmOPFir5JhdXVpm0Q-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C2964460;
        Wed,  6 May 2020 13:29:58 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.192.32])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8271664430;
        Wed,  6 May 2020 13:29:55 +0000 (UTC)
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
Subject: [PATCH 2/9] bpf: Add d_path whitelist
Date:   Wed,  6 May 2020 15:29:39 +0200
Message-Id: <20200506132946.2164578-3-jolsa@kernel.org>
In-Reply-To: <20200506132946.2164578-1-jolsa@kernel.org>
References: <20200506132946.2164578-1-jolsa@kernel.org>
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

Adding whitelist for d_path helper under:
  kernel/bpf/helpers-whitelist/d_path

Currently it's just list of test functions, which will
be replaced by list promised by Brendan ;-)

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 kernel/bpf/helpers-whitelist/d_path | 8 ++++++++
 1 file changed, 8 insertions(+)
 create mode 100644 kernel/bpf/helpers-whitelist/d_path

diff --git a/kernel/bpf/helpers-whitelist/d_path b/kernel/bpf/helpers-whitelist/d_path
new file mode 100644
index 000000000000..e5adf2a9e1cb
--- /dev/null
+++ b/kernel/bpf/helpers-whitelist/d_path
@@ -0,0 +1,8 @@
+do_truncate
+vfs_fallocate
+finish_open
+vfs_open
+generic_file_open
+filp_close
+dentry_open
+vfs_getattr
-- 
2.25.4

