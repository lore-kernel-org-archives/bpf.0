Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2903C36403B;
	Tue, 17 Mar 2026 10:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773744958; cv=none; b=kDlFv+oZ35oC1R+uhcsAY2gcQT659fjnq88a2BBnz15wIllDtHlKQQA0LL+7f0eH+Y7Tife2ms9RxJRVPTTnlNMgRwgZkuMW3hhqMEOjvLuuz0D3fPiQ8hNvwqaZflFb2m7Kc43pw92A30CM1iIIxQG24Iz0Bc65CEk38rKoGbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773744958; c=relaxed/simple;
	bh=rXOjATTUi8wxb6WZdH8wP/yeOu/3DLjUMmxyBtYdHWQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iTPLV4J59X0rJHsXk1qa+J7utPZguz6LpMrKTa0AIOcLSqX98KmadZ2t8DPwC+B3B9RQ8/aa68SDUkC/jr00HAFPbek2pBcVrVVT5Gox2AAzoC6DV+Pe7Bew+LzDY2BCfPuQV9feDQxfQvmuSEbMR4iSg5rBwiqYuHk8CvvmbPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A4EP5uJv; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A4EP5uJv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773744956; x=1805280956;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rXOjATTUi8wxb6WZdH8wP/yeOu/3DLjUMmxyBtYdHWQ=;
  b=A4EP5uJvf6GWARJ3SyagJZJPKaPpAeA2bEVlynbg1MnWXSUuDfX2hW4T
   KSk6qIPZCkHErQMs0Ld+S3sLK8iZ4K3xYow8Qr4KWURevLCjfLR3kxbQa
   xnwpzUXutjQx/jF1ia+UR2ELdWwQSvSQ5oprSq27nWgVSzvsBn8drjU2m
   mbOWGY9GF3ceNfONJqZ4wuGgN/HKmv5RrShYP2ArCG1YCiELCiWvMoycb
   ZCAJ7Bl8UnLFogBscDmitkGFWmonc6s5uanQ08Ha97FFC4UIqzEWvVukn
   ufKEhDdxdn5Maqbg4ZiXDW23t02pw9iBW2QQs7mGSCKKd4BYvzSHkE2Ma
   Q==;
X-CSE-ConnectionGUID: wfBo7Vy0SXC0UIFD5me4ng==
X-CSE-MsgGUID: Tr1/1JY5TFCSLYzJjaVrDw==
X-IronPort-AV: E=McAfee;i="6800,10657,11731"; a="73791751"
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="73791751"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2026 03:55:54 -0700
X-CSE-ConnectionGUID: n/SGPSluTc2VciJcnqUI/Q==
X-CSE-MsgGUID: wx7avkihQ7W4fj4H8mE5kw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="222459726"
Received: from lkp-server01.sh.intel.com (HELO 63737dd503cb) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 17 Mar 2026 03:55:47 -0700
Received: from kbuild by 63737dd503cb with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w2S5P-000000000HB-30v8;
	Tue, 17 Mar 2026 10:55:43 +0000
Date: Tue, 17 Mar 2026 18:55:03 +0800
From: kernel test robot <lkp@intel.com>
To: Xu Kuohai <xukuohai@huaweicloud.com>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: oe-kbuild-all@lists.linux.dev, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Puranjay Mohan <puranjay@kernel.org>,
	Anton Protopopov <a.s.protopopov@gmail.com>,
	Shahab Vahedi <list+bpf@vahedi.org>,
	Russell King <linux@armlinux.org.uk>,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	Hengqi Chen <hengqi.chen@gmail.com>,
	Johan Almbladh <johan.almbladh@anyfinetworks.com>,
	Paul Burton <paulburton@kernel.org>,
	Hari Bathini <hbathini@linux.ibm.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Naveen N Rao <naveen@kernel.org>,
	Luke Nelson <luke.r.nels@gmail.com>, Xi Wang <xi.wang@gmail.com>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
	Pu Lehui <pulehui@huawei.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	"David S . Miller" <davem@davemloft.net>,
	Wang YanQing <udknight@gmail.com>
Subject: Re: [bpf-next v8 1/5] bpf: Move constants blinding from JIT to
 verifier
Message-ID: <202603171843.yv0X1mn3-lkp@intel.com>
References: <20260309140044.2652538-2-xukuohai@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260309140044.2652538-2-xukuohai@huaweicloud.com>

Hi Xu,

kernel test robot noticed the following build errors:

[auto build test ERROR on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Xu-Kuohai/bpf-Move-constants-blinding-from-JIT-to-verifier/20260309-214106
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20260309140044.2652538-2-xukuohai%40huaweicloud.com
patch subject: [bpf-next v8 1/5] bpf: Move constants blinding from JIT to verifier
config: powerpc64-randconfig-001-20260317 (https://download.01.org/0day-ci/archive/20260317/202603171843.yv0X1mn3-lkp@intel.com/config)
compiler: powerpc64-linux-gcc (GCC) 8.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260317/202603171843.yv0X1mn3-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603171843.yv0X1mn3-lkp@intel.com/

All errors (new ones prefixed by >>):

   powerpc64-linux-ld: kernel/bpf/core.o: in function `bpf_jit_blind_constants':
>> kernel/bpf/core.c:1467: undefined reference to `bpf_patch_insn_data'


vim +1467 kernel/bpf/core.c

  1429	
  1430	int bpf_jit_blind_constants(struct bpf_verifier_env *env)
  1431	{
  1432		struct bpf_insn insn_buff[16], aux[2];
  1433		struct bpf_prog *prog = env->prog;
  1434		int insn_delta, insn_cnt;
  1435		struct bpf_insn *insn;
  1436		int i, rewritten;
  1437	
  1438		if (!prog->blinding_requested || prog->blinded)
  1439			return 0;
  1440	
  1441		insn_cnt = prog->len;
  1442		insn = prog->insnsi;
  1443	
  1444		for (i = 0; i < insn_cnt; i++, insn++) {
  1445			if (bpf_pseudo_func(insn)) {
  1446				/* ld_imm64 with an address of bpf subprog is not
  1447				 * a user controlled constant. Don't randomize it,
  1448				 * since it will conflict with jit_subprogs() logic.
  1449				 */
  1450				insn++;
  1451				i++;
  1452				continue;
  1453			}
  1454	
  1455			/* We temporarily need to hold the original ld64 insn
  1456			 * so that we can still access the first part in the
  1457			 * second blinding run.
  1458			 */
  1459			if (insn[0].code == (BPF_LD | BPF_IMM | BPF_DW) &&
  1460			    insn[1].code == 0)
  1461				memcpy(aux, insn, sizeof(aux));
  1462	
  1463			rewritten = bpf_jit_blind_insn(insn, aux, insn_buff, prog->aux->verifier_zext);
  1464			if (!rewritten)
  1465				continue;
  1466	
> 1467			prog = bpf_patch_insn_data(env, i, insn_buff, rewritten);
  1468			if (!prog)
  1469				return -ENOMEM;
  1470	
  1471			env->prog = prog;
  1472			insn_delta = rewritten - 1;
  1473	
  1474			/* Walk new program and skip insns we just inserted. */
  1475			insn = prog->insnsi + i + insn_delta;
  1476			insn_cnt += insn_delta;
  1477			i        += insn_delta;
  1478		}
  1479	
  1480		prog->blinded = 1;
  1481		return 0;
  1482	}
  1483	#endif /* CONFIG_BPF_JIT */
  1484	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
