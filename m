Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A32E633A005
	for <bpf@vger.kernel.org>; Mon, 13 Jul 2026 21:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783978045; cv=none; b=l9IcgA6SefiwrVU9v8EWSN/1RCsCsnutrQ9xtcTTnh3JJrhqes+Z7puLYqqtlvr6BYOImFxiuNy7pC0oMvxxKCP2R1/buF2jwW1UvR9rKb13YIgiefU6CAF6If+4KTKvCYw3ZqhTN0nud9kkeWM+0g2aJUPwj7yKftotsnRD11M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783978045; c=relaxed/simple;
	bh=6D4BSK+3T1nAiGUpMmtNjk230tXko9pc9t83etZFzeI=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=CS4k58YeK4jVCdExTyeSxU4VRuWgbmww59pieVV+K4FVn3aKdVRWEs/I9JU4DiVMFMg6mYQPzUel2TeaUqhMIH4zwhQdVajXmXi9PFNvk98e1egv9O05YVSSTUFayHuPCi2Gg0lsp5EeOlgRN1hF94KE5lh/kdKhnWcGA9n41wY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=occITeni; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="occITeni"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-38e07ebd263so257766a91.1
        for <bpf@vger.kernel.org>; Mon, 13 Jul 2026 14:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1783978044; x=1784582844; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=+USb3n4BDL969RhM6AFut2RcEXsxb0pNRXhYra/sKHA=;
        b=occITeni3/o9TT3l1OusAcPoV8PGL/cch5kYRpqzXUZcwB1uNaULdpCcrogGpDsncp
         Oe4HsCEUjuFcrxy3SdWykfqxz1nSjVEoyOtYf49ktgS4aQj9NnBjdND8ChOtVUSomzP3
         2/7lY29kf0kJYnJOxT0imCbQ4F7hlNcSrc81s4AO10OVxIaz6d+FpK+6O0l3kjtXEpPw
         euqb694AyWe1Ne6GzTQSDcRr0H2NQI8hDA+HRYrpgv7mQCLtpcvnNNPyGr3BCVVse0ig
         jTdOkO8SlFu5Am1xJTOnp/WQoEGVzDh8VQapRd1D+9QgwvsFGieAj5IrD8DNK0/x1Rse
         yMmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783978044; x=1784582844;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+USb3n4BDL969RhM6AFut2RcEXsxb0pNRXhYra/sKHA=;
        b=NsDFrmJhfGvJ9sxKMCn66+Nx1Rdscdvk5Blb1iXIO9upXrTNDxrPDYCwcknTIwqsSS
         DCxP4e+AScP0F28jVe8s0l9M7nuISKjfAWgqbiyZAaVb71N1WHOF+MRav/yv06ZA3tmn
         365OXE3NNylKkzUB8NTjLLw2+AMURc/aCcGg6aB4MeyvPBTgNEdBT0Jl48/I2g9Src6X
         30t7CgW+XQgF+0UUYoVLileLosIjLSbLeC0nhGJOD2OyuKkxe/oHpHet2+QDQ+sa+b4M
         CCLUTbSUfh/dyR8BCOp/NXMYi8MNlirZzjq83NtqTN+VJ/P0Rlm0S8lbfHRgEC4pcl8c
         jAbg==
X-Forwarded-Encrypted: i=1; AHgh+Ro/Dhhf/ZMK3wavfra5gF26+Uw/erRyciX9kIqA1kw0jMeoKtHGQeiIvKmDMJTRY1vXRdY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8cSA0oWnqKmIBLxjKc3EilaNOlkBcXJbgqNy9KbTbC2MdtFVH
	iUl1+snVlA8zM3+n0cFzsKqhMB5xcscwUgKRFRbgRG/5KK7raYjnE6+I9At7yYbUxtVFr6NRmaC
	YGtuDiY0=
X-Gm-Gg: AfdE7clb7KNvVyvaYCfLDiIbU3ADuJIfguEovO5fCyBwB072aE2EY8JLdsite5oadJc
	LlGe0D8bo6mMtizp3I0sPAuw7LLV0BWpQxrnulBYix0SLSM3NU3iUOBvapazDOEHDInGV2ujEVx
	kbGmB1LSRlX63vYkP0tvwUYpcgK6JqDDniBGPXmycp9Rdj61zkwpCiZm4Snuw58nUwPmpFK6oSS
	Qpx5uT+APTQhDf1ABcpjRlhfnXurEkfDQeRd40fyY4ZfHW99FkNncP0bLVMNjJMQugFPiOAt4nG
	9bqIwjUGV3RshDMs6H33xMHR2B0yB4ojTcFPMpjU+PAPFlcdMcbuupXjHvVC9JtNJyWRvMa3op6
	9Vk9LpDeB2EXaPmmytVyRn9LG0P5dI2aqMfJzl9I3VyohFRgTvp1gI3QZq1/3wGwTPksdI4zbPp
	MOazgYFmhKSRppKoAQbT+EiRyvmRnyjCCYTc3DtjLJdAZPaJJYc9qq
X-Received: by 2002:a17:90b:2d10:b0:37f:9ce1:735f with SMTP id 98e67ed59e1d1-38dc779f507mr9978583a91.32.1783978044021;
        Mon, 13 Jul 2026 14:27:24 -0700 (PDT)
Received: from localhost (107-190-31-17.cpe.teksavvy.com. [107.190.31.17])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38e172faba3sm433937a91.11.2026.07.13.14.27.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jul 2026 14:27:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 13 Jul 2026 17:27:22 -0400
Message-Id: <DJXRFQTMYRTX.16Q66ORKV2WCA@etsalapatis.com>
Cc: <netdev@vger.kernel.org>, <alexei.starovoitov@gmail.com>,
 <andrii@kernel.org>, <daniel@iogearbox.net>, <eddyz87@gmail.com>,
 <memxor@gmail.com>, <martin.lau@kernel.org>, <shakeel.butt@linux.dev>,
 <roman.gushchin@linux.dev>, <kuniyu@google.com>,
 <kerneljasonxing@gmail.com>, <kernel-team@meta.com>
Subject: Re: [PATCH bpf-next v3 05/15] bpf: Replace prog_list_prog() check
 with direct pl->prog and pl->link check
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Amery Hung" <ameryhung@gmail.com>, <bpf@vger.kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260706171918.317102-1-ameryhung@gmail.com>
 <20260706171918.317102-6-ameryhung@gmail.com>
In-Reply-To: <20260706171918.317102-6-ameryhung@gmail.com>

On Mon Jul 6, 2026 at 1:19 PM EDT, Amery Hung wrote:
> From: Martin KaFai Lau <martin.lau@kernel.org>
>
> prog_list_length() and compute_effective_progs() use !prog_list_prog(pl)
> to skip a 'detaching' pl.
>
> When pl->link is not NULL, prog_list_prog(pl) returns
> the pl->link->link.prog. This does not work for the upcoming struct_ops
> patch where pl->link is not NULL but pl->link->link.prog is NULL,
> because a struct_ops map is attached to the cgroup instead of a BPF prog.
>
> To prepare for the upcoming struct_ops patch, this patch
> replaces the prog_list_prog() test with the
> "!pl->prog && !pl->link". In __cgroup_bpf_detach(),
> both pl->prog and pl->link are set to NULL, so testing
> "!pl->prog && !pl->link" is the same test to tell
> if a pl is being detached. This change should be a no-op.
>
> Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
> Signed-off-by: Amery Hung <ameryhung@gmail.com>

This change itself is ok, but now prog_list_prog never returns NULL
under normal operation AFAICT. Can we add error handling in the
remaining two call sites? prog_list_id() especially, since it blindly
dereferences the result like so:

	return prog_list_prog(pl)->aux->id;

Imo it's worth it even if the code gets slightly more verbose.

> ---
>  kernel/bpf/cgroup.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
> index b64f6757096c..b100c04cb9c8 100644
> --- a/kernel/bpf/cgroup.c
> +++ b/kernel/bpf/cgroup.c
> @@ -408,7 +408,7 @@ static u32 prog_list_length(struct hlist_head *head, =
int *preorder_cnt)
>  	u32 cnt =3D 0;
> =20
>  	hlist_for_each_entry(pl, head, node) {
> -		if (!prog_list_prog(pl))
> +		if (!pl->prog && !pl->link)
>  			continue;
>  		if (preorder_cnt && (pl->flags & BPF_F_PREORDER))
>  			(*preorder_cnt)++;
> @@ -482,7 +482,7 @@ static int compute_effective_progs(struct cgroup *cgr=
p,
> =20
>  		init_bstart =3D bstart;
>  		hlist_for_each_entry(pl, &p->bpf.progs[atype], node) {
> -			if (!prog_list_prog(pl))
> +			if (!pl->prog && !pl->link)
>  				continue;
> =20
>  			if (pl->flags & BPF_F_PREORDER) {

