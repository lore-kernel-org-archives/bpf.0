Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.213
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794253604;
	b=o/o9c+kzHyrpGeWrwCkQlXwshV4U8QifckTHns7DsZOd7M6FU49dYiL3LREZtujwvPJQ
	 bSawP1M2KoAbVMJIDUHzL6DRiYQ0a7RfXo8DU1j9mFm4bBG19Vo55rDd7cLkPdnZ+G2zr
	 oRB5d9FlRmQG940lAArKMpMUvcvvENtqVu/FcLOlmvKXLc+cyl9LIK1nhEMLwxk3Aybbr
	 khEQAGyKREpRZbH+VQm04lRiHmlrUU7jynk3UIPDuQPEJJ994U1G5i09RX2N/warzWPj3
	 vRjtwmzMBLiHWAgXVVUB3c/7WajwMNSKNC+Haff4W5owxONdV383P8n2ENxuXheMcpg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794253604;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=qEBa9u+yInBAIiZjw4VsN7vRNVc+Jm7tQI4mTxNp3jo=;
	b=Vw/ber7OZAgSROHnb8hQe6rUNWmDrRvjQt2dyx01Q7EA1FFGOvLatWK3ix7s7mNqYpJb
	 jCJDMi9t6PMn/PULGYhgoDa5aRK0rfvjzZbmca6Sic+lYHnixA1d7MnzGm/LXb9OETOpj
	 MwGQuM6NrI+Xf7Z/AXC+lofHkKL0hOHZr0gv9luyvl1Aw83nneSCapJt1JdlidD2yf24j
	 w2yy851/Qpe8phHKkimVcZw3S/tLI/OepljmOAraXO7I2nKKcPlZuF2SOXf1ndmKuOl0U
	 0wHmWkDNKLLYxvNTK5Pd8BAb+3XlDyi+4q3kETRxXUuv+8dO3xelB1ky7IkHjZDhiJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Nh8itQRj;
	arc=none smtp.remote-ip=91.218.175.213
Received: from mta0.migadu.com (out-213.mta0.migadu.com [91.218.175.213])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E343606A325
	for <bpf@vger.kernel.org>; Mon,  9 Nov 2026 19:46:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0E343606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Nh8itQRj
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=PIjbipDEmK9uXK7APGMPOggxwIyBx+5BzwGbBoTwbE8=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794253601; v=1; x=1794858401;
 b=Nh8itQRjTd0/TuCusCGC7qb22M4+RP/At2u6Nhs+uE0uJY9amvjJz/gswMTRpN1p8aecKz7/
 FIXomRgIIuoJwJ8vChQWQPvw/K2DdenZ3JyJ5EdAiZJIraO6lTis0ohTuuwgvOZxWaQzcyFPhk3
 viKMdOvRjaQkuiRUCm1oMDeY=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 6e2f040e86cc4919;
	Mon, 09 Nov 2026 19:46:40 +0000
X-Mizu-Trace-ID: 6e2f040e86cc4919
X-Migadu-Flow: FLOW_OUT
Message-ID: <f5a22a46-0fd8-4739-bf11-a20e0b3a443b@linux.dev>
Date: Mon, 9 Nov 2026 12:46:34 -0700
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
Subject: Re: [PATCH RFC bpf-next 0/7] bpf: Support struct_ops in light
 skeletons
To: Siddharth Nayyar <sidnayyar@google.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Emil Tsalapatis <emil@etsalapatis.com>, Quentin Monnet <qmo@kernel.org>,
 Shuah Khan <shuah@kernel.org>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Giuliano Procida <gprocida@google.com>,
 Neill Kapron <nkapron@google.com>, =?UTF-8?Q?Thi=C3=A9baud_Weksteen?=
 <tweek@google.com>, Maxime Ripard <mripard@kernel.org>
References: <20261106-lskel-struct-ops-v1-0-a4486ffc79cb@google.com>
Content-Language: en-US
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <20261106-lskel-struct-ops-v1-0-a4486ffc79cb@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/6/26 1:19 PM, Siddharth Nayyar wrote:
> BPF light skeletons (bpftool gen skeleton -L) compile BPF object loading
> into a self-contained BPF_PROG_TYPE_SYSCALL loader program (gen_loader)
> embedded in a C header, removing any runtime dependency on libbpf or
> userspace BTF parsing. Currently, light skeletons do not support
> BPF_MAP_TYPE_STRUCT_OPS maps or BPF_PROG_TYPE_STRUCT_OPS programs
> because preparing a struct_ops map normally relies on libbpf parsing the
> target vmlinux or kernel module BTF in userspace to resolve type IDs,
> struct sizes, member byte offsets, and member indices.
> 
> This series adds BPF_MAP_TYPE_STRUCT_OPS support for link-based
> (SEC(".struct_ops.link")) maps in light skeletons across both vmlinux
> and kernel module BTF targets:
> 
> - Patch 1 adds a new bpf_btf_get_struct_member_info() helper for
>   BPF_PROG_TYPE_SYSCALL programs to query a struct's byte size (when the
>   member name is NULL) or a named member's byte offset and member index
>   from vmlinux or module BTF at load time.
> - Patches 2-5 wire up struct_ops initialization, map creation, program
>   loading, and map update in libbpf's gen_loader. At runtime, the loader
>   program resolves the kernel wrapper type bpf_struct_ops_<name> and
>   target <name> struct BTF IDs (and module BTF FDs) via
>   bpf_btf_find_by_name_kind(), queries struct sizes and member
>   offsets/indices via bpf_btf_get_struct_member_info(), constructs the
>   kernel vdata buffer in the loader data blob, passes the resolved BTF
>   metadata to BPF_MAP_CREATE and BPF_PROG_LOAD, and populates the
>   callback program FDs before issuing BPF_MAP_UPDATE_ELEM.
> - Patch 6 teaches bpftool to generate per-map skel_link_create() attach
>   functions and skel__attach() / skel__detach() plumbing for BPF_F_LINK
>   struct_ops maps in light skeletons, skips gen_st_ops_shadow() so the
>   light skeleton ctx layout is preserved, and rejects non-link
>   struct_ops maps.
> - Patch 7 adds light skeleton struct_ops selftests covering both vmlinux
>   (tcp_congestion_ops) and bpf_testmod (bpf_testmod_ops, including a
>   subset struct with reordered members, scalar fields, detach, and
>   re-attachment).
> 
> Adding a new BPF helper and alternative kfunc approach
> ======================================================
> I am aware that BPF helpers have been frozen for several years in favor
> of kfuncs. I propose adding bpf_btf_get_struct_member_info() as a BPF
> helper (restricted exclusively to BPF_PROG_TYPE_SYSCALL loader programs,
> alongside bpf_btf_find_by_name_kind()) because, to my knowledge, there
> is no better way to enable struct_ops support in light skeletons.
> 
> Before settling on a BPF helper, I explored an alternative approach
> using a kfunc, which hit a roadblock. Calling a kfunc directly from the
> light skeleton loader program is not possible because kfunc calls
> (BPF_PSEUDO_KFUNC_CALL) require the target kfunc's BTF ID in insn->imm
> when the loader program itself is loaded, whereas light skeletons ship
> pre-generated loader bytecode without userspace BTF resolution.

Hi Siddharth,

I don't think a new helper is going to fly.
It's a legacy baggage we are carrying because we can't easily get rid
of it, we don't want to make it heavier.

IIUC the problem is that the BPF instructions of the loader are
supposed to be frozen (signed?), therefore it's not an option to patch
them at load time, as libbpf normally does with kfuncs.

I think the way around this may be teaching the kernel to resolve
kfuncs itself, similar to how it resolves CO-RE relocations?

The call instruction (or a new bpf_core_relo kind) would refer to the
kfunc in the *program* BTF instead of a kernel BTF ID. Early in
bpf_check(), the verifier would look the name up in vmlinux and module
BTF, check prototype compatibility against the local FUNC, and patch
imm/off. The rest of the verifier would see a regular kfunc call.

The loader could then call kfuncs, so your member info query could be
a kfunc, and the programs it loads would resolve kfuncs the same way
libbpf does.

One concern with this may be that we are moving libbpf functionality
into the kernel, which may not be desirable for reasons I haven't
thought of. Not sure.

Andrii, Alexei, wdyt? Any other ideas?



> [...]
