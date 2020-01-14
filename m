Return-Path: <SRS0=Nq9f=3D=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5FE3C33CA9
	for <bpf@archiver.kernel.org>; Tue, 14 Jan 2020 03:14:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B091214AF
	for <bpf@archiver.kernel.org>; Tue, 14 Jan 2020 03:14:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i/iwDg1s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729465AbgANDOq (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 13 Jan 2020 22:14:46 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:36067 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729072AbgANDOp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 13 Jan 2020 22:14:45 -0500
Received: by mail-io1-f65.google.com with SMTP id d15so12251114iog.3;
        Mon, 13 Jan 2020 19:14:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=DTo5OHV5/09OqbCaWCXkttjsIPzJmf0OAwUdTCU43a4=;
        b=i/iwDg1sF+fWg6UPwTAxL7Y2YNa4QFtiVbzwR9vw7GyuEydtGn0oBpUO1SAy36RHrZ
         pJKzwdJf6ccUQeQQm2xvDLureT05/xPNYAb/FiWT4IFB9oNljPuprvA/QOozbs+AKGEh
         qYYlQ0mrNHzRzPa7+ga1h0G6va8FwyybegEfKV3PY4eOjTfMbM6goTO2uf3A/jWpjz0+
         slLcF4sDAvQti3r11IEtE5+H55wCaabTjdyHCkVsd2QLSCz2+ZetKWsnA13aB2/P0+Qe
         6gcFdZMK8SxX4UJwx2FGXyHOhQcVoS49HNimxhwk2NiqYDbKODW6JEfTF1JbNo+cXUtM
         88nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=DTo5OHV5/09OqbCaWCXkttjsIPzJmf0OAwUdTCU43a4=;
        b=T1Lu68JQq0MYQEvHipj1b/u8gyAJS9XZIrYp/IU9YWgVBxr7ElGuz876dqxRlN5Pm1
         aoWL+vTtSGBQ93iWV89aJxOvUFSDoOe0fN4xUca9ituUG04eOhnjgrL076kFqDNdQDGk
         GNF5cmkUZXoDgfO89AcyILuNiyN/2hE/u+r/psk/iyvIz8u3xaFY/RoDRlaIZJZXfWW0
         +SOjDjL4QNjyLJnobsVZ7q7CCEMXq8nSEZjlgqxlqEH3gFtMLYKAxqhjSs05xNqIsZUS
         9e1Fnaqxol5pQZ1aChu7YD1hbVZO6tG/QGIzyqSvFuHoM3b+OWT4TqRAmqGUTSXhUx0v
         xRZw==
X-Gm-Message-State: APjAAAX8c/lQx3cX9ipguEcdxioLej4y/PuJ2fJGhyOIrNST0JZ/+Ksp
        aKY3UKPEMjlfm2jQd0pivTM=
X-Google-Smtp-Source: APXvYqx2wBZ8LrN0nMUiotXp2q4RW9wBpNwoyL2Dv6I3wH+6b3n7lIal5vFS9ksiIOC1vJwkwxqNWg==
X-Received: by 2002:a5e:cb4c:: with SMTP id h12mr7240295iok.251.1578971685097;
        Mon, 13 Jan 2020 19:14:45 -0800 (PST)
Received: from localhost ([184.63.162.180])
        by smtp.gmail.com with ESMTPSA id e1sm4422205ill.47.2020.01.13.19.14.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2020 19:14:44 -0800 (PST)
Date:   Mon, 13 Jan 2020 19:14:32 -0800
From:   John Fastabend <john.fastabend@gmail.com>
To:     Jakub Sitnicki <jakub@cloudflare.com>,
        John Fastabend <john.fastabend@gmail.com>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        kernel-team@cloudflare.com, Eric Dumazet <edumazet@google.com>,
        Lorenz Bauer <lmb@cloudflare.com>,
        Martin KaFai Lau <kafai@fb.com>
Message-ID: <5e1d321894782_78752af1940225b49e@john-XPS-13-9370.notmuch>
In-Reply-To: <87muars890.fsf@cloudflare.com>
References: <20200110105027.257877-1-jakub@cloudflare.com>
 <20200110105027.257877-3-jakub@cloudflare.com>
 <5e1a56e630ee1_1e7f2b0c859c45c0c4@john-XPS-13-9370.notmuch>
 <87muars890.fsf@cloudflare.com>
Subject: Re: [PATCH bpf-next v2 02/11] net, sk_msg: Annotate lockless access
 to sk_prot on clone
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Jakub Sitnicki wrote:
> On Sun, Jan 12, 2020 at 12:14 AM CET, John Fastabend wrote:
> > Jakub Sitnicki wrote:
> >> sk_msg and ULP frameworks override protocol callbacks pointer in
> >> sk->sk_prot, while TCP accesses it locklessly when cloning the listening
> >> socket.
> >>
> >> Once we enable use of listening sockets with sockmap (and hence sk_msg),
> >> there can be shared access to sk->sk_prot if socket is getting cloned while
> >> being inserted/deleted to/from the sockmap from another CPU. Mark the
> >> shared access with READ_ONCE/WRITE_ONCE annotations.
> >>
> >> Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
> >
> > In sockmap side I fixed this by wrapping the access in a lock_sock[0]. So
> > Do you think this is still needed with that in mind? The bpf_clone call
> > is using sk_prot_creater and also setting the newsk's proto field. Even
> > if the listening parent sock was being deleted in parallel would that be
> > a problem? We don't touch sk_prot_creator from the tear down path. I've
> > only scanned the 3..11 patches so maybe the answer is below. If that is
> > the case probably an improved commit message would be helpful.
> 
> I think it is needed. Not because of tcp_bpf_clone or that we access
> listener's sk_prot_creator from there, if I'm grasping your question.
> 
> Either way I'm glad this came up. Let's go though my reasoning and
> verify it. tcp stack accesses the listener sk_prot while cloning it:
> 
> tcp_v4_rcv
>   sk = __inet_lookup_skb(...)
>   tcp_check_req(sk)
>     inet_csk(sk)->icsk_af_ops->syn_recv_sock
>       tcp_v4_syn_recv_sock
>         tcp_create_openreq_child
>           inet_csk_clone_lock
>             sk_clone_lock
>               READ_ONCE(sk->sk_prot)
> 
> It grabs a reference to the listener, but doesn't grab the sk_lock.
> 
> On another CPU we can be inserting/removing the listener socket from the
> sockmap and writing to its sk_prot. We have the update and the remove
> path:
> 
> sock_map_ops->map_update_elem
>   sock_map_update_elem
>     sock_map_update_common
>       sock_map_link_no_progs
>         tcp_bpf_init
>           tcp_bpf_update_sk_prot
>             sk_psock_update_proto
>               WRITE_ONCE(sk->sk_prot, ops)
> 
> sock_map_ops->map_delete_elem
>   sock_map_delete_elem
>     __sock_map_delete
>      sock_map_unref
>        sk_psock_put
>          sk_psock_drop
>            sk_psock_restore_proto
>              tcp_update_ulp
>                WRITE_ONCE(sk->sk_prot, proto)
> 
> Following the guidelines from KTSAN project [0], sk_prot looks like a
> candidate for annotating it. At least on these 3 call paths.
> 
> If that sounds correct, I can add it to the patch description.
> 

Logic looks correct to me thanks for the details, please put those in
the commit so we don't lose them. Can you also add a comment where it
makes most sense in the code? This is a bit subtle and we don't want
to miss it later. Probably in tcp_update_ulp near that WRITE_ONCE would
do. It doesn't need to be too verbose but something as simple as,

"{WRITE|READ}_ONCE wrappers needed around sk_prot to protect unlocked
 reads in sk_clone_lock"

> Thanks,
> -jkbs
> 
> [0] https://github.com/google/ktsan/wiki/READ_ONCE-and-WRITE_ONCE


