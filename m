Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=124.71.94.104
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792590825;
	b=ULm/M3jzAOW6sKeyQEmAOug09oC1Zrf62Wmnuargbm21iFqL0IpDlg8A6iM7hhw1Dl4M
	 jf0U3gltmVPUOlE7kRG282gRwJpUiPCkM+Ox8xmUioJV88GqVBsejnSQjVpX1i8DygM0B
	 qz9oTktN1Fl3g2h3L3vvIyv6M/SXWqWsq1Pl9qWMNtF2gpk6oGWucVOtxJoiaJLI6VU0D
	 Z8pOVhnyEvaSi2LEIElKdVUwPYxnxECKWaSFIvMk9whjcabgbcg7mcUPi55R6reglEQF7
	 YmFfFvrCcpIvpZD2MXjbQtoeaR6yl0/zFmihM7zYILGxblTWLG3mFx3DLsOKWleFBJQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792590825;
	h=DMARC-Filter:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:Content-Language:To:Cc:References:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-CM-SenderInfo;
	bh=mcBoLhqXlZY1gmB6abGsJpOCYs+KNAogyHwVMiLPJT4=;
	b=GE05dXlZNT8KCpgC7DrJiLPlm+WbyzEPpicXOk/Z6l3DxyXYyXtR7th+UxLf/2rPjQux
	 CC2qx9EGQoVxRXBqYRsX4Jmxmxn9KzoIx983ky314OENCsISE+lBO08SScJfvAdNJHr/a
	 kMtFSyhHNwAFWZ86w3Nr8fBG105prOYx8tnipa1oIXVZ1RXCaMr3aQW8iXtUYQifD2Nhi
	 m26BDknRLSvL3F89OSxlVq1I3ieNVR7yCpWWG2Ezo2c3HFEpx9w8Q8Snba2/Yk+zcUm+X
	 anRUDH9oD+IE5fWbDq2ZkEXHNAd9Dow6dlnQ2I5YbKkM5nZuFLi4V6Y2eI4BEG+PJKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=huaweicloud.com;
	spf=pass smtp.mailfrom=huaweicloud.com;
	arc=none smtp.remote-ip=124.71.94.104
Received: from dggmsgout13.his.huawei.com (dggmsgout13.his.huawei.com [124.71.94.104])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B66BB606A321;
	Wed, 21 Oct 2026 13:53:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B66BB606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggmsgout13.his.huawei.com (SkyGuard) with ESMTP id 4j8rNB5W2Cz1rrxZ;
	Wed, 21 Oct 2026 21:53:30 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id B789C40573;
	Wed, 21 Oct 2026 21:53:32 +0800 (CST)
Received: from [10.67.111.192] (unknown [10.67.111.192])
	by APP4 (Coremail) with UTF8SMTPA id gCh0CgAXS+rbw9hq+lksBQ--.46926S2;
	Wed, 21 Oct 2026 21:53:32 +0800 (CST)
Message-ID: <3f5446dc-7e7a-4f12-89b8-6e590b2ee1b1@huaweicloud.com>
Date: Wed, 21 Oct 2026 21:53:31 +0800
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 00/16] Add percpu variable support for bpf arena
Content-Language: en-US
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Emil Tsalapatis <emil@etsalapatis.com>,
 Yonghong Song <yonghong.song@linux.dev>
References: <cover.1792503001.git.xukuohai@huawei.com>
 <DM9QXVWZXOHM.21TW53TSXHZ9F@gmail.com>
From: Xu Kuohai <xukuohai@huaweicloud.com>
In-Reply-To: <DM9QXVWZXOHM.21TW53TSXHZ9F@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgAXS+rbw9hq+lksBQ--.46926S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWr1UWr1DAFW5uw4fCFyxAFb_yoW5CF4xpF
	WSkw1DAr1DJ3s7Awn3Cw1DZryF93W3XFWUGw1rtr98ZFnxWrnayrWkKa15uF95uws7uw4F
	v3yDX3sxKa90y3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUylb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAK
	I48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x02
	67AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUF1v3UUUUU
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

On 10/20/2026 10:47 PM, Alexei Starovoitov wrote:
> On Tue, Oct 20, 2026 at 06:22 AM Xu Kuohai <xukuohai@huaweicloud.com> wrote:
>> To use percpu data in a bpf arena today, we need to define an array
>> sized to the maximum possible cpu number, like the cpu_ctxs array
>> defined in tools/sched_ext/scx_qmap.h. This is not a convenient
>> pattern. It lacks performance and scalability, and wastes memory.
> 
> It depends on how you use it.
> Patches 10 and 11 emit the same thing as
> &arr[bpf_get_smp_processor_id()]: load the cpu id, multiply, add.
> The x86 verifier and the arm64 JIT inline that helper already.
> 
> __u64 hits takes a page per possible cpu with this series and 8 bytes
> per cpu in an array.
> 
> cpu_ctxs[] is indexed by cid and qmap_dump_cid() reads other cpus'
> slots from bpf, so scx_qmap cannot use this.
> > Keep it in the bpf prog.
> 
> Any arena offset is safe to access, so the kernel doesn't need to know
> about percpu chunks. bpf_arena_alloc.h does it already with
> page_frag_cur_page[NR_CPUS]: a table of pointers and a page that the
> cpu allocates on the first use. NUMA_NO_NODE gives the local node and
> user space reads the table through its mmap.
> Then no need for BPF_PSEUDO_ARENA_PERCPU, the map_create attrs, verifier
> and JIT changes, new libbpf APIs and libbpf changing thread affinity
> during load. What is lost is plain 'hits++', but kernel C doesn't have
> that either. Initial values are left to the prog below.
>

Another thing I initially counted as a loss is isolation, but since
bpf prog is allowed to read or write any address in the arena, the
isolation is fake.

> Something like this:
> 
> +/*
> + * One copy of 'type' per cpu. A cpu allocates its copy on the first use,
> + * so it comes from the local NUMA node and cpus that never run the prog
> + * cost nothing. User space reads any cpu's copy through name[cpu].
> + */
> +#define DEFINE_ARENA_PER_CPU(type, name)				\
> +type __arena * __arena name[NR_CPUS];					\
> +									\
> +static inline type __arena *this_cpu_##name(void)			\
> +{									\
> +	__u32 cpu = bpf_get_smp_processor_id();				\
> +	type __arena *p = name[cpu];					\
> +									\
> +	if (!p) {							\
> +		p = bpf_arena_alloc_pages(&arena, NULL,			\
> +					  round_up(sizeof(type), PAGE_SIZE) / PAGE_SIZE, \
> +					  NUMA_NO_NODE, 0);		\
> +		name[cpu] = p;						\
> +	}								\
> +	cast_kern(p);							\
> +	return p;							\
> +}
>

Thanks for the sketch. The macro makes senses to me, except two concerns:

1. The table wastes a pointer (8 bytes) for each non-exist CPUs, as the
    global data is populated at load time by libbpf. On my debian machine,
    the CONFIG_NR_CPUS is 8192, while the machine has just a dozen CPUs, so
    the 64 KB bytes per variable are almost all wasted. An alternative way
    is to allocate the pointers at load time.

2. For small variables, the page rounding is a big cost as this series. A
    better way is to make percpu copies on the same NUMA node share the same
    page.

> Orthogonal to that people are working on slab-quality allocator
> for arena. It's also going to be done completely on bpf side.

I noticed the slab allocator work just sent by Emil. I will find out what
percpu support will look like with that.

> pw-bot: cr

