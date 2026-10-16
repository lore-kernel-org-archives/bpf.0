Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A83B422D7A1;
	Fri, 16 Oct 2026 02:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792116256; cv=none; b=ApHh2Z4+dW7o8uuEkdCRQbdkuJzXhtNR7oJiJ3mxH3e8M/Yx6te7cQ9eoKnWNSkmGNnZr5JyG1FijMchJPlDIhLBTRoyQ4Lvvp48+bE6/FUSzmPACP56C7BLQXBLjBHHbniue0e9IuMIOc7cU+BRtMsjMqOZOrY5eIc21w2hCgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792116256; c=relaxed/simple;
	bh=Ek1V+N7g1D2a4bZSwwuQseWVPWHykaYNi0E7PzhBNKY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZsT/57WNW03mF7kowuDw/VqTnplgdr9Ao+F2ZSrMJ3vShZawtBghN2EIsrIlGiomQVGL6uk6yCT6waRxpFGRu6VwGVa8ojM3RLs0w1leIFLD43AeaQSqjhYcwDRlRLx31kkIO213gpiq5s2uLDIC8/MlF+6d5Nv5WQMptB6OvYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YrQh5WU6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YrQh5WU6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D514A1F000C4;
	Fri, 16 Oct 2026 02:04:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792116255;
	bh=1Fukj1dfV1IvigqoxcDUAtpNDbjYsN/ZWbsZDQKeTMI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=YrQh5WU6+oNMTDVjYV1QtxM+nzrJ5Wnz9YbF+6PQZKa2BV1Qm/PZVPTqGyaoSgJbR
	 3GfL6KfeVrGfEy016lQADy+4pQ8lY+arXD9lh++6AZb+PUUMKZQnYyh+T57vXytWao
	 gbOid5qjeG63pey29xVn3D/6+Wsqfpj5BZb+AsAiDNNk7CdNzlgaVTglDXK17EY+Xb
	 2J7selcd/zCvatRe4d+an0M+lPQhKF3rLt3rs1AEp0/fw81DKsXC97UnmTZ+1Dwd97
	 OHSK+cQ1L8l24jszIJHNZEobv/D6oLv+XnmSjSlNupukLjlPy1GtyZLLgv3LeScAsM
	 +qKXuW7YCp1IA==
Date: Thu, 15 Oct 2026 19:04:14 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Quanye Yang via B4 Relay <devnull+quanyeyang.proton.me@kernel.org>
Cc: quanyeyang@proton.me, John Fastabend <john.fastabend@gmail.com>, Sabrina
 Dubroca <sd@queasysnail.net>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Jakub Sitnicki <jakub@cloudflare.com>, Jiayuan
 Chen <jiayuan.chen@linux.dev>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH net-next v3 1/2] tls: annotate lockless access to
 sk->sk_err
Message-ID: <20261015190414.000e83dd@kernel.org>
In-Reply-To: <20261010-tls-fix-sk-kcsan-err-v3-1-e28aadeb31ad@proton.me>
References: <20261010-tls-fix-sk-kcsan-err-v3-0-e28aadeb31ad@proton.me>
	<20261010-tls-fix-sk-kcsan-err-v3-1-e28aadeb31ad@proton.me>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 10 Oct 2026 07:46:28 -0700 Quanye Yang via B4 Relay wrote:
> +		if (has_copied) {
> +			int err = READ_ONCE(sk->sk_err);
> +
> +			if (err)
> +				return -err;
> +		} else {
> +			int err = sock_error(sk);
> +
> +			if (err)
> +				return err;

the int err declaration force you to add ugly empty
lines, just decl skerr at the top level of the func
and use it here and in the chunk below
-- 
pw-bot: cr
