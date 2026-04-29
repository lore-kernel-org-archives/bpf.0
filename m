Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BFA73DE427
	for <bpf@vger.kernel.org>; Wed, 29 Apr 2026 10:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777458816; cv=none; b=bUbWmJQecDQGTqufoXGUEsEASvRRuU+vyuIN6bouWX9hScbk/fp5ggosISH2VOlZmdKEqfQeMKSvlD20nf6siwyBWE+7joGLup8qPvgoVC+5d/kIdqsW83O+s03UQ7veNFx5Jp5HK60KBrx9u+WBQd0oDgXbUQbQRPXn0oDT7m8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777458816; c=relaxed/simple;
	bh=UmShxRC6zXdEi19yg5n4FmGwxPh4rT9g/WgZDs5vHuQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=td8fN5b2plTEd8+3W3x+dixLsXG0dcVGsMtIRKgTHw5Nb5KEMr/ExbAppNAZxTavj5j9FHLH1ORVaNQKl63B67nyleIGlpq0JPd5TiQ2HPlqs3TUeMHmWasya+xWXSiK69hDuwHjmEzD/LIe4EDgrqIz5eNI5yDApBlN3peZKx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b=EpwayYP1; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b="EpwayYP1"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-43d77f6092eso8624725f8f.2
        for <bpf@vger.kernel.org>; Wed, 29 Apr 2026 03:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg.org; s=google; t=1777458812; x=1778063612; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Rc1bdtiiLVnrHG/ySdu4hkFQib6QmOtBtlzbNliUfdc=;
        b=EpwayYP1a25T9uZmWPDwtK9u2GFuQxMsQ57cOyHVNzBiwDTCHkZ6XErPck5T3OSWBt
         FqpMrq9N36wf/JWaaMTultN8ZyO8iVW2h1neAqZJjT3aEkbY+lj7OChaMTcv2wrkXeyy
         rtyVipUFsC7SxB1S3G3DPwm9wD7f0g+1wCp4NPJQ0f1IBjxj3jC2s8Uh/dHVNnJ7NxMO
         qKE5YUddBINhKi0gQOuPmbj2IwGvqZnWl1U6osduPiFeytJ7Xsy7XGIQYxv0YrWFJSUc
         nmAH5h7GHKZyFPftPmfd3CkyBEJJl9zEs/woj8j0yVR/CUiYVofMY9C7sDSFFNVdGwvp
         bK9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777458812; x=1778063612;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rc1bdtiiLVnrHG/ySdu4hkFQib6QmOtBtlzbNliUfdc=;
        b=P+d/gtxH+AHnzgaIO/rlOWcUSKP6mzsTRo0Y6sMkSkeTezua4KgBhrQh51BAUesJSQ
         eIMUgf1fiAeF35MS2Z6/X4RLQKgTmVQG3kYQrL8A6by7aUbwvT9jUbyN6vaz9/Q2DgIS
         hUEAE+YPHokAOWjB+qt0sm10+eR1HtGZqN4EjpMrw5TfpVx+8CYkAGvCxxKg09MMvzC8
         igz5llbQTNpyAuY7PaHJrlvieqmzLMOh6L6NTiL/WYvN2QBXBxi0KR6/q19pF8UxfD28
         tzZlWGiIFaH8VwX8eVWNbGCeRSTnNFDNkg0pIVUo/eDVQrR5Nl2UkB2oYWDyykHtirMm
         bLjg==
X-Forwarded-Encrypted: i=1; AFNElJ/hwZ6NebwgrEVAUehflVZdkIFnzSYzcVyiEDRqJ02qmQnfkUZfqzINQNkIEgprGNUTpXw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKytTiET2EfeIIOhhDgWavpZEwgEz2ZMvztmb1QsPw3dAygzbC
	U46tKlYdlPRGO3mg/q1RK93J7H7yunJmoZ5E3JzV83fiQIoMGT1rABIXbxQ0vSgBDWo=
X-Gm-Gg: AeBDietSltukKDZEumNFcy/2NVItz0e45Srt01Otsof0tr2r2rblIKpQKoccTznGwQd
	2f3plzX8HLMRplbfis3s2CFiIVkVE77tbLRZ8xPbLWmtRAp4TO2KSiGx4aMkqa0uLDYI+9XD1JO
	xV5iwjrMe/IFpPyQi/zBu957XE2NgOo5hHLanc9j2ACKsKNiHJInOeyRfrykCarMPUsJhwKTJ55
	l6HydZ/5iBHov43CnINM3/1y0mjbVbeuNr2WH0MwVbEo6vwyRW3x9T39y5zfzjsR5jZmPxLFKBv
	eOntdgZX2Emv7edDV/hf61/H9FBHHwJ25VP5QNOolQFJEJZ/LMehehWKXa2oRnf1k9GRhkeuagj
	OaFPTQtKkTl08zKino8iH4w4oLCzfPTnmjr1RfFXjbVUHgnu0SSnjNH9ecj99dda8BNKXrtywNK
	pTXNDv/KU5MHDq3Rg=
X-Received: by 2002:a05:6000:438a:b0:43d:c95c:5e75 with SMTP id ffacd0b85a97d-44648f28e79mr12311770f8f.4.1777458812324;
        Wed, 29 Apr 2026 03:33:32 -0700 (PDT)
Received: from localhost ([2620:10d:c092:600::1:ef7e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-447b3d481b2sm5124018f8f.4.2026.04.29.03.33.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 03:33:31 -0700 (PDT)
Date: Wed, 29 Apr 2026 06:33:26 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Muhammad Usama Anjum <usama.anjum@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Brendan Jackman <jackmanb@google.com>, Zi Yan <ziy@nvidia.com>,
	Uladzislau Rezki <urezki@gmail.com>, Nick Terrell <terrelln@fb.com>,
	David Sterba <dsterba@suse.com>,
	Vishal Moola <vishal.moola@gmail.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	Ryan.Roberts@arm.com, david.hildenbrand@arm.com
Subject: Re: [PATCH v6 0/3] mm: Free contiguous order-0 pages efficiently
Message-ID: <20260429103326.GA1743@cmpxchg.org>
References: <20260401101634.2868165-1-usama.anjum@arm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260401101634.2868165-1-usama.anjum@arm.com>

On Wed, Apr 01, 2026 at 11:16:18AM +0100, Muhammad Usama Anjum wrote:
> Hi All,
> 
> A recent change to vmalloc caused some performance benchmark regressions (see
> [1]). I'm attempting to fix that (and at the same time significantly improve
> beyond the baseline) by freeing a contiguous set of order-0 pages as a batch.

I think we should revert the original patch.

The premise is that we can save some allocator calls by requesting
higher orders and splitting them up into singles. This is a frivolous
and short-sighted use of a very coveted and expensive resource.

The buddy allocator tries hard to retain contiguity *if it isn't
needed by the caller*. This patch actively works around that.

The cost of recreating those higher orders elsewhere is shouldered by
whoever actually needs the contiguity down the line. And that process
is orders of magnitudes more expensive than we save here:

We're saving cycles per page in the vmalloc path, and later spend tens
of thousands of cycles per page to recreate the contiguity. Scanning
PFN ranges, folio locks, rmap walks, TLB flushes, page copies.

That's a terrible trade-off.
