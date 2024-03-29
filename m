Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22EC012F5B4
	for <bpf@vger.kernel.org>; Fri, 29 Mar 2024 14:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711722612; cv=none; b=FxIPX9VkVRm5aoUIMwVKbCfH1eohkAdg9cXL/iu2xya1zbjiOZ/y4uDvXiKsEEpz7KkYNraFaNjoJiI06jcJkMomaQBI1y3jMbO5+rkTElO3S0MHJB5UH+MQYlYVTYjox7gujJmTmQOIkSR9tkNyLBRv0xkPKP3yg/LtoL/6jQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711722612; c=relaxed/simple;
	bh=lLlhUw0iWmY3YGYKQ/zqyuFEWOUmwy87WRle4ydkO2E=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=J4VN790RVkGWmNTjTZMGMX2lqVOutBS9BrLVvUVVxyzUeHrsX2RMotASMZLcEWuZvHCVKvqOLP/L2X395bW6AycYY+dEkmR4YdG7+3rRlCQ8rUzc0/+boIc+sOTQgsR/NuVdFj9Hp9x5Edsrlx4s3t/MRloLI3MvPbOQSjokTgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=v0J+pq1+; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="v0J+pq1+"
Message-ID: <3d9f90ce-ad48-4b0a-95b5-d772dbc8eca7@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1711722608;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hMkpjlPr1I7hLv/sDHqpPaXSyY9Z3PMgDKDBs0VxYGM=;
	b=v0J+pq1+FP7W75IzgYKUXZV33niC/ZcjIHnX3PKbzziQfOPShWTN0BtpgpizcjHB9B8E7/
	TW3tTJFciDSmtRvchI0pDzKBMtlP4FMMigToXQUP3HiHxc74hHbQxMUN0khUKVqwq2SPvB
	bnAQqIcQaSfZ8FY+0MxLUrIJ8yR8ze4=
Date: Fri, 29 Mar 2024 07:30:00 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 bpf-next] bpf: fix possible file descriptor leaks in
 verifier
Content-Language: en-GB
To: Anton Protopopov <aspsk@isovalent.com>,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Jiri Olsa <jolsa@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Stanislav Fomichev
 <sdf@google.com>, bpf@vger.kernel.org
References: <20240329071106.67968-1-aspsk@isovalent.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20240329071106.67968-1-aspsk@isovalent.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 3/29/24 12:11 AM, Anton Protopopov wrote:
> The resolve_pseudo_ldimm64() function might have leaked file
> descriptors when BPF_MAP_TYPE_ARENA was used in a program (some
> error paths missed a corresponding fdput). Add missing fdputs.
>
> v2:
>    remove unrelated changes from the fix
>
> Fixes: 6082b6c328b5 ("bpf: Recognize addr_space_cast instruction in the verifier.")
> Signed-off-by: Anton Protopopov <aspsk@isovalent.com>

Thanks for the dedicated patch for the bug fix. LGTM.

Acked-by: Yonghong Song <yonghong.song@linux.dev>

