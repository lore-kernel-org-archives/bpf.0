Return-Path: <SRS0=gyPw=BT=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8D41C433DF
	for <bpf@archiver.kernel.org>; Sun,  9 Aug 2020 15:03:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A67BB206B5
	for <bpf@archiver.kernel.org>; Sun,  9 Aug 2020 15:03:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596985414;
	bh=eQ2N8hFkse2G/MXOJxR5j7na+SnmuTYekoF0e2+A4LE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NuD4B2UxBeLGJro+QzTG3iadyqpNy0NAmDMFtXYpxVXIU2hMzuvuLUfSGHOJuL7ho
	 jACdwl5Xwc+rtL9bjo4Z2Htri9YrQw/kHsBfAvJKEIFW+OVXnrIyok96YYR1qjSsbL
	 prtRjXj7jFWqNgKu2utFdPw7BxBn4af+ZmIyuYNk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726350AbgHIPDb convert rfc822-to-8bit (ORCPT
        <rfc822;bpf@archiver.kernel.org>); Sun, 9 Aug 2020 11:03:31 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:37963 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726210AbgHIPDV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 9 Aug 2020 11:03:21 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-50-PwcY3Fc1P0Gcw_bK2_rG7A-1; Sun, 09 Aug 2020 11:03:13 -0400
X-MC-Unique: PwcY3Fc1P0Gcw_bK2_rG7A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C5E23107ACCA;
        Sun,  9 Aug 2020 15:03:11 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.192.79])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7C7495F1EA;
        Sun,  9 Aug 2020 15:03:07 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andriin@fb.com>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Martin KaFai Lau <kafai@fb.com>,
        David Miller <davem@redhat.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Wenbo Zhang <ethercflow@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Brendan Gregg <bgregg@netflix.com>,
        Florent Revest <revest@chromium.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: [RFC PATCH v11 bpf-next 01/14] tools resolve_btfids: Add size check to get_id function
Date:   Sun,  9 Aug 2020 17:02:49 +0200
Message-Id: <20200809150302.686149-2-jolsa@kernel.org>
In-Reply-To: <20200809150302.686149-1-jolsa@kernel.org>
References: <20200809150302.686149-1-jolsa@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jolsa@kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kernel.org
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

To make sure we don't crash on malformed symbols.

Acked-by: Andrii Nakryiko <andriin@fb.com>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/bpf/resolve_btfids/main.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/tools/bpf/resolve_btfids/main.c b/tools/bpf/resolve_btfids/main.c
index 52d883325a23..b83369887df6 100644
--- a/tools/bpf/resolve_btfids/main.c
+++ b/tools/bpf/resolve_btfids/main.c
@@ -199,9 +199,16 @@ static char *get_id(const char *prefix_end)
 	/*
 	 * __BTF_ID__func__vfs_truncate__0
 	 * prefix_end =  ^
+	 * pos        =    ^
 	 */
-	char *p, *id = strdup(prefix_end + sizeof("__") - 1);
+	int len = strlen(prefix_end);
+	int pos = sizeof("__") - 1;
+	char *p, *id;
 
+	if (pos >= len)
+		return NULL;
+
+	id = strdup(prefix_end + pos);
 	if (id) {
 		/*
 		 * __BTF_ID__func__vfs_truncate__0
-- 
2.25.4

