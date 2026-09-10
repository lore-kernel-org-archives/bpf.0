Received: from mail-oo2-f42.google.com (mail-oo2-f42.google.com [74.125.231.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7D874A68B7
	for <bpf@vger.kernel.org>; Thu, 10 Sep 2026 15:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789054977; cv=none; b=cN0OU2+rNG2wAzuh+XhD9gD58SUC6E7ju7GpOy85idZUcyXeHXCylC8kuwWRbE4KGydDhDEcgYeL60oQK3BX3AnkuDz7iDdhvXo1ys/CAGJPuLyIMUU0fY8d07sXnXX2Yc4hH8kSQS1tfnusmcuxMNnwGRH+BvG1hBP6mimOETM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789054977; c=relaxed/simple;
	bh=A/nCDgyDPUPU1RSCTCEMlXBoBaDdeCZCssb3K4mcjCE=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=G67No1yhTGOxXm4Gj0sjc5RdQ048H5M1ht6nqGrtsQihqxPPZZvzW76qMVXmzGMwRLFnINoZ+66YFKCdmaLfnZIHdkhFOPBHMI5bvwJevYhXwT418Blw+sJQYBrk49CnHmBEXi1Ci9Ny4iqtqMx5M06pQ7i9vjAzN8KreC/qgOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gAv6lxyX; arc=none smtp.client-ip=74.125.231.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gAv6lxyX"
Received: by mail-oo2-f42.google.com with SMTP id 46e09a7af769-7fcb425fb6bso1044075a34.2
        for <bpf@vger.kernel.org>; Thu, 10 Sep 2026 08:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789054974; x=1789659774; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=VMVAvPPStqPTw7eCOoENioqc61FRpj+jpgH7CPpMJ1Q=;
        b=gAv6lxyXpRFTn3U/u1uPriCuliGH41NI3j9rp8OLHWcbrqR94iVkP2G6WoZEoiBHzk
         4hbelOe7bRb0jnR1dxP8b4TcLSLia7wSp6MZ20fiz2HeIn620Iqc2/vBA6w0Ve+wB6Di
         1/FgoaBsSu37sLBfz1KW0KhMLq7Ur/XBPWv7jS9DUykfc/xm4HTeB359NskZSv7fdfnG
         bKwbMUbc34fOn5Y+VdBcVSw1F5ZC3xDmged2fc/x/QXwdMBhWjSm81peA2SFZ5Qcs1c+
         JhgrFXLnhx/F6H5H5QqTZ43Jd67MCLOEDZfWAOX3Th4DNFL7hziiHgMH2r/hxFFTgv52
         nqtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789054974; x=1789659774;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VMVAvPPStqPTw7eCOoENioqc61FRpj+jpgH7CPpMJ1Q=;
        b=LOZQM5E1K3b4SEu1F5cSJZyJ7bYbYgAvcA8RhQtzw77W+CMzyUZpOR8juC1VwdOT+N
         ECGA0Ur6qcTw3s2mjrMsG2+iOEGRp2Vl4JCCpMwpurvmlh1XrZrCP6c1Del9hxHS2q1x
         WAqo5n6XpW7KQohKklZRx3D9uWnGo81Mh5hjBLaFGCoHsizWR4k4yenz7x6t/jZZYL2e
         x5oLEh01aPFYdKs3UYzHxKZUR0Guj0ar2I1Lut+dbI+pp6RoLp3Ia+bchLvhnoKg0AOw
         QNsaZt/RjcelmUZMsNZ6Dj2sUl8kD7DCjlVS5FNFtv2ZLzX864c+auo83/ofdOF5sWey
         kstw==
X-Forwarded-Encrypted: i=1; AKwUvBzJph1pJ9t/F6bTLTg9zTT9sBZnq2d1SgQ1zRd0H5W83/fZ0CKrHoj7l1W/cLYTkuPQWr0=@vger.kernel.org
X-Gm-Message-State: AFuF++l297SvKUs3HbOFMUFAuBePjluQM56QmUMAjzEiXe+uGM4f9udV
	rZ9obBaWYd7hyRLAqwIgrUCY6YjBAFeH/AJ5ih9RyItN9vtWi2EsTTgw
X-Gm-Gg: AYBFou1nVL980obbCHwdlBE0lfaxrMdEsTOF7TDMxStcJ5ZYtZlfcOIsPh8mH11Rdcf
	3JWFJu7u3m7DP9a9T8aqmtVcgSERCQh9mjTn5ZN29vj5CBVLIuAiisOT6wolhKc/yaA3BCJPCUZ
	9tSXHJXVB6SaFQ5zNwBMJrvTUJVF7BtHN5zZvT2XB+ek29uXcTYtfiyN78R63jKYWoJip5qfsW1
	BTN9DayyLIRZIq6uBI36K8kuW9qqZlE8xW7xRw2Ifzd3PjdWxERSIBh7XDNWUF2l5BqLaJvlQtC
	yHpbh/AXU5YDdF66fHDdL18xCdD7/TaY7ArXEFksLsIoktTlfiyBc7Xr0pWZ0RQyjKpfxzkOWEg
	F7N/YrxD/QB/V1ZgWzdxdzwDQSFRIhDGx23dHmlknBcvB23M7ihXIG58kuqR7RncSfZcpeH9Q93
	UN9Wq1PmBlLUsryewxyMTuO1rXmDwM5yr4CL/3if7C7wVuQ49O5eJTqLydNbSB4pMcHifZihhld
	nK0H82ICNq95Hu1kO4PvruwWkKnqSw2Mztseg2N7ePfrKcQfAndYTgjgMDBr8nH7w==
X-Received: by 2002:a05:6820:820:b0:6b1:a812:987b with SMTP id 006d021491bc7-6bee2f1f13fmr7998958eaf.14.1789054974256;
        Thu, 10 Sep 2026 08:42:54 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:33::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6c0990cc05fsm147707eaf.3.2026.09.10.08.42.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Sep 2026 08:42:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 10 Sep 2026 08:42:52 -0700
Message-Id: <DLBR23ZSPNHT.49259869EXRH@gmail.com>
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Daniel Borkmann" <daniel@iogearbox.net>, <ast@kernel.org>
Cc: <memxor@gmail.com>, <eddyz87@gmail.com>, <info@starlabs.sg>,
 <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf 3/4] bpf: Require CAP_PERFMON for untrusted
 read-only memory reads
X-Mailer: aerc
References: <20260910142107.40582-1-daniel@iogearbox.net>
 <20260910142107.40582-3-daniel@iogearbox.net>
In-Reply-To: <20260910142107.40582-3-daniel@iogearbox.net>

On Thu Sep 10, 2026 at 7:21 AM PDT, Daniel Borkmann wrote:
> Marking bpf_rdonly_cast() KF_PERFMON CAP-limits one producer of PTR_TO_ME=
M |
> MEM_RDONLY | PTR_UNTRUSTED, but not the type itself. A global subprogram
> argument tagged __arg_untrusted results in the same register with no kfun=
c
> call.
>
> Fixes: c4aa454c64ae ("bpf: support for void/primitive __arg_untrusted glo=
bal func params")
> Reported-by: STAR Labs SG <info@starlabs.sg>
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> ---
>  kernel/bpf/verifier.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 5d61e74865a8..3f99b20e04fc 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -6453,6 +6453,16 @@ static int check_mem_access(struct bpf_verifier_en=
v *env, int insn_idx, struct b
>  			return -EACCES;
>  		}
> =20
> +		if (rdonly_untrusted && !env->allow_ptr_leaks) {
> +			verbose(env, "%s access is allowed only to CAP_PERFMON and CAP_SYS_AD=
MIN\n",
> +				reg_type_str(env, reg->type));
> +			bpf_diag_policy(
> +				env, insn_idx, "read from untrusted read-only memory",
> +				"the access requires CAP_PERFMON",
> +				"Load the program with CAP_PERFMON, or avoid dereferencing untrusted=
 pointers.");

That's an odd formatting.
	bpf_diag_policy(env, insn_idx, "read from untrusted read-only memory",
			"the access requires CAP_PERFMON",

would look more normal.

pw-bot: cr
