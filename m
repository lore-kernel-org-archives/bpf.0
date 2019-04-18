Return-Path: <SRS0=qXn4=SU=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B942C10F0E
	for <bpf@archiver.kernel.org>; Thu, 18 Apr 2019 23:08:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 298AD21479
	for <bpf@archiver.kernel.org>; Thu, 18 Apr 2019 23:08:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MJ0zouFG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725887AbfDRXIN (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 18 Apr 2019 19:08:13 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:37419 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbfDRXIN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 18 Apr 2019 19:08:13 -0400
Received: by mail-lf1-f65.google.com with SMTP id o19so2812114lfl.4;
        Thu, 18 Apr 2019 16:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ApNRfARxnCFvxgASQhaNTJ0cL6eMb5MLXMzAN9NWC6c=;
        b=MJ0zouFGjoxf2/ZNY5DlLdJFFivX6FHhQ+tEsPzrp3agEFThrW3ttbxsmaNUOJ8PwN
         qT4ZYvX4nQFqr0kRsLRqyBsE0Ub9urfNPR7CYLfy3kAvCZZeZhHzyEH1em3zLFvcXY62
         IRgALNdaVzaFrN7if5d58Yyl37m/URw1JOaEL6pBZ/D0v+8nqF7BxRO5YJLuQ5h8JkOo
         pH1rQpEIVgFmhs1YJU2j3M+rlJpo6GtMKeX1lOCaLGVeeukmsaAvpkqzMMdKRhLftGLt
         2PZF86i/r11S9aO7ad5MGdOw5B9EU6LqFHqbXloNARXY7ErMR6P+j3A1iM9Qj+WaJhGb
         ZIMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ApNRfARxnCFvxgASQhaNTJ0cL6eMb5MLXMzAN9NWC6c=;
        b=lQfKAiIfJVsLk/KP3pdwYEZNTFxuDtexKBxUC3gGSMxrSh+rDRxYk327Mj/9s/jQBr
         0BWtG1viI7FQFjrFh/ui6ez6BNCaECd8OdZbEyv4NRUbqk+rFKKSDBT/QW5pWtJzqQ/R
         5LDByq0Y3Z3l1LqxWfZE7+Jia0UQFATvWaTCu11N5w4nx7r2x/nK6BfnudoSxlSiDsaU
         LjVpwyHsLjRAouBszFIJldHgFGpGuXkugoDEDmNk2B8XiAy7h0wiu7hk13hzaEYMhUgx
         hwgmcLRrHCL2O/0sDkCSJsJ6IBXUtl63Txml3CklQtWvqjso3nt1GNybeckDnjoDGXWb
         7HNA==
X-Gm-Message-State: APjAAAXHz4ngtWAd688HF7JBvuzKRwXbrvMU9pnrDGEbw/p46Omd+dFt
        jqAtyvjC1j5uLhfyhDbXisTS3uKEX+TiTb2DXqE=
X-Google-Smtp-Source: APXvYqxwhtX75Bi02i068h7WQsAHIaFcr0Gr5afhJ15Egg7Nmd74V5h9C6Asl8agqMQWoZuhTcftqBlPVqxUpwyXBxA=
X-Received: by 2002:a19:c216:: with SMTP id l22mr364283lfc.112.1555628891292;
 Thu, 18 Apr 2019 16:08:11 -0700 (PDT)
MIME-Version: 1.0
References: <1555572070-30796-1-git-send-email-magnus.karlsson@intel.com>
In-Reply-To: <1555572070-30796-1-git-send-email-magnus.karlsson@intel.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 18 Apr 2019 16:07:59 -0700
Message-ID: <CAADnVQJCR7Hi=7MWAc4F-ERg46X9t87kGzACxrN7EUMt5PXD0w@mail.gmail.com>
Subject: Re: [PATCH bpf-next] libbpf: remove compile time warning from libbpf_util.h
To:     Magnus Karlsson <magnus.karlsson@intel.com>
Cc:     =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@intel.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Network Development <netdev@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Apr 18, 2019 at 12:21 AM Magnus Karlsson
<magnus.karlsson@intel.com> wrote:
>
> Having a helpful compile time warning in libbpf_util.h is not a good
> idea since all warnings are treated as errors. Change this into a
> comment in the code instead.
>
> Fixes: b7e3a28019c9 ("libbpf: remove dependency on barrier.h in xsk.h")
> Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>

Applied. Thanks
