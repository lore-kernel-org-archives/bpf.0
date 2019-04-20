Return-Path: <SRS0=qOzI=SW=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48D7BC282DD
	for <bpf@archiver.kernel.org>; Sat, 20 Apr 2019 12:40:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F9602183F
	for <bpf@archiver.kernel.org>; Sat, 20 Apr 2019 12:40:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726082AbfDTMkJ (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Sat, 20 Apr 2019 08:40:09 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39704 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbfDTMkJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 20 Apr 2019 08:40:09 -0400
Received: by mail-wr1-f65.google.com with SMTP id j9so10025890wrn.6;
        Sat, 20 Apr 2019 05:40:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2zUdyrXjB8zSmFinaD8juGVP7dY0GPuIVrNW+lzoEfA=;
        b=lJz9xrFpQC2GBhJslhkjoXGK5AGt6zxSt/4H29fhFCyLiOqBEdL4qVusvWWcMZpfSU
         VycBYcoHvUhAXBQGvO32+JXOpYJIVpNkCt3EonIsya11jbD76sO+w0oPW8PAmXUxxT1A
         u4JgJjh0I7kSRDrmfDYArXBaSSz4bz1EMcb+bYtbExfptvEZk9l0fwbQBnsMkXhkqP1N
         tg8Uxiam08j8+GrPgfYP8HztOXxdc5PK0TG4ychk7ZPkdb8xX7rUITjgq3g/DOea7Egb
         QJ1jM+AH6/8frheDFcboizlnsVOBu6sm/hgHDA2unuG7Wins+HhQ3dJKvwuAUp4cEgsu
         OwaA==
X-Gm-Message-State: APjAAAVwxOi3cydWmLs3c+8dIoxP5iZOd70cQJSrBniM2TVdSJJzEKfW
        BmJpLRPqAK5yzoQTE0J9+/E=
X-Google-Smtp-Source: APXvYqzjmJjN6j1GE1fkAtzqm+4gp9yQqQrxa14oxaxOVZNBdg2WwODyBccMZkriTjTWLD8yNCNEFg==
X-Received: by 2002:a5d:6a03:: with SMTP id m3mr6768483wru.88.1555764007617;
        Sat, 20 Apr 2019 05:40:07 -0700 (PDT)
Received: from Nover ([161.105.209.130])
        by smtp.gmail.com with ESMTPSA id s2sm4816531wrr.50.2019.04.20.05.40.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 20 Apr 2019 05:40:06 -0700 (PDT)
Date:   Sat, 20 Apr 2019 14:39:55 +0200
From:   Paul Chaignon <paul.chaignon@orange.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Cc:     Xiao Han <xiao.han@orange.com>, Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>
Subject: [PATCH bpf 1/2] bpf: mark registers as safe or unknown in all frames
Message-ID: <06e9f9c4c3cb780459fa22e552fe65328726e55c.1555761008.git.paul.chaignon@orange.com>
References: <cover.1555761008.git.paul.chaignon@orange.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1555761008.git.paul.chaignon@orange.com>
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

1: sk = bpf_sk_lookup_tcp();
2: subprog(sk) {
3:   if (sk)
4:     bpf_sk_release(sk, 0);
5: }
6: if (!sk)
7:   return 0;
8: return sk;

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

