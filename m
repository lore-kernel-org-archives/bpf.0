Return-Path: <SRS0=GcXc=RS=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C09FEC43381
	for <bpf@archiver.kernel.org>; Fri, 15 Mar 2019 19:54:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90367218D0
	for <bpf@archiver.kernel.org>; Fri, 15 Mar 2019 19:54:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bMyL6O7m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726404AbfCOTxx (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 15 Mar 2019 15:53:53 -0400
Received: from mail-pg1-f202.google.com ([209.85.215.202]:48948 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727269AbfCOTvv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 15 Mar 2019 15:51:51 -0400
Received: by mail-pg1-f202.google.com with SMTP id f6so11226851pgo.15
        for <bpf@vger.kernel.org>; Fri, 15 Mar 2019 12:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=HBqdcrrZbnaUQvnw2SuV9xpSHs4pKIOHqIC9BZ3VFKg=;
        b=bMyL6O7mL3v0PpvhcraOwU0+T0KPIFPV/p7nmVTvmipE51X/RVpxp6XgCeUgtieP7G
         ixioELJzjz0dEoQWCYr0YK3/FbXsJYHqdPSXpUIsBdn1yDDXj6QnCZ35FOYA8i9HT63C
         4NxOaja1Vj1CohRqNK5BDjm+Ej2ZsDeLIYnjGIPj/aDrjQ9HbzCW01i4AWSy9c6BCqBH
         VOneIHkae9V1wBY19FpITt5gyzE2kQ3GzB4IuuJ9g8/ByewueOS2EyupEZ9Fn2xI7TMs
         eSLl2rv00PucX+Qh3Q1GWwU/1iBbczPrTond0HrvoOUHVc5VY5X1umF2QYAhZzj9B3zd
         L8hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=HBqdcrrZbnaUQvnw2SuV9xpSHs4pKIOHqIC9BZ3VFKg=;
        b=qyTcWNhBD7WES8XP64Ch9+8Ux+kDeKAgH1/iTMh2JVHZLeBVlKozjujXtvGCZ9YLnO
         BaPztf28cunaz4AJVfsgbPFs1A5TNBd0niWz7AbO64hrMcaT0NWrQeYIyDCHai+Sjzo7
         ZCTXpURW1kYH/ISjRQKPc63srUVTNWsUVf8OsGR/7BGytZ4e4LHtYkbv3q5RPudUScGh
         7u3boDCI5hshUg9iwwvKX9WR+EBXB0HOe05o0k2uGNdq2UQ7JbizTxy00GIfxzhFUtg5
         BJzN/lqAjXPsdGcVZl1xWnipMm3d85F4Q0CF5r7RNEO63XTuBbV1q1QbM5VhHNJdv4DZ
         SRTQ==
X-Gm-Message-State: APjAAAUu/kveXSrZyrbQ/KvDMwqcYvqgJn0gi0HorWcBM8YO2ki5lck9
        rEKtTu7mdVV3QvTBx0rZZdiM9O0P8Nkg1GAl
X-Google-Smtp-Source: APXvYqwlT5i1jX7khcwaLfGY9H0rl+oWt5KckuYgCZmSJDPuy2OzcL+WBdRis5ZekWALtZsnFbHnM5bpC2RyyAOF
X-Received: by 2002:a65:52c5:: with SMTP id z5mr2165417pgp.71.1552679510299;
 Fri, 15 Mar 2019 12:51:50 -0700 (PDT)
Date:   Fri, 15 Mar 2019 20:51:26 +0100
In-Reply-To: <cover.1552679409.git.andreyknvl@google.com>
Message-Id: <f7b263a20223da2b8b26f6a5b0d84a575af28010.1552679409.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1552679409.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.21.0.360.g471c308f928-goog
Subject: [PATCH v11 02/14] arm64: untag user pointers in access_ok and __uaccess_mask_ptr
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

copy_from_user (and a few other similar functions) are used to copy data
from user memory into the kernel memory or vice versa. Since a user can
provided a tagged pointer to one of the syscalls that use copy_from_user,
we need to correctly handle such pointers.

Do this by untagging user pointers in access_ok and in __uaccess_mask_ptr,
before performing access validity checks.

Note, that this patch only temporarily untags the pointers to perform the
checks, but then passes them as is into the kernel internals.

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 arch/arm64/include/asm/uaccess.h | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/include/asm/uaccess.h b/arch/arm64/include/asm/uaccess.h
index e5d5f31c6d36..9164ecb5feca 100644
--- a/arch/arm64/include/asm/uaccess.h
+++ b/arch/arm64/include/asm/uaccess.h
@@ -94,7 +94,7 @@ static inline unsigned long __range_ok(const void __user *addr, unsigned long si
 	return ret;
 }
 
-#define access_ok(addr, size)	__range_ok(addr, size)
+#define access_ok(addr, size)	__range_ok(untagged_addr(addr), size)
 #define user_addr_max			get_fs
 
 #define _ASM_EXTABLE(from, to)						\
@@ -226,7 +226,8 @@ static inline void uaccess_enable_not_uao(void)
 
 /*
  * Sanitise a uaccess pointer such that it becomes NULL if above the
- * current addr_limit.
+ * current addr_limit. In case the pointer is tagged (has the top byte set),
+ * untag the pointer before checking.
  */
 #define uaccess_mask_ptr(ptr) (__typeof__(ptr))__uaccess_mask_ptr(ptr)
 static inline void __user *__uaccess_mask_ptr(const void __user *ptr)
@@ -234,10 +235,11 @@ static inline void __user *__uaccess_mask_ptr(const void __user *ptr)
 	void __user *safe_ptr;
 
 	asm volatile(
-	"	bics	xzr, %1, %2\n"
+	"	bics	xzr, %3, %2\n"
 	"	csel	%0, %1, xzr, eq\n"
 	: "=&r" (safe_ptr)
-	: "r" (ptr), "r" (current_thread_info()->addr_limit)
+	: "r" (ptr), "r" (current_thread_info()->addr_limit),
+	  "r" (untagged_addr(ptr))
 	: "cc");
 
 	csdb();
-- 
2.21.0.360.g471c308f928-goog

