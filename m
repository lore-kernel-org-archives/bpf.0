Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 940B93CCFD4
	for <bpf@vger.kernel.org>; Thu,  9 Apr 2026 12:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775738521; cv=pass; b=r4XiXceq13jQZtmvem5mAGZ8k0XqlSBs2NAtEg9J58EbFnOTFLbYeBdL+Ipo3BWWR9d1/0p1z3MteYzYG7GdfXBu7pG/y0+BAJUcYe1KA3kPjPgdEZvJVsZFk09ld2i9vjr4WnVqz6HoPVofWrJQU6x8g6mqtBOSJgEH9ssTRB4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775738521; c=relaxed/simple;
	bh=CXVexyaHWcToRDmha3nkO9tNbAoOtfc3VkC6kJvbNfs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U6Bs+hLdqcgoDNt6kvKJH8gIcpUroFAUbzdTJpqWfaM8KkfvrrNLNiJYFX4eNpuuVSe4CMzKf/Glya+Re62i+p11Jk/X9RH7ab8IQ+TYSG46oxeErlw3sG0uH5RtVx46LuBO3+bDqp50EQhNbt3TBAUsP3lyNhA4vBN0QI8NaUQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IthU/XcS; arc=pass smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IthU/XcS"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b936331786dso97074266b.3
        for <bpf@vger.kernel.org>; Thu, 09 Apr 2026 05:41:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775738518; cv=none;
        d=google.com; s=arc-20240605;
        b=BoEO8KNZ5nGvPQESJAhqSk6/aMUgobvr9fIw/usn82cqravnvwIU4UUl6+HSOOCUH8
         BNn/hvx8l4OBWsWn5bTkEnuw4NzXy1aNWBoI2bPtIvhI8qWe/+N30i9gvFvkNDQYIcM2
         KN97TDmJ+4IcPpFQnP7XxS/RNDuekz9FqLVjdpuxtAq8l78L19irwdbrGNkl7TRAluqy
         nDX2INYmOUwGTI9hmhml2I7oODTbMZVcfisl/dCxooh4e75JktGPPEQ8ZHsmx0qDbWOB
         7gB3sddFsGJSQ8xaVzMNYzg+C7911HRmtwc58HOt/I1s+5qvhBsOcfg/lV36Wf+0N5fi
         itng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=krEW4g39zA5lK72ctRH8tMRv6A/4JdJgscNdgkiGL6s=;
        fh=Kpau32bzo/z3G4uu8tE0wIS5W+4qWCDeMdkZykfGSoA=;
        b=Zs/vjWTydLhoWwNJGuZmVAcdoEKxUvRZuQP1ZUcB1O4+SMOgJRT5C58tmtOulPQPhw
         k137GqNNRzFAvv+6CVZE/byE9ezPH5rX5uyu4ddwixYJ3gFAQqDuHgqhlNbrJe5mEpwR
         fu9JF8dQ5BdH+HXEBE+qVKTqpSmsIkNtlD1SA444aC8syUP3ObqG4EIv9Z3OHsjKuAam
         eZ62f4Y14YnXWd+2v1IdtbRYY1pzeA7Dj9MY8g2Sby8YM6LTSWXtAaaRjzHOLFJOi6JK
         Ep53yu+pHkATwtjBL6RbetF61tzBcMtTLzJWttgXf4MQT+St94tYFsWi76oUAP9sDlF9
         c58w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775738518; x=1776343318; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=krEW4g39zA5lK72ctRH8tMRv6A/4JdJgscNdgkiGL6s=;
        b=IthU/XcSupH+OgHD8NXunweaKIvTONcJamSFL5u6YyWy40cjdTPM6ugARishw4pYUp
         Dw89NmnKassrmOiY2qq5pmJwgLzelNf3qNP+x67owH3luLUT/9QOLpq4DGf7LwpcCfl7
         1TSF0U1RizNxdjbzhsH1GK0suw4xx2nLOMnsgBMufgGPf6MrMnFwkRjEi1gT6Y0+aaR7
         exEWYybDlgDsaWqWEHVgyIc6ERSKoT7KbjiC5X5ur+Ub1rWJzMBsa6FVLLRejl68RAW0
         j/N6kiglSHfHGnfvpSouDjzl0DPyI1k5hJTQA5x9If6qKOFKCwRxj/0zliDTnx3qxsFc
         LGng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775738518; x=1776343318;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=krEW4g39zA5lK72ctRH8tMRv6A/4JdJgscNdgkiGL6s=;
        b=tSaU4dzgiTnMOBlPIiVLEEVFSZixdCGU08A6zoj0epkM6UOH7d3VX7jmUTKgqtl/me
         LQypGLrTBZA1pfdD7BTlDnRUMXH5+uC+syHqs4NmNHImzozRC7qD4HoBVQv9pnnT5CjI
         1uu7S0cTbwpCyzBDFQ2OsCCwwpn5OFpHL+8Hghjmwgkx28R4CBeVASVInSap+1NPruUO
         djcAZfHgJ61gRkMYcZQHdDtZh2p1ORC7fDNPJriie+MwyVCV5BLFb7ZAgbpN/sTFLpCJ
         tSDpQ1eVVrbAWfy02TqPXpDMh31tOIwq62rDJk8ufAoms+AnCYwfofazjc4iWYsWDgr9
         zO2Q==
X-Forwarded-Encrypted: i=1; AJvYcCXAaNqaV0BQKRiS96ZbbehUPGvHjrN7+CL2id4WEbZdVmM6jCQsWl4rwdQBV4tcq4cb9Z8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNnS60dDbKWXlZFN26TIispFmc5Us2zVlrDJNUA6XllLLE8fGf
	PVekb1Y/af4gRjMOXNqrDRpnI1Idb/zR/L6POFyaDQt8mCPl4X/ugj76Qj/lFx0g2SkJKLOcGLO
	38dAULSWfAzuItBRhkv2MqqbDEJqORss=
X-Gm-Gg: AeBDietGEnlfScdHgtaE3WAdJFZzfBqlGhmjyZnnmjGTyvBschgZaXQst7sdeZB6h8b
	tVP83iDIb/h7/lvSprRET/h9y4lZ2EEYcp529LvNz18ykmp+6prfNvyHH3FmdyF/o5LfBpg/gti
	rCzkD5rXBlf+bW4+2u80kIXz0JoXYcSsnOkHSFxPWEJzfUTp2xDXfpbVf32UXc3TPBEiNJZlYnG
	M8d81Jy/vqYv92ZEnj40E0Ibqhp+uZwM7R0dplsAgfpIB4GkEiKzPf0Yvmn7EdIQXCm02Kdq9EX
	eEwRzrRBApOcQxcIuROxf4q3amB+B5LefoWkcdQ3sVnsNCX0Yz16
X-Received: by 2002:a17:907:2d9f:b0:b9c:b3b5:bbf0 with SMTP id
 a640c23a62f3a-b9cb3b5bc8fmr945171466b.6.1775738517415; Thu, 09 Apr 2026
 05:41:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <DGJLR6FR7XLX.1D72IEB0DX9KC@wdc.com>
In-Reply-To: <DGJLR6FR7XLX.1D72IEB0DX9KC@wdc.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 9 Apr 2026 14:41:46 +0200
X-Gm-Features: AQROBzAuccbaZp02NzvMuXculSFeovu_NcZCmib9V_mWpNftbSe0wxj4pImE1J8
Message-ID: <CAOQ4uxgxUAzmmS7=TJi2zDX15vkG7Z2jtG2_Nh=HqEeyNLzzXw@mail.gmail.com>
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] eBPF-driven Data Placement Hint
To: Naohiro Aota <Naohiro.Aota@wdc.com>
Cc: "lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 20, 2026 at 8:22=E2=80=AFAM Naohiro Aota via Lsf-pc
<lsf-pc@lists.linux-foundation.org> wrote:
>
> Hi all,
>
> In Zoned Block Devices (ZBD), Garbage Collection (GC) efficiency is the
> primary determinant of sustained write performance. While current ZBD-awa=
re
> filesystems (F2FS, Btrfs, XFS) are zone-literate, they typically fill zon=
es
> "blindly" by appending incoming data as it arrives. When "hot" (frequentl=
y
> updated) and "cold" (static) data are interleaved within the same zone, t=
he
> filesystem must move the cold data to a new zone before the current one c=
an
> be reclaimed. This write amplification leads to significant performance
> drops across the storage stack.
>
> Existing solutions for data temperature segregation are often static (e.g=
.,
> F2FS file extensions). However, these don't scale well for dynamic,
> multi-tenant environments where data lifetime is better predicted by
> application context or directory hierarchy.
>
> We propose a unified VFS-level eBPF interface that allows for flexible,
> programmatic data steering. By invoking a BPF program (e.g., at file_open=
),
> the system can set necessary steering information, based on parent
> directory, process, or custom metadata, to ensure data is directed to a
> desired zone or block group.
>
> # Use Cases:
>
> - ZBD GC Efficiency: Programmatically separating short-lived journals and
>   write-ahead logs (WAL) from colder database workloads into distinct zon=
e
>   pools, enabling clean zone resets.
>
> - Multi-Tenant Isolation: Using cgroup context to influence e.g, block
>   group selection in ext4, preventing "noisy neighbor" fragmentation.
>
> - HDD Performance Zoning: Steering latency-critical metadata to
>   high-performance areas of the drive while pushing archive data to
>   lower-tier zones, accounting for hardware-specific geometry.
>
> - Optional: Transparent Compression Hints: Expanding the interface to ski=
p
>   compression for already-encrypted/compressed formats or choosing betwee=
n
>   LZ4 and Zstd based on workload priority.
>
> # Discussion Points:
>
> - The Attachment Point: We currently use a struct_ops approach in XFS, bu=
t
>   a cleaner VFS-level path would be allowing bpf_prog_attach on a directo=
ry
>   FD.
>
>   Discussion: Is a new hook in struct file_operations the right way to
>   "pin" a policy to a subtree? Are there better alternatives?
>
> - The Placement "Contract": Defining a stable struct bpf_placement_hint
>   that works across XFS, Btrfs, F2FS, and ext4:
>
> struct bpf_placement_hint {
>     enum rw_hint i_write_hint;
>     u32 stream_id;      /* Generic Stream/Class ID / Block Group hint */
>     u64 flags;          /* Behavioral toggles (e.g., ALLOC_FROM_HEAD, NO_=
COMPRESS) */
>     u64 private_data;   /* FS-specific context, could have compression hi=
nt here? */
> };
>
> - Lifecycle and Persistence: BPF programs are runtime-only.
>
>   Discussion: Should we keep this as an FD-based, runtime-only attachment=
,
>   or is there a need for persistence (e.g., via xattr)?
>
> I look forward to hearing your thoughts.

Naohiro,

I scheduled your session for FS+IO.
You did not mention if you needed the BFP developers to attend this session=
.
I assume you do not?

Thanks,
Amir.
