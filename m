Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792620618;
	b=NiGphz+7uLrBScXLpnZxGt1BIve57mASgVb5honrTz/wfLVw33iS19/1FtDuwr4KcddQ
	 r59cYkxVcmD71Pvm67uwll7m8GV1x24tMEuw7GJoSglrNHDAiZHWis90hFKyw9lsFA+nB
	 DNSN7oWyr36Cdztu+o/MOH+vKtnWs3zZ2JqqCNDygz+0E7K8TtXQDc7D5q/XYHb9/wuQR
	 BZszl1v06wNnPDK31xZG6+sdy8EwjrSpcaDaNfyqxEi91BMehauUlkVsDAB/lPqjIAm2V
	 S07wMuMDmytOPg9wP8plgMXiF/q+t2x8QAnocsa+r/XXvsjWnta0HFcGwdQRb684dmQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792620618;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Mime-Version:
	 Content-Transfer-Encoding:Content-Type:Date:Message-Id:Cc:Subject:
	 From:To:X-Mailer:References:In-Reply-To;
	bh=HOE1IrYVyFQYYyvpqYSqs+O/GoZP90UMQeDB0h5VTgI=;
	b=qPkDPa+KrQSoyhg9t6/r9iEL/2RD3ms2yfb7LXBNm0IMVnkYVDs/sMKIrlWLII+HyzL8
	 Ji53/Z5s/gylakpKXgkZ27bqwns0HGe5g0kLMuTOZ2NpUDQ3aJpue3HeLaIVVl1i6TND4
	 gxZW16saPe4zHZkZmaGdK+1WRsgP/TzzinckTJXmXchJfeCvgzZ6CC9TpN1F5NbhguLUO
	 +oP/bsHaS/8gWCPsSoP28Nv0tr5Q6tK51L2pZb1ZWB8F/1A0oCMgJA8N7qwcE4FLstU90
	 3gg8rOaaxlo/AIorFpZvKi8x/YzT2o5BnFXc3EAM27NtP2SmolZD+M8zRuJrbO+PgXg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ZEE5FWE2;
	arc=none smtp.remote-ip=209.85.214.182
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C8B4606A319
	for <bpf@vger.kernel.org>; Wed, 21 Oct 2026 22:10:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6C8B4606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ZEE5FWE2
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2e96502e447so9157505ad.1
        for <bpf@vger.kernel.org>; Wed, 21 Oct 2026 15:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792620618; x=1793225418; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=HOE1IrYVyFQYYyvpqYSqs+O/GoZP90UMQeDB0h5VTgI=;
        b=ZEE5FWE2MW3CNu9TCX0duti0XLGGNXrxt9CbrBrmvEtjVBeY1u32rDl1W5B+O1qZru
         DCDIPQ2dqoiO59/DNaAuKQw/z89nTfd222Z/bJU9VIGFkMd+WTiXCIiSBHvuDdAHeuai
         zzaxnC65Jqz5nEXZcCsX6nw4vbMi6NcGGFR5DMDbH8tkVKkTpjXx0HaCONOoCI1SdoRq
         NcCP+76bovKQWzGTDkciGitW38BoqFp/SBURz3oLQQ4whKFKUpQCMTUlCkYgdpWqlogo
         ZuOGoyhWEFmSqpIUHeZbIlEPr0ghcMdu0mmpPnU790nzh/TeZiqQYoFBTYrpaGNKT9BI
         Dw8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792620618; x=1793225418;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HOE1IrYVyFQYYyvpqYSqs+O/GoZP90UMQeDB0h5VTgI=;
        b=zhKh1dHgoYRhkBN5+GXt/WtRD5I7c8exrxNtWtmUSLwMft/H99xvJBMFG/CtjLeFLk
         zsNjibBQNk75PuofL96IxGx7+4XmTplanILSvuODy79Zw6Uxpcqjkoeuhe/k7dfyR4Mn
         x2X0lfu/j8H3T+R9NzM0Jj7AQZVDj1ZOfnhW8h+8+a4+hZmf8k6xgdxxKVA5oO1WA+nu
         xbs80IqtnYmSM1zbrREdI3GWqZPBu3Q2csASNRRrY3YPlOZ1rDx/5DDnBhIhZ8nT49bh
         CnmJlo5q652dNm1T97UYCgEP+Du04Q0AnBmFecAToQeEo6ZwhbdSS7McNBwEg9Tkh5Al
         MOWw==
X-Gm-Message-State: AFq9FYJaTcIXpkd4KsNZdJ6PX96sOyyPWfnHVOJchSxqRqTjzRm6wLMw
	XAC5mHy/Xv/2h653ErhaHZJoC7N6dg8rJcw+2+3ShV3hP4cbJAijJSJS
X-Gm-Gg: AYBFou3rqd1geJHFDz1t8bR1ohhXzlX9NOQMfOv3TIoXKxKpUYHCtfcdKkHKa/b3biz
	sUWQ+SzB0EzkFRc+RJZGmXTA3PNSifsjmVDb4Rh+HobH9aog5mzV2t0wlD+aJT4sQv77+Pm9OaJ
	gRMSW7qnTMnLQEllyrNAIsU3z6F5nvx3hdWiVGQ+c/3cH+pKrAgSbFYdWcg+6lKK982hg1iuMy+
	aZSS3Ndda2Di4D+yKtE0SjHLU4XScK5XT1LXsTwxHQIoXBwZ5bDeIA7o8R92TdGhBBBAEKgGmDW
	CAn+0sSO1/Vr4/hSfaqYDozi70r62W8B+L8cnACy3iyc5xiHqyGyMjj2b/WwIksJzvl6z0ZarlY
	epRpvFbow5lUNUg9N8tV64VRXy+lJ36yNBC9IJmz5JnneFAuY7aCvVMYfEwG3N+HJup40u9eJNr
	cby3e6tgc0iG0UXNMvu8+07spKHBEbSf4UOVOX3O5oBlhJq+uu0CQDxjnQ/zlfAvEzFPsayuObH
	cnw2EhOM8wsLBPXu9T1Bw3w4vrY8AdlvvPY2WOUSooNFFIr2bgaaQ+IwKMEizabhM2jsP65u0Wc
	A17EaG4JjJngFBHtz8bacajCv9TJD3j07rr7v/pTgvpbpo168Ae4IVqToR2U
X-Received: by 2002:a17:903:1a70:b0:2e9:4048:3031 with SMTP id d9443c01a7336-2ea43cc2bcfmr29451795ad.39.1792620617640;
        Wed, 21 Oct 2026 15:10:17 -0700 (PDT)
Received: from localhost ([153.61.198.246])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ea3b4af4dasm16308155ad.75.2026.10.21.15.10.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Oct 2026 15:10:17 -0700 (PDT)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 21 Oct 2026 22:10:16 +0000
Message-Id: <DMAUZ2HNWF7I.3MTUYUUN3E5JQ@gmail.com>
Cc: <bpf@vger.kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
 <eddyz87@gmail.com>, <memxor@gmail.com>, <yonghong.song@linux.dev>
Subject: Re: [PATCH v4 bpf-next 2/6] bpf, x86: Support unwind_goto and
 unwind_exit
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Nathan Chancellor" <nathan@kernel.org>
X-Mailer: aerc 0.20.1-349-gb940a4174a3e-dirty
References: <20261020181320.1284798-1-alexei.starovoitov@gmail.com>
 <20261020181320.1284798-3-alexei.starovoitov@gmail.com>
 <20261021201456.GA3197963@ax162>
In-Reply-To: <20261021201456.GA3197963@ax162>

On Wed Oct 21, 2026 at 8:14 PM UTC, Nathan Chancellor wrote:
> After this change landed in -next as commit cff94a3d78d8 ("bpf, x86:
> Support unwind_goto and unwind_exit"), I am seeing the following objtool
> warning when building with LLVM 23.1.4 and a recent tip of tree version
> of LLVM 24 with the attached configuration (which can become an error
> with CONFIG_OBJTOOL_WERROR):
>
>   vmlinux.o: warning: objtool: do_jit+0x1330: relocation to !ENDBR: .text=
+0xc7fab
>
> Something like the below diff appears to inhibit this but I am not sure
> if it is too big of a hammer or if there is a better solution, hence
> just the report and deferring to you, but maybe it is a good starting
> point.
>
> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index d3ab36281144..b80f05f377c2 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
> @@ -641,6 +641,7 @@ static int emit_patch(u8 **pprog, void *func, void *i=
p, u8 opcode)
> =20
>  static int emit_call(u8 **pprog, void *func, void *ip)
>  {
> +	OPTIMIZER_HIDE_VAR(func);
>  	return emit_patch(pprog, func, ip, 0xE8);
>  }

Thanks for the report.
Sent a fix. Pls test it in your setup.

