Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795053300;
	b=CEhjoii+OhfVnXWhum6eT3TGGtUUXGyc9f3RebgHzWRz9VTC9oR72yuW66EyDx+4/U1w
	 AupztOAz7fa/sigI4mHOOnoiWGJtyYUicwJ2sZD/C9OoLjiJByMr9FSs/sovdg1SGejiE
	 1FaXwaDmpg+fk6f688Tw67/ud5KTKMdnuod8n0hiUlagexQeLcgiSXlXIoUBbzXFiCLIb
	 LQPEwdAGPY1Wh8ZCrTiNJu2T8dihRZyK91SMy7o5qnv5TUuG/ShU/68gRIqmLU/+i9YGU
	 jNv34/DPbSy/ilrWOoIGDKqmFSrMexPmKyspsGE9q2lqDZDYovbFpORMJO4AFpvOAoA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795053300;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=6oqckTj4aBrYkNlCPOoGtpoPLOPKhvVx0CS2wne8WA8=;
	b=yJeUYxlABjJxFk3bad92tHULaena/FnRCkQryVRwzM37ASJ0fpdACDQ9vhkULggsBo5K
	 XCQUKPtRj29Vzza9BTGzp++hmQi6LXY7h05A/wYTJ9gdP0pYtJso4HTpSRZwfVsCQ/J/9
	 /nqJ7XgILSHWhG+ksD7m4PpjpPNUIM8GAeIJw4wCRQwCBD/P9khMq9SS2KEzBkrs3eu79
	 O0rxjmGfDp22QgakMbR6+xDs+VuiX/MYzU7Kc5yEqQW9ItoydGefI9LRWMYvkX/1EMMnB
	 SuipuegbW/NqhL03UXUuymCh20qdkcbJ40TyphQGXr7otv/qp83E39kI7nAXjv6FGwA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=laiqhx6J;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A3D060A260E;
	Thu, 19 Nov 2026 01:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=laiqhx6J
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A885D1F000C5;
	Thu, 19 Nov 2026 01:54:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795053300;
	bh=6oqckTj4aBrYkNlCPOoGtpoPLOPKhvVx0CS2wne8WA8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=laiqhx6JSs7EWtNGLJtaa4YqZt/dnpnLkxKJ1ohDy0R5XLGTHBN/X/sst+q1STvlU
	 vRPeVi7Q4djMZw7uKUQB+HYuaNbi5mGS1PbeLyLG65RtWZKKxd0XyemGLZs7zWHh1N
	 Ai3KjrFxZO567G/hzF4OvO6mfSMKfUFBq2KBlG57eHe3JfzYi6ufe4m1zf9XZhJnLh
	 aYRzaPJtaLT34l8rCWy5XPiv8Df3BmfQkIDUGHhodlZqVFkgDc/y4V8cQfD0H6rU0W
	 0HLRkcN58CpqelRnHOeERaHv67oteX2Lwj3mwPEFjQvYksrDVwfqBGhTTcOEwW0pXp
	 agzSWIDt1FVVw==
Date: Wed, 18 Nov 2026 17:54:58 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
Cc: "Shihuang Liu" <shlomojune6@gmail.com>, <netdev@vger.kernel.org>,
 <bpf@vger.kernel.org>, <edumazet@kernel.org>, <kuniyu@google.com>,
 <pabeni@redhat.com>, <willemb@google.com>, <davem@davemloft.net>,
 <horms@kernel.org>
Subject: Re: [PATCH v2] net: sock_reuseport: check program type on the
 migration path
Message-ID: <20261118175458.6c7e5940@kernel.org>
In-Reply-To: <DMYSGWL8247Y.DQAGO9I6EPK3@gmail.com>
References: <20261118153541.172499-1-shlomojune6@gmail.com>
	<DMYSGWL8247Y.DQAGO9I6EPK3@gmail.com>
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

On Thu, 19 Nov 2026 01:16:30 +0000 Alexei Starovoitov wrote:
> netdev folks, opinion?
> I'm fine whichever way.

Don't care either FWIW, if you want to take it:

Acked-by: Jakub Kicinski <kuba@kernel.org>
