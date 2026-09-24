Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F8747ECD8
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 10:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790245384; cv=none; b=dWmLfNzZ5U9yKJcwYz8wKwMet2XT0Q7wCe6i4TUNvQFWIIVYkEeUGMtku4xO3yx+c4HQusFKt5IuJNKcTko3kATz7Ud3kYgJ2o1yCc0+U8QhmcRvyy614sm6My1qoUEVr1mM6owdmYwVWlzXReNtEwjw+L3WRB4SAJ323jgqD14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790245384; c=relaxed/simple;
	bh=8CqWs2BAk8rGu5p7Vtkh3GDcNWKUwwombm9axyV6GDM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cWFfTB+ZXQoZUQ87ixYri1Qvay4LuesufVll6e6iKDgV2IJuw2IV6z6Nhhv31b4g4pgEIiQRciIRC/miBr0b36jCNigDPDZhkHKUCcezbADh22AaKVzmY5IADpwnzFKIM9LgwTdFptOtUgjXpRyvrPNYSjgNyxi94uPVkSUPwak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cOv01eN9; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cOv01eN9"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-39b910bdf2eso987553a91.2
        for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 03:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790245382; x=1790850182; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8CqWs2BAk8rGu5p7Vtkh3GDcNWKUwwombm9axyV6GDM=;
        b=cOv01eN9czQ88wp4pzx1qezwNGWSR8P15PxxzgnDFW4ltpWKI+IY2GUHmrFszU9Xvc
         UeDkqS6qRoMkdDS714t+NWX/r64njyk2X5qMd05yVi+SNNbfyHHgS5/ZFLSN//UL8WYp
         cnYmgDmSEUN0VplB8+1NVnFkZJam+VjG+ysr2W3NyjphRN1YlI7Z2gCKpspe20S6H6QV
         kL1gdMKnZgYdkU8109Irq2YWtqC9pTvSn48FI31T4SWrmLdhlnydGo1xxrVPagj4kV/Y
         MAVPn02tXI4cNfTIMk1VHTTKrYLZuurHPhEingAiYM68XscSKRQ3v6aMMbIXpYFdCyV9
         EpRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790245382; x=1790850182;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8CqWs2BAk8rGu5p7Vtkh3GDcNWKUwwombm9axyV6GDM=;
        b=dni80sMo4uBA0TVs8LLALPTM0aUgq/swq4PwTlGJvL55dGXAMd3SUld3Z0BKlfLZwd
         X7XqNrGtGIm1tY/qYewINgvBOyd094141IA4biM/6dlDoxioG43w2y86c10mtqC1T0w1
         gKJgVmRu9cTqpgZ7hHUFfYW9x78H6GvoRYWsJ4AHJxkm2EeAtEZiYph5FxrSgFTb2l3e
         KTxbzaFV9nmwapCpqwG37cNrmDfeB8n/fkISKDP3VZbhq9xohW1DOwmUxxNXcTmwJuLr
         jg/6giO2h7gGOwGYmVjLsb0nHip+l40UNGuaT4twhR2hpJA5DpVYnIqvrypremR1rhmi
         S3Ag==
X-Forwarded-Encrypted: i=1; AKwUvBy3eEoLTUyOacEfXKZCaHA+n3FE1WDMK6bzTTrsQuUyNUNFXu9clxTen9VaNOECSD1zXpw=@vger.kernel.org
X-Gm-Message-State: AFuF++mYvNtadzi8iuUnCnT9tPhzzQMI+SyeKvVEFVI4DZJ99BGIjAgp
	KmrJAPQDCZIAfb20jVoZRuJYMT+JI0Zm6Jy84X8tXL0M43QAlwMDLFM=
X-Gm-Gg: AYBFou0EHyK8N2PcPkJZhanpuvo3XAgpA9DbUaYBHoGvTE3YfT8Rt0nqoT+SlXpD5h4
	gwoC7b1L8FnX5sgLqsaDGjXgn6+g2BOyBRQJ23cZSL4ncIo/ckbaTrWeOEiDVnM/Pxd52vPtUt2
	HfM3jX0cP7X5yPsN2EfAQl38gNupR5+shlA2ejyF1G6GljkR6B9RNSktK/+KFDXB+RayvGtQO8c
	6F83vaVwbG6klmHJKBMv0YSCzKOWHuUNRp1EjAALHeoz/+CFBj2JJlVJohSoMrHALF5Adt+yKHj
	pU+FqR4gJQ5nF8MtHJ/rz7xwGDl3FkYUQU8m+1Gd+MbdR9J3FQp7GPo2ogT2JvAXModWXs0dIWg
	mDyDDghA2RO0g7GUtlbVLa+Z4qhUgo49l8IP8EyOGIb3JrZWQVdYWS9I+WIEsDZu32hYgxJW3sl
	uigYr0gdknj/lAoy/gQfrFOcR5DAgYsqWDabTojj3Pv2aWKu2WO4kR213RSJwDvtiB+vP/ercIR
	oq7IjH5P/wp0L4evrI33rvKOQ==
X-Received: by 2002:a17:90a:1149:b0:3a0:9c9d:eb0b with SMTP id 98e67ed59e1d1-3a09c9df050mr891571a91.58.1790245381935;
        Thu, 24 Sep 2026 03:23:01 -0700 (PDT)
Received: from ydg-Zenbook-14-UM3406GA ([211.230.25.193])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0972b15f1sm4035343a91.2.2026.09.24.03.22.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 03:23:01 -0700 (PDT)
From: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
To: Leon Hwang <leon.hwang@linux.dev>,
	bpf@vger.kernel.org
Cc: Donggeun Yoo <donggeunyoo.kernel@gmail.com>,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	ihor.solodrai@linux.dev,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf v2 1/2] bpf: Zero-fill other CPUs when BPF_F_CPU creates a per-cpu hash element
Date: Thu, 24 Sep 2026 19:22:54 +0900
Message-ID: <20260924102254.2120344-1-donggeunyoo.kernel@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <0a30f489-6771-4798-ab59-b658ef4c24f0@linux.dev>
References: <20260923000801.1764758-1-donggeunyoo.kernel@gmail.com> <20260923000801.1764758-2-donggeunyoo.kernel@gmail.com> <0a30f489-6771-4798-ab59-b658ef4c24f0@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 23 Sep 2026 10:09:40 +0800, Leon Hwang wrote:
> 'onallcpus ? map_flags >> 32' does not look reasonable.
>
> Based on the 'if' above, either of these looks straightforward to me.
>
> int init_cpu = !onallcpus ? raw_smp_processor_id() : map_flags >> 32;
>
> or
>
> int init_cpu = (map_flags & BPF_F_CPU) ? map_flags >> 32 :
> raw_smp_processor_id();

Agreed, v3 takes the second.

Thanks,
Donggeun
