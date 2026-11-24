Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.229
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795560769;
	b=oRTU7+u+zMdWUuD2TyQv5Fb34DzKVtQnNFAPJNFx1+XHsASsqg0hJCzMxFm2D9X3a/bo
	 pg60qLjzXtYSupOc+XI3x99zvM6dV0dsfBD5BT8efst5EOKeVRgnQxa/uco4+BXi72h5H
	 /wstEwFYmoBREhHak/SnhjPj5ugessiungITva6qXMbMG+3qeZ9AEJdraoNPuRj6Tx/Ho
	 vmVngd7Spegjf6nMvkFkiZA2i4DB6Adoe2+oGoRoTJUEn27Mu2a8oKA9B/jGySvpK2dCk
	 WtwCa3ztxfgDdkv+TofpQyxJm01ZPBbCpT8z98GZwGNpic7IqHl7s+W65UTQfAgSflw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795560769;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=yQKyOvawwuO1atA3WB4zRh3RGdgT+yLKezQY+myigjY=;
	b=VFgNXZCo29XLHHOtM/bsvmTXzwiRJJoIaoyydyAbEUvPpRtOGUdH6Nece3u3EalXePUo
	 SsO7tQhnmnyuvsyuGBw3NfDzhq7uT9f4xZKNkLC6Y2Vgrt8jP4SN8j4W9wfB6mHX8ntbH
	 aD+AH/SH6pm2J+ph1z8fn41zMJmMc+EhU5a2FMoJ0ik3eI3gQ+vevf+HPPWeCDxrdDeAv
	 HVeRCOkeBQmgZChxw6gWR2EmRv7Z6zM92KXn3GNmkliBXqpss4jemnw4RWpZ4tr4vRiMX
	 /5sGnuznlrowqENET7oqyOP+bNForqtYJgH4DeRAVJTkgvDk1x4PyNoVa4d5kcxZ6Xg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=xBNIXxBk;
	arc=none smtp.remote-ip=91.218.175.229
Received: from mta0.migadu.com (out-229.mta0.migadu.com [91.218.175.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35D82606A31E
	for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 22:52:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 35D82606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=xBNIXxBk
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=7c2eK5ZRoYhnY7geiYrgE1DFXHDzKCbM54tHz+l+sEo=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795560767; v=1; x=1796165567;
 b=xBNIXxBk2CRHLR+Tp+h7cgJ9NofnLvGZsK2zRJb3ARl2dQR72hbn/La/SJFu0TnvSwZ5/W4n
 YzCcEYqNb3g8+RXTI6wF1rBrtBl/Q3rh1raWwGpoK4AkqKgdKYm28iuMQFiBzo+/sUMu3pQMmvA
 gv9F0NioGN3bRnZGcEoI7enw=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 2315a5e7c2c7fbb3;
	Tue, 24 Nov 2026 22:52:47 +0000
X-Mizu-Trace-ID: 2315a5e7c2c7fbb3
X-Migadu-Flow: FLOW_OUT
Message-ID: <a34def3c-0b04-4f28-823d-9c629285ecdf@linux.dev>
Date: Tue, 24 Nov 2026 15:52:42 -0700
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
Subject: Re: [PATCH bpf-next v2 1/6] libbpf: Separate interfaces shared with
 in-tree tools
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Quentin Monnet <qmo@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Alan Maguire <alan.maguire@oracle.com>,
 Emil Tsalapatis <emil@etsalapatis.com>, Jiri Olsa <jolsa@kernel.org>,
 Song Liu <song@kernel.org>, Tejun Heo <tj@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, sched-ext@lists.linux.dev
References: <20261121003403.2928928-1-ihor.solodrai@linux.dev>
 <20261121003403.2928928-2-ihor.solodrai@linux.dev>
 <adf5a84b-5d80-4c02-91f5-12def2c37304@kernel.org>
 <faecfef3-ac9f-41be-8bc3-83a66572066a@linux.dev>
 <CAEf4Bza6oDkY=mfa4PedrQYtjYnkefTs2m-wVatK9BGoNLd-wA@mail.gmail.com>
Content-Language: en-US
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <CAEf4Bza6oDkY=mfa4PedrQYtjYnkefTs2m-wVatK9BGoNLd-wA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2026-11-24 3:47 p.m., Andrii Nakryiko wrote:
> On Mon, Nov 23, 2026 at 9:44 AM Ihor Solodrai <ihor.solodrai@linux.dev> wrote:
>>
>> On 2026-11-23 7:55 a.m., Quentin Monnet wrote:
>>> 2026-11-20 17:33 UTC-0700 ~ Ihor Solodrai <ihor.solodrai@linux.dev>
>>>> resolve_btfids links libbpf statically and uses its BTF header
>>>> accessor, field iterator and SHA-256 helper. libbpf_internal.h
>>>> also defines logging macros and poisons kernel integer typedefs,
>>>> so resolve_btfids wraps the hash helper in a separate source file.
>>>>
>>>> Move the shared declarations to libbpf_tools.h and use them
>>>> directly in resolve_btfids. The header is for in-tree tools and
>>>> stays uninstalled. No shared-library symbols change.
>>>
>>>
>>> Hi Ihor, the change in bpftool's Makefile looks OK and I understand the
>>> motivation for libbpf_tools.h for resolve_btfids. But I find it a bit
>>> confusing to move away from libbpf_internal.h only partially for
>>> bpftool, and to have a split dependency on both libbpf_internal.h and
>>> libbpf_tools.h. Have you considered moving the other objects that
>>> bpftool requires from libbpf_internal.h to libbpf_tools.h as well?
>>
>> Hi Quentin, thank you for taking a look.
>>
>> I haven't considered that, and it seems like a good idea to me.
>>
>> The way I thought about this is that in practice libbpf has at least
>> three levels of (userspace, non-BPF) API:
>>     - public API defined in the symbols map
>>     - internal API, shared helpers and such
>>     - API for the in-tree users, that doesn't make sense to make
>>       public

Hi, Andrii. Just saw your comment after posting.

Please see:
https://lore.kernel.org/bpf/10ad779b-708b-4b0b-b6af-54f3d7414f82@linux.dev/

> 
> well, I don't think encouraging this with extra "libbpf_tools.h" is a
> good thing. I'd prefer to keep stuff like that in libbpf_internal.h
> (because it is meant to be internal to libbpf, with bpftool and
> resolve_btfids being a special case)
> 
> Do I understand correctly that the problem is mostly in poisoning?
> should we just guard those pragmas with #ifdef check and let
> resolve_btfids disable that, if desired?

Yes, this appears to be the root cause so to speak.
An #ifdef may help as well, yes.

> 
>>
>> I felt like the last one needs a header to reduce the amount of
>> copy-paste. I don't like "libbpf_tools.h", it gives me "10k loc
>> utils file" vibes, but I couldn't come up with a better name. Open
>> to suggestions.
>>
>> I need to look into bots' feedback, and I expect there will be a v3,
>> so I'll see what bpftool parts can be moved to the new header as well.
>>
>> Thanks!
>>
>>>
>>> Thanks,
>>> Quentin
>>
>>

