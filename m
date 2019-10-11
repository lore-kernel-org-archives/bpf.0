Return-Path: <SRS0=XZ9j=YE=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B333C10F14
	for <bpf@archiver.kernel.org>; Fri, 11 Oct 2019 00:29:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1657121929
	for <bpf@archiver.kernel.org>; Fri, 11 Oct 2019 00:29:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="U8B4vmxp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727682AbfJKA3c (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 10 Oct 2019 20:29:32 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:40313 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727602AbfJKA2b (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 10 Oct 2019 20:28:31 -0400
Received: by mail-lj1-f194.google.com with SMTP id 7so8024794ljw.7
        for <bpf@vger.kernel.org>; Thu, 10 Oct 2019 17:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZXAfjdX+WvsCZ4Putv4iaBG542bdy+GxK4sst7rF5S0=;
        b=U8B4vmxpgfJnzBiDJsbyyQvQCGTuwkGq440RprVd0W/jBwPaWulfeCmeD7ZzaIVdWh
         PBT2V1HNzKuxn9toI+ubYWKykuXxFguzRYTDd8aU43+pbuXMFAXCOFHgx8OTesJKeHiP
         u8fxXTOmnvuWqXYlx3MeAD2HpWswrvkvtw0QVFQ1TgcOPxhyNo1fHUaNodXg+eVN8lHz
         lyUqk+Nwewllbi0cPmn0R28no3ae8PrTbX1i54WHZxoYPkI0ILgtCmFu+vOGKLD3Eskz
         vjscmyBfhit3N498RUoFIS4ShuUVwWFD8rcLhkMAMURHLcw3iCv8D598o9x/C5n1OoqD
         dIFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZXAfjdX+WvsCZ4Putv4iaBG542bdy+GxK4sst7rF5S0=;
        b=JIY1g7124pf1Qe6fYriJx0ihXz48Pn5Ikl8IUdhqz0o7oySaQ19O9lXp6KG48udxN8
         iijAEDHmSelVShNv/Hv/p6lZSKF6lnPyRNus6XAr1ata3BKxPM/O9ydC34W+JmYv25j7
         eI1sdesrTkbvAg/7DxXMVj+OGTyJBX3h+pxhSmhcHcEZAR/EZhCQOpsRFQPOrE4eG0ka
         FDjNPHcaRlsHu8OkHd+Q73cQZ9OL/gP0tpqhDUCQUazfudujY6XbptoPNMWmFxOio/76
         6k7OHucv4VAcg5FAfbi5khXXl47KZbrtRROTGeG4nKVd7zmBRrtAwtzp75trRrRrJq03
         18vA==
X-Gm-Message-State: APjAAAXnFYR14BjKDGI3xliI5Pi0PxlFKdqnZFoOqOiqpdZ3kS+cWFk1
        AP8MxhSH6IwG1osZH6aGgbE4Mg==
X-Google-Smtp-Source: APXvYqwArHNK6yFOGfNBm56dLOLa/ki3fV+x83BMbZjybbtZFF/vhXt8lhYHjA0KBaEmMKXer8mkYA==
X-Received: by 2002:a2e:9890:: with SMTP id b16mr7075689ljj.153.1570753709112;
        Thu, 10 Oct 2019 17:28:29 -0700 (PDT)
Received: from localhost.localdomain (88-201-94-178.pool.ukrtel.net. [178.94.201.88])
        by smtp.gmail.com with ESMTPSA id 126sm2367010lfh.45.2019.10.10.17.28.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2019 17:28:28 -0700 (PDT)
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     ast@kernel.org, daniel@iogearbox.net, yhs@fb.com,
        davem@davemloft.net, jakub.kicinski@netronome.com, hawk@kernel.org,
        john.fastabend@gmail.com
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, clang-built-linux@googlegroups.com,
        ilias.apalodimas@linaro.org, sergei.shtylyov@cogentembedded.com,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: [PATCH v5 bpf-next 06/15] samples/bpf: drop unnecessarily inclusion for bpf_load
Date:   Fri, 11 Oct 2019 03:27:59 +0300
Message-Id: <20191011002808.28206-7-ivan.khoronzhuk@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191011002808.28206-1-ivan.khoronzhuk@linaro.org>
References: <20191011002808.28206-1-ivan.khoronzhuk@linaro.org>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Drop inclusion for bpf_load -I$(objtree)/usr/include as it is
included for all objects anyway, with above line:
KBUILD_HOSTCFLAGS += -I$(objtree)/usr/include

Acked-by: Andrii Nakryiko <andriin@fb.com>
Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
---
 samples/bpf/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
index 9b33e7395eac..bb2d976e824e 100644
--- a/samples/bpf/Makefile
+++ b/samples/bpf/Makefile
@@ -176,7 +176,7 @@ KBUILD_HOSTCFLAGS += -I$(srctree)/tools/testing/selftests/bpf/
 KBUILD_HOSTCFLAGS += -I$(srctree)/tools/lib/ -I$(srctree)/tools/include
 KBUILD_HOSTCFLAGS += -I$(srctree)/tools/perf
 
-HOSTCFLAGS_bpf_load.o += -I$(objtree)/usr/include -Wno-unused-variable
+HOSTCFLAGS_bpf_load.o += -Wno-unused-variable
 
 KBUILD_HOSTLDLIBS		+= $(LIBBPF) -lelf
 HOSTLDLIBS_tracex4		+= -lrt
-- 
2.17.1

