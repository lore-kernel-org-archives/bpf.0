Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C86644BCB8;
	Tue, 16 Jun 2026 15:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781623386; cv=none; b=rjfm1wYShytlF3Ot+symI+yNIUMwIAPH1eeV+eEXids9Z5dgKTCYpJMgXjfGbhtXUT677QdDY7Dg3BeyVSPQoLQXrGsewB/eRdgJrB2I+KlTKOacvSS0RYdqoLaLEYHpucCk8y4lpqtMeuSxaTjLmYM2grCtrqa46GbJ+vj5omM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781623386; c=relaxed/simple;
	bh=epA1r6GiMx7JHmbS/clLse1iSFl+j4KCb4HpFi3L6Tw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M+W5lrWOeFPWegDicb3641EhAAbZA29P7zFGbZrXqWcAWErOb0mjPnhH1Inz9Eq62+30cwQZ54/3pG/IhjrZxwCuCFRe7Rv4JQKksTHuvTdRM0a1khTo0Ax4IMHpjWe/esU6Ud8tqBhcPtRGIxr1Sfq5X5Nabg6IJJINQYAqhfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k4kMTGuD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k4kMTGuD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E21B1F00A3A;
	Tue, 16 Jun 2026 15:23:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781623385;
	bh=hv3h9P487Z/2V1mgo4zQS3Oy7NlqKKmp31AJLcXoCVc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=k4kMTGuDMCmD6OS9LfuXYbkRWW31lLBNhI6ik+zHXuJot7rwzAwrbAGDBim2ZvwtB
	 fGfPhqSLO4L/iLhILtd69p8v+zRV3cVKl7VBDxpT8D+OTLkJLU75kHEn7tRCSRXZf5
	 oxCarQDMtggvI+p2Du6GihVTitESMoFa3CN5SYLq0wTssC0nnyD3QhyZy7epPEmgJD
	 jTM6dJ8DeKZTeDE+3FrxoelU+UgEmctdA/tDp/3y/SFHL1EofQQ+/QKepzKY+L0S8p
	 gS7B9r35GKdbCyfNNARm2N6SAdp6UE1wFDK4AHzXEW6RUDWuHiwHohMoV62V8/+43x
	 99FWIDTvJCEZg==
Date: Tue, 16 Jun 2026 08:23:02 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Chia-Yu Chang (Nokia)" <chia-yu.chang@nokia-bell-labs.com>
Cc: "edumazet@google.com" <edumazet@google.com>, "ncardwell@google.com"
 <ncardwell@google.com>, "jolsa@kernel.org" <jolsa@kernel.org>,
 "yonghong.song@linux.dev" <yonghong.song@linux.dev>, "song@kernel.org"
 <song@kernel.org>, "linux-kselftest@vger.kernel.org"
 <linux-kselftest@vger.kernel.org>, "memxor@gmail.com" <memxor@gmail.com>,
 "shuah@kernel.org" <shuah@kernel.org>, "martin.lau@linux.dev"
 <martin.lau@linux.dev>, "ast@kernel.org" <ast@kernel.org>,
 "daniel@iogearbox.net" <daniel@iogearbox.net>, "andrii@kernel.org"
 <andrii@kernel.org>, "eddyz87@gmail.com" <eddyz87@gmail.com>,
 "horms@kernel.org" <horms@kernel.org>, "dsahern@kernel.org"
 <dsahern@kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "pabeni@redhat.com"
 <pabeni@redhat.com>, "jhs@mojatatu.com" <jhs@mojatatu.com>,
 "stephen@networkplumber.org" <stephen@networkplumber.org>,
 "davem@davemloft.net" <davem@davemloft.net>, "andrew+netdev@lunn.ch"
 <andrew+netdev@lunn.ch>, "donald.hunter@gmail.com"
 <donald.hunter@gmail.com>, "kuniyu@google.com" <kuniyu@google.com>,
 "ij@kernel.org" <ij@kernel.org>, "Koen De Schepper (Nokia)"
 <koen.de_schepper@nokia-bell-labs.com>, "g.white@cablelabs.com"
 <g.white@cablelabs.com>, "ingemar.s.johansson@ericsson.com"
 <ingemar.s.johansson@ericsson.com>, "mirja.kuehlewind@ericsson.com"
 <mirja.kuehlewind@ericsson.com>, "cheshire@apple.com" <cheshire@apple.com>,
 "rs.ietf@gmx.at" <rs.ietf@gmx.at>, "Jason_Livingood@comcast.com"
 <Jason_Livingood@comcast.com>, "vidhi_goel@apple.com"
 <vidhi_goel@apple.com>
Subject: Re: [PATCH v2 net-next 1/1] tcp: Replace min_tso_segs() with
 tso_segs() CC callback for TCP Prague
Message-ID: <20260616082302.3618bd90@kernel.org>
In-Reply-To: <PAXPR07MB7984585F9348BB3F000EB330A3E52@PAXPR07MB7984.eurprd07.prod.outlook.com>
References: <20260614071756.239686-1-chia-yu.chang@nokia-bell-labs.com>
	<20260615185102.5e8de52d@kernel.org>
	<20260615191704.31be22da@kernel.org>
	<PAXPR07MB7984585F9348BB3F000EB330A3E52@PAXPR07MB7984.eurprd07.prod.outlook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 16 Jun 2026 12:23:11 +0000 Chia-Yu Chang (Nokia) wrote:
> > On Mon, 15 Jun 2026 18:51:02 -0700 Jakub Kicinski wrote:  
> > > On Sun, 14 Jun 2026 09:17:56 +0200 chia-yu.chang@nokia-bell-labs.com
> > > Eric, Neal, looks good?
> > >
> > > The min rtt thing in tcp_tso_autosize() helps a bit but if the sender 
> > > gets congested for a longer stretch min_rtts on new connections are 
> > > high and we're back to sending small TSO, keeping the sender overloaded.
> > > Which is to say - I _hope_ this also solves some of Meta's problems :)  
> > 
> > Ugh, I didn't see the Sashiko report, it's only CCed to the author and bpf@, not to netdev :/
> > 
> > The zero-check sounds legit. Let's revisit this after the merge window.  
> 
> Thanks for the comment, I will take action after the merge window.
> 
> And, please correct me if I am wrong, the next eligible submission is expected from 30-June, right?

It usually opens Monday morning (PST) so Jun 29th
