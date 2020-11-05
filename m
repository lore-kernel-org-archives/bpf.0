Return-Path: <SRS0=NbGg=EL=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F241C00A89
	for <bpf@archiver.kernel.org>; Thu,  5 Nov 2020 09:00:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC54D206C0
	for <bpf@archiver.kernel.org>; Thu,  5 Nov 2020 09:00:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729977AbgKEJAG convert rfc822-to-8bit (ORCPT
        <rfc822;bpf@archiver.kernel.org>); Thu, 5 Nov 2020 04:00:06 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:43950 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725827AbgKEJAG (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 5 Nov 2020 04:00:06 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-231-8UX6HNYcNJS69Go7Z9G_5w-1; Thu, 05 Nov 2020 09:00:01 +0000
X-MC-Unique: 8UX6HNYcNJS69Go7Z9G_5w-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Thu, 5 Nov 2020 09:00:00 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Thu, 5 Nov 2020 09:00:00 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Daniel Xu' <dxu@dxuuu.xyz>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>
CC:     "kernel-team@fb.com" <kernel-team@fb.com>
Subject: RE: [PATCH bpf v2 1/2] lib/strncpy_from_user.c: Don't overcopy bytes
 after NUL terminator
Thread-Topic: [PATCH bpf v2 1/2] lib/strncpy_from_user.c: Don't overcopy bytes
 after NUL terminator
Thread-Index: AQHWsxsIE6fPG3mijk+FzhsUr3fzDam5OvTg
Date:   Thu, 5 Nov 2020 09:00:00 +0000
Message-ID: <cbe00e1421db4566a076102506b6d670@AcuMS.aculab.com>
References: <cover.1604542786.git.dxu@dxuuu.xyz>
 <487a07aa911b4e822a0b931f7b33a4f67fedb6bd.1604542786.git.dxu@dxuuu.xyz>
In-Reply-To: <487a07aa911b4e822a0b931f7b33a4f67fedb6bd.1604542786.git.dxu@dxuuu.xyz>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=C51A453 smtp.mailfrom=david.laight@aculab.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Daniel Xu
> Sent: 05 November 2020 02:26
...
> --- a/lib/strncpy_from_user.c
> +++ b/lib/strncpy_from_user.c
> @@ -35,17 +35,22 @@ static inline long do_strncpy_from_user(char *dst, const char __user *src,
>  		goto byte_at_a_time;
> 
>  	while (max >= sizeof(unsigned long)) {
> -		unsigned long c, data;
> +		unsigned long c, data, mask, *out;
> 
>  		/* Fall back to byte-at-a-time if we get a page fault */
>  		unsafe_get_user(c, (unsigned long __user *)(src+res), byte_at_a_time);

It's not related to this change, but since both addresses
are aligned (checked earlier) a page fault on the word read
is fatal.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

