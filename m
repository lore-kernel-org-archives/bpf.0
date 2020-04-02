Return-Path: <SRS0=GciS=5S=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BB83C2BA17
	for <bpf@archiver.kernel.org>; Thu,  2 Apr 2020 15:34:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6190F206F6
	for <bpf@archiver.kernel.org>; Thu,  2 Apr 2020 15:34:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bacher09.org header.i=@bacher09.org header.b="HNrpNMyR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389294AbgDBPek (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 2 Apr 2020 11:34:40 -0400
Received: from pub.regulars.win ([89.163.144.234]:35722 "EHLO pub.regulars.win"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732754AbgDBPek (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 2 Apr 2020 11:34:40 -0400
From:   Slava Bacherikov <slava@bacher09.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bacher09.org;
        s=reg; t=1585841677;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bKUf/bnAONFPXaf6zoV9Cn+HIIIIoYflCpB+vjMGW18=;
        b=HNrpNMyRlD90A3TMwMZHALy+ta+0ynQ+1oVhRvwwGsCPTvsRtsjf4Ds9ztmBRuq3sAOWKK
        RG/VAG3HXogrMUbFpmqA/WQufGMoqj4Bg663lFurWifyDKMZQ7p3Vc/RXS0Jch/uOh7pJ3
        0zhAfPmaMV+DII6Y5Ggr0RlbXON+Y9A=
To:     keescook@chromium.org
Cc:     andriin@fb.com, bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        jannh@google.com, alexei.starovoitov@gmail.com,
        daniel@iogearbox.net, kernel-hardening@lists.openwall.com,
        liuyd.fnst@cn.fujitsu.com, kpsingh@google.com,
        Slava Bacherikov <slava@bacher09.org>
Subject: [PATCH v4 bpf] kbuild: fix dependencies for DEBUG_INFO_BTF
Date:   Thu,  2 Apr 2020 18:33:36 +0300
Message-Id: <20200402153335.38447-1-slava@bacher09.org>
In-Reply-To: <202004010849.CC7E9412@keescook>
References: <202004010849.CC7E9412@keescook>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam: Yes
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Currently turning on DEBUG_INFO_SPLIT when DEBUG_INFO_BTF is also
enabled will produce invalid btf file, since gen_btf function in
link-vmlinux.sh script doesn't handle *.dwo files.

Enabling DEBUG_INFO_REDUCED will also produce invalid btf file, and
using GCC_PLUGIN_RANDSTRUCT with BTF makes no sense.

Signed-off-by: Slava Bacherikov <slava@bacher09.org>
Reported-by: Jann Horn <jannh@google.com>
Reported-by: Liu Yiding <liuyd.fnst@cn.fujitsu.com>
Acked-by: KP Singh <kpsingh@google.com>
Acked-by: Andrii Nakryiko <andriin@fb.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Fixes: e83b9f55448a ("kbuild: add ability to generate BTF type info for vmlinux")
---
 lib/Kconfig.debug | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index f61d834e02fe..b94227be2d62 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -222,7 +222,9 @@ config DEBUG_INFO_DWARF4
 
 config DEBUG_INFO_BTF
 	bool "Generate BTF typeinfo"
-	depends on DEBUG_INFO
+	depends on DEBUG_INFO || COMPILE_TEST
+	depends on !DEBUG_INFO_SPLIT && !DEBUG_INFO_REDUCED
+	depends on !GCC_PLUGIN_RANDSTRUCT || COMPILE_TEST
 	help
 	  Generate deduplicated BTF type information from DWARF debug info.
 	  Turning this on expects presence of pahole tool, which will convert
