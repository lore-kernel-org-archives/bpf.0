Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67F823B6C1D
	for <bpf@vger.kernel.org>; Tue,  2 Jun 2026 09:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780392433; cv=none; b=IqfIQadlH8PLDtMazrkLOiGUedI9YpS15jcCnVRD3uDWPlQSo19o90EENz4f6RwqgeH9dqUXIlEdHs7xwWiNwv8cZDKXpkFKe2cijCezlQGdIMD02tiiQXon2xtvi+DTZ6H/3QnDzZ9E9folJmE4ofIB4A+iTP8EfMrRzgSylcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780392433; c=relaxed/simple;
	bh=M33NTbtwQR9F95umErmtiR+VlJXuRXuGvhc25Hrb2Eg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R9G49y1djic1kTaezKHsqVWbekv1IXVYKXeJ6U2NkynXMvsvidRYUbilZbsf/tfQEhEVhJV9OkdQesUwQFf8OwHiRH5yYu3fvbDCfqGqaSvnqgYz792uSQ3FQRS1R1UrAflcaJBFuOONrkMP5HLCHlGRa6jHiE7KJAwFJ/4h038=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=INq90XuV; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="INq90XuV"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-68acf0a15b3so8092074a12.1
        for <bpf@vger.kernel.org>; Tue, 02 Jun 2026 02:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1780392429; x=1780997229; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8xj507zVwH4D1UTAxqa+3yn4B7/3s6P++nE9EZjUyMs=;
        b=INq90XuVNVQCYobwCSbIw49KlvlFf1RV/9OJUt0njb4xhKoBe43YZRQXvvp3khcc/B
         m4Jp1UKuNzISHuOzhvV9erWXZo4nQrA1hjc+AUsUF9Jp7hnOm0O0NDVKruugdONgYbeQ
         w8nEuEO2wzX2zvkyMZYHIoyMIZWaS1/jeSuCBkVRQ1+qE1IxVCg9SKQLPKu3pBoyS+y4
         3apa5ONqIumH3rN+Tath5+Kk3t/xDGeqYHiIIQ4ZIXsuffMmpT71GPKRNBGLZ3W2dzpe
         cr61Fd5wooVq8wIoddYEG3LOdUv0TKXD7R/Vbog9YpQ+EiqLKpuR1Yer0M723Bkc/0tU
         uS8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780392429; x=1780997229;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8xj507zVwH4D1UTAxqa+3yn4B7/3s6P++nE9EZjUyMs=;
        b=ixXD4zcsSgFEhxgI2VqsNXXAGAk7PW8MEMv/GLO/YgwSyiz0rZSrgGzYZqPp+RWazJ
         62d2Qf6udLkQLT9jYVTgrgDAk50RRIIfMWIJNY/JiEeWBpkDyvpP7OtKDTMcFltgqtW2
         ptwoMN8k90ser9436q9KDFp8ELlDnmT9Ibp5Bub9WJYuAxteBAAm/cqp38IqqGnh0lTF
         FerR9h3Y+sP02IGTpqIncUALrvTWwPvEJWd4jh9ZGVDliNKWHl9Fb47in60Whta6CRr9
         ivFmFCvjd+u/0eu+PseRlwqMJtbn8AFQ5IhxeD+hhv+J9bD6920VchwYqvyHR6JqWwgp
         HOzQ==
X-Forwarded-Encrypted: i=1; AFNElJ/8DEauRud3nNNJlJqkpO/6UwVNlhVWcI6m4E2quhbDB7D6e4/T94dcKTkO6c5ELpi29FQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhJYCeprTP0GDlwTEkdT85pOexgwssqRgC4gloPYo1m6Vb+WuZ
	5sO0ztw3dVg4u/YDCXKn1qccacukLEgxEto2oXB6kbbyTs7GtTJDcUudXCmZOiZtkj4=
X-Gm-Gg: Acq92OFK+1UnFTyyletCMg2BYUj1oUpL9tfXpScECqyMUPfxm4nHJLj8MQPFbNyFW63
	HWipAh9VgPXbG8B/jkWoH+KoRycs0N5l/Rdha0PdHEUtB7bZW6E4+M9zUVBeuC1Q7FNtOFWwp9s
	SV+N0BjGes9LSfuzethq86IjcAQguQ25zVZplyLpLb/+1dpgPkHqZ0Ei9QV3ROt+xNd6Obk+J7S
	pHWkyHbwlqlXmER7zFvXzZwrpep8/mKgqu6gVk12mw5iLvLozUHkWZURH+E7hSxVRnFYkFWHET9
	1rCHvjxmfUR7Jg9BQ3st8lMgPUStTNhpfU/XzjcNezcwA2BrBDFOVIIY3PsktY3U8U1s6wDndne
	cnaKvJRiC9+iLBJP+Qh3KrQfsy6ToVdxp/CP3mzTeU9r1dgxjztxX0czPSTD38zChwHXGaUW6O2
	vHQXHYbN1R1rxktSjoCw8lylIhXnwp9KVfCMJQ93DVfYbSTPBRko/OwQ==
X-Received: by 2002:a17:907:a786:b0:bee:a4b8:d595 with SMTP id a640c23a62f3a-beea4b8d664mr333399566b.7.1780392428574;
        Tue, 02 Jun 2026 02:27:08 -0700 (PDT)
Received: from u94a (27-240-75-84.adsl.fetnet.net. [27.240.75.84])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84238f1ce65sm8655498b3a.5.2026.06.02.02.27.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 02:27:07 -0700 (PDT)
Date: Tue, 2 Jun 2026 17:26:56 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Jerome Marchand <jmarchan@redhat.com>
Cc: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf@vger.kernel.org, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	Mykyta Yatsenko <yatsenko@meta.com>, linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/bpf: Page out as late a possible in file_reader
Message-ID: <ah6g7JSYOWGp2oAG@u94a>
References: <20260420134637.2513867-1-jmarchan@redhat.com>
 <f02fd939-85f7-414a-8b03-a9ebe56c7660@gmail.com>
 <836b0ce8-f427-434f-984b-4fc60b02c810@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <836b0ce8-f427-434f-984b-4fc60b02c810@redhat.com>

On Tue, Apr 21, 2026 at 07:59:08AM +0200, Jerome Marchand wrote:
> On 4/20/26 6:52 PM, Mykyta Yatsenko wrote:
> > On 4/20/26 2:46 PM, Jerome Marchand wrote:
> > > The file_reader/on_open_expect_fault fails consistently on my system.
> > > It expects a page fault on first dynptr read of some range the exe
> > > file of the current process because it has paged out that page range
> > > earlier. However a lot can happen to that range (which depending on
> > > the actual memory layout could contain text section, data section,
> > > sections )related to dynamic linking...) between the moment it was
> > > paged out and the moment the bpf program expected to hit a pagefault
> > > actually run.
> > > 
> > > A bit of instrumentation with mincore() shows that pages from that
> > > range were accessed several times before the program is run. In
> > > particular the call of file_reader__load() seems to fault all the
> > > range in.
> > > 
> > > Move the call to madvise(MADV_PAGEOUT) to just before attaching the
> > > program to minimize the risk of having those page pulled back in from
> > > under our feet.
> > > 
> > > Signed-off-by: Jerome Marchand <jmarchan@redhat.com>
> > > ---
> > 
> > Thank you for the patch, the change looks good. Does it fail
> > consistently on 4K page size?
> 
> It did when I ran the test manually. On our automated testing system, it
> failed intermittently.

On my fork of BPF CI the test was failing[1] consistently, even when
this commit is applied. However I wasn't able to reproduce locally on my
laptop when I ran manually.

Any hints regarding where to look and how to reproduce?

Thanks,
Shung-Hsi

1: https://github.com/shunghsiyu/libbpf/actions/runs/26807198259/job/79027625188

...
