Received: from mail-pj2-f40.google.com (mail-pj2-f40.google.com [74.125.227.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 200D53F823C
	for <bpf@vger.kernel.org>; Mon, 28 Sep 2026 07:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790581335; cv=none; b=iRSGMBLjY+cjuGpCrN2WmzWIgKqFmgCPphnLx1hUAKGdw1kqvXiT7F0ouurfgtE3xGL45vH+2Mpb8PCTlblfAdcnu59C0qjr4WsKOMQqLQtr25Gyv0cQydjY6iYSNVV0mTXBY39UP6bSbVnrIAJSJu7AYzo5lM5c1XXZXsyK9Mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790581335; c=relaxed/simple;
	bh=eviVKQL1GqxJ7n6WTPVfikHyW1NbKYtUFXOY02zwrio=;
	h=Content-Type:Date:Message-Id:Subject:From:To:Cc:In-Reply-To:
	 References:MIME-Version; b=mdgxPGvMia9+35dDsSC9OgtFbTiU/AADsx8VRZUQROz29sTRPk/3uW5LfiOWe0SUvcYeVuMuMB0/6nphX+vm9V1D8QI21IJVWqtdU5pwfo6KjjllxPhs3gPYQabazHNl3v54rSYw5JXfCuh6pOAWPK7U9aI+0Tp64ca3twYc7v8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GbVVFhT+; arc=none smtp.client-ip=74.125.227.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GbVVFhT+"
Received: by mail-pj2-f40.google.com with SMTP id 98e67ed59e1d1-3a0d31bda43so1268889a91.1
        for <bpf@vger.kernel.org>; Mon, 28 Sep 2026 00:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790581333; x=1791186133; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:cc:to
         :from:subject:message-id:date:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wzC7ZwZxhN/+isWJR43KtRgUye/21tDI5dM3m9YrgyE=;
        b=GbVVFhT+1SypBnt7bd7P+9HUIs0CrzHlOnB82gde1LN1yvOO3HUg+Y6LfP7dUfZfP3
         tuiPgS9cRxiSDG/Q68FofQikYkwUJ24D+CnM/XbRV34HWDbnS55ajRuiTtSpFIv6CH7b
         Ib/p6ZHun1E4ydMbanoMjLzBXpcaxNsPOpPlqMg4Us0CXj+B00eB4+SO2qscTjy4t4E9
         7nDaWda7Fi4b8xh0j5SxvjMURcuGu3s1ZwZGvGlVseKKnlcwBgEg9kNQus44QjO8MBcT
         g8HeHMXafk/rMsGz8IQv2ypVlhMSgWG7rHLcu9hdzGPa1YERCBoy9TX7lTN8OfEoYGUC
         VxNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790581333; x=1791186133;
        h=mime-version:content-transfer-encoding:references:in-reply-to:cc:to
         :from:subject:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wzC7ZwZxhN/+isWJR43KtRgUye/21tDI5dM3m9YrgyE=;
        b=T9ngGCwV1hKegx1KIwFluKZMVLmuxtGIpt4ZugkpQWgsb0cSMfPh/Yj7fpGt036fsD
         sArQgA5H5R+igQJoZ+WNPJ/YdzKlwS1PITerla23fFU6C0USGInDzGjPJ9FnMCBoWk21
         gOCWk8WHHfB9KybrYWcq4AORPMODFYfZ768YG//yXq4tOjwsoe1w4xy7N/tQ3AO8FKWO
         WXxGEX6TD5+CsAnozR6kcRD0p50wBU7XXybEdLk34MLYm84QneMkJr4MstdsSmRtkilF
         b09PaZK3blmMlpxZmLqsO/qVqXcAa/Etn0rfn51uSmQPDlX8u/wnXb6T66beznoIbsxh
         5HrQ==
X-Forwarded-Encrypted: i=1; AKwUvBwU+MGSx5jMQyeOPVN5J91rXYsSRVeHFQbTXpkB5LMKJcxd+ZVi5KzzYP0MSc1DYuHMmr8=@vger.kernel.org
X-Gm-Message-State: AFq9FYJsoNaKxskMZvySqj7KjXPAVqeiyfzaY6VDWU3kgXeC+E3ZBSMc
	jD7TCDxtjDNx3R2noY5zpP/kY5xSX4UwPqTcKoAGJSHID22AFEDck01X
X-Gm-Gg: AYBFou04Z6TpDzZzmYL6xj0qLcQLaeDryjswPfHR955q7CNBb8cKIqb72KRAE0rTXhV
	WWKmWv4cpXna0zKP57ou8wRIMUw12XPns3zV92rPS/GShs/I1NvMQU2LZP25ptn5KtLy2uxpH9Q
	7Hmoygp/N08z2mS0kKrQg5NVbeLYNCnCtKhDHW9aOkz6iG7TD14A68ZtRiiJREqWdzM/Y5OyNCr
	fbehL5Phc8/zrIIZJa73k3U1uAS4AU4S2YIgLAgrZi6gMjuH5zvZ/F8E7E0FaOYDIB+n4iMpfTF
	QQAU/XLOHdILfYNfk0qx3WRUT6qwvo7HUIeqQLk96HEGj+qIP4T7dth7igh2nwGipB135+Y9V3d
	wWoYJSAyauMCP4w7hKpTUVt/KNOmAxxw+hR3+BvZpDbKXuc7AzMKFxWtE8DgQS4Jkxy5ppX7UQT
	uTiZdkN1K/+YnWDasrc3DkojvXz05ONLVbhBbW4qKWsdvNvS4EyGjLvNomU7iMCOINOlGZQtw4D
	ZWssK17qxbILJIT2wIM9RR1VFrFyjOqshM8q92tDdTP9i3jFRp839AgeCp2JUKuGAPkvBNOfG+h
	GKZMcGJKp8lyPaQ=
X-Received: by 2002:a17:90b:3843:b0:3a0:e4ce:31fd with SMTP id 98e67ed59e1d1-3a0e4ce57f5mr4745750a91.10.1790581333234;
        Mon, 28 Sep 2026 00:42:13 -0700 (PDT)
Received: from localhost ([153.61.198.253])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0e151be04sm12870178a91.9.2026.09.28.00.42.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Sep 2026 00:42:12 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Mon, 28 Sep 2026 07:42:11 +0000
Message-Id: <DLQS3VWUPXK9.NWD6AU4CU898@gmail.com>
Subject: Re: [PATCH v2] bpf: add diagnostics for rejected memory and map
 accesses
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Suchit Karunakaran" <suchitkarunakaran@gmail.com>,
 <daniel@iogearbox.net>, <andrii@kernel.org>, <eddyz87@gmail.com>,
 <memxor@gmail.com>, <martin.lau@linux.dev>
Cc: <song@kernel.org>, <yonghong.song@linux.dev>, <jolsa@kernel.org>,
 <emil@etsalapatis.com>, <ihor.solodrai@linux.dev>,
 <john.fastabend@gmail.com>, <bpf@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
In-Reply-To: <20260927194205.125086-1-suchitkarunakaran@gmail.com>
References: <20260927194205.125086-1-suchitkarunakaran@gmail.com>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, Sep 28, 2026 at 01:12 AM Suchit Karunakaran <suchitkarunakaran@gmail.com> wrote:
> @@ -4472,12 +4472,22 @@ static int check_map_access_type(struct bpf_verifier_env *env, struct bpf_reg_st
>  	if (type == BPF_WRITE && !(cap & BPF_MAP_CAN_WRITE)) {
>  		verbose(env, "write into map forbidden, value_size=%d off=%lld size=%d\n",
>  			map->value_size, reg_smin(reg) + off, size);
> +		bpf_diag_policy(env, env->insn_idx,
> +				bpf_diag_fmt(env, "write to map '%s'",
> +					map->name[0] ? map->name : "unnamed"),
> +				"this map was created with BPF_F_RDONLY_PROG, which allows BPF programs to only read it",
> +				"Remove the write, or create the map without BPF_F_RDONLY_PROG if BPF programs need to write to it.");

That's not true.
dev_map_init_map() and insn_array_alloc() set BPF_F_RDONLY_PROG
in the kernel for every devmap and insn_array.
libbpf sets it for .rodata when the prog has a const global.
The user didn't create the map with that flag and
cannot create it without.
Same in record_func_map().

[...]

> @@ -6944,6 +6954,10 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, struct b
> +					"Use a writable destination, or copy the data into a writable buffer before modifying it.");

[...]

> @@ -7032,6 +7046,10 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, struct b
> +					"Remove the direct write, or perform the modification in a program type and hook that support packet writes.");

These two are the same as in v1 and don't tell the user anything.

Pls focus your tokens elsewhere. I don't feel we will converge here.

pw-bot: cr
