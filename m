Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90CBF279DAF
	for <bpf@vger.kernel.org>; Wed, 22 Jul 2026 11:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784719193; cv=none; b=Kx6ORGxJMd1nuQX8OxQq/AFfbSiBFOviFcqKuNy7nXeoinqfk1T16o9WpTCwsGISrMCTOMyPs9Npw8D/45qMRiRKTLSJO4ubYoWm7Hz5lUy7eL1mSr9UZC0oC2ecm+RUM3yF5iIHnqQ3qBa3tNerBl8cG0lAZ0iCSLCYevOtHmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784719193; c=relaxed/simple;
	bh=RxMIjj07LsUJcropft0k91Ai7UiLRrZZbLIu+bRLNWo=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eu27+maevHjMZlUwMcN2OV+rmjxf7AtmTPgxV6A0lKSYAUtfgit2YFF0XzpVMnqid235FiAtG1Uxg4X7V+2SwIkUShauOLCseMnOJsAWnBojdnLJd+g5E9yKkBGhkdgUX+8Gq2WYACDRB0pJjlK7sdBq7BiUVWRUckqmpYz/5AA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dtrTHo8a; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dtrTHo8a"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-47f7027ca11so2705059f8f.3
        for <bpf@vger.kernel.org>; Wed, 22 Jul 2026 04:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784719190; x=1785323990; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FcTLnpaMyjPTSw74/bk89WEOA9WOPNLCuc5b614k7DA=;
        b=dtrTHo8a/ilFIBawuIEoORSKjQKnGI5c23LfgL8c7mThqns1odE6QDT+9vxZMDDAqz
         w/vG3E1dY85aEUZqD2E50zZRoCA8ExaivgOWjXluLCU2ImcV/ZKU+DZ+1ltevuTo8ng9
         9ePVZJRrgqg6udPS99keKVW5DlU1K07g1L+JoX0ijhSk9X2aNmXM0sX0QeXJBG4ZOnZL
         /Wx4uEVkIoxLoYojYpZyxL3ucclOj/ghlO+YjPude21Xg0wmeOj1a0kBDhPr0jE1eBwr
         COdmCQr3hlvdt48Zls47a1nsDwahLTtHFtPfUajBp6sszpEtBJmkHi+mynzdlwnCyixZ
         /w1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784719190; x=1785323990;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FcTLnpaMyjPTSw74/bk89WEOA9WOPNLCuc5b614k7DA=;
        b=CQf7Ta8UruFeqPzIYsgrfiVTmVV11kDJ/TZt+3aqvZXJjPw71k4grdnxRMfk2Hj88t
         zZ8zK/6OVrEN54nYhL2BixwMPr5mEKx3LusGzxIAAWtABB57PFfWNGU2MAGd3xD9YFQ7
         t5oIdFdmshAqK6ON5DoPvJhHUFmgs/XVe0ww6c/p02xYix+xO6xox3NDl6KaQFBvEyEK
         msgdcHcAStmAUmUGdVxL+iH6HReNUnhTqG9rx6+W+AF/eVY4Vc5DAh9U803DxwUpu79c
         IuJ7RMirhB15wccNKUaCgCRF6X+xRGUfWgPBuFLeWSZGBBK5vkCPZ16mbOLU941hbDpS
         5yYQ==
X-Gm-Message-State: AOJu0Yyzih9uyIUwzSTXYGr/+IRbgi2ARjipTj2nL9JQbKQLziRstXME
	Moz8ueXJ9RQctL81aBcIPIDaPfnmkX0oKZWq2wMAENKx+oCygb3BxUzEsm5c0A==
X-Gm-Gg: AR+sD124OD/qcHF0yz9boGLvGILV6BXBIHgyLd7voJYC2CUSh+658OiiA8tbaDLIxEI
	8ev+u/je0VZH/ImdGKtrwCc/rH4oYgsKnNuzmNS0PJre9+0Qn+8WSI/9sBvWj9S/qB0gyuTSPBE
	KuboiKywgw4xC/D/fcAVAN1yLE1l9w7LXZN9KGZqwT2XS4P3SnpXzilNFeN5wQEwPidiJ3LQhW3
	sreRmp+ZKYqKzXIAZ0XqwMLyQXgx3nEx23IF/LANq+6/qYOI/Bc9Jzz4d5xTcNycBroyZieejow
	sjiU2o1+SqCwW7U0Pl3n1gyteyKlWLrPf/LYbNbFFI3B/4R4SiDHyTMcZYpox/2CRGdWsyK2HiB
	83Cdub8mzLTbL3jQSmXTsEFA4CMC9cYd27Tf01+6BP1s7AVmcsrw=
X-Received: by 2002:a05:6000:2994:10b0:461:a15f:6df4 with SMTP id ffacd0b85a97d-47f6232cda4mr20595526f8f.35.1784719189644;
        Wed, 22 Jul 2026 04:19:49 -0700 (PDT)
Received: from krava ([2a02:8308:a00c:e200::86b6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85c6d277sm5440731f8f.32.2026.07.22.04.19.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 04:19:49 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 22 Jul 2026 13:19:46 +0200
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
	Shuah Khan <shuah@kernel.org>, Jingguo Tan <tanjingguo@huawei.com>,
	Pu Lehui <pulehui@huawei.com>, Lin Ma <malin89@huawei.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	kernel-patches-bot@fb.com
Subject: Re: [PATCH bpf-next 1/2] bpf: Fix WARNING in bpf_tracing_link_release
Message-ID: <amCnUg9xTo4kStW8@krava>
References: <20260721133036.49265-1-leon.hwang@linux.dev>
 <20260721133036.49265-2-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260721133036.49265-2-leon.hwang@linux.dev>

On Tue, Jul 21, 2026 at 09:30:34PM +0800, Leon Hwang wrote:
> The trampoline could be corrupted by the blindly
> 'tr->flags = BPF_TRAMP_F_TAIL_CALL_CTX' in verifier.
> 
> 1. A fexit attached to a tail_call_reachable prog.
> 2. Another fexit loaded with the same tail_call_reachable prog target.
> 3. Close the first fexit link.

had to ask ai for more details on how the warning was trigered ;-)
would be nice to have that info in the changelog

Acked-by: Jiri Olsa <jolsa@kernel.org>

jirka

> 
> [    3.410719] WARNING: kernel/bpf/syscall.c:3551 at bpf_tracing_link_release+0x53/0x60, CPU#1: test_progs/98
> ...
> [    3.428793]  bpf_link_free+0x58/0x130
> [    3.429293]  bpf_link_release+0x23/0x30
> 
> Fix the warning by updating 'tr->flags' with '|=' and lock.
> 
> Fixes: 2b5dcb31a19a ("bpf, x64: Fix tailcall infinite loop")
> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
> ---
>  include/linux/bpf.h     | 2 ++
>  kernel/bpf/trampoline.c | 7 +++++++
>  kernel/bpf/verifier.c   | 2 +-
>  3 files changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index d9542127dfdf..fc84f39967ae 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -1523,6 +1523,7 @@ int bpf_trampoline_multi_attach(struct bpf_prog *prog, u32 *ids,
>  				struct bpf_tracing_multi_link *link);
>  int bpf_trampoline_multi_detach(struct bpf_prog *prog,
>  				struct bpf_tracing_multi_link *link);
> +void bpf_trampoline_set_flags(struct bpf_trampoline *tr, u32 flags);
>  
>  /*
>   * When the architecture supports STATIC_CALL replace the bpf_dispatcher_fn
> @@ -1646,6 +1647,7 @@ static inline int bpf_trampoline_multi_detach(struct bpf_prog *prog,
>  {
>  	return -ENOTSUPP;
>  }
> +static inline void bpf_trampoline_set_flags(struct bpf_trampoline *tr, u32 flags) {}
>  #endif
>  
>  struct bpf_func_info_aux {
> diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
> index 6eadf64f7ec9..129d07db117e 100644
> --- a/kernel/bpf/trampoline.c
> +++ b/kernel/bpf/trampoline.c
> @@ -670,6 +670,13 @@ static struct bpf_tramp_image *bpf_tramp_image_alloc(u64 key, int size)
>  	return ERR_PTR(err);
>  }
>  
> +void bpf_trampoline_set_flags(struct bpf_trampoline *tr, u32 flags)
> +{
> +	trampoline_lock(tr);
> +	tr->flags |= flags;
> +	trampoline_unlock(tr);
> +}
> +
>  static int bpf_trampoline_update(struct bpf_trampoline *tr, bool lock_direct_mutex,
>  				 const struct bpf_trampoline_ops *ops, void *data)
>  {
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 52be0a118cce..66d8d9eaec05 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -19523,7 +19523,7 @@ static int check_attach_btf_id(struct bpf_verifier_env *env)
>  		return -ENOMEM;
>  
>  	if (tgt_prog && tgt_prog->aux->tail_call_reachable)
> -		tr->flags = BPF_TRAMP_F_TAIL_CALL_CTX;
> +		bpf_trampoline_set_flags(tr, BPF_TRAMP_F_TAIL_CALL_CTX);
>  
>  	prog->aux->dst_trampoline = tr;
>  	return 0;
> -- 
> 2.55.0
> 
