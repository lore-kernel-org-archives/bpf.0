Received: from mail-pg1-f195.google.com (mail-pg1-f195.google.com [209.85.215.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A1A234EEE5
	for <bpf@vger.kernel.org>; Thu,  4 Jun 2026 15:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780587438; cv=none; b=qaln4xWbO8QdMmuKr/Eg15KHKCkPId5dNBnsCGJV6s0zUs//Z3EWmdjywP9+cf2qPx+C2mfO0E9SWq/xjYKSZ08eCFGlNyOxWBnZX2fGW+WA5TI5vV6KAPL21KcjcqEueCUtqVLDhLs30C5xAZncGl27wwb76L6VA+jB2PO0KCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780587438; c=relaxed/simple;
	bh=nY6/njLe0UgFMoo9e4udwPdESJgHeK8pFOEaepKtfx8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jVDdnp+1b3fXLoyeYm5zl70OTzvnLQkYajjYGOaAu+OF+iPQd5WikJKh2r8tKnj4GTGp0baxELPrVMRrf6i5oyimHGAxQ2J9P35+X0dkaWu6PosD5L5XjWlIdh4GXlZBxNx0eGYlu3U0o9u+lDMZOQrB06dp7iDenIVXRn3ywqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lo5XpSr7; arc=none smtp.client-ip=209.85.215.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lo5XpSr7"
Received: by mail-pg1-f195.google.com with SMTP id 41be03b00d2f7-c8571db044eso551697a12.2
        for <bpf@vger.kernel.org>; Thu, 04 Jun 2026 08:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780587436; x=1781192236; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nY6/njLe0UgFMoo9e4udwPdESJgHeK8pFOEaepKtfx8=;
        b=Lo5XpSr7DkvL5Up68ZMUVAf7yB1OGHrS8qFYMhCxWptn4A23IL+jcvOESR8vwrXoLZ
         xfZbN6gX/7BejqGNUoL93Bfj+lQSqdi5fxh/uWcN2n9LQ3/7Q9zzM7Yy7ZIzKe3rsskd
         ztDknvjq29YFb7z4dYaI+SbZMxRpaRzSnloHk/K1jFxyX1nxm44W8c9r15E3cgkpUMhq
         RluFKWV+q7OCoNGPuSaKEuNYc5IdKEaCwgqUva7nyFlJLTLsH7wR0NyS4lwtVbHgX0KN
         TGmHI/+x4x3t25Coje2x7Oz9uNeLxc7WRVhvvgdg4nWaXemUlTc59SUMuvDpL3npkNT9
         psxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780587436; x=1781192236;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nY6/njLe0UgFMoo9e4udwPdESJgHeK8pFOEaepKtfx8=;
        b=RXLs8R3Xvbk73qxBOQCfPF+Fhn39wqIYKh/GwQSHY+DxW9DL69PPRsZ0KKWx/QkFeH
         XxUyxg049Muuc2VnfaF+jXhCFIvh8DrwlueDtH7QKumGjinQhGf8sAGoYVx7bL4qrBQl
         PnmDB2lqRmeD6rd5DP1VSWjC8RtQzt3GjZgAn9SLI09cT4cVKTuU7XjJR5Z+cza3aXmT
         XRL8UBUMXC4SfQWpjW1q6sMwT3Kn9JJ+sDVEuUsCSBSnuFp0PE7/gfVfaydbAEg5SzTa
         x5PlNK17QAcfID6RXl57vyJknCRSERVayVnEce+nADj3E2QHuzYPS4JQdrxKC1ldrejq
         UCXA==
X-Gm-Message-State: AOJu0Yw+ejhMaN53K1Ijap7ZSCOT2M+oVfSKtrc5MpuGRocr2apaVut1
	VEZKEe4wsoiWZeviQsjVhaYp8NTXmxSseeBBLuM1IKEL0z+5O0AovLKB
X-Gm-Gg: Acq92OG8vB+CwH2QwZ2ZtANNLRs7K5h2tlPLRSREumn9zqvPKwjkEDEuyurmVfP3F8A
	apR992hiQj08MtAR17RpZmQFV0g/TFeULNBpqMxos69nddE2ajP4wkoILl93aHI9x3Wa0nRhV1r
	mnozrl0ZO4OJbDWE0mhuAPCZ1gqoQTi812biztCVGnpSCQafcaOwBKmCSGOU10557wbnicSI05S
	8FaXoESyRfDqAHtJ7IwGT+/VeuxNvMqH4xpsWvoNA3vAq/e2yJmUr+Ft8QQEKPZRXu8HE3Lko2u
	854YyehXat6wGdOeDeWyJ1C72V9r5chR6SFFNr3yQ5Ru/iWysTu45X5cTdxlLdyDXIbkNM8CqS4
	J/ZrpyUKPS5nBeXLqzMg0vaNUUEEwVM1xoeJ5f9YqYsJEKl9uWBRUg5CPQPVrYzQyUVbie4DEsL
	7fqV1Yf5msuIZdJDl2AgN1Sf+pgrpd4Ik=
X-Received: by 2002:a05:6a20:d52a:b0:3a2:d838:bfdb with SMTP id adf61e73a8af0-3b49782ebdcmr9551112637.29.1780587436380;
        Thu, 04 Jun 2026 08:37:16 -0700 (PDT)
Received: from laptop ([223.131.147.119])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c85df0b374fsm5526657a12.25.2026.06.04.08.37.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 08:37:15 -0700 (PDT)
From: Woojin Ji <random6.xyz@gmail.com>
To: Emil Tsalapatis <emil@etsalapatis.com>
Cc: bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Woojin Ji <random6.xyz@gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: Add arena direct-value one-past-end reject test
Date: Fri,  5 Jun 2026 00:37:10 +0900
Message-ID: <20260604153712.199362-1-random6.xyz@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <DIZJ5P33U6YT.14OWBKG3T9LVD@etsalapatis.com>
References: <20260603-arena-direct-value-v1-v1-1-7b31cc0a8cac@gmail.com> <DIZJ5P33U6YT.14OWBKG3T9LVD@etsalapatis.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Thanks for the review.

I tried moving this into verifier_arena.c, but this test needs to set the
second BPF_PSEUDO_MAP_VALUE ldimm64 immediate to arena_size exactly. The
__arena C forms I checked materialize the arena-end offset as a separate ALU
add or memory access offset instead, so they do not exercise
arena_map_direct_value_addr() with off == arena_size.

So v2 keeps the userspace raw-instruction test and expands the commit message
to explain why it is needed.

v2: https://lore.kernel.org/all/20260605-arena-direct-value-v1-v2-1-a92cb281e376@gmail.com/
