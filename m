Return-Path: <SRS0=M9Uk=B7=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DF9FC433DF
	for <bpf@archiver.kernel.org>; Fri, 21 Aug 2020 17:08:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 05AD920656
	for <bpf@archiver.kernel.org>; Fri, 21 Aug 2020 17:08:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728893AbgHURH6 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 21 Aug 2020 13:07:58 -0400
Received: from smtprelay0042.hostedemail.com ([216.40.44.42]:34838 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727076AbgHUQSC (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 21 Aug 2020 12:18:02 -0400
X-Greylist: delayed 503 seconds by postgrey-1.27 at vger.kernel.org; Fri, 21 Aug 2020 12:18:01 EDT
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave01.hostedemail.com (Postfix) with ESMTP id AEA351801B5E3
        for <bpf@vger.kernel.org>; Fri, 21 Aug 2020 16:09:35 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 80432100E7B42;
        Fri, 21 Aug 2020 16:09:33 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: frogs77_130d49d2703a
X-Filterd-Recvd-Size: 2436
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf08.hostedemail.com (Postfix) with ESMTPA;
        Fri, 21 Aug 2020 16:09:27 +0000 (UTC)
Message-ID: <d9ea16e803e219894416894a5cbed0fac00d891e.camel@perches.com>
Subject: Re: [PATCH 00/49] DRM driver for Hikey 970
From:   Joe Perches <joe@perches.com>
To:     Sam Ravnborg <sam@ravnborg.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Xinliang Liu <xinliang.liu@linaro.org>,
        Wanchun Zheng <zhengwanchun@hisilicon.com>,
        linuxarm@huawei.com, dri-devel <dri-devel@lists.freedesktop.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        devel@driverdev.osuosl.org, Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Xiubin Zhang <zhangxiubin1@huawei.com>,
        Wei Xu <xuwei5@hisilicon.com>, David Airlie <airlied@linux.ie>,
        Xinwei Kong <kong.kongxinwei@hisilicon.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Bogdan Togorean <bogdan.togorean@analog.com>,
        Laurentiu Palcu <laurentiu.palcu@nxp.com>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        Liwei Cai <cailiwei@hisilicon.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Chen Feng <puck.chen@hisilicon.com>,
        Alexei Starovoitov <ast@kernel.org>,
        linaro-mm-sig@lists.linaro.org, Rob Herring <robh+dt@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>, mauro.chehab@huawei.com,
        Rob Clark <robdclark@chromium.org>,
        linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Liuyao An <anliuyao@huawei.com>,
        Rongrong Zou <zourongrong@gmail.com>, bpf@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>
Date:   Fri, 21 Aug 2020 09:09:25 -0700
In-Reply-To: <20200819204800.GA110118@ravnborg.org>
References: <cover.1597833138.git.mchehab+huawei@kernel.org>
         <20200819152120.GA106437@ravnborg.org> <20200819174027.70b39ee9@coco.lan>
         <20200819204800.GA110118@ravnborg.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 2020-08-19 at 22:48 +0200, Sam Ravnborg wrote:
> And sometimes checkpatch is just wrong.

I'm interested in examples for when checkpatch is "just wrong".


