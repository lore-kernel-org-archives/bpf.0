Return-Path: <SRS0=sRBR=SN=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFF90C10F11
	for <bpf@archiver.kernel.org>; Thu, 11 Apr 2019 03:19:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B958F2133D
	for <bpf@archiver.kernel.org>; Thu, 11 Apr 2019 03:19:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="bn5N8667"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726595AbfDKDTT (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 10 Apr 2019 23:19:19 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:46681 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726551AbfDKDTT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 10 Apr 2019 23:19:19 -0400
Received: by mail-qk1-f196.google.com with SMTP id s81so2595561qke.13
        for <bpf@vger.kernel.org>; Wed, 10 Apr 2019 20:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=Stv9amIHvPKv9p/IrjinlHjHvT9wVMW4NeoYprIzRw0=;
        b=bn5N8667U5FIH1YNWTaFM79g2bFdOsYifesrp+NiYnsOAF0K8zFKx753BiDQPCOz3P
         UPa9t/O893aCaZmsA2v6koSt4ZaoD2yYJgYHENsVhT/lXvCGhRkQVONMjZ8Mpk/5hRMC
         wiHrpuuRSoazd9SVZpwvw8zH7v5tQhwsdISKVFEXbW7Zk6eUtpOT1gOS+HYoUccLBSM0
         Hzhv0sqUbmuzGvhVXnTXvKm2FdOM1bc6Fos8ivlNOdoJAQv+ASMjZHORuflkaafqpqHf
         /UKKIsF9bDw6BOmCDDb5DpHzBdpWrzuU02ytde/bZUcfNHUOIBus5rsQBlUG8apwEAj2
         2MKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=Stv9amIHvPKv9p/IrjinlHjHvT9wVMW4NeoYprIzRw0=;
        b=oF6TYV22V8gDD3wHyvcwSgR/Kj7G8qX+X5R2Kl8LT0j9KOIaNKCrBSlfuTDWPH+MM4
         oQPJtfoG9BIWXBoSBWZIYwl99Ek6/bCr7t/jNLVoPeu9OQ3Yr9fCxjlueI/SNWBRRARM
         0WpJOdteIymOALAxP1pgGJqjbUfaJYqURMwPCnfvpRv4zIf7tr3FBHVAg8PemK0OAstr
         vKPZ2zYjlnueLZNosU/FwrWm048lezguaNeNgxteuhLg9ko6LMOMfLhicxDbd+WaVYby
         e1CvAZJV1Xe+olY3PLoUaLS6b/JX89xdTlctk+/8NycPxV8f/dG1x+wJOlNW/z94rxoH
         NKYA==
X-Gm-Message-State: APjAAAWsw19STZupeExzD3r4T1qMZXl+60Tfk6HhgwfyeplYpSZTyBFR
        s9eD60NRkc1gJyBW1ksWnG4URw==
X-Google-Smtp-Source: APXvYqxiswjoLZExCuhF8og2HEFHaEAmCqsN/0Vn6cN+1t2nGmBl0d1nAEJnx4RnSHO+sh4W+1zv+A==
X-Received: by 2002:a05:620a:132b:: with SMTP id p11mr36511784qkj.279.1554952758089;
        Wed, 10 Apr 2019 20:19:18 -0700 (PDT)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id d21sm28293074qtc.91.2019.04.10.20.19.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 10 Apr 2019 20:19:17 -0700 (PDT)
Date:   Wed, 10 Apr 2019 20:19:13 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Jiong Wang <jiong.wang@netronome.com>
Cc:     alexei.starovoitov@gmail.com, daniel@iogearbox.net,
        bpf@vger.kernel.org, netdev@vger.kernel.org,
        oss-drivers@netronome.com
Subject: Re: [PATCH/RFC v2 bpf-next 11/19] libbpf: new global variable
 "libbpf_test_mode"
Message-ID: <20190410201913.44dbf536@cakuba.netronome.com>
In-Reply-To: <1554925833-7333-12-git-send-email-jiong.wang@netronome.com>
References: <1554925833-7333-1-git-send-email-jiong.wang@netronome.com>
        <1554925833-7333-12-git-send-email-jiong.wang@netronome.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 10 Apr 2019 20:50:25 +0100, Jiong Wang wrote:
> Enable BPF_F_TEST_RND_HI32 for all existing bpf selftests or other
> independent tests could involve quite a few changes to make sure all bpf
> prog load places has BPF_F_TEST_RND_HI32 set.
> 
> Given most of the tests are using libbpf, this patch introduces a new
> global variable "libbpf_test_mode" into libbpf, once which is set, all bpf
> prog load issued through libbpf will have BPF_F_TEST_RND_HI32 set
> automatically, this could minimize changes required from testsuite.
> 
> The other way might be introducing new load function like
> "bpf_prog_test_load", which will set BPF_F_TEST_RND_HI32. But there are
> several prog load APIs, and we need minor changes on some parameters.
> 
> The global variable approach seems to be a proper first step for easy
> testsuite porting.
> 
> Signed-off-by: Jiong Wang <jiong.wang@netronome.com>

Can we perhaps make it per-object by setting it after
bpf_object__open() but before bpf_object__load(), or add 
it to struct bpf_object_open_attr?
