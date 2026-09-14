Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B3B3363095
	for <bpf@vger.kernel.org>; Mon, 14 Sep 2026 19:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789415681; cv=pass; b=nQJE9OUvBcsztBVcyiGbzEfEwKQU46q/HFmIeYLEG8nscYCUP/GJH0AF8fzQM5WVGksv/heZybhshbuUlfjduC+PBsMpd2eOWi+p1D6c9eWzbqmnXEgxLx+0NoOWNBvKX3t7PwJAd1t6d/jJiNLjqeuFJOSrIkI7sFjyqAn/tH4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789415681; c=relaxed/simple;
	bh=fSapdCDZQ6QLFIEqMM1MeGmV8MwvDQGmJdKKe2cHLPM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OTkIyQUPXiyjobrdgw+gbb7d9Trs/8n/Rm/lovVtDzsx6KmFZYEH5UVgQYe5/B9kIFty1On7NpAluz9SnsR1WSzXDpG64SmgIVH+5YYrJp/lweJRsq0R5VNo3rHpplfj7TcAdmrIev5e2NgT+/ZrYJgkslZQWTfJNXnkJOmkXD0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D99QjmqV; arc=pass smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D99QjmqV"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-398b3b189e0so1885632a91.2
        for <bpf@vger.kernel.org>; Mon, 14 Sep 2026 12:54:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789415679; cv=none;
        d=google.com; s=arc-20260327;
        b=ZE6YJaJzeeHNj2LdFg/B3AaELhzacJcg+sJRAVc+RstIgJ5b7kG/f7wDD3T3aJuNNS
         +CR8fZUmcyO5DpZpdn37ZFenF/NR6B88rEXrJvgoH7oxKv8NTQzlKoI8Nmuw/Av0z5V4
         HaGsRqQxZajGM8KM//RKXJSzTuD6AJXfas2ncO0fSgptHyUSHBUDipmpWjJeYtmvQm94
         0YhjPUKhsLjZ/m4NcIgsrQOdWY3KAA1tjRXa5vvQE9xfZE3EV/cUvnfdeuhPGEvJuPE4
         1JMm8drs8PP5yTOynQ1oewem2D8yjh+iRAIOt2g2uTHhDqZJVfYrHrG0zMzaZzHublkj
         7cng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NH5JWH9+8ywBNkaYo4fuAfeFL7cCQ5kLjBxDoQ+Ftzw=;
        fh=k+96ManRf2cL4KLU0yCSwZe66ZSjd4F4fA87/2F2CvI=;
        b=gO5vYshS1Dz2rKxRG5/08Pz9MKMvpBynh6Rpr5c52y8X77c+3kkz2iQgKvYXz8BCY8
         fc2TA7pwms2lOAYcu56/IyPt2Ntt3eVfIGipa1aSo8jtTiXLlrDIDfTyvnu3fjEh2rvx
         8muZ1ZCd7man0J4yZEBVVn0ua9mZ+dtWJgSDwmbyZ7zIMy9ILabqFjIntro85WHo8nm0
         eRAVNuthreDk+40+Gw+PZX3xKH6LZbeQ1t60TWtCtjHfuRjpRNfLpGbNsdJwtE/SEvmD
         y7mCF/FmgBq/a+Fx2Jzc7XWrsqmtofGhJfmlOPaRSb5rZZudgGAU55e9m01w+zSclzFR
         ijxg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789415679; x=1790020479; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NH5JWH9+8ywBNkaYo4fuAfeFL7cCQ5kLjBxDoQ+Ftzw=;
        b=D99QjmqVpFFIJmj5cD9QI/GoJnswqJt4CW6JmAVjcdJhSMzNlmR+wh3A4sZlqob5sm
         E9oscYKVHOciDhm7+tK2dn1z/ZegCCLa3DUEQ6w+vtWEPRDMErbvRRdGqYLXupR8X31S
         yjSWDPmu4I0/oc9b7sYK9vXKN7kWXln55uH1YCFRiqw8X1nfL7+q2yz79fUDGlmsQaev
         wr1Tj7oXRXKNboisSm4a1v7rGh2+uxVl0VhOtcFBWTSoO9AvTYRlwD7s+dqlTNVgduEE
         np2MfIKC8a3JDsJ9OqBItvotemcvCIHqqgY+S29zAKmA6S6EmON4oiUs0fdBaUZMFldj
         vrRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789415679; x=1790020479;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NH5JWH9+8ywBNkaYo4fuAfeFL7cCQ5kLjBxDoQ+Ftzw=;
        b=GsR8RX6xB18MEiw+yjiFuANOlgaEAejrlQEUjvh34HdldWY8M0KImVcJUtNdtBMV/T
         flnrmsOxHwWFfdto9xaoWWNW26UnfjXU2xNKl0HXBpks6Wyas9BkMN0HGr/0zX73aaPv
         JrJIaVQYn2XxiDMeZsyS81UFA05AVy2Wa2GfwoL2YjWFtr7TrYGMXHGBatH7jZpLMDBz
         1YcVM16pGLQQHv0gShR0Rc04tLkI6GDQwuif6JmmftoXgI49IoENUDerzNez4NfWp7XR
         tfWhSQnC3JfXg3Kd1i2aRYA32OUTnUtstYAgY8xLMxNJBmYd0Cp3605+oItGZeLsUfbq
         qs1Q==
X-Gm-Message-State: AFuF++kRt6wgGht6gf+QpG41mSYS6gP2aqeRuU8JlQovnsA6/km96W4H
	3h0/islXmug1NgDRhY6KHkTdqfRgVxJkeW6kspajPbnSfsVt4uwb6xn0YZhWbM8p9DkXG3g4sE1
	6E6jGhEX1zJZT4FvciG8MWvKEklC49jY=
X-Gm-Gg: AYBFou1sk3A6TWvsX8fC84zO6j97McNKlY+oDdPGmu0k4/aky/rl4JxQ/zzW2EjNCPu
	O5SdHJOApOI5W1xGLFZAsKi9sUDr9kIG3ST1rasTaPJIXhMGxIRzmidiNlHgFeuxGEWI2ju3bWC
	ln09STSDKt7pEW3+dPiz9lpGcSSBP/EYjDm8XbcLhsmwsy5hAT/H7E/tAaQvRuvf9Vg7v0K1Hd4
	viqp2Y2zGLjUC21kuyq3rov0nbB1n++/9Nt6JYyNviXWY15UWESVy1dLr0XULCnM41QI3RgWRv9
	SKuyQB9XPLLpNbFo99DhWFvrtW360BjhrYK/Q/e2A0AWWZuepzK6I7SoHz9cuQQZToOJ4flqoR9
	N/ugC8cxIOYbf4gtkjjlYE7O4Lv9d9pDwpGZrUZDbmVjc6f7KpbVv
X-Received: by 2002:a17:90b:384f:b0:39d:f770:774 with SMTP id
 98e67ed59e1d1-39df77007e9mr4251508a91.20.1789415679511; Mon, 14 Sep 2026
 12:54:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260914131701.2529725-1-memxor@gmail.com> <20260914131701.2529725-5-memxor@gmail.com>
In-Reply-To: <20260914131701.2529725-5-memxor@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 14 Sep 2026 12:54:24 -0700
X-Gm-Features: AcwNN1Wu6M71qyfnT4DTMJ4fws26On6V9VuPbGQGO9xsTtPzErePNNHFBrXts5c
Message-ID: <CAEf4BzZjrWzQxaZ1kXyvXHXuUFDsgZe6NwQHH6seqfoMLpJLZw@mail.gmail.com>
Subject: Re: [PATCH bpf v3 4/7] bpf: Restrict CO-RE poisoning to relocatable instructions
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, Nicholas Carlini <npc@anthropic.com>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman <eddyz87@gmail.com>, 
	Emil Tsalapatis <emil@etsalapatis.com>, kkd@meta.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 14, 2026 at 6:17=E2=80=AFAM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> check_subprogs() verifies that each subprogram ends in an exit or an
> unconditional jump before in-kernel CO-RE relocations are applied.
> An unresolved relocation can then replace that terminal instruction with
> an invalid helper call. The resulting fall-through into another subprogra=
m
> breaks the CFG invariant used by postorder and stack liveness analysis,
> which can write past their per-subprogram arrays.
>
> Handle instruction poisoning after the instruction has passed the same
> class and operand-form checks used for a resolved relocation. This reject=
s
> relocations targeting jumps, calls, exits, register-source arithmetic, or
> non-immediate loads before they can alter the control flow. Keep poisonin=
g
> supported instructions, including both halves of a plain ldimm64, so an
> unresolved relocation in dead code remains valid.
>
> The shared relocation code applies this restriction to both libbpf and
> in-kernel CO-RE.
>
> Fixes: efcda22aa541 ("bpf: compute instructions postorder per subprogram"=
)
> Reported-by: Nicholas Carlini <npc@anthropic.com>
> Suggested-by: Nicholas Carlini <npc@anthropic.com>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---
>  tools/lib/bpf/relo_core.c | 28 +++++++++++++++++-----------
>  1 file changed, 17 insertions(+), 11 deletions(-)
>

Kumar, can you please see if we can move check_core_relo() to right
after bpf_prepare_btf_info() instead of trying to guard against
malicious CO-RE relocation? I think what CO-RE logic is doing here
with poisoning is correct, it marks instruction as invalid because
CO-RE relocation couldn't be resolved/applied/whatever. That's sane
generic behavior, IMO.

The fact that this breaks subprog validation is more of a sign that we
do this CO-RE application too late, perhaps?

Also looking at current bpf_check_btf_info() logic, seems like we'll
skip CO-RE relocations altogether if we don't have
func_info/line_info, which is... fine, I guess, in modern world. But
it certainly is a bit orthogonal. So check_core_relo() seems like a
stand-alone step to me, which hopefully can be done very-very early,
so that no matter what patching we did will be properly validated by
verifier.

> diff --git a/tools/lib/bpf/relo_core.c b/tools/lib/bpf/relo_core.c
> index 8ad2715721cf..a884bc2bff19 100644
> --- a/tools/lib/bpf/relo_core.c
> +++ b/tools/lib/bpf/relo_core.c
> @@ -1047,17 +1047,6 @@ int bpf_core_patch_insn(const char *prog_name, str=
uct bpf_insn *insn,
>
>         class =3D BPF_CLASS(insn->code);
>
> -       if (res->poison) {
> -poison:
> -               /* poison second part of ldimm64 to avoid confusing error=
 from
> -                * verifier about "unknown opcode 00"
> -                */
> -               if (is_ldimm64_insn(insn))
> -                       bpf_core_poison_insn(prog_name, relo_idx, insn_id=
x + 1, insn + 1);
> -               bpf_core_poison_insn(prog_name, relo_idx, insn_idx, insn)=
;
> -               return 0;
> -       }
> -
>         orig_val =3D res->orig_val;
>         new_val =3D res->new_val;
>
> @@ -1066,6 +1055,8 @@ int bpf_core_patch_insn(const char *prog_name, stru=
ct bpf_insn *insn,
>         case BPF_ALU64:
>                 if (BPF_SRC(insn->code) !=3D BPF_K)
>                         return -EINVAL;
> +               if (res->poison)
> +                       goto poison;
>                 if (res->validate && insn->imm !=3D orig_val) {
>                         pr_warn("prog '%s': relo #%d: unexpected insn #%d=
 (ALU/ALU64) value: got %d, exp %llu -> %llu\n",
>                                 prog_name, relo_idx,
> @@ -1082,6 +1073,8 @@ int bpf_core_patch_insn(const char *prog_name, stru=
ct bpf_insn *insn,
>         case BPF_LDX:
>         case BPF_ST:
>         case BPF_STX:
> +               if (res->poison)
> +                       goto poison;
>                 if (res->validate && insn->off !=3D orig_val) {
>                         pr_warn("prog '%s': relo #%d: unexpected insn #%d=
 (LDX/ST/STX) value: got %d, exp %llu -> %llu\n",
>                                 prog_name, relo_idx, insn_idx, insn->off,=
 (unsigned long long)orig_val,
> @@ -1140,6 +1133,9 @@ int bpf_core_patch_insn(const char *prog_name, stru=
ct bpf_insn *insn,
>                         return -EINVAL;
>                 }
>
> +               if (res->poison)
> +                       goto poison;
> +
>                 imm =3D (__u32)insn[0].imm | ((__u64)insn[1].imm << 32);
>                 if (res->validate && imm !=3D orig_val) {
>                         pr_warn("prog '%s': relo #%d: unexpected insn #%d=
 (LDIMM64) value: got %llu, exp %llu -> %llu\n",
> @@ -1164,6 +1160,16 @@ int bpf_core_patch_insn(const char *prog_name, str=
uct bpf_insn *insn,
>         }
>
>         return 0;
> +
> +poison:
> +       /*
> +        * Only relocatable instructions reach here. Poison both halves o=
f
> +        * ldimm64 so the verifier reports the bad relocation, not opcode=
 00.
> +        */
> +       if (is_ldimm64_insn(insn))
> +               bpf_core_poison_insn(prog_name, relo_idx, insn_idx + 1, i=
nsn + 1);
> +       bpf_core_poison_insn(prog_name, relo_idx, insn_idx, insn);
> +       return 0;
>  }
>
>  /* Output spec definition in the format:
> --
> 2.53.0
>
