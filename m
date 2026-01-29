Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF01F318B81;
	Thu, 29 Jan 2026 06:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769669921; cv=none; b=SX/oEz4NK6RJ+i8rmJlQ8hY9EUCG8Ts5RgPTnl6D1FPcrAwT1jFPJcI9uKkeZvNcomCFu1sA1Iku5b4ndJHevAfADwS9S09rkgrNnB4UFsVvwHhULQMQ0J32fJmJGlsQb13ZLSg0DG6X+PgPU4pTGnS1MOjMOWYCHcDQja/GXAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769669921; c=relaxed/simple;
	bh=6q9ecXOAduobTNUC7At4SbfE2hkxTHIZg3D9BGnKiuY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LmMEvf+6r96yRvG570qWq8kVNH4QeEQjv3ar6qJoUFM5Gd95yajocmILFqVuupHZEJIZV3Io2NkZ0jG+M9B+DFO+m1nxGKwd/I5/UBJENZb2XOWxkMRgmc1gQt6FsxIfQdInjJhDjVaN/aLd/cNuP52ln0VlOPzGLvBKZIkQs4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KQCId170; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KQCId170"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769669920; x=1801205920;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6q9ecXOAduobTNUC7At4SbfE2hkxTHIZg3D9BGnKiuY=;
  b=KQCId170PSDULnclMkCVmd/0vKrgXbxSlEbdcUcVd6rk0R05or0Mx4gP
   U7mDHOa0Oy//Mp+q4PeKAO1hVNfARV9VfegDfRfEVAXMELJ8qCq/Ljhb7
   GRSS8E795YjM7zMN2MHT7Gua2faNH6VDHwmaSvXNcBWpf1ZBpySemVh3A
   qwbaxCCYb5gZ4dctsrnQqAtk6CL5sXN7R05Da/AgHougRJDEn4UC+/ZFh
   RjOyqY19S3CirgGMu4KMFvObrgq4dkz8PxawTSiHMqAzRhByaURX+K+I+
   570mdINOa4BHqxUa4tGOM5D+ogqGxEsPcB2z3aMC8JCfbNcjX+F4yyCTu
   g==;
X-CSE-ConnectionGUID: h7dL67wYTw6pQ2MCZU7RcA==
X-CSE-MsgGUID: /g5Yu7+ORFmr0CZPVt3X6A==
X-IronPort-AV: E=McAfee;i="6800,10657,11685"; a="70793007"
X-IronPort-AV: E=Sophos;i="6.21,260,1763452800"; 
   d="scan'208";a="70793007"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2026 22:58:40 -0800
X-CSE-ConnectionGUID: Ph1sbCvuRqGMBhv8WnM2IQ==
X-CSE-MsgGUID: DLGKmnjlSyqn8GrIn4Qipg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,260,1763452800"; 
   d="scan'208";a="213360551"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost) ([10.239.160.39])
  by fmviesa004.fm.intel.com with ESMTP; 28 Jan 2026 22:58:35 -0800
Date: Thu, 29 Jan 2026 15:24:27 +0800
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
Message-ID: <aXsLKxukv60p3QWF@intel.com>
References: <20260123-sheaves-for-all-v4-0-041323d506f7@suse.cz>
 <20260123-sheaves-for-all-v4-6-041323d506f7@suse.cz>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260123-sheaves-for-all-v4-6-041323d506f7@suse.cz>

On Fri, Jan 23, 2026 at 07:52:44AM +0100, Vlastimil Babka wrote:
> Date: Fri, 23 Jan 2026 07:52:44 +0100
> From: Vlastimil Babka <vbabka@suse.cz>
> Subject: [PATCH v4 06/22] slab: add sheaves to most caches
> X-Mailer: b4 0.14.3
> 
> In the first step to replace cpu (partial) slabs with sheaves, enable
> sheaves for almost all caches. Treat args->sheaf_capacity as a minimum,
> and calculate sheaf capacity with a formula that roughly follows the
> formula for number of objects in cpu partial slabs in set_cpu_partial().
> 
> This should achieve roughly similar contention on the barn spin lock as
> there's currently for node list_lock without sheaves, to make
> benchmarking results comparable. It can be further tuned later.
> 
> Don't enable sheaves for bootstrap caches as that wouldn't work. In
> order to recognize them by SLAB_NO_OBJ_EXT, make sure the flag exists
> even for !CONFIG_SLAB_OBJ_EXT.
> 
> This limitation will be lifted for kmalloc caches after the necessary
> bootstrapping changes.
> 
> Also do not enable sheaves for SLAB_NOLEAKTRACE caches to avoid
> recursion with kmemleak tracking (thanks to Breno Leitao).
> 
> Reviewed-by: Suren Baghdasaryan <surenb@google.com>
> Reviewed-by: Harry Yoo <harry.yoo@oracle.com>
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---
>  include/linux/slab.h |  6 ------
>  mm/slub.c            | 56 ++++++++++++++++++++++++++++++++++++++++++++++++----
>  2 files changed, 52 insertions(+), 10 deletions(-)

vm_area_cachep's capacity seems to be adjusted to 60 and
maple_node_cache keeps 32 as the args setting.

I still use will-it-scale to evaluate the impact of this patch, and
performance results appear to be on par with previous ones (*) - doesn't
have regression on my cases.

Based on the results of previous capacity adjustments testing, I think
it shows that the capacity of the maple_node_cache appears to have the
significant impact.

There may still be room for optimization in maple_node_cache. As a
general-purpose algorithm at present, I think it has achieved its
intended purpose based on my test results. So,

Tested-by: Zhao Liu <zhao1.liu@intel.com>


(*): The previous ones include 2 cases:
  1) w/o this series, and directly based on the previous commit ("slub:
     keep empty main sheaf as spare in __pcs_replace_empty_main()").
  2) w/o this single patch, and based on the previous patch 5.

Regards,
Zhao


