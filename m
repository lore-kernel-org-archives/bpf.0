Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AAF945DF77;
	Tue, 15 Sep 2026 07:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789456715; cv=none; b=INTSsFE+k9AKQPoulo3LqaDMjsfSruZMzzNKQ/XLfko0D90oiVq4oWQZFQ+No4ZucjAOsXLU0RPdApFGzhGvNvnrlJirp5acv9EdZUt7MclVY32osB4shEkZtIVssb7PfdnSlmOLj+7Vf/cZIZ08c6QSslmRgRlt7kUMM2pX4H0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789456715; c=relaxed/simple;
	bh=8JU3wQ5UAveR6AgU9oKwo08O2SofNaKGpS3k9ni4dkE=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=JSpfBpB7mYSzVG/liohujPv4ne+WOLG1qZKS7VHhKzXtqLT6gF0NCZSmu06DLmXFh1DCSpe9h7JUMnw76d6y3rltq+XKch8rvI2BHfvbR/tNKsO39WUVmcNUulvyylLX8Qk14znzE6HVnIweZqBEGwSkbi3woSNR0rk9Do8M5zE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H2SPgSvP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H2SPgSvP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65C611F000FF;
	Tue, 15 Sep 2026 07:18:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789456713;
	bh=8JU3wQ5UAveR6AgU9oKwo08O2SofNaKGpS3k9ni4dkE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=H2SPgSvPohZVl2/J84QfGz69hW0xs7fb8WLua+1MwiZbKlg9qI281JesO8wHndjwx
	 BfQannnNC0BLG20vioLTpLyXCsxlqmkRMenWX+/ps+H3xWbHRFG9n18otdyjdi675/
	 nfYx8VWo8HIbTOF2GVB04/sKkJzXKYvfxtP8sYbXb6SG8IHKBNG8fV5g5vt1RayFnW
	 sZTCuVlIrmwDmnduz5bSCxCwQO8wIt7rWlOuIkikoolMZhz931YdYkGFoGI1es5vou
	 P4Y7LfwBSF3XY7rB76Q0FglCFM8XUKvrn/y5xZxKzdSW9tGG4rxpn6hj7XIG3Ikxap
	 El2o1QTISiaRA==
Date: Mon, 14 Sep 2026 21:18:27 -1000
Message-ID: <15d99d51c32bed6f26b0d3f521e16b53@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Amery Hung <ameryhung@gmail.com>
Cc: Tejun Heo <tj@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Emil Tsalapatis <emil@etsalapatis.com>,
 Ihor Solodrai <ihor.solodrai@linux.dev>, bpf@vger.kernel.org,
 sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf] bpf: Keep generic __uninit kfunc arguments live
In-Reply-To:
 <CAMB2axMJ6NJUtDc4xhUbSaqUsRyNXfyWTNTR7SCYyRwiBdoLAg@mail.gmail.com>
References: <86d966ec88bbf27d21b2bb4e18c8aa00@kernel.org>
 <CAMB2axMJ6NJUtDc4xhUbSaqUsRyNXfyWTNTR7SCYyRwiBdoLAg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Hello, Amery.

On Mon, Sep 14, 2026 at 05:39:04PM -0700, Amery Hung wrote:
> A generic __uninit argument should behave like a helper output buffer:
> generate MEM_UNINIT | MEM_WRITE, validate it as write-only, and mark
> the written range initialized after the kfunc call.

Kumar suggested a similar solution and will drive the fix. Dropping this
patch.

Thanks.

--
tejun
