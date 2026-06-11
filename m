Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF22825FA29;
	Thu, 11 Jun 2026 04:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781150813; cv=none; b=O3fWSu0x3gN3xfu2fDXYtVmV29b9JrNLlOHtZyd51LAUFzgZ8E3JVMxYivou4MjFAZ+QakKAz8q+9YQaF3+hsLzcFJCA8wLVGISORORikcY+11q0Yl/mpHAxfeY6EYfKEkORHWaLmRN52ft80BlAx/FH5Br8IyMvtc6HK1B28OA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781150813; c=relaxed/simple;
	bh=tCKXuux5w+PsoscSs2ajnpA+0k0HsLplhT8RfrDe/pY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XwJ4Lo6Jb3MNFG0GO54Ump71MBg63CazORkX+e3i++LuBHHZS4LYuJAKfRoJV2aGVaQqdV6KCJh2Ldo7Eq7QR+lF7pGY9A2zf+5V74g3Hl9FJ13BFa/S/7lZnGdOhNCJmYJcx57hFfY5AhkDAU1J0Y7USHDO6+VjC4OEk40GUfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4gbTbl6q0rzYQv6J;
	Thu, 11 Jun 2026 12:06:27 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 9877040561;
	Thu, 11 Jun 2026 12:06:47 +0800 (CST)
Received: from [10.67.111.192] (unknown [10.67.111.192])
	by APP2 (Coremail) with SMTP id Syh0CgBn3oNFNCpqRKCDBQ--.52639S3;
	Thu, 11 Jun 2026 12:06:47 +0800 (CST)
Message-ID: <ffcc7086-941c-443f-bf54-c33610147ca3@huaweicloud.com>
Date: Thu, 11 Jun 2026 12:06:47 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] arm64: ftrace: allow DIRECT_CALLS without CALL_OPS
Content-Language: en-US
To: "Jose Fernandez (Anthropic)" <jose.fernandez@linux.dev>,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, llvm@lists.linux.dev,
 bpf@vger.kernel.org, Florent Revest <revest@chromium.org>,
 Puranjay Mohan <puranjay@kernel.org>
References: <20260609-arm64-ftrace-direct-calls-v1-0-4a46f266697f@linux.dev>
 <20260609-arm64-ftrace-direct-calls-v1-2-4a46f266697f@linux.dev>
From: Xu Kuohai <xukuohai@huaweicloud.com>
In-Reply-To: <20260609-arm64-ftrace-direct-calls-v1-2-4a46f266697f@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:Syh0CgBn3oNFNCpqRKCDBQ--.52639S3
X-Coremail-Antispam: 1UD129KBjvJXoWxWFyxKr48JF1fZr47Ww4fAFb_yoW5uFW3pr
	yfuwnrCrsxZF1F9r42ga4UW345Z397ArW3GF95JrZ0k3s5CrWvkFsxtFZrK34Dtrs3GrWU
	XF1Y934UWFnrZFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPjb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGw
	A2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_GF
	v_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AK
	xVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrx
	kI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v2
	6r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8Jw
	CI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU3cTmDUUU
	U
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

On 6/9/2026 1:19 PM, Jose Fernandez (Anthropic) wrote:
> arm64 gained ftrace direct calls in commit 2aa6ac03516d ("arm64:
> ftrace: Add direct call support") on top of
> DYNAMIC_FTRACE_WITH_CALL_OPS, using the per-callsite ops pointer as a
> fast path to reach the direct trampoline. Since commit baaf553d3bc3
> ("arm64: Implement HAVE_DYNAMIC_FTRACE_WITH_CALL_OPS"), CALL_OPS is
> mutually exclusive with CFI: the pre-function NOPs would change the
> offset of the pre-function kCFI type hash, and the compiler support
> needed to keep that offset consistent does not exist yet.
> 
> The result is that a CONFIG_CFI=y kernel loses CALL_OPS, and with it
> DIRECT_CALLS, and with it every BPF trampoline attachment to kernel
> functions: register_fentry() returns -ENOTSUPP, so fentry/fexit,
> fmod_ret and BPF LSM programs cannot attach at all. This is a real
> problem for hardened arm64 deployments that rely on BPF LSM for
> security monitoring while keeping kCFI enabled.
> 
> CALL_OPS is an optimization for direct calls, not a dependency. When
> the direct trampoline is within BL range, the callsite branches
> straight to it and ftrace_caller is not involved. When it is out of
> range, ftrace_find_callable_addr() already falls back to
> ftrace_caller, and the DIRECT_CALLS machinery there
> (FREGS_DIRECT_TRAMP, ftrace_caller_direct_late) is gated on
> DIRECT_CALLS alone, not CALL_OPS: the ops dispatch invokes
> call_direct_funcs(), which stores the trampoline address in
> ftrace_regs, and ftrace_caller tail-calls it. s390 and loongarch use
> this same mechanism for HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS without
> having CALL_OPS at all, and DYNAMIC_FTRACE_WITH_ARGS without CALL_OPS
> is already a supported arm64 configuration (GCC builds with
> CC_OPTIMIZE_FOR_SIZE do not satisfy the CALL_OPS select condition).
> 
> Drop the CALL_OPS requirement from the
> HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS select. Configurations that
> keep CALL_OPS (!CFI clang builds, and GCC builds without
> CC_OPTIMIZE_FOR_SIZE) are unchanged. CALL_OPS-less configurations
> take the ftrace_caller ops-dispatch path for out-of-range direct
> calls, trading the per-callsite fast path for working BPF
> trampolines; in-range attachments still branch directly with no
> overhead. GCC -Os builds also gain DIRECT_CALLS as a side effect.
> That is intended: s390 and loongarch already ship DIRECT_CALLS
> without any per-callsite fast path.
> 
> Assisted-by: Claude:unspecified
> Signed-off-by: Jose Fernandez (Anthropic) <jose.fernandez@linux.dev>
> ---
>   arch/arm64/Kconfig | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index fe60738e5943b..2cd7d536671c9 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -188,7 +188,7 @@ config ARM64
>   		if (GCC_SUPPORTS_DYNAMIC_FTRACE_WITH_ARGS || \
>   		    CLANG_SUPPORTS_DYNAMIC_FTRACE_WITH_ARGS)
>   	select HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS \
> -		if DYNAMIC_FTRACE_WITH_ARGS && DYNAMIC_FTRACE_WITH_CALL_OPS
> +		if DYNAMIC_FTRACE_WITH_ARGS
>   	select HAVE_DYNAMIC_FTRACE_WITH_CALL_OPS \
>   		if (DYNAMIC_FTRACE_WITH_ARGS && !CFI && \
>   		    (CC_IS_CLANG || !CC_OPTIMIZE_FOR_SIZE))
> 
Acked-by: Xu Kuohai <xukuohai@huawei.com>

