Return-Path: <SRS0=ObQj=7J=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26349C433DF
	for <bpf@archiver.kernel.org>; Wed, 27 May 2020 17:35:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EFF0520707
	for <bpf@archiver.kernel.org>; Wed, 27 May 2020 17:35:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dCGTihIt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391263AbgE0Rfl (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 27 May 2020 13:35:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387837AbgE0Rfk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 27 May 2020 13:35:40 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 649ECC03E97D
        for <bpf@vger.kernel.org>; Wed, 27 May 2020 10:35:39 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id 14so183081qkv.16
        for <bpf@vger.kernel.org>; Wed, 27 May 2020 10:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=5pjnryafVyy4mvARp4PLvV79vSG5/akHWFEPy2KlnO8=;
        b=dCGTihItQsGdYpyiMxMhs9bG07VqaX7OZDpHdEgQ/I0ws6IWqscrTrbKj7KnmVsugx
         L85ohmrQrYqgB5F/1TCwKCYf3AIZSNRBUSzHYw9Cv+cYNiaPGQTJOtCx6Iyy6r5S+Tga
         k3naGklZtQ4/a4uIwun19KNN7T+1Gu0qn2nCn/TxTvkB/XDzhBiAnAcJ6XDv2vi7oi1Y
         6j65zq5TwYq8Hp9V7VLehld2v2x9RUZLLvBHRu6pJzniue+UazeBwON5gfDoBqnduqAg
         zY+LIu4ln8I+LP3bWh1a+HzcJYPs8Q5Kgsry75N+g3/Y9nrTmpGzAZijFMX43oyWWwNH
         3aQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=5pjnryafVyy4mvARp4PLvV79vSG5/akHWFEPy2KlnO8=;
        b=Ods+d2gjERSIyboarJpGokA1r4J9ZcP8kM37qNh1+ZRdANPNsAKdn1cBs4ycVNymsh
         r2NfmeLccV+yOio86G6B+bWYdPnwAZT71lMkdkP5ek+JRvEjURXr7cu7PBHtyGGd8a3L
         VdfpM6F1eoBZ4e9QaH4sGPSh6ANK3673WqCZFTLYTEIU68V6ruefxlRpBA6VROyI0LNO
         wgHzcdErMMEQwUXZBKtIeT6aSMePQLY97jBQJWaJAvFzsFWo8im+U02R+/CJHJYYUSKz
         0GJcCX51Y0D1Ulg2DxVZuXwrpJpfgB2oPK82NEU88ol7N2nviXzlueuH8NjPwCi7goSe
         fwmg==
X-Gm-Message-State: AOAM532vwpVemjI2N1Bg6CfQDsyMZ0uZ10BKzmDR6Ex130BZlWPdZcWQ
        BCp3JN3M/RYxao+LGLEO8XEVWEo=
X-Google-Smtp-Source: ABdhPJwP0e9h28WtLMf45Hus656qDYeDO+Q/IfiFF60rc2z7Uf9u2AXgp8ITZaNsqnb7aOyvExdPpjA=
X-Received: by 2002:a0c:fb0e:: with SMTP id c14mr12165721qvp.63.1590600938582;
 Wed, 27 May 2020 10:35:38 -0700 (PDT)
Date:   Wed, 27 May 2020 10:35:36 -0700
In-Reply-To: <20200527170840.1768178-2-jakub@cloudflare.com>
Message-Id: <20200527173536.GD49942@google.com>
Mime-Version: 1.0
References: <20200527170840.1768178-1-jakub@cloudflare.com> <20200527170840.1768178-2-jakub@cloudflare.com>
Subject: Re: [PATCH bpf-next 1/8] flow_dissector: Don't grab update-side lock
 on prog detach from pre_exit
From:   sdf@google.com
To:     Jakub Sitnicki <jakub@cloudflare.com>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        kernel-team@cloudflare.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 05/27, Jakub Sitnicki wrote:
> When there are no references to struct net left, that is check_net(net) is
> false, we don't need to synchronize updates to flow_dissector prog with  
> BPF
> prog attach/detach callbacks. That allows us to pull locking up from the
> shared detach routine and into the bpf prog detach callback.

> Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
Reviewed-by: Stanislav Fomichev <sdf@google.com>
