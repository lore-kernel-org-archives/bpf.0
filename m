Return-Path: <SRS0=US5c=RX=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72057C4360F
	for <bpf@archiver.kernel.org>; Wed, 20 Mar 2019 12:53:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43A192075C
	for <bpf@archiver.kernel.org>; Wed, 20 Mar 2019 12:53:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lbqsMLSi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727916AbfCTMx5 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 20 Mar 2019 08:53:57 -0400
Received: from mail-pf1-f178.google.com ([209.85.210.178]:40514 "EHLO
        mail-pf1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727415AbfCTMx4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 20 Mar 2019 08:53:56 -0400
Received: by mail-pf1-f178.google.com with SMTP id c207so1873728pfc.7;
        Wed, 20 Mar 2019 05:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ukIKVfInVk0vzQJMfehxG9303g8RS5J5ExpczTZNN+Q=;
        b=lbqsMLSiUTrERt4auZfNZGjK8kgDMeg1rfLiRflCBH1aVPDS+D4VC3unUfhCsMdyxY
         cDDrZ+jiaCXa3YiHc2qq9aXGKc+GP5CfBihzEKn9N3WKNfJ25sppsOp5OGBctg7tI6QA
         iCc3DnptFPwbunL6XQogVlobLE5uT11rRadC7nHDVLz5rILL8WU2cUefuYCrAAfkkJeq
         rR2uQIJna8nqt3i/8POhx0XuGxnxNEfOEnqCQQVkU3IqlGFZaEVR9GYVOOeWGwp+4yDQ
         B8HaVGM70T1FWnBStofWRO1pVBRXfwQPwNLnHEhqef02RsXInSEaNWmgAI8gMpl79LbL
         dMew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ukIKVfInVk0vzQJMfehxG9303g8RS5J5ExpczTZNN+Q=;
        b=ZilT+c1P2re6AneIO6VHeKqWOI61WZCOVnWEXxZqksQDl0vugSgrFJeIpdptMw79Br
         NzWDO69pA5HrSUjKdh+M6UHvctIPAuVGZb9CNkNItkpmHjma4KLDvh0iI7S/4s+4INoj
         dHhDkEW9WQihc4zSq+pzmfaSRitO2l2HpN81G8jODBxEMfGkm+Hn9DwkHORpcpM3AhYi
         cmFtUzVGXNfcpGSNl6B7D9uaf2Un+ftXxVGWd4oFeql84f04YB5BAqvG0VeORx/tNABT
         UC5rH1BHHx8Ba6znv1wNizaCsTixnjbUYf2GAQWfS9qILAmihzf/dtxwbZsWOcNaRhj8
         y20w==
X-Gm-Message-State: APjAAAX41KuUdx6LSzHg0uBy/NmUZ9jqlxisWeV7QVIIKQbphSWOrTsp
        FiAeAKUNoFvCA/BYlsXwnA4=
X-Google-Smtp-Source: APXvYqyxYzoAhjYzxiR+Zyg73++5Wn2Nj8P2oYyNjvPtFqBo3GQM36yjLXNuuol4spCJ1ySjKSCr6A==
X-Received: by 2002:a17:902:1029:: with SMTP id b38mr7730072pla.204.1553086436089;
        Wed, 20 Mar 2019 05:53:56 -0700 (PDT)
Received: from localhost.localdomain ([121.137.63.184])
        by smtp.gmail.com with ESMTPSA id r8sm2707467pfd.8.2019.03.20.05.53.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Mar 2019 05:53:55 -0700 (PDT)
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To:     Shuah Khan <shuah@kernel.org>, Alexei Starovoitov <ast@kernel.org>
Cc:     Stanislav Fomichev <sdf@google.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: [PATCHv2 bpf-next 2/3] bpf, tests: drop unused __bpf_constant_foo defines
Date:   Wed, 20 Mar 2019 21:53:34 +0900
Message-Id: <20190320125335.19621-2-sergey.senozhatsky@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190320125335.19621-1-sergey.senozhatsky@gmail.com>
References: <20190320125335.19621-1-sergey.senozhatsky@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Additionally, simplify bpf_ntohs/bpf_ntohl/bpf_htons/bpf_htonl
by switching to UAPI swab().

Signed-off-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
---
 tools/testing/selftests/bpf/bpf_endian.h | 37 +++++-------------------
 1 file changed, 8 insertions(+), 29 deletions(-)

diff --git a/tools/testing/selftests/bpf/bpf_endian.h b/tools/testing/selftests/bpf/bpf_endian.h
index 1ed268b2002b..ba06222963d5 100644
--- a/tools/testing/selftests/bpf/bpf_endian.h
+++ b/tools/testing/selftests/bpf/bpf_endian.h
@@ -20,38 +20,17 @@
  * use different targets.
  */
 #if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
-# define __bpf_ntohs(x)			__swab16(x)
-# define __bpf_htons(x)			__swab16(x)
-# define __bpf_constant_ntohs(x)	___constant_swab16(x)
-# define __bpf_constant_htons(x)	___constant_swab16(x)
-# define __bpf_ntohl(x)			__swab32(x)
-# define __bpf_htonl(x)			__swab32(x)
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

