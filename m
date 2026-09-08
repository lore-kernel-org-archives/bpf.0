Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44C9D34F48F
	for <bpf@vger.kernel.org>; Tue,  8 Sep 2026 04:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788842027; cv=pass; b=lDFyK5kjWKhzInDX8sIbpCZhwz8Yl8YGd8jytTIh7mrr3+YvjTXoq9L85wFbipB1T2auWdbKs5LcCFEWZlmODRHnF+eJA0jaKERj/WKkA6nX4VVys9nXVsnLn9/X89kNe/nK/eRrC76mIN41Wib6xwbpsmFJUCQ/ESqNtu8d6qU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788842027; c=relaxed/simple;
	bh=K3YzIKrdp0xHz4kM+Xx1KDKzwy6/7yM8hWsmSrej0v8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pmUWfNbg9fYMbSbQVTwuWcK4fj/T7BmhoXktUqi6seFMFvxSHNwzcDxI5YN2xrKtQZ/gXWpIuISGvdIIilWwJANwYOzcbu8Xv0BU5h325B+eqIHL3w8jvYiGK/dW5ETYFnh7Mf6FGJdgeawa23jFqsnZfHKwMwQMuke/odoGBHc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VgZyQHmG; arc=pass smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VgZyQHmG"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2cc891373e0so43383905ad.2
        for <bpf@vger.kernel.org>; Mon, 07 Sep 2026 21:33:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788842025; cv=none;
        d=google.com; s=arc-20260327;
        b=YVqgC91wxl6Qw1qprYfuR049OfuBVfm8zAMuuUF/zZ4I03Gy0W/C3Qyykby/nE46ho
         CnWthYZviioDi+KqDebbHjN3sLNo1lQND1/G/J8Fx2j6pcx28+SHSDDxo69u53viB/Wi
         seLUv2n/RIwWc0MmBoPt4N4ViPkWC4N6LCB9dLiatt2mC6Ypuxl9d+24ShGbbQwKAjug
         aTOpa3jfiIcmbtH41D4SviUDueZ7807431lZeUsM+45gBb9pqhXcS+EMvCGVzkKe4Y/H
         MGZEcxdDzcIGeNnvgf6grBiI9XzfpKZS26fLB/iX24LrMtFX7+AWekT03Rl2VIn+FHDY
         BGAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Yc9vqmQ6+QNFh35I/TzRT2EaMn55yM+Ti8vxun0EI0U=;
        fh=PiZzXbmd7hJcZtjSouyIc1YrC1qfhJkhey4rD+tta/c=;
        b=CA37tbebrl1hrYTZuewN5ihVzSK6+MOC1dMdWqnztoH2klNQlQ/wWVZC3UNrgJsAx+
         dPjbfZXGRBESqokHl0Wr0al9vV5JBDofgQpdCLISYbX187DaoygauTo+K/iqLAYlZEz6
         Kb8eYmnEFGCoqkbez0RzyrxlnVzoAKXlwW2QZM1eMbHXrL1+sdoaK8qCt9LBD/c/ng2U
         kQuVOqfyb+CE5DngFPZIV285b7siyR8YmFia73XczH3nYlqdUlLlZFKjk9K1f3znhWnl
         3GsmQyMa7HSZQRZiiF23ML5G++kZh43VXHS3imAd+ncNX1vXvyjH3QwMzOgkD5Ozr9Ph
         ox4A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788842025; x=1789446825; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Yc9vqmQ6+QNFh35I/TzRT2EaMn55yM+Ti8vxun0EI0U=;
        b=VgZyQHmGavDTvcxEUWp80oXHDo4esTInkTPjtn2VHj3xGGdGEGl31TG3k5R2fTXa1Y
         bsTBLC86a1pIXiSaY8j2FdprEg//6AosWdf3QtTdBTnD0btQfKq3LFj0+lap1v5aX52S
         O1WCtaqP/BBv0LDRNZscMheeJsfGkHZngbVPNexCtzuXypTMPwor1gfn/eaaZ3N2VkhO
         T5N147Z98hBfiybvciW3yJCc2SpupuaFDs3I+CrJwqt/NQ0MM01iOoadfhjZYav2aN7I
         B6+9qAO7443MR1MyiNyjwOG7a5EsPY2lISSre27f+jziBnvAF/W3cnYlWBe1dQMkNUGj
         lXQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788842025; x=1789446825;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Yc9vqmQ6+QNFh35I/TzRT2EaMn55yM+Ti8vxun0EI0U=;
        b=mLkTgs/74R7d2112l14QlDT83Ue3DbfhvEBQCEL/J68qQjgrrBv3elrkzc38isHAGo
         +Hufxc0Ye+5cgPKQq0fuO1hO+Y9ZScqCJy63uD2x0GGjM49yaPTp37AD2zN8ocuOxi0M
         S+6kyQJdeiVCMHdkNDsVyC7sFY2LJL2iEUHaCwUt7G9y/gHO58BVjO4ESGLCjBCyz/gI
         MnrSQyhZcuspAZcuNrkYTjqd4u5CCK7Kd97ndAgZttXXW2FLCbrdG2jNte6P0AaodlR7
         VfJKk+cbtpH0xRewXoGlhKl9R99eIpfS06eibHLB18Eb9ilYykK0U9bBZsQvfBYDDF0M
         foMA==
X-Gm-Message-State: AFuF++ksKvDkaC39/Jp9zE+2jv78rFEoa4qEmTEIEOtsB0nWZfoeXfw9
	U17ifkirA30McVNXuQpfpqtuEAZPgMvyKhrMfw93auw+Rws5SA/FxkFP3fdcrNhHK/mJKXyO9+2
	W42hdpqbXhJejXOYyx4tzmLW2m59ayXmXtw==
X-Gm-Gg: AYBFou0iwakUP3INxi+y24bzD0fAzWpgwXEW8SGopDarl5KtU4mK+OHCXeihkgf+iWB
	UXH8XZdP0qx8WaOQRhO7PYRib/8E9OEChdrCBLbR3LEr9G8UkxzJ/Ca7K3Nb7cDLAibSoP4zEOb
	IVEXMNWj1yQx1aqfC+IMTjvyrm2+rvB9rmqOnCz3gzdtq2sskKorxTBmMiAsWT0g4+GsrbMLS3Y
	e2OFNU+GYlhdJ6Ycl5kVzYo5tCaaymmSVLPNhTXjxsrZjtbw0Tf2qS8606xxCXtg3gcsZntugLz
	DSPygjhTB7mITyoc8NJAt7owGfZ7e0LxfGtz6lCY5dMlod41ceWljF7v9NvL5vziZ6pGr4Fi/EM
	xiYCpZLncZmaodPB2nB7zibWJ3GPc
X-Received: by 2002:a17:902:fda4:b0:2d9:32ee:7b83 with SMTP id
 d9443c01a7336-2db124b148dmr434362485ad.8.1788842025294; Mon, 07 Sep 2026
 21:33:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260904050957.3976119-1-yonghong.song@linux.dev>
 <20260904051033.3979978-1-yonghong.song@linux.dev> <DL6XUEHAJN3Z.20UKZKTLHI2XZ@gmail.com>
 <f034ac4a-2829-4932-b3f8-b13cee4688a6@linux.dev>
In-Reply-To: <f034ac4a-2829-4932-b3f8-b13cee4688a6@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 7 Sep 2026 21:33:33 -0700
X-Gm-Features: AcwNN1VEx7NPFO41s845Nu-JgkS90Q9HuOj_D5Vdi1fHxSpdM7JsT5vQEs4OcUo
Message-ID: <CAADnVQ+bKmypdfAPXdk9jDN3QedX9EO9YXHFudLu71AR02Z3CQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 07/12] bpf, x86: Place kfunc arguments per the
 SysV calling convention
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 6, 2026 at 1:15=E2=80=AFPM Yonghong Song <yonghong.song@linux.d=
ev> wrote:
>
>
>
> On 9/4/26 4:58 PM, Alexei Starovoitov wrote:
> > On Thu Sep 3, 2026 at 10:10 PM PDT, Yonghong Song wrote:
> >> The JIT hands each eightbyte the BPF calling convention passes an
> >> argument in to the argument position of the same number, registers fir=
st,
> >> so the two conventions agree unless the kernel one places an argument
> >> somewhere else. Compute where SysV wants each eightbyte, and move the
> >> ones that differ before the call.
> >>
> >> SysV disagrees over an argument that the registers left cannot hold: i=
t
> >> moves the whole of it to the stack and leaves the registers to the
> >> arguments that follow, while the BPF convention splits it and keeps
> >> filling slots in order. So for
> >>
> >>    u64 f(u64 a, u64 b, u64 c, u64 d, u64 e, struct pair s);
> >>
> >> the BPF convention puts s in the last argument register and the first
> >> stack slot, while SysV puts it wholly on the stack. Add an argument af=
ter
> >> s and it takes the register s vacated, which makes the moves a cycle, =
so
> >> one value at a time waits in RAX, dead before a call.
> >>
> >> The outgoing argument area is sized for both conventions, as SysV can =
put
> >> on the stack an argument the BPF slots kept in a register, and
> >> bpf_jit_supports_kfunc_arg_slot() can now answer yes to any placement.
> > What is SysV ? This change is about x86-64 ABI.
>
> SysV refers to https://wiki.osdev.org/System_V_ABI#x86-64.
>
> > How come BPF calling convention diverged from x86-64?
>
> Let me explain the calling convention difference between BPF and x86_64.
>
> For x86_64,
>     rdi, rsi, rdx, rcx, r8, r9, <stack...>
> So for
>     foo(long a, __int128 b, __int128 c, __int128 d, __int128 e, long f)
> the register/stack mapping:
>     a:rdi, b:rsi/rdx, c:rcx/r8, d:stack, e:stack, f/r9
>
> For bpf, the abi is simply sequential, e.g. for the above foo()
>     a, b, c, d, e, f // no gap
> For bpf, bar(long a, long b, __int128 c, __int128 d, __int128 e, long f, =
__int128 g)
>     a, b, c, d, e, f, g // no gap
>
> The upstream llvm:
>
> SDValue BPFTargetLowering::LowerCall(TargetLowering::CallLoweringInfo &CL=
I,
>                                       SmallVectorImpl<SDValue> &InVals) c=
onst {
> ...
>    // Walk arg assignments
>    for (size_t i =3D 0; i < OutVals.size(); ++i) {
>      CCValAssign &VA =3D ArgLocs[i];
>      SDValue &Arg =3D OutVals[i];
>
>      // Promote the value if needed.
>      switch (VA.getLocInfo()) {
>      default:
>        report_fatal_error("unhandled location info: " + Twine(VA.getLocIn=
fo()));
>      case CCValAssign::Full:
>        break;
>      case CCValAssign::SExt:
>        Arg =3D DAG.getNode(ISD::SIGN_EXTEND, CLI.DL, VA.getLocVT(), Arg);
>        break;
>      case CCValAssign::ZExt:
>        Arg =3D DAG.getNode(ISD::ZERO_EXTEND, CLI.DL, VA.getLocVT(), Arg);
>        break;
>      case CCValAssign::AExt:
>        Arg =3D DAG.getNode(ISD::ANY_EXTEND, CLI.DL, VA.getLocVT(), Arg);
>        break;
>      }
>
>
>      // Push arguments into RegsToPass vector
>      if (VA.isRegLoc()) {
>        RegsToPass.push_back(std::make_pair(VA.getLocReg(), Arg));
>        continue;
>      }
>
>      if (VA.isMemLoc()) {
>        int Off =3D -8 - VA.getLocMemOffset();
>        if (Off < INT16_MIN) {
>          fail(CLI.DL, DAG, "extra parameter stack depth exceeded limit");
>          break;
>        }
>
>        // STORE_STACK_ARG requires i64 operands. With ALU32 mode, the CC
>        // promotion may only extend to i32, so extend to i64 if needed.
>        if (Arg.getValueType() !=3D MVT::i64)
>          Arg =3D DAG.getNode(ISD::ANY_EXTEND, CLI.DL, MVT::i64, Arg);
>
>        SDValue OffVal =3D DAG.getConstant(Off, CLI.DL, MVT::i64);
>        Chain =3D DAG.getNode(BPFISD::STORE_STACK_ARG, CLI.DL, MVT::Other,=
 Chain,
>                            OffVal, Arg);
>        continue;
>      }
>
>      report_fatal_error("unhandled argument location");
>    }
>
>  From above, for a 16-byte struct e.g. __int128 or struct {long a; long b=
;};
> they can have half in R5 and the other half in Stack. But this is not
> allowed for x86_64.
>
> arm64 has more constraints on top of x86_64. For any 16-byte (or > 8 byte=
)
> argument, the argument must be 16-byte aligned (in registers or in stacks=
).
> For the following example:
>    foo(long a, __int128 b, __int128 c, __int128 d, __int128 e, long f, __=
int128 g)
> the registers/stack:
>    a: x0, b: x2/x3, c: x4/x5, d: x6/x7
>    stack: e (offset 0), f (offset 16), g (offset 32).
>
> > Maybe we should adjust bpf side instead.
>
> We can keep llvm implementation but we can adjust bpf side in kernel.
>
> For x86, if we have a reorder of an argument or a hole in the slots, reje=
ct.
> For arm64, if there is a hole in the slots, reject.
>
> This will simplify jit a lot.

Why cannot we adjust bpf calling convention to match arm64/x86 the best?
Since arm64 is stricter, I'd pick that style.
There are no kfuncs that use int128 or 16+ byte args,
so it's a matter of bpf subprogs calling bpf subprogs.
Seems cleaner to adjust what llvm emits instead of forcing all jits to adap=
t.
