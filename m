Return-Path: <SRS0=k+HZ=YH=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 150E5ECE587
	for <bpf@archiver.kernel.org>; Mon, 14 Oct 2019 16:53:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD7E82067B
	for <bpf@archiver.kernel.org>; Mon, 14 Oct 2019 16:53:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d9HDmOCZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730192AbfJNQxc (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 14 Oct 2019 12:53:32 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:39380 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727083AbfJNQxc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 14 Oct 2019 12:53:32 -0400
Received: by mail-io1-f68.google.com with SMTP id a1so39422703ioc.6
        for <bpf@vger.kernel.org>; Mon, 14 Oct 2019 09:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=yPcvNHM4b1vjARt8oTsLoZYUU7lqXZfnGSi8YIZjqRI=;
        b=d9HDmOCZkiHdRSpgEwGizIBP0+W0/ajYyt5MIbglx7NgBlU8PtW0N7f59Sxxm1iISP
         wlsV0fytwOD0g9ysiByWaqGs0nkPmpMDT/wmMx4FdV6xTJdihEQW/enLo+ld6koVG0e8
         yz9am3GJO0UB9l/VNbps3+uErd5w3U1X0pIFI0dFGxIFxOxBIo03xbOJHcFYHOsUBufn
         5t1OrTPxXdth2p0MY99FyeJ6pFD7rMIRd0ZKZ8D6dNPUu2xQsI1SKhv6oBiFkxyPCki9
         W0l0/drjBnzynywaKujmSYrK/oZPDepuKKhOdid3wbzdSpvF/4uuDC8S0O31OQwA5ULO
         69TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=yPcvNHM4b1vjARt8oTsLoZYUU7lqXZfnGSi8YIZjqRI=;
        b=evF0aHWPjHRaQEXKb2fp90TsEU/bao2wrIiS3oCubqaIcvg93n/5nxjDACK4OuIQid
         WmxFaoGDV3S4PhubEPk0/nn15QMSUOe2PowD88zYxTdnwXV6liBMrgiW6T7bGGNJ0CRF
         MPgjpMDIadAeB6rHJd94wQ+dok6em3w9kiCsC+Ke6JjaHSatWC5lBObtVXID8d8NzgfE
         c6ieXT3H210hc7z6wM0/h9cnSSFelXnmlc3fPJAl2SUnpab5EIch3LjUU7G/Cj3PNP2z
         2OQIWTvc/VfnTP9sMYjVe39cmsnPT3QrCqpH+zRvYwzp7fYO+RcvEM7vlNEkOUhpIh+I
         KChw==
X-Gm-Message-State: APjAAAXecyR2cBNaVX9ADUjm4ppvcuwKxw4BhjYIomfd6/OIrxsN8hTm
        Blfglfz/bzV0YtHmEH7U+fk=
X-Google-Smtp-Source: APXvYqwCOpfxzWPSo6GYh1dNYmPn9hgJh31JS3nZOAv+QPR/h1vmAPgshQ/505qSHQYfDjvI+CBtTw==
X-Received: by 2002:a92:5a9b:: with SMTP id b27mr1435682ilg.180.1571072011579;
        Mon, 14 Oct 2019 09:53:31 -0700 (PDT)
Received: from localhost ([184.63.162.180])
        by smtp.gmail.com with ESMTPSA id z5sm13455991ioh.23.2019.10.14.09.53.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2019 09:53:30 -0700 (PDT)
Date:   Mon, 14 Oct 2019 09:53:23 -0700
From:   John Fastabend <john.fastabend@gmail.com>
To:     Martin Lau <kafai@fb.com>,
        John Fastabend <john.fastabend@gmail.com>
Cc:     "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>
Message-ID: <5da4a803b249b_25f42addb7c085b827@john-XPS-13-9370.notmuch>
In-Reply-To: <20191014164623.wp4dpi5nghji25ot@kafai-mbp.dhcp.thefacebook.com>
References: <20191014121330.GA14089@mwanda>
 <20191014164623.wp4dpi5nghji25ot@kafai-mbp.dhcp.thefacebook.com>
Subject: Re: [bug report] bpf, sockmap: convert to generic sk_msg interface
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Martin Lau wrote:
> On Mon, Oct 14, 2019 at 03:13:30PM +0300, Dan Carpenter wrote:
> > Hello Daniel Borkmann,
> > 
> > This is a semi-automatic email about new static checker warnings.
> > 
> > The patch 604326b41a6f: "bpf, sockmap: convert to generic sk_msg
> > interface" from Oct 13, 2018, leads to the following Smatch complaint:
> > 
> >     net/core/skmsg.c:792 sk_psock_write_space()
> >     error: we previously assumed 'psock' could be null (see line 790)
> > 
> > net/core/skmsg.c
> >    789		psock = sk_psock(sk);
> >    790		if (likely(psock && sk_psock_test_state(psock, SK_PSOCK_TX_ENABLED)))
> >                            ^^^^^
> > Check for NULL
> > 
> >    791			schedule_work(&psock->work);
> >    792		write_space = psock->saved_write_space;
> >                               ^^^^^^^^^^^^^^^^^^^^^^^^
> > 
> >    793		rcu_read_unlock();
> >    794		write_space(sk);
> >                 ^^^^^^^^^^^^^^
> > The warning is on the wrong line.  The dereference is really here.
> > 
> > regards,
> > dan carpenter
> John, can you also take a look?

Thanks Dan, seems there is a chance we could have a null psock here
so we need to wrap both dereferences in the 'if (psock)'. I'll send
a patch.
