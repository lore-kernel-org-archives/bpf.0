Return-Path: <bpf-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 559BEC77B73
	for <bpf@archiver.kernel.org>; Thu, 20 Apr 2023 13:51:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230246AbjDTNvI (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 20 Apr 2023 09:51:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229867AbjDTNvG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 20 Apr 2023 09:51:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BBA740D2
        for <bpf@vger.kernel.org>; Thu, 20 Apr 2023 06:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681998615;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=oIP0bCmd7XrrGCB4SWFDIts0Y0EaQGhKyG3U4x13jbE=;
        b=A5ja48iuD8ZOrrKYtmvolNwHWCVcJkw72z7eAo7wGRYFD9Vq1QUBbtmFEItF3IamLAy+WX
        1327rX8rCgbcSmG35FGh8N1sVe6rkobcoQrYJ9pBwoyNcV9aZTftOL6QomloESfBuNC2jq
        EBZppeEpleJ+47rXt/siBfelDeEtQlw=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-494-bWZXaqTiMimir7_sOM_l9w-1; Thu, 20 Apr 2023 09:50:12 -0400
X-MC-Unique: bWZXaqTiMimir7_sOM_l9w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id ECD4B3C0F42B;
        Thu, 20 Apr 2023 13:50:11 +0000 (UTC)
Received: from astarta.redhat.com (unknown [10.39.192.158])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B20D751E3;
        Thu, 20 Apr 2023 13:50:10 +0000 (UTC)
From:   Yauheni Kaliuta <ykaliuta@redhat.com>
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf@vger.kernel.org, asavkov@redhat.com, vmalik@redhat.com
Subject: sys_enter tracepoint ctx structure
Date:   Thu, 20 Apr 2023 16:50:08 +0300
Message-ID: <xunyjzy64q9b.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi!

Should perf_call_bpf_enter/exit (kernel/trace/trace_syscalls.c)
use struct trace_event_raw_sys_enter/exit instead of locally
crafted struct syscall_tp_t nowadays? test_progs's vmlinux test
expects it as the context.

Or at least use struct trace_entry instead of struct pt_regs?

I have a problem with one RT patch with extends trace_entry.

-- 
WBR,
Yauheni Kaliuta

