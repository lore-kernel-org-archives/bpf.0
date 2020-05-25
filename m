Return-Path: <SRS0=jDDX=7H=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FEFAC433DF
	for <bpf@archiver.kernel.org>; Mon, 25 May 2020 13:54:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4334A2071A
	for <bpf@archiver.kernel.org>; Mon, 25 May 2020 13:54:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403909AbgEYNyY (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 25 May 2020 09:54:24 -0400
Received: from sym2.noone.org ([178.63.92.236]:57420 "EHLO sym2.noone.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403812AbgEYNyX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 25 May 2020 09:54:23 -0400
Received: by sym2.noone.org (Postfix, from userid 1002)
        id 49Vz9B07Vjzvjc1; Mon, 25 May 2020 15:54:21 +0200 (CEST)
From:   Tobias Klauser <tklauser@distanz.ch>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     bpf@vger.kernel.org
Subject: [PATCH] bpftool: print correct error message when failing to load BTF
Date:   Mon, 25 May 2020 15:54:21 +0200
Message-Id: <20200525135421.4154-1-tklauser@distanz.ch>
X-Mailer: git-send-email 2.11.0
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

btf__parse_raw and btf__parse_elf return negative error numbers wrapped
in an ERR_PTR, so the extracted value needs to be negated before passing
them to strerror which expects a positive error number.

Before:
  Error: failed to load BTF from .../vmlinux: Unknown error -2

After:
  Error: failed to load BTF from .../vmlinux: No such file or directory

Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
---
 tools/bpf/bpftool/btf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/bpf/bpftool/btf.c b/tools/bpf/bpftool/btf.c
index 41a1346934a1..da6c3b9bd821 100644
--- a/tools/bpf/bpftool/btf.c
+++ b/tools/bpf/bpftool/btf.c
@@ -553,7 +553,7 @@ static int do_dump(int argc, char **argv)
 			btf = btf__parse_elf(*argv, NULL);
 
 		if (IS_ERR(btf)) {
-			err = PTR_ERR(btf);
+			err = -PTR_ERR(btf);
 			btf = NULL;
 			p_err("failed to load BTF from %s: %s",
 			      *argv, strerror(err));
-- 
2.26.1

