Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795189664;
	b=oODF67/pAqtgBHr6yjeii55qVCdzLSjFchoVKXBc8qnWb8ybBUurmXKZB20eLhBqsYV0
	 psc4x0NGCmDdrLt5UOjySpsLfK2srQ/m3InHJtSXGuvd44yWDTD6xy79bbguz7HF1UQHJ
	 cvP01qBWD7+vx9ibOneX+PMbPeBaikR4MJA/9BOeVmgx+tXHAc0zxNWhIDmu3lEftlz9K
	 WqKpLoW6E96fkCXJWeN+EUTaT5agdo27rX0gPL1hXgLcixEOmqZKTZ/C2SD6rOWpCsnkC
	 nZnMX9KNCPsKEFGt9QSeBvy8IIWUnlVzC4b0yONvCW7BxDy/NZAj/ISrUKQ9iUQFYFw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795189664;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=sS9FIrfW22SIhehTvpH3rdvmtslwIeEYozBr0OvaZe8=;
	b=RWszjj99M/gXC43cpEK5UvOhucAfqztcJdmlLQegN9YXoJvT5/aVmaM3f7cHiSdKbNvp
	 RMBr2yynRmilz+5NhJ7rv9hHujjorbIWpikZXFr6IXFdKkDcI5f51WSPfFyfxqAk98zyG
	 liZbmQ/pUld4ScjukglM3c06z6ySgbgGAjecL4aHnZ6Izd7+P1u1AL3epzLyG/HDskKG5
	 rg76H2qzb15HTcquoteLZY1wGKbFxEIYy9wChU+W3vCNXkMmag/qAgST7MAoCo7ja3HeR
	 6Ppa/svZxo3oujNFDUfeinSUC1RJAwokHrLL+l6vQFi8PIrltnAqdP4XXnZ+6WiHZEQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mCLElhnF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89F9D60A2601;
	Fri, 20 Nov 2026 15:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mCLElhnF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F76A1F000D1;
	Fri, 20 Nov 2026 15:47:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795189664;
	bh=sS9FIrfW22SIhehTvpH3rdvmtslwIeEYozBr0OvaZe8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mCLElhnFr4/AoPZb/NFGMVEnmoeiSCitsPhZ7g8eiopeP+FrL4cYiweHZojEBbJ07
	 l58B6XpHJh90KYGeE4RbARqUpV73QSEV4NN0OUuAjEPmaLvanU9OkQPYcVPuTJGt7t
	 +k8Lhb1z+u8G6DgZ9msEEUWvJbuLoWNdzNPvA8wqn9g2dJpyrWXs1R5FPwB8wFz884
	 cac2Grx6gLOYecXOqM/LabmTcybO1JjGUJ4KYYjUQJMAeSJNOFdBrGAayXuvOkao9f
	 y6jedtFLBDSuPCqHhvSatkxjxN/UWXv8BV3MNnxoT5sYJS/hWdS84xAMg0/WmmJnkA
	 CP/UpK9TyFuOQ==
From: netdev-bot+sinfo@kernel.org
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Jiri Pirko <jiri@resnulli.us>, Victor Nogueira <victor@mojatatu.com>
Subject: Re: [PATCH net-next 0/1] net: neighbour: skip the stale dst lookup
 for a redirected skb
Date: Fri, 20 Nov 2026 15:47:43 +0000
Message-ID: <179518966319.3291.5653366565460355407@kernel.org>
In-Reply-To: <CORE-J9UK.v1.r0.20261120103344@mojatatu.com>
References: <CORE-J9UK.v1.r0.20261120103344@mojatatu.com>
Auto-Submitted: auto-generated
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Hi!

This is an automated message. This series looks like a fix, but its
commit messages seem to be missing some information:

 - How the issue was discovered, e.g. hit in production, hit during
   development, syzbot report, manual code inspection, LLM or static
   analysis tool scan.

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account.

*IMPORTANT*: If you do repost (for other reasons) - please include
the relevant info in the cover letter or commit messages.
-- 
The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
