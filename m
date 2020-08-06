Return-Path: <SRS0=fFcV=BQ=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 603F8C433DF
	for <bpf@archiver.kernel.org>; Thu,  6 Aug 2020 23:57:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5491A204EF
	for <bpf@archiver.kernel.org>; Thu,  6 Aug 2020 23:57:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WgXA67LC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726130AbgHFX5t (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 6 Aug 2020 19:57:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726027AbgHFX5t (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 6 Aug 2020 19:57:49 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 173F8C061574;
        Thu,  6 Aug 2020 16:57:49 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id i80so57688lfi.13;
        Thu, 06 Aug 2020 16:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ouBAvOKZrTg4PSEgOb7kFgQ9N7F4V+Ghtb63tkJxvpc=;
        b=WgXA67LCd2a2NXQvmgeGOXVGFcNPNwV35W14nDHtVT5B3okM61s3EvormTFOqy1bD1
         +6phJN6V7Z7v97ZutOQqBaK1aoLW69AZYvHz0DT2IxGOMA4Y5C2M7/u6CQ0L5CMPxbxj
         5PTOiB29uUvbRd2wF4V/bxdtB6dsPF8ZvGyy8w908M+enmtIBJqqno1QWwl62TL5npHa
         MIuWTbaxQISzZKdkS7wGnWhU9WYZvDa93RU6ri902JzivkkTaAxzyx7lw4oMCcPAZHw6
         qphPzCU6SQYO8ROB4g/k4o8Yj0c+qPoEU+3TzdfiruKQCFC3V0te/HC0/w2T5fI8EUq1
         IhLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ouBAvOKZrTg4PSEgOb7kFgQ9N7F4V+Ghtb63tkJxvpc=;
        b=S49I1Ds5atR3DynRnzNYRwiIYi2X1q2qjogzG11uwAQ2P+duI0WxSmQMlYAhaITHCL
         tYtPOs3clSpilGBGQq2r9CQg0UvEFyCBplennvPYPJbGJ3TrWb+OLgHyjIgSFTOL95ph
         qhuSHYQqwyp/NsEsLwxIeQu4/uM5Zef6rRUt6OJZFPOZtH/s7l7oP0Con4ff5GkdYfmY
         qhwTFEd3A9AxUUH2LuIBn4c6abrG1nSuD5Bw750nHt9GVg29WX8gLqrDlMMPLzW41WzE
         rp+OR9bAzskSqrAqcMbIDqgtu5+uigfsLlKl8KLTY6MN54x0fGzi/SD1ezTM8JpPjqlR
         xblw==
X-Gm-Message-State: AOAM531lE0gmB6K5+59hizJwXkRKbUMvqFSZXAMm5chMEZVq2+H+cTN+
        XcZoqZ9H5L8HqpKeW7/xBR3U+67r3LkVCO/h03Q=
X-Google-Smtp-Source: ABdhPJx6msrXwaQ5f484ydZpSr77WXauMkFhHZvxrLpt3btWKEWLIO7vM6f0xkkLPBQycp0gxzDUBYPl/8YhUV/j/oQ=
X-Received: by 2002:a05:6512:74b:: with SMTP id c11mr4871237lfs.119.1596758267443;
 Thu, 06 Aug 2020 16:57:47 -0700 (PDT)
MIME-Version: 1.0
References: <7a9198ed10917f4ecab4a3dd74bcda1200791efd.1596739059.git.jbenc@redhat.com>
In-Reply-To: <7a9198ed10917f4ecab4a3dd74bcda1200791efd.1596739059.git.jbenc@redhat.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 6 Aug 2020 16:57:36 -0700
Message-ID: <CAADnVQ++gwpScZkkaXMpEdt72tabeEFW+gozh4gXZG_1bV3J2Q@mail.gmail.com>
Subject: Re: [PATCH bpf] selftests: bpf: switch off timeout
To:     Jiri Benc <jbenc@redhat.com>
Cc:     Network Development <netdev@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Aug 6, 2020 at 11:42 AM Jiri Benc <jbenc@redhat.com> wrote:
>
> Several bpf tests are interrupted by the default timeout of 45 seconds added
> by commit 852c8cbf34d3 ("selftests/kselftest/runner.sh: Add 45 second
> timeout per test"). In my case it was test_progs, test_tunnel.sh,
> test_lwt_ip_encap.sh and test_xdping.sh.
>
> There's not much value in having a timeout for bpf tests, switch it off.
>
> Signed-off-by: Jiri Benc <jbenc@redhat.com>

Applied. Thanks
