Return-Path: <SRS0=c9tz=YX=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46785CA9EC5
	for <bpf@archiver.kernel.org>; Wed, 30 Oct 2019 19:54:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0977F20717
	for <bpf@archiver.kernel.org>; Wed, 30 Oct 2019 19:54:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ikCwF4wA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726462AbfJ3TyS (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 30 Oct 2019 15:54:18 -0400
Received: from mail-lf1-f42.google.com ([209.85.167.42]:46354 "EHLO
        mail-lf1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726269AbfJ3TyS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 30 Oct 2019 15:54:18 -0400
Received: by mail-lf1-f42.google.com with SMTP id t8so2529703lfc.13
        for <bpf@vger.kernel.org>; Wed, 30 Oct 2019 12:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2xrFQT4wFXD3Gy0+We99RGmRvXgB/nwM6Gk7dX0iJaU=;
        b=ikCwF4wAFRrcsGQNDJX1WIjPdWrSMYziMG5YlYWM9w81d3LRuP44bl3ZW/5wJqimNO
         h9k4PENAu5kMRjYsTKoucrZXRYOeajIyAIzh+kiOEhyRJrjFgfZFCNGrAVOXN8+uOP37
         pxtN8C5nvsfZ/nImnv2lMEj7MluNK466/KRrimxQNHtbsMrHzj8NjzmAARE84cU8a7PQ
         keDDZ2pJ7fuHCjHHCAEioFuMvrhpaPT8kKWUnvqzhFon0GdRv0pE7GqKVmeyYeNB7hmA
         xXrIBxb/+AjJioA7SGPP8I8F2nh83nFwK/5yAenUFJ0qBUOW8DjPRVEco9cIMXDSG06B
         wGag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2xrFQT4wFXD3Gy0+We99RGmRvXgB/nwM6Gk7dX0iJaU=;
        b=L+3NlP3A7KfA/UGL/7X4smY9MB58Rf9CMdz3ui5qykqrh775yW75kDd4NN6hXY5/LW
         1qioi9/0W2AdCHOtf3hUnWMOnvWEtdkQ1bXLAEXs5/ym0N4pfUzvIn+nUn6NzAD5Gb8C
         joU6E/fMqB6fevAzOE2WVGz+l1ZN5x0QQt32muZ7Nd6N/MfH3wnW0QSPBQhTHeqZbZJG
         TsiuKznynNcNLhhrVxaeu/u0M2lBUZzCnRhoPYc6gBzjKMj0KEIjd82jBODqicYbADrJ
         tbQdUJUCLZVCm00nk4hjpicBED64vgdBO5S519h3nudTfuWQVekp+JIZu8SM+6BO0Rrv
         UKiQ==
X-Gm-Message-State: APjAAAWqAlhyMrYAcP0xZqa8jR9/B0vawdxIjIBsm/zC/1hEpEmpx7Ca
        MOSOBLA0jTZogT16jwS6rJ7al9Rk1moHilVAH38=
X-Google-Smtp-Source: APXvYqzhDPZ0A89sJKUFRpO9O2MXhQCKNVkdsEQB4Nmk/VCvMSf9c5JolIuyahYdXFqG1XWOSPUzmLdZL7RCv2+hy/M=
X-Received: by 2002:a19:3845:: with SMTP id d5mr574624lfj.162.1572465255012;
 Wed, 30 Oct 2019 12:54:15 -0700 (PDT)
MIME-Version: 1.0
References: <20191028122902.9763-1-iii@linux.ibm.com> <CAEf4BzajQL463pCogVAnX1H5Tg-+kj9p_-mAJs=n1r6OfZ2mXg@mail.gmail.com>
 <9B04A778-42CE-4451-A276-5A41D6290055@linux.ibm.com> <20191029151615.GA83844@rdna-mbp>
 <CAEf4BzahGwFmFP6wZkLda1p68JUDJRv36XM-8uKtHLovKLNLOQ@mail.gmail.com>
In-Reply-To: <CAEf4BzahGwFmFP6wZkLda1p68JUDJRv36XM-8uKtHLovKLNLOQ@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 30 Oct 2019 12:54:03 -0700
Message-ID: <CAADnVQ+UUQfzh-hN-vn9rXXXf+qVZeLaCJQ7y_YUH2hYsTOS4w@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf: allow narrow loads of bpf_sysctl fields with
 offset > 0
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Andrey Ignatov <rdna@fb.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Applied to bpf tree. Thanks
