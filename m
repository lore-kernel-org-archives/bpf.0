Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87A6D31F9A4
	for <bpf@vger.kernel.org>; Thu, 28 May 2026 05:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779947010; cv=none; b=Tb4eJNaMrIFoZRgCESHFcgSnz2X6JvjzhZQYfzTGerE3DyHQODOGxrs6aOUMHCh91/vEBMmKa9WxWN+cRhQ4ZsafdCVE8YUfuibT+yzVQGf1h8x5FUy++6HzKkBi4ed1ozAkspXqSIz8KGnywrtsWD+0NoL1BsDjQl5pS9qer+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779947010; c=relaxed/simple;
	bh=3+2kHB7xatzySevM7gTiAUUaPJ1VXmBosZw9dubFN1k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Efj7ciqBUVLn9m0BlOLWKFrbUEb+SR+cPXx1n1zgfJOFZkagKrOO19YltaRagXWnNmJikhUSTiZxqInPEY1C04pZtPDBKKm+Xc5ZV0nhHnkQfUvYieh9zX06q43q4wyd33nl1dy/+2WWlOXvACf8qD4mzhBrch8HKo2SsSMvHH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=E83/Uq6x; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="E83/Uq6x"
Message-ID: <34b18a3e-50c0-4b0c-8ee6-d7a291619231@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779946997;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z9MM3Y2Qx7TZns2bRxhLBJKfpUN8+EXhIH0wXQGN7SM=;
	b=E83/Uq6xFRMZLXHh68vtrKfbFf7EdTNwTqtKOO8LknYlzMhk+IVIUiXNqPnCNAb6Fx5tTD
	Da1NgMC3YaBJM/KbHh/6/ah/HSUiM9fWKolnirRifbPdr0f+2H9hr46Gs/W1e5e7IA5LJ5
	JY2Uuytq31I9ajPzQOEvkDszj08JcBo=
Date: Thu, 28 May 2026 13:42:58 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 1/2] bpf: align syscall writeback behavior with
 caller-declared size
Content-Language: en-US
To: Yuyang Huang <yuyanghuang@google.com>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>, bot+bpf-ci@kernel.org,
 Alexei Starovoitov <ast@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard <eddyz87@gmail.com>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Jiri Olsa <jolsa@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>,
 Nikolay Aleksandrov <razor@blackwall.org>, Paolo Abeni <pabeni@redhat.com>,
 Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>,
 Song Liu <song@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
 Yonghong Song <yonghong.song@linux.dev>, bpf <bpf@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>,
 "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
 Network Development <netdev@vger.kernel.org>,
 =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>,
 Lorenzo Colitti <lorenzo@google.com>,
 Martin KaFai Lau <martin.lau@kernel.org>, Chris Mason <clm@meta.com>,
 Ihor Solodrai <ihor.solodrai@linux.dev>
References: <20260515071504.2054786-2-yuyanghuang@google.com>
 <2e08eb1ca27a9a2f8ad29e1c24f779b579621b0a648589f7044799d91c5e00f5@mail.kernel.org>
 <CADXeF1GVtFHNZJb8xwFh6aadR=H19S+kja8rF185XB5=fg0D0Q@mail.gmail.com>
 <CAADnVQ+42+Th6OFGq2KawzvyKUAykazb4fXh2_uqss-T+R8VCg@mail.gmail.com>
 <CADXeF1F=7RcxAsW38w_mpFeKCLxTAh5p_XYHd=x2Ru+oajoN3Q@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <CADXeF1F=7RcxAsW38w_mpFeKCLxTAh5p_XYHd=x2Ru+oajoN3Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 25/5/26 15:21, Yuyang Huang wrote:
[...]
> 
> Feel free to let us know your thoughts.
> 
I believe this is a user space issue instead of a kernel bug.

I tried to use mmap() memory as uattr that got -EFAULT instead of crash.

[................] /* mmap() memory */
             ^ tail 40B as uattr
                    ^ 56B offset for copy_to_user()

Thanks,
Leon

