Return-Path: <SRS0=8uh4=SB=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80598C43381
	for <bpf@archiver.kernel.org>; Sat, 30 Mar 2019 03:29:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 444022184C
	for <bpf@archiver.kernel.org>; Sat, 30 Mar 2019 03:29:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KXLG0NfM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730171AbfC3D3k (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 29 Mar 2019 23:29:40 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:39714 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729375AbfC3D3k (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 29 Mar 2019 23:29:40 -0400
Received: by mail-pl1-f196.google.com with SMTP id b65so1884977plb.6;
        Fri, 29 Mar 2019 20:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gE0V6DWU33sCGMQfvZHsFBS4hSuTDS3dsG9n2hk0A0E=;
        b=KXLG0NfMe4BACMlI1XnlLY2WmKSZyNz8s8JFUO/VFsAzMF0V8YHfj0fyEQ65sx7H5C
         nl4DNnsChnyWJYLBcxRiGb21+yiid2rM3IoBTAyhXJ/KnvfmzoFtcX0PLFO+yi9FTPOH
         wOY4gJ1HkeHB2ih0LFaYs0m/e8s+TvCslBweZ+c7czwqKodkVHXz0E0b8/QUDlI5Snp0
         WZiE5Z7pbZ00lfUVxwEPns9tzmajAnfIOWb0v0rLKQw8Tf1WSzkHq5nejNujedB/bLhn
         aJuyE9qBBL1T1Rczs5iNe09g4jOfyvSMJS3W4QvXyeS5ix36LXocs5WQQT2Wocf4CT9f
         UrzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gE0V6DWU33sCGMQfvZHsFBS4hSuTDS3dsG9n2hk0A0E=;
        b=SRLYf1VgrNL+M38Q0qnZcBNY1Ers+YBkAB4Kxuj5OxnvZ/52s0Xfzt21vY0cy9UoaI
         bSOxtFHBgijYmzDYzKKNE6HgV7I8auf+KK6Ae2aNQwRGgMN7BbgFQQcQ0WsPbDKfB4tD
         oe/+AS7IEjspsPPR9S25me4by6SuXTD3IJEGrrmp7y8HUWVybMxUiRe3ADejSY8+5PF6
         Mi5DOBP7L0qUZDQPWxMyc1pS3aJ2Tm4kiw9oBB4lMo0MLD3uaAm6N+I9B4e4CMur1CEJ
         yMf+ThcKy7ezEdP2nGJlv9xah+4fPEqjeC/KB90cvv5M15XDkrPmrRJArqFZ8azgT3ff
         noxA==
X-Gm-Message-State: APjAAAVZHMV7HM2inb19EnzKAge731d9Tuy7un2IiJXcz0IVHIXhxZaA
        9SSHKQ8rIS7MSCWdEo9qzMg=
X-Google-Smtp-Source: APXvYqw8I4gPMMI/BXQNPCBFeaa0ukBpw1oCuSNgnERWwv4wGY0eeJjyLQc2RnEfzGmuCV4qP+Wz7w==
X-Received: by 2002:a17:902:ab95:: with SMTP id f21mr52689656plr.188.1553916579519;
        Fri, 29 Mar 2019 20:29:39 -0700 (PDT)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:180::a875])
        by smtp.gmail.com with ESMTPSA id x24sm4809629pfn.128.2019.03.29.20.29.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Mar 2019 20:29:38 -0700 (PDT)
Date:   Fri, 29 Mar 2019 20:29:36 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Jakub Kicinski <jakub.kicinski@netronome.com>
Cc:     Alexei Starovoitov <ast@kernel.org>, davem@davemloft.net,
        daniel@iogearbox.net, jannh@google.com, netdev@vger.kernel.org,
        bpf@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH bpf-next 2/7] bpf: improve verification speed by droping
 states
Message-ID: <20190330032934.633zkp65tl2k7eua@ast-mbp.dhcp.thefacebook.com>
References: <20190330001612.2354959-1-ast@kernel.org>
 <20190330001612.2354959-3-ast@kernel.org>
 <20190329201239.7736739e@cakuba.netronome.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190329201239.7736739e@cakuba.netronome.com>
User-Agent: NeoMutt/20180223
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Mar 29, 2019 at 08:12:39PM -0700, Jakub Kicinski wrote:
> On Fri, 29 Mar 2019 17:16:07 -0700, Alexei Starovoitov wrote:
> > Branch instructions, branch targets and calls in a bpf program are
> > the places where the verifier remembers states that led to successful
> > verification of the program.
> > These states are used to prune brute force program analysis.
> > For unprivileged programs there is a limit of 64 states per such
> > 'branching' instructions (maximum length is tracked by max_states_per_insn
> > counter introduced in the previous patch).
> > Simply reducing this threshold to 32 or lower increases insn_processed
> > metric to the point that small valid programs get rejected.
> > For root programs there is no limit and cilium programs can have
> > max_states_per_insn to be 100 or higher.
> > Walking 100+ states multiplied by number of 'branching' insns during
> > verification consumes significant amount of cpu time.
> > Turned out simple LRU-like mechanism can be used to remove states
> > that unlikely will be helpful in future search pruning.
> > This patch introduces hit_cnt and miss_cnt counters:
> > hit_cnt - this many times this state successfully pruned the search
> > miss_cnt - this many times this state was not equivalent to other states
> > (and that other states were added to state list)
> > 
> > The heuristic introduced in this patch is:
> > if (sl->miss_cnt > sl->hit_cnt * 3 + 3)
> >   /* drop this state from future considerations */
> > 
> > Higher numbers increase max_states_per_insn (allow more states to be
> > considered for pruning) and slow verification speed, but do not meaningfully
> > reduce insn_processed metric.
> > Lower numbers drop too many states and insn_processed increases too much.
> > Many different formulas were considered.
> > This one is simple and works well enough in practice.
> > (the analysis was done on selftests/progs/* and on cilium programs)
> > 
> > The end result is this heuristic improves verification speed by 10 times.
> > Large synthetic programs that used to take a second more now take
> > 1/10 of a second.
> > In cases where max_states_per_insn used to be 100 or more, now it's ~10.
> > 
> > There is a slight increase in insn_processed for cilium progs:
> >                        before   after
> > bpf_lb-DLB_L3.o 	1831	1838
> > bpf_lb-DLB_L4.o 	3029	3218
> > bpf_lb-DUNKNOWN.o 	1064	1064
> > bpf_lxc-DDROP_ALL.o	26309	26935
> > bpf_lxc-DUNKNOWN.o	33517	34439
> > bpf_netdev.o		9713	9721
> > bpf_overlay.o		6184	6184
> > bpf_lcx_jit.o		37335	39389
> > And 2-3 times improvement in the verification speed.
> > 
> > Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> 
> Reviewed-by: Jakub Kicinski <jakub.kicinski@netronome.com>
> 
> > @@ -6182,8 +6185,35 @@ static int is_state_visited(struct bpf_verifier_env *env, int insn_idx)
> >  				return err;
> >  			return 1;
> >  		}
> > -		sl = sl->next;
> >  		states_cnt++;
> > +		sl->miss_cnt++;
> > +		/* heuristic to determine whether this state is beneficial
> > +		 * to keep checking from state equivalence point of view.
> > +		 * Higher numbers increase max_states_per_insn and verification time,
> > +		 * but do not meaningfully decrease insn_processed.
> > +		 */
> > +		if (sl->miss_cnt > sl->hit_cnt * 3 + 3) {
> > +			/* the state is unlikely to be useful. Remove it to
> > +			 * speed up verification
> > +			 */
> > +			*pprev = sl->next;
> > +			if (sl->state.frame[0]->regs[0].live & REG_LIVE_DONE) {
> > +				free_verifier_state(&sl->state, false);
> > +				kfree(sl);
> > +				env->peak_states--;
> 
> nit: is peak_states always equal to number of states when verifier
>      exits?

yes.
I was thinking as a follow up to add peak_states-- in bpf_verifier_env free-ing
logic to check that there are no memory leaks.

Few other follow ups on my todo list:
. write a ton more tests for scalability
. remove few leftover global variables and drop mutex for root
. account all verifier memory in memcg
. may be introduce a limit for peak_states for unpriv
. continue exploring state merging ideas
. introduce explicit rcu_unlock + preempt_enable in the programs

