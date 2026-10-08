Received: from mail-pj2-f3.google.com (mail-pj2-f3.google.com [74.125.227.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99CA347C0EB
	for <bpf@vger.kernel.org>; Thu,  8 Oct 2026 22:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791497617; cv=none; b=PEyAuZg2/e4wXSalG3rH0hyfH+CemxOlPxymCAcRNf2csJErnzg1Na1LhXltemC7Mf6MwHQQB2pV3FaAp0UDL1ddkJ5Porqvzel/FKiHi1+eWDHLQfz0jf0S57f8PN4OKXLxfLx1JHLZRkkiXN+e9G4TzfrTlu0pxC8qGNACxM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791497617; c=relaxed/simple;
	bh=Q7MGTWa//SXgvQo5YsxMlTwYxjEqnejLhQsOPwoBlxU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jv8Mf2Kz+DAWsqRz+qzcSKqI93incfuIFAyswRo+7Mu42EVZgrOLZCpX+gfJWWpI1rRZuCIR/3VP9xeoT/dwFWbPg6q6Bq1U9T9+zVI9SxV7H7yhnP8sdE+/R0VVh8/UWEIm5W1ZKMzYV6IeCKkTdFTtd8Na/Lc9yb9+nbJUdY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cq/iAPFZ; arc=none smtp.client-ip=74.125.227.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cq/iAPFZ"
Received: by mail-pj2-f3.google.com with SMTP id 98e67ed59e1d1-3ab04c3c533so591227a91.0
        for <bpf@vger.kernel.org>; Thu, 08 Oct 2026 15:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791497616; x=1792102416; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WPbmrGBLIr/te7gZCrNpUgaX1e+f/sOX+nH1nGhEvRo=;
        b=Cq/iAPFZ0I3yriGo5nLOwuz3OJvnVsGyz5DHBmZAwJ4r5blX3aQva1cPyw4/5zG+GQ
         f6giR89e7Lj4wO1oZTev6G38b0qQ688zSfzRWvv9tvLppeEpAUJzIy3bS9y+fPm0+zmn
         AoJb4a16euwlm6cE0lX8TFD3mGNMRfODNRjtXcMdR/qLfLilE7H8UNAffWx7ecWBXVvr
         uZwtsm4h0+JhvNkMFkSUJJ15sGZoX+/j+xSbxFmY/04yE6O+WNkCI0bRpBrG8oR3AfKY
         LQl0ErUoXDYJaL8oPrnH2xv0TVzafgiQ6d1CdmCg+bmDCNU05OpeIf3VaPUkrKolpVG1
         Z7Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791497616; x=1792102416;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WPbmrGBLIr/te7gZCrNpUgaX1e+f/sOX+nH1nGhEvRo=;
        b=hqOSfJc4xFKJbwGfzzdlydRqQxAOcO8FJHj2yRXpMNbxZtYNfITyBxQNieZXFOnh4O
         QVNBEaygrd6xf+g6VPCNHiyCPBVjZkUQSzTZdqQMmIE8mLHKsE/0hlXnytx/wGPZK2Bu
         mkXo+5kxK7FBLa2EEdReVmlDasQYHe0dOk+kV8pXQfEqhs7XQmLpWBw+H4OyJaSyl9TL
         qFkLgcUDw7ifPeh9vKY5rIK9fjhB0xaxYYQt+LPDdhRkpCE0MHEbLdHL/MjxJGXGJLk6
         iTbArHWW9OeOVrJqQkjqeG8XUYQQ+259p70pdo0a6LbbC04codAvRVlHKZ2AbilQRfVN
         t1nQ==
X-Forwarded-Encrypted: i=1; AKwUvBxvHSTRB9bdqYWB4YM5YsME5h6EIPI//s/pUME6OXHucg6zKVndI5ZNFLc/qojPFYBYYas=@vger.kernel.org
X-Gm-Message-State: AFq9FYLaXAZEXjLM1ELBIqSLPK/xckDmTVmkYLx2fJ4GmkhUW0aQ5SFj
	iSXIk1iATUtiz9vuRqT2GLxSuWDYF8alBX/5BSeqzx4KqYM1S87rt2vz
X-Gm-Gg: AYBFou3kbCEbJSJZnWBDF94KgmCMa608cDIovun63zNrXNbxOztWC0tgc7QXta2KMGf
	k2jfkx9bvda8MsISuZ3cYqcbsbcLvxffRKhWUVp7YIa7gZ2uFa+W70+DW7KcrjhsnAHDHNB5SIK
	05eZwialQ3cSWwY/7nAce0HPGtAjW6jInTgnUSOSMerTtj8oHN6TiK8Le4pA3XinfapHuNenZml
	Yq95bRT6tz1ay/w1/0H0Lnl6r6p/SdIortprM/18z9Gu5K+GUDSyT13tVtwuEJZk/4DJljYVHG0
	KE6E6avflFOImXiQtgsEm39BGXcjy+j8mDJexEYsiPbJRSf5OEnZjEzrfrF3DNBNJEPk5pV8wje
	6Cqu51yMw0InR22RA6NhIU9XC7BY5ZaGJEqU+FBtpCbTp61U6aAxp24b/S9MWWKjyvtTTP9Y9Kl
	9Krxl6LC6x/Ur5IL1tKfWOAldPiQGJkXUtz2ORsJg3QAJEhlNssyz0uQpabe4GMW5L
X-Received: by 2002:a17:90b:1dd1:b0:3a8:bb56:f1ed with SMTP id 98e67ed59e1d1-3ab3acf313fmr167389a91.50.1791497615949;
        Thu, 08 Oct 2026 15:13:35 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:74::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab36f4737esm559908a91.7.2026.10.08.15.13.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 15:13:35 -0700 (PDT)
Date: Thu, 8 Oct 2026 15:11:19 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Amery Hung <ameryhung@gmail.com>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Eric Dumazet <edumazet@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Willem de Bruijn <willemb@google.com>, 
	Tenzin Ukyab <ukyab@berkeley.edu>, =?utf-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@meta.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v5 bpf-next 05/10] bpf: tcp: Check
 BPF_SOCK_OPS_TEST_FLAG() after cgroup_bpf_enabled(CGROUP_SOCK_OPS).
Message-ID: <asgVAPc-KLwrL95a@devvm7509.cco0.facebook.com>
References: <20261008031604.256498-1-kuniyu@google.com>
 <20261008031604.256498-6-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261008031604.256498-6-kuniyu@google.com>

On 10/08, Kuniyuki Iwashima wrote:
> BPF_CGROUP_RUN_PROG_XXX() macros guard __cgroup_bpf_run_filter_XXX()
> with cgroup_bpf_enabled().
> 
> However, even when no SOCK_OPS prog is attached, callers still
> initialise struct bpf_sock_ops_kern (memset(), etc.) or evaluate
> BPF_SOCK_OPS_TEST_FLAG(), which loads tp->bpf_sock_ops_cb_flags
> from a cold cacheline near the end of struct tcp_sock.
> 
> Similar to bpf_tcp_ops, let's check cgroup_bpf_enabled() before
> BPF_SOCK_OPS_TEST_FLAG() and struct bpf_sock_ops_kern setup, and
> rename BPF_CGROUP_RUN_PROG_SOCK_OPS{,_SK}() with __ prefix.
> 
> Since all direct callers of tcp_call_bpf() pass 0 and NULL for
> nargs and args, they can be folded into the new tcp_call_bpf()
> macro.
> 
> All callers of tcp_call_bpf_{2,3}arg() check BPF_SOCK_OPS_TEST_FLAG()
> and do not need the return value.  These are replaced with the new
> tcp_call_bpf_flag() macro.
> 
> Now, bpf_skops_hdr_opt_len() and bpf_tcp_ops_hdr_opt_len() are
> just NOPs without bpf prog attached.
> 
>   $ llvm-objdump -S -D --disassemble=tcp_established_options vmlinux
>   ...
>   ; 	asm goto(ARCH_STATIC_BRANCH_ASM("%c0 + %c1", "%l[l_yes]")
> >>ffffffff825127e6: 66 90                	nop
> >>ffffffff825127e8: 66 90                	nop
>   ; 	size = MAX_TCP_OPTION_SPACE - remaining;
>   ffffffff825127ea: b9 28 00 00 00       	movl	$0x28, %ecx
>   ffffffff825127ef: 29 c1                	subl	%eax, %ecx
>   ; 	return size;
>   ffffffff825127f1: 89 c8                	movl	%ecx, %eax
>   ...
>   ffffffff825127fb: 2e e9 6f 02 43 00    	jmp	0xffffffff82942a70 <__x86_return_thunk>
> 
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> ---
> v5: Always inline static key to tcp_established_options()

Acked-by: Stanislav Fomichev <sdf@fomichev.me>
