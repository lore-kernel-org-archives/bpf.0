Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3499951121F;
	Wed, 30 Sep 2026 21:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790805290; cv=none; b=WYe9nBueMoAF93ygAdBd1evVKOHupLTOohOOAVWrNiLo3/6W43Ga9WjK6Frr840KAPpIys4enSWF2mj0TEeRMaMK6qslml8KVYoCH1pDW4Y7G8C4fUX8DfvXQDX8PAzffsoISZSt4IHlZvlLVMOaS4HPxgRyRz2YbKmTsMJk84o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790805290; c=relaxed/simple;
	bh=DxOA3K04TdGKgV9RBzwq7NMB042SfZvdvrNpiga7nYU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JSwcBq3rHVDeaMoejBh/LWEh2ZdgaPUzWuG6Jg17Kog2iVM1yzPiLUMjc4DkXfn9V1w+tRqaxqok4O5Hrz1938Zo08YObQ4aJytSmK+y/MT0wyrLLzAIVCmjqKCvllLDy3h5bIh1t7rWsQYdC0k0nHMH0LUs70jZL01k2zPUctQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S+6VrlJh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S+6VrlJh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8D271F000FF;
	Wed, 30 Sep 2026 21:54:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790805288;
	bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=S+6VrlJhleKk/D23qXCGHjQRBlzgzVEjaeTEzwZSxyQPbKY4X23mGzknudLaguk7a
	 orFNCIi8+tzm3Er9qVWS436J8dyEEJHvQV8PtJ6+hofwDK668H1wfwK5zJmOB1OAHH
	 XBDr8J2lRL7eGTW5WMHmc6IMftagAux1SM6JYMHqXJpjZIyze1Ss2JMuhs2byDox2l
	 1pxxA2A0WqI0c+9XpP3S8v07du0Vz2bQ88BT4NYVWxqiCSjs036Yrlphnr2LHn+LM9
	 ooUwg6WXqvbij1ro0Veo2bLH0Vgb9f684wrlZF9hD8y4oxeyXKfy9BbDaqkIl7Yx4k
	 ivw3fByqWvCwg==
From: netdev-bot+sinfo@kernel.org
To: Joshua Washington <joshwash@google.com>
Cc: netdev@vger.kernel.org, Harshitha Ramamurthy <hramamurthy@google.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>,
 Jordan Rhee <jordanrhee@google.com>, Ankit Garg <nktgrg@google.com>,
 Tim Hostetler <thostet@google.com>, Jeroen de Borst <jeroendb@google.com>,
 Praveen Kaligineedi <pkaligineedi@google.com>,
 Stanislav Fomichev <sdf@fomichev.me>, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org
Subject: Re: [PATCH net v3 0/3] gve: various XDP fixes
Date: Wed, 30 Sep 2026 21:54:47 +0000
Message-ID: <179080528731.31693.11268580346361726174@kernel.org>
In-Reply-To: <20260930214735.3288780-1-joshwash@google.com>
References: <20260930214735.3288780-1-joshwash@google.com>
Auto-Submitted: auto-generated
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi!

This is an automated message. This series looks like a fix, but its
commit messages seem to be missing some information:

 - How the issue was discovered, e.g. hit in production, hit during
   development, syzbot report, manual code inspection, LLM or static
   analysis tool scan.

 - Whether the issue was actually triggered, or is only theoretical
   (e.g. found by code inspection). If it was triggered please include
   the symptoms, like the stack trace or error messages.

 - What hardware the change was tested on. For driver fixes please
   mention the device (and if relevant firmware version) used for
   testing, or say that the change was not tested on real hardware.

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
