Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 643753C4B9A;
	Mon,  6 Jul 2026 06:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783319903; cv=none; b=I2T3OOeQA/U/FX66+fIpo1r6hQr8jfd58B7p+m1Fg7XzmL9t28s3eivTGwA/bCAbYLO2I2xjprEwR4tpLB3GV416mkJDT3sLUsYzUxlem4IBGjUUebHBYOzxRJBlG1w9DVNQkjDC3rVQgBqUfd9tOo7B33zeI2gWEXT0NVRxqDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783319903; c=relaxed/simple;
	bh=B/VsvCqwGSzjjqv0oZ/hUkno6smebR7mTBRCKYTUubk=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=rC5clK6LOiZ5kkm1GOCmHC6tJ3foAWSQJS10wtufNGX8rdsF8y577vCfdHFtPvD9h7zp9KYlknL1vt1K96m5NTJuhgdKr+QesxGu6eJxI3c8oyutImm3QMFKaWQCj5ZsbQMSU8+shGpN8CjO6z7qlXb5DsRl+SO/0XdwNypDZ7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8Axx+pKTUtqZVAAAA--.1524S3;
	Mon, 06 Jul 2026 14:38:02 +0800 (CST)
Received: from [10.130.40.83] (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowJCxLcVGTUtqU+cBAA--.205S3;
	Mon, 06 Jul 2026 14:38:00 +0800 (CST)
Subject: Re: [PATCH bpf-next v2 11/11] selftests/bpf: Add LoongArch deny list
To: George Guo <dongtai.guo@linux.dev>, Huacai Chen <chenhuacai@kernel.org>,
 Hengqi Chen <hengqi.chen@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>
Cc: WANG Xuerui <kernel@xen0n.name>, Martin KaFai Lau <martin.lau@linux.dev>,
 Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 George Guo <guodongtai@kylinos.cn>, bpf@vger.kernel.org,
 loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20260702022322.51033-1-dongtai.guo@linux.dev>
 <20260702022322.51033-12-dongtai.guo@linux.dev>
From: Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <eb26a22c-7c64-6d4b-da22-297917702849@loongson.cn>
Date: Mon, 6 Jul 2026 14:37:58 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260702022322.51033-12-dongtai.guo@linux.dev>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJCxLcVGTUtqU+cBAA--.205S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj9xXoWrtw45KFyfJrW5tw1xJF18Zwc_yoWktrc_KF
	WfJrn7XrWkCF9IyF10gFyruayIg3WxurWDu3s5Xr1xW34UWr40qFs7ur1kuFyYgrZ8KrZI
	gFs5XrZ8Ar1Y9osvyTuYvTs0mTUanT9S1TB71UUUUj7qnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUbg8YFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6F4UJVW0owAaw2AFwI0_JF0_Jw1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0c
	Ia020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JF0_
	Jw1lYx0Ex4A2jsIE14v26F4j6r4UJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr4
	1lc7I2V7IY0VAS07AlzVAYIcxG8wCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxG
	rwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C267AKxVWUAVWUtwC20s026c02F40E14
	v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkG
	c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26F4j6r4U
	JwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7IU8jQ6J
	UUUUU==

On 2026/7/2 上午10:23, George Guo wrote:
> From: George Guo <guodongtai@kylinos.cn>
> 
> Add an empty test_progs deny list for LoongArch, mirroring the other
> architectures, so BPF CI and local vmtest have a place to record cases
> that cannot pass on LoongArch.
> 
> Signed-off-by: George Guo <guodongtai@kylinos.cn>
> ---
>   tools/testing/selftests/bpf/DENYLIST.loongarch | 1 +
>   1 file changed, 1 insertion(+)
>   create mode 100644 tools/testing/selftests/bpf/DENYLIST.loongarch
> 
> diff --git a/tools/testing/selftests/bpf/DENYLIST.loongarch b/tools/testing/selftests/bpf/DENYLIST.loongarch
> new file mode 100644
> index 000000000000..70cc007e396e
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/DENYLIST.loongarch
> @@ -0,0 +1 @@
> +# loongarch64 deny list for BPF CI and local vmtest

LoongArch doesn't have an active BPF CI yet,
there is no need to add an empty DENYLIST.

If there are already known test failures on LoongArch,
it would be much more valuable to either:
1. Fix those failures directly, or
2. Report those failures.

We should only consider adding CI after all current
test failures are resolved.

Thanks,
Tiezhu

