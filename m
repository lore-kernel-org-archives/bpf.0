Return-Path: <SRS0=V8Hm=SE=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D447C4360F
	for <bpf@archiver.kernel.org>; Tue,  2 Apr 2019 17:08:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 326452084C
	for <bpf@archiver.kernel.org>; Tue,  2 Apr 2019 17:08:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l4ubVTmf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730883AbfDBRIn (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 2 Apr 2019 13:08:43 -0400
Received: from mail-yw1-f74.google.com ([209.85.161.74]:35842 "EHLO
        mail-yw1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726168AbfDBRIn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 2 Apr 2019 13:08:43 -0400
Received: by mail-yw1-f74.google.com with SMTP id o66so10307202ywc.3
        for <bpf@vger.kernel.org>; Tue, 02 Apr 2019 10:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=p+7LH8ggaGy3rBYJYGFrLBo5V0lM9KRo0tlXTIQp0QA=;
        b=l4ubVTmf+PdlyUF8rV4nW2HIc8nD4h7eKIo2Ur1Ib8bRjZ2ReEnKZQbOEe+zu+jlYO
         3oAN0Ua+J1wd8MMnPmy9dWAueYK/3GpFkDiLJbz2mZmBwbAYRpYDiuHLaeF4WUINb7y6
         3eOHGdrPqyYfCJj7F5Wl2+IXaPytZspXifk7/MNYvR7eBWfciTFYomvjWVA+vh3c5pNr
         KbhKG7+KfvYGTwpG45xKzqmSU1sZAsPpS0YtEI6PuWcFrfkhURnPhyeYicPoH99/jJqk
         xbolqUB6CdVlv0QKM0yYa04w+GKW5sge08PZk/NPP8mKsZIAZF3ArxmvWcPHBy/Ltd8E
         FFQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=p+7LH8ggaGy3rBYJYGFrLBo5V0lM9KRo0tlXTIQp0QA=;
        b=Xomt59OH5VmTORBzIfMcoEcM0TtYMx7qWAS/ldgyVvBUGUtoDdLwsf5H2f0zXB1OWc
         oANMGdk85w1UIE9l/AGgs+Wdv8DG5jYYRUilVu9CZ61WSDgJIbEz3kBbXMOG4hV8vbej
         72wNQT4JipMe1mhfUbq6wj5ahc5uEbKUpWULr88D/yfeLMoTG1LhzeykaOC4zFGbwvGW
         QP702U6GyzlBW1VoH3ilzM52O1W7qQSSrtuSjSjkuLdq9elMOijs4o14crKJLpIGzRHR
         yfO1A2E1RpQy2VkpAO1XQqi6l63JkWq9KUxjtRZpf2/kDTdud6ZoKBDmI3/1jNbKuFUy
         fa1Q==
X-Gm-Message-State: APjAAAX+geu4Oe9lTOwJksqXRel2fo9Ufgh/JUDFHeDEgCEfxVn53dRA
        TusXNFPnblo5wjTNgig8HOrx7nQ=
X-Google-Smtp-Source: APXvYqzBiSIzpF48YJbyd6t5pgmKVmVwnoUmcFSzhFv7nhOyblonqlygtaYQi1ExslGzYLsJU+wzDGs=
X-Received: by 2002:a25:d995:: with SMTP id q143mr2054706ybg.88.1554224922777;
 Tue, 02 Apr 2019 10:08:42 -0700 (PDT)
Date:   Tue,  2 Apr 2019 10:08:33 -0700
In-Reply-To: <20190402170835.30732-1-sdf@google.com>
Message-Id: <20190402170835.30732-3-sdf@google.com>
Mime-Version: 1.0
References: <20190402170835.30732-1-sdf@google.com>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: [PATCH bpf-next 2/4] selftests: bpf: fix -Wformat-security warning
 for flow_dissector_load.c
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     davem@davemloft.net, ast@kernel.org, daniel@iogearbox.net,
        Stanislav Fomichev <sdf@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

flow_dissector_load.c:55:19: warning: format string is not a string literal (potentially insecure)
      [-Wformat-security]
                error(1, errno, command);
                                ^~~~~~~
flow_dissector_load.c:55:19: note: treat the string as an argument to avoid this
                error(1, errno, command);
                                ^
                                "%s",
1 warning generated.

Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 tools/testing/selftests/bpf/flow_dissector_load.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/flow_dissector_load.c b/tools/testing/selftests/bpf/flow_dissector_load.c
index 77cafa66d048..7136ab9ffa73 100644
--- a/tools/testing/selftests/bpf/flow_dissector_load.c
+++ b/tools/testing/selftests/bpf/flow_dissector_load.c
@@ -52,7 +52,7 @@ static void detach_program(void)
 	sprintf(command, "rm -r %s", cfg_pin_path);
 	ret = system(command);
 	if (ret)
-		error(1, errno, command);
+		error(1, errno, "%s", command);
 }
 
 static void parse_opts(int argc, char **argv)
-- 
2.21.0.392.gf8f6787159e-goog

