Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C2413C9C4
	for <bpf@vger.kernel.org>; Mon,  9 Mar 2026 17:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773077144; cv=none; b=UtGq42tBvOdwJR8M5S2JdQJZQV7vx+WYfhj4qec7VLOALAQbI0fhmHQlr2xUaXj8Q4CCPBXIYHi5dS00jmB5iwCQkGhlEe7W4FO+BzZfBhdD7NBVyMTU6vT8NmIrQrnf4HceKMBqCLQax6CUYJQ5gfrCycL7iLoqvwynzxiJh8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773077144; c=relaxed/simple;
	bh=gEPjI0ct7ELSWIQQSRe/eRzQ0GMb0bd5GlDYE6jefs4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=FXQtLXP1+LGuKpXpDMErtmlLcHA0moudvrWmh/eRS2uPy0a7lzJtm8grpdKggzyEVLzJ+sEVzH2yIuKS/SB/iDjrRB5Cr+aXEqUTBVMpgz6KfyCn3L1Qdv4nxJyIvjkMKUsJEA3Roj5IHFaH6EbZeBNcR58fbc2uRwaw3nh77s4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IiNAVjQl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IiNAVjQl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E02F3C4CEF7;
	Mon,  9 Mar 2026 17:25:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773077144;
	bh=gEPjI0ct7ELSWIQQSRe/eRzQ0GMb0bd5GlDYE6jefs4=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=IiNAVjQlozmjN4fsYkHHQY2uK7ErJiw81Q1djlZc+DnyA1o9t3cDAii+LavKL2kov
	 R4EpqQriNUgwFci4Ew62EkL5Uo7CrTHRCkGt5cZvS+VHuzeCzE8QGf32AntK50wE6p
	 GXLJDhU+rqTw7cQjr3a39DSiUrnE4oKF89KLUcSKSBAYB7P2aGydo/leEH9th3oULh
	 ePC7nh2ZIHb25FL2eAIZveeEXchbWaTYwlh6opGC2nzBOgMuV7qQzYQthC78Cr5VFu
	 Wk2aVaoTAeV+AaS60Eg8V0ujW+qRN7z62o6iu1BlNcbTRCagBp3mmuJKS1Caur1Sta
	 RPZHD3hzCfNKw==
Message-ID: <f7be55c8-be47-490f-8afd-65cfaa95fbfe@kernel.org>
Date: Mon, 9 Mar 2026 17:25:42 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: bpftool generated jited has unpreventable jump addresses
To: Farbod Shahinfar <fshahinfar1@gmail.com>, bpf@vger.kernel.org
References: <CA+WLDByd8qeUpVBijKooyZkBRB1iwGT8fjUEUKXgQEFAZ_pzHA@mail.gmail.com>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <CA+WLDByd8qeUpVBijKooyZkBRB1iwGT8fjUEUKXgQEFAZ_pzHA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

2026-03-05 14:54 UTC+0100 ~ Farbod Shahinfar <fshahinfar1@gmail.com>
> Hi,
> 
> I want to prepare a CFG for a jited eBPF program. The output of
> `bpftool prog dump jited id xx` reports jumps with kernel memory
> address (e.g., `ja      0xffffffffc013ad2a`) and it seems impossible
> to infer where the destination of the jump is. I thought maybe by
> knowing the base address of the program, I can manually convert jump
> destinations to relative addresses, but the base address is not known
> by bpftool (As far as I understood looking at the code).


Hi, if I remember correctly you may be able to get the base address for
the image from /proc/kallsyms, depending on your privileges and your
sysctl configuration, see:

https://docs.kernel.org/admin-guide/sysctl/net.html#bpf-jit-kallsyms


> My questions are:
> 1. Is this a real problem or am I missing something (I might be
> because the bpftool already reports CFG for xlated version)


As far as I'm aware, there hasn't been much interest so far in
generating the CFG for the JITed program, knowing that it's already
available for xlated instructions indeed.


> 2. If it is a limitation, how do you suggest to address the problem
> (if it is of interest to others of course). My initial guess is to
> return the load address of the program in the `bpf_prog_info` when
> doing `bpf_prog_get_info_by_fd`


If the sysctl knob is turned off, I'm not sure allowing the extraction
of image addresses through bpftool is a good idea.

Quentin
