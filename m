Return-Path: <SRS0=/2zk=34=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6223C35254
	for <bpf@archiver.kernel.org>; Sat,  8 Feb 2020 15:43:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 860122082E
	for <bpf@archiver.kernel.org>; Sat,  8 Feb 2020 15:43:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581176581;
	bh=Efwp8we5TDUw82MoH4D0u43DZsXefxidmnaSIcyLbJE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TBkgcHxE4Hkm1Mo9e5QIZ1KIW/OxJLwjMGfLgQ8OmVfLyPhIfp7kvSF1wcA0EmuSw
	 3xRRDldAYuUWbduN52O5Rl+wklfE3blepdb/2BaQf63Gt9Wocoxf52lC0Rtt5W2uAn
	 VK6fK0JjoqwYxZpGVMGEdMFT4l9IL/WSmFr1w1/s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727558AbgBHPnB convert rfc822-to-8bit (ORCPT
        <rfc822;bpf@archiver.kernel.org>); Sat, 8 Feb 2020 10:43:01 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:51943 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727546AbgBHPnB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 8 Feb 2020 10:43:01 -0500
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-350-45redfCwPh-WpmZuHuWcIg-1; Sat, 08 Feb 2020 10:42:57 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D037C8014D1;
        Sat,  8 Feb 2020 15:42:55 +0000 (UTC)
Received: from krava.redhat.com (ovpn-204-79.brq.redhat.com [10.40.204.79])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DD4225C28F;
        Sat,  8 Feb 2020 15:42:52 +0000 (UTC)
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
        Jesper Dangaard Brouer <hawk@kernel.org>
Subject: [PATCH 10/14] bpf: Re-initialize lnode in bpf_ksym_del
Date:   Sat,  8 Feb 2020 16:42:05 +0100
Message-Id: <20200208154209.1797988-11-jolsa@kernel.org>
In-Reply-To: <20200208154209.1797988-1-jolsa@kernel.org>
References: <20200208154209.1797988-1-jolsa@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: 45redfCwPh-WpmZuHuWcIg-1
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
index 73242fd07893..66b17bea286e 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -676,6 +676,13 @@ void bpf_ksym_del(struct bpf_ksym *ksym)
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

