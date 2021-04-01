Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46954C433B4
	for <bpf@archiver.kernel.org>; Thu,  1 Apr 2021 23:33:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2617661105
	for <bpf@archiver.kernel.org>; Thu,  1 Apr 2021 23:33:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236441AbhDAXdc (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 1 Apr 2021 19:33:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236378AbhDAXdJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 1 Apr 2021 19:33:09 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BA3FC061788
        for <bpf@vger.kernel.org>; Thu,  1 Apr 2021 16:32:42 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id c20so4067943qtw.9
        for <bpf@vger.kernel.org>; Thu, 01 Apr 2021 16:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=h2cUBfrxKiLvUm4K3FiEqQsW7/CwbTTOloFCTdH2CHs=;
        b=WwXYJEUtzPp5OgieXNSDH1jlEl5JZ0W/R7AL0K533fvUhOWdAZ9AGUs2eGGOPAXoOV
         9ozbSMsvBM3fx5D5LtP6Wwj5vTRMKtVGliPsMJFstImK8hWqbNvneO11EFMHlgjN9j8E
         Gxgb+CYWv9/NMpO603YX/M1xglU8wTRB2je50aC09bt/Q+N13fSJMOHOutVU+FJW8VRH
         buFVQ6JhTKnPP9sHJSvuwhCmHBM3KlHMmvtXp8wtpQYRTn/+3gN0dNfz6qElxu5IW19P
         6wyJ5fhugbFhtzg1oHjkOAL/OAUuMNDm5YMcIesJpyOU9dDyMEApglZuAgeX/R91ZsV9
         QlzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=h2cUBfrxKiLvUm4K3FiEqQsW7/CwbTTOloFCTdH2CHs=;
        b=D26QjauANq1QGYKBwsUWPwkfvj4hs4mxaSoWJb7wfjZN9ppnofiAjLQlAFvd+t/vS9
         57L76P+VqahSJIfNy3f3GTxeO55Bs8ceNrq0uwNqnkLQBifdhMNVcYZB7nzgndi9uE1E
         SdNpx9uf5SWSzicY62lumWi+wrt4oCLeHS1K/jF7R76F+2gnte8vLqxChM1yeFUD9V7B
         smzkrYY61PqOxALyXWIgEIfKnVEaaK7STwXKP8SjdH6ddsulBA5CrVdVtnlWD7/sZSf8
         JoKGoBb3QaS/YSMJhWOrkqyh9W8pT00Rl0PlSfjcdV5T0kXnkvLSnmaQ76Wam4VLRpLD
         U2rQ==
X-Gm-Message-State: AOAM532inUgwsGdBZNJQcHJCgzUrecM45mLvMuovgwMthG3UJnrfV1i5
        qyaBdRpsqNFb8QE0ZjwoJ/gkUw62ep9mTt/huCo=
X-Google-Smtp-Source: ABdhPJziT3D45uCf3xMud/lYL8zWHTujTbizJ/biGPptb9CAf5S2oQq2ohDlzAjndytnNYlfJC1g6e8VKQiUGTMfQg8=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:4cd1:da86:e91b:70b4])
 (user=samitolvanen job=sendgmr) by 2002:a0c:eb87:: with SMTP id
 x7mr10859482qvo.14.1617319961673; Thu, 01 Apr 2021 16:32:41 -0700 (PDT)
Date:   Thu,  1 Apr 2021 16:32:09 -0700
In-Reply-To: <20210401233216.2540591-1-samitolvanen@google.com>
Message-Id: <20210401233216.2540591-12-samitolvanen@google.com>
Mime-Version: 1.0
References: <20210401233216.2540591-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.31.0.208.g409f899ff0-goog
Subject: [PATCH v5 11/18] psci: use function_nocfi for cpu_resume
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>, Jessica Yu <jeyu@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Tejun Heo <tj@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>, bpf@vger.kernel.org,
        linux-hardening@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

With CONFIG_CFI_CLANG, the compiler replaces function pointers with
jump table addresses, which results in __pa_symbol returning the
physical address of the jump table entry. As the jump table contains
an immediate jump to an EL1 virtual address, this typically won't
work as intended. Use function_nocfi to get the actual address of
cpu_resume.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 drivers/firmware/psci/psci.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
index f5fc429cae3f..64344e84bd63 100644
--- a/drivers/firmware/psci/psci.c
+++ b/drivers/firmware/psci/psci.c
@@ -325,8 +325,9 @@ static int __init psci_features(u32 psci_func_id)
 static int psci_suspend_finisher(unsigned long state)
 {
 	u32 power_state = state;
+	phys_addr_t pa_cpu_resume = __pa_symbol(function_nocfi(cpu_resume));
 
-	return psci_ops.cpu_suspend(power_state, __pa_symbol(cpu_resume));
+	return psci_ops.cpu_suspend(power_state, pa_cpu_resume);
 }
 
 int psci_cpu_suspend_enter(u32 state)
@@ -344,8 +345,10 @@ int psci_cpu_suspend_enter(u32 state)
 
 static int psci_system_suspend(unsigned long unused)
 {
+	phys_addr_t pa_cpu_resume = __pa_symbol(function_nocfi(cpu_resume));
+
 	return invoke_psci_fn(PSCI_FN_NATIVE(1_0, SYSTEM_SUSPEND),
-			      __pa_symbol(cpu_resume), 0, 0);
+			      pa_cpu_resume, 0, 0);
 }
 
 static int psci_system_suspend_enter(suspend_state_t state)
-- 
2.31.0.208.g409f899ff0-goog

