Return-Path: <SRS0=US5c=RX=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97C79C10F05
	for <bpf@archiver.kernel.org>; Wed, 20 Mar 2019 12:54:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67BAF2146E
	for <bpf@archiver.kernel.org>; Wed, 20 Mar 2019 12:54:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qEzcFVEs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727307AbfCTMyM (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 20 Mar 2019 08:54:12 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:35648 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727663AbfCTMxv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 20 Mar 2019 08:53:51 -0400
Received: by mail-pf1-f196.google.com with SMTP id t21so1125849pfe.2;
        Wed, 20 Mar 2019 05:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NPe7yqjMKa6Oo+8z7flxzvxuW217bRbP0r4e28VijkY=;
        b=qEzcFVEsU4JuWCQ0G+66AamOCpEIjynb2TYKRRQWTU96YscncfRreao45B8Ojy+PlT
         eYAMs8vgJQNkJ7QQ4H/OsDSsDeyyWoVNxRq8OLp6wiVJRKYugvUN/0LM445qhN3ZvBM+
         i1HARaBgrSnBiCRGQn460FLLbGsnehkKC2x7FsLtaLUyWT4VKnptVtMjIRP0QrqrTPu8
         98QTdteoC947DrJcr/6Xnq/pYy6IvbltOKmVsEAhnRhojhE/4xwL6j8Et5iG+h3dUm2F
         ikcbr/09JrrWGLXf/5zsYbr3lReFfRhTwPHrTFYljhmV2gxyUw8fPV0NYtvtCIn88hcS
         xrEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NPe7yqjMKa6Oo+8z7flxzvxuW217bRbP0r4e28VijkY=;
        b=UlmaXlJARY+Pxs32+WtxCEqUAlFNDtNNgTW8Did1+gcOR/foIJcoNMZTejpgdISFri
         zKfFZ5mJpRfsndRD1eSNGi8fS26OAVLw5TRRfskzxdHWGVR5a66Z+Ps7zMZNceE3Vo+A
         bU4kQu94LN37OWQgmHhPJVbn6s1YenAcPPgFjR2E2qaT2Vvsh5cBvzxIkLjVZrLqK6OZ
         ZD+1/Max6To7uuRbLda1hC33WpW4FIchdqWK6vD//g9Y5QLhuf7kht+GiYh+LvbO+UNc
         CxOc9l1deHxZ7otF+wFYJLyuTOo37SzOTtYvmV2YgrxtE70syXkkRoS5na3VEHr4HrV+
         iMZQ==
X-Gm-Message-State: APjAAAUdtb1gdUM5/NkNBG0FLZPThYbofvSUDas7GjaFMOZtcFNpvla0
        LhTWIZRxWeIWIiy9MwVxuVg=
X-Google-Smtp-Source: APXvYqyuTzN8bCsj7O5P1QCul5kCCFwcFAi5tsusLmTtB3usd7N8YEpJSIpOWUADQ1l6LqlvsHkcNg==
X-Received: by 2002:a17:902:20e3:: with SMTP id v32mr7818234plg.213.1553086430488;
        Wed, 20 Mar 2019 05:53:50 -0700 (PDT)
Received: from localhost.localdomain ([121.137.63.184])
        by smtp.gmail.com with ESMTPSA id r8sm2707467pfd.8.2019.03.20.05.53.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Mar 2019 05:53:49 -0700 (PDT)
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To:     Shuah Khan <shuah@kernel.org>, Alexei Starovoitov <ast@kernel.org>
Cc:     Stanislav Fomichev <sdf@google.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: [PATCHv2 bpf-next 1/3] bpf, tests: tweak endianness selection
Date:   Wed, 20 Mar 2019 21:53:33 +0900
Message-Id: <20190320125335.19621-1-sergey.senozhatsky@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Not all compilers have __builtin_bswap16() and __builtin_bswap32(),
thus not all compilers are able to compile the following code:

        (__builtin_constant_p(x) ? \
                ___constant_swab16(x) : __builtin_bswap16(x))

That's the reason why bpf_ntohl() doesn't work on GCC < 4.8, for
instance:

        error: implicit declaration of function '__builtin_bswap16'

We can use __builtin_bswap16() only if compiler has this built-in,
that is, only if __HAVE_BUILTIN_BSWAP16__ is defined. Standard UAPI
__swab16()/__swab32() take care of that, and, additionally, handle
__builtin_constant_p() cases as well:

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

v2: fixed build error, reshuffled patches (Stanislav Fomichev)

 tools/testing/selftests/bpf/bpf_endian.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/bpf_endian.h b/tools/testing/selftests/bpf/bpf_endian.h
index b25595ea4a78..1ed268b2002b 100644
--- a/tools/testing/selftests/bpf/bpf_endian.h
+++ b/tools/testing/selftests/bpf/bpf_endian.h
@@ -20,12 +20,12 @@
  * use different targets.
  */
 #if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
-# define __bpf_ntohs(x)			__builtin_bswap16(x)
-# define __bpf_htons(x)			__builtin_bswap16(x)
+# define __bpf_ntohs(x)			__swab16(x)
+# define __bpf_htons(x)			__swab16(x)
 # define __bpf_constant_ntohs(x)	___constant_swab16(x)
 # define __bpf_constant_htons(x)	___constant_swab16(x)
-# define __bpf_ntohl(x)			__builtin_bswap32(x)
-# define __bpf_htonl(x)			__builtin_bswap32(x)
+# define __bpf_ntohl(x)			__swab32(x)
+# define __bpf_htonl(x)			__swab32(x)
 # define __bpf_constant_ntohl(x)	___constant_swab32(x)
 # define __bpf_constant_htonl(x)	___constant_swab32(x)
 #elif __BYTE_ORDER__ == __ORDER_BIG_ENDIAN__
-- 
2.21.0

