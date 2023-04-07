Return-Path: <bpf-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32862C77B6C
	for <bpf@archiver.kernel.org>; Fri,  7 Apr 2023 00:18:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237914AbjDGAS2 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 6 Apr 2023 20:18:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233559AbjDGAS1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 6 Apr 2023 20:18:27 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A826C5272
        for <bpf@vger.kernel.org>; Thu,  6 Apr 2023 17:18:25 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id v67-20020a254846000000b00b8189f73e94so20248238yba.12
        for <bpf@vger.kernel.org>; Thu, 06 Apr 2023 17:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680826705; x=1683418705;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3z+/NV0dPqokddCY1NlsxXvpM1kRG3zeyORz1bdClYA=;
        b=Ie+PkEdZ8NlP4tCL2e6yryjW43O3XlBR/u9iiXFJbrMgcpOc3IYxzbK4XarLY/c800
         EXG+bqUm99QO6vRxqGGm6L0NFj0Pw4CjBYbEzTau0rzhcOGvAgnM9Uo5IfqMZnQS7rm1
         keHAfSFEnykWagzbkDK1KJhuzdPGEQbG36JE6SsUX1oZF2k7fIXPYJx1wg0LP2dYC+0n
         qNK1r8WguwjJ3Et1uGsyLEP3V6c6ipuIZlxizPlgqJIKZVmfhCH7l3Xg7bHM+ZptjsfE
         f+OGQyLSDyReUxbTJGma+JqRqXVN3DAhfOeHehKH+lrI1JZJ1gBCq6eHAK0XqL+3LQw1
         yLrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680826705; x=1683418705;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3z+/NV0dPqokddCY1NlsxXvpM1kRG3zeyORz1bdClYA=;
        b=ZLo4e2p+ukY2mEJ7ZFJU6QpcipAQSbMmVn8QCaRH3AK8gpYP9xlEdUpNMHUZ4IbNHY
         dk2HYSfqxUIoZGtgUOsczmy4H0qSnEi/7w6F1UL5xcabSzOoGk/ayilj4Ppi9gBLDhK2
         QCJAQkPuknfS4CSkZVxHjYxzY0+shAjUpPqc1VpSoDdVTGQSJHvO3Uvi5Jy+gGMYAZ6M
         wy9ERDZYEhiKTKFCkMfMM1D4L48Nva3xjWcsn4fgYt4kTpG9TDBvtXxwKAgsa/UK9DGK
         0eOadeuGCahRT/hrjbYi6z69JRs9FKNwbJC/EslQlo+cMFxBK34lnGgPcxfO93efvGc7
         gLZA==
X-Gm-Message-State: AAQBX9eIxpXGxB61ecNYPVUq4jVErZ09XKR4y0GnwLyZ7g03S4Cx+7LD
        HZC6x0OiHoEUAqyQopECWi+fjaKo
X-Google-Smtp-Source: AKy350YirQjSwlcK32mrO8lnWvk2qTJsYhBwSukQ/GdXrsixXKlrQORwIQb2OB7EAa5VenlcolW2BFg+
X-Received: from gnomeregan.cam.corp.google.com ([2620:15c:93:4:5600:3a73:ddd5:3f6f])
 (user=brho job=sendgmr) by 2002:a25:7716:0:b0:b6a:2590:6c63 with SMTP id
 s22-20020a257716000000b00b6a25906c63mr214401ybc.2.1680826704897; Thu, 06 Apr
 2023 17:18:24 -0700 (PDT)
Date:   Thu,  6 Apr 2023 20:18:08 -0400
In-Reply-To: <20230405225246.1327344-1-brho@google.com>
Mime-Version: 1.0
References: <20230405225246.1327344-1-brho@google.com>
X-Mailer: git-send-email 2.40.0.577.gac1e443424-goog
Message-ID: <20230407001808.1622968-1-brho@google.com>
Subject: [PATCH bpf-next] bpf: ensure all memory is initialized in bpf_get_current_comm
From:   Barret Rhoden <brho@google.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

BPF helpers that take an ARG_PTR_TO_UNINIT_MEM must ensure that all of
the memory is set, including beyond the end of the string.

Signed-off-by: Barret Rhoden <brho@google.com>
---
 kernel/bpf/helpers.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 6be16db9f188..b6a5cda5bb59 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -258,7 +258,7 @@ BPF_CALL_2(bpf_get_current_comm, char *, buf, u32, size)
 		goto err_clear;
 
 	/* Verifier guarantees that size > 0 */
-	strscpy(buf, task->comm, size);
+	strscpy_pad(buf, task->comm, size);
 	return 0;
 err_clear:
 	memset(buf, 0, size);
-- 
2.40.0.577.gac1e443424-goog

