Return-Path: <SRS0=moIC=UQ=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6CC8C31E5B
	for <bpf@archiver.kernel.org>; Mon, 17 Jun 2019 18:01:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FB3720861
	for <bpf@archiver.kernel.org>; Mon, 17 Jun 2019 18:01:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FvdtVe3V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726614AbfFQSBx (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 17 Jun 2019 14:01:53 -0400
Received: from mail-oi1-f202.google.com ([209.85.167.202]:50412 "EHLO
        mail-oi1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726215AbfFQSBx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 17 Jun 2019 14:01:53 -0400
Received: by mail-oi1-f202.google.com with SMTP id p83so3824449oih.17
        for <bpf@vger.kernel.org>; Mon, 17 Jun 2019 11:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=aMAVJjYPVW0LDE+1k3jh4sYPHN+8Kpd0vTrAOfnc5og=;
        b=FvdtVe3Vbc39dmix+NbXtFO0MuPToF39PwPdhhwcCGBjaXhcsjoA1cZ/nxNgHkXDzs
         bDh7EnOcFzrQFcGVb1ZYN8oQypdkRkfrmpttn1B4VuXFewqPFXKnPZWLicYPWufdgZxV
         NizLHYuh/GucFT0L7dVVIWgGRmVraYJMqpwp1XZYTHgFZ7Sf/jNqalwqKfgv3KF8eZ6X
         iT9mJS4RU/1C89Gma3S87e8VViiFzMczPDPrjD46QAzv9QAokmdk+syLfcFiuDolECmH
         rv0QVS9sJxSIkbs89KVok78IEESMPTD1FIPikZvdyB9CcX8XDb0WTvzhIGgy4wLurg4r
         MiZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=aMAVJjYPVW0LDE+1k3jh4sYPHN+8Kpd0vTrAOfnc5og=;
        b=E9+WhJnnL4ei1TMGuAWmgsYv1eYevzMTZ+ng17RqPpOFXvAssNf3j37JfmAq+H5fF2
         GN3DqhfUsRfKCJB8lB6NzShVtGPAB4/SxvVbT4UYB6zVuas9Vcyljxn3VbFs4qzfUq70
         SVhfbHBR/CRTuU7P1TPG6k203q6+aZ7C57oYWkfo2kXBD1oAmc943+pwW5JTfLWlIfKF
         Hv0yqamMrN3NuAoFZ16Y8ECZMnJKZFfQxMdXVZs+p40VlENiRkZJv2RGyT/NfQU8sEZ9
         pDcTRa7jRPM3KRSxCxYDv7hAHvhh8rI1C9+vGBNRDPsveetpFbAZgZbvb2PhpsTuD1Ut
         r8vA==
X-Gm-Message-State: APjAAAXUt59Ga7IfdBqwKnl1beHG5TdZnvq0Oy2UwDfMabKD4pElIvrq
        gvGYEGb64ijkmTVA18DIj1F5F/o=
X-Google-Smtp-Source: APXvYqz0mqk9GIDPC4J50t86rZtPLM7U1vEjox029PZVgNZ5MlaXtPjOaPVh9OkXzxEyrgOK4HnCTrw=
X-Received: by 2002:aca:cc85:: with SMTP id c127mr123475oig.81.1560794512480;
 Mon, 17 Jun 2019 11:01:52 -0700 (PDT)
Date:   Mon, 17 Jun 2019 11:01:04 -0700
In-Reply-To: <20190617180109.34950-1-sdf@google.com>
Message-Id: <20190617180109.34950-5-sdf@google.com>
Mime-Version: 1.0
References: <20190617180109.34950-1-sdf@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH bpf-next v6 4/9] selftests/bpf: test sockopt section name
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     davem@davemloft.net, ast@kernel.org, daniel@iogearbox.net,
        Stanislav Fomichev <sdf@google.com>, Martin Lau <kafai@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add tests that make sure libbpf section detection works.

Cc: Martin Lau <kafai@fb.com>
Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 tools/testing/selftests/bpf/test_section_names.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tools/testing/selftests/bpf/test_section_names.c b/tools/testing/selftests/bpf/test_section_names.c
index bebd4fbca1f4..5f84b3b8c90b 100644
--- a/tools/testing/selftests/bpf/test_section_names.c
+++ b/tools/testing/selftests/bpf/test_section_names.c
@@ -124,6 +124,16 @@ static struct sec_name_test tests[] = {
 		{0, BPF_PROG_TYPE_CGROUP_SYSCTL, BPF_CGROUP_SYSCTL},
 		{0, BPF_CGROUP_SYSCTL},
 	},
+	{
+		"cgroup/getsockopt",
+		{0, BPF_PROG_TYPE_CGROUP_SOCKOPT, BPF_CGROUP_GETSOCKOPT},
+		{0, BPF_CGROUP_GETSOCKOPT},
+	},
+	{
+		"cgroup/setsockopt",
+		{0, BPF_PROG_TYPE_CGROUP_SOCKOPT, BPF_CGROUP_SETSOCKOPT},
+		{0, BPF_CGROUP_SETSOCKOPT},
+	},
 };
 
 static int test_prog_type_by_name(const struct sec_name_test *test)
-- 
2.22.0.410.gd8fdbe21b5-goog

