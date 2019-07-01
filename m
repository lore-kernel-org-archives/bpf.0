Return-Path: <SRS0=ay3l=U6=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48920C0650E
	for <bpf@archiver.kernel.org>; Mon,  1 Jul 2019 11:54:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13451208CA
	for <bpf@archiver.kernel.org>; Mon,  1 Jul 2019 11:54:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qRz9hdlP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728677AbfGALyR (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 1 Jul 2019 07:54:17 -0400
Received: from mail-wr1-f51.google.com ([209.85.221.51]:35550 "EHLO
        mail-wr1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728075AbfGALyR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 1 Jul 2019 07:54:17 -0400
Received: by mail-wr1-f51.google.com with SMTP id c27so5810415wrb.2
        for <bpf@vger.kernel.org>; Mon, 01 Jul 2019 04:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=4l1OoRGJHKr+MWQVNEEoY4Tjxrzxl48tKVdN29VwLY0=;
        b=qRz9hdlPoMqyZHQQvqF09N2wmlh7pAa9MaqTcojhJBXFy2vQx3qTwNlWIP6rNxxgnJ
         eOLU3akvmQN5UnRNkjrNI1mPwzNW4dJSWdezuVbfZ5UBdGRH3yJw2J1d//b61J80Go/a
         yMSW5K8zElIkKh0e706+eT0+SUbRiOS8q4y2zWs0xxReFxQbQvCzoT4WCpShfm01hrE5
         PW2PniRGZnQxspVv4K+Ud5tUiwUSs3OCNiOaqgXFjN4YNhjQGuuB4cDZIW2RNah/KOMd
         vxIEDtx3HEov4u5shZhuRJss1ubrpg6P5kZV96j4AUZ4obD+Z/lJK1ycU5v+zRmM/UXK
         thDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=4l1OoRGJHKr+MWQVNEEoY4Tjxrzxl48tKVdN29VwLY0=;
        b=IsWiXybz3upyu8OEaslCVPqvPYPtqw5F+aIdwehylkXlN4hivp8PUxzznn1Xo4xPVd
         QZ0tbQCeTpSJSUAwyKMEN+qGRMJJc2rj9jgRxD564w7IDS8kVBG2g937Ic+bziSc0RLe
         LjFgJ9mSR64L94cQmso5lNFqaB5b9MpnhF412ObESil7/F54eH2lkPHi1dmWzmWWMdeK
         8g1gWhx55qRRuosIIG4vflYAY7gfVo74A8g8sekQ7OidLqDmUsJErxbbum+L8P51CYDf
         9N4xntbbV3YwGLzB2ufmwI/NiWQoM+gxAfCInw4NDLxXWZoOe9UCbibdwRRrPi0/b9kf
         59Fg==
X-Gm-Message-State: APjAAAVjkQgkXKhIRcNKsD8HSZ5QK92fbKpvfxtOeGBGStM/zKdquBqc
        QPv567ithpvBO5reM8/uX0I=
X-Google-Smtp-Source: APXvYqyr9nafbHjUyLUebLlEjAC0ZnpkLOODa1nvfY87hI6ZAbt8b/HNS2Xog/YuHRQgTIcxV/qEzA==
X-Received: by 2002:adf:ed41:: with SMTP id u1mr17884568wro.162.1561982055094;
        Mon, 01 Jul 2019 04:54:15 -0700 (PDT)
Received: from gmail.com (net-5-95-187-49.cust.vodafonedsl.it. [5.95.187.49])
        by smtp.gmail.com with ESMTPSA id h9sm3334734wrw.85.2019.07.01.04.54.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Jul 2019 04:54:14 -0700 (PDT)
Date:   Mon, 1 Jul 2019 13:54:14 +0200
From:   Paolo Pisati <p.pisati@gmail.com>
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        bpf@vger.kernel.org
Subject: [RESEND] test_verifier #13 fails on arm64: "retval 65507 != -29"
Message-ID: <20190701115414.GA4452@harukaze>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Full failure message:

...
#13/p valid read map access into a read-only array 2 FAIL retval 65507 != -29 
verification time 14 usec
stack depth 8
processed 14 insns (limit 1000000) max_states_per_insn 0 total_states 2
peak_states 2 mark_read 1
...

this on 5.2-rc6, arm64 defconfig + CONFIG_BPF* enabled (full config here [1]).
Any idea what could be wrong?

1: http://paste.ubuntu.com/p/tXXFGCPwbp/
-- 
bye,
p.
