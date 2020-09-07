Return-Path: <SRS0=5Irp=CQ=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D335DC43461
	for <bpf@archiver.kernel.org>; Mon,  7 Sep 2020 17:56:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8BD2B2080A
	for <bpf@archiver.kernel.org>; Mon,  7 Sep 2020 17:56:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599501376;
	bh=few+SPI/Oy8S+VrQdUBXsEisTbEhd4ob+xpR7tk7F78=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=HrGF0j6jKwG4b6xwS681MhIWQbZSukZlQ2ps1evm9PpKyKUckz4oYES2co3EcNrlc
	 DA/55v0Po05J73Bg3rxSRnBRMf8fxIUPtS6ZDkpYEEmPeedjJKsk1wWbULpljF9S2V
	 3jBemTJNzTVYfS99tc2XJYLBiTtO6y81oMGXgqFo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728925AbgIGR4P convert rfc822-to-8bit (ORCPT
        <rfc822;bpf@archiver.kernel.org>); Mon, 7 Sep 2020 13:56:15 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:52094 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728809AbgIGLVb (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 7 Sep 2020 07:21:31 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-164-jBWXxxlPOsqCyMA0FODBgg-1; Mon, 07 Sep 2020 07:02:47 -0400
X-MC-Unique: jBWXxxlPOsqCyMA0FODBgg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9EA9D18B9EC1;
        Mon,  7 Sep 2020 11:02:45 +0000 (UTC)
Received: from krava.redhat.com (ovpn-112-180.ams2.redhat.com [10.36.112.180])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1F4661A3D7;
        Mon,  7 Sep 2020 11:02:38 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Jesper Dangaard Brouer <brouer@redhat.com>
Subject: [PATCH] perf tools: Do not use deprecated bpf_program__title
Date:   Mon,  7 Sep 2020 13:02:37 +0200
Message-Id: <20200907110237.1329532-1-jolsa@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jolsa@kernel.org
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: kernel.org
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The bpf_program__title function got deprecated in libbpf,
use the suggested alternative.

Fixes: 521095842027 ("libbpf: Deprecate notion of BPF program "title" in favor of "section name"")
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/bpf-loader.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/bpf-loader.c b/tools/perf/util/bpf-loader.c
index 2feb751516ab..73de3973c8ec 100644
--- a/tools/perf/util/bpf-loader.c
+++ b/tools/perf/util/bpf-loader.c
@@ -328,7 +328,7 @@ config_bpf_program(struct bpf_program *prog)
 	probe_conf.no_inlines = false;
 	probe_conf.force_add = false;
 
-	config_str = bpf_program__title(prog, false);
+	config_str = bpf_program__section_name(prog);
 	if (IS_ERR(config_str)) {
 		pr_debug("bpf: unable to get title for program\n");
 		return PTR_ERR(config_str);
@@ -454,7 +454,7 @@ preproc_gen_prologue(struct bpf_program *prog, int n,
 	if (err) {
 		const char *title;
 
-		title = bpf_program__title(prog, false);
+		title = bpf_program__section_name(prog);
 		if (!title)
 			title = "[unknown]";
 
-- 
2.26.2

