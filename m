Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 994303C4B91
	for <bpf@vger.kernel.org>; Sat, 17 Oct 2026 14:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792247743; cv=none; b=ae0102O8FbdeDaWA79RCN4kkSoQJi4MC2e6TKZLZBKAcQz+cv6h3tuV4Tfmf1GPXMjdu4PVhK/hNQZ4gsKHT8Av0WACav4WvbinCuYhsNOpb0fpTUnIloycsvS0szOrbxyzHdxLXrMpDb83XSryjrRztOK0y4eb47WppF3MQOoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792247743; c=relaxed/simple;
	bh=IKt9NuWfuDnSYraXYKeAE6c1daptRqUpbqVflH4dGAg=;
	h=Content-Type:Date:Message-Id:Subject:From:To:In-Reply-To:
	 References:MIME-Version; b=HHvpeui+wr3NOrsGHcQ7bAZE0+B9H38E79okrZwxM7+YL9Se7nA3csOFSG0qWMfwOY/s562uOCydOA4P3ezREm4Fa013PC2KqYV/NvZIbZXCHFklaKTcpjmg7Moky4jLL9oeq0/bSgFzYFCoCP7rD0X9W4Rwi4zJNet/uv/xk8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nHKCIPI5; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nHKCIPI5"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-cd5e2d696e0so645292a12.1
        for <bpf@vger.kernel.org>; Sat, 17 Oct 2026 07:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792247742; x=1792852542; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:message-id:date:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=R0prkCVmVqtbO/5ihUpRIPrDLEgJwbGQq+wbCVT7ZDg=;
        b=nHKCIPI5jI4ZyRwcJXCHRV5pgeX8u1j6U2oAwBlVZxSW5mZFuxP6rRTQXS6UArnI0/
         V2uh+iuEdVbYKhNTh9d0P5FSwaHctGN20g6KXwPtbf8GeG9RxC0JfCGUJl7uoG/E40Xc
         eKpWvS27czYi+tlwF3eQb/skcBfwBlN1CuMmzbZlZTy4fKTezGRVUM0eM9usn3aOHKPP
         7nHzDuyIwKAhhS0jYMyv7mIDl836cHKTNWHbLN37OLG/54mmRf6OddFuBTHJEjsWEkRu
         zHRSBOSFiiD+yU3tmnvD97NNBZ4eftnox4EgsRyfhaJDH9ixEfv/hADSm0deLzNxSoo+
         6Evw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792247742; x=1792852542;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=R0prkCVmVqtbO/5ihUpRIPrDLEgJwbGQq+wbCVT7ZDg=;
        b=g8LMgkBWQP+W+SFzRu7vyIB6R95QheVJZjuxkN8CyYtWoiSJwejyT7T1nnDLBMkE8m
         06FcVKoOP8AP0TdtsOLEjpfuVf4XtN5d3UzxPx++M3jVso9igsv3JOCz/lH/dmQqt9hG
         24uN+ZW+vH6wqREeBWOP4YRjn4WwcjHvJxMbVc8TGAiMOkaRK91+X1QJFNupzMjQ5L+z
         qx1cM4cfrv5wx07LtcorOdYRgm320YTN0UtKFNkWH0GRJWzpToN4+iTHros7fj0WPkSj
         o3h56kRnKBh8RWlNhxE9VOTJuYYu00jRju6Y6RJsebPn1XiaVrqGRF4pPH54AssH/I0V
         FFug==
X-Forwarded-Encrypted: i=1; AKwUvBxR68xK7wYeKpFJLRjBLbiQvhUjjkkzYYJtR93Spryaew0gurLTqAnW9G2j8z+cTH8AAec=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ/K0kQxltS4K6nHMNQVXJDZtrJIumkQ8+CPFc4x4BYbcDFTM8o
	3RqX5Ft5AgLA2WI1B35+yC6p8aE1dUsu0OeJPtgw5V179hs++lcu8UNP
X-Gm-Gg: AYBFou18Jxr9Fw5ngp9LXbnxdgmEAzKYwOtNkiH4GSK/l411k1ZCTVIKi7FmVqF3JSH
	/SN0u3aYg5nra0qOtRYQr/WOEvRsJCforbWoWOnkkQ0afizn3Q2znsf4h3GYokhRsKkhXCFy+D+
	idQbMY+d4cJb3qEL3m8E9+1CLDPOqJSuHZXRplB4t1cRVyzp9LgD2y5z+eSeCcVWCoq8Vhm9w1Z
	qWxk7rDZMBbNbG+LD/Jruenn56dOs1IE2YHYUlpE83tf5ykL3tSMVlGwrH1QD35Ajvh0j8WwitJ
	NG2Kxm0eY2gVqHfmJHmJd9He91F8RYvzcSNzvTd6yZDNz/NnxQYKvHGFthErbIXH1QwGv3/Nkg/
	ztI3VQlBXfVQ7Le/g1uUCDdszJHb2pT7xF68k4OP8st7X8i3a0WXdcDpNYC1p93DHEHbVx2Vb20
	CW/U7P6F+o4FZOtcn9G129DXQp7cmZ68q0BwIBI/OKqOS1K7dw1+4Gw62y2KytwnmWsY3YQ9Im0
	LNYqDjMNQenOQehMkNICI2hhfIudKO2Z4Xpib4LvgLFl1/4p6VB6mLw/Fs3TusMpc3lYhRicSDH
	2w2XQZIfBRTDhg==
X-Received: by 2002:a05:6a20:6a1e:b0:3e2:fdb:4584 with SMTP id adf61e73a8af0-3e2263d7812mr2146536637.52.1792247741755;
        Sat, 17 Oct 2026 07:35:41 -0700 (PDT)
Received: from localhost ([153.61.198.244])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd6549fb556sm2530201a12.22.2026.10.17.07.35.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Oct 2026 07:35:41 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Sat, 17 Oct 2026 14:35:40 +0000
Message-Id: <DM76STO8ECCU.36Z2ATFECUFLJ@gmail.com>
Subject: Re: [PATCH bpf] bpf: Zero-extend the index in inlined
 bpf_get_func_arg()
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Woojin Ji" <random6.xyz@gmail.com>, <bpf@vger.kernel.org>
In-Reply-To: <179221432098.1890560.17043109037413683447.get-func-arg-index@gmail.com>
References: <179221432098.1890560.17043109037413683447.get-func-arg-index@gmail.com>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, Oct 17, 2026 at 02:42 PM Woojin Ji <random6.xyz@gmail.com> wrote:
> +			/*
> +			 * The helper takes a u32 index; zero-extend it before
> +			 * the bounds check and the 64-bit address math below.
> +			 */
> +			insn_buf[cnt++] = BPF_MOV32_REG(BPF_REG_2, BPF_REG_2);
>  			insn_buf[cnt++] = BPF_JMP32_REG(BPF_JGE, BPF_REG_2, BPF_REG_0, 6);
>  			insn_buf[cnt++] = BPF_ALU64_IMM(BPF_LSH, BPF_REG_2, 3);

After JMP32 the low 32 bits of R2 are below nr_args, which is at most
255, so a 32-bit shift cannot overflow and it clears the upper bits.
can we just make the shift 32-bit ?
Then no need for the extra insn and the comment.
The selftest stays as is.
Something like this (compile tested only):

diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
index d6f8352..ec62df6 100644
--- a/kernel/bpf/fixups.c
+++ b/kernel/bpf/fixups.c
@@ -2256,7 +2256,7 @@ patch_map_ops_generic:
 				cnt = 2;
 			}
 			insn_buf[cnt++] = BPF_JMP32_REG(BPF_JGE, BPF_REG_2, BPF_REG_0, 6);
-			insn_buf[cnt++] = BPF_ALU64_IMM(BPF_LSH, BPF_REG_2, 3);
+			insn_buf[cnt++] = BPF_ALU32_IMM(BPF_LSH, BPF_REG_2, 3);
 			insn_buf[cnt++] = BPF_ALU64_REG(BPF_ADD, BPF_REG_2, BPF_REG_1);
 			insn_buf[cnt++] = BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_2, 0);
 			insn_buf[cnt++] = BPF_STX_MEM(BPF_DW, BPF_REG_3, BPF_REG_0, 0);

pw-bot: cr
