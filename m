Return-Path: <SRS0=V6te=D5=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3B00C388F2
	for <bpf@archiver.kernel.org>; Thu, 22 Oct 2020 08:22:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72BAC2065D
	for <bpf@archiver.kernel.org>; Thu, 22 Oct 2020 08:22:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1603354948;
	bh=grrujud9EHPu2ij7pJxYCd0l9+KzN+YRkFGQSDx/LVk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=R2BeQY5EDdVVshqrF9OMNAGwgL2Wnsg/slFP0evzF4otD52De2UWYEc1jagY8hKk+
	 DzYWgqSG4hCKZL68xRX+6gYrUUsWdeN/W9EKbXPd+DMgLwH6G4D/ayLjCDACzZs+oZ
	 muvJiIr5PTJLeEputlBw1zKz7weIARAzHieA9pyY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2895284AbgJVIW1 convert rfc822-to-8bit (ORCPT
        <rfc822;bpf@archiver.kernel.org>); Thu, 22 Oct 2020 04:22:27 -0400
Received: from us-smtp-delivery-44.mimecast.com ([205.139.111.44]:47619 "EHLO
        us-smtp-delivery-44.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2895275AbgJVIW1 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 22 Oct 2020 04:22:27 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-144-O96xkGQbMumUIQ-GyHKVXQ-1; Thu, 22 Oct 2020 04:22:20 -0400
X-MC-Unique: O96xkGQbMumUIQ-GyHKVXQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0AB57186DD31;
        Thu, 22 Oct 2020 08:22:18 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.195.55])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CE75C60BFA;
        Thu, 22 Oct 2020 08:22:14 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andriin@fb.com>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>, Daniel Xu <dxu@dxuuu.xyz>,
        Steven Rostedt <rostedt@goodmis.org>,
        Jesper Brouer <jbrouer@redhat.com>,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Viktor Malik <vmalik@redhat.com>
Subject: [RFC bpf-next 08/16] bpf: Use delayed link free in bpf_link_put
Date:   Thu, 22 Oct 2020 10:21:30 +0200
Message-Id: <20201022082138.2322434-9-jolsa@kernel.org>
In-Reply-To: <20201022082138.2322434-1-jolsa@kernel.org>
References: <20201022082138.2322434-1-jolsa@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jolsa@kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kernel.org
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=WINDOWS-1252
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Moving bpf_link_free call into delayed processing so we don't
need to wait for it when releasing the link.

For example bpf_tracing_link_release could take considerable
amount of time in bpf_trampoline_put function due to
synchronize_rcu_tasks call.

It speeds up bpftrace release time in following example:

Before:

 Performance counter stats for './src/bpftrace -ve kfunc:__x64_sys_s*
    { printf("test\n"); } i:ms:10 { printf("exit\n"); exit();}' (5 runs):

     3,290,457,628      cycles:k                                 ( +-  0.27% )
       933,581,973      cycles:u                                 ( +-  0.20% )

             50.25 +- 4.79 seconds time elapsed  ( +-  9.53% )

After:

 Performance counter stats for './src/bpftrace -ve kfunc:__x64_sys_s*
    { printf("test\n"); } i:ms:10 { printf("exit\n"); exit();}' (5 runs):

     2,535,458,767      cycles:k                                 ( +-  0.55% )
       940,046,382      cycles:u                                 ( +-  0.27% )

             33.60 +- 3.27 seconds time elapsed  ( +-  9.73% )

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 kernel/bpf/syscall.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 1110ecd7d1f3..61ef29f9177d 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -2346,12 +2346,8 @@ void bpf_link_put(struct bpf_link *link)
 	if (!atomic64_dec_and_test(&link->refcnt))
 		return;
 
-	if (in_atomic()) {
-		INIT_WORK(&link->work, bpf_link_put_deferred);
-		schedule_work(&link->work);
-	} else {
-		bpf_link_free(link);
-	}
+	INIT_WORK(&link->work, bpf_link_put_deferred);
+	schedule_work(&link->work);
 }
 
 static int bpf_link_release(struct inode *inode, struct file *filp)
-- 
2.26.2

