Return-Path: <SRS0=W3SG=S2=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 391A8C10F11
	for <bpf@archiver.kernel.org>; Wed, 24 Apr 2019 19:50:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0954E21773
	for <bpf@archiver.kernel.org>; Wed, 24 Apr 2019 19:50:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731543AbfDXTu6 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 24 Apr 2019 15:50:58 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38085 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbfDXTu6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 24 Apr 2019 15:50:58 -0400
Received: by mail-wr1-f67.google.com with SMTP id f14so26227472wrj.5;
        Wed, 24 Apr 2019 12:50:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=z4L0btbftjpl6bOwBQSKWvEaWDfbjbHbWFKMkjqKcFI=;
        b=AgURp3Csies1Pi0K/G4eXjSWSsKNylAQjNnA9mV3yzbh8CDcB4ZYTTGU71vavmbFn/
         BvAu6rvmhFyRfRhB4qYIxc1/n1iVtvfcJRaM33edjA6Fjp9DIuaDGN+R2Yi+siewUBE/
         qu6ZBxRP5RDs/l/m5U7RzgGDSMt5qhgBa8E6J0x8R326lR9XKOjiuyZfLxB7Bq4YF4xz
         7NgR0bmvNlIITdk3ML330IDhkXVllOLPcS97qPnCm2hyQkINCOUIGUrY2fa09F8Ln1mP
         N6CV0YrzMZxSNZlIK40NfwhA0PPSTuaA1szKKjGnN2OrZFtTNA3dIY0NkSKTI62LmC5R
         TU+Q==
X-Gm-Message-State: APjAAAVB4xYldUf0RRMkrvbNEzXPm3ZT+zeDq7PaIZ9qpX7eIq3GvTrk
        IDc3R4zAt7c1pX7XmQBzuT8Jo2lgYoc=
X-Google-Smtp-Source: APXvYqyC/ONvBZmWmEJY7u0PkpFenBhPXQvbl1H5EX+VBYH1rKxjjQELjpvsRVWQbEvrUKLbeEWpag==
X-Received: by 2002:a5d:6a51:: with SMTP id t17mr22182164wrw.329.1556135455745;
        Wed, 24 Apr 2019 12:50:55 -0700 (PDT)
Received: from Nover ([161.105.209.130])
        by smtp.gmail.com with ESMTPSA id u10sm19433506wml.32.2019.04.24.12.50.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Apr 2019 12:50:55 -0700 (PDT)
Date:   Wed, 24 Apr 2019 21:50:42 +0200
From:   Paul Chaignon <paul.chaignon@orange.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Cc:     Xiao Han <xiao.han@orange.com>, Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>
Subject: [PATCH bpf v3 1/2] bpf: mark registers in all frames after pkt/null
 checks
Message-ID: <afdfb6e73b2ba60a2b97a35f78d1fba0d85c3b64.1556127905.git.paul.chaignon@orange.com>
References: <cover.1556127905.git.paul.chaignon@orange.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1556127905.git.paul.chaignon@orange.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

In case of a null check on a pointer inside a subprog, we should mark all
registers with this pointer as either safe or unknown, in both the current
and previous frames.  Currently, only spilled registers and registers in
the current frame are marked.  Packet bound checks in subprogs have the
same issue.  This patch fixes it to mark registers in previous frames as
well.

A good reproducer for null checks looks as follow:

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
 kernel/bpf/verifier.c | 76 ++++++++++++++++++++++++++-----------------
 1 file changed, 46 insertions(+), 30 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 423f242a5efb..cc2d85bd5a3a 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -4297,15 +4297,35 @@ static int check_alu_op(struct bpf_verifier_env *env, struct bpf_insn *insn)
 	return 0;
 }
 
+static void __find_good_pkt_pointers(struct bpf_func_state *state,
+				     struct bpf_reg_state *dst_reg,
+				     enum bpf_reg_type type, u16 new_range)
+{
+	struct bpf_reg_state *reg;
+	int i;
+
+	for (i = 0; i < MAX_BPF_REG; i++) {
+		reg = &state->regs[i];
+		if (reg->type == type && reg->id == dst_reg->id)
+			/* keep the maximum range already checked */
+			reg->range = max(reg->range, new_range);
+	}
+
+	bpf_for_each_spilled_reg(i, state, reg) {
+		if (!reg)
+			continue;
+		if (reg->type == type && reg->id == dst_reg->id)
+			reg->range = max(reg->range, new_range);
+	}
+}
+
 static void find_good_pkt_pointers(struct bpf_verifier_state *vstate,
 				   struct bpf_reg_state *dst_reg,
 				   enum bpf_reg_type type,
 				   bool range_right_open)
 {
-	struct bpf_func_state *state = vstate->frame[vstate->curframe];
-	struct bpf_reg_state *regs = state->regs, *reg;
 	u16 new_range;
-	int i, j;
+	int i;
 
 	if (dst_reg->off < 0 ||
 	    (dst_reg->off == 0 && range_right_open))
@@ -4370,20 +4390,9 @@ static void find_good_pkt_pointers(struct bpf_verifier_state *vstate,
 	 * the range won't allow anything.
 	 * dst_reg->off is known < MAX_PACKET_OFF, therefore it fits in a u16.
 	 */
-	for (i = 0; i < MAX_BPF_REG; i++)
-		if (regs[i].type == type && regs[i].id == dst_reg->id)
-			/* keep the maximum range already checked */
-			regs[i].range = max(regs[i].range, new_range);
-
-	for (j = 0; j <= vstate->curframe; j++) {
-		state = vstate->frame[j];
-		bpf_for_each_spilled_reg(i, state, reg) {
-			if (!reg)
-				continue;
-			if (reg->type == type && reg->id == dst_reg->id)
-				reg->range = max(reg->range, new_range);
-		}
-	}
+	for (i = 0; i <= vstate->curframe; i++)
+		__find_good_pkt_pointers(vstate->frame[i], dst_reg, type,
+					 new_range);
 }
 
 /* compute branch direction of the expression "if (reg opcode val) goto target;"
@@ -4857,6 +4866,22 @@ static void mark_ptr_or_null_reg(struct bpf_func_state *state,
 	}
 }
 
+static void __mark_ptr_or_null_regs(struct bpf_func_state *state, u32 id,
+				    bool is_null)
+{
+	struct bpf_reg_state *reg;
+	int i;
+
+	for (i = 0; i < MAX_BPF_REG; i++)
+		mark_ptr_or_null_reg(state, &state->regs[i], id, is_null);
+
+	bpf_for_each_spilled_reg(i, state, reg) {
+		if (!reg)
+			continue;
+		mark_ptr_or_null_reg(state, reg, id, is_null);
+	}
+}
+
 /* The logic is similar to find_good_pkt_pointers(), both could eventually
  * be folded together at some point.
  */
@@ -4864,10 +4889,10 @@ static void mark_ptr_or_null_regs(struct bpf_verifier_state *vstate, u32 regno,
 				  bool is_null)
 {
 	struct bpf_func_state *state = vstate->frame[vstate->curframe];
-	struct bpf_reg_state *reg, *regs = state->regs;
+	struct bpf_reg_state *regs = state->regs;
 	u32 ref_obj_id = regs[regno].ref_obj_id;
 	u32 id = regs[regno].id;
-	int i, j;
+	int i;
 
 	if (ref_obj_id && ref_obj_id == id && is_null)
 		/* regs[regno] is in the " == NULL" branch.
@@ -4876,17 +4901,8 @@ static void mark_ptr_or_null_regs(struct bpf_verifier_state *vstate, u32 regno,
 		 */
 		WARN_ON_ONCE(release_reference_state(state, id));
 
-	for (i = 0; i < MAX_BPF_REG; i++)
-		mark_ptr_or_null_reg(state, &regs[i], id, is_null);
-
-	for (j = 0; j <= vstate->curframe; j++) {
-		state = vstate->frame[j];
-		bpf_for_each_spilled_reg(i, state, reg) {
-			if (!reg)
-				continue;
-			mark_ptr_or_null_reg(state, reg, id, is_null);
-		}
-	}
+	for (i = 0; i <= vstate->curframe; i++)
+		__mark_ptr_or_null_regs(vstate->frame[i], id, is_null);
 }
 
 static bool try_match_pkt_pointers(const struct bpf_insn *insn,
-- 
2.17.1

