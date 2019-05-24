Return-Path: <SRS0=P0Qj=TY=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 734E8C072B5
	for <bpf@archiver.kernel.org>; Fri, 24 May 2019 17:16:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D8362175B
	for <bpf@archiver.kernel.org>; Fri, 24 May 2019 17:16:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W/ZZHjif"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726184AbfEXRQv (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 24 May 2019 13:16:51 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:45109 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725777AbfEXRQv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 24 May 2019 13:16:51 -0400
Received: by mail-qk1-f194.google.com with SMTP id j1so8587226qkk.12;
        Fri, 24 May 2019 10:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=eNIStrPn0BG4pO2jy68OHoQM86aAF6JCW3zEX5mNojo=;
        b=W/ZZHjifrH6J0guHGvUub2x2kfrDNQbmIfxxsE8fw4kdHuIZc5j11Yvd2zUwPzaJr+
         gsaC2RSm3cT+Pq+X9F/9DyzZSU2LhdXxHhtG6lf+jJqwV49Xf5nHE3CXq7aTSu/7juE3
         NRluIzBEZhx/Z5A7AIq0Z1ED9l61Q5SjRL0JNszKafi81gjChKvTr6f3Lugs+N/5J9cz
         gMboUEAlnh52oEBEqDaqv6nB8EFtbOr995UiAOE3E6IP4FASjv/d2nOoshV8U6iUp1rM
         5ZaOS1mZt3sEy3MtQ6UcObAKpgQoomwIkS8oI0HxrmnGpYVzj9NkW1kj7RehGzH5fB6I
         yPiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=eNIStrPn0BG4pO2jy68OHoQM86aAF6JCW3zEX5mNojo=;
        b=qYDAc17ku68wFfQwF+wPz00RchDL4qoyY2otuYAeYjWjCn6UEpQtY/D/M0hK+0zBuK
         L6vneKbg9ckbrHeqmQNMVlaL8JwSoqzyM9WPw9SNyIKwx92KJORRsrNdjLoFBmu+tkGy
         UPDVYBQv1pTdWizenkbyKMMNkjs/2OBBkgtS/FmlvLoZtVEG2MsoYlrrJfdKMoOISIyq
         RUd23ZM2ooM14hfgE8FhoTV53Ae3aCzLXOlhtzOBp443q61dqnAIlO57Y+mB0f+9MUqZ
         moUu5yBD5ErCRnFM10HoNdVVMBgf1MZiTkLD+mygSZQl7gCMfeV+hrtLwyQd5w7mHxci
         CUTw==
X-Gm-Message-State: APjAAAUutIPps3KpwLJYb1jtyjTBTiRQbNAnEeP2cJCwAxeuP+tFlr57
        P8QPLXmLrfiZCbf2j5+p8b7q7FW6OTeMqA1NYII=
X-Google-Smtp-Source: APXvYqySuBOtDzzV6M8BLOSVzBiLz3IBuBe3qEL3KXydRXZ1JlXu/2ed/K43BpCya3dP4lYRx8O1z/rEyu/1TNclQA4=
X-Received: by 2002:a05:620a:12c4:: with SMTP id e4mr67370930qkl.81.1558718210662;
 Fri, 24 May 2019 10:16:50 -0700 (PDT)
MIME-Version: 1.0
References: <1558697726-4058-1-git-send-email-jiong.wang@netronome.com>
 <1558697726-4058-16-git-send-email-jiong.wang@netronome.com>
 <CAJ+HfNjJ6hoDvcjbU7yELDrzWhxXmyG44TcvBRL4OO1035U5fw@mail.gmail.com> <871s0nlsgp.fsf@netronome.com>
In-Reply-To: <871s0nlsgp.fsf@netronome.com>
From:   =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@gmail.com>
Date:   Fri, 24 May 2019 19:16:39 +0200
Message-ID: <CAJ+HfNg_yiVTt4Y+sqs2YFW4rYPkTvcFjKyAAgOxZZR5uxfzzQ@mail.gmail.com>
Subject: Re: [PATCH v8 bpf-next 15/16] riscv: bpf: eliminate zero extension code-gen
To:     Jiong Wang <jiong.wang@netronome.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>, Netdev <netdev@vger.kernel.org>,
        oss-drivers@netronome.com, David Miller <davem@davemloft.net>,
        paul.burton@mips.com, udknight@gmail.com, zlim.lnx@gmail.com,
        illusionist.neo@gmail.com, naveen.n.rao@linux.ibm.com,
        sandipan@linux.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com,
        Jakub Kicinski <jakub.kicinski@netronome.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, 24 May 2019 at 18:36, Jiong Wang <jiong.wang@netronome.com> wrote:
>
[...]
> > Hmm, missing is64 check here (fall-through for 64-bit movs)?
>
> (re-send because of bouncing back)
>
> FOR BPF_X form, when imm =3D=3D 1, it is a special mov32 constructed by
> verifier, it can only be BPF_ALU, not BPF_ALU64. And it is used for
> instructing JIT back-end to do unconditional zero extension.
>
> Please see patch 3 description for the explanation.
>

Doh! Thanks.


Bj=C3=B6rn
