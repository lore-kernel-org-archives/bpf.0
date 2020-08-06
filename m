Return-Path: <SRS0=fFcV=BQ=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15CAAC433DF
	for <bpf@archiver.kernel.org>; Thu,  6 Aug 2020 17:07:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61FD623119
	for <bpf@archiver.kernel.org>; Thu,  6 Aug 2020 17:07:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nfs+5xU7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730077AbgHFRHF (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 6 Aug 2020 13:07:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730052AbgHFRGn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 6 Aug 2020 13:06:43 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58203C061756;
        Thu,  6 Aug 2020 10:06:40 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id h8so26481506lfp.9;
        Thu, 06 Aug 2020 10:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d8a50wXhNSPR+EWjZSXZ3Tu+1bSTiMj6hrt2UgG57X8=;
        b=Nfs+5xU7a4pVp1CK2c4u/boeHxj1boMyYoI3Fsbxg2UhiqXtmHm5EwZp0AeR4OMllA
         1txfiBAYxqzrBpeFNcpZ16iZFcjL1Fg8AgsTxsWHfiEZrDp6bcH/thycCSy0FwejJEO0
         FjSxixjOIPXAqMlnLov9wHBDM8r1gcXTIVtQ8DBpKt5Z6haRuyQhWmfWx0ifMUVmUEPv
         //OS9q2L9Ep3J+WsF1laPHYgaNnQpalWTB8bPvI7F6qC3U1G/qC5HOrXUEjpmRhsGSBX
         O07EteCShAVxlAjoJUQEuWKUwYupVT2ymCPvUiGQpMZOHTBjM1TlJO3QztmvhZUq0177
         c2gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d8a50wXhNSPR+EWjZSXZ3Tu+1bSTiMj6hrt2UgG57X8=;
        b=j8cNNpI5sT9x9Z6+CwQAyuuPT1/HIf4d778tJvWuSyT4DoBykbbgpqCQJtCuVkUTZ4
         n/FRkywtcx6pLfq71V57X9ZynzfS2qxZTYC8ESH+sGNozBM1d62AROKEvwFyR+4O1fDW
         Wxe6wnbwPTfkss5jSoW4rHstERtsbsVuHAIMWq08F4PVy3qELElzRE011Zt1cE5QxgyT
         wkCya/g4IJ6PD8McAFHuMKxQo/LYC5H9lJQ4hbm3YrndkU9ld5aIJNA2BThjN76i5njI
         iyh2bA4icPXZdwnzUReqD1Py34GDIJQkpP4UgVjZV/7mojTYSOXlfuQKc+cZoDpcrs4Y
         7gGA==
X-Gm-Message-State: AOAM530WmAlb3Yd/TeHkFro/K3zCp5YCDNRBUGqB2KugvjG/kXGdEN64
        DGWvkvdAPrahQ+mbsrJUDmCzyhZ5u5sj5OEzyGc=
X-Google-Smtp-Source: ABdhPJyiyWiQuJXmVjJZaDv8uj82n0oPrs6RElbuPj79xv47Zv0ZPbGjmMRyFwFQT7+psDX+TNRV5wROnR2cZfdlqzY=
X-Received: by 2002:a05:6512:2010:: with SMTP id a16mr4239392lfb.196.1596733598126;
 Thu, 06 Aug 2020 10:06:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200729162751.GC184844@google.com> <20200804194251.GE184844@google.com>
 <CAADnVQJ-usRjX20KBuCot3NNmrsVZ5oN3c+cZ86Hbr5a9F7n3g@mail.gmail.com> <20200805231049.GF184844@google.com>
In-Reply-To: <20200805231049.GF184844@google.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 6 Aug 2020 10:06:26 -0700
Message-ID: <CAADnVQJ1CbPgwpmHF8ZeegWjV+S8AoVVoAXfZi0gvsr=Nafizw@mail.gmail.com>
Subject: BPF office hours via google meet. Was: BPF program metadata
To:     Stanislav Fomichev <sdf@google.com>,
        Network Development <netdev@vger.kernel.org>
Cc:     bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andriin@fb.com>,
        YiFei Zhu <zhuyifei@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Aug 5, 2020 at 4:10 PM <sdf@google.com> wrote:
> > Since google folks have trouble with zoom I've added google meets link
> > to the spreadsheet. Let's try it tomorrow.

Today we held BPF office hours via google meet and it worked well.
So we will be using it for future meetings.
zoom link has been removed from the spreadsheet to avoid confusion.
