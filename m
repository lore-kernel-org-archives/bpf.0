Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE79A36896B;
	Mon,  9 Mar 2026 09:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773048191; cv=none; b=EQsWARG9Uz4QkBUjEqYOr7Awt2NM2U4n2c70CRFFrBSY1MNWatNB5XZk8JfACqo3/lSDfDCt0ytuRniCMfa9LcoJh4YXLT69XHmohHMweWJgb8iv3CQZ7zBj3OmjH87m+7dXL8hh64QLS31E5bFgzQfF0BVVqyH+YZaFpsSHg7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773048191; c=relaxed/simple;
	bh=JMXViFWMTNfo+yhVFBtXHtyP9ZgTL9VYu1BjU/X26Rs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iZexpyZC+hP/wQOTs8c/RRu39Y0DLm1ToP41KplYYfYz0k8OJH4alr2uRpn60ggXr5rZLp9BOBACHffX/9B7ADc03D2mg/XnXWpZaT1SwIzRPW6g+M6zTsaDqkOMYEqd2XZ6ayAsbelPJSW+Hc4f+cgT9zRl/NQy4LgOwUg5Fsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4fTs4F0SFSzKHMt4;
	Mon,  9 Mar 2026 17:22:53 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 8DDFC4058C;
	Mon,  9 Mar 2026 17:23:06 +0800 (CST)
Received: from [10.67.111.192] (unknown [10.67.111.192])
	by APP4 (Coremail) with SMTP id gCh0CgBHIUxuka5pnygTAQ--.6481S2;
	Mon, 09 Mar 2026 17:22:54 +0800 (CST)
Message-ID: <3b2d9b4b-099c-411f-9bc7-b4cbd11f01ee@huaweicloud.com>
Date: Mon, 9 Mar 2026 17:22:54 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bpf-next v7 1/5] bpf: Move constants blinding from JIT to
 verifier
Content-Language: en-US
To: kernel test robot <lkp@intel.com>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Yonghong Song <yonghong.song@linux.dev>, Puranjay Mohan
 <puranjay@kernel.org>, Anton Protopopov <a.s.protopopov@gmail.com>,
 Shahab Vahedi <list+bpf@vahedi.org>, Russell King <linux@armlinux.org.uk>,
 Tiezhu Yang <yangtiezhu@loongson.cn>, Hengqi Chen <hengqi.chen@gmail.com>,
 Johan Almbladh <johan.almbladh@anyfinetworks.com>,
 Paul Burton <paulburton@kernel.org>, Hari Bathini <hbathini@linux.ibm.com>,
 Christophe Leroy <chleroy@kernel.org>, Naveen N Rao <naveen@kernel.org>,
 Luke Nelson <luke.r.nels@gmail.com>, Xi Wang <xi.wang@gmail.com>,
 =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
 Pu Lehui <pulehui@huawei.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 "David S . Miller" <davem@davemloft.net>, Wang YanQing <udknight@gmail.com>
References: <20260307103949.2340104-2-xukuohai@huaweicloud.com>
 <202603071836.igZbCyrE-lkp@intel.com>
From: Xu Kuohai <xukuohai@huaweicloud.com>
In-Reply-To: <202603071836.igZbCyrE-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgBHIUxuka5pnygTAQ--.6481S2
X-Coremail-Antispam: 1UD129KBjvJXoWxGFWfCrW7uw4DtF1rKw1Utrb_yoW5KFW7pa
	y8Wr9Ikr4qqr1I939rKr4kCFn8t395Jw13K3WUu34rCFsrZFZrGFyxK3yavFya9r95G3yS
	qrZxZ3s7t34DGa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvFb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r4a6rW5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWrXVW8
	Jr1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7
	CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AK
	xVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvj
	xU4R6zUUUUU
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

On 3/8/2026 1:08 AM, kernel test robot wrote:
> Hi Xu,
> 
> kernel test robot noticed the following build errors:
> 
> [auto build test ERROR on bpf-next/master]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Xu-Kuohai/bpf-Move-constants-blinding-from-JIT-to-verifier/20260307-181538
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
> patch link:    https://lore.kernel.org/r/20260307103949.2340104-2-xukuohai%40huaweicloud.com
> patch subject: [bpf-next v7 1/5] bpf: Move constants blinding from JIT to verifier
> config: x86_64-kexec (https://download.01.org/0day-ci/archive/20260307/202603071836.igZbCyrE-lkp@intel.com/config)
> compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260307/202603071836.igZbCyrE-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202603071836.igZbCyrE-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
>>> kernel/bpf/verifier.c:23100:9: error: call to undeclared function 'bpf_jit_blind_constants'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
>      23100 |                 err = bpf_jit_blind_constants(env);
>            |                       ^
>     1 error generated.
>

oops, it's not defined when CONFIG_BPF_JIT is not enabled

> 
> vim +/bpf_jit_blind_constants +23100 kernel/bpf/verifier.c
> 
>   23087	
>   23088	static int fixup_call_args(struct bpf_verifier_env *env)
>   23089	{
>   23090	#ifndef CONFIG_BPF_JIT_ALWAYS_ON
>   23091		struct bpf_prog *prog = env->prog;
>   23092		struct bpf_insn *insn = prog->insnsi;
>   23093		bool has_kfunc_call = bpf_prog_has_kfunc_call(prog);
>   23094		int i, depth;
>   23095	#endif
>   23096		int err = 0;
>   23097	
>   23098		if (env->prog->jit_requested &&
>   23099		    !bpf_prog_is_offloaded(env->prog->aux)) {
>   23100			err = bpf_jit_blind_constants(env);
>   23101			if (err)
>   23102				return err;
>   23103			err = jit_subprogs(env);
>   23104			if (err == 0)
>   23105				return 0;
>   23106			if (err == -EFAULT)
>   23107				return err;
>   23108		}
>   23109	#ifndef CONFIG_BPF_JIT_ALWAYS_ON
>   23110		if (has_kfunc_call) {
>   23111			verbose(env, "calling kernel functions are not allowed in non-JITed programs\n");
>   23112			return -EINVAL;
>   23113		}
>   23114		if (env->subprog_cnt > 1 && env->prog->aux->tail_call_reachable) {
>   23115			/* When JIT fails the progs with bpf2bpf calls and tail_calls
>   23116			 * have to be rejected, since interpreter doesn't support them yet.
>   23117			 */
>   23118			verbose(env, "tail_calls are not allowed in non-JITed programs with bpf-to-bpf calls\n");
>   23119			return -EINVAL;
>   23120		}
>   23121		for (i = 0; i < prog->len; i++, insn++) {
>   23122			if (bpf_pseudo_func(insn)) {
>   23123				/* When JIT fails the progs with callback calls
>   23124				 * have to be rejected, since interpreter doesn't support them yet.
>   23125				 */
>   23126				verbose(env, "callbacks are not allowed in non-JITed programs\n");
>   23127				return -EINVAL;
>   23128			}
>   23129	
>   23130			if (!bpf_pseudo_call(insn))
>   23131				continue;
>   23132			depth = get_callee_stack_depth(env, insn, i);
>   23133			if (depth < 0)
>   23134				return depth;
>   23135			bpf_patch_call_args(insn, depth);
>   23136		}
>   23137		err = 0;
>   23138	#endif
>   23139		return err;
>   23140	}
>   23141	
> 

