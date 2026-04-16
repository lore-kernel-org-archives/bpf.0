Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9BB439FCD7
	for <bpf@vger.kernel.org>; Thu, 16 Apr 2026 11:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776340705; cv=none; b=KdIyRAL8kK/x1PqCPiQGwDKjKzYauuIjrSdv0vicCbBXxVk+dUZkj0871oknh2C7hRewXLGWkznsNt9K66BOiaSpM8SrF/jgxVNBlBf/xqz3VqFEo8G9VSr3U21NoF3CRxfXHe9+F0pPOyei3ZN3IyN5nl0MJ4NiWpGg212w5Eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776340705; c=relaxed/simple;
	bh=9QpOVqk9PefAIVLsbFNfDAp88LZKMe4ZC7ob89smceU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Du6DUVXQZSluO1sazQG/uf0mnMiQpQ0kGVRznRygvsi33VlqO0etKJCu/7+HmxchKKTxIFn0ryo3FZVr9p8M/XlqeI4nuJYh66TLe2B31qomfoMhX/rxATxv88v854nBx2Kku7zaBs1Ae/zLIZrN7G9HzGu8mRp7k7otV0aQE7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gWk0m1yb; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gWk0m1yb"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-43d73352cf2so4055938f8f.1
        for <bpf@vger.kernel.org>; Thu, 16 Apr 2026 04:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776340702; x=1776945502; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L9ylrYIuDgodTTNkfq8YPCdUP+i3S2INv5wmyzL6RM4=;
        b=gWk0m1ybJyP65MLbaz52n/FiTXzJv7+52/vE6sGB5Dl2GUYZfGbkuCZF/Fn3LkMugt
         UdXA0UhIbi1ESHOcDgGIixdOcnRMx+ofx+zNTPv+815G8wJC9zWDlNs6rRPnlEDpX9zd
         M3cU5KAhMG3xRnPn/gpaFUY48O/TM7kDbbL2Lx/d662P52FpXy9XQEjkYAQrxldlDCGG
         BwpI6sHkfpOJED+QOUUystV2Tz4TtR4p5sQcWHW3WGls1OmzdHt47cRqdZEekzkDnBIk
         yf2hkz17zomKz+qKaP8Lt+F6+RjlUhDt6POwTG3Es5dD4526cevff6PAxx7/12zVsVxr
         zSYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776340702; x=1776945502;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=L9ylrYIuDgodTTNkfq8YPCdUP+i3S2INv5wmyzL6RM4=;
        b=FMd3l2Za7vcPkU8ICno7JxK+1guYXegcSJYfIS9uB+dyoa6jec62UzqwGAGdpgsA63
         Z/m1wSEc53pacODJPlctCM8LrNUQ9fJExJaZb73cPAfnVdirK5W2YzNuHuRk8k2fLWPi
         gPAQxW/MY5z7LyxEdWajRbQ/Y/NXVun9QTSyrIzY9XTdLGH7alQbBhuvhERUER37HnUx
         kU03H98GCXNGt1ZMmnlzKAbdbHtkrpn3RdbqAFKkuLqBvZQlTSdM7bgp7+pZdS+FKjnO
         r14gIWK4VnufUn8zvD6yT/6as6ntVRaDSzcoHoQJcgnnMV8Hfw1eNpea6ZAAnGI84Xhc
         P5XQ==
X-Forwarded-Encrypted: i=1; AFNElJ91YzJMwMNHmHQnBrdHVLerZ4V6tyrPpIQzw7pKrNantcundjQB9xZBo9ldKO79rAUxhqc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxi6Ee+I/S4m9rgrkeIPP7WA9vgmI/2RCap/DELLrDtxGDm+NxW
	+RfqRNNHtOGmEipY2dvR4EvSMpTe7dJ8MyaVFupvgBI1T5wxWcqgjqzy
X-Gm-Gg: AeBDiesBRF9L4arOm4P61YMrzVpZ+CWGD7aXDQm49x+JkkWWmQYSnWj59bUM2DiaPmD
	3dnDWyA7GiL2RSIu5HP+YehZXUwObfbbRuMYBVMr/GAOv7cuQXImT+0auNX5gikhKx5lBMulbH/
	U2dZ5ph17jYcy6kh6MlD6elXGe3q1NrjAK9M5WwgyIeOoE1KS1cPgHMVPT1T89UxWBWVZKkBdYu
	yp+jci9MmyJlPjITFAJ5RMJReCqyQA7OuHOgEdlGEx4wJlqnzZijZX/R3yHOFlvPvWMvngKbZs2
	8nwhGqKSv/Irtl5upf1uA3xrFE8zk+fpzWG0YHrX0tWs/MlubPww7X56z4W7xwtfdggFFnlh6K4
	f6fS910ARhd0XSrkvStK9/O+0MkcrGWhh5xuEGXpBP/xrYyeeDLkP4MBzzdVtg9zXhc19L9oOsl
	yU369axuCYPaawUsA=
X-Received: by 2002:a05:6000:1a8d:b0:43c:fde6:212d with SMTP id ffacd0b85a97d-43d642cd3ddmr39199178f8f.33.1776340702075;
        Thu, 16 Apr 2026 04:58:22 -0700 (PDT)
Received: from localhost ([2620:10d:c092:500::4:7fe8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43ead3e89ddsm12664005f8f.30.2026.04.16.04.58.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 04:58:21 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: Hiker Cl <clhiker365@gmail.com>, bpf@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: NULL pointer dereference in map_kptr_match_type when storing
 scalar values into kptr slots
In-Reply-To: <CAGM=xGABGeeGVU7hy_mRr_rp377dBzVVAOpkLnuYKb8XyEs7Hg@mail.gmail.com>
References: <CAGM=xGABGeeGVU7hy_mRr_rp377dBzVVAOpkLnuYKb8XyEs7Hg@mail.gmail.com>
Date: Thu, 16 Apr 2026 12:58:20 +0100
Message-ID: <87340v9kwz.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hiker Cl <clhiker365@gmail.com> writes:

> Hi BPF maintainers,
>
> I'm reporting a bug I encountered in the BPF subsystem on Linux kernel
> version 7.0.0-g1f5ffc672165.
>
> ### Summary
> A NULL pointer dereference vulnerability was discovered in the eBPF
> verifier. A local user can trigger this by loading a BPF program that
> attempts to store a scalar value (non-pointer) into a map slot
> designated as a kptr (kernel pointer). This leads to an immediate
> kernel crash (DoS).
> ### Environment
> - Kernel version: 7.0.0-rc6 (Commit: 71b500afd2f7 from bpf-next tree),
> 7.0.0-g1f5ffc672165 (Commit: 1f5ffc672165 from linux tree)
> - Architecture: x86_64
> - Config: BPF_SYSCALL=3Dy, DEBUG_INFO_BTF=3Dy
>
> ### Steps to Reproduce =EF=BC=88poc.c)
> #include "vmlinux.h"
> #include <bpf/bpf_helpers.h>
> /* BTF type tags for kptrs */
> #ifndef __kptr_untrusted
> #define __kptr_untrusted __attribute__((btf_type_tag("kptr_untrusted")))
> #endif
> struct map_value {
> struct task_struct __kptr_untrusted *ptr;
> };
> struct {
> __uint(type, BPF_MAP_TYPE_LRU_HASH);
> __uint(max_entries, 1);
> __type(key, int);
> __type(value, struct map_value);
> } crashing_map SEC(".maps");
> SEC("kprobe/htab_map_get_next_key")
> int trigger_crash(struct pt_regs *ctx)
> {
> int key =3D 0;
> u64 *val =3D bpf_map_lookup_elem(&crashing_map, &key);
> if (val) {
> /*
> * Trigger: Store a scalar (non-pointer) into a slot
> * designated as a kptr. The verifier's map_kptr_match_type
> * fails to handle the NULL reg->btf for scalars.
> */
> *val =3D 0xdeadbeef;
> }
> return 0;
> }
> char LICENSE[] SEC("license") =3D "GPL";
>
> ### Kernel Log Extract
> [   91.277247][ T7627] Oops: general protection fault, probably for
> non-canonical address 0xdffffc0000I
> [   91.279715][ T7627] KASAN: null-ptr-deref in range
> [0x00000000000000e8-0x00000000000000ef]
> [   91.280906][ T7627] CPU: 0 UID: 0 PID: 7627 Comm: bpftool Not
> tainted 7.0.0-g1f5ffc672165 #5 PREEMPT(full)
> [   91.282421][ T7627] Hardware name: QEMU Standard PC (i440FX + PIIX,
> 1996), BIOS 1.15.0-1 04/01/2014
> [   91.283556][ T7627] RIP: 0010:btf_is_kernel+0x2a/0x50
> ...
>
> ### Actual Results
> The kernel crashes during the verification phase. The verifier calls
> `map_kptr_match_type`, which subsequently calls
> `btf_is_kernel(reg->btf)`. Since the source register is a scalar,
> `reg->btf` is NULL, leading to a NULL pointer dereference.
>
> Detailed info including reproducible BPF program and kernel logs have
> been filed on Bugzilla:
>
>   https://bugzilla.kernel.org/show_bug.cgi?id=3D221372
>
> Please let me know if you need more information or if I can help test
> a patch.

Thanks for reporting the issue, I can reproduce it.
Looks like a simple fix resolves is:

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 9882475ee9da..91aa51a19c91 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -4544,6 +4544,9 @@ static int map_kptr_match_type(struct bpf_verifier_en=
v *env,
        int perm_flags;
        const char *reg_name =3D "";
=20
+       if (base_type(reg->type) !=3D PTR_TO_BTF_ID)
+               goto bad_type;
+
        if (btf_is_kernel(reg->btf)) {
                perm_flags =3D PTR_MAYBE_NULL | PTR_TRUSTED | MEM_RCU;
=20
@@ -4556,7 +4559,7 @@ static int map_kptr_match_type(struct bpf_verifier_en=
v *env,
                        perm_flags |=3D MEM_PERCPU;
        }
=20
-       if (base_type(reg->type) !=3D PTR_TO_BTF_ID || (type_flag(reg->type=
) & ~perm_flags))
+       if (type_flag(reg->type) & ~perm_flags)
                goto bad_type;
