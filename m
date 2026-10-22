Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792663392;
	b=w47HdD5Y3IPsSR8tBJBKPe7ADb3zBMmoi2mnMC2SH+azFyJzHICl6ww6DfVfS4e3YFmz
	 HslyE/7qayAQ6jHgSNmPO3sA7qtJD0OIO5EBCmtr2Fv892R7BLfXTcooAF0I87wnqPvuc
	 q8imaY7PwA/UWqT1Dtvcet4azvROBa8oQh+SJve99D+d/7ZccOSH/YKMyldNaU2mVzcdF
	 iJjhEQQIMVtvjuSd7cp4FMs9VhldraWbSFfHaTtPyHR8jXwx4WIuntLNwc4ctPN6ZOOb0
	 IFlRRynTJnNPk/dQeHPMrS1AcLa0Z0rzzOd9XSbvlq/+mI8iPpc00PQQ7rxoVUXE7Dg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792663392;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	b=d77M0x8e/wZZO9+jhMjnDBMzX+6H05XzDJFWFjExTtTv4IzAiGR0TYLkL14P6peWajbp
	 5L64Id0WyCCSPi590lVfhHDrDFOTeBrEXKKft08lOBPRQn3lE7pLFMox+fj7SaKZK49A2
	 SfiUhHcc9iJ9TrsX3iBpOUpOVqEV+8OCyN8W4qr66mly342+zEEnx5G6RLiyxTs7kkRXZ
	 r7Jm3SbTMPP8IoFN0fY/jYMPb/Db5fX2raqQY/H4FZcbxfYvI8qA0KcX0822VMkdqkJF5
	 dPCsh3Ep5BCL9TyhJHM0qLsfJjyaFDQ37YLoH2NBpEkQofizPq31EhzOzIVNEUvlklg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YB5obVEn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E665606A32F;
	Thu, 22 Oct 2026 10:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YB5obVEn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D1C51F000C1;
	Thu, 22 Oct 2026 10:03:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792663391;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YB5obVEn6prZEpAh3lVidgQj8DoL1YoYmWeM6YAi0gVLCZaqkNPbfajHjbAgp1OZA
	 rLdKAwK5YqkRbh21npc9/wqv73O8lSVMdi52fisufsA97WfOZV2Tffv7LbN72oLk3k
	 fAB7yQ7WP4/YTlWY4GSI30z1U5jXN/RjLCeuudigDSthpeZXgSKOHkkoY3I9E6mY2R
	 ezVb0/AymNrl7OPfxClVoazO5/FJYfnSRkiVRtB+DaN5XglCNzCgP4LIWEoppDSl49
	 LdLblLytwIWkaDMKYv+TcdxKivWNNGWDGVgEpb5TaSNV6idbXAMQItktko7KVVgixv
	 rMLlTbVaKzbvg==
From: netdev-bot+sinfo@kernel.org
To: Rui Qi <qirui.001@bytedance.com>
Cc: netdev@vger.kernel.org, John Fastabend <john.fastabend@gmail.com>,
 Jakub Sitnicki <jakub@cloudflare.com>, Jiayuan Chen <jiayuan.chen@linux.dev>,
 Eric Dumazet <edumazet@kernel.org>, Neal Cardwell <ncardwell@google.com>,
 Kuniyuki Iwashima <kuniyu@google.com>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Levi Zim <rsworktech@outlook.com>,
 "open list:BPF [L7 FRAMEWORK] (sockmap)" <bpf@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>
Subject: 
 Re: [PATCH] bpf, sockmap: Propagate sk_msg_memcopy_from_iter error code
Date: Thu, 22 Oct 2026 10:03:10 +0000
Message-ID: <179266339055.3290.10579295938182930016@kernel.org>
In-Reply-To: <20261022095853.1829161-1-qirui.001@bytedance.com>
References: <20261022095853.1829161-1-qirui.001@bytedance.com>
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

 - Whether the issue was actually triggered, or is only theoretical
   (e.g. found by code inspection). If it was triggered please include
   the symptoms, like the stack trace or error messages.

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
