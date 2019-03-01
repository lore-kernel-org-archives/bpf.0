Return-Path: <SRS0=adOE=RE=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33137C10F03
	for <bpf@archiver.kernel.org>; Fri,  1 Mar 2019 20:08:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0336420848
	for <bpf@archiver.kernel.org>; Fri,  1 Mar 2019 20:08:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="Xtvy6uZr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725934AbfCAUIY (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 1 Mar 2019 15:08:24 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:36568 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725905AbfCAUIX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 1 Mar 2019 15:08:23 -0500
Received: by mail-qt1-f195.google.com with SMTP id p25so29271868qtb.3
        for <bpf@vger.kernel.org>; Fri, 01 Mar 2019 12:08:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=Xvvd0LRfzhVeWgtCA/8HowmEJU+4/SexrZUTbC9Fw1M=;
        b=Xtvy6uZrFYnMHymL6nmyrWf8u35hZ2ar22GNZNSRr4boCkkJLk32Szhb+kJphihl3d
         lftalo9JqOHcsr2VoIYk3zHzA8PDjK2N3fxYhDgrJrdbAmMdBJamGrtn51+oPYsP1ogV
         LTJVekoGA8+YwYeVhAcHlkIOBKLC534+gi+dCM6ZUftdEIgT12P755P//5yhEZ5OsRws
         yUJnamPWng2cKf8Z48y+y2hDWkit9C+FCTf4dIltsG5H26/V38wJPJEeC4jQ33TGU2FV
         yD5m7MomChEbYDkirGbUZdTEN96/lLYtXLW1hPAPAKzEKJCafhdMFqJ3qCH3rdznrdcU
         W3tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=Xvvd0LRfzhVeWgtCA/8HowmEJU+4/SexrZUTbC9Fw1M=;
        b=a17vITEiC+K3qBJkjBHxqYK8PZSNlp0Ga/q/synwumXGTYgfNkvZJw6kzh80hfJwpB
         nlfgJRGDymlxQScEtHvH1OWwLR8kp49ONaPexxVVqcwF63Uq0wJ/fRSYEQr4qHqWIqRL
         uGoOzz6XvroCbsNsljR+UaYjcgZ2yDtScOIzKgmhGWmhqrQk1+OPdY8DVYga1Jy1FjJ7
         M8XbYW/zw/xg1C3Z6shO5SovPRGmzbkumt3XkedHZE6DABcqFWOIu1ME9lQl0A0AokBs
         ECFDuCkX++hGfaQy70CAe2zSylicv0BVDVZK+zp9Sn+A+OeCN5N7H2PYv+/qc+9g9bLq
         nU+A==
X-Gm-Message-State: APjAAAVsc77R+uJIgKPQCb8oyMgA9DxrZEwqnhGTsI7WPx+GQgK+4yB5
        dyirLKKZh0hszxhwRcMk8/wIV7+COOQ=
X-Google-Smtp-Source: APXvYqwp5FCCr3ZYp1wt148J+6HjxznPpZ5DVnVaDnBUqO2+7N18Ujf6Uu0YvRtTs+Eq2favmd3mng==
X-Received: by 2002:a0c:ae78:: with SMTP id z53mr5185315qvc.235.1551470902146;
        Fri, 01 Mar 2019 12:08:22 -0800 (PST)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id 17sm7861591qtt.18.2019.03.01.12.08.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 01 Mar 2019 12:08:22 -0800 (PST)
Date:   Fri, 1 Mar 2019 12:08:13 -0800
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@fb.com>, bpf@vger.kernel.org,
        Networking <netdev@vger.kernel.org>,
        Joe Stringer <joe@wand.net.nz>,
        john fastabend <john.fastabend@gmail.com>, tgraf@suug.ch,
        Yonghong Song <yhs@fb.com>, Andrii Nakryiko <andriin@fb.com>,
        lmb@cloudflare.com
Subject: Re: [PATCH bpf-next v2 1/7] bpf: implement lookup-free direct value
 access
Message-ID: <20190301120813.2517cbd2@cakuba.netronome.com>
In-Reply-To: <CAEf4BzYeuBQn6GT7GAQooAsxevBXP2RJjGJV4QBUghAmewrJDg@mail.gmail.com>
References: <20190228231829.11993-1-daniel@iogearbox.net>
        <20190228231829.11993-2-daniel@iogearbox.net>
        <CAEf4BzYCFw861q-S=7VH3B7d9wQha5WYbNnbi+YU6XEya1ZE_w@mail.gmail.com>
        <93040e2a-cf74-0dfe-276f-0a91598011c5@iogearbox.net>
        <CAEf4BzYeuBQn6GT7GAQooAsxevBXP2RJjGJV4QBUghAmewrJDg@mail.gmail.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, 1 Mar 2019 11:35:17 -0800, Andrii Nakryiko wrote:
> > > Do you think that would work? Using array is a bit limiting, because
> > > it doesn't allow to do partial reads/updates, while BPF_MAP_TYPE_HEAP
> > > would be single big value that allows partial reading/updating.  
> >
> > If I understand it correctly, the main difference this would have is
> > to be able to use spin_locks in a more fine-grained fashion, right?  
> 
> spin_lock is just a nice bonus, if there is any manipulation that
> isn't <= 8 byte long that needs to be done atomically.
> 
> The reason for this new type of map is actually ability to update
> global variables from outside BPF program in granular fashion. E.g.,
> turning on some extra debug output temporarily, tuning parameters,
> changing PID to trace, etc, without stopping and reloading BPF
> program. With array, it's all-or-nothing: to update anything you have
> to overwrite entire .data section. As I mentioned, if we can get BTF
> type information for entirety of .data, it would allow to manipulate
> those variables by name even with generic tools like bpftool.

Sounds like you'd almost want to mmap the value ;)
