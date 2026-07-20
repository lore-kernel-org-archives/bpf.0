Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B1BB417BE2
	for <bpf@vger.kernel.org>; Mon, 20 Jul 2026 18:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784573076; cv=none; b=rWc9aFFVa8UQX5B8NIKATyQd0ky6o0qRz6Vfl4gAWpr1JQlHWrnyr80evsLA2YdaaW9EiQoxLB7K3vSCXrndrwzrc4vT5enKDAYbZto7BofWJknw1JPZT+bghQL74gH8tSa4bbCZOX08ZzgCZ7GbQaUkegZpMn8YQZINELussQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784573076; c=relaxed/simple;
	bh=2L2fv/rRlQ7gXsqSpb4UNsGxj75C744R/uNr4AqWByk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oK4c2Zdj6pEJp79R7aRMSJGJ+/SK318mIiYbyZfj8ni43ouMS/97wJ3Pqy5WLZBqBKgy16PAEJtkzpAU9XKOp0osvkiBevfXBPX1WANlpl08Q7j4l7aey1GlNlLSDVBJsS4wFn9ffMsoOrmPATMlAcZYqsOgrFCzVsNgrlchlRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qSpVrccG; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qSpVrccG"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2ceb096e675so103651135ad.0
        for <bpf@vger.kernel.org>; Mon, 20 Jul 2026 11:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784573075; x=1785177875; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aASqcmVgH1IHSjKyVpZV3aEHq+SHY3BNiJAYIynxciA=;
        b=qSpVrccGvQS7zE5r981XwhOxmrYGCFN2KZ8gmiY1X228J/M3oy7gKMoV5W5GOQ1icv
         HVMI3A5Y19DAF4gV/a9lbg8zL8TWeW/4P8s+eXv42Ei/tsfDwLHONEISADJGn9gYC/Mf
         AQ6dzGFmYZFi0KpRRISaT6aZBDWXRZNFNHlVO+FwDvvZKFBnA+QGdxroQlnFqN5gAeH0
         0XORlfKxapA2m63365kCeBA5mmrTUf1F58eYILqGs38fCSTnDkNQBN8DYovF6QTvDhtv
         /hmASv0hloJT0V7WPqcx+CvGAx/5GKDGeXdv4AQ2ixr8RC4Cpm06Sd4sBrS8isWJV87Z
         P5FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784573075; x=1785177875;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aASqcmVgH1IHSjKyVpZV3aEHq+SHY3BNiJAYIynxciA=;
        b=E2Rq+b02P0vMkqX6weq3O1RNCqAULd/5LnLtAz09tcqaimNkLL/1pMsjmZ71poO2hA
         lDXTD448ypMpy0tRfz18vE9+8k7z5/8CRk7bkyd59YKVMufOEXNKrx3V/fzl/oJeJ5aK
         x/kils5XdGWlUn8sYXS7seftoVRI+mQGq+PNwXl4qWxTH1MSVQOkwyi678AnQlGmDGhV
         CvaNdD/XvnQrP4l/9vRoSq0F/cumtq36AYvD2F4wB8VJmPrnXNokkS7beDrPuR8jv3n4
         sDwtBSdTADU2JmYn9VMOYT5rTdHE+E4dYno6v4uw5OrZG/JTnE1ChSwNu57tgEOkm+RS
         YsSA==
X-Forwarded-Encrypted: i=1; AHgh+Rqx5J65vq4wbRTf41lFw+gVxMoe9LbehZD8l22MO89T9bE8mkmOwr4aBMtBzAvpeDf7eqA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjOxRxj5iUx5pPiEyJwHzmiAzok7EGeUNAwlUfsDSr57SiWEv9
	8EhPp5OMEl4SbNGW7k8DNnTrgkwSB9eT26UVNaESmzHe7vZFzO6BkTmU
X-Gm-Gg: AR+sD12SSfXD6d0xNgU27Td6tEgoaL1QPH52CdUH3fGQZUm8qMGqdWqWOxdj+H03myU
	27tfaeinbsQQQ9bBQyBFmWsdpbEbJZTxbEhJlvzRox4mWABuapbiuS029JUyKOlYJ+433mxWJNU
	Jv7lGXxE9/VSdNps5Iv3NKbqEUxXS52K4Ek8NIV+dCj6DjEdIzmjuGj8rmEVc2xhVzWTLJ2HCtt
	JURq+Xnthf5bXjzoN6X6buBKzcrKRIAUs+NPhen1ls0Mar5C4jdAW2oM+4XGbYt1LkkWVKJqOCv
	QrU8oIcAOlBO3vTzkrgYATah/cL87T7PrPvlz7AA9rbC8D//EisSTNFAef9q6WY053qcNBlp0l2
	HBOR3JMX7jxFX0OlyFyIKGvAVmmKFI1bDJf39y9TbL5owjt08WPfEar10ynPccskDsVL9qxSQcc
	0Xo+0pvDybB4DwYVicDJQ=
X-Received: by 2002:a17:903:184d:b0:2cc:d6de:d597 with SMTP id d9443c01a7336-2cf348332bamr158556905ad.7.1784573074798;
        Mon, 20 Jul 2026 11:44:34 -0700 (PDT)
Received: from [192.168.1.77] ([50.47.108.115])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf344bd3aesm61347835ad.26.2026.07.20.11.44.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jul 2026 11:44:34 -0700 (PDT)
Message-ID: <4b343a35-45a2-40c2-a27d-36998688f5d7@gmail.com>
Date: Mon, 20 Jul 2026 11:44:33 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf v4 2/4] bpf: Fix UAF due to missing link type check in
 mprog
To: Pu Lehui <pulehui@huaweicloud.com>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>,
 Yonghong Song <yonghong.song@linux.dev>, Song Liu <song@kernel.org>,
 Jiri Olsa <jolsa@kernel.org>, Emil Tsalapatis <emil@etsalapatis.com>,
 Pu Lehui <pulehui@huawei.com>
References: <20260720134547.1289964-1-pulehui@huaweicloud.com>
 <20260720134547.1289964-3-pulehui@huaweicloud.com>
Content-Language: en-US
From: Amery Hung <ameryhung@gmail.com>
In-Reply-To: <20260720134547.1289964-3-pulehui@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7/20/26 6:45 AM, Pu Lehui wrote:
> From: Pu Lehui <pulehui@huawei.com>
> 
> In bpf_mprog_link, the code does not check the link->type first before
> dereferencing link->prog->type. This missing validation allows a user to
> pass an abnormal non-netkit or non-tcx link via relative_fd. If do
> BPF_LINK_UPDATE on the abnormal link, it can trigger a UAF issue.
> 
> CPU0                                      CPU1
> netkit_link_prog_attach
> bpf_mprog_attach
> bpf_mprog_tuple_relative
> bpf_mprog_link
>    link = bpf_link_get_from_fd(id_or_fd);
>                                            BPF_LINK_UPDATE
>                                            ...
>                                            old_prog = xchg(&link->link.prog, new_prog);
>                                            bpf_prog_put(old_prog);
>    if (type && link->prog->type != type) <-- trigger UAF
> 
> Fix this by strictly validate link->type in bpf_mprog_link against the
> expected link type. bpf_mprog_tuple_relative is also adjusted to accept
> and pass down the expected link type.
> 
> Fixes: 053c8e1f235d ("bpf: Add generic attach/detach/query API for multi-progs")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Signed-off-by: Pu Lehui <pulehui@huawei.com>

Reviewed-by: Amery Hung <ameryhung@gmail.com>

The message can be improved. The reason for the UAF is that each 
subsystem provides its own protection for link->prog. Since there is no 
cross subsystem protection (if not considering the RCU of prog tear 
down), dereferencing the prog of an anchor link that does not belong to 
the current subsystem is not safe: it may have been freed. Therefore, we
need to validate link->type to reject foreign anchors.

There are also some grammar errors:
If do -> If doing
strictly validate -> strictly validating.

> ---
>   kernel/bpf/mprog.c | 15 ++++++++++-----
>   1 file changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/bpf/mprog.c b/kernel/bpf/mprog.c
> index 1394168062e8..367f8f10da0a 100644
> --- a/kernel/bpf/mprog.c
> +++ b/kernel/bpf/mprog.c
> @@ -6,7 +6,7 @@
>   
>   static int bpf_mprog_link(struct bpf_tuple *tuple,
>   			  u32 id_or_fd, u32 flags,
> -			  enum bpf_prog_type type)
> +			  enum bpf_link_type type)
>   {
>   	struct bpf_link *link = ERR_PTR(-EINVAL);
>   	bool id = flags & BPF_F_ID;
> @@ -17,7 +17,7 @@ static int bpf_mprog_link(struct bpf_tuple *tuple,
>   		link = bpf_link_get_from_fd(id_or_fd);
>   	if (IS_ERR(link))
>   		return PTR_ERR(link);
> -	if (type && link->prog->type != type) {
> +	if (type && link->type != type) {
>   		bpf_link_put(link);
>   		return -EINVAL;
>   	}
> @@ -52,21 +52,22 @@ static int bpf_mprog_prog(struct bpf_tuple *tuple,
>   
>   static int bpf_mprog_tuple_relative(struct bpf_tuple *tuple,
>   				    u32 id_or_fd, u32 flags,
> -				    enum bpf_prog_type type)
> +				    enum bpf_link_type ltype,
> +				    enum bpf_prog_type ptype)
>   {
>   	bool link = flags & BPF_F_LINK;
>   	bool id = flags & BPF_F_ID;
>   
>   	memset(tuple, 0, sizeof(*tuple));
>   	if (link)
> -		return bpf_mprog_link(tuple, id_or_fd, flags, type);
> +		return bpf_mprog_link(tuple, id_or_fd, flags, ltype);
>   	/* If no relevant flag is set and no id_or_fd was passed, then
>   	 * tuple link/prog is just NULLed. This is the case when before/
>   	 * after selects first/last position without passing fd.
>   	 */
>   	if (!id && !id_or_fd)
>   		return 0;
> -	return bpf_mprog_prog(tuple, id_or_fd, flags, type);
> +	return bpf_mprog_prog(tuple, id_or_fd, flags, ptype);
>   }
>   
>   static void bpf_mprog_tuple_put(struct bpf_tuple *tuple)
> @@ -243,6 +244,8 @@ int bpf_mprog_attach(struct bpf_mprog_entry *entry,
>   		return -EEXIST;
>   	ret = bpf_mprog_tuple_relative(&rtuple, id_or_fd,
>   				       flags & ~BPF_F_REPLACE,
> +				       link ? link->type :
> +				       BPF_LINK_TYPE_UNSPEC,

nit: keep it in a line. It is well under 100 cols.

>   				       prog_new->type);
>   	if (ret)
>   		return ret;
> @@ -343,6 +346,8 @@ int bpf_mprog_detach(struct bpf_mprog_entry *entry,
>   	if (!bpf_mprog_total(entry))
>   		return -ENOENT;
>   	ret = bpf_mprog_tuple_relative(&rtuple, id_or_fd, flags,
> +				       link ? link->type :
> +				       BPF_LINK_TYPE_UNSPEC,

Same here.

>   				       prog ? prog->type :
>   				       BPF_PROG_TYPE_UNSPEC);
>   	if (ret)

