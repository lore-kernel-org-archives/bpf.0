Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E07CC433F5
	for <bpf@archiver.kernel.org>; Thu, 17 Feb 2022 18:55:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240446AbiBQS4B (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 17 Feb 2022 13:56:01 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237163AbiBQS4A (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Feb 2022 13:56:00 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D1FC58399
        for <bpf@vger.kernel.org>; Thu, 17 Feb 2022 10:55:45 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id e17so853122ljk.5
        for <bpf@vger.kernel.org>; Thu, 17 Feb 2022 10:55:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vu8A5HA8xXgQWRXtk0eL/iZTbM1NfHkZSIXuMCdz2kg=;
        b=QIAR+MdCpchUk8HUvFVhdqYIRatBHpoLnwR9LxpWFxk+NfR/kMYr2o9qxchCAYWpSA
         a1WQBakOJiFMOrA3gRc2cC9eQlU4YaQPPdZ9ipjjh7mEhZzbtyYScELHrkHMZpZvE5W5
         it6fZSv0B6GGnXjfjUMObodVQXmj13VGx8xnhU008B7MCIOBNYqIFWbXB5yzM+GkF/mO
         RwfmTztRC4ot5KNm1tJWqhXwIkTG6cB2NUtX8EBICwRvHZRxfXYT5HFEWyvk/Yld0o8Y
         siw65cFv0FyXOZKWBEBBCMKEqnwQlR50QBgRAZ35+IZFbTo/cYwpA9oOEy5do5geOEEl
         R1fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vu8A5HA8xXgQWRXtk0eL/iZTbM1NfHkZSIXuMCdz2kg=;
        b=qn4Z7114Fnarvn9pBsisnfJCsIjHVXN0DOaNJpcYvY+Y5oyHTcbifDw6lr1kZDqxkk
         M8CAFmtZpZS4MyEoWprpAoJbyrZhcPoRTBjpvAQnhJxdD0JpONHoym4o0pGcU0dtZ7ic
         u40GnEeSH/V7kLxFp/1bDORpoi6NyFpMFVwjPmPGEFpI0DdlKaUHJvEZkqZRmeujdsY5
         yshbERzyd+xCTPZo3ykLMT/5wumQuuHXN32LE3pT71xK8DcZwjz6htV3d9UNqKS2pJ1s
         DXWI3vd8o6bWTEHznRrjamvYiXDYnJ8zandODwgIFcOthuInaXDSDlP7xxWbe0C8eeMJ
         q7wg==
X-Gm-Message-State: AOAM533NV5ZYnzRd3o7XDwrVYSfswi1Um9LepCfAlFY41e8LPYWA4kNJ
        OxtDYg5TudfRhX2ZVOXYh0jYGhzxu21od8f+s/w=
X-Google-Smtp-Source: ABdhPJwWGn2ebHOhi4Y2jxL9kD7oiahZY+aueA8C2vJEclsADcIGUUHygAHobAYiReBgGx3zbZ4rSUGfhrqnEy2WkdQ=
X-Received: by 2002:a05:651c:1411:b0:246:187:4cd2 with SMTP id
 u17-20020a05651c141100b0024601874cd2mr3104951lje.299.1645124143581; Thu, 17
 Feb 2022 10:55:43 -0800 (PST)
MIME-Version: 1.0
References: <20220217180210.2981502-1-fallentree@fb.com> <20220217183253.ihfujgc63rgz7mcj@kafai-mbp.dhcp.thefacebook.com>
In-Reply-To: <20220217183253.ihfujgc63rgz7mcj@kafai-mbp.dhcp.thefacebook.com>
From:   "sunyucong@gmail.com" <sunyucong@gmail.com>
Date:   Thu, 17 Feb 2022 13:55:17 -0500
Message-ID: <CAJygYd3m0_EkqD8DepPLX0rk48BO0TwHkqJ81KRfOvaygMg9_w@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: fix crash in core_reloc when
 bpftool btfgen fails
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     Yucong Sun <fallentree@fb.com>, bpf <bpf@vger.kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

> Should it be:
>                 bpf_object__close(obj);
>                 obj = NULL:

No, the actual crash is caused by this line:
https://github.com/kernel-patches/bpf/blob/bpf-next/tools/testing/selftests/bpf/prog_tests/core_reloc.c#L896

When run_btfgen fails, the obj contains uninitialized data and then
bpf_object__close(obj) crashes.
