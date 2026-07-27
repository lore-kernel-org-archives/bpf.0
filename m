Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99ECB3C2B8D;
	Mon, 27 Jul 2026 23:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785193724; cv=none; b=eLLR1HaGh6iTfLDi9QUg4dyXsy7S0wJ79YKAbY4K9orDkZ6Z2aaYRcLA5EaAIYDF+GFOWs2vS8xG5zBrEP8ys4asZN7+voIhVQ9dijYjCOcrUlIzhlAWibMGyDaVRYwgGChWLVlRxRGX2tipYbmsaLyT3ed45SswDMopvmwuBeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785193724; c=relaxed/simple;
	bh=I78J8rlILj0qomHIOdPBN4IPMyQJ6lurM+p5CZWcrtc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aqUEmiDxoInuJ1IaPfheqJDBP7vqXP8067CzDqSiC9xaJLfF63qXm0WBhMylrxGN6iFYJE39tgezyrEUvidYmCcGgFSznyRSvi6CV6tg8oF4kteCPoaXCPdr6nefMQLKqpOoaYsm+Hl1W8Ui6jTN1T36wdkxGjEEI872o51W+7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IuX+/7D7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IuX+/7D7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D627C1F00A3A;
	Mon, 27 Jul 2026 23:08:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785193723;
	bh=PxFa8mBAJMO2Gptu6EU6UbOF+/7VolunlsPoWte10eI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=IuX+/7D7lEEEwqdad4Jq6UJvUexUMhpvd7sDZVcpJXWgrFUA+6HNfjsuGkxE3f/00
	 aauvNLMM8W8oqIBKhqXDOG5PSudSuoJT58QXY1d5zIS9Yb6lFJheGfSo7lDBrdHfmM
	 FBwuHPzC4BRdYLa8vLqle4kIFtJ9KPBiO9RTPuvViqfrBly9+RlnpU0zJ4xNX5T2BD
	 osND9Ygv9VsMl9tt4QhE0TeTXXSuhy4nznb1mD6fK5D15t+NotLhKxt0sWGE90LkGg
	 +rFrzCegova+mS0kVpaHP3ecCjpG/Nqfctomlu0KrVTGQp+ZtAOp6ZXMSDyl9yTltM
	 ORz+nQD6ppgvw==
Date: Mon, 27 Jul 2026 16:08:42 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Chia-Yu Chang (Nokia)" <chia-yu.chang@nokia-bell-labs.com>
Cc: "horms@kernel.org" <horms@kernel.org>, "dsahern@kernel.org"
 <dsahern@kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "pabeni@redhat.com"
 <pabeni@redhat.com>, "jhs@mojatatu.com" <jhs@mojatatu.com>,
 "stephen@networkplumber.org" <stephen@networkplumber.org>,
 "davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
 <edumazet@google.com>, "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
 "donald.hunter@gmail.com" <donald.hunter@gmail.com>, "kuniyu@google.com"
 <kuniyu@google.com>, "ij@kernel.org" <ij@kernel.org>,
 "ncardwell@google.com" <ncardwell@google.com>, "Koen De Schepper (Nokia)"
 <koen.de_schepper@nokia-bell-labs.com>, "g.white@cablelabs.com"
 <g.white@cablelabs.com>, "ingemar.s.johansson@ericsson.com"
 <ingemar.s.johansson@ericsson.com>, "mirja.kuehlewind@ericsson.com"
 <mirja.kuehlewind@ericsson.com>, "cheshire@apple.com" <cheshire@apple.com>,
 "rs.ietf@gmx.at" <rs.ietf@gmx.at>, "Jason_Livingood@comcast.com"
 <Jason_Livingood@comcast.com>, "vidhi_goel@apple.com"
 <vidhi_goel@apple.com>
Subject: Re: [PATCH v4 net-next 1/1] tcp: allow congestion controls to
 override TSO autosizing
Message-ID: <20260727160842.5bf1b6ac@kernel.org>
In-Reply-To: <PAXPR07MB79842FC5D44F3964BFEDA505A3CC2@PAXPR07MB7984.eurprd07.prod.outlook.com>
References: <20260726193802.397321-1-chia-yu.chang@nokia-bell-labs.com>
	<PAXPR07MB79842FC5D44F3964BFEDA505A3CC2@PAXPR07MB7984.eurprd07.prod.outlook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 27 Jul 2026 08:02:00 +0000 Chia-Yu Chang (Nokia) wrote:
> I see this commit is marked as Changes Requested; however, I do not see any request yet.
> 
> Could anyone let me know which specific request it is?
> 
> This commit updated our previously submitted v3 https://lore.kernel.org/all/20260630120145.286497-1-chia-yu.chang@nokia-bell-labs.com/ to have no impact on BPF.

The BPF CI has failed with your patch applied, that's why it was
auto-ejected. You need to fix up the BPF selftests to use the new
callback.
