Return-Path: <SRS0=sRBR=SN=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C95BC10F13
	for <bpf@archiver.kernel.org>; Thu, 11 Apr 2019 22:47:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D68F22084D
	for <bpf@archiver.kernel.org>; Thu, 11 Apr 2019 22:47:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IWhc9lO4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726770AbfDKWrL (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 11 Apr 2019 18:47:11 -0400
Received: from mail-qk1-f202.google.com ([209.85.222.202]:56651 "EHLO
        mail-qk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726693AbfDKWrL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 11 Apr 2019 18:47:11 -0400
Received: by mail-qk1-f202.google.com with SMTP id a15so6393154qkl.23
        for <bpf@vger.kernel.org>; Thu, 11 Apr 2019 15:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=1Pi1XLhjKt+Uz5YHVsvxX+uAnkFkW6KcVUEtq9i/B7k=;
        b=IWhc9lO4kGiQd5+YmnH4wfSDEvkxhuJS7T3Ngj1Ue0JTiFeoBaMMjiRlPth6kC3249
         PTOSEjS3o8dKncz8LcJheahHe5nyVdjeMniprqmtOLenor5Rw+PslNiScS0qKyV0+zV5
         t8FX5PRUV9GXCC3H77o3Jfy1erVLjERnTUIEg6PmArmdk7+Q9gItTmVajoCFtRzMRmjB
         QZ1nYIzuan3TQGfv4OywcAKFr1Ei/O0gRtPANgrIZXxZgO6tlH6Eg1QZMYY0H69bzeun
         hBzv1663uFfVCtEVUwSiFfbapTsqcEW+yhSIgPu7XJadYy1qqBwW+PeN8QeSYFpvsVBp
         fudw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=1Pi1XLhjKt+Uz5YHVsvxX+uAnkFkW6KcVUEtq9i/B7k=;
        b=ljrXZhtr+n3fSp7vjApK9kZrYtfcj1XAFUfbbCjF1HKyLiR7R1HqhqJ0P1jgi6qo8t
         WAq8DO+kJ8eMLGwbtHtws6mhH8y5WY2i1ijxgKzTkPutNhv4WbYnY+Bi0mBDuSehyzm1
         xWTHATIWRQuVHrfbWFfxHvTa1ESURx+ANjXCESad+LOcXpDXZk7tgxlnNfsNXIoix3TG
         DTPChi8kghv6x/fNVSEsUhY0LCTu9zvaAEr5KmN1o9z2XlWKGXADNiMgT7qEcBRZndMZ
         eTvBwtvkAExAltfqKUvoQYRCoMH8DerVYWHjen6n4ekJc46ILKcJ90kGAcU6t67ge2Ql
         6DUA==
X-Gm-Message-State: APjAAAXuMKa9wCPBSvPg6ItvCMcLqRCOqjpe+cpR+lZKZ9a5z/CK7dNP
        CPiMTd9jFCgMXlHTCpimrW2yA/A=
X-Google-Smtp-Source: APXvYqzfQpPad6PzmxEiCl6xOo2FKZGP6Z7R0mY1mmsIhkSUqbBVrumw5pfUCmS/eS8Svatj1OD2sTI=
X-Received: by 2002:ac8:2562:: with SMTP id 31mr7198230qtn.16.1555022830003;
 Thu, 11 Apr 2019 15:47:10 -0700 (PDT)
Date:   Thu, 11 Apr 2019 15:47:07 -0700
Message-Id: <20190411224707.104655-1-sdf@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: [PATCH bpf-next] bpf: explicitly prohibit ctx_{in,out} in non-skb BPF_PROG_TEST_RUN
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     davem@davemloft.net, ast@kernel.org, daniel@iogearbox.net,
        Stanislav Fomichev <sdf@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This should allow us later to extend BPF_PROG_TEST_RUN for non-skb case
and be sure that nobody is erroneously setting ctx_{in,out}.

Fixes: b0b9395d865e ("bpf: support input __sk_buff context in BPF_PROG_TEST_RUN")
Reported-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 net/bpf/test_run.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index cbd4fb65aa4f..2221573dacdb 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -347,6 +347,9 @@ int bpf_prog_test_run_xdp(struct bpf_prog *prog, const union bpf_attr *kattr,
 	void *data;
 	int ret;
 
+	if (kattr->test.ctx_in || kattr->test.ctx_out)
+		return -EINVAL;
+
 	data = bpf_test_init(kattr, size, XDP_PACKET_HEADROOM + NET_IP_ALIGN, 0);
 	if (IS_ERR(data))
 		return PTR_ERR(data);
@@ -390,6 +393,9 @@ int bpf_prog_test_run_flow_dissector(struct bpf_prog *prog,
 	if (prog->type != BPF_PROG_TYPE_FLOW_DISSECTOR)
 		return -EINVAL;
 
+	if (kattr->test.ctx_in || kattr->test.ctx_out)
+		return -EINVAL;
+
 	data = bpf_test_init(kattr, size, NET_SKB_PAD + NET_IP_ALIGN,
 			     SKB_DATA_ALIGN(sizeof(struct skb_shared_info)));
 	if (IS_ERR(data))
-- 
2.21.0.392.gf8f6787159e-goog

