Return-Path: <SRS0=J20p=SM=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93767C10F11
	for <bpf@archiver.kernel.org>; Wed, 10 Apr 2019 17:30:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 557EB20850
	for <bpf@archiver.kernel.org>; Wed, 10 Apr 2019 17:30:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Krk6JoUx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729226AbfDJRa1 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 10 Apr 2019 13:30:27 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:50499 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728692AbfDJRa0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 10 Apr 2019 13:30:26 -0400
Received: by mail-it1-f195.google.com with SMTP id q14so4836412itk.0;
        Wed, 10 Apr 2019 10:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5TIt5GPcRrei032vfth6Md2qvVtzE3bA9YK/vF3benc=;
        b=Krk6JoUxzBEm5V4EzDxi/XwA4/kWxfEuGBmrEuAo5Tb+swAiOEBqPjOKl9tUxsXhIJ
         emRI36eXvF5ybGtlR/RL+87rj4w4QA66uNpjaa7ZXBIhbYfECkeJgD9rssIMdNNkpmkw
         okpWFDGP8kUa2nd1MqvpDgkTHaS7pkv3u7mYgF6ES3yHlyDJiyRwwZNQCvA+b6yq5L4F
         FOcAQaXZZdu2kYqx4gBbOoqLcrTEqqnHmHh56VW5lvY7xbPoz5JOkGikqG4kJEZdQbXo
         6OJCO6O8vC9twZ8QiD1Ut3pqFt9wwklGtdzHkl4IuyVlEXmYkIoEuox2jE1q+6YZTypH
         qZtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5TIt5GPcRrei032vfth6Md2qvVtzE3bA9YK/vF3benc=;
        b=dFkSbH4OnZd7TgPUUriB56fHv9gZYvMin8jlHssBOC6PWyqoUFO/cjObVti+BCqKUY
         lOWMNlLFWoJo0VTzI0E+j3jtaZfHgC5kwH9Ntt8edP7BPqZA5ojLptGqE2/xs8CmbaTm
         S1U6TiNx8oFb/ff16Y3EqTZkRWhz7F4572YNoBWxZK0g4mFSBILX5ZvdmK2Oeg4klrJ3
         zSgM6WxDslsCuZ4P5ojCQTwQTawEnRo7bTDZuf7QW3rNyI1ilGcKQLyqgWBdVnJHWWAM
         m+H1o8l3FCPSGgkYnZTbm6DGVuJLV/Bj3nXr4njTdTa6VArsCp3jaTFnk3ZHczhxkO5Y
         QFnw==
X-Gm-Message-State: APjAAAWy5X4yJX0uD8TItSGdISMthxWuPbsvu8xD5Msgl+jp6CQpYGsC
        P8bHWSM+jxWZTNP26V98jhxXTEtWNha/0Nm4Dmg=
X-Google-Smtp-Source: APXvYqyzSDPgtSBPuJ14uOTIWYb4NUWbmjIJQE7jrFTqQwMSLS+CK4a8QyR1l6tN7mWxVIoDEd/zSgrMNAYObifGAR8=
X-Received: by 2002:a02:9a02:: with SMTP id b2mr32352270jal.120.1554917425931;
 Wed, 10 Apr 2019 10:30:25 -0700 (PDT)
MIME-Version: 1.0
References: <1554879256-30587-1-git-send-email-magnus.karlsson@intel.com>
In-Reply-To: <1554879256-30587-1-git-send-email-magnus.karlsson@intel.com>
From:   Y Song <ys114321@gmail.com>
Date:   Wed, 10 Apr 2019 10:29:49 -0700
Message-ID: <CAH3MdRXkQzN3srL1Bmkf18Tvb7Uk1M6XQFDog7eA-fPa38Cpog@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] libbpf: fix crash in XDP socket part with new
 larger BPF_LOG_BUF_SIZE
To:     Magnus Karlsson <magnus.karlsson@intel.com>
Cc:     =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@intel.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        netdev <netdev@vger.kernel.org>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Apr 9, 2019 at 11:55 PM Magnus Karlsson
<magnus.karlsson@intel.com> wrote:
>
> In commit da11b417583e ("libbpf: teach libbpf about log_level bit 2"),
> the BPF_LOG_BUF_SIZE was increased to 16M. The XDP socket part of
> libbpf allocated the log_buf on the stack, but for the new 16M buffer
> size this is not going to work. Change the code so it uses a 16K buffer
> instead.
>
> Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>

Acked-by: Yonghong Song <yhs@fb.com>

> ---
> v2: simplified code as suggested by Daniel Borkmann
>
>  tools/lib/bpf/xsk.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
