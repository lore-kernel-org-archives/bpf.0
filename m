Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793990912;
	b=qq28ZjHqAX+4pslrLHFh3AssEjj/sNbnq4jjlhP0GU6/qWN9WRuWlkF4CD8EzO1eIh73
	 s5AYzKR1TFwCGi2WtaYb3TeHEHe8zMxxQs+/nz0JoS1rg0cD6qaXbgKoYy/rukHZA5+qz
	 XcjnD+kgux/IMRqUvtIzpAtJB/KBH6YZcDQ11uQ9L00a+WRg7Gj0JZrGTrxP5p+F51i/1
	 OA49CTmCpuahl5FO/adAcSpRqT8uV97iY/1REaZCLO5xE3sSNf1mhlk51HZKjBpE2QFLY
	 K9p/PO35BZ/yqZHdwzxBE9O5ZPR13YNolDQVHARCLPGC1jLrbizxGUtzPi9/lc9eUPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793990912;
	h=Received:DKIM-Signature:Date:Message-ID:From:To:Cc:Subject:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=g8oRdUIPNrM19I+aRr6Xrjnpls3CINQLfjEu+H+Ojoc=;
	b=iXhEYRqYK/YEFnKv1HLADLJdWtpONsmJM3eFjtm6o8yTqJfE4jAw7P5s8qBgHu1MkDDJ
	 +rvk6jmsKaV4m83oYFfHYdyJ0ZFXTA5cOxK2g9OuQ2Na9ZBmYN3cMJLH0h15j/91YJx02
	 TI7w1DaQ/2Xg8wmdASjz/Osm/kSgLIOFYuAOKXDUb8tf+0C+BSDE0FKuQu7tMtqMNpz55
	 lt0DLIWOoe3YVq4tZdW4+ag8P9v7yKFF8sr6uImYRVufeb5Ow67CsCDp3sM9D3rKbctmZ
	 59uABZG+FteMOeBBKB1CaAcmcJhNolEF61RnYRzIkl/w7ATyqkhAdnpcva7m3AwOSzA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SyZb44dD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2B22606A33C;
	Fri,  6 Nov 2026 18:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SyZb44dD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37A071F0089F;
	Fri,  6 Nov 2026 18:48:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793990911;
	bh=g8oRdUIPNrM19I+aRr6Xrjnpls3CINQLfjEu+H+Ojoc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=SyZb44dD7utSkOsJS/IOXorgrZ4kMReKn9B1uMpwESxplMpOD52i3e+ONBMjxVl9V
	 L7qd9UFNr71Q68WWTjcE6e8PcBXUOXC0iKBIrbN0kKFrFaYW+WUHXmlJacNH/7NWG5
	 bAwaMsN2XG21jb/ul45N9FAh36CMCWAT6+01nEBM0rtCyDee3Jm72Z+wCzjU3S/RCF
	 FGgZw4jZSIxabncA4RSWhagv5G6fzj38dKVPhGJnARFaDK13Hium8YPZYirBIMvVGb
	 GvVGCpitDfczv3jDBSIn34wX6jQO44u7g3aG+xFN7ah6U3u9cLZnjeYVFw8UvK7G/2
	 iiwPIfVaVTmKw==
Date: Fri, 06 Nov 2026 08:48:30 -1000
Message-ID: <d71ce22da31bceab849e0ca8dc39fe2b@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Rahad Bhuiya <rahadbhuiya2021@gmail.com>
Cc: void@manifault.com, arighi@nvidia.com, changwoo@igalia.com,
 sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, sashiko-bot@kernel.org,
 sashiko-reviews@lists.linux.dev
Subject: Re: [PATCH v2] sched_ext: Reset task fields on exit of an SCX_TASK_READY task
In-Reply-To: <20261106180353.457-1-rahadbhuiya2021@gmail.com>
References: <20261106142818.1475-1-rahadbhuiya2021@gmail.com> <20261106180353.457-1-rahadbhuiya2021@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Applied to sched_ext/for-7.4-fixes.

Thanks.

--
tejun
