Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2ECE49620;
	Thu, 30 Jul 2026 11:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785412541; cv=none; b=EGm42EKi08NZLcj0uuxveaKtGxlkI9BXOnFZkWLpe0EIg/wzdVLj8WH5/qCL7ESLJxjwN3kxb5BguVkAOMG+uQ9+9a2sJsgma7yDHrbYAzEDf8JoXkNJgPZb9tlPjS02PVy37ipO5RuKfomexkfmfD+DwfTSX2Uax1KkfTBPMIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785412541; c=relaxed/simple;
	bh=+j1VnqSKqnc+FrNGQ+OqOjsz5AUPNsXurs9CX6pwzbU=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=M1Pv7An0xcfqfvLZEic919ROr5cWh45JIZj5qg1zD0o36yVrGJlGMMnKOPHVMWXZP2DlzgGV3Oi2vaJm+jQ+6zvQDptt/9L90ffIM0Ov0/Gt2nlMkJtshyYOqnNF/S6S8kIgxuFBGnAsaRhp3rTS1OYuRPlN8tgeDH9mOXf+fsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=mChPwVLU; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="mChPwVLU"
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1wpPMB-008RM3-Pk; Thu, 30 Jul 2026 13:55:23 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:
	Cc:To:Subject:From:MIME-Version:Date:Message-ID;
	bh=Y9826SXsKMxkrm5PlSCjhk43jMi0lB5nA/aZyGom5VI=; b=mChPwVLUKjiPadu8Nsa/Kfxf2t
	IGLp5aif6HFMpAd2uN/BCtLd+mk6LaJttZFQ194Oixzo0nVvcEGiHIW+6NkVfcF64tO7iPfMGIdB7
	vdzBaX8mEtTDwyqXpLkRYXgXrAePuPOkufb88wxaknHTGW9GlkZ8jwMFAy/bDnEdwu+HQS+d3qh22
	rRFdV2ygZeRPoNZOfFM3wApEwnaXq1LqxM44hfBBRs/YYiDS7R45B/K3PH2Cweqd7cgTvV/XUx62E
	eom2pmsM2LJvNNL3pU7HUc+/PyC7WYZETL9/ajnxwCM7RuBj0/kAAfpUhCcwWun2jtO9RCsRzMt/C
	UNzdW8gA==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1wpPM9-0000Ug-VS; Thu, 30 Jul 2026 13:55:22 +0200
Received: by submission01.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1wpPLu-004qqu-Vf;
	Thu, 30 Jul 2026 13:55:07 +0200
Message-ID: <591fd57e-d006-4e51-af5c-fea65a071819@rbox.co>
Date: Thu, 30 Jul 2026 13:55:04 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Michal Luczaj <mhal@rbox.co>
Subject: Re: [PATCH bpf 3/3] bpf: Unconditionally take socket references in
 lookup helpers
To: Emil Tsalapatis <emil@etsalapatis.com>, Eric Dumazet
 <edumazet@google.com>, Kuniyuki Iwashima <kuniyu@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>,
 John Fastabend <john.fastabend@gmail.com>,
 Jakub Sitnicki <jakub@cloudflare.com>, Jiayuan Chen
 <jiayuan.chen@linux.dev>, "David S. Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Stanislav Fomichev
 <sdf@fomichev.me>, Martin KaFai Lau <martin.lau@linux.dev>,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Joe Stringer <joe@wand.net.nz>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>
References: <20260723-sockmap-lookup-tcp-leak-v1-0-1bbdc58ce514@rbox.co>
 <20260723-sockmap-lookup-tcp-leak-v1-3-1bbdc58ce514@rbox.co>
 <DKBCACHGQHYB.194JPC04N9WT0@etsalapatis.com>
Content-Language: pl-PL, en-GB
In-Reply-To: <DKBCACHGQHYB.194JPC04N9WT0@etsalapatis.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/29/26 22:32, Emil Tsalapatis wrote:
> On Thu Jul 23, 2026 at 7:33 AM EDT, Michal Luczaj wrote:
>> Lookup helpers gate whether to acquire a socket reference on
>> sk_is_refcounted(), a check re-evaluated at release. An established socket
>> refcounted at acquire time can gain SOCK_RCU_FREE via
>> connect(AF_UNSPEC)+listen() before release runs; the release-side re-check
>> then reads sk_is_refcounted() == false and skips the put. The reference
>> leaks.
>>
>> Make acquire and release unconditional and symmetric: always take a
>> reference, always put it. Adapt sk_select_reuseport().
> 
> Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

Thanks!

> The bot's concern about the comment style is obviously invalid here.

Are the prompts incorrect?
https://github.com/masoncl/review-prompts/blob/59469708305eca305cbd9eb94e5aa0ee3627529c/kernel/subsystem/bpf.md#bpf-comment-style

Michal

