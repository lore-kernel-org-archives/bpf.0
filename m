Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDF233264DF
	for <bpf@vger.kernel.org>; Mon,  6 Jul 2026 17:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783357995; cv=pass; b=GE24wA5OgST/9cHy0M5X3U/LpccWcReYdzbnNCrJyLdNEUyojq90I1tU/lssZythjhWw2cdqN4HzetY3KRU7GVfVQEp0rAE0qvlC4tzbMlkZgJJJNVbyINL8EaoL4VgCx+ybPJZSFDH+7RBkBRzLqLs6cXtMafzpAUjRD6t59jU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783357995; c=relaxed/simple;
	bh=1ZNEn0E8kMjTljW5xMZlKQLRFTDyE82gh+WwjDpJB3w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lPqTquER29GnqwQ2ExlPZduthT4OFgUp8nRD1OpHvCz/l9sFrvc8GggDQcRTa2qrZujFG0syk/y+PwMrFUmIIsilhIPSfDWMnuRINRYDaonBpSupMc9xiDzkDAfZivK8qjcmJIORg2/hy54YB49g6ZD0dXn/XzU8q1kV0MQ8a6U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=gABKBJEZ; arc=pass smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="gABKBJEZ"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-381065a7a03so2439104a91.0
        for <bpf@vger.kernel.org>; Mon, 06 Jul 2026 10:13:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783357993; cv=none;
        d=google.com; s=arc-20260327;
        b=RXh4epyPW0u7CfWHiddmQ9bMI6Xd5K319cKb9/YPj9ehd2HAQddAD/sw2WOAkmI2zk
         Zw2is3CGdQmezQrzuo17ozPaRU87UuSBuGqufZ3u7fu6vCyWUZ8E0zg7/bTEAOM9rpYX
         03rj7Hzierl5M9a1FyahsBFP+a/Uz2HxNE8ksU76Av8LDWdJE02cYkVBkM/FZRTFYNOR
         6ZFsXKzcSnbp6yMqkcx7Jajk5sqHYo1jGWRnzC5Saz5WQHwb1xopdjIwAs6p9YMhnFYQ
         /VyXc0JOjsqQeIk0WWdXT829hn6NH3eZsTflh0b8MLn0nL0ZxR/6RA6/t3sIIIEsjDbm
         HFzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0xmu+kWC2HiBNzOMZUwexKsbY0N1RGOC8BXOe7wfUo8=;
        fh=GbIDqfATo2fbDwropNDCkLA0fO6Q2aLROXRKa3+qGLc=;
        b=FxrTitGHeoHCnslLzu2ynvsgR9RGnkvkapb0ftj5FOXgap+iLNBU4ZRYbgWrzXin5y
         APjyPv9TRuhxM/UZKvXwEwUPgDGAV4+4e8OtaimWqEmehh0mVkP4YteJvw8Ojci7oB6G
         A6fER00YshqTfHehY234M8uf3V6aUdyXQ9oFR/6N9ypx5LaH6iER+r7N+qQv62oqwcqu
         LGcWJkGq3nKhVOs4/DleLuRil1Wk4J9VFoul7VfpPs/lAVW1iiteURqhrfzbgzjm20Ek
         R+ApIWHwr4YoLQIjcAr0epGw/dA+WQ4w9ykyCfjjGus1V6g9ffk1b7sJhKLrpcFQ3Qgg
         i30g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1783357993; x=1783962793; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0xmu+kWC2HiBNzOMZUwexKsbY0N1RGOC8BXOe7wfUo8=;
        b=gABKBJEZplBQOeAiY58cDNt5l0T9YcmfC8zY4vMK88ojpnv5vLtz7eivmuXDl2tMJU
         JK9l07DOsc3RjvWRy6M96kAaJjUxsmgOLj5009a8lVsW+Fs7jBbKEtXlfnWllROILO4W
         CkiD9t3Rg9zR3ogGXsoBJPKiDlN2r90zET1lOG32RWRqjS/OAF7Jkq4NmRcmLLS7BS9m
         lBMwB++Prq8P0TPuR43XDT4fOdoJq1jxrywAw/7nbnquEySFtxGFTDQWLDLeeW7//3tO
         ve5jm4rzh7lyZbr1fpLQnVhUjsAenkcw/gyZ27VM4HZcN+i4bYE2D7PyMKPvwsOPLzO6
         S7Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783357993; x=1783962793;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0xmu+kWC2HiBNzOMZUwexKsbY0N1RGOC8BXOe7wfUo8=;
        b=ZzbT2T5CuDNTiGusUEXxane2Uc6XmvX5XMx9qLl8JI4a741Fd2PY2NAahjRJgd6zG6
         5Wmig8qLjVaom3ErY3HlZgcRC6VIHbAov6xHdTjQ+mQPXKxls5uEiEM1zHLJ7GaTx9tV
         6rpc6ahJhvLbX/FMuMc6mi4ih8XN4Z5h3ce8ocQtuJThCc35Eul38i0LwnzMrHnk+AI+
         /MG5iM5zbrA7DkbMHbI2YDDGy6k2fvSDd5GsYqWwpVg2UEdvI8ivNS0/PHCTr9fyJgE9
         tLQT8aKQQGvdmSV1k3RhxxgqV2tGHReDsESY/nn+UUfT3jKdsxm6dF0URiSH02ksnXNO
         JmoQ==
X-Forwarded-Encrypted: i=1; AHgh+Rp+DU/Lr0HPTm54wY+8qIaegi33amdo22w9N9dy4WmaUmqZAV+vI02gZE0P+RAVEcF1gsE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFS7qnqrYJ/Rv46hOAPd6O4DQLTbOR8KdZUUzPJk6/VGokSR5v
	fsDoPYOmDlPhAmo4vaknFTHbRKD+ywl+sezkRYFY2hYw4MCV5mIrEPg7FW5bYVVVAU58NGPsjen
	hrwdwqqziH700+BgOjW3ZGdzdu7jeAdjvXBSIUygZ
X-Gm-Gg: AfdE7cnWIIxvxbVctlAO9lnlKGYoHAv/dmZ6M/cF2mTY/k4iED79r6jSKWqtQ5t/jcJ
	e0OkM+b4pQzonpX6Veie6Z63sK5/JCLwK56+A++Q4Udsa1q12RUVWnsgBamsxcAMduJzG+uC1or
	NEgJv1HAMiVCXlxaNgvS72nHMsHyBSE66AIUM2+xC7xlD6eHEFQMLKrs+X9IlnDSFwCabSPMDum
	eDiiwYSjaYq0SN3N5LgV/8muxlNI43u/pnBZbJr6JJrLLOYUm0jT30PgawrZcyGa3u477Lm
X-Received: by 2002:a17:90b:3dc5:b0:381:6466:7160 with SMTP id
 98e67ed59e1d1-387575a0b4cmr1310473a91.26.1783357992887; Mon, 06 Jul 2026
 10:13:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260706135644.326006-1-daniel@iogearbox.net>
In-Reply-To: <20260706135644.326006-1-daniel@iogearbox.net>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 6 Jul 2026 13:13:00 -0400
X-Gm-Features: AVVi8CeCuWrUiOENGEA-IpthH0EltUGg_gz23gBLobgWKHgUrDsTpSX5qNBeOt0
Message-ID: <CAHC9VhQbqxJFBX+3-JiHR7+QqgWsiAAak7J4-q3QykdGqB7g+g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 0/9] Verify BPF signed loader at load time
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: ast@kernel.org, kpsingh@kernel.org, James.Bottomley@hansenpartnership.com, 
	bboscaccy@linux.microsoft.com, memxor@gmail.com, 
	torvalds@linux-foundation.org, a.s.protopopov@gmail.com, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 6, 2026 at 9:56=E2=80=AFAM Daniel Borkmann <daniel@iogearbox.ne=
t> wrote:
>
> The BPF signing scheme signs a light skeleton's loader program and lets
> the loader vouch for everything else: bpftool bakes the SHA256 of the
> metadata map into the loader's instructions, signs the instructions, and
> the loader compares the (frozen, exclusive) map against that hash from
> within BPF once it runs. The construction is sound as a trusted hash
> chain, but the kernel itself never attests the metadata, and that split
> has been the recurring objection from the LSM / integrity side since the
> scheme was proposed.
>
> This proposal closes both gaps by having the kernel verify the metadata
> at BPF_PROG_LOAD time, before the LSM admission hook and before the
> verifier, /without/ growing the UAPI. A signed loader binds its metadata
> map(s) through the existing fd_array/fd_array_cnt, and exclusive maps
> are already bound to the loader's digest via excl_prog_hash. When a
> signature is present, the kernel collects the exclusive maps from the
> fd_array and appends their frozen contents to the instructions before
> PKCS#7 verification, so the signature covers ...
>
>     insns || metadata_0 || metadata_1 || [...]
>
> ... in fd_array order. The in-loader hash check is dropped from the
> gen_loader entirely: generated loaders carry no verification logic
> anymore, and signing or verifying a skeleton becomes an ordinary CMS
> operation over bytes that sit verbatim in the skeleton, reproducible
> offline. A signed program is either BPF_SIG_UNSIGNED or BPF_SIG_VERIFIED
> with nothing in between.
>
> There is no new UAPI, we now have a single signature scheme, no LSM
> code reaching into BPF internals, no new LSM hook, and unsigned loads
> are completely unaffected. It is also less complex since the loader
> does not need to deal with BTF, an extra kfunc, etc, as proposed in
> an earlier series [0]. Tested against full BPF CI which came back
> green. For more details and examples, see the documentation patch in
> this series.
>
>   [0] https://lore.kernel.org/bpf/20260522023234.3778588-1-kpsingh@kernel=
.org/
>
> v3 -> v4:
>   - Fix upper limit in MAX_FD_ARRAY_CNT (Anton)
>   - Reject !fd_array && attr->fd_array_cnt (Anton)
>   - Add bpftool patch wrt ignored return value of EVP_Digest() (sashiko)
>   - Fix setting of gen_loader_fixture_init (sashiko)
>   - Fix unused map_fd cleanup branch in selftest (bot+bpf-ci)
>   - Remove now unused map->excl member and adjust selftests
>   - Added more BPF signed_loader corner case selftest coverage
>   - Added Paul's Nack wrt bpf_prog_load LSM hook dispute
>   - Added patch 2 to move bigger allocations below fd_array
>     resolution (Paul)

If you want to squash patch 2/9 and 3/9 together so that one can't
easily merge 3/9 without the vzalloc(program) relocation I'll gladly
drop my NACK on patch 3/9.

> v2 -> v3:
>   - Added first commit to cache and work on objects in fd_array
>     which was the most recent issue sashiko rightfully complained
>   - Added more BPF signed_loader selftest coverage to cover that
>     usage of sparse fd_array or map fds gets rejected
>   - I left the security_bpf_prog_load as in v2 given preference
>     from BPF side over adding new hook
> v1 -> v2:
>   - Addressed both sashiko complaints, the TOCTOU bug regarding
>     fd_array processing, as well as exclusive map checking to
>     only allow array maps. The validation is now moved into the
>     verifier before the main verification work happens. This also
>     gives the opportunity to utilize the verifier log.
>
> Daniel Borkmann (9):
>   bpf: Resolve and cache fd_array objects at load time
>   bpf: Move bigger allocations below fd_array resolution
>   bpf: Verify signed loader metadata at load time
>   libbpf: Drop in-loader metadata check for load-time verification
>   bpftool: Check EVP_Digest when computing excl_prog_hash
>   bpftool: Cover loader metadata with the program signature
>   selftests/bpf: Adjust bpf_map layout in verifier_map_ptr
>   selftests/bpf: Verify load-time signed loader metadata
>   Documentation/bpf: Add BPF signing and enforcement doc
>
>  Documentation/bpf/index.rst                   |    1 +
>  Documentation/bpf/signing.rst                 |  496 ++++++++
>  include/linux/bpf.h                           |    1 -
>  include/linux/bpf_verifier.h                  |   23 +-
>  kernel/bpf/syscall.c                          |   83 +-
>  kernel/bpf/verifier.c                         |  450 ++++++--
>  tools/bpf/bpftool/gen.c                       |    2 +
>  tools/bpf/bpftool/sign.c                      |   24 +-
>  tools/lib/bpf/bpf_gen_internal.h              |    1 -
>  tools/lib/bpf/gen_loader.c                    |   76 +-
>  tools/lib/bpf/libbpf_internal.h               |    1 -
>  tools/lib/bpf/skel_internal.h                 |   31 +-
>  .../selftests/bpf/prog_tests/signed_loader.c  | 1004 ++++++++++++++---
>  .../selftests/bpf/progs/test_signed_loader.c  |    9 +-
>  .../selftests/bpf/progs/verifier_map_ptr.c    |   23 +-
>  15 files changed, 1786 insertions(+), 439 deletions(-)
>  create mode 100644 Documentation/bpf/signing.rst

--=20
paul-moore.com
