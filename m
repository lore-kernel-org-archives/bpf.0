Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com [209.85.221.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F4E1F4CB3
	for <bpf@vger.kernel.org>; Sat, 18 Apr 2026 11:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776510448; cv=pass; b=Mwexa/e79r3KtJDqtoF44XwTKnISJYgc8UKtm4YDB23MvGCGP3LS97tf7l0XXpAm4Am06tgXgiub5X1NutUv/DcWo3tSCHAtRHjLdAP8Y+c8hPt0RDPXfZ9k+ZswaZBHTb/Jx77VjQ4jNAMGHumQ94h+59Wa+5+Z2nJ0pTx/joQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776510448; c=relaxed/simple;
	bh=2KMY10Aw1i9kS7+kOOY1zUbpUZXi9Dr79ju1rqbd09o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sq4gi/BflyPxZz8OeRezQjXmLogXucOc70W48TQj4yNep3GsJb2D4cH+Evroq6TYP9oyQrvtVd2Q+BIe+E+gFkgB+fz92E4QyZGxrPGxxgz4asmSJrT+MVc+oulcEznGpDeLfdZSr9rfyVj2R/rCSI09MOrXgtqN5nqV7ASEudo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n1/fj1C6; arc=pass smtp.client-ip=209.85.221.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n1/fj1C6"
Received: by mail-wr1-f65.google.com with SMTP id ffacd0b85a97d-43eb012ac4fso878200f8f.0
        for <bpf@vger.kernel.org>; Sat, 18 Apr 2026 04:07:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776510446; cv=none;
        d=google.com; s=arc-20240605;
        b=doZX9w3cHHcK/+xpCwterX9A68wJ1WZ5oD8JFBRTRFuVSK3gxMBYpKDYMFe0sM9sAR
         DK1wDlCK0L2UfTB9NpX0oiRxNxFOYiP+wTV7u70Qq46ZBH6YKrKWil/CV333s5od7PAk
         WPZ9df+fU1QSLyf20xr14Kqlrh4mkGVcqRUn1CpiGs/q0ITp3I01S7NCLkRwQA+dlhLc
         Ny2jRLBmw/BMPPX7XiteGPYP5CU9XxQfATbk4l+F0fjH4/0t6lfGe5JvEUaFncyygBan
         HQyEcMyBovfVwMzM0gOkeINglbqQWU5rzVUpj1fPNwCYNF0vYpI/Dp7ogacSxJpiteID
         oBbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=XcpucQ8CNaBk0jS985T+c/26ZYeKxe0kmY/R7U9Ehxk=;
        fh=aNrAQtSaA5ARnjt9jUNjEHO5rsiFrt0ivL8kgZMZ9Lw=;
        b=CT+tDRA5XKMIwWjjI1awd3ZMK2+zb8q6tZ+25kue5kxNZkQJYPRlZYzV6SAJJ+WRUH
         9kztVunbDAqySgLgevwqIotmL3h4EdcxraO7ZIzcCtLyj418tEgbOJ/53FCw7Xqi4tMZ
         R46vPM7GdwPy27A34IpYyfg7XxYXraYMwhYXLhY2fMB7B4SD2A7QzQ7CubGYdYdp261/
         NNzlsaJRotkkXtEHLsSlVZ2EzbFnFuXlZIlE1Lb5uohyWHGCWpoOKyqpKlMct8d0+jZm
         POUtoy0qJGgyxqBGkKpJLcpIFX06cNbsmFVP6uF2XYwu9TDHKCJLt2/WssVuu7GX3HQT
         Olug==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776510446; x=1777115246; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XcpucQ8CNaBk0jS985T+c/26ZYeKxe0kmY/R7U9Ehxk=;
        b=n1/fj1C6SDEFWKhnrRQ53ExuBiF5X1udtWy2MKlUbVq1f0Nl1Qd8bOWIlQ8K92dMr4
         2ByhzF/76uqPScRpsd/4NCO8NK24pD0kjnPCzRoQMg2UDqUUbwcfCYHXNqrpXOuOenfP
         wlfPki6qsQpr89v3fQBH0IjInDpnC93vPxiCD0mwNSXnnkbXQG5ekz+4cwaLsdv2rzps
         8NwOtjpeeeBhsMyShc+j0zHn6l57+AYUBi1b0ZQ9Xfy4ump9a/gqdejj8owcBwjYanZG
         58gIxTOe3fQZE0f5jeINwCXHGIbbosIhSwWcFzT3agIzluxEig/1sfo2urqwGMoK3yTv
         iLPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776510446; x=1777115246;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XcpucQ8CNaBk0jS985T+c/26ZYeKxe0kmY/R7U9Ehxk=;
        b=TdGeBlrbntxyYn9w60yoQ7kr7pgViGNoFF7pWKw35aDaoXoAtSuEMh0Wv3SL4kssWo
         kD8JfizeUkeOwe3cynFEK0EbnDJJoJg4glvPkbvQaJ0HiyXxV6kvYkSb1Ct85tSzMq3U
         B8y1WL3YiDU5vGoSlZ2jxRm83J/1FuFxEKcygAeAhdRNz1h6gl8un7epR7lmbvwen6Ao
         HBdf5jdrXT6CtIcRJh49kfBKu3MDq+A4R1q5drHNVPCJ2/diiEmHLV6H8FW+uOKNbIfj
         71cwyPvPmf0ysUJO+r3Mc3/fc5FMJ1XCtGZOq/28zQX5zBcc0o1TWirahbY/2pup2rh9
         hRhw==
X-Gm-Message-State: AOJu0Yy6qsdmgd6vNTCBI/jusKjGIAZLU0PuNExlYzzIlOfgC58loRX1
	aJHUfO0gBXjs4Iv8QTP2SukdfE+uuW6Rkl9c9u6EnDwesB8myX94WW3xQZQRc7yMJoYY4Zm65+S
	7YWaj/NoBnUrhiykPanODDYu6dOeOaj35tOobi8heAg==
X-Gm-Gg: AeBDiesub17+3UMzfVOPJ3O2s8QEyKhhZ1Vh4qrX9BPsrmipRJm8t3MDR9M+Q8XjG2U
	4PMVnIIGxl4wx2gX4r/ZdY6j8ycXcWAJYx/NJu+OJXOuSx8q+PVEhVnIuKC21CEjIjyZZGNNkr3
	YipN3KuZb+kO976gcrzSyd/ljB5VUi+osovM5uacj+ffS4BYqIELEu1HAHRE12Typr8uGpGOQFu
	plqVMdysOGEGmvDPqYw8sV45T5XKmQEEfn+w0uQ3/wYzt3rlj//Dj9x1F6/oQ7w7u1lpwqe/fEr
	vno8wGB6hmqKOT5g8hwBY0kXWmDUL5xVwddUFuLIUSFJ5U51p79ERnXjLwrJuWxhQ9Z5sUmeBSZ
	oOLwEUjKbCgGNGhUHjQ8zgx23M5p/PAVqLcTLWg==
X-Received: by 2002:a05:6000:2013:b0:43d:c95c:4259 with SMTP id
 ffacd0b85a97d-43fe3e07216mr9681115f8f.30.1776510445550; Sat, 18 Apr 2026
 04:07:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260408021359.3786905-1-memxor@gmail.com> <1a7aea41-cc64-4277-a08d-1cee1ad6024b@gmail.com>
 <66a977bb-cfe4-4bac-990e-2b91512c354a@gmail.com>
In-Reply-To: <66a977bb-cfe4-4bac-990e-2b91512c354a@gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Sat, 18 Apr 2026 12:06:48 +0100
X-Gm-Features: AQROBzBpKEQQUWWaGRMhPkaMSV3yIiGxCBLqSUrLnPwWiI3BY-AY7deXZtOKOKg
Message-ID: <CAP01T76wkwaXSmLpAS3GtK4VKELzgkeYxozcxFav+C1F7LTYTg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 0/6] Add support to emit verifier warnings
To: Leon Hwang <hffilwlqm@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, kkd@meta.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 8 Apr 2026 at 16:30, Leon Hwang <hffilwlqm@gmail.com> wrote:
>
> On 2026/4/8 22:55, Leon Hwang wrote:
> >
> >
> > On 2026/4/8 10:13, Kumar Kartikeya Dwivedi wrote:
> >> Currently, there are only two ways of communicating information to the user
> >> when a program is verified, success or failure with a verbose verifier log.
> >> Some information is meant to be more discretionary, e.g. warning about use of
> >> kfuncs that are deprecated, and may be removed in future kernel releases.
> >>
> >> An example is shown below.
> >>
> >> $ ./test_progs -t kfunc_implicit_args/test_kfunc_implicit_arg_legacy_impl -v
> >> ...
> >> 2: (b7) r3 = 0                        ; R3=0
> >> 3: (85) call bpf_kfunc_implicit_arg_legacy_impl#114683
> >> kfunc_implicit_args.c:40 (insn #3) uses deprecated kfunc bpf_kfunc_implicit_arg_legacy_impl(), which will be removed.
> >> Switch to kfunc bpf_kfunc_implicit_arg_legacy() instead.
> >> For older kernels, choose the correct kfunc using bpf_ksym_exists().
> >> 4: R0=scalar()
> >> 4: (95) exit
> >> ...
> >>
> >> With verbose logging, the deprecation warnings are printed inline in the
> >> verifier log. When no log level is chosen, the warning is printed in a
> >> block, as follows:
> >>
> >> libbpf: prog 'test_kfunc_implicit_arg_legacy_impl': -- BEGIN PROG LOAD WARNINGS --
> >> kfunc_implicit_args.c:40 (insn #3) uses deprecated kfunc bpf_kfunc_implicit_arg_legacy_impl(), which will be removed.
> >> Switch to kfunc bpf_kfunc_implicit_arg_legacy() instead.
> >> For older kernels, choose the correct kfunc using bpf_ksym_exists().
> >> -- END PROG LOAD WARNINGS --
> >>
> >> The set was tested with and without kernel changes applied, so that we
> >> could conclude that libbpf feature detection works correctly and
> >> backwards compatibility is not violated on older kernels. Still, it
> >> would be helpful if other reviewers could recheck all assumptions and
> >> make sure I didn't miss any corner case.
> >>
> >> One case I need more opinions on: log_buf.c passes log_buf with
> >> log_level=0 and expects it to be empty, with newer libbpf that won't be
> >> true on older kernels anymore. I don't think this is something that
> >> needs to be addressed, but explicitly noting it here since I saw that
> >> test fail when testing new libbpf on older kernels. The kernel will now
> >> populate such log_buf will "processed N insns ..." log since on failure
> >> libbpf will retry with log_level=1, so unless applications are relying
> >> on log_buf to be empty for correctness it should be ok.
> >>
> >
> > Since I'm going to add common attributes [1] support for BPF syscall,
> > how about reporting the warnings via the common attributes? Even though,
> > the original intent of common attributes support for BPF_LOAD was
> BPF_LOAD -> BPF_PROG_LOAD
>
> Also, common attributes support for BPF_BTF_LOAD was to report logs,
> similar to btf_log_* in union bpf_attr.
>
> If to report the warnings via common attributes for BPF_PROG_LOAD, we
> should rethink the purpose of common attributes support for BPF_BTF_LOAD.
>
> > report the verifier log too.
> >
> > [1]
> https://lore.kernel.org/bpf/20260216150445.68278-1-leon.hwang@linux.dev/

It can be used when present, I will switch to a warning bit in the log
level in the next version. But I don't think we need to rethink
anything. If we want warnings for other objects they can use the log
level's warning bit to supply those to user space as well. When you
add support you already have to figure out how to merge those in
bpf_attr and common attributes.

> >
> > Thanks,
> > Leon
> >
>
>
