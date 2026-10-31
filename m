Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793424586;
	b=F9hEDNwy7QN4ogLIu3XhDzrZ3wfB2a3F4o+oJtpOqvF9kqZPr/Uabyh+giGZTy3pkt2z
	 ts25OgHfKgnAbwPSbhFa4y0xmL4jdbDzPT3rtyeOoNuQ2PHwOB47wubSH7k4tZxFuu/y7
	 u9a568Ja8eFa9qtciPG6lqE92qt6ceiCzW+Z8lxNw1AYfrVTI1Wt587Hd8IOgI4T4aDE4
	 K+/biscWpUgj/Yq2UmvkPdHHDJf4TDoEkGKRDtmP36rHZtAKtArTSJdRdx4qfNUY+ucZ0
	 Ue27dxBXC9DBNUUYnnhtEmbQl4OtvLiSmfibgb9u4knrqZ3EODemoZuuAMjAd8ArsTQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793424586;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Content-Type:Date:
	 Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Content-Transfer-Encoding:MIME-Version;
	bh=pPCYtQzMZtajXWmvtb2q+ThOcxjNXkaUo5PJHZCV/CM=;
	b=hUcQVwfWMMkbUNBPGhd8ZXvZ4J0n3/HHAs5DKQQfSs9KEvB5ZgCQsxOykaDYOI2KXY8B
	 FFl50CZ0WtehIhBS9TiONvOMvXi/goFeuHMKC1KnJz7qf/cPEvDwHZZjNOi0tjSbsVujw
	 od/TWXQG/IcSIpezdTLmrj6T8s7Avru1MnID6Gmfa3IYaJQ8Z3VDlMAeoSpqwe9DNBZJj
	 pr6S39Pk6yHGHrm67xGU621bo6u2qko0GnUcNOA0PeFqizT0tHFfpcCmvt+O+VZi8F7RX
	 Fc+wMWf6JnNHC4aaiBuQbhN+xTvmjE3850CoOCuzHVPR8UxUUFL/AaOM91L9tx65FZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ocmjj6TV;
	arc=none smtp.remote-ip=209.85.216.48
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2B54606A320
	for <bpf@vger.kernel.org>; Sat, 31 Oct 2026 05:29:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C2B54606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ocmjj6TV
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3ae691283ecso747956a91.0
        for <bpf@vger.kernel.org>; Fri, 30 Oct 2026 22:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793424585; x=1794029385; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:from
         :subject:cc:to:message-id:date:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pPCYtQzMZtajXWmvtb2q+ThOcxjNXkaUo5PJHZCV/CM=;
        b=ocmjj6TVIvlHNqe4suqwOILLkAWxwzL2+oK3CrsX4xlSxWKBbGvRQxBURZ6Hoa1vkQ
         /MCoc2qsnAJwrym5ldC7tWZaik4xJgiRUwuGDrM013ukasqiZTX7EOjTDpKU2W+nv+Lp
         +r4Oyojn0AcdY6tZI32VcYdlKIM6FZXMEnakR+WWXid2sLZbpKB2/DlSyHH1X9/6NOvn
         sKT/Ve5Yr5wO+HcxxcwNV1VEsFPg2aUVDlSq1Hl+Ab8rnBHiM+OkVbJMzkyM1SxoME+8
         HoDqGtybBm/6JHnUlk2lhcLE9k8UlOQpBE8/nCzMyQPYtUIaTIHzDPiMp9qXS6OCoOaS
         BOUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793424585; x=1794029385;
        h=mime-version:content-transfer-encoding:references:in-reply-to:from
         :subject:cc:to:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pPCYtQzMZtajXWmvtb2q+ThOcxjNXkaUo5PJHZCV/CM=;
        b=Aw5mWP9zEB3yxLSAit4NuHcCevxWN5xARmZTCCKbAIQya4+/fOSqWZTY/knPrDw9YZ
         AdTGcV6bQ3jovS4q0t1t8oloFP8ypS6Q0dYuPwUiNEONOTpaYYqvzwazhEIX7Yx6BrRj
         fiz0EuwoNA7ua7zH8t5QYKm+YXgLmXSOzAzrPOo4NPzu5om/l9VlVkVURZBwH8VZ4szw
         eCL9XRTP7MnOOiyCrCRiS7Ynglzo4WW/YXfddge/dZTJIvP12BnPC/3w07HlJPH6TCzi
         UYpBK6GqjIllW5HgwpivviC6gMWlb9SqvGWke01aT5gxP1Kwt2YPnTEFcn6X9uMUrBum
         TLYg==
X-Gm-Message-State: AFq9FYJfBaNpp9BzBl32De4AHDJXhjeBxbs08YJigFc64BRXrTz/SP56
	7l+MfJ704yFYEeV4RFA6Jze3fMN6C2pG1ynEkI664FVLdCJv1cz/5Bww
X-Gm-Gg: AYBFou0+/Qn48zSmROwD/q3EQXi6LkPYuP1BMnzvIEcOtijB92jBQt01GgLixFHh8CE
	scVkN8xGN8BuBXfesKO0jebpDUGOemfDg8/DWarOQCQi0650meJDomuTEz37J7QW5k6KyXZhgtF
	ihyZFKV7QseWaQU1J1ql+FK1LyfyDOGacL0ZqfPZLEGm2q1KNdO2dxS0/85ALQIbhk5QVMJ4rlf
	E/Scg/qvwufJKZxXYqwaD2KcApRwxdEaiVa0qWc2OAXQYYl77QplLbW4QRvvzvJTmv5+Mn0gj0R
	pLu8e41F16Ef+cUWIonkIAMP+30Ak2cp70iM1rsI6gssiveTAl8TX3YGU2O1KkqK3eH5zEZm3N7
	q9n6Xl/3cd5EbsaO6/3NtMxKUaddQZCbt9TMZV6I3/0rTxd2O+o5BOnIE88helVHI/d8UyBQJ9g
	DFGajBOulxyCkFOWNZRN9mMHNWOEuo7Z20OwyOtYMWLk1cg+vw/rZXLmyGf2PLhiJ9PGP2BYlYc
	/IRy7p+VLhvSqVuhWL/K46sdB/Mu7/qkSVZJT1c4ZAOHyMYiZvFph7zkWxFRIXd+0LWWWxervPC
	r8PN2mYSQ8av5FxH/tIwV7rld/5mKY6O/eDT3oU+FiyV6cjbEbRq6HwbAGUKyT0J3PWaZP+4ZJF
	a4c/y9qhYZZiYgLPvL7WfAvJr4rQtW1E7gmM=
X-Received: by 2002:a17:90b:4c4c:b0:3a6:d2ac:74ce with SMTP id 98e67ed59e1d1-3ae8972b662mr2341161a91.19.1793424584986;
        Fri, 30 Oct 2026 22:29:44 -0700 (PDT)
Received: from localhost ([153.61.198.254])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae8826a769sm2582771a91.4.2026.10.30.22.29.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Oct 2026 22:29:44 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Sat, 31 Oct 2026 05:29:43 +0000
Message-Id: <DMIRYFU9YEX1.14HBEXD0UQR7H@gmail.com>
To: "Qiliang Yuan" <odys.yuan@gmail.com>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "John Fastabend" <john.fastabend@gmail.com>,
 "Andrii Nakryiko" <andrii@kernel.org>, "Eduard Zingerman"
 <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, "Martin
 KaFai Lau" <martin.lau@linux.dev>, "Song Liu" <song@kernel.org>, "Yonghong
 Song" <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>, "Emil
 Tsalapatis" <emil@etsalapatis.com>, "Ihor Solodrai"
 <ihor.solodrai@linux.dev>, "Shuah Khan" <shuah@kernel.org>
Cc: <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH bpf-next v2 07/22] bpf: Let the patch list remove
 instructions
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
In-Reply-To: <20261030-bpf-verifier-patch-batch-v2-7-55cd43439f7c@gmail.com>
References: <20261030-bpf-verifier-patch-batch-v2-0-55cd43439f7c@gmail.com> <20261030-bpf-verifier-patch-batch-v2-7-55cd43439f7c@gmail.com>
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

On Fri, Oct 30, 2026 at 04:51 AM Qiliang Yuan <odys.yuan@gmail.com> wrote:
>  	bpf_patch_image_install(prog, &img);
[...]
> +	/* before subprogs are removed, since it looks at them */
>  	for (i = 0; i < env->func_ptr_cnt; i++) {
>  		struct bpf_func_ptr *fp = &env->func_ptrs[i];
> +		int subprog;
>
>  		if (fp->xlated_off == BPF_FUNC_PTR_DELETED)
>  			continue;
> +		if (bpf_patch_image_deleted(&img, fp->xlated_off)) {
> +			subprog = bpf_find_subprog(env, fp->xlated_off);
> +			if (subprog <= 0 ||

Sashiko is right. It's real, and it crashes the kernel.

bpf_patch_image_install() already set prog->len to the new length.
bpf_find_subprog() gets an old offset and compares it with prog->len.
When the prog shrinks enough it doesn't find a live function.
The func ptr is marked as deleted and the slot in .rodata becomes NULL.

It needs two things:
- the first insn of the function goes away as a nop
- this commit removes at least (end of prog - start of function) insns

Plain C hits it:

  #include <linux/bpf.h>
  #include <bpf/bpf_helpers.h>

  struct st { int a; } g = { .a = 10 };

  #define OP(name, expr)					\
  static __noinline int name(struct st *s)		\
  {							\
  	if (!s)						\
  		return bpf_get_prandom_u32();		\
  	return expr;					\
  }
  OP(op_a, s->a + 2) OP(op_b, s->a + 3) OP(op_c, s->a + 4) OP(op_d, s->a + 5)
  OP(op_e, s->a + 6) OP(op_f, s->a + 7) OP(op_g, s->a + 8) OP(op_h, s->a + 9)

  static int (* const volatile ops[])(struct st *) = {
  	op_a, op_b, op_c, op_d, op_e, op_f, op_g, op_h
  };

  SEC("socket")
  int vt_all(struct __sk_buff *skb)
  {
  	int i, sum = 0;

  	for (i = 0; i < 8; i++)
  		sum += ops[i](&g);
  	return sum;
  }
  char _license[] SEC("license") = "GPL";

The verifier knows that &g is not NULL, so every op starts with a nop.

  bpf-next:     Return value: 124
  this series:  BUG: kernel NULL pointer dereference, address: 0000000000000000
                RIP: 0010:0x0

That's the shape of any table of ops.

The minimal fix is to do the lookup before the install.
On top of the whole series:

diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
index a442188647bc..de758ce7afac 100644
--- a/kernel/bpf/fixups.c
+++ b/kernel/bpf/fixups.c
@@ -451,6 +451,28 @@ int bpf_patch_list_commit(struct bpf_verifier_env *env)
 		}
 	}
 
+	/*
+	 * Before the new image is installed and subprogs are removed:
+	 * bpf_find_subprog() looks at prog->len and at the subprogs.
+	 */
+	for (i = 0; i < env->func_ptr_cnt; i++) {
+		struct bpf_func_ptr *fp = &env->func_ptrs[i];
+		int subprog;
+
+		if (fp->xlated_off == BPF_FUNC_PTR_DELETED)
+			continue;
+		if (bpf_patch_image_deleted(&img, fp->xlated_off)) {
+			subprog = bpf_find_subprog(env, fp->xlated_off);
+			if (subprog <= 0 ||
+			    img.new_off[env->subprog_info[subprog].start] ==
+			    img.new_off[env->subprog_info[subprog + 1].start]) {
+				fp->xlated_off = BPF_FUNC_PTR_DELETED;
+				continue;
+			}
+		}
+		fp->xlated_off = bpf_patch_image_remap(&img, img.new_off, fp->xlated_off);
+	}
+
 	bpf_patch_image_install(prog, &img);
 
 	for (i = 0, k = 0; i < img.cnt; i = end) {
@@ -474,25 +496,6 @@ int bpf_patch_list_commit(struct bpf_verifier_env *env)
 	env->insn_aux_data_len = img.new_cnt;
 	data = NULL;
 
-	/* before subprogs are removed, since it looks at them */
-	for (i = 0; i < env->func_ptr_cnt; i++) {
-		struct bpf_func_ptr *fp = &env->func_ptrs[i];
-		int subprog;
-
-		if (fp->xlated_off == BPF_FUNC_PTR_DELETED)
-			continue;
-		if (bpf_patch_image_deleted(&img, fp->xlated_off)) {
-			subprog = bpf_find_subprog(env, fp->xlated_off);
-			if (subprog <= 0 ||
-			    img.new_off[env->subprog_info[subprog].start] ==
-			    img.new_off[env->subprog_info[subprog + 1].start]) {
-				fp->xlated_off = BPF_FUNC_PTR_DELETED;
-				continue;
-			}
-		}
-		fp->xlated_off = bpf_patch_image_remap(&img, img.new_off, fp->xlated_off);
-	}
-
 	if (img.del)
 		patch_list_del_subprogs(env, img.new_off);
 

With it the prog above returns 124.

But that fixes one instance.
The commit changes prog->len, aux data, func ptrs, subprogs, line info and
insn arrays one after another, and helpers read env and prog in between.
So the order of the steps is load-bearing, and nothing says so.
Make each table a function of (old value, new_off[]), with no helper that
looks at env or prog, and install the image as the last step.
Then this class of bugs cannot happen.

Please add a selftest for it: callx through a pointer in .rodata, the callee
starts with a nop, and main loses more insns than the callee has.
All tests in patches 21 and 22 pass on bpf-next without the series,
so they don't tell whether a remap rule of the commit is wrong.

Also patches 4 and 6 don't apply anymore, since arena_scalar is gone.

Other than that the patches look great.

pw-bot: cr
