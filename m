Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FEEC1F03DE
	for <bpf@vger.kernel.org>; Wed, 29 Jul 2026 08:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785314250; cv=none; b=IjZxk9sLAxPeLtANuyfHc52Nce7CT1Iy66ji2lEJO30ZhVQNuGRMLXoXZegEMSw/mPH8ZehzPY8nIQXZ0X1BLh3zBYtbnbo1wBWlMNxVdF7sLuE8Uoms1UajZv6LQwhaTGusioK1DAXYhk2ZyxR0LpWISIYy2pKxMZH//u3ITKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785314250; c=relaxed/simple;
	bh=dB5K+/Xq9QaqHEbLAYZyoL6lCfrYbTpgTEMSzgQfflo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZuBLsk60j945+KttNR+A5R8c88FnD46xEVjxDL9xI3tamFLZW7TLkVJON3LYeVuaQsutGrzyNCbwT3p75+VT8v7YTpeA8eti5IYFEnkCAzjKVfsazNUArQAsVuIWcomz/3gucYgBdcSCeppYMbsnPgI1PZ1uOa7xwfcy+tFLy4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JRvuiJ4t; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JRvuiJ4t"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785314248; x=1816850248;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dB5K+/Xq9QaqHEbLAYZyoL6lCfrYbTpgTEMSzgQfflo=;
  b=JRvuiJ4tkl46fvYkxSarD4nFmAR1PJ0kTnTmhia/FnFVljKcKL9LOk+b
   vhUeJQN5iT7nOcT2HPSZxnWRHdn0NyGfVyFGvuSPJLaj19YboXZ1AyDmK
   ZgQl/eNKqF3noc/iXEeszCdM9tinFNUyK1Y6qfUy4eLmTRBBahUOWhBgv
   0od/w9c6uOqfYaNFkcWTLBVRDrs8wp5wMtFgP8yXl/dqg9ogqBhO/Vco+
   M5zAxJS4JG1vWu65WpXqvwt8Q+8+dScA91NdAXheOgDL/VlOgcyZhg3n0
   BqsDUtKNJ6PWRHkYOcgadnw2JB9yvNO8EjEZwhALJXZfQsQkXbR8r3cE2
   Q==;
X-CSE-ConnectionGUID: EkEgNwJ3S8aTDIfrKv6J/g==
X-CSE-MsgGUID: 10BKUWc0QA6vT5n2j4kTzA==
X-IronPort-AV: E=McAfee;i="6800,10657,11859"; a="85765574"
X-IronPort-AV: E=Sophos;i="6.25,192,1779174000"; 
   d="scan'208";a="85765574"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2026 01:37:27 -0700
X-CSE-ConnectionGUID: o8f25oJqTmutMbHcGPVAvA==
X-CSE-MsgGUID: qJEvWb5PTL+m2C0M/1qjCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,192,1779174000"; 
   d="scan'208";a="298167910"
Received: from lkp-server02.sh.intel.com (HELO ea128546eb3d) ([10.239.97.151])
  by orviesa001.jf.intel.com with ESMTP; 29 Jul 2026 01:37:26 -0700
Received: from kbuild by ea128546eb3d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wozmr-00000000fCR-46DF;
	Wed, 29 Jul 2026 08:37:15 +0000
Date: Wed, 29 Jul 2026 16:36:11 +0800
From: kernel test robot <lkp@intel.com>
To: Song Liu <song@kernel.org>, bpf@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com,
	kernel-team@meta.com, Song Liu <song@kernel.org>
Subject: Re: [PATCH v3 bpf-next 1/1] bpf: Populate mmap-able array map memory
 lazily
Message-ID: <202607291608.xeQ99Iqz-lkp@intel.com>
References: <20260729001033.3433328-2-song@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260729001033.3433328-2-song@kernel.org>

Hi Song,

kernel test robot noticed the following build errors:

[auto build test ERROR on fdec474c65fd35d5a6e1497ed50a9f98c07192f0]

url:    https://github.com/intel-lab-lkp/linux/commits/Song-Liu/bpf-Populate-mmap-able-array-map-memory-lazily/20260729-093241
base:   fdec474c65fd35d5a6e1497ed50a9f98c07192f0
patch link:    https://lore.kernel.org/r/20260729001033.3433328-2-song%40kernel.org
patch subject: [PATCH v3 bpf-next 1/1] bpf: Populate mmap-able array map memory lazily
config: arm-randconfig-002-20260729 (https://download.01.org/0day-ci/archive/20260729/202607291608.xeQ99Iqz-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 8.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260729/202607291608.xeQ99Iqz-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202607291608.xeQ99Iqz-lkp@intel.com/

All errors (new ones prefixed by >>):

   kernel/bpf/arraymap.c: In function 'array_map_mmap_pages':
>> kernel/bpf/arraymap.c:659:6: error: implicit declaration of function 'pmd_none'; did you mean 'p4d_none'? [-Werror=implicit-function-declaration]
     if (pmd_none(*vmf->pmd))
         ^~~~~~~~
         p4d_none
>> kernel/bpf/arraymap.c:673:8: error: implicit declaration of function 'pte_none'; did you mean 'p4d_none'? [-Werror=implicit-function-declaration]
      if (!pte_none(ptep_get(vmf->pte)))
           ^~~~~~~~
           p4d_none
>> kernel/bpf/arraymap.c:673:17: error: implicit declaration of function 'ptep_get'; did you mean 'btf_get'? [-Werror=implicit-function-declaration]
      if (!pte_none(ptep_get(vmf->pte)))
                    ^~~~~~~~
                    btf_get
>> kernel/bpf/arraymap.c:682:3: error: implicit declaration of function 'set_pte_range'; did you mean 'free_pgd_range'? [-Werror=implicit-function-declaration]
      set_pte_range(vmf, folio, page, 1, addr);
      ^~~~~~~~~~~~~
      free_pgd_range
   In file included from include/linux/kallsyms.h:13,
                    from include/linux/bpf.h:23,
                    from kernel/bpf/arraymap.c:5:
>> include/linux/mm.h:3848:2: error: implicit declaration of function 'pte_unmap'; did you mean 'memunmap'? [-Werror=implicit-function-declaration]
     pte_unmap(pte);     \
     ^~~~~~~~~
   kernel/bpf/arraymap.c:689:2: note: in expansion of macro 'pte_unmap_unlock'
     pte_unmap_unlock(start_pte, vmf->ptl);
     ^~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +659 kernel/bpf/arraymap.c

   637	
   638	/*
   639	 * Fault-around handler: install PTEs for the whole [start_pgoff, end_pgoff]
   640	 * window under a single page-table lock, so that populating a large mapping
   641	 * (e.g. mmap(MAP_POPULATE) or a linear access pattern) does not take one full
   642	 * fault per page.
   643	 */
   644	static vm_fault_t array_map_mmap_pages(struct bpf_map *map, struct vm_fault *vmf,
   645					       pgoff_t start_pgoff, pgoff_t end_pgoff)
   646	{
   647		struct bpf_array *array = container_of(map, struct bpf_array, map);
   648		struct vm_area_struct *vma = vmf->vma;
   649		unsigned long addr, rss = 0;
   650		vm_fault_t ret = 0;
   651		pte_t *start_pte;
   652		pgoff_t pgoff;
   653	
   654		/*
   655		 * The PTE table for this PMD must already exist; installing it needs
   656		 * mm-internal helpers. If it is missing, let the regular ->fault path
   657		 * install it and rely on the next fault-around to batch the rest.
   658		 */
 > 659		if (pmd_none(*vmf->pmd))
   660			return 0;
   661	
   662		addr = vma->vm_start + ((start_pgoff - vma->vm_pgoff) << PAGE_SHIFT);
   663		start_pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd, addr, &vmf->ptl);
   664		if (!start_pte)
   665			return 0;
   666		vmf->pte = start_pte;
   667	
   668		for (pgoff = start_pgoff; pgoff <= end_pgoff;
   669		     pgoff++, vmf->pte++, addr += PAGE_SIZE) {
   670			struct folio *folio;
   671			struct page *page;
   672	
 > 673			if (!pte_none(ptep_get(vmf->pte)))
   674				continue;
   675	
   676			page = array_map_fault_page(array, pgoff);
   677			if (!page)
   678				continue;
   679	
   680			folio = page_folio(page);
   681			folio_get(folio);
 > 682			set_pte_range(vmf, folio, page, 1, addr);
   683			rss++;
   684			if (addr == vmf->address)
   685				ret = VM_FAULT_NOPAGE;
   686		}
   687	
   688		add_mm_counter(vma->vm_mm, MM_FILEPAGES, rss);
   689		pte_unmap_unlock(start_pte, vmf->ptl);
   690	
   691		return ret;
   692	}
   693	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
