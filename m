Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=124.71.93.99
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795846465;
	b=Dqnu9a5/7SlZ0M69yf2jzVs1tE18oT1LJl/HiGQdQyXlj3IqlvT9DaRjmxbmvutpuofi
	 YAs+oeUtGlZU36INZhYnOvirsfW8qWPDKGnHU1bcWTrc8wINFLHPGnPWeUpRZ2Pr+J9nN
	 pkmHR95lBgS7mX0wDBtIPbsDtLvmuBr+lFv2pgdrlw7058a9B8zDdOEWbiSLtTy/o/RKd
	 nFdinbiXZkkoNF4z/EJgXw8Q0/ieqjrnO1pRdH0HMdDF6gmb6RG0BANoVQ+qbPKg3vF6T
	 mo5yAnVJPL349Rn/ISOVvxVDiLiyJKBcwccjIoj6KfGABM8IengIvuLVeSXLpqxbTWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795846465;
	h=DMARC-Filter:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:Content-Language:To:Cc:References:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-CM-SenderInfo;
	bh=BpeYc5qapvr7db1WC0PM9BXoxCZrn7LTw/6t/OyLwrM=;
	b=tu+jXMZmrae/+LOUb50iM+a+1mtTeX3BXLw9fx5numgTNCB6OFqnV9QsgQ9vC097thZp
	 3r6srEguOXcc5z7f3J+jWlSxDPcNDPo59h/qjXT+efiNCPvRhTPTD1udI+rL61Vp7qhwH
	 +Ke8+wsc3CrR71Yq9FZ/3qVt1WNJWsenmY1DOE/TcPmNLZViokuOlbd0J0NhEZcV+Gi9P
	 UFPb0kbxarXEe0FI1RZkrh/8JADddgrWcpuUteTf5sFWOq7H8lqVK1mSf0jhS/IS0aR0o
	 uYR6iNwaxcCfsVLJaju95sBTdjxw7RMDsTVjxcdwGL54UxyztRvI5dz1uFKILyp2TKQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=huaweicloud.com;
	spf=pass smtp.mailfrom=huaweicloud.com;
	arc=none smtp.remote-ip=124.71.93.99
Received: from dggmsgout11.his.huawei.com (dggmsgout11.his.huawei.com [124.71.93.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D30D2606A31C;
	Sat, 28 Nov 2026 06:14:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D30D2606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggmsgout11.his.huawei.com (SkyGuard) with ESMTP id 4jc0Nb11wvz1c1Tr;
	Sat, 28 Nov 2026 14:14:07 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 25AFF4058F;
	Sat, 28 Nov 2026 14:14:17 +0800 (CST)
Received: from [10.67.111.192] (unknown [10.67.111.192])
	by APP1 (Coremail) with UTF8SMTPA id cCh0CgDXKM43cQpr6dATGA--.2610S2;
	Sat, 28 Nov 2026 14:14:16 +0800 (CST)
Message-ID: <a27f5e70-8a42-468b-82e7-4a6d47969814@huaweicloud.com>
Date: Sat, 28 Nov 2026 14:14:15 +0800
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
Subject: Re: [RFC PATCH 0/3] Introduce a classic BPF filter cache for seccomp
Content-Language: en-US
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, io-uring@vger.kernel.org,
 netdev@vger.kernel.org
Cc: Kees Cook <kees@kernel.org>, Andy Lutomirski <luto@amacapital.net>,
 Will Drewry <wad@chromium.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Stanislav Fomichev <sdf@fomichev.me>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Jens Axboe <axboe@kernel.dk>
References: <cover.1795139109.git.xukuohai@huaweicloud.com>
 <DN0AIFQ82CFP.34SDTH6ZFZC1G@gmail.com>
 <309b8e49-2f9c-4a2f-9b40-8e7e7cce3455@huaweicloud.com>
 <DN5F4EBDNESC.3UOJRTCXCL4HI@gmail.com>
 <5b1c03a4-f910-4f97-af3e-1b8c328dd1ba@huaweicloud.com>
 <DN6F6Y9I0QD7.1B49UETL2EKDJ@gmail.com>
From: Xu Kuohai <xukuohai@huaweicloud.com>
In-Reply-To: <DN6F6Y9I0QD7.1B49UETL2EKDJ@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:cCh0CgDXKM43cQpr6dATGA--.2610S2
X-Coremail-Antispam: 1UD129KBjvdXoWrtr4rKw1UWr4xWrW3uw1DAwb_yoWDJFb_Xw
	srWFs8tw1ag3ZxJ3WUKw45Ar4kKryrXFy8JFy8Gr17AryDXr1rCF4kKrsa9FZ3AayxAFZx
	Gwn0qay0qr9F9jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbxxYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AF
	wI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUF1
	v3UUUUU
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

On 11/28/2026 8:33 AM, Alexei Starovoitov wrote:
> On Fri, Nov 27, 2026 at 07:15 AM Xu Kuohai <xukuohai@huaweicloud.com> wrote:
>> The free path is dominated by bpf_arch_text_invalidate(), which sends IPIs
>> to all CPUs and waits for completion. The wait happens after put_cpu(), so
>> the task is preemptible. If the task is preempted, other lock waiters remain
>> blocked until it is scheduled back and releases the lock. This can extend
>> the lock hold time to seconds.
> 
>> After moving bpf_arch_text_invalidate() out of pack_mutex, the p99 VM
>> startup latency drops from 2.79 s to 170 ms under the same workload.
> 
> Awesome!
> 
> btw every free still sends these IPIs.
> We can probably remove them.
> 
> aarch64_insn_set() can do caches_clean_inval_pou() only
> like aarch64_insn_patch_text_nosync().
> bpf_arch_text_invalidate() is its only caller and nothing runs in
> the freed chunks.
> 
> It can be a separate patch, of course.

Yeah, I'll look into it.

