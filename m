Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8677B287508;
	Fri, 30 Jan 2026 06:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769755817; cv=none; b=sEd80vsp75BBnA4cLKlxcpoCVOvof42GsTIOLL9A4UDytEkfshTtkh6m4+kKxDq7itFzwPiMZ1r8L2iBCovPKf/p03Fzvv+jEA8Xqhg/e16tx/24VfJxBi/RhPOcDWYIsZDHjWcR+BVSfSjpwrQ1N7qga87Fr91Ig3M1SPNLnK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769755817; c=relaxed/simple;
	bh=YXKpjh0EJpqLSUJ/jki6Dyz4NykXUAKico+Ez/AF1IE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AtZlV8r+oixM3ibIPxJjmxobJYabSK5GtHp6bOyuawyIHDOyQ9z45ATd2BmONbmAu8lCx1vOt0K7hpUnOFJtYqVZsQXZp31fEkORDzO2xC19eWmarR5cWMGufm6Gl1NmiYB4Bb36QdxyenAFFxHyxYTZ3rwdrT2chhdmi1X+p8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MdrH8qq7; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MdrH8qq7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769755816; x=1801291816;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=YXKpjh0EJpqLSUJ/jki6Dyz4NykXUAKico+Ez/AF1IE=;
  b=MdrH8qq7ruGsb+hhzBk0tR3hTBwMUHFf53P3gWzQJdbKwo72oTpxuvp7
   gLgAZDnntRdhrcKCg0KoNvvftZMyO44dtaSLlObelDQWeJt9HiLcPJ7Oh
   ihgO03psKlUsqAeWg8Jtz4zoPBzoj7tBcVZgLSGFOuVQJdBRXJvs2ZK8n
   dWlQxK8PIJ0xJsyP90nOWwvAId1XriGyqyPKDyqvonqrPERqoRVFjgVO2
   KCte0cmpn0GU4h/tIA4+9TQg5OZXM4FjyTRF/Z+Kq/hQcU5BeWsGDZL0n
   ovbAHSXtqm39PVhvD45ecL+qJJyaS1yDX8Pdf20BDowvGuB0Pk1nTqvEz
   A==;
X-CSE-ConnectionGUID: db2rBWNoSdi6AJwz/+VS8w==
X-CSE-MsgGUID: ubrm6crkTwOXYPk10rPlVg==
X-IronPort-AV: E=McAfee;i="6800,10657,11686"; a="81320115"
X-IronPort-AV: E=Sophos;i="6.21,262,1763452800"; 
   d="scan'208";a="81320115"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2026 22:50:11 -0800
X-CSE-ConnectionGUID: mYaf0TBPRa2ykUmhlHu8pg==
X-CSE-MsgGUID: LrWGv+Y3RriQke2ImZiRkw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,262,1763452800"; 
   d="scan'208";a="208696559"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost) ([10.239.160.39])
  by fmviesa006.fm.intel.com with ESMTP; 29 Jan 2026 22:50:06 -0800
Date: Fri, 30 Jan 2026 15:15:59 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Harry Yoo <harry.yoo@oracle.com>, Petr Tesarik <ptesarik@suse.com>,
	Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hao Li <hao.li@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Alexei Starovoitov <ast@kernel.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	bpf@vger.kernel.org, kasan-dev@googlegroups.com
Subject: Re: [PATCH v4 06/22] slab: add sheaves to most caches
Message-ID: <aXxaryFUrIFo7/hL@intel.com>
References: <20260123-sheaves-for-all-v4-0-041323d506f7@suse.cz>
 <20260123-sheaves-for-all-v4-6-041323d506f7@suse.cz>
 <aXsLKxukv60p3QWF@intel.com>
 <2cd89ed5-0c8e-43f8-896d-1b7dee047fef@suse.cz>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=gb2312
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2cd89ed5-0c8e-43f8-896d-1b7dee047fef@suse.cz>

Hi Vlastimil,

> > vm_area_cachep's capacity seems to be adjusted to 60 and
> > maple_node_cache keeps 32 as the args setting.
> 
> Good to know. It is a bit larger.
> Hm I could have probably applied the args capacity before doing the roundup
> to make sheaf fill whole kmalloc size. Would add a few object for maple node
> I guess.

Re-considerring this formula:

the nr_objects in set_cpu_partial() in fact represents the half-full
case since it was used to calculate nr_slabs in slub_set_cpu_partial().

Therefore, the maximum capacity of this partial approach should be
nr_objects * 2 (and should actually be even larger, since it doesn't
account for the object on CPU's freelist).

But here, for sheaf, the implicit assumption is that it is completely
full, so that for the maximum capacity of objects per CPU, the sheaf
approach is "half" that of the partial approach.

Is this expected? I'm considering whether we should remove the
¡°divide by two¡± and instead calculate the sheaf capacity based on
half-full assumption (e.h., full main & empty spare).

Thanks,
Zhao


