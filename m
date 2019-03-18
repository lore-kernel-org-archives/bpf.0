Return-Path: <SRS0=JidB=RV=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03F4CC43381
	for <bpf@archiver.kernel.org>; Mon, 18 Mar 2019 17:18:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDA5D2133F
	for <bpf@archiver.kernel.org>; Mon, 18 Mar 2019 17:18:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dTJdgx9r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727985AbfCRRST (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 18 Mar 2019 13:18:19 -0400
Received: from mail-qk1-f202.google.com ([209.85.222.202]:39035 "EHLO
        mail-qk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727973AbfCRRSS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 18 Mar 2019 13:18:18 -0400
Received: by mail-qk1-f202.google.com with SMTP id w134so15210796qka.6
        for <bpf@vger.kernel.org>; Mon, 18 Mar 2019 10:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=MbZWy7wAoKF2UH6KYiAHojRGCKZALRbT18PDS+70hHM=;
        b=dTJdgx9rsdhWwnH1vj3NCjwrEhJg/K0jCXzsmKz7jGqUZPjqwUKpFn+JEqgSqgARw9
         GrzD9yyxUHnRskQDw06ApmJmm4CviNLtYfaeZvHjLd+qEW/xvKmpZ5tctndli+aq+QJ+
         mN64ZM999i8sOV7xSisbUkRr7FtVDWyYxMIQoLM+kZd6b4bIMr962tyM0XVMA+4Q18Qd
         lVla1m0kLDsWhi4cKBVmQI6ReqbQA7JBzC8qCDo47JiKKxjfiE4rs0YovHR0owNKBMBX
         ZJCYPGfxLUSYTCbfgcVQ0olftrEme4tvTFhAZs+XoCLg9KByJFWUuoPw+gnbDN8qzSKS
         I9pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=MbZWy7wAoKF2UH6KYiAHojRGCKZALRbT18PDS+70hHM=;
        b=ru6F0s0W5A556tbfIokASizR+UJD0Og087Ckp5MtZltoBN5hwyCH+lRZxvQUVmogWn
         Pzvb5mgoechPpG1PAcabQ4Vp4Fp8MSJgESulvKcRELyvK41YLVNAIHNKZQpa2N1BS3Ni
         x/0pYtGJLrImBD7Os6pATMZNUq37NssJxQidXtleeJ+xFyZdQDFXHVvrovqYZxrHFzmb
         w0i7q/H1ZFxdvQB0Iv5AgskaJnldQJ5XJFyF/9bv6OGzkgx0SRLqLCS16V4B1fO9Vh4+
         LLWOiM07kODtvjm7RxXmFDwoT+s32yHQ/LxQUiesnUwFXaL+2XPy5YzZ0DnFgOcbJxsv
         cVug==
X-Gm-Message-State: APjAAAUpMxpipLeaUs/b+K+MhUPhbUakFXKncPi5TdkWtBGZw0Cmkppm
        WlNr7FtREQZAx+Ukoh8fN1yctqyiAU+CA558
X-Google-Smtp-Source: APXvYqyzI2O9PCu/G52HAhDudo47fXjMCsiQUjfmsAvF2tFQ9HZJ/l6jqHwwYscpkKbnsmeTP6mnJBPbZYdiBoYi
X-Received: by 2002:ac8:821:: with SMTP id u30mr9205117qth.12.1552929496933;
 Mon, 18 Mar 2019 10:18:16 -0700 (PDT)
Date:   Mon, 18 Mar 2019 18:17:41 +0100
In-Reply-To: <cover.1552929301.git.andreyknvl@google.com>
Message-Id: <82bc7a289c6b9162c64a25b1e6f60f0318db779b.1552929301.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1552929301.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.21.0.225.g810b269d1ac-goog
Subject: [PATCH v12 09/13] kernel, arm64: untag user pointers in prctl_set_mm*
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

prctl_set_mm() and prctl_set_mm_map() use provided user pointers for vma
lookups and do some pointer comparisons to perform validation, which can
only by done with untagged pointers.

Untag user pointers in these functions for vma lookup and validity checks.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 kernel/sys.c | 44 ++++++++++++++++++++++++++++++--------------
 1 file changed, 30 insertions(+), 14 deletions(-)

diff --git a/kernel/sys.c b/kernel/sys.c
index 12df0e5434b8..fe26ccf3c9e6 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -1885,11 +1885,12 @@ static int prctl_set_mm_exe_file(struct mm_struct *mm, unsigned int fd)
  * WARNING: we don't require any capability here so be very careful
  * in what is allowed for modification from userspace.
  */
-static int validate_prctl_map(struct prctl_mm_map *prctl_map)
+static int validate_prctl_map(struct prctl_mm_map *tagged_prctl_map)
 {
 	unsigned long mmap_max_addr = TASK_SIZE;
 	struct mm_struct *mm = current->mm;
 	int error = -EINVAL, i;
+	struct prctl_mm_map prctl_map;
 
 	static const unsigned char offsets[] = {
 		offsetof(struct prctl_mm_map, start_code),
@@ -1905,12 +1906,25 @@ static int validate_prctl_map(struct prctl_mm_map *prctl_map)
 		offsetof(struct prctl_mm_map, env_end),
 	};
 
+	memcpy(&prctl_map, tagged_prctl_map, sizeof(prctl_map));
+	prctl_map.start_code	= untagged_addr(prctl_map.start_code);
+	prctl_map.end_code	= untagged_addr(prctl_map.end_code);
+	prctl_map.start_data	= untagged_addr(prctl_map.start_data);
+	prctl_map.end_data	= untagged_addr(prctl_map.end_data);
+	prctl_map.start_brk	= untagged_addr(prctl_map.start_brk);
+	prctl_map.brk		= untagged_addr(prctl_map.brk);
+	prctl_map.start_stack	= untagged_addr(prctl_map.start_stack);
+	prctl_map.arg_start	= untagged_addr(prctl_map.arg_start);
+	prctl_map.arg_end	= untagged_addr(prctl_map.arg_end);
+	prctl_map.env_start	= untagged_addr(prctl_map.env_start);
+	prctl_map.env_end	= untagged_addr(prctl_map.env_end);
+
 	/*
 	 * Make sure the members are not somewhere outside
 	 * of allowed address space.
 	 */
 	for (i = 0; i < ARRAY_SIZE(offsets); i++) {
-		u64 val = *(u64 *)((char *)prctl_map + offsets[i]);
+		u64 val = *(u64 *)((char *)&prctl_map + offsets[i]);
 
 		if ((unsigned long)val >= mmap_max_addr ||
 		    (unsigned long)val < mmap_min_addr)
@@ -1921,8 +1935,8 @@ static int validate_prctl_map(struct prctl_mm_map *prctl_map)
 	 * Make sure the pairs are ordered.
 	 */
 #define __prctl_check_order(__m1, __op, __m2)				\
-	((unsigned long)prctl_map->__m1 __op				\
-	 (unsigned long)prctl_map->__m2) ? 0 : -EINVAL
+	((unsigned long)prctl_map.__m1 __op				\
+	 (unsigned long)prctl_map.__m2) ? 0 : -EINVAL
 	error  = __prctl_check_order(start_code, <, end_code);
 	error |= __prctl_check_order(start_data, <, end_data);
 	error |= __prctl_check_order(start_brk, <=, brk);
@@ -1937,23 +1951,24 @@ static int validate_prctl_map(struct prctl_mm_map *prctl_map)
 	/*
 	 * @brk should be after @end_data in traditional maps.
 	 */
-	if (prctl_map->start_brk <= prctl_map->end_data ||
-	    prctl_map->brk <= prctl_map->end_data)
+	if (prctl_map.start_brk <= prctl_map.end_data ||
+	    prctl_map.brk <= prctl_map.end_data)
 		goto out;
 
 	/*
 	 * Neither we should allow to override limits if they set.
 	 */
-	if (check_data_rlimit(rlimit(RLIMIT_DATA), prctl_map->brk,
-			      prctl_map->start_brk, prctl_map->end_data,
-			      prctl_map->start_data))
+	if (check_data_rlimit(rlimit(RLIMIT_DATA), prctl_map.brk,
+			      prctl_map.start_brk, prctl_map.end_data,
+			      prctl_map.start_data))
 			goto out;
 
 	/*
 	 * Someone is trying to cheat the auxv vector.
 	 */
-	if (prctl_map->auxv_size) {
-		if (!prctl_map->auxv || prctl_map->auxv_size > sizeof(mm->saved_auxv))
+	if (prctl_map.auxv_size) {
+		if (!prctl_map.auxv || prctl_map.auxv_size >
+						sizeof(mm->saved_auxv))
 			goto out;
 	}
 
@@ -1962,7 +1977,7 @@ static int validate_prctl_map(struct prctl_mm_map *prctl_map)
 	 * change /proc/pid/exe link: only local sys admin should
 	 * be allowed to.
 	 */
-	if (prctl_map->exe_fd != (u32)-1) {
+	if (prctl_map.exe_fd != (u32)-1) {
 		if (!ns_capable(current_user_ns(), CAP_SYS_ADMIN))
 			goto out;
 	}
@@ -2120,13 +2135,14 @@ static int prctl_set_mm(int opt, unsigned long addr,
 	if (opt == PR_SET_MM_AUXV)
 		return prctl_set_auxv(mm, addr, arg4);
 
-	if (addr >= TASK_SIZE || addr < mmap_min_addr)
+	if (untagged_addr(addr) >= TASK_SIZE ||
+			untagged_addr(addr) < mmap_min_addr)
 		return -EINVAL;
 
 	error = -EINVAL;
 
 	down_write(&mm->mmap_sem);
-	vma = find_vma(mm, addr);
+	vma = find_vma(mm, untagged_addr(addr));
 
 	prctl_map.start_code	= mm->start_code;
 	prctl_map.end_code	= mm->end_code;
-- 
2.21.0.225.g810b269d1ac-goog

