Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795707241;
	b=MXaqQMd0rwWeujIBT1AoheDwYNmqAk0qj5fSwa9vZdKZ29l6hvdaRweNHcN69jfQE8VS
	 FN/Z217bMvRyYy+BHtoA3U4/4/I7wzZUQxL5t2MO1yBT/nC2pDNvelt7tk9tJWjgimYtU
	 hsmtHbuDOMEdyIi3oe7SRnQuVRM7MpzwViYGlzWGf6sWEcQj2TQ6ySZCrF5GIt3jE888Y
	 v/ihZ1i27ssAU84MH6kuwFQZ8j27uPNk/hMm6xtTHr42uGsJPjyz1rqLM1XLArf91Pgc/
	 H6W5wt76XVXPC9mzH4MzMDQChcbzQ225S57S5Qs96UInd//QeJi+Rxky1ELIV2axAxA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795707241;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=u0Ytbl+IDSkalVlee+5jscw80Egfp1AfgDfazx2Nkgs=;
	b=HUNoO7dFjPFRSbUPrUbMYqPmgK1TxfafWzKTNK+cIXjsIZ/DhTyOv+LcIVS9mPwHzlyP
	 Akup3CQkBuZj244WO6zioRhQBMN6exmGVkABvtiYTohqQ00VbTFbdjEfioQtOq7B75wZc
	 eIUA9EwwmY0sIsJZ2uGoYAz1wc7LNpgRlMoB3jpSxOc9KgGq1LwNvmT/79EhkMbXtmIpg
	 st5WkUUVm2BcnJbCPo600tQviaId7+qpuXL17PoZG407nnCdx1RMK/DFGpoDHHob9HWVi
	 Qj/ADoOXsA8YBhtL/MFPRFjmrlKAPq/IVrBsw7MVFzRvsjnEblRLeAiLBJLX9AEWOiQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nCowHwB8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30204606A31C;
	Thu, 26 Nov 2026 15:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nCowHwB8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 343191F000D4;
	Thu, 26 Nov 2026 15:33:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795707240;
	bh=u0Ytbl+IDSkalVlee+5jscw80Egfp1AfgDfazx2Nkgs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=nCowHwB8Kcpu0K3Uru5apaPwI9Lvx4lE19Nx3meP1Bh8Er9MvgCMR1G/XbsHW8Dcc
	 ohXC56tiu7Jy2K5474cDLmMREMbZOXF5lnOiO0JoV8TiR9c2cWuP/TYDUa58BSIeTK
	 JbTX4vZ/R1FnDCkfhl9phV+7UQb8sNWs5+xYvNwB2RrVgwHDE/jTIJhGuMO1kMofnN
	 ZmIlySOOM0evF90tWsOs+PLpyC7Oz0HFOB+ORLh3dRMZQJZpV5NtEI81GZQ+S2aHTZ
	 uR/FuGPzxB1v/UIjfioHu/OLUjCxyC+L4JEG1IKhf/2d36EWktFPLEKMnyKRAa17tj
	 XKfPPj3vbvUCA==
Message-ID: <628b56f3-3b6f-46c6-b9ae-e96ceadd1206@kernel.org>
Date: Thu, 26 Nov 2026 15:33:57 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf 3/3] selftests/bpf: Test non-autoload rejection in
 light skeletons
To: =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Shuah Khan <shuah@kernel.org>,
 Leon Hwang <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Emil Tsalapatis <emil@etsalapatis.com>,
 Ihor Solodrai <ihor.solodrai@linux.dev>, Sid Nayyar <sidnayyar@google.com>
References: <20261125004911.3937193-1-tweek@google.com>
 <20261125004911.3937193-4-tweek@google.com>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <20261125004911.3937193-4-tweek@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

2026-11-25 11:49 UTC+1100 ~ Thiébaud Weksteen <tweek@google.com>
> Add a test (bpftool_gen/lskel_non_autoload) that invokes
> 'bpftool gen skeleton -L' on an object containing non-autoload
> programs (test_global_percpu_data_failure.bpf.o) and verifies that
> generation fails with the expected error message.
> 
> Signed-off-by: Thiébaud Weksteen <tweek@google.com>

Acked-by: Quentin Monnet <qmo@kernel.org>
