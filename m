Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF6F4C433EF
	for <bpf@archiver.kernel.org>; Wed, 13 Apr 2022 05:42:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbiDMFoU (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 13 Apr 2022 01:44:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232276AbiDMFoP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 13 Apr 2022 01:44:15 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90D9920BD0
        for <bpf@vger.kernel.org>; Tue, 12 Apr 2022 22:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649828515; x=1681364515;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3+7xb50yyAkZcjyiKM5epqXVFZW9Cu31ER3KCuvz5gw=;
  b=jor9EdHf7yOiub5GMTyLfAtzMZ/56lDgqqmlmQ+bb3t/CMaE1A0n5ZSU
   wA/JIOoeTHe1SPtk6oa1cRSDwhXOyNAcXC1QP5xHy+8GeK8soXk2/AW+A
   mtgwfcKHeEu2KvSIKDXM2YK8K0IvDHNOTH84stpb6PjZCZY9I9xPriHqi
   p8kVTavV/jwqZKNcjkEC8J+o0Pk/U+9vvHJL/iBpd24AFxjpl+wJbjjSs
   qoWWm896L+yxFExBjyrA2JVo60prT1zLlglU4GZi9cW9qDaxqqkmc8hWq
   Yum9oQ/OW5My1+zZzNMnWZFa9zyoGpqNHJVnn4LQVTZCNObSh+8FaH9KL
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10315"; a="261427632"
X-IronPort-AV: E=Sophos;i="5.90,255,1643702400"; 
   d="scan'208";a="261427632"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2022 22:41:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,255,1643702400"; 
   d="scan'208";a="660794906"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 12 Apr 2022 22:41:52 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1neVlI-00003w-3a;
        Wed, 13 Apr 2022 05:41:52 +0000
Date:   Wed, 13 Apr 2022 13:41:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc:     kbuild-all@lists.01.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>
Subject: Re: [PATCH bpf-next v4 03/13] bpf: Allow storing unreferenced kptr
 in map
Message-ID: <202204131252.o56DuHxd-lkp@intel.com>
References: <20220409093303.499196-4-memxor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220409093303.499196-4-memxor@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Kumar,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Kumar-Kartikeya-Dwivedi/Introduce-typed-pointer-support-in-BPF-maps/20220409-173513
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
config: microblaze-randconfig-c024-20220408 (https://download.01.org/0day-ci/archive/20220413/202204131252.o56DuHxd-lkp@intel.com/config)
compiler: microblaze-linux-gcc (GCC) 11.2.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


cocci warnings: (new ones prefixed by >>)
>> kernel/bpf/syscall.c:530:11-18: WARNING opportunity for kmemdup

Please review and possibly fold the followup patch.

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
