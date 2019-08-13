Return-Path: <SRS0=vYPl=WJ=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECE25C32750
	for <bpf@archiver.kernel.org>; Tue, 13 Aug 2019 23:59:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B51E020840
	for <bpf@archiver.kernel.org>; Tue, 13 Aug 2019 23:59:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="GfIUpV2W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726365AbfHMX7O (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 13 Aug 2019 19:59:14 -0400
Received: from mail-qk1-f179.google.com ([209.85.222.179]:40337 "EHLO
        mail-qk1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726102AbfHMX7O (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 13 Aug 2019 19:59:14 -0400
Received: by mail-qk1-f179.google.com with SMTP id s145so81211216qke.7
        for <bpf@vger.kernel.org>; Tue, 13 Aug 2019 16:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=puwKGvMHBRGGwnXpTzyxte5//PO1DQzRFyAR88F1LHM=;
        b=GfIUpV2WFfIt/TZJG9RCEnWkYQWE4g5TCogARMUD7cy5ZSagkbIfo7Dd3D/1DdT69M
         6UguVvy8mIpio/oCU4CpkFacBdyVe+rykoBW/imDUaE5hm3Z0Z+47cB7ob/pJHC4SOoj
         mOjY1fQdsfIZ9X2v2409xfU+DZ6RqIh+qD8MQnJRd/f+UwzQbwM+8OaHlEKcr+3OJ4a7
         sIpc9I5LtkH9g9o8j/yKPD1lHJdYCoB7VBHIAu2vO8WhHjNyIK+b/UimurjkRL9uF+rL
         S5w+2G8J29uu1W/yVn7c2UT+7pD2ak4tsZKXpUyYnQ2B4I8j2IQBol78m+0o9OArsRH2
         E41A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=puwKGvMHBRGGwnXpTzyxte5//PO1DQzRFyAR88F1LHM=;
        b=Z0q1Ju7R6oV6Ex9yHK63l64P4Etfsf2cH4ZhH+ZQrWPNPY/IbRIV2W6yeuxu88DrDH
         lXujWFDnWaGlUyLtqevfkA44v5kbTUAcEvWZ/oQvu2+SRuvesSXABpAp4I607r6DuI0u
         JvuWUh6bAZ9aeW3Rry0a+y5s9NNnMgtyuzS9dxfQTRBGLutG5rH/zZdAUNdFXX90FUoZ
         WkwnE01CzmjVL+vQtQrd7ck+LzzAdFQLKfO713nr9gLeHZTERH3i5JvtKVe93uU8ElVu
         kjMKsaU7iCUJYCWiGLs0h4rPtUaJZQtFwzcZh4UxuTFTP+Gl0+aTtZT/4UL1ryPMKW2v
         PrXQ==
X-Gm-Message-State: APjAAAVl7QvidnFpxdlNILMYfzRezj8Zj/7VEwOcdjq16UtEV3/IbjDS
        KSWL5orVJCkXQhZjlYM0pUsPWw==
X-Google-Smtp-Source: APXvYqxNDfm93dGm8rKT57NcptHKGxkf0EPwpFoD7YNZ0cXT33fvXUY9sdVbitMxp6dCM5dgryvRhw==
X-Received: by 2002:a37:bac3:: with SMTP id k186mr12613qkf.61.1565740753019;
        Tue, 13 Aug 2019 16:59:13 -0700 (PDT)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id j184sm44248666qkc.65.2019.08.13.16.59.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2019 16:59:12 -0700 (PDT)
Date:   Tue, 13 Aug 2019 16:59:02 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     davem@davemloft.net, ast@kernel.org, andrii.nakryiko@gmail.com,
        netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: pull-request: bpf-next 2019-08-14
Message-ID: <20190813165902.41da0730@cakuba.netronome.com>
In-Reply-To: <20190813231639.29891-1-daniel@iogearbox.net>
References: <20190813231639.29891-1-daniel@iogearbox.net>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 14 Aug 2019 01:16:39 +0200, Daniel Borkmann wrote:
> Hi David, hi Jakub,
>=20
> The following pull-request contains BPF updates for your *net-next* tree.

Pulled, let me know if I did it wrong =F0=9F=A4=9E
