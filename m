Return-Path: <SRS0=ACyN=SY=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A62AC10F11
	for <bpf@archiver.kernel.org>; Mon, 22 Apr 2019 15:56:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AB5520881
	for <bpf@archiver.kernel.org>; Mon, 22 Apr 2019 15:56:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aaXmj3kS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728067AbfDVP4R (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 22 Apr 2019 11:56:17 -0400
Received: from mail-qt1-f202.google.com ([209.85.160.202]:45694 "EHLO
        mail-qt1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728053AbfDVP4Q (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 22 Apr 2019 11:56:16 -0400
Received: by mail-qt1-f202.google.com with SMTP id n1so11995734qte.12
        for <bpf@vger.kernel.org>; Mon, 22 Apr 2019 08:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=CTIFoZD1NpSBhLZTX7ZFgMBi6RqUbXh0M8HABmMEVRk=;
        b=aaXmj3kSzBlOU9AuIRFbqiA/pUfFMpKLgobnYfD4mbiHYab4Za/EqmgNWonztNImZL
         X9/nltDapnpgtI0TVk/UJHYwur+6cIY7BrBu57xU1ktkFAwkMERoIZ7xui/msIAy7TCL
         ptG9/E6X6AQOmNPwLJkqzSZCkjQ3Jwp5MWgzTJHweIakD4W82aQFuY7xxnvSBxHR1ydU
         HXbl2leaEXVvbVqNM6zdePev4kqjPfRU9fXZV/2+bjHnqw+gwnTgH9VSsJemSikYECmQ
         yz1m1XOHAQHE6smwyYCa82aihTHkn/wCBolMl5PTx44aQ3dKMc8Yy1oIjGRuztpar+Ch
         4cYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=CTIFoZD1NpSBhLZTX7ZFgMBi6RqUbXh0M8HABmMEVRk=;
        b=ix351l6nSuPiDEev8CkhGvMhLUR6W5MeN67cLR6teViAMVqr/qdnD0va47KLHjRzWs
         mDlEqvlQI0t0QQJZnSHhLdM+s9P0kd5RLIQKEX9V3AOg2puXWKl6lMnZEyhERWlvvSHD
         1fWhxG85o5QGyHJdWWmU8u2GuPInQcUHHru70qF0QixPNoVsGwirutxwV6bVMPZo+cPw
         KF08dK2kanawpzmAie1zCfaq1PKjgejWBnrme0oSFneYJJYw6/dhAa837coW7t9pfL+j
         8mwyoC1ILfJxOKqZXcdjqzm7Zl7/v4kZemlykk0wDr2hIlozcwkY3n9odUOO9LfyrZB8
         ldqg==
X-Gm-Message-State: APjAAAWlkmHTtz64LHfMCMxCN39VfIgRdkVF7qNLD7ErNKEPzgscqLNy
        WsrXlGJVU6/cisG5ec5gTOkhoS0=
X-Google-Smtp-Source: APXvYqwCgr3LiQhooxyScLA8eG5E/VTPp+79szVOQACdoY/+CV5o2/uKx1u8cH7h5E9BwHd4pm76Qiw=
X-Received: by 2002:ac8:170d:: with SMTP id w13mr15886237qtj.220.1555948575727;
 Mon, 22 Apr 2019 08:56:15 -0700 (PDT)
Date:   Mon, 22 Apr 2019 08:55:51 -0700
In-Reply-To: <20190422155552.222910-1-sdf@google.com>
Message-Id: <20190422155552.222910-9-sdf@google.com>
Mime-Version: 1.0
References: <20190422155552.222910-1-sdf@google.com>
X-Mailer: git-send-email 2.21.0.593.g511ec345e18-goog
Subject: [PATCH bpf-next v6 8/9] selftests/bpf: properly return error from bpf_flow_load
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     davem@davemloft.net, ast@kernel.org, daniel@iogearbox.net,
        simon.horman@netronome.com, willemb@google.com,
        peterpenkov96@gmail.com, Stanislav Fomichev <sdf@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Right now we incorrectly return 'ret' which is always zero at that
point.

Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 tools/testing/selftests/bpf/flow_dissector_load.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/flow_dissector_load.h b/tools/testing/selftests/bpf/flow_dissector_load.h
index eeb48b6fc827..daeaeb518894 100644
--- a/tools/testing/selftests/bpf/flow_dissector_load.h
+++ b/tools/testing/selftests/bpf/flow_dissector_load.h
@@ -25,19 +25,19 @@ static inline int bpf_flow_load(struct bpf_object **obj,
 
 	main_prog = bpf_object__find_program_by_title(*obj, section_name);
 	if (!main_prog)
-		return ret;
+		return -1;
 
 	*prog_fd = bpf_program__fd(main_prog);
 	if (*prog_fd < 0)
-		return ret;
+		return -1;
 
 	prog_array = bpf_object__find_map_by_name(*obj, map_name);
 	if (!prog_array)
-		return ret;
+		return -1;
 
 	prog_array_fd = bpf_map__fd(prog_array);
 	if (prog_array_fd < 0)
-		return ret;
+		return -1;
 
 	if (keys_map_name && keys_fd) {
 		keys = bpf_object__find_map_by_name(*obj, keys_map_name);
-- 
2.21.0.593.g511ec345e18-goog

