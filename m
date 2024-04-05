Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EC28E541
	for <bpf@vger.kernel.org>; Fri,  5 Apr 2024 00:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712278321; cv=none; b=L0H01HeVDmP4oLkBHgn5/nUbv7W5pgEQR2dJLVzseUe1VHghrPve79/ygvdPX6WDdp7blNP6+GW7sD1YDf204lCeub+PwFywHAiGQ8G+Yi8A9KT7DhuGFvUIqfKME54Cvsl65aXQVhIXBaKOGKGg2Rtrv6y7WWnPLTDSPSH+JH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712278321; c=relaxed/simple;
	bh=y3XnB1JwQEzvB2Lm6HoBIymVkHSIrOjODjrkeVQMoNk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AUJsfIHgMdzN10rteCBVamw0PEaCvhLSXgrawFmZI/VyWIM4xDherL0DQoMLGPGwxI843RIONj6q3oE9ax42fUfQbJo93GK1VyvsenQmZHTDIDwbO6Y1mZXvW/pWuRA7TlNG8Ie1oqniE7oMOsCWiWWvaW2Z5TBl5tpOW+uUrVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rp+Iux4G; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rp+Iux4G"
Message-ID: <f7fd3183-e305-44da-a39d-6cef4495e207@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1712278317;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y3XnB1JwQEzvB2Lm6HoBIymVkHSIrOjODjrkeVQMoNk=;
	b=rp+Iux4G02xROXsj/I2AaOVzz7t0CggDEdAvG20qoCE6tEbWFjwhLG+i1LpIptJ2X97hgO
	cn38GyHD+wQtSQPzRmbP5NPcY0I3eMUwzcYh7T/Z6oZ/usELL/nSjRIhhwgSUcO2IZj6zZ
	blbwceOKaLIQ9EEsFQ+VOUG9p1kbIhQ=
Date: Thu, 4 Apr 2024 17:51:49 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 bpf-next 2/2] selftests/bpf: add fp-leaking precise
 subprog result tests
Content-Language: en-GB
To: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, ast@kernel.org,
 daniel@iogearbox.net, martin.lau@kernel.org
Cc: kernel-team@meta.com,
 syzbot+148110ee7cf72f39f33e@syzkaller.appspotmail.com
References: <20240404214536.3551295-1-andrii@kernel.org>
 <20240404214536.3551295-2-andrii@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20240404214536.3551295-2-andrii@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 4/4/24 2:45 PM, Andrii Nakryiko wrote:
> Add selftests validating that BPF verifier handles precision marking
> for SCALAR registers derived from r10 (fp) register correctly.
>
> Given `r0 = (s8)r10;` syntax is not supported by older Clang compilers,
> use the raw BPF instruction syntax to maximize compatibility.
>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

Acked-by: Yonghong Song <yonghong.song@linux.dev>

