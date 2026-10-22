Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792656189;
	b=c7tqL4c/rEtZ3CSYsBg84/F3NGg3e56OjlQ9xlYHRuzvePLIgRmVhJxvIJQoBbVhCxMe
	 PEbiY8Md2JJStnIk26Uu7TDgXFfOOQZ3xTgqRcxphgbq8lUtsVkBHTyuNy4B6pz4eNSsR
	 kQtHxpe8/7Fc+GzNVA2H2VNvdRvxiHhrjW5yUIOEJskd7hJvbF1MY1Kih0hP0fW994Jop
	 N8fxhrx7NnNa0K0Gd3pvRAHXT8AKRbj/hDg3ANto6NTx9Mp3LA/MSnY1b02FxlVUrvBfx
	 Fb8JQIyy/XRztQjbvrorQJLkoDSDO69jww48aQ8voPu+ByzdufKsWVll9ZFhgSba/Cw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792656189;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	b=0YlYQV6Etaand/7nvfHGt9haD56uWLN172lCNlj5YngmhYwP1ppNlH/8rtAOf/nF1rtq
	 KTBhievzGb4VvqO6qlTmeQAoY8L2LXZuHGszCBxUEw5qZhkALAm8CvpxK59vr389ON3LJ
	 YnG2lw0bSwhZhWq/A7Na33fIPibr2XMqx1PBKA9NlcruJIOdwOpVwAf1hYcGZp1kdSnnX
	 0wvvPieW6GuXPoDpbVBfduaCDSDkcwPwpeEniuNVcO3oV/UnjekbiRpovt6LQa+dBpuOg
	 6J5T8t7o42ZB0irBpqh9gchX0wIWAPLMa+E/Kjy+RfF3EV1zw8eGqInEiQ6SaISCJiA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IKMXTvuY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72CE9606A31A;
	Thu, 22 Oct 2026 08:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IKMXTvuY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E59F1F000C1;
	Thu, 22 Oct 2026 08:03:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792656189;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IKMXTvuY7A39mNbitGLZkITWaYkQaEM3fZri0v2Ks6yJekcEwZKE8M2RhP8CL5sjA
	 vEQYsZHgDcNeF2o9ImlGD8yXTL8QLf+6UiDtFHWqPye+1Uiqs8Ev4pfZ3UN4LyjLuC
	 BBE9bbVo1LhLSrcszi65VwiED3o87VUR6iSAp/vsMTEK9jVbZSQJpFssJcmgs1IK+g
	 UOPunpKfLmXsvOZlPh4s6Y1MHZ6wlujgkZl69CiZWe9W/5OAUB4wJ9QCHlj4YqsYvV
	 W/vJQScXBOprhlrRpFGGqujJ6keZysuS+LS1mm0nHwAGe6viKK5fjO2eV4w4HS2DKL
	 ARRCzpxTa7VEw==
From: netdev-bot+sinfo@kernel.org
To: Zhiling Zou <zhilinz@nebusec.ai>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, magnus.karlsson@intel.com,
 maciej.fijalkowski@intel.com, sdf@fomichev.me, davem@davemloft.net,
 edumazet@kernel.org, pabeni@redhat.com, horms@kernel.org, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 vega@nebusec.ai
Subject: Re: [PATCH net 0/1] xsk: validate fill-ring producer index
Date: Thu, 22 Oct 2026 08:03:07 +0000
Message-ID: <179265618778.3290.6590304416142136273@kernel.org>
In-Reply-To: <cover.1792654486.git.zhilinz@nebusec.ai>
References: <cover.1792654486.git.zhilinz@nebusec.ai>
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
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
