Received: from mta0.migadu.com (out-148.mta0.migadu.com [91.218.175.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38AC74B95D0
	for <bpf@vger.kernel.org>; Fri,  2 Oct 2026 13:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790949024; cv=none; b=sKQRIOwXok2Z9QVjx+qiG8mTtiAK6m2inePgP5FGPKcEiIEkQnM5HciJKKPdHxuySEyGmalKz+UfttICJkFs2/v7nTx1S+tt7+GyrObYpmqvBryXZlAPrL8eGRHbyIx5P14SyEivvFGO5wMv91sEm3J8ekVbR6e97ecD7d4LZK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790949024; c=relaxed/simple;
	bh=C/wAt1LQIExSHw4S8KqSvpcjB37pdcwAu4E/VAWQEvg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dJeUDrm0QWy+rZCBPJb2itFIch7dqrG9j7VOcHHfoN1Ba/aefmbuzqQ+yOUcj/oqDJL6YhcOU0gmESjAqSRsDE3EF9wlZevqS5fDaxTyj1HvGs2D4k0ObPRr/c+EvetES47m9I3nnvOK+8+deMAMTBQDmW1zoKVHyJ46yjnQG0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=uY3CnhBy; arc=none smtp.client-ip=91.218.175.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uY3CnhBy"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=C/wAt1LQIExSHw4S8KqSvpcjB37pdcwAu4E/VAWQEvg=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790949019; v=1; x=1791553819;
 b=uY3CnhByVv7Q4SHLKgnSQNU6hz6LiSHkgP76iBFt9q2Z8Nt+oerDM73/8MuGUfSC461L4oOF
 ZU15E4vag2ka19ShFfme45+gZjy0ZVVhx5NPaBsHZTfQoycmQbgXs9OUOhYOWj+RL+q0agi/+BF
 im8EmjyLIyppVQATYCgx9cyI=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 6242a16857386e04;
	Fri, 02 Oct 2026 13:50:12 +0000
X-Mizu-Trace-ID: 6242a16857386e04
X-Migadu-Flow: FLOW_OUT
Message-ID: <da2773b2-1ed2-40ef-aefa-0e754cdb2f9d@linux.dev>
Date: Fri, 2 Oct 2026 21:50:02 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] selftests/bpf: Use the new NMI_BITS definition
To: Boqun Feng <boqun@kernel.org>, Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>,
 Waiman Long <longman@redhat.com>, Gary Guo <gary@garyguo.net>,
 Alice Ryhl <aliceryhl@google.com>, Lyude Paul <lyude@redhat.com>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>,
 Miguel Ojeda <ojeda@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
 Thomas Gleixner <tglx@kernel.org>, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Emil Tsalapatis <emil@etsalapatis.com>,
 Ihor Solodrai <ihor.solodrai@linux.dev>, Shuah Khan <shuah@kernel.org>,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Shrikanth Hegde <sshegde@linux.ibm.com>, Alexei Starovoitov <ast@kernel.org>
References: <20261002102923.45846-1-boqun@kernel.org>
Content-Language: en-US
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <20261002102923.45846-1-boqun@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2026/10/2 18:29, Boqun Feng wrote:
> The definition of NMI_BITS was out of sync after the introduction of
> HAS_SEPARATE_PREEMPT_RESCHED_BITS, hence adjust it.
> 
> Reported-by: Shrikanth Hegde <sshegde@linux.ibm.com>
> Fixes: 3b0e2a22d408 ("preempt: Introduce HAS_SEPARATE_PREEMPT_RESCHED_BITS")
> Reviewed-by: Shrikanth Hegde <sshegde@linux.ibm.com>
> Cc: Leon Hwang <leon.hwang@linux.dev>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Signed-off-by: Boqun Feng <boqun@kernel.org>

lgtm,

Acked-by: Leon Hwang <leon.hwang@linux.dev>

One nit below.

> ---
> v2: https://lore.kernel.org/lkml/20261001082519.16195-4-boqun@kernel.org/
> v2 -> v3:
> 
> * Add Fixes tag.
> * Add CONFIG_HAS_SEPARATE_PREEMPT_RESCHED_BITS weak symbol because
>   CONFIG_* is not available in bpf programs.
> 
> 
>  tools/testing/selftests/bpf/bpf_experimental.h | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/bpf/bpf_experimental.h b/tools/testing/selftests/bpf/bpf_experimental.h
> index 2893bf06ff25..a09448347966 100644
> --- a/tools/testing/selftests/bpf/bpf_experimental.h
> +++ b/tools/testing/selftests/bpf/bpf_experimental.h
> @@ -367,11 +367,16 @@ extern int bpf_cgroup_read_xattr(struct cgroup *cgroup, const char *name__str,
>  extern int bpf_sock_read_xattr(struct socket *sock, const char *name__str,
>  			       struct bpf_dynptr *value_p) __weak __ksym;
>  
> +extern bool CONFIG_HAS_SEPARATE_PREEMPT_RESCHED_BITS __kconfig __weak;
> +
> +/* A trivial macro to make NMI_BITS exactly the same as in <linux/preempt.h> */
> +#define IS_ENABLED(cfg)	(cfg)

NIT: change this to ((cfg) ? 1 : 0) to match IS_ENABLED() semantics.

Thanks,
Leon

> +
>  #define PREEMPT_BITS	8
>  #define SOFTIRQ_BITS	8
>  #define HARDIRQ_DISABLE_BITS	8
>  #define HARDIRQ_BITS	4
> -#define NMI_BITS	1
> +#define NMI_BITS	(1 + 3*IS_ENABLED(CONFIG_HAS_SEPARATE_PREEMPT_RESCHED_BITS))
>  
>  #define PREEMPT_SHIFT	0
>  #define SOFTIRQ_SHIFT	(PREEMPT_SHIFT + PREEMPT_BITS)

