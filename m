Return-Path: <SRS0=GcXc=RS=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 294F9C43381
	for <bpf@archiver.kernel.org>; Fri, 15 Mar 2019 17:08:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9D5E218D3
	for <bpf@archiver.kernel.org>; Fri, 15 Mar 2019 17:08:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jzElN1GG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729679AbfCORIp (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 15 Mar 2019 13:08:45 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:43123 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729149AbfCORIp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 15 Mar 2019 13:08:45 -0400
Received: by mail-ot1-f67.google.com with SMTP id d22so7993479otk.10
        for <bpf@vger.kernel.org>; Fri, 15 Mar 2019 10:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M9IFkbGmAJ84i0U/Jfhc7CBcgkQY40J0Bl6s06s5SgM=;
        b=jzElN1GGVq0KTFksWGehR+DJWp7jLunfcYwAvknwd7Y0dHnJqHqvDZnfW3vhLIV2FW
         WV/h9Rdyf4hrBhNB9dKglnBhutzbsk79+bikpgbgqS0otDrRkwj86q67i8FCkTwRYu2f
         xN1wMtG8z5RFLalT3pfNkew1bbPbBvwxQoOCmMRSdSrY+ZzyIeIk53oopyd1+aJCHG4f
         U/emgkbLfALr8AZPy7+isVMCj3Z3EO6zlxmgQU90C/CUHy4IQTc19fbdSswiD2oFjVWK
         N7kPOVqy1xvEWaLV/t3xuH5Zw3V9insq3TJMqeIg0LKsLhwK3ABRFM9JULympNStP6U8
         kQuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M9IFkbGmAJ84i0U/Jfhc7CBcgkQY40J0Bl6s06s5SgM=;
        b=JI8FYlcOqD/SPGBIpd2r+daXurC+TZJJZAdSRyrue/WjaX3k4jADJkPeAg7/6/D8aN
         iYfSFF+ZwgUHTt9iXNTPHuFGcKJxWYxEs+089a4brCEv3Bw/qT97pBSLYmSHClMyKfZU
         9eqV4Qp7jtWsmH9QOs7kXcmM69eSd1C6AUCDqB1bIEZbhpvQS8iIekhC8Y3nz+zMSjIe
         WLsE1/6y67uUJNIQ3jmNpu2to1aAFhujweRAZ1bWxqDVCzAPa6awzrVqMsOpgGU5P41y
         FoeLhzrRSxXB47eca+Wv5JbDkwyk4BIRxph3V2TESOenFrFLVOCswqbpKZCfRkfQJwaj
         BzbQ==
X-Gm-Message-State: APjAAAU3IJlEzaBwj5e9wBU2U/uqh+dym8PyXgYosQh6Xb47SKjkE4Wn
        yhAA7GYrhZ1M0g3hshnpc99sBGROdKLUP1Fthxi3Bw==
X-Google-Smtp-Source: APXvYqxzOc0J9dHAIDCxt/6SNckqQtMRL+VoY/PcuC4Hc55OcqmwLxIjhzuuW/cKNxz7RctFyTpGvClFFRNkmv3roEI=
X-Received: by 2002:a9d:67d4:: with SMTP id c20mr2909420otn.58.1552669723985;
 Fri, 15 Mar 2019 10:08:43 -0700 (PDT)
MIME-Version: 1.0
References: <20190315002858.228416-1-posk@google.com> <20190315165153.sostcwsrzkj4luff@kafai-mbp.dhcp.thefacebook.com>
In-Reply-To: <20190315165153.sostcwsrzkj4luff@kafai-mbp.dhcp.thefacebook.com>
From:   Peter Oskolkov <posk@google.com>
Date:   Fri, 15 Mar 2019 10:08:33 -0700
Message-ID: <CAPNVh5cogyKJ7kSb8J0kOAu4G7F1++Cq4H03N9bcAKJV-z9PpQ@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf: make bpf_skb_ecn_set_ce callable from BPF_PROG_TYPE_SCHED_ACT
To:     Martin Lau <kafai@fb.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        Lawrence Brakmo <brakmo@fb.com>, Peter Oskolkov <posk@posk.io>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Mar 15, 2019 at 9:52 AM Martin Lau <kafai@fb.com> wrote:
>
> On Thu, Mar 14, 2019 at 05:28:58PM -0700, Peter Oskolkov wrote:
> > This helper is useful if a bpf tc filter sets skb->tstamp.
> >
> For the patch,
> Acked-by: Martin KaFai Lau <kafai@fb.com>
>
> Not sure if it should belong to bpf-next material though.

Thanks, Martin! I consider it a bug that the helper is not available
in TC context... ;-)
