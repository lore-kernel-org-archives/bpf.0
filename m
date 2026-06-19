Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0804F3B71B4;
	Fri, 19 Jun 2026 15:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781883823; cv=none; b=M7MmQ7RGIZGkLtLgcL5mAA5GHktjXIhjrFYE+D6YVOlqKox7Az3tTD3chfcUJm1V3GuCpFDvW1ZMG7ciAyvH4vARZ3npYEZdXodFAKTNrXAtxqtHo4DETPtFh3FoWOPvqN1XExeZD9/etwpXeeWJXVbvNEfTni3Av6Hhn/yyPUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781883823; c=relaxed/simple;
	bh=V6fq8mfMiZVKCtjCrzdZ0T3E02/F+cxLsUSpHzRXKp0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VLRMZdX7J9bqqunF7dYYNcoMg9Ibx24NixiOFqne3YExI67v7InyPssvI+cfL9rwRPeJH/bfVnhaWRhlknT5we8vms+cOXom259v9IhMAgpYqWIQHLG5DHbBuiyTGL0AFFak2MgalwHAy80fKQWuTnyjen+a8DYduhphHF/9/dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F7aVViyf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F7aVViyf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50B281F000E9;
	Fri, 19 Jun 2026 15:43:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781883817;
	bh=d7uDHjPWfe+a8WAJh7CqLu6PRzd1eWr1kyfgk1N9hjo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=F7aVViyfNdD0xIGGnW9PO5rasMldVDIwDoFgCWWLixSeZuN784c+fKdsH+I7kh8kk
	 zLFfTBlX6eoclArQ2Ht+HV8ni+pTvka0T8VDtfeoweggbR5R9TQnVf+Y0+iogVHvuW
	 oq02CQ2wur9mUnGaBGnS6bO7XVx+vXNV4wu9EzzhRDSKDvkJ0iUb68nYJtQ0E+UdvP
	 KFs16cHgrguGwEgpzCsSvKq2VTjmWH69rR9HJgJfVeg4rvRI2RragLNIH5QqhajH4v
	 9vQhYou1S4/36hBSSA2hPg31K1kSyPpLKWJYV0npgASs2Ciuvg75mU7+4frJU9w9Bh
	 +yX5hBpIJoaBQ==
Message-ID: <fcb66294-b3ca-4bf1-970d-23e4a7431757@kernel.org>
Date: Fri, 19 Jun 2026 16:43:33 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tools/bpf/bpftool: Fix vmlinux BTF leak in cgroup
 commands
To: Yichong Chen <chenyichong@uniontech.com>, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com
Cc: martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
 jolsa@kernel.org, sdf@fomichev.me, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <24357C69B4405079+20260617090117.280222-1-chenyichong@uniontech.com>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <24357C69B4405079+20260617090117.280222-1-chenyichong@uniontech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

2026-06-17 17:01 UTC+0800 ~ Yichong Chen <chenyichong@uniontech.com>
> bpftool cgroup show and tree call libbpf_find_kernel_btf() to
> resolve attach_btf names, but never release the returned BTF object.
> 
> For cgroup tree, do_show_tree_fn() is called once for each cgroup
> visited by nftw(). When more than one cgroup has attached programs,
> each callback overwrites btf_vmlinux with a new object and loses the
> previous allocation.
> 
> Load vmlinux BTF only once during a tree walk and release it when
> cgroup show or tree completes. Reset btf_vmlinux_id at the same time
> so batch mode starts with clean state.
> 
> Fixes: 596f5fb2ea2a ("bpftool: implement cgroup tree for BPF_LSM_CGROUP")
> Signed-off-by: Yichong Chen <chenyichong@uniontech.com>


Reviewed-by: Quentin Monnet <qmo@kernel.org>

Thank you.

It seems that Sashiko is right regarding the occurrences in struct_ops.c
and map.c, would you mind following up with the related fixes, please?

Thanks,
Quentin
