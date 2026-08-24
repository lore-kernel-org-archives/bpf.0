Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95E39376BD7;
	Mon, 24 Aug 2026 17:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787592504; cv=none; b=L9P5zwcUJDQnPXSdgTPCsytHR9Liaw9q/2r5j7Sxu3C1qAxNGHjUwbBmH8v7drWiAc8Qdy9jZSc7MVU9j1hBK1Qar0QQ9V3hvJ36p9/+e29LIOecMexj0yiHr0QnUibSGBwuOPuLjzcQ20FV7/hKEFwa/GIgDwCMOR+9C6IRntA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787592504; c=relaxed/simple;
	bh=6Y7vYf/xc/TsRZfeinhAcNhu9VUF65Y4YoGWlsYueBI=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=KF5WM5PfnizivbSI8n0PEjU1pQau1+Kf/6E19/phVMaSeeolzg/De84jwKXneXMJunK6CN0Bw9UxLhleGklVRVBlAq7UTRk4WfLZXaIovGiefZ1XIoIXeb0WsioP8uPdLSzZeY8kwTWU9NmIjwP1eUBqnIt2UbYS1+gqX2CFwkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iwb3W9YZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iwb3W9YZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0106B1F000E9;
	Mon, 24 Aug 2026 17:28:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787592503;
	bh=6Y7vYf/xc/TsRZfeinhAcNhu9VUF65Y4YoGWlsYueBI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=iwb3W9YZ8OEHKAnC99xKdT/4bviC5eyf0UDVDj5+kworw9kOnw6XlcNZHfQpqozqT
	 oBNEG3lsjX3060HH8TbPYN9PrkXdqix7K4CnsZ9fG2Uy30kydKuvqIaGqTsXenq5IC
	 D15ktNkAk837MvfgZQHCDcJ0MyYzUc8orAEgjry/Slmx9T9g/nhMd4Z86dTMISkEwk
	 0Pnmj8n5IFyshlfRbQ3InqBnHz8KABZF2hzpofKb6XS4btLxafHiyKVXGcfCfBxIn2
	 8WnjYysRPU+FICBpmzZ0Qh3pcFTUYJNlYOVJyJPWII5blrfUonwu4wNVpS2DOlZUOc
	 +jKip4rAI0WnQ==
Date: Mon, 24 Aug 2026 07:28:22 -1000
Message-ID: <47c0ea280ab24d0ca940a8fe70cb9a56@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Tao Cui <cui.tao@linux.dev>
Cc: Andrea Righi <arighi@nvidia.com>, David Vernet <void@manifault.com>,
 Changwoo Min <changwoo@igalia.com>, suzhidao@xiaomi.com,
 sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, Tao Cui <cuitao@kylinos.cn>
Subject: Re: [PATCH v4] docs/sched_ext: document that cgroup CPU knobs are
 scheduler-dependent
In-Reply-To: <20260824132116.560347-1-cui.tao@linux.dev>
References: <20260824132116.560347-1-cui.tao@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Applied to sched_ext/for-7.3-fixes.

Thanks.

--
tejun
