Received: from out-184.mta1.migadu.com (out-184.mta1.migadu.com [95.215.58.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5CC939AC1
	for <bpf@vger.kernel.org>; Fri, 29 Mar 2024 03:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711682596; cv=none; b=UDuISSu3OcfBNSIRpuDn/xsI+5e+KCN9ZsKwrmybTq+6GAKluONVhSNNJlgvQKkfdeCqQZJA2Z9hRTYEb4QLpkuVr7yQzaO+TWmbd00wC6oIxrZ2TPmt7HSDUCvRIzRTykWLukksk6gW1lTp+klRv2/Q7ta3u4cJqjK8BvBx2TE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711682596; c=relaxed/simple;
	bh=6xzV/n3RZo8Osk/HoXuZDS0UbfBF6Fv8rNTUdjCiZhs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=jVhvpX9EVBoKHLiv47SZkSipiz0DSuO1W3g+vYZ92Gvq3s/nOEBzN/Is8BLWSe9DLFMktanivm0FWDkdmT/QcvApPezm8C8d9Tku7f6q94fzcBTNKJ0ZduBy4gvhH9xnNH1Tm4YMBL4ebqe4WOune28Lukfwr5U6kDfBFhp4rNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lGzp4Su6; arc=none smtp.client-ip=95.215.58.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lGzp4Su6"
Message-ID: <cf8d5e75-dc75-4f86-be60-013f7ed7c688@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1711682591;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=enwHo9F0kA6u98m3PQof3etjy89jBUpZ2VWwFFKo2G4=;
	b=lGzp4Su6KANBgOGBTw/S1akA2mJQG+awn78UEEV7yiQBJ1lJlyYzVVFshWPAPGDJxOLaAv
	uc/WbuLnjM9AUH2GwViYknpmsfuSUFPD65xVDVudUcTQELfmyzladoWft8jHrBVDib1Lhq
	t/x0kXUfGcDTgZwCcy+dvslpDOtd200=
Date: Thu, 28 Mar 2024 20:23:03 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 1/1] bpf: fix possible file descriptor leaks in
 verifier
Content-Language: en-GB
To: Anton Protopopov <aspsk@isovalent.com>,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Jiri Olsa <jolsa@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Stanislav Fomichev
 <sdf@google.com>, bpf@vger.kernel.org
References: <20240328095657.1995763-1-aspsk@isovalent.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20240328095657.1995763-1-aspsk@isovalent.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 3/28/24 2:56 AM, Anton Protopopov wrote:
> The resolve_pseudo_ldimm64() function might have leaked file
> descriptors when BPF_MAP_TYPE_ARENA was used in a program (some
> error paths missed a corresponding fdput).
>
> Fix leaks and also extract code which adds maps to env->used_maps
> into a separate function. This simplifies code of resolve_pseudo_ldimm64
> and makes it possible to reuse this code later.  While at it, also add a
> verifier verbose message when the maps usage limit is reached.

Could you break this single patch into a series? For example,
for 'to reuse this code later', refactoring the code (without
funcitonality change) can be a separate patch, could you explain
what do you mean reusing the code later? Do you have some plans
to reuse the code later?

The fix for missing fdput() should be its own patch with
Fixes tag below.

You can have yet another patch to enhance verifier by adding
verbose messages.

>
> Fixes: 6082b6c328b5 ("bpf: Recognize addr_space_cast instruction in the verifier.")
> Signed-off-by: Anton Protopopov <aspsk@isovalent.com>
> ---
>   kernel/bpf/verifier.c | 150 ++++++++++++++++++++++--------------------
>   1 file changed, 79 insertions(+), 71 deletions(-)
[...]
