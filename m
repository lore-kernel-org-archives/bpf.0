Received: from mta1.migadu.com (out-116.mta1.migadu.com [95.215.58.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D2E344B663
	for <bpf@vger.kernel.org>; Fri, 21 Aug 2026 10:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787307996; cv=none; b=uSUTcZJ+UzWbYsPtOcHyxXG2XurrenNrDKhYXJy8THN/3SI/pGVEWakl5i4Rdd03JuT81udmW9R3D9Nng0cq+/LezvwXM5eREl+LBoMSPey7F4lXLF1psIKtLo329Ojg771O7PousKjbzBCmOxiUFP0mnSYrJlwjH4K5it/cQZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787307996; c=relaxed/simple;
	bh=AZtGpB8cAixSCG1gYkxZYk7i2Aa5q842H31VCI3h/xY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HpSNfpW+HMARM90iUyPDaS0qq+x0B7WF1w4fuBbaXBSwrWMRZCKGtZkBAGjOAstKZrwNJJb75piTtB4VGmo6BlKvfANvr/T+TBTMZ93soOn4lg3de1nwT3oflj+qoYk0XuNtlpsmZe1AssNm+Bexf9TyI92loxxxvTjJT3uuTTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LVeXG4pU; arc=none smtp.client-ip=95.215.58.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LVeXG4pU"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=AZtGpB8cAixSCG1gYkxZYk7i2Aa5q842H31VCI3h/xY=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787307986; v=1; x=1787912786;
 b=LVeXG4pUCxrOEUuwxSLNewDPJxIR2+HStDkek43mbsm/qSVNdEVVVKnpaPSkH1C4aejdjZdR
 Ke1tO7thsFJgi7S+t+oDmhFilXRzW+M5WcsXwtNE9qhQEmL0hQZmvASc37x+NZjVcGSnPMSykPV
 Le3SteHUO5vpoGUHK77zjgyQ=
X-Envelope-To: bpf@vger.kernel.org
Received: from [10.22.64.46] (118.201.124.118)
	by smtp.migadu.com with ESMTPS id b12b57000b2c7d09;
	Fri, 21 Aug 2026 10:26:16 +0000
X-Mizu-Trace-ID: b12b57000b2c7d09
X-Migadu-Flow: FLOW_OUT
Message-ID: <b380f7e7-2e0e-4c8c-9a70-e6a577d268cf@linux.dev>
Date: Fri, 21 Aug 2026 18:26:11 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3] bpf: Fix stack out-of-bounds write in cgroup
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
References: <20260821084726.3769957-2-sanghyun.park.cnu@gmail.com>
Content-Language: en-US
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <20260821084726.3769957-2-sanghyun.park.cnu@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 21/8/26 16:47, Sanghyun Park wrote:
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

Any issue of checking CAP_NET_ADMIN for BPF_LINK_UPDATE?

If no, checking CAP_NET_ADMIN for BPF_LINK_UPDATE looks okay.

> 
> Fixes: 0c991ebc8c69 ("bpf: Implement bpf_prog replacement for an active bpf_cgroup_link")
> Signed-off-by: Sanghyun Park <sanghyun.park.cnu@gmail.com>
> ---
> v3:
>   - Factor the CGROUP_SKB CAP_NET_ADMIN check into an attach-only helper.
> v2: https://lore.kernel.org/r/20260818061021.2551771-2-sanghyun.park.cnu@gmail.com
>   - Extend validation from cgroup sock_addr programs to all cgroup program
>     types, including exact LSM attach flavors.
>   - Preserve legacy CGROUP_SKB ingress/egress replacement compatibility.
>   - Keep the CGROUP_SKB CAP_NET_ADMIN check on attach, not link update.
> v1: https://lore.kernel.org/r/20260805052858.2390918-3-sanghyun.park.cnu@gmail.com
> ---
>  kernel/bpf/syscall.c | 41 ++++++++++++++++++++++++++++++++---------
>  1 file changed, 32 insertions(+), 9 deletions(-)
> 
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 6874ba1424af05..dfea337ff25ea5 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -4483,12 +4483,6 @@ static int bpf_prog_attach_check_attach_type(const struct bpf_prog *prog,
>  	case BPF_PROG_TYPE_SK_LOOKUP:
+	case BPF_PROG_TYPE_LSM:

Add a 'case' here instead of checking it in link_update()?

And, a selftest is needed to verify the issue and the fix.

Thanks,
Leon

>  		return attach_type == prog->expected_attach_type ? 0 : -EINVAL;
> [...]
