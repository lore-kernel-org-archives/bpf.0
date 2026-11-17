Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.226.149.37
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794914369;
	b=u0JjvBkD4KmpD1VWAAYsQhpExgzDRRK5Hj+mCJoOJfb8J2pI9hsSOkVDMO8ac28rOyGT
	 DwdCb9+3nM/b3imh4umALqjlt6dIc3YcH7rCBQgCKQOwJMghBWu27nN8Z4q7LWVkDoVbF
	 hytcyAnNZSt6qC7IwNlz/KV5TcbcRdwuDE44AWiCkdA5UwoiyGoz6lzVepSl6lFHrokX3
	 eSgAfiZ6BtRAFDItqgT+p3KugjGVXeVRDnw5ag7+9iR7DYNadAjbzyyCZijh9sHzPOrAR
	 kgZKZJi+cuMW9p0O5rb1tbsYCE3MBm7hY9lEPyGLWCH8M/UZoERw7nFwyAJJp250Scw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794914369;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:From:Subject:To:Cc:References:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=mCqQJNmMZFkW4nsQs73NYaQkmKbHvRdPsyNWIbbsPg4=;
	b=0XZDctsSHMFgQy96G1xJTnhh0RLpF/2C43qOrZUAh4jHppLlqOGiu9PIEdhRdn+G5/0u
	 srcmBwrQcDfH6IGuD0EXgL16EZek8ji0srQiLZ+AGlv15ZyHic5mP82Fd3H8ElBGl+9SJ
	 D4Ow21g0Sv9Lr54hoRaTTkXkuOrHKtxv8syKaRNgKH9PsHGrhyqi5/K0fUIFu9oS5O1i4
	 e468ypjOFxFjm7UQ2qfX9qa3IblVLCJQRd9WfZmf8idIJAlSGBuMERxQlT3nzVas5O53W
	 0YMEgEi+lajkPTOD2MNDSxZfvoNd3sxQ1PCAPBtuI58PoZ5vXAeClO9fgI8/oPOEzLw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=rbox.co;
	spf=pass smtp.mailfrom=rbox.co;
	dkim=pass header.d=rbox.co header.i=@rbox.co header.a=rsa-sha256 header.s=selector1 header.b=YwN54L1u;
	arc=none smtp.remote-ip=185.226.149.37
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE8CC606A334
	for <bpf@vger.kernel.org>; Tue, 17 Nov 2026 11:19:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CE8CC606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=rbox.co header.i=@rbox.co header.a=rsa-sha256 header.s=selector1 header.b=YwN54L1u
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1xTHDg-001Wud-VV; Tue, 17 Nov 2026 12:19:24 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector1; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:
	Cc:To:Subject:From:MIME-Version:Date:Message-ID;
	bh=mCqQJNmMZFkW4nsQs73NYaQkmKbHvRdPsyNWIbbsPg4=; b=YwN54L1ugDlTG8RBWa3bJUSY68
	H76uVsuzvE+yfOftKmOscSXjzujPuebjux1NtdewBSNifWpcmZFjV4PzIoi3KAJdlVRqIxKYAKBZy
	MPxZYd99+2IzggQVHr1pZ9JuDuY62WXHCNlIx75BNIT4d2AZ6T0C68gPZ5paqvah3Mc2zuiMBO2Tb
	x8nMn9bcpvYBzsNIC7hJLogPypTtCbnI8WGg98kAqTDBc33YCVSVH0HeaDa4l652Y03fnSAPpfAMQ
	O+l4sgayeBr0Siz4sTSGR8T4+pcyMqWSoYeMnvtiFni/pNdlzR110ptB/cv/R4uJH4hZQmUlzRwBu
	I5OY/Z1g==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1xTHDa-0005zW-L6; Tue, 17 Nov 2026 12:19:18 +0100
Received: by submission02.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1xTHDZ-005o4G-AZ;
	Tue, 17 Nov 2026 12:19:17 +0100
Message-ID: <5efc22be-a517-4587-8e43-609bc876b54f@rbox.co>
Date: Tue, 17 Nov 2026 12:19:15 +0100
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
From: Michal Luczaj <mhal@rbox.co>
Subject: Re: [PATCH bpf v1] selftests/bpf: Fix CO-RE relocation of anonymous
 unions for bpf-gcc
To: Jiayuan Chen <jiayuan.chen@linux.dev>, bpf@vger.kernel.org, ast@kernel.org
Cc: Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Emil Tsalapatis <emil@etsalapatis.com>,
 Ihor Solodrai <ihor.solodrai@linux.dev>, Shuah Khan <shuah@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, Sechang Lim
 <rhkrqnwk98@gmail.com>, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20261117094544.148437-1-jiayuan.chen@linux.dev>
Content-Language: pl-PL, en-GB
In-Reply-To: <20261117094544.148437-1-jiayuan.chen@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/17/26 10:45, Jiayuan Chen wrote:
> bpf-gcc fails to load test_trace_iter_unix:
> 
>   Error: #766/6 verifier_sockmap_mutate/test_trace_iter_unix
>   libbpf: elf: skipping section(3) .data (size 0)
>   libbpf: elf: skipping unrecognized data section(18) .comment
>   run_subtest:PASS:obj_open_mem 0 nsec
>   libbpf: prog 'test_trace_iter_unix': relo #0: insn #0 (LDX/ST/STX) accesses field incorrectly. ...
>   libbpf: prog 'test_trace_iter_unix': BPF program load failed: -EINVAL
>   libbpf: prog 'test_trace_iter_unix': failed to load: -EINVAL
>   libbpf: failed to load object 'verifier_sockmap_mutate'
>   run_subtest:PASS:unexpected_load_success 0 nsec
>   validate_msgs:FAIL:1014 expect_msg
>   VERIFIER LOG:
>   =============
>   0: R1=ctx() R10=fp0
>   ;  @ verifier_sockmap_mutate.c:124
>   0: <invalid CO-RE relocation>
>   failed to resolve CO-RE relocation <byte_off> [4] struct bpf_iter__unix (0:0 @ offset 0)
>   processed 1 insns (limit 1000000) max_states_per_insn 0 total_states 0 peak_states 0 mark_read 0
>   =============
>   EXPECTED   SUBSTR: 'cannot update sockmap in this context'
> 
> GCC only applies preserve_access_index to types that carry the attribute
> themselves. The anonymous union holding the sock pointer doesn't, so the
> CO-RE access stops at the union ("0:0") instead of reaching the pointer
> ("0:0:0"), and libbpf rejects the relocation. Mark the unions too.
> 
> Fixes: e16c83fa764f ("selftests/bpf: Add negative test for sockmap update from non-sockmap iter")
> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> ---
>  tools/testing/selftests/bpf/progs/verifier_sockmap_mutate.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/progs/verifier_sockmap_mutate.c b/tools/testing/selftests/bpf/progs/verifier_sockmap_mutate.c
> index 1516fe1524bb..68b1a5323470 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_sockmap_mutate.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_sockmap_mutate.c
> @@ -16,13 +16,13 @@ struct sock {
>  struct bpf_iter__sockmap {
>  	union {
>  		struct sock *sk;
> -	};
> +	} __attribute__((preserve_access_index));
>  } __attribute__((preserve_access_index));
>  
>  struct bpf_iter__unix {
>  	union {
>  		struct sock *unix_sk;
> -	};
> +	} __attribute__((preserve_access_index));
>  } __attribute__((preserve_access_index));
>  
>  struct {

What about dropping the unions?

-struct sock {
-} __attribute__((preserve_access_index));
-
 struct bpf_iter__sockmap {
-       union {
-               struct sock *sk;
-       };
+       struct sock *sk;
 } __attribute__((preserve_access_index));

 struct bpf_iter__unix {
-       union {
-               struct sock *unix_sk;
-       };
+       struct sock *unix_sk;
 } __attribute__((preserve_access_index));

Works under clang.

