Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793363041;
	b=slqIY9WVYaK+86gmzKPqNRXZ1JmxE+8fstGper96fk21ZoljrALJFFD3JnXPEXwpLe3u
	 QxcDdXil3Oq6vdPP5ZpcFusGVUySmpv0kFXCyNzNWX2L6YrU5edbULlcdvn0Jyrd+akPW
	 QQ2gphhA+TjFDGe1MNln+ppUBRUSzHrJYsUZd3qi9h4okGJPnwfpxDtIGmj3828C/PJHr
	 gn1a7WUQt8+tT7Ms+wZtX+Wzke51Ys5XtCRWDU/OMjbVqV+JTKMd8Od3uYShayWKGvnYv
	 KOanlyE7aqwZC85ZWlI11z5js7at1k0r7IIcgQN2W8qC5QDy89HbJsNSL13COTqJvoQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793363041;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=ZCAoLYZlSrLohEk+mBrzJi43HvKosm2TxiN/tMhp9/s=;
	b=cBNGU2Rhyk2ONsxRq54H3qJ5gMWgU3YH8N3iHHmY5KrLG4Vtyk30ODRBEyZg6rJxhjSd
	 i94gvFeJJk2VHIyaqtpLUz+QdRll1RHncZgh+tTMgWA49LDuqKYjNIzB23qsGYi3Fh14y
	 3h2X6YVqI5M0oz94mAkjmDTidpQ+CpDtawuNSw64pvUVpeaSa+EEK/hpWIb4irn1gkpFj
	 tAz5qN8Ywm7e1jnAIadX5BkNaj/KopvGQLQiT81E2bVdyz4LO6Phv1B4xoB36kZFB/BnT
	 qumBssphrmMSB209hU55p8MP2TSJDsgQiGFBFtKJj7oPll+gdlfCzne0FnxTeGpbcJg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UsrnWmk0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C97606A31C;
	Fri, 30 Oct 2026 12:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UsrnWmk0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B82D31F000C1;
	Fri, 30 Oct 2026 12:24:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793363041;
	bh=ZCAoLYZlSrLohEk+mBrzJi43HvKosm2TxiN/tMhp9/s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UsrnWmk0tNu2Ota/pUSV7d1ppcc6O+aCrxP/1nY8K89vzVBZtdyvjyXoOgqbJyRMB
	 8+1hohHqugsJGDRs1P40L2OvyPU0gKPQZcV1gi9jKuUjGE0Q+O3pHl71ZHkYX338g3
	 Q3FQTAGcLQ+hsJ4pN7ZwCKjtF4YesoXYsdf9/29oZq3SNvbcoWTONNvBP7OIiw63W3
	 QHYv05fxC+StT0+APDa089m7pC3TbJdgEem0RprffF/cAevbh9P8foLvBC++JolG9F
	 IY+5eqVp+EwQpE4jrfXJgazCad17QEp4YRe04DqeA3LNCb8i2m4i2IjFv49tIZ+A0x
	 6hnBN5K9B/06g==
From: netdev-bot+sinfo@kernel.org
To: Eric Dumazet <edumazet@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>,
 Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, bpf@vger.kernel.org,
 David Laight <david.laight.linux@gmail.com>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Subject: Re: [PATCH v2 net] udp: restore hlist_nulls for primary and secondary
 hash tables
Date: Fri, 30 Oct 2026 12:24:00 +0000
Message-ID: <179336304025.3327.10793165490482025394@kernel.org>
In-Reply-To: <20261030122045.3035709-1-edumazet@kernel.org>
References: <20261030122045.3035709-1-edumazet@kernel.org>
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
