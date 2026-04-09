Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E89B827E04C
	for <bpf@vger.kernel.org>; Thu,  9 Apr 2026 05:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775711933; cv=none; b=KLi0+NiEXIungjl7XwtIaAM+2Qu1GKwf6MerOsUF07XKhedOJRhLR6NkjL20HQCUbzNpuwmbTd/iNw2rZc9vOoOZuXvSvyg6h6gTQgG6gClcg4xoEPbvMWc8UG460VqiIYNPuMjKoOMG+UdZmEnaD+eiIT+pt25eDW4ToZaC7pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775711933; c=relaxed/simple;
	bh=IiIjfaAakQDPNkQgQkfMdzZDuNR7hFEeDHo2PAQjn+4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xathei/buRwnPvd5ovK7wbhcpk7tfDLhGQAEhuKNVKvDbNiuWqYvb7Yy2oNHCpd66ZV1c6kjw8RkaeUERqtFU3dXRVk4Zq26wyVMhHLEQ0H+8Br+lL7XsgVZ+Chy4AaqCKEtZr/UuqhNqcH3M/ll7ZBo9Q4+G4rAboBnK2SXhkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fyJevyQo; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fyJevyQo"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-8d76492e51bso44851785a.0
        for <bpf@vger.kernel.org>; Wed, 08 Apr 2026 22:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775711931; x=1776316731; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2ML8LqxZrjyjFmoSU8L6gN5gKbH63aXwV93VjwmnQ70=;
        b=fyJevyQoaF4R7nupUHBAB4PS/rs+dfU0PaYmTC4mZrMynI4zV+y/NwknQAtHHXnhQ1
         lxOFEbL/79EE5rAZzio2Fa5dMSt97oF2lQ6vzlnlfbZ4RoG1qkJLCAo41sJe/aUkQm78
         eXhr5GRIu4psZYVbEOoZNDTJ1MkU0wuUrVt9bWBnXBM2/IUo1bZNeXMMl3FwypazsmET
         oSgvuHQRD1R0GI05Bk1TV1ikkzpZPwbWf7NcB7FkZpI96EZ/hYqOv3375tM/8hKhidBd
         qp5MPDHHNddbR+afTIZGJ+5BLIc2D89TfRCW8S6FBfowOr2OCBl0uZSUqbPaSpDZpEqo
         9JVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775711931; x=1776316731;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2ML8LqxZrjyjFmoSU8L6gN5gKbH63aXwV93VjwmnQ70=;
        b=qzxW/ytsOdFGJvL15SqoFioabUPGUdtdvjo+kPxdz6EM6BgYJ611dVhsPFJwjelsdV
         ITaG7/wdOMl5XbFFvLJ+pvkpEcq4CXreHA1f0xgdBR9zgdk8505KeU3dmBZMMCWh3IEy
         +wxV+sWE9D0JQk4mlaZ96AL4OvYx9vrZkhiRQgF2lJNSHNzCYrsDtldEUkKwH+hk2rgm
         5Bo6BTS16Tq/zewgDHHMItAyhYaXC/kdIqUGbmDbfjWWlrahf3GTdQXbzPyP4GlqaWbB
         9acDb3/6rPJbkGuAEBT27YIzAQoIjOXR8raQHPNlQ9hJC032+j1RA+1yY2tqAd3rhuNt
         dsaw==
X-Forwarded-Encrypted: i=1; AJvYcCW6tRSxH/jpZwGYIxls2gbPVNX4zzIypeDZg80yp+u9Kg9BfehFTJ1QJjirA/J3GAAUvII=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBleDfPZeIEefNS1B35WJZOvOFQziP/biT7aIbd3ta4wsmrRfC
	lApWLoyfcHgx+J3NDAWRgHOnzNWp8BRyOeiENYkvs1Evfsd3MF/zkLO2
X-Gm-Gg: AeBDievay2PQAjNN3ikd+aLC+rN1UbKUn67gzVHC6wNtDq1PFIf8/prRVgV/FhkjPtY
	s2oQwiNK6aOGHMPwUUvFJh4cltAItWxk/XKpHuwtG0snPWpNCeqDVJAGgdZTYBR82EidHbLtRxA
	KCu2vS5UXRCqa8EV8nMakWNBoTdG1+oydRIv5MKd/X+TaTRg07NxGby+zOZ9Ll8oSn6JnSmy2Xe
	oV91Vqhds5LmvaMbAl8i712+Yb0PML2Ai2oBAbJwqdiT5RgNUSK5V/g5fbeV5XbFXhuQ03VfHNw
	cCtPlF7UKVc8+jsSaqQxNmaCTdTwFrWEiT8ax50qkyccfrSZj5BUlobifPsxU6sPc7DTqvRFpNx
	e88wth7luYkRY4D9lT24pfYFx3cwVKMZFChHnPBo34bRWrSXQgjKNdzYQewrH+5k+YBDNtJ/PDY
	2+C2mX5ZCm4HhR0qHoFTxJ62oNfhd/X6SU8u2CmbAm9KBAj083AgPlGA2yjdpxYt6yr37dOPgVd
	g6GcJC8MBDVAGzXrtVcoIM7DHIkln0=
X-Received: by 2002:a05:6214:5081:b0:89c:c8eb:e807 with SMTP id 6a1803df08f44-8a704e9f9dcmr373036276d6.54.1775711930702;
        Wed, 08 Apr 2026 22:18:50 -0700 (PDT)
Received: from lima-default (pool-108-50-252-180.nwrknj.fios.verizon.net. [108.50.252.180])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8a59691580bsm189419036d6.26.2026.04.08.22.18.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 22:18:50 -0700 (PDT)
From: Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>
To: paul.chaignon@gmail.com
Cc: andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	harishankar.vishwanathan@gmail.com,
	memxor@gmail.com
Subject: Re: [PATCH bpf-next] selftests/bpf: Fix reg_bounds to match new tnum-based refinement
Date: Thu,  9 Apr 2026 01:18:49 -0400
Message-ID: <20260409051849.228066-1-harishankar.vishwanathan@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <ada_F2WbRcnOYXWb@mail.gmail.com>
References: <ada_F2WbRcnOYXWb@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Wed, Apr 8, 2026 at 4:48 PM Paul Chaignon <paul.chaignon@gmail.com> wrote:
> On Wed, Apr 08, 2026 at 10:40:50PM +0200, Paul Chaignon wrote:
[...]
> This one hits an invariant violation on an impossible branch and the
> bounds are set to an incorrect value that doesn't match what the test
> expects.
> 
>   19: w0 = w6                ; R0=scalar(smin=0,smax=umax=0xffffffff,
>                                          var_off=(0x0; 0xffffffff))
>                                R6=scalar(smin=0xfffffffe00000002,smax=0xffffffff00000000,
>                                          umin=0xfffffffe00000002,umax=0xffffffff00000000,
>                                          var_off=(0xfffffffe00000000; 0x1ffffffff))
>   20: w0 = w7                ; R0=1 R7=0x8000000000000001
>   21: if w6 == w7 goto pc+3  ; [...]
>   [...]
> 
>   from 21 to 25: R0=1 R1=0x8000000000000001 R2=0x8000000000000001 R6=0xffffffff00000001 R7=0x8000000000000001 R10=fp0
>   [...]
> 
>   ACTUAL   TRUE1:  scalar(u64=0xffffffff00000001,u32=1,s64=0xffffffff00000001,s32=0x1)
>   EXPECTED TRUE1:  scalar(u64=[0xfffffffe00000002; 0xffffffff00000000],u32=1,s64=[0xfffffffe00000002; 0xffffffff00000000],s32=0x1)
> 
> W7 is equal to 1 and, given R6's ranges, cannot be equal to W6. The
> condition is always false. On the true branch, the verifier thus
> incorrectly refines R6's value to 0xffffffff00000001.
> 
> This is a new type of invariant violation (i.e., involving the tnum)
> that is not detected by range_bounds_violation(). I'm expecting it will
> be handled by Hari's followup patchset. I've shared the program with
> Hari so it can maybe be used as a selftest. I'm guessing we're fine
> waiting for that fix as it's not failing in CI; if not, we could do a
> quick fix in the verifier.

At 21, after simulate_both_branches(), R6's tnum is var_off=(0xfffffffe00000001;
0x100000000) and u64 is [0xfffffffe00000002; 0xffffffff00000000]. 

The tnum and u64 ranges do not intersect, but in a specific way: the u64 range
is lodged within the tnum, i.e. tmin < umin <= umax < tmax

u64:        [      ]
tnum:  x                   x

When the tnum and u64 don't intersect along a branch, that branch is dead, and
we should prune it. Because simulate_both_branches() currently only checks for
"range bounds" violations, (e.g. umin > umax) it doesn't detect this kind of
"intersection" violation (tnum and u64 ranges don't intersect), and doesn't
prune the branch where the violation occurs.

As Paul mentioned, the follow-up patchset, which implements intersection
detection for all domain pairs, should fix this. This particular case will be
detected using a tnum-u64-intersection check that employs tnum_step, as
mentioned before [1, 2]. 

[1]: https://lore.kernel.org/bpf/CAM=Ch05-XWF-x_VzUZAWhRO9eum-bjdutuwvPXEcOvnx_0omAA@mail.gmail.com/
[2]: https://lore.kernel.org/bpf/20251107192328.2190680-1-harishankar.vishwanathan@gmail.com/

I have tested the idea and it works (able to prune the branch where the
violation occurred). We'll follow up with the intersection patchset, and can
definitely use this as a selftest.

> ---
> 
> reg_bounds_gen_consts_s64_u32/(s64)[0xffffffff00000002; 0] (u32)<op> S64_MIN+1
> 
> This one fails because reg_bounds' branch detection logic doesn't match
> the kernel's.
> 
>   ACTUAL   FALSE1: scalar(u64=[0; U64_MAX],u32=[0; 4294967295],s64=[0xffffffff00000002; 0],s32=[S32_MIN; S32_MAX])
>   EXPECTED FALSE1: scalar(u64=[0; U64_MAX],u32=[0; 4294967295],s64=[0xffffffff00000002; 0],s32=[S32_MIN; S32_MAX])
>   ACTUAL   FALSE2: scalar(u64=0x8000000000000001,u32=1,s64=S64_MIN+1,s32=0x1)
>   EXPECTED FALSE2: scalar(u64=0x8000000000000001,u32=1,s64=S64_MIN+1,s32=0x1)
>   ACTUAL   TRUE1:  <not found>
>   EXPECTED TRUE1:  scalar(u64=[0xffffffff00000002; 0x7fffffffffffffff],u32=[2147483648; 1],s64=[0xffffffff00000002; 0xffffffff00000001],s32=0x1)
>   ACTUAL   TRUE2:  <not found>
>   EXPECTED TRUE2:  scalar(u64=0x8000000000000001,u32=1,s64=S64_MIN+1,s32=0x1)
> 
> It's failing with that error since b254c6d816e5 ("bpf: Simulate branches
> to prune based on range violations"), but was already failing before
> with a different error (unexpected range). The root cause seems to be
> that the test runs into an invariant violation, here as well.
> 
> We'll probably need to update reg_bounds's branch prediction logic to
> match what the kernel is now doing. I can look into this next.
> 
> [...]
