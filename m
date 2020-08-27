Return-Path: <SRS0=MPUm=CF=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F74FC433DF
	for <bpf@archiver.kernel.org>; Thu, 27 Aug 2020 16:49:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E4FC022CBB
	for <bpf@archiver.kernel.org>; Thu, 27 Aug 2020 16:49:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZTLNUEBG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727046AbgH0QtU (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 27 Aug 2020 12:49:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727883AbgH0QtS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 27 Aug 2020 12:49:18 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1022C06121B
        for <bpf@vger.kernel.org>; Thu, 27 Aug 2020 09:49:17 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id k4so5432828ilr.12
        for <bpf@vger.kernel.org>; Thu, 27 Aug 2020 09:49:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=v9ZyGHwAqhd4TejFabDc6/PzC/u7N902eASqly8StkU=;
        b=ZTLNUEBGYrrFPRLYpDlQNCn/VXu5DlNjkXlWLdjYdlKI+Miqmm9KKLX5ebyDG6joSd
         YjnGdwjqSX+zUX6Xde0DWGLTeiS5rw5d6Uapq8mcBLX37RIZ49Rsey0T3Smvh0fOIree
         DI+ZejK3GmR7hFIwVR9HAxx8dNG+EkpCBD0YDnpy0oy0XTGM+kBBWP1XHhwpuFsTeRAS
         +IAhvXO8eteKMQQkD9JSHCzdGE+GmeW1dOepr6Lk16LKpNzY8Qicxf9K9F9A9HqgBN4Z
         WITrWsz1zievmgL+ey+64vJVGHlTck3KI3qLlBsTar7jmlJXCQeQXaczSHHg1sA9inhQ
         0WNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=v9ZyGHwAqhd4TejFabDc6/PzC/u7N902eASqly8StkU=;
        b=anaWTaJCOerAqHLLElpUMP5baxf9HN0JzyAw9HgOlSTMPnT8J3UG+ICHfTebjKQVu5
         Sfrpils5f5Aulqo4TobX5WVv+NcXm1yf29Y09z46xwRGRz6YywiHpt29xudfnFldkFDi
         Waikty2DQr0a6tNDSXlrvr7R8XSBIaBirH7bvQBGFmCdA/7txpj3hR5c0asal7YP1Pnl
         N8Khl0LMV5v5cPSZdJCX2ShJ38hJ2OdwXFJc72m4p8+APbTlsD/XoPsNLSjBl99mi3kA
         h3reA9v8eY1ryCYaTWxTmjExg+FqtJM9J152oauPfcWl6/Tw5d2ZSpafKD3x7j2+nBJQ
         0fsw==
X-Gm-Message-State: AOAM53001jl4Ag5tbLEYV7/6/JcFvtUkOU9hqrfdOs8ThAbBDtL+9JZd
        qBPNt+FyOE0zB533hnCDWL3L9lDIcIiVYg==
X-Google-Smtp-Source: ABdhPJxYZ/dD0KOxKFi3aDdy52FO303Pfjhg3gPfh6rEsjm/xuAUFmHc5+k1SzPeRbixuGEmhGDSxg==
X-Received: by 2002:a92:4995:: with SMTP id k21mr17578367ilg.30.1598546954273;
        Thu, 27 Aug 2020 09:49:14 -0700 (PDT)
Received: from Davids-MacBook-Pro.local ([2601:282:803:7700:3005:f69c:3e46:66e5])
        by smtp.googlemail.com with ESMTPSA id p21sm1446151ioj.10.2020.08.27.09.49.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Aug 2020 09:49:13 -0700 (PDT)
Subject: Re: Frozen Maps
To:     Abhishek Vijeev <abhishek.vijeev@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>
References: <CAHhV9ERe4VwPrrwDJF4xqmaeyqQqPvYaY2Wb9DEk8tf-GB_-Yw@mail.gmail.com>
 <b8a11771-7b7c-a3b1-0639-dc4706ef3ecf@gmail.com>
 <CAHhV9ERrtpmNdAmM0-evExLi=iC0wkwTByw5AqBbSQv9CbaNow@mail.gmail.com>
From:   David Ahern <dsahern@gmail.com>
Message-ID: <01775dda-3e00-708a-1433-a1facb79db3d@gmail.com>
Date:   Thu, 27 Aug 2020 10:49:12 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CAHhV9ERrtpmNdAmM0-evExLi=iC0wkwTByw5AqBbSQv9CbaNow@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 8/27/20 10:43 AM, Abhishek Vijeev wrote:
> Thank you.
> 
> To confirm, is this the only way?

appears so from a code review. I am surprised it is not in GET_INFO
response.
