Return-Path: <SRS0=ovpu=UL=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D119C31E47
	for <bpf@archiver.kernel.org>; Wed, 12 Jun 2019 21:15:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FBF4215EA
	for <bpf@archiver.kernel.org>; Wed, 12 Jun 2019 21:15:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="fIoONPxS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727263AbfFLVPN (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 12 Jun 2019 17:15:13 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:33270 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727233AbfFLVPM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 12 Jun 2019 17:15:12 -0400
Received: by mail-qt1-f194.google.com with SMTP id x2so19239842qtr.0
        for <bpf@vger.kernel.org>; Wed, 12 Jun 2019 14:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=SGMJGhFfpnL2JqkDysdCHR3w5AusuLSP/YMpsTHHK+o=;
        b=fIoONPxS8cgfjItxGUrfUCdrJKLMbHMGy4EoJSyVD2I2iaFW7sFj0eZApDi9aVWJcw
         PJTwSYXSIdemh5JgMwlXwikQ9SjWjZKMH0I83H1bGUkc+WZK7JWFmOuq49Snj0gvv2X7
         G+U6uNeUDfK+jRQcX4q7Wq/4UNrsZ9URfnOz6bGoJsKvVuMIaRpP1RH3i/W9g9LkZVkP
         8t4IKlBsUUehxI+OGk94w70u1npteM57fGfXAjAe1Vd3XGgBU6Zz+jXrJTL5VFGQO9sY
         85mn6Za5abeSN4xj4F+vXo1V1cGzNsg0qHLYqF65wD+cHFJVd40ZdcpQL01En4km+izv
         D67A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=SGMJGhFfpnL2JqkDysdCHR3w5AusuLSP/YMpsTHHK+o=;
        b=sWyzzLBzCToFyR8vSum6an79pSXP2p49P2zxtZjLM47leBwYxs0WdWcJg+Yfmm9hXs
         BmmiJ0eCbGyuq8CXzqXbvJXA8AAyi+AGMDmg88KrENW14O/p8KPg8cAq16OYQ/OJfPRE
         SpIQrJkG6QqOS6RJ1PCjRCYQ0dviL2RCTzb1seK7Nn0OXkF8YyKalld9wzTdjJWhvlkh
         97hW5/8YIzZdMU6mUDEUMJblYwnBmjeBdrNdAyTkQV0VQvdGcTXY4v0TUyFVYicH5iv+
         +znVvPBIfi7dlyPGacE3BWY3qRbeQ8J2/+2nSkRTzHRjqbV8+tAcUw8J+O8QcmAHaFAk
         Zb7g==
X-Gm-Message-State: APjAAAW82tHBp3KtKou/Y8QDMx1JII2lmNhZNMS++tP7giTu199jyZrX
        UBgB2HIucOTQU7YPlrOvmn+xgA==
X-Google-Smtp-Source: APXvYqw7b3GMuPYy2Wp2MkgpYIt7RJMKsD9ooltxVCCLMZoybsVXH99TRxkdVGT+kPjLpqx6Bo9l8w==
X-Received: by 2002:ac8:5141:: with SMTP id h1mr36799595qtn.15.1560374111730;
        Wed, 12 Jun 2019 14:15:11 -0700 (PDT)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id u7sm583271qta.82.2019.06.12.14.15.10
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 12 Jun 2019 14:15:11 -0700 (PDT)
Date:   Wed, 12 Jun 2019 14:15:06 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Maxim Mikityanskiy <maximmi@mellanox.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@intel.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>
Subject: Re: [PATCH bpf-next] net: Don't uninstall an XDP program when none
 is installed
Message-ID: <20190612141506.7900e952@cakuba.netronome.com>
In-Reply-To: <20190612161405.24064-1-maximmi@mellanox.com>
References: <20190612161405.24064-1-maximmi@mellanox.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 12 Jun 2019 16:14:18 +0000, Maxim Mikityanskiy wrote:
> dev_change_xdp_fd doesn't perform any checks in case it uninstalls an
> XDP program. It means that the driver's ndo_bpf can be called with
> XDP_SETUP_PROG asking to set it to NULL even if it's already NULL. This
> case happens if the user runs `ip link set eth0 xdp off` when there is
> no XDP program attached.
>=20
> The drivers typically perform some heavy operations on XDP_SETUP_PROG,
> so they all have to handle this case internally to return early if it
> happens. This patch puts this check into the kernel code, so that all
> drivers will benefit from it.
>=20
> Signed-off-by: Maxim Mikityanskiy <maximmi@mellanox.com>
> ---
> Bj=C3=B6rn, please take a look at this, Saeed told me you were doing
> something related, but I couldn't find it. If this fix is already
> covered by your work, please tell about that.
>=20
>  net/core/dev.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/net/core/dev.c b/net/core/dev.c
> index 66f7508825bd..68b3e3320ceb 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -8089,6 +8089,9 @@ int dev_change_xdp_fd(struct net_device *dev, struc=
t netlink_ext_ack *extack,
>  			bpf_prog_put(prog);
>  			return -EINVAL;
>  		}
> +	} else {
> +		if (!__dev_xdp_query(dev, bpf_op, query))
> +			return 0;

This will mask the error if program is installed with different flags.

You driver should do nothing is program installation state did not
change.  I.e.:

	if (!!prog =3D=3D !!oldprog)

You can't remove the active -> active check anyway, this change should
make no difference.

>  	}
> =20
>  	err =3D dev_xdp_install(dev, bpf_op, extack, flags, prog);
