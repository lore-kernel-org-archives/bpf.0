Return-Path: <SRS0=z629=BW=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4338C433E0
	for <bpf@archiver.kernel.org>; Wed, 12 Aug 2020 12:31:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8EE5C2076C
	for <bpf@archiver.kernel.org>; Wed, 12 Aug 2020 12:31:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597235475;
	bh=h/Bin9cS9SMOGn/RBKy2acbeJ50oS4XDvyPx+SiLz9M=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=ojg24njLgOhyg71oNmHfW6OpadkTjpVUfyuGI1vg/OnyOxR+AZsKazTXH4m2gfxDZ
	 YFLOr/Pd+cNpSIiO32gReTj5FJ6feLde2bTl+NROCD0amqGvLEOaRcm2mvbJsKCkrf
	 0lF/yrhTMiXUZPXAiPB7G2s6Gfc4UGmXvpNs4PwU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727930AbgHLMbP convert rfc822-to-8bit (ORCPT
        <rfc822;bpf@archiver.kernel.org>); Wed, 12 Aug 2020 08:31:15 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:39876 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726698AbgHLMbO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 12 Aug 2020 08:31:14 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-71-kGLdQcsNOBislaL2_Ax9eA-1; Wed, 12 Aug 2020 08:31:09 -0400
X-MC-Unique: kGLdQcsNOBislaL2_Ax9eA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8A11C1005504;
        Wed, 12 Aug 2020 12:31:07 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.192.161])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DD0FF5D9D3;
        Wed, 12 Aug 2020 12:31:03 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>
Subject: [RFC PATCH bpf-next] bpf: Iterate through all PT_NOTE sections when looking for build id
Date:   Wed, 12 Aug 2020 14:31:02 +0200
Message-Id: <20200812123102.20032-1-jolsa@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
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

Currently when we look for build id within bpf_get_stackid helper
call, we check the first NOTE section and we fail if build id is
not there.

However on some system (Fedora) there can be multiple NOTE sections
in binaries and build id data is not always the first one, like:

  $ readelf -a /usr/bin/ls
  ...
  [ 2] .note.gnu.propert NOTE             0000000000000338  00000338
       0000000000000020  0000000000000000   A       0     0     8358
  [ 3] .note.gnu.build-i NOTE             0000000000000358  00000358
       0000000000000024  0000000000000000   A       0     0     437c
  [ 4] .note.ABI-tag     NOTE             000000000000037c  0000037c
  ...

So the stack_map_get_build_id function will fail on build id retrieval
and fallback to BPF_STACK_BUILD_ID_IP.

This patch is changing the stack_map_get_build_id code to iterate
through all the NOTE sections and try to get build id data from
each of them.

When tracing on sched_switch tracepoint that does bpf_get_stackid
helper call kernel build, I can see about 60% increase of successful
build id retrieval. The rest seems fails on -EFAULT.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 kernel/bpf/stackmap.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
index 4fd830a62be2..cfed0ac44d38 100644
--- a/kernel/bpf/stackmap.c
+++ b/kernel/bpf/stackmap.c
@@ -213,11 +213,13 @@ static int stack_map_get_build_id_32(void *page_addr,
 
 	phdr = (Elf32_Phdr *)(page_addr + sizeof(Elf32_Ehdr));
 
-	for (i = 0; i < ehdr->e_phnum; ++i)
-		if (phdr[i].p_type == PT_NOTE)
-			return stack_map_parse_build_id(page_addr, build_id,
-					page_addr + phdr[i].p_offset,
-					phdr[i].p_filesz);
+	for (i = 0; i < ehdr->e_phnum; ++i) {
+		if (phdr[i].p_type == PT_NOTE &&
+		    !stack_map_parse_build_id(page_addr, build_id,
+					      page_addr + phdr[i].p_offset,
+					      phdr[i].p_filesz))
+			return 0;
+	}
 	return -EINVAL;
 }
 
@@ -236,11 +238,13 @@ static int stack_map_get_build_id_64(void *page_addr,
 
 	phdr = (Elf64_Phdr *)(page_addr + sizeof(Elf64_Ehdr));
 
-	for (i = 0; i < ehdr->e_phnum; ++i)
-		if (phdr[i].p_type == PT_NOTE)
-			return stack_map_parse_build_id(page_addr, build_id,
-					page_addr + phdr[i].p_offset,
-					phdr[i].p_filesz);
+	for (i = 0; i < ehdr->e_phnum; ++i) {
+		if (phdr[i].p_type == PT_NOTE &&
+		    !stack_map_parse_build_id(page_addr, build_id,
+					      page_addr + phdr[i].p_offset,
+					      phdr[i].p_filesz))
+			return 0;
+	}
 	return -EINVAL;
 }
 
-- 
2.25.4

