Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE8C143F0BB
	for <bpf@vger.kernel.org>; Wed, 15 Jul 2026 22:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784154947; cv=none; b=uExEpzXtjx7Psmc1KZoNRDsa6niusvp9n5/vs3URyRUa0YQ7kDjFWfGtDxngj1O74HOqCH4jwwq3KIVtA+wZw08rS+E2BTEYkKNJVy1mTiEowCP2ITdu0K81boyx87c/pFddFLxoMOWfnfPxL5JMvi5OcmzdSx/N+2WQp2H1qns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784154947; c=relaxed/simple;
	bh=SDsZdw6OMSNqS29Bbj+Cm8FUJaBh4xusjt5qSIOht9g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P6DYoy0TKxjZ9i9h9VC+LFnubkMM9FFJ7fzZvm5uzFTHijWHD+tNzGfJxMuCwjVWCD11Bj4OtRKpLRV1ZfJ9GDCdW0l5EQNQ/oUm8oVddDFEo6T/vLVur/zRbf19Pv92N657gTJlraiTsP9gg4Q9jXO9PEl6vadrFTvROSv7Hsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=iYmhV0Dl; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="iYmhV0Dl"
Message-ID: <d326caf4-3d43-4880-8081-c21ef9748cdd@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784154943;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bAl/tZhe92Vx98Y5GuS5KBzuHkCzcmMeO9fblaVAisA=;
	b=iYmhV0Dl38ZI1TQxO2ccbqLGdv9IIVDNaIBRxJWsgSaJLDzbETw2fGhu4acwOEANr4LlSy
	Y5QBJta0f52rFnXwVAcmqXWFQcAzoEDa8cp3JuYICzPcJVW4rMJIkWTQlzyg/XnONsGujc
	m2nc0LoJSGRgUYRorRw8Lmk8Dwsak6Y=
Date: Wed, 15 Jul 2026 15:35:35 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v5 10/10] selftests/bpf: add tests to validate
 KASAN on JIT programs
To: =?UTF-8?Q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?=
 <alexis.lothore@bootlin.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Thomas Gleixner <tglx@kernel.org>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, Shuah Khan <shuah@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Andrey Konovalov <andreyknvl@gmail.com>
Cc: ebpf@linuxfoundation.org,
 Bastien Curutchet <bastien.curutchet@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20260709-kasan-v5-0-1c64af8e4e1e@bootlin.com>
 <20260709-kasan-v5-10-1c64af8e4e1e@bootlin.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <20260709-kasan-v5-10-1c64af8e4e1e@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 7/9/26 3:01 AM, Alexis LothorÃ© (eBPF Foundation) wrote:
> Add a basic KASAN test runner that loads and test-run programs that can
> trigger memory management bugs. The test captures kernel logs and ensure
> that the expected KASAN splat is emitted by searching for the
> corresponding first lines in the report, hence validated that the needed
> instrumentation has been inserted by the JIT compiler before the
> relevant memory accesses. To allow each test to trigger the expected
> report, the kernel must run with the kasan_multi_shot configuration.
> 
> The runner covers different cases and settings: in the nominal case, it
> validates kasan reports on basic instructions (on all supported accesses
> sizes) but also when report _should not_ be emitted (eg: for accesses on
> program stack). The runner also comes with a few specialized tests that
> are then not executed for all sizes/locations:
> - specific atomic ops
> - test for instructions involving different verifier states, with some
>   states flagging memory as stack, and other states as non-stack memory
> - tests that validate the stack marking shifting when a patch is emitted
>   by the verifier (zext/rnd_hi32, constant blindind)
> 
> A few of those tests depends on cpuv4 (load_acquire and store_release).
> 
>   # ./test_progs -a kasan
>   #165/1   kasan/st_1_not_on_stack:OK
>   #165/2   kasan/st_1_on_stack:OK
>   #165/3   kasan/st_2_not_on_stack:OK
>   #165/4   kasan/st_2_on_stack:OK
>   #165/5   kasan/st_4_not_on_stack:OK
>   #165/6   kasan/st_4_on_stack:OK
>   #165/7   kasan/st_8_not_on_stack:OK
>   #165/8   kasan/st_8_on_stack:OK
>   #165/9   kasan/stx_1_not_on_stack:OK
>   #165/10  kasan/stx_1_on_stack:OK
>   #165/11  kasan/stx_2_not_on_stack:OK
>   #165/12  kasan/stx_2_on_stack:OK
>   #165/13  kasan/stx_4_not_on_stack:OK
>   #165/14  kasan/stx_4_on_stack:OK
>   #165/15  kasan/stx_8_not_on_stack:OK
>   #165/16  kasan/stx_8_on_stack:OK
>   #165/17  kasan/ldx_1_not_on_stack:OK
>   #165/18  kasan/ldx_1_on_stack:OK
>   #165/19  kasan/ldx_2_not_on_stack:OK
>   #165/20  kasan/ldx_2_on_stack:OK
>   #165/21  kasan/ldx_4_not_on_stack:OK
>   #165/22  kasan/ldx_4_on_stack:OK
>   #165/23  kasan/ldx_8_not_on_stack:OK
>   #165/24  kasan/ldx_8_on_stack:OK
>   #165/25  kasan/simple_atomic_4_not_on_stack:OK
>   #165/26  kasan/simple_atomic_4_on_stack:OK
>   #165/27  kasan/simple_atomic_8_not_on_stack:OK
>   #165/28  kasan/simple_atomic_8_on_stack:OK
>   #165/29  kasan/load_acquire_1_not_on_stack:SKIP
>   #165/30  kasan/load_acquire_1_on_stack:SKIP
>   #165/31  kasan/load_acquire_2_not_on_stack:SKIP
>   #165/32  kasan/load_acquire_2_on_stack:SKIP
>   #165/33  kasan/load_acquire_4_not_on_stack:SKIP
>   #165/34  kasan/load_acquire_4_on_stack:SKIP
>   #165/35  kasan/load_acquire_8_not_on_stack:SKIP
>   #165/36  kasan/load_acquire_8_on_stack:SKIP
>   #165/37  kasan/store_release_1_not_on_stack:SKIP
>   #165/38  kasan/store_release_1_on_stack:SKIP
>   #165/39  kasan/store_release_2_not_on_stack:SKIP
>   #165/40  kasan/store_release_2_on_stack:SKIP
>   #165/41  kasan/store_release_4_not_on_stack:SKIP
>   #165/42  kasan/store_release_4_on_stack:SKIP
>   #165/43  kasan/store_release_8_not_on_stack:SKIP
>   #165/44  kasan/store_release_8_on_stack:SKIP
>   #165/45  kasan/ldx_patched:OK
>   #165/46  kasan/ldx_patched_on_stack:OK
>   #165/47  kasan/verifier_paths_stack_and_non_stack:OK
>   #165/48  kasan/st_blinded:OK
>   #165     kasan:OK (SKIP: 16/48)
>   Summary: 1/32 PASSED, 16 SKIPPED, 0 FAILED

That's quite comprehensive, good work!

> 
> Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>
> ---
> [...]
> +
> +#define MAX_LOG_SIZE		(8 * 1024)
> +#define READ_CHUNK_SIZE		256
> +
> +#define KASAN_PATTERN_SLAB_UAF "BUG: KASAN: slab-use-after-free " \
> +	"in bpf_prog_%02x%02x%02x%02x%02x%02x%02x%02x_%s"
> +#define KASAN_PATTERN_REPORT "%s of size %d at addr"

I don't know how feasible that is, but I think it would be good to
have a test or two for other KASAN errors, like OOB for example.


> [...]
> +
> +SEC("tcx/ingress")
> +int simple_atomic_on_stack(struct __sk_buff *skb)
> +{
> +	struct kasan_write_val val;
> +
> +	bpf_kfunc_kasan_poison(&val, sizeof(struct kasan_write_val));
> +	switch (access_size) {
> +	case 4:
> +		__sync_fetch_and_add(&val.data_4, 4);
> +		break;
> +	case 8:
> +		__sync_fetch_and_add(&val.data_8, 8);

It looks like the BPF_FETCH wouldn't execute this way, because the
result is discarded? And the whole if (is_atomic_fetch) branch in
do_jit() is also not covered?

Maybe it's worth adding a test with __sync_val_compare_and_swap() into
a poisoned map value, or something of the sort?

> +		break;
> +	}
> +	bpf_kfunc_kasan_unpoison(&val, sizeof(struct kasan_write_val));
> +	return 0;
> +}
> +
> +SEC("tcx/ingress")
> +int simple_atomic_not_on_stack(struct __sk_buff *skb)
> +{
> +	struct kasan_write_val *val;
> +	__u32 key = 0;
> +
> +	val = bpf_map_lookup_elem(&test_map, &key);
> +	if (!val)
> +		return 0;
> +
> +	bpf_kfunc_kasan_poison(val, sizeof(struct kasan_write_val));
> +	switch (access_size) {
> +	case 4:
> +		__sync_fetch_and_add(&val->data_4, 4);
> +		break;
> +	case 8:
> +		__sync_fetch_and_add(&val->data_8, 8);
> +		break;
> +	}
> +	bpf_kfunc_kasan_unpoison(val, sizeof(struct kasan_write_val));
> +	return 0;
> +}
> +
> [...]
> 

