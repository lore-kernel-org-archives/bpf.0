Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B4364A441F;
	Thu, 15 Oct 2026 09:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792055291; cv=none; b=JJeIC5RZ/y48Bomomxdccp3OWQW/b+X3IWHWehqEJASRynrHejLKvx1C5R7PfYHU+XNzI6kBEzPn0wkTm6WzA67AwQLDrY5wvNMOL1C9+QoApJ4n9/keqdxM7QUUTIjZ4mp081n+sT1q7bkApDd0CpjkEZ84lWn2px5ZgvS9wRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792055291; c=relaxed/simple;
	bh=zuaM+VGru1m/6y7TFr9PaijXH9jqx4LvM/Kzy9qrWuU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KIVTgnbm6W25JXb2EAnd8F3+Qokfy9Cc2HkHr4RwRQ8SgmVa/OZ0r3svnk1EzWOmFUFLxme879y2dDfs/0GFuPvNs3XaA1GdX/UNIUviQbisKaToe5KOodDXO0PZXkzZ1bETkw6gfMIbnDXA+NJWzPZlXNR1vT6p2eVQDZqc2/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=i6jkBeWL; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="i6jkBeWL"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=I++fZM7lxU4jwwgJIKIJhzt0UB3NLsFnGz+ZkO6eDWM=; b=i6jkBeWLXEjeEBhbrRx3iPtjTR
	a1Xx7VCs0wjMB5AySVTdo55qNeIdl5LlA3hKbu4n31iVn0pBuw5UbqubLdcFyPQG2zmZLCy4oCS47
	m0RxCYM5jy6M+fSiLH9U+cYDpSv1Ik9IXROU5wFJ6YmvtKcjca4lrczHL+GRRYQ4fFp1uiVjsqSuD
	gFJUQQeccaNbetodZOuHtjgwhFjsznTyZ8dl5eZzXw4DTaKBJXYED4F6wKbVVA89QwiRJeIc4n3Nq
	QoFSw12wfGPAfJ+jgX5GRva0O4X32zGyMf8WRfSJF3llJhMDmouCb2+9EmcnRqsw4RmdzyeMNOnR5
	fswpbE6g==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1xHHRD-00557i-2M;
	Thu, 15 Oct 2026 09:07:47 +0000
Date: Thu, 15 Oct 2026 02:07:40 -0700
From: Breno Leitao <leitao@debian.org>
To: Stanislav Fomichev <sdf.kernel@gmail.com>
Cc: David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	Jiri Olsa <jolsa@kernel.org>, Emil Tsalapatis <emil@etsalapatis.com>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Shuah Khan <shuah@kernel.org>, 
	Eric Dumazet <edumazet@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, david.laight.linux@gmail.com, 
	kernel-team@meta.com
Subject: Re: [PATCH net-next v2 0/7] ipv4,ipv6: convert the getsockopt
 switches to sockopt_t
Message-ID: <atCXY4Net2pzxecg@gmail.com>
References: <20261009-sockopt_expand_out_v2-v2-0-8ac08c469ecb@debian.org>
 <as_EIAJpsA1nWKU4@devvm7509.cco0.facebook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <as_EIAJpsA1nWKU4@devvm7509.cco0.facebook.com>
X-Debian-User: leitao

On Wed, Oct 14, 2026 at 11:04:24AM -0700, Stanislav Fomichev wrote:

> Acked-by: Stanislav Fomichev <sdf@fomichev.me>

Thanks! I will respin a v3 with the fixes for sashiko, basically doing
the follow to try to keep sashiko clean.

	1) restore the -EINVAL for MRT6_* when optlen is negative
	2) Fix the commit messages issues.

--breno
