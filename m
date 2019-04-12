Return-Path: <SRS0=9Oao=SO=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36EBDC282CE
	for <bpf@archiver.kernel.org>; Fri, 12 Apr 2019 23:53:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03EFE2084E
	for <bpf@archiver.kernel.org>; Fri, 12 Apr 2019 23:53:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="TzMRpWtv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726902AbfDLXx0 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 12 Apr 2019 19:53:26 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:34070 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726898AbfDLXxY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 12 Apr 2019 19:53:24 -0400
Received: by mail-qk1-f195.google.com with SMTP id n68so6739367qka.1
        for <bpf@vger.kernel.org>; Fri, 12 Apr 2019 16:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=8sOmxLmmjAUY3g336Xbrt7cJqZbf51aFYEIiJOAF5Uw=;
        b=TzMRpWtvuIlNLT0GHP/sd+0aYPUD/sejixhohFBxEbXOA4fvqAhUTsFESQZ46momWy
         tTKMGg6FTi0jnAFDRy9r9v/yiIXVepGOmAv1zSDLFOXNXto1HBE1ATx6guK4ex2PvCr3
         bY6CubQaBn8Q8yhtlYImPil9uFpXSuEPwdH5T4+ye4BwekPNnTs0Gq17AAq/WXRF78LV
         06phnLLebeCUfbvawXr5PVwhJLrjnptIU/5vZVeehjn0CXmy+9gFAwNHEXEYv/8qZafD
         3VsY1qd72HOuNRaUGBWXh/ahRWvme9DrykypLAPAaTScosNk+F6JutVtXj19QYTrqsMN
         H74w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=8sOmxLmmjAUY3g336Xbrt7cJqZbf51aFYEIiJOAF5Uw=;
        b=o7HTU521aphXW/vYyPJqYtnNo5sVdoiK/H032goerOT+qTKkwNR8YTwIF8UpyWucE2
         QTqku+sss+FdzDT4uruPVK8fEoylgiUWHR7dM9c8IHPNJtVO58Rc7ceNaWu60zNfJEH2
         LnmOxPaeqzzgDmxRFKOBAWjwX0GujQ5T2NtUWCxO6vLnN/BUQpM90Xx0R4xxoTE5ilMx
         tq7ItQKfuMzyzz8/Rtu5VHo4vxnd8g1Gqy2FucR+UobVuju9oLsQAjsS6soSLpDr/A2O
         Er7SFYsi7ve+WASsDa1ewIa2WSEA3qLB0h84f3F0+oa9Tz8Xv2wv5ggdg/gBv571xhCu
         xlFg==
X-Gm-Message-State: APjAAAXkOfETWBoXthvyDwMiuhEf1yhZ5fDO5Xt1Dtl0HPsjdSFVmNwU
        yvFhzYyX6K2ZTes9Ik5p5eWm2g==
X-Google-Smtp-Source: APXvYqxg/Ira5McPX/mUPcK5qGiruf5WZoyEjXBF9/8i2tvudkoEW0UGvqnmFAilDVhkzt2e5oyUiA==
X-Received: by 2002:a05:620a:1490:: with SMTP id w16mr46547899qkj.26.1555113203435;
        Fri, 12 Apr 2019 16:53:23 -0700 (PDT)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id m93sm26403624qte.74.2019.04.12.16.53.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Apr 2019 16:53:23 -0700 (PDT)
Date:   Fri, 12 Apr 2019 16:53:18 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Benjamin Poirier <bpoirier@suse.com>
Cc:     Quentin Monnet <quentin.monnet@netronome.com>,
        Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, David Ahern <dsahern@gmail.com>
Subject: Re: [PATCH v2 bpf-next 1/2] bpftool: Use print_entry_error() in
 case of ENOENT when dumping
Message-ID: <20190412165301.1c4b7390@cakuba.netronome.com>
In-Reply-To: <20190412224924.GA21826@f1>
References: <20190411082700.26888-1-bpoirier@suse.com>
        <20190412030322.15494-1-bpoirier@suse.com>
        <44958814-3145-717f-366e-ecc52f2145b9@netronome.com>
        <20190412224924.GA21826@f1>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, 13 Apr 2019 07:49:24 +0900, Benjamin Poirier wrote:
> To be honest, I don't think the formatting in those print_entry_*
> functions should change according to the length in any case. I think the
> key and value for each entry should always be on the same line for ease
> of grepping. A followup patch maybe...

No, no, please never grep bpftool output.  We have JSON output,
please use JQ: http://manpages.ubuntu.com/manpages/bionic/man1/jq.1.html
