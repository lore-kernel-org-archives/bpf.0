Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795282016;
	b=PnXDXm7VA9EKS9Z/HsPGMVjPNYmd7MApSFFYauyC+NpJ8EyuPyut4cA0P8vqn+wnIxZF
	 fDhd+/JD5CQTH8B4e4BDGj/jSP4DOyUsaWdTvitUn5sXkzPJStTLAw+rS1FPnp3uF81TG
	 0cMbhnMbma1lYUA29CjJdSIKiXkIeEEDxH1WnyCj8CPTdW44X9racO6PQe3SmjBUw7Bao
	 WaVWZiu/e+5Npv4JGUTKYoGxAZ/ywjPlD3PsZ0ESMY6rM9TM7JSnWVReEzD2Dz4XYYMLS
	 ucezPe8taBR7Ic+sC+YzBh47WA512TqotagBTcxTd/e1AB3cI9M3x1BRhmglt/c7I3A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795282016;
	h=Received:DKIM-Signature:Date:Message-ID:From:To:Cc:Subject:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=Q14+I1yQ7Sma4xwQJB7gAXB4B95i0YaZvVDOXAWUofE=;
	b=MrZ/wwtXIoERsPfRpATlQrG07+DPta7dBB4ffzG5jAdNGVUUhxOmOWHnCgvBf79gYgIL
	 ftLRBnXP9Fd4AYH+xNV80yyZ7RTHoEE2g7xpJOhqJ536zuQ9xA51wagFx2hP/4tcUMlTh
	 pDva+YGkY3qePw371MMAQqA4C5S0Esh8LxcZPQgBoNU5jeisbG2LHJV7t/MGJEN4z61bZ
	 q5JDyL5/c8G3fvGR7/3eTXUWJmA2JUT3UUyRAu3KZ7askPBUeuDM/antcZKKt+y90wTxH
	 DHUSt9Zwy/WxQzxS4QUoDzon+phuN1pn7elbtj4FbM1QudHO7TpuNCH9waiEjNPw/Rw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I4fboAHL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6488606A32A;
	Sat, 21 Nov 2026 17:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I4fboAHL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EB161F000C0;
	Sat, 21 Nov 2026 17:26:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795282016;
	bh=Q14+I1yQ7Sma4xwQJB7gAXB4B95i0YaZvVDOXAWUofE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=I4fboAHLl+kB7zfgLjn4Zq95yIEpDi9IZzT1WmuAjwK8TqTK1biFiL4buNzzAYDLf
	 JvXBRdSkZRqFPZPVBMbx2WGiUg6TE/dzVJPtUA32zKFW7/AR4TYg9PDbM/UhrPDxPH
	 +cJZ3hHfFDo2Z71qA0oI0J2oddl5XtFQ6XrTJIwxxYTAMrjtBuGiZp1xQHzvULnPiL
	 /ab98Mn1O5Rdj9GGyUr6QQOVQW/mqNokaBmlF6ojie+U00GM2BtPVxiShsUbDW75E4
	 Tl6KqxC8853XQfse3MaVFUoGvYvvNrLpe5sIG7eWrqtIM7qF0A9nT+M0FhAobIrjVK
	 o/zhMpIKigNpw==
Date: Sat, 21 Nov 2026 07:26:55 -1000
Message-ID: <3c8a9bd9ea1d3faf7a072eaf4666125c@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Tao Cui <cui.tao@linux.dev>
Cc: void@manifault.com, arighi@nvidia.com, changwoo@igalia.com, mingo@redhat.com, peterz@infradead.org, sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, Tao Cui <cuitao@kylinos.cn>
Subject: Re: [PATCH 1/2] sched/core: Pass ENQUEUE_RQ_SELECTED on initial enqueue
In-Reply-To: <20261112144935.583937-2-cui.tao@linux.dev>
References: <20261112144935.583937-1-cui.tao@linux.dev> <20261112144935.583937-2-cui.tao@linux.dev>
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

Applied to sched_ext/for-7.4-fixes with a stable tag (v6.12+) added.

Thanks.

--
tejun
