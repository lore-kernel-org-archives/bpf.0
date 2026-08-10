Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10B6F322B87
	for <bpf@vger.kernel.org>; Mon, 10 Aug 2026 13:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786367627; cv=none; b=N6wbgLUfPWDkf5CAaa9PSzVZI4QPGDmEu6/gBvYhiLkkHJiBVLjCEANDMCz7/MrjEMyixMhELT9Y3yoNPotc1fGDY1jdxFNZv+k47LeDb7UnGL2Aj2PtNoFzTtQiyHQ3DCiRyikqkuSadQLr+XcXY+1PbI18VJSRUGTCWP0FE+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786367627; c=relaxed/simple;
	bh=+p361PJ3B+QMHcZkiDEsM9uslCImslOoTSD1bEzCyJk=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ExCK58+NiPvIJ8HW3pHrtVq6+phxCBzkp1cPPJnfwGJfyEOk81POplQ9L8UnxVQY2oQhGb5+sxoATiU8NLRhUlQYbmE6PCvxPknHr0KSzT2pZqKPUNFpI3cIjPveiEz8mJa30PIsax3cMjkRHmwUkrPmAMXyBn++EppG1KvbOT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bqeEJioY; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bqeEJioY"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6a1a546a6bbso2419294a12.1
        for <bpf@vger.kernel.org>; Mon, 10 Aug 2026 06:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786367624; x=1786972424; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=omSmpY+SPBy7RnMBwSboFmt1RUmEOInaHtgqQGhZ4w0=;
        b=bqeEJioYn4bSJgBxcqAJIchULM+3EIjjJDVS5Slu6T3wBa2LvYSpPeJgG9/UhMphai
         5G75SVGkI5xEvsoymeUuO/Gh5aSDFRw81RTpZK3lqMxlMkdCKP+DHzJLEdq8NTMR7o3f
         B0gPff9GFMlgbTgYhqTLm+GxjX2xJrFjhyPVuGgJ645g+uWe5kTEgls5vr2j8DZjeWPL
         5oT+b586PZ8knq1xULscJYsu4oZBS7/87pqdxAeg5eDfAmx3miunA8eUILINNH5873f+
         u7yq/Uf00P3Ot0+jZQABtOTf5bVNEdmbppGMoV4oFZhQHHHzjYTTHVpEoYKMEpPEc/6O
         58Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786367624; x=1786972424;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=omSmpY+SPBy7RnMBwSboFmt1RUmEOInaHtgqQGhZ4w0=;
        b=TtOPSek7uIeqFpLpw/HqmxkIpSfMz4bOzaO34h5ihmIMtBdq9hHloy5W+dw89j1M/K
         NN1WHC2P1FqdRwXgDJoy3uYRa7pfWBPPT7OWloxFhKQyJ3mX2S5w7qDr0SfjyYnBXFKH
         7sh6taVlpZf1RCK8qlQ9GSAk/2gExVW6ekTNTBVJ7xj6F+yZkUGRm5kvodbzMPvMKP2Q
         2X36WlU8qfT0WMeqdeaYLUT5yZkcb1jKUG3HH+creVFxIcJj0TY/xOcbZV6ygvNkucCK
         7MnWWVduJFo5obd1TUaj+K209ZzDDqErCuGLt26Wrs2RJKEoHn6btI/gsqK/sBmFFxK5
         cBeQ==
X-Gm-Message-State: AOJu0YzYo4SvdtTJRdGjp84yxW2pwW6J+0Mx1/uigvpFS9enk44JZdRs
	jlc7aWsId6QUe8z8k2vyyocsSnhPPkbrE6z+Fok98h5d/NpcM3VTFQsh
X-Gm-Gg: AR+sD132PA6cyVZDzMsMnvRXNa+hLZQ++aAAdVbvvJ+DjbVHlMf/rK0ju/07Uo646Jr
	ek2xMQ+2nqDxBwBx5ZMmiTwrzYatAlo1QOyV3mfCO6d2Gl/y2ZIF68IUEethz3ZPWO/rClVy0Q/
	981T9jr961ULP5Rywo4Np/t3uhpMbvT/oYLvkDxRmQUrQHtb2veENHX5hz8sgb44xOWinAZGbw8
	bAfdm10Uzp0Tmo3v9w+bBMFHgrPDIOrreRK10XuoArAKjwUe5sdi4G5f0y4Ur8eW+oyeJPV8i8v
	U5ZKauyhRgbllLKFS444cGkK4gLm3dmspPCJr56QCmss8fXQaacSdowYrT0VDYU7ZqzR7R3j/Cw
	93Uvk6an84eMrSN4KZqFnCdUMHNA4++IYOTTkLAGGXiPupErgEbf6As4Mhdew23zlN9jkY7CuAB
	rLM39iBnxs7h3uk+Wc/SBoKxtQa35QhvTba8dX43t/TIdcawM=
X-Received: by 2002:a05:6402:388d:b0:698:ae69:3992 with SMTP id 4fb4d7f45d1cf-6a1b4b98deemr13567414a12.16.1786367623915;
        Mon, 10 Aug 2026 06:13:43 -0700 (PDT)
Received: from krava ([173.38.220.33])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a1e7d5aacesm4507663a12.21.2026.08.10.06.13.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 06:13:43 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 10 Aug 2026 15:13:41 +0200
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Quentin Monnet <qmo@kernel.org>, Shuah Khan <shuah@kernel.org>,
	Mykyta Yatsenko <yatsenko@meta.com>,
	Avinash Duduskar <avinash.duduskar@gmail.com>,
	Anton Protopopov <a.s.protopopov@gmail.com>,
	Amery Hung <ameryhung@gmail.com>, Jordan Rife <jordan@jrife.io>,
	Rong Tao <rongtao@cestc.cn>, Eyal Birger <eyal.birger@gmail.com>,
	Pu Lehui <pulehui@huawei.com>, Jingguo Tan <tanjingguo@huawei.com>,
	Lin Ma <malin89@huawei.com>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH bpf-next 04/13] bpf: Add tracing_multi link support for
 bpf progs
Message-ID: <annOhedRtHBce3px@krava>
References: <20260809150111.45000-1-leon.hwang@linux.dev>
 <20260809150111.45000-5-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260809150111.45000-5-leon.hwang@linux.dev>

On Sun, Aug 09, 2026 at 11:01:02PM +0800, Leon Hwang wrote:

SNIP

> diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
> index eddd259d3776..fc51ea2428be 100644
> --- a/kernel/bpf/trampoline.c
> +++ b/kernel/bpf/trampoline.c
> @@ -1572,12 +1572,23 @@ static int update_fentry_multi(struct bpf_trampoline *tr, u32 orig_flags,
>  			       struct bpf_tramp_image *im, struct ftrace_hash *hash,
>  			       struct bpf_tracing_multi_data *data)
>  {
> -	unsigned long addr = (unsigned long)(im ? im->image : tr->cur_image->image);
> +	if (tr->func.ftrace_managed) {
> +		unsigned long addr = (unsigned long)(im ? im->image : tr->cur_image->image);
>  
> -	if (bpf_trampoline_use_jmp(tr->flags))
> -		addr = ftrace_jmp_set(addr);
> +		if (bpf_trampoline_use_jmp(tr->flags))
> +			addr = ftrace_jmp_set(addr);
> +
> +		ftrace_hash_add(hash, data->entry, tr->ip, addr);
> +	} else {
> +		void *old_addr = tr->cur_image ? tr->cur_image->image : NULL;
> +		void *new_addr = im ? im->image : NULL;
> +		int ret;
> +
> +		ret = bpf_trampoline_update_fentry(tr, orig_flags, old_addr, new_addr);
> +		if (ret)
> +			return ret;
> +	}

hum, so IIUC this sequentially attaches to target bpf program as it
would with current API, so there's no attachent speedup, right?

>  
> -	ftrace_hash_add(hash, data->entry, tr->ip, addr);
>  	tr->cur_image = im;
>  	return 0;
>  }
> @@ -1627,6 +1638,18 @@ static void bpf_trampoline_multi_attach_free(struct bpf_trampoline *tr)
>  
>  static void bpf_trampoline_multi_attach_rollback(struct bpf_trampoline *tr)
>  {
> +	if (!tr->func.ftrace_managed) {
> +		void *failed_addr = tr->cur_image ? tr->cur_image->image : NULL;
> +		void *old_addr = tr->multi_attach.old_image ?
> +				 tr->multi_attach.old_image->image : NULL;
> +		u32 orig_flags = tr->flags;
> +		int ret;
> +
> +		tr->flags = tr->multi_attach.old_flags;
> +		ret = bpf_trampoline_update_fentry(tr, orig_flags, failed_addr, old_addr);
> +		WARN_ONCE(ret, "bpf_trampoline_update_fentry failed: %d\n", ret);
> +	}
> +
>  	if (tr->cur_image)
>  		bpf_tramp_image_put(tr->cur_image);
>  	tr->cur_image = tr->multi_attach.old_image;
> @@ -1643,6 +1666,7 @@ static void bpf_trampoline_multi_attach_rollback(struct bpf_trampoline *tr)
>  	for_each_mnode_cnt(mnode, link, link->nodes_cnt)
>  
>  int bpf_trampoline_multi_attach(struct bpf_prog *prog, u32 *ids,
> +				u64 *keys, struct bpf_prog **progs,
>  				struct bpf_tracing_multi_link *link)
>  {
>  	struct bpf_tracing_multi_data *data = &link->data;
> @@ -1651,18 +1675,18 @@ int bpf_trampoline_multi_attach(struct bpf_prog *prog, u32 *ids,
>  	struct bpf_tracing_multi_node *mnode;
>  	struct bpf_trampoline *tr;
>  	int i, err, rollback_cnt;
> -	u64 key;
>  
>  	for_each_mnode(mnode, link) {
>  		rollback_cnt = i;
>  
> -		err = bpf_check_attach_btf_id_multi(btf, prog, ids[i], &tgt_info);
> +		if (progs)
> +			err = bpf_check_attach_target(NULL, prog, progs[i], ids[i], &tgt_info);
> +		else
> +			err = bpf_check_attach_btf_id_multi(btf, prog, ids[i], &tgt_info);
>  		if (err)
>  			goto rollback_put;
>  
> -		key = bpf_trampoline_compute_key(NULL, btf, ids[i]);
> -
> -		tr = bpf_trampoline_get(key, &tgt_info);
> +		tr = bpf_trampoline_get(keys[i], &tgt_info);
>  		if (!tr) {
>  			err = -ENOMEM;
>  			goto rollback_put;
> @@ -1691,6 +1715,9 @@ int bpf_trampoline_multi_attach(struct bpf_prog *prog, u32 *ids,
>  	for_each_mnode(mnode, link) {
>  		bpf_trampoline_multi_attach_init(mnode->trampoline);
>  
> +		if (progs && progs[i]->aux->tail_call_reachable)
> +			mnode->trampoline->flags |= BPF_TRAMP_F_TAIL_CALL_CTX;
> +
>  		data->entry = &mnode->entry;
>  		err = __bpf_trampoline_link_prog(&mnode->node, mnode->trampoline, NULL,
>  						 &trampoline_multi_ops, data);

IIUC for bpf_program targets the actuall attachment is happening in
here, right?

the rest of the function logic won't execute, because there won't
be any data in the reg/noreg/mod hashes..?

you seem to use the tracing_multi API to ease up attachment to multiple
bpf programs and end up with just single link fd for all attachments

I think it'd be cleaner to have separate api or code paths for that

jirka
