Received: from mta0.migadu.com (out-166.mta0.migadu.com [91.218.175.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CA091F94F
	for <bpf@vger.kernel.org>; Sun, 11 Oct 2026 17:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791739839; cv=none; b=j/Lkj9RYeWtuuhlYnbu6/lyAVSTr7QKIZ49PCRPOPE/gerYCiowj9MJx3agMEslhNXj1wcNtAiQV8JQqslxlk2cEnmbcuN+U32CdVyTMcXS1mRmeAYgCCqAHK29RQyxkiMJqm3Mnn7CyLdrX6l/ewK3XYctF+QsreRrdXPT1iNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791739839; c=relaxed/simple;
	bh=bqMBD5O3uvLfXmOyS+CPYfehpuT/o82plZXJsXgenqM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gIjBKxVZFcTuzHUI5B70A3+UhTkquPsMFEHq1qojbxbrLjdgpAk7BANC+Pe2+d2mI6Wk8ZMogfv4Y/rDBA2lV+OovK05DGwNSo4oQXbO+xw4zO7P/Y8o0j8/pnX5xdSKvF5IVlrbvF59JRPf3jKEL/aF/1H3yQsajIQzZhrJRNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ld8V0uWk; arc=none smtp.client-ip=91.218.175.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ld8V0uWk"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=bqMBD5O3uvLfXmOyS+CPYfehpuT/o82plZXJsXgenqM=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791739834; v=1; x=1792344634;
 b=ld8V0uWkaiNP4hdF4sGLF1e6BBOn1fk1LpCO5h1H+gZI3zEquHeehkQ7oE3GyYJvq+U+q/w1
 z4gtkffWT4vy+PEd+bG/rK+qAec27WSkdSTcxNXfaws00BWHnj16gUc0uBrtlImDlqBfKxQ9Wv1
 QRbNOkmu/uai3hrIZNc4DjII=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id f8639adb461494ef;
	Sun, 11 Oct 2026 17:30:19 +0000
X-Mizu-Trace-ID: f8639adb461494ef
X-Migadu-Flow: FLOW_OUT
Message-ID: <514a64b7-9d3e-473d-b85b-b25aef2be151@linux.dev>
Date: Sun, 11 Oct 2026 10:30:15 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v10 00/24] bpf: Run exception cleanup landing
 pads when bpf_unwind() unwinds
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
Cc: Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman
 <eddyz87@gmail.com>, kernel-team@fb.com
References: <20261009041447.17092-1-yonghong.song@linux.dev>
 <DM19999Y1AUY.1DBGK5HO3G8QR@gmail.com>
Content-Language: en-GB
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <DM19999Y1AUY.1DBGK5HO3G8QR@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 10/10/26 5:15 PM, Alexei Starovoitov wrote:
> # CARRIED OVER from the unsent v9 draft (nothing was sent on v9, v10 has only bot fixes). Delete this line, or the file if you dropped it on purpose.
> On Thu, Oct 08, 2026 at 09:14 PM Yonghong Song <yonghong.song@linux.dev> wrote:
>>    - A subprog an unwind passes through must have an exit.
>>    - Until the Rust toolchain supports BPF exception handling, the selftests
>>      write their tables by hand in inline asm.
> rustc can do it already.
> For example,
> take RUSTC_BPF from selftests/bpf/Makefile.buildvars, replace
> panic=abort with panic=unwind, build core, then --emit=llvm-bc and
> clang -c like Makefile.skel does for progs/*.rs.
>
>    #[inline(never)]
>    fn fail() -> ! { unsafe { bpf_unwind() }; loop {} }
>
>    #[inline(never)]
>    fn check(i: u32) -> u32 { if i > 7 { fail() } i }
>
>    pub extern "C-unwind" fn prog(ctx: *const u32) -> u32 {
>        let _g = RcuReadGuard::new();
>        check(unsafe { *ctx })
>    }
>
> The object has .bpf_cleanup with the right record and this code:
>
>    fail:
>        call bpf_unwind
>    L0: goto L0
>    check:
>        if w1 > 0x7 goto L0
>        w0 = w1
>        exit
>    L0: call fail
>    prog:
>        r6 = r1
>        call bpf_rcu_read_lock
>        w6 = *(u32 *)(r6 + 0x0)
>        w1 = w6
>        call check
>        call bpf_rcu_read_unlock
>        w0 = w6
>        exit
>        r6 = r0
>        call bpf_rcu_read_unlock
>        r1 = r6
>        call _Unwind_Resume
>
> They won't pass the verifier,
> because
> _Unwind_Resume() and fail() don't return, so LLVM emits nothing after
> the call. check_subprogs() refuses prog() and check() with
> "last insn is not an exit or jmp".
> rust-bpf hack adds 'exit' and replaces call with 'call bpf_unwind_resume'.

The following is what I have:

$ cat exc_review.rs
#![no_std]
#![no_main]
#![feature(lang_items)]
#![allow(internal_features)]

unsafe extern "C-unwind" {
     fn bpf_unwind();
}

unsafe extern "C" {
     fn bpf_rcu_read_lock();
     fn bpf_rcu_read_unlock();
}

struct RcuReadGuard;

impl RcuReadGuard {
     #[inline(always)]
     fn new() -> Self {
         unsafe { bpf_rcu_read_lock() };
         RcuReadGuard
     }
}

impl Drop for RcuReadGuard {
     #[inline(always)]
     fn drop(&mut self) {
         unsafe { bpf_rcu_read_unlock() };
     }
}

#[inline(never)]
#[unsafe(no_mangle)]
fn fail() -> ! {
     unsafe { bpf_unwind() };
     loop {}
}

#[inline(never)]
#[unsafe(no_mangle)]
fn check(i: u32) -> u32 {
     if i > 7 {
         fail()
     }
     i
}

#[unsafe(no_mangle)]
#[unsafe(link_section = "syscall")]
pub extern "C-unwind" fn prog(ctx: *const u32) -> u32 {
     let _g = RcuReadGuard::new();
     check(unsafe { *ctx })
}

#[panic_handler]
fn panic(_info: &core::panic::PanicInfo) -> ! {
     loop {}
}

#[lang = "eh_personality"]
extern "C" fn rust_eh_personality() {}

#[used]
#[unsafe(link_section = "license")]
static LICENSE: [u8; 4] = *b"GPL\0";

$ cat run.sh
R=~/.rustup/toolchains/nightly-x86_64-unknown-linux-gnu/bin/rustc
CL=/home/yhs/work/llvm-project/llvm/build.23/Release/bin

$R -Z unstable-options --print target-spec-json --target bpfel-unknown-none | \
    sed 's/"obj-is-bitcode": true/"obj-is-bitcode": false/' > bpfel-elf.json
T=$PWD/bpfel-elf.json; D=$PWD/core-elf; mkdir -p $D
SRC=$($R --print sysroot)/lib/rustlib/src/rust/library/core/src/lib.rs
$R -Z unstable-options -Z always-encode-mir -O -C panic=unwind --crate-type rlib \
    --target $T -A warnings --edition 2024 --crate-name core --emit=metadata --out-dir $D $SRC
echo '#![feature(compiler_builtins)] #![compiler_builtins] #![no_std]' | \
    $R -Z unstable-options -O -C panic=unwind --crate-type rlib --target $T -L $D \
    -A warnings --crate-name compiler_builtins --emit=metadata --out-dir $D -

$R -Z unstable-options -Z function-sections=no -O -C panic=unwind --crate-type rlib \
    --target $T -L $D --edition 2021 -C debuginfo=2 -C target-cpu=v3 \
    --emit=asm -s exc_review.s exc_review.rs

and below exc_review.s:

check:
         if w1 > 7 goto .LBB1_2
         w0 = w1
         exit
.LBB1_2:
         call fail
fail:
         call bpf_unwind
.LBB2_1:
         goto .LBB2_1
prog:
         r6 = r1
         call bpf_rcu_read_lock
         w6 = *(u32 *)(r6 + 0)
         w1 = w6
         call check
         call bpf_rcu_read_unlock
         w0 = w6
         exit
         r6 = r0
         call bpf_rcu_read_unlock
         r1 = r6
         call _Unwind_Resume

So it pretty similar to the above.

However, we have a big issue for BTF.

$ bpftool btf dump file exc_review.bpf.o
[1] PTR '(anon)' type_id=2
[2] STRUCT 'PanicInfo' size=24 vlen=4
         'message' type_id=3 bits_offset=0
         'location' type_id=4 bits_offset=64
         'can_unwind' type_id=5 bits_offset=128
         'force_no_backtrace' type_id=5 bits_offset=136
[3] PTR '(anon)' type_id=23
[4] PTR '(anon)' type_id=24
[5] INT 'bool' size=1 bits_offset=0 nr_bits=8 encoding=BOOL
[6] FUNC_PROTO '(anon)' ret_type_id=0 vlen=1
         '_info' type_id=1
[7] FUNC 'panic' type_id=6 linkage=global
[8] INT 'u32' size=4 bits_offset=0 nr_bits=32 encoding=(none)
[9] FUNC_PROTO '(anon)' ret_type_id=8 vlen=1
         'i' type_id=8
[10] FUNC 'check' type_id=9 linkage=global
[11] FUNC_PROTO '(anon)' ret_type_id=0 vlen=0
[12] FUNC 'fail' type_id=11 linkage=global
[13] PTR '(anon)' type_id=8
[14] FUNC_PROTO '(anon)' ret_type_id=8 vlen=1
         'ctx' type_id=13
[15] FUNC 'prog' type_id=14 linkage=global
[16] FUNC_PROTO '(anon)' ret_type_id=0 vlen=0
[17] FUNC 'rust_eh_personality' type_id=16 linkage=global
[18] INT 'u8' size=1 bits_offset=0 nr_bits=8 encoding=(none)
[19] ARRAY '(anon)' type_id=18 index_type_id=20 nr_elems=4
[20] INT '__ARRAY_SIZE_TYPE__' size=4 bits_offset=0 nr_bits=32 encoding=(none)
[21] VAR '_RNvCs63bSbDYK0Bo_10exc_review7LICENSE' type_id=19, linkage=global
[22] DATASEC 'license' size=0 vlen=1
         type_id=21 offset=0 size=4 (VAR '_RNvCs63bSbDYK0Bo_10exc_review7LICENSE')
[23] FWD 'Arguments' fwd_kind=struct
[24] FWD 'Location' fwd_kind=struct

There is no BTF for bpf_unwind, bpf_rcu_read_lock, _Unwind_Resume, etc.

In llvm, we have two commits in clang frontend to allow generate extern functions
BTF. See below:
   commit e3d8ee35e4ad: reland "[DebugInfo] Support to emit debugInfo for extern variables"
   commit a2a3ca8d9796: BPF: emit debuginfo for Function of DeclRefExpr if requested

I think the best way is for rustc supports the above two commits.

> We need to get rid of rust-bpf IR rewrite,
> so let's try to do so now?

Yes, the best way is for rustc to support generating proper debuginfo for extern variables.

Alternatively, we use use __kfunc_btf_anchor() thing to force btf generation where
__kfunc_btf_anchor() has been used in various bpf selftests.
Use clang to generate a .bc files (with __kfunc_btf_anchor()) and then merge (through llvm-link)
this .bc file and another .bc file generated from rustc and then finally clang to
generate .s or .o file. But this seems still a hack. See
   exceptions_cleanup.c, exceptions_cleanup_fail.c and exceptions_cleanup_shapes.c


> 'call _Unwind_Resume' can be replaced by LLVM, by libbpf, or by the verifier
> with an exit. I feel that the verifier is right place to do it,
> but open to suggestions.

Yes, _Unwind_Resume can be replaced with bpf_unwind_resume() kfunc.
I think we should do libbpf or verifier since llvm has used _Unwind_Resume
for x86_64, arm64, riscv, powerPC, loongArch, etc.

Currently my patch already used bpf_unwind_resume() in the kernel. In libbpf,
a little bit code to rename _Unwind_Resume to bpf_unwind_rename for some logs.

>
> but since rustc doesn't emit debug info for extern fn, so there is no BTF
> for _Unwind_Resume, so libbpf may be a better place?
> Not sure, let's discuss.

The best option is for rustc to support generating extern func debug info.
But if that is not possible, the libbpf will need to generate btf and amend
them to the prog btf before loading.

>
> pw-bot: cr

