Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2461B3DEFF3
	for <bpf@vger.kernel.org>; Wed, 25 Mar 2026 16:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774457370; cv=none; b=TgBPRZ+xp3CVjl9y3Jlr7MvQZwv7kJecLDta84uc2/LzpfonayNbOkEluZfsch+wGzB4fuTXYClw5Z9XF+87RBrJN100W3JfBlPE+eofvYHAwv0VNRFf65qpUrh3ukIyfCaBeoUvl5IYU05ArRF3IeJ/aZb1MQvg1yAAClXdEc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774457370; c=relaxed/simple;
	bh=iMGhwqFWkB54ZSWljJvvt29P23iRPNTtnPWO0uSjd5o=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kof6dEU21nVkzOr1GoIGlStDzOoj9Ywqh/Pt3SoOXokXoEMx6D9be90puDAIur/kt4TPE6Hka0gekf7nzhJnOLYATi8D4IJP16XzyTC9K9N3gymXiu0iYiW8aBk86SWm/Z8469jmZz08T2XQUQuEN1Hox0vpacImVC2eaGiAMcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MYVSz005; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MYVSz005"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5a1443780c4so1053555e87.0
        for <bpf@vger.kernel.org>; Wed, 25 Mar 2026 09:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774457365; x=1775062165; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0KHc+LjoEpTOzgKnEsolcMaPHiEs9PP1WuXP2Jldb0w=;
        b=MYVSz005bYFjtaF0DJfrU5GN5BeHirHBAAJ0RomF8QHF9wbgY1cDXFCc6mQzEb3Xtx
         yIPTRt8+V18xOnMrjnH7O4/BJ8wMOmJNZH5xkYT/d9TEZysq0h0W9fmsQnFJWIOJ0qsw
         RaVgq+PaYppol9BrGyKkWu6Z++NJ1nuF8kZcX/potwsTQwqKsrkalOpzCkX9F39yY3Y/
         kAD8fbAZZFYM4w9ANIBJj/fxGXS+9+ci7qD8taQrj8EURDEdjKKJPn/cuC6qbBz6eBvd
         dVCJFDcWafTLIEe9kEV6dDArTgZW1NBZpZU66SZdv/NkuuLEf/abtoMUFHxtSA3b3A9y
         w0gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774457365; x=1775062165;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0KHc+LjoEpTOzgKnEsolcMaPHiEs9PP1WuXP2Jldb0w=;
        b=ODRBmZORPiExbDw94TFHUFhAuZYnO3FR5h650GxrtHFZzzIghDIYbZGfiOAXjHJQCy
         LA08peYXO7VB4ZbJ1gJ5XYrpSxZ3mUqAjZnPYKTQ+jL9SCDkqICPhbd6eL73tLbsnTvU
         3vk2Cm4mJWFnOIoeMh3UtJj9eDCQHnFqA1O7PEXId4Ih8oGUt/UdlMABhlXfmSjiubae
         yTjea4IxbFSfOwZOzsvX9reduGuGXxOcBWDpJHkmLMHEyYWJUFBI2J9eo2bTmuqoKuzQ
         jhE2y2abxgj/s5NVWi9WU+bsjlFmCsm3+YUuP89LYmBfTvBc8oFeoJo9ZEW8X5jM7IoQ
         hJtA==
X-Forwarded-Encrypted: i=1; AJvYcCVev7awUjTRIdFykANo3ckJvJPwyAwZBcAKbjiwoO4aHJw6WVwtKjY+tl0x+BDf7v1kpAg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPP6br1lCaPEVcl1ZTGmWcNQSjIbpWNTduQYzHpZjWMJpV/tlS
	1Ek0l8tcdPRKJC0WIYvtwyQ7tluJrwz4hr4ztwR6UN8GjguqG2rnpxxI
X-Gm-Gg: ATEYQzyxjFPcIEExaPHv96GnEp8U+Zt+XrvWOIMSa/EoZFQj3SUnLjcGbwrlfESQpJi
	kt21F9QE8O27qVfcaaBNGijiHuRFuJVpbOxGUKEMYoVckZNHm9U3ccvFtekt508ptCAjDiQBrhA
	iq0yki/ReCDgMlVHdwTfbL6biMTDC18ftLirsYnBvcLLJMTNyxg0iSNqHqrCZMTbDIWF8PNxzbF
	1wLmrnR5DiVWcvUCKAphDc/bCsE7zJ+2Ua+SgyzesdZ4hmCCxYlCLSaDNtYxPn0csXfFUg/NT6h
	gwmTB0QLRgM8yBEi9e4PesoVOwT4XnVcIK+w87ceBbledAv42g8pd1DynKNmz0crXquxTtpRfVI
	nMb9/SoTKR7TCjWbslchJXft8VRPt83H3gXm4MUj66GgaDEioGFW5rRKzNKlLdAUB
X-Received: by 2002:a05:6512:15a9:b0:5a1:3d15:2861 with SMTP id 2adb3069b0e04-5a29b4f8bccmr1758576e87.6.1774457364681;
        Wed, 25 Mar 2026 09:49:24 -0700 (PDT)
Received: from milan ([2001:9b1:d5a0:a500::24b])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a2a06892b2sm13867e87.40.2026.03.25.09.49.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 09:49:23 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@milan>
Date: Wed, 25 Mar 2026 17:49:22 +0100
To: "David Hildenbrand (Arm)" <david@kernel.org>,
	Muhammad Usama Anjum <usama.anjum@arm.com>
Cc: Muhammad Usama Anjum <usama.anjum@arm.com>,
	Uladzislau Rezki <urezki@gmail.com>, Zi Yan <ziy@nvidia.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Brendan Jackman <jackmanb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Nick Terrell <terrelln@fb.com>, David Sterba <dsterba@suse.com>,
	Vishal Moola <vishal.moola@gmail.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	Ryan.Roberts@arm.com, david.hildenbrand@arm.com
Subject: Re: [PATCH v3 2/3] vmalloc: Optimize vfree
Message-ID: <acQSEn2ZfF5zEtE6@milan>
References: <20260324133538.497616-1-usama.anjum@arm.com>
 <20260324133538.497616-3-usama.anjum@arm.com>
 <1D88CFF0-8A74-413F-9A6A-39E27B760AE1@nvidia.com>
 <acOjIcqyIVY9KNn0@milan>
 <a79ff8ba-ed4a-43d0-9c4b-d2883a5c48e8@arm.com>
 <acQKZBqTjpm6-k2f@milan>
 <84f14a13-6236-47ef-afc5-e168d16caeec@arm.com>
 <cbc7c2d7-963e-4630-baf5-287fb127774f@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cbc7c2d7-963e-4630-baf5-287fb127774f@kernel.org>

On Wed, Mar 25, 2026 at 05:34:08PM +0100, David Hildenbrand (Arm) wrote:
> On 3/25/26 17:25, Muhammad Usama Anjum wrote:
> > On 25/03/2026 4:16 pm, Uladzislau Rezki wrote:
> >> On Wed, Mar 25, 2026 at 03:02:14PM +0000, Muhammad Usama Anjum wrote:
> >>> Sorry, I didn't get it. How does having cond_resched() in this function
> >>> affects __free_contig_range()?
> >>>
> >> It is not. What i am asking is about:
> >>
> >> <snip>
> >> spin_lock();
> >> free_pages_bulk()
> >> ...
> >> <snip>
> >>
> >> so this is not allowed because there is cond_resched() call. We
> >> can remove it and make it possible to invoke free_pages_bulk() under
> >> spin-lock, __but__ only if for example other calls do not sleep:
> >>
> >> __free_contig_range()
> >> memdesc_section()
> >> free_prepared_contig_range()
> >> ...
> >>
> >>>
> >>> The current user of this function is only vfree() which is sleepable.
> >>>
> >> I know. But this function can be used by others soon or later.
> >>
> >> Another option is add a comment, saying that it is only for sleepable
> >> contexts.
> > Thank you for detailed response. I can move cond_resched() to vfree() and make
> > free_pages_bulk() allowed to be called form sleepable context. But I feel the
> > current implementation is better to avoid latency spikes. I'll put explicit
> > comment that this function can only be called from sleepable contexts.
> 
Sounds good!

> That's probably good enough for now. It can accept arbitrarily large
> areas, so the cond_resched() in there is the right thing to do. :)
> 
I agree, since it will be available for other callers, adding the
comment is a right way, so people know :)

--
Uladzislau Rezki
