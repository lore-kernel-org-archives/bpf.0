Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794491682;
	b=PTkfYqRc85BYGoO6QH4JK/eGsqd4Vx2UYFMlRCL5AJTz3EJlMvahA8hKOVqTfQvZeKeU
	 LCCxnq1dfXQT0rOpgojqtmycHNgmrqNRZf6GSXgGgcVtHkKSvVTEassZ10Ntd7j9Bdg41
	 jPU1HcER2Dj82KUX8YnGAVko25fFuR8Q+orPmnUBS5VM96O7rcUH8YaGPEbXkPB+rYUlv
	 nxrfmGaM3m8XIBiDKBXJ6kxByG2nsfQA+dURYyNpZ6fDXzg9oHcSpQ+r4bNsOsufzFor7
	 Ma4QS1GRNydELeaEylnVSfZ4phza8ScSCChOiFFmi0uT/vFK/IjYFrOwV26QdmNvOXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794491682;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=GJzpU18PpbltGnIbSo/mDFrOgiPvvS/9/MBenbJHib4=;
	b=NKFLCoczUMtqSkI/G5FcEijmLqyTCTlf76ynS39jnt6BdIDx5x+UH1f/YPqNX3lN67H+
	 JJku6Vn5gvi8eMcuv3VG7PSPQTuy37W4DWfbQRFs27URe/jaFDnQGFY7sakW6amWded8c
	 M4K7UPKNldUDFdqBSkzTKnzy4eBDoTFA204ZH1wQheofM7YeGzYkn5M7NAPWmvllUmxFE
	 jY2EdPaQPUVV4t7k/NQX7+Jxnrp21JmnVFOmkQWB/OC4Rk4qXVxQAmD00+nSPAQdSO4l+
	 Ci5saWXzyeozSAq18v9aDi8AukTzoUIAwrsl7j5nNyg9DyneoMFeeWMBnNzGU5Pk3yQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=debian.org;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.128.180
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F183606A338
	for <bpf@vger.kernel.org>; Thu, 12 Nov 2026 13:54:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1F183606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-8b3a332105bso9211807b3.1
        for <bpf@vger.kernel.org>; Thu, 12 Nov 2026 05:54:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794491681; x=1795096481;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GJzpU18PpbltGnIbSo/mDFrOgiPvvS/9/MBenbJHib4=;
        b=DdPG9sdsTxKToOMACJfJvzDdzsNWdFUsypqIyOGQE/o88rva8i/f8Dr0B9rU4HBiwi
         oKpfU1TxAHxUbQB4MK81Mp0gfm7Tyi2p6Jb3GWpIuhk3IgHsBwo4JyICAQKi3y9OD9JY
         LppXHIlRr18eodgJ0HbX6SARI0Ibzn3BE5m/elpAYIEAP59Ex7kPmt4VAKdrsjqMwvZO
         yaHs0nFDO4NUfFYPx8Sc5SpsaqtOvkHZxcF1cl5hJ88yAiUqztIi0jHbmy4RfVqRjk4P
         4KnLBhqiuMV1klCRbPz6xOZcez8NhkbwsmGpAnj/bsHdv9sbpXTh2/uesiR1QN/dGGf9
         rHdw==
X-Forwarded-Encrypted: i=1; AL+hErEqhREmi/I14CX7dluItCNSirCCFyoZlH0Q6o6iL/eRU0hDLoZjoScdc7C1YlgOo5wifP8=@vger.kernel.org
X-Gm-Message-State: APuU4Z985JjcuEAcPQMsi2OOzrlH5iZAS+1Kr72BIO4o3INQVmTwkCcQ
	FBL+VmtRrAqJ7CJaoGU8+LUq6SGHYRT7a6hTMS0EbmC9FxE2pQy06LtBHe4A8A==
X-Gm-Gg: AYBFou0P/m5gfNUuuYTtorGJbDeE2GDsTkYbxT1NCN81u3VgbsM4tAUH/8/QFDBHNVV
	BdB3Hn5L7wHCW1DgrlwktpjJTDMQqBZwAgraME8oumw0b6DwI8RVfD4Nkehj7cWYobW72zVv3Js
	teL/Vy1ObTUZKdUNe3AyAfDMcT/oxlk+Rv+DdWR3SvkMv77ezDDYOLxPGNTHgbAwdcPwkGF7htu
	TAqpYj4GtNwT9jbHPKFkHuStR/8HUjnkfU1kYfUXfmJIRKCJLg0xBgdMNkX8RVKVhkZ0hq+dhKC
	mjPYLo/ZKBC+bb9zDNoLurVYRv7jeK5GxGgV4DFWHblZGeEJDa+C7GFdzVBFDURbICjgYRWQH0N
	rQNP5kAqi3KW88Yz6uiYLLTa7Vn2HSpkzURo4KYY7cchFt3k4XdwvHDXyqv62Yt4hwQP9IS/sq5
	9ZpUe2ckGJADak4Fz5O3Qq08rudt4Csv23U3R4len61MGazoVbW/gF0zkPQcwDH/q5Nf/i3Zj0O
	UWrWv+G38kdv+UWWtrYd+pR/Gks+s1pzEEk7pvx0j9iRn+k9nE/CZ3rICMF9uZTPazC/P/RnjVL
	60GV6lobMW9wk0yElMXu
X-Received: by 2002:a05:690c:c4e6:b0:87e:645c:182b with SMTP id 00721157ae682-8b3baf09b42mr17315587b3.26.1794491681204;
        Thu, 12 Nov 2026 05:54:41 -0800 (PST)
Received: from gmail.com ([2a03:2880:24ff:42::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b3933e0d01sm70407067b3.22.2026.11.12.05.54.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 05:54:40 -0800 (PST)
Date: Thu, 12 Nov 2026 05:54:38 -0800
From: Breno Leitao <leitao@debian.org>
To: Alan Maguire <almagui@kernel.org>
Cc: Yonghong Song <yonghong.song@linux.dev>, 
	Alan Maguire <alan.maguire@oracle.com>, Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>, 
	dwarves@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH dwarves] btf_encoder: Keep the source prototype of kfuncs
Message-ID: <avXE70_JpiqemxzV@gmail.com>
References: <20261111222447.322978-1-yonghong.song@linux.dev>
 <ffd8e847-6a3f-4403-a33c-1b3804e1c039@kernel.org>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ffd8e847-6a3f-4403-a33c-1b3804e1c039@kernel.org>

Hello Alan,

On Thu, Nov 12, 2026 at 12:36:29PM +0000, Alan Maguire wrote:
> > Reported-by: Breno Leitao <leitao@debian.org>
> 
> I'm having trouble reproducing the original failure; would you mind sharing
> the config that reproduces it? I tried with clang 22, but no luck so far.

This reproduces it on x86_64, with next-20261111, clang 22.1.3 and
pahole master (9eb594d):

    # make LLVM=1 x86_64_defconfig
    # ./scripts/config -e BPF_SYSCALL -e BPF_JIT -e CGROUP_BPF \
            -d DEBUG_INFO_NONE -e DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT \
            -e DEBUG_INFO_BTF -e KCSAN -e UBSAN -e WERROR
    # make LLVM=1 olddefconfig
    # make LLVM=1 -j$(nproc) vmlinux
    [...]
      BTF     .tmp_vmlinux1
    WARN: resolve_btfids: no BTF func for kfunc bpf_tcp_ops_set_rcvlowat in bpf_tcp_ops_set_rcvlowat_kfunc_set
    WARN: resolve_btfids: unresolved symbol bpf_tcp_ops_set_rcvlowat
    Failed to generate BTF for vmlinux

let me know if you are not able to, and I will send you my full .config

Thanks,
--breno
