Return-Path: <SRS0=1cax=SP=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D195AC10F0E
	for <bpf@archiver.kernel.org>; Sat, 13 Apr 2019 01:42:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9128420869
	for <bpf@archiver.kernel.org>; Sat, 13 Apr 2019 01:42:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="r6TyItrC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726963AbfDMBmk (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 12 Apr 2019 21:42:40 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:40232 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726902AbfDMBmj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 12 Apr 2019 21:42:39 -0400
Received: by mail-qk1-f193.google.com with SMTP id w20so6814764qka.7
        for <bpf@vger.kernel.org>; Fri, 12 Apr 2019 18:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=/f+vyUN2ZQGeou4KMz/lqq9tOX4S4TlztZSwgnmKNZc=;
        b=r6TyItrCwKgsQcjXw5hyiUB/OkG7sPIOw1NM5C240xCSd+Lgfh71CvLfOVFL/pOzg0
         BsK6H9FSM+WUo9b3/bFhwfcQLyrNQh9i9Rl9uzI7AFZViko8I/KxhjaTFKkd7Nteu/bZ
         Wq0ct/wANRWk+JTWrPutH6CLCRdZroKA48veOjOPVAIS1z9oIl/Vp8UQhuLtyhr8g/ZQ
         mx+3K36LPRvVgGiQGdNs7Oknh9ehAEnQDP2xmaN9lt4AzIyxNyXS/BBw5gE9373fMSCE
         p/y7qXheGsNYTX7dFUCXJ3nHZMxZYgT+4Hf3/LP4XzAQlH6cTfAOzlocxIvy29weIEcP
         UN9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=/f+vyUN2ZQGeou4KMz/lqq9tOX4S4TlztZSwgnmKNZc=;
        b=ODqv/dX/RLSpUvrrKM50gKZY6nbjW/h/cA3F0Nptj5CbqcnWQ0kRDPg6zigQr8vH6m
         AYp+biKxJq7XSZXbRD5Y3sbKuB++O5p25uqqv8r8D3CMwguYq6h8bn/eNY6D2zA/QWzZ
         US1eKrGUHOwwrQOVxT/vbO6/elt2qouDO39X8lGQ9h3PwkbCqflqh+FrGhi4zorNAp/j
         ZX8wkdRXFgq6JkhIbAuFFFxBI1fXu7zTJCmSF1fVNV4yTA9cbVDpHI2NhRbad0CisYsG
         Yd90eq6w4k5I9rR5tPriffDe67LKb859HZ5GVuNciaLlvg6cFYS52VRRginirUybzadI
         hIZg==
X-Gm-Message-State: APjAAAUYdm0sp+nLL0bzYywoKE4Q+22i14zsKJu7Yl7cK75ktDaFVgdL
        mC8Lw72HbmqQXz+8wO0G4UXIcg==
X-Google-Smtp-Source: APXvYqz+BRt/VQYxC0FrA1cEZxHEfS1gWSyivLFgmLA4h4kKd/futu3XRf5gXNsXiEcoUbtQd30NgQ==
X-Received: by 2002:ae9:e413:: with SMTP id q19mr46728227qkc.324.1555119758991;
        Fri, 12 Apr 2019 18:42:38 -0700 (PDT)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id n184sm21867797qke.29.2019.04.12.18.42.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Apr 2019 18:42:38 -0700 (PDT)
Date:   Fri, 12 Apr 2019 18:42:35 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Matteo Croce <mcroce@redhat.com>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: Re: [PATCH bpf] libbpf: add binary to gitignore
Message-ID: <20190412184235.5fd2d650@cakuba.netronome.com>
In-Reply-To: <20190413013732.18432-1-mcroce@redhat.com>
References: <20190413013732.18432-1-mcroce@redhat.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, 13 Apr 2019 03:37:32 +0200, Matteo Croce wrote:
> Some binaries are generated when building libbpf from tools/lib/bpf/,
> namely libbpf.so.0.0.2 and libbpf.so.0.
> Add them to the local .gitignore.
> 
> Signed-off-by: Matteo Croce <mcroce@redhat.com>

Reviewed-by: Jakub Kicinski <jakub.kicinski@netronome.com>

Thanks!
