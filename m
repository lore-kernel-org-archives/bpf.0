Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794509174;
	b=ccS8ePrenY1Sq6Vmm0Q3jlvmJOgj8xH2uO1xn3cmgzgYVyDWqNIHUhjLZbIAc2hlS5bH
	 PS68763/X8mt9PSgdtSlRn9v8fOS+bjXr6lffmc4A8vFpTZhn8FRyT/RsIPgKTztY5YIA
	 8/ZiMPterxVHlYFVip1FBl4AYnlhs6VLO0YjZS/5RxSTVB4BfWCOamkkhUeEICUmJb8Al
	 nphfuJ7/Lzu+ZTFvOuFDchXA3NeLEm9dnKaY/FXjlg3q8eccFxGhrzFv39yBV1tYl0RLv
	 Anh4wJMQ/KnCpASS48lRFJPiGoJalJ3dWF2sFHHGBKsVbdNU99IFYWVXsjs9bB7t35A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794509174;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=x3rVQKLNyXgwCalWuHmNjEvs5Zt3d54kCgFpqRsY3Kk=;
	b=XJXW+Jz8MaGY1DV6RfSA3Iwyfsw6j+fO3qsaRZ7grzXyM+gSRg/o/PGk8vI0TZTQ17gc
	 Q3q5gyy9m7cWmg6HZr7mpgqYGzbiZKcITSD9VrrwSK1nfYuA8NUbOHWqFNYtwJYlQUmcr
	 DpMpGKj2NLv+spo36JH1jxicJnb8rXJr2PLJ02VvjIzKVwPZM2mxbidpqZqJeEXOroXCE
	 4a9dBX/T35Hf7hTvGBX/DG0h/TUSRFRbOG1LMQ/tYkK6hCTfJe1sBYUJJDgEYdSFKjk6J
	 WhCHTbrmeNws/r5guzbI3JU45B7yWEZi9HUeGEghlV+cHatSwmlo97Fk5EEFlw4MtqQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="Bq/HEmfP";
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.51
Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B00B2606A336
	for <bpf@vger.kernel.org>; Thu, 12 Nov 2026 18:46:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B00B2606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Bq/HEmfP
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-677bc4704cbso149906d50.0
        for <bpf@vger.kernel.org>; Thu, 12 Nov 2026 10:46:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794509173; cv=none;
        d=google.com; s=arc-20260327;
        b=ORlJjc5KxyCKHLTRmywj7LbW0sqcSIBLVqEimFIxAreg2dzfsPvbE0OJsdZxFlXRuM
         N3kTs+scUQMw5pj2r6lyopjBufQGzH/u+lgbVIj4/UwQP4cLDl9f4Tsxczjp9jrbR7Ny
         SyYL5WZx2xhxqDZ6MRzVOa6vIySf7lN+7DTEasu3/JfJ6dP8Rb0i5g3aRX+6Vg9+sMsx
         2ex+S4VxoZ5L2vwbQWX1Csq954BciET+hf2RHfD1jhHdlw5Rely4LyUlXl8RC8aXBE+V
         ZUOLJjxSJfNtRNX2eJnbuPQXOYkcXPckt3+9uX4Cn7Aa9nmaHEigaeckM7ARR01zPdWp
         xsFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=x3rVQKLNyXgwCalWuHmNjEvs5Zt3d54kCgFpqRsY3Kk=;
        fh=R8BU2yF4CrhD2szyM+OdVFJqHyACMniUSKqaOjdXodo=;
        b=sCT2zT02UNAk6syrMcUJgtoH3deV4IihbSxgVT0hBmnub3o4kinHOk8wbE7w6URXj7
         fXXQvDojQWf0HyCap8BgbrmdczAVJLTW5mQJThH18F/EwbFQKLGbHnoGpvdyQE/uZ0SR
         U5WUOdmg4x1QgDspy0oSB4g4oF8hkA78HXE5oFHd2FQuhAOsi/1ggFFfSPiSV78RxSWs
         5vABqsyzBjlYpAPrTC1UWU6V6fqkzGVauRIsCHrOyPzeS7tiAOsMszcmCaQFlh8R0XX8
         NZgOTSjrRHG67h4l/5lcNXyJgYvGA9qviECSKuetO4Car0zs0Y7bJgqYCoUNcpkpQ76J
         XwZQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794509173; x=1795113973; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=x3rVQKLNyXgwCalWuHmNjEvs5Zt3d54kCgFpqRsY3Kk=;
        b=Bq/HEmfPsxRrBbzAXNyJJfHucRLuhzK77L4t/Pk4tybSrTM/szEkDr3kvuDeUmMjpw
         J0Qx0DG/zkHeYfIo1YlNZmB7muL78EZeuMzg2tkOo75jcwc0udrwwqV3rehNuYU4Vx9e
         7YcFl9NhIFksS2kfivkSt/lJbgcux5N5kH616AKvu035FH0lRpHvBQdOUx7fXZBg8IxW
         3fqTs0CyJid7CK444UJKacxi6EkzvNjWUD1cvSih+D3TIAbtbuX+weLUz/hCG3a1FX2U
         IOyaHXXBbNrPpcRciYmrvQXBEezj7QVnOxe9fMgN5u4iV/mmO7hVVMKu484/OloYKeSQ
         Ap0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794509173; x=1795113973;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=x3rVQKLNyXgwCalWuHmNjEvs5Zt3d54kCgFpqRsY3Kk=;
        b=ysHExU4xkV8iVLLaRtwt8cXTfvnMkVsDS+WLofwXEkQoRNIDdFnJB/Tckcb0vUJzig
         XwmoUBlCv4RmBtJbqSqIg+PY20eYFRG+dv6b/Y7BiwlRuvagltgV7W376WvlhVZcKGnX
         RDnpHGXRsDHVkqAptrWKO/fNNrbqHtLdKf8q1yXEuucHgSOhL+vMXVrHQKMjs8hBWdfD
         8SrrzgT4HaMg9xHfn5rVPkiFygwsJ0PX5yZDAQAfK9g9TWnBiim/1DFNWo9N8i4H2QPV
         +5CvwBgEAY+Y14BjW3bnRh+7pKL1dB+sT7f5YFAMUgaz8bZrThXUbDmIHpARmSbqAGbN
         dKWg==
X-Gm-Message-State: APuU4Z/9pn7wcDw1H6U15dIg+bg6tmHqUhHrffScr2oRlbVGJfYQn68e
	Nu2IFKuiefIBFrCKA5O0nQAi1IwT9QmFD9mfKiiXvbEBd33WT2YAdikV+f4xxk8RPBSQgpelnri
	UrV6QE1E3dl7j7trDk54pb5rrqzZwd25tRs+vkRA=
X-Gm-Gg: AYBFou2FDyoZRx3j/wHI87j4xjY+LI91Q37KNXb6gwurYdZUHNqY1QnSVJUjRBo7y+l
	C56vNFn5gGZW6CFUJdxrPgTtJ3nduY8H0PDHBHDviE0UtgAiBZDhKfbjUeVmhddiuoPxVEnvhMK
	AqepQy14CqFZdODbVUzn0sr3V9nSa8QpJdGn588zRVa/0uyFftrCWIjHg1SXTh9He8/Z4lClzzJ
	xmcHI4t6pygqs4iEUj0z7yOzLK7Osx1OmZhNX/RtyUa6WutHHkTf8IJCH6TmosGLFw5eY109Br7
	iY+Xu7Y3tvZZbWn8zThKpVfLGJzwUVfrW4CiUewhf12qxnfqJB4oOn0VRIpqly+b4RN67blYuln
	V5/aibCxrcP/mngaeoZdSuz95VkfWAq0TOyh+bQ==
X-Received: by 2002:a05:690e:4002:b0:67c:1557:7b4f with SMTP id
 956f58d0204a3-67d897cc499mr144350d50.141.1794509172542; Thu, 12 Nov 2026
 10:46:12 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261112164610.1917256-1-alexei.starovoitov@gmail.com>
In-Reply-To: <20261112164610.1917256-1-alexei.starovoitov@gmail.com>
From: Anton Protopopov <a.s.protopopov@gmail.com>
Date: Thu, 12 Nov 2026 19:46:01 +0100
X-Gm-Features: AclHuK-4w17Lo6YKPSWizS3VdkazWV9aFW6Z67O90E00UP20KEfYwfKexz2nclk
Message-ID: <CAGn_itym+8YRWMXS7-EUfewVXtct0fF2nPE-V4v2YoOeDM8MaQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 00/10] bpf: fmod_ret for each function that
 returns errors
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	eddyz87@gmail.com, memxor@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 12, 2026 at 5:46=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> From: Alexei Starovoitov <ast@kernel.org>
>
> In short: with CONFIG_BPF_FMODRET_SCAN=3Dy the build tags the functions t=
hat
> return errors, 12633 of them. A program with CAP_BPF and CAP_PERFMON can
> attach to one, skip a call and return one of its errors. No file of net,
> fs or mm changes. Test: one skipped call per function, 4401 functions of
> net, fs, mm. With this set 1 function in 180 then damages the kernel. A
> deny list by name can take those out.
>
> 1. What for?
> BPF can keep user space away from a security bug in the rest of the kerne=
l
> until the fixed kernel runs. An fmod_ret program attaches to a function o=
n
> the way to the bug and fails the bad call:
>   SEC("fmod_ret/vfs_fallocate")    return len > MAX_LEN ? -EFBIG : 0;
>   err =3D vfs_fallocate(..) --> program
>                                returns 0      --> call it, err =3D its re=
sult
>                                returns -EFBIG --> skip it, err =3D -EFBIG
> Such a program needs targets in net, fs and mm. Today it has 1000 syscall
> entries, the security hooks and about 20 other functions. Of 417 fixes of
> one year that add a failing check to a function, the fixed function is a
> target: today 1 %, v3 (4) 17 %, this set 50 %.
>
> 2. What is a target?
>   THE RULE  A function f() that returns errors is a target.
>             A program returns 0, or an error that f() returns.
>   EXCEPTION An error is not allowed if each path to its "return" calls a
>             void function with a pointer: an argument of f() or
>             &arg->member, not a loaded arg->ptr.
>             If no error is left, f() is no target.
> A caller can get each of these errors today, without a program. The rule
> is simple on purpose. It does not aim at 100 % safety (5).
> Why the exception? "spin_unlock(&arg->lock); return -EBUSY;". If f() fail=
s,
> the lock is free. A skip of f() leaves the lock held. So a program cannot
> return this -EBUSY (5).
> A program can only fail a call. Loss of function is the purpose: a progra=
m
> that switches off a part of netfilter to keep a bug out of reach works as
> designed. Who may load does not change: CAP_BPF and CAP_PERFMON, or a BPF
> token. An attach does not taint the kernel, as today.
>
> 3. How are targets found?
>   vmlinux, *.ko      machine code of GCC or clang, inlined and linked
>   resolve_btfids     "the tool". It runs at the link, after pahole
>     | 1 decode       LLVM's MC (machine code) layer gives the length, the
>     |                branches, the written and the read registers
>     | 2 analyse      data flow, backward, may, like liveness: the constan=
ts
>     |                -4095..-1 that reach the return value register.
>     |                Forward, may: is a path free of the exception's call=
?
>     v 3 tag
>   DECL_TAG 'bpf_fmodret_retval:-95,-29,-27,-26,-22,-21,-19,-9,-1'
>            on FUNC 'vfs_fallocate'. This is "the list" of vfs_fallocate()
>     v verifier       at load
>   The program attaches. At each exit R0 is 0 or an error of the list.
>
> 4. What do I get, and what is the price?
> v3 is "[PATCH v3 bpf-next 00/18] Auto-detect BPF fmodret targets" by Anto=
n
> Protopopov. This set is a rework of v3. The idea, resolve_btfids as the
> place, the tag, the check, the tests, and that Kconfig asks llvm-config a=
nd
> a host C++ compiler are his. So is the question behind the exception: wha=
t
> has f() done before the error?
>
>                      targets   kernel damage   the build reads
>   allowed today         1290    not measured   -
>   v3                    4457           0.2 %   LLVM IR, in a clang plugin
>   this set             12633     0.6 - 0.7 %   machine code, GCC or clang
>   targets: tags in one x86-64 clang kernel. GCC: 11985. arm64: 11601.

Just in case, I've got 16524 on x86, and 15149 on my arm.

>   A program can attach to 12096 of the 12633, and to 4454 of v3's 4457.
>   kernel damage: the share of the functions in net, fs, mm where one
>   injected error ends in a panic, a stall or a lockdep report (5). 0.7 %:
>   a second run, and a blind run on new functions.
>   allowed today: 957 syscall entries, 312 security_*(), 21 others. They a=
re
>   no safe baseline. security_*() is a match by name: 47 are internals of
>   SELinux, 59 return void, 12 are hooks that BPF LSM refuses. The value
>   that a program returns is not checked. This set does not change that.
> v3's rule: a "clean path", one without side effects, leads from the entry
> to "return -E..". A call, a store or a shared "goto err" label ends it.
> The exception (patch 8) takes v3's clean path and narrows what ends it:
> only a call of a void function on an argument.
>
> 5. Does the kernel survive?
> An injection: one program attaches to one tagged function. At one call it
> returns one error of the list, whoever calls. The control attaches and
> always returns 0. The kernel is x86-64 GCC with inline KASAN, lockdep,
> kmemleak and a wide config. The workload is 530 tests and scripts, mostly
> selftests. It calls 8027 tagged functions, 4401 of them in net, fs, mm.
> Each gets one injection:
>
>                                          panic
>                                          oops
>                                kernel    BUG()   hang   lock
>                   functions    damage    KASAN   stall  dep    WARN   lea=
k
>   net                  2716   25  0.9 %     20      4     1      14     3=
4
>   fs                   1307   18  1.4 %      5     13     0       4      =
2
>   mm                    378    7  1.9 %      6      1     0       2      =
0
>   net + fs + mm        4401   50  1.1 %     31     18     1      20     3=
6
>     error is dropped    290   27  9.3 %     16     10     1       1     1=
6
>     error stays        4111   23  0.6 %     15      8     0      19     2=
0
>       v3 has it too     903    2  0.2 %      2      0     0       3      =
1
>       only this set    3208   21  0.7 %     13      8     0      16     1=
9
>   kernel damage =3D the three columns right of it. WARN stands apart.
>   A leak is the lowest concern: it is not in the rate.
>   The run has the lists without the exception. "error is dropped": the
>   exception takes the injected error out of the list.
>
>  1 With the exception about 1 function in 180 damages the kernel after on=
e
>    injection. It is not 1 in 2, not 1 in 10.
>  2 The exception takes out 27 of the 50 cases, for 7 % of the functions.
>    These 27 functions have no error left: no tag, no attach. The exceptio=
n
>    comes from this run. In a blind run on 632 new functions: 3 of 9 cases=
.
>  3 v3's rule is safer per function, 0.2 % against 0.7 %. It has far fewer
>    functions: 903 of the 4111.
>  - Of all 8027 injections 48 % only give user space an error, 50 % nothin=
g.
>  - 354 of 355 runs of the control are clean. A second harness with its ow=
n
>    program sees all 50 cases again.
>  - Are the 50 cases bugs in the kernel? By the source of each case: at mo=
st
>    2 are, on an error path. In the other 48 a real failure of f() at that
>    call does not do that damage, or cannot happen.
>
>   A skip of f() is not a failure of f(). 38 of the 50 cases come from tha=
t.
>   The exception of (2) is made for them. It closes 26 of the 38. An
>   example, fs/file.c. ksys_dup3() takes the lock and ends with
>   "return do_dup2(..)":
>       static int do_dup2(..) __releases(&files->file_lock)
>       ..
>       Ebusy:
>               spin_unlock(&files->file_lock);
>               return -EBUSY;
>       do_dup2() fails        dup2() =3D -EBUSY, the lock is free
>       do_dup2() is skipped   dup2() =3D -EBUSY, the lock stays held
>   With this set do_dup2() has no tag: a program cannot attach to it. The
>   tool sees that in the machine code. It needs no name and no __releases(=
):
>       mov  %rdi,%r13           r13 =3D files: a pointer argument
>       lea  0xc0(%r13),%rdi     rdi =3D &files->file_lock: no load
>       call _raw_spin_unlock    BTF: it returns void and takes a pointer
>       mov  $0xfffffff0,%eax    -EBUSY: each path to it has this call
>   A void function cannot fail: it has done its work when f() returns the
>   error. The caller relies on that work, and a skip leaves it out. Most
>   unlock, put, free and init functions return void. A function that retur=
ns
>   a value can be the one that failed: it does not count.
>   v3 has no do_dup2() either: the unlock ends its clean path.
>   Functions with __releases() and no __acquires() that have a tag, withou=
t
>   and with the exception: 7 and 0 in this kernel, 4 and 0 in the GCC kern=
el
>   of (4), 3 and 1 with clang and on arm64.
>
>   What stays? In four runs, all directories, 169 functions cause kernel
>   damage in this kernel. The exception takes out 55. A deny list by name,
>   not in this set, can take out the other 114, 55 of them in net, fs, mm.
>
> 6. What does it cost me?
>   CONFIG_BPF_FMODRET_SCAN    option off   option on
>   each Kconfig run           +3 ms        +3 ms: one run of llvm-config
>   build host                 as today     C++17, llvm-config, headers and
>                                           libraries of LLVM 17 or later
>   the tool on vmlinux        0.31 s       0.9 s, after 4.3 s of pahole
>   BTF of vmlinux             8.02 MB      8.25 MB =3D +2.9 %
>   kernel memory              -            +0.33 MB: BTF and its index
>  - Nobody gets the option without a question: no default, not in defconfi=
g.
>    allmodconfig and allyesconfig have no BTF, so they do not have it.
>  - A GCC build needs LLVM too. It need not be the LLVM of the compiler.
>  - LLVM's C++ API and opcode names change between releases. The build the=
n
>    stops and says why. So a new LLVM can stop the build of an old kernel
>    with the option on.
>  - x86-64 and arm64 only.
>  - No file outside of BPF's entries in MAINTAINERS changes.
>
> 7. Why this rule? Why machine code? Why LLVM?
>   the rule (* =3D taken)                 targets  against it
>   v3: an error on a clean path            4457  17 % of the fixed f() (1)
>   an error reaches a return              13549  0.9 - 1.3 % kernel damage
> * the same with the exception            12633  0.6 - 0.7 % (5, patch 8)
>   + the errors of callees               + 40 %  3 - 6 % are never returne=
d
> v3's promise holds in the machine code for each of its 5249 errors. The
> exception drops none of them.
>
>   who reads what               lines  against it
>   v3: clang plugin, LLVM IR    +1913  no GCC, no LTO yet
>   objtool, v3's rule           +1272  no arm64
> * resolve_btfids at the link   +2118  LLVM on the host
>   lines: the part that finds and tags.
> The rule makes the targets, not the reader. A plugin with "an error reach=
es
> a return" finds 14229. But a plugin serves one compiler, before the link.
> Why LLVM? A decoder by hand is 300 - 800 lines per arch, for ever. The MC
> layer takes 538 lines, and a table of 137 (x86-64) or 123 (arm64) lines:
> what an opcode computes, by opcode name. The tool checks the table agains=
t
> LLVM at each start. LLVM's C API gives only text, so it is C++ (patch 3).
>
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
>
> Alexei Starovoitov (5):
>   selftests/bpf: Don't depend on the width of a BTF id in
>     verifier_live_stack
>   resolve_btfids: Describe machine instructions with LLVM's MC layer
>   resolve_btfids: Fold the constants of a select without a branch
>   resolve_btfids: Say which registers an instruction reads
>   resolve_btfids: Don't list an error that follows work on an argument
>
> Anton Protopopov (5):
>   resolve_btfids: Read the code of an ELF file by address
>   resolve_btfids: Find the definitions that reach the return value
>   resolve_btfids: Tag the functions that return errors
>   bpf: Allow fmod_ret on tagged functions and check the return value
>   selftests/bpf: Test fmod_ret on tagged functions
>
>  include/linux/bpf.h                           |   2 +
>  include/linux/bpf_verifier.h                  |   2 +
>  kernel/bpf/Kconfig                            |  19 +
>  kernel/bpf/verifier.c                         |  83 ++++
>  scripts/Makefile.btf                          |   1 +
>  tools/bpf/resolve_btfids/Build                |  13 +
>  tools/bpf/resolve_btfids/Makefile             |  23 +-
>  tools/bpf/resolve_btfids/fmodret.c            | 185 ++++++++
>  tools/bpf/resolve_btfids/fmodret.h            |  12 +
>  tools/bpf/resolve_btfids/fmodret_scan.c       | 259 +++++++++++
>  tools/bpf/resolve_btfids/fmodret_scan.h       |  29 ++
>  tools/bpf/resolve_btfids/image.c              | 222 +++++++++
>  tools/bpf/resolve_btfids/image.h              |  62 +++
>  tools/bpf/resolve_btfids/llvm-mc.sh           |  59 +++
>  tools/bpf/resolve_btfids/main.c               |  11 +
>  tools/bpf/resolve_btfids/text_flow.c          | 262 +++++++++++
>  tools/bpf/resolve_btfids/text_flow.h          |  77 ++++
>  tools/bpf/resolve_btfids/text_insn.h          |  87 ++++
>  tools/bpf/resolve_btfids/text_mc.cpp          | 431 ++++++++++++++++++
>  tools/bpf/resolve_btfids/text_mc.h            | 107 +++++
>  tools/bpf/resolve_btfids/text_mc_arm64.c      | 123 +++++
>  tools/bpf/resolve_btfids/text_mc_x86.c        | 137 ++++++
>  tools/testing/selftests/bpf/config            |   1 +
>  .../selftests/bpf/prog_tests/fmodret_retval.c | 152 ++++++
>  .../selftests/bpf/progs/fmodret_retval.c      | 168 +++++++
>  .../selftests/bpf/progs/fmodret_retval_ext.c  |  18 +
>  .../selftests/bpf/progs/verifier_live_stack.c |   6 +-
>  .../testing/selftests/bpf/test_kmods/Makefile |   8 +
>  .../selftests/bpf/test_kmods/bpf_testmod.c    |   4 +-
>  .../bpf/test_kmods/bpf_testmod_retval.c       | 131 ++++++
>  30 files changed, 2689 insertions(+), 5 deletions(-)
>  create mode 100644 tools/bpf/resolve_btfids/fmodret.c
>  create mode 100644 tools/bpf/resolve_btfids/fmodret.h
>  create mode 100644 tools/bpf/resolve_btfids/fmodret_scan.c
>  create mode 100644 tools/bpf/resolve_btfids/fmodret_scan.h
>  create mode 100644 tools/bpf/resolve_btfids/image.c
>  create mode 100644 tools/bpf/resolve_btfids/image.h
>  create mode 100755 tools/bpf/resolve_btfids/llvm-mc.sh
>  create mode 100644 tools/bpf/resolve_btfids/text_flow.c
>  create mode 100644 tools/bpf/resolve_btfids/text_flow.h
>  create mode 100644 tools/bpf/resolve_btfids/text_insn.h
>  create mode 100644 tools/bpf/resolve_btfids/text_mc.cpp
>  create mode 100644 tools/bpf/resolve_btfids/text_mc.h
>  create mode 100644 tools/bpf/resolve_btfids/text_mc_arm64.c
>  create mode 100644 tools/bpf/resolve_btfids/text_mc_x86.c
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/fmodret_retval=
.c
>  create mode 100644 tools/testing/selftests/bpf/progs/fmodret_retval.c
>  create mode 100644 tools/testing/selftests/bpf/progs/fmodret_retval_ext.=
c
>  create mode 100644 tools/testing/selftests/bpf/test_kmods/bpf_testmod_re=
tval.c
>
>
> base-commit: 2e14a351662dc5a3b7421d210049c59edd0425d2
> --
> 2.55.0
>
