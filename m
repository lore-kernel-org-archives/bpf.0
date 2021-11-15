Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECCBCC433F5
	for <bpf@archiver.kernel.org>; Mon, 15 Nov 2021 16:12:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0F8661BD3
	for <bpf@archiver.kernel.org>; Mon, 15 Nov 2021 16:12:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231428AbhKOQPA (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 15 Nov 2021 11:15:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:28098 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232262AbhKOQOo (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 15 Nov 2021 11:14:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636992707;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tNyDHo3AD5AOiLxANvvb4nIQRqpQcwvtj6KaVinsXbg=;
        b=e8yuCJM+gEAtjlRNejkHQWtN1MR4UgmnK6Gu4eDi+Fv5lwgMmMMOwRMjsN7+bE8qh9R1l9
        HpDBfqB99WFE+vSBcsNrwiSDJUZ6p/7LNGCJx9Te7p56S9rnyqehjcyOIaMoz+8zlANYHM
        yRxpuV/WcQtVz+V9wMDIe3OvRJPwqQ8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-332-URmi0DeqPia8L-ie5PzMwA-1; Mon, 15 Nov 2021 11:11:43 -0500
X-MC-Unique: URmi0DeqPia8L-ie5PzMwA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D4841802C96;
        Mon, 15 Nov 2021 16:11:41 +0000 (UTC)
Received: from gerbillo.fritz.box (unknown [10.39.194.235])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7A7EE10016F5;
        Mon, 15 Nov 2021 16:11:40 +0000 (UTC)
From:   Paolo Abeni <pabeni@redhat.com>
To:     netdev@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Subject: [RFC PATCH 1/2] bpf: do not WARN in bpf_warn_invalid_xdp_action()
Date:   Mon, 15 Nov 2021 17:10:43 +0100
Message-Id: <188c69a78ff2b1488ac16a1928311ea3ab39abed.1636987322.git.pabeni@redhat.com>
In-Reply-To: <cover.1636987322.git.pabeni@redhat.com>
References: <cover.1636987322.git.pabeni@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The WARN_ONCE() in bpf_warn_invalid_xdp_action() can be triggered by
any bugged program, and even attaching a correct program to a NIC
not supporting the given action.

The resulting splat, beyond polluting the logs, fouls automated tools:
e.g. a syzkaller reproducers using an XDP program returning an
unsupported action will never pass validation.

Replace the WARN_ONCE with a less intrusive pr_warn_once().

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/core/filter.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index e471c9b09670..3ba584bb23f8 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -8183,9 +8183,9 @@ void bpf_warn_invalid_xdp_action(u32 act)
 {
 	const u32 act_max = XDP_REDIRECT;
 
-	WARN_ONCE(1, "%s XDP return value %u, expect packet loss!\n",
-		  act > act_max ? "Illegal" : "Driver unsupported",
-		  act);
+	pr_warn_once("%s XDP return value %u, expect packet loss!\n",
+		     act > act_max ? "Illegal" : "Driver unsupported",
+		     act);
 }
 EXPORT_SYMBOL_GPL(bpf_warn_invalid_xdp_action);
 
-- 
2.33.1

