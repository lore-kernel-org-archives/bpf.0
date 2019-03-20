Return-Path: <SRS0=US5c=RX=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 861A5C43381
	for <bpf@archiver.kernel.org>; Wed, 20 Mar 2019 01:51:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56F512175B
	for <bpf@archiver.kernel.org>; Wed, 20 Mar 2019 01:51:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KoBZ5ftB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727390AbfCTBva (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 19 Mar 2019 21:51:30 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43018 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726884AbfCTBv3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 19 Mar 2019 21:51:29 -0400
Received: by mail-pg1-f196.google.com with SMTP id l11so504646pgq.10;
        Tue, 19 Mar 2019 18:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vergPYE5OUnFH9ZA86DfTu9LZz/bZHQ6seyMpjOMYIY=;
        b=KoBZ5ftBCQkKFhAGCVdN+br34pnv0ZqJJ8vFLbmCiOUMgBuE8t4ZLlp0aoZyLR6bqD
         J7Zupn0YdjyO5fzWnTW7oBLcEJhuPQ9a6EekaBHwK6Jciyr0q0i736e3G2/L1s6YO5OP
         mrrI3vxuER0BjaPtguk8CWiWWEKVyJ0InRBww9eokFvTTmuG5yjCNwLdSuAUsOKQbGWx
         VKMqyJFTNhVfpfG01PNnqWRJBZUlPoGpLKtEs7bIHJOdP2krxzDyTMQV1odWRDv3FaNZ
         cH+VrPyGCwWdQZE+yrw1K78qrtwMFSptlN+TkkxFrmmDW0pN0jDuz6YTQdPudIEzOLU6
         +DgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vergPYE5OUnFH9ZA86DfTu9LZz/bZHQ6seyMpjOMYIY=;
        b=Z7DdzOKqph4rYS3YpU+p1a8rPU32ITMtDQiWSy+e7LX4iwWn4wUNDjL+t03pckYzBj
         jRrQz64F80FzcuY9fRADEtAtpsTbm5RMxF5L6cHlvvsHdHrs+EE2SuojE/CP9+jjhce8
         QlK3AfWTafyt0n/ZhdsGAxPxoAkQoty5D0NjZUT2jofMhJU++dR45cWj4GRLYuNHrJGU
         ZVG4XCFVFrUNyC/A9HcOuKkdop9LNaIUtLtIEusI7aCcfe9Fvsq18ThIKKd+hWoR4hfe
         RKzzcCVfQU9pkQHxQO7CdIz0lpIxy52abMYu3decK7VZ3Bz7tEtVQgPCMmu3piwf0Ii3
         VEZQ==
X-Gm-Message-State: APjAAAVRO6R5xQzX/J6Zj5+iHFtdlMC/5jplWz/pDppSyjU+mui8zEPN
        UWXhhT1zrvPz/SVI7v4EU/U=
X-Google-Smtp-Source: APXvYqySJ1mVA8GP6JZvQeM4gxBYpDt/0ZZ2bRmlFqnRwmVjFLE7YWX6J6VqOrkXIGhg4ExTV872Xw==
X-Received: by 2002:a62:b618:: with SMTP id j24mr5224314pff.120.1553046689009;
        Tue, 19 Mar 2019 18:51:29 -0700 (PDT)
Received: from localhost ([211.246.69.17])
        by smtp.gmail.com with ESMTPSA id i16sm352662pgk.51.2019.03.19.18.51.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Mar 2019 18:51:28 -0700 (PDT)
Date:   Wed, 20 Mar 2019 10:51:24 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Stanislav Fomichev <sdf@fomichev.me>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Shuah Khan <shuah@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [PATCH] bpf, tests: tweak endianness selection
Message-ID: <20190320015124.GB4718@jagdpanzerIV>
References: <20190319023331.23207-1-sergey.senozhatsky@gmail.com>
 <20190319160115.GD7431@mini-arch.hsd1.ca.comcast.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190319160115.GD7431@mini-arch.hsd1.ca.comcast.net>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On (03/19/19 09:01), Stanislav Fomichev wrote:
> > diff --git a/tools/testing/selftests/bpf/bpf_endian.h b/tools/testing/selftests/bpf/bpf_endian.h
> > index b25595ea4a78..ba06222963d5 100644
> > --- a/tools/testing/selftests/bpf/bpf_endian.h
> > +++ b/tools/testing/selftests/bpf/bpf_endian.h
> > @@ -20,38 +20,17 @@
> >   * use different targets.
> >   */
> >  #if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
> > -# define __bpf_ntohs(x)			__builtin_bswap16(x)
> > -# define __bpf_htons(x)			__builtin_bswap16(x)
> > -# define __bpf_constant_ntohs(x)	___constant_swab16(x)
> > -# define __bpf_constant_htons(x)	___constant_swab16(x)
> This breaks the build until your next patch is applied (in other
> words, breaks bisection). Can we do it in three steps?

Bummer!
I thought about applying the second patch (flow_dissector.c) first
and then the first one (bpf/bpf_endian.h).

> Convert to swab (without breaking existing tests), convert the tests,
> remove unused __bpf_xyz defines?

OK.

> Could you also send it as a series (git format-patch --thread)? Those
> patches depend on each other. And pls use [PATCH bpf-next] ... subj.

Right. I figured out that I also need to patch flow_dissector.c after
I sent out bpf/bpf_endian.h patch.

Sorry about that, will fix.

	-ss
