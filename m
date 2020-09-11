Return-Path: <SRS0=Rse5=CU=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3874C43461
	for <bpf@archiver.kernel.org>; Fri, 11 Sep 2020 00:25:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80BFD2078B
	for <bpf@archiver.kernel.org>; Fri, 11 Sep 2020 00:25:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F1jxNm2P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725298AbgIKAZ6 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 10 Sep 2020 20:25:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725294AbgIKAZ5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 10 Sep 2020 20:25:57 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4B32C061573
        for <bpf@vger.kernel.org>; Thu, 10 Sep 2020 17:25:56 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id b19so10470999lji.11
        for <bpf@vger.kernel.org>; Thu, 10 Sep 2020 17:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LyC7HwfK23FPwbJFXodypHnuVv0Nu47CRBtkkOz3tHc=;
        b=F1jxNm2PkJJ2bDsduuXMCrEd8l1sy8IW89LJBCzpJKt160vxjYUrg8X/Hpzfkrt9gd
         MoshSkZVwAlHYPCyt8tofQx096A/ts2ZivAbwUIofmCkElN/mIuUt1MkDON/b2H3Ai9g
         0KKs11ax4DK634RHfOdRi1458THHJ249cBxbx3iC/Il3+8dAOz3tAkQsiuFu6UIXBfyG
         +XGKEzyBs1S93nwGPukyDYOnxykDi5MmypLYtIfPOqJ9eVh0UU3/kT8+1aug8+WHeXUi
         JF8JzZFJAjkXaMwCIc4ot1Ohb9m1aPRm2dlyEpeFU6CDcBKPOTm6SR8fP6wPPAZ6eqY4
         7qZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LyC7HwfK23FPwbJFXodypHnuVv0Nu47CRBtkkOz3tHc=;
        b=SAsSaJl99b62WopW/FVCYuiLmyCRyNW5Ooo2tOB/qVBPDVl8bnAlBOE7dvzh/fAapk
         WLV0KhqEWkzzlvR4WM/0x+xg5oaSrx5HN5AazwCYGYbkLwbziP2fBhZQZsD/8C+6sESY
         BuG5CCJ23VUD94SpxSya2yqTxIlyLkPi/DjWa87eYOqVXMpIBvFKzefsnPnawcf/ywXl
         blC3sVbN7nIs7bw84Yn2Ao6xR8DRHCxUbXqJdr70Odpi5ddZGSYO964v29Wl6czTZvb+
         eTEAJsb7eYEb8X8c5ny7y20u/tKnhyznxpie9sWR0Ol2M4zQuo7/T4rZiv8kW+qW55Ia
         kfRQ==
X-Gm-Message-State: AOAM533O7TdP8gTOatrCLZozgl+HJqr2uXmiyI+isJFvkgjWrmuYcEY7
        W9P2R7PmVVa+oocdwMIeza0HGRyHXN+GH/LEhCg=
X-Google-Smtp-Source: ABdhPJyM1ybos967q0V8khoON78NtQK7OXd2AG9RupIGtR2p0GFcpQ1TsSyeI1QnpbmGFe8biykwdyXi4n0pmZGDq0Y=
X-Received: by 2002:a05:651c:cb:: with SMTP id 11mr5873812ljr.2.1599783954743;
 Thu, 10 Sep 2020 17:25:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200909233439.3100292-1-iii@linux.ibm.com> <20200909233439.3100292-6-iii@linux.ibm.com>
In-Reply-To: <20200909233439.3100292-6-iii@linux.ibm.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 10 Sep 2020 17:25:43 -0700
Message-ID: <CAADnVQ+2RPKcftZw8d+B1UwB35cpBhpF5u3OocNh90D9pETPwg@mail.gmail.com>
Subject: Re: [PATCH RFC bpf-next 5/5] bpf: Do not include the original insn in
 zext patchlet
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Sep 9, 2020 at 4:37 PM Ilya Leoshkevich <iii@linux.ibm.com> wrote:
>
> If the original insn is a jump, then it is not subjected to branch
> adjustment, which is incorrect. As discovered by Yauheni in

I think the problem is elsewhere.
Something is wrong with zext logic.
the branch insn should not have been marked as zext_dst.
and in the line:
zext_patch[0] = insn;
this 'insn' should never be a branch.
See insn_no_def().
