Received: from mail-dl1-f68.google.com (mail-dl1-f68.google.com [74.125.82.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E2B34B1AD
	for <bpf@vger.kernel.org>; Fri, 22 May 2026 17:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779472741; cv=none; b=OrOSC2zFxe2JpBw+OD4FFmv5qaxBEyvc0Z9YHN5Gqk8ipDiyFEKUZxdkMYHt0l1HTK0a4A2RGSWl8qX/z8wE5D0rJxUzfPJ/tjaJdH9h/c5xUmSLHpRU6VOD+oI8jjjN0sOkIVHvlJRagRWWEA9eRIcBA9Yv5rTJfJ9us0476AA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779472741; c=relaxed/simple;
	bh=KsyZKnI/Bz6wXOoeWnbUNwaDH5l3/eOwz6xwoeoB2dY=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=kwBStB53iVQDA1+eR4qnRPSxHMLEsP/dOLErbxt6kWmSwUaBQYc0dKmBQzVAJhB7QEYJTqTXgJ0NcvK5mp55/VWPFyKJ3xynllp5YWfmgO/5dsN5//+i6yehJixYOoMFg0SqYgo2+ggTEmKvHv5fnCWb8CSKvhIiB7z0mIoC3Fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=YZLgQO3u; arc=none smtp.client-ip=74.125.82.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="YZLgQO3u"
Received: by mail-dl1-f68.google.com with SMTP id a92af1059eb24-1329fc4bf77so1352609c88.1
        for <bpf@vger.kernel.org>; Fri, 22 May 2026 10:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1779472739; x=1780077539; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lh4W5BNIoskLX0TQMdv0FPpA/HQYFRMPHADPB5KSOos=;
        b=YZLgQO3u/QqaKbo0o4buONu5nBGgpmI3J9eU1HXUbvkH6p0l4U7P1t3yApOX4CfQZ4
         VnEFc9JYJ4D83wnicMJ71Th5XtOjFLfV0aSSs1rJky24LwvOKhnMTvtN9diqgyEEAjL0
         qrLFhCbvIuHCELPx1k2QctGSWemE1uIRtazWHjakAHkR8nSNUyqZp4amwiwcTFY6nown
         IACZyh/5PaFu/WR+zM2mJ20O7svH1mMAidFvfp0JledJOEa1PJAdO3PcNiuJ8/hw33OW
         QLJ9Q8uS8gjd9A9FjdelnqBN7+2qnDJ2G+gcykRB221D74Fg3RCh2UOcFXAO2FByB0Ta
         touA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779472739; x=1780077539;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Lh4W5BNIoskLX0TQMdv0FPpA/HQYFRMPHADPB5KSOos=;
        b=inx5xYwomDcWwGj3sej3JnS+Zht7mG6HVeG8Qsxvjp4H4dMUnX6bO1WYLbv+/nrZfu
         Ygkuto0N8ItqN9Gkd70BHwbKazfxtPL+ZHjy/gHBvFMzn9fXRkq2qgtj/sNOM/iO2AKm
         cCQMgisBB1KvD7/YTBPNXcK1ZarBdp7wh7AO+MV536yqzyKCRFNJHnXPmXh6/prJj7rY
         oFzOP0lBJyTee3jx5pSh1/nAbVmtGYu6hRVDBCRXGok1RTw+s2dPC697NkhmnxhUe+yh
         FrM6rbehZW6wu94x5lhIcDkDm9B8JTEtk3k8dauQfKxqwiKicsJvcOT9Uc5M3DJNZcF8
         qwoQ==
X-Forwarded-Encrypted: i=1; AFNElJ8vXHyJpYV9bU9OTPtJmxievJMruAYNrRxYKVNh0L54re4fcaeCCGfgrvIkIBBK1u+xioM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/hUDW/gxkexD7y9G9vUPcszQSHDniYPsNjPwXArC9fnXFf3H1
	kf2EA7vosMD5hKQ9R2VNGS7L5Me0Y8ElgmwU+85kFnFayxwZt5VmYKGkSpt+e6/MT/4=
X-Gm-Gg: Acq92OFSEclPtkJD+b+VLLSEtund35zub8+CzWTtYfTRXCcX8Q1pk8cfq7tI+zsz3N0
	NpxCAACi0gmTKPLU2XVOPwC653qoQ2nFFyaEmszUPGGKUSuz5F8Hi2IqBCj8m6yJPYBEQ2MKR6L
	J83tmGTQBdOsmwin9Md15bR1NprJqzbzX6HpPV88Ejhquol9SKafqksSSHtE2ftSzKUtcWV2PV0
	FT3ORb3kWpMhN1QmlJv4X11HKHO8JdwAxuSXWHeLdbi45YOJeycU6V0zY4/zeBE81NNgfDJ06A2
	V4ihTvG4aAStkyK9HrkxHSzWZXcG++9LQnm8ZaB9/o0ZGc4j5646ANNbZzO75Frt2rMCOC0hhu3
	BeuQWgJtK9LVtBsWZECCxmqm3JQwQtV72hXhUHGTHNBOXtNkGNW+Pi8XEsLfU0SrgZIOXyEI+Yr
	4HO8vaZbH99FiTgwU=
X-Received: by 2002:a05:7022:fa9:b0:11b:f056:a19b with SMTP id a92af1059eb24-1365f926a43mr1952822c88.18.1779472738250;
        Fri, 22 May 2026 10:58:58 -0700 (PDT)
Received: from localhost ([2620:10d:c090:600::69da])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1366a40187fsm1730445c88.5.2026.05.22.10.58.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 May 2026 10:58:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 22 May 2026 13:58:50 -0400
Message-Id: <DIPEFQQTYWPL.2PQYHGMN8D55U@etsalapatis.com>
Cc: "Alexei Starovoitov" <ast@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Martin KaFai Lau" <martin.lau@linux.dev>, "Kumar
 Kartikeya Dwivedi" <memxor@gmail.com>, "Song Liu" <song@kernel.org>,
 "Yonghong Song" <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>,
 <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] libbpf: harden parse_vma_segs() path parsing
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Michael Bommarito" <michael.bommarito@gmail.com>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Eduard Zingerman" <eddyz87@gmail.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260522125657.328840-1-michael.bommarito@gmail.com>
In-Reply-To: <20260522125657.328840-1-michael.bommarito@gmail.com>

On Fri May 22, 2026 at 8:56 AM EDT, Michael Bommarito wrote:
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

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

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
>  	char path[PATH_MAX], line[PATH_MAX], mode[16];
>  	size_t seg_start, seg_end, seg_off;
>  	struct elf_seg *seg;
> -	int tmp_pid, i, err;
> +	int n, i, err;
>  	FILE *f;
> =20
>  	*seg_cnt =3D 0;
> @@ -480,8 +480,13 @@ static int parse_vma_segs(int pid, const char *lib_p=
ath, struct elf_seg **segs,
>  	 * /proc/<pid>/root/<path>. They will be reported as just /<path> in
>  	 * /proc/<pid>/maps.
>  	 */
> -	if (sscanf(lib_path, "/proc/%d/root%s", &tmp_pid, path) =3D=3D 2 && pid=
 =3D=3D tmp_pid)
> +	n =3D snprintf(line, sizeof(line), "/proc/%d/root", pid);

Minor nit in case this gets respun: Can you mention that the n >=3D int(siz=
eof(line)) check also
takes care of making sure the libbpf_strlcpy below doesn't overflow path?

> +	if (n < 0 || n >=3D (int)sizeof(line))
> +		return -ENAMETOOLONG;
> +	if (str_has_pfx(lib_path, line) && lib_path[n] =3D=3D '/') {
> +		libbpf_strlcpy(path, lib_path + n, sizeof(path));
>  		goto proceed;
> +	}
> =20
>  	if (!realpath(lib_path, path)) {
>  		pr_warn("usdt: failed to get absolute path of '%s' (err %s), using pat=
h as is...\n",
> @@ -504,8 +509,11 @@ static int parse_vma_segs(int pid, const char *lib_p=
ath, struct elf_seg **segs,
>  	 * 7f5c6f5d1000-7f5c6f5d3000 rw-p 001c7000 08:04 21238613      /usr/lib=
64/libc-2.17.so
>  	 * 7f5c6f5d3000-7f5c6f5d8000 rw-p 00000000 00:00 0
>  	 * 7f5c6f5d8000-7f5c6f5d9000 r-xp 00000000 103:01 362990598    /data/us=
ers/andriin/linux/tools/bpf/usdt/libhello_usdt.so
> +	 *
> +	 * Bound the writes and drain residue: maps lines can exceed
> +	 * PATH_MAX when seq_path() uses a larger seq buffer.
>  	 */
> -	while (fscanf(f, "%zx-%zx %s %zx %*s %*d%[^\n]\n",
> +	while (fscanf(f, "%zx-%zx %15s %zx %*s %*d%4095[^\n]%*[^\n]\n",

It would be nice if we could somehow not hardcode the lengths to make it cl=
ear,
where we're deriving the values from, but unless I'm missing something ther=
e=20
the only way would be to snprintf the format string every single time which=
 would
be overkill.

>  		      &seg_start, &seg_end, mode, &seg_off, line) =3D=3D 5) {
>  		void *tmp;
> =20

