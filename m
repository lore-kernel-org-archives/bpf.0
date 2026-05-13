Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 999654C9578
	for <bpf@vger.kernel.org>; Wed, 13 May 2026 16:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778690002; cv=pass; b=PC+4y87YI8Dnm+/WceFQoW+qm0xvzI8qUfvVL406WhwrVzz0fFs5GROLZSMmH/SobUFjuj9h664I5wNuBS7LbsNPATA2D1SJbSkH6gft8QZMDY6T2mjzhoALmVDEvVXcKuXwaEyglU+QeEgqLr0bkhLXD83D0yUCcUMw8lCFTD0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778690002; c=relaxed/simple;
	bh=WR/8YmX23CkzJcwwg7fTBK38+sxF6XLPcHmBJgieS60=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YP8Jvoz8DMUFPTcYnBzF09lfvk0QkA/c2exZlUP5tDlqKLmMf7w+ypoWS5Zprzt/En/BYQi+dxuprEb2ZB++a1hX0l6sn0osNv4BgUqecjAuRp1tn8NlDuj2zfTFdj1wn6xQBLKsUNAxY7eZVN/+6XrxUk/U937wBlKRW0WmGcM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lxriURAZ; arc=pass smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lxriURAZ"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-43fe608cb92so4458455f8f.2
        for <bpf@vger.kernel.org>; Wed, 13 May 2026 09:33:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778689999; cv=none;
        d=google.com; s=arc-20240605;
        b=lYZMLj/6nYkxZ7m5B7Bjpx1inZ9c5VmTU7mvj4WUEPseXaFWSeMgQ2WoOF3JNmCp4I
         tmGyk0JMAnvm8CVTwHTzLs+EnRaYXpM+OkSI8m3to+arzoiIyWM/XP36cwNn62AG62tm
         RE6KaVpqVGzGn6gw38FICTh7Cqqd6awTqVv9WMzCC1tb14KbYL4JR48HrVAVe7aYjZq+
         V515l/2SdKaP+CADwXMqtfuYh2Dw6NffE+UDJxNQ9c0LiVwvbSXjYUrCqODbZ/hLrDAu
         XWbc9d3MnFsh4WRb5rU41Z7UA+r2sxEVVV9oxxTk07ZtRdruzYZR3O/gb51luygG+lNn
         7AaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VZhcetZGDMkSPT86RXOgyCgM2a+STJswD2NnAtfGdJQ=;
        fh=wi89WQjOF2HvnYB0v50Lj11/w784Fae/K3mXW7+OEdE=;
        b=KDvquJKyTvYuNEY6Nw8gU/jP86pj45ZzGiiuTj4R+oIiRuXXdkRMzCxwlXKrv23TpJ
         ND2+nUJHP56/F7Rxcc1+ekZqP2861ym4oDYlcXssxnBADrQGHcttSaGDtvqQk+Q/WQ2H
         5Ez6FGqWZr/zDyCHICHhEAfyFRtUa0vnmGS3NhFy212eNjTDcF0h9csbg9HZbDcexRH5
         jzNCX9VCwMtcoW5Lot5RrW1viEF9lf4YUHHjaqdTBmP4lRFUe8aGtsdoehx+QXC0zRev
         hBBkWUCzggOch12LJXn9G3BT+QyUpBih53IQPAeNFV+79jUzDj3ilYZPemTtUj0jar3j
         lKnw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778689999; x=1779294799; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VZhcetZGDMkSPT86RXOgyCgM2a+STJswD2NnAtfGdJQ=;
        b=lxriURAZv2TiH0ab+rESSZxtSXIG4mvGZGDyjLfl05boM2Pd3uhXqIRwQBM0mESd+B
         l/S0M056RewQuZqnOkH5LI15O82dzPlBBxDwMygckcGXZYJY8ibcWJBst895HYtQvd9P
         rrxetfrU4g8DCrbcwyxs4J5ycson28bKb3Kap8Wk5JHUJYvhSaP5TssGBTxL+Y+p7o8B
         XcyKFdqGlo6tpo2tqmUWFbF2dXYcI4K0IwcYEVUDvf89QdeGsr6i/1j5mb65AqUEYzEx
         EKFEoP4hyg+rIdIxeV+wAGfr05VD5MRk4kLYEJvlhudBqrnKBVdEk1FMxM/aqFoZpCvt
         xmkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778689999; x=1779294799;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VZhcetZGDMkSPT86RXOgyCgM2a+STJswD2NnAtfGdJQ=;
        b=nhgRvRr1F9LZ7I2G+tbKlIINJzgWcmnZVIMkEJytufVj/0Piql8a4qmO5CVkDOELZn
         xukr6GgLGz5XNMw993hJFk7MLAwBXgVeEvGFU+VYgoKnWru+amnvu/LgETEcDEz5+5Mu
         rYrxApDNqIABerkhEUXklCR9XisVI/4SeHuITuNNFwAMPq/ZYZoeo/YR0+n4TKSGVaVD
         qRB8uCOp6WleEnV6kp0MRx58ArMpFjd8VMKPFBQMiKe57MbX3/zRNMZWI/DtD4ljuqZ6
         +t3hTBxRUojh1OqNNuNLCWhNaqzE+OkaL7wKOFRgNeAGas7yxc+qdAYutTuZKBhgfgrA
         X41A==
X-Gm-Message-State: AOJu0YwumTL/w86nhwlQNq7SzehX16H+srNkB9nwguMPRXgAm7oa4kuL
	+zEa45jhFN/PP9JaBPcCz33hkrUXYHuuGcQelAXgaWQvi/q83RFhPou+v68h4Tb+9FvViyWpJ+N
	za2JC+qNwiy9TjrWJMCJTDOe/Gs4qn6Q=
X-Gm-Gg: Acq92OF9H3j4GRUOkE8w0S1rRKoIlfAEyNwpjBm8Fws9E3TBRAUxWafTQeaWakueM0j
	rSHsCfIrzN6gTLtY01P12dkQCp1OjoMewn8IX/iitK0Bj7uoRxh+BIpqpyJfexXMqUm69Lm9sPe
	tJ4iG8sIeNNnEq5fMqK4etZgJk8LV1+ypc3Y88DhfieIkmFyooe4CaotmjLYCREF6vWfqMmHtUs
	JMVopFnTEUoK1/QQnd6zPPG/O3qej3N0fe0a4G/gXQ4d0lGBu6YSPvA/j3KC9QCMqpRLrJd8cvt
	8+gVhVEmULJt2rprXDrV+lQAWHE98Ef4cd2Cdr2lwCPifM/6HHifzbA4JgrR/Ep3pbeQ9/oF6e9
	jUOwHPaPzOfBSZ5It5fXA+bBZgw==
X-Received: by 2002:a05:6000:2313:b0:43d:775b:c9bd with SMTP id
 ffacd0b85a97d-45c586960aemr6168658f8f.10.1778689998587; Wed, 13 May 2026
 09:33:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260513044949.2382019-1-yonghong.song@linux.dev>
In-Reply-To: <20260513044949.2382019-1-yonghong.song@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 13 May 2026 09:33:07 -0700
X-Gm-Features: AVHnY4Jz4vW1QZ371fKVYIk346genXKVv6Wf-VeBjnC_VRrhghd6BTTjS26gnMk
Message-ID: <CAADnVQKjVKG8cfMBpWpmbtPToGPSyD13aXLNOzb2PTQm_bS_2w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 00/25] bpf: Support stack arguments for BPF
 functions and kfuncs
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"Jose E . Marchesi" <jose.marchesi@oracle.com>, Kernel Team <kernel-team@fb.com>, 
	Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 12, 2026 at 9:50=E2=80=AFPM Yonghong Song <yonghong.song@linux.=
dev> wrote:
>
> Currently, bpf function calls and kfunc's are limited by 5 reg-level
> parameters. For function calls with more than 5 parameters,
> developers can use always inlining or pass a struct pointer
> after packing more parameters in that struct although it may have
> some inconvenience. But there is no workaround for kfunc if more
> than 5 parameters is needed.
>
> This patch set lifts the 5-argument limit by introducing stack-based
> argument passing for BPF functions and kfunc's, coordinated with
> compiler support in LLVM [1]. The compiler emits loads/stores through
> a new bpf register r11 (BPF_REG_PARAMS), to pass arguments beyond
> the 5th, keeping the stack arg area separate from the r10-based program
> stack. The current maximum number of arguments is capped at
> MAX_BPF_FUNC_ARGS (12), which is sufficient for the vast majority of
> use cases.
>
> All kfunc/bpf-function arguments are caller saved, including stack
> arguments. For register arguments (r1-r5), the verifier already marks
> them as clobbered after each call. For stack arguments, the verifier
> invalidates all outgoing stack arg slots immediately after a call,
> requiring the compiler to re-store them before any subsequent call.
> This follows the native calling convention where all function
> parameters are caller saved.
>
> The x86_64 JIT translates r11-relative accesses to RBP-relative
> native instructions. Each function's stack allocation is extended
> by 'max_outgoing' bytes to hold the outgoing arg area below the
> callee-saved registers. This makes implementation easier as the r10
> can be reused for stack argument access. At both BPF-to-BPF and kfunc
> calls, outgoing args are pushed onto the expected calling convention
> locations directly. The incoming parameters can directly get the value
> from caller.
>
> Global subprogs and freplace progs with >5 args are not yet supported.
> Only x86_64 and arm64 are supported for now. Same selftests are tested
> by both x86_64 and arm64. Please see each individual patch for details.
>
>   [1] https://github.com/llvm/llvm-project/pull/189060
>
> Changelogs:
>   v3 -> v4:

Applied, but see veristat failures:

|strobelight-server-monitors-gpu_mem_snapshot-gpu_mem_snapshot_bpf-gpu_mem_=
snapshot_bpf.o|handle_cu_mem_address_reserve_ret
|success -> failure (!!)|-100.00 % |
|strobelight-server-monitors-gpu_mem_snapshot-gpu_mem_snapshot_bpf-gpu_mem_=
snapshot_bpf.o|handle_cu_mem_create_ret
|success -> failure (!!)|-100.00 % |
|strobelight-server-monitors-gpu_mem_snapshot-gpu_mem_snapshot_bpf-gpu_mem_=
snapshot_bpf.o|handle_malloc_ret
|success -> failure (!!)|-100.00 % |
|strobelight-server-monitors-gpu_mem_snapshot-gpu_mem_snapshot_bpf-gpu_mem_=
snapshot_bpf.o|handle_mtia_allocate_exit
|success -> failure (!!)|-83.67 %

I couldn't see what might have caused it. Hopefully something minor.
Pls follow up.
