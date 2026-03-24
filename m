Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5938240629D;
	Tue, 24 Mar 2026 15:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774365962; cv=none; b=OVIEqAlFsFGbqXNgTiUVxET68hD2F0UyMnYjnfHN3LBl7fKhcW/YiXUUVhovkxnnm8J/KrIDf7eT+kse4a8ZGtqCOdFCvCoQ4ApbtSTB7NSyM2551Gonz/H9x2Wlteu0V4y19Ge+06jUwSe166uC4+ptmqhiLkXWBayS26unGUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774365962; c=relaxed/simple;
	bh=0l54IzxQAoRqsYSO6TE+G9d9c9o2rAL1/Mv505hhc7E=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=NeVtf7HWmyHSaX6My42W8r8vRtQHCHfBJlYoVZ5F92J+D2RzuTYYAAmboCOEdkpy7Z17LLgtyvvngiui4IBAbNI1ysY3pxNbumGB0043VdRwVj9HPna2vEpUvtki6ldMoiav4HBcGGa0qPChVx6DfRAqLSz6O88pRV+99PimYMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DTS6vtRb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DTS6vtRb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04568C19424;
	Tue, 24 Mar 2026 15:26:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774365962;
	bh=0l54IzxQAoRqsYSO6TE+G9d9c9o2rAL1/Mv505hhc7E=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=DTS6vtRbP0gWv5jr2c32wDNYzcUbkb6n7IRoH/XJAEUSQcIHLAbLeWE86uM75aqKH
	 04Y4LA43MtAEUqZhoWn5AVM+tf/2YvNSAaKvWX9HrwicwNWpZ8o2kl9X7ID7AVWeXo
	 o/r33udoskhlHz8caw4PrwgZlmE13OOy7nDjllO9t8KPbt46WzzAsN08mnjgfu4OIX
	 ooJyAAc1sv/yM7L8cMNTlHweJ+ZA25mGMcOVJF+PE7DbqZD46H55u6boJqEJ0xgloj
	 RniNrD9GOS+eatBNNrdQr0tYY5L+To4cmvlRg/yOW51W2lcE5Pk8h2NCWlwCaZqeMa
	 AWNA4Gelnr2ww==
Date: Tue, 24 Mar 2026 08:26:01 -0700
From: Kees Cook <kees@kernel.org>
To: Jiri Olsa <olsajiri@gmail.com>
CC: Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2=5D_libbpf=3A_Replace_strncpy=28=29_w?=
 =?US-ASCII?Q?ith_strnlen=28=29+memcpy=28=29_in_skel=5Fmap=5Fcreate=28=29?=
User-Agent: K-9 Mail for Android
In-Reply-To: <acJXtr10v7wE_xT9@krava>
References: <20260324053036.it.906-kees@kernel.org> <acJXtr10v7wE_xT9@krava>
Message-ID: <6F875550-530E-484C-B6EB-D2E18DCB257C@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On March 24, 2026 2:21:58 AM PDT, Jiri Olsa <olsajiri@gmail=2Ecom> wrote:
>On Mon, Mar 23, 2026 at 10:30:37PM -0700, Kees Cook wrote:
>> Replace the deprecated[1] strncpy() with strnlen() on the source
>> followed by memcpy()=2E Normally strscpy() would be used in this case,
>> but skel_internal=2Eh is shared between kernel and userspace tools, and
>> strscpy() is not available in the userspace build context=2E
>>=20
>> The source map_name is a NUL-terminated C string (the only caller
>> passes a 12 character string literal)=2E The destination attr=2Emap_nam=
e is
>> char[BPF_OBJ_NAME_LEN] (16 bytes) in union bpf_attr, passed to the bpf(=
)
>> syscall=2E The kernel's bpf_obj_name_cpy() requires a NUL terminator wi=
thin
>> the 16-byte field, rejecting names that use all 16 bytes=2E Valid names
>> are therefore at most 15 characters=2E
>>=20
>> The attr is pre-zeroed with memset() at the top of the function,
>> so the byte at position 15 is always NUL=2E The copy is bounded to
>> sizeof(attr=2Emap_name) - 1 (15 bytes) to guarantee NUL-termination is
>
>hm, but this version no longer does that, right?

Arg=2E Yes, correct=2E I'll fix the commit log for v3=2E And yes, the bpf =
test suite reported that v2 shows no test failures any more=2E

(Why does this need an unterminated string internally here when the syscal=
l refuses to build one?)


--=20
Kees Cook
