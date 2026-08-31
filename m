Received: from mta1.migadu.com (out-138.mta1.migadu.com [95.215.58.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DC2A37C10D
	for <bpf@vger.kernel.org>; Mon, 31 Aug 2026 14:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788187721; cv=none; b=RQnYOuvpwp1zEpZnWjo5NlStBHi4SRTtD+f2NwTVmq0JdXaaC679omY4ueZUEfiKSSmCJSeURsB+FTSKDu+CgDvbFH+dnnTHPuYbqTgkpSdll4pnnvK12frxKJ4aA7ybaCmu6SCDca4S+nO2RR8ANK0fWTnzpNxFO5ygM8I0VO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788187721; c=relaxed/simple;
	bh=XlUfOP+W//enh+au1jMIgUYjAAT9ofj9xy46RbawLkM=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=g1Kz14Me6fjkeMFZ+8MuF/1Iy9uccPgMFMmt6QvpYn02tpf9wKA7uOpixf9fN5Hz/zDLLijC23+hv2J+epR5Kag/7Isehhi/X4k3j4jOlMd1ZcjQmzmiachF39O/qP0GdXtEtVktzckdTnbwP9JaP/TkxRWNbmYsUvmvBAC/hqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KOQZs/cT; arc=none smtp.client-ip=95.215.58.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KOQZs/cT"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=XlUfOP+W//enh+au1jMIgUYjAAT9ofj9xy46RbawLkM=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788187716; v=1; x=1788792516;
 b=KOQZs/cTGb4U8UmqMs0ShP7qgjoQlg7zu/EKDKqrHFVhyuB2/ybU1eYZBOgiE35nPnfCDAfm
 uP3MO+4yXldRywZtygcb4AiGrckKh7muxE03VeNieokMwo7lzHTDzp3m4PYIk0ZzsCC8wHwK5iW
 8FznH6YeuVaG3/a32bMDiOfs=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id bbff91df0d4f5654;
	Mon, 31 Aug 2026 14:48:36 +0000
X-Mizu-Trace-ID: bbff91df0d4f5654
X-Migadu-Flow: FLOW_OUT
Message-ID: <61e8bf2e-b2aa-4f41-9861-1b075cdc8d16@linux.dev>
Date: Mon, 31 Aug 2026 22:48:29 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Leon Hwang <leon.hwang@linux.dev>
Subject: Re: [PATCH bpf-next v4 1/2] bpf: Validate program attach type during
 link update
To: Sanghyun Park <sanghyun.park.cnu@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: John Fastabend <john.fastabend@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Emil Tsalapatis <emil@etsalapatis.com>,
 Ihor Solodrai <ihor.solodrai@linux.dev>, Shuah Khan <shuah@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Pu Lehui <pulehui@huawei.com>,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20260831023918.1857658-1-sanghyun.park.cnu@gmail.com>
Content-Language: en-US
In-Reply-To: <20260831023918.1857658-1-sanghyun.park.cnu@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2026/8/31 10:39, Sanghyun Park wrote:
> Cgroup link updates compare only the program type. Programs verified
> for different hooks can share a type, so a UDP6 sock_addr program can
> replace a UDP4 program and write beyond the four-byte ipc.addr field in
> the stack-local struct ipcm_cookie. The same gap permits incompatible
> LSM_MAC and LSM_CGROUP replacements.
> 
> Validate every replacement program against the link attach type before
> dispatching to the link-specific update operation. Keep the CGROUP_SKB
> CAP_NET_ADMIN check at initial attach so pinned or delegated link FDs can
> still be updated after a capability drop.
> 
> Fixes: 0c991ebc8c69 ("bpf: Implement bpf_prog replacement for an active bpf_cgroup_link")
> Signed-off-by: Sanghyun Park <sanghyun.park.cnu@gmail.com>

One nit below, others lgtm:

Acked-by: Leon Hwang <leon.hwang@linux.dev>

> ---
> v4:
>   - Validate every program link update through the shared attach-type helper.
>   - Fold the LSM attach-flavor check into that helper.
>   - Keep the CGROUP_SKB permission check in the attach-only wrapper and rename
>     the wrapper to describe that role.
>   - Follow the preferred BPF multi-line comment style.
>   - Add focused regression selftests as patch 2/2.
> v3: https://lore.kernel.org/r/20260821084726.3769957-2-sanghyun.park.cnu@gmail.com
>   - Factor the CGROUP_SKB CAP_NET_ADMIN check into an attach-only helper.
> v2: https://lore.kernel.org/r/20260818061021.2551771-2-sanghyun.park.cnu@gmail.com
>   - Extend validation from cgroup sock_addr programs to all cgroup program
>     types, including exact LSM attach flavors.
>   - Preserve legacy CGROUP_SKB ingress/egress replacement compatibility.
>   - Keep the CGROUP_SKB CAP_NET_ADMIN check on attach, not link update.
> v1: https://lore.kernel.org/r/20260805052858.2390918-3-sanghyun.park.cnu@gmail.com
> ---
>  kernel/bpf/syscall.c | 31 ++++++++++++++++++++++---------
>  1 file changed, 22 insertions(+), 9 deletions(-)
> 
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 6874ba1424af..84823149dffa 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -4481,14 +4481,9 @@ static int bpf_prog_attach_check_attach_type(const struct bpf_prog *prog,
>  	case BPF_PROG_TYPE_CGROUP_SOCK_ADDR:
>  	case BPF_PROG_TYPE_CGROUP_SOCKOPT:
>  	case BPF_PROG_TYPE_SK_LOOKUP:
> +	case BPF_PROG_TYPE_LSM:
>  		return attach_type == prog->expected_attach_type ? 0 : -EINVAL;
>  	case BPF_PROG_TYPE_CGROUP_SKB:
> -		if (!bpf_token_capable(prog->aux->token, CAP_NET_ADMIN))
> -			/* cg-skb progs can be loaded by unpriv user.
> -			 * check permissions at attach time.
> -			 */
> -			return -EPERM;
> -
>  		ptype = attach_type_to_prog_type(attach_type);
>  		if (prog->type != ptype)
>  			return -EINVAL;
> @@ -4542,6 +4537,20 @@ static int bpf_prog_attach_check_attach_type(const struct bpf_prog *prog,
>  	}
>  }
>  
> +static int bpf_prog_attach_check_perm(const struct bpf_prog *prog,
> +				      enum bpf_attach_type attach_type)
> +{
> +	/*
> +	 * CGROUP_SKB programs can be loaded by unprivileged users, so check
> +	 * permissions at attach time.
> +	 */
> +	if (prog->type == BPF_PROG_TYPE_CGROUP_SKB &&
> +	    !bpf_token_capable(prog->aux->token, CAP_NET_ADMIN))
> +		return -EPERM;
> +
> +	return bpf_prog_attach_check_attach_type(prog, attach_type);
> +}
> +
>  static bool is_cgroup_prog_type(enum bpf_prog_type ptype, enum bpf_attach_type atype,
>  				bool check_atype)
>  {
> @@ -4606,7 +4615,7 @@ static int bpf_prog_attach(const union bpf_attr *attr)
>  	if (IS_ERR(prog))
>  		return PTR_ERR(prog);
>  
> -	if (bpf_prog_attach_check_attach_type(prog, attr->attach_type)) {
> +	if (bpf_prog_attach_check_perm(prog, attr->attach_type)) {
>  		bpf_prog_put(prog);
>  		return -EINVAL;
>  	}
> @@ -5805,8 +5814,8 @@ static int link_create(union bpf_attr *attr, bpfptr_t uattr)
>  	if (IS_ERR(prog))
>  		return PTR_ERR(prog);
>  
> -	ret = bpf_prog_attach_check_attach_type(prog,
> -						attr->link_create.attach_type);
> +	ret = bpf_prog_attach_check_perm(prog,
> +					 attr->link_create.attach_type);

NIT: fold into one line. 100 chars are allowed per line.

Thanks,
Leon

>  	if (ret)
>  		goto out;
>  
> @@ -5968,6 +5977,10 @@ static int link_update(union bpf_attr *attr)
>  		goto out_put_progs;
>  	}
>  
> +	ret = bpf_prog_attach_check_attach_type(new_prog, link->attach_type);
> +	if (ret)
> +		goto out_put_progs;
> +
>  	if (link->ops->update_prog)
>  		ret = link->ops->update_prog(link, new_prog, old_prog);
>  	else

