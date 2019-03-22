Return-Path: <SRS0=YBMC=RZ=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DBE8C43381
	for <bpf@archiver.kernel.org>; Fri, 22 Mar 2019 03:12:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1C06218FC
	for <bpf@archiver.kernel.org>; Fri, 22 Mar 2019 03:12:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YDWCfuaY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727519AbfCVDMw (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 21 Mar 2019 23:12:52 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45021 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727495AbfCVDMw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 21 Mar 2019 23:12:52 -0400
Received: by mail-pg1-f195.google.com with SMTP id i2so456811pgj.11;
        Thu, 21 Mar 2019 20:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/AlaoP2QpMymG1u4Y3M84Jghb8jQbXyNDZtGvHoTxvY=;
        b=YDWCfuaY1SRiIMzgoaQ3tGLvx21BY88nuhT+iiwHvx/9wL0EVnmPu73R8iGBBPFgGk
         ULOkiSXXWyfum3qJNQTju5h3JDxZA1j5o4xnDrippNyj2uX5xWU1Rg7Cnd5FYew6/wHG
         9Rm7yM1iHpubSPYIysbYTjUltiaKUdWDs/Okl34eP6G4zGQqw+LRsFJKf1IjaMDQIp1a
         A3h/sdWqWm/VYTxNcBSsrU76cORlwPYU/M+ksl31y968XcslXxGudUMDXTHbQdxQT4fA
         LRvqtVuaSYETxZRDhx+3vXCP7A9kBg5kN61PhVk1q7eIqIzSqgrg5SdVLiWL/RhrOld3
         GZGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/AlaoP2QpMymG1u4Y3M84Jghb8jQbXyNDZtGvHoTxvY=;
        b=HseUqSUQaUW9NL6+HaWzAQ6wC/84ghKrEGc3uMJHMiBXt/umVx7v9UE/lQffBJAfVv
         8oLftHgXRpsWWQN804jdOWo7ZDTscB6eIPSAFDKpHA4rjmJhgJIcDirNXbn+EJ8tDJOJ
         PJ+jQlWCtYPXcRu5xfKLfwyjP0l1NVAinqUeqVya8Js0FY8Kt6vxQpy9AGMys4KK5yIe
         j9QJ9k+XVSzcHhYotov0Js1weILIuuOrJ1HlnbSxPxLqKabIo3wMcrIOZVikStqrn2mq
         LldE2gFlfOg2TVpD0BFWkAS3sSekGq5DOsgu2a1YtmS5T9WAFPLdgmOAzrjN675T0PvA
         yQ3w==
X-Gm-Message-State: APjAAAWhJ3NRrpiVzVUiX8Xa24ztl0sUhbtQqfRSmQyY/+oi/T4jBNZm
        xsWbAXsccllud+4OK6AmAEl9uyw5
X-Google-Smtp-Source: APXvYqxuGTBcEWRkFtcDaa8CSs2nIOB5b+y4mmWKd/wb9qNfi2YRKH0/0O0KHID3ujpFfzmwF+afJw==
X-Received: by 2002:a17:902:ba88:: with SMTP id k8mr4462127pls.268.1553224371337;
        Thu, 21 Mar 2019 20:12:51 -0700 (PDT)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:180::d464])
        by smtp.gmail.com with ESMTPSA id k74sm13852383pfb.172.2019.03.21.20.12.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Mar 2019 20:12:50 -0700 (PDT)
Date:   Thu, 21 Mar 2019 20:12:48 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     Stanislav Fomichev <sdf@fomichev.me>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Shuah Khan <shuah@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: Re: [PATCHv2 bpf-next 1/3] bpf, tests: tweak endianness selection
Message-ID: <20190322031247.6somplkx7lmr3ksm@ast-mbp.dhcp.thefacebook.com>
References: <20190320125335.19621-1-sergey.senozhatsky@gmail.com>
 <20190321032429.2e7jddbltblaekjc@ast-mbp.dhcp.thefacebook.com>
 <20190321050852.GA1534@jagdpanzerIV>
 <20190321154928.GT7431@mini-arch.hsd1.ca.comcast.net>
 <20190322024652.GA3679@jagdpanzerIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190322024652.GA3679@jagdpanzerIV>
User-Agent: NeoMutt/20180223
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Mar 22, 2019 at 11:46:52AM +0900, Sergey Senozhatsky wrote:
> On (03/21/19 08:49), Stanislav Fomichev wrote:
> > On 03/21, Sergey Senozhatsky wrote:
> > > On (03/20/19 20:24), Alexei Starovoitov wrote:
> > > > On Wed, Mar 20, 2019 at 09:53:33PM +0900, Sergey Senozhatsky wrote:
> > > > > Not all compilers have __builtin_bswap16() and __builtin_bswap32(),
> > > > > thus not all compilers are able to compile the following code:
> > > > > 
> > > > >         (__builtin_constant_p(x) ? \
> > > > >                 ___constant_swab16(x) : __builtin_bswap16(x))
> > > > > 
> > > > > That's the reason why bpf_ntohl() doesn't work on GCC < 4.8, for
> > > > > instance:
> > > > 
> > > > nack to fixes to support such old compilers.
> > > 
> > > Fair enough.
> > What is too old? Documentation/process/changes.rst says that minimum
> > supported gcc is 4.6, do we lift that requirement for the tests?
> 
> Hmm, good point, Stanislav. I thought it was gcc 4.9 which introduced
> asm goto and hence 4.9 is the minimum supported version. But it seems
> that it was 4.5/4.6, so the min supported gcc version is 4.6. Which
> means that those bpf defines won't work on some compilers.
> 
> Alexei, does your NACK still stand?

yes.
bpf samples and selftests require llvm and new features like BTF
require the latest llvm which requires gcc 5.1.
Things are more or less working still with gcc 4.8, but soon will
likely start breaking.
