Return-Path: <SRS0=yvf5=RY=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7A25C43381
	for <bpf@archiver.kernel.org>; Thu, 21 Mar 2019 13:59:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 844C72183E
	for <bpf@archiver.kernel.org>; Thu, 21 Mar 2019 13:59:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pEidBysz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727934AbfCUN7W (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 21 Mar 2019 09:59:22 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:34275 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727823AbfCUN7W (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 21 Mar 2019 09:59:22 -0400
Received: by mail-ed1-f65.google.com with SMTP id a16so5085153edn.1;
        Thu, 21 Mar 2019 06:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lcdJQ9qZUng4s9pEni7EUzFHboSzbJdSTsJnxSIzmq4=;
        b=pEidByszIRo+/n8cvZLY1zAQgcFHUsGzgDHbq1BnxuJXAmIWqTkbXPjBK37A+MrTan
         qpcusNB7j4P4RtBxW7GigBdfuJftHixZLrd4QLwVZn6BF+fJSkNOFEvOhC+GjFLpYfE3
         g4KSQoshyukF7zYzg4AFlHBxPfij27Gk2vlTaGZDYfkgmRuLeKBCf8agOHrfRqnUzM+H
         b+XRb2yCfwsJtrnWicDz3sZ50CLaWfaptX+4kMy1Do8+fCKawT+CsXwuB3N2NQYmtokM
         RWQ329Fw670vKMYK/7mSAsV419xHaVvEbrAr9EFjzLTGNLRrVerDxnpWaCbL/zjnaq5I
         g5IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lcdJQ9qZUng4s9pEni7EUzFHboSzbJdSTsJnxSIzmq4=;
        b=uWJ8geCf3ULOvPAPI4QklPPep/dfP5wd64wczQcT2/ek5V8QRlPdN18LwWJi5agajM
         qD237z8u2v2EIuUizjxInK+XzArGRYwN6Cul3ZlBfwasFl87F6ONpuZubzEtZ+DYrGKn
         MCuZquVS3GUuuAZI70o5UA2ObQoxoq/ldIAnjwmy85BL7x2+1NO8Nces16AGrpSvisvv
         QGDSrqkwiGus4q8+xv1ORoARnYHkyaLpuG+VQqDKmRxpuDvSAZVKlGSMl6XPXkEg84Db
         KHZ7YpIoNSkg++rRVc4ljze5+uCn2AMx7052I5u5TdyHs/20YyHBzAVCMO3lMINlmHQO
         XYpg==
X-Gm-Message-State: APjAAAUuX1cg0mFdBC2Npjkcprb5rljjN9l6cutV3PBxpXcyAuKRnHvh
        6HmcudwvabJs/2c0dadTFq/cD3B3XgzkUy6chV8=
X-Google-Smtp-Source: APXvYqwt3bSe6C0GVS9emgvTiIyZZ2qyycTdc3xP1x7/ScMYXwLgPpwQn5TB1Q8x5aKQD+saWymeoAX9pbWBlwEdb0g=
X-Received: by 2002:a50:86c3:: with SMTP id 3mr2606656edu.143.1553176760109;
 Thu, 21 Mar 2019 06:59:20 -0700 (PDT)
MIME-Version: 1.0
References: <20190319221948.170441-1-sdf@google.com> <20190319221948.170441-2-sdf@google.com>
 <20190321033941.bygpejl2krltkdmm@ast-mbp.dhcp.thefacebook.com> <6406eae2-4633-9b2a-1101-2de48d29f9dd@gmail.com>
In-Reply-To: <6406eae2-4633-9b2a-1101-2de48d29f9dd@gmail.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Thu, 21 Mar 2019 09:58:44 -0400
Message-ID: <CAF=yD-KFZ2-p8BWf_EBpqCbpzeqwLbqtZutio5WM6MP62G7wKQ@mail.gmail.com>
Subject: Re: [RFC bpf-next v2 1/9] net: introduce __init_skb{,_data,_shinfo} helpers
To:     Eric Dumazet <eric.dumazet@gmail.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Stanislav Fomichev <sdf@google.com>,
        Network Development <netdev@vger.kernel.org>,
        bpf@vger.kernel.org, David Miller <davem@davemloft.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        simon.horman@netronome.com, Willem de Bruijn <willemb@google.com>,
        Petar Penkov <peterpenkov96@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Mar 21, 2019 at 12:45 AM Eric Dumazet <eric.dumazet@gmail.com> wrote:
>
>
>
> On 03/20/2019 08:39 PM, Alexei Starovoitov wrote:
>
> > I think you need to convince Dave and Eric that
> > above surgery is necessary to do the hack in patch 6 with
> > +static DEFINE_PER_CPU(struct sk_buff, bpf_flow_skb);
> >
>
> Yes, this is a huge code churn.

It touches a lot of lines. But it deduplicates logic that might become
out of sync if we don't do that now.

> Honestly I believe we are going too far in this series.
>
> > I think the better option it to introduce new prog type that works
> > without skb. I think it can be pretty close to shape and form to xdp.
> >

That's an interesting alternative. The existing sample dissector
does not access any skb fields aside from vlan. The interface could
be superseded with one that has a more constrained context, like xdp.

When parsing for headlen in the device driver rx path, a program could
conceivably in the same pass also compute an rxhash in case the
device did not supply an L4 one. And perhaps some hash (the same?)
to speed up GRO flow lookup. This would require a few extra fields in
bpf_flow_keys.
