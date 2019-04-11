Return-Path: <SRS0=sRBR=SN=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25D91C10F11
	for <bpf@archiver.kernel.org>; Thu, 11 Apr 2019 02:39:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D81382133D
	for <bpf@archiver.kernel.org>; Thu, 11 Apr 2019 02:39:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="NR6qXsvi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbfDKCjt (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 10 Apr 2019 22:39:49 -0400
Received: from mail-qt1-f172.google.com ([209.85.160.172]:39134 "EHLO
        mail-qt1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726536AbfDKCjt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 10 Apr 2019 22:39:49 -0400
Received: by mail-qt1-f172.google.com with SMTP id t28so5407471qte.6
        for <bpf@vger.kernel.org>; Wed, 10 Apr 2019 19:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=0fz+K3R0tAzzdSY1oKWuvWSeTOonhZrLvLq4ZlSWLto=;
        b=NR6qXsvi0GdGHV2Q8PZZ/4t+L5wk+JWykpDAfndaC7XyNpVjhGiq9SQDpgLG0FgAFT
         z+IYaxkZ6YmpPsrXmxeqmDarK8dDOe24ld6CWrOHsHhujubGvxJ2fIFF1JJULxNDYnXQ
         PESSckraaKB76zKUsCa4hQuW3+PgcwXoH+syb69LouXxBqUCh0ksQsq91incUE5p1iJw
         7ezCSYcIp+VbAuMCEfHCVNbIdashtA+mPpw9HzBH2uf+pvQh7Proe9w4T0XUsH4I+SjG
         oyvtT4tKCjDoRZ7Bntk7woRJCPgxyw3l8eOR5zCWHv05vIdQdAoj4OiFup03ROxm/Xhp
         bPfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=0fz+K3R0tAzzdSY1oKWuvWSeTOonhZrLvLq4ZlSWLto=;
        b=PWE3UabGvB00/MVe5T30Sgr8CyrhLG+yv1MkfQ8Xyw8J71yCrdKZUyWkrPWoY0oCqu
         22oWDyK8VDp8MbnJMTCy3FVs9xTTAe/pxEhPJkRdqssAjVco35dvKiayTLCMOjy68rzf
         XtV2BWraDrGTf0Qwf8FnRq3Dg34eZSsMCVUmM3giRxjm5Hcop1CWX0qd2qCeplb6oMfn
         uhV5VKbzxXEI2mBX6dFpOfLWIbz5MrwxfRWKgDFdC3HDzcll2wEU6Y51f1rOEkPAfXJB
         IjeGDF6bOfbx/XFzZysUhUnmcH4O5pyvT/Hs4/YmD9XnEcnUOl8UHrsgttvrBg8sAv9i
         Cy8g==
X-Gm-Message-State: APjAAAUxjRpbH0NSWnFYHionloNylhYw3uupl29bBta76zmEc9z1rJRb
        j9PrlkkjJdTYmaGOLGeHCm2law==
X-Google-Smtp-Source: APXvYqyMH6NKoCbnKG8CIJBVUgJ8aJEWS/tIr6iXwcvJ2q40IPjGES5RvJl8kcL4w7mhlIqOE7TLGw==
X-Received: by 2002:a0c:9945:: with SMTP id i5mr37569220qvd.159.1554950388594;
        Wed, 10 Apr 2019 19:39:48 -0700 (PDT)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id e18sm5315749qki.82.2019.04.10.19.39.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 10 Apr 2019 19:39:48 -0700 (PDT)
Date:   Wed, 10 Apr 2019 19:39:43 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Jiong Wang <jiong.wang@netronome.com>
Cc:     alexei.starovoitov@gmail.com, daniel@iogearbox.net,
        bpf@vger.kernel.org, netdev@vger.kernel.org,
        oss-drivers@netronome.com
Subject: Re: [oss-drivers] [PATCH/RFC v2 bpf-next 03/19] bpf: factor out reg
 and stack slot propagation into "propagate_liveness_reg"
Message-ID: <20190410193943.24fbd383@cakuba.netronome.com>
In-Reply-To: <1554925833-7333-4-git-send-email-jiong.wang@netronome.com>
References: <1554925833-7333-1-git-send-email-jiong.wang@netronome.com>
        <1554925833-7333-4-git-send-email-jiong.wang@netronome.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 10 Apr 2019 20:50:17 +0100, Jiong Wang wrote:
> After code refactor in previous patches, the propagation logic inside the
> for loop in "propagate_liveness" becomes clear that they are good enough to
> be factored out into a common function "propagate_liveness_reg".
> 
> Signed-off-by: Jiong Wang <jiong.wang@netronome.com>

Reviewed-by: Jakub Kicinski <jakub.kicinski@netronome.com>
