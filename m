Return-Path: <SRS0=za3g=2Y=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CC62C2D0C2
	for <bpf@archiver.kernel.org>; Fri,  3 Jan 2020 19:27:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D63B7215A4
	for <bpf@archiver.kernel.org>; Fri,  3 Jan 2020 19:27:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bBcQoSAZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728503AbgACT11 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 3 Jan 2020 14:27:27 -0500
Received: from mail-qk1-f171.google.com ([209.85.222.171]:37715 "EHLO
        mail-qk1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728485AbgACT11 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 3 Jan 2020 14:27:27 -0500
Received: by mail-qk1-f171.google.com with SMTP id 21so34636593qky.4;
        Fri, 03 Jan 2020 11:27:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dMeBWVG91pHubNQWYivBpH2U/MdEbVYxoDpB6kBimc8=;
        b=bBcQoSAZqxJ86WrFmQLxtF0khw3qu8NdpIqVsiNsZz5FwVjuSH0+rUPAJwSCk6zm0V
         U0199OaSF+u0TVC43kgylZJJzSmQvieO3ppgiAnXpRH2GGjy+/fg0YD5A32pg48eDvCz
         eTpkaLntLRrQW2e8LjSvEW9/SzNP23ovgt6vxfWRJbhAn+NLJ6F6QDI7NLLyA2rHdwd3
         XdDPSBcWDDOSYkdgSGgysfQtdQAM8CcVl2JYGsEHQ4hew5sbw1rsXOtSwLIarm/ZSrIB
         UZnBkhW29ZC2WxxeKSrY6kXL+INVQwlSjtpdrEy1uW/6V82OtAgKHE4OyCQb7vsTfCpT
         SQSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dMeBWVG91pHubNQWYivBpH2U/MdEbVYxoDpB6kBimc8=;
        b=nDnibp90X0rGb0YqNQYSUThTyAzDc1FtbOieK0rPcdO20rhxtUvoMbAmo1922iXY1s
         iaQKCvOiQ2DI9yHoSctizICI77ER/w05/B0aOcx1iWSUyU2/AylegBh6Uuounwzx1l7w
         HL/EGu/srDXGDwAu5j09xFBT3rAS9SyzG2Y4rwrG8QfTlx9FDspJNg+ohSyiCe6U4TsI
         J4bn/Q4PldLzKGJYDqAfBQwpY7mAJZKX8WdcmR7vAlgrDPAlUhtwZVGOVCq6PEocIiS7
         8PvJh7Um2pyGclbFBWtn+YHZmF40982eptcvXeXoMN05qbC84/crPPbSLNCd3o1oWO9u
         S5SQ==
X-Gm-Message-State: APjAAAU9rmDxY+ijlymRAZUllJejxqd5d8Jfua1FQ7qCmoTuyYHFTizv
        XwDec3BcJffrbK0S5J/YM5KA+5GjnFy57K6N95w=
X-Google-Smtp-Source: APXvYqwpj0MxNUn2no56Ue+nb3rSr2sEVuat2D3u1eAsTiEmDw4u3iOiGU+9ogvAkWCDGjnipY9zW5knmlNjOZzf5lc=
X-Received: by 2002:a05:620a:1324:: with SMTP id p4mr74143048qkj.497.1578079646156;
 Fri, 03 Jan 2020 11:27:26 -0800 (PST)
MIME-Version: 1.0
References: <1578032749-18197-1-git-send-email-lirongqing@baidu.com>
In-Reply-To: <1578032749-18197-1-git-send-email-lirongqing@baidu.com>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Fri, 3 Jan 2020 11:27:15 -0800
Message-ID: <CAPhsuW6FOKjAzjqfnddJKMxcH2VQKXqLdoxzBQ558UK8fiCrXA@mail.gmail.com>
Subject: Re: [PATCH][bpf-next] bpf: return EOPNOTSUPP when invalid map type in __bpf_tx_xdp_map
To:     Li RongQing <lirongqing@baidu.com>
Cc:     Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jan 2, 2020 at 10:26 PM Li RongQing <lirongqing@baidu.com> wrote:
>
> a negative value -EOPNOTSUPP should be returned if map->map_type
> is invalid although that seems unlikely now, then the caller will
> continue to handle buffer, or else the buffer will be leaked
>
> Signed-off-by: Li RongQing <lirongqing@baidu.com>

Acked-by: Song Liu <songliubraving@fb.com>
