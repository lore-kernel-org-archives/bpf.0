Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B22FF288B8
	for <bpf@vger.kernel.org>; Thu, 16 Jul 2026 21:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784236184; cv=none; b=NL74ENJAdY3w7hXyStU5TfdTt+Xqi+vythtXgr9F7NGejQF1wmnEz157+NQajD12w2jGNVTuBmOdlEbMPMhssTHai7SClnwTlMJ6zUmrlGDpzdBySLyNOQu8d6iWLJYWn/uzFo09ZlEbWCcWhiMPF4qOxybmZ/3mxG9FAWBErQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784236184; c=relaxed/simple;
	bh=aOjQstTkfrqW9EREwl6wTjEnaJdoRbk9gUXBta3Zqw0=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tc1PsHfq/P+3MasGVmL7oR8ZVCU5FUJmr7hcCGVRuf8Wmcva5ljI24VUQaBxvIUoNxDsgX1z45moV6eHQtDlc6PG5QHrE+kBDeTUFx089XCDXGbdEJ04fpSie4LzVniHK+hWquv/9MQABiJoKS/xmNsKNRHwrGHDsPh6gH7Gt6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KX4WSmog; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KX4WSmog"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-47df6a5202bso4736892f8f.0
        for <bpf@vger.kernel.org>; Thu, 16 Jul 2026 14:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784236179; x=1784840979; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9adGFST24XbUB9HX5zfJ4jTnzDpD6OlzQnD7d2fItro=;
        b=KX4WSmogKQPjmmpCoR2LvReQ04UgI60ckiKvUO0g1wMV5bkjqsz5zHXiqBuIEfabt+
         kN4Lc9GLg9mK5950y3KWjrpHQZpKM5Gp+SRmjiiyVhFiGit9d7kFxo3L5eGSKKSY38gT
         +QeRaICG5s+8COJyeo0nIrGV6EQDKYE87IFaLws91fRIJi6Zx5hRr/iyME12BGYnaRpA
         0Vp5EKH0uf4nlwX1ehG3ft/dD0b8nYa3CJzygQbMseN7ZtCMMKVW7xyMQHm/jN94+yWo
         kKaOHy4/Lc2kOW7Y2QzmVRQsEvLGBzGybEZmBm2pfZ+3jayfyHp6tLkpLUxhTwMCZBGo
         WNpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784236179; x=1784840979;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9adGFST24XbUB9HX5zfJ4jTnzDpD6OlzQnD7d2fItro=;
        b=g/I31Rqa5Q+fdG8khYl5frfDUHmeE//Ik0uyDEfNoZ6KQn8kGIJTP6iZgigecyhmNj
         7CtfjFxHBSb7d93G6pfwD7gKHD0ygSUbbpDKrDACPaMis3lD8xtYBwJuU6IqycMzKWle
         R9bAWWFFUQgirVl7NzmeXWikh1GGRkterh18EjPKU+DjoOuo06b5YMEiJCM8XjpN86ya
         /Uip1FcZ/J3OPLqG5JWzdl+vFEqLdl3wpsU8QYWseeZMv/IOJ7fZDgXR6kfsGMiplC+t
         drPq0FCjRRlQuj2DIDFRQB6Zl53cgxpVzPl7F6UWrOXWLZDD0Ng1xfmZnPcfy3RePACR
         RP/A==
X-Forwarded-Encrypted: i=1; AHgh+RrEGZQjXsWMWCCFoGJfOZlJI10UIYChn/IFc2cvdxS+MiHIqABFcM+AKmp48ajZQO5L69g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yycd6bTtt+1yh7iwtE33fuNuQBrs+UEz982d4mRmaVDHK1YCgu8
	6PhIxkpq0nFTZ9RT95gxRTYOYuhGARQekaNyG4+SZJlG952OGlxvzTjO
X-Gm-Gg: AfdE7cmQNVrMmWy7Dk/GaPYEsA6MS8DetmweVbUOTFuW1zM8/xkaOLZfGm5Nf+fGFJO
	Gel8eBPrEq271nD4xhfytkiIkycqlBARdjJKne+WEl56tFTtk2Hkxxq8ifCgkzF/w0UPFMwd/3H
	oZmALWXFj/P29tsiULKFcPuiLGkBZMGBhSaN6POPTn2RzKxg671nZd5O15jegfqgH/O9k1DZN2l
	SqTrx7/UxBEkqNnVBmZVkWwighDa5RLT2Z9plxrf023UcSWT5V155oYE0mN3HNUAiBGSAolAfqY
	EMvsJ3Zr7WMgx8w6oVVrB3J3gGj3cKFOQrVp3KzRLdPimzFMyJzSo5zoD/Zhtsn5l9DGLwPyyVH
	sIQmHs6yGYCUIhjgwfFgUrHCmdztGbAAlpa9IE+ynOshYcS7bCsC0RDPtA71W5T6G3A==
X-Received: by 2002:a05:600c:5904:b0:490:9d1b:f086 with SMTP id 5b1f17b1804b1-4953c156283mr80700865e9.14.1784236178517;
        Thu, 16 Jul 2026 14:09:38 -0700 (PDT)
Received: from krava ([193.86.205.162])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f4635082csm26531281f8f.7.2026.07.16.14.09.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 14:09:38 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 16 Jul 2026 23:09:36 +0200
To: Hui Zhu <hui.zhu@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Emil Tsalapatis <emil@etsalapatis.com>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, Hui Zhu <zhuhui@kylinos.cn>
Subject: Re: [PATCH bpf-next 2/2] bpf: Fix UAF in bpf_trampoline_multi_detach
 when ftrace update fails
Message-ID: <allIkF_1_P5z_zuN@krava>
References: <cover.1784191209.git.zhuhui@kylinos.cn>
 <d1fcbede8f311db5cfa7cbe34371de7b63186ce5.1784191209.git.zhuhui@kylinos.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d1fcbede8f311db5cfa7cbe34371de7b63186ce5.1784191209.git.zhuhui@kylinos.cn>

On Thu, Jul 16, 2026 at 04:43:39PM +0800, Hui Zhu wrote:
> From: Hui Zhu <zhuhui@kylinos.cn>
> 
> After the per-mnode unlink loop, the return values of the batch
> update_ftrace_direct_del()/update_ftrace_direct_mod() calls are only
> WARN_ON_ONCE()'d, not checked. bpf_trampoline_multi_attach_free() is
> then called unconditionally for every mnode, freeing old_image
> whenever the single-point unlink succeeded (old_image != cur_image).
> 
> If the batch update fails, ftrace still points to old_image for the
> affected IPs, so freeing it is a UAF.
> 
> Capture the two return values and, for mnodes whose single-point
> unlink succeeded but whose batch update failed, call
> bpf_trampoline_multi_attach_rollback() instead of
> bpf_trampoline_multi_attach_free(). cur_image == NULL identifies the
> unreg path (set by unregister_fentry_multi when total == 0),
> cur_image != NULL identifies the modify path (set by
> modify_fentry_multi when total > 0), so err_unreg/err_mod can be
> matched to the right mnodes. Rollback restores cur_image = old_image,
> the image ftrace is still actually calling.
> 
> This mirrors the existing error handling in
> bpf_trampoline_multi_attach()'s rollback_unlink path.
> 
> Fixes: aef4dfa790b2 ("bpf: Add bpf_trampoline_multi_attach/detach functions")
> Signed-off-by: Hui Zhu <zhuhui@kylinos.cn>
> ---
>  kernel/bpf/trampoline.c | 42 ++++++++++++++++++++++++++++++++++-------
>  1 file changed, 35 insertions(+), 7 deletions(-)
> 
> diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
> index a78fbf726fad..44ef25beb4cc 100644
> --- a/kernel/bpf/trampoline.c
> +++ b/kernel/bpf/trampoline.c
> @@ -1723,7 +1723,7 @@ int bpf_trampoline_multi_detach(struct bpf_prog *prog, struct bpf_tracing_multi_
>  {
>  	struct bpf_tracing_multi_data *data = &link->data;
>  	struct bpf_tracing_multi_node *mnode;
> -	int i;
> +	int i, err_unreg = 0, err_mod = 0;
>  
>  	trampoline_lock_all();
>  
> @@ -1734,13 +1734,41 @@ int bpf_trampoline_multi_detach(struct bpf_prog *prog, struct bpf_tracing_multi_
>  					NULL, &trampoline_multi_ops, data));
>  	}
>  
> -	if (ftrace_hash_count(data->unreg))
> -		WARN_ON_ONCE(update_ftrace_direct_del(&direct_ops, data->unreg));
> -	if (ftrace_hash_count(data->modify))
> -		WARN_ON_ONCE(update_ftrace_direct_mod(&direct_ops, data->modify, true));
> +	if (ftrace_hash_count(data->unreg)) {
> +		err_unreg = update_ftrace_direct_del(&direct_ops, data->unreg);
> +		WARN_ON_ONCE(err_unreg);
> +	}
> +	if (ftrace_hash_count(data->modify)) {
> +		err_mod = update_ftrace_direct_mod(&direct_ops, data->modify, true);
> +		WARN_ON_ONCE(err_mod);
> +	}
>  
> -	for_each_mnode(mnode, link)
> -		bpf_trampoline_multi_attach_free(mnode->trampoline);
> +	for_each_mnode(mnode, link) {
> +		struct bpf_trampoline *tr = mnode->trampoline;
> +
> +		/* If the batch ftrace update failed for this mnode's path,
> +		 * ftrace still points to old_image. Use rollback to restore
> +		 * cur_image to old_image (putting the new cur_image if any)
> +		 * so the trampoline keeps the image ftrace is calling.
> +		 *
> +		 * This relies on update_ftrace_direct_del/mod being atomic:
> +		 * on failure, NO IPs in the hash are modified in ftrace (all
> +		 * validation/allocation happens before any ftrace record is
> +		 * touched). If this assumption is broken in the future (i.e.,
> +		 * partial success becomes possible), this rollback logic would
> +		 * need to be revisited.
> +		 *
> +		 * cur_image == NULL indicates the unreg path (total == 0);
> +		 * cur_image != NULL indicates the modify path (total > 0).
> +		 */
> +		if (tr->multi_attach.old_image &&

I think tr->multi_attach.old_image is always != NULL in here?

> +		    tr->multi_attach.old_image != tr->cur_image &&
> +		    ((err_unreg && !tr->cur_image) ||
> +		     (err_mod && tr->cur_image)))
> +			bpf_trampoline_multi_attach_rollback(tr);

it's good that we won't free the image that's used, but after the link
is detached, its program will be freed, so I expect the trampoline execution
is likely to crash anyway.. did you try to simulate the errors?

I remember suggesting to increase the prog's refcount to prevent that
but I never sent that change.. I think also standard trampolines have
the same issue

> +		else
> +			bpf_trampoline_multi_attach_free(tr);
> +	}
>  
>  	trampoline_unlock_all();

also we could have bpf_trampoline_multi_detach returning void,
without the WARN_ON_ONCE in bpf_tracing_multi_link_release,
we already have the warnings in here

thanks,
jirka
