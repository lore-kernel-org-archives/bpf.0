Return-Path: <SRS0=TRWS=3N=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94F95C3F68F
	for <bpf@archiver.kernel.org>; Fri, 24 Jan 2020 09:53:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AB4D214DB
	for <bpf@archiver.kernel.org>; Fri, 24 Jan 2020 09:53:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XI21VxhI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388266AbgAXJxc (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 24 Jan 2020 04:53:32 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:24667 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2388276AbgAXJxb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 24 Jan 2020 04:53:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579859611;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=K4t1ejswvOE8YpSGKPzSa4YPCF/SE/Nt+MqgosBi2Qk=;
        b=XI21VxhIGwSyepACeyH5nb+9+uif9aipIvSLxlvMjGczWq4E0aF46BgY296xAGXMe6xxUf
        Maq7DD7xHp1EGIsfH5vHWQ3iCOtRSYWYoKlzy3Ml3kABb9f0lK28bdCRaD3WDvV8wwT3lC
        cRHvilrL1a34SlcmUPhYeAyGHe7oNoU=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-301-MKwuqPpzMAyL0uTFOsX9yw-1; Fri, 24 Jan 2020 04:53:28 -0500
X-MC-Unique: MKwuqPpzMAyL0uTFOsX9yw-1
Received: by mail-lj1-f200.google.com with SMTP id t11so498282ljo.13
        for <bpf@vger.kernel.org>; Fri, 24 Jan 2020 01:53:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=K4t1ejswvOE8YpSGKPzSa4YPCF/SE/Nt+MqgosBi2Qk=;
        b=eJW7WKGMGqZ0TAbGdaZONLme3b/8piVlucmW3rYT3XCVDf5wJacrcdacOdyAm4+Mq/
         CxAehzvuLKwKWhvgh0KZCv7WJV7znb0ZocGET69X6b4aoWAfb0ZTOf1CAjgKZNmRMFK9
         6nB/c170ddPJrQCXl/AVo89mzyjXAad+Ws5GuMzggWh7CbI9mRsG/EgJ0TZE+5PEU/WC
         fWAvR8JC2JGNtR6aX5aj3digRxIphJHr6O/qTyP3qDTNkvTxmOtp65M8w3zWBUTy1v7c
         W+cNZgbUXeLlqUH+m3CtHeJaDEp39xDiYIbEBp5R31hA5dOjy/JA6co0UlQLts7JFf2h
         UemQ==
X-Gm-Message-State: APjAAAVrse14HF6892O6RXVGQqLjnT9eTRnK2LaTAcDxMFVx5lIhISgb
        D3x6vyymKAuU1Jz2MI0HahEfqDj8JywZx6RrguVoVXo2S+XZmP5Ib7+UKSN7fPi6FMPhn55oiCb
        oX7QP7UIwGUoT
X-Received: by 2002:a19:7401:: with SMTP id v1mr1007725lfe.129.1579859606821;
        Fri, 24 Jan 2020 01:53:26 -0800 (PST)
X-Google-Smtp-Source: APXvYqwQhJNQcaaDcM834fVbk7QurTLRj5MsyegI59sBDkZiVOmXuoqHNrXEWKdwQ6zpuD/sqWaBBQ==
X-Received: by 2002:a19:7401:: with SMTP id v1mr1007721lfe.129.1579859606635;
        Fri, 24 Jan 2020 01:53:26 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([85.204.121.218])
        by smtp.gmail.com with ESMTPSA id q10sm2776696ljj.60.2020.01.24.01.53.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2020 01:53:25 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 622D1180073; Fri, 24 Jan 2020 10:53:25 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Andrii Nakryiko <andriin@fb.com>, bpf@vger.kernel.org,
        netdev@vger.kernel.org, ast@fb.com, daniel@iogearbox.net
Cc:     andrii.nakryiko@gmail.com, kernel-team@fb.com,
        Andrii Nakryiko <andriin@fb.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: improve bpftool changes detection
In-Reply-To: <20200124054148.2455060-1-andriin@fb.com>
References: <20200124054148.2455060-1-andriin@fb.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Fri, 24 Jan 2020 10:53:25 +0100
Message-ID: <87wo9hgoyy.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Andrii Nakryiko <andriin@fb.com> writes:

> Detect when bpftool source code changes and trigger rebuild within
> selftests/bpf Makefile. Also fix few small formatting problems.
>
> Signed-off-by: Andrii Nakryiko <andriin@fb.com>

Thanks for taking care of this!

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>

