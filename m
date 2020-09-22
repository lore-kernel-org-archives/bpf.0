Return-Path: <SRS0=pAHC=C7=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1658C2D0E2
	for <bpf@archiver.kernel.org>; Tue, 22 Sep 2020 09:21:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 786E02075E
	for <bpf@archiver.kernel.org>; Tue, 22 Sep 2020 09:21:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="KxEZ38Fb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbgIVJVx (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 22 Sep 2020 05:21:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726424AbgIVJVx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 22 Sep 2020 05:21:53 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AFEBC061755
        for <bpf@vger.kernel.org>; Tue, 22 Sep 2020 02:21:53 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id n61so14960098ota.10
        for <bpf@vger.kernel.org>; Tue, 22 Sep 2020 02:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OU+qS9YAG/VZrpnjQl2h8/gd+ft5/Qg3gm3naYNnkPg=;
        b=KxEZ38Fbm/om8lQTQQ9ZaiIIDdfs9Zw3UMM/XZh57RmMiSXa3JK/LNC9Mk3uo9VzlH
         qquO0CwQ0bGoTYwNqVcIHDuzXGZsRX9YX9HXD/w0zxBnh/pqwVoTIYsjJm6vi/DqzR2R
         txNBMT+AL+Oxnp+Rfeyhh5V8WI5ZY9fmC2ls0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OU+qS9YAG/VZrpnjQl2h8/gd+ft5/Qg3gm3naYNnkPg=;
        b=Oe5pvzwayNFBbEUOB07Y4p/Z3HvRPRqkC7WdOTqikyFgnxFoLM4YCY9g5AyouJwWao
         hKCK7P/+pE+E7dL/j9rp2WJeqIYZ28SZeEXx8LVkawLdYbnNHSQgzFBgvuqjbkKxYofs
         E9dOUdYmCAfDCnL7Gz2brh/rvyusODnMr+8aPYwi637nM6WyfkXEpMFH2Frb0ZyquNzi
         T4KfVoIoAZbjTnkq0nKW00lS7IQAiqjBa179pwKGuv50q6gmA3rQOjGdccLFQzcsKk2D
         07jL/A/p6lwVx0Ql3hsdN3TGsMi6dVYGLWTcSEOMivR0NeZaZ7k8tdGpVRjgXFJiaNii
         Jmzg==
X-Gm-Message-State: AOAM531EsXI7e2avE7z7iIFq1nVKU5tNNcKUsMuul/mM165MlhUj6HpG
        49Kr/759OjB72YD4E/dMk49nI+y7cfNR+d4SwJRHKQ==
X-Google-Smtp-Source: ABdhPJxWGwB4Hz1/af2msHi62jplb55obrvDl06OYMifrHK4ZzzcELLeqBmhmUTLJYELJ7w1pi3I4EgaTVHI2hE9kps=
X-Received: by 2002:a9d:6e90:: with SMTP id a16mr2113160otr.132.1600766512830;
 Tue, 22 Sep 2020 02:21:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200922070409.1914988-1-kafai@fb.com> <20200922070447.1920932-1-kafai@fb.com>
In-Reply-To: <20200922070447.1920932-1-kafai@fb.com>
From:   Lorenz Bauer <lmb@cloudflare.com>
Date:   Tue, 22 Sep 2020 10:21:41 +0100
Message-ID: <CACAyw9_XEKZ+Z2w6GLERBS4cK4aygrCJYhT50hk=vVd_XQK5hQ@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 06/11] bpf: Change bpf_sk_assign to accept ARG_PTR_TO_BTF_ID_SOCK_COMMON
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>,
        Networking <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, 22 Sep 2020 at 08:04, Martin KaFai Lau <kafai@fb.com> wrote:
>
> This patch changes the bpf_sk_assign() to take
> ARG_PTR_TO_BTF_ID_SOCK_COMMON such that they will work with the pointer
> returned by the bpf_skc_to_*() helpers also.
>
> The bpf_sk_lookup_assign() is taking ARG_PTR_TO_SOCKET_"OR_NULL".  Meaning
> it specifically takes a scalar NULL.  ARG_PTR_TO_BTF_ID_SOCK_COMMON
> does not allow a scalar NULL, so another ARG type is required
> for this purpose and another folllow-up patch can be used if
> there is such need.
>
> Signed-off-by: Martin KaFai Lau <kafai@fb.com>

Acked-by: Lorenz Bauer <lmb@cloudflare.com>

-- 
Lorenz Bauer  |  Systems Engineer
6th Floor, County Hall/The Riverside Building, SE1 7PB, UK

www.cloudflare.com
