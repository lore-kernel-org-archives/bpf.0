Return-Path: <SRS0=JidB=RV=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2343C10F00
	for <bpf@archiver.kernel.org>; Mon, 18 Mar 2019 17:19:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74C3820863
	for <bpf@archiver.kernel.org>; Mon, 18 Mar 2019 17:19:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YkzThGw7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727883AbfCRRSG (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 18 Mar 2019 13:18:06 -0400
Received: from mail-qk1-f202.google.com ([209.85.222.202]:34873 "EHLO
        mail-qk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727868AbfCRRSF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 18 Mar 2019 13:18:05 -0400
Received: by mail-qk1-f202.google.com with SMTP id t13so15350988qkm.2
        for <bpf@vger.kernel.org>; Mon, 18 Mar 2019 10:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=LfpjTjIWpAUqgBuBr+ROlRDq3TWjVWHbA3wqyLv7Gqg=;
        b=YkzThGw7U5bxwuGivZfG7gXjy3sbFeGI9LQQNwpjKesMWYXA6dWvmlyTVIDVds3jdT
         99Hv46CfyNGepDjQmBrGdjnE8DmIFRJxBJqNXjHLIWC7+99xjXgyacIB4V4zSxrfGRS1
         gCdVGS/MQBILBUagjA0XfHFo8FDflJm4SJEr94PsmlNdR79rNuZTcqAgPDOmgM2h8uU1
         X27jM72pTPp4w4jfVrzQIbmq9wd3O59csXywpy8yafGddFfq57LOwhbAfJSUMg2BvGCJ
         ay4PGD3jH0Ph4L+WAj6gW2ezv9U1Ktw+Hx+TJhzvpdvgFTaZaxSZHrZdwWAc4E0uG5zJ
         mTGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=LfpjTjIWpAUqgBuBr+ROlRDq3TWjVWHbA3wqyLv7Gqg=;
        b=B0FXXJOs7jRzxgKrmhSjSnLDqgbHcdthSMT4xrm6An0tIHRe405K/p71N0MMP0qhrJ
         yJI7Lao7cCEa+ulN6qbykWOepZRmKlUmGlzL1ykplwY5tI6UeTbhL431LrFN/tKSmCux
         MGW3s7m3WDoK4s390szdk9RBkEv3zljpGm/382sbY9O34FHdvhwFGiPISInxTk+ZU5EO
         LvE9bYjPtW7gqSrJdIjD+0upuPQaB20lRUD8299QWewZ/96tlPGtICdgSrk0Dr58kDfU
         Sg1+O2h4GUd2xVtyMtV01Q2k5CyqjCIbCdgExeqruaGR1F5tMNEsY/Ycogg/pQ8C6trR
         KoAg==
X-Gm-Message-State: APjAAAX54licYiC8cvg0NT6l7ixmb9jzdrOVClTM503JZZZhj29NqAOP
        7queruqHrDS5qEDw5gb+vFr05du3y7IF5oKv
X-Google-Smtp-Source: APXvYqwvaFpE6Rrk389WuFNgjhFYIoDJPXDJycXik4soUJpzaOpECOFFeWGr/7DmdYgwI9v4deSBDrsPhVpuummk
X-Received: by 2002:aed:3a42:: with SMTP id n60mr10517091qte.62.1552929484433;
 Mon, 18 Mar 2019 10:18:04 -0700 (PDT)
Date:   Mon, 18 Mar 2019 18:17:37 +0100
In-Reply-To: <cover.1552929301.git.andreyknvl@google.com>
Message-Id: <f46caf7bea6bdbb7e50f2abedc83df13d075735c.1552929301.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1552929301.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.21.0.225.g810b269d1ac-goog
Subject: [PATCH v12 05/13] mm, arm64: untag user pointers in mm/gup.c
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Evgeniy Stepanov <eugenis@google.com>,
        Lee Smith <Lee.Smith@arm.com>,
        Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
        Jacob Bramley <Jacob.Bramley@arm.com>,
        Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
        Chintan Pandya <cpandya@codeaurora.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Szabolcs Nagy <Szabolcs.Nagy@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch is a part of a series that extends arm64 kernel ABI to allow to
pass tagged user pointers (with the top byte set to something else other
than 0x00) as syscall arguments.

mm/gup.c provides a kernel interface that accepts user addresses and
manipulates user pages directly (for example get_user_pages, that is used
by the futex syscall). Since a user can provided tagged addresses, we need
to handle this case.

Add untagging to gup.c functions that use user addresses for vma lookups.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 mm/gup.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/mm/gup.c b/mm/gup.c
index f84e22685aaa..3192741e0b3a 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -686,6 +686,8 @@ static long __get_user_pages(struct task_struct *tsk, struct mm_struct *mm,
 	if (!nr_pages)
 		return 0;
 
+	start = untagged_addr(start);
+
 	VM_BUG_ON(!!pages != !!(gup_flags & FOLL_GET));
 
 	/*
@@ -848,6 +850,8 @@ int fixup_user_fault(struct task_struct *tsk, struct mm_struct *mm,
 	struct vm_area_struct *vma;
 	vm_fault_t ret, major = 0;
 
+	address = untagged_addr(address);
+
 	if (unlocked)
 		fault_flags |= FAULT_FLAG_ALLOW_RETRY;
 
-- 
2.21.0.225.g810b269d1ac-goog

