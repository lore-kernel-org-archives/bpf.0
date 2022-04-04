Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D272C433EF
	for <bpf@archiver.kernel.org>; Mon,  4 Apr 2022 06:47:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348985AbiDDGte (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 4 Apr 2022 02:49:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377599AbiDDGtd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 4 Apr 2022 02:49:33 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EE733B014;
        Sun,  3 Apr 2022 23:47:31 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id d3so6171934ilr.10;
        Sun, 03 Apr 2022 23:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tyBnVz8XzR/TOwXl3pFQ1AhrjPd/slT15AWdIMX+5Fc=;
        b=k0XSB2zouBSd417Vc0CCeT1+FFq68wjlNyn30zSZrG241q6FuEULnikyEXB3Y0NbnE
         Ikmy8hnharg5GES0ZX3OQkiYqiBvUzmFydBX9wMTOcrb6gcHpt42yHNVRNhnxkvD4mzQ
         5LaDYmk8N8SXZzNMLJDJhW1+TKTP575H36h2fg33jvtK1HXvKoUpbKnZYq0X9D5mv5va
         OHdFVC6CDv2nwt2otmNcmhamXEIkEtY4XIT9w5rcHTwUbtD0gotH2w7jZ3KCGVR6nr3Y
         iHdbMSb4EMvijOWh4zW9Dqubs97PNz01tCdNxhiSOjV9z6KHhb8ZlzTAgYthzgkrK2KL
         KkBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tyBnVz8XzR/TOwXl3pFQ1AhrjPd/slT15AWdIMX+5Fc=;
        b=R2Pqk1IkCpylgT5Of/UgqIjH5XJrRCIhL0FWuSGKtrVzd6ynz1dJtA7FdWrRYMxa31
         2o5+u4CK861E36iGdLSkyusQvWXmMKcMIgSB7XDpDes74fUbMAIC9glm2zgc9G2fQ17D
         wmj4USfUjJhVPN8OmvZZNLS+rfU883MNnvdxyTzrERGAt+h+HO1dbjcwzezCWutJQGmZ
         uzr9xR//p2mAMlCon9kK2zArxqDBLxM6D8YM682Zpkzye6egM99w3WjVTV4rWrgUdJ6/
         46U0YcfACl4xdW+l2DgcVhYFkGhVmS6Xk5YH6Mmr1DY1a04ML5d1ybRBBIOUSpW1e7lw
         CU3g==
X-Gm-Message-State: AOAM533b0IsyjPHvrMVCFFK85xCwzdw63znAU+vER1yPjZRGz+0lhEZL
        Va4V2rg9qH11PDfL/YoyaVsRoIhgUkfOhzVbxIY=
X-Google-Smtp-Source: ABdhPJxPyOMcfDiR8+cP7uD+hyVkhdW0giw0E6uajw5UZcYO4fGu6RXxeOw2wGoHkaP9Jf4tP7hnaVCCkwMhBOK64Vw=
X-Received: by 2002:a92:c54e:0:b0:2c9:aa07:71b2 with SMTP id
 a14-20020a92c54e000000b002c9aa0771b2mr4862706ilj.257.1649054850948; Sun, 03
 Apr 2022 23:47:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220403144300.6707-1-laoar.shao@gmail.com> <20220403144300.6707-3-laoar.shao@gmail.com>
 <CAEf4Bza7ZoRaHWLF=03+Z-PLTvZ3EOKZR02=UgDLDX-XXOewJg@mail.gmail.com>
In-Reply-To: <CAEf4Bza7ZoRaHWLF=03+Z-PLTvZ3EOKZR02=UgDLDX-XXOewJg@mail.gmail.com>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Mon, 4 Apr 2022 14:46:55 +0800
Message-ID: <CALOAHbBJH8xuviP7oOiPnqCU1=hDbEzRRdcTPgUvH=q=OJeBqg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 2/9] bpf: selftests: Use bpf strict all ctor
 in xdping
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, Martin Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        john fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Apr 4, 2022 at 9:26 AM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Sun, Apr 3, 2022 at 7:43 AM Yafang Shao <laoar.shao@gmail.com> wrote:
> >
> > Aoid using the deprecated RLIMIT_MEMLOCK.
>
> typo: avoid

Thanks again.


-- 
Thanks
Yafang
