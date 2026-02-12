Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F9951A275
	for <bpf@vger.kernel.org>; Thu, 12 Feb 2026 06:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770877094; cv=none; b=RVqkoN6o31VxPqPMcc9NVGU9mFQWA9j2oElK05ka2ZvwWOS7Fcg0NXuaBVVqIasM1WomCoD9ooxfwmYZmWjRRXBdchKCp1cje5Dbyf6iQcfJwi3WW2TIkx4bgutNTLgfXZHsaQAekvpwRt2U/e9nUEFf2pcENlIJomF/4rAJk4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770877094; c=relaxed/simple;
	bh=H+XBjU5JyjY5Ru0UaJLknveABR6zuIAvYARoo0e4Z6Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gdtj3SwYmSuaLBWG5ZwjCheLJRtzQnuN4THiYhBcOXEdq5zwC/2uaMgW+Fr5o2ociDLzl9ZN50cPYgR2fbZF+NFeNKvk+19ZbaNunQiVGL3eOm7h8msuPT0QNp1BdtL3Wv6uTGvVKD+T6eLVJX/W/DQWWr83SxkvKMs/P3ieXIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=euPJanfQ; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="euPJanfQ"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-658b6757f7fso3157096a12.1
        for <bpf@vger.kernel.org>; Wed, 11 Feb 2026 22:18:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1770877091; x=1771481891; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=t0mu2eNit75QG15HEFRC2fEz8Kg1bLA2cxtvUtjIoxs=;
        b=euPJanfQJcnNOm3my3sKjKhuCZ9H3FOzi0SFnZRNJqjyLWUFoL3M1zlCAwEk1he97h
         9W32OEeK48FBRHzRb7o+TZJXlicOSR7okZaH7yPiAdL4ELDrZmgvI1Qd3qVgjr5HDBxl
         P2DiNuIXVvEjiZb0OkrmbXgd33SEvWlbWM7Bf3nR7NxWC5TV5glj05ALJ/96LZoTQ7HL
         YmOPrXbUcI9ZNBb0RuNDlDNEsO8RAoS+6e21U+PBa6zyKGzD54YHU7hdpoVRvbLC4YHO
         ncpXktNSWXLPF3CwoEuE/ED9GZqmC+Gzs4sE/ga/Kiac8pROyDTJoa4xmYHveN6zAD+P
         zHyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770877091; x=1771481891;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t0mu2eNit75QG15HEFRC2fEz8Kg1bLA2cxtvUtjIoxs=;
        b=e1MqjFS/ebdZFnoowxIMj00fRf2gqxUsoVEuBqJZXkFv+hjEajlPXePuqYu3IT19wk
         f1KmWiSiXj6oRyHDPcoDKaZa0ZLkUHX0WnMe+1k0rpMQPC97+wih9hz7TbK/WcWD1VOm
         2qOF7+BByHjWAxHhXTeubXDnnVtkW602U8zAJQwIubvFa3q7yJ1qREdeV9nyMOcxgCGE
         byw/ip6VwqWXZPl2jRK3QvT80YC4hfmGbelE7NGyf6DuR58S8bmpp3Fv/lIZsP09wsaG
         w87LvLfoA0volvaf/Dd7GY64owEb3OSc+eQIKU1lJGYAHdqIYUu6226ZRn9/Oj6FJ+6X
         l/qg==
X-Gm-Message-State: AOJu0YwoFFDe3DDZn+IELdXUE28xeNzCsH3H9rpvy+CMU//CVB+WDxpo
	/7+7tGsTwOWUhxE3i5pvz9E2RmWbFpU8LoHoj0i3g8SjncF3pMuISBxdZ09UjScEkrZoYOvfy6r
	ucrBv
X-Gm-Gg: AZuq6aIaBBsQU+9uIzJDx787SkDuNGfOLmg1MScStqR6lPrrZ3tWP1XVn9w+Tx2qe41
	cJvd8mA8CQY4jrjgMY+xVwVLqsaEgDx1VJFP+4qtOEnYitehyW4QdClbDEJBim0LQbP/cHOWSXy
	X28ob439C+9nmKzmSaaVv1D8UPamfsNdkjGMQvOjgxf2mz7tpGRafkUzO8xSlWBwy5CuLiNNCL6
	k2/LIMsJPJBg0U0h9/PZxrN8iY6BV3F4nVdMNkqVSUWFCbnXtlPn7rd9kwPwWMeh4E/aRELpr/C
	XLS02XTMXjAsv4AuKJEZCYSdTBDPv4fGndEIz1TH/jhZufHXraNbH7D5e3O+Z2EW4Sf9ogMm2lR
	1OEOloHzwAytB/19yGPcAJDe1BFM/u1W78WuCRUatOotQKBpyh0VTBBhxjETT3jmD0DXThaZogH
	Lnqf6NrGjrvEW1MLjEidM=
X-Received: by 2002:a17:907:9305:b0:b87:105f:312b with SMTP id a640c23a62f3a-b8f9065de85mr72922866b.16.1770877091301;
        Wed, 11 Feb 2026 22:18:11 -0800 (PST)
Received: from u94a ([2401:e180:88b2:2f01:9d74:8645:fc44:9410])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d4a75309a6sm3064282a34.3.2026.02.11.22.18.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Feb 2026 22:18:10 -0800 (PST)
Date: Thu, 12 Feb 2026 14:18:04 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: bpf@vger.kernel.org
Subject: Re: Mainline BPF selftests failure due to rcu_tasks_trace and
 do_filp_open changes
Message-ID: <hnkdxrgrkvalkz4wf4fsfh3j3aumt3xo6pri6hhe5nne6prmdx@jytdc3k5lcj7>
References: <djwjf2vfb7gro3rfag666bojod6ytcectahnb5z6hx2hawimtj@sx47ghzjg4lw>
 <33a19d40-e8f4-4eec-a82e-d0a1048a34a9@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <33a19d40-e8f4-4eec-a82e-d0a1048a34a9@linux.dev>

On Tue, Feb 10, 2026 at 04:08:22PM -0800, Ihor Solodrai wrote:
> On 2/9/26 11:34 PM, Shung-Hsi Yu wrote:
> > Testing with Linus' tree (4adc13ed7c28), BPF selftests in failing in the
> > following cases across test_progs{,-no_alu32,-cpuv4}:
> > 
> > 1. map_kptr: failed to create kprobe 'rcu_tasks_trace_postgp+0x0'
> > 
> >    rcu_tasks_trace_postgp() no longer exists with commit c27cea4416a3
> >    ("rcu: Re-implement RCU Tasks Trace in terms of SRCU-fast")[2]
> > 
> > 2. test_profiler: failed to create kretprobe 'do_filp_open+0x0'
> > 
> >    renamed to do_file_open() in commit 541003b576c3 ("rename
> >    do_filp_open() to do_file_open()")[3]
> > 
> 
> Hi Shung-Hsi,
> 
> I've just sent out a fix for test_profiler [1].
> 
> As for map_kptr, I disabled it temporarily on BPF CI.  I looked into
> this a little, and the test relies on kprobing a static function,
> which isn't very reliable.  Kumar has some ideas how to make the test
> better, stay tuned.

Saw it merged today, thanks for the pointer!

> [1] https://lore.kernel.org/bpf/20260210235855.215679-1-ihor.solodrai@linux.dev/
> 
> > Not familiar with when fix for these are usually done/sent. I suppose
> > after 7.0-rc1?
> 
> AFAIU yes, the patches fixing this would go through -rc PRs.
[...]
