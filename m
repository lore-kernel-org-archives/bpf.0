Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D4D81F8691;
	Thu, 13 Aug 2026 00:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786581997; cv=none; b=W+7nksZx0UFNFtf4llsM710KexsXRxm2GheljNwkLRmJLZ6MO55qQdY6FGqietb9lM3iDWcSnQt3kRh+hto9jk8ddERprLnXFrqrxw/PDgNKHOmV9BietIbE06dwPH4qp9cEfPhwqJ+7ElSLM+DlUULJtXhwne2OlUhh+wgL7/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786581997; c=relaxed/simple;
	bh=WiFXDU1I9MeuScrQyuz54o1ORGdFSIqyuDYtnp9x7CI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VQXBsq1RSZEHI3RnsntcuCNm8zQAsXJWDfi3MeShb/KhrSHctEMYq3MfTBeCSiXrJow08lyGacJ5osVVVkjH/3cHqUoUVO6G5bMT/5xftieHstYPilsJIy+KHHjcG8U3AWkLPrjKMqLTSuYb0/Qn0dPPjVByot6xBhhhDfcQJ9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F7sex3Zq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F7sex3Zq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 627B41F000E9;
	Thu, 13 Aug 2026 00:46:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786581995;
	bh=8Tc0JfRnaARko0F7UAJI0lauL1jerJ7xT2B7s/zrh3s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=F7sex3ZqOyi/+f/FGVsAw+oq1t/GreacBJumCns7WktkFFdQqkveMh0XLf+qc5cqW
	 WPM5cXQN70UaFyXZsDiiXu6W6RkHm7lNC2J7O7h7p8C33NBZJZT2DYjEwkQz8cWF3p
	 Ju/N4fNFoV85+WGnPJRbbZY9a8uyiEHVhfebf3D+qVE0yyNdzh1fIrKCrOjrrcg12S
	 +rQrJY0yETYQONW1j2+J5JbybIZsH+m1eIdkU/t3zmqmma4GQOBPaUd4TALCbvGD6i
	 Ct6kXy41lgc2dtAVuW0GsxhQlZhdz+GVKSTMb2yesMwUw43zHd6rzQYr/3aArrsDjB
	 QsEFSJ0ZqW0YQ==
Date: Wed, 12 Aug 2026 17:46:34 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Victor Nogueira <victor@mojatatu.com>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 jhs@mojatatu.com, jiri@resnulli.us, daniel@iogearbox.net,
 john.fastabend@gmail.com, sdf@fomichev.me, martin.lau@linux.dev,
 ast@kernel.org, andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com,
 song@kernel.org, jolsa@kernel.org, emil@etsalapatis.com, horms@kernel.org,
 vega@nebusec.ai, netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH net] net/sched: add get_fill_size callbacks for actions
 missing them
Message-ID: <20260812174634.62cb59f0@kernel.org>
In-Reply-To: <CA+NMeC8cG60HaEFhz1AvbWi+xNYDE3pPwxqk9oTFBwf-mJQDPg@mail.gmail.com>
References: <20260810164357.1653956-1-victor@mojatatu.com>
	<20260811181958.04b42aba@kernel.org>
	<CA+NMeC8cG60HaEFhz1AvbWi+xNYDE3pPwxqk9oTFBwf-mJQDPg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 12 Aug 2026 14:53:15 -0300 Victor Nogueira wrote:
> > On Mon, 10 Aug 2026 13:43:57 -0300 Victor Nogueira wrote:  
> > > When an RTM_NEWACTION request with NLM_F_ECHO (or an RTNLGRP_TC
> > > listener) creates several actions, tcf_add_notify_msg() allocates the
> > > echo skb from this underestimated size. act_bpf is the clearest case:
> > > TCA_ACT_BPF_OPS alone reaches 32KB per action (BPF_MAXINSNS), so two
> > > actions are enough to overrun the allocation. act_pedit overruns with
> > > 32 actions of four munge keys each,  
> >
> > "overruns" makes it sounds like we overflow a buffer.  
> 
> Fair enough, it doesn't actually overflow a buffer.
> I can change that.
> 
> > AFAICT we'd at worse hit a WARN somewhere due to EMSGSIZE?  
> 
> The issue is more subtle.
> The kernel might create the actions, but fail to notify userspace
> because the notification message is too large for the allocated skb.
> So it's not a crash or a WARN, but rather a correctness issue.
> 
> > > act_police with 32 policers once the
> > > optional rate/peakrate/result/avrate attributes are present, and
> > > act_tunnel_key with a single action carrying a maximum-sized geneve
> > > option blob, whose 63 class/type/data attribute triplets expand to about
> > > 1.2KB. tca_get_fill() then fails and the request returns -EINVAL, but
> > > tcf_action_init() has already committed the actions via
> > > tcf_idr_insert_many(), so they stay installed even though userspace is
> > > told the request failed.  
> >
> > Please TAL at Clashiko review.  
> 
> Yes, I belive it's correct - the code should acquire the lock in act_bpf.
> Also yes, the GET path suffers from the same issue, I can send a fix
> for it as a follow up.

to be clear - im expecting a respin with a much better commit msg
