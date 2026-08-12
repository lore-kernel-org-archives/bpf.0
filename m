Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B81230DEA6;
	Wed, 12 Aug 2026 01:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786497601; cv=none; b=eqVpuUnPF0oGuYWGJPJcOxVebV9rgXydIAgMFOWBFrJqmPcq7xx+1yagi7weWMEGQdWRdBXc6XA/Cj79JMaXnJQiRUhA6l1ZGTWaptuZsyWQOFNKLHMETlJww4FQ2Gqwd70H5/27/HqFAUMfXRW969N7anfpcgDz6AnobBensbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786497601; c=relaxed/simple;
	bh=fyZiAx4RwT4ghqHa8ZYliTS1dyMnLcl5lS9FIw9KQQw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l1ZUzTuAVehrtlM3VpLB6nlIBUympJSXTg87/2Xr3Y1+EqLV6gaEoiabhC7xkFYLiN977PVzKwpxFvvIya25g4asoR6vlquTgQpW/Ugj+SNZK5pgMTdjpstG/me1oBDa/Pz5ek58gdNZGjSOpTOYHwImZGN/8f6vEuugMusW/vQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tvt6oQXn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tvt6oQXn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32C791F000E9;
	Wed, 12 Aug 2026 01:19:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786497599;
	bh=qKuvoCOYFhowNNJHWa8pQE/WbDav5JFa+G9x/LjmbYc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Tvt6oQXnKHbb4kMWUgEn0Fp5HaWkaU7hlbSxRF+cbM118FD/B/JYf+3KUjN5XrWwA
	 LIDAbXj3HowUbgUdNqZ1gzkniXJgEKS6eu72YpVxJiMorrP+PMXSIiA9M5Cs4yzPTF
	 TqBJ8E2W5itaF0NaC6edbNuNzXRRRVS/fUhuPjWZEsJPIOJGzL5ywKJBhbzMqOlfB1
	 Kwnqrtmof4vpW4dM+zxv8cBBolOHuRWS0gx4sZprfwy67Us86r4yAt7fkrb0dDZkED
	 MjnN//P2hF1tcR2YhuoyWBo8YfUUCYOEueugTRBQ1OltmefZUsm3bqOrTjk7FO9ogM
	 49BrigioXVgtA==
Date: Tue, 11 Aug 2026 18:19:58 -0700
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
Message-ID: <20260811181958.04b42aba@kernel.org>
In-Reply-To: <20260810164357.1653956-1-victor@mojatatu.com>
References: <20260810164357.1653956-1-victor@mojatatu.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 10 Aug 2026 13:43:57 -0300 Victor Nogueira wrote:
> When an RTM_NEWACTION request with NLM_F_ECHO (or an RTNLGRP_TC
> listener) creates several actions, tcf_add_notify_msg() allocates the
> echo skb from this underestimated size. act_bpf is the clearest case:
> TCA_ACT_BPF_OPS alone reaches 32KB per action (BPF_MAXINSNS), so two
> actions are enough to overrun the allocation. act_pedit overruns with
> 32 actions of four munge keys each,

"overruns" makes it sounds like we overflow a buffer.
AFAICT we'd at worse hit a WARN somewhere due to EMSGSIZE?

> act_police with 32 policers once the
> optional rate/peakrate/result/avrate attributes are present, and
> act_tunnel_key with a single action carrying a maximum-sized geneve
> option blob, whose 63 class/type/data attribute triplets expand to about
> 1.2KB. tca_get_fill() then fails and the request returns -EINVAL, but
> tcf_action_init() has already committed the actions via
> tcf_idr_insert_many(), so they stay installed even though userspace is
> told the request failed.

Please TAL at Clashiko review. 

One thing that'd be good to clarify is which WARN gets hit (if my
assumption is correct that it's a WARN) and that the path where it
hits has a lock covering the get_size and the rest of the operation.
