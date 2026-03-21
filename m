Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F23FF34846D;
	Sat, 21 Mar 2026 18:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774118565; cv=none; b=i0dHKNigUIeczg6Nv0VmDoEzIhYXAubS0Xw4ZmDH9sH2K/P9XwodLw2RUpKV/8ZOwqPHGZmY3N96c68tyZdz92rohsrr0vlaB5GhiT9gpX9slYmdImRh/7dMcySug20qNz81i7ob4reCgRHaBJTyh4TdyRduMABE+FHKj2P3lrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774118565; c=relaxed/simple;
	bh=o9U4kP9BoiNmczBWmGX/rTwZTTh7SYM3gh/9l0lKK5A=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=begf35vFJaMWjvGnSYidKXj00mHwxJu2xWdrro0xiz5BSbk87BPJ+kgJcvRkyjV554AdxSpdB3G8KDxTmwlK7EJs4crnIp7hJvSHZZsWp0auwrak6Y4Dcbkg4dqStgLbHP6qmgRGmz7s9khYC3QpaIvz2ixaNbo1pgOAEqoGs50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gSZiczFf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gSZiczFf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95B61C19421;
	Sat, 21 Mar 2026 18:42:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774118564;
	bh=o9U4kP9BoiNmczBWmGX/rTwZTTh7SYM3gh/9l0lKK5A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gSZiczFfo2UzIAgZVNnQe4g8BjvB2OFszj1FAwvm/4p1LxXPKpHCUZfuU7PCyX+w/
	 m9bWL4t0Z+He0AxFB/jtl/sBDzzY8ch9+mXaxofsT5Ae9DxHNf4baV67D4wr6vAnWx
	 nf83hxkA20+FiPXodrsOTUlFjYl7Ug35PVgEU5EnqWb8vYyCc9m6Vp6LhwjACeiNeR
	 sf/WiH5W3E7QY+RB+2nC5nEF1CHdL06iOHCEYjn03dcX1lmnGLgbPj/nS9krvdLoKB
	 iA6Fe/v62Jko+YJ2ZE7Gk3xiSQcI+JrjiJ4ymnc7JJjuFsO/7ZEJYiAr4Am/SAQUqi
	 E4InHFtCEaMag==
Date: Sat, 21 Mar 2026 08:42:43 -1000
Message-ID: <b15a066e61354d85033150addb07f33c@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Ke Zhao <ke.zhao.kernel@gmail.com>,
 David Vernet <void@manifault.com>,
 Andrea Righi <arighi@nvidia.com>,
 Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
 linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org,
 Cheng-Yang Chou <yphbchou0911@gmail.com>,
 Emil Tsalapatis <emil@etsalapatis.com>
Subject: Re: [PATCH v3] tools/sched_ext: Update stale scx_ops_error()
 comment in fcg_cgroup_move()
In-Reply-To: <20260318085349.78063-1-ke.zhao.kernel@gmail.com>
References: <20260318085349.78063-1-ke.zhao.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Hello,

Applied to sched_ext/for-7.1.

Thanks.

--
tejun
