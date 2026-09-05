Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EA1A266B72
	for <bpf@vger.kernel.org>; Sat,  5 Sep 2026 23:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788649708; cv=none; b=ebruDA3CGHP2iNH03O35CbuszKaOviUGbza0BrrU4emHpLyDd+FEFnq0DJA1mn/+Y4LVqF/OiuM/r0ynGyGQYCo9f8VZPmXr7dvfAu3HocUsB7We8roivc0f4on4nSFlNbovvG3NacxEozv4kBbKf/OVUHeZ9k6okuJGDKBRftE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788649708; c=relaxed/simple;
	bh=LaN2xMzOHzzbeIvI2UgrxQzAc1tTjl2cLxpMYFmZuJg=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=Sf0Sqbm3doCaIOV0dKms1xY6dFeLtxNCaDH+n/8NzF4R6vhc8ChRyMXGDaAYn+LS89EoRZCxR7WwKvi31EDyfFCe6B4QdhpMa6ldZ4gfl5VPtT0DXmHFdrxOk2GqDj4BL/ZoELiuBYhil2d0sqfdnoFEwwsggMBsbQzGSKcf9ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JY79pgTz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JY79pgTz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E3311F00A3A;
	Sat,  5 Sep 2026 23:08:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788649706;
	bh=qHhzeUUbitMPYwC6TlSj7pgrAyI8r7fIruG0xLyT48c=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=JY79pgTz4EZXPt6Y1Czh8HOGetuqJOH0sqU/xaXGd5N7EDyEKyUCg+C1vpllbhfUo
	 ur46p7HpSQsMWDHawfzaecj3UNtC8v8wtujZM0y38WWIb//XaL8lM6k+aYZz68YQKc
	 JLDHmeVtAa8g5C2luPGE2EANsiVf616sFyZIz0Ny4YH8OgEZx2zxM3rPM5IC7HoFk7
	 OA9qLGoAYQ5papcA9G7BVoZXWLGB/F/O5w/WqjqOSnp/p1eNvfwaRZ5r1RGreAUt/L
	 AGGsxn485iQ0ZJH/2l0Heg+PbVIsr1jxf5QiU0fv8GZZX1UeRQuKxwIWAPq+eADozy
	 az2j2dNN0NtWA==
Content-Type: multipart/mixed; boundary="===============2615222167423158485=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <42bf7cbbe585cf05895199e9f39ee29f4e4e83c6f06ae84cfac7ed5dd984cd38@mail.kernel.org>
In-Reply-To: <20260905220117.922028-17-ameryhung@gmail.com>
References: <20260905220117.922028-17-ameryhung@gmail.com>
Subject: Re: [PATCH bpf-next v1 16/22] bpf: Drop redundant BTF pointer helper write rejection
From: bot+bpf-ci@kernel.org
To: ameryhung@gmail.com,bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,memxor@gmail.com,ameryhung@gmail.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Sat,  5 Sep 2026 23:08:26 +0000 (UTC)

--===============2615222167423158485==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> commit 5188979f5e68c2684632ba13facdb46febabed5a
> Author: Amery Hung <ameryhung@gmail.com>
> Date:   Sat Sep 5 15:01:11 2026 -0700
>
>     bpf: Drop redundant BTF pointer helper write rejection
>
>     check_reg_type() rejects a trusted PTR_TO_BTF_ID admitted by
>     mem_types unless the argument carries MEM_RDONLY. This duplicates
>     argument-specific memory access validation and is too conservative for
>     map keys and input map values, whose read direction is not represented
>     by MEM_RDONLY.
>
>     Since commit fa75b7c85b0d ("bpf: Enforce write checks for BTF pointer
>     helper access"), check_helper_mem_access() forwards the requested access
>     type to check_ptr_to_btf_access(). Map keys always request read access.
>     Map values request write access only when tagged with MEM_WRITE.
>     ARG_PTR_TO_MEM prototypes must carry either MEM_RDONLY or MEM_WRITE,
>     and size arguments use the direction of their associated memory
>     argument. btf_struct_access() therefore checks the effective access
                         ^^^^
>     direction in every case.

Is btf_struct_access() the correct function name here?

btf_struct_access() in kernel/bpf/btf.c explicitly ignores the access
direction; the parameter is declared unused:

  int btf_struct_access(struct bpf_verifier_log *log,
                        const struct bpf_reg_state *reg,
                        int off, int size, enum bpf_access_type atype __maybe_unused,
                        u32 *next_btf_id, enum bpf_type_flag *flag,
                        const char **field_name)

The direction is enforced one level up, in check_ptr_to_btf_access()
in kernel/bpf/verifier.c, which:
  - rejects any non-read of a faultable pointer,
  - for atype == BPF_WRITE dispatches to the program-type callback
    env->ops->btf_struct_access() when one is installed, and
  - otherwise rejects with "only read is supported" unless the register
    is a program-allocated object.

Reading btf_struct_access() as the op pointer env->ops->btf_struct_access
(same name, so the sentence is ambiguous) does not make the claim correct
either: that op is NULL for most program types, and in that case the
direction check is check_ptr_to_btf_access()'s own "only read is
supported" rejection rather than any btf_struct_access().

Should the commit message say check_ptr_to_btf_access() instead?


>
>     Drop the early rejection and keep check_reg_type() limited to register
>     admission.
>
>     Signed-off-by: Amery Hung <ameryhung@gmail.com>

This looks like a bug fix for commit fa75b7c85b0d. The commit message
explicitly references commit fa75b7c85b0d which introduced the validation
flow change that made the check_reg_type() logic become redundant and
overly conservative. After fa75b7c85b0d changed check_helper_mem_access()
to forward the requested access_type to check_ptr_to_btf_access(), the
early rejection in check_reg_type() for mem_types without MEM_RDONLY
became incorrect, blocking valid use cases for map keys and input map
values.

Should this include:

  Fixes: fa75b7c85b0d ("bpf: Enforce write checks for BTF pointer helper access")


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/33995442755
--===============2615222167423158485==--
