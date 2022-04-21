Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D364C433F5
	for <bpf@archiver.kernel.org>; Thu, 21 Apr 2022 00:39:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383508AbiDUAmM (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 20 Apr 2022 20:42:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383488AbiDUAmK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 20 Apr 2022 20:42:10 -0400
Received: from mail-40133.protonmail.ch (mail-40133.protonmail.ch [185.70.40.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7985524597
        for <bpf@vger.kernel.org>; Wed, 20 Apr 2022 17:39:18 -0700 (PDT)
Date:   Thu, 21 Apr 2022 00:39:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
        s=protonmail2; t=1650501556;
        bh=xsNYvkm5Qd125vyidZBd6wtSSydi8Pp6nb55LqTjBlw=;
        h=Date:To:From:Cc:Reply-To:Subject:Message-ID:In-Reply-To:
         References:Feedback-ID:From:To:Cc:Date:Subject:Reply-To:
         Feedback-ID:Message-ID;
        b=dS9u56yR1Ee0jS8CgcSI9UUgtL7gjpQnm5XkfmIF0d21RxGa0Cll2OUQWgSywkX5k
         Q79O0HkfV9P+Xx3Cxkdsy1V6vPK3pM/ZywTMuNu30pJmtazMqkUs6n1KpMeM0yL3Rq
         D0FOZ8iP/D8oZLZbfNKiStHbRgv/aJW7Ff3f2/lFCtWzs03RUOIalGbthXSa8EB/UI
         qYSUR825wYkwEdZdTvXvBFYH0wYNp21C5NVMNlHoMeivOIwgBpbAbBSMUsVF35WDnB
         SlW9koZjJhR7ebCZRbO4bFpsV/zNbY36y6KvEAj2bG8Xy7kGzT+iXXIrnG+l/po9hi
         NnUdJFa3rw+JQ==
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
From:   Alexander Lobakin <alobakin@pm.me>
Cc:     Alexander Lobakin <alobakin@pm.me>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Song Liu <songliubraving@fb.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        bpf@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Reply-To: Alexander Lobakin <alobakin@pm.me>
Subject: [PATCH v2 bpf 04/11] bpftool: fix fcntl.h include
Message-ID: <20220421003152.339542-5-alobakin@pm.me>
In-Reply-To: <20220421003152.339542-1-alobakin@pm.me>
References: <20220421003152.339542-1-alobakin@pm.me>
Feedback-ID: 22809121:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Fix the following (on some libc implementations):

  CC      tracelog.o
In file included from tracelog.c:12:
include/sys/fcntl.h:1:2: warning: #warning redirecting incorrect #include <=
sys/fcntl.h> to <fcntl.h> [-Wcpp]
    1 | #warning redirecting incorrect #include <sys/fcntl.h> to <fcntl.h>
      |  ^~~~~~~

<sys/fcntl.h> is anyway just a wrapper over <fcntl.h> (backcomp
stuff).

Fixes: 30da46b5dc3a ("tools: bpftool: add a command to dump the trace pipe"=
)
Acked-by: Song Liu <songliubraving@fb.com>
Signed-off-by: Alexander Lobakin <alobakin@pm.me>
---
 tools/bpf/bpftool/tracelog.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/bpf/bpftool/tracelog.c b/tools/bpf/bpftool/tracelog.c
index e80a5c79b38f..bf1f02212797 100644
--- a/tools/bpf/bpftool/tracelog.c
+++ b/tools/bpf/bpftool/tracelog.c
@@ -9,7 +9,7 @@
 #include <string.h>
 #include <unistd.h>
 #include <linux/magic.h>
-#include <sys/fcntl.h>
+#include <fcntl.h>
 #include <sys/vfs.h>

 #include "main.h"
--
2.36.0


