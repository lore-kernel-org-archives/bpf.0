Return-Path: <SRS0=uCLx=25=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D789C33CA2
	for <bpf@archiver.kernel.org>; Wed,  8 Jan 2020 23:05:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59693206DA
	for <bpf@archiver.kernel.org>; Wed,  8 Jan 2020 23:05:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rHN1WWEm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726930AbgAHXFx (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 8 Jan 2020 18:05:53 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:42046 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726721AbgAHXFw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 8 Jan 2020 18:05:52 -0500
Received: by mail-lj1-f196.google.com with SMTP id y4so5080752ljj.9;
        Wed, 08 Jan 2020 15:05:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=U3HPxq+JaW3pFiI3JEEs7YjUhltYkB8RZv+GfM+9QN0=;
        b=rHN1WWEmH1HX3GAQDZmboMD6pXD7lDzxL7dZ/wWDDvp3v2YEElZ4l+6K7zjY3F/Mn7
         L5LyojHf7T7zbRxR2nQ2YRgWbKjgEBkcBTqG3xBGMkNogMBMNtBIGImZMarcbY2I+1Ni
         TueaiPAVx3Cvf2bPyhcRnTIePHWDV2nEQU8b9doS9mv/eziwfWVuMCfAwD5R9vkbXBEs
         te/NTPhAHn7AaEbMy+tw7jLr39arfOp9q8pX6hIEoSUgBCQAOWdRhvg2tBjypDa5Ne36
         +PIEvhyx1oK9Jjt6CXtI7kMx1ASAEvskbqezFVBtP/j6MjSgmKIFnUFXGttYz3EYpQXn
         zwPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U3HPxq+JaW3pFiI3JEEs7YjUhltYkB8RZv+GfM+9QN0=;
        b=AcO/3CwV8NigDQ40y90ZfMxgO93MoEhbhthPPSqs6Wcz1Er9Hma7rQHqafVSF+eIiX
         pzsI+QN6InxvJWZ2vHBa0nQFM0DWwp7AKpHPZ3ykNwim2JcQFJleYC1F/JqILlkgz/3y
         vGBU389wYumGd+pLS+uQZBdmfgBYUkiKVKEO3D1M7SVzP5tqiKB6QcxN2K2N9LDuwT4i
         HBDZz2iwvuHeWWv5fi8qdylsuMwg4xuJio4gzy9z85Vtx/jEIljSPNHywNEh52M8PUAc
         YJiaTy8mSC5WFgfL+ubGXPA0cMMPHnVnotva/IYhpsG2+0i0tCwhxtQtEUhtvE3XnPn2
         RC+Q==
X-Gm-Message-State: APjAAAXV3GIV1EnNFhrCNJU7h//y9txh1zgkYhhN18vA9hKNyhAHFgHj
        1D7M5VXzYkv3NE7lqUHNO91t2WMpQD4XWaQ4DOE=
X-Google-Smtp-Source: APXvYqzTuS9Q0QvxC9u/Dzmy4m72UQ1BJMgE0SJpYNDGrSFfFqNl0bRsgv2Nj3FOR2BWhioDY0F+8pU363wKvYBk4Ko=
X-Received: by 2002:a2e:89d0:: with SMTP id c16mr4417580ljk.228.1578524750262;
 Wed, 08 Jan 2020 15:05:50 -0800 (PST)
MIME-Version: 1.0
References: <20200108072538.3359838-1-ast@kernel.org> <20200108072538.3359838-4-ast@kernel.org>
In-Reply-To: <20200108072538.3359838-4-ast@kernel.org>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 8 Jan 2020 15:05:39 -0800
Message-ID: <CAADnVQLrvMm35VwTsf-+TFFbimZEFm15kCFrUW2=hySXGEiRPw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 3/6] bpf: Introduce function-by-function verification
To:     Alexei Starovoitov <ast@kernel.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Network Development <netdev@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jan 7, 2020 at 11:27 PM Alexei Starovoitov <ast@kernel.org> wrote:
> +       if (subprog) {
> +               ret = btf_prepare_func_args(env, subprog, regs);
> +               if (ret)
> +                       return ret;

noticed a memory leak here.
Will respin with all comments addressed soon.
