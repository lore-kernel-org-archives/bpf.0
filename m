Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 121AF3B52F4
	for <bpf@vger.kernel.org>; Tue, 11 Aug 2026 15:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786463879; cv=pass; b=XKCCVVdF/NfxScxUs+Ry1G/74sEdAWk/O+lZ8mQkrq99lWsn1iJJ65f65j2zZJtpy37cr3KpO4mMd6I9Sq8Qv5al1ZiQ8sq6AAt8MBCWC+f4ijQTZZUZ9YfW8BcW6vUpGdYLJOb9NqD8ynNP+8mp0OKmHwURdG46M+ke9rqgI2k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786463879; c=relaxed/simple;
	bh=HV9wuqGIDFd3ZMyzbq1fthIEYbweZNdxebq+MuPqJOM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GUm98mvQI7wjEKfvHwpwnQjb/Vi9ucnxaNZhsTnEYnNgp2il2oLElxeQwiZMnCkxHniFzLbMIf1w1ct0r5UQjHeUm7o+18+CWgjMnGUDbNSwgolSZs6NOLqKqUlEm63Nrlxi6zL/nSwhmOeQF9Hhc9sudIdRN3usVpmfDdsqi34=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b3XD4mNM; arc=pass smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b3XD4mNM"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-c16794450aeso134042366b.2
        for <bpf@vger.kernel.org>; Tue, 11 Aug 2026 08:57:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786463876; cv=none;
        d=google.com; s=arc-20260327;
        b=GNnB5aGuC6D/YQT06BUaPOJH5qzk64Zh3/X4g8negXR/rv1UZ2/ilrb9kVe2uQXOxw
         1HHLAqOlQX+YPX29WFFQs9kVb9945RSTT6wKQX+eT1jv6frJ+GcrEeSFWSST4FlyyOtI
         A+6QWC+xbiFMdMOWIFVG/2rSR9vWbccDvANqa9EsfQ4AOESRP1wZxkvJawbRlLAMGNkg
         UnS4sv+grmyqZDRpJ7yQTlY+2LZpvBQCgxFAHhsKCR1j1zgtvj8B8jl9SL88ekpG0ipY
         thm8/CzlRFQGt6imJB5JYaZr37cW8bYxBy275IWmvyXYvBqsRw4OkQALwHS+nUVWMMfZ
         qqAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9E6XQS742nSv1psv7gDwulUbhWFR+956DPCpZ1nmD7k=;
        fh=YtNL2Gpb/UJBgVvoYO3ha4DqoIU6e8xvZay33UuHI9s=;
        b=eXFE+o3kNqRxJ4BZ+zIMzPaCYyqkI7iOVtEP4I6HPp0OlQAx4++H7jsbdw5sVQCj83
         0F8QbSqJ6veR/XemuWMb/S90Nbyz8e6YSJbvEaC/yjqQeNEG3ohY1D+w3lMtFLF+W6V7
         FLwXJ3XmC5+swfmMRei0Lsaiw+3OBWgY40bAnEXn3obcmYhbu9Z9E2M2fw7YeWD7YWsw
         XPX0RCgGowAi4a/jYlfXWNk13IpANwlFXEcdqf7/qSUWkHULp7axxV6YbRXym2VY7HFD
         4zDBkuwh/x0IMgh5wHSJ2qSyAE1pFvuuRaLi7OPVaSz1F1zbEgBRE4PvsJLToJidZ/b7
         Pcpg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786463876; x=1787068676; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9E6XQS742nSv1psv7gDwulUbhWFR+956DPCpZ1nmD7k=;
        b=b3XD4mNMTK7PootocR9SMdE1wesraVkfBQP4i6da4WzM6XKn2C8P5UlEO1viOyoyOv
         QlTYg3ykqG9RPdGj/8zibwRFLhvCL+tb6ijit/UF5NvbkUlrc/kNi3XneHFE79SWUVk7
         gs66+3iMCsEKJAaZm37LIqEmSXVIsxHJ1JionNjJz5yXuWVcVxCBCeeav9sOA+XsnPh4
         2HlcEU+n6uaN4oe8kIwjVDAclQVvSNroIqdPu7kZID7efYqsEZumKHHui2JUHkFy5Pzf
         j7dHgR5OVyfk5XwWS3CTLg1YJfPikVdns0zZdSBD36TewSP7WyojE61x24+1AA2Xplr8
         DG+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786463876; x=1787068676;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9E6XQS742nSv1psv7gDwulUbhWFR+956DPCpZ1nmD7k=;
        b=e4ZlCLXFGaNqM2N0RV/KfxfveNfj7iMvunjs1053KmvcsQMsGeU9ljJVofbk9OQN1U
         GdSzjocne4Ym1I9567TOZ8IWvaR1j1sXYSrKyyqvAligfRFUVjYFDJUDTFhJiUi7UtNz
         oMXAWQwf1NGjG+VJAej/qO3fsRr5elBzgVU3PjtSNaODGlmXK3RKzLNL16dRd7rTGW+M
         f5HHXNwdp9Ho02VU73c+rQTOwv42lraQXCCZg9CyfZGB7/a5KFfBLcL3rqJdCyTGUrQV
         9Nh8zcPjaCKz3woHlCU9YsOtwveF/qaNMR4gGcc/qsuAKpI9OALBjG+GmupQ+9EMVBOz
         ffKw==
X-Forwarded-Encrypted: i=1; AHgh+RrfMZhzDNtm9GGXUAwLieT7MEDlAHTsjrHB0l41yl+M+JDKH77nSS5ZXn7V5qdqUIxq3Yg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZjU4hDH4q4QwDYQfFs9sGuzaWn+lzecQX/rW7M54IK3HZ5Df9
	MUG8a4EnTgaEGamUnK1L4K9863rk/FtOpYrVqJrJ9Wod/Eh+Neq32isBoP5bLjriKvgs5g42FYf
	03nESYaN3KlSKS3VaLFRj8R8LBZlmXdU=
X-Gm-Gg: AR+sD10f3rCH3yvNOjG67BpnlodYoB3PJ8dQ71XCXc0UFG+Yy+o5tKC6UfO4Mb6i+/h
	rtaWa7KOEKKNV9oudWFxiO0CxqMXQGumOVIk42NRSIudRcoedvQ57poNaihyA1clSihQHF1x/dC
	VYxK8Q/CuoDomNOAg1iNMvqPVfRjyyDWq8z7RlrlJpsux6J3k3L5EQUTLCBOmiwhy6uLsVV+KCU
	KLJ5XaJWndckBXYQCA457+Gf9cwwpmmmxlwg+g8SPFBbn6E6MnsRamxrIeYi4grUuJ4vzjz8Em+
	JQhql70fiK84smQ9H1Ke+Tx8vi2ICIqUpEX0tmke2mh1VfEVGuWDmMfQKu/K
X-Received: by 2002:a17:907:3cd5:b0:c12:8b1c:454f with SMTP id
 a640c23a62f3a-c20ec8d8561mr68867466b.2.1786463876063; Tue, 11 Aug 2026
 08:57:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260811131600.506721-1-daniel@iogearbox.net> <20260811131600.506721-6-daniel@iogearbox.net>
In-Reply-To: <20260811131600.506721-6-daniel@iogearbox.net>
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Tue, 11 Aug 2026 16:57:42 +0100
X-Gm-Features: AUfX_mx-dLNlYj99ZI-BxuL4-oIMNerkuXiNM7O-vVizhiJcLPvAKctV_XevxyI
Message-ID: <CANk7y0i547J6gTdCCksWOyy6jj0acb3dyUaVmagvCnQ9N1AGCA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 6/6] selftests/bpf: Add arena fault tests for
 atomics with fetch
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: memxor@gmail.com, eddyz87@gmail.com, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 11, 2026 at 2:16=E2=80=AFPM Daniel Borkmann <daniel@iogearbox.n=
et> wrote:
>
> Add stream_arena_xchg_fault and stream_arena_cmpxchg_fault next to the
> existing read, write and load-acquire fault tests, covering the two
> places a read-modify-write can deposit the old value: src_reg for a
> BPF_XCHG and r0 for a BPF_CMPXCHG. Both cover both halves of the JIT
> bug that left the fetch destination alone when a RMW on an arena pointer
> faulted:
>
>   - the fault has to be reported as a WRITE, and at the address held by
>     the destination register, which __stderr() and test_address() check
>   - the register receiving the fetched value has to be cleared by the
>     fault handler, which the programs check by poisoning it before the
>     atomic and returning it, so __retval(0) fails if it is left untouched
>
> The __stderr() annotation can only wildcard the faulting address since
> the arena base is not known until runtime, hence the two test_address()
> subtests on top, which pin it to the address held by dst_reg rather than
> src_reg.
>
> Note, the atomics are open coded since linux/filter.h cannot be included
> alongside vmlinux.h.
>
>   # LDLIBS=3D-static PKG_CONFIG=3D'pkg-config --static' ./vmtest.sh -- ./=
test_progs -t stream
>   [...]
>   #464/1   stream_arena_fault_address/read_fault:OK
>   #464/2   stream_arena_fault_address/write_fault:OK
>   #464/3   stream_arena_fault_address/load_acquire_fault:OK
>   #464/4   stream_arena_fault_address/xchg_fault:OK
>   #464/5   stream_arena_fault_address/cmpxchg_fault:OK
>   #464     stream_arena_fault_address:OK
>   [...]
>   #466/5   stream_success/stream_arena_write_fault:OK
>   #466/6   stream_success/stream_arena_read_fault:OK
>   #466/7   stream_success/stream_arena_load_acquire_fault:OK
>   #466/8   stream_success/stream_arena_xchg_fault:OK
>   #466/9   stream_success/stream_arena_cmpxchg_fault:OK
>   [...]
>   Summary: 4/22 PASSED, 0 SKIPPED, 0 FAILED
>
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
> ---
>  v1 -> v2:
>    - Updated commit msg wrt test_address structuring
>
>  .../testing/selftests/bpf/prog_tests/stream.c |   4 +
>  tools/testing/selftests/bpf/progs/stream.c    | 101 ++++++++++++++++++
>  2 files changed, 105 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/stream.c b/tools/test=
ing/selftests/bpf/prog_tests/stream.c
> index 15dd3ae2a84b..e4e9374309e2 100644
> --- a/tools/testing/selftests/bpf/prog_tests/stream.c
> +++ b/tools/testing/selftests/bpf/prog_tests/stream.c
> @@ -105,6 +105,10 @@ void test_stream_arena_fault_address(void)
>                 test_address(skel->progs.stream_arena_write_fault, &skel-=
>bss->fault_addr);
>         if (test__start_subtest("load_acquire_fault"))
>                 test_address(skel->progs.stream_arena_load_acquire_fault,=
 &skel->bss->fault_addr);
> +       if (test__start_subtest("xchg_fault"))
> +               test_address(skel->progs.stream_arena_xchg_fault, &skel->=
bss->fault_addr);
> +       if (test__start_subtest("cmpxchg_fault"))
> +               test_address(skel->progs.stream_arena_cmpxchg_fault, &ske=
l->bss->fault_addr);
>
>         stream__destroy(skel);
>  }
> diff --git a/tools/testing/selftests/bpf/progs/stream.c b/tools/testing/s=
elftests/bpf/progs/stream.c
> index cf5533e11f39..00a37933e411 100644
> --- a/tools/testing/selftests/bpf/progs/stream.c
> +++ b/tools/testing/selftests/bpf/progs/stream.c
> @@ -229,6 +229,107 @@ int stream_arena_load_acquire_fault(void *ctx)
>         return val;
>  }
>
> +SEC("syscall")
> +__arch_x86_64
> +__arch_arm64
> +__success __retval(0)
> +__stderr("ERROR: Arena WRITE access at unmapped address 0x{{.*}}")
> +__stderr("CPU: {{[0-9]+}} UID: 0 PID: {{[0-9]+}} Comm: {{.*}}")
> +__stderr("Call trace:\n"
> +"{{([a-zA-Z_][a-zA-Z0-9_]*\\+0x[0-9a-fA-F]+/0x[0-9a-fA-F]+\n"
> +"|[ \t]+[^\n]+\n)*}}")
> +int stream_arena_xchg_fault(void *ctx)
> +{
> +       static const struct bpf_insn xchg_insn =3D {
> +               .code    =3D 0xc3,        /* BPF_STX | BPF_ATOMIC | BPF_W=
 */
> +               .dst_reg =3D 1,           /* BPF_REG_1 */
> +               .src_reg =3D 2,           /* BPF_REG_2 */
> +               .off     =3D 0x7fff,
> +               .imm     =3D 0xe1,        /* BPF_XCHG */
> +       };
> +       struct bpf_arena *ptr =3D (void *)&arena;
> +       u64 user_vm_start, val;
> +
> +       /*
> +        * Prevent GCC bounds warning: casting &arena to struct bpf_arena=
 *
> +        * triggers bounds checking since the map definition is smaller t=
han
> +        * struct bpf_arena. barrier_var() makes the pointer opaque to GC=
C,
> +        * preventing the bounds analysis.
> +        */
> +       barrier_var(ptr);
> +       user_vm_start =3D ptr->user_vm_start;
> +       fault_addr =3D user_vm_start + 0x7fff;
> +       bpf_addr_space_cast(user_vm_start, 0, 1);
> +       /*
> +        * A read-modify-write carrying BPF_FETCH writes to memory, so th=
e fault
> +        * has to be reported as a WRITE from the dst_reg address, but it=
 also
> +        * reads the old value into src_reg, so the exception handler has=
 to
> +        * clear src_reg. Poison it up front, the returned value must be =
0.
> +        */
> +       asm volatile (
> +               "r1 =3D %[user_vm_start];"
> +               "r2 =3D 1;"
> +               ".8byte %[xchg_insn];" /* r2 =3D xchg((u32 *)(r1 + 0x7fff=
), r2) */
> +               "%[val] =3D r2;"
> +               : [val] "=3Dr" (val)
> +               : [user_vm_start] "r" (user_vm_start),
> +                 __imm_insn(xchg_insn, xchg_insn)
> +               : "r1", "r2"
> +       );
> +       return val;
> +}
> +
> +SEC("syscall")
> +__arch_x86_64
> +__arch_arm64
> +__success __retval(0)
> +__stderr("ERROR: Arena WRITE access at unmapped address 0x{{.*}}")
> +__stderr("CPU: {{[0-9]+}} UID: 0 PID: {{[0-9]+}} Comm: {{.*}}")
> +__stderr("Call trace:\n"
> +"{{([a-zA-Z_][a-zA-Z0-9_]*\\+0x[0-9a-fA-F]+/0x[0-9a-fA-F]+\n"
> +"|[ \t]+[^\n]+\n)*}}")
> +int stream_arena_cmpxchg_fault(void *ctx)
> +{
> +       static const struct bpf_insn cmpxchg_insn =3D {
> +               .code    =3D 0xc3,        /* BPF_STX | BPF_ATOMIC | BPF_W=
 */
> +               .dst_reg =3D 1,           /* BPF_REG_1 */
> +               .src_reg =3D 2,           /* BPF_REG_2 */
> +               .off     =3D 0x7fff,
> +               .imm     =3D 0xf1,        /* BPF_CMPXCHG */
> +       };
> +       struct bpf_arena *ptr =3D (void *)&arena;
> +       u64 user_vm_start, val;
> +
> +       /*
> +        * Prevent GCC bounds warning: casting &arena to struct bpf_arena=
 *
> +        * triggers bounds checking since the map definition is smaller t=
han
> +        * struct bpf_arena. barrier_var() makes the pointer opaque to GC=
C,
> +        * preventing the bounds analysis.
> +        */
> +       barrier_var(ptr);
> +       user_vm_start =3D ptr->user_vm_start;
> +       fault_addr =3D user_vm_start + 0x7fff;
> +       bpf_addr_space_cast(user_vm_start, 0, 1);
> +       /*
> +        * Same as the exchange above, except that a BPF_CMPXCHG reads th=
e old
> +        * value into r0 rather than into src_reg, so r0 is the register =
the
> +        * exception handler has to clear. It doubles as the compare valu=
e, but
> +        * the comparison never happens since the access faults first.
> +        */
> +       asm volatile (
> +               "r1 =3D %[user_vm_start];"
> +               "r0 =3D 1;"
> +               "r2 =3D 2;"
> +               ".8byte %[cmpxchg_insn];" /* r0 =3D cmpxchg((u32 *)(r1 + =
0x7fff), r0, r2) */
> +               "%[val] =3D r0;"
> +               : [val] "=3Dr" (val)
> +               : [user_vm_start] "r" (user_vm_start),
> +                 __imm_insn(cmpxchg_insn, cmpxchg_insn)
> +               : "r0", "r1", "r2"
> +       );
> +       return val;
> +}
> +
>  static __noinline void subprog(void)
>  {
>         int __arena *addr =3D (int __arena *)0xdeadbeef;
> --
> 2.43.0
>



Acked-by: Puranjay Mohan <puranjay@kernel.org>

Thanks,
Puranjay
