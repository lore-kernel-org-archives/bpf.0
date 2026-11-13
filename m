Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.133
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794601339;
	b=s7eQ6x9XRBzle1qlrVJ/mKAbY0Twxh2uOYWwO/8X1s63Q7NztZU7SgaaOACHJaY8pChL
	 Nnfd05zxdMTrxYFW/eJUc7uafKMAc+9CCtzForXz3IRhov2t5GgjnWfa8Avd7EyAU/DGR
	 uxTz/EETewLZW7IWXqMN01Kmk7j+u+4kB/SJi2FNekrisF8JpcjIhHyA2Ghl16l70/uU0
	 xXwtT3LBX4mKbC7o4VwXN7t/dHM8hpI4Ki4zcG9YhnNOmZSJ0CWTo0xy11l0T2jiRuQ1a
	 q1/ifSSa8EoHhWac76Y0BfxLacl2eWuBX2yqxos/M56ghGvlwzvu9c+yUifzIzVR2Og==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794601339;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=HopEjVcKVy5WlPlbnxrcDQWkWX0L0xT3AvRN619hsz4=;
	b=4uB5iXp7tcbrj9+gx91q5F5ZWvg0qM0VfVije9aPNq/JCGvkr2IcZwBcZKfDMjaWVVW3
	 vyODsn9lczUs90Ntse3K+HEjWexT1vIp+cSCQEToSsjLbmFDW3tzEnx7cf2zPFOQ9kiT8
	 kuefSAFayWF0V68TLywET69lCtzcf1hLPrUGtWJq1qn4r2HnrzRswpZYehALSx/rOo0nf
	 ToSPzoVdVRhmm0DkeTPma2ogWRLuI7ttyB7ceoFlFlGDhy/EymuCIGhAxrn4Ky03x6t61
	 RWlApo2dG6vAXbZLzvnQZ2LruQaLovspvI8JJVjJwTwPPqmk8Qs+MtCv3hy1qnMc4Sw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OpB7fYZ5;
	arc=none smtp.remote-ip=74.125.229.133
Received: from mail-dl2-f5.google.com (mail-dl2-f5.google.com [74.125.229.133])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C871606A33D
	for <bpf@vger.kernel.org>; Fri, 13 Nov 2026 20:22:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8C871606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OpB7fYZ5
Received: by mail-dl2-f5.google.com with SMTP id a92af1059eb24-1ac216daf7dso450205c88.1
        for <bpf@vger.kernel.org>; Fri, 13 Nov 2026 12:22:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794601339; x=1795206139; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HopEjVcKVy5WlPlbnxrcDQWkWX0L0xT3AvRN619hsz4=;
        b=OpB7fYZ5oudIYsb91KeZQgQ1i2+Yz+pWWPbfqpFJ0c/wuhFClNklZv6sc4wpmQeaDl
         mUOsbOVX7fX4RiViMDJs2bAsdSH/f7cYI4vJPbL3GaFQcLDk2FVjwuZryQqyXIUMjYIc
         cq8hIvkyFTHYgr64EYJprVhlJq+G0bix/FOaebLcvIFybOfqUcuDl9cx3LTbKx6THvar
         0Sgko3b/NsmmejwxUdRbl7fx9witxeyO2B3kJMMwS2bWhIRQFd5P0Z5zAK4L+w0MZ7Nh
         IqN2OxnSyPaddB0xEhdEs0rSnMF0M6WyShKcYcMK8UgAo/+ut4VgCMY/0f6ljygrmQdK
         5qsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794601339; x=1795206139;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HopEjVcKVy5WlPlbnxrcDQWkWX0L0xT3AvRN619hsz4=;
        b=qvc+qT1uYeRjksCr/mYqXZWHlWDJmOpLDWPOfreO2PbFZqBd2RB1isPFvhOwP9iavT
         uK3Xf2Ssd1SFGH7CQkpnbouro4ItLXQrtgTNn8pF+F/WpmuOJxOiVs38WVi9+6sP5nC9
         iKpUg3QCLj1LkP+CpCMPIfZSYFeF9MWoopwZJ/jQLWe+yLd4wjeYOkU5P+QnhyixwK9X
         TfvjJ3CZP4P8zuy6rCUj2YObHaFwe5mvLxDjQBLpGlIUfuPSzCrmIRLU+loI9rPKlxc+
         v2JVYVNceUNRZbmDjAHRf0zptcWQhvSHskX2RHzpCjahI1c9vmrqalhlDLLn5Q1XGAF6
         gv8g==
X-Forwarded-Encrypted: i=1; AL+hErFUDXhd2Gci0nY4hhsXf1xG/X6UFF6QS1mB63ZbrPsQkHQ7nG2svag+HawsA0s+RCpw8Gk=@vger.kernel.org
X-Gm-Message-State: APuU4Z/NAi8zIMGGz6XiYQAe4aUiR6WGP7bqWQGTaj4ZCahihxXG0NMh
	Kg9m5BD0imboTdEhLKJ9cwbw73Y0uroJ3BoMbO2CaifZjAvDJICYqiW0
X-Gm-Gg: AYBFou33tzXgBu4O6ltJQKFWeK5cqa7tdLdgRQpp5U+Nubb8Nxt6iqeYTVP/UT4WXEF
	sc2OHWz47BZbSJCyZcYR3/nucEEWO/sRALCVXw89KixMjnB8aSjOLnOwcGFs64gHjJEMZjiiOsE
	J5wSYdLhZ4GTiLVB471fhWf8pSCdkYO1Rhl9ZhOI96fKnliYrubCyV9yNDa1yvXJ6mNGv2myPY9
	Wrw6azJHjUH0WY/lisLF02gwfOOdKK4ToIZFNekwaLstayMA2BSL1DJr1XXTWwtlgYh4doyg7yy
	eV9tEusR6s6Ug9WcCDhToN1tKWRjafxUj96AblnEN8DhSZm/Y98OoBh4Du0KmMlKFT83WhXF/LR
	a9hUpoPiEpUa2pPa3ksVmK0gKCMSaj5pkxGSuhAA81N7YhHytbBQ7OizWZ8ePtVcBZKn2064Mrg
	zzhQf1aRX5zs1/Oai+NcReK/e/6W7LuswLwR8HpLqh7/QkGUyI/TK61crmOX1H+cbrnNurCHac2
	K8TQegCu75FsHg2O3i45XBeJ+ndnBIdY+++Z9JzhYVHJ0hyyNEewXdwLimOPmydJt6D9KvwSxg1
	Jqr+6QQI+HtbqzokQXqTMT8=
X-Received: by 2002:a05:701b:4587:b0:1b2:6844:25c9 with SMTP id a92af1059eb24-1b5030613dbmr3036601c88.3.1794601338374;
        Fri, 13 Nov 2026 12:22:18 -0800 (PST)
Received: from localhost ([2a03:2880:9ff:67::])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b50316e195sm11098622c88.8.2026.11.13.12.22.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 12:22:18 -0800 (PST)
Date: Fri, 13 Nov 2026 12:21:59 -0800
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Breno Leitao <leitao@debian.org>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Willem de Bruijn <willemb@google.com>, 
	Neal Cardwell <ncardwell@google.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH net-next 2/3] tcp: convert do_tcp_getsockopt() to
 sockopt_t
Message-ID: <avdxYs47SOZHDU-D@devvm16445.scu0.facebook.com>
References: <20261112-getsockopt_phase7-v1-0-1eb759dd0929@debian.org>
 <20261112-getsockopt_phase7-v1-2-1eb759dd0929@debian.org>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261112-getsockopt_phase7-v1-2-1eb759dd0929@debian.org>

On 11/12, Breno Leitao wrote:
> Convert the SOL_TCP switch to sockopt_t. The TCP-AO helpers already
> take one, so they get it directly and the tcp_ao_get_sockptr() bridge
> goes away.
> 
> The options that re-read optlen to get past the sizeof(int) clamp at
> the top take it from sopt->optlen instead, so optlen is read once.
> 
> Only a user buffer reaches TCP_ZEROCOPY_RECEIVE: BPF's sol_tcp_sockopt()
> does not take it, and it maps pages into the caller's mm anyway. It
> keeps checking the bytes past its struct with check_zeroed_user(), now
> on iter_in.ubuf, and a kernel buffer gets -EINVAL.
> 
> tcp_getsockopt() builds the sockopt_t with sockopt_init_user() once the
> level is known to be SOL_TCP, and writes optlen back unconditionally,
> because TCP_SAVED_SYN reports the length it needs and then fails with
> -EINVAL. This mirrors ip_getsockopt().
> 
> Every SOL_TCP getsockopt() now writes optlen, including the ones that
> did not before, such as TCP_REPAIR_WINDOW, TCP_ZEROCOPY_RECEIVE and the
> error returns. An unwritable optlen word therefore turns them into
> -EFAULT.
> 
> The others stored optlen before optval, so an unwritable optlen word
> stopped optval from being written. Now optval is written first.
> 
> sol_tcp_sockopt() and sol_tcp_sockopt_congestion() reach
> do_tcp_getsockopt() through sol_tcp_getsockopt(), which builds the
> sockopt_t with sockptr_to_sockopt() and stores optlen back, as
> sol_ip_sockopt() does.
> 
> copy_to_iter() runs the hardened usercopy check on its source, which
> copy_to_sockptr() skips for a kernel buffer. BPF programs call
> bpf_getsockopt() from the receive softirq too. On the vmapped IRQ
> stack, the check then takes the lock in find_vmap_area(), which is not
> softirq safe, and lockdep reports an inconsistent lock state.
> 
> sol_tcp_getsockopt() therefore calls do_tcp_getsockopt() with page
> faults disabled, which makes check_heap_object() skip that lookup.
> Commit d319f344561d ("mm: Fix copy_from_user_nofault().") added that
> guard for BPF and kprobes.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>
