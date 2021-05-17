Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9094DC433B4
	for <bpf@archiver.kernel.org>; Mon, 17 May 2021 10:11:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6189A61029
	for <bpf@archiver.kernel.org>; Mon, 17 May 2021 10:11:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236234AbhEQKMz (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 17 May 2021 06:12:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229474AbhEQKMz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 17 May 2021 06:12:55 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 022E6C061573
        for <bpf@vger.kernel.org>; Mon, 17 May 2021 03:11:38 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id z17so5738827wrq.7
        for <bpf@vger.kernel.org>; Mon, 17 May 2021 03:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hpUh4Ffbb4Fad/SsWwT8fqQl920NddgTQPB1i/rlRls=;
        b=jfPq3mGnL0/sEDDs+4gLTDSCZaaw/yHUfaRgWyzqlYqJGbmTTXv0RXSyFZQ7M2t0EE
         n8QyCmSguRu1GDxXGXWLftjEg9RDcVzDoZqn6d3nYRx8suLl2wvLVpYcvMgr+QUffyM8
         Moeyfy8puhdUfjphsd/wg+3SQCLH5ZCq7Vjhg79MccJfcB9X4rtvQJyP7CAi5w/Ugkwr
         FRZ5jMSR1othmMwvtPOsLi3y9SjtbR2oexE8aLkWKTPtkNcI54prHucFA10osePXs2qW
         ytvS9TgJH8996HjldJnhcoHI9UGJ/oSxugSpxXBPSuetA9koeiaoGZeQOm3l1aaxLZtT
         HhoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hpUh4Ffbb4Fad/SsWwT8fqQl920NddgTQPB1i/rlRls=;
        b=AFEubRRj2eXei0oKQFwlAOTxnoF7NeCn2MRacjudvqHYK0uWUPIUOmE1EnQS58PztJ
         wUL7oXvEtZjuSYA5XM4Qd7nQV33HRE3dhDVcnHMzMoScZs10kFamsIGPv07YBSjSVixN
         t59X3hL11fBxwNcmDe/f+f4tbe6HpfhCyrkxF4V2eJURFWXy6IK1ZFfM5UEXQCd1iU/r
         glA5rYf4kigywJL5N07iwkSf9KYgw0Mee+aWmLAV+0aAaakSOmx7j3GQvfGktUvw/HBX
         X+yBg7eVbTC2Ff2h0yZtcDKfZACp7scTRpXIjvm0bIfuajxW7JeCqRRLrCzCSOZdaUZg
         UupQ==
X-Gm-Message-State: AOAM532MEjVQBRqozuEwV8jX4gTxzxBw6leEecwM4IAMZ1ncktmAVnFR
        tyfIXvWlolzR+hgxccw/gTpEg2QDlRUg
X-Google-Smtp-Source: ABdhPJzsyMza4xBJwC2lt52+yipw1DFhf8O5QA+4z8toP25xO6BCCf9AbhJk2y6XQu4/DZ8tNOaxBQ==
X-Received: by 2002:adf:9c8e:: with SMTP id d14mr75224437wre.140.1621246296490;
        Mon, 17 May 2021 03:11:36 -0700 (PDT)
Received: from balnab.. ([37.17.237.224])
        by smtp.gmail.com with ESMTPSA id q12sm16993265wrx.17.2021.05.17.03.11.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 03:11:36 -0700 (PDT)
From:   Jussi Maki <joamaki@gmail.com>
To:     bpf@vger.kernel.org
Cc:     daniel@iogearbox.net, andrii.nakryiko@gmail.com
Subject: [PATCH bpf v2 0/2] bpf: Fix l3 to l2 use of bpf_skb_change_head
Date:   Mon, 17 May 2021 10:11:26 +0000
Message-Id: <20210517101128.641827-1-joamaki@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210427135550.807355-1-joamaki@gmail.com>
References: <20210427135550.807355-1-joamaki@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This fixes an issue with using bpf_skb_change_head to redirect
packet from l3 to l2 device. See commit messages for details.

v1->v2:
- Port the test case to the newly refactored prog_tests/tc_redirect.c.


