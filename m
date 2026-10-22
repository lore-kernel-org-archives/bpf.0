Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792664854;
	b=VNSWMupYYr27AdVsw4x4BTPI4ju6/xnn571sUJ/vfkAsLJaEdrRzE8hDSg14vAcWg1I7
	 7C1n9EAvMIVU+N1UAkPexd+ur2cx8m2AKM9terW/B+n9T/gFsZUaBGF2YddT7oOpEBcBe
	 eU13zvoTHJLZUrHveAaFuxpBR+sefKV73+i8dPAKrTkq/xCAVgSjeUYCotBoj+eUws7t6
	 T3iwCyRWzlk3CWDZfgp9xTW2tPnsQkxyq17h7vtIKYhgHdDJkHBZ1No66I3XSZ8UTlgav
	 LVYUQJoyUjENhUrm1W5IuYnSwhoXCGtDyh723ZfKUyzPh96UcdeiYeQcxeArHTLkfUQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792664854;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=5i/bEbxuGcfxHFgBF33/3ognHBBD4uli9jC93OptmuQ=;
	b=TSw4WgI9i60hA1p9vM40ocQS/kMlyGi8MQtFjT9zFSjOw7wofBPCsLJk9GMYbC6eesvH
	 VJCB1/K1x5G0bTy2lBd4vyRhSqLqlH9Q8THJ7U3KHkmmTuUb9VGwq+mdBVR7+zwK+l6ct
	 M9fpv+jJnLJyEcBwLzW+hCSmLobqnL8bKaSx91pK+XRof0y0iuCHpxab3XdzolatrhRBC
	 Q474JU2Jns+Y/3fl9iI0xpxEJ2TegnjcSTnn9C41yFln93aWcaNQZPbMOLhpB/bAeYNdR
	 lSPRsBXwJ/BuFlnt+mrEQKXIfT2+FWz8up5tXIFN2k4/0IVB8Wcr8au4wJEucCGWu4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=msyIHhIt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 706B4606A32A;
	Thu, 22 Oct 2026 10:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=msyIHhIt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE27D1F000C2;
	Thu, 22 Oct 2026 10:27:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792664854;
	bh=5i/bEbxuGcfxHFgBF33/3ognHBBD4uli9jC93OptmuQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=msyIHhItxYKTq5jN2FoTYszCQmBbsyMEdqNkkA32J/6maH5H4ZVWFZHljKJHN60uv
	 poiaB6oeeUhom1gG63UWLiobxbTQJb1J2RhsigElHV+uyio8Prca260ioYuHGqhlke
	 ucHRvG1j50mu7u72qrDcWfTG3+OY7O6mBFrITHF9gXXs/2PRtMgunqARusriUEpKLv
	 E/JglBMz12mGed1hL+yePPEbEc9ZYdk8CnmWTZU3PbA+KVM/7Y6Dk7SxIOOw//l/Pv
	 WT6aAYyNGtcBkMSV7KYWSUZwZvjijOs+SFQyK6aZGtvxyxTgGUW5Y9mtHgSEZvCcJs
	 D0eq7s/O/0WxQ==
Date: Thu, 22 Oct 2026 11:27:28 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	bpf@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, linux-mm@kvack.org, 
	Andrew Morton <akpm@linux-foundation.org>, "Liam R. Howlett" <liam@infradead.org>, 
	linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>
Subject: Re: [RFC bpf-next 0/9] bpf: Add support to allocate user page
Message-ID: <atnk5kjaeHLhbxVh@gremlin>
References: <20261021195759.119421-1-jolsa@kernel.org>
 <DMAUMG9WL4X6.12UEJJMJSW54Z@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DMAUMG9WL4X6.12UEJJMJSW54Z@gmail.com>

On Wed, Oct 21, 2026 at 09:53:47PM +0000, Alexei Starovoitov wrote:
> On Wed, Oct 21, 2026 at 12:57 PM Jiri Olsa <jolsa@kernel.org> wrote:
> > hi,
> > we have few use cases where having the ability to allocate normal
> > or executable user space memory would help (like to replace function
> > in live process or change environment variables)
>
> I think it's better to do what debuggers do:
> vm_mmap() with the final prot and
> access_process_vm(FOLL_FORCE | FOLL_WRITE), like PTRACE_POKETEXT,
> to fill it. It faults the pages in, writes into r-x private mapping
> and copy_to_user_page() takes care of icache.
> Then no need for bpf_user_page_exec(), do_mprotect_pkey_locked(),
> the marker, READ_IMPLIES_EXEC special case, get_user_pages(), etc.
> No mm changes.

OK thanks that addresses my concerns :)

--
Cheers, Lorenzo
