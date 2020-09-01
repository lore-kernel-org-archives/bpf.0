Return-Path: <SRS0=+JL0=CK=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69149C433E2
	for <bpf@archiver.kernel.org>; Tue,  1 Sep 2020 09:30:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 441CF20866
	for <bpf@archiver.kernel.org>; Tue,  1 Sep 2020 09:30:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Cu67wSTp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726107AbgIAJa4 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 1 Sep 2020 05:30:56 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:59587 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725848AbgIAJa4 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 1 Sep 2020 05:30:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598952654;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hEI6w8pkhBx0pRn2evfFgE40/baKnW53cmKF71KTuiY=;
        b=Cu67wSTp6lThmRoCzCdyEfrwt8tv9+Ml5e9sRK+di+lJiYsIS/z41AFTc8yo+f0GjTseP6
        PlpPYOoVahD6k9f1STtTF/B5ubxVtIwNRfBMnKic4lZH2nuAxa1fMBIh2/1bcDaur0tVMA
        pgAj20DpqIdhgOIHmXyHfZ2T3aNnif8=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-492-JFds6vxjO3GNri2__aWMvQ-1; Tue, 01 Sep 2020 05:30:53 -0400
X-MC-Unique: JFds6vxjO3GNri2__aWMvQ-1
Received: by mail-ed1-f70.google.com with SMTP id m88so300723ede.0
        for <bpf@vger.kernel.org>; Tue, 01 Sep 2020 02:30:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=hEI6w8pkhBx0pRn2evfFgE40/baKnW53cmKF71KTuiY=;
        b=bXh46R4BU4klVkcN4MzLWFHgTmlLt+NIUwB4mRQomOIsmwf0Zu+4usQNxOe545ShOx
         E3bxHqmpPG4MnMlNsY+feMblTecraqX0jZBJYlmlLj33pEe3T+3imTfNLq71tIP8cUNH
         W+kaL7Lu1SplTqqGLexAEkDwrNSCIkNm64iuAGV+Zp+NOZyKTcXTz/eeDj14GJ6Q8Q0v
         gM0r7vgP0yqubbDrVwnESXt6hxn3Igd0ttYETCE4IcATkfVJWFKyLr6g2rOvfje5MBD3
         +y22Evz8tTRf1SgmJH0rBazLRC64WIX+wkwCX8ekIZWWouve2SWIh4NH+gTY6nYhMIaG
         KuHw==
X-Gm-Message-State: AOAM533H1vDP5qSY8UgEdnk3tIJaMOrdD1LriUfB+5I8TPPfSRhLrnE4
        uB0piBZIUte1eGMg9eZX4HwKQkBemEs/WRDA1LuNc74CTQ0B1Ynhjs2k8Edx0Lcr6dxHj8qVKKq
        eFU+BaeygpgOb
X-Received: by 2002:a17:906:2a1a:: with SMTP id j26mr664889eje.456.1598952651897;
        Tue, 01 Sep 2020 02:30:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxi8RpvZMvbljE/lfXOnHgixWg+IZS3T/Azy6rX2jkbDTJ08NmOlGgnQ5zLeRudM/YORCYNaw==
X-Received: by 2002:a17:906:2a1a:: with SMTP id j26mr664879eje.456.1598952651741;
        Tue, 01 Sep 2020 02:30:51 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id 1sm726011ejn.50.2020.09.01.02.30.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2020 02:30:51 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 9CB6C182A41; Tue,  1 Sep 2020 11:30:49 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@gmail.com>,
        ast@kernel.org, daniel@iogearbox.net, bpf@vger.kernel.org
Cc:     =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@intel.com>,
        magnus.karlsson@intel.com, netdev@vger.kernel.org,
        brouer@redhat.com, dsahern@gmail.com
Subject: Re: [PATCH bpf-next v2] bpf: {cpu,dev}map: change various functions
 return type from int to void
In-Reply-To: <20200901083928.6199-1-bjorn.topel@gmail.com>
References: <20200901083928.6199-1-bjorn.topel@gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Tue, 01 Sep 2020 11:30:49 +0200
Message-ID: <87blipkfna.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Bj=C3=B6rn T=C3=B6pel <bjorn.topel@gmail.com> writes:

> From: Bj=C3=B6rn T=C3=B6pel <bjorn.topel@intel.com>
>
> The functions bq_enqueue(), bq_flush_to_queue(), and bq_xmit_all() in
> {cpu,dev}map.c always return zero. Changing the return type from int
> to void makes the code easier to follow.
>
> Suggested-by: David Ahern <dsahern@gmail.com>
> Signed-off-by: Bj=C3=B6rn T=C3=B6pel <bjorn.topel@intel.com>

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>

