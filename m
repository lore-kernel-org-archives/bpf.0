Return-Path: <SRS0=ACyN=SY=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00F07C10F11
	for <bpf@archiver.kernel.org>; Mon, 22 Apr 2019 18:34:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D091C20896
	for <bpf@archiver.kernel.org>; Mon, 22 Apr 2019 18:34:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726430AbfDVSey (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 22 Apr 2019 14:34:54 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52958 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726305AbfDVSey (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 22 Apr 2019 14:34:54 -0400
Received: by mail-wm1-f66.google.com with SMTP id a184so15403829wma.2;
        Mon, 22 Apr 2019 11:34:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2qW0B6c+gjBj2a2CaMOT7NEqXe3ybY4s2479Mq4BOPU=;
        b=AdX8mVS9aqb5qHaAn+Y87kMYl9i/B5WXOsfqCURTt0zkQu+sXjAkQfm/lwwyuGuPS1
         8Ks/0e2YTEbS2xh7OSEkRumsgFdA6DB47UPPDbyRNk7e20RMUG0+8n9zqbFXHz5QTt/A
         iEkPFditHqZYnDtfJOdACScd6oC3MH2bNadxeWWSQVch+vzaHXM4NauLIlCSfLXzs1wq
         rn2lhH8my1DYw58CuzXDktJ4DIflBysRi9dqYTd1RzecaL9uHXVZ1EX+YTd7G0qyav7E
         iqZfVQrymq3hWQ+0KCZOauhJPFK+X3M2dZa6L9P0f2av5eZHklHKa/jYeuRusoaLud3h
         AX/A==
X-Gm-Message-State: APjAAAV28qAgeMYk5QVJUCQwAuB3az6dK3PUC8HU+4XOaj+9qx43DVar
        Cj7Y9AkJsSl5RCPTnBJJz2E=
X-Google-Smtp-Source: APXvYqycjpz01m6bKprpG06snYee/6w9J0uoWx5JeXuqr/MLkmYNpskDnigHx4M4xk6bTazjl1czig==
X-Received: by 2002:a1c:5543:: with SMTP id j64mr13185575wmb.37.1555958092550;
        Mon, 22 Apr 2019 11:34:52 -0700 (PDT)
Received: from Nover ([161.105.209.130])
        by smtp.gmail.com with ESMTPSA id s203sm21760849wmf.14.2019.04.22.11.34.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 22 Apr 2019 11:34:51 -0700 (PDT)
Date:   Mon, 22 Apr 2019 20:34:43 +0200
From:   Paul Chaignon <paul.chaignon@orange.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Cc:     Xiao Han <xiao.han@orange.com>, Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>
Subject: [PATCH bpf v2 1/2] bpf: mark registers as safe or unknown in all
 frames
Message-ID: <d2c281e7a9a8011d5890103c15be5fdd2d2c7864.1555957346.git.paul.chaignon@orange.com>
References: <cover.1555957346.git.paul.chaignon@orange.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1555957346.git.paul.chaignon@orange.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

In case of a null check on a pointer inside a subprog, we should mark all
registers with this pointer as either safe or unknown, in both the current
and previous frames.  Currently, only spilled registers and registers in
the current frame are marked.  This patch also marks registers in previous
frames.

A good reproducer looks as follow:

1: ptr = bpf_map_lookup_elem(map, &key);
2: ret = subprog(ptr) {
3:   return ptr != NULL;
4: }
5: if (ret)
6:   value = *ptr;

With the above, the verifier will complain on line 6 because it sees ptr
as map_value_or_null despite the null check in subprog 1.

Note that this patch fixes another resulting bug when using
bpf_sk_release():

1: sk = bpf_sk_lookup_tcp(...);
2: subprog(sk) {
3:   if (sk)
4:     bpf_sk_release(sk);
5: }
6: if (!sk)
7:   return 0;
8: return 1;

In the above, mark_ptr_or_null_regs will warn on line 6 because it will
try to free the reference state, even though it was already freed on
line 3.

Fixes: f4d7e40a5b71 ("bpf: introduce function calls (verification)")
Signed-off-by: Paul Chaignon <paul.chaignon@orange.com>
---
 kernel/bpf/verifier.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index db301e9b5295..777970d8c245 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -4876,11 +4876,11 @@ static void mark_ptr_or_null_regs(struct bpf_verifier_state *vstate, u32 regno,
 		 */
 		WARN_ON_ONCE(release_reference_state(state, id));
 
-	for (i = 0; i < MAX_BPF_REG; i++)
-		mark_ptr_or_null_reg(state, &regs[i], id, is_null);
-
 	for (j = 0; j <= vstate->curframe; j++) {
 		state = vstate->frame[j];
+		for (i = 0; i < MAX_BPF_REG; i++)
+			mark_ptr_or_null_reg(state, &state->regs[i], id,
+					     is_null);
 		bpf_for_each_spilled_reg(i, state, reg) {
 			if (!reg)
 				continue;
-- 
2.17.1

