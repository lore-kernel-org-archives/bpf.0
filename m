Return-Path: <SRS0=CEAn=TO=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B44BDC04AB4
	for <bpf@archiver.kernel.org>; Tue, 14 May 2019 21:12:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A6EB20873
	for <bpf@archiver.kernel.org>; Tue, 14 May 2019 21:12:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lbqQA+/r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbfENVMl (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 14 May 2019 17:12:41 -0400
Received: from mail-oi1-f202.google.com ([209.85.167.202]:52858 "EHLO
        mail-oi1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726265AbfENVMk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 May 2019 17:12:40 -0400
Received: by mail-oi1-f202.google.com with SMTP id j9so175047oih.19
        for <bpf@vger.kernel.org>; Tue, 14 May 2019 14:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=f4HloUjiQjHr3SUwk4xw1iDaHpvfypDo+dWu4ub0D+0=;
        b=lbqQA+/roB+NGcMKRsBPTxAX3UnGLFutoQsaIbPCUy/dl61OTM4A4waSp4cIh7BmWZ
         FRyLPWnVmHGOUZO1ZxzkFWO2sigyRVhdfNjZBzDstPAdsNeXDKbq7IofpFzjGrc1e2Xa
         S1EoHeKUkdHtPFHDLBhsp+u16C3mZU+cHdCXwLalXja2oTivUUo5+XQyn35YSs1qOhgG
         v04gyApmmXzFCr9JtlAtZNm+DteGh4kbElbudxNIVtbHb4A3HMN3bqcUrOHaX5WOSOJS
         IpLc3th2aHTMEP9R+k1cmljO4JbWizXZdcWI71S87R/XV2E8Sti1V9cF1XgWxoRmYo1+
         7/wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=f4HloUjiQjHr3SUwk4xw1iDaHpvfypDo+dWu4ub0D+0=;
        b=bJtvy97xaLZYlVEbqa6Pmzi1o2e1OLwOV5HU9Ag0Htb52LVALo3lCwDHtfGOKyqEcM
         zVpNnhOWQWQ1G4gFdSyIW/G/DmXRRDPI/N9PUhlxZHddzXjCG7aEQyU3qOF47CmI8tOR
         6Nolfdt8QIvxV6YUj7HuwCBi3Cp4Nn4UZr+LWlJYcjlAjH89t8l3H2kTFPBiK0upCB8r
         BkNGdAVTO48+E78BdO0pmgLwwcesenYrzu2XpnhSzWqEw04psEGM9f7FVFGgaKHEwMXD
         Bwpfkj7BaP9vxT5l6Ruyd/J8C67tEv6s0x8DCC1Py777u4E9nEUq8hCvPHlH3nGv/rWr
         kf8Q==
X-Gm-Message-State: APjAAAVfGtJJ4UiOmSUJ4tRrOGSlFMOfzH2oNVVoO9mgXdI/DYrDMTzJ
        9aeKzPEc1zb+ZeRKPBYruVUdy+g=
X-Google-Smtp-Source: APXvYqyYiCp5DjnGAGHgrnNj6QVVU3tpJjkbXwVF4DaNh3Y34av5Dx+2S3jwV2YxuYPaxPcL0EY6wNM=
X-Received: by 2002:aca:da82:: with SMTP id r124mr4192393oig.49.1557868359634;
 Tue, 14 May 2019 14:12:39 -0700 (PDT)
Date:   Tue, 14 May 2019 14:12:34 -0700
In-Reply-To: <20190514211234.25097-1-sdf@google.com>
Message-Id: <20190514211234.25097-2-sdf@google.com>
Mime-Version: 1.0
References: <20190514211234.25097-1-sdf@google.com>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
Subject: [PATCH bpf 2/2] selftests/bpf: add prog detach to flow_dissector test
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     davem@davemloft.net, ast@kernel.org, daniel@iogearbox.net,
        Stanislav Fomichev <sdf@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

In case we are not running in a namespace (which we don't do by default),
let's try to detach the bpf program that we use for eth_get_headlen tests.

Fixes: 0905beec9f52 ("selftests/bpf: run flow dissector tests in skb-less mode")
Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 tools/testing/selftests/bpf/prog_tests/flow_dissector.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/flow_dissector.c b/tools/testing/selftests/bpf/prog_tests/flow_dissector.c
index d40cee07a224..fbd1d88a6095 100644
--- a/tools/testing/selftests/bpf/prog_tests/flow_dissector.c
+++ b/tools/testing/selftests/bpf/prog_tests/flow_dissector.c
@@ -264,5 +264,6 @@ void test_flow_dissector(void)
 		CHECK_FLOW_KEYS(tests[i].name, flow_keys, tests[i].keys);
 	}
 
+	bpf_prog_detach(prog_fd, BPF_FLOW_DISSECTOR);
 	bpf_object__close(obj);
 }
-- 
2.21.0.1020.gf2820cf01a-goog

