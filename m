Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA06EC433EF
	for <bpf@archiver.kernel.org>; Wed, 13 Jul 2022 01:27:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233517AbiGMB1g (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 12 Jul 2022 21:27:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230343AbiGMB1e (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 12 Jul 2022 21:27:34 -0400
Received: from 69-171-232-181.mail-mxout.facebook.com (69-171-232-181.mail-mxout.facebook.com [69.171.232.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF8EAC9135
        for <bpf@vger.kernel.org>; Tue, 12 Jul 2022 18:27:31 -0700 (PDT)
Received: by devbig010.atn6.facebook.com (Postfix, from userid 115148)
        id AC204EE07695; Tue, 12 Jul 2022 18:27:19 -0700 (PDT)
From:   Joanne Koong <joannelkoong@gmail.com>
To:     bpf@vger.kernel.org
Cc:     andrii@kernel.org, daniel@iogearbox.net, ast@kernel.org,
        Joanne Koong <joannelkoong@gmail.com>
Subject: [PATCH bpf-next v1] bpf: Fix bpf/sk_skb_pull_data for flags == 0
Date:   Tue, 12 Jul 2022 18:26:21 -0700
Message-Id: <20220713012621.2485047-1-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

In the case where flags is 0, bpf_skb_pull_data and sk_skb_pull_data
should pull the entire skb payload including the bytes in the non-linear
page buffers.

This is documented in the uapi:
"If a zero value is passed for *len*, then the whole length of the *skb*
is pulled"

Fixes: 36bbef52c7eb6 ("bpf: direct packet write and access for helpers
for clsact progs")
Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 net/core/filter.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index 4ef77ec5255e..97eb15891bfc 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -1838,7 +1838,7 @@ BPF_CALL_2(bpf_skb_pull_data, struct sk_buff *, skb=
, u32, len)
 	 * access case. By this we overcome limitations of only current
 	 * headroom being accessible.
 	 */
-	return bpf_try_make_writable(skb, len ? : skb_headlen(skb));
+	return bpf_try_make_writable(skb, len ? : skb->len);
 }
=20
 static const struct bpf_func_proto bpf_skb_pull_data_proto =3D {
@@ -1878,7 +1878,7 @@ BPF_CALL_2(sk_skb_pull_data, struct sk_buff *, skb,=
 u32, len)
 	 * access case. By this we overcome limitations of only current
 	 * headroom being accessible.
 	 */
-	return sk_skb_try_make_writable(skb, len ? : skb_headlen(skb));
+	return sk_skb_try_make_writable(skb, len ? : skb->len);
 }
=20
 static const struct bpf_func_proto sk_skb_pull_data_proto =3D {
--=20
2.30.2

