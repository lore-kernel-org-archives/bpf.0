Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B0FA395AD3
	for <bpf@vger.kernel.org>; Sat, 10 Oct 2026 15:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791645313; cv=none; b=PP1kLwelnAvoHxr1oJPO20OCcZxcRslleT81BmTaRBuqxH0fzFiP7WLT/wOIydJcr0x1g65ozMLusN0M58MwaX1nIaUXUDDi3j2yczgf2t5VUaBUnLPn44wxkKkEomwTOwmbHRWvsESvKK2vI9Xxuh0dWV9c1Y7cuiQOLHp5XSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791645313; c=relaxed/simple;
	bh=gbtaKOrX7mCRAugDbyYx553EgyuRZhqyQOnUZJgo3Rk=;
	h=Content-Type:Date:Message-Id:To:Cc:Subject:From:In-Reply-To:
	 References:MIME-Version; b=NsCapAmb+S2p2DimJL52FThXm369GmdjR2BM7IX/YHOSQ8QZVe2qZzFHuTaizzaa+0UkP27QjNxS7/ZaqDvKFgZoA//uJvuKv43cs8bz6liYrvFe79oYqopOTkg1jRl1nQu780R/aHlIwND43Y9tnHhStGdukmS3KARCN6mgL5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HKRlbSXF; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HKRlbSXF"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-887a58523e6so138782b3a.3
        for <bpf@vger.kernel.org>; Sat, 10 Oct 2026 08:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791645312; x=1792250112; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:from
         :subject:cc:to:message-id:date:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PA1SeCKCJVM/ga+przkjEyBFpbrA00Lf9TqlwG/r05o=;
        b=HKRlbSXFsXw1WfiqvgpGwkFOZDYFHBzP6cSJXaBzJ+niWp691gizuJw+/ovrnlmSii
         iMIAgNQ5Nc3+xlUfIQlgw6LRFbv+mwHJg7Dk00hePG4Jw6pfxcO8peojRRiYgXIatYJK
         emcSC6JVcOD4pNC41j0Q0CQBDoI1ffKj/uanRPVDBRwZKiGvuNEoneV0NM8+DxrjozFt
         Um2MxtzvmOVLHKoB7ZxkipsfKmkAyvSSg+a5qLI0Sji1jLlCQvW0UfLoS6JNt/uSV/NE
         t3aUDQviHfh9zsCLZB7G44tTpzeFk0UT7c2a5qqVr8rzL6RHOYlfBcSwKEQS7fWbjrDH
         SsXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791645312; x=1792250112;
        h=mime-version:content-transfer-encoding:references:in-reply-to:from
         :subject:cc:to:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PA1SeCKCJVM/ga+przkjEyBFpbrA00Lf9TqlwG/r05o=;
        b=edYPHCRJHnQyjE88zIxJX/kuPj7TqXrq7qMnO6PHeFNisz2a3l8cwQkeXNVtCsspel
         y3F7i4CNE57QMI5Rae7Ir7nJOPxy7U/7sF9AlpAGAtQcpIJSKHT2PS/ivBtnwi40Ex3g
         63/GGM/92jqLMQJq/MzrkBtcw2z3MkfqLaPACIH8sRA7razN5np3kfSPWdVmmjOaQO8W
         G/6QVXB3Z9+3aMZ9AW9yi+cvuPtis30HpRaxY8Fa89SxeP4odKmFypobP/itivDlWV5T
         mX3fUNSrn6CyAv1TwhTaLJeeTBmE2u/aeg1RHk2GGMMPG/oD0upGeSadTZ61ZcUohJpw
         4Nyw==
X-Forwarded-Encrypted: i=1; AKwUvBz4XV+wI8Jls487IN4/yAd4TVdfMhkOYrq6CHUYjmQrW2duKb156vKIKEeHRrxpb2H7F7A=@vger.kernel.org
X-Gm-Message-State: AFq9FYKeRBlce3D/A6ReFaQYzY2aDHMm62XjumYBhovo3Jd8HHVjzcol
	Hk6LOa1xEYRecqchHbew4vOU3Orco3wDcsdwB+Af/DFfy/wLkfu5o86otQ8nS3/qcxY=
X-Gm-Gg: AYBFou2FjRGRIgr7ZcRDjEGkQbW7ceNx/jHaRzhQ5lDNWMyr9UlVV7y3vsb7c4Qs1jC
	1jZLGjmX2m8KCZ9Wu3TcLn2fcQ1AMJy+WMrlhSPq9JR0xEWramSIArwmTQddCYr+BaSnKDLBSfg
	uWTwbWgHWF7G3GGc7oqGOxdAs9/M2ArPDlTlSGqU1I2S6bJwV92KETbmlK51EN3AD1xzg5tWiso
	PmqUSJkIVdoKsvgVTwUFh/1CmRPr9iA5aeaZns4zLqvzPm0l5Cm1RHQCMaqNyRnmn2Z4+MPTE9j
	faSflLYSFQfMIfF5iE/Q0VrXm5dQ3gDBHcpOVLElUyIHttaBLR+CKCQmzeF6qhTQ/ZPykPRcwsq
	I4gOEZkbnZW5UvwlGI0eD5Wz94Xnto7k6veIjrGvbVMhRzPTqppAAJ7dMHULFB8S3cGRTEcdEit
	rAXXABrlHA92GWeoJOpwRd9xb8m0yU3kkmFHayfbcAgV2Coyyee8qajoHoiUpmkgsAU9rnlcSoe
	15a85wztU0frsdDY65eNbN8pO9zAXQTTUIVk7rgw7pFbWtxklpI6glVf3WGHD72n+A3bx94oACP
	zXc=
X-Received: by 2002:a05:6a20:4393:b0:3bf:63af:855 with SMTP id adf61e73a8af0-3e16bb0935bmr4508143637.1.1791645311805;
        Sat, 10 Oct 2026 08:15:11 -0700 (PDT)
Received: from localhost ([153.61.198.253])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd3d9e42f9bsm2265320a12.21.2026.10.10.08.15.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 Oct 2026 08:15:11 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Sat, 10 Oct 2026 15:15:11 +0000
Message-Id: <DM19999Y1AUY.1DBGK5HO3G8QR@gmail.com>
To: "Yonghong Song" <yonghong.song@linux.dev>, <bpf@vger.kernel.org>
Cc: "Andrii Nakryiko" <andrii@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Eduard Zingerman" <eddyz87@gmail.com>,
 <kernel-team@fb.com>
Subject: Re: [PATCH bpf-next v10 00/24] bpf: Run exception cleanup landing
 pads when bpf_unwind() unwinds
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
In-Reply-To: <20261009041447.17092-1-yonghong.song@linux.dev>
References: <20261009041447.17092-1-yonghong.song@linux.dev>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

# CARRIED OVER from the unsent v9 draft (nothing was sent on v9, v10 has only bot fixes). Delete this line, or the file if you dropped it on purpose.
On Thu, Oct 08, 2026 at 09:14 PM Yonghong Song <yonghong.song@linux.dev> wrote:
>   - A subprog an unwind passes through must have an exit.
>   - Until the Rust toolchain supports BPF exception handling, the selftests
>     write their tables by hand in inline asm.

rustc can do it already.
For example,
take RUSTC_BPF from selftests/bpf/Makefile.buildvars, replace
panic=abort with panic=unwind, build core, then --emit=llvm-bc and
clang -c like Makefile.skel does for progs/*.rs.

  #[inline(never)]
  fn fail() -> ! { unsafe { bpf_unwind() }; loop {} }

  #[inline(never)]
  fn check(i: u32) -> u32 { if i > 7 { fail() } i }

  pub extern "C-unwind" fn prog(ctx: *const u32) -> u32 {
      let _g = RcuReadGuard::new();
      check(unsafe { *ctx })
  }

The object has .bpf_cleanup with the right record and this code:

  fail:
      call bpf_unwind
  L0: goto L0
  check:
      if w1 > 0x7 goto L0
      w0 = w1
      exit
  L0: call fail
  prog:
      r6 = r1
      call bpf_rcu_read_lock
      w6 = *(u32 *)(r6 + 0x0)
      w1 = w6
      call check
      call bpf_rcu_read_unlock
      w0 = w6
      exit
      r6 = r0
      call bpf_rcu_read_unlock
      r1 = r6
      call _Unwind_Resume

They won't pass the verifier,
because
_Unwind_Resume() and fail() don't return, so LLVM emits nothing after
the call. check_subprogs() refuses prog() and check() with
"last insn is not an exit or jmp".
rust-bpf hack adds 'exit' and replaces call with 'call bpf_unwind_resume'.
We need to get rid of rust-bpf IR rewrite,
so let's try to do so now?
'call _Unwind_Resume' can be replaced by LLVM, by libbpf, or by the verifier
with an exit. I feel that the verifier is right place to do it,
but open to suggestions.

but since rustc doesn't emit debug info for extern fn, so there is no BTF
for _Unwind_Resume, so libbpf may be a better place?
Not sure, let's discuss.

pw-bot: cr
