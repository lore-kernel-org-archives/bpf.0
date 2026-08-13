Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15771438487
	for <bpf@vger.kernel.org>; Thu, 13 Aug 2026 11:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786622187; cv=none; b=DmdbrdAnZuRCAg1mM7la9kcxZIbKZci4qhCDtpPaMKlDUoegY1OYJiX8MKbyNzIch3P8QxxU8TQOR5AlUQUJMUq6ZnyxPjQivM4rDGYhRJ++jWg2WcmbxvtUF91rNYyRmWPdZnBhC3tyWMuK7qLeXc9ClwkOsfVYqGls2D0LUps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786622187; c=relaxed/simple;
	bh=K4bCS56/5V3iahQy/PIJhV+M58cYF8KVhlg5x9D+5wg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jvGTuHShFHnfAxc0E4/RfECCm9SisN4CZXZxrdHz80K2+9CqxkGqb7+69toOeMawpV04vfXRJSAtqZPwdpYptWerhOXgDk2ZV1IrMvcbl/4Fk+cFi470Qo9KbJ8qeUBMJ6GtHRx4CnTANVWkwpDYV7vH8PT4XhdGlU8KuP998eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4hLP2Q5QprzKHNDR
	for <bpf@vger.kernel.org>; Thu, 13 Aug 2026 19:55:58 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 061B640590
	for <bpf@vger.kernel.org>; Thu, 13 Aug 2026 19:56:18 +0800 (CST)
Received: from [10.67.111.192] (unknown [10.67.111.192])
	by APP4 (Coremail) with UTF8SMTPA id gCh0CgBnSB3hsH1qW1m8CA--.49356S2;
	Thu, 13 Aug 2026 19:56:17 +0800 (CST)
Message-ID: <690f71ec-a0fa-4911-9d23-4e122d23527f@huaweicloud.com>
Date: Thu, 13 Aug 2026 19:56:17 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 5/7] selftests/bpf: Add arm64 JIT-sequence tests
 for __arena kfunc arguments
Content-Language: en-US
To: Puranjay Mohan <puranjay@kernel.org>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 Mark Rutland <mark.rutland@arm.com>, Will Deacon <will@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>
References: <20260810190922.3408757-1-puranjay@kernel.org>
 <20260810190922.3408757-6-puranjay@kernel.org>
From: Xu Kuohai <xukuohai@huaweicloud.com>
In-Reply-To: <20260810190922.3408757-6-puranjay@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgBnSB3hsH1qW1m8CA--.49356S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWF1rtw13urWxur4UCw1kAFb_yoW5GrWrpF
	y5WFyrWr10qw47A3y3Gr47AF15Gr1rJay5Cr17WrWFkFsFvr1DXr4xKF1Ut39rCrn0vw1Y
	vF4F9w1v9F1xAaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AF
	wI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUOB
	MKDUUUU
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

On 8/11/2026 3:09 AM, Puranjay Mohan wrote:
> Pin the arm64 counterparts of the x86-64 rebase sequences: the single
> extended-register add for an unconditional argument, the nullable
> truncate-test-and-skip variant, and all five argument registers in one
> call. The nullable cases use a local label so the branch is pinned to
> the instruction right after the add, and the label line does not spell
> out the call because arm64 emits either a direct bl or a materialize-
> and-blr pair depending on the distance to the kfunc.
> 
> Note that on arm64 an unconditional argument is one instruction with
> nothing to anchor it against, so arena_arg_jit_rebase alone cannot tell
> the two forms apart; it only requires that nothing is emitted between
> the rebase and the call. The args5 test is what pins the distinction,
> since its four consecutive adds leave no room for a nullable
> truncate-and-branch pair between them.
> 
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> ---
>   .../selftests/bpf/progs/arena_kfunc_jit.c     | 20 +++++++++++++++++++
>   1 file changed, 20 insertions(+)
> 
> diff --git a/tools/testing/selftests/bpf/progs/arena_kfunc_jit.c b/tools/testing/selftests/bpf/progs/arena_kfunc_jit.c
> index c9b9186626162..b5a01cbc33a73 100644
> --- a/tools/testing/selftests/bpf/progs/arena_kfunc_jit.c
> +++ b/tools/testing/selftests/bpf/progs/arena_kfunc_jit.c
> @@ -32,6 +32,10 @@ __jited("	movl	%edi, %edi")
>   __jited("	addq	%r12, %rdi")
>   __jited("...")
>   __jited("	callq	{{.*}}")
> +__arch_arm64
> +__jited("...")
> +__jited("	add	x0, x28, w0, uxtw")
> +__jited("	{{(bl|mov)	.*}}")
>   __success
>   int arena_arg_jit_rebase(void *ctx)
>   {
> @@ -48,6 +52,12 @@ __jited("	testl	%edi, %edi")
>   __jited("	je	L0")
>   __jited("	addq	%r12, %rdi")
>   __jited("L0:	callq	{{.*}}")
> +__arch_arm64
> +__jited("...")
> +__jited("	mov	w0, w0")
> +__jited("	cbz	w0, L0")
> +__jited("	add	x0, x28, w0, uxtw")
> +__jited("L0:	{{.*}}")
>   __success
>   int arena_arg_jit_nullable(void *ctx)
>   {
> @@ -72,6 +82,16 @@ __jited("	testl	%r8d, %r8d")
>   __jited("	je	L0")
>   __jited("	addq	%r12, %r8")
>   __jited("L0:	callq	{{.*}}")
> +__arch_arm64
> +__jited("...")
> +__jited("	add	x0, x28, w0, uxtw")
> +__jited("	add	x1, x28, w1, uxtw")
> +__jited("	add	x2, x28, w2, uxtw")
> +__jited("	add	x3, x28, w3, uxtw")
> +__jited("	mov	w4, w4")
> +__jited("	cbz	w4, L0")
> +__jited("	add	x4, x28, w4, uxtw")
> +__jited("L0:	{{.*}}")
>   __success
>   int arena_arg_jit_args5(void *ctx)
>   {

Acked-by: Xu Kuohai <xukuohai@huawei.com>

