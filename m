Received: from localhost.localdomain (unknown [147.136.157.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F8A239448F;
	Wed,  1 Jul 2026 08:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=147.136.157.0
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782893461; cv=none; b=TCklem+Ym26K1+WlNNf1GQfidovN5Jh53q4/TvjDYICa7zIKsFMcW5dzt4mzFaUKSTCdD+hJhC9b2YhYGDKrhxuKmvNJL8ZOscd/b+itm17O/Ysbo2ya2oSJM49+u8L/RgyIEpz4P9bMB6FKHkudyBNAXCjT/kmLFfGCDk0guwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782893461; c=relaxed/simple;
	bh=A71KniBxj6AqbKjBGpQsPVKmK3p0wYzdL3smoRNFjQo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qiMpu0RR5QTjAvIEYvnsi64J6QJ0UeOWyvdrVGvsb8+hF2IjEBG/IM75WqtfT6YgycMOhAXstw4m1wpme89w0GD6MXjPxXAjywxdrFKkq1Ya6gzcCTrFzEvXOaEnRcghvBUkLDUD8QvBgRMXryOA/WOc0fU3reYKjk4k8kxZy+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=shopee.com; spf=none smtp.mailfrom=localhost.localdomain; arc=none smtp.client-ip=147.136.157.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=shopee.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=localhost.localdomain
Received: by localhost.localdomain (Postfix, from userid 1007)
	id 640AB27E725; Wed,  1 Jul 2026 16:05:51 +0800 (+08)
From: Leon Huang Fu <leon.huangfu@shopee.com>
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: Leon Huang Fu <leon.huangfu@shopee.com>,
	Leon Hwang <leon.hwang@linux.dev>,
	KaFai Wan <kafai.wan@linux.dev>,
	bpf@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>,
	Puranjay Mohan <puranjay@kernel.org>,
	Anton Protopopov <a.s.protopopov@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [RFC PATCH bpf 1/6] bpf: Disallow interpreter fallback for user BPF_ADDR_SPACE_CAST insn
Date: Wed,  1 Jul 2026 16:04:38 +0800
Message-ID: <20260701080524.194326-1-leon.huangfu@shopee.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <7438f087-7fb4-4991-a095-1d24d6d09895@loongson.cn>
References: <20260626154330.33619-1-leon.hwang@linux.dev>  <20260626154330.33619-2-leon.hwang@linux.dev>  <e279c9a7ca6b16e52dc261560513b0eafdd70f87.camel@linux.dev>  <a2aaa21d-4cf9-48a4-839f-dd152bda8185@linux.dev>  <af9c0a7e-13de-c227-849f-4b35d1fb74ff@loongson.cn>  <d55e10b1-d883-4fcf-8fb3-8210db935e4a@linux.dev>  <1c07a34f-b050-a281-6a7b-542a9bfa30b3@loongson.cn>  <bfb432db-bd29-419a-8147-78ff6fac07ad@linux.dev>  <7438f087-7fb4-4991-a095-1d24d6d09895@loongson.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, 1 Jul 2026 15:29:28 +0800, Tiezhu Yang <yangtiezhu@loongson.cn> wro=
te:=0D
> On 2026/7/1 =E4=B8=8B=E5=8D=883:02, Leon Hwang wrote:=0D
>> On 1/7/26 14:49, Tiezhu Yang wrote:=0D
>> [...]=0D
>>>>=0D
>>>> It is a real issue.=0D
>>>>=0D
>>>> Instead of fixing up helper calls, it seems better to prevent=0D
>>>> interpreter fallback if the prog has any JIT-inlineable helper call.=0D
>>>=0D
>>> Hi Alexei and Leon,=0D
>>>=0D
>>> What about the following: (not tested yet, if it is good, I can test it=
)=0D
>>>=0D
>>> [...]=0D
>>>=0D
>>> If you are OK with the above changes, I will test it again and send=0D
>>> a new version later.=0D
>>>=0D
>>=0D
>> If you don't mind, I think I can disallow the interpreter fallback by=0D
>> the below diff in the next revision of this series.=0D
>>=0D
>> The 'aux->jit_required' is introduced by following Alexei's suggestion.=
=0D
>=0D
> I am not sure if introducing a new aux->jit_required member is necessary,=
=0D
> as we already have a local jit_needed flag in the current logic.=0D
=0D
A 'must_jit'-like member was suggested by Alexei [1].=0D
=0D
Probably, the commits in [2] could help to understand 'aux->jit_required'.=
=0D
=0D
[1] https://lore.kernel.org/bpf/DJMRIZ5PDWP4.12OOZ8H881H6O@gmail.com/=0D
[2] https://github.com/Asphaltt/bpf/commits/bpf/fix-interpreter-fallback/v2=
/=0D
=0D
>=0D
> Additionally, the issue reported in my patch [1] is fundamentally tied=0D
> to bpf_jit_inlines_helper_call(). Maybe we can simply reuse jit_needed=0D
> by checking bpf_prog_has_inline_helpers() right before JITing, and then=0D
> reject fallback with -ENOTSUPP if JIT compilation fails.=0D
=0D
Correct. Reusing jit_needed is preferred.=0D
=0D
Thanks,=0D
Leon=0D
=0D
>=0D
> Let us wait for Alexei's comments on the overall direction before=0D
> respinning.=0D
>=0D
> [1] bpf: Fix unaligned interpreter panic on JIT fallback path=0D
> https://lore.kernel.org/bpf/20260615025316.24429-1-yangtiezhu@loongson.cn=
/=0D
>=0D
> Thanks,=0D
> Tiezhu=0D
