Return-Path: <SRS0=PZ8U=UG=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_MED,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75A15C2BCA1
	for <bpf@archiver.kernel.org>; Fri,  7 Jun 2019 16:29:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C03B2064A
	for <bpf@archiver.kernel.org>; Fri,  7 Jun 2019 16:29:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OmSHvnck"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730633AbfFGQ3b (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 7 Jun 2019 12:29:31 -0400
Received: from mail-yb1-f201.google.com ([209.85.219.201]:41633 "EHLO
        mail-yb1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730649AbfFGQ33 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 7 Jun 2019 12:29:29 -0400
Received: by mail-yb1-f201.google.com with SMTP id x73so2442879ybe.8
        for <bpf@vger.kernel.org>; Fri, 07 Jun 2019 09:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=CU+Wum/bihwDTWLVJmYTACBXxoMM3npiy+H9eNDd5/8=;
        b=OmSHvnckM8/kQx4C4wGR5PBZmfcaSfKhBiGmJEUihqFB/mOT72h5s6s5Wc0wkrN1Ab
         cI6Z3+8C2BSF6Nez6xTiTKDergSOPPdBOC/T5bhHcQe+nWglkLDZ9cs+n1GyKJfBbw7t
         UypEc2mpFiB6Cs+6ixyEVwkUZgSmM6LZzYkFJ4dQHwyHT32cVO9VzHHyxoKHRZo3b/2s
         Z32ONE25zgYs15RWDwHmfYr+E+vsRbbenjU70WCfsgrQrrTZH7ExZAmEb7bg6nXqUsNz
         v3CswHipy1gwNNcPC4VSdXMhiagL8iJ/dWQ9nY/WRp2h4b8oraASVJ408HELltqXtcxA
         O/IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=CU+Wum/bihwDTWLVJmYTACBXxoMM3npiy+H9eNDd5/8=;
        b=QRQwkBJNGeUFbHHo96n5jTOos4i7FVZvdJe0XOAuUIsu4AEbpKK6+seFK6R9ko1S5A
         Gw8IZIEOzQZHl6WrGXpeNJnB85SIDplXnZuhmKPWNdUhRd3lxu3tBCoTwozf3DlbO9pj
         bycZsYKBQQrWyJsVVmJLdfgSl42mmRfU7uhfqpuXJOnTnv2NZaQpAyd3d8wdnVZbYpOY
         55PR2ZQQKU/uMnzBppVKuiN6qolx1JCyN91gPZl8F+QmvPLrjc0lYtWIXrlYbszM4l6a
         9fTtUJNPnEQAtVumDRm1aqsHnnhWeVpOvqWD5q/zqG08lPvyeMjjsMDIJ2DS1ZueLeG1
         gv9w==
X-Gm-Message-State: APjAAAVSub9bEkRc7FZV4/G89ip5pHajF5gNGfW/BEmPY4Y5fTn51KD1
        5WfO1k6uNleo2zztEkPqfbVnoDo=
X-Google-Smtp-Source: APXvYqwoc5ZaQx9NJ9FBbFgWnQg2m8XzxRJEFQmDcpdfructb3T9tzxtz8PnRxaNmyeld/NeRPkJThA=
X-Received: by 2002:a25:cf89:: with SMTP id f131mr25969629ybg.301.1559924968763;
 Fri, 07 Jun 2019 09:29:28 -0700 (PDT)
Date:   Fri,  7 Jun 2019 09:29:15 -0700
In-Reply-To: <20190607162920.24546-1-sdf@google.com>
Message-Id: <20190607162920.24546-4-sdf@google.com>
Mime-Version: 1.0
References: <20190607162920.24546-1-sdf@google.com>
X-Mailer: git-send-email 2.22.0.rc1.311.g5d7573a151-goog
Subject: [PATCH bpf-next v3 3/8] libbpf: support sockopt hooks
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     davem@davemloft.net, ast@kernel.org, daniel@iogearbox.net,
        Stanislav Fomichev <sdf@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Make libbpf aware of new sockopt hooks so it can derive prog type
and hook point from the section names.

Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 tools/lib/bpf/libbpf.c        | 5 +++++
 tools/lib/bpf/libbpf_probes.c | 1 +
 2 files changed, 6 insertions(+)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index ba89d9727137..cd3c692a8b5d 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -2243,6 +2243,7 @@ static bool bpf_prog_type__needs_kver(enum bpf_prog_type type)
 	case BPF_PROG_TYPE_RAW_TRACEPOINT_WRITABLE:
 	case BPF_PROG_TYPE_PERF_EVENT:
 	case BPF_PROG_TYPE_CGROUP_SYSCTL:
+	case BPF_PROG_TYPE_CGROUP_SOCKOPT:
 		return false;
 	case BPF_PROG_TYPE_KPROBE:
 	default:
@@ -3196,6 +3197,10 @@ static const struct {
 						BPF_CGROUP_UDP6_SENDMSG),
 	BPF_EAPROG_SEC("cgroup/sysctl",		BPF_PROG_TYPE_CGROUP_SYSCTL,
 						BPF_CGROUP_SYSCTL),
+	BPF_EAPROG_SEC("cgroup/getsockopt",	BPF_PROG_TYPE_CGROUP_SOCKOPT,
+						BPF_CGROUP_GETSOCKOPT),
+	BPF_EAPROG_SEC("cgroup/setsockopt",	BPF_PROG_TYPE_CGROUP_SOCKOPT,
+						BPF_CGROUP_SETSOCKOPT),
 };
 
 #undef BPF_PROG_SEC_IMPL
diff --git a/tools/lib/bpf/libbpf_probes.c b/tools/lib/bpf/libbpf_probes.c
index 5e2aa83f637a..7e21db11dde8 100644
--- a/tools/lib/bpf/libbpf_probes.c
+++ b/tools/lib/bpf/libbpf_probes.c
@@ -101,6 +101,7 @@ probe_load(enum bpf_prog_type prog_type, const struct bpf_insn *insns,
 	case BPF_PROG_TYPE_SK_REUSEPORT:
 	case BPF_PROG_TYPE_FLOW_DISSECTOR:
 	case BPF_PROG_TYPE_CGROUP_SYSCTL:
+	case BPF_PROG_TYPE_CGROUP_SOCKOPT:
 	default:
 		break;
 	}
-- 
2.22.0.rc1.311.g5d7573a151-goog

