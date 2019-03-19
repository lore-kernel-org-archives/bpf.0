Return-Path: <SRS0=wUMJ=RW=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E8C9C43381
	for <bpf@archiver.kernel.org>; Tue, 19 Mar 2019 02:33:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E891D20828
	for <bpf@archiver.kernel.org>; Tue, 19 Mar 2019 02:33:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qzyqfNVi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726915AbfCSCdm (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 18 Mar 2019 22:33:42 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45631 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727000AbfCSCdm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 18 Mar 2019 22:33:42 -0400
Received: by mail-pf1-f196.google.com with SMTP id v21so12599758pfm.12;
        Mon, 18 Mar 2019 19:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Duc2arZhee1lUOGKBxa9lSmU3G52PRaSjxVkALPDdt4=;
        b=qzyqfNViriNkKzC6YunqAf2RnJ9J8466SYO1+zSNO70fZnalFCX0q9fn7KdOevAWdC
         nREiPeprEZIyiX5ycO2ZppCC2ubKEYXe2BxWm5/jsQcKvIckrKhPtpMWv3WtAm1dpJaD
         ud5Yr5ReC9NcE1Dr28Sw7+0TF5CVoQ1Lbygi12flPuO7WsfMAG7Pye5QVFF2zADvrZjM
         l2JAOtxiOhisSh+ioKpyxsrO045TdFgDjdVVu5IrI2oOOvBJgegOoyL0lwdgYIfZ1XgW
         PXJyEzuF6qFcBToA1TrnMawvyZ6AhdrOCF5OD/e6yEU6QlhfVNhBGGjagjTx69X0jXbR
         Fvgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Duc2arZhee1lUOGKBxa9lSmU3G52PRaSjxVkALPDdt4=;
        b=PZlpzaugIcBn86D6qte0fMTXLBAUkaRKDY62dByAKxjq416SL0xi2nA8bPiBzIsxiF
         +yH5hWWioVo21TeqGGUDiKpX6l3tf88qzcAr7GAsLMb/VE0rp6mfrWjUfLVe0k4KK0rM
         u21bpv5FkdmDnl+YpzzVn4ON7geRGPSvcbcWFqNYHdJ3+0hNTK/VNkhnCArtVjdtM5ug
         cLDoLjNtyEXDY/ceO50TTbLtmFm/WObHBCseo0r3Ay9+Wtz3oYTSS0AlPSY3jSrEaF7b
         XdI7PfSYbWqPwxPGvBqsDfk6wMBoPR9U6z1tGhDz+1olOZC/hNBI4zOAjXKtK968Pp+r
         mq8g==
X-Gm-Message-State: APjAAAWQsRIHEKQB/VE9xezEkdtwVOELGxQq4Kay201z1f1ONyvxXx7S
        3VBxuZXP4Cn4ltzfc0Foc5w=
X-Google-Smtp-Source: APXvYqw86SC3qmcb7s5Z7YAHDefb3AuaiSBqhGiFXA7ZQxjKiMKlVscsRJRfq6Wecxt0xjenNjPmIQ==
X-Received: by 2002:a62:564d:: with SMTP id k74mr27687pfb.19.1552962821015;
        Mon, 18 Mar 2019 19:33:41 -0700 (PDT)
Received: from localhost.localdomain ([175.223.38.238])
        by smtp.gmail.com with ESMTPSA id j13sm15638969pfh.32.2019.03.18.19.33.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Mar 2019 19:33:40 -0700 (PDT)
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
X-Google-Original-From: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To:     Shuah Khan <shuah@kernel.org>, Alexei Starovoitov <ast@kernel.org>
Cc:     Stanislav Fomichev <sdf@google.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: [PATCH] bpf, tests: tweak endianness selection
Date:   Tue, 19 Mar 2019 11:33:31 +0900
Message-Id: <20190319023331.23207-1-sergey.senozhatsky@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Not all compilers have __builtin_bswap16() and __builtin_bswap32(),
thus not all compilers are able to compile the following code
(bpf_htons):

	(__builtin_constant_p(x) ? \
	 	___constant_swab16(x) : __builtin_bswap16(x))

That's why, for instance, bpf_htons() doesn't work on GCC < 4.8:

	error: implicit declaration of function '__builtin_bswap16'

We can use __builtin_bswap16() only if compiler has this built-in,
that is, only if __HAVE_BUILTIN_BSWAP16__ is defined. Standard UAPI
__swab16()/__swab32() take care of that, and, additionally, handle
__builtin_constant_p() cases as well (if compiler doesn't provide
builtin bswap with constants folding):

 #ifdef __HAVE_BUILTIN_BSWAP16__
 #define __swab16(x) (__u16)__builtin_bswap16((__u16)(x))
 #else
 #define __swab16(x)                             \
         (__builtin_constant_p((__u16)(x)) ?     \
         ___constant_swab16(x) :                 \
         __fswab16(x))
 #endif

So we can tweak selftests/bpf/bpf_endian.h and use UAPI
__swab16()/__swab32().

Signed-off-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
---
 tools/testing/selftests/bpf/bpf_endian.h | 37 +++++-------------------
 1 file changed, 8 insertions(+), 29 deletions(-)

diff --git a/tools/testing/selftests/bpf/bpf_endian.h b/tools/testing/selftests/bpf/bpf_endian.h
index b25595ea4a78..ba06222963d5 100644
--- a/tools/testing/selftests/bpf/bpf_endian.h
+++ b/tools/testing/selftests/bpf/bpf_endian.h
@@ -20,38 +20,17 @@
  * use different targets.
  */
 #if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
-# define __bpf_ntohs(x)			__builtin_bswap16(x)
-# define __bpf_htons(x)			__builtin_bswap16(x)
-# define __bpf_constant_ntohs(x)	___constant_swab16(x)
-# define __bpf_constant_htons(x)	___constant_swab16(x)
-# define __bpf_ntohl(x)			__builtin_bswap32(x)
-# define __bpf_htonl(x)			__builtin_bswap32(x)
-# define __bpf_constant_ntohl(x)	___constant_swab32(x)
-# define __bpf_constant_htonl(x)	___constant_swab32(x)
+# define bpf_ntohs(x)		__swab16(x)
+# define bpf_htons(x)		__swab16(x)
+# define bpf_ntohl(x)		__swab32(x)
+# define bpf_htonl(x)		__swab32(x)
 #elif __BYTE_ORDER__ == __ORDER_BIG_ENDIAN__
-# define __bpf_ntohs(x)			(x)
-# define __bpf_htons(x)			(x)
-# define __bpf_constant_ntohs(x)	(x)
-# define __bpf_constant_htons(x)	(x)
-# define __bpf_ntohl(x)			(x)
-# define __bpf_htonl(x)			(x)
-# define __bpf_constant_ntohl(x)	(x)
-# define __bpf_constant_htonl(x)	(x)
+# define bpf_ntohs(x)		(x)
+# define bpf_htons(x)		(x)
+# define bpf_ntohl(x)		(x)
+# define bpf_htonl(x)		(x)
 #else
 # error "Fix your compiler's __BYTE_ORDER__?!"
 #endif
 
-#define bpf_htons(x)				\
-	(__builtin_constant_p(x) ?		\
-	 __bpf_constant_htons(x) : __bpf_htons(x))
-#define bpf_ntohs(x)				\
-	(__builtin_constant_p(x) ?		\
-	 __bpf_constant_ntohs(x) : __bpf_ntohs(x))
-#define bpf_htonl(x)				\
-	(__builtin_constant_p(x) ?		\
-	 __bpf_constant_htonl(x) : __bpf_htonl(x))
-#define bpf_ntohl(x)				\
-	(__builtin_constant_p(x) ?		\
-	 __bpf_constant_ntohl(x) : __bpf_ntohl(x))
-
 #endif /* __BPF_ENDIAN__ */
-- 
2.21.0

