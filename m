Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.172
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793925293;
	b=H0xlZHMIzbQtGhpd191xgl6zdqzmbgmwD70yIVLIlyyEj/kFqoBKwh4ve5dbgbl1phCl
	 OCa1MN1orfokGJNoZjb+h6CGG4iQo0uP2cD8io86j8gzuoHV94XYG4ISUwsu0QYIc1SDb
	 bvcpfDyOJbQb0WX9iauOKnLtoaOCHlIlfZXEbCVFYR+3rY8XmLr3RKt1cO/6x6nI6gAhG
	 jVwzT1WqGAOfhUt27kXmh/lMMZy3k56k4saC2qv4uMmxHAlZhDzfQUHrsyABKbUef2XKb
	 k8OUpRv3wpxH9YHsHjVFsLpYIbbX0inwcTZWJqCr1hnIn9Ld1hgtxNjg2kQhwuqv+xg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793925293;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=02QAP4BRChAM3iykURm2Ztmkd6pLWewsJZlk3WHtQgM=;
	b=OyrHgTqRIeU24uXuwZZ8wIVmPqlNDWq0Hx5MH8WG0gFgdLcWF1LEEMR9SHYegvq69zZN
	 54I6cuV0YPrujAPrCKwdkuphjApOwV8ebcUoWzsQXM+5PbLo0crAyX03FnUD9Ykj2dno4
	 NhKilXgHs+ocNcNq9rhv6Rm24D5x6pslKq5eHRqMICxmoTzIAJEYPsLqtVYG9XC2AATQb
	 2s14vDa2IQ4dn0N/z2eLwCddQWAzTz4sPG2Y67SwfWi2WrFgJV0g7d86lJfUE1Av8RbMi
	 INzK1ONgYXu1Z4zTz3c0NSF33nHi+v7PAaW7bFvvqhiiWAVy2U5r2B1XaiHphNqNIzw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lWB83nU3;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.172
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A71CE606A31B
	for <bpf@vger.kernel.org>; Fri,  6 Nov 2026 00:34:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A71CE606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lWB83nU3
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2ed0890476fso556175ad.0
        for <bpf@vger.kernel.org>; Thu, 05 Nov 2026 16:34:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793925292; cv=none;
        d=google.com; s=arc-20260327;
        b=E3/bCq7UxNMs48osfiNeVcBS8vKGi+7x2NorMv8HjnBLRPu/gkSTzB4/4RuHc/vVZ9
         i01PxUK6Fz1NuoIUZPbwqVMwStc75pI3mn32DZNyfz6j9EpqVhpOS7wz5dFJrJe7thDc
         Eq4qvvMKWFIrHWygDOUu6Am6uKKUtFGtplEA/g6FzjTanGVjXQPeAwJkOEGkorFcfhpV
         Wzj72NNoCHC8/aVMWFIePzavtxdd8kXQI+8B4XwwbcUcc/Z0tk8nZg0dG6uo3bMVuDmP
         3Cy1YPgLAG8cjoRK6+nBOse1VQJYHWT1ndknER8a+qAMtp8UoVN6FpIagznL3ABsYgo2
         rOpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=02QAP4BRChAM3iykURm2Ztmkd6pLWewsJZlk3WHtQgM=;
        fh=stsBBFSdoStyUEGubALNOTH9zWlzOBzr0TAuhis0r4w=;
        b=ZoLH2baEbYCROxd2LTpQs2axMeMSDxU8oOu944RQbj4Om0pkmCsEc7s9ZokE0fmWMY
         FK6wxv7Wpm5cXkm+2Jx6JKwUdFkQ4QUtP+6fsRkfK6/HLb9dl4caQ/wsMSRZ+kvsVA+O
         jPQhE0QhFesY5ePPyEzdnTrawrTS/Hk/2/OAtvKPfonzat1hBNRwWBkWDr0fSWtwhEMx
         GKmfx9ihLKy4hj79M8o4VUKj2pYyQ46ajSf8/L2oXtyDbp9N6pBsvx4VuKbHR1EGfsVP
         /O9srJ+DVsjC0vEB3tVnyN+2FXfaZC5HJEJYPHlkeGfLR4/rn69kK1eYlQT+04bZ1YIW
         zQkQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793925292; x=1794530092; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=02QAP4BRChAM3iykURm2Ztmkd6pLWewsJZlk3WHtQgM=;
        b=lWB83nU3TZZT2juICGQlBDuYesWYWuyX2h6wcT2WorIWomjEynyzi2MTLlwbgtd/Kh
         kEMSWSfSZvdI4ipoFYzunCZoaO5jwHDXR7EaT/BvC+VszGmArQl1konDBs/e3qv7jHWU
         fLRtFEWVTggAkTRIn+8nFBS8HI5buW+UvBmg7+f3i9NjkJxhp038gs7svcEsyGjX+A4c
         aoM7jocnkQ2Ou9eWTlieBNveQ+rUktswxYSCf7x2214xcA7LnEnYygjY6YyCb8N8ApTw
         GBsEXyliQJWvaZ+Yu6hGVl2QQmQhaAiSsoAr8d8jVG6/v2n2kFLQnxA/PyzNlAd2wNcY
         zKOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793925292; x=1794530092;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=02QAP4BRChAM3iykURm2Ztmkd6pLWewsJZlk3WHtQgM=;
        b=AFr+DGw+IblsATmGltunKDS+1iSiEnXWIUx6QAiJxuO0nuROg62t/ugdmTnxal1OYy
         ir4iSIJxYnpfrDlWqrqnC1HuuMDV/nW20o3FRTMqJctv6YIErU21XMxmUgkowr0dUqA0
         l7wMkQ6H/FRkrHREakr5AB4R4fVzO6i8/ttAgTt5JwyOs2SgwnTL0Ubfi/993M6FeFME
         dIc3ltNE66N6xIBkdWtGjdSvuC8MM2itnu2Lf03qat2XMeqeM5CKF9mSe/UnNC8zvku3
         PiEFqHGm3mAsd3Erta+5Z/Jtbbru27RzcSzkBCfpxQypJGKQEzipNnfm0ItDVNyGEZHz
         axcw==
X-Forwarded-Encrypted: i=1; AKwUvBweVN0nxy7XlvZaVjiU3He7C8HSnu6ecIYsalxBTnKkPX4si3qGajr/AULd6yymp1ycWGk=@vger.kernel.org
X-Gm-Message-State: APuU4Z+ULjBnSXLg/1vDp1jcproWlp1+C9Vyfk/oM2ZUg7wZAMhMpcUJ
	9Wbal9TUs+bKC18uZb3VqSfLFp2gGrrIEpX0VNHsZapLHuQ5dIg7aXixTqH7e4tSIFh74rxrlCP
	e9egfC/kSsTp5EnL7h0SgMkWWucH/Rx4=
X-Gm-Gg: AYBFou19+n9Mgd0390EQ7Z1YkQYfYMYhBwNFzqzBCTCdY8+YyDdrOB5QPcmWi4PsLDn
	YQ30ExGjSUiqhvcsCZFxAuv6qgP7CEF2PqMkuQI88W/7BJd2PVlnXW38ptTZkDrQhMVgGYQ6FcJ
	hwZ9qqFz6dfwo2kQf6TMb4ftjggVSN+BBq4d9jjnFi3tcahsHmzXBjRnBOnonQHL2gtxiBW9tm5
	/9brlyVXWkoBCwd0vjiUocCZxeNLHpZaUoB4BQzY0lutZcgzvPCHXfuVhLkpGIVU3FON8Otz/Q1
	eWuf/KA76cjUGZ1b/soX5bj9rIeH6FzrPeVQWbRUC4MHHB3I4/uR/pGlV07tXddD7u9tKGsZuwH
	SmZqdvJISWkiIBTJyayBLW4zmvvYieKbVEVkdJFdfkPxXkS31j5AvKnJDJlCTrurMO83kE2PJXm
	KnoSkqkrwUYAkj6vgicI6KTqR89YHnfW1ZEw==
X-Received: by 2002:a17:903:2b05:b0:2ed:3f47:9696 with SMTP id
 d9443c01a7336-2ed40c7b5bcmr13899535ad.35.1793925291850; Thu, 05 Nov 2026
 16:34:51 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261105102343.311331-1-jolsa@kernel.org> <20261105102343.311331-3-jolsa@kernel.org>
In-Reply-To: <20261105102343.311331-3-jolsa@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 5 Nov 2026 16:34:40 -0800
X-Gm-Features: AclHuK8eP4aP7e5aZ3VTvmtBXE3vHsFqbDq4B6KK4YEagZrzajw2VXUziTJJzRM
Message-ID: <CAEf4BzY+1a8v8AHcr1AfUBR24uMitU7gEe2_1Npwp-8_kagU3w@mail.gmail.com>
Subject: Re: [PATCHv3 bpf-next 2/8] bpf: Add user memory kfuncs
To: Jiri Olsa <jolsa@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org, 
	linux-mm@kvack.org, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Lorenzo Stoakes <ljs@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Federico Di Pierro <nierro92@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 5, 2026 at 2:24=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Add sleepable kfuncs to copy data into a task's address space and to map
> or unmap private anonymous memory in the current process.
>
> Require a usable user mm for mmap and munmap. Register the kfuncs for
> KPROBE programs and gate them on CAP_SYS_ADMIN BPF token capability and
> the BPF_WRITE_USER lockdown check.
>
> Use FOLL_FORCE | FOLL_WRITE for task memory copies and return -EFAULT
> when a copy is incomplete.
>
> Rename the syscall info-copy helper to bpf_copy_to_user_buf to avoid
> the name collision.
>
> Assisted-by: Codex:GPT-6
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  Documentation/bpf/kfuncs.rst |  17 ++++++
>  kernel/bpf/helpers.c         | 107 +++++++++++++++++++++++++++++++++++
>  kernel/bpf/syscall.c         |  10 ++--
>  3 files changed, 129 insertions(+), 5 deletions(-)
>
> diff --git a/Documentation/bpf/kfuncs.rst b/Documentation/bpf/kfuncs.rst
> index 4f8dd7c1d785..81686d556f58 100644
> --- a/Documentation/bpf/kfuncs.rst
> +++ b/Documentation/bpf/kfuncs.rst
> @@ -976,3 +976,20 @@ the verifier. bpf_cgroup_ancestor() can be used as f=
ollows:
>  BPF provides a set of kfuncs that can be used to query, allocate, mutate=
, and
>  destroy struct cpumask * objects. Please refer to :ref:`cpumasks-header-=
label`
>  for more details.
> +
> +4.4 User memory kfuncs
> +----------------------
> +
> +The user memory kfuncs operate on the current process's address space.
> +``bpf_copy_to_user()`` writes to this address space, including private m=
appings
> +that are not writable. A partial copy is not rolled back if it faults.
> +
> +``bpf_user_anon_mmap()`` and ``bpf_user_munmap()`` create and remove map=
pings
> +by calling the kernel's mapping functions directly rather than issuing
> +``mmap(2)`` or ``munmap(2)`` syscalls. As a result, seccomp filters do n=
ot
> +mediate these mapping operations. A seccomp filter can still allow or de=
ny the
> +syscall that triggers a BPF program, but it cannot separately filter the
> +mapping performed by these kfuncs.
> +
> +.. kernel-doc:: kernel/bpf/helpers.c
> +   :identifiers: bpf_copy_to_user bpf_user_anon_mmap bpf_user_munmap
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 6788489a2608..937a0d7d6839 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -29,6 +29,9 @@
>  #include <linux/task_work.h>
>  #include <linux/irq_work.h>
>  #include <linux/buildid.h>
> +#include <linux/mm.h>
> +#include <linux/mman.h>
> +#include <linux/limits.h>
>
>  #include "../../lib/kstrtox.h"
>
> @@ -3768,6 +3771,88 @@ __bpf_kfunc int bpf_copy_from_user_mm(void *dst, u=
32 dst__sz,
>         return ret;
>  }
>
> +/**
> + * bpf_copy_to_user() - Copy data to the current task's address space
> + * @unsafe_ptr__ign: Destination address in the current task's address s=
pace
> + * @src:     Source address, in kernel space
> + * @src__sz: Number of bytes to copy
> + * @flags:   Reserved for future use; must be zero
> + *
> + * Faults in the destination and writes the way ptrace(PTRACE_POKETEXT) =
does:
> + * a private mapping doesn't have to be writable. A partial copy is not =
undone,
> + * the bytes before the fault stay written.
> + *
> + * The caller must coordinate with other threads so they do not execute =
the
> + * destination range while it is being modified, and ensure execution be=
gins
> + * only after the copy completes.
> + *
> + * Return: 0 on success, -EINVAL if @flags is non-zero, or -EFAULT if th=
e copy
> + * fails or is partial.
> + */
> +__bpf_kfunc int bpf_copy_to_user(void __user *unsafe_ptr__ign, const voi=
d *src,
> +                                u32 src__sz, u64 flags)

you'll eventually want bpf_copy_to_user_dynptr (we already have
bpf_copy_from_user_dynptr), so might as well add it from the get go?

> +{
> +       int ret;
> +
> +       if (unlikely(flags))
> +               return -EINVAL;
> +       if (unlikely(src__sz > S32_MAX))
> +               return -EINVAL;
> +       if (unlikely(!src__sz))
> +               return 0;
> +       ret =3D access_process_vm(current, (unsigned long)unsafe_ptr__ign=
, (void *)src,
> +                               src__sz, FOLL_FORCE | FOLL_WRITE);
> +       return ret =3D=3D src__sz ? 0 : -EFAULT;
> +}
> +

[...]
