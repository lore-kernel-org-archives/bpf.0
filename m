Received: from mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DC3241D4FE
	for <bpf@vger.kernel.org>; Wed, 14 Oct 2026 06:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791959771; cv=none; b=CQFWSFYto0yJ0Jym0s7HXaVhiQmixZ9d1AysD0A+XcsyJphhjk1ZVi7V3VuM5m+8xZPAbJpjgZRSosQ2qUm7PeKgRXrKUVSCf35pL9XZl3ntiptc+WMjfTkgLjO4DBfoYSK9wp+QGPP3bQz/+M9I9Sgb3NRMI2O3c+lGlS/4WK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791959771; c=relaxed/simple;
	bh=r1gNJIox97LUTwVd1f1r/PVsJ3ok2l4Kv/14nlUYMOA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=T/V/HkO6BIEdgeLZBjeIcOaPz/Znq5D7FkGi2bZo7HQvuzD6BSob4zuLpfglsRr7L70QFEOcbNZHp5njTDjQ21I2/iF0TuIo8dV6au+n71kxcO2C9qDOdyF55He3pgje7NAEMnc5SQzhCv6ehl88ulGea+yTEYtrk5h2sw/ZGks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Cm6wNXUg; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Cm6wNXUg"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=r1gNJIox97LUTwVd1f1r/PVsJ3ok2l4Kv/14nlUYMOA=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791959762; v=1; x=1792564562;
 b=Cm6wNXUgPYg0EWuNxe/dnUTEFxstZAsXKm9+pUTSqTlvxhnOkKjk5Qcif5e0ep4y37EBgoRh
 YQfQvv0EOgNm7OwTk3Ib4ac2pHgLZDrEGBFCUFVhb4TQqdllb3Ew7SaZM7GzxkA3ovOno83UZS8
 +qAOJeFQCTBlTsale0ifrcDA=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 49600eacf981ff5c;
	Wed, 14 Oct 2026 06:36:02 +0000
X-Mizu-Trace-ID: 49600eacf981ff5c
X-Migadu-Flow: FLOW_OUT
Message-ID: <439c15c4-a386-4360-948f-7745860f618d@linux.dev>
Date: Tue, 13 Oct 2026 23:35:59 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v10 00/24] bpf: Run exception cleanup landing
 pads when bpf_unwind() unwinds
From: Yonghong Song <yonghong.song@linux.dev>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
Cc: Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman
 <eddyz87@gmail.com>, kernel-team@fb.com
References: <20261009041447.17092-1-yonghong.song@linux.dev>
 <DM19999Y1AUY.1DBGK5HO3G8QR@gmail.com>
 <514a64b7-9d3e-473d-b85b-b25aef2be151@linux.dev>
Content-Language: en-GB
In-Reply-To: <514a64b7-9d3e-473d-b85b-b25aef2be151@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 10/11/26 10:30 AM, Yonghong Song wrote:
>
>
> On 10/10/26 5:15 PM, Alexei Starovoitov wrote:
>> # CARRIED OVER from the unsent v9 draft (nothing was sent on v9, v10 
>> has only bot fixes). Delete this line, or the file if you dropped it 
>> on purpose.
>> On Thu, Oct 08, 2026 at 09:14 PM Yonghong Song 
>> <yonghong.song@linux.dev> wrote:
>>>    - A subprog an unwind passes through must have an exit.
>>>    - Until the Rust toolchain supports BPF exception handling, the 
>>> selftests
>>>      write their tables by hand in inline asm.
>> rustc can do it already.
>> For example,
>> take RUSTC_BPF from selftests/bpf/Makefile.buildvars, replace
>> panic=abort with panic=unwind, build core, then --emit=llvm-bc and
>> clang -c like Makefile.skel does for progs/*.rs.
>>
>>    #[inline(never)]
>>    fn fail() -> ! { unsafe { bpf_unwind() }; loop {} }
>>
>>    #[inline(never)]
>>    fn check(i: u32) -> u32 { if i > 7 { fail() } i }
>>
>>    pub extern "C-unwind" fn prog(ctx: *const u32) -> u32 {
>>        let _g = RcuReadGuard::new();
>>        check(unsafe { *ctx })
>>    }
>>
>> The object has .bpf_cleanup with the right record and this code:
>>
>>    fail:
>>        call bpf_unwind
>>    L0: goto L0
>>    check:
>>        if w1 > 0x7 goto L0
>>        w0 = w1
>>        exit
>>    L0: call fail
>>    prog:
>>        r6 = r1
>>        call bpf_rcu_read_lock
>>        w6 = *(u32 *)(r6 + 0x0)
>>        w1 = w6
>>        call check
>>        call bpf_rcu_read_unlock
>>        w0 = w6
>>        exit
>>        r6 = r0
>>        call bpf_rcu_read_unlock
>>        r1 = r6
>>        call _Unwind_Resume
>>
>> They won't pass the verifier,
>> because
>> _Unwind_Resume() and fail() don't return, so LLVM emits nothing after
>> the call. check_subprogs() refuses prog() and check() with
>> "last insn is not an exit or jmp".
>> rust-bpf hack adds 'exit' and replaces call with 'call 
>> bpf_unwind_resume'.
>
> The following is what I have:
>
> $ cat exc_review.rs
> #![no_std]
> #![no_main]
> #![feature(lang_items)]
> #![allow(internal_features)]
>
> unsafe extern "C-unwind" {
>     fn bpf_unwind();
> }
>
> unsafe extern "C" {
>     fn bpf_rcu_read_lock();
>     fn bpf_rcu_read_unlock();
> }
>
> struct RcuReadGuard;
>
> impl RcuReadGuard {
>     #[inline(always)]
>     fn new() -> Self {
>         unsafe { bpf_rcu_read_lock() };
>         RcuReadGuard
>     }
> }
>
> impl Drop for RcuReadGuard {
>     #[inline(always)]
>     fn drop(&mut self) {
>         unsafe { bpf_rcu_read_unlock() };
>     }
> }
>
> #[inline(never)]
> #[unsafe(no_mangle)]
> fn fail() -> ! {
>     unsafe { bpf_unwind() };
>     loop {}
> }
>
> #[inline(never)]
> #[unsafe(no_mangle)]
> fn check(i: u32) -> u32 {
>     if i > 7 {
>         fail()
>     }
>     i
> }
>
> #[unsafe(no_mangle)]
> #[unsafe(link_section = "syscall")]
> pub extern "C-unwind" fn prog(ctx: *const u32) -> u32 {
>     let _g = RcuReadGuard::new();
>     check(unsafe { *ctx })
> }
>
> #[panic_handler]
> fn panic(_info: &core::panic::PanicInfo) -> ! {
>     loop {}
> }
>
> #[lang = "eh_personality"]
> extern "C" fn rust_eh_personality() {}
>
> #[used]
> #[unsafe(link_section = "license")]
> static LICENSE: [u8; 4] = *b"GPL\0";
>
> $ cat run.sh
> R=~/.rustup/toolchains/nightly-x86_64-unknown-linux-gnu/bin/rustc
> CL=/home/yhs/work/llvm-project/llvm/build.23/Release/bin
>
> $R -Z unstable-options --print target-spec-json --target 
> bpfel-unknown-none | \
>    sed 's/"obj-is-bitcode": true/"obj-is-bitcode": false/' > 
> bpfel-elf.json
> T=$PWD/bpfel-elf.json; D=$PWD/core-elf; mkdir -p $D
> SRC=$($R --print sysroot)/lib/rustlib/src/rust/library/core/src/lib.rs
> $R -Z unstable-options -Z always-encode-mir -O -C panic=unwind 
> --crate-type rlib \
>    --target $T -A warnings --edition 2024 --crate-name core 
> --emit=metadata --out-dir $D $SRC
> echo '#![feature(compiler_builtins)] #![compiler_builtins] #![no_std]' 
> | \
>    $R -Z unstable-options -O -C panic=unwind --crate-type rlib 
> --target $T -L $D \
>    -A warnings --crate-name compiler_builtins --emit=metadata 
> --out-dir $D -
>
> $R -Z unstable-options -Z function-sections=no -O -C panic=unwind 
> --crate-type rlib \
>    --target $T -L $D --edition 2021 -C debuginfo=2 -C target-cpu=v3 \
>    --emit=asm -s exc_review.s exc_review.rs
>
> and below exc_review.s:
>
> check:
>         if w1 > 7 goto .LBB1_2
>         w0 = w1
>         exit
> .LBB1_2:
>         call fail
> fail:
>         call bpf_unwind
> .LBB2_1:
>         goto .LBB2_1
> prog:
>         r6 = r1
>         call bpf_rcu_read_lock
>         w6 = *(u32 *)(r6 + 0)
>         w1 = w6
>         call check
>         call bpf_rcu_read_unlock
>         w0 = w6
>         exit
>         r6 = r0
>         call bpf_rcu_read_unlock
>         r1 = r6
>         call _Unwind_Resume
>
> So it pretty similar to the above.
>
> However, we have a big issue for BTF.
>
> $ bpftool btf dump file exc_review.bpf.o
> [1] PTR '(anon)' type_id=2
> [2] STRUCT 'PanicInfo' size=24 vlen=4
>         'message' type_id=3 bits_offset=0
>         'location' type_id=4 bits_offset=64
>         'can_unwind' type_id=5 bits_offset=128
>         'force_no_backtrace' type_id=5 bits_offset=136
> [3] PTR '(anon)' type_id=23
> [4] PTR '(anon)' type_id=24
> [5] INT 'bool' size=1 bits_offset=0 nr_bits=8 encoding=BOOL
> [6] FUNC_PROTO '(anon)' ret_type_id=0 vlen=1
>         '_info' type_id=1
> [7] FUNC 'panic' type_id=6 linkage=global
> [8] INT 'u32' size=4 bits_offset=0 nr_bits=32 encoding=(none)
> [9] FUNC_PROTO '(anon)' ret_type_id=8 vlen=1
>         'i' type_id=8
> [10] FUNC 'check' type_id=9 linkage=global
> [11] FUNC_PROTO '(anon)' ret_type_id=0 vlen=0
> [12] FUNC 'fail' type_id=11 linkage=global
> [13] PTR '(anon)' type_id=8
> [14] FUNC_PROTO '(anon)' ret_type_id=8 vlen=1
>         'ctx' type_id=13
> [15] FUNC 'prog' type_id=14 linkage=global
> [16] FUNC_PROTO '(anon)' ret_type_id=0 vlen=0
> [17] FUNC 'rust_eh_personality' type_id=16 linkage=global
> [18] INT 'u8' size=1 bits_offset=0 nr_bits=8 encoding=(none)
> [19] ARRAY '(anon)' type_id=18 index_type_id=20 nr_elems=4
> [20] INT '__ARRAY_SIZE_TYPE__' size=4 bits_offset=0 nr_bits=32 
> encoding=(none)
> [21] VAR '_RNvCs63bSbDYK0Bo_10exc_review7LICENSE' type_id=19, 
> linkage=global
> [22] DATASEC 'license' size=0 vlen=1
>         type_id=21 offset=0 size=4 (VAR 
> '_RNvCs63bSbDYK0Bo_10exc_review7LICENSE')
> [23] FWD 'Arguments' fwd_kind=struct
> [24] FWD 'Location' fwd_kind=struct
>
> There is no BTF for bpf_unwind, bpf_rcu_read_lock, _Unwind_Resume, etc.
>
> In llvm, we have two commits in clang frontend to allow generate 
> extern functions
> BTF. See below:
>   commit e3d8ee35e4ad: reland "[DebugInfo] Support to emit debugInfo 
> for extern variables"
>   commit a2a3ca8d9796: BPF: emit debuginfo for Function of DeclRefExpr 
> if requested
>
> I think the best way is for rustc supports the above two commits.

I hacked rust compiler (https://github.com/rust-lang/rust) and the rust compiler
is able to support to emit btf for extern variables.

The following is a portion of rust example code. Some of them could be simplified
with macro, e.g., for link_section '.ksyms'...

...
unsafe extern "C-unwind" {
     #[link_section = ".ksyms"]
     fn bpf_unwind() -> !;
}

unsafe extern "C" {
     #[link_section = ".ksyms"]
     fn bpf_rcu_read_lock();
     #[link_section = ".ksyms"]
     fn bpf_rcu_read_unlock();
     #[link_section = ".ksyms"]
     fn bpf_preempt_disable();
     #[link_section = ".ksyms"]
     fn bpf_preempt_enable();
     #[link_section = ".ksyms"]
     fn bpf_local_irq_save(flags: *mut u64);
     #[link_section = ".ksyms"]
     fn bpf_local_irq_restore(flags: *mut u64);
}

// LLVM ends each cleanup landing pad with a call to _Unwind_Resume, and libbpf maps that
// extern onto the bpf_unwind_resume kfunc, so it needs BTF in .ksyms like the rest. The
// call reuses this declaration when the module already has one, but rustc only declares
// an extern that is used, and nothing in Rust calls it; the static keeps it referenced.
unsafe extern "C" {
     #[link_section = ".ksyms"]
     fn _Unwind_Resume(exception: *mut c_void);
}

#[used]
static UNWIND_RESUME_ANCHOR: unsafe extern "C" fn(*mut c_void) = _Unwind_Resume;

// One bit per landing-pad Drop. Must match prog_tests/rust_exceptions.c in the kernel tree,
// which runs this program and reads PADS_RAN back out of .bss.
const RAN_FOO3_PREEMPT: u64 = 0x1;
const RAN_FOO2_RCU: u64 = 0x2;
const RAN_FOO2_TRACKER: u64 = 0x4;
const RAN_FOO3_IRQ: u64 = 0x8;

#[no_mangle]
pub static mut PADS_RAN: u64 = 0;

// Volatile, because nothing in the program reads PADS_RAN back: plain stores would be dead.
#[inline(always)]
fn pad_ran(bit: u64) {
     unsafe {
         let p = &raw mut PADS_RAN;
         write_volatile(p, *p | bit);
     }
}

// -- RAII guards --

struct PreemptGuard;

impl PreemptGuard {
     #[inline(always)]
     fn disable() -> PreemptGuard {
         unsafe { bpf_preempt_disable() };
         PreemptGuard
     }
}

impl Drop for PreemptGuard {
     #[inline(always)]
     fn drop(&mut self) {
         unsafe { bpf_preempt_enable() };
         pad_ran(RAN_FOO3_PREEMPT);
     }
}

// The verifier tracks the saved flags by their stack slot, so the owning frame
// builds the guard in place rather than receiving it from a constructor.
struct IrqGuard {
     flags: u64,
}

impl IrqGuard {
     #[inline(always)]
     fn save(&mut self) {
         unsafe { bpf_local_irq_save(&mut self.flags) };
     }
}

impl Drop for IrqGuard {
     #[inline(always)]
     fn drop(&mut self) {
         unsafe { bpf_local_irq_restore(&mut self.flags) };
         pad_ran(RAN_FOO3_IRQ);
     }
}

...

// -- level 2: two invoke regions sharing one landing pad --

#[inline(never)]
#[no_mangle]
pub extern "C-unwind" fn foo2(fail3: bool, fail2: bool, val: u64) -> u64 {
     let _tracker = Tracker;
     let _rcu = RcuGuard::lock();

     let r = foo3(fail3, val);

     if fail2 {
         unsafe { bpf_unwind() };
     }

     black_box(r)
}

// -- level 1: no resources, so no .bpf_cleanup entry --

#[inline(never)]
#[no_mangle]
pub extern "C-unwind" fn foo1(fail3: bool, fail2: bool, val: u64) -> u64 {
     foo2(fail3, fail2, val)
}

#[unsafe(link_section = "syscall")]
#[no_mangle]
pub extern "C-unwind" fn entry(_ctx: *mut u8) -> i32 {
     foo1(black_box(true), black_box(false), black_box(101)) as i32
}

// The verifier only lets a GPL-compatible program call kfuncs.
#[unsafe(link_section = "license")]
#[no_mangle]
static _LICENSE: [u8; 4] = [b'G', b'P', b'L', 0];

// -- unwinding runtime bits --

// Referenced by every function with a landing pad; never called on BPF, where
// the kernel dispatches to the pads itself.
#[lang = "eh_personality"]
extern "C" fn rust_eh_personality() {}

#[lang = "panic_in_cleanup"]
fn panic_in_cleanup() -> ! {
     loop {}
}

The compilation is all from rustc.

The following is the objdump dump:

Disassembly of section .text:
                                                                                                               
0000000000000000 <foo1>:
;     foo2(fail3, fail2, val)
        0:       85 10 00 00 ff ff ff ff call -0x1
                 0000000000000000:  R_BPF_64_32  foo2
; }
        1:       95 00 00 00 00 00 00 00 exit
                                                                                                               
0000000000000010 <foo2>:
; pub extern "C-unwind" fn foo2(fail3: bool, fail2: bool, val: u64) -> u64 {
        2:       bf 37 00 00 00 00 00 00 r7 = r3
        3:       bf 26 00 00 00 00 00 00 r6 = r2
        4:       bf 18 00 00 00 00 00 00 r8 = r1
;         unsafe { bpf_rcu_read_lock() };
        5:       85 10 00 00 ff ff ff ff call -0x1
                 0000000000000028:  R_BPF_64_32  bpf_rcu_read_lock
;     let r = foo3(fail3, val);
        6:       bf 81 00 00 00 00 00 00 r1 = r8
        7:       bf 72 00 00 00 00 00 00 r2 = r7
        8:       85 10 00 00 ff ff ff ff call -0x1
                 0000000000000040:  R_BPF_64_32  foo3
;     if fail2 {
        9:       15 06 02 00 00 00 00 00 if r6 == 0x0 goto +0x2 <L0>
;         unsafe { bpf_unwind() };
       10:       85 10 00 00 ff ff ff ff call -0x1
                 0000000000000050:  R_BPF_64_32  bpf_unwind
       11:       85 10 00 00 ff ff ff ff call -0x1
                 0000000000000058:  R_BPF_64_32  __bpf_trap
<L0>:
;         unsafe { black_box(dummy) }
       12:       7b 0a f8 ff 00 00 00 00 *(u64 *)(r10 - 0x8) = r0
       13:       bf a1 00 00 00 00 00 00 r1 = r10
       14:       07 01 00 00 f8 ff ff ff r1 += -0x8
;         unsafe { bpf_rcu_read_unlock() };
       15:       85 10 00 00 ff ff ff ff call -0x1
                 0000000000000078:  R_BPF_64_32  bpf_rcu_read_unlock
;         write_volatile(p, *p | bit);
       16:       18 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 r1 = 0x0 ll
                 0000000000000080:  R_BPF_64_64  PADS_RAN
       18:       79 12 00 00 00 00 00 00 r2 = *(u64 *)(r1 + 0x0)
       19:       bf 23 00 00 00 00 00 00 r3 = r2
       20:       47 03 00 00 02 00 00 00 r3 |= 0x2
;         unsafe { volatile_store(dst, src) };
       21:       7b 31 00 00 00 00 00 00 *(u64 *)(r1 + 0x0) = r3
;         write_volatile(p, *p | bit);
       22:       47 02 00 00 06 00 00 00 r2 |= 0x6
;         unsafe { volatile_store(dst, src) };
       23:       7b 21 00 00 00 00 00 00 *(u64 *)(r1 + 0x0) = r2
; }
       24:       79 a0 f8 ff 00 00 00 00 r0 = *(u64 *)(r10 - 0x8)
       25:       95 00 00 00 00 00 00 00 exit
       26:       bf 06 00 00 00 00 00 00 r6 = r0
;         unsafe { bpf_rcu_read_unlock() };
       27:       85 10 00 00 ff ff ff ff call -0x1
                 00000000000000d8:  R_BPF_64_32  bpf_rcu_read_unlock
;         write_volatile(p, *p | bit);
       28:       18 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 r1 = 0x0 ll
                 00000000000000e0:  R_BPF_64_64  PADS_RAN
       30:       79 12 00 00 00 00 00 00 r2 = *(u64 *)(r1 + 0x0)
       31:       bf 23 00 00 00 00 00 00 r3 = r2
       32:       47 03 00 00 02 00 00 00 r3 |= 0x2
;         unsafe { volatile_store(dst, src) };
       33:       7b 31 00 00 00 00 00 00 *(u64 *)(r1 + 0x0) = r3
;         write_volatile(p, *p | bit);
       34:       47 02 00 00 06 00 00 00 r2 |= 0x6
;         unsafe { volatile_store(dst, src) };
       35:       7b 21 00 00 00 00 00 00 *(u64 *)(r1 + 0x0) = r2
       36:       bf 61 00 00 00 00 00 00 r1 = r6
       37:       85 10 00 00 ff ff ff ff call -0x1
                 0000000000000128:  R_BPF_64_32  _Unwind_Resume

0000000000000130 <foo3>:
; pub extern "C-unwind" fn foo3(fail: bool, val: u64) -> u64 {
       38:       bf 26 00 00 00 00 00 00 r6 = r2
       39:       bf 17 00 00 00 00 00 00 r7 = r1
;         unsafe { bpf_preempt_disable() };
       40:       85 10 00 00 ff ff ff ff call -0x1
                 0000000000000140:  R_BPF_64_32  bpf_preempt_disable
...
;         unsafe { volatile_store(dst, src) };
       78:       7b 17 00 00 00 00 00 00 *(u64 *)(r7 + 0x0) = r1
       79:       bf 61 00 00 00 00 00 00 r1 = r6
       80:       85 10 00 00 ff ff ff ff call -0x1
                 0000000000000280:  R_BPF_64_32  _Unwind_Resume

0000000000000288 <rust_eh_personality>:
; extern "C" fn rust_eh_personality() {}
       81:       95 00 00 00 00 00 00 00 exit

Disassembly of section syscall:

0000000000000000 <entry>:
;         unsafe { black_box(dummy) }
        0:       b7 01 00 00 01 00 00 00 r1 = 0x1
        1:       73 1a f6 ff 00 00 00 00 *(u8 *)(r10 - 0xa) = w1
        2:       bf a1 00 00 00 00 00 00 r1 = r10
        3:       07 01 00 00 f6 ff ff ff r1 += -0xa
        4:       b7 01 00 00 00 00 00 00 r1 = 0x0
        5:       73 1a f7 ff 00 00 00 00 *(u8 *)(r10 - 0x9) = w1
        6:       bf a1 00 00 00 00 00 00 r1 = r10
        7:       07 01 00 00 f7 ff ff ff r1 += -0x9
        8:       b7 01 00 00 65 00 00 00 r1 = 0x65
        9:       7b 1a f8 ff 00 00 00 00 *(u64 *)(r10 - 0x8) = r1
       10:       bf a1 00 00 00 00 00 00 r1 = r10
       11:       07 01 00 00 f8 ff ff ff r1 += -0x8
;     foo1(black_box(true), black_box(false), black_box(101)) as i32
       12:       79 a3 f8 ff 00 00 00 00 r3 = *(u64 *)(r10 - 0x8)
       13:       71 a2 f7 ff 00 00 00 00 w2 = *(u8 *)(r10 - 0x9)
       14:       71 a1 f6 ff 00 00 00 00 w1 = *(u8 *)(r10 - 0xa)
       15:       85 10 00 00 ff ff ff ff call -0x1
                 0000000000000078:  R_BPF_64_32  foo1
; }
       16:       95 00 00 00 00 00 00 00 exit


$ bpftool btf
  dump file exc_cleanup.o
[1] PTR '(anon)' type_id=2
[2] INT 'u8' size=1 bits_offset=0 nr_bits=8 encoding=(none)
[3] FUNC_PROTO '(anon)' ret_type_id=4 vlen=1
         '_ctx' type_id=1
[4] INT 'i32' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED
[5] FUNC 'entry' type_id=3 linkage=global
[6] INT 'bool' size=1 bits_offset=0 nr_bits=8 encoding=BOOL
[7] INT 'u64' size=8 bits_offset=0 nr_bits=64 encoding=(none)
[8] FUNC_PROTO '(anon)' ret_type_id=7 vlen=3
         'fail3' type_id=6
         'fail2' type_id=6
         'val' type_id=7
[9] FUNC 'foo1' type_id=8 linkage=global
[10] FUNC_PROTO '(anon)' ret_type_id=7 vlen=3
         'fail3' type_id=6
         'fail2' type_id=6
         'val' type_id=7
[11] FUNC 'foo2' type_id=10 linkage=global
[12] FUNC_PROTO '(anon)' ret_type_id=0 vlen=0
[13] FUNC 'bpf_rcu_read_lock' type_id=12 linkage=extern
[14] FUNC_PROTO '(anon)' ret_type_id=0 vlen=0
[15] FUNC 'bpf_unwind' type_id=14 linkage=extern
[16] FUNC_PROTO '(anon)' ret_type_id=0 vlen=0
[17] FUNC '__bpf_trap' type_id=16 linkage=extern
[18] FUNC_PROTO '(anon)' ret_type_id=0 vlen=0
[19] FUNC 'bpf_rcu_read_unlock' type_id=18 linkage=extern
[20] FUNC_PROTO '(anon)' ret_type_id=0 vlen=1
         '(anon)' type_id=21
[21] PTR '(anon)' type_id=0
[22] FUNC '_Unwind_Resume' type_id=20 linkage=extern
[23] FUNC_PROTO '(anon)' ret_type_id=7 vlen=2
         'fail' type_id=6
         'val' type_id=7
[24] FUNC 'foo3' type_id=23 linkage=global
[25] FUNC_PROTO '(anon)' ret_type_id=0 vlen=0
[26] FUNC 'bpf_preempt_disable' type_id=25 linkage=extern
[27] FUNC_PROTO '(anon)' ret_type_id=0 vlen=1
         '(anon)' type_id=28
[28] PTR '(anon)' type_id=7
[29] FUNC 'bpf_local_irq_save' type_id=27 linkage=extern
[30] FUNC_PROTO '(anon)' ret_type_id=0 vlen=1
         '(anon)' type_id=28
[31] FUNC 'bpf_local_irq_restore' type_id=30 linkage=extern
[32] FUNC_PROTO '(anon)' ret_type_id=0 vlen=0
[33] FUNC 'bpf_preempt_enable' type_id=32 linkage=extern
[34] FUNC_PROTO '(anon)' ret_type_id=0 vlen=0
[35] FUNC 'rust_eh_personality' type_id=34 linkage=global
[36] ARRAY '(anon)' type_id=2 index_type_id=37 nr_elems=4
[37] INT '__ARRAY_SIZE_TYPE__' size=4 bits_offset=0 nr_bits=32 encoding=(none)
[38] VAR '_LICENSE' type_id=36, linkage=global
[39] PTR '(anon)' type_id=20
[40] VAR '_RNvCsl8ViJ65pEud_19bpf_exc_cleanup_btf20UNWIND_RESUME_ANCHOR' type_id=39, linkage=global
[41] VAR 'PADS_RAN' type_id=7, linkage=global
[42] DATASEC '.bss' size=0 vlen=1
         type_id=41 offset=0 size=8 (VAR 'PADS_RAN')
[43] DATASEC '.data.rel.ro._RNvCsl8ViJ65pEud_19bpf_exc_cleanup_btf20UNWIND_RESUME_ANCHOR' size=0 vlen=1
         type_id=40 offset=0 size=8 (VAR '_RNvCsl8ViJ65pEud_19bpf_exc_cleanup_btf20UNWIND_RESUME_ANCHOR')
[44] DATASEC '.ksyms' size=0 vlen=9
         type_id=13 offset=0 size=0 (FUNC 'bpf_rcu_read_lock')
         type_id=15 offset=0 size=0 (FUNC 'bpf_unwind')
         type_id=17 offset=0 size=0 (FUNC '__bpf_trap')
         type_id=19 offset=0 size=0 (FUNC 'bpf_rcu_read_unlock')
         type_id=22 offset=0 size=0 (FUNC '_Unwind_Resume')
         type_id=26 offset=0 size=0 (FUNC 'bpf_preempt_disable')
         type_id=29 offset=0 size=0 (FUNC 'bpf_local_irq_save')
         type_id=31 offset=0 size=0 (FUNC 'bpf_local_irq_restore')
         type_id=33 offset=0 size=0 (FUNC 'bpf_preempt_enable')
[45] DATASEC 'license' size=0 vlen=1
         type_id=38 offset=0 size=4 (VAR '_LICENSE')


And I tried the following user space check:

+#define RUST_OBJ_FILE          "progs_rust/exc_cleanup.o"
+
+/* exc_cleanup.rs: one bit per Drop, innermost frame first. */
+#define RUST_RAN_FOO3_PREEMPT  0x1
+#define RUST_RAN_FOO2_RCU      0x2
+#define RUST_RAN_FOO2_TRACKER  0x4
+#define RUST_RAN_FOO3_IRQ      0x8
+
+#define RUST_PADS_RAN                                                  \
+       (RUST_RAN_FOO3_PREEMPT | RUST_RAN_FOO2_RCU | RUST_RAN_FOO2_TRACKER |    \
+        RUST_RAN_FOO3_IRQ)
+
+void test_rust_exceptions(void)
+{
+       char log[8192] = {};
+       LIBBPF_OPTS(bpf_object_open_opts, opts,
+                   .kernel_log_buf = log,
+                   .kernel_log_size = sizeof(log));
+       struct bpf_program *prog;
+       struct bpf_object *obj;
+       struct bpf_map *bss;
+       __u64 pads_ran, ctx = 0;
+       __u32 key = 0;
+       int err;
+
+       LIBBPF_OPTS(bpf_test_run_opts, topts,
+                   .ctx_in = &ctx,
+                   .ctx_size_in = sizeof(ctx),
+       );
+
+       if (access(RUST_OBJ_FILE, R_OK)) {
+               printf("%s:SKIP: no %s, see the comment in %s\n", __func__,
+                      RUST_OBJ_FILE, __FILE__);
+               test__skip();
+               return;
+       }
+
+       obj = bpf_object__open_file(RUST_OBJ_FILE, &opts);
+       if (!ASSERT_OK_PTR(obj, "open"))
+               return;
+
+       err = bpf_object__load(obj);
+       if (err) {
+               if (err == -EOPNOTSUPP &&
+                   strstr(log, "exception cleanup needs a JIT that can dispatch landing pads"))
+                       test__skip();
+               else if (!ASSERT_OK(err, "load"))
+                       fprintf(stderr, "%s", log);
+               goto out;
+       }
+
+       prog = bpf_object__find_program_by_name(obj, "entry");
+       if (!ASSERT_OK_PTR(prog, "find entry"))
+               goto out;
+
+       /* PADS_RAN is the whole of the object's .bss. */
+       bss = bpf_object__find_map_by_name(obj, ".bss");
+       if (!ASSERT_OK_PTR(bss, "find .bss"))
+               goto out;
+
+       err = bpf_prog_test_run_opts(bpf_program__fd(prog), &topts);
+       if (!ASSERT_OK(err, "run"))
+               goto out;
+
+       /* The unwind leaves entry too, and an unwound program returns 0. */
+       ASSERT_EQ(topts.retval, 0, "retval");
+
+       err = bpf_map__lookup_elem(bss, &key, sizeof(key), &pads_ran,
+                                  sizeof(pads_ran), 0);
+       if (!ASSERT_OK(err, "lookup PADS_RAN"))
+               goto out;
+       ASSERT_EQ(pads_ran, RUST_PADS_RAN, "pads_ran");
+out:
+       bpf_object__close(obj);
+}

And it works properly.

>
>> We need to get rid of rust-bpf IR rewrite,
>> so let's try to do so now?

Yes, currently I hacked into rustc compiler with AI help. Will need to
understand better for this.

>
> Yes, the best way is for rustc to support generating proper debuginfo 
> for extern variables.
>
> Alternatively, we use use __kfunc_btf_anchor() thing to force btf 
> generation where
> __kfunc_btf_anchor() has been used in various bpf selftests.
> Use clang to generate a .bc files (with __kfunc_btf_anchor()) and then 
> merge (through llvm-link)
> this .bc file and another .bc file generated from rustc and then 
> finally clang to
> generate .s or .o file. But this seems still a hack. See
>   exceptions_cleanup.c, exceptions_cleanup_fail.c and 
> exceptions_cleanup_shapes.c
>
>
>> 'call _Unwind_Resume' can be replaced by LLVM, by libbpf, or by the 
>> verifier
>> with an exit. I feel that the verifier is right place to do it,
>> but open to suggestions.

I agree, using bpf_unwind_resume() in kernel is a better choice. In libbpf,
we just simply change _Unwind_Resume names to bpf_unwind_resume() to satisfy log's.

>
> Yes, _Unwind_Resume can be replaced with bpf_unwind_resume() kfunc.
> I think we should do libbpf or verifier since llvm has used 
> _Unwind_Resume
> for x86_64, arm64, riscv, powerPC, loongArch, etc.
>
> Currently my patch already used bpf_unwind_resume() in the kernel. In 
> libbpf,
> a little bit code to rename _Unwind_Resume to bpf_unwind_rename for 
> some logs.
>
>>
>> but since rustc doesn't emit debug info for extern fn, so there is no 
>> BTF
>> for _Unwind_Resume, so libbpf may be a better place?
>> Not sure, let's discuss.

Yes, I hacked in rustc and it seems working. I will continue to explore.

>
> The best option is for rustc to support generating extern func debug 
> info.
> But if that is not possible, the libbpf will need to generate btf and 
> amend
> them to the prog btf before loading.
>
>>
>> pw-bot: cr
>
>

