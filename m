Return-Path: <SRS0=uCLx=25=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC27EC282DD
	for <bpf@archiver.kernel.org>; Wed,  8 Jan 2020 21:15:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBF4520643
	for <bpf@archiver.kernel.org>; Wed,  8 Jan 2020 21:15:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LHAPrUnk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727181AbgAHVP3 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 8 Jan 2020 16:15:29 -0500
Received: from mail-il1-f175.google.com ([209.85.166.175]:36999 "EHLO
        mail-il1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726836AbgAHVP3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 8 Jan 2020 16:15:29 -0500
Received: by mail-il1-f175.google.com with SMTP id t8so3906269iln.4;
        Wed, 08 Jan 2020 13:15:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=fEakvqeYkfbBRut9ZFCKn5+KChuB1ZUOtinLv56jXgE=;
        b=LHAPrUnkslrPTMrvfOpckVTzEnaENBRbXh3/kSs6LMYHkEIxW/eO2t2abowS/bHQ+0
         ODJGM830KdVPViX26vYP6fmRpab/WuF6Y30QeWWO7ivEXIA7ew/V24Axxr2NPi6A/to3
         LU59Zrjpjm5gSirbhgrCDZeWhdtXDAtBtHqUBaYA20i1537qbtNek4SQQ46ZFHeROF6n
         c10Ep8I4u2aaDsMeVLqKHf1Qk1jyf5gAgvEV/zHcxSfk2R218v4dLCP6oOirIC1l2jn5
         gZKXbjTLR9LyLGf6T+9gnX9IMprqnHClKcSOUWcHQfFDrdxPrE61tEPDGhWZHm67Onh7
         Pzxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=fEakvqeYkfbBRut9ZFCKn5+KChuB1ZUOtinLv56jXgE=;
        b=GA7nVxAiw33pL7Su/IPsjDbWsVPX8x/dNBTpkG4xtkBQrJp5CLb+LGt1YBRkrBo2UD
         q5JYDq6D5bUy19LHI4n9yXBFqo+wgU8M7oY4lIbE73PUpviK9IfY3ODw2SorBX0SGg6y
         fez5GdUvh3TeoKB1tYYkT5zHo5A9YIwkBxf/ttFzA6rRgL/pj5GopMnLYl1Kpf0Ah6kx
         IGFVen+tkMMxcmDlWA26bVWk8i1jJzS1IbJnDikWcFKAqs/sp8bluy3UMq1wDsuzWgdK
         YTAW7QDwUikMdnGyq0fHbpeYLIF41b56VGzMx8/9+30Nd3RsHaWNUEBytABDBy5fE+ah
         ABDQ==
X-Gm-Message-State: APjAAAUMrvxwHRNX6FWxQYaYQ+8lx7O6XXcIYA0vEdh1tWzgiI3EQ+vm
        4QyULUHF96RcdBR4sS6CL8UiwrAQ
X-Google-Smtp-Source: APXvYqzBdHe+4liKu5ft7mY/wrFcOXAPVyCB9Tt0sKPsizSfd4NUJU8NEh0iq1ijAcRFrARF5BRQWA==
X-Received: by 2002:a92:cd0c:: with SMTP id z12mr5920744iln.45.1578518128556;
        Wed, 08 Jan 2020 13:15:28 -0800 (PST)
Received: from [127.0.1.1] ([184.63.162.180])
        by smtp.gmail.com with ESMTPSA id j88sm1301928ilf.83.2020.01.08.13.15.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2020 13:15:28 -0800 (PST)
Subject: [bpf PATCH 5/9] bpf: sockmap/tls,
 msg_push_data may leave end mark in place
From:   John Fastabend <john.fastabend@gmail.com>
To:     bpf@vger.kernel.org
Cc:     netdev@vger.kernel.org, john.fastabend@gmail.com, ast@kernel.org,
        daniel@iogearbox.net
Date:   Wed, 08 Jan 2020 21:15:16 +0000
Message-ID: <157851811621.1732.15187089912852035409.stgit@ubuntu3-kvm2>
In-Reply-To: <157851776348.1732.12600714815781177085.stgit@ubuntu3-kvm2>
References: <157851776348.1732.12600714815781177085.stgit@ubuntu3-kvm2>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Leaving an incorrect end mark in place when passing to crypto
layer will cause crypto layer to stop processing data before
all data is encrypted. To fix clear the end mark on push
data instead of expecting users of the helper to clear the
mark value after the fact.

This happens when we push data into the middle of a skmsg and
have room for it so we don't do a set of copies that already
clear the end flag.

Fixes: 6fff607e2f14b ("bpf: sk_msg program helper bpf_msg_push_data")
Signed-off-by: John Fastabend <john.fastabend@gmail.com>
---
 net/core/filter.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/net/core/filter.c b/net/core/filter.c
index 34d8eb0823f4..21d0190b5413 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -2415,6 +2415,7 @@ BPF_CALL_4(bpf_msg_push_data, struct sk_msg *, msg, u32, start,
 
 		sk_msg_iter_var_next(i);
 		sg_unmark_end(psge);
+		sg_unmark_end(&rsge);
 		sk_msg_iter_next(msg, end);
 	}
 

