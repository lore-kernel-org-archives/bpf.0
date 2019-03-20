Return-Path: <SRS0=US5c=RX=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 398D7C43381
	for <bpf@archiver.kernel.org>; Wed, 20 Mar 2019 12:58:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1262D2146E
	for <bpf@archiver.kernel.org>; Wed, 20 Mar 2019 12:58:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726644AbfCTM60 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 20 Mar 2019 08:58:26 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43509 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725996AbfCTM60 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 20 Mar 2019 08:58:26 -0400
Received: by mail-wr1-f65.google.com with SMTP id d17so2625401wre.10;
        Wed, 20 Mar 2019 05:58:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UED6eKg2BsARb7l3cPMyfZMQtxwdMVAAMbeHPWe9wnw=;
        b=DxAP4DPF2mw7fHpt/M3OFk1a66mr8BCYYOkHUCvjwoSi3ctsxGECfQ79G5k9E0DhMm
         zVBXGgPcbL/sbHkzuJJiR6x+XSby1pRuxzSqLzx8FaJ21Ca0Pj1PDpEAK9JiRMsN5SjV
         tH2mVjkbpUn4asB0hucEn2c6TEqpUMt2xESdjSlCZU2o0olgeF3UoE2o0CzgkSXhRbcx
         2NKF6LM9JrmDIQsofLMXExCCaK/hugqeMASfN3KxEvmHxZKBKoVD4kZarbxkOCZdeGtQ
         Lhwad1MC+7lrQs5RUrUc1xKkTaaLgRRM95lsuTKAHr3qN6+kXZBmKIt0WKFBWwVcPe5I
         4x5g==
X-Gm-Message-State: APjAAAX4GRkYtjjhGfE/JMp3Zo+C+Y9mhGQfZdmhtNKK+RqbYpoY+hFj
        w9TNYzp26l40afM00BQpwPc=
X-Google-Smtp-Source: APXvYqyx8njLy7Rk84DVtEt5gCmZa473N5Y7D+FFmvarocjHEJerNRPrF6oL/kOqmAhnpvFIGdMHQQ==
X-Received: by 2002:adf:edca:: with SMTP id v10mr2338175wro.157.1553086704802;
        Wed, 20 Mar 2019 05:58:24 -0700 (PDT)
Received: from Nover ([161.105.209.130])
        by smtp.gmail.com with ESMTPSA id i11sm3090661wrp.40.2019.03.20.05.58.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Mar 2019 05:58:24 -0700 (PDT)
Date:   Wed, 20 Mar 2019 13:58:27 +0100
From:   Paul Chaignon <paul.chaignon@orange.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Cc:     xiao.han@orange.com, paul.chaignon@gmail.com,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>
Subject: [PATCH bpf-next 1/2] bpf: remove incorrect 'verifier bug' warning
Message-ID: <cbdb78d8a0d9a652134824bc73f847acf2a70d9d.1553085539.git.paul.chaignon@orange.com>
References: <cover.1553085539.git.paul.chaignon@orange.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1553085539.git.paul.chaignon@orange.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The BPF verifier checks the maximum number of call stack frames twice,
first in the main CFG traversal (do_check) and then in a subsequent
traversal (check_max_stack_depth).  If the second check fails, it logs a
'verifier bug' warning and errors out, as the number of call stack frames
should have been verified already.

However, the second check may fail without indicating a verifier bug: if
the excessive function calls reside in dead code, the main CFG traversal
may not visit them; the subsequent traversal visits all instructions,
including dead code.

This case raises the question of how invalid dead code should be treated.
This patch implements the conservative option and rejects such code.

Signed-off-by: Paul Chaignon <paul.chaignon@orange.com>
Tested-by: Xiao Han <xiao.han@orange.com>
---
 kernel/bpf/verifier.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 86f9cd5d1c4e..6719bb9b332e 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -1888,8 +1888,9 @@ static int check_max_stack_depth(struct bpf_verifier_env *env)
 		}
 		frame++;
 		if (frame >= MAX_CALL_FRAMES) {
-			WARN_ONCE(1, "verifier bug. Call stack is too deep\n");
-			return -EFAULT;
+			verbose(env, "the call stack of %d frames is too deep !\n",
+				frame);
+			return -E2BIG;
 		}
 		goto process_func;
 	}
-- 
2.17.1

