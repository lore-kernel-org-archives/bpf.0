Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D78D633B955
	for <bpf@vger.kernel.org>; Wed, 21 Jan 2026 05:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768971869; cv=none; b=vD6/bXV8Q19Vozwfusd3qauGt/3e39kFRwlyWS4pZrxG71+CcXbryhCgvNX/NfJNQvhxXD14RDFNQzduWMTMJokM95t0N10EygeLnpo9Vnpywe0QCx5WMypO9op2rgMXGaQyK6utyE/ljxGPsWiX+c9pZpgb28IbhSIxf6ZQg0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768971869; c=relaxed/simple;
	bh=v1W9PXHHW8JmGQRKPIGWJNieXs78Z0SYug1ixi5BbXE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g0963C5RJ3j2mC31t8PBEd7mFEcd5036EA0BP/RlumNfplipw1g8XPW9xhY5bjGcpR1lPEqRgACacp5l8pZmiYaeGQb8Fc06A2u9eY9K/3pna8QjbQv5Wcbtuv5rtSxi8wQfinE07/ajOqXJnsVtV3n4mlu7O4Ux4/Mh3pIIK/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Ba/Bx5O7; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Ba/Bx5O7"
Message-ID: <c8eb9347-b23c-4ad5-9555-b2a55b788dce@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768971856;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mRB8tvxmnI4O2dINRIDuf5YHKQB2kGq3bqQ9+3NoM6I=;
	b=Ba/Bx5O73wTY0f+vg7jmRB9iXS0gzYLA0w6uA4ZpAFqgCcW8jdL3mB2Wnclfg0eZHToEcx
	8U6Ejr6gDNhRi38Ipbyk4qbzHtlNTNXYLrmGA5JYsA8aregObZyVMk8moagJedOnFhamlQ
	vxQtikjzRCa9ya7ndjhXG/3LfooWXS8=
Date: Tue, 20 Jan 2026 21:04:08 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] scripts/gen-btf.sh: fix shebang for NixOS
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?=
 <linux@weissschuh.net>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, bpf <bpf@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>
References: <20260120182034.3647092-1-gary@kernel.org>
 <b53ee085-d9d2-4365-a5bc-d61e2bce97f8@linux.dev>
 <DFTNNQLGB1CS.2HDOGB99S9ACP@garyguo.net>
 <ea83b91a-796c-4329-bcf5-2c49efa897fc@t-8ch.de>
 <5364d5ec-f30c-40d6-9a99-c251fec3868c@linux.dev>
 <DFTTLB4I89PR.26SQVXWNG9U7@garyguo.net>
 <1897b382-41b7-4d63-815d-ac63f38485ee@linux.dev>
 <CAADnVQKLtnfbaJCbbe=JY+85kBKfiUv9hjW+bumO_Y_YovuFow@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <CAADnVQKLtnfbaJCbbe=JY+85kBKfiUv9hjW+bumO_Y_YovuFow@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 1/20/26 8:52 PM, Alexei Starovoitov wrote:
> On Tue, Jan 20, 2026 at 8:50 PM Ihor Solodrai <ihor.solodrai@linux.dev> wrote:
>>
>>
>>
>> On 1/20/26 3:54 PM, Gary Guo wrote:
>>>> [...]
>>>>
>>>> So it's trivial to put $(CONFIG_SHELL) in front of it. But then it
>>>> must be migrated to #!/bin/sh, right?
>>>
>>> Documentation/kbuild/makefiles.rst says:
>>>
>>> Make rules may invoke scripts to build the kernel. The rules shall
>>> always provide the appropriate interpreter to execute the script. They
>>> shall not rely on the execute bits being set, and shall not invoke the
>>> script directly. For the convenience of manual script invocation, such
>>> as invoking ./scripts/checkpatch.pl, it is recommended to set execute
>>> bits on the scripts nonetheless.
>>>
>>> Kbuild provides variables $(CONFIG_SHELL), $(AWK), $(PERL),
>>> and $(PYTHON3) to refer to interpreters for the respective
>>> scripts.
>>>
>>> So I suppose it would need to migate to POSIX shell...
>>
>> That's my blunder then.
>>
>> I'll send a patch tomorrow to make gen-btf.sh runnable with /bin/sh
> 
> Isn't the current patch enough?
> -#!/bin/bash
> +#!/usr/bin/env bash
> 
> I don't think all kernel build scripts are pure 'sh'.

Well, if we want to follow the makefiles.rst (and Thomas')
recommendation, which is executing the script via $(CONFIG_SHELL),
then we have to migrate to #!/bin/sh, because that's the default.

This concerns only scripts in the kernel build pipeline AFAIU.

But you may be right that this is not a strict rule, idk.
It did come up quite late on the list.

