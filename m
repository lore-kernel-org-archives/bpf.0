Return-Path: <SRS0=7UPC=4O=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EEECC4BA12
	for <bpf@archiver.kernel.org>; Wed, 26 Feb 2020 13:04:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 310EB24685
	for <bpf@archiver.kernel.org>; Wed, 26 Feb 2020 13:04:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582722273;
	bh=+4bD8HmzjZJimDj1BvNUweQ61AZLIuLodFHN8toqNTQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BmJKSOKtfcgR9bLPIy/A4AFOOQ8HFh1jnWgj64jbrlpoCzouEiJwFeuSt81fsiLG+
	 1cp+euWlVkqTf1+0nrV7QARbMqju2c+VPMRj78rjyyodoIuf0gGeLk+MgXrqPTGh9Y
	 nEGdHxI6WjgjKFsGuG8MQMT6drdNljvPAZzfplEM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727221AbgBZNEc convert rfc822-to-8bit (ORCPT
        <rfc822;bpf@archiver.kernel.org>); Wed, 26 Feb 2020 08:04:32 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:51257 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727210AbgBZNEc (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 26 Feb 2020 08:04:32 -0500
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-215-0_xVLilXPIKoscetdlR72A-1; Wed, 26 Feb 2020 08:04:27 -0500
X-MC-Unique: 0_xVLilXPIKoscetdlR72A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6C700800D5A;
        Wed, 26 Feb 2020 13:04:25 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.43.17.9])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 932F619C7F;
        Wed, 26 Feb 2020 13:04:22 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        Andrii Nakryiko <andriin@fb.com>, Yonghong Song <yhs@fb.com>,
        Song Liu <songliubraving@fb.com>,
        Martin KaFai Lau <kafai@fb.com>,
        Jakub Kicinski <kuba@kernel.org>,
        David Miller <davem@redhat.com>,
        =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn.topel@intel.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 10/18] bpf: Re-initialize lnode in bpf_ksym_del
Date:   Wed, 26 Feb 2020 14:03:37 +0100
Message-Id: <20200226130345.209469-11-jolsa@kernel.org>
In-Reply-To: <20200226130345.209469-1-jolsa@kernel.org>
References: <20200226130345.209469-1-jolsa@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kernel.org
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

When bpf_prog is removed from kallsyms it's on the way
out to be removed, so we don't care about lnode state.

However the bpf_ksym_del will be used also by bpf_trampoline
and bpf_dispatcher objects, which stay allocated even when
they are not in kallsyms list, hence the lnode re-init.

The list_del_rcu commentary states that we need to call
synchronize_rcu, before we can change/re-init the list_head
pointers.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 kernel/bpf/core.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index c95424fc53de..1af2109b45c7 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -672,6 +672,13 @@ void bpf_ksym_del(struct bpf_ksym *ksym)
 	spin_lock_bh(&bpf_lock);
 	__bpf_ksym_del(ksym);
 	spin_unlock_bh(&bpf_lock);
+
+	/*
+	 * As explained in list_del_rcu, We must call synchronize_rcu
+	 * before changing list_head pointers.
+	 */
+	synchronize_rcu();
+	INIT_LIST_HEAD_RCU(&ksym->lnode);
 }
 
 static bool bpf_prog_kallsyms_candidate(const struct bpf_prog *fp)
-- 
2.24.1

