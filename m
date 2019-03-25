Return-Path: <SRS0=sqwL=R4=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04EAAC43381
	for <bpf@archiver.kernel.org>; Mon, 25 Mar 2019 13:17:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C81112087C
	for <bpf@archiver.kernel.org>; Mon, 25 Mar 2019 13:17:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MZ3lp/8+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731031AbfCYNRl (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 25 Mar 2019 09:17:41 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:41995 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730694AbfCYNRl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 25 Mar 2019 09:17:41 -0400
Received: by mail-ed1-f68.google.com with SMTP id x61so1818301edc.9;
        Mon, 25 Mar 2019 06:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NTYtd96afzWcrqGsBnsO85pwRp8TTOT26hbBI8+JDxg=;
        b=MZ3lp/8+/HAz6HNmRbU4ZQYgNp6z6uIKUx/iph5JIqwC73Grl79u5xtGmxLEVtDfU/
         Qt5XH5EfsOStd6GaozmHunal8TBzwEQKwqspZLRPfHp+vmmZPoaXkzkZG0M6SoiOkwwn
         OXKzCfaYlgcHoqHfP4kHW44rzYi2TJW8UrtbhOk7gsRcEU+NJG9ho+3wYXFddUOwPYDu
         wcUhl9g38l9HCOjGbsmDUOvIck1ouOET1VdIJ3/K+ID7N09Ighy2KnWnidvm3RruKae4
         9hdpTjM3YlTXHcN1jldJP43olCxsvuhSf4AwE/PgvUVKSnTm36WsCwYdkWL8BFbTWnTV
         eHRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NTYtd96afzWcrqGsBnsO85pwRp8TTOT26hbBI8+JDxg=;
        b=tBn6QH7MXnDqaA4Td919uWxILZnFsi9U2+AwJ8MLqFCJYYCtKmP25J+W6YTKWMIJZx
         MeHgJQjK/oCyJ/CtATBSv0Zp6BMDTkzORAu0u1Eo1CA9Jo3xqwyxIyJQh1xcnnWVhxpr
         KTinzOWm/tj914KunY9fDvGGl8mAPaEcqnLuASiXSHyTki9DPIJ4O83VLOi4QiJ+IL8f
         Gd3xKDtSfnZu+YTu4j0Z2ezvrUVShtIPX3/OtEZw06N24ugclQK5F6HPKrTvH14zvX9X
         0Am5KDlbWDATjtqcXjKW8UylPMQhSlcOyPqNE4c5hxEZh0W1OfW008Mg0hfxh9Pu2B0X
         MTSw==
X-Gm-Message-State: APjAAAVHK5PaUhubXtN56KI/9/l3ShDq89AB32/KwRMrbZgj7EDNujx3
        6z/gUjUg0vmTiISNf5LYtTqg9GFqHl4nexfH9BQ=
X-Google-Smtp-Source: APXvYqx0X4xN0x+1lnXjv7ZGxh0TAC9/Xd3CtTskimgT9bKgYDBbHBzeF0EXXZUm/X4gAO2GOgET683Y+ENp+kBcnY8=
X-Received: by 2002:a50:86c3:: with SMTP id 3mr16501392edu.143.1553519859072;
 Mon, 25 Mar 2019 06:17:39 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.LRH.2.20.1903250930270.2818@dhcp-10-175-167-141.vpn.oracle.com>
In-Reply-To: <alpine.LRH.2.20.1903250930270.2818@dhcp-10-175-167-141.vpn.oracle.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Mon, 25 Mar 2019 09:17:02 -0400
Message-ID: <CAF=yD-KJrFPoA26VvLhu-myeFHJErShYz4Fmx9h3G0o8eOTwGw@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: test_tc_tunnel.sh needs reverse path
 filtering disabled
To:     Alan Maguire <alan.maguire@oracle.com>
Cc:     Shuah Khan <shuah@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>, songliubraving@fb.com,
        yhs@fb.com, linux-kselftest@vger.kernel.org,
        Network Development <netdev@vger.kernel.org>,
        bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Mar 25, 2019 at 5:36 AM Alan Maguire <alan.maguire@oracle.com> wrote:
>
> test_tc_tunnel.sh sets up a pair of namespaces connected by a
> veth pair to verify encap/decap using bpf_skb_adjust_room.  In
> testing this, it uses tunnel links as the peer of the bpf-based
> encap/decap.  However because the same IP header is used for inner
> and outer IP, when packets arrive at the tunnel interface they will
> be dropped by reverse path filtering as those packets are expected
> on the veth interface (where the destination IP of the decapped
> packet is configured).
>
> To avoid this, ensure reverse path filtering is disabled for the
> namespace using tunneling.
>
> Fixes: 98cdabcd0798 ("selftests/bpf: bpf tunnel encap test")
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>

Acked-by: Willem de Bruijn <willemb@google.com>

Thanks, Alan. Indeed, I had been developing on a platform with reverse
path filter off by default (debian stretch).
