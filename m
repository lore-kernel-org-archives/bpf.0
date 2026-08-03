Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 161662E717B
	for <bpf@vger.kernel.org>; Mon,  3 Aug 2026 02:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785725057; cv=none; b=N99VKupuFq6x1uwTQgSz3tUvVejKpxZnlDC2v1f9kOuanxhIO9AUxGVSiqZ1nS1/qUZgOMHoG9IvMaq5h+UfZNYlT+fOL6/iLirvcY4zPsXEyeUNYEjRAQgP3HEAxQhzJFJZ+0cMHdykyBv4yWgnN6xg/I6E8WQbZLoUUt/LmS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785725057; c=relaxed/simple;
	bh=K5s9lTAQPLH/FEQye48lkO8oviReYqMjahuDwGe1BD8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WPp8Jp8Hue+l0vNkHWoKinEYILTVgWTaErRfCMgkNAXtNyzxNeAvPYp+OEEf8YmOia2ueRE2GnoTZSJVS4I6GZCVu0Q07rOco/vYnTDCh6S+XBnCUFCva6aQDcczk/c21j8d83QPbOHKhFB2G0xdCqc35U1H/g6belLk8T9N4pA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=o/5jzC0A; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="o/5jzC0A"
Message-ID: <a68933c3-39d6-414e-b869-bb3fd1a6b4ba@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785725052;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IaMVPcpYZB9rfzDTPJpCcq6FfrbIBXVXDRiLOonr2y4=;
	b=o/5jzC0A+DN9k4z4e8lt4e557gg1qfJvrH/ssib85T1UJ9IghuOeHSnBKFV40eYczdoe9o
	b91BQhtfrCcS9x2msiG9q0Ym9LIK50Z2kJ3G3bSidiLKnoCXUDxcTFNrF7AjPBBg55zQ9X
	TiBilDU0qG/u0GGN0AlCf77pWYO2ixg=
Date: Mon, 3 Aug 2026 10:44:04 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next] bpf: add BPF_F_SEALED flag to seal BPF links at
 creation
To: David Windsor <dwindsor@gmail.com>, bpf@vger.kernel.org,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Emil Tsalapatis <emil@etsalapatis.com>,
 Ihor Solodrai <ihor.solodrai@linux.dev>
References: <20260803021643.2189641-1-dwindsor@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <20260803021643.2189641-1-dwindsor@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 3/8/26 10:16, David Windsor wrote:
> Introduce a new BPF_F_SEALED flag for BPF_LINK_CREATE that creates the
> link permanently sealed. A sealed link can never have its program
> replaced via BPF_LINK_UPDATE, can never be detached via BPF_LINK_DETACH,
> and holds an extra self-reference that is never released, so the link and
> its program attachment persist until the machine reboots, even after user
> space closes every fd referring to it. There is no way to unseal a link.
> 
> The sealed state is tracked by a new bool field on struct bpf_link.


Why do you want BPF_F_SEALED? What's your case for it?

I think 'sealed' should be set before allocating the FD to avoid the
race issues reported by Sashiko.

Thanks,
Leon

> [...]
