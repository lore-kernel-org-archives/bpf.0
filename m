Return-Path: <SRS0=cBVn=BV=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CD4BC433DF
	for <bpf@archiver.kernel.org>; Tue, 11 Aug 2020 18:14:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03C26206B2
	for <bpf@archiver.kernel.org>; Tue, 11 Aug 2020 18:14:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MJ9OXyaY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725889AbgHKSOG (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 11 Aug 2020 14:14:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbgHKSOF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 11 Aug 2020 14:14:05 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6F8EC06174A
        for <bpf@vger.kernel.org>; Tue, 11 Aug 2020 11:14:05 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id d9so10179990qvl.10
        for <bpf@vger.kernel.org>; Tue, 11 Aug 2020 11:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ijGiSh9Wmr1/sro0pf1RkDdHdjZ6SNjuoQkEgOgEweQ=;
        b=MJ9OXyaYeU+D9d77fwmB30OZUklLwdiQSbT2tBGCShmFfrs+H//CgEAVSuvY4ZHVUj
         s66/hZpVZQ2hvYxlP6zRGpOj3aJZycsCn7zcPz7tzlq9Fma0rGmyOmTX6ae/6+yaTY3J
         teqGvHRvaNHe4lh4QiSQzOthOv8m0W8YCRE52YF4G5CnsKuJvHomJSLaTGWkQOZIDJNM
         PiugnSEykoZcuiHRR+t3MPou7tFD/RfrxPysGa01HW4D8nrX666gbNJfU/Wt92DUt3kG
         OFiiEXX7V+na9SKBU5xX7UHVbvq/3AussDDyhgXshpJYYEMjo/VyuEIPhI+6n+CFSu38
         TguA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ijGiSh9Wmr1/sro0pf1RkDdHdjZ6SNjuoQkEgOgEweQ=;
        b=IXPLbcQpc/1JWtCgyAaVuTTYaAmakobM7HrdxrMAbChfRRp6VLaXrmkamcsTIoBZrN
         oLNlihWTAchMX7fjIY1UQmcGXr2BzAhjpDhmxVk7mEUObZBSJ4I9etpOmpLv5wvT8Dkv
         ft3HRw0koBIfNJUQnQOZORaH+k8XTxLqmBV2kh+niR/VRR0I/yo9hmGyGAyKsmc4nfLH
         2TqkACfk0SSqmmex9hmAub7EEzBVbVr9smwKy2+vq7EYxfIplppQXQ3p61lckEBPPtrq
         hyKAaOig4F2ASL0uAHLmGxPINhGrkh7U5/s5+moJ1kWaZG3mHMVkir4AOTEgwGuj0ok3
         1cXA==
X-Gm-Message-State: AOAM531IeevrQfJROoUKoWZ/DKph2ktlfwdiZuMcxtkA4wZ8IeLNgcL2
        lFRhaupGiW56lLXOXCOMow9LNis=
X-Google-Smtp-Source: ABdhPJyOVpxF1YNWr3W01L1nr9AI8RztJtBQKMeNubpv6bT1v7IDkHEzig3EHxuPHCp5RT0JrQPPs6g=
X-Received: by 2002:a0c:b591:: with SMTP id g17mr2704700qve.1.1597169644851;
 Tue, 11 Aug 2020 11:14:04 -0700 (PDT)
Date:   Tue, 11 Aug 2020 11:14:03 -0700
In-Reply-To: <20200722064603.3350758-4-andriin@fb.com>
Message-Id: <20200811181403.GH184844@google.com>
Mime-Version: 1.0
References: <20200722064603.3350758-1-andriin@fb.com> <20200722064603.3350758-4-andriin@fb.com>
Subject: Re: [PATCH v4 bpf-next 3/9] bpf, xdp: extract common XDP program
 attachment logic
From:   sdf@google.com
To:     Andrii Nakryiko <andriin@fb.com>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org, ast@fb.com,
        daniel@iogearbox.net, dsahern@gmail.com, andrii.nakryiko@gmail.com,
        kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 07/21, Andrii Nakryiko wrote:
> Further refactor XDP attachment code. dev_change_xdp_fd() is split into  
> two
> parts: getting bpf_progs from FDs and attachment logic, working with
> bpf_progs. This makes attachment  logic a bit more straightforward and
> prepares code for bpf_xdp_link inclusion, which will share the common  
> logic.
It looks like this patch breaks xdp tests for me:
* test_xdping.sh
* test_xdp_vlan.sh

Can you please verify on your side?

Looking at tools/testing/selftests/bpf/xdping.c I see it has:
static __u32 xdp_flags = XDP_FLAGS_UPDATE_IF_NOEXIST;

And it attaches program two times in the same net namespace,
so I don't see how it could've worked before the change :-/
(unless, of coarse, the previous code was buggy).
