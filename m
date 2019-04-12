Return-Path: <SRS0=9Oao=SO=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89AC1C282CE
	for <bpf@archiver.kernel.org>; Fri, 12 Apr 2019 13:29:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A90C218A3
	for <bpf@archiver.kernel.org>; Fri, 12 Apr 2019 13:29:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="LdJgXIQI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726964AbfDLN3z (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 12 Apr 2019 09:29:55 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44709 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726944AbfDLN3y (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 12 Apr 2019 09:29:54 -0400
Received: by mail-wr1-f67.google.com with SMTP id y7so11934755wrn.11
        for <bpf@vger.kernel.org>; Fri, 12 Apr 2019 06:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dBs+e9EOCCaPGeHytyBV5Ss9U2o5szbpJsDv1y8Kpww=;
        b=LdJgXIQIPjniGjXXMKd3/reBYY660pmki3E+O1WsXAqqMVYt1dybDhelHG8dOH3q/V
         uWgrkkQFaJQ7LBGnapSwBxmtlAimW4OUab1RoHgeBfoXffLSByFUoeJXqZu2g7ps0s63
         D9YPDKr3MI7LS/2fPgMGui6mFr6NbkeW0lCVoqtyKHWCcsRe+zQfxMpphSVhZw1E5uNn
         8fgrqVxr6JA6w19T0Jt4sXqOxGP55D5j5Qsy4VC0Oh45o6jR9j/5EcVnDTQuAk00eGuH
         1sZloUOelMpwTtEU6b5bw5gwKFXowy6+zasQN8eJDd6cjsV7AyXZYnJn8mclNcqOf5Sg
         Aezw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dBs+e9EOCCaPGeHytyBV5Ss9U2o5szbpJsDv1y8Kpww=;
        b=s3QseO2+AHRGWyZLrDZzYZ5wKpuOML0/gUJ1/e8zqPHQqJ1d+dVyVWnoFi99aBwF79
         ggiw79wn0yr4Ov6kmAtLraYvx3qMES5gylDe4tZei+Q2s3/ijmjkgsZ3ZTK5T/MCPfeN
         V76tbhVNZdK/8TrzYq7htLmOSeJfP+2k7zV4/V3A/COHNNBScUthXz5f3EM5aivtCzJe
         EVbla9lpM1lkacaiSw8SWD/RwUZcIwS9+2KpQyZI5lJ9DTZK09atpwI7XWGL80re43nt
         Ju3OV59lypKLJJkKoB/naa6HsBy7jceBOpLjPd8AVz7HNz/JZXYHrQtl5pfI5s08dguJ
         l2uQ==
X-Gm-Message-State: APjAAAWZkUKhOLcIhUzGg+kk8d0hFe1whd70w73xOAskEykA+eCvm7XJ
        saxGek976rmpEd8iVCi6nGgIFQ==
X-Google-Smtp-Source: APXvYqxWFY4LZ1j7U5p3lkylq5jJY+A/JBvDKvYJCk8tLsP8VgnDXrl9DlgYOzoCHUjeEyg5QpTDqg==
X-Received: by 2002:adf:fa86:: with SMTP id h6mr34526610wrr.67.1555075791958;
        Fri, 12 Apr 2019 06:29:51 -0700 (PDT)
Received: from cbtest32.netronome.com ([217.38.71.146])
        by smtp.gmail.com with ESMTPSA id v184sm15752915wma.6.2019.04.12.06.29.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Apr 2019 06:29:51 -0700 (PDT)
From:   Quentin Monnet <quentin.monnet@netronome.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        oss-drivers@netronome.com,
        Quentin Monnet <quentin.monnet@netronome.com>
Subject: [PATCH bpf-next 1/5] tools: bpftool: remove blank line after btf_id when listing programs
Date:   Fri, 12 Apr 2019 14:29:34 +0100
Message-Id: <20190412132938.9044-2-quentin.monnet@netronome.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190412132938.9044-1-quentin.monnet@netronome.com>
References: <20190412132938.9044-1-quentin.monnet@netronome.com>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Commit 569b0c77735d ("tools/bpftool: show btf id in program information")
made bpftool print an empty line after each program entry when listing
the BPF programs loaded on the system (plain output). This is especially
confusing when some programs have an associated BTF id, and others
don't. Let's remove the blank line.

Signed-off-by: Quentin Monnet <quentin.monnet@netronome.com>
Reviewed-by: Jakub Kicinski <jakub.kicinski@netronome.com>
---
 tools/bpf/bpftool/prog.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
index 81067803189e..4b7a307b9fc9 100644
--- a/tools/bpf/bpftool/prog.c
+++ b/tools/bpf/bpftool/prog.c
@@ -323,7 +323,7 @@ static void print_prog_plain(struct bpf_prog_info *info, int fd)
 	}
 
 	if (info->btf_id)
-		printf("\n\tbtf_id %d\n", info->btf_id);
+		printf("\n\tbtf_id %d", info->btf_id);
 
 	printf("\n");
 }
-- 
2.17.1

