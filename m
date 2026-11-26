Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=124.71.94.104
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795705344;
	b=N+hUYpSV2y9yAVP9V0j7vNjvuxQdcz1Hce2aHRJ6PAKL4mIz8bfSA/o/UqwX6NvOUPV6
	 +BoqgUEaD6TtaghvmvSiZB3U8EZthjHBP3AYsl9MmW7CSK8WK4Sfz1sZWZ6npodfJtVZZ
	 Caf1FX9zl/GB4rjtaAzhwEPibKmFcZj+rYjN1MxAR9q0KEGY4uMWgAynocsBJtN6drNrH
	 H6F+4M+pgIpszMm0yB31SgskW2TrxPa7olDRI7lkx8aHg5sz1dxfUxckVfFtVYeCnBJz2
	 WeVfK2J0HQxJ74BQYY/aBmcS5l7sYFXwNRI+S0TWKdjJ8dK8L9HKzWNc0IZljimqH4A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795705344;
	h=DMARC-Filter:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:Content-Language:To:Cc:References:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-CM-SenderInfo;
	bh=Qv+/RlZ3IZV9hggQM88PlxrjkV3JuGKZj3tmAt55rsU=;
	b=DijO6sGy1JmdBDo3lHmmuuR125g9KBE2EacxqmDe0xjHxrXNicfj83qS+UpNWqoJVAiu
	 Cklfn4C+I0hMyzuNXmAag5TzkWZX/FVn0gCi6LjmIyuE5lc8SrWHDhfuhVbO97fymZ+qL
	 xAWEWPP+3qnC702kQSDcovAmb6kniqcDkpKBvnnO9v0oSsFc18ljPAxfPK7lRZuoSi3vD
	 BbNkNkKcvR2kYiLEV2eLxIW3DQ1ozDrqyrlK96T717JnueJTH+7e36dxZ1jCvMTYVNJPC
	 xuOgbZ2G/IRMz2LJut307ZmSHG2nXgKRAeCtgdL2DdcmoKgwwerQ1mnKhu1d8Xip0Ug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=huaweicloud.com;
	spf=pass smtp.mailfrom=huaweicloud.com;
	arc=none smtp.remote-ip=124.71.94.104
Received: from dggmsgout13.his.huawei.com (dggmsgout13.his.huawei.com [124.71.94.104])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB45A606A331;
	Thu, 26 Nov 2026 15:02:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BB45A606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggmsgout13.his.huawei.com (SkyGuard) with ESMTP id 4jb0Bq0Fvnz1rr2v;
	Thu, 26 Nov 2026 23:02:11 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 493BF4056D;
	Thu, 26 Nov 2026 23:02:16 +0800 (CST)
Received: from [10.67.111.192] (unknown [10.67.111.192])
	by APP2 (Coremail) with UTF8SMTPA id Syh0CgDXW_H2SQhr6+xRFw--.58962S2;
	Thu, 26 Nov 2026 23:02:16 +0800 (CST)
Message-ID: <309b8e49-2f9c-4a2f-9b40-8e7e7cce3455@huaweicloud.com>
Date: Thu, 26 Nov 2026 23:02:14 +0800
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
From: Xu Kuohai <xukuohai@huaweicloud.com>
In-Reply-To: <DN0AIFQ82CFP.34SDTH6ZFZC1G@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:Syh0CgDXW_H2SQhr6+xRFw--.58962S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Wry3KFy8Gr18ZF18Jr13Jwb_yoW8KF15pF
	W3Gw4Ykr4DJw4rAwn7Xw4UuFy2vFs5JwsxCrn8Kws7try5KrWDKw4IgrWFga15Cry0g340
	vr4jq3s8Ja10v3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkEb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2
	j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7x
	kEbVWUJVW8JwACjcxG0xvEwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AK
	xVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F4
	0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFyl
	IxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxV
	AFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j
	6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UAwI
	DUUUUU=
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

On 11/21/2026 3:37 AM, Alexei Starovoitov wrote:
> On Thu, Nov 19, 2026 at 10:48 PM Xu Kuohai <xukuohai@huaweicloud.com> wrote:
>> The kernel repeatedly translates and JIT-compiles these same cBPF
>> programs, wasting CPU cycles and slowing down bulk startup of
>> identically sandboxed workloads. cBPF lacks dynamic instruction patching
> 
> There is no VM startup number in the series
> which makes me question the whole thing.
>

The problem comes from an agent sandbox deployment, where
sandboxes are snapshotted to disk and resumed on demand for
each new request.

Below are the Firecracker microVM startup latencies I
measured on a local server at different VM request rates.
Parentheses show the improvement over the base kernel.

VM req/s   base p50   series p50 (gain)    base p95   series p95 (gain)    base p99   series p99 (gain)
400        20.2 ms    19.7 ms  (+2%)       29.2 ms    27.9 ms  (+5%)       34.7 ms    33.3 ms  (+4%)
500        28.2 ms    27.1 ms  (+4%)       96.8 ms    69.4 ms  (+28%)      164.0 ms   107.9 ms (+34%)
600        56.6 ms    45.0 ms  (+21%)      602 ms     154.5 ms (+74%)      831.8 ms   223.6 ms (+73%)
700        65.5 ms    41.1 ms  (+37%)      1.63 s     134.1 ms (+92%)      2.43 s     194.1 ms (+92%)
800        65.4 ms    39.4 ms  (+40%)      2.97 s     113.8 ms (+96%)      4.60 s     167.3 ms (+96%)
900        61.9 ms    35.7 ms  (+42%)      3.04 s     95.2 ms  (+97%)      5.13 s     147.3 ms (+97%)
1000       53.2 ms    32.2 ms  (+39%)      3.38 s     80.0 ms  (+98%)      5.78 s     125.1 ms (+98%)

At 400 VM/s, the two kernels perform similarly. At higher
rates, the base kernel suffers severe tail latency
collapse, while this series keeps p99 below 225 ms,
reducing it by up to 98% at 1000 VM/s.

After further profiling, I found that this collapse is
mainly caused by Firecracker instances queuing on the
global pack_mutex in bpf_prog_pack_alloc(). So a better
approach is to replace the global mutex to per-pack locks.
I will work on that instead.

>> features like tail calls or tracing. Its JITed instructions remain
>> immutable at runtime. This makes it possible to share the same cBPF
>> filter between different processes.
> 
> Immutable is not enough. The image depends on the caps of the task
> that loads the filter.
> Also any task can time seccomp() and learn that somebody has this filter.
> seccomp_get_filter() needs CAP_SYS_ADMIN for that today.
> 
> fork() shares the filter already, see copy_seccomp().
> A launcher can install the common filter once and fork the VMs.
> 
> I don't think we need this.
> 
> pw-bot: cr

