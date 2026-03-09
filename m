Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E5A63D330A
	for <bpf@vger.kernel.org>; Mon,  9 Mar 2026 14:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773066598; cv=none; b=sTt0dJSMx3B4Dio6plY3ILw9kspgjOzktdiapCPR+PIrdTQ0UE3i3Vs8ZW3bs3H16Ho4LYTPrpdaKWCAr8nQ6fN0xXkJKpTm5Hp/MmUV9jqG7nZMLqT/PfOs2JLP6QnSwVdpKE37zHl5QAUEKfhDbM79TxXbn+u/clpnmwtODBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773066598; c=relaxed/simple;
	bh=qGkfUw0cAuRi50whdAw9tYXjFfsurpxdwyuHiMRzvHk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GnZeIH5jInyMWqoyZGhlhc2qOWTQPnBSgkYhaBp4RqOqhvKR2e5F9y/5YjJ+2DPbSfFHwD5Ppk/Tw9urUtyL1cDJ0rssDmUVnfmf+EJ1dj6eQSz2VOYs5rAUhIF95ORTbi6amHxMZSEgKCiBOV6ilZgS6EnxTxmYcmEK/paa01Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=ihyQWMnv; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="ihyQWMnv"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-8cd847b4b23so132432185a.0
        for <bpf@vger.kernel.org>; Mon, 09 Mar 2026 07:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1773066596; x=1773671396; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0bCgFz4UpYVbBeKSYmRS1UHS00xtZH8a/t+DzU0dS+U=;
        b=ihyQWMnvVuXvR909Z1cWQbCW/x6Uje2bNeYH28gk0StuBuzAOqigvjL7w1dE9RCBvz
         ZoZwM7cx4GGinybPk7GhMgYWs8ydFH/+Jkrso2JRthaffI2Zbp5XMm+3eSXkDs8OrWPp
         1PdirPb87UjX0oH7606aIZq+oaAGP7vKybDN2bYMkprfF7k83xhQjnzcnPUik0YOPAdr
         2/KizCv3zVMKKDWmAMInYE8tZ68AN+LVOAzGdtD0I5zgKs6YmQZljOhOH1YH4QRwNHq0
         ro70VHn1/JFY0xIEfw2/X2a1ANbJoQ6e9TuLfleRF6ybM460qzLn7jf0fGZVrlG5Po2P
         lTEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773066596; x=1773671396;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0bCgFz4UpYVbBeKSYmRS1UHS00xtZH8a/t+DzU0dS+U=;
        b=tDtLjIz+qfntkgkd+UkuchpDCJM1aq+xM1OErQoHOxtvvuxOf4MwJOWaMAAEIIMtIn
         1YhQnFh4dcNgZLIhp8Qyz+NpJez87wbKCSYG1hj37iM26zLRoglZUaFltCXIZLhmhXnH
         BVMH6gg+D76b18UOS20eTKxURP4Yeor+LWf5QuibwH0Ea6RR39W+kMuKm/SM6lNJFVQq
         AuXVIpdVlmlR3+Jcry7tkCTxup58IdgQFwLj549M3l0lyFajliMly2e4vGrJa/gtpH8g
         ZJERti6vHw5N5x0Qx2szVEVJ9bZRKF9KOl4WvwYYx4PWpKkCxXW/BE8eOiZWuVFRNRUD
         Z2cQ==
X-Forwarded-Encrypted: i=1; AJvYcCVKqe4/NTzVsupiJxswGoseFGdnfMwNnH8EK/56ayRVEp6eWjteA3nCeYXPUO1drkf8CbU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcTcHdYanvc16LUhrM8WwPdTN4ooFcNgf64doFbWmgUbyXjrgZ
	R+IzK61mhmtKIsHKj/9IAzoqIie42KrrYhCqG0YEo07GquNG+HhhYGWdSqc+ZZiPXg4=
X-Gm-Gg: ATEYQzxTVWtpbQ1HGQYZ2rJGJTPiLzVXzEYUP6TdgpSvZYHwyqDoyh02tlHJoiHJM6+
	f8Fbd4sqspV2/r4byelRO4IWqcL3IPsYFk6ZM29cyvpR+COE6xcigznOfGk51ORoNz7umVw5SgC
	8xv6u5jWrhZ+U7l7La2U9CUQ77xIwubgfm4DS4UxhZDiHOj0N+crilUtPZHoVHqV9xhceQj926h
	WR2npBPr5luB0BMQ3/47C/oTYDgk3sfFXfSa+ScNqdaTiR6xXji02d7CiTQRPdrBvjB5j/hYA1Z
	vqT6l9eoHo9KCtCkjWK6g06jhzt8Zos/Kbu5s1/6waT7bDv6lQVyj5R35+3N07+Z+t2pwVPu888
	gk3Q1xkIlB3atF4pYbppNRZzuS2lnTsuTzxsqQ3cGjJQ6LabGCzXI9I+n2J2EH7RNdfEfhMg6+F
	GhlQFBKTKTPJ8b+5Nj+me2zSv+1y1O2/RW9ySx8WKx5oXDA64XDtNnu/Ag91XE/7EKNPkVu97Uv
	A4aLLLV
X-Received: by 2002:a05:620a:4809:b0:8ca:305b:749b with SMTP id af79cd13be357-8cd6d4d5456mr1426307785a.60.1773066595964;
        Mon, 09 Mar 2026 07:29:55 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cd8d4cad48sm148711185a.33.2026.03.09.07.29.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 07:29:55 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vzbcI-0000000GTxY-2R0b;
	Mon, 09 Mar 2026 11:29:54 -0300
Date: Mon, 9 Mar 2026 11:29:54 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	"linux-mm @ kvack . org" <linux-mm@kvack.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Jann Horn <jannh@google.com>,
	Pedro Falcato <pfalcato@suse.de>,
	David Rientjes <rientjes@google.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Janosch Frank <frankja@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arve =?utf-8?B?SGrDuG5uZXbDpWc=?= <arve@android.com>,
	Todd Kjos <tkjos@android.com>,
	Christian Brauner <brauner@kernel.org>,
	Carlos Llamas <cmllamas@google.com>, Ian Abbott <abbotti@mev.co.uk>,
	H Hartley Sweeten <hsweeten@visionengravers.com>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Leon Romanovsky <leon@kernel.org>,
	Dimitri Sivanich <dimitri.sivanich@hpe.com>,
	Arnd Bergmann <arnd@arndb.de>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Andy Lutomirski <luto@kernel.org>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Eric Dumazet <edumazet@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Miguel Ojeda <ojeda@kernel.org>,
	linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org,
	linux-s390@vger.kernel.org, linux-sgx@vger.kernel.org,
	intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	linux-rdma@vger.kernel.org, bpf@vger.kernel.org,
	linux-perf-users@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	netdev@vger.kernel.org, rust-for-linux@vger.kernel.org,
	x86@kernel.org
Subject: Re: [PATCH v1 16/16] mm/memory: support VM_MIXEDMAP in
 zap_special_vma_range()
Message-ID: <20260309142954.GM1687929@ziepe.ca>
References: <20260227200848.114019-1-david@kernel.org>
 <20260227200848.114019-17-david@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260227200848.114019-17-david@kernel.org>

On Fri, Feb 27, 2026 at 09:08:47PM +0100, David Hildenbrand (Arm) wrote:
> There is demand for also zapping page table entries by drivers in
> VM_MIXEDMAP VMAs[1].
> 
> Nothing really speaks against supporting VM_MIXEDMAP for driver use. We
> just don't want arbitrary drivers to zap in ordinary (non-special) VMAs.
> 
> [1] https://lore.kernel.org/r/aYSKyr7StGpGKNqW@google.com

Are we sure about this?

This whole function seems like a hack to support drivers that are not
using an address_space.

I say that as one of the five driver authors who have made this
mistake.

The locking to safely use this function is really hard to do properly,
IDK if binder can shift to use address_space ??

Jason
