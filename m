Return-Path: <SRS0=YBMC=RZ=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FC45C43381
	for <bpf@archiver.kernel.org>; Fri, 22 Mar 2019 02:46:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D58E218FE
	for <bpf@archiver.kernel.org>; Fri, 22 Mar 2019 02:46:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LqEORLJn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727451AbfCVCq6 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 21 Mar 2019 22:46:58 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33378 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbfCVCq5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 21 Mar 2019 22:46:57 -0400
Received: by mail-pf1-f196.google.com with SMTP id i19so484797pfd.0;
        Thu, 21 Mar 2019 19:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=who9YPOO2VsQzz5k8vgRhc7mw9PFaOxvJ1BUC8DoORU=;
        b=LqEORLJn0lQdr5JcVxUBOSp8CTzKMJXOCIltklBfz8owmy4b7Rt83XjLx/t5DlOmq9
         Cyilv+EPT+pHYRp6jfrAJswvrPPMWOvvdMYf2Dgwt1BW+gWckyBwZosHewXNgmpumJ57
         dni67draRgLa8Jyv0dHZOQWJ4L5kTjdq83Y6dPyWWdV/H8nWgiowdX76G4VDcjccNNo7
         f02kNH4Ib2LjV+YVWLwy8xDw+ZCQlNtJoyMydHnOvHA4n9rM1z1qSy20ONIekbdRB9Or
         xZFfoPCIHHM1gahOhEloHB0P+qHEk93YW5Nz4vLsCIiAdiwK4sfBnXKMnj/caV8PYs3j
         tfjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=who9YPOO2VsQzz5k8vgRhc7mw9PFaOxvJ1BUC8DoORU=;
        b=VP8kwYkhcGyM3baGBc+LaHSSeLtAcjM6LdK5N7+GtyYxvQP345pFmvOyHEgRyaOSO/
         ZzSUYEIg5mlN+zlmEjv+iHPZyxEnibu9JA2G0HwMtNkFNyMTqxVQul96GijzOk8PAqMj
         KBWWHmYrSBopBJKvpMRSVLkaHsVFOnVAgu0zDR5Ra7m+xugIwB0WqmS/n1wMersl1R9b
         5Y0y9TB4LJnH5GThqdGkUizExsQAtHctK4VKIrzHj+SE/Y9JqiTas3LQNXKgA/g7Hy2z
         EmLucjMEMUlI8Y31vmhIy6TwWM2i7A8HP6bqUX0wHG9gKIgL4WC3ePWFkc5cWv32GBBf
         Vofw==
X-Gm-Message-State: APjAAAUBUTBxDwos2FzqQpysOQzwFL+39s47VqX4YOsTDdykxFmz+f2f
        BWIk3d75Gzv0bEmQcLBw9gTwZGwt
X-Google-Smtp-Source: APXvYqwdRZZnLu/81lH6uHza+wL4rhvPMYHWfWefdVYQnT7PH1IfnViScMFs3+LnTINLkWLDGNUnpQ==
X-Received: by 2002:a63:ee04:: with SMTP id e4mr6617885pgi.310.1553222816394;
        Thu, 21 Mar 2019 19:46:56 -0700 (PDT)
Received: from localhost ([175.223.33.106])
        by smtp.gmail.com with ESMTPSA id e2sm9238294pfa.64.2019.03.21.19.46.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Mar 2019 19:46:55 -0700 (PDT)
Date:   Fri, 22 Mar 2019 11:46:52 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Stanislav Fomichev <sdf@fomichev.me>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
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
Message-ID: <20190322024652.GA3679@jagdpanzerIV>
References: <20190320125335.19621-1-sergey.senozhatsky@gmail.com>
 <20190321032429.2e7jddbltblaekjc@ast-mbp.dhcp.thefacebook.com>
 <20190321050852.GA1534@jagdpanzerIV>
 <20190321154928.GT7431@mini-arch.hsd1.ca.comcast.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190321154928.GT7431@mini-arch.hsd1.ca.comcast.net>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On (03/21/19 08:49), Stanislav Fomichev wrote:
> On 03/21, Sergey Senozhatsky wrote:
> > On (03/20/19 20:24), Alexei Starovoitov wrote:
> > > On Wed, Mar 20, 2019 at 09:53:33PM +0900, Sergey Senozhatsky wrote:
> > > > Not all compilers have __builtin_bswap16() and __builtin_bswap32(),
> > > > thus not all compilers are able to compile the following code:
> > > > 
> > > >         (__builtin_constant_p(x) ? \
> > > >                 ___constant_swab16(x) : __builtin_bswap16(x))
> > > > 
> > > > That's the reason why bpf_ntohl() doesn't work on GCC < 4.8, for
> > > > instance:
> > > 
> > > nack to fixes to support such old compilers.
> > 
> > Fair enough.
> What is too old? Documentation/process/changes.rst says that minimum
> supported gcc is 4.6, do we lift that requirement for the tests?

Hmm, good point, Stanislav. I thought it was gcc 4.9 which introduced
asm goto and hence 4.9 is the minimum supported version. But it seems
that it was 4.5/4.6, so the min supported gcc version is 4.6. Which
means that those bpf defines won't work on some compilers.

Alexei, does your NACK still stand?

	-ss
