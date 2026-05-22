Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ABBD34388F
	for <bpf@vger.kernel.org>; Fri, 22 May 2026 18:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779474883; cv=pass; b=MhbRjs6hKMdwVyghBqrp+45ljqwytVHUbqTza6dDgD6qtxJHeIL/EYw5sE2FZ1ppefPwf0zPWN7oCMWha5QS6cYXRDIEtQ4mCWf38w7PV5h6rWbsRgxrK1HCmqsIxbTkFMHh5y7IjAoDSdR3BR5RCRSfMWMpya/Oritm0Pu7wv8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779474883; c=relaxed/simple;
	bh=Sy7iHC43dqOUvOqOXnQpn94I0stJf8jK+dwPg8++a+E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cop2I9aDIr7kbvtXSugsR0exNct3Z5I/f+A2VlxvDrPWVzefDoSDZuBIWmeUfiuvH5u58GWAtGESm+wik1Z0sgjCA6zpiLLmq7lVsWFOPYe+Jh6/5+r8SMEj4oEAgHig6Qb4V9/048IsCsY7cY0Z4IWHIcGZKh6AStwMb+Tz8YY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bnAKtyRl; arc=pass smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bnAKtyRl"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-c798fc1a28cso3430473a12.3
        for <bpf@vger.kernel.org>; Fri, 22 May 2026 11:34:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779474881; cv=none;
        d=google.com; s=arc-20240605;
        b=MkUOMMTYiZ9Ots4Qb2dJlE1n8jZUqHX3AbwUs7IuD9AHHev82BxQ0SyUC7zSVL9mfO
         rkKlWLTZ7aQX1oLyaFGms30qbI9W/b5G5VD5i83Qe3/xKh9H2aSK9YK2SUjswWI1J9vN
         cajWbaW0EHHLboc7Wk/kpnCM6mZ19oowJnmtvtL+FG9djb7bIxIKo/IKZVvMymo7KEf0
         HL7b9ZVPohMdYDknhV51re9o7iMi7T3wwL9IZp+SDg0wt3uSPGhZgX9sDjD7xceuP6Nd
         atfGvNdVf50GLX6RjkYIKvp4ifzRtULH0h7O3J++iitqWsJ/Tbpn7rhKGsMn0gfgofpm
         DlPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UPIIKZSuMDYHMAWcwom+NGDo9HPoParcv3S6Ulj/Jq4=;
        fh=rnpm9eY/wL9D+DaDljY0PDPmeZOPze768yiADm1Tq4U=;
        b=fsv+eyvaFE6Zr8VhM3SV1N4PQixf3DVcYVNRR+HlA0zqN6kuBxVt+3L05oGGU3QWxO
         bXgOombzQd4dUyGFrXdG3OOU/ti7TKG6TmcAxznTCGisivI40ktlwQDHrPmHG1eJopi4
         S7KKQz/63nMygU5dthIa5l+8BBnxVsVXvatjIk9lrFLTbm3NuwiQZYx+O6qac/3RUYqR
         J77FsCzdybrE/zisPYM51uDm1fojJSSd13ZCL3BzobMuiTzaLB//1QRNyFW64tHFeOx1
         mg1jHPg8w7VPNe/TOgR2l3dVCZ3gSm137l15NFxMzHR1YxxjyFBhPhfZYAV7BGbottav
         B4JA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779474881; x=1780079681; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UPIIKZSuMDYHMAWcwom+NGDo9HPoParcv3S6Ulj/Jq4=;
        b=bnAKtyRlHAVcmfuYlffMFe3p/GMePDl0FHZOQcrj8a4RjzQExyNIkkX5BEn4ABSsye
         IKufywJdCP29Ux1B5NvxwlnN/xKqne0OB5Y7O6JH4Op9SqdS4/Vt/pHAsysVbXwC/4g1
         TbeXsBFv2n6FZFAKP7AAyl/VpGsujWc1okXzTtiYyMjGQN/pePLRokxWaKy0nwr10+Pc
         g1kkeIBgbAH6Uqn5Ln5AQtvArjnR8KXYi+as/0R84xcTN+KIBsrKw3cOSnTkRHlrGPpt
         H0Lbe2v2pZrRZ1IOXdGv329fueaQ2+NmXWoNlGW2oTybTiBjHE6J1dsLrNmFgm3bcbia
         D5Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779474881; x=1780079681;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UPIIKZSuMDYHMAWcwom+NGDo9HPoParcv3S6Ulj/Jq4=;
        b=BlDn0paefBa0wHOdoTtaxgZ6sBa2lEGaAn9u6V/JHvRf8T0FKO4ERUs6417no1EQNW
         O78bzOU4FLASklO4yxzfr7dDbRUX+5iksrdS55J2N/r6tTc+nOSqMwtLaT1ORE0qWKZl
         yNKUOCWztS2Hap8Ij9NHZ2kMaZgAutLEcdeZLhkgrTUEON0CuYePvqUAS1hLO4DwAUcL
         ceF/MKkmdqQF1vn7OiDTf35XjPThqzKlvLgY8u7g3IgGq4eTJmA4VfTAk+FNvmBjwMoy
         ID2W/UnkSBGcpM0+vHEGCbDLFw5E/DWsTPhZoQa0+BfZldTyDl6WBCHe46pewNtgH/YK
         VrOQ==
X-Forwarded-Encrypted: i=1; AFNElJ+i90CqhfRKQcl8NyFGlBCicZHEvJ1DvMgfCR52PglcrPvy9iXKI2qMQqnPkVB2wqTLoQs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFs4sQsKf4921tqC8fJNSlU5VKKvisjjw4aM9/boS5UQvgDGKZ
	BPFWA+C8hJ2sxUDhK+YTSF3FmNqD5gaFW8Cs5Vc/i/JHHLKKusnUPEQh6Ja9Ik58otjcALdSEhg
	D2ukXRpqepL4HIA4Av0rf5ch0TqTacJk=
X-Gm-Gg: Acq92OF4shVMQSTHxC/vt318hyFPXlRoApnYsFKjqAuBHoZvQW3QRmRf3Y/O8Z2RE7+
	xNuRK8lk63adAD9KmwLCn+GYLDlqXaV7KimImTSKwGX4II1EPhb6DW6wNf9SHULKORnNlKvF73j
	kTcV8//MLda+M437/Ox4h1uqfV+V0+m8ZqCg8hN6jCMJqMpaINS1YZT1SlKr7hGCCLL1/YKT1if
	ex5Hfv8gDGeVLLYiwfrV30ZQZZvvbOmCF7K2BuC6s75h9v2WB/htxfQhhzv24U9nIezrOyI3BAW
	11fGHP3iPVogjKH/FBOG4BI=
X-Received: by 2002:a05:6a20:a122:b0:3b3:2703:12b with SMTP id
 adf61e73a8af0-3b328c700aemr5116344637.3.1779474881107; Fri, 22 May 2026
 11:34:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260522125657.328840-1-michael.bommarito@gmail.com>
In-Reply-To: <20260522125657.328840-1-michael.bommarito@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 22 May 2026 11:34:27 -0700
X-Gm-Features: AVHnY4KTOowvuD6XjQwRG69Vc_jNPi7Gp_JoUyDHDPgT7OHkgSNeSdfoQyIrlk0
Message-ID: <CAEf4Bzb2SJc4G9ah4R0gHYqHgRzED9+Ua+eLG=bG6Unn7f0Waw@mail.gmail.com>
Subject: Re: [PATCH v3] libbpf: harden parse_vma_segs() path parsing
To: Michael Bommarito <michael.bommarito@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 22, 2026 at 5:57=E2=80=AFAM Michael Bommarito
<michael.bommarito@gmail.com> wrote:
>
> parse_vma_segs() in tools/lib/bpf/usdt.c parses /proc/<pid>/maps
> with two widthless scansets, "%s" into mode[16] and "%[^\n]"
> into line[PATH_MAX]. Both assume the kernel caps maps records to
> PATH_MAX; it does not.
>
> show_map_vma() emits the path via seq_path() against the seq buffer,
> which doubles on overflow (m->size <<=3D 1 in fs/seq_file.c), so a VMA
> whose backing path is a deeply nested directory tree produces a single
> maps record longer than PATH_MAX. scanf "%s" / "%[^\n]" without a
> width writes until the field terminator regardless of destination size,
> so a bpf_program__attach_usdt() consumer attaching against an
> attacker-controlled PID overflows its own stack inside parse_vma_segs().
>
> Bound both scansets to the declared buffer sizes ("%15s" for mode[16]
> and "%4095[^\n]" for line[PATH_MAX]) and drain any residue past
> line[4094] with "%*[^\n]" before the trailing "\n", matching the
> libbpf-local fscanf style. Without the drain the residue of an
> over-long record would stay in the stream and break the next "%zx-%zx"
> parse, so the loop would exit early and any maps records after the
> over-long entry would be silently skipped.
>
> Also stop using sscanf(..., "%s") to peel the /proc/<pid>/root prefix
> from lib_path. Build the exact prefix for the requested PID with
> snprintf(), check it directly, and copy the remainder with
> libbpf_strlcpy(). That removes a second unbounded stack write and
> preserves paths containing spaces.
>
> Fixes: 74cc6311cec9 ("libbpf: Add USDT notes parsing and resolution logic=
")
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-opus-4-7
> Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
> ---
> v3:
> - Correct Fixes tag to the initial USDT implementation commit,
>   per BPF CI review after adding second site.
>
> v2:
> - Replace the unbounded /proc/<pid>/root sscanf() path peeling with
>   snprintf() + prefix check + libbpf_strlcpy(), addressing review
>   feedback on v1 and preserving paths containing spaces.
> - Keep the v1 maps parser fix using bounded fscanf() scansets and a
>   suppressed scanset drain for over-long records.
> - Re-ran real parse_vma_segs() ASAN harnesses for the original maps
>   overflow, the proc-root overflow, proc-root paths with spaces, and
>   adjacent successful parses after an over-long maps record.
>
> Reproduced with Debian 12 on rootless podman: an unprivileged
> container process mkdirs 50 nested 200-char directories and mmaps
> a file at the bottom, producing a 10403-byte /proc/<host-pid>/maps
> line.  A harness on the host then calls the real parse_vma_segs()
> against the container's PID; libbpf is built with
> -fsanitize=3Daddress and the only local source change is dropping
> the "static" keyword on parse_vma_segs so the symbol is linkable
> from the harness.
>
> Stock libbpf reports:
>
>   =3D=3DERROR: AddressSanitizer: stack-buffer-overflow
>   WRITE of size 10349 at <line> thread T0
>     #0 scanf_common -> #1 __isoc99_fscanf
>     #3 parse_vma_segs tools/lib/bpf/usdt.c:509
>   Address ... in frame parse_vma_segs at offset 8512, just past
>   line[PATH_MAX].
>
> Patched libbpf parses the same maps cleanly.  Follow-up calls
> return 0 with seg_cnt > 0 for libc.so.6 and for
> ld-linux-x86-64.so.2 (format drain), which appears in maps
> after the over-long entry.
>
> On normal hardened builds the stack canary aborts the consumer;
> on builds without stack protector the bytes past line[] are
> attacker-influenced path bytes.
>
> Selftest gate
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> tools/testing/selftests/bpf/test_progs -t usdt under QEMU x86_64
> (KVM) on the patched kernel: all 6 subtests pass (usdt/basic,
> basic_optimized, optimized_attach, multispec, urand_auto_attach,
> urand_pid_attach) on both stock and patched libbpf, diff-clean.
> The in-tree selftest does not itself exercise long maps records.
>
>  tools/lib/bpf/usdt.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
>
> diff --git a/tools/lib/bpf/usdt.c b/tools/lib/bpf/usdt.c
> index e3710933fd52a..2ed792cf11438 100644
> --- a/tools/lib/bpf/usdt.c
> +++ b/tools/lib/bpf/usdt.c
> @@ -471,7 +471,7 @@ static int parse_vma_segs(int pid, const char *lib_pa=
th, struct elf_seg **segs,
>         char path[PATH_MAX], line[PATH_MAX], mode[16];
>         size_t seg_start, seg_end, seg_off;
>         struct elf_seg *seg;
> -       int tmp_pid, i, err;
> +       int n, i, err;
>         FILE *f;
>
>         *seg_cnt =3D 0;
> @@ -480,8 +480,13 @@ static int parse_vma_segs(int pid, const char *lib_p=
ath, struct elf_seg **segs,
>          * /proc/<pid>/root/<path>. They will be reported as just /<path>=
 in
>          * /proc/<pid>/maps.
>          */
> -       if (sscanf(lib_path, "/proc/%d/root%s", &tmp_pid, path) =3D=3D 2 =
&& pid =3D=3D tmp_pid)
> +       n =3D snprintf(line, sizeof(line), "/proc/%d/root", pid);
> +       if (n < 0 || n >=3D (int)sizeof(line))
> +               return -ENAMETOOLONG;

this can never happen, no matter the pid value

> +       if (str_has_pfx(lib_path, line) && lib_path[n] =3D=3D '/') {

seems like an overkill, I get the point of not using unbounded %s, but
we can do the same trick you are doing with %* below, so

if (sscanf(lib_path, "/proc/%d/root%n%*[^/n]", &n, &pid) =3D=3D 1 && pid
=3D=3D tmp_pid) {
    libbpf_strlcpy(path, lib_path + n, sizeof(path));
    goto proceed;
}

or something along those lines?

> +               libbpf_strlcpy(path, lib_path + n, sizeof(path));
>                 goto proceed;
> +       }
>
>         if (!realpath(lib_path, path)) {
>                 pr_warn("usdt: failed to get absolute path of '%s' (err %=
s), using path as is...\n",
> @@ -504,8 +509,11 @@ static int parse_vma_segs(int pid, const char *lib_p=
ath, struct elf_seg **segs,
>          * 7f5c6f5d1000-7f5c6f5d3000 rw-p 001c7000 08:04 21238613      /u=
sr/lib64/libc-2.17.so
>          * 7f5c6f5d3000-7f5c6f5d8000 rw-p 00000000 00:00 0
>          * 7f5c6f5d8000-7f5c6f5d9000 r-xp 00000000 103:01 362990598    /d=
ata/users/andriin/linux/tools/bpf/usdt/libhello_usdt.so
> +        *
> +        * Bound the writes and drain residue: maps lines can exceed
> +        * PATH_MAX when seq_path() uses a larger seq buffer.

Claudespeak. Just say in human language that in some weird cases VMA
name/path can be longer than PATH_MAX, so we protect from that but
need make sure we consume the entire line with $* argument. Who cares
about seq_path() internals and its buffer usages?..

>          */
> -       while (fscanf(f, "%zx-%zx %s %zx %*s %*d%[^\n]\n",
> +       while (fscanf(f, "%zx-%zx %15s %zx %*s %*d%4095[^\n]%*[^\n]\n",
>                       &seg_start, &seg_end, mode, &seg_off, line) =3D=3D =
5) {

given you hard-coded 4095 in sscanf format string, let's use 4096 in
line declaration instead of PATH_MAX, ok?

pw-bot: cr


>                 void *tmp;
>
> --
> 2.53.0
