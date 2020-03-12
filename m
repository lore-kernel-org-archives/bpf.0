Return-Path: <SRS0=5rgj=45=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0581C10DCE
	for <bpf@archiver.kernel.org>; Thu, 12 Mar 2020 19:57:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0B5720724
	for <bpf@archiver.kernel.org>; Thu, 12 Mar 2020 19:57:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584043052;
	bh=qKe0OWZWXGY78xKzR20X97tq0N+9+WtaSp9ZVfEY6iU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=D+NavGIG+TnMh0Nd1lSFZu5msHy1TdRINlKBBTBgcm9j3dIg5qzp3nG/w/vlxJ0op
	 HYNHVjjnEiG9oz6pIFXhglEWn6dorvofqj/Ro8QmcEjvGnk4I4gcQ36Y8GclC6LnY+
	 a8K1T79QbuE7IbI+gVyH5j916CBGtmOHOi6xop+g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727079AbgCLT5c convert rfc822-to-8bit (ORCPT
        <rfc822;bpf@archiver.kernel.org>); Thu, 12 Mar 2020 15:57:32 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:20140 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727077AbgCLT5c (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 12 Mar 2020 15:57:32 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-23-IxvI6rggMmeLaU-M9WQ-LA-1; Thu, 12 Mar 2020 15:57:27 -0400
X-MC-Unique: IxvI6rggMmeLaU-M9WQ-LA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 634F1801E6C;
        Thu, 12 Mar 2020 19:57:25 +0000 (UTC)
Received: from krava.redhat.com (ovpn-204-40.brq.redhat.com [10.40.204.40])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 76EEF5D9C5;
        Thu, 12 Mar 2020 19:57:21 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Song Liu <songliubraving@fb.com>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, Andrii Nakryiko <andriin@fb.com>,
        Yonghong Song <yhs@fb.com>, Martin KaFai Lau <kafai@fb.com>,
        Jakub Kicinski <kuba@kernel.org>,
        David Miller <davem@redhat.com>,
        =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn.topel@intel.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Song Liu <song@kernel.org>
Subject: [PATCH 14/15] perf tools: Set ksymbol dso as loaded on arrival
Date:   Thu, 12 Mar 2020 20:56:09 +0100
Message-Id: <20200312195610.346362-15-jolsa@kernel.org>
In-Reply-To: <20200312195610.346362-1-jolsa@kernel.org>
References: <20200312195610.346362-1-jolsa@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kernel.org
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

There's no special load action for ksymbol data on
map__load/dso__load action, where the kernel is getting
loaded. It only gets confused with kernel kallsyms/vmlinux
load for bpf object, which fails and could mess up with
the map.

Disabling any further load of the map for ksymbol related dso/map.

Acked-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Acked-by: Song Liu <songliubraving@fb.com>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/machine.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index fb5c2cd44d30..463ada5117f8 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -742,6 +742,7 @@ static int machine__process_ksymbol_register(struct machine *machine,
 		map->start = event->ksymbol.addr;
 		map->end = map->start + event->ksymbol.len;
 		maps__insert(&machine->kmaps, map);
+		dso__set_loaded(dso);
 	}
 
 	sym = symbol__new(map->map_ip(map, map->start),
-- 
2.24.1

