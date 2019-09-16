Return-Path: <SRS0=t4jm=XL=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7020CC4CECD
	for <bpf@archiver.kernel.org>; Mon, 16 Sep 2019 10:55:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45E912171F
	for <bpf@archiver.kernel.org>; Mon, 16 Sep 2019 10:55:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="renlPhv6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730913AbfIPKzs (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 16 Sep 2019 06:55:48 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:35685 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732486AbfIPKyu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 16 Sep 2019 06:54:50 -0400
Received: by mail-lj1-f196.google.com with SMTP id f1so1762940ljc.2
        for <bpf@vger.kernel.org>; Mon, 16 Sep 2019 03:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ICv/vY4XAwe136r6/MDdnRXmmJJ1JFeohZKBWO948JI=;
        b=renlPhv6Vx5CNHYksA5WzO20FVIYXEGpjJn5/YGtCgnC0BCwjUvLBlAbeS2QWSwpah
         jcbI6KeCWf9WpTaXKqzoATiWjCG2prOysrOtXjGAuLCXoTntdh4Qt/9m80BBL8QN4pzD
         XadY611DPWHua3DwZGOlRJTNUpZN6TrPk0Qwv6sDmublMKNGDX/eMekRKEEMHAPLynHN
         5myrlSfFkSMecyixXnfJtcPFSkWkbeUOkkzmZn0e084lNX5MEANYr1m0mJB052RjofTA
         cKvGdlGjvGxXUcAUQef27FEQY1g72gk+N/QCID6XsEJxukpv5MfPHG1nANwRFzRONI4R
         ysPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ICv/vY4XAwe136r6/MDdnRXmmJJ1JFeohZKBWO948JI=;
        b=dlghcmYKXJmJasOE20No3JB3xfUe28KMlTI11yGYRvJEV4AY1RTE//Jxln5I24rX98
         ccDa68kLEYV7A8ypXtzL7iSzqL7aIQMc8qx34mteo3Uf6dCxtrDIXGb9aEKLjg2D8Da6
         Xw6NgAp43f4xbISELXhUp6MKILYLtG+3QNktGXU8GQQ7GfsOHBn0umCa06iUjnyPacMi
         Ef3miQpeWHhNQapjlVAWkywqrM8NHpn53ykMq9ZJ3EEypaUuCeECvjdejfxw8b0xx2YC
         Un9sS4ANokrjVYgjP9uL7qTeHJ798HVU3TlPXmAsMNuPz03rKv27eRcB534lrjcZqyno
         m4AQ==
X-Gm-Message-State: APjAAAUpnuNucP45XwU19b93FLr36WGYlHQHHfi2aihtKai+tqHLypj3
        U78jc7PlxyF9ng13HFPafua6+A==
X-Google-Smtp-Source: APXvYqxSBkjyrfAdAo3XLVu9mwgNU46b8BtP9TI1G+SDVPq/GRexV8qvD6bjRrTR9lMP98abCOCLiQ==
X-Received: by 2002:a2e:9881:: with SMTP id b1mr19271028ljj.134.1568631288103;
        Mon, 16 Sep 2019 03:54:48 -0700 (PDT)
Received: from localhost.localdomain (168-200-94-178.pool.ukrtel.net. [178.94.200.168])
        by smtp.gmail.com with ESMTPSA id v1sm8987737lfq.89.2019.09.16.03.54.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2019 03:54:47 -0700 (PDT)
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     ast@kernel.org, daniel@iogearbox.net, yhs@fb.com,
        davem@davemloft.net, jakub.kicinski@netronome.com, hawk@kernel.org,
        john.fastabend@gmail.com
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, clang-built-linux@googlegroups.com,
        sergei.shtylyov@cogentembedded.com,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: [PATCH v3 bpf-next 06/14] samples: bpf: makefile: drop unnecessarily inclusion for bpf_load
Date:   Mon, 16 Sep 2019 13:54:25 +0300
Message-Id: <20190916105433.11404-7-ivan.khoronzhuk@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190916105433.11404-1-ivan.khoronzhuk@linaro.org>
References: <20190916105433.11404-1-ivan.khoronzhuk@linaro.org>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Drop inclusion for bpf_load -I$(objtree)/usr/include as it is
included for all objects anyway, with above line:
KBUILD_HOSTCFLAGS += -I$(objtree)/usr/include

Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
---
 samples/bpf/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
index d3c8db3df560..9d923546e087 100644
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

