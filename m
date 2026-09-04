Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1980399CF0;
	Fri,  4 Sep 2026 18:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788544991; cv=none; b=ocvCOKJgfJgVrlunfd5z8y6MXfmUuFrF931Ld2RfaJ/7W41PsyR7+IARFhmxMqzPZB/y6uzOW7ieune46FdjvFvgvkl6NFmFAZdUsdvdstG/02F2P/RlF4fkGdAwfggE3im9QUXdpCgC95+VZFLGzxk93Lcx6fn9cvOLmV+2H5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788544991; c=relaxed/simple;
	bh=TkXCFXgFK2bzzDHVRuhjrGUuwNuqMlDFTU2OpPNhgOM=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=MiFdQiOIprQYQZVh5rvI1Vfgn/z37fUIYsYuwzd2/w4iPZKcl0G/WK++ITSgmEUxhbZXx30FOGGUqE9+WuSEW0vbS51LssHb6Ai7w3DvNH33uwQvXeRYzs8bh1E8fVfE2GryuMkBrNfg2qgHmURKuBxYNjVVL4lIOm6Q3w68y+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=P+VWg/n6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="P+VWg/n6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67C191F00A3D;
	Fri,  4 Sep 2026 18:03:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1788544990;
	bh=/ev2idwf/cRdO21vilJlKS8uLeOphzrHyKdxcKhFvig=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=P+VWg/n6qG4nawFvDzIt6ngXMNxN2sAVMzhN1MbsKMMZxRXjHBZujph2TeZrLFo9E
	 oaeR35MQK6J7zTXvfNVdMY7s8jtU06Py4y63d6DUtMtCfKaxtbL5kVMdfcFz7S7c9a
	 TmK2qynE/qKWwuc7OM86fs6M+wk2DvyrBBGZk/Hk=
Date: Fri, 4 Sep 2026 11:03:08 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: "Hui Zhu" <hui.zhu@linux.dev>
Cc: Roman Gushchin <roman.gushchin@linux.dev>, JP Kobryn
 <inwardvessel@gmail.com>, Shakeel Butt <shakeel.butt@linux.dev>, Andrii
 Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, Ihor
 Solodrai <ihor.solodrai@linux.dev>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Kumar Kartikeya Dwivedi
 <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu
 <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa
 <jolsa@kernel.org>, Emil Tsalapatis <emil@etsalapatis.com>, Shuah Khan
 <shuah@kernel.org>, Barry Song <baohua@kernel.org>, Geliang Tang
 <geliang@kernel.org>, linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 linux-mm@kvack.org, linux-kselftest@vger.kernel.org, Hui Zhu
 <zhuhui@kylinos.cn>
Subject: Re: [PATCH bpf-next v7 1/2] mm/bpf: Add bpf_proactive_reclaim kfunc
Message-Id: <20260904110308.4473cde499e91aab14dbd5fc@linux-foundation.org>
In-Reply-To: <7d8b77dc99ffe99a7bef874a257472fdaaf07e1c.1788516769.git.zhuhui@kylinos.cn>
References: <cover.1788516769.git.zhuhui@kylinos.cn>
	<7d8b77dc99ffe99a7bef874a257472fdaaf07e1c.1788516769.git.zhuhui@kylinos.cn>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  4 Sep 2026 18:20:19 +0800 "Hui Zhu" <hui.zhu@linux.dev> wrote:

> @@ -159,6 +160,74 @@ __bpf_kfunc void bpf_mem_cgroup_flush_stats(struct mem_cgroup *memcg)
>  	mem_cgroup_flush_stats(memcg);
>  }
>  
> +/*
> + * Reclaim must not recurse: try_to_free_mem_cgroup_pages() overwrites
> + * current->reclaim_state, so a nested call would corrupt the outer
> + * reclaim state. Reclaim windows are marked with PF_MEMALLOC;
> + * reclaim_state is also checked because it is installed slightly
> + * before PF_MEMALLOC.
> + */
> +static bool bpf_in_reclaim_context(void)
> +{
> +	return (current->flags & PF_MEMALLOC) || current->reclaim_state;
> +}
> +

Would life improve if try_to_free_mem_cgroup_pages() didn't do that? 
If try_to_free_mem_cgroup_pages() (or some variant of it) were to
permit nesting?

	rs = new_thing(current, &sc.reclaim_state);
	...
	set_task_reclaim_state(current, rs);

?
