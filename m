Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792795641;
	b=VwIYAj0JYdyBH6IbOfFEN16Ro0S49oNilTPGfq/KbSVW+DWgim5rRFJB1pn7O1AM5cId
	 K1T3KlZmTuCUj6OvaA3A+2hfPnEh6XJfnXIcQRgknWn2BokAafGeABLQExSzhK6wy1W8f
	 5DyLvlmJ0LIcqtfvfzOxxY/3F/3qu3NeujvMKn4z/YHZs8Xjlhg/UOFJjoKChT5vKWNEG
	 Gope7mIh9Ubdnukdg1gclYKfpCAVgH2hCP57/eXIgZXC3ABtfHpRaQ3cBSSsPuKOAaNTj
	 enXbqNdK15q17iwC0/VRI+OiKG1dHdeKosXRCiY0Iwa6SKDfvgGIAodKgwFC9Qi2/Gg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792795641;
	h=Received:DKIM-Signature:Date:Message-ID:From:To:Cc:Subject:
	 In-Reply-To:References;
	bh=NYqDm/1QvLb9/cOBOgwdPYESEm3xrv+yvgkisJotDv4=;
	b=4PlmQ5Ae/hPUw+oZacxuDVhU0+NIdaoTKPQZI5HUXcJ88nkUQ+lN/vvcL1YMdhIBwkVv
	 bhKNX/BxOGYd5v6nd9XJJl+aFb9NBseR1nAHGP/RxOWIj3ANJ6bMrUwKOxMIFe2HPUh4t
	 ZdSiDDY3NKmzjBU2MD71Z2zlZ5M7uyvyU0prXu28amWySAK3fZUg77UlltB8FCuLAX7M6
	 jMjCpE3ues7hsfIbfuXFhaQJVn67uAbwCEsQlrnH5mlhtqJ1CIFvyveqvqvqwQtUBc0ed
	 UpoVayl4tepDAZEY3s0irNv11D06f1bqqx+BRBhkjWL8ytMvBn8emaVAgc1WwtSzxbg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FPXcpDeL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38A3B606A31A;
	Fri, 23 Oct 2026 22:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FPXcpDeL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 994111F01825;
	Fri, 23 Oct 2026 22:47:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792795640;
	bh=NYqDm/1QvLb9/cOBOgwdPYESEm3xrv+yvgkisJotDv4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=FPXcpDeLDDUrNjD122pYRGp9vXVSRY9A3Vj2VTwesPT4PstebgEpsheDmXw2k4Z+R
	 9G1Zmrw51U4tOvPe1zd9V5WOhPXlD21dWUUxtHn+pPKlwoNyAXUQkr2QseEYReunXV
	 KwL5DZy5bHETzAAmpM/ATU5pojkhoMcx2YVJt4oe/b4nVf3gM7vHpPh+pfC1LWGyTT
	 8tozX1vMyuO6cNNIKCUcM+GP7fdXRE40GAC6F1+YMgmni6/3KD61v4pMy80bBYqoEY
	 Xpc+7bYY69s17OszXi3RPaJUogLO63TYUp1kPaeJa0PRkYsx2cZZVSTR/GybijZYQe
	 2ELfAvmxrnsgA==
Date: Fri, 23 Oct 2026 12:47:19 -1000
Message-ID: <a5551d69c989776eeb576456f0056fb9@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Qiliang Yuan <odys.yuan@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>, Shuah Khan <shuah@kernel.org>,
	Amery Hung <ameryhung@gmail.com>, bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev
Subject: Re: [PATCH bpf-next v6 0/4] bpf: Fix a struct_ops use-after-free behind a flaky assoc_in_timer test
In-Reply-To: <20261022-selftests-bpf-struct-ops-assoc-timer-v6-0-2c0f18e82582@gmail.com>
References: <20261022-selftests-bpf-struct-ops-assoc-timer-v6-0-2c0f18e82582@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Hello,

The following is a Claude-generated review.

On Thu, Oct 22, 2026 at 04:48:35PM +0800, Qiliang Yuan wrote:
> grace period of bpf_map_put(), so nothing waits for a prog that reads
> the association in between.

sched_ext hits the same use-after-free. Its kfuncs find the scheduler
through bpf_prog_get_assoc_struct_ops() in scx_prog_sched(), from bpf_timer
callbacks too, such as central_timerfn() in scx_central. The series fixes
that as well.

5db69b0fbdc8 ("bpf: Make struct_ops tasks_rcu grace period optional") is in
the bpf-next-7.4 pull, so the bug lands in 7.4-rc1. Can the fix go through
bpf for 7.4-rc?

Thanks.

--
tejun
