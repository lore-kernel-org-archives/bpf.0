Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794409388;
	b=04XaTxZdCBt4MDcYEDHd6U3+yxRyRXA2DMNNO1MhadCbDdlqLH8b7SEtMpSqXxiz6xRc
	 8KKtieMVxlYfGLdHFHrKfWXiDgpKTjud/hBurGnSxFkUAKkBWZB8ENo8nUjYVOWTOlx0M
	 P6E+34k7BCJwahdqefALTuGtOyz/hiaTJs5DmNgL+Eyjs0PpoILtpwztJ7LXtOtY5j1rE
	 Nl6fOfB6XYnL9ejelsw1F2l0nzP5OHY2l5yzslBLCe2oU6ytQ+IRZtJLdiviqBks+kZKH
	 qecpn5V8z49Dw8CxiQHKI9hrRf4scdxveCU9Kowm4h1zseQqBXMklCMXTWiV5EgWgRQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794409388;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=zY9qkPq4UWHB4KqiLgHLBILRCHQoafymdwJhzC8Rif8=;
	b=3PlJJ8LOuAL3WQAf3Z2CoQuB9BX+ldNtAn09fSj+Ov84s0QYOdBzce/+yJWNRdpJBAIK
	 Ct1N0odKPxy4E0EINThPswHTzIJo7gpRvlGm0F+A46BXxj2vIT9v3bwYzzadMRJqa1Y++
	 OR4aSNjDpg8WdQ79BWdwlYtAdq+NN6rWwLQfEWFqKrZMKq64B3xvmA/EFFo+iHcuZGj6z
	 C9jruChbeFAUTM7FMBzJtl+I6kCyasIqJWdz0IPQvM0JjYArlAsw/+dSuIeswZZSn+kiD
	 ps3UwtVBnV3EgEx74gPRq37Gu1E9+ZxkafaT0Ps/i2ysDxGKdte1ay9yaGFHfHyR3lA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hzIqcLoM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C45EB606B201;
	Wed, 11 Nov 2026 15:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hzIqcLoM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D0601F00A05;
	Wed, 11 Nov 2026 15:03:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794409388;
	bh=zY9qkPq4UWHB4KqiLgHLBILRCHQoafymdwJhzC8Rif8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=hzIqcLoMSvWECh5078hr0ZGVTbqsmHqndNPk0MuLRdKZN/CjOsGUi5+p/YCSVpo42
	 LfDmZf/4Mtfa1tjQapz6Nq3/EFAz1ozTTSU7TgLY5G6ohxcpuNHjlY++ChbLVuCoX3
	 E4ZBzVldxtVM2JJQxbgx4i9zA2umENJ2QOMP96KyX++jneMqvlNanhZ2CogeDB3aJU
	 fKBD6YNb2HKiRPBPJHQ1REaWybiv4S/RrdeKVluebON9NP8ZfJWzyJef6U1t5GnSWV
	 Gp335HFERj5EGlaCa9TzNSwl4h7p7bWTKeFiaTP+WBU7JuPYFEuhcJTSIwimxvKVA9
	 gbxnoRk+r7N0Q==
Message-ID: <8963886e-f000-4d25-a5a9-04ad0163e7ac@kernel.org>
Date: Wed, 11 Nov 2026 15:03:04 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next] bpftool: Skip cgroups removed during cgroup tree
 walk
To: thamrinjonathan@gmail.com, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Emil Tsalapatis <emil@etsalapatis.com>,
 Ihor Solodrai <ihor.solodrai@linux.dev>,
 Roman Gushchin <roman.gushchin@linux.dev>, Jakub Kicinski <kuba@kernel.org>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261111-bpftool-cgroup-tree-enoent-v1-1-f3bfcddb4f3d@gmail.com>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <20261111-bpftool-cgroup-tree-enoent-v1-1-f3bfcddb4f3d@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

2026-11-11 12:17 UTC+0700 ~ Jonathan Bastari Thamrin via B4 Relay
<devnull+thamrinjonathan.gmail.com@kernel.org>
> From: Jonathan Bastari Thamrin <thamrinjonathan@gmail.com>
> 
> When a cgroup is removed after being found by nftw(), open() or
> cgroup_has_attached_progs() in do_show_tree_fn() returns ENOENT.
> This is treated as a fatal error so the walk stops and the rest of
> the tree isn't listed. This is common on systemd hosts as
> transient scopes are created and removed all the time.
> 
> With "systemd-run --user --scope true" running in a loop, the walk
> fails within a few hundred runs:
> 
>   Error: can't query bpf programs attached to /sys/fs/cgroup/user.slice/user-1000.slice/user@1000.service/app.slice/run-p126141-i75408.scope: No such file or directory
> 
> Treat ENOENT as the cgroup being gone and continue the walk. With
> this patch, 2000 runs in a row complete without error.
> 
> Link: https://github.com/libbpf/bpftool/issues/159
> Fixes: 2058b38371d0 ("bpftool: introduce cgroup tree command")
> Signed-off-by: Jonathan Bastari Thamrin <thamrinjonathan@gmail.com>
> ---
> The ENODEV originally reported in #159 was fixed by 98b303c9bf05
> ("bpftool: Query only cgroup-related attach types"). This fixes the
> ENOENT race that still breaks cgroup tree on bpftool v7.6.0.

Looks good to me, thank you for the fix.

Acked-by: Quentin Monnet <qmo@kernel.org>
