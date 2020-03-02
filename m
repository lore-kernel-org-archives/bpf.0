Return-Path: <SRS0=Nxng=4T=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1556EC3F2D1
	for <bpf@archiver.kernel.org>; Mon,  2 Mar 2020 14:33:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0765214DB
	for <bpf@archiver.kernel.org>; Mon,  2 Mar 2020 14:33:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583159599;
	bh=qKe0OWZWXGY78xKzR20X97tq0N+9+WtaSp9ZVfEY6iU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WDEuvdAuAIWG7dt99QuOw0qLif07V3d5mX+RPsaATiYqd2ObJ4fkS5Rv4N4Nfl8nD
	 uWH7Xn03uTz5r/a0kIJLZ45pOEZXsE8v+/DnCUSBGhW9uI6emB1iO9Cm4thksLW97Q
	 ORdUr9AqvM7dhTxxwZPdEWLZNJMeq67aoMfhWOHg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727461AbgCBOdS convert rfc822-to-8bit (ORCPT
        <rfc822;bpf@archiver.kernel.org>); Mon, 2 Mar 2020 09:33:18 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:42310 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727053AbgCBOdS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 2 Mar 2020 09:33:18 -0500
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-460-kxuhJlW0Mu6crOfZUxKhkg-1; Mon, 02 Mar 2020 09:33:13 -0500
X-MC-Unique: kxuhJlW0Mu6crOfZUxKhkg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 73FAE1016E08;
        Mon,  2 Mar 2020 14:33:11 +0000 (UTC)
Received: from krava.redhat.com (ovpn-205-46.brq.redhat.com [10.40.205.46])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B7B7792D34;
        Mon,  2 Mar 2020 14:33:07 +0000 (UTC)
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
Date:   Mon,  2 Mar 2020 15:31:53 +0100
Message-Id: <20200302143154.258569-15-jolsa@kernel.org>
In-Reply-To: <20200302143154.258569-1-jolsa@kernel.org>
References: <20200302143154.258569-1-jolsa@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
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

