Return-Path: <SRS0=IWuG=RQ=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28EE0C43381
	for <bpf@archiver.kernel.org>; Wed, 13 Mar 2019 21:21:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E55242054F
	for <bpf@archiver.kernel.org>; Wed, 13 Mar 2019 21:21:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ViLYiMmB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727187AbfCMVV6 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 13 Mar 2019 17:21:58 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:33628 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726994AbfCMVV6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 13 Mar 2019 17:21:58 -0400
Received: by mail-qk1-f193.google.com with SMTP id x9so2084280qkf.0;
        Wed, 13 Mar 2019 14:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Sin21Y5zxCdKvCbMTCPYdWjniTBQ/YASC2K22GISZkM=;
        b=ViLYiMmBjhxpyP7NTHNpUMCqx9Cng15DoM4YuZGwpH61hVwNkQNSC+fehoFBJL01BH
         PQL7uMwBfy8iLrUhumRr18k59hgwHiCtPJ28KwRE0VSPm1TGh2OEfHeifQYdZHd+PyOM
         +YR60z6PyMze+1mxTt709YWXdM4fPOcnyGndohJyU06XKAjUPqIRJAMswwxxth/Y7Ikz
         hEmgfhYcGQ/8J0t+QUlT4UfmYC2UC/9digPp9Yu7vAYRCVD25nMg/tCpCPsn1eww8OLC
         0uJDogF7xiexZUy34d9VzIRhfN5qmCozRvrBh5bmMZmGusulk5iVCu9TZ86CrzqVvqjJ
         atXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Sin21Y5zxCdKvCbMTCPYdWjniTBQ/YASC2K22GISZkM=;
        b=RmG3aRS8yXB2CJQhsPrdScikJuNAVL/wvoF/jKxYBXylyC+LFZ4ZvBOiaovBC8n4rr
         sPlzIgeoL/M4PpbwsnWE7nMNDKV3hYFE1UgsMN7DE00TeFrYibnuhVOzN2LLZaI76hyS
         NgN6693eiL+1buRJ8/PSJWlTY4Zjw0oAMewflF9qew8kWyRJn0jFP2XQJQKAoGdn26qX
         8x/Cii5ZYPhQc3+X3vmjpqg9s+ONjPSkHZJVRn+B/CuXv+JsYRgMSmQ+sDZbat0F/07k
         NR8y3AjwV/KWCzY9BN5R4Ah5TeZdOjv9AUu7ZcM4i8oC4uDquWRwF6dPAsQdMm3gM9t8
         0GBQ==
X-Gm-Message-State: APjAAAUKQjVVCiunAJpYA6sJEnr8ch+NEpTsz8by18yBpI0O/0KVvD+f
        5dCWzQu0jr81mVEx3B+RdqY=
X-Google-Smtp-Source: APXvYqwyN31ei6e1EDsd0NTVwAlw0DqupfImuHC7OumT7qP2zzRuohxOrYKbJ82yIpLp1ngMCjFCZg==
X-Received: by 2002:a37:c20c:: with SMTP id i12mr14017307qkm.94.1552512117158;
        Wed, 13 Mar 2019 14:21:57 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.35.11])
        by smtp.gmail.com with ESMTPSA id 24sm8835153qtu.17.2019.03.13.14.21.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Mar 2019 14:21:56 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 4A07E4039C; Wed, 13 Mar 2019 18:21:54 -0300 (-03)
Date:   Wed, 13 Mar 2019 18:21:54 -0300
To:     Andrii Nakryiko <andriin@fb.com>
Cc:     andrii.nakryiko@gmail.com, dwarves@vger.kernel.org,
        bpf@vger.kernel.org, ast@fb.com, yhs@fb.com
Subject: Re: [PATCH pahole] loaders: strip away volatile/const/restrict when
 fixing bitfields
Message-ID: <20190313212154.GD4786@kernel.org>
References: <20190313165301.2739423-1-andriin@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190313165301.2739423-1-andriin@fb.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Wed, Mar 13, 2019 at 09:53:01AM -0700, Andrii Nakryiko escreveu:
> btf_loader and ctf_loader didn't remove const/volatile/restrict, so
> bitfields using modifiers were not adjusted properly.
> 
> This patch abstracts logic of stripping aways typedefs and access
> modifiers into tag__strip_typedefs_and_modifiers, which handles any
> interleaving of typedefs and modifiers. dwarf_loader was adapter to
> reuse this function as well, instead of custom goto loop.

Thanks, applied.

- Arnaldo
