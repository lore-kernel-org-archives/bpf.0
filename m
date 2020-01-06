Return-Path: <SRS0=wjVQ=23=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CC74C33C8C
	for <bpf@archiver.kernel.org>; Mon,  6 Jan 2020 23:46:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FAFF2072A
	for <bpf@archiver.kernel.org>; Mon,  6 Jan 2020 23:46:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AhB2kstv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726858AbgAFXqn (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 6 Jan 2020 18:46:43 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:37890 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726599AbgAFXqn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 6 Jan 2020 18:46:43 -0500
Received: by mail-pj1-f65.google.com with SMTP id l35so8416148pje.3;
        Mon, 06 Jan 2020 15:46:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lXzoNNYg+iL14F+bP33SlPZMJC722e8o96/p03q5+eU=;
        b=AhB2kstvXC4bjVGm9u3+Ft9mq2oBei9/53hsYBcE/6iGpONhX5ZIeDcx5OwTrNNRX+
         z/qQB0r3WwLxuhj5NY4dj3tF354VQ4VPdkEeKbw0GHxhigUenl/I4uAMdYJ40dGmGVPe
         C21WjDqVt5gYo1r4FgMf0roUJzpHsRRrm4ukuCNAQ2Ns/dXfs0YkomOw7Uc5i0Syyi5y
         1N0hwr/1fB9z3RbSAjsmH141qZ7E/isZse+77mnMW1/ppPo3ix7R8qEV2AcACX7bUETb
         EUi+gBjGXjo0/MVqvGJbnY2dF3eALQ4TfUWE62qLgkCnljiy3KFcc0ChJgbcyrJiwyw8
         QKzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lXzoNNYg+iL14F+bP33SlPZMJC722e8o96/p03q5+eU=;
        b=B3STh9qR0xAP+w6X81nTVCAeRn/d6fC5pBtU/dUBCqiJGQPMvcR76X6XAxf3vANVx6
         dzE/ggKjKqk375bmXKllBwpt9a39a+Urr0Pu9uo0ul6PYfVS5gw13D7KQVD2HCpHHYyF
         WYbThvmthB++sO/Q11/bH75Zg3y/vLuYisnN1TZ69RP6zS3PalOHhdWzkNSAKiknikty
         if62p8Zfi1Dn+gcRll3loDRiL3ptgtX2NbvmcD45pRMHX2aWsea6r+TCVE3WdaRc0WS3
         lTbX3G05IAZi4P962YdWzzB0CsPzb1D6+TaiJGNXrlnyGGmJyYXaeSd5LmAdeyXPotJ1
         s4dg==
X-Gm-Message-State: APjAAAWL/AMHcj1bkQ8vI/QxeIh5A1W0rjOwjfuZ7vqxm/bHRd+z6dLr
        kX/nVozjZSlOPH24MqHLnE4=
X-Google-Smtp-Source: APXvYqzs+BBcsUpY85BwooDMbFNUg82RZQ28blt2CVIjO/xu7m2nxo0kG7BS75dYe3uFLAV/E2czIg==
X-Received: by 2002:a17:90a:778a:: with SMTP id v10mr43717211pjk.26.1578354402800;
        Mon, 06 Jan 2020 15:46:42 -0800 (PST)
Received: from ast-mbp ([2620:10d:c090:200::1:2bf6])
        by smtp.gmail.com with ESMTPSA id e16sm72115828pgk.77.2020.01.06.15.46.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Jan 2020 15:46:42 -0800 (PST)
Date:   Mon, 6 Jan 2020 15:46:40 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, Andrii Nakryiko <andriin@fb.com>,
        Yonghong Song <yhs@fb.com>, Martin KaFai Lau <kafai@fb.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        David Miller <davem@redhat.com>, bjorn.topel@intel.com
Subject: Re: [PATCH 5/5] bpf: Allow to resolve bpf trampoline in unwind
Message-ID: <20200106234639.fo2ctgkb5vumayyl@ast-mbp>
References: <20191229143740.29143-1-jolsa@kernel.org>
 <20191229143740.29143-6-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191229143740.29143-6-jolsa@kernel.org>
User-Agent: NeoMutt/20180223
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Dec 29, 2019 at 03:37:40PM +0100, Jiri Olsa wrote:
> When unwinding the stack we need to identify each
> address to successfully continue. Adding latch tree
> to keep trampolines for quick lookup during the
> unwind.
> 
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
...
> +bool is_bpf_trampoline(void *addr)
> +{
> +	return latch_tree_find(addr, &tree, &tree_ops) != NULL;
> +}
> +
>  struct bpf_trampoline *bpf_trampoline_lookup(u64 key)
>  {
>  	struct bpf_trampoline *tr;
> @@ -65,6 +98,7 @@ struct bpf_trampoline *bpf_trampoline_lookup(u64 key)
>  	for (i = 0; i < BPF_TRAMP_MAX; i++)
>  		INIT_HLIST_HEAD(&tr->progs_hlist[i]);
>  	tr->image = image;
> +	latch_tree_insert(&tr->tnode, &tree, &tree_ops);

Thanks for the fix. I was thinking to apply it, but then realized that bpf
dispatcher logic has the same issue.
Could you generalize the fix for both?
May be bpf_jit_alloc_exec_page() can do latch_tree_insert() ?
and new version of bpf_jit_free_exec() is needed that will do latch_tree_erase().
Wdyt?
