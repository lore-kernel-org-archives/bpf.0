Return-Path: <SRS0=ULdP=WI=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79A64C433FF
	for <bpf@archiver.kernel.org>; Mon, 12 Aug 2019 21:52:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E2592067D
	for <bpf@archiver.kernel.org>; Mon, 12 Aug 2019 21:52:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AwtjYLPB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727975AbfHLVwu (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 12 Aug 2019 17:52:50 -0400
Received: from mail-pl1-f202.google.com ([209.85.214.202]:43405 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727968AbfHLVwt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 12 Aug 2019 17:52:49 -0400
Received: by mail-pl1-f202.google.com with SMTP id t2so61832530plo.10
        for <bpf@vger.kernel.org>; Mon, 12 Aug 2019 14:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Yon+tib6K4agCcJ7udMNHZNwzVmJ2uncNyVHsVPdrbk=;
        b=AwtjYLPB1NH0++/16ytBu/qI2LJprggt3H70hAQSh1ZzM8gc9ZiVcgqdHhYHXjchQt
         px5nT4Pi96B1pKyG9a5L3txn6JOs4iAqr09VPH4Rc6QBU0eIn18RE2GlNcfxtWkO95vq
         Ly5ZNh4d0hDjxSSOfFs68hEEiC7GflyQcqAFn1iTWgvWYYb2TAk7xqAS59yUSWRrr9F3
         WtuDrsR+Q2muciUZZXeLwu0n7pCa1Q/LADXXO5mjKy9NHLwVSB9CVMCXlCnpigDonN01
         P+EORjsojsvbjUmK6aVl6sSTi/qOtZasZVk8CgCwV1MtPLNISfyl0xMhy6EYCrfo3xhU
         UoaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Yon+tib6K4agCcJ7udMNHZNwzVmJ2uncNyVHsVPdrbk=;
        b=hh1kEd6xu7UZ9BNCwsMi0DiVvCXIE+KW4EgKp8rRFVKqFCG7fWFqKHqxWlC9fyq+6X
         9GhuVoa1HoxcMzApSru1i2VVa5sURh5d5CzRe7bVLztYi5BXUfC2+qiSU7rg51/1oziV
         aFLn8YJV1pfdB8LtqNMZms2tA3t71gWUD8UBWA2yGTTdfmYlL07uaPUEItKUN2zr0l7p
         hGsoOSGq7cxfOT/tg/LIzPtCkhkH/ZrLs9uAscgozV0Qa4iWssxKhJjDVbOtMjX8RVkQ
         s80o1zRqIugEjgTPJCCyTFOTp8hF+CQTc4Q/VtY7nZh40PG3m3eaXFdUTuxDKQ7Q/x5g
         uibA==
X-Gm-Message-State: APjAAAW4A2W0aHqAArkwKmhnYx/pR0jBrTuYreKzB1nErch7Ol2KbtjT
        uEvJKhctRwlLg16zv/Kg8klCP1yGFkiBz6+G+BI=
X-Google-Smtp-Source: APXvYqzCWXrNnwSVGWU/yjnPa5MZIYrlXiagIBVTokW6Y6IHKWHzr3XziMRENeEKwhMqE6kFR9aoA+C9u955afZ4mGE=
X-Received: by 2002:a63:5550:: with SMTP id f16mr33164653pgm.426.1565646768288;
 Mon, 12 Aug 2019 14:52:48 -0700 (PDT)
Date:   Mon, 12 Aug 2019 14:50:46 -0700
In-Reply-To: <20190812215052.71840-1-ndesaulniers@google.com>
Message-Id: <20190812215052.71840-13-ndesaulniers@google.com>
Mime-Version: 1.0
References: <20190812215052.71840-1-ndesaulniers@google.com>
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
Subject: [PATCH 13/16] include/asm-generic: prefer __section from compiler_attributes.h
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     akpm@linux-foundation.org
Cc:     sedat.dilek@gmail.com, jpoimboe@redhat.com, yhs@fb.com,
        miguel.ojeda.sandonis@gmail.com,
        clang-built-linux@googlegroups.com,
        Nick Desaulniers <ndesaulniers@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Reported-by: Sedat Dilek <sedat.dilek@gmail.com>
Suggested-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
 include/asm-generic/error-injection.h | 2 +-
 include/asm-generic/kprobes.h         | 5 ++---
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/include/asm-generic/error-injection.h b/include/asm-generic/error-injection.h
index 95a159a4137f..a593a50b33e3 100644
--- a/include/asm-generic/error-injection.h
+++ b/include/asm-generic/error-injection.h
@@ -23,7 +23,7 @@ struct error_injection_entry {
  */
 #define ALLOW_ERROR_INJECTION(fname, _etype)				\
 static struct error_injection_entry __used				\
-	__attribute__((__section__("_error_injection_whitelist")))	\
+	__section(_error_injection_whitelist)				\
 	_eil_addr_##fname = {						\
 		.addr = (unsigned long)fname,				\
 		.etype = EI_ETYPE_##_etype,				\
diff --git a/include/asm-generic/kprobes.h b/include/asm-generic/kprobes.h
index 4a982089c95c..20d69719270f 100644
--- a/include/asm-generic/kprobes.h
+++ b/include/asm-generic/kprobes.h
@@ -9,12 +9,11 @@
  * by using this macro.
  */
 # define __NOKPROBE_SYMBOL(fname)				\
-static unsigned long __used					\
-	__attribute__((__section__("_kprobe_blacklist")))	\
+static unsigned long __used __section(_kprobe_blacklist)	\
 	_kbl_addr_##fname = (unsigned long)fname;
 # define NOKPROBE_SYMBOL(fname)	__NOKPROBE_SYMBOL(fname)
 /* Use this to forbid a kprobes attach on very low level functions */
-# define __kprobes	__attribute__((__section__(".kprobes.text")))
+# define __kprobes	__section(.kprobes.text)
 # define nokprobe_inline	__always_inline
 #else
 # define NOKPROBE_SYMBOL(fname)
-- 
2.23.0.rc1.153.gdeed80330f-goog

