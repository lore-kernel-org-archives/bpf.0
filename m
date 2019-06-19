Return-Path: <SRS0=Gc+U=US=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05F9EC31E5B
	for <bpf@archiver.kernel.org>; Wed, 19 Jun 2019 19:01:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D223F21734
	for <bpf@archiver.kernel.org>; Wed, 19 Jun 2019 19:01:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TvyiAye0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727076AbfFSTBI (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 19 Jun 2019 15:01:08 -0400
Received: from mail-yw1-f73.google.com ([209.85.161.73]:43676 "EHLO
        mail-yw1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726109AbfFSTBI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 19 Jun 2019 15:01:08 -0400
Received: by mail-yw1-f73.google.com with SMTP id b188so442281ywb.10
        for <bpf@vger.kernel.org>; Wed, 19 Jun 2019 12:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=l1RuwYyoUM7MNHsNUYaTIHfvJqt14cXBll+xGfKKm/Q=;
        b=TvyiAye05jpzYD46+mAT0CLyCxyO9PtWq8Q3ysQr4Wv3LlhEvCYSX3vWEDga6uEddU
         MjqEwMNfNJ6e7Hwcd7P104InSEi3uXKWaujfM8jXnYvq4zg2PRBtxry0Ico0HtF9rQgF
         7QAj6cmX0a3vllnZo5QlOCUttlKNT5xuwW1eUdzN7uq+Ik1iptgXJN75CwkUTD/188AT
         8tBlaOoL6OMkNQkUosiWjp2N+H81y6nOKuWAUOyOgLpZaNZs28isjFpx1oZQ4OVtGstP
         fVeS76aM1xQLLi87A6POQVI5wQFYeikm249j1+9oEoCLvS5WS05OF2/PzXFMa9VJcIxw
         qm8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=l1RuwYyoUM7MNHsNUYaTIHfvJqt14cXBll+xGfKKm/Q=;
        b=K05lnhl/YFaIENuM7S/icUV7K1+4MjzEjUJPHCh8Iy+WpnrWkCT+CDq7nkx769b+Rp
         O+VoAXu4HxDcK7LlLq9AesQoM8EudkkljJxSQWBvEQVnqqwrr3E8ySOYmNIAVN4NgyFe
         bEHyjlHeCRhgueebupKI8r1jiGKFP1cHL35d9bqQTZrn41S0JUYG4d8a4gbl5gO212Mk
         FMPPi/RFcIQ+Q44wSybEaYgqJ6SLllTjIdrL7y5A/Ap7fI9t/+dGXja4OcJ5nvyK4GnP
         SHBPXRwONxGFicAnFYnW7RW8LV2mcSZnfkjyWZN68Ywa0l702DkgIc+uuJNfqO04TSgJ
         G3iA==
X-Gm-Message-State: APjAAAXDihz0aMMeqzazUoTuqNnkUs4EGNtWSMNZgDYZVRkh+OiNoja6
        wOoV1OMuX3CsdQGRldpc5JwXFVs=
X-Google-Smtp-Source: APXvYqxMz00FvxaGlp0Jxfi22VLBSc9wPG0CNDNf59lIDUkewplCsLiI/8FKnHNNQt3yZ6aGZe6UosM=
X-Received: by 2002:a81:195:: with SMTP id 143mr55515168ywb.147.1560970867614;
 Wed, 19 Jun 2019 12:01:07 -0700 (PDT)
Date:   Wed, 19 Jun 2019 12:01:05 -0700
Message-Id: <20190619190105.261533-1-sdf@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH bpf] bpf: fix NULL deref in btf_type_is_resolve_source_only
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     davem@davemloft.net, ast@kernel.org, daniel@iogearbox.net,
        Stanislav Fomichev <sdf@google.com>,
        syzbot <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Commit 1dc92851849c ("bpf: kernel side support for BTF Var and DataSec")
added invocations of btf_type_is_resolve_source_only before
btf_type_nosize_or_null which checks for the NULL pointer.
Swap the order of btf_type_nosize_or_null and
btf_type_is_resolve_source_only to make sure the do the NULL pointer
check first.

Fixes: 1dc92851849c ("bpf: kernel side support for BTF Var and DataSec")
Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 kernel/bpf/btf.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index cad09858a5f2..546ebee39e2a 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -1928,8 +1928,8 @@ static int btf_array_resolve(struct btf_verifier_env *env,
 	/* Check array->index_type */
 	index_type_id = array->index_type;
 	index_type = btf_type_by_id(btf, index_type_id);
-	if (btf_type_is_resolve_source_only(index_type) ||
-	    btf_type_nosize_or_null(index_type)) {
+	if (btf_type_nosize_or_null(index_type) ||
+	    btf_type_is_resolve_source_only(index_type)) {
 		btf_verifier_log_type(env, v->t, "Invalid index");
 		return -EINVAL;
 	}
@@ -1948,8 +1948,8 @@ static int btf_array_resolve(struct btf_verifier_env *env,
 	/* Check array->type */
 	elem_type_id = array->type;
 	elem_type = btf_type_by_id(btf, elem_type_id);
-	if (btf_type_is_resolve_source_only(elem_type) ||
-	    btf_type_nosize_or_null(elem_type)) {
+	if (btf_type_nosize_or_null(elem_type) ||
+	    btf_type_is_resolve_source_only(elem_type)) {
 		btf_verifier_log_type(env, v->t,
 				      "Invalid elem");
 		return -EINVAL;
@@ -2170,8 +2170,8 @@ static int btf_struct_resolve(struct btf_verifier_env *env,
 		const struct btf_type *member_type = btf_type_by_id(env->btf,
 								member_type_id);
 
-		if (btf_type_is_resolve_source_only(member_type) ||
-		    btf_type_nosize_or_null(member_type)) {
+		if (btf_type_nosize_or_null(member_type) ||
+		    btf_type_is_resolve_source_only(member_type)) {
 			btf_verifier_log_member(env, v->t, member,
 						"Invalid member");
 			return -EINVAL;
-- 
2.22.0.410.gd8fdbe21b5-goog

