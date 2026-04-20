Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF8013CFF48
	for <bpf@vger.kernel.org>; Mon, 20 Apr 2026 20:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776716744; cv=pass; b=s8vbyfu9Z4uOSNODmxYc/fmbsETFXptJLtor9veDfW0TTLAWjkeMkEidkIoUXV3kTfRWfbCp5zfanSl1w8JBaUCyTQMSPD5/jCy3StzXItOFWDcmAONFfdEel6ZDBkSSM3bdqg13JRBuXTeT9fUxBD6Dsj93d3EOAFGa71wNDRU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776716744; c=relaxed/simple;
	bh=sdWCQEXIQS5bBfBg72yd1+Dh+OHFA9Rfjm+8luZNvAk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cdBU48uSVlbVxWPZQmj+hCPLPaf/CZpB5al7CiRgYjPYNY0BXStRBnf22DZ5YMuOGiomwEO7zolJm/gY0gh4ZLwAa+1AWSi8vgACd6rHXOgnCbJlr049vvbeGRuiYZxU0phw9WSi6NGsG/8liDQtR5lNwp3uJb8f/iMj616RNr0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fckvQtOy; arc=pass smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fckvQtOy"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-674a44b84fcso3130284a12.1
        for <bpf@vger.kernel.org>; Mon, 20 Apr 2026 13:25:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776716741; cv=none;
        d=google.com; s=arc-20240605;
        b=FCxSOtMw5tIa1/2AOfwvPaa9SX9Txl4dw6TCe0+EgtMRJ2fC3xQIH4dXu+7ymhE63R
         kAp2b4kFe6wyjiTeTtD2FjXuBaKEuLqlCPRFzjQxtp0O0FtzS87PltNvmtXdz45dieYS
         bbDpj9MZomJQm3KQKbShKLbGlXpC71W5OaM/D49zPcMru8pgKNJG7etsJui3zd1gCiEN
         RYfhTSwUYOzCTOkqmOEXl/e2nDIyGIx9wQC3xNtOoPcHQr+ROqNUgIMhHsaZewW43rxc
         CKF/RMrnghgHkg5qJIC6zbmb+3JVUIGKZ/dfDWDVCTbR/eddlahqviGhzJsbTQ0I1JtL
         ESbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8rKhjMi3E3WcIpH7aVaoCazgmuS985YswoJthnSUvmQ=;
        fh=PvYPcwWkAFTdNDlHuRMEXK4H0X8YFjGgiYsXgOFIKvA=;
        b=KH1zc1gl7u3FpRsM/z5up4Ql61Jahz9wUkYVS3PhSZ5KNN/1xibNYXaHh3FbSrRnQh
         WPj8aLtAxCZZNmRsdX3rzn5L3Sr9Qdlv0YoxLK0juOtqgZTus1ZSdcoTi5EtXPgroecg
         jFvVpuq2qlKhEwiFVJ0aFT3f/4Uh1NVdROtOW9SjcZfiLaxBb0rvU5B1egLS2QOfJgwH
         nqC16hTADakHv2G4tYOfxdarmo6RhRokLjw6u55Y7lWsW5tSJxP/gnRXIzm5VnGEtsnK
         W+kPl2mb10uKOzJFhDqGTZEEQ34NVLGIhwPVMNkXTpLZ/cTmWC15mrI3fvG78dUzBC6F
         TDPQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776716741; x=1777321541; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8rKhjMi3E3WcIpH7aVaoCazgmuS985YswoJthnSUvmQ=;
        b=fckvQtOyJ/nnKusEVIJrfIIWe+P4NvqhpJm9EDhE5LZLuDpOIEMqDsMYX8jO0UFJIt
         h+nal/o93HIG+lgfaVgcXdTeZwy2cBC1wn2DZX4nT3OndoUfigoPVMAhZ7pTtPZH+I9A
         uSUBWEEOEBfUpRMCsD1WEvond8Pr5i36gOtiJR64HM23AufsHqEsnLs6aoA0QwAOCzdf
         gP14XG3KLz1a2M4OMEF2BXdmMdGCkCfIoQ7w5thLOVlSb1EXEg4Rhfl4NGXVRM67J+PL
         ZmQLa0T+1xHyAfCFDc4NcZeCAW1ZHBYOUmN5LXyllSfzjRbgzG1D1pO+22zCeVwrn2fX
         waxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776716741; x=1777321541;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8rKhjMi3E3WcIpH7aVaoCazgmuS985YswoJthnSUvmQ=;
        b=a0rp3gLt/kdtr4Jzbz8lKJUNGmTs8dWWZDNVl9qQQ+xTDq8REkifgCGiTe46NrNYag
         Z2fQ7WMRfreBqYC1U+hymGa10ON6LJvUZdiG2tPdJ7027nwyxqSKOZZje1BT/XlJwuJS
         XeFkCOM4KOlJof8QfUKl9jUpueR6QyO3gX3O12vmkIIGagP2ZPR+AzGU4qntmLi7QR7A
         ZyXJPCsM9y7KUbn6uSlv2kN+0jPZbSvTnf2dk+o+35RP8xupAYeJNP3g2aIuGT4Wn3xC
         q2tKjPKq0I2gXqhEhmFT+YlVX8K7h5uJzxMsXbXwXSffPMN0H+o1yAupqycdXoTOlrcC
         oOxw==
X-Gm-Message-State: AOJu0YzBKq+Iz5wIlplwdehG97yN4SvUspTHr63NrTDnoKWsqKwUu4R1
	RaVi3c656AQG1Olp7JucABaYbaCRi7i/fueih3uqZY0IBxcVKk7oHBCOdjc702dKaKCdQSNT2le
	G+cRRXQ5syE+RJOmZkjGrJU2j+J+Bs13Z51YO
X-Gm-Gg: AeBDievgjsxQhX1oGdET4rx+kGYg4FKrWfhqxNgLpmFkupOcP/RKItFS31+S/q/qXPt
	O5wJ3BazznmDMxbCzJ6DFIfAYn2jtIeJxCPG7h8vjj7zEcyijCTHjBXH2VgSUsLtyVMd11rNhdk
	vhntgWehI8vNOb/+yKneklpH0LY3Li2tRO+z18y9qKfYk6eRiYieE7esBaR0/b1zRwSGmaEAeQJ
	fsanrFTWbk7huf1IlP2NB2ynfVD3IgZYU48RW/4pOOPVaXLaHaRPLpJXcr/8ZgMzlttCgSqP8p1
	dQu4s/0iI7n0XKQ4kcvnbgc1aICzCcy7lw==
X-Received: by 2002:a05:6402:17c8:b0:676:98a0:1c8d with SMTP id
 4fb4d7f45d1cf-67698a01e82mr702866a12.1.1776716740802; Mon, 20 Apr 2026
 13:25:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260419163316.731019-1-yonghong.song@linux.dev>
 <m2mryx1vwi.fsf@kernel.org> <21aad67d-97b8-4ffd-8b4a-747ee8b917be@linux.dev>
In-Reply-To: <21aad67d-97b8-4ffd-8b4a-747ee8b917be@linux.dev>
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Mon, 20 Apr 2026 21:25:25 +0100
X-Gm-Features: AQROBzBrllsMIVZkR_w_r614JWM8WwSO1jv9HWhn7nG8LwpdR51QUFjCcH_7D0Q
Message-ID: <CANk7y0iU-u2=Rmi88DbHz_L87ERpXvUR0EormKqo==9KPh0MvQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6 00/17] bpf: Support stack arguments for BPF
 functions and kfuncs
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"Jose E . Marchesi" <jose.marchesi@oracle.com>, kernel-team@fb.com, 
	Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 20, 2026 at 9:23=E2=80=AFPM Yonghong Song <yonghong.song@linux.=
dev> wrote:
>
>
>
> On 4/20/26 8:41 AM, Puranjay Mohan wrote:
> > Yonghong Song <yonghong.song@linux.dev> writes:
> >
> >> Currently, bpf function calls and kfunc's are limited by 5 reg-level
> >> parameters. For function calls with more than 5 parameters,
> >> developers can use always inlining or pass a struct pointer
> >> after packing more parameters in that struct although it may have
> >> some inconvenience. But there is no workaround for kfunc if more
> >> than 5 parameters is needed.
> >>
> >> This patch set lifts the 5-argument limit by introducing stack-based
> >> argument passing for BPF functions and kfunc's, coordinated with
> >> compiler support in LLVM [1]. The compiler emits loads/stores through
> >> a new bpf register r11 (BPF_REG_PARAMS) to pass arguments beyond
> >> the 5th, keeping the stack arg area separate from the r10-based progra=
m
> >> stack. The current maximum number of arguments is capped at
> >> MAX_BPF_FUNC_ARGS (12), which is sufficient for the vast majority of
> >> use cases.
> >>
> >> All kfunc/bpf-function arguments are caller saved, including stack
> >> arguments. For register arguments (r1-r5), the verifier already marks
> >> them as clobbered after each call. For stack arguments, the verifier
> >> invalidates all outgoing stack arg slots immediately after a call,
> >> requiring the compiler to re-store them before any subsequent call.
> >> This follows the native calling convention where all function
> >> parameters are caller saved.
> >>
> >> The x86_64 JIT translates r11-relative accesses to RBP-relative
> >> native instructions. Each function's stack allocation is extended
> >> by 'max_outgoing' bytes to hold the outgoing arg area below the
> >> callee-saved registers. This makes implementation easier as the r10
> >> can be reused for stack argument access. At both BPF-to-BPF and kfunc
> >> calls, outgoing args are pushed onto the expected calling convention
> >> locations directly. The incoming parameters can directly get the value
> >> from caller.
> >>
> >> To support kfunc stack arguments, before doing any stack arguments,
> >> existing codes are refactored/modified to use bpf_reg_state as much
> >> as possible instead of using regno, and to pass a non-negative argno,
> >> encoded to support both registers and stack arguments, as a single
> >> variable.
> >>
> >> Global subprogs with >5 args are not yet supported. Only x86_64
> >> is supported for now.
> >>
> >> For the rest of patches, patches 1-4 make changes to make it
> >> easy for future stack arguments for kfuncs. Patches 5-8
> >> supports bpf-to-bpf stack arguments. Patch 9 rejects interpreter
> >> for stack arguments. Patch 10 rejects subprogs if tailcall reachable.
> >> Patch 11 adds stack argument support for kfuncs. Patch 12 enables
> >> stack arguments for x86_64 and Patch 13 implements the x86_64 JIT.
> >> Patches 14-16 are some test cases.
> >>
> >>    [1] https://github.com/llvm/llvm-project/pull/189060
> >>
> >> Note:
> >>    - The patch set is on top of the following commit:
> >>      eb0d6d97c27c  Merge tag 'bpf-fixes' of git://git.kernel.org/pub/s=
cm/linux/kernel/git/bpf/bpf
> >>    - This patch set requires latest llvm23 compiler. It is possible th=
at a build
> >>      failure may appear:
> >>        /home/yhs/work/bpf-next/scripts/mod/modpost.c:59:13: error: var=
iable 'extra_warn' set but not used [-Werror,-Wunused-but-set-global]
> >>               59 | static bool extra_warn;
> >>                  |             ^
> >>            1 error generated.
> >>      In this case, the following hack can workaround the build issue:
> >>        --- a/Makefile
> >>        +++ b/Makefile
> >>        @@ -467,7 +467,7 @@ KERNELDOC       =3D $(srctree)/tools/docs/k=
ernel-doc
> >>         export KERNELDOC
> >>
> >>         KBUILD_USERHOSTCFLAGS :=3D -Wall -Wmissing-prototypes -Wstrict=
-prototypes \
> >>        -                        -O2 -fomit-frame-pointer -std=3Dgnu11
> >>        +                        -O2 -fomit-frame-pointer -std=3Dgnu11 =
-Wno-unused-but-set-global
> >>         KBUILD_USERCFLAGS  :=3D $(KBUILD_USERHOSTCFLAGS) $(USERCFLAGS)
> >>         KBUILD_USERLDFLAGS :=3D $(USERLDFLAGS)
> >>
> >> Changelogs:
> >>    v5 -> v6:
> >>      - v5: https://lore.kernel.org/bpf/20260417034658.2625353-1-yongho=
ng.song@linux.dev/
> >>      - Do stack arguments invalidation after bpf function or kfunc all=
. This is to
> >>        following native achitecture calling convention.
> >>      - Fix some r11 related issues in const_fold, liveness and insn ch=
ecking.
> >>      - Fix a few places for precision marking for stack arguments. All=
 these cases
> >>        have const value and mark them as precise.
> >>      - Unconditionally copy some incoming/outgoing stat.
> >>      - Fix a missing tailcall case with main prog having tailcall and =
there is no
> >>        other subprog's.
> >>      - Add and fix tests as suggested in v5.
> >>      - Reorder some patches, e.g., preparing stack arguments in bpf fu=
nctions,
> >>        disabling JIT, before allowing proper r11 usage.
> >>    v4 -> v5:
> >>      - v4: https://lore.kernel.org/bpf/20260412045826.254200-1-yonghon=
g.song@linux.dev/
> >>      - Use r11 instead of r12, llvm also updated with r11.
> >>      - Change int type 'reg_or_arg' to u32 'argno' where 'argno' encod=
es to support
> >>        both bpf registers and stack arguments.
> >>      - Track per-state bitmask 'out_stack_arg_mask' for r11 based stor=
es, so at any
> >>        particular call, it knows what stores are available. This is im=
portant since
> >>        stores may be in different basic block.
> >>      - Previously after each call, all store slots are invalidated. Th=
is patches
> >>        disabled such invalidation.
> >>      - Ensure r11 reg only appearing in allowed insns. Also avoid r11 =
for reg tracking
> >>        purpose.
> >>      - Make stack_arg_regs more similar to regular reg's (struct bpf_r=
eg_state *)..
> >>      - Reorder r11 based stores from 'arg6:off:-24, arg7:off:-16, arg8=
:off:-8" to
> >>        "arg6:off:-8, arg7:off:-16, arg8:off:-24".
> >>      - Add a few more tests, including e.g., two callee's with differe=
nt number of
> >>        stack arguments, shared r11-stores in different branches, etc.
> >>
> >>    v3 -> v4:
> >>      - v3: https://lore.kernel.org/bpf/20260405172505.1329392-1-yongho=
ng.song@linux.dev/
> >>      - Refactor/Modify codes to make it easier for later kfunc stack a=
rgument support
> >>      - Invalidate outgoing slots immediately after the call to prevent=
 reuse
> >>      - Fix interaction between stack argument PTR_TO_STACK and dead sl=
ot poisoning
> >>      - Reject stack arguments if tail call reachable
> >>      - Disable private stack if stack argument is used
> >>      - Allocate outgoing stack argument region after callee saved regi=
sters, and this
> >>        simplifies the JITed code a lot.
> >>    v2 -> v3:
> >>      - v2: https://lore.kernel.org/bpf/20260405165300.826241-1-yonghon=
g.song@linux.dev/
> >>      - Fix selftest stack_arg_gap_at_minus8().
> >>      - Fix a few 'UTF-8' issues.
> >>    v1 -> v2:
> >>      - v1: https://lore.kernel.org/bpf/20260402012727.3916819-1-yongho=
ng.song@linux.dev/
> >>      - Add stack_arg_safe() to do pruning for stack arguments.
> >>      - Fix an issue with KF_ARG_PTR_TO_MEM_SIZE. Since a faked registe=
r is
> >>        used, added verification log to indicate the start and end of s=
uch
> >>        faked register usage.
> >>      - For x86_64 JIT, copying incoming parameter values directly from=
 caller's stack.
> >>      - Add test cases with stack arguments e.g. mem, mem+size, dynptr,=
 iter, etc.
> >>
> >> Yonghong Song (17):
> >>    bpf: Remove unused parameter from check_map_kptr_access()
> >>    bpf: Refactor to avoid redundant calculation of bpf_reg_state
> >>    bpf: Refactor to handle memory and size together
> >>    bpf: Prepare verifier logs for upcoming kfunc stack arguments
> >>    bpf: Introduce bpf register BPF_REG_PARAMS
> >>    bpf: Reuse MAX_BPF_FUNC_ARGS for maximum number of arguments
> >>    bpf: Support stack arguments for bpf functions
> >>    bpf: Reject stack arguments in non-JITed programs
> >>    bpf: Track r11 registers in const_fold and liveness
> >>    bpf: Prepare architecture JIT support for stack arguments
> >>    bpf: Enable r11 based insns
> >>    bpf: Support stack arguments for kfunc calls
> >>    bpf: Reject stack arguments if tail call reachable
> >>    bpf,x86: Implement JIT support for stack arguments
> >>    selftests/bpf: Add tests for BPF function stack arguments
> >>    selftests/bpf: Add tests for stack argument validation
> >>    selftests/bpf: Add verifier tests for stack argument validation
> >>
> > This set looks good to me overall:
> >
> > Acked-by: Puranjay Mohan <puranjay@kernel.org>
> >
> > I added support for arm64 in https://lore.kernel.org/all/20260420153603=
.4097618-1-puranjay@kernel.org/
> > Please incorporate it into your series if you do another version.
>
> Thanks, Puranjay! I will send another revision later which adds support
> for precision backtracking and additional/modified test cases among other
> things. I won't include your patches in the next revision. Once the patch
> set is stable enough, I can add your patches. Optionally, the patch set i=
s
> already large enough, so maybe at some point, after this patch set is mer=
ged,
> you can send your patch set separately.

Okay, doing it separately is better I guess, I will wait for your
patches to land and then resend the arm64 support.

Thanks,
Puranjay
