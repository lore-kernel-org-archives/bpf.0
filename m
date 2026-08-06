Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15A4E483BCF;
	Thu,  6 Aug 2026 15:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786031535; cv=none; b=KfkwKx07txb8pGfl4poRiRdig3YyXAQ2PWmokUgzsdcXcvmKpB9L8EZDNikOuIrq7mQ5L1f4sya33aUlJ7AUYLOXfHZmFp0kftsa4Rtkgm6e2CAXcQrewAWrRYoWv2RvXOxXM2Lw+paTD2dTfi6P7REb2txPRbNIqRN4jSUXwRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786031535; c=relaxed/simple;
	bh=sBKDEW0AUr4kLunSKJ019oApGWBtXsdK0DPgsrfMfJ8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hMCtoE2/coJxENjAeAnPTDu7aeomLWnMk1mUfyTQGX4o4UpinJwvbq+ovv/w+gfCmVqfNVIvs638MNs4DH1BkjYSB7HCqIRFJ5EOLL1s3vjUzpAfVUShZ61y6By+LrMt5eAp4oilAYDw2bLUxahdbuc9d6nZQCbvnTqL8xmk84E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=he0Hu72k; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="he0Hu72k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F07C1F000E9;
	Thu,  6 Aug 2026 15:52:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786031526;
	bh=u9sQG2+W9lMUVWO8Bdrc6IqrG5y10nYPViWQOiYk/+o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=he0Hu72kqoWqqMUzxRuU7R2DBEBdfSuBd03hZWVSX7Nv3nZfUeWrdtQ/01NQcwbaE
	 sDAOExCxDY+K1Ii9Syy0vnR2a7FQtWLReY/PQlEZMFvYU0RJQI7aAAy56pXBEzlagQ
	 TIvai0mNidnX6MzU+BzS7IhmoMVp9IxxMYkBruTIdDlPkdmdzCcJ9rwuv/Z5e36vmb
	 MLHCZxqbFPjWUJx5H0gl4dkqHxwKEmy8opyGlC6hvjzFLz/4CoqHzNm+qYNidOwn37
	 Qwu+XYE/4+k1vuJiShVzpqNqWcIcljPA05vM/T0w3xL50tg7Q0qBa0XCKu51ToAcyk
	 4u8PO6Jz7JYDw==
Date: Thu, 6 Aug 2026 08:52:05 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Feng Tang <feng.tang@linux.alibaba.com>
Cc: "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Shuah Khan <shuah@kernel.org>, Andi Kleen
 <ak@linux.intel.com>, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org
Subject: Re: [PATCH net v2] selftests: net: reuseport_bpf_numa: consider
 cpuless numa node
Message-ID: <20260806085205.5300e081@kernel.org>
In-Reply-To: <20260803014214.80748-1-feng.tang@linux.alibaba.com>
References: <20260803014214.80748-1-feng.tang@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  3 Aug 2026 09:42:14 +0800 Feng Tang wrote:
> +static inline bool is_cpuless_node(int node_id)

Also - why is this "inline" ? It's a test.
