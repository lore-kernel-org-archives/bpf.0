Return-Path: <SRS0=+7Cc=BL=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13FF3C433E1
	for <bpf@archiver.kernel.org>; Sat,  1 Aug 2020 17:03:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF151206E9
	for <bpf@archiver.kernel.org>; Sat,  1 Aug 2020 17:03:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596301423;
	bh=JLkc6w0q8bm6rcbojeHLpm/9hfjE5to6nb5xM3WFa7w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ErX8mCaTLTujkNobdPqfjzdQhsxNORBxHut1GpKbPP2dvACXRG7KgLsRlb12G3YcT
	 C0pXWKFMRGn0bJCu68MPeXTsXDUaPCDgcY5OmWhH9YVbvRDAZErYPvB2txppqBArcM
	 1Sk+ZPy/5UcCdI1YZN6yNsLZNIW1nTc3zmCcnF3Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727914AbgHARDn convert rfc822-to-8bit (ORCPT
        <rfc822;bpf@archiver.kernel.org>); Sat, 1 Aug 2020 13:03:43 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:27701 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727912AbgHARDm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 1 Aug 2020 13:03:42 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-278-hjIeETCkPLeoMBFqNsb5zg-1; Sat, 01 Aug 2020 13:03:36 -0400
X-MC-Unique: hjIeETCkPLeoMBFqNsb5zg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C97CC8017FB;
        Sat,  1 Aug 2020 17:03:33 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.192.39])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A3ECB5F7D8;
        Sat,  1 Aug 2020 17:03:30 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andriin@fb.com>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Martin KaFai Lau <kafai@fb.com>,
        David Miller <davem@redhat.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Wenbo Zhang <ethercflow@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Brendan Gregg <bgregg@netflix.com>,
        Florent Revest <revest@chromium.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH v9 bpf-next 02/14] tools resolve_btfids: Add support for set symbols
Date:   Sat,  1 Aug 2020 19:03:10 +0200
Message-Id: <20200801170322.75218-3-jolsa@kernel.org>
In-Reply-To: <20200801170322.75218-1-jolsa@kernel.org>
References: <20200801170322.75218-1-jolsa@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kernel.org
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The set symbol does not have the unique number suffix,
so we need to give it a special parsing function.

This was omitted in the first batch, because there was
no set support yet, so it slipped in the testing.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/bpf/resolve_btfids/main.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/tools/bpf/resolve_btfids/main.c b/tools/bpf/resolve_btfids/main.c
index e0929620abc6..5ad15ac61aa1 100644
--- a/tools/bpf/resolve_btfids/main.c
+++ b/tools/bpf/resolve_btfids/main.c
@@ -227,6 +227,24 @@ static char *get_id(const char *prefix_end)
 	return id;
 }
 
+static struct btf_id *add_set(struct object *obj, char *name)
+{
+	/*
+	 * __BTF_ID__set__name
+	 * name =    ^
+	 * id   =         ^
+	 */
+	char *id = name + sizeof(BTF_SET "__") - 1;
+	int len = strlen(name);
+
+	if (id >= name + len) {
+		pr_err("FAILED to parse set name: %s\n", name);
+		return NULL;
+	}
+
+	return btf_id__add(&obj->sets, id, true);
+}
+
 static struct btf_id *add_symbol(struct rb_root *root, char *name, size_t size)
 {
 	char *id;
@@ -383,7 +401,7 @@ static int symbols_collect(struct object *obj)
 			id = add_symbol(&obj->funcs, prefix, sizeof(BTF_FUNC) - 1);
 		/* set */
 		} else if (!strncmp(prefix, BTF_SET, sizeof(BTF_SET) - 1)) {
-			id = add_symbol(&obj->sets, prefix, sizeof(BTF_SET) - 1);
+			id = add_set(obj, prefix);
 			/*
 			 * SET objects store list's count, which is encoded
 			 * in symbol's size, together with 'cnt' field hence
-- 
2.25.4

