Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DBC7267B89
	for <bpf@vger.kernel.org>; Sun, 21 Jun 2026 15:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782055296; cv=none; b=rd2KIGFWxT3I1U5pornxacGbwg6KiDvHjN8Ckq8IftpMQ9sVNcZcYS4TlzhSTzzL9FUru2C4IKmaonbObAhBSSTXC/8lo4wA1IID7jfAuxanIqEfTlLZEZv35EeOlau1i9HWnNVRHzL1x4SsqfYGmUUMYwFds9btBk6UQukuxmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782055296; c=relaxed/simple;
	bh=mUfHQsiWMHhccHi25NVjyUAhn41PnQ/PnHyC4+6MmbA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M3UDy6YZsMLgwD/qxIld6shiu39tG2Z1I49JmTdqjtAkSBlL8NQZp7Dw29yO8WG4LgaD4+t+Tm7oRKqTu1damp51SVtYtq64jpH2yYoax842v6ZZU61CY3QIlLmpx/5AWOcG8HnIswhhF1SIKXyK1xCG7wMQoTx/aa13YygTehI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ND+0AHkK; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ND+0AHkK"
Message-ID: <f0f66c49-fccd-4488-91eb-c173ceb818b2@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782055291;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mUfHQsiWMHhccHi25NVjyUAhn41PnQ/PnHyC4+6MmbA=;
	b=ND+0AHkKb7fHwODrsPux8xMeIPBmvIxcaXMEmuGs1mPwpswH/0VDZlTDDReTXqvc31/r3c
	E6S3TvBKh8H0HDjzfm/XrgGMPPaRkl9RUY9HDCJ+iajFxoEDzVsv1w651qVb3h7Ep7cTsr
	yQ27CFRNrx//DIBp+6Bp/+ICE0Kx8Jo=
Date: Sun, 21 Jun 2026 08:21:13 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 2/2] selftests/bpf: Add cross-subprog gotox
 target coverage
Content-Language: en-GB
To: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>,
 Anton Protopopov <a.s.protopopov@gmail.com>, Shuah Khan <shuah@kernel.org>,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260613-f01-02-gotox-bpf-next-v2-send-v2-0-ff980bc5a329@mails.tsinghua.edu.cn>
 <20260613-f01-02-gotox-bpf-next-v2-send-v2-2-ff980bc5a329@mails.tsinghua.edu.cn>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20260613-f01-02-gotox-bpf-next-v2-send-v2-2-ff980bc5a329@mails.tsinghua.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 6/13/26 2:33 AM, Nuoqi Gui wrote:
> Add a gotox regression test with two one-entry INSN_ARRAY maps. CFG can
> model a map whose target stays in the main subprog, while the verified path
> can load a different map whose target is the first instruction of another
> subprog.
>
> That second target is outside the subprog that contains this gotox
> instruction, so program load must be rejected with -EINVAL.
>
> Signed-off-by: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>

Acked-by: Yonghong Song <yonghong.song@linux.dev>

