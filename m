Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795724405;
	b=pfUjC0I8v6ltgp/s85vC3brTj5cd1bZgGW/5BnoyWMTrAzIygtkBArCLRiTxG+uDYWRp
	 TmXC+KfCLcpmnteBzWViTivu/xpeS0EaOYp1LRf80dAUbOUgENMDbkO1QbUdiBtTvCT2l
	 RF636kefDoq8ZqilyPO1wGQdcUTOWcpRo/vX+sbB8Ztz6lgsLpgy4OqgrojbnUSzZ3GcF
	 MEySTpnkZaieaGpfkT3u0uJvujdsHF+e08evY1Kmx3A2dce+7g4ykpBvmQrfxRoAfnTs2
	 YG1hfQncCpYzQuptepxMNZDgsN8ZG7Wt9It1uF1si8ktpTwN8pn64befvcP0EVR+qYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795724405;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:From:To:Cc:Subject:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=IisAYb8F5NSvxIkhX9CrgM5ii3NEhDX/Q4K4kANyb+M=;
	b=Dsjg4n5BGkzHqjyauKXuZtYvMN+ewqr0eoWeGw4svCfgDeigX1fuCWuk/1SuLKmaV1Nv
	 0W8kZAZu47T5w8XRD7C8iYth+TVRHRggAL5mIGmVV4ICInVTzK2gg/W1wIMmc+u3f9HCw
	 5z+HdlwqHSNWh041ErV/boAHeqY9EybZrp1Qo9HsRgsWPNYCJJQJUvpyDC42ppi6+eQ6h
	 6DBpcxDRJ+Pwj7imYNY+wEZWEkIhdc8yvc6692CGxSsGr9ADn2qryYipmzouKuPQ6Q6B8
	 U8+zN0Y0H70VGQa89m+xV/X24twu57xfbL+0fwNL3gToDTHPaTTfZHVO7QHwqDIjPMg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rA2xqivq;
	arc=none smtp.remote-ip=209.85.215.173
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 899E2606A31C
	for <bpf@vger.kernel.org>; Thu, 26 Nov 2026 20:20:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 899E2606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rA2xqivq
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-cde4b4e936fso3584001a12.1
        for <bpf@vger.kernel.org>; Thu, 26 Nov 2026 12:20:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795724405; x=1796329205; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to
         :subject:cc:to:from:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=IisAYb8F5NSvxIkhX9CrgM5ii3NEhDX/Q4K4kANyb+M=;
        b=rA2xqivqn4GQV0PIyzUQCSdE38owzLO31tugYhwHFuAdrBPLg+UuH0swS2++8QZLMM
         7E56OX+d7/jhauTjlx+qGefY6VGaI6eeWIaiKC/1qttrYRYkLbeIvHduB4PsTNuXhZod
         uMExpJh8ijbYh8RyNmO9vFMWT7oCsR6oaHEir7sd+p9NIIcVa6ZROvYIdbWzhh6SjSjk
         90yZdwX+oJhNQGS8ehLC/Rqm2vhsddYIDwWrgHxKaAD0g+24qT5cFNXMozYpCxa0+rVD
         hqvfORZRf5YwZmGhqi1FXbA3jKEICNs9sfBGeRA3F5t8WzsdPJ+o6BdAvkqw2jHsVhv7
         muzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795724405; x=1796329205;
        h=mime-version:content-transfer-encoding:references:in-reply-to
         :subject:cc:to:from:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IisAYb8F5NSvxIkhX9CrgM5ii3NEhDX/Q4K4kANyb+M=;
        b=fq2/7ZiO7SPqvyuqijXE5vI3e3I/Wnpcq2Dw8te8s1/T8TQ8tPZlfNsi9kBWa6QZH5
         AmxBSwPB/FvYmKmyRDNUAVFECkNNkx0d+yiFRtM4+U8c+eDr8Ldx/v7dq74AfAjp0c0O
         FT9AQT8jbU5S57AMPEQRls5sLY+swC9PGIMgjj5knaydN68mOxDXTvhCh8pKGAJUKPnM
         esXJwP8iosVqw3SwRU9nz9IymUAU0Z35pRjuq96AqaHi34KYbIhipLgie9jT1Jb0lxMX
         Yqkb/j1oms/pcwEnmQFS52ax3XNz79gEBM3/U1aKVaPu1IMkXqHOwt3Kjkq2V4jkVCQY
         c7qA==
X-Forwarded-Encrypted: i=1; AL+hErEcUV9bovxzje+rAj5/x0UlD6GTJUdXDD5+IE5+gj0iijJopjRWqMkzA8Mos3yO+HRttbE=@vger.kernel.org
X-Gm-Message-State: APuU4Z/4QlKYLherTNh0POMG2fwUCjzp7gULx6CZ6b0FTUA7On+uWvkw
	lq7UMf4hslLpO66S258n0WJxkyEB+/dKbq7QUeRkfp5cl/Lgm+F/H0sWLegaJg==
X-Gm-Gg: AZFdTZesS+rSxCH3rcKqEIi8mbIbg6JBc/Mspre09/0v1/LG2XEsNTPvsiZrC1p5ASR
	+8FtNOyQ8xG4Itj58TOdK/ABjk9kAxNk9tQt7IGEaNxZOti98uu7g4YRKI+vyBFPi4KCovbYDo1
	r77Iu/D1F67w+sbdfgWu6JUPfnqEc4gQWYhmZbKKKhDnvJ5qZcvUN0jZeS9rokrdTy/WqGclcRz
	PnHCPnVXBpTc2HFn5Roinj+P6JCEg0YZxNmWoIaqxgPPU96vNtsgWWXhir4nf/6ONDa0flP0OT/
	seoYclGg2AScRgezCZm9zKWxK0T5+mTVpVy+YEfsfsIft0gxS8nnMM9Y0RWSEIMlbWhJpE6T3Zp
	V7zlZ4s7HFml4Jph55A/yF77mbITtwouweLNa9CB1JPRmrDMS2qthjDsXh2F+XwjdFaALQY6rav
	ysPthq/IdB9XubDniXHoFztAuESRJJWNO6jhIqEWMMle7d8CDcm9xkLvG8TZDiWw9kh3duX6XFp
	eF1i+U6s1a42pfSfpkFWh26R8F2wrPzPmkYFdjB1SQwOIKr/NPmMHHIFozLDpf+SspScj4r79Oc
	KFvCU72H7jPpJAqAXjFYNNwbUjwtWKxE7COmdg6aYoBojeOayTDjSwBNJrPro1+MGmER4OvKbZ4
	TrR2NGgYm51VOrmuADEepQzQeraXm2j4APw==
X-Received: by 2002:a17:90b:4d86:b0:3ae:3b3d:c617 with SMTP id 98e67ed59e1d1-3b41c93cdbdmr14036244a91.29.1795724404531;
        Thu, 26 Nov 2026 12:20:04 -0800 (PST)
Received: from localhost ([153.61.198.244])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b405ecbd0bsm37175353a91.15.2026.11.26.12.20.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Nov 2026 12:20:04 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Thu, 26 Nov 2026 20:20:03 +0000
Message-Id: <DN5F6AJVK33K.25IJTI12XHRKN@gmail.com>
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Yonghong Song" <yonghong.song@linux.dev>, <bpf@vger.kernel.org>
Cc: "Andrii Nakryiko" <andrii@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Eduard Zingerman" <eddyz87@gmail.com>,
 <kernel-team@fb.com>
Subject: Re: [PATCH bpf-next 1/3] libbpf: Poison an enum value relocation
 out of the local enumerator range
In-Reply-To: <20261126175607.1883240-1-yonghong.song@linux.dev>
References: <20261126175602.1882988-1-yonghong.song@linux.dev> <20261126175607.1883240-1-yonghong.song@linux.dev>
Content-Transfer-Encoding: 8bit
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Thu, Nov 26, 2026 at 09:56 AM Yonghong Song <yonghong.song@linux.dev> wrote:
> So a program is only rejected if the poisoned instruction is reachable.
>
> This also applies to bpf_core_enum_value(), since libbpf cannot tell the
> two forms apart. A program like g() above, which could use a target
> value out of the range of the local enumerator type before, is now
> rejected if the instruction is reachable. Document this in
> bpf_core_read.h.

The usual guard doesn't make it unreachable.
bpf_core_enum_value_exists() returns 1 here.
I think this takes back what your commit 776281652ddc allowed.
The local value is often a placeholder, like in profiler.inc.h:

  pids_cgrp_id___local = 123, /* value doesn't matter */

What bpf_core_enum_value() gets today and with the patch:

  local enumerator                   target       today       patch
  ---------------------------------  -----------  ----------  --------
  SCX_ENQ_PREEMPT___local = 0        1ULL << 32   1ULL << 32  poisoned
  PERF_EVENT_STATE_OFF = -1          -1, kflag 0  0xffffffff  poisoned
  PERF_EVENT_STATE_OFF = 4294967295  -1, kflag 1  -1          poisoned

Row 2 runs on v5.15. Before commit 4fad237494f1 it got -1.
Row 3 has vmlinux.h of v5.15 and runs on bpf-next.
The kernel builds relo_core.c too.
A light skeleton with row 1 stops loading after a kernel upgrade.

> The target value is taken as signed or unsigned according to the kflag
> of the target enum, which pahole sets for a signed enum since v1.24, the
> minimum version now required for kernel BTF.

That covers new kernels only.
Before v6.0 btf_enum_check_meta() refuses an enum with kflag.
Row 2 ends up in:

  val <= INT_MAX        val = 0xffffffff, val_signed = 0

Code like f2() gets -1 there today, since s>>= restores the sign.
So the attribute form fails to load too, and its value is correct.

> +/*
> + * As in C, the enumerators of an enum have type int if all values of the enum
> + * fit in int, even for a 1-byte enum made with the packed or mode(byte)
> + * attribute, and otherwise the type of the enum, which is then 4 or 8 bytes.
> + */
> +static bool bpf_core_enum_fits_int(const struct btf_type *t)

Not with a fixed underlying type. sizeof(N) is 8 with clang 21:

  enum E : unsigned long { N = 10 };

This function says int, and 0x100000000 gets poisoned.
BTF doesn't have the type of the enumerator. The compiler has it.

can clang emit mov for 32-bit enumerators, like for field relos ?

  enumerator    insn
  ------------  ---------------
  int           r0 = 0xa
  unsigned int  w0 = 0x80000000
  long          r0 = 0xa ll

bpf_core_enum_value() keeps ld_imm64 and works as before.
bpf_core_patch_insn() patches ALU imm already, without a range check.
With mov the diff poisons all three examples from the log.
Rows 2 and 3 load in both forms.
The diff skips the sign of a long and fixed types of 1 and 2 bytes.
No need for bpf_core_check_enumval_range(), bpf_core_enum_fits_int(),
and for the shifts in f2() and f3().

relo_core.c in place of patch 1, compiles for libbpf and kernel, not run:

diff --git a/tools/lib/bpf/relo_core.c b/tools/lib/bpf/relo_core.c
index 58c782c..b2c8632 100644
--- a/tools/lib/bpf/relo_core.c
+++ b/tools/lib/bpf/relo_core.c
@@ -1031,6 +1031,20 @@ static int insn_bytes_to_bpf_size(__u32 sz)
 	}
 }
 
+/*
+ * ALU zero-extends imm, ALU64 sign-extends it. BTF before v6.0 has no sign of
+ * an enum, so accept both forms when bit 31 of the local value is set.
+ */
+static bool insn_imm_fits(const struct bpf_insn *insn, __u64 val)
+{
+	bool zext = val == (__u32)val;
+	bool sext = (__s64)val == (__s32)val;
+
+	if (insn->imm < 0)
+		return zext || sext;
+	return BPF_CLASS(insn->code) == BPF_ALU ? zext : sext;
+}
+
 /*
  * Patch relocatable BPF instruction.
  *
@@ -1067,13 +1081,18 @@ int bpf_core_patch_insn(const char *prog_name, struct bpf_insn *insn,
 			goto bad_insn;
 		if (res->poison)
 			return bpf_core_poison_insn(prog_name, relo_idx, insn, insn_idx);
-		if (res->validate && insn->imm != orig_val) {
+		if (res->validate && insn->imm != (__s32)orig_val) {
 			pr_warn("prog '%s': relo #%d: unexpected insn #%d (ALU/ALU64) value: got %d, exp %llu -> %llu\n",
 				prog_name, relo_idx,
 				insn_idx, insn->imm, (unsigned long long)orig_val,
 				(unsigned long long)new_val);
 			return -EINVAL;
 		}
+		if (!insn_imm_fits(insn, new_val)) {
+			pr_warn("prog '%s': relo #%d: insn #%d (ALU/ALU64) value out of range: 0x%llx\n",
+				prog_name, relo_idx, insn_idx, (unsigned long long)new_val);
+			return bpf_core_poison_insn(prog_name, relo_idx, insn, insn_idx);
+		}
 		orig_val = insn->imm;
 		insn->imm = new_val;
 		pr_debug("prog '%s': relo #%d: patched insn #%d (ALU/ALU64) imm %llu -> %llu\n",

pw-bot: cr
