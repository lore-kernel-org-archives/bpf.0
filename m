Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6489C283FEA
	for <bpf@vger.kernel.org>; Thu, 16 Apr 2026 15:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776355121; cv=pass; b=Yk+AX1VBgGXM5LvetIEWVwPrdvBcO7VRdb8e3ANQ4u8i9sAKzsxPdvC5I2Q4JQda0nVmA+DFCURhVRM2Wtl3GODJBD5mDW0GvH7yQvwrgTky2F0tpolbiMbrvFLWUgnKM5IsITqtMg6/X98lWo2r4In5ltZrBkgq8g/b1d7lgB0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776355121; c=relaxed/simple;
	bh=LW2sC2x9q/+n0m/wJ8sF8OE+XcZ2gB8CIBLlfBuK4pI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qDHTMIAd9hwoxk9eZMo8HkZXfrhAKAbdquGxRlDYnynkT3MGTUd6JwX+Oa/CIYt7U9+cKpyrhyGEiKusFmuOwzfPQzlxla+uq/he9LQ3s6of1fmQB/GGw5yM+px2EHXxZCakCbb3EY1L5rQmk1cFZwIddtNzTsIZVwqUEbaSiXc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=q5PMqwm9; arc=pass smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q5PMqwm9"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-671a2f4fd28so6733622a12.3
        for <bpf@vger.kernel.org>; Thu, 16 Apr 2026 08:58:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776355119; cv=none;
        d=google.com; s=arc-20240605;
        b=NW7xWIHFrBGWhI+kb6VcXM8ezZeXf375RXIk6eNs7cYNg6ORUoMoBPDdS/hrJsXQf3
         UccMZlU1LxYtElFb17wMb8LANaPy+U4c8IgkFm49k8uei9keJrZIeEI5Xe14OEBX89BS
         BUvtpbWQFzQTE/w1wW55itvVeeVQ5kD/oN6P13JZKI1JKC272qXA/cT3GKBrJpZB1I/Y
         KT/DCIKbCmXGz6f+FT1VrTQGTXm2fkf71PyjRCmbEFrik0Uc/wKiBY/GRIsiSwGnJgea
         LchWX10mTblBjlbMBRO7zhDYE9kC6WKZ9R1AYCsE0/+8QkBFdAomRNZDXJsQ2ye1/BIP
         4WTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VBZcqZ07o7jMXxr7GmeejdtZbmwTRCXgZObaRE0vW7o=;
        fh=Y9lhbKfcB6hc9LDq+2Y0ls5jRw85Wzz7VP29QKCwt0E=;
        b=fBV40fEdYfyJxV13x6WBayKYZ6KvDHBGj8I8EuQXLfcTqdcyB4E2MAuw9Ek5XBrtne
         egxwLH9hg/XrwEjPDRmi3dZ/TEhwNd0Mq4JNSFEw9p0WqGnfUjKRHeOkUuivilcXSxWB
         zwEPcZsGiq+oBRz1HO1QWmUox8EseMz7MkTABV8pJe9ERRKk8wQvisesc6N1dzX4RSLt
         soXWfruJYT+2HSnpULc9lRE4YsWH2ElQiJOZTgRXlX+I2iQPhbJ3a9HXiqDRIMpb7SGa
         QZo5fkg4isNhjLsk60R/ARfDBarykjDL0X2UBvP0NEB+j5MkpXDYIcUMxYP0ch/2Zh8D
         88Lw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776355119; x=1776959919; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VBZcqZ07o7jMXxr7GmeejdtZbmwTRCXgZObaRE0vW7o=;
        b=q5PMqwm967BPpMEJ5euzS5E+U2YMSDhkp8nYUmd+kajSLdq4qGSBUdEmRLA2uBlkM9
         iT3Qiu3eMWoeHUEFH3sm6o2f4llLrg0OmAW1ZNVz2ookAitkM6QuAqCQUcQRjd0v90zj
         7Pbnl8OQC+U4NANxOT0fA9Qy+m6T3Oy6MyakZQCHlO66ZRnru4oxwr1uIS5SRwLwRSjM
         iIG1jGUYTNttFRvkvBIeqzJ+oDYccoxrJtMAGVATdxfO1wow3BoCTFu95R87Ko2bXkA4
         k4vj1ayiSEdaeo+WjSGiWowxMbvkL9FPfDVqlp1SYGmS4Y4U3LhteNhiYB53NhlijYT1
         KBpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776355119; x=1776959919;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VBZcqZ07o7jMXxr7GmeejdtZbmwTRCXgZObaRE0vW7o=;
        b=qqoXEDIer0fvcVX8Z5gfrtPrnhfK5okH0nOe4yaejjWCkkkgCWZNSIbyNiHlpgPBv5
         Cs4GttWB18ZvrqaA62if8R7R/qTTYQqsVZOIqQRx6a1fyEYz/SsGyFusL9Xp6ZATDl5I
         UvvM5eovksaiqQW3sPtzSbg6bO21ZbjEHt3G9LuHIysj1bFjTBX1XqgWwjOU/FaRLC7N
         B2S1msmbL32gOScX+Pr0NxtIqpRL+iyQw7dRtDxUWekmHnES+p8CkAWMtpB7jeJ2DXUQ
         WbpSidJP2FIcjfELc4PnHQrc4bujScacJh5hbJ5yp8IcELE5XcQgHpcjERqI7LbH720D
         CnPQ==
X-Forwarded-Encrypted: i=1; AFNElJ8tuEBdhEiijQJwcBSrVtYeegLFk9AuR4OPdWLECxJjA2K8VF4hkrkSk+Har07e5t3hwZY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHB3KOaxgmh6amYe/XHt8sicpWeQhmpLJL/rhIBihWDfv1QNU1
	KLGeomMeedsHSvz6mzK2UMPRqyzxA/DSfsiXaO3IoKSppeXpuwK3AvzoyM1RxT3np/UIlIDpOfC
	X7C+frglO6lItUF6o/yOZDc6QwmIiAEA=
X-Gm-Gg: AeBDietI+sMBhpMEuh+NSQuhqn06A5VkSE1Ip0diVxyjzVRqB8lmfZkX7lfVkS8LQC2
	x5yoCzhr8b8VpKuLnPt3Y8yLGweuvzR2ZedwaSvTcRaKDWIkquSb3t0QT8hg7eDPxY+QlmXZPVS
	kt5olQVl11+fpDKSdO0E4ROgXYqDprnfAt/JrpGIoVZyHcOs+svd7OM/PoHc44J3eOBJXGJA3hL
	U5yC1XY6jqh+tkpOMxZdGSs6s48s9WG0qBcz32bdgNk/Y5uxkfZ3UTvllj3rXVcVHhOtFKZeWo9
	JltFmePDo6C6GqsEMDyEtsMUIZMx58iUGQ==
X-Received: by 2002:a05:6402:5213:b0:66e:afef:d4b9 with SMTP id
 4fb4d7f45d1cf-6707a854db9mr13866448a12.19.1776355118372; Thu, 16 Apr 2026
 08:58:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <b63e9174-7a3d-4e22-8294-16df07a4af89@pengutronix.de> <96a56535-6016-402e-ad25-237427c2caaf@iogearbox.net>
In-Reply-To: <96a56535-6016-402e-ad25-237427c2caaf@iogearbox.net>
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Thu, 16 Apr 2026 16:58:24 +0100
X-Gm-Features: AQROBzC2dQSzUVxB6k2hrG0eT7a2YtU3WjtY9-e-E83AXqyNWVTGERA_t2AlUlY
Message-ID: <CANk7y0h8F2rhosKzHuf7eewuwCofjNLut0pQ=v-gehHdMcT0Bw@mail.gmail.com>
Subject: Re: XDP BPF JIT memory leak on armv7
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: Jonas Rebmann <jre@pengutronix.de>, Alexei Starovoitov <ast@kernel.org>, 
	Russell King <linux@armlinux.org.uk>, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel@pengutronix.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 16, 2026 at 3:36=E2=80=AFPM Daniel Borkmann <daniel@iogearbox.n=
et> wrote:
>
> Hi Jonas,
>
> On 4/16/26 4:05 PM, Jonas Rebmann wrote:
> > Hello,
> >
> > We have observed a memory leak when using the JIT on armv7 with XDP
> > programs in all kernels tested (6.1 to v7.0/master).
> >
> > kmemleak reports:
> >
> > unreferenced object 0xbf0a1000 (size 4096):
> >    comm "ping", pid 818, jiffies 4294949376
> >    hex dump (first 32 bytes):
> >      00 10 00 00 f1 de fd e7 f1 de fd e7 f1 de fd e7  ................
> >      f1 de fd e7 f1 de fd e7 f1 de fd e7 f1 de fd e7  ................
> >    backtrace (crc 38a5ba95):
> >      kmemleak_vmalloc+0x38/0x94
> >      __vmalloc_node_range_noprof+0x624/0x7e0
> >      execmem_alloc+0x7c/0x100
> >      bpf_jit_binary_alloc+0x64/0xfc
> >      bpf_int_jit_compile+0x14c/0x348
> >      bpf_jit_subprogs+0x4fc/0xa60
> >      bpf_check+0x1840/0x30e0
> >      bpf_prog_load+0x720/0xec4
> >      __sys_bpf+0x4cc/0x25d4
> >      ret_fast_syscall+0x0/0x54
> >
> > This was reproduced on various debian systems:
> >   - stock debian sid with 6.19.12+deb14-armmp-lpae
> >   - stock debian 12 with 6.1.0-44-armmp-lpae
> >
> > As well as debian sid with custom built kernels with a
> > multi_v7_defconfig based config, amongst versions tested: latest master=
,
> > (7.0.0-08391-g1d51b370a0f8), v7.0, v6.18, v6.8, v6.12.
> >
> > Precise reproduction steps:
> > Enable the BPF JIT (if not done via CONFIG_BPF_JIT_ALWAYS_ON=3Dy):
> > # sysctl -w net.core.bpf_jit_enable=3D1
> >
> > Prepare any simple XDP program:
> > $ git clone https://github.com/xdp-project/xdp-tutorial.git
> > $ cd xdp-tutorial
> > # apt install git cmake build-essential xdp-tools clang pkg-config libe=
lf-dev m4 libpcap-dev llvm libbpf-dev libxdp-dev
> > $ ln -s /usr/include/arm-linux-gnueabihf/gnu/stubs-hard.h /usr/include/=
arm-linux-gnueabihf/gnu/stubs-soft.h
> > $ ./configure
> > $ cd basic01-xdp-pass
> > $ make
> >
> > Store /proc/vmallocinfo:
> > # cat /proc/vmallocinfo > /tmp/vmallocinfo-before
> >
> > Load the program and confirm it is loaded, unload and confirm:
> > # ./xdp_pass_user -d lo
> > # xdp-loader status
> > lo                     xdp_prog_simple   skb      83   d4f8542f2b42fac5
> > # ./xdp_pass_user -d lo --unload-all
> > # xdp-loader status
> > lo                     <No XDP program loaded!>
> >
> > Compare /proc/vmallocinfo:
> > # cat /proc/vmallocinfo > /tmp/vmallocinfo-after
> > # diff -u <(grep bpf_jit_binary_alloc /tmp/vmallocinfo-before) <(grep b=
pf_jit_binary_alloc /tmp/vmallocinfo-after)
> > +0x4e292a08-0xae3e49c0    8192 bpf_jit_binary_alloc+0x64/0xfc pages=3D1=
 vmalloc
> >
> > # echo scan > /sys/kernel/debug/kmemleak
> > # cat /sys/kernel/debug/kmemleak
> > [see above]
> >
> > The backtrace corresponds in commit 1d51b370a0f8 to
> >
> > mm/kmemleak.c:596
> > mm/vmalloc.c:4093
> > mm/execmem.c:44
> > kernel/bpf/core.c:1093
> > arch/arm/net/bpf_jit_32.c:2241
> > kernel/bpf/fixups.c:1122
> > kernel/bpf/verifier.c:20099
> > kernel/bpf/syscall.c:3083
> > kernel/bpf/syscall.c:6252
> > arch/arm/kernel/entry-common.S:44
> >
> > Each subsequent run introduces an additional leak.
> I don't have access to arm32, but it looks like its completely missing th=
e
> ability to do BPF to BPF calls.. you would need something like the below
> (uncompiled / untested).

I think the problem is that BPF to BPF calls are not supported but the
JIT doesn't reject them as well, so the best way to fix this would be
to do:

diff --git a/arch/arm/net/bpf_jit_32.c b/arch/arm/net/bpf_jit_32.c
index deeb8f292454..91fef10e88bc 100644
--- a/arch/arm/net/bpf_jit_32.c
+++ b/arch/arm/net/bpf_jit_32.c
@@ -2047,6 +2047,8 @@ static int build_insn(const struct bpf_insn
*insn, struct jit_ctx *ctx)
        /* function call */
        case BPF_JMP | BPF_CALL:
        {
+               if (insn->src_reg =3D=3D BPF_PSEUDO_CALL)
+                       goto notyet;
                const s8 *r0 =3D bpf2a32[BPF_REG_0];
                const s8 *r1 =3D bpf2a32[BPF_REG_1];
                const s8 *r2 =3D bpf2a32[BPF_REG_2];

This will cause the memory to be freed properly.

> It would actually be nice to you have any chance to run through the BPF
> selftests to see what else is broken on arm32. Outside of x86-64, arm64,
> riscv64 and s390x BPF JITs the results might vary quite a lot on what wor=
ks
> and what doesn't. :/

I will do that soon when I get some time, the selftests won't easily
compile for 32-bit archs as pointers are 32-bit and bpf pointers are
64 bit, etc. etc.

[..]

Thanks,
Puranjay
