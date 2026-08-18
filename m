Received: from mta1.migadu.com (out-89.mta1.migadu.com [95.215.58.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D872427FB1C
	for <bpf@vger.kernel.org>; Tue, 18 Aug 2026 07:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787037551; cv=none; b=YgOjRGKyPgZDF1nTuIfXvjnT+3hiEOr9qNRkfpuamTOXh5bmvuoZQrba/nTm6usucR8UkwcHIplvoxsBVgu84SBxZv9oQa4YHwRxqNNjKMQTKOAvNf5z625qsgp6/TwL8Sv1DmzW2jPmIwONGerab0shObN/XNrlRfc+JHmR900=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787037551; c=relaxed/simple;
	bh=qijLpjB7Onakw0hE5/ojFQV2R7U8R9ea3OyclgmS1Z4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ULugN4E7KBjQmRWW4XZL57ih9nqGuN9wqJBcv9mH0D3X19kPifqQ3kMlZYG90fjbFSnLEWwsP0fNuWCgdpOZ6ZFVRKym7tSzY5AsRM0IBn/9ca7q59hd1sBuqMhAvEge2jNns7IMF6jXCgBW7Gcvq2AyLdyFUIWT0bQ4RgZW5Z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KEYu8zm2; arc=none smtp.client-ip=95.215.58.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KEYu8zm2"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=qijLpjB7Onakw0hE5/ojFQV2R7U8R9ea3OyclgmS1Z4=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787037547; v=1; x=1787642347;
 b=KEYu8zm23BhYK3QdyOXV2xedm7S71n4V2ufLoS7fchoPhv7gve2QJ6aLpM1PEa5gosvqq++5
 6PO7UxUxW9G2yf6g/qEZP/Tls5oHWZDhPzhBMVDFAgJEI/WI0IUzW/BIAUdFR5UCapjstrhIzUA
 w5sieojeAHk2gypJaPcKP+P0=
X-Envelope-To: bpf@vger.kernel.org
Received: from [10.22.64.46] (118.201.124.118)
	by smtp.migadu.com with ESMTPS id 2322ecc1f5850b8a;
	Tue, 18 Aug 2026 07:19:07 +0000
X-Migadu-Flow: FLOW_OUT
Message-ID: <c065e1e3-7d78-4098-901d-7cf257f3ce0e@linux.dev>
Date: Tue, 18 Aug 2026 15:19:02 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2] bpf: Fix stack out-of-bounds write in cgroup
 link update
To: Sanghyun Park <sanghyun.park.cnu@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: John Fastabend <john.fastabend@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Emil Tsalapatis <emil@etsalapatis.com>,
 Ihor Solodrai <ihor.solodrai@linux.dev>, Stanislav Fomichev
 <sdf@fomichev.me>, Pu Lehui <pulehui@huawei.com>,
 linux-kernel@vger.kernel.org
References: <20260818061021.2551771-2-sanghyun.park.cnu@gmail.com>
Content-Language: en-US
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <20260818061021.2551771-2-sanghyun.park.cnu@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 18/8/26 14:10, Sanghyun Park wrote:
> The cgroup link update path checks only the program type. Several cgroup
> hooks share a type while using different runtime contexts or verifier
> contracts. A UDP6 sock_addr program can therefore replace a UDP4 program
> and write beyond the four-byte ipc.addr context into adjacent fields of
> the stack-local struct ipcm_cookie. The same omission lets an LSM_MAC
> program replace an LSM_CGROUP program despite the incompatible return
> semantics.
> 
> Validate replacement programs against the link attach type. Use the
> existing per-type rules where applicable, and compare LSM
> expected_attach_type explicitly because both flavors share
> BPF_PROG_TYPE_LSM. Preserve legacy non-enforcing CGROUP_SKB
> ingress/egress updates.
> 
> CGROUP_SKB programs do not require CAP_NET_ADMIN when loaded. That
> permission is checked when the program is attached. Once the link exists,
> updates are controlled through its FD, so BPF_LINK_UPDATE does not check
> CAP_NET_ADMIN again. Keep this behavior and only validate the attach type
> during link update.
> 
> Fixes: 0c991ebc8c69 ("bpf: Implement bpf_prog replacement for an active bpf_cgroup_link")
> Signed-off-by: Sanghyun Park <sanghyun.park.cnu@gmail.com>
> ---
> v2:
>   - Extend validation from cgroup sock_addr programs to all cgroup program
>     types, including exact LSM attach flavors.
>   - Preserve legacy CGROUP_SKB ingress/egress replacement compatibility.
>   - Keep the CGROUP_SKB CAP_NET_ADMIN check on attach, not link update.
> v1: https://lore.kernel.org/r/20260805052858.2390918-3-sanghyun.park.cnu@gmail.com
> ---
>  kernel/bpf/syscall.c | 28 ++++++++++++++++++++++++----
>  1 file changed, 24 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 8d111da886553c..de7a8b46814648 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -4462,7 +4462,8 @@ attach_type_to_prog_type(enum bpf_attach_type attach_type)
>  }
>  
>  static int bpf_prog_attach_check_attach_type(const struct bpf_prog *prog,
> -					     enum bpf_attach_type attach_type)
> +					     enum bpf_attach_type attach_type,
> +					     bool check_cap_net_admin)

Seems not a good choice to use 'bool check_cap_net_admin' here.

Better to factor out a helper to check CAP_NET_ADMIN first? Like:

static int bpf_prog_attach_check(const struct bpf_prog *prog,
				 enum bpf_attach_type attach_type)
{
	/* ... */
	if (prog->type == BPF_PROG_TYPE_CGROUP_SKB &&
	    !bpf_token_capable(prog->aux->token, CAP_NET_ADMIN))
		return -EPERM;

	return bpf_prog_attach_check_attach_type(prog, attach_type);
}

Thanks,
Leon

>  [...]
