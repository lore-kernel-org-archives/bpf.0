Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C513BADBD;
	Thu, 16 Jul 2026 07:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784187362; cv=none; b=ryRCtUW65RVhePOQQ0dRKJC8QN7CCG1TqaE/kkXFtkMoztt+5AaNf8MsNswLWp/OGED5QCGeBMqHESOAizOegKdJCmw+xo2++boWjs1BHi0ucc0gIQ4+knl/JgazRjYZPXeHqJJ0yUF+r8edG+p3aElBvhjHKFKW/qhyuSg5h34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784187362; c=relaxed/simple;
	bh=OGqKv6lXyy5rBAkr1uv/qWBvT9R0O9rWcZMCpcghbXE=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:From:To:
	 References:In-Reply-To; b=Vj4YsaYuoStcHOFgN/JU7P+YYmtSJ7jEtbBU/OYgdsqQ9T/Y5+ijW/BT9HcGBRzMDpz3oQowL+/1rxnKR8pYXWFYQBsdjfPBGgbYl/JHahybtX/EHufMCytmhrJBYASO642WlU70OV+GxiQaEn6DhxA5r9HhRIP1EMDrOb6d/jQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=0Xb18TN2; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="0Xb18TN2"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id F23501A101E;
	Thu, 16 Jul 2026 07:35:56 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id C2EE760363;
	Thu, 16 Jul 2026 07:35:56 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1815B11BD1CD7;
	Thu, 16 Jul 2026 09:35:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1784187355; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=q9YO09rA/6j8Bztf3pgjcHg1z7vDydo8nps7mvB/RmI=;
	b=0Xb18TN2vpRTPI846+LeDI/oJpkGWcHgCX7ZExpFcRnmowU04L4B7xHUx0j3L2p5Gm+ul+
	PwSxyzrjPVTc6tFEPm7PKAd0yZEaMkjKDknlj/TytPNgZ4PHPq5fg0WgNBP4rN+8DnU//R
	ddcjOSEMiye8ntmvjp140gGNxw25tD8Ux8RcHPFkpZu33qUQAM2kVOZzsPoRLJTL/0K2eu
	NI++q9LDhILLRMFWDBnP06IlxZMAqRTSLIBXDu636lUi1kixe5bGxO+9z/8CQn+KcDFhJG
	AMk1/w6ixarcPHih39yNX0eSzFdbveHjvR2o2LKu8hKCUo6ZDIt8YP9dUR3+XA==
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 16 Jul 2026 09:35:47 +0200
Message-Id: <DJZTMNWA9JGC.1J4BR7LH0OT3V@bootlin.com>
Subject: Re: [PATCH bpf-next v5 10/10] selftests/bpf: add tests to validate
 KASAN on JIT programs
Cc: <ebpf@linuxfoundation.org>, "Bastien Curutchet"
 <bastien.curutchet@bootlin.com>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>, <bpf@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
From: =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
To: "Ihor Solodrai" <ihor.solodrai@linux.dev>,
 =?utf-8?b?QWxleGlzIExvdGhvcsOpIChlQlBGIEZvdW5kYXRpb24p?=
 <alexis.lothore@bootlin.com>, "Alexei Starovoitov" <ast@kernel.org>,
 "Daniel Borkmann" <daniel@iogearbox.net>, "John Fastabend"
 <john.fastabend@gmail.com>, "Andrii Nakryiko" <andrii@kernel.org>, "Martin
 KaFai Lau" <martin.lau@linux.dev>, "Eduard Zingerman" <eddyz87@gmail.com>,
 "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, "Song Liu" <song@kernel.org>,
 "Yonghong Song" <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>,
 "Thomas Gleixner" <tglx@kernel.org>, "Borislav Petkov" <bp@alien8.de>,
 "Dave Hansen" <dave.hansen@linux.intel.com>, <x86@kernel.org>, "H. Peter
 Anvin" <hpa@zytor.com>, "Shuah Khan" <shuah@kernel.org>, "Ingo Molnar"
 <mingo@redhat.com>, "Andrey Konovalov" <andreyknvl@gmail.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260709-kasan-v5-0-1c64af8e4e1e@bootlin.com>
 <20260709-kasan-v5-10-1c64af8e4e1e@bootlin.com>
 <d326caf4-3d43-4880-8081-c21ef9748cdd@linux.dev>
In-Reply-To: <d326caf4-3d43-4880-8081-c21ef9748cdd@linux.dev>
X-Last-TLS-Session-Version: TLSv1.3

On Thu Jul 16, 2026 at 12:35 AM CEST, Ihor Solodrai wrote:
> On 7/9/26 3:01 AM, Alexis Lothor=C3=83=C2=A9 (eBPF Foundation) wrote:
>> Add a basic KASAN test runner that loads and test-run programs that can
>> trigger memory management bugs. The test captures kernel logs and ensure
>> that the expected KASAN splat is emitted by searching for the
>> corresponding first lines in the report, hence validated that the needed
>> instrumentation has been inserted by the JIT compiler before the
>> relevant memory accesses. To allow each test to trigger the expected
>> report, the kernel must run with the kasan_multi_shot configuration.
>>=20
>> The runner covers different cases and settings: in the nominal case, it
>> validates kasan reports on basic instructions (on all supported accesses
>> sizes) but also when report _should not_ be emitted (eg: for accesses on
>> program stack). The runner also comes with a few specialized tests that
>> are then not executed for all sizes/locations:
>> - specific atomic ops
>> - test for instructions involving different verifier states, with some
>>   states flagging memory as stack, and other states as non-stack memory
>> - tests that validate the stack marking shifting when a patch is emitted
>>   by the verifier (zext/rnd_hi32, constant blindind)
>>=20
>> A few of those tests depends on cpuv4 (load_acquire and store_release).
>>=20
>>   # ./test_progs -a kasan
>>   #165/1   kasan/st_1_not_on_stack:OK
>>   #165/2   kasan/st_1_on_stack:OK
>>   #165/3   kasan/st_2_not_on_stack:OK
>>   #165/4   kasan/st_2_on_stack:OK
>>   #165/5   kasan/st_4_not_on_stack:OK
>>   #165/6   kasan/st_4_on_stack:OK
>>   #165/7   kasan/st_8_not_on_stack:OK
>>   #165/8   kasan/st_8_on_stack:OK
>>   #165/9   kasan/stx_1_not_on_stack:OK
>>   #165/10  kasan/stx_1_on_stack:OK
>>   #165/11  kasan/stx_2_not_on_stack:OK
>>   #165/12  kasan/stx_2_on_stack:OK
>>   #165/13  kasan/stx_4_not_on_stack:OK
>>   #165/14  kasan/stx_4_on_stack:OK
>>   #165/15  kasan/stx_8_not_on_stack:OK
>>   #165/16  kasan/stx_8_on_stack:OK
>>   #165/17  kasan/ldx_1_not_on_stack:OK
>>   #165/18  kasan/ldx_1_on_stack:OK
>>   #165/19  kasan/ldx_2_not_on_stack:OK
>>   #165/20  kasan/ldx_2_on_stack:OK
>>   #165/21  kasan/ldx_4_not_on_stack:OK
>>   #165/22  kasan/ldx_4_on_stack:OK
>>   #165/23  kasan/ldx_8_not_on_stack:OK
>>   #165/24  kasan/ldx_8_on_stack:OK
>>   #165/25  kasan/simple_atomic_4_not_on_stack:OK
>>   #165/26  kasan/simple_atomic_4_on_stack:OK
>>   #165/27  kasan/simple_atomic_8_not_on_stack:OK
>>   #165/28  kasan/simple_atomic_8_on_stack:OK
>>   #165/29  kasan/load_acquire_1_not_on_stack:SKIP
>>   #165/30  kasan/load_acquire_1_on_stack:SKIP
>>   #165/31  kasan/load_acquire_2_not_on_stack:SKIP
>>   #165/32  kasan/load_acquire_2_on_stack:SKIP
>>   #165/33  kasan/load_acquire_4_not_on_stack:SKIP
>>   #165/34  kasan/load_acquire_4_on_stack:SKIP
>>   #165/35  kasan/load_acquire_8_not_on_stack:SKIP
>>   #165/36  kasan/load_acquire_8_on_stack:SKIP
>>   #165/37  kasan/store_release_1_not_on_stack:SKIP
>>   #165/38  kasan/store_release_1_on_stack:SKIP
>>   #165/39  kasan/store_release_2_not_on_stack:SKIP
>>   #165/40  kasan/store_release_2_on_stack:SKIP
>>   #165/41  kasan/store_release_4_not_on_stack:SKIP
>>   #165/42  kasan/store_release_4_on_stack:SKIP
>>   #165/43  kasan/store_release_8_not_on_stack:SKIP
>>   #165/44  kasan/store_release_8_on_stack:SKIP
>>   #165/45  kasan/ldx_patched:OK
>>   #165/46  kasan/ldx_patched_on_stack:OK
>>   #165/47  kasan/verifier_paths_stack_and_non_stack:OK
>>   #165/48  kasan/st_blinded:OK
>>   #165     kasan:OK (SKIP: 16/48)
>>   Summary: 1/32 PASSED, 16 SKIPPED, 0 FAILED
>
> That's quite comprehensive, good work!
>
>>=20
>> Signed-off-by: Alexis Lothor=C3=A9 (eBPF Foundation) <alexis.lothore@boo=
tlin.com>
>> ---
>> [...]
>> +
>> +#define MAX_LOG_SIZE		(8 * 1024)
>> +#define READ_CHUNK_SIZE		256
>> +
>> +#define KASAN_PATTERN_SLAB_UAF "BUG: KASAN: slab-use-after-free " \
>> +	"in bpf_prog_%02x%02x%02x%02x%02x%02x%02x%02x_%s"
>> +#define KASAN_PATTERN_REPORT "%s of size %d at addr"
>
> I don't know how feasible that is, but I think it would be good to
> have a test or two for other KASAN errors, like OOB for example.

For the record, I initially started with some real memory issues (with
kfuncks performing both OoB or UaF accesses), but I quickly switched
to the shadow memory tampering method (the poisoning kfunc surgically
modifying shadow memory) as soon as I started struggling to trigger some
cases (eg: pretty hard/close to impossible to trigger a kasan write
fault without the verifier catching it first), and so I got rid in the
process of any real access issue. But I guess I can reintroduce a few
real accesses to make sure that OoB from a prog indeed trigger a report,
even if it does not cover the whole range mentioned in the listing
above.

>> [...]
>> +
>> +SEC("tcx/ingress")
>> +int simple_atomic_on_stack(struct __sk_buff *skb)
>> +{
>> +	struct kasan_write_val val;
>> +
>> +	bpf_kfunc_kasan_poison(&val, sizeof(struct kasan_write_val));
>> +	switch (access_size) {
>> +	case 4:
>> +		__sync_fetch_and_add(&val.data_4, 4);
>> +		break;
>> +	case 8:
>> +		__sync_fetch_and_add(&val.data_8, 8);
>
> It looks like the BPF_FETCH wouldn't execute this way, because the
> result is discarded? And the whole if (is_atomic_fetch) branch in
> do_jit() is also not covered?

Hmmmm, for this prog, clang emits the following:

  c3 1a f4 ff 01 00 00 00 w1 =3D atomic_fetch_add((u32 *)(r10 - 0xc), w1)

and despite the result being discarded, the operation is properly
instrumented and executed in my setup, I see an __asan_store4 check
being instrumented just before the jited "lock xadd $edi,0x4(%rbx)" for
this insn. As a test I tried storing and using the return value to check
the difference in the emitted code, but I get a build error:

  progs/kasan.c:248:13: error: Invalid usage of the XADD return value
    248 |                 old_val =3D __sync_fetch_and_add(&val->data_4, 4)=
;

I'll dig into that. Anyway you're right about is_atomic_fetch, the
branch is not being tested here, I'll fix that.
>
> Maybe it's worth adding a test with __sync_val_compare_and_swap() into
> a poisoned map value, or something of the sort?
>

Thanks,

Alexis

--=20
Alexis Lothor=C3=A9, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

