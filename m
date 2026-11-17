Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794948795;
	b=X1s4u7GPFlCLZCA0ewtRqg/7XtzSVQB5+0Scu3y2PhT++m59tYCIa/RBuvcelGsBWNAE
	 RvRvaXvLOQz1yTmKFHjVPTYYtgziFyoSaNcgSgPDK7wJPjCxFuPrYoDjSLhmsfIg14x+u
	 7n/k06dglXTR+mkbHrwA3GWJbmycOYPb4RBc4JnS3xXxTfM8hcTKkVYqHS4ObG74pNf5u
	 x1oGv73fnrC1uGBToJ9QqIFnV24+hYv56Hlk5sRo441cUIVjenrzAWBDyJtGRYPQmw/qM
	 B5ja06RaZNyqTjqKsqobGHDEj0qIniAZi6/vOl9GT8xeuWhMiOlvG5ZgutHfAToFYqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794948795;
	h=Received:DKIM-Signature:Date:Message-ID:From:To:Cc:Subject:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=WwkRnlzqwRmjwZJRu50HJCPKBZWwdh8g6TZ+JAOUqQA=;
	b=W+H0kvDR7DgBi41X7D3RMwdSaz8Gx2iyxT/URaXxciqA2aimh35Od+mkiCyXxBkXFQv0
	 PjK3bCEjmYFqmEROIfbxNYtPMvYzXoAeSw8nKYYHDm/3KbPJDImVnmkcWGAXR5R3v9XPa
	 5VZVBx4CqpKOAGg+1ZdNflHse9PrF+j+orp3r/dPTkVdSRCkj4puNsM6T7ckTKZc8vJSB
	 Az6u8SPRmDloQXp0e4A0fajvAo0Ey0TP5oBhYovhWAMpYUMAAee0GkITtEEKSetlKEwwD
	 03GE45SL4ETeVlaNvaJ7pr4Iigna6oDRXZ41uqKRrsh+ZlQIXQPS0mLQr4E/dVzXivw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V5Pza6T8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB737606A31C;
	Tue, 17 Nov 2026 20:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V5Pza6T8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DCCC1F000C4;
	Tue, 17 Nov 2026 20:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794948795;
	bh=WwkRnlzqwRmjwZJRu50HJCPKBZWwdh8g6TZ+JAOUqQA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=V5Pza6T83EYc3041/5lBrqm/56F6npbZmZf0C63l1HymCE2s49SynTw5TeFUAzRmH
	 7hiBjFSYbvPSOe5vchKiB0O2eOQJYqGM3ZYOvDq20cutWmwdahddJScSpvsifLS6Mz
	 CG7FfpZGMfh+DSCcDTv6aaWauIv4/z2U6jixSSQlBfGEE+UOfRL3QojFNlIzSSXg2I
	 91O63UfalWajHFbmwEEhdCHD5qLeTNvQjF7LRuyyQ5POTr8RDrjTg0Teukk5SHvsy3
	 94sVlSD5SKrF/6s1cNz+nfN51HVTwPsHwx/blSUHh6VjaOQCVEalfTz3SBtTj3SQUu
	 iy9Daj8Fjw9IA==
Date: Tue, 17 Nov 2026 10:53:14 -1000
Message-ID: <0bb9c43843dd6eeebf21cccd9fabe3d8@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Alan Maguire <alan.maguire@oracle.com>, Emil Tsalapatis <emil@etsalapatis.com>, Jiri Olsa <jolsa@kernel.org>, Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, sched-ext@lists.linux.dev
Subject: Re: [PATCH bpf-next v1 0/4] libbpf: Support kernel-side kfunc flavors
In-Reply-To: <20261117192153.3384031-1-ihor.solodrai@linux.dev>
References: <20261117192153.3384031-1-ihor.solodrai@linux.dev>
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

Hello, Ihor.

Thanks for working on this. This would make compat support a lot easier
and more robust for sched_ext.

Thanks.

--
tejun
