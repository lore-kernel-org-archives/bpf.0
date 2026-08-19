Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEE903403E9;
	Wed, 19 Aug 2026 15:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787155031; cv=none; b=T+ISAPcev2xfVY3oGRaub+BHbUDL0C9A6xCj6If5dXR/eJGYe/M6s1EAI+WrjYV8qbO+PU/ZK053CfZVEocjqF5h4y51EsIVEOVph5NKxvm+hjwtnfE92VsKjDG4gkdHHd+su0UoULxSp3OTtDdf5aJKl03M1xPIWo2mkx+PUCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787155031; c=relaxed/simple;
	bh=lcaZB2zZhWd8gxVKfPNX7hvCn4I5z575ddyIK/6EWNk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fs/p1VU5/RZWw1l7DuVhi677MgsAvvCCqxwLLtok8g4tDtn7a+WU2PSev7evLqveC1P+XWLYtbWnDCinxuneJyKSeGiWrf8Ykuf5v/0iIysJXlEAzLL/fiEIJ0HcoR/epm6PD2TVDnLthtbaQYezQSPotHKmJ3mJNxrkWbEDyR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KhVNfSGg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KhVNfSGg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E37C31F000E9;
	Wed, 19 Aug 2026 15:57:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787155029;
	bh=hsBZBMt20iy4q7D/b4V4nh6Zij4DqaFaa78JPWPYzaw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=KhVNfSGgTXL7ZLYawnS7iDXjxrawmZ6GL8auCNxTaTQr3uN9aWWQ+GS8Wz7cvMOGQ
	 /H8NRDJFZ3Kyrh1LyUhPqTUy3ugb8Bw2r2SUXlX9JSSPodrGgkwLzozbJzA7RrxUsS
	 WHQPcN623W3ZSw5C5CYPkK9NXvvkzA+DFGE3cBUa5AZIIhxWEsYkZ8Cnr0HJ6ZA5yv
	 /4bxsR5vJskQXYRdqryU2Mrsvqw2cYPgkXBlzVHNgwesOvEy1FXrdmk0l8dtbe8HaI
	 ePCzg3YIjVzkkcGhJ0w3MYGISXlXhYAf999lkqalIVrQZELPhTtIhci0OEFSgpBvHd
	 BcpBRdWgY6Yqw==
Date: Wed, 19 Aug 2026 16:57:03 +0100
From: Simon Horman <horms@kernel.org>
To: Victor Nogueira <victor@mojatatu.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, jhs@mojatatu.com, jiri@resnulli.us,
	daniel@iogearbox.net, john.fastabend@gmail.com, sdf@fomichev.me,
	martin.lau@linux.dev, ast@kernel.org, andrii@kernel.org,
	eddyz87@gmail.com, memxor@gmail.com, song@kernel.org,
	jolsa@kernel.org, emil@etsalapatis.com, vega@nebusec.ai,
	netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH net v2] net/sched: add get_fill_size callbacks for
 actions missing them
Message-ID: <20260819155703.GV265046@horms.kernel.org>
References: <20260816201327.2435335-1-victor@mojatatu.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260816201327.2435335-1-victor@mojatatu.com>

On Sun, Aug 16, 2026 at 05:13:27PM -0300, Victor Nogueira wrote:
> Several tc actions - act_police, act_bpf, act_pedit, act_ife, act_sample,
> act_ct, act_ctinfo and act_tunnel_key among them - provide no
> get_fill_size() callback, so tcf_action_fill_size() falls back to
> tcf_action_shared_attrs_size() which does not account for the
> action-specific netlink attributes emitted inside TCA_ACT_OPTIONS by
> their dump functions.
> 
> When an RTM_NEWACTION request with NLM_F_ECHO (or an RTNLGRP_TC
> listener) creates several actions, tcf_add_notify_msg() allocates the
> echo skb from this underestimated size. When this happens, the act_api
> code fails to add all of the fields to the netlink message and, thus,
> fails to send it. Issue is that, when that happens, this failure doesn't
> stop the action instances from being added. So any user watching these
> events will be under the false impression that no actions were created at
> all.
> 
> For example, act_pedit overruns with 32 actions of four munge keys each,
> act_police with 32 policers once the optional rate/peakrate/result/avrate
> attributes are present.
> 
> To fix this, add the missing get_fill_size callbacks returning the
> worst-case size of each action's dump attributes, following the pattern
> used by act_gact/act_skbedit/act_vlan. Also widen the TCA_GACT_TM
> accounting in tcf_action_shared_attrs_size() to nla_total_size_64bit(),
> since actions dump their tcf_t with nla_put_64bit(), which may be
> preceded by an NLA_PAD attribute.
> 
> Note: We only provided fixes for the actions we reproduced this bug with
> as of today. We can send a separate hardening patch for the remaining
> actions to net-next later. The other pre-existing issues, pointed out by
> Clashiko [1], will be fixed in upcoming patches.
> 
> [1] https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260810164357.1653956-1-victor%40mojatatu.com
> 
> Fixes: 4e76e75d6aba ("net sched actions: calculate add/delete event message size")
> Reported-by: Vega <vega@nebusec.ai>
> Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
> Signed-off-by: Victor Nogueira <victor@mojatatu.com>
> ---
> v1 -> v2:
> - Use tcf_lock when accessing shared bpf action fields
> - Improve commit message clarifying what the bug actually affects - Jakub
> - Make it explicit that the list of actions missing get_fill_size() is
>   not exhaustive

Reviewed-by: Simon Horman <horms@kernel.org>

