Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.193
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792794533;
	b=VnAezP/O0RJAAnxm3EtfYVr0MSZWLeV8U2STs5hPk2YRp6Ixa3M7P6pkvaHPyL0vsbLz
	 w1b9/zHB7T6biBLNhPIgQhKk7yorKIWuMUQ8DMDfwJWHJZOYXnzHKScnlD6gTtULFCiOB
	 UKv3pn1QZkp+t3ttMjNap9MGfXtlu2diYT1j4k9/48RzAC1MNp2k8p0ohOU+IgRxVKBD6
	 T9pOvYkwDtFf2hEqfILNz4MXGYhiUcKAh9c/NPfHjDuqGx4FmMAmzMp5vDejKW57oqnE3
	 l2Z1zM6ykLmkluJTa7H1YuXlPyH7SNPWw9Y9eXEpCeTRKU/fHWFVvLmXdeZ0FRBMChA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792794533;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=lERYG3uyAw47Hs3uFjYBtyFNr1OwJXCxC0QuK0OOpeY=;
	b=owNEAQi0Y+yBrlVKrT+jJPe+WmnkD+cEfURC5xDIar2MMnCJp9Hc7ZqfQzBnVxUKqMfX
	 hLfE1WuXZtkKILW5Kh9/efvaGrMVihihZ9eOt8AGeM7btcjICZug5GkZEsE5+kttCfWSq
	 Q122BjJIKv3+ChA0J3pgrRjlxRADevj0s5w0RRq7jnPc6wqgkgX8LNeuWQnoH4FOF17IB
	 OBJ2q8FR1X+KieypL+XGHtONPfjaT67cFtvkhlgukpfNin5NmtdyfrlSHxQAGsOzK6L0s
	 yTemTjnb9VQpJp4AXwmFyNavYbdygmSK3Nw2rSgd77+sWNeeZNn2MP8Batwq0OxKofw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=f+6MYXBd;
	arc=none smtp.remote-ip=95.215.58.193
Received: from mta1.migadu.com (out-193.mta1.migadu.com [95.215.58.193])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C23F606A31A
	for <bpf@vger.kernel.org>; Fri, 23 Oct 2026 22:28:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6C23F606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=f+6MYXBd
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=3flmrgIB54BI9umvSMuyJ9h+zDfDtTwLe2nqZzNViZg=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792794530; v=1; x=1793399330;
 b=f+6MYXBdzFOhvK4cFWNbnheAjBsOETBX7+xJg7ZtjklnzrFYuutdnzHb4mABFIPsc0ECm5dv
 Hn8UWSaMLqCpYqJHGrpUeaDHqnx5MyQtbECcHBqfhi59/mrnEZ0n3nCuzweg+wQDAhiJ8jRLbKf
 ISAObz8n8UYW5FXXz4+OuRzY=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 7020c0f8bf4c5a31;
	Fri, 23 Oct 2026 22:28:50 +0000
X-Mizu-Trace-ID: 7020c0f8bf4c5a31
X-Migadu-Flow: FLOW_OUT
Message-ID: <5225ee82-984b-4150-918c-bb6b9a05096c@linux.dev>
Date: Fri, 23 Oct 2026 15:28:45 -0700
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
Subject: Re: [PATCH bpf-next v2 0/8] bpftool: Per-record CO-RE attributes in
 the C dump
To: Ihor Solodrai <ihor.solodrai@linux.dev>,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman
 <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Quentin Monnet <qmo@kernel.org>
Cc: bpf@vger.kernel.org, Alan Maguire <alan.maguire@oracle.com>,
 Cupertino Miranda <cupertino.miranda@oracle.com>,
 Ian Rogers <irogers@google.com>, "Jose E . Marchesi"
 <jose.marchesi@oracle.com>, Yonghong Song <yonghong.song@linux.dev>,
 David Faust <david.faust@oss.qualcomm.com>
References: <20261023222652.3927736-1-ihor.solodrai@linux.dev>
From: Vineet Gupta <vineet.gupta@linux.dev>
Content-Language: en-US
In-Reply-To: <20261023222652.3927736-1-ihor.solodrai@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

+CC David's new email

On 10/23/26 3:26 PM, Ihor Solodrai wrote:
> bpftool's C dump wraps its output in a clang attribute pragma:
>
>    #pragma clang attribute push (__attribute__((preserve_access_index)), apply_to = record)
>
> GCC-BPF implements preserve_access_index, but not the pragma. Since
> the commit 675b4e24bc50 ("bpf: Temporarily define
> BPF_NO_PRESEVE_ACCESS_INDEX for GCC") the BPF selftests build GCC
> objects with -DBPF_NO_PRESERVE_ACCESS_INDEX, which drops CO-RE from
> vmlinux.h altogether.
>
> This series replaces the pragma with an explicit attribute on each
> record definition, and uses the same mechanism to annotate the context
> types that the verifier rewrites with preserve_static_offset.
>
> Jose proposed per-record attributes in May 2024 [1]. It stalled on a
> requirement from preserve_static_offset (PSO) work [2] to add
> attributes on selected types only, which a fixed string cannot
> express.
>
> BTF decl tags can carry an arbitrary attribute list since commit
> 51d1b1d42841 ("libbpf: Introduce kflag for type_tags and decl_tags in
> BTF"), and btf_dump renders them on record definitions, since
> 76ea31239021 ("libbpf: Render decl_tags in btf_dump"). This allows
> bpftool to put any attribute on any subset of records, with no new
> libbpf API.
>
> [1] https://lore.kernel.org/bpf/20240503111836.25275-1-jose.marchesi@oracle.com/
> [2] https://lore.kernel.org/bpf/20231208000531.19179-1-eddyz87@gmail.com/
>
> ---
>
> v1->v2:
>    * Rename __bpf_core_pai to __bpf_relocatable
>    * Rename __bpf_core_pso to __bpf_static_offset
>    * Use a split BTF to add decl_tags in bpftoo instead of a detached
>      copy (Alexei, Alan)
>      * New patch "libbpf: Look up BTF strings without making BTF
>        modifiable" lets btf__find_str() build its string index without
>        making BTF modifiable
>      * Dropped patch "bpftool: Dump C from a detached BTF copy"
>    * The Clang crash on __builtin_preserve_field_info over PSO types is
>      fixed in LLVM. PSO stays on by default; -D__bpf_static_offset=
>      remains the documented workaround for Clang 18 through 23
>    * GCC-BPF gets __bpf_relocatable from patch #3, so its narrow loads
>      from context types fail verification until patch #4 (bpf-ci bot),
>      left as is
>    * Commit message and documentation rewording
> v1: https://lore.kernel.org/bpf/20261016000012.2232059-1-ihor.solodrai@linux.dev/
>
> ---
>
> Ihor Solodrai (8):
>    libbpf: Look up BTF strings without making BTF modifiable
>    selftests/bpf: Cover unknown BTF header-extension bytes in btf dump
>    bpftool: Apply __bpf_relocatable per record on BTF dump
>    bpftool: Skip __bpf_relocatable on verifier-rewritten context types
>    bpftool: Emit __bpf_static_offset on verifier-rewritten context types
>    selftests/bpf: Cover record attributes in bpftool BTF dumps
>    selftests/bpf: Cover context and socket accesses through vmlinux.h
>    bpftool: Document __bpf_relocatable and __bpf_static_offset
>
>   .../bpf/bpftool/Documentation/bpftool-btf.rst |  24 +++
>   tools/bpf/bpftool/btf.c                       | 154 ++++++++++++++++--
>   tools/lib/bpf/btf.c                           |  36 ++--
>   .../bpf/bpftool_btf_dump_sorted.expected      |  48 +++++-
>   .../bpf/bpftool_btf_dump_unsorted.expected    |  48 +++++-
>   .../bpf/prog_tests/bpftool_btf_dump.c         | 102 +++++++++++-
>   .../selftests/bpf/prog_tests/verifier.c       |   2 +
>   .../bpf/progs/verifier_ctx_rewritten.c        |  59 +++++++
>   8 files changed, 423 insertions(+), 50 deletions(-)
>   create mode 100644 tools/testing/selftests/bpf/progs/verifier_ctx_rewritten.c
>
>
> base-commit: b116ac6087541d3d98031e786adbe9c733cd6df3

