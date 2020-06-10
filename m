Return-Path: <SRS0=M8wK=7X=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59AEBC433DF
	for <bpf@archiver.kernel.org>; Wed, 10 Jun 2020 13:08:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3EE0F2078C
	for <bpf@archiver.kernel.org>; Wed, 10 Jun 2020 13:08:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729128AbgFJNIG (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 10 Jun 2020 09:08:06 -0400
Received: from sym2.noone.org ([178.63.92.236]:40362 "EHLO sym2.noone.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728844AbgFJNIF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 10 Jun 2020 09:08:05 -0400
Received: by sym2.noone.org (Postfix, from userid 1002)
        id 49hnNN1RwKzvjc1; Wed, 10 Jun 2020 15:08:04 +0200 (CEST)
From:   Tobias Klauser <tklauser@distanz.ch>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     bpf@vger.kernel.org
Subject: [PATCH bpf] tools, bpftool: Fix memory leak in codegen error cases
Date:   Wed, 10 Jun 2020 15:08:04 +0200
Message-Id: <20200610130804.21423-1-tklauser@distanz.ch>
X-Mailer: git-send-email 2.11.0
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Free the memory allocated for the template on error paths in function
codegen.

Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
---
 tools/bpf/bpftool/gen.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
index a3c4bb86c05a..ecbae47e66b8 100644
--- a/tools/bpf/bpftool/gen.c
+++ b/tools/bpf/bpftool/gen.c
@@ -224,6 +224,7 @@ static int codegen(const char *template, ...)
 		} else {
 			p_err("unrecognized character at pos %td in template '%s'",
 			      src - template - 1, template);
+			free(s);
 			return -EINVAL;
 		}
 	}
@@ -234,6 +235,7 @@ static int codegen(const char *template, ...)
 			if (*src != '\t') {
 				p_err("not enough tabs at pos %td in template '%s'",
 				      src - template - 1, template);
+				free(s);
 				return -EINVAL;
 			}
 		}
-- 
2.27.0

