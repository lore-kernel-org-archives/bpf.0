Return-Path: <SRS0=ObQj=7J=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 004D0C433DF
	for <bpf@archiver.kernel.org>; Wed, 27 May 2020 08:42:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C73D62078C
	for <bpf@archiver.kernel.org>; Wed, 27 May 2020 08:42:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="grA6yVkH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388112AbgE0ImN (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 27 May 2020 04:42:13 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:54495 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387929AbgE0ImN (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 27 May 2020 04:42:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590568932;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=cRnUD5oK5sLVCVcFqnFWAetwGl+ORfvUve2vTyNoLZU=;
        b=grA6yVkHWnOlIukkJm6VOKhCTkTdubTkDHq0UNulyRtOuh/BNuEso3PDU2cXW2DvCqCo5W
        89ZZBoee/MseNB6seft3yCAoldJOQgagrKc22uUHPdusv3FMydEJwUogsoIQlYvHcYquXB
        3JzsaZ8h+QXDZ5iIFWbuXKtz7DUOrUU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-284--Y7aSUawNriOQ3BKB4PO7g-1; Wed, 27 May 2020 04:42:10 -0400
X-MC-Unique: -Y7aSUawNriOQ3BKB4PO7g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 195D8107ACF3;
        Wed, 27 May 2020 08:42:09 +0000 (UTC)
Received: from ebuild.redhat.com (ovpn-112-147.ams2.redhat.com [10.36.112.147])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 615E35D9E5;
        Wed, 27 May 2020 08:42:04 +0000 (UTC)
From:   Eelco Chaudron <echaudro@redhat.com>
To:     bpf@vger.kernel.org
Cc:     davem@davemloft.net, netdev@vger.kernel.org, ast@kernel.org,
        daniel@iogearbox.net, kafai@fb.com, songliubraving@fb.com,
        yhs@fb.com, andriin@fb.com, toke@redhat.com
Subject: [PATCH bpf-next] libbpf: fix perf_buffer__free() API for sparse allocs
Date:   Wed, 27 May 2020 10:42:00 +0200
Message-Id: <159056888305.330763.9684536967379110349.stgit@ebuild>
User-Agent: StGit/0.21
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

In case the cpu_bufs are sparsely allocated they are not
all free'ed. These changes will fix this.

Signed-off-by: Eelco Chaudron <echaudro@redhat.com>
---
 tools/lib/bpf/libbpf.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 5d60de6fd818..74d967619dcf 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -8137,9 +8137,12 @@ void perf_buffer__free(struct perf_buffer *pb)
 	if (!pb)
 		return;
 	if (pb->cpu_bufs) {
-		for (i = 0; i < pb->cpu_cnt && pb->cpu_bufs[i]; i++) {
+		for (i = 0; i < pb->cpu_cnt; i++) {
 			struct perf_cpu_buf *cpu_buf = pb->cpu_bufs[i];
 
+			if (!cpu_buf)
+				continue;
+
 			bpf_map_delete_elem(pb->map_fd, &cpu_buf->map_key);
 			perf_buffer__free_cpu_buf(pb, cpu_buf);
 		}

