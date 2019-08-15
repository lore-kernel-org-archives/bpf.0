Return-Path: <SRS0=AlFI=WL=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CF0BC3A59B
	for <bpf@archiver.kernel.org>; Thu, 15 Aug 2019 14:32:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32ED7206C1
	for <bpf@archiver.kernel.org>; Thu, 15 Aug 2019 14:32:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="14Lz+QG3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732950AbfHOOcg (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 15 Aug 2019 10:32:36 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36848 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731220AbfHOOcf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 15 Aug 2019 10:32:35 -0400
Received: by mail-wr1-f67.google.com with SMTP id r3so2421980wrt.3
        for <bpf@vger.kernel.org>; Thu, 15 Aug 2019 07:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+M5QZmIoEDjFoyJBHLElsXh3utBUpsKEGE+Jc7c8+z4=;
        b=14Lz+QG3aKErrirXSdHf9sfwowcVMZ+QzmhdAcvspB14S7fqQ2tdA3bUAt/ynFNDND
         GvN9sUKqN6NflQl+U8npeZDjxRvxL9Rl6sDjF6kH/RFDkFVyAZv4IWiNHQhPAtRJS1+Y
         waaNF9x9XQ9vKNq/LPk1HzbNmwVETp+QOEmcwbmwnib5Ev6LI3t4bibUFBQDGpwb/7Hq
         QEP66Fg9yFHZsxw0HrxnGieMcD8RO2xZGVOPgm7rHupGY2EXfF34j3pf3kxXyjd1rV0P
         PWbCh4pFLitqbm/oi1HYV8aoFF8XxYjS0LPntrVkxl/UIYVaJYoiTjry5040rKbpic4w
         9ogQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+M5QZmIoEDjFoyJBHLElsXh3utBUpsKEGE+Jc7c8+z4=;
        b=cu/0gSgaVpNg23eLovsujSg/uPV5jJagew6bbGNVzfiZRp7/Lf4LY4FF7webuMrNBr
         M2ojC/PLSfB9zuPnCLxI7r2hUbCNcn/2Z+zz+nxhf8xzOMNs2JuZ5ZjivCRT8zZ2ENHd
         NGCoblmxOAEdJeyxqrMhY6JD/O51LJ0LW8YZndAJ7M6AoTL4hmEQ9zavRT7CJvcxMDm9
         1GGYgXi/T3TFuGC604Rua5NXQLZbh0xaXoxRRaXCIjQZjl2ZV9GDU49SMJPgZCy3Px1I
         f4OneFxau73tyFMEoyThy8I7Z83zMWl3FqQbpjCHbDtX606aqCWCmWyWmpb1e5gE1P6Y
         jMdg==
X-Gm-Message-State: APjAAAUN9PMjsBWp3m9RVUJomzx9QWlaN7hgMp+PWSEqkjTUVdA5IU/H
        Wr/0naRye40oDi6MIOJSvCEyGA==
X-Google-Smtp-Source: APXvYqxEiYETrrbQa3ic3kkobppYtfhZlBW+hw4D3+wsUpJUdI+0fj2L1q9agB3rNRCTY7aibCOjtQ==
X-Received: by 2002:adf:f5c5:: with SMTP id k5mr6175339wrp.42.1565879553547;
        Thu, 15 Aug 2019 07:32:33 -0700 (PDT)
Received: from cbtest32.netronome.com ([217.38.71.146])
        by smtp.gmail.com with ESMTPSA id a19sm8857463wra.2.2019.08.15.07.32.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2019 07:32:32 -0700 (PDT)
From:   Quentin Monnet <quentin.monnet@netronome.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        oss-drivers@netronome.com,
        Quentin Monnet <quentin.monnet@netronome.com>
Subject: [PATCH bpf 3/6] tools: bpftool: fix argument for p_err() in BTF do_dump()
Date:   Thu, 15 Aug 2019 15:32:17 +0100
Message-Id: <20190815143220.4199-4-quentin.monnet@netronome.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190815143220.4199-1-quentin.monnet@netronome.com>
References: <20190815143220.4199-1-quentin.monnet@netronome.com>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The last argument passed to one call to the p_err() function is not
correct, it should be "*argv" instead of "**argv". This may lead to a
segmentation fault error if BTF id cannot be parsed correctly. Let's fix
this.

Fixes: c93cc69004dt ("bpftool: add ability to dump BTF types")
Signed-off-by: Quentin Monnet <quentin.monnet@netronome.com>
Reviewed-by: Jakub Kicinski <jakub.kicinski@netronome.com>
---
 tools/bpf/bpftool/btf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/bpf/bpftool/btf.c b/tools/bpf/bpftool/btf.c
index 1b8ec91899e6..8805637f1a7e 100644
--- a/tools/bpf/bpftool/btf.c
+++ b/tools/bpf/bpftool/btf.c
@@ -449,7 +449,7 @@ static int do_dump(int argc, char **argv)
 
 		btf_id = strtoul(*argv, &endptr, 0);
 		if (*endptr) {
-			p_err("can't parse %s as ID", **argv);
+			p_err("can't parse %s as ID", *argv);
 			return -1;
 		}
 		NEXT_ARG();
-- 
2.17.1

