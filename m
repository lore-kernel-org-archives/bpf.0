Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B419D7C096
	for <bpf@vger.kernel.org>; Tue, 12 Mar 2024 15:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710257032; cv=none; b=NhkI9glI49eY7DUql5ettEhA4HGa7+EAIhH4QUubMXyNNHgDHO6cfA1fHiDqYWqvya54bS+3GQ2iqs9FWrft2Al5uE3X7sfW2UQODm7x5uIq94Ujf3veVa7pG3lOIlI/NVnRLyofUu+RoeKvOFpiRxh/cS0+1Q1K3HXSFVYJ8zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710257032; c=relaxed/simple;
	bh=kjQ22PAcHSF6Qer8WdJCdUb8ysOXVIPo549hA28Cxrs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iiatEdJqnZiNT0EA9JEa+E++zg6B9CwmFolAsLGch0yZP/EoaXbk+Gb/upgno6iAfMqQ4PR3DBi9EaVdGWFGU0Q6XTdExbiv3Z9H2kkvXd+Hira0bRkO+aVZZEPPujzRlYuG5FWKh8kfT3QzwsGO9d8v1rPCcG9+6n9UktCgudo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Zafj1o38; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Zafj1o38"
Message-ID: <b29a7355-350d-4ed7-9929-18f5188b5547@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1710257028;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RJxhKP0NIOmY9GLnyffXKhdjqL9PeQRBPczI5MzSlgg=;
	b=Zafj1o38psgFg7QK+GoqrKj3CHk7vc3FHU60oXgypa4fy0kMLf4x47+F3bw+AXFa82oHaj
	q6Ngkl4A7NVCTyjQow/XUUINSi7lRsEha7iraPcs5YwyuKHUly0M0KKqtpTfJcz3xeBqAa
	w8RUGNx3qkurYR+dH+rckp13qHdJAGs=
Date: Tue, 12 Mar 2024 08:23:43 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next] bpftool: Fix missing pids during link show
Content-Language: en-GB
To: Quentin Monnet <quentin@isovalent.com>,
 Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 kernel-team@fb.com, Martin KaFai Lau <martin.lau@kernel.org>
References: <20240311214116.2123875-1-yonghong.song@linux.dev>
 <CAEf4BzYU0R=HxFk0h_4rHdfCD=9hX-8NRSr=eGiND_3p=8Syvg@mail.gmail.com>
 <e4196303-0631-4a08-a544-ade179d41ef8@linux.dev>
 <59db83c6-e16f-40f6-becc-968292d9564f@isovalent.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <59db83c6-e16f-40f6-becc-968292d9564f@isovalent.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 3/12/24 7:00 AM, Quentin Monnet wrote:
> 2024-03-11 23:30 UTC+0000 ~ Yonghong Song <yonghong.song@linux.dev>
>> On 3/11/24 4:13 PM, Andrii Nakryiko wrote:
>>> On Mon, Mar 11, 2024 at 2:41 PM Yonghong Song
>>> <yonghong.song@linux.dev> wrote:
>>>> Current 'bpftool link' command does not show pids, e.g.,
>>>>     $ tools/build/bpftool/bpftool link
>>>>     ...
>>>>     4: tracing  prog 23
>>>>           prog_type lsm  attach_type lsm_mac
>>>>           target_obj_id 1  target_btf_id 31320
>>>>
>>>> Hack the following change to enable normal libbpf debug output,
>>>>     --- a/tools/bpf/bpftool/pids.c
>>>>     +++ b/tools/bpf/bpftool/pids.c
>>>>     @@ -121,9 +121,9 @@ int build_obj_refs_table(struct hashmap **map,
>>>> enum bpf_obj_type type)
>>>>             /* we don't want output polluted with libbpf errors if
>>>> bpf_iter is not
>>>>              * supported
>>>>              */
>>>>     -       default_print = libbpf_set_print(libbpf_print_none);
>>>>     +       /* default_print = libbpf_set_print(libbpf_print_none); */
>>>>             err = pid_iter_bpf__load(skel);
>>>>     -       libbpf_set_print(default_print);
>>>>     +       /* libbpf_set_print(default_print); */
> I'm taking note to make these logs available when users pass the --debug
> flag (https://github.com/libbpf/bpftool/issues/137), there's no reason
> to hide them in that case.

Totally make sense as most kernels used in production should already have
bpf_link and bpf_iter support already.

[...]

