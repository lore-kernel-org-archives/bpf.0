Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7DF4433BD4;
	Mon,  3 Aug 2026 19:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785783649; cv=none; b=GbtpGgtjNYxTqh02kptTNkgCzmgFOSISPA/f86g85U/YdmlCegBC380Uzq5MsPNdNBQJH8Q4DFX0o2OENrOgtB5US8RkDwieMoDYS6xE1YiIY2ViMNVrqVDTvH/agz1njAvOQWWhjEzfcwHp6qRiOedv7U6HcfGqhixxskmO+qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785783649; c=relaxed/simple;
	bh=gfW3zLBWcf63HpKqSIgLaax56M6wiTtHTP2PxlqGlqE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PZVUV/OE1ZkNgIC3hUwh7asDryL/JwwbMtXuCxgtIyk11d2O024bUlr9moxt/rhGlYkd9A6W0tSgi18cGc1Y8vsehdg+KWNRqS/DodzY6Dh/m6m8zn/WiSNENfRdgTgZtXAjuPbpfMz7ERQyfAWMhWRS8p2+xUAmkgL3FL1/k18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=AJmCPVSX; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="AJmCPVSX"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=u07MDJ2rdK5GAVue/ThEStaSUIWdbcw+D0Wtb3VsepE=; b=AJmCPVSXYIJOuix83e6Pu221Ny
	ZqCHFL2R0Dio5OjiKe49K8NJ+J9LZM1s9BPjmw/jt1jHkOYl37qOyCgMEcHfq7aDRbMCAwZB8jFyy
	tvMmMOM8fxEXisSN00UwD7irs/6/ygaeplRXqIwYkTRqFHRlOqCxxuBSWq5qfp4lETGuR4aE7I9/H
	3uG1Alzu/XVoC59FdNbDWVq2tyoG7cxh2z+sAQN9OemY1Aj2DUNlh0F4nnHvX51TJ8idoAW4T5Vq/
	IlkXTgRM/7i/Mepxt1RVgDsdA5p//222I5ORtcsq5wX5HgPKLeHDrsxTGQKH7lSQfRpJYbxC0i4W4
	gCWR8Ajw==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1wqxtP-0008Cz-33;
	Mon, 03 Aug 2026 21:00:07 +0200
Received: from localhost ([127.0.0.1])
	by sslproxy05.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1wqxtO-0007VN-2G;
	Mon, 03 Aug 2026 21:00:06 +0200
Message-ID: <da7357fe-9d64-4e9c-a0f6-573a9761c8b2@iogearbox.net>
Date: Mon, 3 Aug 2026 21:00:06 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf v4] bpf: Fix UAF when reading prog type in
 bpf_mprog_link
To: Pu Lehui <pulehui@huaweicloud.com>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>,
 Yonghong Song <yonghong.song@linux.dev>, Song Liu <song@kernel.org>,
 Jiri Olsa <jolsa@kernel.org>, Emil Tsalapatis <emil@etsalapatis.com>,
 Pu Lehui <pulehui@huawei.com>
References: <20260728074223.2831773-1-pulehui@huaweicloud.com>
Content-Language: en-US
From: Daniel Borkmann <daniel@iogearbox.net>
Autocrypt: addr=daniel@iogearbox.net; keydata=
 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
In-Reply-To: <20260728074223.2831773-1-pulehui@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28081/Mon Aug  3 08:25:52 2026)

On 7/28/26 9:42 AM, Pu Lehui wrote:
> From: Pu Lehui <pulehui@huawei.com>
> 
> In bpf_mprog_link, the code currently allows a user to pass an abnormal
> non-netkit or non-tcx link via relative_fd. If a concurrent
> BPF_LINK_UPDATE is performed on this abnormal link before dereferencing
> link->prog->type in bpf_mprog_link(), it can trigger a UAF issue.
> 
> CPU0                                      CPU1
> netkit_link_prog_attach
> bpf_mprog_attach
> bpf_mprog_tuple_relative
> bpf_mprog_link
>    /* non-netkit or non-tcx link */
>    link = bpf_link_get_from_fd(id_or_fd);
>                                            BPF_LINK_UPDATE on relative link
>                                            ...
>                                            old_prog = xchg(&link->link.prog, new_prog);
>                                            bpf_prog_put(old_prog);
>    if (type && link->prog->type != type) <-- trigger UAF
> 
> The reason for the UAF is that each subsystem provides its own
> protection for link->prog. Since there is no cross subsystem protection
> (if not considering the RCU of prog tear down), dereferencing the prog
> of an anchor link that does not belong to the current subsystem is not
> safe: it may have been freed.
> 
> To resolve this, we access link->prog under RCU protection to safely
> fetch the pointer and guarantee its lifetime during the type check.
> Meanwhile, add a comment explaining that when ptype == UNSPEC in
> bpf_mprog_detach, it acts as a wildcard.
> 
> Fixes: 053c8e1f235d ("bpf: Add generic attach/detach/query API for multi-progs")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
> Signed-off-by: Pu Lehui <pulehui@huawei.com>
> ---
> v4:
> - Access prog->type under rcu protection to simplify the repair logic,
>    and let unconditional detachment make sense when the bare prog or
>    link->prog being detached is NULL.
> - Add Reviewed-by tag by Emil.
> - Separate from patchset [0]. (Andrii)
> 
> Link: https://lore.kernel.org/bpf/f87b53c0-8f00-45a6-82db-8242fa9b143f@huaweicloud.com [0]
> 
> v3: https://lore.kernel.org/bpf/20260722072326.1545677-3-pulehui@huaweicloud.com
> - BPF_F_LINK flag set means the relative id_or_fd is a link, not the object being
>    attached. We can not get the link while attach a bare prog with relative link.
>    So passing expected link type from callers of bpf_mprog_attach/detach. (Sashiko)
> - Add comment to explain that why ptype == UNSPEC. (Emil)
> 
> v2: https://lore.kernel.org/bpf/20260721041048.1394085-3-pulehui@huaweicloud.com
> - Improve commit msg for patch 2. (Amery)
> 
> v1: https://lore.kernel.org/bpf/20260720134547.1289964-3-pulehui@huaweicloud.com
> 
>   kernel/bpf/mprog.c | 17 +++++++++++++----
>   1 file changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/bpf/mprog.c b/kernel/bpf/mprog.c
> index 1394168062e8..af3e6c1c6a1f 100644
> --- a/kernel/bpf/mprog.c
> +++ b/kernel/bpf/mprog.c
> @@ -10,6 +10,8 @@ static int bpf_mprog_link(struct bpf_tuple *tuple,
>   {
>   	struct bpf_link *link = ERR_PTR(-EINVAL);
>   	bool id = flags & BPF_F_ID;
> +	bool type_mismatch = false;
> +	struct bpf_prog *prog;
>   
>   	if (id)
>   		link = bpf_link_by_id(id_or_fd);
> @@ -17,13 +19,20 @@ static int bpf_mprog_link(struct bpf_tuple *tuple,
>   		link = bpf_link_get_from_fd(id_or_fd);
>   	if (IS_ERR(link))
>   		return PTR_ERR(link);
> -	if (type && link->prog->type != type) {
> +
> +	rcu_read_lock();
> +	prog = READ_ONCE(link->prog);
> +	if (!prog || (type && prog->type != type))
> +		type_mismatch = true;
> +	rcu_read_unlock();

Hm, what about progs under rcu_read_lock_trace cases, wouldn't the UAF
still be there?

Even though the diff is smaller, I'd kind of lean towards link->type
testing since this addresses the underlying issue and avoids touching
the prog completely.. do you want me to look into it and also add a
BPF selftest to it as patch 2/2?

> +	if (type_mismatch) {
>   		bpf_link_put(link);
>   		return -EINVAL;
>   	}
>   
>   	tuple->link = link;
> -	tuple->prog = link->prog;
> +	tuple->prog = prog;
>   	return 0;
>   }
>   
> @@ -343,8 +352,8 @@ int bpf_mprog_detach(struct bpf_mprog_entry *entry,
>   	if (!bpf_mprog_total(entry))
>   		return -ENOENT;
>   	ret = bpf_mprog_tuple_relative(&rtuple, id_or_fd, flags,
> -				       prog ? prog->type :
> -				       BPF_PROG_TYPE_UNSPEC);
> +				       /* Use UNSPEC as wildcard when prog is NULL */
> +				       prog ? prog->type : BPF_PROG_TYPE_UNSPEC);
>   	if (ret)
>   		return ret;
>   	if (dtuple.prog) {

