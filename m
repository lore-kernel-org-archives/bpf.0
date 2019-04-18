Return-Path: <SRS0=qXn4=SU=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D263C10F0E
	for <bpf@archiver.kernel.org>; Thu, 18 Apr 2019 23:11:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 579F220675
	for <bpf@archiver.kernel.org>; Thu, 18 Apr 2019 23:11:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SgR+UfR2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725894AbfDRXLx (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 18 Apr 2019 19:11:53 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:41832 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725887AbfDRXLw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 18 Apr 2019 19:11:52 -0400
Received: by mail-lf1-f66.google.com with SMTP id t30so2803870lfd.8;
        Thu, 18 Apr 2019 16:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w4swCaiPCj1c1c3EtcgDMRehIoIdfL3ZTGvBmiQbVfI=;
        b=SgR+UfR2a8CkZzr7upD7ry0bFwSHaQ7a6Q+VHc1CGmbAs3ntf/JxOqeug0GAwJm2YG
         U/VRXkO3z1Y4ChygSkdSIP7hYSdS0iipZ98I+FZfCQQEgpcAPnWFeM3yA8ymTP8pL9/p
         WW0IWOF5q9dOwhp33VLV8Ee3ihIlybhSLZBLdgn+v+dndiE3E10Bk6PFUXM/dGQ5+Fpn
         ZcjYINc5cjd/43rU8eVgUOigVwRu0I/lUxDNN+jV1qX+jbOVD0xDQ1IUgwSgVddHt2IP
         jnfIQ8cEFbHUqAeZlturazAmevBiFtP+8osCzRxF1kV6r7Zsx4wYYSz41VbU34tnojme
         opTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w4swCaiPCj1c1c3EtcgDMRehIoIdfL3ZTGvBmiQbVfI=;
        b=niqzlIljtDCkIwERBXxNAtoc/spl5J6p3FraeSh09C3tyC6W3gQYGq+aR2/6FK5mr4
         wF7mdxfOrqThxL0sSAXpmLZaDL3VOcBBMJMQH31zcaeHD4A+GvAOwNa22Rr+wZxhT6S3
         epgJ72Ra8r1zXAnzDowzyQ5R/LyYH6Yoyw9R4McyuIhzAPVBJjREBnRhR8F0YexuDx3m
         dNpWJX7kAapZM00Afba9cC43jNrJCGrCEbrOKorhBbWO6SJ+3BYKFDHPs1v5KdbWV5QC
         A0ZGEPHqI3edZ8yxckzTUsYrsI408nap/s2tdK6guP9vqf4glRd+aleQsXbeo9xyWJ6i
         cQ0Q==
X-Gm-Message-State: APjAAAW1+jHmWW+Rlhn8+MAE3qKKI3lTSjiwF+Q6oqDhuk7b7CyvZK2r
        uWjWdBC8ujWRCSKH6f5vihS2y+4p/+dOJbcJpV1h9g==
X-Google-Smtp-Source: APXvYqy8hNkRuD1+3joTe7eEKs12PKTkrTzZkoQcANkDZ3pfkxK3s/p4bYclNwrts98ioFu2f+cTUyrhHQHMQ60VFug=
X-Received: by 2002:a19:c216:: with SMTP id l22mr370664lfc.112.1555629111071;
 Thu, 18 Apr 2019 16:11:51 -0700 (PDT)
MIME-Version: 1.0
References: <20190418213330.225474-1-kafai@fb.com>
In-Reply-To: <20190418213330.225474-1-kafai@fb.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 18 Apr 2019 16:11:38 -0700
Message-ID: <CAADnVQLgamdSPvfwOmKkLu-SgF7Vv=xwFyZ-+VAWGPs=iLQY2w@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Increase MAX_NR_MAPS to 17 in test_verifier.c
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     bpf <bpf@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>, Yonghong Song <yhs@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Apr 18, 2019 at 2:34 PM Martin KaFai Lau <kafai@fb.com> wrote:
>
> map_fds[16] is the last one index-ed by fixup_map_array_small.
> Hence, the MAX_NR_MAPS should be 17 instead.
>
> Fixes: fb2abb73e575 ("bpf, selftest: test {rd, wr}only flags and direct value access")
> Signed-off-by: Martin KaFai Lau <kafai@fb.com>

Applied. Thanks
