Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793887373;
	b=hxgU75o0MNEyj9Wcy+C54mmMULliEYUPa3QXGaJYe4r6ekksCLYNOraZ8ViOd7/sPobV
	 aTHVgt2bPIMfH7G5ylcy0PAYPdUaigyTB9IQemo6w0AgC8tXTQ1aR9lZhJaPKBJ6k6H0k
	 cMqQz7UKaxhWzgAesyRV7iOnTXN5soFFEnxlnFdCXxY4f8LoDx+bg4MiI2DZoBsKht3HD
	 ZncOESiVC5sotWP1cjlavuakSeEU/MMCurJ1iu5w8W/Fu19C7bXfQdH0lNJy19DWVWc5G
	 amyzEQXXzz+EaW7JIMXihUb8uMTDWW7m6FNJHG7E/DvDioE5a5goOqA0eRxJbuDHy+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793887373;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=Zn4FGyqcpXuDOI4yAR+P0rUnqH2M0CuU1TGwYX3rR+o=;
	b=MlwkFfnMiVIeQRsaDL0JteocjMeRv/dUbF4P0aKgQ8goy9hgBboLu3ZqopepROyHPkt8
	 pIVrROEaIBWDoPP5muMSFK9LCjApSPM/vTFHkZpZ/xyK/US2TCcYxUlu2KwAoJrua3lSk
	 BsU754XzuBgjXk5rxkEdevqSryW2OwQuqqbV8oRz11bhFGP79GgHlXFK2nm1roqXcjX97
	 qmVw+iM7B7nbgF3DJf5NalGIOkjcktKaX9w1n4gaEd9+MBTzxYKW72dbX+MTjuNtaZarf
	 UFimc9aqDFOA2gzT69Hv1W7/ioSwxouarzzQntY5BFqVTiwktgwoyNUnLdN255UTsnw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PBGMmnjh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B14C2606A31B;
	Thu,  5 Nov 2026 14:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PBGMmnjh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A31E1F00919;
	Thu,  5 Nov 2026 14:02:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793887372;
	bh=Zn4FGyqcpXuDOI4yAR+P0rUnqH2M0CuU1TGwYX3rR+o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=PBGMmnjhDZ38hOgzwbJkh3sIHEnlSGL9uYp2wngdD276txrDfZ30SbBzuawEV1nnq
	 Rv0xUXVLJMiY178nhfx2khC2t9XI1dRXm6G5TlAoNS7YPerunjz7djsPlvLVZ0/C/k
	 26g4h1VjB/HlAFQV1zmssZ7NwOIYzsSSZb0yhkM1tOMG25faR5/ai3+x+Y/3RVOPDj
	 gdYrprathq27egizqYSvwVuvU1wkKGxUxFpKE7ymPIMPn6A9ky5MdawMzjXl4/mefd
	 pI0UAGhaO/oyhaxueCevuZ2zkOe8TTbhuwEgihtJKqK+ADu/Zx5bMOsVPAt+1bETdu
	 NZoZqyIdegmtQ==
Date: Thu, 5 Nov 2026 14:02:45 +0000
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Zi Yan <ziy@nvidia.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	"Liam R. Howlett" <liam@infradead.org>, Nico Pache <nico.pache@linux.dev>, 
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
	Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>, 
	Kiryl Shutsemau <kas@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, 
	Boqun Feng <boqun@kernel.org>, Waiman Long <longman@redhat.com>, 
	Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@kernel.org>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Yonghong Song <yonghong.song@linux.dev>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Song Liu <song@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH 4/5] mm: add and use mmap_read_lock[_killable]_nosteal()
 on contention
Message-ID: <auyMat25VPKwzSuL@gremlin>
References: <20261103-khugepaged-latency-fix-v1-0-a07ab16ac860@kernel.org>
 <20261103-khugepaged-latency-fix-v1-4-a07ab16ac860@kernel.org>
 <3a77219e-39e5-4e98-8f88-6f90bccf69f0@kernel.org>
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
In-Reply-To: <3a77219e-39e5-4e98-8f88-6f90bccf69f0@kernel.org>

On Thu, Nov 05, 2026 at 11:16:23AM +0100, David Hildenbrand (Arm) wrote:
> On 11/3/26 09:27, Lorenzo Stoakes (ARM) wrote:
> > With down_read[_killable]_nosteal() available, it becomes possible to
> > release the mmap read lock in such a way that a queued write lock always
> > takes precedence.
> >
> > Expose this to mm through two new wrappers - mmap_read_lock_nosteal() and
> > mmap_read_lock_killable_nosteal().
> >
> > Make use of this in scenarios where the mmap read lock is dropped
> > explicitly for the purposes of relieving mmap_lock contention - the BPF
> > task VMA iterator, and lock_next_vma_under_mmap_lock(), which is where
> > /proc/$pid/smaps_rollup re-acquires the mmap lock after dropping it on
> > contention and falling back from per-VMA locking.
> >
> > Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> > ---
> >  include/linux/mmap_lock.h | 44 ++++++++++++++++++++++++++++++++++++++++++++
> >  kernel/bpf/task_iter.c    |  2 +-
>
>
> I'd appreciate an ack from BPF folks and a confirmation that I could take this
> through my tree :)

With the rwsem thing as a separate patch this patch will be dropped in any case,
which simplifies things :)

--
Cheers, Lorenzo
