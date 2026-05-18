Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12ADD2882C9;
	Mon, 18 May 2026 11:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779105443; cv=none; b=MBq52wCaGkE11DZUO6pUqAA6MXOqHm3aor2VUF3XEsRomX4KgiilTXjQxvGkQYsIveVLVA5Wdbz/27ptxxYiToiUPLnr24kKfsyW1Lp7uPnroeoknZz6usWay2IbWzhxU/BQ6Up13rwPtjwGC4jGoOFKHrICdn7G0IT7PErzk/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779105443; c=relaxed/simple;
	bh=6ROGVadPwq5Q7Gz9WoMLBxVIVVNoZyNCKKg3PyKPaaU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=igjtdnXyeOU/uLRG4Q2Zh6rWN7YJlq7azLzCMVi8dQ/QxxQaXtV0odRMIdIymkTUS2JtuGzmDzz/6uEy75Yam2Vq+jMxrFmOtbInyzzof5kVdTIsYnh3Fv3VY7Eo6BSUKevcW39Xsvslk34xDLjozS6T7Lk93j3aWD7k79wUJLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KuB1KIqg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KuB1KIqg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19D26C2BCB8;
	Mon, 18 May 2026 11:57:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779105443;
	bh=6ROGVadPwq5Q7Gz9WoMLBxVIVVNoZyNCKKg3PyKPaaU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=KuB1KIqghdPy+qvB8a4BGNDu6xNalPP0oV8XWG/e2ciCg80o/WaGbPTsX/hWeK/9k
	 0EZt2y2sCPEMV0+Jb7JbI0ekQWKUby8jXo3vaamxUr/iUkKkp1tvUSQlkIcPHWlMsx
	 d5Ibsns/MgWUW9ECqB19gcPet6uFULJo00PyS0Sh8HNKxlz2lewT06uo/TmcSCJjuL
	 XukqYt/wvKqwFfAnUmoSWe5YmXEypqkmXx18W8/0g0rqJd6KRV26GF+CK6J32ze2gt
	 2vYG5u2R2kjKz15NPKK50cUQFNBQ0NmDh8Jr7rXHOs9vGQz+2WmbkjxVoZ1cSzGHnE
	 NzEO2QE/xoqOg==
Message-ID: <850e3709-2cb1-4a26-8546-745401423696@kernel.org>
Date: Mon, 18 May 2026 13:57:15 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/6] bpf: Add bpf_ktime_get_real_ns() kfunc
To: Jason Xing <kerneljasonxing@gmail.com>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 willemb@google.com, kuniyu@google.com, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com,
 memxor@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 jolsa@kernel.org, sdf@fomichev.me
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org,
 Jason Xing <kernelxing@tencent.com>, john.fastabend@gmail.com,
 Simon Sundberg <Simon.Sundberg@kau.se>, =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hy?=
 =?UTF-8?Q?gensen?= <toke@toke.dk>
References: <20260518082344.96647-1-kerneljasonxing@gmail.com>
 <20260518082344.96647-2-kerneljasonxing@gmail.com>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <20260518082344.96647-2-kerneljasonxing@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 18/05/2026 10.23, Jason Xing wrote:
> From: Jason Xing <kernelxing@tencent.com>
> 
> Currently BPF programs can obtain timestamps via bpf_ktime_get_ns(),
> which returns CLOCK_MONOTONIC time. However, the skb->tstamp field
> populated by the network stack uses ktime_get_real() which is in the
> CLOCK_REALTIME domain.
> 
> In the series, kernel reports the software/hardware timestamps through
> sockopt and then userspace bpf application gets them and calculate the
> delta only through an unified time unit.
> 
> However, prior to this, when a BPF program tries to measure RX packet
> delay by comparing skb->tstamp with bpf_ktime_get_ns(), the result
> is incorrect because the two clocks have different epochs.
> 
> Introduce a new BPF kfunc bpf_ktime_get_real_ns() that returns the
> current CLOCK_REALTIME time. This allows BPF programs to perform
> accurate delay calculations without clock domain mismatch issue.
> 

I support adding this helper, because have also hit this issue[1].
Our ugly workaround is to use the TAI clock and adjust for the current 
TAI offset.

[1] https://github.com/xdp-project/bpf-examples/tree/main/netstacklat

Cc Simon Sundberg <Simon.Sundberg@kau.se>

> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> ---
>   kernel/bpf/helpers.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 2bb60200c266..863645d096ef 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -2317,6 +2317,11 @@ void bpf_rb_root_free(const struct btf_field *field, void *rb_root,
>   
>   __bpf_kfunc_start_defs();
>   
> +__bpf_kfunc u64 bpf_ktime_get_real_ns(void)
> +{
> +	return ktime_get_real_fast_ns();
> +}
> +
>   /**
>    * bpf_obj_new() - allocate an object described by program BTF
>    * @local_type_id__k: type ID in program BTF
> @@ -4859,6 +4864,7 @@ BTF_ID_FLAGS(func, bpf_task_work_schedule_resume, KF_IMPLICIT_ARGS)
>   BTF_ID_FLAGS(func, bpf_dynptr_from_file)
>   BTF_ID_FLAGS(func, bpf_dynptr_file_discard)
>   BTF_ID_FLAGS(func, bpf_timer_cancel_async)
> +BTF_ID_FLAGS(func, bpf_ktime_get_real_ns)
>   BTF_KFUNCS_END(common_btf_ids)
>   
>   static const struct btf_kfunc_id_set common_kfunc_set = {

