Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795226589;
	b=lCjfQtOh2xoBm5Y06Gk7QJMAP+2vpO5pn5HuDTQB0mmjcVsVVFi3Vrhcw73zP1qBV/Gt
	 NggpVs8Rbo3xsx838ukzI3T39g8b96RuTByK8gwQS29qxsTZMyu3dCgjiYfzfrAqaFdIE
	 k6MZ0vbUUno+bppvfBhKaYINvyfQfATVbJ8X5IJ/inPyhrwsJghGx8oJkKCgr8ptwm9TV
	 agujuW0Jdm11u34zFG3d7tR9FUfGcICxMBvbBQpl646xeQ1ZS24oKoQHxTkn8wLGEMTYT
	 htYL57/QC1ZrzC1MPI9HPUU3a6gv3ANhjEeuw36lGus+CBd6WPHYHkS0UxvcjYXN5yA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795226589;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=mchuVHlFnYU5zgCWTakjMGlmjLTHuywPhXqITRTH/FE=;
	b=pgCkQTIJL9/olJ2P/TC9L1Lq8k79qxPVSOBbJf5OchWZA/D8mR7xH/+W4MHmYeVVug4B
	 qM3g1wBoXqfEUG1TSwxJslsbDxP2bn3TtHa+9e1CmBPcQV6rMzEwZDHPoIM6ObAu93k47
	 m3yRT4BTY9uHCjw1Qxz0mSsSwh1JwIRi0WknLhZ0f8u09YISdHSwX+TlmNiAwydWtfpiJ
	 97rIuwgH7T8vScdKVvWpfsuxvsJa41nVr4NE5OpcOJ3kcTXL2gilIQr+GRBMvbfKAPmQh
	 JasXAjwX0UPoLlmsawabIuSslQjye49apbXGG9OwutpjXzAmH/+20Yy0gkyN4/ucIXg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nD38McHw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E0AE606A683;
	Sat, 21 Nov 2026 02:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nD38McHw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E736B1F000CA;
	Sat, 21 Nov 2026 02:03:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795226588;
	bh=mchuVHlFnYU5zgCWTakjMGlmjLTHuywPhXqITRTH/FE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=nD38McHwbWEPsR/Y4qfwpa0bIhERNb9cQc8T8e8+NZbC7ZbAXr4mDe+TeicoPkrnL
	 hrzktdtrxTeRQjl1GNlsDndy2EzrtSd/C5UxSbDnNgI0GPAoVHaomoaQPsxHLqKJTH
	 Y0pR55OB8EpVvTct0mZgffDQLwb9mRdMlnHAlPo5A1zKoGbsITaWOY9WfLOmWq0fVW
	 5SGoUhmGkFP7KIWo1zgySyRzxhTZX3BcGH5UEYkOY8M1AvQNAYo/ekDGrjuNiY6c1u
	 8gMwu+/2kCojNEO9929HP87LWfmUqVRgbiuXzWVE5ulgy5NzMzQ4MxyM25UJ6vRI0s
	 gg7/QM+KX12oA==
Date: Fri, 20 Nov 2026 18:03:07 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
Cc: "Maciej Fijalkowski" <maciej.fijalkowski@intel.com>,
 <netdev@vger.kernel.org>, <bpf@vger.kernel.org>, <daniel@iogearbox.net>,
 <pabeni@redhat.com>, <edumazet@kernel.org>, <horms@kernel.org>,
 <davem@davemloft.net>, <shuah@kernel.org>, <hawk@kernel.org>,
 <john.fastabend@gmail.com>, <sdf@fomichev.me>, <willemb@google.com>,
 <petrm@nvidia.com>, <bjorn@kernel.org>, <magnus.karlsson@intel.com>,
 <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH net-next] selftests: net: don't warn when bpftool is
 missing
Message-ID: <20261120180307.363312fd@kernel.org>
In-Reply-To: <DMYSCT1OYI5F.2HSYP9MZ2BRJU@gmail.com>
References: <20261118165338.1064930-1-maciej.fijalkowski@intel.com>
	<DMYSCT1OYI5F.2HSYP9MZ2BRJU@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 19 Nov 2026 01:11:08 +0000 Alexei Starovoitov wrote:
> On Wed, Nov 18, 2026 at 08:53 AM Maciej Fijalkowski <maciej.fijalkowski@intel.com> wrote:
> > Based on the bpf-net-xsk-move tag so it can go to net-next and bpf-next
> > through another shared branch, as Alexei asked:  
> 
> Acked-by: Alexei Starovoitov <ast@kernel.org>
> 
> Thanks for the quick fix.
> 
> Jakub,
> could you make another stable branch to pull?

Are you sure we need to fix this? Do we care about the bot?
We have a similar warning for having latest version of liburing
in drivers/net. I think it's useful to let the user know that
they are not building all the tests.
